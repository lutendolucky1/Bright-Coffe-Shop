--My table
select *
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


-------------------------------------------------------------------------------------------------
--Time dimention
--6 months duration

--------------------------------------------------------------------------------------------------

--start 2023-01-01
select min(transaction_date) as min_date
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 --end 2023-06-30
 select max(transaction_date) as max_date
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 --Sales by day for most to least
select transaction_date , count(transaction_id) as daily_sales
from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by transaction_date 
order by transaction_date asc;


--opening and closing timse
--2026-03-17T20:59:32.000+00:00	to 2026-03-17T06:00:00.000+00:00
 select max(transaction_time) as max_date , min(transaction_time) as min_date
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;

 
---Sales by time of day
select time_phase , count(transaction_id) as totl_sales
from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by time_phase;

--sales each month 
select month , count(transaction_id) as total_sales
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by month; 

select count(time_bucket) as total_time_buckets , time_bucket
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by time_bucket;


--revenue per transaction
 select transaction_id,
 dayname(transaction_date) as day_name , 
 transaction_date ,
  (transaction_qty*unit_price) as revenue,
 monthname(transaction_date) as month_name
  from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


--sales & revenue per day
   select count(distinct transaction_id) as number_of_sales,
 dayname(transaction_date) as day_name , 
 transaction_date ,
  sum(transaction_qty*unit_price) as revenue,
 monthname(transaction_date) as month_name
  from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by transaction_date , day_name , month_name;

--which day genrate the most revenue
select dayname(transaction_date) as day_name ,  sum(transaction_qty*unit_price) as revenue
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by day_name
 order by revenue desc;
 


------------------------------------------------------------------------------------------------------
--New column - time phase
--New column - Month
-----------------------------------------------------------------------------------------------------
select transaction_time ,
 CASE 
        WHEN transaction_time BETWEEN '00:00:00' AND '06:00:00' THEN 'Early Morning'
        WHEN transaction_time BETWEEN '06:00:01' AND '12:00:00' THEN 'Morning Peak'
        WHEN transaction_time BETWEEN '12:00:01' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_phase
FROM `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


-------------------------------------------------------------------------------------------
--Add time_phase colomn
ALTER TABLE `bright`.`default`.`bright_coffee_shop_analysis_case_study_1` 
ADD COLUMN time_phase STRING;

select transaction_date
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 set time_phase = CASE 
    WHEN HOUR(transaction_time) < 6 THEN 'Early Morning'
    WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning Peak'
    WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
    ELSE 'Evening'
END;

--add a month colonm
ALTER TABLE `bright`.`default`.`bright_coffee_shop_analysis_case_study_1` 
ADD COLUMN Month STRING;

update `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
  set month =  CASE 
        WHEN MONTH(transaction_date) = 1 THEN 'Jan'
        WHEN MONTH(transaction_date) = 2 THEN 'Feb'
        WHEN MONTH(transaction_date) = 3 THEN 'Mar'
        WHEN MONTH(transaction_date) = 4 THEN 'Apr'
        WHEN MONTH(transaction_date) = 5 THEN 'May'
        WHEN MONTH(transaction_date) = 6 THEN 'Jun'
        ELSE 'Other'
    END;


---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
--category dimension
--------------------------------------------------------------------------------------------

--Types of product categories
select distinct product_category
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 --Product type
 select distinct product_type
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 --Product details
 select distinct product_type
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 --Most popular categories by sales
 select product_category , count(transaction_id) as total_category
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by product_category
 order by `total_category` desc;


--Most popular product type
 select count(transaction_id) as total_category ,product_type
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by product_type
 order by `total_category` desc;

--------------------------------------------------------------------------

--------------------------------------------------------------------------
--prices
--------------------------------------------------------------------------

--cheap price 
select min(unit_price) as cheapest_price 
from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


--expensive price
select max(unit_price) as expensive_price 
from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


--Total sales R698812
select sum(unit_price*transaction_qty) as total_sales
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 --Total sales in product category
 --R698,812.33
select (unit_price*transaction_qty) as total_sales	
	from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;

	
	--population in each product
  select product_category , count(product_id) as total_sales
  from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
  group by product_category
 order by total_sales desc;


--Total sales by product type
 select sum(unit_price*transaction_qty) as total_sales , product_type 
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by product_type
 order by total_sales desc;


 --Total sales by time phase
 select sum(unit_price*transaction_qty) as total_sales , Time_phase 
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by Time_phase
 order by total_sales desc;


--
select time_bucket , count(transaction_id)
from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by time_bucket


-------------------------------------------------------------------------------
--add new table time_bucket
alter table `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
ADD COLUMN `time_bucket` STRING;

 update `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 set time_bucket = case 
 when (unit_price*transaction_qty) <=50 then '01.lows pending'
 when (unit_price*transaction_qty) between 51 and 200 then '02.medium spending'
 when (unit_price*transaction_qty) between 201 and 300 then '03.high spending'
 else '04.most spending'
 end ;
  
 -----------------------------------------------------------------------

 -----------------------------------------------------------------------
 --location
 -----------------------------------------------------------------------

 --different stores
 select distinct store_location
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`;


--population in each store
 select distinct store_location , count(transaction_id) as population
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by store_location
 order by population desc;



 --most visted time in each store
 select count(transaction_id) as population, Time_phase ,store_location
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by time_phase , store_location;


 --total sales in each store
 select sum(unit_price*transaction_qty) as total_sales , store_location
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by store_location;

 --revenue by sore location
 select sum(transaction_qty*unit_price) as renenue ,store_location , month
 from `bright`.`default`.`bright_coffee_shop_analysis_case_study_1`
 group by store_location , month
----------------------------------------------------------------------------------
