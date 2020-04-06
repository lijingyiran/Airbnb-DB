// passes input to the db instead of user writing queries in pgadmin/command line
// performs the actual sql queries based on user input and returns results

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	_ "github.com/lib/pq"
)

func main() {
	e := echo.New()

	// middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	// TODO: double check if CORS must be enabled
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"http://localhost:3000"},
		AllowMethods: []string{http.MethodGet, http.MethodPut, http.MethodPost, http.MethodDelete},
	}))

	// connect to db; use this one as a global
	dbx := connectToDb("postgres", generateDBXConnection())

	authAPI := e.Group("/api") // groups all calls under /auth to ensure user is logged in

	authAPI.GET("/employee", func(c echo.Context) error {
		var employees []string
		if err := dbx.Select(
			&employees,
			`
			SELECT staffid
			FROM employee
			WHERE race = $1
			`,
			c.QueryParam("race"),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, employees)
	})

	authAPI.GET("/money_transfer", func(c echo.Context) error {
		moneytransfers := []MoneyTransfer{}
		if err := dbx.Select(
			&moneytransfers,
			`
			SELECT *
			FROM moneytransfer
			WHERE amount > $1 and date > $2
			`,
			c.QueryParam("amount"),
			c.QueryParam("date"),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, moneytransfers)
	})

	authAPI.GET("/money_transfer_join", func(c echo.Context) error {
		var moneytransfers []string
		if err := dbx.Select(
			&moneytransfers,
			`
			SELECT accountnum
			FROM moneytransfer
			NATURAL JOIN host_transfer
			WHERE amount > $1 and date > $2
			`,
			c.QueryParam("amount"),
			c.QueryParam("date"),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, moneytransfers)
	})

	authAPI.GET("/commission", func(c echo.Context) error {
		commission := []Commission{}
		if err := dbx.Select(
			&commission,
			`
			SELECT emt.staffid, cah.commission + cag.commission AS commission1
			FROM
			Commission_amount_host AS cah, Commission_amount_guest AS cag,
			Guest_transfer AS gt,
			Host_transfer AS ht,
			MoneyTransfer AS mt,
			Employee_manage_transfer as emt
			WHERE
			cah.amount = cag.amount
			AND
			cag.amount = gt.amount
			AND
			cah.amount = ht.amount
			AND
			gt.TransactionNum = ht.TransactionNum
			AND
			gt.TransactionNum = mt.TransactionNum
			AND
			mt.TransactionNum = emt.TransactionNum
			GROUP BY emt.staffid, commission1
			`,
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, commission)
	})

	authAPI.GET("/guests_talk_to_hosts", func(c echo.Context) error {
		var guests []string
		if err := dbx.Select(
			&guests,
			`
			SELECT guestid
			FROM talk_host_guest
			WHERE host_id = $1
			`,
			c.QueryParam("host_id"),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, guests)
	})

	authAPI.POST("/employee", func(c echo.Context) (err error) {
		newEmployee := new(Employee)
		if err = c.Bind(newEmployee); err != nil { // bind request body to struct
			return
		}

		if _, err = dbx.NamedExec(
            `
            INSERT INTO employee (staffid, age, race)
            VALUES (
                :staffid,
                :age,
                :race
            )
            `,
            newEmployee); err != nil {
            log.Print(err)
            return c.String(http.StatusBadRequest, "Invalid insert")
        }


			employees := []Employee{}
			if err := dbx.Select(
			&employees,
			`
			SELECT * FROM employee
			`,
		); err != nil {
			log.Fatal(err)
			return c.JSON(http.StatusBadRequest, "Invalid insert")
		}
		return c.JSON(http.StatusOK, employees)
	})

	authAPI.DELETE("/delete_staff", func(c echo.Context) error {
		if _, err := dbx.Exec(
			`
			delete from employee
			where staffid = $1
			`,
			c.QueryParam("staff_id"),
		); err != nil {
			log.Fatal(err)
		}


		employees := []Employee{}
		if err := dbx.Select(
			&employees,
			`
			SELECT * FROM employee
			`,
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, employees)
	})

	authAPI.POST("/update_ziphood", func(c echo.Context) error {
		update := new(UpdateZiphood)
		if err := c.Bind(update); err != nil { // bind request body to struct
			return err
		}

		if _, err := dbx.Exec(
			`
			UPDATE Zip_hood
			SET zipcode = $1, HouseLocation = $2
			where zipcode = $3
			`,
			update.Zip2,
			update.HouseLocation,
			update.Zip1,
		); err != nil {
			log.Fatal(err)
		}


		ziphood := []Ziphood{}
		if err := dbx.Select(
			&ziphood,
			`
			SELECT * FROM Zip_hood
			`,
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, ziphood)
	})

	authAPI.GET("/get_avg_money", func(c echo.Context) error {
		var money float32
		if err := dbx.Get(
			&money,
			`
			select avg(amount)
			from moneytransfer
			where date = $1
			`,
			c.QueryParam("date"),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, money)
	})

	authAPI.GET("/get_guests_by_sin", func(c echo.Context) error {
		var sins []int
		if err := dbx.Select(
			&sins,
			`
			select g.SIN
			from guest_account as g
			where not exists (
			(select l.ListingID
					from Listing_Info as l)
			except
			(select v.ListingID
					from View_listing as v
					where v.SIN = g.SIN))
			`,
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, sins)
	})

	authAPI.GET("/account_with_rating", func(c echo.Context) error {
		var accounts []Account
		if err := dbx.Select(
			&accounts,
			`
			select ListingID, HostAccountNum
			from Review_Info
			where rating > (select Max(rating) from Review_Info where ListingID = $1)
			`,
			c.QueryParam("listingid"),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, accounts)
	})


	authAPI.DELETE("/delete_upcomingbooking", func(c echo.Context) error {
		if _, err := dbx.Exec(
			`
			delete from UpcomingBooking
			where confirmationnum = $1
			`,
			c.QueryParam("ConfirmationNum"),
		); err != nil {
			log.Fatal(err)
		}


		upcomingbooking := []UpcomingBooking{}
		if err := dbx.Select(
			&upcomingbooking,
			`
			SELECT * FROM UpcomingBooking
			`,
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, upcomingbooking)
	})

	authAPI.GET("/get_projection", func(c echo.Context) error {
		var results []string
		if err := dbx.Select(
			&results,
			fmt.Sprintf(
				"select %s from employee", c.QueryParam("projection"),
			),
		); err != nil {
			log.Fatal(err)
		}
		return c.JSON(http.StatusOK, results)
	})

	authAPI.GET("/get_join", func(c echo.Context) error {
		rows, err := dbx.Queryx(
			fmt.Sprintf(
				"select * from %s, %s", c.QueryParam("table1"), c.QueryParam("table2"),
			),
		)
		if err != nil {
			log.Fatal(err)
		}

		var results []interface{}
		for rows.Next() {
			result := make(map[string]interface{})
			err = rows.MapScan(result)
			if err != nil {
				log.Fatal(err)
			}
			results = append(results, result)
		}
		return c.JSON(http.StatusOK, results)
	})

	port := os.Getenv("PORT")
	if port == "" {
		os.Setenv("PORT", "1323")
		port = os.Getenv("PORT")
	}
	e.Logger.Fatal(e.Start(":" + port))
}

