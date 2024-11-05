/*
** Name          : Oluwagbemila Oluwaseyifunmi
** Course        : COMP-1701 (245815)
** Date          : 2024-09-16
** File          : oo_0410892_boxstore.sql
** Description   : Script to create and manage the Boxstore database with relationships and constraints.
*/

-- -------------------------------------------------------------------
-- Create the Boxstore database
DROP DATABASE IF EXISTS boxstore;
CREATE DATABASE boxstore;
USE boxstore;

-- -------------------------------------------------------------------
-- Creating 'people' table to store client and employee data
BEGIN;

CREATE TABLE people (
    person_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Creating indexes for frequently queried columns
CREATE INDEX idx_people_email ON people (email);
CREATE INDEX idx_people_phone ON people (phone);

COMMIT;

-- -------------------------------------------------------------------
-- Adding Relationships and Other Tables
BEGIN;

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    person_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) CHECK (total_amount >= 0),
    FOREIGN KEY (person_id) REFERENCES people(person_id) ON DELETE CASCADE
);

CREATE INDEX idx_orders_date ON orders (order_date);

COMMIT;

-- Insert sample data and additional tables as needed

-- Additional queries or modifications go here














