create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')

---------------------------------DML----------------------------------

with floor_visit as
(
    select name,floor,count(1) as no_of_floor_visited,
    rank() over (partition by name order by count(1) desc) as rn
    from entries
    group by name,floor
), total_visits as 
(
    select name,count(1) as total_visit,string_agg(resources,',') as res_used
    group by name
)

select fv.name, tv.total_visit, fv.floor as most_visited_floor, tv.res_used
  
from floor_visit fv inner join total_visits tv on tv.name=fv.name

where rn=1