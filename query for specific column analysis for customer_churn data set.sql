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

select *,
	sum(MonthlyCharges) over (partition by contract
    order by MonthlyCharges desc)
from customer_churn;


-- ! Subqueries

select * from customer_churn
where TotalCharges > (select avg(TotalCharges)from customer_churn)
order by TotalCharges desc;

with service_revenue as(
		select
			InternetService,
            round(sum(totalcharges),2)as total_Revenue
            from customer_churn
            group by internetService
        )        
select * from service_revenue
where total_Revenue > (select avg(total_Revenue)from service_revenue);

select *,
	sum(TotalCharges) over (partition by Contract
						order by customerID desc)
from customer_churn;


with top_ten_percent as
(
	select customerid,
			totalcharges,
            ntile(10) over(order by totalcharges desc) as top_10
            from customer_churn
)
select * from top_ten_percent
		where top_10 =1
        order by totalcharges desc;
        
select contract , avg(tenure)as max_avg_tenure
from customer_churn
group by contract
order by max_avg_tenure desc
limit 1;

select contract,
		max(tenure) as max_tenure
from customer_churn
group by contract
order by max_tenure desc
limit 1;

select case 
		when tenure between 0 and 12 then "New"
        when tenure between 13 and 36 then "Regular"
        when tenure between 37 and 60 then "Loyal"
        else "VIP"
        end as customer_segment,
        count(tenure)as tenure
from customer_churn
group by customer_segment
order by tenure desc;
        
select 
	case 
    when tenure between 0 and 12 then "new"
	when tenure between 13 and 36 then "Regular"
    when tenure between 37 and 60 then "loyal"
    else "VIP"
    end as customer_segment,
    count(case when churn = "Yes" then 1 end)as churn_count,
    round(sum(case when churn = "Yes" then 1 end)*100.0/count(*),2)as churn_rate
from customer_churn
group by customer_segment;
    
        
select * from customer_churn;

create view Month_to_month_contract_cumulative_sum as
	(select 
	*,
    sum(totalcharges) over(partition by contract
    order by customerid asc)
    from customer_churn
	where contract = 'Month-to-month'
);
drop view Month_to_month_contract;

select * from Month_to_month_contract_cumulative_sum;


select contract,sum(totalcharges)
from customer_churn
group by contract;


create view One_year_contract_cumulative_sum as
(	
	select *,
    sum(totalcharges) over (partition by contract
    order by customerid asc)
    from customer_churn
    where contract = 'One year'
);
select * from One_year_contract_cumulative_sum;

create view Two_year_contract_cumulative_sum as
(
	select *,
    sum(totalcharges) over (partition by contract
    order by customerid asc)
    from customer_churn
    where contract = 'Two year'
);
select * from Two_year_contract_cumulative_sum;

create view Customer_churn_count as
(
	select 
    churn,
    count(churn)as churn_Count
    from customer_churn
    group by churn
);
select * from Customer_churn_count;

create view Male_revenue as
(
select gender,sum(totalcharges)as total_revenue
from customer_churn
where gender = 'Male'
group by gender
);
select * from Male_revenue;

create view Female_revenue as
(
select gender,sum(totalcharges)as total_revenue
from customer_churn
where gender = 'Female'
group by gender
);
select * from Female_revenue;

select customerID,tenure
from customer_churn
where tenure = (select max(tenure)from customer_churn);