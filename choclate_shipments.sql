create database choclates;
use choclates;
show tables from choclates;

select *from geo;
select *from people_tel;
select*from products;
select*from shipments;;

# SQL Examples

# 1 – See all shipments
select*from shipments;

# 2 – All shipments by SP02
select*from shipments where sales_Person="SP02";

-- ALTER TABLE shipments CHANGE COLUMN `sales Person` sales_person VARCHAR(100);

# 3 – All shipments by SP02 to G3
select*from shipments s  where s.sales_person='Sp02' and s.geo='G3' order by s.amount desc;

# 4 – All shipments in Jan 2023
select*from shipments s where s.date between '2023-01-01' and '2023-01-31';

# 5 – All shipments by SP02, SP03, SP12, SP15
select*from shipments where sales_person in ('sp02','sp03','sp12','sp15');

# 6 – Products that have the word choco in them
select*from products where product like '%choco%';

# 7 – Sales persons whose name begins with S
select*from shipments where sales_person like 's%';

# 8 – Sales per box of chocolates in Feb 2023
select s.date,s.amount,s.boxes,round(s.amount/s.boxes,1)as amount_per_box from shipments s  where extract(year_month from s.date)=202302;

# 9 – All shipment data for Subbarao
select p.sales_person,s.date,s.amount,s.boxes from shipments s join people_tel p on p.sp_id=s.sales_person where p.sales_person like 'subba%';

# 10 – All shipment data for Subbarao by month
select extract(year_month from s.Date) as yearmonth,sum(s.amount)as amount,sum(s.boxes)as boxes from people_tel p join shipments s 
on p.sp_id=s.sales_person
group by yearmonth;

# H1 – All shipment data for Subbarao to USA
select p.sales_person,g.geo,s.date,s.amount,s.boxes from shipments s join people_tel p on s.sales_person=p.sp_id join geo g on s.geo=g.geoid
where p.sales_person like 'subba%' and g.geo='usa';

# H2 – What is the maximum amount in each month?
select month(s.date)As month,max(amount)as max_monthamnt from shipments s group by month order by month;

# H3 – How many shipments we do by each country in the month of March 2023
select g.geo,count(*),sum(s.amount) from shipments s join geo g on g.geoid=s.geo where extract(year_month from s.date)='202303' group by g.geo;
