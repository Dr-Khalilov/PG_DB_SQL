CREATE TABLE Products
(
    Id SERIAL PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Company VARCHAR(20) NOT NULL,
    ProductCount INTEGER DEFAULT 0,
    Price NUMERIC NOT NULL
);
CREATE TABLE Customers
(
    Id SERIAL PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
    Id SERIAL PRIMARY KEY,
    ProductId INTEGER NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
    CustomerId INTEGER NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
    CreatedAt DATE NOT NULL,
    ProductCount INTEGER DEFAULT 1,
    Price NUMERIC NOT NULL
);

INSERT INTO Products(ProductName, Company, ProductCount, Price) 
VALUES ('iPhone X', 'Apple', 2, 66000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 42000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8 Plus', 'Samsung', 1, 46000),
('Nokia 9', 'HDM Global', 2, 26000),
('Desire 12', 'HTC', 6, 38000);
  
INSERT INTO Customers(FirstName) 
VALUES ('Tom'), ('Bob'),('Sam');
  
INSERT INTO Orders(ProductId, CustomerId, CreatedAt, ProductCount, Price) 
VALUES
( 
    (SELECT Id FROM Products WHERE ProductName='Galaxy S9'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-11',  
    2, 
    (SELECT Price FROM Products WHERE ProductName='Galaxy S9')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 8'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-13',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 8')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 8'), 
    (SELECT Id FROM Customers WHERE FirstName='Bob'),
    '2017-07-11',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 8')
);

	
SELECT * FROM Orders, Customers;

SELECT * FROM Orders, Customers
WHERE Orders.CustomerId = Customers.Id;

SELECT Customers.FirstName, Products.ProductName, Orders.CreatedAt 
FROM Orders, Customers, Products
WHERE Orders.CustomerId = Customers.Id AND Orders.ProductId=Products.Id;

SELECT O.CreatedAt, O.ProductCount, P.ProductName 
FROM Orders AS O
JOIN Products AS P ON P.Id = O.ProductId;

SELECT  O.CreatedAt, C.FirstName, P.ProductName
FROM Orders AS O
JOIN Products AS P ON P.Id = O.ProductId
JOIN Customers AS C ON C.Id = O.CustomerId
WHERE P.Price >45000
ORDER BY C.FirstName;


SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName 
FROM Orders
JOIN Products ON Products.Id = Orders.ProductId AND Products.Company='Apple'
JOIN Customers ON Customers.Id=Orders.CustomerId
ORDER BY Customers.FirstName;