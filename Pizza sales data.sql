-- Q1. Retrieve the total number of orders placed.

select count(order_id) from "Orders";

-- Q2.Calculate the total revenue generated from pizza sales.

select 
"Order_details".quantity * "Pizza".price as total_sales
from "Order_details" join "Pizza"
on "Pizza".Pizza_id = "Order_details".Pizza_id


select 
sum("Order_details".quantity * "Pizza".price) as total_sales
from "Order_details" join "Pizza"
on "Pizza".Pizza_id = "Order_details".Pizza_id


-- Q3.Identify the highest-priced pizza.


select "Pizza_types".name, "Pizza".price
from "Pizza_types" join "Pizza"
on "Pizza_types".pizza_type_id = "Pizza".pizza_type_id
order by "Pizza".price desc limit 1;

-- Q4.Identify the most common pizza size ordered.

select quantity, count(order_details_id)
from "Order_details" group by quantity;

select "Pizza".size, count("Order_details".order_details_id) as order_count
from "Pizza" join "Order_details"
on "Pizza".pizza_id = "Order_details".pizza_id
group by "Pizza".size order by order_count desc ;


-- Q5.List the top 5 most ordered pizza types along with their quantities.

select "Pizza_types".name,
sum ("Order_details".quantity)quantity
from "Pizza_types" join "Pizza"
on "Pizza_types".pizza_type_id = "Pizza".pizza_type_id
join "Order_details"
on "Order_details".pizza_id = "Pizza".pizza_id
group by "Pizza_types".name order by quantity desc limit 5 ;


-- Q6. Join the necessary tables to find the total quantity of each pizza category ordered.


select "Pizza_types".category,
sum ("Order_details".quantity) as quantity
from "Pizza_types" join "Pizza"
on "Pizza_types".pizza_type_id = "Pizza".pizza_type_id
join "Order_details"
on "Order_details".pizza_id = "Pizza".pizza_id
group by "Pizza_types".category order by quantity desc ;


-- Q7. Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from "Pizza_types"
group by category;


-- Q8. Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity)) as Avg_Pizza_ordered_per_day
from 
(select "Orders".date, sum ("Order_details".quantity) as quantity
from "Orders" join "Order_details"
on "Orders".order_id = "Order_details".order_id
group by "Orders".date) as order_quantity;


-- Q9. Determine the top 3 most ordered pizza types based on revenue.


select "Pizza_types".name,
sum("Order_details".quantity * "Pizza".price) as revenue 
from "Pizza_types" join "Pizza" 
on"Pizza".pizza_type_id = "Pizza_types".pizza_type_id
join "Order_details"
on "Order_details".pizza_id = "Pizza".pizza_id
group by "Pizza_types".name order by revenue desc limit 3;


-- Q10. Calculate the percentage contribution of each pizza type to total revenue.


select "Pizza_types".category,
round(sum("Order_details".quantity * "Pizza".price) /(select round (sum("Order_details".quantity * "Pizza".price),2) as total_sales
from "Order_details" join "Pizza"
on "Pizza".Pizza_id = "Order_details".Pizza_id) * 100,2) as revenue
from "Pizza_types" join "Pizza" 
on"Pizza".pizza_type_id = "Pizza_types".pizza_type_id
join "Order_details"
on "Order_details".pizza_id = "Pizza".pizza_id
group by "Pizza_types".category order by revenue desc;


