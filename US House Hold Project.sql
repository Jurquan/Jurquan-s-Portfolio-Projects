-- US Project Data Cleaning


Alter table us_project.us_household_income_statistics
rename column `ï»¿id` to `id`;

SELECT *
FROM us_project.us_household_income_statistics;


SELECT *
FROM us_project.us_household_income;


SELECT Count(ID)
FROM us_project.us_household_income_statistics;



SELECT Count(ID)
FROM us_project.us_household_income;

-- Removing Duplicates 

select id, count(id) 
from us_household_income
group by id
having count(id) > 1
;


Select *
from(
Select row_id, id,
row_number() over(partition by id order by id) as row_num
from us_household_income) as row_table
where row_num > 1;


delete from us_household_income
where row_id in (
Select row_id
from (
Select row_id, id,
row_number() over(partition by id order by id) as row_num
from us_household_income) as row_table
where row_num > 1);


select state_name, count(state_name)
from us_household_income
group by State_Name
;

select distinct state_name
from us_household_income
group by State_Name
;


update us_household_income
set state_name = 'Georgia'
where State_name = 'georia'
;


update us_household_income
set state_name = 'Alabama'
where State_name = 'alabama'
;


select distinct state_name
from us_household_income
group by State_Name
;

select * 
from us_household_income
where place = ''
;


select * 
from us_household_income
where county = 'Autauga County'
order by 1
;

update us_household_income
set place = 'Autaugaville' 
where county = 'Autauga County'
and city = 'Vinemont'
;


select type, count(type)
from us_household_income
group by type
;


update us_household_income 
set type = 'Borough'
where type = 'Boroughs'
;



-- Exploratory Data Analysis

SELECT *
FROM us_project.us_household_income_statistics;


SELECT *
FROM us_project.us_household_income;


select state_name, SUM(ALand), SUM(AWater)
from us_household_income
group by State_Name
order by SUM(Awater) desc
limit 10
; 


select * 
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
    ;
    
    
select * 
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
where mean <> 0
    ;
    
    
select u.State_Name, county, type, `Primary`, Mean, Median
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
where mean <> 0
    ;
    
    
select u.State_Name, round(avg(mean),1), round(avg(median),1)
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
where mean <> 0
group by u.state_name
order by 3  -- ASC
limit 10
    ;
    
    
select Type, count(Type), round(avg(mean),1), round(avg(median),1)
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
where mean <> 0
group by Type
order by 3 desc  -- ASC
limit 20
    ;
    
    
    Select * 
    from us_household_income
    where type ='community';
    
    
    
select Type, count(Type), round(avg(mean),1), round(avg(median),1)
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
where mean <> 0
group by Type
having count(type) > 100
order by 3 desc  -- ASC
limit 20
    ;    
    
select u.state_name, city, round(avg(mean),1)
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
group by u.state_name, city
order by 3 desc
    ;
    
select u.state_name, city, round(avg(mean),1), round(avg(median),1)
from us_household_income u 
join us_household_income_statistics us 
	on u.id = us.id
group by u.state_name, city
order by 3 desc
    ;










