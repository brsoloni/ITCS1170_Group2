use master;
go
drop database Dealership; --For now, I have this here for testing table statements.
go
create database Dealership;
go
use Dealership;
go


--Create Table Statements: Nick Barney
create table ZipCode (
	ZipCodeID int not null, --- Needed to change this to integer as the zipcode was being limited by the smallint to only the 32767 value
	City char(20) not null,
	PeopleState char(12) default 'Michigan' not null,
--constraints
	constraint zipcode_zipcodeid_pk Primary Key (ZipCodeID)
);
go


create table People (
	PeopleID int identity(1000, 1) not null,
	PeopleType char(20) default 'Customer' not null,
	FirstName char(15) not null,
	LastName char(15) not null,
	DOB date not null,
	PeopleAddress varchar(80) not null,
	SSN int not null, 
	ZipCodeID int not null,  --- Needed to change this to integer as the zipcode was being limited by the smallint to only the 32767 value
	Email varchar(50) not null,
	Phone varchar(10) not null, --- Needed to change this to varchar as the phone number field was limited by the int data type.
	--constraints
	constraint people_peopleid_pk primary key (PeopleID),
	constraint people_zipcodeid_fk foreign key (ZipCodeID) references ZipCode (ZipCodeID)
		on update cascade
		on delete no action
);
go

--drop table customer;
create table Customer (
	PeopleID int not null,
	CustomerCard char(15) not null,
	--constraints
	constraint customer_peopleid_pk primary key (PeopleID),
	constraint customer_peopleid_fk foreign key (PeopleID) references People (PeopleID)
		on update cascade
		on delete no action
);
go

create table Employee (
	PeopleID int not null,
	EmployeeLicense char(15) not null,
	--constraints
	constraint employee_peopleid_pk primary key (PeopleID),
	constraint employee_peopleid_fk foreign key (PeopleID) references People (PeopleID)
		on update cascade
		on delete no action
);
go

create table Feature (
	FeatureID smallint identity(1, 1) not null,
	FeatureName char(25) not null,
	FeatureDesc varchar(100) not null,
	Price decimal (6, 2) not null,
	--constraints
	constraint feature_featureid_pk primary key (FeatureID)
);
go

create table Inventory (
	InventoryID int identity(100, 1) not null,
	InventoryType char(7) not null,
	QuantityInStock smallint not null,
	--constraints
	constraint inventory_inventoryid_pk primary key (InventoryID)
);
go

create table Feature_Inventory (
	FeatureID smallint not null,
	InventoryID int not null,
	--constraints
	constraint featureinventory_featureinventoryid_pk primary key (FeatureID, InventoryID),
	constraint featureinventory_featureid_fk foreign key (FeatureID) references Feature (FeatureID)
		on update cascade
		on delete no action,
	constraint featureinventory_inventoryid_fk foreign key (InventoryID) references Inventory (InventoryID)
		on update cascade
		on delete no action
);
go

create table Make (
	MakeID smallint identity(1000, 100) not null,
	MakeDesc varchar(100)  not null,
	--constraints
	constraint make_makeid_pk primary key (MakeID)
);
go

create table Model (
	ModelID smallint identity(100, 100) not null,
	ModelDesc varchar(100)  not null,
	--constraints
	constraint model_modelid_pk primary key (ModelID)
);
go

create table Color (
	ColorID tinyint identity(10, 10) not null,
	ColorDesc char(50) not null,
	--constraints
	constraint color_colorid_pk primary key (ColorID)
);
go

create table VehicleType (
	TypeID tinyint identity(1, 1) not null,
	VehicleType char(15) not null,
	--constraints
	constraint vehicletype_typeid_pk primary key (TypeID)
);
go


create table Vehicle (
	VehicleID int identity(1,1) not null,
	MakeID smallint not null,
	ModelID smallint not null,
	ColorID tinyint not null,
	TypeID tinyint not null,
	InventoryID int not null,
	VehicleYear smallint not null,
	WholesalePrice decimal (8, 2) not null,  ---Updated this to 8,2 from 6,2; ERD UPDATED
	RetailPrice decimal (8, 2) not null,  ---Updated this to 8,2 from 6,2; ERD UPDATED
	--key constraints
	constraint vehicle_vehicleid_pk primary key (VehicleID),
	constraint vehicle_makeid_fk foreign key (MakeID) references Make (MakeID)
		on update cascade
		on delete no action,
	constraint vehicle_modelid_fk foreign key (ModelID) references Model (ModelID)
		on update cascade
		on delete no action,
	constraint vehicle_colorid_fk foreign key (ColorID) references Color (ColorID)
		on update cascade
		on delete no action,
	constraint vehicle_typeid_fk foreign key (TypeID) references VehicleType (TypeID)
		on update cascade
		on delete no action,
	constraint vehicle_inventoryid_fk foreign key (InventoryID) references Inventory (InventoryID)
		on update cascade
		on delete no action,
	--check constraints
	constraint vehicle_wholesaleprice_ck check (WholesalePrice <= RetailPrice),
	constraint vehicle_retailprice_ck check (RetailPrice >= WholesalePrice)
);
go



create table Invoice (
	InvoiceID int identity(1000,1) not null,
	CustomerID int not null,
	EmployeeID int not null,
	VehicleID int not null,
	Price decimal(8,2) not null, ---Updated this to 8,2 from 6,2 --ERD UPDATED
	--constraints
	constraint invoice_invoiceid_pk primary key (InvoiceID),
	constraint invoice_customerid_fk foreign key (CustomerID) references People (PeopleID) 
		on update no action
		on delete no action,
	constraint invoice_employeeid_fk foreign key (EmployeeID) references People (PeopleID)
		on update no action
		on delete no action,
	constraint invoice_vehicleid_fk foreign key (VehicleID) references Vehicle (VehicleID)
		on update cascade
		on delete no action
);
go

create table Feature_Invoice (
	FeatureID smallint not null,
	InvoiceID int not null,
	--constraints
	constraint featureinvoice_featureinvoiceid_pk primary key (FeatureID, InvoiceID),
	constraint featureinvoice_featureid_fk foreign key (FeatureID) references Feature (FeatureID)
		on update cascade
		on delete no action,
	constraint featureinvoice_invoiceid_fk foreign key (InvoiceID) references Invoice (InvoiceID)
		on update cascade
		on delete no action
);
go



--Insert Data for Make Table--By Brad Metzger
insert into Make
	(MakeDesc)
values
	('Audi'),('BMW'),('Cadillac'),('Chevrolet'),('Chrysler'),('Dodge'),('Ford'),('Honda'),('Toyota'),('Nissan');
go


--Insert Data for Model Table--By Brad Metzger
insert into Model
	(ModelDesc)
values
	('A3'), ('3 Series'), ('Lyriq'), ('Suburban'), ('300'), ('Ram'), ('F-150'), ('Civic'), ('Camry'), ('Ultima');
go


--Insert Data for Color Table--By Brad Metzger
insert into Color
	(ColorDesc)
values
	('White'), ('Red'), ('Black'), ('Gold'), ('Silver'), ('Blue'), ('Green'), ('Champagne'), ('Yellow'), ('Purple');
go

--Insert Data for VehicleType Table--By Brad Metzger
insert into VehicleType
	(VehicleType)
values
	('Sedan'), ('Coupe'), ('Sports Car'), ('Station Wagon'), ('Hatchback'), ('Convertible'), ('SUV'), ('Mini Van'), ('Pickup Truck'), ('Commercial');
	go

--Insert Data for Inventory Table--By Brad Metzger
insert into Inventory
	(InventoryType, QuantityInStock)
values
	('Vehicle', 2),
	('Vehicle', 0),
	('Vehicle', 6),
	('Vehicle', 1),
	('Vehicle', 3),
	('Vehicle', 12),
	('Vehicle', 1),
	('Vehicle', 2),
	('Vehicle', 1),
	('Vehicle', 4);
go


----Insert Data for Vehicle Table--By Brad Metzger

----set identity_insert vehicle off
insert into Vehicle
	(MakeID, ModelID, VehicleYear, ColorID, TypeID, InventoryID, WholesalePrice, RetailPrice)
values
	(1000, 100, 2020, 30, 1, 103, 52500.00, 58000.00),
	(1100, 200, 2021, 10, 2, 104, 65000.00, 69000.00),
	(1200, 300, 2022, 50, 4, 106, 89000.00, 92000.00),
	(1300, 400, 2020, 20, 7, 107, 75000.00, 79000.00),
	(1400, 500, 2022, 40, 1, 108, 45000.00, 60000.00),
	(1500, 600, 2021, 60, 9, 109, 56000.00, 62000.00),
	(1600, 700, 2019, 70, 9, 101, 70000.00, 78000.00),
	(1700, 800, 2022, 80, 1, 100, 55000.00, 58000.00),
	(1800, 900, 2021, 90, 1, 102, 60000.00, 62000.00),
	(1900, 1000, 2020, 100, 1, 105, 49000.00, 51000.00); --change wholesale and retail to test check constraint-- CONFIRMED this work!!!
	----set identity_insert vehicle on


--Insert Data for Zipcode Table--By Brad Metzger
insert into Zipcode
	(ZipCodeID, City, PeopleState)
Values
	(48154,'Livonia','Michigan'),
	(48152,'Livonia','Michigan'),
	(48313,'Sterling Heights','Michigan'),
	(48040,'Madison Heights','Michigan'),
	(48240,'Redford Twp.','Michigan'),
	(48219,'Novi','Michigan'),
	(48984,'Lansing','Michigan'),
	(90210,'Beverly Hills','California'),
	(48714,'Beverly Hills','Michigan'),
	(49474,'Grayling','Michigan');
go

--Insert Data for People Table -- By Brad Metzger
insert into People
	(PeopleType, FirstName, LastName, DOB, PeopleAddress, SSN, ZipCodeID, Email, Phone)
values
	('Employee', 'John', 'Smith', '01/15/1987', '12467 White Pine Dr.', '698955564', '48154', 'johnsmith@hotmail.com', '5865551147'),
	('Employee', 'Jane', 'Lane', '10/17/2000', '35874 Homer Dr.', '254785486', '48240', 'jl@gmail.com', '5865551277'),
	('Employee', 'John', 'Jack', '9/5/1978', '411 Harper Ave', '987654321', '48984', 'JohnJack@lycos.com', '5865559854'),
	('Employee', 'Jamie', 'Sanders', '5/15/1988', '6957 Candy Cane Lane', '876543219', '48313', 'candycanelane@northpole.com', '5865555417'),
	('Employee', 'Sandy', 'Miller', '4/17/1981', '6587 Pabst Ave', '765432198', '90210', 'millertime@molson.com', '5865559632'),
	('Employee', 'Wyatt', 'Hobbs', '12/25/1992', '7484 Riverland Dr', '654321987', '48040', 'Hobbstoit@carrotsRus.com', '5865556328'),
	('Employee', 'Johnny', 'Knoxville', '01/20/1988', '12467 Black Pine Dr.', '698955565', '48984', 'johnny@hotmail.com', '5865551146'),
	('Employee', 'Jay Anne', 'Long', '11/17/1984', '35 Homer Run Dr.', '254785487', '48313', 'jayanne@gmail.com', '5865551276'),
	('Employee', 'Jack', 'Frost', '6/15/1974', '19 Grand Ave', '987654320', '48714', 'Frostyone@fetch.com', '5865559853'),
	('Employee', 'Morley', 'Coco', '8/7/1987', '6977 Candy Cane Lane', '876543218', '48219', 'cocoman@northpole.com', '5865555416'),
	('Employee', 'Morgan', 'Wallace', '3/17/1981', '687 Water Ave', '765432197', '48219', 'wallace@molson.com', '5865559631'),
	('Employee', 'Chase', 'Kim', '12/18/1965', '6847 Washington Dr', '654321986', '48240', 'chasehim@nascar.com', '5865556327'),
	('Customer', 'Ronny', 'Mancotti', '2/14/1974', '87 Pasta Road', '543219876', '48219', 'pastaman@pastashop.com', '5865555874'),
	('Customer', 'Cher', 'Sonney', '04/16/1962', '695 Singer Drive', '432198765', '48714', 'singingallday@songer.com', '5865555412'),
	('Customer', 'Todd', 'Bertuzzi', '04/04/1944', '44 Sniper Drive', '321987654', '48984', 'hockey4life@puckhead.com', '5865554444'),
	('Customer', 'Tim', 'Cheveldae', '06/15/1995', '624 Pull Goalie Lane', '219876543', '48219', 'anothergoal@helmethead.com', '5865556573'),
	('Customer', 'Paul', 'Coffee', '06/09/1962', '7544 Defense Street', '198765432', '48040', 'trophyman@stanley.com', '5865557777'),
	('Customer', 'Jonny', 'Mancini', '3/15/1976', '75 Rager Road', '543219875', '48219', 'Doughman@pastashop.com', '5865555873'),
	('Customer', 'Cheryl', 'Sonet', '04/16/1962', '695 Singer Drive', '432198764', '48714', 'Cherry@singer.com', '5865555411'),
	('Customer', 'Ted', 'Bert', '02/02/1988', '456 Bear Drive', '321987653', '48984', 'tedEBear@buildabear.com', '5865554445'),
	('Customer', 'Tom', 'Chevy', '10/15/1996', '624 Pull Goalie Lane', '219876542', '48219', 'chevyman@trucker.com', '5865556572'),
	('Customer', 'Paulina', 'Barq', '05/10/1962', '7544 Defense Street', '198765431', '48040', 'trophygirl@Winner.com', '5865557778');
go



----Insert Data for Customer Table -- By Brad Metzger
insert into Customer
	(PeopleID, CustomerCard)
Values
	('1006', '123456789'),
	('1007', '234567891'),
	('1008', '345678912'),
	('1009', '456789123'),
	('1010', '567891234'),
	('1011', '567891231'),
	('1012', '567891232'),
	('1013', '567891233'),
	('1014', '567891234'),
	('1015', '567891235');
go


------Insert Data for Employee Table -- By Brad Metzger
insert into Employee
	(PeopleID, EmployeeLicense)
Values
	('1000', 'S 123456789'),
	('1001', 'L 234567891'),
	('1002', 'J 345678912'),
	('1003', 'S 456789123'),
	('1004', 'M 567891234'),
	('1005', 'H 567891231'),
	('1006', 'K 567891232'),
	('1007', 'L 567891233'),
	('1008', 'F 567891234'),
	('1009', 'C 567891235'),
	('1010', 'C 765432197'),
	('1011', 'W 654321986');
go

------Insert Data for Feature Table -- By Brad Metzger
insert into feature
	(FeatureName, FeatureDesc, Price)
Values
	('Heated Seats', 'Cold Weather Package - Heated Seats', 650),
	('Cooling Seats', 'Warm Weather Package - Cooling Seats', 700),
	('Sun Roof', 'Warm Weather Package - Sun Roof', 1250),
	('Trailer Hitch', 'Towing Package', 1500),
	('Bluetooth', 'Bluetooth Connections', 550),
	('Wireless Charging', 'Phone Package - Wireless Charting', 600),
	('Navigation', 'Touch Screen Navigation', 1400),
	('Touch Screen', 'Touch Screen Package', 1350),
	('Racing Mode', 'Racing Key / Race Package', 2700),
	('Wheels', 'Upgraded Wheel Package - 22"', 2600)
	;
	go


------Insert Date for Invoice Table -- By Brad Metzger
insert into Invoice
	(CustomerID, EmployeeID, VehicleID, Price)
values
	(1012, 1000, 1, 60000),
	(1013, 1001, 2, 70000),
	(1014, 1002, 3, 93000),
	(1015, 1003, 4, 80000),
	(1016, 1004, 5, 61000),
	(1017, 1005, 6, 63000),
	(1018, 1006, 7, 79000),
	(1019, 1007, 8, 59000),
	(1020, 1008, 9, 63000),
	(1021, 1009, 10, 52000);
	go

--Queries
use Dealership
go

--Nicholas Perrin	(where clause, multi-table join)
select inv.InvoiceID
	, CONCAT(RTrim(FirstName),' ',LastName) as [Customer Name]
	, cast(Make.MakeDesc as char(10)) as [Make]
	, cast(Model.ModelDesc as char(10)) as [Model]
	, veh.VehicleYear as [Vehicle Year]
	, '$' + convert(varchar,veh.RetailPrice) as [Retail Price]
	, '$' + convert(varchar,inv.Price) as [Total]
--multi-table join
from People p join Invoice inv
	on p.PeopleID = inv.CustomerID
join Vehicle veh
	on veh.VehicleID = inv.VehicleID
join Make
	on veh.MakeID = Make.MakeID
join Model
	on veh.ModelID = Model.ModelID
--where clause
where veh.VehicleYear > 2019;

--Nicholas Perrin	(subquery)
select InvoiceID as [Invoice ID]
	, LastName
	, veh.VehicleID
	, '$' + convert(varchar,inv.Price) [Total]
from People p join Invoice inv
	on p.PeopleID = inv.EmployeeID
join Vehicle veh
	on veh.VehicleID = inv.VehicleID
--subquery
where CustomerID =
		(select PeopleID
		from People
		where LastName = 'Sonney');

--Nicholas Perrin	(set operator)
--first select stement
select PeopleType as [People Type]
	,Concat(RTrim(FirstName),' ',LastName) as [Name]
	,EmployeeLicense as [ID]
from People p join Employee e
	 on p.PeopleID = e.PeopleID
--set operator
UNION
--second select statement
select PeopleType as [People Type]
	,Concat(RTrim(FirstName),' ',LastName) as [Name]
	,CustomerCard as [ID]
from People p join Customer c
	 on p.PeopleID = c.PeopleID
order by [People Type],Name;


/*Below Queries Created by Brent Soloniewicz - Group 2
3 Queries -
1 & 2 - GroupBy & Having
3 - Outer Join Statement
*/

use Dealership;

/*Using CONVERT to remove the extra spaces for the tables*/
select CONVERT(char(12), MakeDesc) as [Make]
	 , CONVERT(char(12), ModelDesc) as [Model]
	 , '$' + CONVERT(char(12), RetailPrice) as [Retail Price]
	 , '$' + CONVERT(char(16), WholeSalePrice) as [Wholesale Price]
	 , '$' + CONVERT(char(20), RetailPrice - WholesalePrice) as [Profit pre Tax & Fees]
	 , '$' + CONVERT(char(12), ((RetailPrice - WholesalePrice) * .2)) as [Tax & Fees]
	 /*sum us used for the having statement*/
	 , '$' + CONVERT(char(12), sum(((RetailPrice - WholesalePrice)-((RetailPrice - WholesalePrice)*.2)))) as [Total Profit]

	from make ma join vehicle v
	on ma.makeid = v.makeid
	join model mo
	on v.modelid = mo.modelid

group by MakeDesc, ModelDesc, RetailPrice, WholesalePrice
/*This takes the sum of 20% of the profit to calculate taxes & fees
and subtracts it from the profit to calculate total profit per vehicle*/
having sum(((RetailPrice - WholesalePrice)-((RetailPrice - WholesalePrice)*.2))) > 3000;



use Dealership;

select firstname
	 , lastname
	 , employeeid
/*The left join shows everyone in the database
but the employee ID for an employee and NULL for a customer*/
from people p left join invoice i
	on p.peopleid = i.employeeid
order by employeeid
;