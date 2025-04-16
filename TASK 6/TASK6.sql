create database DB2
USE DB2 
select * from sales
limit 5

SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(Date, '%d-%m-%Y')) AS year,
    EXTRACT(MONTH FROM STR_TO_DATE(Date, '%d-%m-%Y')) AS month,
    SUM(Total) AS monthly_revenue,
    COUNT(DISTINCT Invoice_ID) AS order_volume
FROM 
    sales
WHERE 
    STR_TO_DATE(Date, '%d-%m-%Y') IS NOT NULL
GROUP BY 
    year, month
ORDER BY 
    year, month;


