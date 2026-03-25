# 🚀 Advanced Pareto Analysis using SQL on Cloud Data Warehouse

## 📌 Project Overview

This project performs an **Advanced Pareto Analysis (80/20 rule)** on transactional sales data using SQL on a **cloud data warehouse (Google BigQuery)**.

The objective is to analyze customer contribution and identify how revenue is distributed across customers.

---

## 🧠 Business Problem

In most businesses, a small percentage of customers contribute to a large portion of total revenue.

This project answers:

> *“What proportion of customers contributes to 80% of total revenue?”*

---

## 🛠️ Tech Stack

* Google BigQuery (Cloud Data Warehouse)
* PostgreSQL (Query development & Analytical SQL)
* DataGrip (IDE)

---

## ⚙️ Key Concepts Used

* Window Functions (`ROW_NUMBER`, `SUM OVER`, `COUNT OVER`)
* Cumulative Calculations
* Ranking & Ordering
* Data Aggregation
* Parameterization using variables
* View-based and CTE-based modeling

---

## 🔄 Approach 1: Layered Views

* Built a transformation pipeline using SQL views:

  * Revenue calculation
  * Customer-level aggregation
  * Ranking customers by contribution
  * Cumulative revenue computation
  * Percentage contribution metrics

---

## 🔄 Approach 2: CTE Pipeline

* Re-implemented the same logic using Common Table Expressions (CTEs)
* Demonstrates modular query design and readability
* Highlights alternative ways to structure analytical SQL workflows

---

## 📊 Key Metrics Computed

* Revenue per Customer
* Total Revenue
* Cumulative Revenue
* Total Customers
* Cumulative Customer Count
* Revenue Contribution (%)
* Customer Contribution (%)

---

## 🎯 Final Outcome

* Identified the **minimum number of customers required to reach 80% of total revenue**
* Quantified:

  * Revenue concentration
  * Customer distribution across revenue tiers

---

## 💡 Key Insights

* Revenue distribution is highly skewed, with a small subset of customers contributing a disproportionate share of total revenue
* The Pareto principle (80/20 rule) is validated within the dataset
* Customer ranking combined with cumulative metrics provides a clear method to identify high-value segments
* Analytical SQL can be used to derive business-critical insights directly within a cloud data warehouse environment

💡 Insight 1: Revenue Concentration

A small percentage of customers contribute a disproportionately large share of total revenue. In this analysis, approximately the top X% of customers account for nearly 80% of total sales, validating the Pareto principle. This highlights the importance of identifying and retaining high-value customers.

💡 Insight 2: Customer Segmentation Opportunity

By ranking customers based on cumulative revenue contribution, we can clearly segment customers into high-value, mid-value, and low-value groups. This enables targeted strategies such as premium retention for top customers and re-engagement campaigns for lower tiers.

💡 Insight 3: Business Risk Exposure

Heavy reliance on a small group of customers introduces revenue concentration risk. If a few top customers churn, it can significantly impact total revenue. This insight helps businesses diversify their customer base or strengthen relationships with key accounts.

💡 Insight 4: Efficiency in Resource Allocation

Instead of treating all customers equally, businesses can focus their resources on the top contributing customers. This improves marketing ROI, customer success efficiency, and overall profitability.

💡 Insight 5: Data-Driven Decision Framework

The combination of ranking and cumulative metrics provides a structured way to evaluate customer contribution. This approach can be reused across different business scenarios such as product analysis, regional performance, or sales channel optimization.

💡 Insight 6: Scalability of Analytical SQL

The entire Pareto analysis was performed using SQL on a cloud data warehouse, demonstrating that complex business analysis can be efficiently executed directly at the data layer without requiring additional tools.

---

## 📈 Business Recommendations

* Focus retention and engagement strategies on top contributing customers to maximize revenue impact.
* Develop targeted marketing campaigns for high-value customer segments.
* Reduce dependency on a small group of customers by expanding the mid-tier customer base.
* Use Pareto-based segmentation to optimize pricing, promotions, and customer experience.
* Continuously monitor customer contribution trends to detect shifts in revenue distribution.


## 📂 Project Structure

* `dataset/` → Raw CSV data
* `sql/` → SQL scripts (views approach + CTE approach)
* `results/` → Output snapshots

---

## 🚀 Why This Project Matters

This project demonstrates:

* Strong analytical SQL skills
* Ability to solve real-world business problems using data
* Experience working with cloud-based data warehouses
* Understanding of scalable data transformation patterns

---

## 🔗 Future Improvements

* Visualization using Power BI or Tableau
* Dynamic parameterization of thresholds (e.g., 70%, 90%)
* Integration into automated data pipelines
