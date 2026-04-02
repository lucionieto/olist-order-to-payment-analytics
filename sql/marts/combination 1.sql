
select o.order_id,
	c.cust_unique_id,
	sum(i.price) as total_price,
	SUM(i.freight_value) AS total_freight,
	count(i.order_item_id) as item_count
	from  order_stage o
	inner join customer_data c  ON o.customer_id = c.customer_id
	left join order_item  i on o.order_id = i.order_id
	group by o.order_id,c.cust_unique_id ;


