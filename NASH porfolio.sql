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
FROM NASH;
 
  SELECT 
  TRIM(SUBSTRING_INDEX(owneraddress, ',', -1)) AS state
FROM nash;

alter  table nash
add state varchar (300);
 
 alter table nash
 drop state;
 
 update nash
 set state =TRIM(SUBSTRING_INDEX(owneraddress, ',', -1));
 
alter table  nash
change state  owner_state varchar (300);

select
TRIM(SUBSTRING_INDEX(owneraddress, ',', 1)) as 
from nash;

alter table  nash
add owner_splitaddress varchar (200);

update nash
set owner_splitaddress =TRIM(SUBSTRING_INDEX(owneraddress, ',', 1));

select * from nash;

select
(SUBSTRING_INDEX(owneraddress, ',', -1)) as ownercity
from nash;


SELECT 
  SUBSTRING_INDEX(SUBSTRING_INDEX(owneraddress, ',', 2), ',', -1) AS owner_split_city
FROM nash;

alter table nash
add owner_split_city varchar(200);

update nash
set owner_split_city =SUBSTRING_INDEX(SUBSTRING_INDEX(owneraddress, ',', 2), ',', -1);


select distinct(SoldAsVacant),count(SoldAsVacant)
from nash
group by SoldAsVacant
order by 2;

select 
SoldAsVacant,
case
 when SoldAsVacant='y' then 'yes'
 when SoldAsVacant = 'N' Then 'No'
 else SoldAsVacant
 end as solddetails
 from nash;
 
 update nash
 set soldasvacant =  
case
 when SoldAsVacant='y' then 'yes'
 when SoldAsVacant = 'N' Then 'No'
 else SoldAsVacant
 end; 
 
 #remove duplicates

with RownumCTE AS(
select *,
row_number() over( partition by 
parcelid,
property_split_address,
saleprice,
legalreference
order by uniqueID) 
as rownum
FROM nash
order by ParcelID)

select *
from RownumCTE
WHERE rownum >1;


         select * from(

             select * ,row_number()
             over
             (partition by parcelid,
              property_split_address,
              saleprice,
              legalreference)as bbc
			   from nash) as ab
where ab.bbc>1 ;	


#delete unused columns
alter table nash
drop column SaleDate;
select * from nash;




