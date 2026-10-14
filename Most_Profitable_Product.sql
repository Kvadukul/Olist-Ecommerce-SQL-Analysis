SELECT 
	p.product_category_name AS category_name,   /* turn into sql column*/
	COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(i.product_id) AS items_sold,           /* TOTAL NUMBER OF PRODUCT IDS = TOTAL SOLD ITEMS*/
    ROUND(SUM(i.price), 2) AS total_revenue   	 /* all prices added up = Total revenue = then matched to each category*/
FROM olist_order_items_dataset i
JOIN olist_products_dataset p 
  ON i.product_id = p.product_id    /*foreign key to match datasets*/
JOIN olist_orders_dataset o 
  ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category_name             /*group by category name so items sold total rewvenue and all match categories */
ORDER BY total_revenue DESC;    /* descending order from most revenue to least per category product*/