SELECT
COUNT(DISTINCT CASE WHEN o.order_status = 'delivered' THEN o.order_id END) AS total_orders,
SUM(p.payment_value) AS total_revenue,
SUM(i.freight_value) AS total_expense,
SUM(p.payment_value) - SUM(i.freight_value) AS total_profit,
COUNT(DISTINCT CASE WHEN o.order_status = 'canceled' THEN o.order_id END) AS cancelled_orders
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
JOIN olist_order_items_dataset i
ON o.order_id = i.order_id 


/*Calculating total revenue from sold items that are delivered,
total orders and cancelled orders and total profit.*