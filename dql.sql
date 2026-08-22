use BikeStores;
select * from sales_schema.customers;
select * from sales_schema.orders;
--inner join or join -> will copmpine the tables
select * from sales_schema.customers as c , sales_schema.orders as o 
where c.customer_id = o.customer_id and c.customer_id=1;

select * from sales_schema.customers as c 
join sales_schema.orders as o on c.customer_id = o.customer_id 
where c.customer_id=1;


select * from sales_schema.customers as c , sales_schema.orders as o,sales_schema.stores as s 
where c.customer_id = o.customer_id and o.store_id = s.store_id and c.customer_id=1;

select * from sales_schema.customers as c 
join sales_schema.orders as o on c.customer_id = o.customer_id 
join sales_schema.stores as s on o.store_id = s.store_id 
where c.customer_id=1;

--get brands users bay from it
select c.first_name||' '||last_name as name,b.brand_name from sales_schema.customers as c 
join sales_schema.orders as o on c.customer_id = o.customer_id 
join sales_schema.order_items as oi  on o.order_id = oi.order_id 
join production_schema.products as p  on oi.product_id = p.product_id 
join production_schema.brands as b  on p.brand_id = b.brand_id 
;



--==============================================================
-- for each category get cat id , max price , min price, avrage
select * from production_schema.products as c ;

select 
count(*) as "products count" , 
min(c.list_price) as 'min price',
max(c.list_price) as 'max price',
avg(c.list_price) as 'avg price'
from production_schema.products as c ;

select 
c.category_id,
count(*) as "products count" , 
min(c.list_price) as 'min price',
max(c.list_price) as 'max price',
avg(c.list_price) as 'avg price'
from production_schema.products as c group by category_id having category_id<5;

select 
brand_name as 'brand name',
count(*) as "products count" , 
min(list_price) as 'min price',
max(list_price) as 'max price',
avg(list_price) as 'avg price'
from production_schema.products as p 
join production_schema.brands as b  on p.brand_id = b.brand_id 
group by brand_name ; 

--==============================================================

