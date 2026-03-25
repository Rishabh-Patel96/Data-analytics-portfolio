-- Main table
select * from pareto_project.Sales;

-- Sales = Quantity * UnitPrice
-- CustomerID, sales
-- View 1
create or replace view pareto_project.Sales_V1 as
select
    CustomerID,
    (Quantity * UnitPrice) as sales
from pareto_project.Sales;

-- GROUP BY customers, sales for each customer in one row of data
-- View 2
create or replace view pareto_project.Sales_V2 as
select
    CustomerID,
    sum(sales) as customer_revenue
from pareto_project.Sales_V1
group by CustomerID;

-- CustomerID, customer_revenue, cum_customers, total_customers, cum_revenue, total_revenue
-- View 3
create or replace view pareto_project.Sales_V3 as
select
    CustomerID,
    customer_revenue,
    row_number() over(order by customer_revenue desc) as cum_customers,
    count(*) over() as total_customers,
    sum(customer_revenue) over(order by customer_revenue desc rows between unbounded preceding and current row) as cum_revenue,
    sum(customer_revenue) over() as total_revenue
from pareto_project.Sales_V2;

-- CustomerID, customer_revenue, cum_customers, total_customers, cum_revenue, total_revenue
-- + cum_sales_share, cum_pct_customers
-- View 4
create or replace view pareto_project.Sales_V4 as
select
    CustomerID,
    customer_revenue,
    cum_customers,
    total_customers,
    cum_revenue,
    total_revenue,
    cum_revenue / total_revenue AS cum_sales_share,
    cum_customers / total_customers AS cum_pct_customers
from pareto_project.Sales_V3;

-- declare variable
declare target_sales_pct float64 default 0.80;

-- number_of_customers, cum_revenue, total_revenue, target_sales_percent,
-- target_sales, cum_sales_share, cum_pct_customers
SELECT
    MIN(cum_customers) AS number_of_customers,
    MIN(total_customers) AS total_customers,
    MIN(cum_revenue) AS cum_revenue,
    MIN(total_revenue) AS total_revenue,
    target_sales_pct * 100 AS target_sales_percent,
    MIN(total_revenue * target_sales_pct) AS target_sales,
    MIN(cum_sales_share) AS cum_sales_share,
    MIN(cum_pct_customers) AS cum_pct_customers
FROM pareto_project.Sales_V4
WHERE cum_sales_share >= target_sales_pct;