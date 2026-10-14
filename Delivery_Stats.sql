SELECT c.customer_state,
	COUNT(DISTINCT CASE WHEN o.order_status = 'delivered' THEN o.order_id END) AS total_delivered,
	SUM(CASE
			WHEN DATE(o.order_delivered_customer_date) < DATE(o.order_estimated_delivery_date)
			THEN 1
			ELSE 0
		END 
	) AS early_deliveries,
	SUM(CASE
			WHEN DATE(o.order_delivered_customer_date) = DATE(o.order_estimated_delivery_date)
			THEN 1
			ELSE 0
		END 
	) AS ontime_deliveries,
	SUM(CASE
			WHEN DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date)
			THEN 1
			ELSE 0
		END 
	) AS late_deliveries,
	ROUND(100.0 * SUM(CASE WHEN DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date)      /* sum of all late X 100 then divided by total orders*/
		THEN 1 ELSE 0 END) / COUNT(o.order_id),2) AS late_delivery_percent
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state    /* groups it by state so each state has its own data*/



