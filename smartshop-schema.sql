-- SmartShop Inventory System - Database Schema Definition
-- Create the database for SmartShop Inventory System
CREATE DATABASE SmartShopInventorySystem;

-- Use the created database
USE SmartShopInventorySystem;

-- Verification queries to confirm current database and structure
SELECT DATABASE() AS 'Current Database';
SHOW TABLES;

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Create Products table with foreign key reference
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockLevel INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Stores table
CREATE TABLE Stores (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactPhone VARCHAR(20) NOT NULL
);

-- Create Sales table
CREATE TABLE Sales (
    SalesID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    StoreID INT NOT NULL,
    SaleDate DATE NOT NULL,
    UnitsSold INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

-- Create Deliveries table
CREATE TABLE Deliveries (
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierID INT NOT NULL,
    ProductID INT NOT NULL,
    ExpectedDate DATE NOT NULL,
    ActualDate DATE,
    QuantityDelivered INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Verify table structure
DESCRIBE Categories;
DESCRIBE Products;
DESCRIBE Stores;
DESCRIBE Suppliers;
DESCRIBE Sales;
DESCRIBE Deliveries;