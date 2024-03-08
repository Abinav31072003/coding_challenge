Create database ecommerce 

-- Customers table
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255),
    password VARCHAR(255)
);

-- Products table
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    description TEXT,
    stockQuantity INT
);

-- Cart table
CREATE TABLE cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Orders table
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    shipping_address VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Order_items table
CREATE TABLE order_items (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Inserting elements in customer table
INSERT INTO customers (name, email, password)
VALUES
('John Doe', 'johndoe@example.com', '123 Main St, City'),
('Jane Smith', 'janesmith@example.com', '456 Elm St, Town'),
('Robert Johnson', 'robert@example.com', '789 Oak St, Village'),
('Sarah Brown', 'sarah@example.com', '101 Pine St, Suburb'),
('David Lee', 'david@example.com', '234 Cedar St, District'),
('Laura Hall', 'laura@example.com', '567 Birch St, County'),
('Michael Davis', 'michael@example.com', '890 Maple St, State'),
('Emma Wilson', 'emma@example.com', '321 Redwood St, Country'),
('William Taylor', 'william@example.com', '432 Spruce St, Province'),
('Olivia Adams', 'olivia@example.com', '765 Fir St, Territory');
Select * from customers
exec sp_rename 'customers.password', 'address', 'column'

--Inserting elements in product table
INSERT INTO products (name, description, price, stockQuantity)
VALUES
('Laptop', 'High-performance laptop', 800.00, 10),
('Smartphone', 'Latest smartphone', 600.00, 15),
('Tablet', 'Portable tablet', 300.00, 20),
('Headphones', 'Noise-canceling', 150.00, 30),
('TV', '4K Smart TV', 900.00, 5),
('Coffee Maker', 'Automatic coffee maker', 50.00, 25),
('Refrigerator', 'Energy-efficient', 700.00, 10),
('Microwave Oven', 'Countertop microwave', 80.00, 15),
('Blender', 'High-speed blender', 70.00, 20),
('Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);
Select * from products

Alter table products add category varchar(30)
UPDATE products SET category = 'Electronics' WHERE product_id = 1;
UPDATE products SET category = 'Electronics' WHERE product_id = 2;
UPDATE products SET category = 'Electronics' WHERE product_id = 3;
UPDATE products SET category = 'Appliances' WHERE product_id = 4;
UPDATE products SET category = 'Appliances' WHERE product_id = 5;
UPDATE products SET category = 'Appliances' WHERE product_id = 6;
UPDATE products SET category = 'Appliances' WHERE product_id = 7;
UPDATE products SET category = 'Appliances' WHERE product_id = 8;
UPDATE products SET category = 'Appliances' WHERE product_id = 9;
UPDATE products SET category = 'Appliances' WHERE product_id = 10;

--Inserting elemnets into orders table
INSERT INTO orders (customer_id, order_date, total_price)
VALUES
(1, '2023-01-05', 1200.00),
(2, '2023-02-10', 900.00),
(3, '2023-03-15', 300.00),
(4, '2023-04-20', 150.00),
(5, '2023-05-25', 1800.00),
(6, '2023-06-30', 400.00),
(7, '2023-07-05', 700.00),
(8, '2023-08-10', 160.00),
(9, '2023-09-15', 140.00),
(10, '2023-10-20', 1400.00);
Select * from orders

--Inserting elements into order items table
Alter table order_items add itemAmount Decimal (10,2)
INSERT INTO order_items (order_id, product_id, quantity, itemAmount)
VALUES
(1, 1, 2, 1600.00),
(1, 3, 1, 300.00),
(2, 2, 3, 1800.00),
(3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00);
Select * from order_items

--Inserting items in cart table
INSERT INTO cart (customer_id, product_id, quantity)
VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2);
Select * from cart

--1. Update refrigerator product price to 800.
Update products SET price = 800 where name = 'Refrigerator'

--2. Remove all cart items for a specific customer.
Select * from cart
Delete from cart where customer_id = 5

--3. Retrieve Products Priced Below $100.
Select * from products where price < 100

--4. Find Products with Stock Quantity Greater Than 5.
Select * from products where stockQuantity > 5

--5. Retrieve Orders with Total Amount Between $500 and $1000.
Select * from orders where total_price between 500 and 1000

--6. Find Products which name end with letter ‘r’.
Select * from products where name like '%r'

--7. Retrieve Cart Items for Customer 5.
Insert into cart values(5, 1, 1)
Select * from cart where customer_id = 5

--8. Find Customers Who Placed Orders in 2023.
Select c.name, o.order_date from customers c join orders o on c.customer_id = o.customer_id where year(o.order_date) = 2023

--9. Determine the Minimum Stock Quantity for Each Product Category.
Select * from products  
Select category, min(stockQuantity) as Minimum_Stock from products group by category

--10. Calculate the Total Amount Spent by Each Customer.Select c.name, o.total_price from customers c join orders o on c.customer_id = o.customer_id--11.  Find the Average Order Amount for Each CustomerSelect c.name, Avg(o.total_price) as Average_price from customers c join orders o on c.customer_id = o.customer_id group by c.name--12. Count the Number of Orders Placed by Each Customer.Select c.name, count(oi.order_item_id) from customers c join orders o  on c.customer_id = o.customer_id left join order_items oi on o.order_id = oi.order_id group by c.name--13. Find the Maximum Order Amount for Each Customer.Select c.name, max(o.total_price) from customers c join orders o on c.customer_id = o.customer_id group by c.name--14. Get Customers Who Placed Orders Totaling Over $1000. Select c.name, o.total_price from customers c join orders o on c.customer_id = o.customer_id where o.total_price > 1000 --15. Subquery to Find Products Not in the Cart. Select * from products where product_id not in (Select product_id from cart) --16. Subquery to Find Customers Who Haven't Placed Orders Insert into customers values ('Giridharan','giri@example.com','123 Laporte St') Select * from customers where customer_id not in (Select distinct customer_id from orders)--17. Subquery to Calculate the Percentage of Total Revenue for a Product. Select oi.product_id, (SUM(oi.quantity * p.price) / (SELECT SUM(total_price) FROM orders)) * 100 AS revenue_percentage
from order_items oi join products p ON oi.product_id = p.product_id
Group by oi.product_id;

--18. Subquery to Find Products with Low Stock.
--i)
Select * from products where stockQuantity < (Select AVG(stockQuantity) from products)
--ii)
Select * from products where stockQuantity = (Select MIN(stockQuantity) from products)

--19. . Subquery to Find Customers Who Placed High-Value Orders.
--i)
Select * from customers where customer_id in (Select customer_id from orders Group by customer_id having(Sum(total_price)) > (Select AVG(total_price) from orders))
--ii)
Select *from customers where customer_id in (Select customer_id from orders where total_price = (select max(total_price) as Maximum_value from orders))