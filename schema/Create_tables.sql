create table order_items(
	order_id VARCHAR , 
	order_item_id INT, 
	product_id VARCHAR, 
	seller_id VARCHAR, 
	shipping_limit_date TIMESTAMP, 
	price numeric(10,2), 
	freight_value numeric(10,2),
	PRIMARY KEY (order_id, order_item_id)
);

create table geolocation(
	geolocation_zip_code_prefix varchar , 
	geolocation_lat FLOAT, 
	geolocation_lng FLOAT,
	geolocation_city VARCHAR, 
	geolocation_state VARCHAR 
);

create table order_payments (
	order_id VARCHAR , 
	payment_sequential Int, 
	payment_type VARCHAR, 
	payment_installments int, 
	payment_value numeric (10,2),
	PRIMARY KEY (order_id, payment_sequential)
);
create table order_reviews(
	review_id varchar primary key, 
	order_id VARCHAR,
	review_score int, 
	review_comment_title varchar, 
	review_comment_message varchar,
	review_creation_date Timestamp,
	review_answer_timestamp timestamp
	
	);
	
create table orders(
	order_id VARCHAR primary key,
	customer_id varchar, 
	order_status varchar, 
	order_purchase_timestamp timestamp, 
	order_approved_at timestamp, 
	order_delivered_carrier_date timestamp, 
	order_delivered_customer_date timestamp,
	order_estimated_delivery_date timestamp
);
create table products(
	product_id varchar primary key, 
	product_category_name varchar,
	product_name_lenght int, 
	product_description_lenght int, 
	product_photos_qty int, 
	product_weight_g int, 
	product_length_cm int, 
	product_height_cm int, 
	product_width_cm int 
	
);

create table seller(
seller_id varchar primary key, 
seller_zip_code_prefix varchar,  
seller_city varchar, 
seller_state varchar
);

create table category_translation(
	product_category_name varchar primary key, 
	product_category_name_english varchar 
);


