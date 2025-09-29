-- Basic Filtering 

-- Q1 : How many payments were made by customer with custmer_id = 100
SELECT
	COUNT(*)
FROM
	PUBLIC.PAYMENT
WHERE
	CUSTOMER_ID = 100;

-- Q2 : What is the last name of our customer with first name 'ERICA'?
SELECT
	LAST_NAME
FROM
	PUBLIC.CUSTOMER
WHERE
	FIRST_NAME = 'ERICA';

-- Q3 : How many rentals have not been returned yet (return_date is null)
SELECT
	COUNT(*)
FROM
	PUBLIC.RENTAL
WHERE
	RETURN_DATE IS NULL;

-- Q4 : Fetch payment_id and amount of all the payments where amount is less than or equal to $2
SELECT
	PAYMENT_ID,
	AMOUNT
FROM
	PUBLIC.PAYMENT
WHERE
	AMOUNT <= 2;

-- Q5 : List of all the payments of customer_id 322, 346, 354 where amount is either less than $2 or greater than $10
--		Also, sort the result by ascending cusotmer first name and decending amount.
SELECT
	*
FROM
	PUBLIC.PAYMENT
WHERE
	CUSTOMER_ID IN (322, 346, 354)
	AND (
		AMOUNT < 2
		OR AMOUNT > 10
	)
ORDER BY
	CUSTOMER_ID ASC,
	AMOUNT DESC;

-- Q6 : Count of payments made on Jan-26 and Jan-27 2020 with amount between 1.99 and 3.99
SELECT
	*
FROM
	PUBLIC.PAYMENT
WHERE
	AMOUNT BETWEEN 1.99 AND 3.99
	AND PAYMENT_DATE BETWEEN '2020-01-26' AND '2020-01-28'
ORDER BY
	PAYMENT_DATE DESC;

-- Q7 : List out the movies that contain the word "Documentary" in their description
SELECT
	*
FROM
	PUBLIC.FILM
WHERE
	DESCRIPTION LIKE '%Documentary%';

-- Q8 : How many movies are there that contain 'Saga' in the description and where the title starts either with 'A' or ends with 'R'
SELECT
	COUNT(*) as no_of_movies
FROM
	PUBLIC.FILM
WHERE
	DESCRIPTION LIKE '%Saga%'
	AND (
		TITLE LIKE 'A%'
		OR TITLE LIKE '%R'
	);

-- Q9 : List all customers where the first name contains 'ER' and has a 'A' as second letter, order result by last name desc.
SELECT
	*
FROM
	PUBLIC.CUSTOMER
WHERE
	FIRST_NAME LIKE '%ER%'
	AND FIRST_NAME LIKE '_A%'
ORDER BY
	LAST_NAME DESC;

-- Q10 : List out payments where amount is either 0 or is between 3.99 and 7.99 and in the same time has happened on 2020-05-01.ABORT
SELECT
	count(*) as no_of_payments
FROM
	PUBLIC.PAYMENT
WHERE
	(
		AMOUNT = 0
		OR AMOUNT BETWEEN 3.99 AND 7.99
	)
	AND PAYMENT_DATE between '2020-05-01' and '2020-05-02';