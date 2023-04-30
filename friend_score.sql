--------------- DML--------------------
select f.personid, sum(p.score) 
from
person p inner join friend f
on p.personid=f.friendid
group by f.personid
having sum(p.score)>100
