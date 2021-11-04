DECLARE @product TABLE (Cust VARCHAR(25), Product VARCHAR(20), QTY INT)

-- Inserting Data into Table
INSERT INTO @product(Cust, Product, QTY) VALUES('KATE','VEG',2)
INSERT INTO @product(Cust, Product, QTY) VALUES('KATE','SODA',6)
INSERT INTO @product(Cust, Product, QTY) VALUES('KATE','MILK',1)
INSERT INTO @product(Cust, Product, QTY) VALUES('KATE','BEER',12)
INSERT INTO @product(Cust, Product, QTY) VALUES('FRED','MILK',3)
INSERT INTO @product(Cust, Product, QTY) VALUES('FRED','BEER',24)
INSERT INTO @product(Cust, Product, QTY) VALUES('KATE','VEG',3)

-- Selecting and checking entires in table
SELECT * FROM @product

-- Pivot Table ordered by PRODUCT
SELECT PRODUCT, FRED, KATE
FROM ( SELECT CUST, PRODUCT, QTY FROM @product) up
PIVOT (SUM(QTY) FOR CUST IN (FRED, KATE)) AS pvt
ORDER BY PRODUCT

-- Pivot Table ordered by CUST
SELECT CUST, VEG, SODA, MILK, BEER, CHIPS
FROM (SELECT CUST, PRODUCT, QTY FROM @product) up
PIVOT (SUM(QTY) FOR PRODUCT IN (VEG, SODA, MILK, BEER, CHIPS)) AS pvt
ORDER BY CUST
