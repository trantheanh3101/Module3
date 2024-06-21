SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

ALTER TABLE customers ADD INDEX idx_customerName(customerName);
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

SELECT * FROM customers WHERE contactFirstName = 'Jean' or contactFirstName = 'King';
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' or contactFirstName = 'King';
ALTER TABLE customers DROP INDEX idx_full_name;

DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`;
CREATE PROCEDURE findAllCustomers()
BEGIN
    SELECT * FROM customers;
END //
DELIMITER ;
call findAllCustomers();


DELIMITER //
CREATE PROCEDURE getCusById(IN cusNum INT(11))
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //
DELIMITER ;
call getCusById(175);

DELIMITER //
CREATE PROCEDURE GetCustomersCountByCity(IN in_city VARCHAR(50),OUT total INT)
BEGIN
    SELECT COUNT(customerNumber) INTO total
    FROM customers
    WHERE city = in_city;
END//
DELIMITER ;

CALL GetCustomersCountByCity('Lyon',@total);
SELECT @total;

CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM  customers;

select * from customer_views;

CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

select  * from customer_views;