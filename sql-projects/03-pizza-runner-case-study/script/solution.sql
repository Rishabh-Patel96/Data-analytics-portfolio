
SELECT * FROM runners;
SELECT * FROM customer_orders;
SELECT * FROM runner_orders;
SELECT * FROM pizza_names;
SELECT * FROM pizza_recipes;
SELECT * FROM pizza_toppings;

CREATE OR REPLACE VIEW clean_customer_orders AS
SELECT
    order_id,
    customer_id,
    pizza_id,
    NULLIF(NULLIF(TRIM(exclusions), 'null'), '') AS exclusions,
    NULLIF(NULLIF(TRIM(extras), 'null'), '') AS extras,
    order_time
FROM customer_orders;

CREATE OR REPLACE VIEW clean_runner_orders AS
SELECT
    order_id,
    runner_id,
    NULLIF(TRIM(pickup_time), 'null')::TIMESTAMP AS pickup_time,
    CAST(REPLACE(NULLIF(TRIM(distance), 'null'), 'km', '') AS NUMERIC) AS distance,
    CAST(REGEXP_REPLACE(NULLIF(TRIM(duration), 'null'), '[^0-9]', '', 'g') AS INTEGER) AS duration_minutes,
    NULLIF(NULLIF(TRIM(cancellation), 'null'), '') AS cancellation
FROM runner_orders;

SELECT * FROM pizza_runner.clean_customer_orders;
SELECT * FROM pizza_runner.clean_runner_orders;

---------------------------------Section A: Pizza Metrics-----------------------------------------------

--1) How many pizzas were ordered?
SELECT
    COUNT(*) AS number_ordered_pizzas
FROM clean_customer_orders;

--2) How many unique customer orders were made?
SELECT
    COUNT(DISTINCT order_id) AS unique_orders
FROM pizza_runner.clean_customer_orders;

--3) How many successful orders were delivered by each runner?
SELECT
    runner_id,
    COUNT(order_id) AS successful_deliveries
FROM pizza_runner.clean_runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;

--4) How many of each type of pizza was delivered?
SELECT
    c.pizza_id,
    COUNT(c.pizza_id) AS types_ofpizza_delivered
FROM pizza_runner.clean_runner_orders AS r
LEFT JOIN pizza_runner.clean_customer_orders AS c
ON r.order_id = c.order_id
WHERE r.cancellation IS NULL
GROUP BY c.pizza_id;

--5) How many Vegetarian and Meatlovers were ordered by each customer?
SELECT
    c.customer_id,
    p.pizza_name,
    COUNT(c.order_id) AS pizzas_ordered
FROM pizza_runner.clean_customer_orders AS c
LEFT join pizza_names AS p
ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id, p.pizza_name
ORDER BY c.customer_id, pizza_name;

--6) What was the maximum number of pizzas delivered in a single order?
SELECT
    t.order_id,
    t.pizza_count AS maximum_pizza_delivered
FROM (
       SELECT
       c.order_id,
       COUNT(*) AS pizza_count
       FROM pizza_runner.clean_customer_orders AS c
       INNER JOIN pizza_runner.clean_runner_orders AS r
       ON c.order_id = r.order_id
       WHERE r.cancellation IS NULL
       GROUP BY c.order_id
     ) AS t
ORDER BY t.pizza_count DESC
LIMIT 1;

--7) For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT
    c.customer_id,
    SUM(
         CASE
         WHEN c.exclusions IS NOT NULL OR c.extras IS NOT NULL THEN 1
         ELSE 0
         END
       ) AS  pizzas_with_changes,
    SUM(
         CASE
         WHEN c.exclusions IS NULL AND c.extras IS NULL THEN 1
         ELSE 0
         END
       ) AS  pizzas_unchanged
FROM pizza_runner.clean_customer_orders AS c
JOIN pizza_runner.clean_runner_orders r
ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id
ORDER BY c.customer_id;

--8) How many pizzas were delivered that had both exclusions and extras?
SELECT
    SUM(
        CASE
        WHEN c.exclusions IS NOT NULL AND c.extras IS NOT NULL THEN 1
        ELSE 0
        END
       ) AS  pizzaswith_exclusions_andextras
FROM pizza_runner.clean_customer_orders AS c
JOIN pizza_runner.clean_runner_orders r
ON c.order_id = r.order_id
WHERE r.cancellation IS NULL;

--9) What was the total volume of pizzas ordered for each hour of the day?
SELECT
    EXTRACT(HOUR FROM order_time) AS order_hour,
    COUNT(*) AS total_pizzas_ordered
FROM pizza_runner.clean_customer_orders
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY order_hour;

--10)What was the volume of orders for each day of the week?
SELECT
    EXTRACT(DOW FROM order_time) AS day_of_week,
    COUNT(*) AS total_pizzas_ordered
FROM pizza_runner.clean_customer_orders
GROUP BY EXTRACT(DOW FROM order_time)
ORDER BY day_of_week;

--11) How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT
    DATE '2021-01-01'
      + (FLOOR((registration_date - DATE '2021-01-01') / 7) * 7)::INTEGER AS week_start,
    COUNT(*) AS runners_signed_up
FROM pizza_runner.runners
GROUP BY week_start
ORDER BY week_start;

--12) What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT
    r.runner_id,
    AVG(EXTRACT(EPOCH FROM (r.pickup_time - c.order_time)) / 60) AS avg_pickup_time_minutes
FROM pizza_runner.clean_runner_orders AS r
JOIN (
    SELECT
        order_id,
        MIN(order_time) AS order_time
    FROM pizza_runner.clean_customer_orders
    GROUP BY order_id
) AS c
    ON r.order_id = c.order_id
WHERE r.pickup_time IS NOT NULL
GROUP BY r.runner_id
ORDER BY r.runner_id;






