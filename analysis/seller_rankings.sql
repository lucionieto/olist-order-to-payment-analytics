create view  seller_rankings as
with seller_revenue as (
select seller_id, count(order_id) as items_sold, sum(price) as total_revenue from order_item oi
group by oi.seller_id)

select *, rank () over (order by total_revenue desc)as revenue_rank 
	from seller_revenue; 

select * from seller_rankings sr 