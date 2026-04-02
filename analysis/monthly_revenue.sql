create view mart_monthly_revenue as 
with monthly_changes as (

	select   date_trunc('month', order_purchase_t) as trunc_month, sum(price) as monthly_revenue 
	from order_item oi 
	join order_stage os on os.order_id = oi.order_id 
	group by trunc_month
	)
	
select *, lag( monthly_revenue) over (order by trunc_month) as prev_month_revenue,
	
ROUND(
    (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY trunc_month))
    / NULLIF(LAG(monthly_revenue) OVER (ORDER BY trunc_month), 0) 
    * 100
, 2) AS month_pct_change

	from monthly_changes;
	

select * from mart_monthly_revenue; 