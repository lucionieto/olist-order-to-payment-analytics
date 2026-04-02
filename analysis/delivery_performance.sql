create view mart_delivery_performance as 

with del_est_accuracy as ( 
	select  os.order_id, cd.customer_state, os.order_del_cust,os.est_delivery, 
	extract(day from os.order_del_cust - os.est_delivery) as delivery_difference 
	from order_stage os
	join customer_data cd on cd.customer_id = os.customer_id 
	where os.order_status = 'delivered')


select customer_state  , 
	count(*) as total_orders, 
	round(100 * sum(case when delivery_difference > 0 then 1 else 0 end ) / count(*),2) as del_pct,
	round(AVG(delivery_difference) ,2)AS avg_days_vs_estimate
	from del_est_accuracy
	group by (customer_state)
;
	
	

select * from mart_delivery_performance; 