CREATE DATABASE E_COMMERCE;
USE E_COMMERCE;
-- Supplier table created
 CREATE TABLE SUPPLIER(
     SUPP_ID INT unsigned PRIMARY KEY auto_increment, 
     SUPP_NAME VARCHAR(50) NOT NULL, 
     SUPP_CITY VARCHAR(50) NOT NULL, 
     SUPP_PHONE VARCHAR(50) NOT NULL
  );
describe supplier;

-- Customer table created
create table customer(
CUS_ID int unsigned primary key auto_increment, 
CUS_NAME varchar(20) NOT NULL, 
CUS_PHONE varchar(10) NOT NULL,
CUS_CITY varchar(30) NOT NULL, 
CUS_GENDER enum('M', 'F')not null);
describe customer;

-- Category table created
create table category(
CAT_ID int unsigned primary key auto_increment,
CAT_NAME varchar(20) not null);
describe category;

-- Product table created
create table product(
PRO_ID int unsigned primary key auto_increment,
PRO_NAME varchar(20) not null, 
PRO_DESC varchar(60) not null,
CAT_ID int unsigned, foreign key(CAT_ID) references category(CAT_ID));
describe product;

-- Supplier_Pricing table created
create table supplier_pricing(
PRICING_ID int unsigned primary key auto_increment,
PRO_ID int unsigned, foreign key(PRO_ID) references product(PRO_ID),
SUPP_ID int unsigned, foreign key(SUPP_ID) references supplier(SUPP_ID),
SUPP_PRICE int default 0);
describe supplier_pricing;

-- Orders table created
create table orders(
ORD_ID int unsigned primary key auto_increment,
ORD_AMOUNT int unsigned not null,
ORD_DATE date not null,
CUS_ID int unsigned, foreign key(CUS_ID) references customer(CUS_ID),
PRICING_ID int unsigned, foreign key(PRICING_ID) references supplier_pricing(PRICING_ID));
describe orders;

-- Ratings table created
create table rating(
RAT_ID int unsigned primary key auto_increment,
ORD_ID int unsigned, foreign key(ORD_ID) references orders(ORD_ID),
RAT_RATSTARS int unsigned not null);
describe rating;

-- Insert the data into Supplier table
insert into SUPPLIER(SUPP_NAME,SUPP_CITY,SUPP_PHONE)
 values('Rajesh Retails','Delhi','1234567890'),
       ('Appario Ltd.','Mumbai','2589631470'),
       ('Knome products','Banglore','9785462315'),
       ('Bansal Retails','Kochi','8975463285'),
       ('Mittal Ltd.','Lucknow','7898456532');
select * from supplier;

-- Insert the data into Customer table 
insert into customer(CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) 
values('AAKASH','9999999999','DELHI','M'),
      ('AMAN','9785463215','NOIDA','M'),
      ('NEHA','9999999999','MUMBAI','F'),
      ('MEGHA','9994562399','KOLKATA','F'),
      ('PULKIT','7895999999','LUCKNOW','M');
select * from customer;

-- Insert the data into Category table
insert into category(CAT_NAME) 
values('BOOKS'),
      ('GAMES'),
      ('GROCERIES'),
      ('ELECTRONICS'),
      ('CLOTHES');
select * from category;

-- Insert the data into Product table
insert into Product(PRO_NAME,PRO_DESC,CAT_ID)
values ("GTA V","Windows 7 and above with i5 processor and 8GB RAM",2),
("TSHIRT","SIZE-L with Black, Blue and White variations",5),
("ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
("OATS","Highly Nutritious from Nestle",3),
("HARRY POTTER","Best Collection of all time by J.K Rowling",1),
("MILK","1L Toned Milk",3),
("Boat Earphones","1.5Meter long Dolby Atmos",4),
("Jeans","Stretchable Denim Jeans with various sizes and color",5),
("Project IGI","compatible with windows 7 and above",2),
("Hoodie","Black GUCCI for 13 yrs and above",5),
("Rich Dad Poor Dad","Written by RObert Kiyosaki",1),
("Train Your Brain","By Shireen Stephen",1);
select * from Product;

-- Insert the data into Supplier_Pricing table
insert into supplier_pricing(PRO_ID,SUPP_ID,SUPP_PRICE)
values (1,2,1500),
       (3,5,30000),
	   (5,1,3000),
       (2,3,2500),
       (4,1,1000);
select * from supplier_pricing;

-- Insert the data into Orders table
insert into orders(ORD_ID,ORD_AMOUNT,ORD_DATE,CUS_ID,PRICING_ID) 
values(101,1500,'2021-10-06',2,1),
      (102,1000,'2021-10-12',3,5),
      (103,30000,'2021-09-16',5,2),
      (104,1500,'2021-10-05',1,1),
      (105,3000,'2021-08-16',4,3),
      (106,1450,'2021-08-18',1,4),
      (107,789,'2021-09-01',3,3),
      (108,780,'2021-09-07',5,2),
      (109,3000,'2021-00-10',5,3),
	  (110,2500,'2021-09-10',2,4),
      (111,1000,'2021-09-15',4,5),
      (112,789,'2021-09-16',4,4),
      (113,31000,'2021-09-16',1,2),
	  (114,1000,'2021-09-16',3,5),
      (115,3000,'2021-09-16',5,3),
      (116,99,'2021-09-17',2,5);
select * from orders;

-- insert the data into rating table
INSERT INTO RATING(RAT_ID,ORD_ID,RAT_RATSTARS) VALUES
		(1,101,4),
		(2,102,3),
		(3,103,1),
		(4,104,2),
		(5,105,4),
		(6,106,3),
		(7,107,4),
		(8,108,4),
		(9,109,3),
		(10,110,5),
		(11,111,3),
		(12,112,4),
		(13,113,2),
		(14,114,1),
		(15,115,1),
		(16,116,0);
select * from rating;

-- Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.
SELECT CUS_GENDER, COUNT(*) AS Total_Customers
FROM customer
INNER JOIN orders ON customer.CUS_ID = orders.CUS_ID
WHERE ORD_AMOUNT >= 3000
GROUP BY CUS_GENDER;

-- Display all the orders along with product name ordered by a customer having Customer_Id=2
SELECT orders.ORD_ID, product.PRO_NAME
FROM orders
INNER JOIN product ON orders.PRICING_ID = product.PRO_ID
WHERE orders.CUS_ID = 2;

-- Display the Supplier details who can supply more than one product.
SELECT supplier.*
FROM supplier
INNER JOIN supplier_pricing ON supplier.SUPP_ID = supplier_pricing.SUPP_ID
GROUP BY supplier.SUPP_ID,supplier.SUPP_NAME
HAVING COUNT(distinct supplier_pricing.PRO_ID) > 1;

-- Find the least expensive product from each category and print the table with category id, name, product name, and price of the product.
SELECT category.CAT_ID, category.CAT_NAME, product.PRO_NAME, supplier_pricing.SUPP_PRICE
FROM category
INNER JOIN product ON category.CAT_ID = product.CAT_ID
INNER JOIN supplier_pricing ON product.PRO_ID = supplier_pricing.PRO_ID
WHERE supplier_pricing.SUPP_PRICE = (
    SELECT MIN(SUPP_PRICE)
    FROM supplier_pricing
    WHERE supplier_pricing.PRO_ID = product.PRO_ID
)
GROUP BY category.CAT_ID,category.CAT_NAME;

-- Display the Id and Name of the Product ordered after "2021-10-05".
SELECT product.PRO_ID, product.PRO_NAME
FROM orders
INNER JOIN product ON orders.PRICING_ID = product.PRO_ID
WHERE orders.ORD_DATE > '2021-10-05';

-- Display customer name and gender whose names start or end with the character 'A'.
SELECT CUS_NAME, CUS_GENDER
FROM customer
WHERE CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

-- Create a stored procedure to display supplier id, name, rating, and Type_of_Service.
DELIMITER //
create PROCEDURE GetSupplierServiceType()
BEGIN
    SELECT SUPP_ID, SUPP_NAME, RAT_RATSTARS,
        CASE
            WHEN RAT_RATSTARS = 5 THEN 'Excellent Service'
            WHEN RAT_RATSTARS > 4 THEN 'Good Service'
            WHEN RAT_RATSTARS > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service
    FROM supplier
    INNER JOIN rating ON supplier.SUPP_ID = rating.SUPP_ID;
END//
DELIMITER ;
 


