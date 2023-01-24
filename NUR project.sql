-- showing all columns and rows in the table
select * 
from   NationalUniversitiesRankings;

-- Renaming the School column
alter TABLE   NationalUniversitiesRankings
RENAME COLUMN name to School_Name;

-- Changing data types of 3 columns to 'Numeric'
select cast(undergrad_enrollment as integer) 
from 		NationalUniversitiesRankings;
select cast(tuition_fee as integer) 
from 		NationalUniversitiesRankings;
select cast('in-state' as integer) 
from	 	NationalUniversitiesRankings;

--showing actual rankings
with cte1 as (
  SELECT *, row_number() over (partition by 'index' order by rank) as ranking 
  from 	NationalUniversitiesRankings)
SELECT * 
from 	cte1;

-- checking for duplicates
with cte as (
  SELECT *, row_number() over (partition by description order by 'index') as row_num 
  from NationalUniversitiesRankings)
SELECT * 
from 	cte
where 	row_num > 1;
-- No duplicates found !!!

-- Creating a new column 'St' 
alter TABLE NationalUniversitiesRankings
add 		St text ;

-- splitting the loacation column and copying the last two letters to the 'State' column
update NationalUniversitiesRankings
set 	St = substring(location, -2,2);

-- Testing the replace function for the state column
select Replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace
  		(replace(replace(replace(replace(replace(replace(replace(St, 'NJ', 'New Jersey')              
         ,'NM','New Mexico'),'WY','Wyoming'),'KY','Kentucky'),'ID','Idaho'),'HI','Hawaii'),'RI','Rhode Island')
        ,'MD','Maryland'),'AR','Arkansas'),'NE','Nebraska'),'OR','Oregon'),'VT','Vermont'),'OK','Oklahoma'),'IA','Iowa'),'DE','Delaware'),'ME','Maine'),'WA','Washington')
         ,'PA','Pennsylvania'),'MI','Michigan'),'MA','Massachusetts'),'NH','New Hampshire'),'ND','North Dakota'),'AK','Alaska'),'SD','South Dakota'),'WV','West Virginia')
         ,'AZ','Arizona'),'KS','Kansas'),'AL','Alabama'),'MT','Montana') as states1 
from 	NationalUniversitiesRankings;
          																					
select replace(replace(replace(replace(replace(replace(replace(replace
        (replace(replace(replace(replace(replace(replace(replace(replace(replace(replace                                                       
        (replace(REPLACE(replace(St,'CO','Colorado'),'TX','Texas'),'NY','New York'),'SC','South Carolina')
		,'OH','Ohio'),'GA','Gorgia'),'MS','Misissippi'),'TN','Tenessee'),'MN','Minnesota'),'UT','Utah')
        ,'WI','Wisconsin'),'NC','North Carolina'),'VA','Virginia'),'LA','Louisiana'),'FL','Florida')
         ,'IN','Indiana'),'MO','Missouri'),'CA','California'),'CT','Connecticut'),'MA','Massachusettes'),'IL','Illinois')                                      
         as states2 
from	 NationalUniversitiesRankings ;   

 --Creating a new column to store the full state names                                                                                                       
alter TABLE NationalUniversitiesRankings
add 		State text ;

-- Replacing the short text in the 'State' column to full texts using 'nested REPLACE' function
update NationalUniversitiesRankings
set 	State = Replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace
  		(replace(replace(replace(replace(replace(replace(St, 'NJ', 'New Jersey')              
         ,'NM','New Mexico'),'WY','Wyoming'),'KY','Kentucky'),'ID','Idaho'),'HI','Hawaii'),'RI','Rhode Island')
        ,'MD','Maryland'),'AR','Arkansas'),'NE','Nebraska'),'OR','Oregon'),'VT','Vermont'),'OK','Oklahoma'),'IA','Iowa'),'DE','Delaware'),'ME','Maine'),'WA','Washington DC')
         ,'PA','Pennsylvania'),'MI','Michigan'),'NH','New Hampshire'),'ND','North Dakota'),'AK','Alaska'),'SD','South Dakota'),'WV','West Virginia')
         ,'AZ','Arizona'),'KS','Kansas'),'AL','Alabama'),'MT','Montana');

update NationalUniversitiesRankings
set 	State = replace(replace(replace(replace(replace(replace(replace(replace(replace
        (replace(replace(REPLACE(replace(replace(replace(replace(replace(replace(replace(replace                                                       
        (replace(replace(State,'CO','Colorado'),'TX','Texas'),'NY','New York'),'SC','South Carolina')
		,'OH','Ohio'),'GA','Gorgia'),'MS','Misissippi'),'TN','Tenessee'),'MN','Minnesota'),'UT','Utah'),'NV','Nevada')
        ,'WI','Wisconsin'),'MO','Missouri'),'NC','North Carolina'),'VA','Virginia'),'LA','Louisiana'),'FL','Florida')
         ,'IN','Indiana'),'CA','California'),'CT','Connecticut'),'MA','Massachusettes'),'IL','Illinois')                                     

-- Dropping unwanted tables
alter TABLE NationalUniversitiesRankings
drop column 'in-state';

alter TABLE NationalUniversitiesRankings
drop column st;

alter TABLE NationalUniversitiesRankings
drop column description;

alter TABLE NationalUniversitiesRankings
drop column 'index';

-- showing top 10 schools with the highest tuition fees
SELECT school_name, location, tuition_fee 
from 	NationalUniversitiesRankings
group by tuition_fee
order by tuition_fee desc
LIMIT 10;

-- showing top 10 schools with the lowest tuition fees
SELECT school_name, location, tuition_fee 
from	 NationalUniversitiesRankings
group by tuition_fee
order by tuition_fee asc
LIMIT 10;

-- showing top 10 schools with the highest enrollees
SELECT school_name, location, undergrad_enrollment 
from 	NationalUniversitiesRankings
group by undergrad_enrollment
order by undergrad_enrollment desc
LIMIT 10;

-- showing top 10 schools with the lowest enrollees
SELECT school_name, location, undergrad_enrollment 
from 	NationalUniversitiesRankings
group by undergrad_enrollment
order by undergrad_enrollment asc
LIMIT 10;

-- showing top 5 States with the highest number of Schools
SELECT state, count(school_name) as 'num of schools' 
from 	NationalUniversitiesRankings
GROUP by state
order by COUNT(school_name) desc
limit 5;

-- showing the bottom 5 Universities
SELECT * 
from 	NationalUniversitiesRankings
group by school_name
order by rank desc
LIMIT 5;

-- showing the Top 5 Universities
SELECT * 
from 	NationalUniversitiesRankings
group by school_name
order by rank asc
LIMIT 5;

-- To view the final Table
SELECT * 
from 	NationalUniversitiesRankings
