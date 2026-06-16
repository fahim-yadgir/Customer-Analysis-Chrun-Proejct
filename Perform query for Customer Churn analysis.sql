select customerID , churn,count(*)as total_count
from customer_churn
group by customerID,churn
order by total_count desc;

select count(*)as total_count
,sum(case when churn = 'Yes' then 1 else 0 end) as total_churn
from customer_churn;


select * from customer_churn
where TotalCharges = '' and null;

update customer_churn
set TotalCharges = ''
where customerID = '7590-VHVEG';

SET SQL_SAFE_UPDATES = 1;

