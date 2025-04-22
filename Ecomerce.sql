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

