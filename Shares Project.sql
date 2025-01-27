CREATE TABLE share (
shrcode CHAR(3),
shrfirm VARCHAR(20)NOT NULL,
shrprice DECIMAL(6,2),
shrqty DECIMAL(8),
shrdiv DECIMAL(5,2),
shrpe DECIMAL(2),
PRIMARY KEY(shrcode)); 

Select * 
from share
; 

INSERT INTO share
VALUES ('FC','Freedonia Copper',27.5,10529,1.84,16);

Select * 
from share; 

INSERT INTO share
VALUES ('PT','Patagonian Tea',55.25,12635,2.50,10);

INSERT INTO share
VALUES ('AR','Abyssinian Ruby',31.82,22010,1.32,13);

INSERT INTO share
VALUES ('SLG','Sri Lankan Gold',50.37,32868,2.68,16);

INSERT INTO share
VALUES ('ILZ','Indian Lead & Zinc',37.75,6390,3.00,12);

INSERT INTO share
VALUES ('BE','Burmese Elephant',0.07,154713,0.01,3);

INSERT INTO share
VALUES ('BS','Bolivian Sheep',12.75,231678,1.78,11);

INSERT INTO share
VALUES ('NG','Nigerian Geese',35.00,12323,1.68,10);

INSERT INTO share
VALUES ('CS','Canadian Sugar',52.78,4716,2.50,15);

INSERT INTO share
VALUES ('ROF','Royal Ostrich Farms',33.75,1234923,3.00,6);

Select * 
from share; 

Select shrfirm, shrpe
from share;

select * 
from share 
where shrpe < 12; 

select shrfirm, shrprice, shrqty, shrdiv
from share
where shrqty >= 100000; 


Select * 
from share 
where shrcode = 'AR';

Select * 
from share 
where shrdiv = 2.5;

Select * 
from share
where shrcode in ('FC', 'AR', 'SLG'); 

Select * 
from share
where shrcode not in ('CS', 'PT'); 

Select *
from share
where shrpe >= 12
order by shrpe desc, shrfirm; 

SELECT shrfirm, 
shrprice, 
shrqty,
round(shrdiv/shrprice*100,2) AS yield 
FROM share;

SELECT AVG(shrdiv) AS avgdiv 
FROM share;

SELECT AVG(shrdiv/shrprice*100) AS
avgyield 
FROM share;


SELECT shrfirm, shrpe FROM share WHERE
shrpe >(SELECT
AVG(shrpe)FROM share);

SELECT shrfirm
FROM share
WHERE shrfirm REGEXP 'Ruby';

SELECT * 
FROM share
WHERE shrfirm REGEXP 'gold|zinc|Gold|Zinc';

SELECT * 
FROM share
WHERE shrfirm REGEXP '^Sri';

SELECT shrfirm
FROM share
WHERE shrfirm REGEXP 'Geese$';

SELECT COUNT(DISTINCT shrpe)AS 'Different PEs'
FROM share;

SELECT DISTINCT shrpe FROM share;

DELETE FROM share
WHERE shrfirm = 'Burmese Elephant';

select * from share;

UPDATE share
SET shrprice = 31.50
WHERE shrcode = 'FC';

select * from share;


UPDATE share
SET shrqty = shrqty*1.1
WHERE shrfirm = 'Nigerian Geese';

select * from share;

-- List full details for all shares with a price less than $1. 
Select * 
from share
where shrprice < 1; 


-- Report showing firm name, share price, share holding, 
-- and total value of shares held. (Value of shares held is price times quantity.)

Select shrfirm, shrprice, shrqty, (shrqty * shrprice) as total_value
from share;


SELECT natname, sum(stkdiv*stkqty*exchrate) AS payment FROM stock JOIN  nation 
ON stock.natcode = nation.natcode 
GROUP BY natname HAVING COUNT(*) >= 3;
