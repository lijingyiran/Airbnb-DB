SELECT staffid
FROM employee
WHERE race = $1



SELECT *
FROM moneytransfer
WHERE amount > $1 and date > $2



SELECT accountnum
FROM moneytransfer
NATURAL JOIN host_transfer
WHERE amount > $1 and date > $2



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


SELECT guestid
FROM talk_host_guest
WHERE host_id = $1


INSERT INTO employee (staffid, age, race)
            VALUES (
                :staffid,
                :age,
                :race
            )


delete from employee
where staffid = $1


UPDATE Zip_hood
SET zipcode = $1, HouseLocation = $2
where zipcode = $3



select avg(amount)
from moneytransfer
where date = $1


select g.SIN
			from guest_account as g
			where not exists (
			(select l.ListingID
					from Listing_Info as l)
			except
			(select v.ListingID
					from View_listing as v
					where v.SIN = g.SIN))



delete from UpcomingBooking
where confirmationnum = $1


select ListingID, HostAccountNum
from Review_Info
where rating > (select Max(rating) from Review_Info where listingId = $1)