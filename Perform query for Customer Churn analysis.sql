select count(*)as total_customer
from customer_churn;

select * 
from customer_churn
where churn = 'Yes';

select churn , count(*)as total_count
from customer_churn
group by churn;

select round(avg(MonthlyCharges),2) as avg_MonthlyCharges
from customer_churn;

select max(tenure) as max_tenure , min(tenure)as min_tenure
from customer_churn;

select * from customer_churn
where tenure >= 24;

select gender , count(*) as total_count
from customer_churn
group by gender;

select customerID , churn,count(*)as total_count
from customer_churn
group by customerID,churn
order by total_count desc;

select count(*),sum(case when churn = 'Yes' then 1 else 0 end) as total_churn
from customer_churn;
	
select * from customer_churn
where TotalCharges = '' and null;

update customer_churn
set TotalCharges = ''
where customerID = '7590-VHVEG';

SET SQL_SAFE_UPDATES = 1;

select TotalCharges , max(churn) as max_churn
from customer_churn
group by TotalCharges
order by max_churn desc
limit 5;

select round(
count(case when churn = 'Yes' then 1 end)*100.0/count(*),2)as percentage_churn
from customer_churn;
