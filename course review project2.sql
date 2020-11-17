/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [studentID]
      ,[First_name]
      ,[Lastname]
      ,[Midtermexam]
      ,[Finalexam]
      ,[assignment1]
      ,[assignment2]
      ,[Totalpoints]
      ,[Studentaverage]
      ,[Grade]
  FROM [ProjectReview2].[dbo].[gradeRecordModuleV]

  use ProjectReview2

  select distinct studentID FROM gradeRecordModuleV

 --deleting duplicate--
with cte as (
  select *, row_number() over(
  partition by studentID 
  order by studentID)row_num 
from gradeRecordModuleV)
select *
FROM cte
where row_num >1

update gradeRecordModuleV
set studentID = 77777
where studentID = 35932 and First_name= 'Tallulah' and Lastname = 'Lynes'

update gradeRecordModuleV
set studentID = 88888
where studentID = 47058 and First_name= 'Jaye' and Lastname = 'Margett'

update gradeRecordModuleV
set studentID = 99999
where studentID = 64698 and First_name= 'Claudian' and Lastname = 'Burree'

select * from gradeRecordModuleV

--creating ID Table --

select studentID, First_name, Lastname 
into ID_Table 
from gradeRecordModuleV

alter table ID_Table
add primary key (studentID)

select* from ID_Table

-- creating Record Table from --
select studentID, Midtermexam , Finalexam, assignment1, assignment2, Totalpoints, Grade
into Record_Table 
from gradeRecordModuleV 

----------------------------------------
alter table Record_Table
add RecordID int identity(1,1)
-----------------------------------------
alter table Record_Table
add primary key(RecordID)

-------------------------------------------
alter table Record_Table
add foreign key (Grade)
references GradeRange_Table(Grade)

-----------------------------------------------------
alter table Record_Table
add foreign key (studentID)
references ID_Table(studentID)
----------------------------------------------------------
select * from Record_Table


select * from gradeRecordModuleV

-- checking grade range Grade Table  --

select  min(Totalpoints) Minimum, max(Totalpoints) Maximum
from gradeRecordModuleV 
group by Grade order by grade

select distinct Grade from gradeRecordModuleV
order by Grade

-- creating Grade Range Table starting from A+ to F --
create table GradeRange_Table ( Grade nvarchar(50) not null,
                           Max_Grade int,
						   Min_Grade int)

insert into GradeRange_Table values ( 'A+', '400', '388')
insert into GradeRange_Table values ( 'A', '387', '372')
insert into GradeRange_Table values ( 'A-', '371', '360')
insert into GradeRange_Table values ( 'B+', '359', '348')
insert into GradeRange_Table values ( 'B', '347', '332')
insert into GradeRange_Table values ( 'B-', '331', '320')
insert into GradeRange_Table values ( 'C+', '319', '308')
insert into GradeRange_Table values ( 'C', '307', '292')
insert into GradeRange_Table values ( 'C-', '291', '280')
insert into GradeRange_Table values ( 'D+', '279', '268')
insert into GradeRange_Table values ( 'D', '267', '252')
insert into GradeRange_Table values ( 'D-', '251', '240')
insert into GradeRange_Table values ( 'F', '239', '0')

select * from GradeRange_Table

alter table GradeRange_Table
add primary key(Grade)
--------------------------------------------------------------------------------------------------------
select * from gradeRecordModuleV order by studentID
select* from ID_Table
select * from Record_Table
select * from GradeRange_Table
