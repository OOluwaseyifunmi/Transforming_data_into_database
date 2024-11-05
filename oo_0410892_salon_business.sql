/* 
** Name           : Oluwagbemila oluwaseyifunmi
** Course         : COMP-1701 (245815)
** Date           : 2024-10-14
** File           : salon_business_database_oo_0410892.sql 
** Student_number : 0410892
** History        : 

2024-10-14       
                  -- CREATING AND MANAGING A SALON BUSSINESS TABLE 
                  -- Creating a unique table for a salon business,
                  -- insert records, and perform select operations
                  -- while demonstrating SQL skills. 
*/



-- -------------------------------------------------------------------                                             
-- Creating and dropping a new database for my salon business
-- db means database 
DROP DATABASE IF EXISTS salon_business; -- Drop the db if it exists
CREATE DATABASE         salon_business; -- Create the new db
USE salon_business;                     -- Use the newly created db




-- -------------------------------------------------------------------
-- Creating a table for my salon services
-- that stores the details about my salon services.
CREATE TABLE salon_services (
service_id INT PRIMARY KEY,         -- Defining a primary key (ID) 
                                    -- for the table
service_name VARCHAR(50) NOT NULL,  -- Name of the service 
                                    -- (cannot be NULL)
duration_in_hours INT,              -- Duration of the service in 
                                    -- hours
price DECIMAL,                      -- Price of the service
stylist VARCHAR(50)                 -- Stylist who provides the 
                                    -- service
;  





-- -------------------------------------------------------------------
-- Inserting a  unique records into the  salon_services table
INSERT INTO salon_services (service_id, service_name, 
                      duration_in_hours, price, stylist) 
VALUES 
    (1, 'conrows ', 1, 45, 'Kay'),
    (2, 'weaving', 2, 65, 'shey'),
    (3, 'fulani braids', 6, 125, 'shey'),
    (4, 'fixing', 2, 100, 'judah'),
    (5, 'dreads', 6, 125, 'judah'),
    (6, 'Blow Dry', 1, 40, 'kay'),
    (7, 'braids', 9, 200, 'shey'),
    (8, 'locs', 3, 60, 'kay'),
    (9, 'shuku', 6, 50, 'judah'),
    (10, 'boho braids', 7, 185, 'kay');

-- -------------------------------------------------------------------
-- Selecting statements with WHERE and ORDER BY clauses
-- Selecting all services with a price greater than $50,order by price
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    price > 50 
ORDER BY price
;


-- -------------------------------------------------------------------
-- Selecting all services performed by 'Kay', ordered by service_id
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    stylist = 'Kay' 
ORDER BY service_id
;



-- -------------------------------------------------------------------
--  Selecting services that take longer than 1 hours, ordered by duration
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    duration_in_hours > 1 
ORDER BY duration_in_hours
;




-- -------------------------------------------------------------------
-- Selecting all services that cost between $40 and $150, ordered by service_name
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    price BETWEEN 40 AND 150 
ORDER BY service_name
;



-- -------------------------------------------------------------------
-- Selecting services with 'braids' in the name, ordered by service_name
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    service_name LIKE '%braids%' 
ORDER BY service_name
;



-- -------------------------------------------------------------------
-- Selecting all services that are either 'Blow Dry' or 'weaving', ordered by stylist
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    service_name IN ('Blow Dry', 'weaving') 
ORDER BY stylist
;



-- -------------------------------------------------------------------
-- Selecting services that take less than 5 hours, ordered by price
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    duration_in_hours < 5 
ORDER BY price
;



-- -------------------------------------------------------------------
--  Selecting services provided by 'judah', ordered by duration_hours
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    stylist = 'judah' 
ORDER BY duration_in_hours
;



-- -------------------------------------------------------------------
-- Selecting all services ordered by service_id
SELECT   service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
ORDER BY service_id
;



-- -------------------------------------------------------------------
-- Selecting services with a price greater than $100 and a 
-- duration less than 7 hours
SELECT    service_id, service_name, duration_in_hours, price, stylist
FROM     salon_services 
WHERE    price > 100 AND duration_in_hours < 7 
ORDER BY price
;

-- -------------------------------------------------------------------
-- Modifying the table to add a new column for 'rating'
ALTER TABLE salon_services 
ADD      rating DECIMAL(2, 1);  -- Adding a rating column to the table

-- -------------------------------------------------------------------
--  Updating one record in the salon_services table
UPDATE salon_services 
SET    rating = 4.5 
WHERE  service_id = 1;  -- Updating the rating for 'conrows'

-- -------------------------------------------------------------------
--  Confirming the changes
SELECT service_id, service_name, duration_in_hours
       , price, stylist, rating
FROM   salon_services
;



-- -------------------------------------------------------------------

