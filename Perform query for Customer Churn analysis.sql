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

select * from customer_churn
where InternetService = 'Fiber Optic';

select * from customer_churn
where PaperlessBilling = 'Yes';

select * ,MonthlyCharges 
from customer_churn
where MonthlyCharges > 80
order by MonthlyCharges desc;

select churn , round(avg(MonthlyCharges),2) as avg_MonthlyCharges
from customer_churn
group by churn;

select Contract ,count(*) as total_count
from customer_churn
group by Contract;

select Contract , round(sum(TotalCharges),2) as total_revenue
from customer_churn
group by Contract;

select InternetService,avg(tenure)
from customer_churn
group by InternetService;

select PaymentMethod,count(*)as customer_count
from customer_churn
group by PaymentMethod;

select * ,TotalCharges
from customer_churn
order by TotalCharges desc 
limit 10;

select InternetService,churn,count(*)as churn_count
from customer_churn
where churn = 'Yes'
group by InternetService,churn;

select count(*),count(case when OnlineSecurity = 'Yes' and OnlineBackup = 'Yes' then 1 end)as OnlineSecurity_and_OnlineBackup
from customer_churn;

select count(*)as count_SeniorCitizen,churn
from customer_churn
where churn = 'Yes';


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

select customerID,TotalCharges,
		rank() over(order by TotalCharges desc)as ranking
from customer_churn;

select Contract , sum(tenure) as 5_longest_tenure
from customer_churn
group by Contract
order by 5_longest_tenure desc
limit 5;

SELECT
    customerID,
    Contract,
    tenure
FROM (
    SELECT
        customerID,
        Contract,
        tenure,
        ROW_NUMBER() OVER (
            PARTITION BY Contract
            ORDER BY tenure DESC
        ) AS rn
    FROM customer_churn
) t
WHERE rn <= 5
ORDER BY Contract, tenure DESC;

select * ,
	round(sum(TotalCharges) over(order by PaymentMethod asc),2)as contract_total_revenu
from customer_churn;

select * ,
	sum(MonthlyCharges) over(partition by Contract)as sum_monthly_charges
from customer_churn;

select * ,
	round(sum(TotalCharges) 
    over(partition by Contract
    order by customerID asc),2)as total_charges
from customer_churn;

select customerID,SeniorCitizen		
        from customer_churn
        where SeniorCitizen = 1;
  
select Contract,InternetService , round(avg(MonthlyCharges),2)as Monthly_charges
from customer_churn
group by Contract,InternetService;

select customerID,MonthlyCharges
from customer_churn
where MonthlyCharges > (select avg(MonthlyCharges)from customer_churn)
order by MonthlyCharges desc;
        

select PaymentMethod , round(sum(TotalCharges)*100.0/(select sum(TotalCharges)from customer_churn),2)as total_chrages
from customer_churn
group by PaymentMethod
order by total_chrages desc;

select customerID , tenure
from customer_churn
where tenure > (select avg(tenure)from customer_churn)
order by tenure desc;

select Contract ,TotalCharges as total_charges
from customer_churn
where Contract = 'month-to-month' and TotalCharges > (select avg(TotalCharges)from customer_churn)
order by total_charges desc;

select * ,
case
when MonthlyCharges < 50 then 'Low Value'
when MonthlyCharges > 50 then 'Medium Value'
when MonthlyCharges > 80 then 'High Value'
end customer_segments
from customer_churn

