# Pizza Runner SQL Case Study

## Project Overview

This project analyzes customer orders, runner deliveries, and pizza performance for **Pizza Runner** using SQL.

The main focus of this case study is to clean messy operational data and use it to answer high-value business questions related to order volume, successful deliveries, customer ordering behavior, and early runner performance metrics.

The project emphasizes practical SQL skills such as data cleaning, reusable view creation, business-rule filtering, aggregation, joins, and time-based analysis.

---

## Problem Statement

Danny launched **Pizza Runner**, a pizza delivery business where customers place pizza orders through an app and runners handle deliveries.

As the business started generating data, Danny wanted to better understand customer demand, delivery outcomes, pizza performance, and runner activity. However, the raw operational data contains inconsistent text values, blank fields, and mixed formatting in important columns such as exclusions, extras, pickup time, distance, duration, and cancellation status.

To support reliable analysis, the data first needed to be cleaned and standardized before calculating business metrics.

This project focuses on building that cleaned analytical layer and using it to answer selected operational questions from the case study.

---

## Project Focus

This case study centers on two main goals:

### 1. Building clean analytical views
Reusable SQL views were created to standardize the raw order and runner data before analysis.

### 2. Answering key operational business questions
The analysis focuses on core Pizza Metrics questions and selected Runner & Customer Experience questions that are especially useful for interview preparation and portfolio presentation.

---

## Business Questions Covered

### Data Exploration
- reviewed all source tables:
  - `runners`
  - `customer_orders`
  - `runner_orders`
  - `pizza_names`
  - `pizza_recipes`
  - `pizza_toppings`

### Data Cleaning
- created `clean_customer_orders` view
- created `clean_runner_orders` view

### A. Pizza Metrics
The following questions were solved:

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
The following questions were solved:

1. How many runners signed up for each 1 week period? (week starts 2021-01-01)
2. What was the average time in minutes it took for each runner to arrive at Pizza Runner HQ to pick up the order?

### Additional Areas in the Original Case Study
The full Pizza Runner challenge also includes additional runner analysis, ingredient optimization, pricing, and ratings-related questions. This project is intentionally centered on the core operational analysis and cleaned data foundation represented in the current SQL scripts.

---

## Dataset

The project uses six tables from the `pizza_runner` schema:

- **customer_orders** – customer pizza order records, including exclusions and extras
- **runner_orders** – runner delivery information, including pickup time, distance, duration, and cancellation status
- **runners** – runner registration details
- **pizza_names** – mapping of pizza IDs to pizza names
- **pizza_recipes** – standard toppings assigned to each pizza
- **pizza_toppings** – mapping of topping IDs to topping names

---

## Data Cleaning Approach

Before solving the business questions, the raw source tables were cleaned and standardized using SQL views.

### `clean_customer_orders`
This view standardizes the `exclusions` and `extras` columns by:

- trimming whitespace
- converting text-based `'null'` values into actual `NULL`
- converting blank strings into actual `NULL`

### `clean_runner_orders`
This view standardizes delivery-related columns by:

- converting text-based `'null'` values into actual `NULL`
- casting `pickup_time` into `TIMESTAMP`
- removing `'km'` from `distance` and converting it to numeric
- extracting numeric values from `duration` and storing them as minutes
- standardizing `cancellation` values

These cleaning views make the downstream analysis simpler, more reusable, and more reliable.

---

## SQL Techniques Used

This project demonstrates:

- data cleaning using `NULLIF`, `TRIM`, `REPLACE`, `CASE`, and casting
- handling inconsistent text values such as `'null'`, blank strings, and mixed formatting
- creating reusable SQL views
- joins between transactional and lookup tables
- aggregations using `COUNT` and `AVG`
- `GROUP BY` analysis
- filtering successful deliveries using cancellation logic
- date and time analysis using `EXTRACT`
- timestamp difference calculation
- numeric parsing using `REGEXP_REPLACE`
- careful handling of order-level vs pizza-level grain

---

## Key Learning Outcomes

This project strengthened practical SQL skills in:

- cleaning messy operational data before analysis
- converting string-based fields into analysis-ready formats
- defining successful delivery logic clearly
- working with the correct table grain while joining datasets
- avoiding counting errors when moving between order-level and pizza-level questions
- calculating time-based metrics from order and pickup timestamps
- writing SQL that is both interview-relevant and easy to explain

---

## Portfolio Context

This project is part of my broader **8 Week SQL Challenge** portfolio.

Within that portfolio, Pizza Runner serves as a strong operational SQL case study focused on:

- messy data cleaning
- delivery logic
- pizza-level and order-level metrics
- customer and runner performance analysis

It complements the other case studies by showcasing SQL work on more realistic operational data rather than only clean transactional data.