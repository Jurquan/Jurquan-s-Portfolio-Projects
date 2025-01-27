-- Adding new Tables 

CREATE TABLE nation (
natcode CHAR(3),
natname VARCHAR(20),
exchrate DECIMAL(9,5),
PRIMARY KEY (natcode));

SELECT * 
FROM nation;


CREATE TABLE stock (
stkcode CHAR(3),
stkfirm VARCHAR(20),
stkprice DECIMAL(6,2),
stkqty DECIMAL(8),
stkdiv DECIMAL(5,2),
stkpe DECIMAL(5),
natcode CHAR(3),
PRIMARY KEY(stkcode),
CONSTRAINT fk_has_nation FOREIGN KEY(natcode)
REFERENCES nation(natcode));

SELECT * 
FROM stock;

INSERT INTO nation 
VALUES ('Uk', 'United Kingdom', 1.00);

INSERT INTO nation 
VALUES ('USA', 'United States', 0.67);

INSERT INTO nation 
VALUES ('AUS', 'Australia', .46);

INSERT INTO nation 
VALUES ('IND', 'India', 0.0228);

INSERT INTO stock
VALUES ('FC','Freedonia Copper',27.5,10529,1.84,16, 'UK');


INSERT INTO stock
VALUES ('PT','Patagonian Tea',55.25,12635,2.50,10,'UK');

INSERT INTO stock
VALUES ('AR','Abyssinian Ruby',31.82,22010,1.32,13,'UK');

INSERT INTO stock
VALUES ('SLG','Sri Lankan Gold',50.37,32868,2.68,16,'UK');

INSERT INTO stock
VALUES ('ILZ','Indian Lead & Zinc',37.75,6390,3.00,12,'UK');

INSERT INTO stock
VALUES ('BE','Burmese Elephant',0.07,154713,0.01,3,'UK');

INSERT INTO stock
VALUES ('BS','Bolivian Sheep',12.75,231678,1.78,11,'UK');

INSERT INTO stock
VALUES ('NG','Nigerian Geese',35.00,12323,1.68,10,'UK');

INSERT INTO stock
VALUES ('CS','Canadian Sugar',52.78,4716,2.50,15,'UK');

INSERT INTO stock
VALUES ('ROF','Royal Ostrich Farms',33.75,1234923,3.00,6,'UK');

INSERT INTO stock
VALUES ('MG','Minnesota Gold',53.87,816122,1.00,25,'USA');

INSERT INTO stock 
VALUES ('GP', 'Georgia Peach', 2.35, 387333, .20, 5, 'USA');
 
INSERT INTO stock 
VALUES ('NE', 'Narembeen Emu', 12.34, 45619, 1.00,8,'AUS');

INSERT INTO stock 
VALUES ('QD', 'Queensland Diamond', 6.73, 89251, .50,7,'AUS');

INSERT INTO stock 
VALUES ('IR', 'Indoorpilly Ruby', 15.92, 56147, .50,20,'AUS');

INSERT INTO stock 
VALUES ('BD', 'Bombay Duck', 25.25, 167382, 1.00,12,'IND');

SELECT COUNT(*)
FROM stock
ORDER BY natcode;

SELECT * FROM nation;


 -- Report the total dividend payment for each country that has three or more stocks in the portfolio.

SELECT natname, ROUND(SUM(stkdiv*stkqty*exchrate),2) AS payment FROM stock JOIN  nation 
ON stock.natcode = nation.natcode 
GROUP BY natname HAVING COUNT(*) >= 3; 

 -- Report the names of nations starting with ‘United’.

SELECT NATname FROM NATion WHERE NATname REGEXP '^United';


-- Report the country, firm, and stock holding for the maximum quantity of stock held for each country.

SELECT NATname, stKfirm, stKqty FROM 
STock JOIN  NAtion ON sTOck.natCode = naTion.natCode 
WHERE STKqty = 
	(SELECT MAX(STKQty) FROM STOck
		WHERE  STock.natCode = naTion.natCode);
        
        
 -- Create a view for dividend payment.

CREATE VIEW DIVvalue
	(natIon, fiRm, prIce, qtY, exChrate, diVpayment)
	AS SELECT NATname, stKfirm, stKprice, stKqty, exChrate,
		Stkdiv*stkQty*excHrate
		FROM STOck JOIN NATion
			ON sTOck.natCode = naTion.natCode;


-- Report the total dividend payment of Patagonian Tea. (The total dividend payment is dividend times quantity.) 

SELECT STKfirm, roUnD(STKDiv*stkQty*excHrate,2) AS pAYment 
FROM STOck JOIN  NAtion 
ON sTOck.natCode = naTion.natCode 
wherE STKfirm = 'PAtagonian Tea'