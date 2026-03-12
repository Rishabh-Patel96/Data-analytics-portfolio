
SELECT * FROM sales;
SELECT * FROM members;
SELECT * FROM menu;


/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant? --
SELECT 
	s.customer_id,
	SUM(price) AS total_amount_per_customer
FROM sales AS s
INNER JOIN menu AS m
ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY customer_id ASC;

-- 2. How many days has each customer visited the restaurant? --
SELECT 
	customer_id,
	COUNT(DISTINCT order_date) AS days
FROM sales
GROUP BY customer_id
ORDER BY customer_id ASC;

-- 3. What was the first item from the menu purchased by each customer? --
SELECT
	*
FROM (
		SELECT
			s.customer_id,
			m.product_name,
			ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date ASC) AS rnk
		FROM sales AS s
		INNER JOIN menu AS m
		ON s.product_id = m.product_id
	 )
WHERE rnk = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers? --
SELECT
	mn.product_name,
	COUNT(*) AS times_ordered
FROM sales AS s
LEFT JOIN menu AS mn
ON s.product_id = mn.product_id
GROUP BY mn.product_name
ORDER BY times_ordered DESC
LIMIT 1

-- 5. Which item was the most popular for each customer? --
SELECT
	customer_id,
	product_name
FROM (
		SELECT
			s.customer_id,
			m.product_name,
			COUNT(*) AS order_count,
			RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(*) DESC) AS rnk
		FROM sales AS s
		INNER JOIN menu AS m
		ON s.product_id = m.product_id
		GROUP BY s.customer_id, m.product_name
	 ) AS t
WHERE rnk = 1;

-- 6. Which item was purchased first by the customer after they became a member?
SELECT
	customer_id,
	order_date,
	product_id
FROM (	
		SELECT 
			s.customer_id,
			s.order_date,
			s.product_id,
			ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY s.order_date ASC) AS rnk
		FROM sales AS s
		LEFT JOIN members AS m
		ON s.customer_id = m.customer_id
		WHERE s.order_date > m.join_date
	 ) AS t
WHERE rnk = 1;

-- 7. Which item was purchased just before the customer became a member?--
SELECT
	customer_id,
	order_date,
	product_id
FROM (
		SELECT
			s.customer_id,
			s.order_date,
			s.product_id,
			ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS rnk
		FROM sales AS s
		LEFT JOIN members AS m
		ON s.customer_id = m.customer_id
		WHERE s.order_date < m.join_date
	 ) AS t
WHERE rnk = 1;

-- 8. What is the total items and amount spent for each member before they became a member?--
SELECT
	s.customer_id,
	COUNT(*) AS Total_items,
	SUM(mn.price) AS Total_amount_spent
FROM sales AS s
LEFT JOIN members AS m
ON s.customer_id = m.customer_id
LEFT JOIN menu AS mn
ON s.product_id = mn.product_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?--
SELECT
	s.customer_id,
	SUM(CASE 
			WHEN mn.product_name = 'sushi' THEN mn.price * 20
			ELSE mn.price * 10
		END) AS Total_points
FROM sales AS s
LEFT JOIN menu AS mn
ON s.product_id = mn.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id ASC;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?--
SELECT
	s.customer_id,
	SUM(CASE 
			WHEN s.order_date BETWEEN m.join_date AND m.join_date + INTERVAL '6 days' THEN mn.price * 20
			WHEN mn.product_name = 'sushi' THEN mn.price * 20
			ELSE mn.price * 10
	    END
	   ) AS points		
FROM sales AS s
LEFT JOIN members  AS m
ON s.customer_id = m.customer_id
LEFT JOIN menu AS mn
ON s.product_id = mn.product_id
WHERE s.order_date <= '2021-01-31' AND s.customer_id IN ('A', 'B')
GROUP BY s.customer_id;










