BRIGHTCART PROFITABILITY ANALYSIS

Questions to Answer
1.	What is the average profit margin by product category? Which categories are the most and least profitable, and what is driving the difference (product cost, shipping, returns, or discounts)?
2.	How does profitability differ across sales channels (Website, Mobile App, Marketplace, Social Commerce)? Which channel has the best and worst profit per order after accounting for platform fees?
3.	What is the return rate by category and channel? Estimate how much total revenue was lost to returns over the analysis period.
4.	Analyze the marketing spend data: Which advertising platform delivers the best ROAS (Return on Ad Spend)? Are there any platforms where the company is spending money but not getting a positive return?
5.	If the CEO asked you to cut 20% of the marketing budget, which platforms and months would you recommend reducing spend on? Support your recommendation with data.


--
--
REGONAL PERFORMANCE ANALYSIS

-- regional orders 

SELECT 
    region,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_id IS NOT NULL
GROUP BY region
ORDER BY total_orders DESC;


-- regioanl performance

SELECT 
    region,
    COUNT(order_id) AS total_orders,
    SUM(items_ordered) AS total_units_sold,
    SUM(gross_revenue) AS total_gross_revenue,
    SUM(total_costs) AS total_costs,
    SUM(net_revenue) AS total_net_revenue,
    SUM(profit) AS total_net_profit
FROM orders
GROUP BY region
HAVING SUM(net_revenue) > 0
ORDER BY total_net_profit DESC;


-- net profit margin by region and category

SELECT 
	region,     
	primary_category,
    -- Calculating margin percentage
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS profit_margin_percentage
FROM orders
WHERE region IS NOT NULL
GROUP BY region, primary_category
ORDER BY profit_margin_percentage DESC;


-- regional cost drivers

SELECT 
    o.region,
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS net_profit_margin_pct, -- 1. TARGET METRIC: Net Profit Margin
    ROUND((SUM(product_cost) / SUM(net_revenue)) * 100, 2) AS product_cost_driver_pct,  -- 2. COST DRIVERS (Expressed as a % of Net Revenue)
    ROUND((SUM(shipping_cost) / SUM(net_revenue)) * 100, 2) AS shipping_cost_driver_pct,
    ROUND((SUM(platform_fee) / SUM(net_revenue)) * 100, 2) AS platform_fee_driver_pct,
    ROUND((SUM(transaction_fee) / SUM(net_revenue)) * 100, 2) AS transaction_fee_driver_pct   
FROM orders o 
GROUP BY region
HAVING SUM(net_revenue) > 0 AND SUM(gross_revenue) > 0
ORDER BY net_profit_margin_pct DESC;


-- regional revenue leakage

SELECT 
    region,
    SUM(net_revenue) AS total_net_revenue,
    ROUND((SUM(discount_amount) / SUM(gross_revenue)) * 100, 2) AS discount_impact_pct, 
    ROUND((SUM(refund_amount) / SUM(gross_revenue)) * 100, 2) AS refund_impact_pct 
FROM orders o 
GROUP BY region
HAVING SUM(net_revenue) > 0 AND SUM(gross_revenue) > 0
ORDER BY refund_impact_pct DESC;


--
--
CATEGORY PERFORMANCE ANALYSIS

-- Orders by product category

SELECT 
    primary_category,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY primary_category
ORDER BY total_orders DESC;

---
-- product category performance
-- Total revenue, total costs, total profit, and profit margin by product category

SELECT 
    primary_category,
    SUM(gross_revenue ) AS total_gross_revenue,
    SUM(total_costs ) AS total_cost,
    SUM(profit) AS total_category_profit,
    SUM(net_revenue) AS total_category_net_revenue,
    -- Calculating margin percentage
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS profit_margin_percentage
FROM orders
GROUP BY primary_category
HAVING SUM(net_revenue) > 0
ORDER BY profit_margin_percentage DESC;

---

-- Drivers of profit margin
-- To determine the operational cost "driving" margins down or up
-- This query groups your data by primary_category and calculates the exact percentage impact of each cost driver, alongside the revenue "leakage" metrics (Discounts and Refunds) from top-line Gross Revenue.

SELECT 
    primary_category,
    SUM(net_revenue) AS total_net_revenue,
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS net_profit_margin_pct, -- 1. TARGET METRIC: Net Profit Margin
    ROUND((SUM(product_cost) / SUM(net_revenue)) * 100, 2) AS product_cost_driver_pct,  -- 2. COST DRIVERS (Expressed as a % of Net Revenue)
    ROUND((SUM(shipping_cost) / SUM(net_revenue)) * 100, 2) AS shipping_cost_driver_pct,
    ROUND((SUM(platform_fee) / SUM(net_revenue)) * 100, 2) AS platform_fee_driver_pct,
    ROUND((SUM(transaction_fee) / SUM(net_revenue)) * 100, 2) AS transaction_fee_driver_pct   
FROM orders
GROUP BY primary_category
HAVING SUM(net_revenue) > 0 AND SUM(gross_revenue) > 0
ORDER BY net_profit_margin_pct DESC;

--
-- revenue leakage drivers 
-- Expressed as a % of gross revenue

SELECT 
    primary_category,
    SUM(net_revenue) AS total_net_revenue,
    ROUND((SUM(discount_amount) / SUM(gross_revenue)) * 100, 2) AS discount_impact_pct, 
    ROUND((SUM(refund_amount) / SUM(gross_revenue)) * 100, 2) AS refund_impact_pct 
FROM orders o 
GROUP BY primary_category
HAVING SUM(net_revenue) > 0 AND SUM(gross_revenue) > 0
ORDER BY refund_impact_pct DESC;




--
--
PRODUCTS PERFORMANCE ANALYSIS

-- Top 10 products by selling price
-- To determine BrightCart's premium inventory tier

SELECT 
    p.product_name,
    p.product_id,
    AVG(p.unit_cost ) AS average_unit_cost,
    AVG(p.selling_price) AS average_selling_price
FROM products p 
GROUP BY product_name, product_id
ORDER BY average_selling_price DESC
LIMIT 10;


--
--
CATEGORY PROFITABILITY

-- Channel sales

SELECT 
    channel,
    SUM(gross_revenue) AS total_sales
FROM orders
WHERE gross_revenue IS NOT NULL
GROUP BY channel
ORDER BY total_sales DESC;


-- sales channel performance 

SELECT 
    channel,
    COUNT(order_id) AS total_orders,
    SUM(items_ordered) AS total_units_sold,
    ROUND(SUM(profit), 2) AS total_net_profit,
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS net_profit_margin_pct
FROM orders
WHERE profit IS NOT NULL
GROUP BY channel
ORDER BY total_net_profit DESC;


-- channel operational cost leakage

SELECT 
    channel,
    SUM(net_revenue) AS total_net_revenue,
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS net_profit_margin_pct, -- 1. TARGET METRIC: Net Profit Margin
    ROUND((SUM(product_cost) / SUM(net_revenue)) * 100, 2) AS product_cost_driver_pct,  -- 2. COST DRIVERS (Expressed as a % of Net Revenue)
    ROUND((SUM(shipping_cost) / SUM(net_revenue)) * 100, 2) AS shipping_cost_driver_pct,
    ROUND((SUM(platform_fee) / SUM(net_revenue)) * 100, 2) AS platform_fee_driver_pct,
    ROUND((SUM(transaction_fee) / SUM(net_revenue)) * 100, 2) AS transaction_fee_driver_pct   
FROM orders 
GROUP BY channel
HAVING SUM(net_revenue) > 0 AND SUM(gross_revenue) > 0
ORDER BY net_profit_margin_pct DESC;



--
-- 

MARKETING SPEND ANALYSIS

-- Marketing ROAS vs Actual ROI
-- To determine if marketing is actually driving profit

WITH monthly_marketing AS (    
    SELECT 
        year_month,
        SUM(spend) AS total_marketing_spend,
        SUM(revenue_attributed) AS platform_reported_revenue
    FROM marketing_spend
    GROUP BY year_month
),
monthly_orders AS (
    -- Formatting order_date to match marketing's YYYY-MM structure
    SELECT 
        strftime('%Y-%m', order_date) AS order_month, 
        SUM(gross_revenue) AS actual_gross_revenue,
        SUM(net_revenue) AS actual_net_revenue,
        SUM(profit) AS actual_order_profit
    FROM orders
    GROUP BY strftime('%Y-%m', order_date)
)
SELECT 
    m.year_month,
    m.total_marketing_spend,
    o.actual_net_revenue,
    o.actual_order_profit,
    -- Blended ROI calculation (Profit after marketing spend)
    (o.actual_order_profit - m.total_marketing_spend) AS business_net_profit
FROM monthly_marketing m
JOIN monthly_orders o 
    ON m.year_month = o.order_month
ORDER BY m.year_month ASC;


-- Marketing attribution and channel audit
-- To break down that $503K spend by specific platform

SELECT 
    year,
    platform,
    SUM(spend) AS annual_platform_spend,
    ROUND(SUM(revenue_attributed), 2) AS platform_reported_revenue,
    ROUND((SUM(revenue_attributed) / SUM(spend)),2) AS platform_reported_roas
FROM marketing_spend
GROUP BY year, platform
ORDER BY year ASC, annual_platform_spend DESC;


-- ROAS, cost per acquisition, and cost per click by platform
-- To identify which platforms are underperforming.

SELECT 
	year,
    platform,
    ROUND(AVG(roas),2) AS avg_return_on_ad_spend,
    ROUND(AVG(cpa), 2) AS avg_cost_per_acquisition,
    ROUND(AVG(cpc),2) AS avg_cost_per_click
FROM marketing_spend
GROUP BY year, platform
ORDER BY year ASC, avg_return_on_ad_spend DESC;


-- Total impressions, clicks and conversions by platform
-- To determine brand awareness, platform traffic, growth/revenue opportunities 

SELECT 
	year_month,
    platform,
    ROUND(SUM(impressions),2) AS total_impressions,
    ROUND(SUM(clicks), 2) AS total_clicks,
    ROUND(SUM(conversions),2) AS total_conversions
FROM marketing_spend
GROUP BY year_month, platform
ORDER BY year_month ASC, total_conversions DESC;


-- Digital marketing metrics performance by platform and year
-- To identify which platforms are underperfoming in the various metrics

SELECT 
    year,
    platform,
    ROUND((SUM(clicks) * 100.0 / SUM(impressions)), 2) AS click_through_rate,
    ROUND((SUM(conversions) * 100.0 / SUM(clicks)), 2) AS conversion_rate,
    ROUND((SUM(spend) / SUM(clicks)), 2) AS cost_per_click,
    ROUND((SUM(spend) / SUM(conversions)), 2) AS cost_per_acquisition,
    ROUND((SUM(spend) / SUM(impressions) * 1000), 2) AS cost_per_mille 
FROM marketing_spend
GROUP BY year, platform
ORDER BY year ASC, cost_per_mille DESC;


-- PAYMENT METHOD ANALYSIS
-- payment method operational performance

SELECT 
    payment_method,
    SUM(gross_revenue) AS total_sales
FROM orders
WHERE gross_revenue IS NOT NULL
GROUP BY payment_method
ORDER BY total_sales DESC;


-- Payment method operational cost and revenue leakage

SELECT 
    payment_method,
    ROUND((SUM(profit) / SUM(net_revenue)) * 100, 2) AS net_profit_margin_pct,
    ROUND((SUM(transaction_fee) / SUM(net_revenue)) * 100, 2) AS transaction_fee_driver_pct,  
    ROUND((SUM(discount_amount) / SUM(gross_revenue)) * 100, 2) AS discount_impact_pct, 
    ROUND((SUM(refund_amount) / SUM(gross_revenue)) * 100, 2) AS refund_impact_pct 
FROM orders o 
WHERE payment_method IS NOT NULL
GROUP BY payment_method
ORDER BY net_profit_margin_pct DESC;

--
--
--SUPPLIER ANALYSIS
-- Calculate supplier's unit cost and shipping cost per unit by supplier
-- To determine the supplier with the lowest unit cost and shipping cost per unit

SELECT 
    supplier,
    COUNT(product_id) AS total_products,
    ROUND(AVG(weight_lbs), 2) AS avg_weight,
    ROUND(AVG(unit_cost ), 2) AS avg_unit_cost,
    ROUND(AVG(shipping_cost_per_unit ), 2) AS avg_shipping_cost_per_unit
FROM products 
GROUP BY supplier 
ORDER BY avg_shipping_cost_per_unit DESC;



--
-- 
- quantities ordered across each supplier and region
To analyze whether the average logistics costs and weights are tied to the volume of customer demand or regional distribution

WITH SupplierRegionQuantity AS (
    SELECT 
        p.supplier,
        o.region,
        SUM(o.items_ordered) AS total_quantity_ordered,
        ROUND(AVG(p.shipping_cost_per_unit), 2) AS avg_shipping_cost_per_unit,
        ROUND(AVG(p.weight_lbs), 2) AS avg_weight
    FROM orders o
    JOIN products p ON o.primary_category = p.category
    GROUP BY p.supplier, o.region
)
SELECT 
    supplier,
    region,
    total_quantity_ordered,
    avg_shipping_cost_per_unit,
    avg_weight
FROM SupplierRegionQuantity
WHERE region IS NOT NULL
ORDER BY supplier, total_quantity_ordered DESC;