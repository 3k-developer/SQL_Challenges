-- Q1 : Write a query to see the Minimum, Maximum, Average (rounded), Sum fo the replacement cost of the films.
SELECT
	MIN(REPLACEMENT_COST) AS "minimum",
	MAX(REPLACEMENT_COST) AS "maximum",
	ROUND(AVG(REPLACEMENT_COST), 2) AS "average",
	SUM(REPLACEMENT_COST) AS "sum"
FROM
	PUBLIC.FILM;

-- Q2 : Which two employees (staff_id) is responsible for higher overall payment amount, skip payments with 0 amount.
SELECT
	STAFF_ID,
	SUM(AMOUNT) AS "total"
FROM
	PUBLIC.PAYMENT
WHERE
	AMOUNT != 0
GROUP BY
	STAFF_ID
ORDER BY
	SUM(AMOUNT) DESC
LIMIT
	2;

-- Q3 : Which two employees (staff_id) is responsible for more payments, skip payments with 0 amount.
SELECT
	STAFF_ID,
	COUNT(PAYMENT_ID) AS "Payment_Count"
FROM
	PUBLIC.PAYMENT
WHERE
	AMOUNT != 0
GROUP BY
	STAFF_ID
ORDER BY
	COUNT(PAYMENT_ID) DESC
LIMIT
	2

-- Q4 : Find out avg payment amt grouped by customers and day - consider only days/customer with more than 1 payment
--		(per customer per day). Order by avg amount in a descending order.
SELECT
	DATE (PAYMENT_DATE),
	CUSTOMER_ID,
	ROUND(AVG(PAYMENT.AMOUNT), 2) AS "Avg_pymt",
	COUNT(PAYMENT_ID) AS "pymt_cnt"
FROM
	PUBLIC.PAYMENT
WHERE
	DATE (PAYMENT_DATE) IN ('2020-04-28', '2020-04-29', '2020-04-30')
GROUP BY
	DATE (PAYMENT_DATE),
	CUSTOMER_ID
HAVING
	COUNT(PAYMENT_ID) > 1
ORDER BY
	ROUND(AVG(AMOUNT), 2) DESC;
