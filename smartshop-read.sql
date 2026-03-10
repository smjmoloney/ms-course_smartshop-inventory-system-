-- SmartShop Inventory System - READ Operations (SELECT Statements)

-- ===========================================
-- BASIC QUERIES
-- ===========================================

-- Retrieve all products with category names (using JOIN)
SELECT ProductName, CategoryName, Price, StockLevel
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

-- Retrieve all products
SELECT *
FROM Products;

-- Retrieve products from a specific category (e.g. Electronics)
SELECT p.ProductName, c.CategoryName, p.Price, p.StockLevel
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Electronics';

-- Retrieve products with low stock (20 or fewer items)
SELECT ProductName, CategoryName, Price, StockLevel
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.StockLevel <= 20;

-- Retrieve all products sorted by price (ascending - lowest to highest)
SELECT ProductName, CategoryName, Price, StockLevel
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY Price ASC;

-- ===========================================
-- MULTI-TABLE QUERIES
-- ===========================================

-- Query: ProductName, SaleDate, StoreLocation, and UnitsSold
SELECT p.ProductName, s.SaleDate, st.Location AS StoreLocation, s.UnitsSold
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
INNER JOIN Stores st ON s.StoreID = st.StoreID;

-- ===========================================
-- AGGREGATE FUNCTIONS & ANALYSIS
-- ===========================================

-- Calculate total sales for each product
SELECT p.ProductName, SUM(s.UnitsSold) AS TotalSalesQuantity
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSalesQuantity DESC;

-- Identify suppliers with the most delayed deliveries
SELECT sup.SupplierName, 
       COUNT(*) AS DelayedDeliveries,
       AVG(DATEDIFF(d.ActualDate, d.ExpectedDate)) AS AvgDelayDays
FROM Suppliers sup
INNER JOIN Deliveries d ON sup.SupplierID = d.SupplierID
WHERE d.ActualDate > d.ExpectedDate
GROUP BY sup.SupplierID, sup.SupplierName
ORDER BY DelayedDeliveries DESC;

-- ===========================================
-- REFERENCE TABLES
-- ===========================================

-- View all categories
SELECT * FROM Categories ORDER BY CategoryID;

-- View all stores
SELECT * FROM Stores ORDER BY StoreID;

-- View all suppliers
SELECT * FROM Suppliers ORDER BY SupplierID;

-- ===========================================
-- ADDITIONAL USEFUL QUERIES
-- ===========================================

-- Sales by store
SELECT st.StoreName, st.Location, SUM(s.UnitsSold) AS TotalUnitsSold
FROM Stores st
INNER JOIN Sales s ON st.StoreID = s.StoreID
GROUP BY st.StoreID, st.StoreName, st.Location
ORDER BY TotalUnitsSold DESC;

-- Sales trends by month
SELECT YEAR(SaleDate) AS SalesYear, MONTH(SaleDate) AS SalesMonth, 
       SUM(UnitsSold) AS MonthlyUnits
FROM Sales
GROUP BY YEAR(SaleDate), MONTH(SaleDate)
ORDER BY SalesYear, SalesMonth;

-- ===========================================
-- DEBUGGING & ERROR CORRECTION EXAMPLES
-- ===========================================

-- ISSUE 1: Fixed JOIN mismatch causing duplicate results
-- PROBLEM: Originally had incorrect JOIN condition
-- BAD: SELECT p.ProductName, s.SaleDate FROM Products p INNER JOIN Sales s ON p.ProductID = s.StoreID;
-- FIXED VERSION:
SELECT p.ProductName, s.SaleDate, s.UnitsSold
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID;

-- ISSUE 2: Corrected nested query syntax error 
-- PROBLEM: Missing correlation in subquery
-- BAD: SELECT ProductName FROM Products WHERE CategoryID IN (SELECT CategoryID WHERE CategoryName = 'Electronics');
-- FIXED VERSION:
SELECT ProductName, Price, StockLevel
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName = 'Electronics');

-- ISSUE 3: Fixed aggregate function grouping error
-- PROBLEM: Non-aggregated column in SELECT without GROUP BY
-- BAD: SELECT p.ProductName, SUM(s.UnitsSold) FROM Products p INNER JOIN Sales s ON p.ProductID = s.ProductID;
-- FIXED VERSION:
SELECT p.ProductName, SUM(s.UnitsSold) AS TotalSold
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName;

-- ISSUE 4: Fixed WHERE clause with NULL values
-- PROBLEM: Not handling NULL ActualDate properly
-- BAD: SELECT * FROM Deliveries WHERE ActualDate > ExpectedDate;
-- FIXED VERSION:
SELECT SupplierID, ProductID, ExpectedDate, ActualDate, 
       DATEDIFF(ActualDate, ExpectedDate) AS DelayDays
FROM Deliveries
WHERE ActualDate IS NOT NULL AND ActualDate > ExpectedDate;

-- ===========================================
-- PERFORMANCE OPTIMIZATION
-- ===========================================

-- OPTIMIZATION 1: Added indexes for frequently queried columns
-- Copilot suggested these indexes based on query patterns:

-- Index on Products.CategoryID (used in many JOINs)
-- CREATE INDEX idx_products_category ON Products(CategoryID);

-- Index on Sales.ProductID (frequent foreign key lookups)
-- CREATE INDEX idx_sales_product ON Sales(ProductID);

-- Index on Sales.StoreID (store-based analysis)
-- CREATE INDEX idx_sales_store ON Sales(StoreID);

-- Index on Sales.SaleDate (date range queries)
-- CREATE INDEX idx_sales_date ON Sales(SaleDate);

-- Composite index for common query pattern
-- CREATE INDEX idx_sales_product_date ON Sales(ProductID, SaleDate);

-- OPTIMIZATION 2: Restructured query for better execution plan
-- BEFORE: Slower subquery approach
-- SELECT p.ProductName, p.Price FROM Products p 
-- WHERE p.ProductID IN (SELECT ProductID FROM Sales WHERE SaleDate >= '2026-02-01');

-- AFTER: Optimized JOIN approach
SELECT DISTINCT p.ProductName, p.Price
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleDate >= '2026-02-01';

-- OPTIMIZATION 3: Reduced unnecessary computation
-- BEFORE: Multiple function calls in WHERE clause
-- SELECT * FROM Sales WHERE YEAR(SaleDate) = 2026 AND MONTH(SaleDate) = 2;

-- AFTER: Using date range for better index usage
SELECT * FROM Sales 
WHERE SaleDate >= '2026-02-01' AND SaleDate < '2026-03-01';

-- OPTIMIZATION 4: Optimized aggregate query with proper indexing
-- Efficient top-selling products query
SELECT p.ProductName, c.CategoryName, SUM(s.UnitsSold) AS TotalSold, p.Price
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
INNER JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, c.CategoryName, p.Price
HAVING SUM(s.UnitsSold) > 5
ORDER BY TotalSold DESC
LIMIT 10;

-- ===========================================
-- TESTING & VALIDATION QUERIES
-- ===========================================

-- Performance comparison: Check query execution time
-- Use EXPLAIN to analyze execution plans

-- EXPLAIN SELECT p.ProductName, SUM(s.UnitsSold) FROM Products p INNER JOIN Sales s ON p.ProductID = s.ProductID GROUP BY p.ProductID, p.ProductName;

-- Validate result accuracy: Verify total sales match
SELECT 'Total Units Sold (Sum Check)' AS Metric, SUM(UnitsSold) AS Total FROM Sales
UNION ALL
SELECT 'Count of Sales Records', COUNT(*) FROM Sales
UNION ALL
SELECT 'Distinct Products Sold', COUNT(DISTINCT ProductID) FROM Sales;

-- Performance test: Compare indexed vs non-indexed query performance
-- Run before and after creating indexes to measure improvement

-- Cross-validation: Ensure JOIN accuracy
SELECT 
    (SELECT COUNT(*) FROM Products) AS TotalProducts,
    (SELECT COUNT(DISTINCT ProductID) FROM Sales) AS ProductsSold,
    (SELECT COUNT(*) FROM Sales) AS TotalSales;