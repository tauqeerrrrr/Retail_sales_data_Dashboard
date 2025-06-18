create database Retail_sales;
use Retail_sales;

select * from retail_sales_dataset;
drop table retail_sales_dataset;
select * from retail_sales;

use retail_sales;
select * from retail_sales;
create table retail_sales2 like retail_sales;
insert into  retail_sales2 select * from  retail_sales;

select * from retail_sales2;
 #find duplicated row in table
 select *, row_number() over(partition by 'Transaction ID', Date,Customer_ID,Gender,Age,Product_Category,Quantity,Price_per_Unit,Total_Amount) as row_num
 from retail_sales2;

with duplicated_cte as (
 select *, row_number() over(partition by 'Transaction ID', Date,Customer_ID,Gender,Age,Product_Category,Quantity,Price_per_Unit,Total_Amount) as row_num
 from retail_sales2)
 delete from duplicated_cte
 where row_num >1;
 select * from retail_sales2;
ALTER TABLE retail_sales2
RENAME COLUMN `Transaction ID` TO Transaction_ID;
select * from retail_sales2;
 create table retail_sales3 (
Transaction_ID int ,
Date text ,
Customer_ID text ,
Gender text ,
Age int ,
Product_Category text ,
Quantity int ,
Price_per_Unit int ,
Total_Amount int,
row_num int);

insert into retail_sales3 (select *, row_number() over(partition by Transaction_ID, Date,Customer_ID,Gender,Age,Product_Category,Quantity,Price_per_Unit,Total_Amount) as row_num
 from retail_sales2);
delete from retail_sales3
where row_num>1;
select count(*) from retail_sales3;
alter table retail_sales3
modify column date date;

SELECT Age,
CASE 
    WHEN Age < 18 THEN 'Under_Age'
    WHEN Age >= 18 AND Age < 25 THEN '18-25'
    WHEN Age >= 25 AND Age < 40 THEN '25-40'
    WHEN Age >= 40 AND Age < 60 THEN '40-60'
    ELSE '60+'
END AS Age_group
FROM retail_sales3;

with Age_group as (

SELECT *,
CASE 
    WHEN Age < 18 THEN 'Under_Age'
    WHEN Age >= 18 AND Age < 25 THEN '18-25'
    WHEN Age >= 25 AND Age < 40 THEN '25-40'
    WHEN Age >= 40 AND Age < 60 THEN '40-60'
    ELSE '60+'
END AS Age_group
FROM retail_sales3)
select * from Age_group;
select sum(Total_Amount) as Total_Amount from retail_sales3;
select max(Total_Amount) as Max_Amount from retail_sales3;
select sum(Quantity) as Total_Quantity from retail_sales3;

select monthname(date) as month_name , sum(Total_Amount) from retail_sales3
group by month_name order by sum(Total_Amount) desc ;

select Gender, sum(Total_Amount)  from retail_sales3
group by Gender;

select Age, sum(Total_Amount) from retail_sales3
group by Age;

select Product_Category, sum(Total_Amount) from retail_sales3
group by Product_Category;








