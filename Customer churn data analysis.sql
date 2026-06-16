create database Customer_churn;
use customer_churn;

alter table `wa_fn-usec_-telco-customer-churn`
rename customer_churn;

select * from customer_churn;

