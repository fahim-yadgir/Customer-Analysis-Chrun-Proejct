-- ! Churn Analysis

select Contract , 
		round(sum(case when churn = 'Yes' then 1 end)*100.0/count(*),2) as churn_rate 
from customer_churn
group by contract;

select PaymentMethod,
		round(sum(case when churn ='Yes' then 1 end)*100.0/count(*),2)as churn_rate
from customer_churn
group by PaymentMethod;

select gender,
		round(sum(case when churn = 'yes' then 1 end)*100.0/count(*),2)as churn_count
from customer_churn
group by gender;

select SeniorCitizen,
		round(sum(case when churn = 'yes' then 1 end)*100.0/count(*),2)as churn_count
from customer_churn
group by SeniorCitizen;



-- ! Revenue Analysis

select churn , 
		round(sum(TotalCharges),2)as revenue
from customer_churn
group by churn;

select contract,
		round(avg(TotalCharges),2)as highest_avg_revenue_PP
from customer_churn
group by Contract
order by highest_avg_revenue_PP desc
limit 1;

WITH customer_rank AS (
    SELECT
        customerID,
        TotalCharges,
        NTILE(5) OVER (ORDER BY TotalCharges DESC) AS revenue_group
    FROM customer_churn
)
SELECT
    customerID,
    TotalCharges
FROM customer_rank
WHERE revenue_group = 1
ORDER BY TotalCharges DESC;

select * ,
		round(sum(TotalCharges) 
        over(partition by tenure
		order by customerid asc),2)as cumulative_revenue
from customer_churn;

select churn,
		round(sum(TotalCharges),2)as lost_revenue
from customer_churn
where churn = 'No'
group by churn;



-- ! TotalCharges

select PhoneService,
		InternetService,
        OnlineSecurity,
        OnlineBackup,
        TechSupport,
        DeviceProtection,
        round(sum(case when churn = 'Yes' then 1 end)*100.0/count(*),2)as highest_churn_rate
from customer_churn
group by PhoneService,
		InternetService,
        OnlineSecurity,
        OnlineBackup,
        TechSupport,
        DeviceProtection
order by highest_churn_rate desc
limit 1;

select OnlineSecurity,
		sum(case when churn = 'Yes' then 1 end)*100.0/count(*) as churn_rate
from customer_churn
where OnlineSecurity = 'No'
group by OnlineSecurity;

select TechSupport,
		round(sum(case when churn = 'Yes' then 1 end)*100.0/count(*),2)as churn_rate
from customer_churn
group by TechSupport;

select PhoneService,
		InternetService,
        OnlineSecurity,
        OnlineBackup,
        TechSupport,
        DeviceProtection,
        count(*) as customer_count
from customer_churn
group by PhoneService,
		InternetService,
        OnlineSecurity,
        OnlineBackup,
        TechSupport,
        DeviceProtection
order by customer_count
limit 1;

select  customerid,
		Contract,
		tenure 
from customer_churn
where tenure < (select avg(tenure) from customer_churn);


select * ,
	avg(tenure) over 
    (partition by Contract )as below_avg
from customer_churn;

select *,
    sum(TotalCharges) over (partition by InternetService
	order by TotalCharges desc) as highest_paying_customers
from customer_churn
limit 3;

select * ,
	sum(totalcharges) over(partition by contract
    order by totalcharges desc)as runnig_total
from customer_churn;