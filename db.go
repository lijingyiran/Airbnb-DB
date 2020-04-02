// connection file
// connects to db (postgres) and establishes mapping between the actual db and objects defined above

package main

import (
    "fmt"
    "log"

    "github.com/jmoiron/sqlx"
)

type Employee struct {
    Staffid string `db:"staffid"`
    Age     string `db:"age"`
    Race    string `db:"race"`
}

type MoneyTransfer struct {
    TransactionNum string `db:"transactionnum"`
    Date     string `db:"date"`
    Amount    string `db:"amount"`
}

type Commission struct {
    Commission int `db:"commission1"`
    Staffid string `db:"staffid"`
}


type UpcomingBooking struct {
    ConfirmationNum int `db:"confirmationnum"`
    CheckinTime string `db:"checkintime"`
    ListingID string   `db:"listingid"`
}

type UpdateZiphood struct {
    Zip1 string `json:"zip1"`
    Zip2 string `json:"zip2"`
    HouseLocation string `json:"houselocation"`
}

type Ziphood struct {
    Zipcode int `db:"zipcode"`
    Houselocation string `db:"houselocation"`
}

type Account struct {
		ListingID string `db:"listingid"`
		HostAccountNum string `db:"hostaccountnum"`
}

const (
    host     = "ec2-34-200-101-236.compute-1.amazonaws.com" // "localhost"
    port     = 5432
    user     = "shcgxryqudmcvh"
    password = "a2ae8fd1dae57ed5b881bf9136517d4c2afb99bcccc36992bff9c8468c0ca9f0"
    dbname   = "dahmtbvtqmfflh"
)

func generateDBXConnection() string {
    connString := fmt.Sprintf("host=%s port=%d user=%s "+
        "password=%s dbname=%s sslmode=require",
        host, port, user, password, dbname)
    return connString
}

func connectToDb(connType string, connString string) *sqlx.DB {
    db, err := sqlx.Connect(connType, connString)
    if err != nil {
        log.Println(err)
        log.Fatal("Error connectToDb 1")
    }
    return db
}

