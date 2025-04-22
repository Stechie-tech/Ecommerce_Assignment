CREATE DATABASE E_COMMERCE;
USE E_COMMERCE;

-- Brand table
CREATE TABLE Brand(
brand_id INT PRIMARY KEY AUTO_INCREMENT,
brand_name VARCHAR(100) NOT NULL UNIQUE);

-- product_category table
CREATE TABLE Product_category(
category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(100) NOT NULL UNIQUE,
description TEXT );

-- color table
CREATE TABLE Color(
color_id INT PRIMARY KEY AUTO_INCREMENT,
color_name VARCHAR(30) NOT NULL UNIQUE,
hex_code VARCHAR(20));

-- Size_category table
CREATE TABLE Size_category (
size_category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(40) NOT NULL UNIQUE);

-- Attribute_type Table
CREATE TABLE Attribute_type (
attribute_type_id INT PRIMARY KEY AUTO_INCREMENT,
type_name VARCHAR(40) NOT NULL UNIQUE);

-- Attribute_category Table
CREATE TABLE Attribute_category(
attribute_category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(40) NOT NULL UNIQUE);

-- product Table
CREATE TABLE product (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(40) NOT NULL UNIQUE,
brand_id INT,
category_id INT,
base_price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (brand_id) REFERENCES Brand(brand_id),
FOREIGN KEY (category_id) REFERENCES Product_category(category_id) );

-- product_image Table
CREATE TABLE product_image(
image_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
image_url VARCHAR(255) NOT NULL,
alt_text TEXT,
FOREIGN KEY (product_id) REFERENCES product(product_id)
);
-- product_attribute Table
CREATE TABLE Product_attribute(
attribute_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
attribute_category_id INT,
attribute_type_id INT,
value VARCHAR(100) NOT NULL ,
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (attribute_type_id) REFERENCES Attribute_type(attribute_type_id),
FOREIGN KEY (attribute_category_id) REFERENCES Attribute_category(attribute_category_id) 
);

-- size_option Table
CREATE TABLE Size_optiob(
size_id INT PRIMARY KEY AUTO_INCREMENT,
size_category_id INT,
size_value VARCHAR(100) NOT NULL,
FOREIGN KEY (size_category_id) REFERENCES Size_category(size_category_id));

ALTER TABLE Size_optiob RENAME TO Size_option;

-- product_item Table
CREATE TABLE Product_item(
item_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
size_id INT,
color_id INT,
stock_quantity INT NOT NULL,
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (size_id) REFERENCES Size_option(size_id),
FOREIGN KEY (color_id) REFERENCES Color(color_id) );

-- product_variation Table
CREATE TABLE Product_variation(
variation_id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT,
size_id INT,
color_id INT,
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (size_id) REFERENCES Size_option(size_id),
FOREIGN KEY (color_id) REFERENCES Color(color_id));

-- customer Table
CREATE TABLE Customer (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
phone_number VARCHAR(20),
address TEXT NOT NULL);

-- creating Orders Table
CREATE TABLE Orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
total_price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);
-- Order Item Table
CREATE TABLE Order_Item (
order_item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_item_id INT,
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_item_id) REFERENCES Product_item(item_id)
);

-- Indexing
CREATE INDEX idx_product_name ON Product (product_name);
CREATE INDEX idx_brand_name ON Brand (brand_name);
CREATE INDEX idx_category_name ON Product_category (category_name);
CREATE INDEX idx_color_name ON Color (color_name);


-- audit logging to Track changes
CREATE TABLE Audit_Log (
log_id INT PRIMARY KEY AUTO_INCREMENT,
action VARCHAR(255),
user VARCHAR(100),
timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Triggers for automatic inventrory updates
CREATE TRIGGER reduce_stock AFTER INSERT ON Order_Item
FOR EACH ROW
UPDATE Product_item SET stock_quantity = stock_quantity - NEW.quantity
WHERE item_id = NEW.product_item_id;





