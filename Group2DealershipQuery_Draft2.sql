use master;
go
drop database Dealership; --For now, I have this here for testing table statements.
go
create database Dealership;
go
use Dealership;
go


----Create Table Statements: Nick Barney
--drop table zipcode
--create table ZipCode (
--	ZipCodeID int not null, --- Needed to change this to integer as the zipcode was being limited by the smallint to only the 32767 value
--	City char(20) not null,
--	PeopleState char(12) default 'Michigan' not null,
----constraints
--	constraint zipcode_zipcodeid_pk Primary Key (ZipCodeID)
--);
--go


--create table People (
--	PeopleID int identity(1000, 1) not null,
--	PeopleType char(20) default 'Customer' not null,
--	FirstName char(15) not null,
--	LastName char(15) not null,
--	DOB date not null,
--	PeopleAddress varchar(80) not null,
--	SSN int not null, 
--	ZipCodeID int not null,  --- Needed to change this to integer as the zipcode was being limited by the smallint to only the 32767 value
--	Email varchar(50) not null,
--	Phone varchar(10) not null, --- Needed to change this to varchar as the phone number field was limited by the int data type.
--	--constraints
--	constraint people_peopleid_pk primary key (PeopleID),
--	constraint people_zipcodeid_fk foreign key (ZipCodeID) references ZipCode (ZipCodeID)
--		on update cascade
--		on delete no action
--);
--go

----drop table customer;
--create table Customer (
--	PeopleID int not null,
--	CustomerCard char(15) not null,
--	--constraints
--	constraint customer_peopleid_pk primary key (PeopleID),
--	constraint customer_peopleid_fk foreign key (PeopleID) references People (PeopleID)
--		on update cascade
--		on delete no action
--);
--go

--create table Employee (
--	PeopleID int not null,
--	EmployeeLicense char(15) not null,
--	--constraints
--	constraint employee_peopleid_pk primary key (PeopleID),
--	constraint employee_peopleid_fk foreign key (PeopleID) references People (PeopleID)
--		on update cascade
--		on delete no action
--);
--go

--create table Feature (
--	FeatureID smallint identity(1, 1) not null,
--	FeatureName char(25) not null,
--	FeatureDesc varchar(100) not null,
--	Price decimal (5, 2) not null,
--	--constraints
--	constraint feature_featureid_pk primary key (FeatureID)
--);
--go

--create table Inventory (
--	InventoryID int identity(100, 1) not null,
--	InventoryType char(7) not null,
--	QuantityInStock smallint not null,
--	--constraints
--	constraint inventory_inventoryid_pk primary key (InventoryID)
--);
--go

--create table Feature_Inventory (
--	FeatureID smallint not null,
--	InventoryID int not null,
--	--constraints
--	constraint featureinventory_featureinventoryid_pk primary key (FeatureID, InventoryID),
--	constraint featureinventory_featureid_fk foreign key (FeatureID) references Feature (FeatureID)
--		on update cascade
--		on delete no action,
--	constraint featureinventory_inventoryid_fk foreign key (InventoryID) references Inventory (InventoryID)
--		on update cascade
--		on delete no action
--);
--go

--create table Make (
--	MakeID smallint identity(1000, 100) not null,
--	MakeDesc varchar(100)  not null,
--	--constraints
--	constraint make_makeid_pk primary key (MakeID)
--);
--go

--create table Model (
--	ModelID smallint identity(100, 100) not null,
--	ModelDesc varchar(100)  not null,
--	--constraints
--	constraint model_modelid_pk primary key (ModelID)
--);
--go

--create table Color (
--	ColorID tinyint identity(10, 10) not null,
--	ColorDesc char(50) not null,
--	--constraints
--	constraint color_colorid_pk primary key (ColorID)
--);
--go

--create table VehicleType (
--	TypeID tinyint identity(1, 1) not null,
--	VehicleType char(15) not null,
--	--constraints
--	constraint vehicletype_typeid_pk primary key (TypeID)
--);
--go

--create table Vehicle (
--	VehicleID int identity(1,1) not null,
--	MakeID smallint not null,
--	ModelID smallint not null,
--	ColorID tinyint not null,
--	TypeID tinyint not null,
--	InventoryID int not null,
--	VehicleYear smallint not null,
--	WholesalePrice decimal (6, 2) not null,
--	RetailPrice decimal (6, 2) not null,
--	--key constraints
--	constraint vehicle_vehicleid_pk primary key (VehicleID),
--	constraint vehicle_makeid_fk foreign key (MakeID) references Make (MakeID)
--		on update cascade
--		on delete no action,
--	constraint vehicle_modelid_fk foreign key (ModelID) references Model (ModelID)
--		on update cascade
--		on delete no action,
--	constraint vehicle_colorid_fk foreign key (ColorID) references Color (ColorID)
--		on update cascade
--		on delete no action,
--	constraint vehicle_typeid_fk foreign key (TypeID) references VehicleType (TypeID)
--		on update cascade
--		on delete no action,
--	constraint vehicle_inventoryid_fk foreign key (InventoryID) references Inventory (InventoryID)
--		on update cascade
--		on delete no action,
--	--check constraints
--	constraint vehicle_wholesaleprice_ck check (WholesalePrice <= RetailPrice),
--	constraint vehicle_retailprice_ck check (RetailPrice >= WholesalePrice)
--);
--go

--create table Invoice (
--	InvoiceID int identity(1000,1) not null,
--	CustomerID int not null,
--	EmployeeID int not null,
--	VehicleID int not null,
--	Price decimal(6,2) not null,
--	--constraints
--	constraint invoice_invoiceid_pk primary key (InvoiceID),
--	constraint invoice_customerid_fk foreign key (CustomerID) references People (PeopleID) 
--		on update no action
--		on delete no action,
--	constraint invoice_employeeid_fk foreign key (EmployeeID) references People (PeopleID)
--		on update no action
--		on delete no action,
--	constraint invoice_vehicleid_fk foreign key (VehicleID) references Vehicle (VehicleID)
--		on update cascade
--		on delete no action
--);
--go

--create table Feature_Invoice (
--	FeatureID smallint not null,
--	InvoiceID int not null,
--	--constraints
--	constraint featureinvoice_featureinvoiceid_pk primary key (FeatureID, InvoiceID),
--	constraint featureinvoice_featureid_fk foreign key (FeatureID) references Feature (FeatureID)
--		on update cascade
--		on delete no action,
--	constraint featureinvoice_invoiceid_fk foreign key (InvoiceID) references Invoice (InvoiceID)
--		on update cascade
--		on delete no action
--);
--go


----Table Test Queries
--/*select *
--from Feature_Invoice;
--go*/


--Insert Data for Make Table--By Brad Metzger
--insert into Make
--	(MakeDesc)
--values
--	('Audi'),('BMW'),('Cadillac'),('Chevrolet'),('Chrysler'),('Dodge'),('Ford'),('Honda'),('Toyota'),('Nissan');
--go


--Insert Data for Model Table--By Brad Metzger
--insert into Model
--	(ModelDesc)
--values
--	('A3'), ('3 Series'), ('Lyriq'), ('Suburban'), ('300'), ('Ram'), ('F-150'), ('Civic'), ('Camry'), ('Ultima');
--go


--Insert Data for Color Table--By Brad Metzger
--insert into Color
--	(ColorDesc)
--values
--	('White'), ('Red'), ('Black'), ('Gold'), ('Silver'), ('Blue'), ('Green'), ('Champagne'), ('Yellow'), ('Purple');
--go

--Insert Data for VehicleType Table--By Brad Metzger
--insert into VehicleType
--	(VehicleType)
--values
--	('Sedan'), ('Coupe'), ('Sports Car'), ('Station Wagon'), ('Hatchback'), ('Convertible'), ('SUV'), ('Mini Van'), ('Pickup Truck'), ('Commercial');
--	go

--Insert Data for Inventory Table--By Brad Metzger
--insert into Inventory
--	(InventoryID, InventoryType, QuantityInStock)
--values
--	(1234,'A', 1234);


--Insert Data for Vehicle Table--By Brad Metzger
--insert into Vehicle
--	(VehicleID, MakeID, ModelID, ColorID, TypeID, InventoryID, VehicleYear, WholesalePrice, RetailPrice)
--values
--	(12345, 1234, 1234, 123, 123, 1234, 2012, 100.00, 150.00); --change wholesale and retail to test check constraint

----Insert Data for Zipcode Table--By Brad Metzger
--insert into Zipcode
--	(ZipCodeID, City, PeopleState)
--Values
--	(48154,'Livonia','Michigan'),
--	(48152,'Livonia','Michigan'),
--	(48313,'Sterling Heights','Michigan'),
--	(48040,'Madison Heights','Michigan'),
--	(48240,'Redford Twp.','Michigan'),
--	(48219,'Novi','Michigan'),
--	(48984,'Lansing','Michigan'),
--	(90210,'Beverly Hills','California'),
--	(48714,'Beverly Hills','Michigan'),
--	(49474,'Grayling','Michigan');
--go

----Insert Data for People Table -- By Brad Metzger
--insert into People
--	(PeopleType, FirstName, LastName, DOB, PeopleAddress, SSN, ZipCodeID, Email, Phone)
--values
--	('Employee', 'John', 'Smith', '01/15/1987', '12467 White Pine Dr.', '698955564', '48154', 'johnsmith@hotmail.com', '5865551147'),
--	('Employee', 'Jane', 'Lane', '10/17/2000', '35874 Homer Dr.', '254785486', '48240', 'jl@gmail.com', '5865551277'),
--	('Employee', 'John', 'Jack', '9/5/1978', '411 Harper Ave', '987654321', '48984', 'JohnJack@lycos.com', '5865559854'),
--	('Employee', 'Jamie', 'Sanders', '5/15/1988', '6957 Candy Cane Lane', '876543219', '48313', 'candycanelane@northpole.com', '5865555417'),
--	('Employee', 'Sandy', 'Miller', '4/17/1981', '6587 Pabst Ave', '765432198', '90210', 'millertime@molson.com', '5865559632'),
--	('Employee', 'Wyatt', 'Hobbs', '12/25/1992', '7484 Riverland Dr', '654321987', '48040', 'Hobbstoit@carrotsRus.com', '5865556328'),
--	('Employee', 'Johnny', 'Knoxville', '01/20/1988', '12467 Black Pine Dr.', '698955565', '48984', 'johnny@hotmail.com', '5865551146'),
--	('Employee', 'Jay Anne', 'Long', '11/17/1984', '35 Homer Run Dr.', '254785487', '48313', 'jayanne@gmail.com', '5865551276'),
--	('Employee', 'Jack', 'Frost', '6/15/1974', '19 Grand Ave', '987654320', '48714', 'Frostyone@fetch.com', '5865559853'),
--	('Employee', 'Morley', 'Coco', '8/7/1987', '6977 Candy Cane Lane', '876543218', '48219', 'cocoman@northpole.com', '5865555416'),
--	('Employee', 'Morgan', 'Wallace', '3/17/1981', '687 Water Ave', '765432197', '48219', 'wallace@molson.com', '5865559631'),
--	('Employee', 'Chase', 'Kim', '12/18/1965', '6847 Washington Dr', '654321986', '48240', 'chasehim@nascar.com', '5865556327'),
--	('Customer', 'Ronny', 'Mancotti', '2/14/1974', '87 Pasta Road', '543219876', '48219', 'pastaman@pastashop.com', '5865555874'),
--	('Customer', 'Cher', 'Sonney', '04/16/1962', '695 Singer Drive', '432198765', '48714', 'singingallday@songer.com', '5865555412'),
--	('Customer', 'Todd', 'Bertuzzi', '04/04/1944', '44 Sniper Drive', '321987654', '48984', 'hockey4life@puckhead.com', '5865554444'),
--	('Customer', 'Tim', 'Cheveldae', '06/15/1995', '624 Pull Goalie Lane', '219876543', '48219', 'anothergoal@helmethead.com', '5865556573'),
--	('Customer', 'Paul', 'Coffee', '06/09/1962', '7544 Defense Street', '198765432', '48040', 'trophyman@stanley.com', '5865557777'),
--	('Customer', 'Jonny', 'Mancini', '3/15/1976', '75 Rager Road', '543219875', '48219', 'Doughman@pastashop.com', '5865555873'),
--	('Customer', 'Cheryl', 'Sonet', '04/16/1962', '695 Singer Drive', '432198764', '48714', 'Cherry@singer.com', '5865555411'),
--	('Customer', 'Ted', 'Bert', '02/02/1988', '456 Bear Drive', '321987653', '48984', 'tedEBear@buildabear.com', '5865554445'),
--	('Customer', 'Tom', 'Chevy', '10/15/1996', '624 Pull Goalie Lane', '219876542', '48219', 'chevyman@trucker.com', '5865556572'),
--	('Customer', 'Paulina', 'Barq', '05/10/1962', '7544 Defense Street', '198765431', '48040', 'trophygirl@Winner.com', '5865557778')
--	;
--go



------Insert Data for Customer Table -- By Brad Metzger
--insert into Customer
--	(PeopleID, CustomerCard)
--Values
--	('1006', '123456789'),
--	('1007', '234567891'),
--	('1008', '345678912'),
--	('1009', '456789123'),
--	('1010', '567891234'),
--	('1011', '567891231'),
--	('1012', '567891232'),
--	('1013', '567891233'),
--	('1014', '567891234'),
--	('1015', '567891235');
--go


--------Insert Data for Customer Table -- By Brad Metzger
--insert into Employee
--	(PeopleID, EmployeeLicense)
--Values
--	('1000', 'S 123456789'),
--	('1001', 'L 234567891'),
--	('1002', 'J 345678912'),
--	('1003', 'S 456789123'),
--	('1004', 'M 567891234'),
--	('1005', 'H 567891231'),
--	('1006', 'K 567891232'),
--	('1007', 'L 567891233'),
--	('1008', 'F 567891234'),
--	('1009', 'C 567891235'),
--	('1010', 'C 765432197'),
--	('1011', 'W 654321986')
--	;
--go