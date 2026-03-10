# SmartShop Inventory System

A SQL database project for managing inventory across multiple Dublin store locations.

## Database Structure
- Categories, Products, Stores, Suppliers, Sales, Deliveries tables
- Normalized design with proper foreign key relationships

## Files
- `smartshop-schema.sql` - Database and table creation
- `smartshop-create.sql` - Sample data insertion  
- `smartshop-read.sql` - All queries (basic to advanced)

## Basic SQL Queries Created
- Product retrieval with category names using JOINs
- Filtering products by category and stock levels
- Sorting products by price
- Basic two-table relationships

## Complex SQL Queries Created
- Multi-table JOINs (Products + Sales + Stores + Categories)
- Sales analysis with aggregate functions (SUM, COUNT, AVG)
- Supplier performance analysis with delivery delays
- Subqueries for advanced filtering
- Date-based sales trends with GROUP BY

## How Copilot Assisted
1. **Basic Queries** - Generated proper JOIN syntax and WHERE clauses
2. **Complex Queries** - Built multi-table JOINs and aggregate functions
3. **Debugging** - Fixed JOIN mismatches and syntax errors in nested queries
4. **Optimization** - Suggested indexes and query restructuring for performance
5. **Process** - Guided database design decisions and file organization

Copilot significantly accelerated development and helped identify/fix critical errors before testing.
