create database if not exists retailnf;
use retailnf;

create table badorders(
order_id int primary key,
order_date date,
customer_id int,
customer_name varchar(50),
customer_city varchar(50),
-- repeating groups comma seperated
product_ids varchar(200),
product_name varchar(200),
unit_prices varchar(200),
quantities varchar(200),
order_total decimal(10,2) -- derivable sum
);


INSERT INTO BadOrders VALUES
-- order_id, date, cust, name, city,     pids,      pnames,                   prices,        qtys,    total
(101, '2025-09-01', 1, 'Rahul', 'Mumbai', '1,3',    'Laptop,Headphones',      '60000,2000',  '1,2',   64000.00),
(102, '2025-09-02', 2, 'Priya', 'Delhi',  '2',      'Smartphone',             '30000',       '1',     30000.00);


create table orders_1nf(
order_id int primary key,
order_date date,
customer_id int,
customer_city varchar(50),
customer_name varchar(50)
);

create table orderitems_1nf(
order_id int,
line_no int,
product_id int,
product_name varchar(50),
unit_price decimal(10,2),
quantity int,
primary key(order_id, line_no),
foreign key(order_id) references orders_1nf(order_id)
);

-- Load split rows bad orders
insert into orders_1nf
select order_id,order_date,customer_id,customer_name,customer_city
from badorders;

-- order 101 have 2 items-- 2 rows
insert into orderitems_1nf values
(101,1,1,'laptop',60000,1),
(101,2,2,'headphones',2000,2);

-- order 102 have 1 item -- 1 row
insert into orderitems_1nf values
(102,1,2,'smartphone',30000,1);

create table customer_2nf(
customer_id int primary key,
customer_name varchar(50),
customer_city varchar(50));

create table orders_2nf(
order_id int primary key,
order_date date,
customer_id int,
foreign key(customer_id) references customer_2nf(customer_id));

create table products_2nf(
product_id int primary key,
product_name varchar(50),
category varchar(50),
list_price decimal(10,2));


CREATE TABLE orderItems_2NF (
  order_id INT,
  line_no INT,
  product_id INT,
  unit_price_at_sale DECIMAL(10,2),  -- historical price
  quantity INT,
  PRIMARY KEY (order_id, line_no),
  FOREIGN KEY (order_id) REFERENCES orders_2NF(order_id),
  FOREIGN KEY (product_id) REFERENCES Products_2NF(product_id)
);
 

INSERT INTO Customer_2NF VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Priya', 'Delhi');
 
INSERT INTO Products_2NF VALUES
(1, 'Laptop',     'Electronics', 60000),
(2, 'Smartphone', 'Electronics', 30000),
(3, 'Headphones', 'Accessories',  2000);
 
INSERT INTO Orders_2NF VALUES
(101, '2025-09-01', 1),
(102, '2025-09-02', 2);
 
INSERT INTO OrderItems_2NF VALUES
(101, 1, 1, 60000, 1),
(101, 2, 3,  2000, 2),
(102, 1, 2, 30000, 1);


create table Cities(
	city_id int primary key,
    city_name varchar(50),
    state varchar(50)
);
 
create table Customers_3NF(
	customer_id int primary key,
    customer_name varchar(50),
    city_id int,
    foreign key (city_id) references Cities(city_id)
);

create Table Products_3NF like Products_2NF;
insert into Products_3NF Select * from Products_2NF;
create table Orders_3NF like Orders_2NF;

create table OrderItems_3NF like ORderItems_2NF;
insert into Cities Values
(10,"Mumbai","Maharashtra"),
(20,"Delhi","Delhi");
insert into Customers_3NF values
(1,"Rahul",10),
(2,"Priya",20);
insert into Orders_3NF select * from Orders_2NF;
insert into OrderItems_3NF select * from OrderItems_2NF;
 