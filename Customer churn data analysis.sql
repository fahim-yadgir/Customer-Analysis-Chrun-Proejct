create database Customer_churn;
use customer_churn;

alter table `wa_fn-usec_-telco-customer-churn`
rename customer_churn;

select * from customer_churn;

alter table customer_churn
drop column MyUnknownColumn;

alter table customer_churn
drop column `MyUnknownColumn_[0]`;

alter table customer_churn
drop column `MyUnknownColumn_[1]`;

alter table customer_churn
drop column `MyUnknownColumn_[2]`;

select * from customer_churn;