-- Q1 : Find out the list of customers (first name & last name in lower case) where either first name or last name is of more than 10 characters long.
SELECT
	LOWER(FIRST_NAME) AS FIRST_NAME,
	LOWER(LAST_NAME) AS LAST_NAME
FROM
	PUBLIC.CUSTOMER
WHERE
	LENGTH(FIRST_NAME) > 10
	OR LENGTH(LAST_NAME) > 10;

-- Q2 : Extract the last 5 characters of the email address. The email address always ends with '.org' and further extract just the dot '.' from email address.
SELECT
	RIGHT(EMAIL, 5) AS FIRST_EXTRACT,
	LEFT(RIGHT(EMAIL, 4), 1) AS SECOND_EXTRACT,
	EMAIL
FROM
	PUBLIC.CUSTOMER

-- Q3 : Create an anonymized version of email address that must contain the first character followed by '***' and ending with '@sakilacustomer.org'
SELECT
	LEFT(EMAIL, 1) || '***' || RIGHT(EMAIL, 19) AS ANONYMIZED_EMAIL
FROM
	PUBLIC.CUSTOMER;

-- Q4 : Suppose you have only email address and last name as available column and you are asked to extract first name from email address and concatenate
--		it with first name and return the result as "Last name, First name"
SELECT
	EMAIL,
	LAST_NAME,
	LAST_NAME || ', ' || LEFT(EMAIL, POSITION(LAST_NAME IN EMAIL) -2) AS NAME
FROM
	PUBLIC.CUSTOMER;
-- Alternate solution
SELECT
	EMAIL,
	LAST_NAME,
	LAST_NAME || ', ' || LEFT(EMAIL, POSITION('.' IN EMAIL) -1) AS NAME
FROM
	PUBLIC.CUSTOMER;

-- Q5 : Write two SQL queries to show email adress in the following formats M***.S***@sakilacustomer.org & ***Y.S***@sakilacustomer.org
SELECT
	LEFT(EMAIL, 1) 
	|| '***' 
	|| SUBSTRING(EMAIL FROM POSITION('.' IN EMAIL) FOR 2) 
	|| '***' 
	|| SUBSTRING(EMAIL FROM POSITION('@' IN EMAIL)) 
	AS ANONYMOUS_EMAIL,
	EMAIL
FROM
	PUBLIC.CUSTOMER;

SELECT
	'***' 
	|| SUBSTRING(EMAIL FROM POSITION('.' IN EMAIL)-1 FOR 3) 
	|| '***' 
	|| SUBSTRING(EMAIL FROM POSITION('@' IN EMAIL) ) 
	AS ANONYMOUS_EMAIL,
	EMAIL
FROM
	PUBLIC.CUSTOMER;

-- Q6 : Analyze payment table and find out
--		what month is the highest total payment amount
--		what day of the week with the highest total payment amount (0 is sunday)
--		what is the highest amount one customer has spent in a week

-- Solution-1
SELECT
	EXTRACT(MONTH FROM PAYMENT_DATE) AS MONTH,
	SUM(AMOUNT) AS TOTAL_PAYMENT_AMOUNT
FROM
	PUBLIC.PAYMENT
GROUP BY
	EXTRACT(MONTH FROM PAYMENT_DATE);

-- Solution-2
SELECT
	EXTRACT(DOW FROM PAYMENT_DATE) AS weekday,
	SUM(AMOUNT) AS TOTAL_PAYMENT_AMOUNT
FROM
	PUBLIC.PAYMENT
GROUP BY
	EXTRACT(DOW FROM PAYMENT_DATE)
ORDER BY
	TOTAL_PAYMENT_AMOUNT DESC;

-- Solution-3
SELECT
	EXTRACT(WEEK FROM PAYMENT_DATE) AS WEEK_NUMBER,
	CUSTOMER_ID,
	SUM(AMOUNT) AS TOTAL_PAYMENT_AMOUNT
FROM
	PUBLIC.PAYMENT
GROUP BY
	WEEK_NUMBER,
	CUSTOMER_ID;

-- Q7 : You are asked to sum the payments and group in the following formats
--		Fri, 24/01/2020
--		May, 2020
--		Thu, 02:44

-- Solution-1
SELECT
	TO_CHAR(PAYMENT_DATE, 'Dy, DD/MM/YYYY') AS PYMT_DATE,
	SUM(AMOUNT) AS AMT
FROM
	PUBLIC.PAYMENT
GROUP BY
	PYMT_DATE
ORDER BY
	AMT ASC;

-- Solution-2
SELECT
	TO_CHAR(PAYMENT_DATE, 'Mon, YYYY') AS PYMT_DATE,
	SUM(AMOUNT) AS AMT
FROM
	PUBLIC.PAYMENT
GROUP BY
	PYMT_DATE
ORDER BY
	AMT ASC;

-- Solution-3
SELECT
	TO_CHAR(PAYMENT_DATE, 'Dy, HH:MI') AS PYMT_DATE,
	SUM(AMOUNT) AS AMT
FROM
	PUBLIC.PAYMENT
GROUP BY
	PYMT_DATE
ORDER BY
	AMT ASC;

-- Q8 : Query all the rental durations of customer with customer_id = 35
SELECT
	RENTAL_ID,
	RETURN_DATE - RENTAL_DATE AS DURATION
FROM
	PUBLIC.RENTAL
WHERE
	CUSTOMER_ID = 35;

-- Q9 : Identify the customer with longest average rental duration.
SELECT
	CUSTOMER_ID,
	AVG(RETURN_DATE - RENTAL_DATE) AS AVG_DURATION
FROM
	PUBLIC.RENTAL
GROUP BY
	CUSTOMER_ID
ORDER BY
	AVG_DURATION DESC;