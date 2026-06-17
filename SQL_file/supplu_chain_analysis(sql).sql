use supply_chain_project;
# 1) Total Orders.
select count(*) as Total_orders from supply_chain;

# 2) Total Sales
select round(sum(sales),2) as total_sales from supply_chain;

# 3) Total profit
select round(sum(`Order Profit Per Order`),2) as Total_profit from supply_chain;

# 4) Average Profit Per Order
select round(avg(`Order Profit Per Order`),2) as avg_profit_per_order from supply_chain;

# 5) Top 10 Categories by Sales
select `Category Name`, round(sum(Sales),2) as total_sales from supply_chain group by `Category Name` order by sum(Sales) desc limit 10 ;

# 6) Top 10 Products by Sales
select `Product Name`, round(sum(Sales),2) as total_sales_of_products from supply_chain group by `Product Name` order by sum(Sales) desc limit 10 ;

# 7) Top 10 Products by Profit
select `Product Name`, round(sum(`Order Profit Per Order`),2) as profit_of_products from supply_chain 
group by `Product Name` order by sum(`Order Profit Per Order`) desc limit 10 ;

# 8) Revenue by Market
select Market, round(sum(Sales),2) as market_revenue from supply_chain group by Market order by sum(Sales) desc;

# 9) Top Countries by Sales
select `Order Country`, round(sum(Sales),2) as Category_sales from supply_chain group by `Order Country` order by sum(Sales) desc;

# 10) Delivery Status Analysis
select `Delivery Status`,count(*)as total_orders from supply_chain group by `Delivery Status`;

# 11) Late Delivery Risk Analysis
select Late_delivery_risk , count(*) as total_orders from supply_chain group by Late_delivery_risk;

# 12) Customer Segment Revenue
select `Customer Segment`, round(sum(Sales),2) as Revenue from supply_chain group by `Customer Segment` Order by sum(Sales) desc;
 
# 13) Loss Making Categories
select `Category Name`, round(sum(`Order Profit Per Order`),2) as total_Loss from supply_chain group by `Category Name` order by sum(`Order Profit Per Order`) asc;

# 14) Top 10 Loss Making Products
select `Product Name`, round(sum(`Order Profit Per Order`),2) as total_Loss from supply_chain group by `Product Name`  order by sum(`Order Profit Per Order`) asc limit 10;

# 15) Sales vs Profit by Category
select `Category Name`, round(sum(Sales),2) as Total_sales, round(sum(`Order Profit Per Order`),2) as Total_profit, round
(sum(Sales) - sum(`Order Profit Per Order`),2) as estimated_investment from supply_chain group by `Category Name` order by sum(Sales) desc;
        
# 16) Top Customer Segments   
select `Customer Segment`, COUNT(*) as total_orders, round(sum(Sales),2) as total_sales from supply_chain group by `Customer Segment` order by total_sales desc;

# 17) Best Shipping Mode
select `Shipping Mode`, count(*) as total_orders, round(avg(`Order Profit Per Order`),2) as avg_profit from supply_chain group by `Shipping Mode` order by avg_profit desc; 

# 18) Monthly Sales Trend
select month(`order date (DateOrders)`) as Month_sales,YEAR(`order date (DateOrders)`) as year_sales, round(sum(Sales),2) from supply_chain group by  month(`order date (DateOrders)`),YEAR(`order date (DateOrders)`)  order by Month_sales, year_sales; 

# 19) Monthly Profit Trend
select month(`order date (DateOrders)`) as Month_profit,YEAR(`order date (DateOrders)`) as year_profit, round(sum(`Order Profit Per Order`),2) as profit from supply_chain group by  month(`order date (DateOrders)`),YEAR(`order date (DateOrders)`)  order by Month_profit, year_profit;

# 20) Top Countries by Profit
select `Order Country`, round(sum(`Order Profit Per Order`),2) as profit from supply_chain group by `Order Country` order by profit desc limit 5;

# 21) Profit Margin by Category
select `Category Name`, round(sum(`Order Profit Per Order`) / sum(Sales) * 100,2) as profit_margin_pct from supply_chain group by `Category Name` order by profit_margin_pct desc;

# 22) Top 5 Markets by Profit
select Market, round(sum(`Order Profit Per Order`),2) as profit from supply_chain group by Market order by profit limit 5;

# 23) Top 3 Products in each Category
WITH product_sales AS (
    SELECT
        `Category Name`,
        `Product Name`,
        SUM(Sales) AS total_sales,
        ROW_NUMBER() OVER(
            PARTITION BY `Category Name`
            ORDER BY SUM(Sales) DESC
        ) AS rn
    FROM supply_chain
    GROUP BY `Category Name`, `Product Name`
)
SELECT *
FROM product_sales
WHERE rn <= 3;