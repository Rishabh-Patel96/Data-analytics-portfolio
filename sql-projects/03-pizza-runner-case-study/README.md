# Pizza Runner SQL Case Study

## Project Overview

This project analyzes customer orders, runner deliveries, and pizza performance for **Pizza Runner** using SQL.

The objective of this case study is to clean messy operational data, evaluate delivery activity, and generate business insights related to customer ordering patterns, runner performance, and pizza-level metrics.

This project demonstrates practical SQL skills used in data cleaning, operational analysis, and business intelligence workflows.

---

## Problem Statement

Danny launched **Pizza Runner**, a pizza delivery business where customer orders are placed through an app and delivered by runners.

As the business started generating data, Danny wanted to use it to better understand customer demand, delivery success, runner activity, and pizza customization patterns.

However, some of the raw data contains inconsistencies and missing values, so the first step is to clean and standardize the datasets before performing analysis.

This case study focuses on helping Danny answer key operational and customer-related questions using SQL.

---

## Business Questions

The analysis answers the following questions:

### A. Pizza Metrics
1. How many pizzas were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each runner?
4. How many of each type of pizza was delivered?
5. How many Vegetarian and Meatlovers were ordered by each customer?
6. What was the maximum number of pizzas delivered in a single order?
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?

### B. Runner and Customer Experience
1. How many runners signed up for each 1 week period? (week starts 2021-01-01)
2. What was the average time in minutes it took for each runner to arrive at Pizza Runner HQ to pick up the order?
3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
4. What was the average distance travelled for each customer?
5. What was the difference between the longest and shortest delivery times for all orders?
6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
7. What is the successful delivery percentage for each runner?

### C. Ingredient Optimisation
1. What are the standard ingredients for each pizza?
2. What was the most commonly added extra?
3. What was the most common exclusion?
4. Generate an order item for each record in the `customer_orders` table in the format:
   - `Meat Lovers`
   - `Meat Lovers - Exclude Beef`
   - `Meat Lovers - Extra Bacon`
   - `Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers`
5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the `customer_orders` table and add a `2x` in front of any relevant ingredients.
   - For example: `Meat Lovers: 2xBacon, Beef, ...`
6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

### D. Pricing and Ratings
1. If a Meat Lovers pizza costs \$12 and Vegetarian costs \$10 and there were no delivery fees, how much money has Pizza Runner made so far if there are no extras?
2. What if there was an additional \$1 charge for any pizza extras?
   - Add cheese is \$1 extra
3. The Pizza Runner team now wants to add an additional ratings table so that customers can rate their runner. Generate a schema and insert data for this new table.
4. Using your new table, calculate:
   - customer ID
   - order ID
   - runner ID
   - rating
   - order time
   - pickup time
   - time between order and pickup
   - delivery duration
   - average speed
   - total number of pizzas
5. If a Meat Lovers pizza was \$12 and Vegetarian \$10, and there was a \$0.30 per kilometre payment to runners, how much money does Pizza Runner have left over after these deliveries?

---

## Dataset

The project uses six tables from the `pizza_runner` schema:

- **customer_orders** – customer-level pizza orders including exclusions and extras
- **runner_orders** – runner delivery information including pickup time, distance, duration, and cancellation status
- **runners** – runner registration details
- **pizza_names** – mapping of pizza IDs to pizza names
- **pizza_recipes** – standard toppings assigned to each pizza
- **pizza_toppings** – mapping of topping IDs to topping names

---

## SQL Techniques Used

This project demonstrates:

- Data cleaning using `NULLIF`, `CASE`, and casting
- Handling inconsistent text values such as `'null'`, blank strings, and missing values
- Aggregations (`COUNT`, `SUM`, `AVG`)
- `GROUP BY` analysis
- Joins between relational tables
- Date and time analysis
- Conditional logic
- String parsing and transformation
- Creating clean views for reusable analysis
- Business metric calculation for operational reporting

---