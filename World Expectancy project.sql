## World Life Expentancy (Data Cleaning)

Select* 
from world_life_expectancy
;

REMOVING DUPLICATES

SELECT country, Year, concat(country, year), count(concat(country, year)) 
FROM world_life_expectancy
group by country, Year, concat(country, year)
having count(concat(country, year)) > 1; 



select *
from(
select Row_ID, 
concat(country, year),
row_number() Over( partition by concat(country, year) order by concat(country, year)) as row_num 
from world_life_expectancy) as row_table
where row_num > 1;

delete from world_life_expectancy 
where 
	Row_ID IN ( 
    select Row_ID
    from (
select Row_ID, 
concat(country, year),
row_number() Over( partition by concat(country, year) order by concat(country, year)) as row_num 
from world_life_expectancy) as row_table
where row_num > 1);


-- FIXING BLANKS OR NULLS 

SELECT * 
FROM world_life_expectancy
where Status = ''
;

SELECT distinct (Status) 
FROM world_life_expectancy
where Status <> ''
; 

select distinct(country) 
from world_life_expectancy
where status = 'developing'
;

update world_life_expectancy
set status = 'developing'
where country in (select distinct(country) 
					from world_life_expectancy 
                    where status = 'developing');
                    

SELECT * 
FROM world_life_expectancy
where country = 'united states of america'
;

update world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.country
    set t1.status = 'developed'
    where t1.status = '' 
and t2.status <> ''
and t2.status = 'developed'
;


select * 
from world_life_expectancy
where `Life expectancy` = ''
;

select t1.country, t1.year,  t1.`Life expectancy`, t2.country, t2.year,  t2.`Life expectancy`
from world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.Country
    and t1.year = t2.year -1
; 


select t1.country,
 t1.year,  
t1.`Life expectancy`, t2.country, 
t2.year,  t2.`Life expectancy`,
t3.year,  t3.`Life expectancy`, 
round((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
from world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.Country
    and t1.year = t2.year -1
    join world_life_expectancy t3
	on t1.country = t3.Country
    and t1.year = t3.year +1 
    where t1.`Life expectancy` = ''
; 


update world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.Country
    and t1.year = t2.year -1
    join world_life_expectancy t3
	on t1.country = t3.Country
    and t1.year = t3.year +1
    set  t1.`Life expectancy` = round((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
    where t1.`Life expectancy` = ''
    ;
    
select * 
from world_life_expectancy;
;


-- Exploratory Data Analysis 

Select * 
From world_life_expectancy
;


Select Country, MIN(`Life expectancy`), MAX(`Life expectancy`),
Round(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) as life_increase_15_years
From world_life_expectancy
group by country 
Having MIN(`Life expectancy`) <> 0 
and MAX(`Life expectancy`) <> 0 
order by life_increase_15_years desc
;



Select Year, round(avg(`Life expectancy`),2)
from world_life_expectancy
where `Life expectancy` <> 0 
and (`Life expectancy`) <> 0 
group by year
order by year
; 


Select * 
from world_life_expectancy
;


Select country, round(AVG(`Life expectancy`),1) as L_E, 
round(AVG(GDP),1) as GDP
from world_life_expectancy
group by country  
having L_E > 0 
and GDP > 0
order by GDP desc
;


Select 
SUM(case When GDP >=1500 then 1 else 0 end) High_GDP_Count,
AVG(case When GDP >=1500 then `Life expectancy` else NULL end) High_GDP_LE,
SUM(case When GDP <=1500 then 1 else 0 end) Low_GDP_Count,
AVG(case When GDP <=1500 then `Life expectancy` else NULL end) Low_GDP_LE
from world_life_expectancy
;



Select status, Round(AVG(`Life expectancy`),1)
from world_life_expectancy
group by status
;

Select status, count(distinct Country), Round(AVG(`Life expectancy`),1)
from world_life_expectancy
group by status
;


Select country, 
round(avg(`Life expectancy`),1) as LE, 
round(Avg(BMI),1) as BMI
from world_life_expectancy
group by country 
having LE > 0 
and BMI > 0 
order by BMI ASC
;


Select country, year, 
`Life expectancy`, 
`Adult Mortality`, 
SUM(`Adult Mortality`) over(partition by country order by year) AS rolling_T
from world_life_expectancy
;


Select country, year, 
`Life expectancy`, 
`Adult Mortality`, 
SUM(`Adult Mortality`) over(partition by country order by year) AS rolling_T
from world_life_expectancy
where country like '%united%'
;


