UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

Alter table pizza_sales
Modify Column order_date DATE;

Alter table pizza_sales
Modify Column order_time TIME;

describe pizza_sales;

-- Total Revenue:
select sum(total_price) as total_revenue
from pizza_sales;

--  Average Order Value:
select (sum(total_price)/count(distinct order_id)) as avg_order_value
from pizza_sales;

-- Total Pizzas Sold:
select sum(quantity) as total_pizza_sold
from pizza_sales;

-- Total Orders:
select count(distinct order_id) as total_orders
from pizza_sales;

-- Average Pizzas Per Order:
select (sum(quantity)/count(distinct order_id)) as avg_pizza_order
from pizza_sales;

--  Daily Trend for Total Orders:
select dayname(order_date) as Day, count(distinct order_id) as total_orders
from pizza_sales
group by 1;

-- Hourly Trend for Orders
select hour(order_time) as hour, count(distinct order_id) as total_orders
from pizza_sales
group by 1;

-- % of Sales by Pizza Category
select pizza_category, round(sum(total_price),2) as total_revenue, round((sum(total_price)/( select sum(total_price) from pizza_sales))*100,2) as PCT
from pizza_sales
group by 1;

-- % of Sales by Pizza Size
select pizza_size, round(sum(total_price),2) as total_revenue, round((sum(total_price)/( select sum(total_price) from pizza_sales))*100,2) as PCT
from pizza_sales
group by 1;

-- Total Pizzas Sold by Pizza Category
select pizza_category, sum(quantity) as pizza_sold
from pizza_sales
group by 1;

--  Top 5 Best Sellers by Total Pizzas Sold
select pizza_name, sum(quantity) as pizza_sold
from pizza_sales
group by 1
order by 2 DESC
limit 5;

-- Bottom 5 Best Sellers by Total Pizzas Sold
select pizza_name, sum(quantity) as pizza_sold
from pizza_sales
group by 1
order by 2 ASC
limit 5;

