drop database krikey_db;
Create database krikey_db;
use krikey_db;

CREATE TABLE authors (
id int PRIMARY KEY,
name text,
date_of_birth varchar(30)
);


CREATE TABLE books (
id int PRIMARY KEY,
author_id integer REFERENCES authors (id), isbn text
);



CREATE TABLE sale_items (
id int PRIMARY KEY,
book_id int REFERENCES books (id), customer_name text, item_price int,
quantity int
);

INSERT INTO AUTHORS VALUES (1,'Yash Kapadia', '11/22/1995');
INSERT INTO AUTHORS VALUES (2,'Kappa', '11/22/1995');
INSERT INTO AUTHORS VALUES (3,'Kappu', '11/22/1995');
INSERT INTO books VALUES (1,1,'book1');
INSERT INTO books VALUES (2,1,'book2');
INSERT INTO books VALUES (3,2,'book3');
INSERT INTO books VALUES (4,3, 'book4');
INSERT INTO books VALUES (5,3, 'book5');
INSERT INTO books VALUES (6,3,'book6');
INSERT INTO sale_items Values(1,4,'abc',100,1);
INSERT INTO sale_items Values(2,6,'xyz',200,1);
INSERT INTO sale_items Values(3,6,'abc',200,2);
INSERT INTO sale_items Values(4,1,'pqr',150,1);
INSERT INTO sale_items Values(5,3,'abc',600,1);

#Query 1
select authors.name from authors order by authors.date_of_birth;

#Query 2
select q.name, sum(q.Sales_revenue) as 'Sales Revenue' 
from (
	select authors.name, sale_items.book_id,sum(sale_items.item_price * sale_items.quantity) as 'Sales_Revenue' 
	from sale_items 
	join books on books.id = sale_items.book_id 
	join authors on authors.id = books.author_id 
	group by sale_items.book_id ) q 
group by q.name having q.name = "Lorelai Gilmore";


#Query 3
select q.name, sum(q.Sales_revenue) as 'Sales Revenue' from (
	select authors.name, sale_items.book_id,sum(sale_items.item_price * sale_items.quantity) as 'Sales_Revenue' 
	from sale_items 
	join books on books.id = sale_items.book_id 
	join authors on authors.id = books.author_id 
	group by sale_items.book_id ) q 
group by q.name order by 'Sales Revenue' desc limit 10;
