-- SmartShop Inventory System - CREATE Operations (INSERT Statements)

-- Insert categories
INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Footwear'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Food & Beverages'),
('Beauty'),
('Sports'),
('Accessories');

-- Insert products - 20 example products with CategoryID references
INSERT INTO Products (ProductName, CategoryID, Price, StockLevel) VALUES
('iPhone 14 Pro', 1, 999.99, 25),
('Samsung Galaxy S23', 1, 799.99, 18),
('Nike Air Max 270', 2, 149.99, 42),
('Levi''s 501 Jeans', 3, 79.99, 35),
('Sony WH-1000XM5 Headphones', 1, 399.99, 12),
('The Great Gatsby', 4, 12.99, 67),
('KitchenAid Stand Mixer', 5, 349.99, 8),
('Adidas Ultraboost 22', 2, 189.99, 28),
('MacBook Pro 16"', 1, 2499.99, 5),
('Organic Green Tea', 6, 24.99, 156),
('Calvin Klein Dress Shirt', 3, 65.99, 22),
('Fenty Beauty Foundation', 7, 38.00, 33),
('Wilson Tennis Racket', 8, 129.99, 14),
('Instant Pot Duo', 5, 79.99, 41),
('Harry Potter Box Set', 4, 58.99, 19),
('Ray-Ban Aviators', 9, 154.99, 31),
('Patagonia Fleece Jacket', 3, 199.99, 16),
('Vitamix Blender', 5, 449.99, 7),
('Organic Coffee Beans', 6, 18.99, 89),
('Fitbit Versa 4', 1, 229.99, 26);

-- Insert store data (Dublin locations)
INSERT INTO Stores (StoreName, Location) VALUES
('SmartShop Temple Bar', 'Temple Bar, Dublin 2'),
('SmartShop Grafton Street', 'Grafton Street, Dublin 2'),
('SmartShop Blanchardstown', 'Blanchardstown, Dublin 15'),
('SmartShop Dundrum', 'Dundrum Town Centre, Dublin 16');

-- Insert supplier data
INSERT INTO Suppliers (SupplierName, ContactPhone) VALUES
('TechSource Ireland', '01-555-0001'),
('Fashion Forward Ltd', '01-555-0002'),
('Sports & Leisure Co', '01-555-0003'),
('Home Essentials Dublin', '01-555-0004'),
('Global Book Distributors', '01-555-0005');

-- Insert sales data (last 2 months - Jan-Mar 2026)
INSERT INTO Sales (ProductID, StoreID, SaleDate, UnitsSold) VALUES
(1, 1, '2026-01-15', 3),    -- iPhone at Temple Bar
(1, 2, '2026-01-18', 2),    -- iPhone at Grafton Street
(2, 1, '2026-01-20', 1),    -- Samsung at Temple Bar
(3, 4, '2026-01-25', 5),    -- Nike shoes at Dundrum
(4, 2, '2026-02-01', 2),    -- Levi's jeans at Grafton Street
(5, 3, '2026-02-05', 1),    -- Sony headphones at Blanchardstown
(6, 1, '2026-02-08', 8),    -- Great Gatsby at Temple Bar
(7, 4, '2026-02-10', 1),    -- KitchenAid at Dundrum
(8, 2, '2026-02-12', 3),    -- Adidas shoes at Grafton Street
(9, 1, '2026-02-15', 1),    -- MacBook at Temple Bar
(10, 3, '2026-02-18', 12),  -- Green tea at Blanchardstown
(11, 2, '2026-02-20', 2),   -- Dress shirt at Grafton Street
(12, 4, '2026-02-22', 4),   -- Foundation at Dundrum
(13, 1, '2026-02-25', 1),   -- Tennis racket at Temple Bar
(14, 3, '2026-02-28', 2),   -- Instant Pot at Blanchardstown
(15, 2, '2026-03-01', 6),   -- Harry Potter at Grafton Street
(16, 4, '2026-03-03', 2),   -- Ray-Ban at Dundrum
(17, 1, '2026-03-05', 1),   -- Patagonia jacket at Temple Bar
(18, 3, '2026-03-07', 1),   -- Vitamix at Blanchardstown
(19, 2, '2026-03-08', 15),  -- Coffee beans at Grafton Street
(20, 4, '2026-03-09', 2);   -- Fitbit at Dundrum

-- Insert delivery data (some on-time, some delayed)
INSERT INTO Deliveries (SupplierID, ProductID, ExpectedDate, ActualDate, QuantityDelivered) VALUES
(1, 1, '2026-01-10', '2026-01-12', 30),   -- TechSource iPhone (2 days late)
(1, 2, '2026-01-15', '2026-01-15', 25),   -- TechSource Samsung (on time)
(2, 3, '2026-01-20', '2026-01-25', 50),   -- Fashion Forward Nike (5 days late)
(2, 4, '2026-02-01', '2026-02-01', 40),   -- Fashion Forward Levi's (on time)
(1, 5, '2026-02-05', '2026-02-08', 15),   -- TechSource Sony (3 days late)
(5, 6, '2026-02-10', '2026-02-12', 80),   -- Global Books Gatsby (2 days late)
(4, 7, '2026-02-12', '2026-02-20', 10),   -- Home Essentials KitchenAid (8 days late)
(2, 8, '2026-02-15', '2026-02-15', 35),   -- Fashion Forward Adidas (on time)
(1, 9, '2026-02-18', '2026-02-25', 8),    -- TechSource MacBook (7 days late)
(4, 14, '2026-02-20', '2026-02-22', 50),  -- Home Essentials Instant Pot (2 days late)
(5, 15, '2026-02-25', '2026-02-28', 25),  -- Global Books Harry Potter (3 days late)
(1, 20, '2026-03-01', '2026-03-02', 30);  -- TechSource Fitbit (1 day late)