declare @today DATE;
declare @n int;
set @today='2022-01-01' -- saturday 7th day
set @n=3

select dateadd(day,8-datepart(day,today),today) as this_sunday,

dateadd(week,n-1,dateadd(day,8-datepart(day,today))) as nth_sunday
