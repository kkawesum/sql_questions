create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
)

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)


--------------------------------------------------DML----------------------------------
with first_visit AS
(
    select customer_id, min(order_date) as first_visit
    from customer_orders
    group by customer_id

),

first_visit_flag as
(
select co.*,fv.first_visit,
case when co.order_date=fv.first_visit then 1 else 0 end as first_visit_flag, 

case when co.order_date!=fv.first_visit then 1 else 0 end as repeat_visit_flag

from customer_orders co
inner join first_visit fv
on co.customer_id = fv.customer_id
order by order_date
)

select order_date,sum(first_visit_flag) as new_cust, sum(repeat_visit_flag) as repeat_cust
from first_visit_flag
group by order_date
;
