USE sakila;

## 1. 

SELECT s.store_id, c.city, ct.country
FROM sakila.store s 
	JOIN sakila.address a 
		USING (address_id)
	JOIN sakila.city c 
		USING (city_id)
	JOIN sakila.country ct 
		USING(country_id)
;

## 2. 

SELECT s.store_id, SUM(p.amount) AS total_dollars
FROM sakila.store s 
	JOIN sakila.staff sf 
		USING (store_id)
	JOIN sakila.payment p
		USING (staff_id)
GROUP BY s.store_id
;

## 3. 

-- If you mean on average:

SELECT c.name, AVG(f.length) avg_length
FROM sakila.film_category fc
	JOIN sakila.film f 
		USING (film_id)
	JOIN sakila.category c
		USING (category_id)
GROUP BY c.name
ORDER BY avg_length DESC
;

-- If you mean in total minutes summed:

SELECT c.name, SUM(f.length) sum_length
FROM sakila.film_category fc
	JOIN sakila.film f 
		USING (film_id)
	JOIN sakila.category c
		USING (category_id)
GROUP BY c.name
ORDER BY sum_length DESC
;

## 4. 

SELECT f.title, COUNT(r.rental_id) AS num_rental
FROM sakila.rental r 
	JOIN sakila.inventory i 
		USING (inventory_id)
	JOIN sakila.film f 
		USING (film_id)
GROUP BY f.film_id
ORDER BY num_rental DESC
;

## 5. 

SELECT c.name, sum(p.amount) AS gross_revenue
FROM sakila.category c
	JOIN sakila.film_category fc
		USING(category_id)
	JOIN sakila.inventory i  
		USING (film_id)
	JOIN sakila.rental r 
		USING (inventory_id)
	JOIN sakila.payment p 
		USING (rental_id)
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5
;

## 6. 

SELECT * FROM sakila.film_category;
SELECT * FROM sakila.category;
SELECT * FROM sakila.film;
SELECT * FROM sakila.rental;
SELECT * FROM sakila.inventory;

SELECT s.store_id, i.inventory_id, f.title, MAX(r.return_date) AS last_return, r.last_update, (r.last_update > r.return_date) AS available_for_rent
FROM sakila.film f
	JOIN sakila.inventory i
		USING (film_id)
	JOIN sakila.rental r
		USING (inventory_id)
	JOIN sakila.store s 
		USING (store_id)
WHERE f.title = 'ACADEMY DINOSAUR'
AND s.store_id = 1
AND return_date IS NOT NULL
GROUP BY inventory_id
;


## 7. 

SELECT fa1.film_id, fa1.actor_id, a1.first_name, a1.last_name, fa2.actor_id, a2.first_name, a2.last_name
FROM sakila.film_actor fa1
	JOIN sakila.film_actor fa2
		USING(film_id)
	JOIN sakila.actor a1
		ON a1.actor_id = fa1.actor_id
	JOIN sakila.actor a2
		ON a2.actor_id = fa2.actor_id
WHERE a1.actor_id != a2.actor_id;

