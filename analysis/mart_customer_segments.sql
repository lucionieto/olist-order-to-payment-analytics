create view customer_segmemts as
with cust_segment as (
select cd.cust_unique_id, max(os.order_purchase_t) as recent_buy, 
	count(distinct os.order_id) as number_of_orders, sum(oi.price) as total_spent
from order_stage os
join customer_data cd  on cd.customer_id = os.customer_id
left join order_item oi on oi.order_id = os.order_id 
group by cd.cust_unique_id),

rfm_score as(
SELECT cust_unique_id, ntile(5) over (order by recent_buy desc) as recency_score, 
	ntile(5) over (order by number_of_orders asc)as order_qty_score, 
	ntile(5) over (order by total_spent asc) as total_spent_score
	FROM cust_segment),

segments as(
select *, 	
	ROUND((recency_score +  order_qty_score + total_spent_score)/3.0, 2) as avg_score,
	case when recency_score >= 4 and order_qty_score >= 4 and total_spent_score >= 4 then 'Champion'
	 when recency_score >= 4 and order_qty_score <= 2 then 'New Customer'
	 when recency_score >= 2 and order_qty_score >= 3 and total_spent_score >= 3 then 'at Risk'
	 when recency_score <= 2 and order_qty_score <= 2 and total_spent_score <= 2 then 'Lost'
	else 'Potential Loyal'
	end as Customer_segment
 from rfm_score)
 
 select Customer_segment, round(AVG(avg_score), 2)as avg_score_across_all_customers ,count(*) as customer_per_segment

 from segments
 group by Customer_segment;

select * from customer_segmemts cs 