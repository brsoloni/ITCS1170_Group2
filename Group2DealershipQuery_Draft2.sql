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
	ZipCodeID smallint not null,
	City char(20) not null,
	PeopleState char(12) default 'Michigan' not null,
	--constraints
	constraint zipcode_zipcodeid_pfk Primary Key (ZipCodeID)
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
	ZipCodeID smallint not null,
	Email varchar(50) not null,
	Phone int not null,
	--constraints
	constraint people_peopleid_pk primary key (PeopleID),
	constraint people_zipcodeid_fk foreign key (ZipCodeID) references ZipCode (ZipCodeID)
		on update cascade
		on delete no action
);
go

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
	Price decimal (5, 2) not null,
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
	MakeID smallint identity(1, 1) not null,
	MakeDesc varchar(100)  not null,
	--constraints
	constraint make_makeid_pk primary key (MakeID)
);
go

create table Model (
	ModelID smallint identity(1, 1) not null,
	ModelDesc varchar(100)  not null,
	--constraints
	constraint model_modelid_pk primary key (ModelID)
);
go

create table Color (
	ColorID tinyint identity(1, 1) not null,
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
	VehicleID int identity(1000,1) not null,
	MakeID smallint not null,
	ModelID smallint not null,
	ColorID tinyint not null,
	TypeID tinyint not null,
	InventoryID int not null,
	VehicleYear smallint not null,
	WholesalePrice decimal (6, 2) not null,
	RetailPrice decimal (6, 2) not null,
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
	Price decimal(6,2) not null,
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


--Table Test Queries
/*select *
from Feature_Invoice;
go*/

--Example Vehicle Table Insert with Test Select NOTE: Omit ID inserts to work with our identity increments
/*insert into Make
	(MakeID, MakeDesc)
values
	(1234,'A');

insert into Model
	(ModelID, ModelDesc)
values
	(1234,'A');

insert into Color
	(ColorID, ColorDesc)
values
	(123,'A');

insert into VehicleType
	(TypeID, VehicleType)
values
	(123,'A');

insert into Inventory
	(InventoryID, InventoryType, QuantityInStock)
values
	(1234,'A', 1234);

insert into Vehicle
	(VehicleID, MakeID, ModelID, ColorID, TypeID, InventoryID, VehicleYear, WholesalePrice, RetailPrice)
values
	(12345, 1234, 1234, 123, 123, 1234, 2012, 100.00, 150.00); --change wholesale and retail to test check constraint

select *
from Vehicle;
*/
