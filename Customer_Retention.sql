SELECT c.customer_unique_id, c.customer_state,
	ROUND(JULIANDAY('2018-10-17') - JULIANDAY(MAX(o.order_purchase_timestamp)), 0) AS recency_days, /*most recent order date per customer*/
	COUNT(DISTINCT o.order_id) AS frequency_orders,   /*how many orders a customer has done*/
    ROUND(SUM(i.price + i.freight_value), 2) AS monetary_value   /*total money spent by a customer*/
FROM olist_orders_dataset o
JOIN olist_customers_dataset c 
  ON o.customer_id = c.customer_id  /* joins using this foreign key*/
JOIN olist_order_items_dataset i 
  ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id, c.customer_state   /*group by customer and the state they from*/
ORDER BY monetary_value DESC;