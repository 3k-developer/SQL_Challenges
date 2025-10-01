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