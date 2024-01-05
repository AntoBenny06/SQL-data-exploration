SELECT * FROM NASH;
#convert into  standard date format
select saledate
from nash;

select cast(45.2 as signed);

select  saledate, cast(saleDate as date)as t_date
from nash;




SELECT 
    saledate, 
    CASE 
        WHEN `isdate`(saledate) = 1 THEN CAST(saledate AS DATE)
        ELSE NULL
    END AS t_date
FROM nash;

SELECT 
    SaleDate,
    STR_TO_DATE(saledate, '%M %e, %Y') AS bb
FROM nash;

update nash
set saledate = STR_TO_DATE(saledate, '%M %e, %Y') ;

select * from nash;

#property address data  
select  *
 from nash
 where PropertyAddress is  not null;


#Breaking out  address into individual coloums (address ,city,state)

select 
substring(propertyaddress,1,instr(propertyaddress,',')-1)as address,
substring(propertyaddress,instr(propertyaddress,',')+1)as city
 from nash;
 
 alter table nash
 add property_split_address varchar(300);
 
 update nash
 set property_split_address =substring(propertyaddress,1,instr(propertyaddress,',')-1);
 
  alter table nash
 add property_city varchar(300);
 
 update nash
 set property_city =substring(propertyaddress,instr(propertyaddress,',')+1);
 
 
select * from nash;


alter table nash
drop property_split_address;

alter table nash 
drop PropertyAddress;

select substring(OwnerAddress,instr(OwnerAddress,','))
FROM NASH

