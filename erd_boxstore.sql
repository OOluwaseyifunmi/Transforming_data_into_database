/* 
** Name: Oluwagbemila oluwaseyifunmi 
** Crse: Comp 1701 245815
** Date: 2024-09-16
** File: oo_0410892_boxstore.sql
** Hist:

2024-09-16	Created Boxstore database
			-- MySQL Database Setup
            -- created oo_0410892_boxstore		 

-- -------------------------------------------------------------------
2024-10-04  Created the people Table 
            -- Dropped and created the (people) table  
            -- INSERTed the instructor and student name records
            -- Loaded 10000 people from CSV file into people table  
            -- Verified loads completed

-- ------------------------------------------------------------------
2024-11-01  Created  (geo_address_type ,geo_towncity,geo_region
            ,geo_country tables)
            -- Drooped and creayed all tables (ga,gt,gr,gc)
            -- Updated records for instructor and employee
            -- Updated the alter statement 
            -- Created JIONs statement            
            -- Created what appears on the front of an envelope 

**
*/
-- -------------------------------------------------------------------
-- DROP/CREATE/USE boxstore DATABASE block 
USE sys;

DROP DATABASE IF EXISTS oo_0410892_boxstore; 
CREATE DATABASE IF NOT EXISTS oo_0410892_boxstore
CHARSET='utf8mb4' 
COLLATE='utf8mb4_unicode_ci';

USE oo_0410892_boxstore;



-- -------------------------------------------------------------------
-- geo_address_type t: DROP/CREATE & TRUNCATE/INSERT/SELECT TABLE 

DROP TABLE IF EXISTS geo_address_type;

CREATE TABLE IF NOT EXISTS geo_address_type (
    addr_type_id TINYINT      AUTO_INCREMENT
  , addr_type    VARCHAR(15)  NOT NULL
  , active       BIT          NOT NULL   DEFAULT 1
  , CONSTRAINT ga_PK PRIMARY KEY(addr_type_id)
  , CONSTRAINT ga_UK UNIQUE     (addr_type ASC)
);

TRUNCATE TABLE geo_address_type;

INSERT INTO geo_address_type (addr_type)
VALUES                       ('Apartment')
                            ,('Building')
                            ,('Condominium')
                            ,('Head Office')
                            ,('House')                            
                            ,('Mansion')
                            ,('Other')
                            ,('Townhouse')
                            ,('Warehouse');
                           
-- retieve all address type  records                          
SELECT ga.addr_type_id, ga.addr_type, ga.active
FROM   geo_address_type ga;




-- -------------------------------------------------------------------
-- geo_country t: DROP/CREATE & TRUNCATE/INSERT/SELECT TABLE

DROP TABLE IF EXISTS geo_country;
CREATE TABLE IF NOT EXISTS geo_country (
    co_id   TINYINT     AUTO_INCREMENT
  , co_name VARCHAR(60) NOT NULL
  , co_code CHAR(2)     NOT NULL
  , active  BIT         NOT NULL DEFAULT 1
  , CONSTRAINT gc_PK PRIMARY KEY(co_id)
  , CONSTRAINT gc_UK_name UNIQUE (co_name ASC)
  , CONSTRAINT gc_UK_code UNIQUE (co_code ASC)
);

TRUNCATE TABLE geo_country;

INSERT INTO geo_country (co_name, co_code)
VALUES            ('Canada','CA')
                , ('Japan','JP')
                , ('South Korea','KR')
                , ('United States of America','US');

-- retieve all geo country  records that are active
SELECT gc.co_id, gc.co_name, gc.co_code
     , gc.active
FROM   geo_country gc;




-- -------------------------------------------------------------------
-- geo_region t:DROP/CREATE & TRUNCATE/INSERT/SELECT TABLE 
DROP TABLE IF EXISTS geo_region;
CREATE TABLE IF NOT EXISTS geo_region (
    rg_id     SMALLINT    AUTO_INCREMENT
  , rg_name   VARCHAR(50) NOT NULL
  , rg_code   CHAR(2) 
  , co_id     TINYINT     NOT NULL
  , active    BIT         NOT NULL  DEFAULT 1
  , CONSTRAINT gr_PK PRIMARY KEY(rg_id)
  , CONSTRAINT gr_UK 
        UNIQUE (co_id ASC, rg_name ASC)
);

TRUNCATE TABLE geo_region;

INSERT INTO geo_region (rg_name, rg_code, co_id)
VALUES                 ('Manitoba', 'MB', 1)
                     , ('Osaka', '', 2)
                     , ('Tokyo', '', 2)
                     , ('Gyeonggi', '', 3)
                     , ('California', '', 4)
                     , ('Texas', '', 4)
                     , ('Washington', '', 4);
                    
                    
-- retieve all  geo_region records                   
SELECT gr.rg_id, gr.rg_name, gr.rg_code, gr.co_id
     , gr.active
FROM   geo_region gr;




-- -------------------------------------------------------------------
-- JOIN geo_region to geo_country 
-- where FK=PK
SELECT gr.rg_id, gr.rg_name, gr.rg_code, gr.co_id, gr.active
     , gc.co_id, gc.co_name, gc.co_code, gc.active
FROM geo_region gr
JOIN geo_country gc ON gr.co_id = gc.co_id;


-- -------------------------------------------------------------------
-- geo_towncity t:DROP/CREATE & TRUNCATE/INSERT/SELECT TABLE block
DROP TABLE IF EXISTS geo_towncity;
CREATE TABLE IF NOT EXISTS geo_towncity (
    tc_id    MEDIUMINT    AUTO_INCREMENT
  , tc_name  VARCHAR(15)  NOT NULL
  , rg_id    SMALLINT     NOT NULL
  , active   BIT          NOT NULL DEFAULT 1
  , CONSTRAINT gt_PK PRIMARY KEY(tc_id)
  , CONSTRAINT gt_UK 
        UNIQUE (rg_id ASC, tc_name ASC)
);

TRUNCATE TABLE geo_towncity;

INSERT INTO geo_towncity (tc_name, rg_id)
VALUES                   ('Winnipeg', 1)
                       , ('Chiyoda', 2)
                       , ('Minato', 2)
                       , ('Kadoma', 3)
                       , ('Suwon', 4)
                       , ('Seoul', 4)
                       , ('Los Altos', 5)
                       , ('Santa Clara', 5)
                       , ('Round Rock', 6)
                       , ('Redmond', 7);
                      
-- retrieve all records from the towncity table                       
SELECT gt.tc_id, gt.tc_name, gt.rg_id
     , gt.active
FROM   geo_towncity gt;




-- -------------------------------------------------------------------
-- JOIN geo_towncity to geo_region and geo_country table
SELECT gt.tc_id, gt.tc_name, gt.rg_id,
       gr.rg_id, gr.rg_name, gr.rg_code, gr.co_id,
       gc.co_id, gc.co_name, gc.co_code
FROM geo_towncity gt
JOIN geo_region gr ON gt.rg_id = gr.rg_id
JOIN geo_country gc ON gr.co_id = gc.co_id;




-- -------------------------------------------------------------------
-- people t: DROP/CREATE-TRUNCATE/INSERT/SELECT people TABLE Block
DROP TABLE IF EXISTS people;
CREATE TABLE IF NOT EXISTS people (
	   p_id       MEDIUMINT        UNSIGNED AUTO_INCREMENT
	 , full_name  VARCHAR(100)     NULL
	 , CONSTRAINT people_PK        PRIMARY KEY (p_id)
      -- , CONSTRAINT people___PK_name  UNIQUE (full_name)
);

TRUNCATE TABLE people;

INSERT INTO people (full_name) VALUES ('Brad Vincelette') 
                                    , ('Oluwagbemila Oluwaseyifunmi')
;

-- retrive all people records 
SELECT p_id, full_name
FROM people;


-- loading the 10000 records
LOAD DATA -- LOCAL 
INFILE 'C:\\_data\\MariaDB_11.5\\oo_0410892_boxstore_people_10000.csv'
INTO TABLE people
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
(full_name);

-- final working SQL
SELECT p_id, full_name 
FROM   people
WHERE  1=1;

-- ALTER adding first and last name fields
ALTER TABLE   people 
    ADD COLUMN  first_name VARCHAR(40) NULL
  ,	ADD COLUMN  last_name  VARCHAR(40) NULL
;
	
	
-- value updates for p_id 1 and 2 
-- p_id 1
UPDATE people 
SET    first_name = 'brad'
     , last_name  = 'vincelette'
WHERE p_id=1;

-- p_id 2
UPDATE people 
SET    first_name = 'oluwaseyifunmi'
     , last_name  = 'oluwagbemila '
WHERE p_id=2;

-- select all people records tat are less than 3 i.e p_id 1 and p_id 2
SELECT p_id, full_name, first_name, last_name 
FROM people
WHERE p_id<3;


-- select all people records 
SELECT p_id, full_name, first_name, last_name 
FROM   people 
WHERE  1=1;


-- Alter table to drop full_name and add new fields 
ALTER TABLE people 
    DROP COLUMN IF EXISTS full_name
  , MODIFY COLUMN first_name VARCHAR(35) 
  -- , MODIFY COLUMN last_name  VARCHAR(35)
  , ADD COLUMN email_addr    VARCHAR(50)
  , ADD COLUMN password      CHAR(32)
  , ADD COLUMN phone_pri     VARCHAR(15)
  , ADD COLUMN phone_sec     CHAR(11) 
  , ADD COLUMN phone_fax     CHAR(11) 
  , ADD COLUMN addr_suite    VARCHAR(20) 
  , ADD COLUMN addr          VARCHAR(60) 
  , ADD COLUMN addr_code     CHAR(7) 
  , ADD COLUMN addr_info     VARCHAR(100) 
  , ADD COLUMN addr_delivery TEXT 
  , ADD COLUMN addr_type_id  TINYINT      -- FK geo_address_type
  , ADD COLUMN tc_id         MEDIUMINT    -- FK geo_towncity
  , ADD COLUMN employee      BIT                NOT NULL DEFAULT 0
  , ADD COLUMN usermod       MEDIUMINT UNSIGNED NOT NULL DEFAULT 2
  , ADD COLUMN datemod       DATETIME           NOT NULL DEFAULT CURRENT_TIMESTAMP
  , ADD COLUMN useract       MEDIUMINT UNSIGNED NOT NULL DEFAULT 1
  , ADD COLUMN dateact       DATETIME           NOT NULL DEFAULT CURRENT_TIMESTAMP
  , ADD COLUMN active        BIT                NOT NULL DEFAULT 1
;




-- select all columns 
SELECT p.p_id, p.first_name, p.last_name
FROM   people p;



-- UPDATES for the instructor
UPDATE people 
SET 
    email_addr = CONCAT(first_name, '.', last_name, '@boxstore.com')
  , password   = md5('Aghvgueggfh123#')
  , phone_pri  = CONCAT(12045678901)
  , addr_suite = NULL
  , addr       = '319 Elgin avenue'
  , addr_code  = 'R2G 168'
  , addr_info  = 'PO Box 123456'
  , addr_delivery = 'Knock outside the door '
  , addr_type_id  = (SELECT addr_type_id 
                     FROM geo_address_type 
                     WHERE addr_type = 'Mansion')
  , tc_id  =  2
  , usermod = 2
  , datemod = NOW()
WHERE p_id=1;

-- UPDATES for  the employee records (Oluwaseyifunmi)
UPDATE people 
SET 
    email_addr = CONCAT(first_name, '.', last_name,'@boxstore.com')
  , password   = md5('Gbemilajvbfjkndb2345@')
  , phone_pri  = CONCAT(1204, 7654368)
  , addr_suite = 612
  , addr       = '640 Ballantrea drive '
  , addr_code  = 'R3T 6J3'
  , addr_info  = NULL
  , addr_delivery = 'Check with concierge on main level'
  , addr_type_id  = (SELECT addr_type_id 
                     FROM geo_address_type 
                     WHERE addr_type = 'Apartment')
  , tc_id  =  1
  , usermod = 2
  , datemod = NOW()
WHERE p_id=2;


-- An update statemnet that changes the primary phone_pri in 
-- the "people" table.
-- To this  new format of +1(204)###-####
UPDATE people 
SET phone_pri = CONCAT(
                   '+', SUBSTRING(phone_pri, 1, 1),
                   '(', SUBSTRING(phone_pri, 2, 3), ')',
                   SUBSTRING(phone_pri, 5, 3), '-',
                   RIGHT(phone_pri, 4)
               )
WHERE p_id < 3;


-- last select statement for the people table 

SELECT p.p_id, p.first_name, p.last_name, p.email_addr, p.password
     , p.phone_pri, p.phone_sec, p.phone_fax
     , p.addr_suite, p.addr, p.addr_code, p.addr_info
     , p.addr_delivery, p.addr_type_id, p.tc_id
FROM people p;

-- -------------------------------------------------------------------
-- JOIN people p to geo_address_type ga 
-- & to JOIN geo_towncity gt thru geo_country gc  

SELECT p.p_id, p.first_name, p.last_name, p.email_addr, p.password
     , p.phone_pri, p.phone_sec, p.phone_fax
     , p.addr_suite, p.addr, p.addr_code, p.addr_info
     , p.addr_delivery, p.addr_type_id, p.tc_id
     , gt.tc_id, gt.tc_name, gt.rg_id
     , gr.rg_id, gr.rg_name, gr.rg_code, gr.co_id
     , gc.co_id, gc.co_name, gc.co_code 
FROM   people p
JOIN geo_address_type ga ON p.addr_type_id = ga.addr_type_id
JOIN geo_towncity gt ON p.tc_id = gt.tc_id
JOIN geo_region gr ON gr.rg_id = gt.rg_id
JOIN geo_country gc ON gr.co_id = gc.co_id;
  




-- -------------------------------------------------------------------
-- ENVELOPE query 
SELECT p.p_id, p.first_name, p.last_name
     , p.addr_suite, p.addr, p.addr_code, p.addr_info, p.addr_delivery
     , p.addr_type_id, p.tc_id
     , ga.addr_type_id
     , gt.tc_name
     , gr.rg_name
     , gc.co_name    
FROM people p
JOIN geo_address_type ga ON p.addr_type_id = ga.addr_type_id
JOIN geo_towncity  gt ON p.tc_id = gt.tc_id
JOIN geo_region gr ON gr.rg_id = gt.rg_id
JOIN geo_country  gc ON gr.co_id = gc.co_id
