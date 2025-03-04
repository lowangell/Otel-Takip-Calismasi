Create Database BankaSorguIslemleri
USE BankaSorguIslemleri
--DDL KOMUTLARI

--Custormer ile account arasinda bag var 
create table customerss(
customer_id int identity(1,1) primary key not null,
email NVARCHAR(30) UNIQUE not null,
customer_name NVARCHAR(50) not null,
customer_surname NVARCHAR(50) not null,
birthdate date not null
);


CREATE TABLE Accountss(
account_id int identity(1,1) primary key not null,
--CUSTOMER SILINIRSE BURADAKI CUSTOMER_ID NULL OLUR
customer_id int FOREIGN KEY REFERENCES customerss (customer_id) ON DELETE SET null,
branch_id int FOREIGN KEY REFERENCES BranchBankk (branch_id) ON DELETE SET null,
account_name NVARCHAR(50) not null,
currency nvarchar(10) not null,
account_no int not null,
balance money not null
);

create table MoneyTransferss(
tranfer_id int identity(1,1) primary key not null,
transfer_date nvarchar(15) not null,
amount money,
currency nvarchar(10) not null
);


create table Employeess(
employee_id int primary key,
branch_id int FOREIGN KEY REFERENCES BranchBankk (branch_id) ON DELETE SET null,
employee_salary money not null,
employee_name NVARCHAR(50)not null,
employee_surname NVARCHAR(50) not null,
startwork_date NVARCHAR(15) not null
);

create table BranchBankk(
branch_id int primary key,
branch_city NVARCHAR(30),
branch_name NVARCHAR(100) UNIQUE NOT NULL
);

create table Kasaa(
kasa_id int primary key,
kasa_no int
);

EXEC sp_rename 'customerss.custormer_name', 'customer_name', 'COLUMN'
Alter table employeess alter column employee_name NVARCHAR(250)
Alter table employeess add employee_birthdate NVARCHAR(50)
Alter table employeess alter column employee_birthdate date
Alter table employeess drop column employee_birthdate 
ALTER TABLE Accountss ALTER COLUMN account_no NVARCHAR(30)

truncate table kasaa
delete from kasaa
Drop table Kasaa
--DML KOMUTLARI VE YARDIMCI KOMUTLAR

select * from BranchBankk

select * from customerss

select * from MoneyTransferss

select * from Employeess

UPDATE Accountss Set Balance=Balance-100 where account_id=1

SELECT DISTINCT COUNT(email) as Email FROM  customerss

SELECT email as mail from customerss

SELECT account_name as AccountName from Accountss where account_name like '%Sila%' and balance BETWEEN 100 and 5000

Select TOP 1 balance from Accountss

Select balance from Accountss order by balance desc 

SELECT UPPER(customer_name) AS customer_name_upper, UPPER(customer_surname) AS customer_surname_upper FROM customerss

SELECT AVG(balance) AS average_balance FROM Accountss

insert into customerss (email, customer_name, customer_surname, birthdate) values ('ahmetyilmaz@gmail.com', 'Ahmet', 'Yılmaz', '1993-03-12'), 
('aysekaya@ornek.com', 'Ayşe', 'Kaya', '1990-07-25'), 
('mehmetdemır@ornek.com', 'Mehmet', 'Demir', '1950-11-05')

insert into customerss (email, customer_name, customer_surname, birthdate) values ('sercanduru@gmail.com', 'Sercan', 'Duru', '1999-01-01'), 
('selimkeskin@gmail.com', 'Selim', 'Keskin', '1999-05-15'), 
('miraydogan@example.com', 'Miray', 'Doğan', '1992-11-30')

insert into MoneyTransferss (transfer_date, amount, currency) values ('2024-04-16', 100, 'TL'), 
('2024-04-16', 50, 'TL'), 
('2024-04-15', 200, 'TL')

insert into Employeess (employee_id, branch_id, employee_salary, employee_name, employee_surname, startwork_date) values (1, 1, 5000, 'Mihriban', 'İşyar', '2020-01-01'), 
(2, 2, 4500, 'Büsra', 'Sevcan', '2018-05-15'), 
(3, 1, 6000, 'Kader', 'Çoban', '2019-11-30')

insert into BranchBankk (branch_id, branch_city, branch_name) values (1, 'İstanbul', 'Vakıfbank-İ1'), 
(2, 'Ankara', 'Vakıfbank-A1')

insert into Accountss(account_name,account_no,balance,currency) values ('Silanin hesabi', 1 ,1200, 'TL')

insert into Accountss(account_name,account_no,balance,currency) values ('Kubilay', 1 , 1500 , 'TL')

insert into Accountss(account_name,account_no,balance,currency) values ('Necmiye', 1 , 5200 , 'TL')

insert into Accountss(account_name,account_no,balance,currency) values ('erdalin', 1 , 8200 , 'TL')


SELECT custormer_name, LEN(custormer_name) AS name_length, customer_surname, LEN(customer_surname) AS surname_length FROM customerss

SELECT ASCII(LEFT(custormer_name, 1)) AS name_ascii,
       ASCII(LEFT(customer_surname, 1)) AS surname_ascii
FROM customerss

SELECT LOWER(LTRIM(custormer_name)) AS lower_name, LOWER(LTRIM(customer_surname)) AS lower_surname FROM customerss

--Bu sorgu hesap numarasi basina 4 tane x ile degistirir ve sonuna 123
SELECT account_id, REPLACE(LEFT(account_no, 4), '123', 'X123') AS modified_account_no FROM Accountss

--Bu sorgu ad ve soyadi birlestirip tek sutun yapar
SELECT CONCAT(employee_name, ' ',employee_surname ) AS full_name FROM Employeess

SELECT MAX(balance) AS max_balance FROM Accountss
SELECT MIN(balance) AS min_balance FROM Accountss
SELECT SUM(balance) AS total_balance FROM Accountss

-- Random sayi uretme ve pi sayisi kullanimi
SELECT ROUND(RAND() * 100, 0) AS random_number

--SET VE DECLARE KOMUTU = Declare, adini ve veri tipini tanimlar\ set, tanimlanana deger atar\round, yuvarlamak icin kullanilir
Declare @alanBulma float
SET @alanBulma= 5.2 
SELECT ROUND(PI() * @alanBulma, 2) AS result

--REVERSE,REPLICATE,SUBSTRING, FLOOR, CEILING, POWER, SING KULLANIMI
DECLARE @text NVARCHAR(50)
SET @text = 'Hello, World!'
-- metnin ters cevirir
SELECT REVERSE(@text) AS reversed_text
--hello kelimesini almak icin kullandik ilk indexini ve son indexini yazdik
SELECT SUBSTRING(@text, 1, 5) AS substring_text
--text metnine bosluklar eklicek
SELECT REPLICATE(' ', 10) + @text AS replicate_text

DECLARE @number FLOAT
SET @number = 4.5
--Sayinin isaretini verir(+ ise 1, - ise -1, 0 ise 0 dondurur)
SELECT SIGN(@number) as signed_number
--Sayinin en büyük tam sayiya yuvarlar
SELECT FLOOR(@number) AS floored_number

--Sayinin en küçük tam sayiya yuvarlar
SELECT CEILING(@number) AS ceiling_number

--Sayinin ussunu alir
SELECT POWER(@number, 2) AS squared_number
--Sayinin karekokunu  alir
SELECT SQRT(@number) AS sqrt_number
--RDBMS VERITABANI YAPISI
--INNER JOIN
--customer_id'ye sahip olan müşterilerin ve hesapların birleştirilmesini sağlar
SELECT customerss.customer_id, Accountss.account_id FROM customerss INNER JOIN Accountss ON customerss.customer_id =Accountss.account_id 

--RIGHT JOIN, LEFT JOIN, FULL JOIN, CROSS JOIN
SELECT customerss.customer_id, customerss.custormer_name, Accountss.account_id, Accountss.account_name FROM customerss LEFT JOIN Accountss ON customerss.customer_id = Accountss.customer_id
SELECT customerss.customer_id, customerss.custormer_name, Accountss.account_id, Accountss.account_name FROM customerss RIGHT JOIN Accountss ON customerss.customer_id = Accountss.customer_id
SELECT customerss.customer_id, customerss.custormer_name, Accountss.account_id, Accountss.account_name FROM customerss FULL JOIN Accountss ON customerss.customer_id = Accountss.customer_id

--Tüm kayıtları her iki tablodan alır ve her bir satırı diğer tablodaki tüm satırlarla birleştirir
SELECT customerss.customer_id, customerss.custormer_name, Accountss.account_id, Accountss.account_name FROM customerss CROSS JOIN Accountss 

--INTERSECT,EXCEPT,
SELECT customer_id, customer_name, customer_surname FROM customerss INTERSECT SELECT customer_id, account_name, '' FROM Accountss
SELECT customer_id, custormer_name, customer_surname FROM customerss EXCEPT SELECT customer_id, account_name, '' FROM Accountss

--GROUP BY , HAVING, BETWEEN
SELECT account_id, CONCAT(account_name,' ', account_no) AS Account, SUM(balance) AS total_balance FROM Accountss
GROUP BY account_id,account_name,account_no
HAVING SUM(balance) BETWEEN 1000 AND 5000

--DATEDIFF 
ALTER TABLE MoneyTransferss
ADD customer_id int
ALTER TABLE MoneyTransferss
ADD CONSTRAINT FK_MoneyTransferss_Customers
FOREIGN KEY (customer_id) REFERENCES customerss(customer_id)

SELECT c.custormer_name, c.customer_surname, DATEDIFF(DAY, c.birthdate, GETDATE()) AS days_since_birth, DATEDIFF(DAY, mt.transfer_date, GETDATE()) AS days_since_transfer
FROM customerss c INNER JOIN MoneyTransferss mt ON c.customer_id = mt.customer_id 

--DECLARE, SET, KARAR YAPILARI VE DONGULER
--DECLARE = degisken tanimlar, SET= deger atar BEGIN= if blogunu baslatir, END= blogu bitirir
DECLARE @balance money
SET @balance = 1000

IF @balance > 500
BEGIN
    PRINT 'Balance is greater than 500'
END
ELSE
BEGIN
    PRINT 'Balance is 500 or less'
END

DECLARE @i INT = 1
WHILE @i <= 10
BEGIN
    PRINT 'Iteration: ' + CAST(@i AS NVARCHAR(10))
    SET @i = @i + 1
END

--musterilerin ad soyad hesap numarasi ve bakiyesini gosterir.Detaylari tek bir tabloda birlestirdik
CREATE VIEW CustomerDetails AS
SELECT c.customer_id, c.custormer_name, c.customer_surname, a.account_no, a.balance FROM customerss c INNER JOIN Accountss a ON c.customer_id = a.customer_id

--Diger dillerdeki metod mantiginda calisir. Musterinin bakiyesini getirir
CREATE PROCEDURE GetCustomerBalance
    @customer_id int
AS
BEGIN
    SELECT balance
    FROM Accountss
    WHERE customer_id = @customer_id
END
-- musterinin hesaplari arasindaki toplam bakiyeyi hesaplar
CREATE FUNCTION GetTotalBalance(@customer_id int)
RETURNS money
AS
BEGIN
    DECLARE @total_balance money
    SELECT @total_balance = SUM(balance)
    FROM Accountss
    WHERE customer_id = @customer_id
    RETURN @total_balance
END
--Bu tablo customerss tablosu guncellendikten sonra gecmis kayit olusturur kullanici gecmisini takip etmeyi kolaylastirir
CREATE TRIGGER CustormeUpdateHistory
ON customerss
AFTER UPDATE
AS
BEGIN
    INSERT INTO CustomerHistory (customer_id, customer_name, customer_surname, update_date)
    SELECT d.customer_id, d.custormer_name, d.customer_surname, GETDATE()
    FROM deleted d
    JOIN inserted i ON d.customer_id = i.customer_id
END