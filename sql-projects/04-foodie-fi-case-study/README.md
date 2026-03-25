# Foodie-Fi SQL Case Study

## Project Overview

This project analyzes customer subscriptions, plan transitions, and lifecycle behavior for **Foodie-Fi**, a subscription-based streaming service, using SQL.

The objective of this case study is to understand how customers move through different subscription plans over time and to generate insights related to conversion, churn, and customer retention.

This project focuses on analyzing event-based data to track customer journeys and extract meaningful business insights from subscription activity.

---

## Problem Statement

Foodie-Fi is a streaming platform that offers multiple subscription plans, including trial, monthly, annual, and churn.

As the platform grows, the business wants to understand how customers transition between plans, how long they stay, and how many eventually churn.

The dataset captures subscription events over time, but meaningful insights require correctly interpreting customer journeys across multiple plan changes.

This project focuses on transforming subscription event data into actionable business insights related to growth, retention, and user behavior.

---

## Analysis Scope

This case study covers end-to-end analysis of the Foodie-Fi dataset, with emphasis on:

- understanding the structure and grain of subscription data
- tracking customer plan transitions over time
- identifying initial customer entry points (trial behavior)
- analyzing conversion from trial to paid plans
- evaluating churn behavior and customer drop-off
- measuring time-based metrics such as time to conversion
- analyzing plan distribution across different time periods
- deriving customer-level insights from event-level data

The analysis is performed completely from start to finish, covering all major sections of the case study.

---

## Dataset

The project uses the following tables:

- **subscriptions** – records of customer plan changes over time
- **plans** – details of each subscription plan (plan name, pricing, etc.)

### Data Characteristics

- event-based dataset (multiple rows per customer)
- each row represents a plan start event
- customers can transition across multiple plans over time
- time is a critical dimension for analysis

---

## Analytical Approach

The analysis follows a structured approach:

### 1. Data Understanding
- exploring subscription events and plan definitions
- identifying table grain and relationships

### 2. Customer Lifecycle Analysis
- identifying each customer’s first plan
- tracking plan transitions over time
- analyzing conversion behavior

### 3. Time-Based Analysis
- grouping subscription activity by month and year
- calculating time differences between plan changes
- evaluating conversion timelines

### 4. Retention and Churn Analysis
- identifying churned customers
- calculating churn rates
- analyzing when churn occurs in the lifecycle

### 5. Plan Distribution Analysis
- understanding how customers are distributed across plans
- analyzing plan composition at different points in time

---

## SQL Techniques Used

This project demonstrates:

- joins between event and lookup tables
- aggregations using `COUNT`, `SUM`, and `AVG`
- `GROUP BY` for customer-level and time-based analysis
- date filtering and extraction
- window functions such as `ROW_NUMBER`, `LEAD`, and `LAG`
- identifying first and latest events per customer
- calculating time differences between events
- conditional logic using `CASE`
- working with event-level vs customer-level grain

---

## Key Learning Outcomes

This case study strengthened practical SQL skills in:

- working with event-based datasets
- tracking customer journeys across multiple records
- distinguishing between event-level and customer-level analysis
- analyzing conversion funnels and lifecycle transitions
- calculating time-to-conversion metrics
- interpreting churn and retention patterns
- writing SQL that is both analytically correct and business-relevant

---

## Portfolio Context

This project is part of my broader **8 Week SQL Challenge** portfolio.

Within that portfolio, Foodie-Fi represents a complete end-to-end SQL case study focused on:

- subscription analytics
- customer lifecycle tracking
- conversion and churn analysis
- time-based business insights

It builds on previous case studies by moving from transactional and operational analysis to more advanced customer lifecycle and retention-focused analytics.

## 📈 Business Recommendations

* Improve trial-to-paid conversion through targeted onboarding strategies.
* Identify early churn signals and implement retention campaigns.
* Optimize pricing and plan offerings based on customer transition patterns.
* Encourage annual subscriptions to improve long-term revenue stability.
* Track customer lifecycle stages to design personalized engagement strategies.
