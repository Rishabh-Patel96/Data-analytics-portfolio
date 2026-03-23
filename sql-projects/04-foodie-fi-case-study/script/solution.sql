SELECT *
FROM subscriptions;
SELECT *
FROM plans;

/*
----------------------------------------------------------------------------Section A: Customer Journey-------------------------------------------------------------------
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.
Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!*/
SELECT s.customer_id,
       s.plan_id,
       s.start_date,
       p.plan_name,
       p.price
FROM subscriptions AS s
INNER JOIN plans AS p
ON s.plan_id = p.plan_id
WHERE s.customer_id <= 8
ORDER BY s.customer_id, s.start_date;

Customer Journeys:

Customer 1 started with a free trial and converted to a basic monthly plan after the trial period, showing initial engagement with the service.
Customer 2 began with a trial and directly upgraded to a pro annual plan, indicating strong early commitment and high conversion value.
Customer 3 started with a trial and converted to a basic monthly plan, following a standard onboarding path without further upgrades.
Customer 4 converted from trial to a basic monthly plan but later churned, indicating initial adoption but lack of long-term retention.
Customer 5 followed a typical journey by converting from trial to a basic monthly plan and continuing without any upgrades or churn within the observed period.
Customer 6 converted to a basic monthly plan after the trial but eventually churned, suggesting short-term engagement without sustained retention.
Customer 7 began with a trial, converted to a basic monthly plan, and later upgraded to a pro monthly plan, indicating increasing engagement and value over time.
Customer 8 followed a similar path by converting from trial to a basic monthly plan and then upgrading to a pro monthly plan, showing progressive adoption of higher-tier services.

🔍 Overall Observation
Most customers follow a standard journey of transitioning from trial to a basic monthly plan, with some customers either upgrading to higher-tier plans or churning after initial usage. This highlights a typical conversion funnel with opportunities for improving long-term retention.

--------------------------------------------------------------------------Section B: Data Analysis Questions------------------------------------------------------------------
--1) How many customers has Foodie-Fi ever had?
SELECT
    COUNT (DISTINCT customer_id) AS total_customers
FROM subscriptions;

--2) What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
SELECT
    DATE_TRUNC('Month', start_date)::DATE AS month,
    COUNT(*) AS trail_count
FROM subscriptions AS s
INNER JOIN plans AS p
ON s.plan_id = p.plan_id
WHERE p.plan_name = 'trial'
GROUP by DATE_TRUNC('Month', start_date)
ORDER BY month ASC;

--3) What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
SELECT
     p.plan_name,
    COUNT(*) event_count
FROM subscriptions AS s
INNER JOIN plans AS p
ON s.plan_id = p.plan_id
WHERE start_date >= '2021-01-01'
GROUP BY p.plan_name
ORDER BY p.plan_name ASC;

--4) What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
SELECT
    total_customers,
    churned_customers,
    ROUND(churned_customers * 100.0 / total_customers, 2) AS churn_percentage
FROM  (SELECT
            COUNT(DISTINCT s.customer_id) AS total_customers,
      (SELECT
            COUNT(DISTINCT s.customer_id)
        FROM subscriptions AS s
        INNER JOIN plans AS p
        ON s.plan_id = p.plan_id
        WHERE p.plan_name = 'churn') AS churned_customers
        FROM subscriptions AS s
      )t;
--------------------ALTERNATIVE SOLUTION-------------------------------

WITH total AS (
    SELECT COUNT(DISTINCT customer_id) AS total_customers
    FROM subscriptions
),
churned AS (
    SELECT COUNT(DISTINCT s.customer_id) AS churned_customers
    FROM subscriptions AS s
    JOIN plans AS p
    ON s.plan_id = p.plan_id
    WHERE p.plan_name = 'churn'
)

SELECT
    t.total_customers,
    c.churned_customers,
    ROUND(c.churned_customers * 100.0 / t.total_customers, 2) AS churn_percentage
FROM total AS t , churned AS c ;

--5) How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
SELECT
    total_customers,
    churned_after_trial,
    ROUND(churned_after_trial * 100.0 / total_customers, 0) AS churn_percentage
FROM (
        SELECT
            COUNT(DISTINCT s.customer_id) AS total_customers,

        (SELECT
           COUNT(DISTINCT customer_id)
          FROM (
                 SELECT
                    s2.customer_id,
                    p2.plan_name,
                    LEAD(p2.plan_name) OVER (PARTITION BY s2.customer_id ORDER BY s2.start_date) AS next_plan
                 FROM subscriptions s2
                 JOIN plans p2
                 ON s2.plan_id = p2.plan_id) x
                 WHERE plan_name = 'trial' AND next_plan = 'churn'
            ) AS churned_after_trial

        FROM subscriptions s
     ) t;

--6) What is the number and percentage of customer plans after their initial free trial?
SELECT
    next_plan,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(COUNT(DISTINCT customer_id) * 100.0 /
           (SELECT
                COUNT(DISTINCT s.customer_id)
            FROM subscriptions AS s
            INNER JOIN plans AS p
            ON s.plan_id = p.plan_id
            WHERE p.plan_name = 'trial'), 2
          ) AS percentage
FROM (
        SELECT
            s.customer_id,
            p.plan_name,
            LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) AS next_plan
        FROM subscriptions AS s
        INNER JOIN plans AS p
        ON s.plan_id = p.plan_id ) AS t
WHERE plan_name = 'trial'
GROUP BY next_plan;

--7) What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
SELECT
    plan_name,
    COUNT(customer_id) AS customer_count,
    ROUND(COUNT(customer_id) * 100.0 /
          (SELECT COUNT(DISTINCT customer_id) FROM subscriptions), 2) AS percentage
FROM (
        SELECT
            s.customer_id,
            p.plan_name,
            ROW_NUMBER() OVER (
                PARTITION BY s.customer_id
                ORDER BY s.start_date DESC
            ) AS rn
        FROM subscriptions s
        JOIN plans p
            ON s.plan_id = p.plan_id
        WHERE s.start_date <= '2020-12-31'
     ) t
WHERE rn = 1
GROUP BY plan_name
ORDER BY plan_name;

--8) How many customers have upgraded to an annual plan in 2020?
SELECT
    COUNT(DISTINCT s.customer_id) AS annual_customers
FROM subscriptions s
JOIN plans p
    ON s.plan_id = p.plan_id
WHERE p.plan_name = 'pro annual';

--9) How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
SELECT
    ROUND(AVG(annual_date - join_date), 2) AS avg_days_to_annual
FROM (
        SELECT
            customer_id,
            MIN(start_date) AS join_date,
            MIN(CASE WHEN p.plan_name = 'pro annual' THEN start_date END) AS annual_date
        FROM subscriptions s
        JOIN plans p
            ON s.plan_id = p.plan_id
        GROUP BY customer_id
     ) t
WHERE annual_date IS NOT NULL;

--10) Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
SELECT
    CASE
        WHEN days_to_annual <= 30 THEN '0-30 days'
        WHEN days_to_annual <= 60 THEN '31-60 days'
        WHEN days_to_annual <= 90 THEN '61-90 days'
        WHEN days_to_annual <= 120 THEN '91-120 days'
        ELSE '120+ days'
    END AS time_bucket,
    COUNT(customer_id) AS customer_count
FROM (
        SELECT
            customer_id,
            MIN(start_date) AS join_date,
            MIN(CASE WHEN p.plan_name = 'pro annual' THEN start_date END) AS annual_date,
            MIN(CASE WHEN p.plan_name = 'pro annual' THEN start_date END) - MIN(start_date) AS days_to_annual
        FROM subscriptions s
        JOIN plans p
            ON s.plan_id = p.plan_id
        GROUP BY customer_id
     ) t
WHERE annual_date IS NOT NULL
GROUP BY time_bucket
ORDER BY time_bucket;

--11) How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
SELECT
    COUNT(DISTINCT customer_id) AS downgraded_customers
FROM (
        SELECT
            s.customer_id,
            p.plan_name,
            s.start_date,
            LEAD(p.plan_name) OVER (
                PARTITION BY s.customer_id
                ORDER BY s.start_date
            ) AS next_plan
        FROM subscriptions s
        JOIN plans p
            ON s.plan_id = p.plan_id
     ) t
WHERE plan_name = 'pro monthly'
  AND next_plan = 'basic monthly'
  AND start_date BETWEEN '2020-01-01' AND '2020-12-31';