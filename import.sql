create table Employee(
	
	staffID varchar(10) primary key,
	age int,
	race varchar(50)
	);
	insert into Employee values('E01', 23, 'White');
	insert into Employee values('E02', 30, 'Black');
	insert into Employee values('E03', 35, 'East Asian');
	insert into Employee values('E04', 56, 'Southeast Asian');
	insert into Employee values('E05', 60, 'Hispanic');


create table MoneyTransfer(
	
	TransactionNum int primary key,
	Date date not null,
	amount int not null
	);
	insert into MoneyTransfer values(23687, '2019-11-13', 200);
	insert into MoneyTransfer values(35671, '2019-11-14', 600);
	insert into MoneyTransfer values(37837, '2019-11-15', 500);
	insert into MoneyTransfer values(98947, '2019-11-16', 1000);
	insert into MoneyTransfer values(37489, '2019-11-17', 100);


create table UpcomingBooking(

		ConfirmationNum int primary key,
		CheckinTime date not null,
		ListingID varchar(100)
		);

	insert into UpcomingBooking values(2019111, '2019-02-06', 'L01');
	insert into UpcomingBooking values(2019112, '2019-07-10', 'L02');
	insert into UpcomingBooking values(2019113, '2019-07-23', 'L03');
	insert into UpcomingBooking values(2019114, '2019-12-03', 'L04');
	insert into UpcomingBooking values(2019115, '2019-12-24', 'L05');

create table BookingHistory(

		ConfirmationNum int primary key,
		CheckInTime date not null,
		CheckOutTime date not null,
		ListingID varchar(100)
	);

insert into BookingHistory values (111, '2018-12-24', '2018-12-28', 'L05');
insert into BookingHistory values (112, '2015-02-28', '2015-03-01', 'L02');
insert into BookingHistory values (113, '2017-05-12', '2017-06-12', 'L01');
insert into BookingHistory values (114, '2016-08-15', '2016-08-16', 'L03');
insert into BookingHistory values (115, '2013-10-01', '2013-10-07', 'L03');

create table Host_Account(

		Host_ID varchar(10) primary key,
		BankInfo varchar(100),
		HostName varchar(100),
		StartTime date not null,
		AccountNum varchar(10) UNIQUE not null
	);
	
	insert into Host_Account values('H01', 'A1234', 'Bojack', '2014-01-30', 'HA01');
	insert into Host_Account values('H02', 'B4321', 'Princess Carolynn',  '2015-02-28', 'HA02');
	insert into Host_Account values('H03', 'C5678', 'Todd', '2015-03-24', 'HA03');
	insert into Host_Account values('H04', 'D8765', 'Mr.Peanutbutter','2015-04-04', 'HA04');
	insert into Host_Account values('H05', 'E9101', 'Diane', '2015-04-27', 'HA05');


create table Guest_Account(

		GAccountNum varchar(10) UNIQUE,
		CreditCardNum int,
		GuestName varchar(100),
		GuestCity varchar(100),
		SIN int primary key
		);

insert into Guest_Account values ('GA01', 12345678, 'Lang', 'Hangzhou', 911911911);
insert into Guest_Account values ('GA02', 87654321, 'Harper', 'Beijing', 912912912);
insert into Guest_Account values ('GA03', 23456789, 'Lily', 'Chengdu', 913913913);
insert into Guest_Account values ('GA04', 98765432, 'Sophia', 'Changsha', 914914914);
insert into Guest_Account values ('GA05', 34567890, 'Sherry', 'Shenyang', 915915915);
insert into Guest_Account values ('GA06', 123123123, 'Rick', 'Mars', 123123123);
insert into Guest_Account values ('GA07', 321321321, 'Morty', 'Moon', 321321321);
insert into Guest_Account values ('GA08', 456456456, 'Summer', 'Jupiter', 456456456);
insert into Guest_Account values ('GA09', 654654654, 'Beth', 'Venus', 654654654);
insert into Guest_Account values ('GA10', 789789789, 'Jerry', 'Uranus', 789789789);


create table Talk_host_guest(
 
		Host_ID varchar(10),
		GuestID int,
		NumOfInteractions int,
		FirstInteraction date,
		LastInteraction date,
		primary key(Host_ID, GuestID),
		foreign key (Host_ID) references Host_Account(Host_ID)
			on delete cascade
			on update cascade,
		foreign key (GuestID) references Guest_Account(SIN)
			on delete cascade
			on update cascade
		);


insert into Talk_host_guest values ('H01', 911911911, 3, '2020-02-19', '2020-02-21');
insert into Talk_host_guest values ('H02', 912912912, 2, '2020-02-19', '2020-02-20');
insert into Talk_host_guest values ('H02', 913913913, 1, '2020-02-20', '2020-02-20');
insert into Talk_host_guest values ('H02', 914914914, 5, '2020-02-19', '2020-02-25');
insert into Talk_host_guest values ('H02', 915915915, 1, '2020-02-19', '2020-02-24');

create table Talk_guest_employee(

		GuestID int,
		staffID varchar(10),
		NumOfInteractions int,
		FirstInteraction date,
		LastInteraction date,
		primary key(GuestID, staffID),
		foreign key (GuestID) references Guest_Account(SIN)
			on delete cascade
			on update cascade,
		foreign key (staffID) references Employee(staffID)
			on delete cascade
			on update cascade
		);

insert into Talk_guest_employee values (911911911, 'E04', 1, '2020-02-20', '2020-02-20'); 
insert into Talk_guest_employee values (912912912, 'E03', 0, NULL, NULL);
insert into Talk_guest_employee values (913913913, 'E01', 3, '2020-02-21', '2020-02-28');
insert into Talk_guest_employee values (914914914, 'E01', 2, '2020-02-16', '2020-02-20');
insert into Talk_guest_employee values (915915915, 'E01', 1, '2020-02-16', '2020-02-16');

create table Review_Info(
		
		ListingID varchar(10),
		HostAccountNum varchar(10),
		ReviewerID int, 
		rating int,
		comments varchar(300),
		date date,
		Primary Key(ListingID, HostAccountNum), 
		foreign key (HostAccountNum) references Host_Account(AccountNum)
			on delete cascade
			on update cascade
	);

insert into Review_Info values ('L01', 'HA03', 123123123, 4, 'Good', '2019-03-01');
insert into Review_Info values ('L02', 'HA02', 321321321, 4, 'Not bad', '2019-04-01');
insert into Review_Info values ('L03', 'HA01', 456456456, 3, 'Don’t like it', '2019-03-04');
insert into Review_Info values ('L04', 'HA04', 654654654, 5, 'Great', '2019-05-23');
insert into Review_Info values ('L05', 'HA05', 789789789, 5, 'Nice', '2019-01-01');

create table Re_HAcct(
		reviewNum varchar(10) UNIQUE, 
		HostAccountNum varchar(10),
		ListingID varchar(10),
		primary key(reviewNum, HostAccountNum, ListingID),
		foreign key (ListingID,HostAccountNum) references Review_Info(ListingID, HostAccountNum)
			on delete cascade
			on update cascade
	);

insert into Re_HAcct values ('R01', 'HA01', 'L03');
	insert into Re_HAcct values ('R02', 'HA01', 'L03');
	insert into Re_HAcct values ('R03', 'HA02', 'L02');
	insert into Re_HAcct values ('R04', 'HA04', 'L04');
	insert into Re_HAcct values ('R05', 'HA05', 'L05');

create table Talk_host_employee(

		Host_ID varchar(10),
		staffID varchar(10),
		NumOfInteractions int,
		FirstInteraction date,
		LastInteraction date,
		primary key(Host_ID, staffID),
		foreign key (Host_ID) references Host_Account(Host_ID)
			on delete cascade
			on update cascade,
		foreign key (staffID) references Employee(staffID)
			on delete cascade
			on update cascade
		);
	
insert into Talk_host_employee values ('H01', 'E01', 1, '2020-02-19', '2020-02-19');
insert into Talk_host_employee values ('H02', 'E02', 9, '2020-02-20', '2020-02-22');
insert into Talk_host_employee values ('H03', 'E03', 1, '2020-02-20', '2020-02-20');
insert into Talk_host_employee values ('H04', 'E04', 1, '2020-02-22', '2020-02-22');
insert into Talk_host_employee values ('H05', 'E01', 1, '2020-02-22', '2020-02-22');


create table Reviewers(

		ReviewerID int primary key,
		ReviewerName varchar(100),
		foreign key (ReviewerID) references Guest_Account(SIN)
			on delete cascade
			on update cascade
	);

insert into Reviewers values (123123123, 'Rick');
insert into Reviewers values (321321321, 'Morty');
insert into Reviewers values (456456456, 'Summer');
insert into Reviewers values (654654654, 'Beth');
insert into Reviewers values (789789789, 'Jerry');

create table Reviews(

		ReviewerID int,
		Host_ID varchar(10),
		reviewNum varchar(10),
		Rating int,
		Comments varchar(1000), 
		Date date,
		primary key(Host_ID, reviewNum),
		foreign key (ReviewerID) references Guest_Account(SIN)
			on delete cascade
			on update cascade,
		foreign key (Host_ID) references Host_Account(Host_ID)
			on delete cascade
			on update cascade,
		foreign key (reviewNum) references Re_HAcct(reviewNum)
			on delete cascade
			on update cascade
		);

insert into Reviews values (123123123, 'H01', 'R01', 4 , 'Good', '2019-03-01');
insert into Reviews values (321321321, 'H02', 'R02', 4, 'Not Bad', '2019-04-01');
insert into Reviews values (456456456, 'H03', 'R03', 3 , 'Don’t like it', '2019-03-04');
insert into Reviews values (654654654, 'H04', 'R04', 5, 'Great', '2019-05-23');
insert into Reviews values (789789789, 'H05', 'R05', 5, 'Nice', '2019-01-01');


create table Zip_hood(
		
Zipcode int primary key,
		HouseLocation varchar(200)
	);

	insert into Zip_hood values(78702, '123 Crosby St');
	insert into Zip_hood values(78729, '462 Wooster St');
	insert into Zip_hood values(78749, '1003 Mercer St');
	insert into Zip_hood values(78704, '3861 Forsyth St');
	insert into Zip_hood values(78705, '5 Broadway St');

create table Listing_Info(
	
	ListingID varchar(10) UNIQUE,
		HostAccountNum varchar(10),
		NumOfGuests int,
		Price int, 
		HouseType varchar(200),
		Zipcode int,
		NumberOfReview int,
		Availability bool,
		primary key (ListingID, HostAccountNum),
		foreign key (Zipcode) references Zip_hood(Zipcode)
			on delete cascade
			on update cascade,
		foreign key (HostAccountNum) references Host_Account(AccountNum)
			on delete cascade
			on update cascade
	);
	 
insert into Listing_Info values('L01', 'HA03', 3, 100, 'House', 78702, 29, TRUE);
	insert into Listing_Info values('L02', 'HA01', 4, 100, 'Bungalow', 78729, 40, TRUE);
	insert into Listing_Info values('L03', 'HA02', 3, 100, 'Condominium', 78749, 20, TRUE);
	insert into Listing_Info values('L04', 'HA04', 1, 100, 'Apartment', 78704, 10, TRUE);
	insert into Listing_Info values('L05', 'HA05', 2, 100, 'Townhouse', 78705, 15, TRUE );


create table View_listing(

		SIN int,
		AccountNum varchar(10),
		ListingID varchar(10),
		primary key(SIN, AccountNum, ListingID),
		foreign key (SIN) references Guest_Account(SIN)
			on delete cascade
			on update cascade,
		foreign key (AccountNum) references Host_Account(AccountNum)
			on delete cascade
			on update cascade,
		foreign key (ListingID) references Listing_Info(ListingID)
			on delete cascade
			on update cascade
	);

insert into View_listing values (911911911, 'HA03', 'L01');
insert into View_listing values (911911911, 'HA03', 'L02');
insert into View_listing values (911911911, 'HA03', 'L03');
insert into View_listing values (911911911, 'HA03', 'L04');
insert into View_listing values (911911911, 'HA03', 'L05');

insert into View_listing values (912912912, 'HA01', 'L02');
insert into View_listing values (913913913, 'HA02', 'L03');
insert into View_listing values (914914914, 'HA04', 'L04');
insert into View_listing values (915915915, 'HA05', 'L05');


create table Access(

		staffID varchar(10),
		ListingID varchar(10),
		HostAccountNum varchar(10),
		foreign key (staffID) references Employee(staffID)
			on delete cascade
			on update cascade,
		foreign key (HostAccountNum) references Host_Account(AccountNum)
			on delete cascade
			on update cascade,
		foreign key (ListingID) references Listing_Info(ListingID)
			on delete cascade
			on update cascade
		);

insert into Access values ('E01', 'L01',  'HA03' );
insert into Access values ('E01', 'L02',  'HA01' );
insert into Access values ('E02', 'L01',  'HA03' );
insert into Access values ('E03', 'L01',  'HA03' );
insert into Access values ('E04', 'L05',  'HA05' );

create table Commission_amount_guest(

		amount int primary key,
		Commission int);

insert into Commission_amount_guest values (100, 10);
insert into Commission_amount_guest values (200, 20);
insert into Commission_amount_guest values (500, 50);
insert into Commission_amount_guest values (600, 60);
insert into Commission_amount_guest values (1000, 100);


create table Guest_transfer(

		AccountNum varchar(10),
		TransactionNum int,
		amount int,
		primary key(AccountNum, TransactionNum),
		foreign key (AccountNum) references Guest_Account(GAccountNum)
			on delete cascade
			on update cascade,
		foreign key (TransactionNum) references MoneyTransfer(TransactionNum)
			on delete cascade
			on update cascade,
		foreign key (amount) references Commission_amount_guest(amount)
			on delete cascade
			on update cascade
		);
insert into Guest_transfer values ('GA01', 98947, 1000);
insert into Guest_transfer values ('GA02', 37489, 100);
insert into Guest_transfer values ('GA03', 23687, 200);
insert into Guest_transfer values ('GA04', 37837, 500);
insert into Guest_transfer values ('GA05', 35671, 600);


create table Commission_amount_host(
		amount int primary key,
		Commission int
		);
insert into Commission_amount_host values (100, 20);
insert into Commission_amount_host values (200, 40);
insert into Commission_amount_host values (500, 100);
insert into Commission_amount_host values (600, 120);
insert into Commission_amount_host values (1000, 200);


create table Host_transfer(

		AccountNum varchar(10),
		TransactionNum int,
		amount int,
		primary key(AccountNum, TransactionNum),
		foreign key (AccountNum) references Host_Account(AccountNum)
			on delete cascade
			on update cascade,
		foreign key (TransactionNum) references MoneyTransfer(TransactionNum)
			on delete cascade
			on update cascade,
		foreign key (amount) references Commission_amount_host(amount)
			on delete cascade
			on update cascade
		);
insert into Host_transfer values ('HA01', 98947, 1000);
insert into Host_transfer values ('HA02', 37489, 100);
insert into Host_transfer values ('HA02', 23687, 200);
insert into Host_transfer values ('HA03', 37837, 500);


create table Employee_manage_transfer(
		TransactionNum int,
		staffID varchar(10),
		primary key (TransactionNum, staffID),
		foreign key (TransactionNum) references MoneyTransfer(TransactionNum)
			on delete cascade
			on update cascade,
		foreign key (staffID) references Employee
			on delete cascade
			on update cascade
		);
insert into Employee_manage_transfer values (23687, 'E01');
insert into Employee_manage_transfer values (35671, 'E02');
insert into Employee_manage_transfer values (37837, 'E03');
insert into Employee_manage_transfer values (98947, 'E03');
insert into Employee_manage_transfer values (37489, 'E04');



create table Contain_Order(
	
	confirmationNum int primary key,
	AccountNum varchar(10),
	GAccountNum varchar(10),
	CheckInTime date,
	foreign key (AccountNum) references Host_Account(AccountNum)
		on delete cascade
		on update cascade,
	foreign key (GAccountNum) references Guest_Account(GAccountNum)
		on delete cascade
		on update cascade
	);
	insert into Contain_Order values(2019111, 'HA03', 'GA04', '2019-02-06');
	insert into Contain_Order values(2019112, 'HA01', 'GA01', '2019-07-10');
	insert into Contain_Order values(2019113, 'HA02', 'GA03', '2019-07-23');
	insert into Contain_Order values(2019114, 'HA02', 'GA04', '2019-12-03');
	insert into Contain_Order values(2019115, 'HA03', 'GA05', '2019-12-24');


/*  1. get employees by race
	2. get transactions from moneytransfer  with amount > input and date > input
	3. get host account number from moneytransfer joining hosttransfer with amount > input and date > input
	4. get staffid and commission amount
	5. insert employee
	6. delete employee by specifying a staff id
	7. delete upcomingbooking by confirmation number 
	8. update ziphood table
	9. get average amount of money transfer by date
	10. get all guests who viewed all listings
*/
