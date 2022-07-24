use weight_tracker


/*Update BMI index = weight /(height^2) with weight in kg, height in m*/
update Body_index set [BMI] = [Weight]*10000/([Height]*[Height])
select * from [Body_index]


/*Update Intake calo in table Menu*/
update M 
set M.[Intake] = M.[Amount] * F.[Calories] 
from Menu M
inner join Food_list F
on M.FoodID = F.FoodID

/*Update Outtake calo in table Workout*/
update W 
set W.[Outtake] = W.[Duration] * A.[Calories] 
from Workout W
inner join Activity_list A
on W.ActivityID = A.ActivityID


/*Update Calories_balance in Body_index table*/
select [UserID], max([Date]) as lasted_rec 
into new_rec from Daily_record group by [UserID]

---select * from new_rec

alter table new_rec add lasted_calo int

update R
set R.[lasted_calo] = D.[Calories_balance]
from new_rec R
inner join Daily_record D
on D.[UserID] = R.[UserID] and D.[Date] = R.[lasted_rec]

update B
set B.[Calories_balance] = R.[lasted_calo]
from Body_index B
inner join new_rec R
on B.UserID = R.[UserID]

drop table new_rec

/*Update normal calorie burnt for table Body_index*/
Update Body_index ---- height in cm, weight in kg
set [Normal_cal_burn] = (6.25 *[Height] + 10*[Weight] - 4.92* [Age] + 5) * [TDEE] ---- for man
where [Sex] = 1

Update Body_index
set [Normal_cal_burn] = (6.25 *[Height] + 10*[Weight] - 4.92* [Age] -95) * [TDEE] ---- for woman
where [Sex] = 0

select * from Body_index

/* Update tier*/
update Body_index
set [tier] = 1
where [BMI] < 18.5 and ([Calories_balance]-[Normal_cal_burn]) <50

update Body_index
set [tier] = 2
where [BMI] <18.5 and ([Calories_balance]-[Normal_cal_burn]) >= 50

update Body_index
set [tier] = 3
where [BMI] >= 18.5 and [BMI] <25

update Body_index
set [tier] = 4
where [BMI] >= 25 and ([Calories_balance]-[Normal_cal_burn]) <-50

update Body_index
set [tier] = 1
where [BMI] >=25 and ([Calories_balance]-[Normal_cal_burn]) >-50

update Body_index
set [tier] = 1
where [BMI] < 18.5 and ([Calories_balance]-[Normal_cal_burn]) <50

/*Record of one user*/
select distinct B.[Name], D.[Date], D.[Calories_balance] from Daily_record D, Body_index B
where B.UserID = D.UserID -- Can change D.UserID with specific userid

/*What is on his/her menu*/
select B.[Name], D.[Date], F.[Food_name] 
from Food_list F, Menu M, Daily_record D, Body_index B
where F.[FoodID] = M.[FoodID] and D.[MenuID] = M.[MenuID] and D.[UserID] = B.[UserID] and B.[UserID] = '3'


/*What is his/her suggestion right now*/
select B.[Name], B.[BMI], S.[Message] 
from Body_index B, Suggestions S 
where /*B.[Calories_balance] is not null  and */ B.[Tier] = S.[Tier] and B.[Name] = 'Tran Lyn Lyn'--- can be change with another name

/*Register new user*/
INSERT INTO Users(UserID ,username , email , passwrd ) 
VALUES ( ' ',' ' ,' ' , ' '),
( ' ',' ' ,' ' , ' ')
/*Change PW */
UPDATE  Users SET passwrd = ' ' WHERE UserID = ''

/*Add food to Food_list*/
INSERT INTO Food_list ( Food_name , Calories ) 
VALUES ( ' ' , '' ),
( ' ' , '' )

/*Add activity to Activity_list*/
INSERT INTO Activity_list ( Activity_name , Calories ) 
VALUES ( ' ' , '' ),
( ' ' , '' )

/*Add a new menu*/
declare @number_input int = 3; ---- number of dish in this menu

declare @new_menuid int;
set @new_menuid = (SELECT TOP 1 [MenuID] FROM Menu ORDER BY [MenuID] DESC) + 1;
print @new_menuid
go

declare @temp_index int = 1;
declare @add_foodid int;
declare @add_amount int;
WHILE @temp_index < @number_input
BEGIN
   insert into Menu([MenuID], [FoodID], [Amount]) ---- User input FoodID and their Amount
   values
   (@new_menuid, @add_foodid, @add_amount)

   SET @temp_index = @temp_index + 1;
END;





-- Update DailyRecord
update Dr
set Dr.[Cal_in] = Calcin.[Calcsum]
from [dbo].[Daily_record] Dr
 inner join (select Dm.[UserID], Dm.[Date], sum(M.[Intake]) Calcsum
from [dbo].[Daily_Menu] Dm inner join [dbo].[Menu] M
on Dm.[MenuID] = M.[MenuID] 
group by Dm.[UserID], Dm.[Date]) as Calcin
on Calcin.[UserID] = Dr.[UserID] and Calcin.[Date] = Dr.[Date]

update Dr
set Dr.[Cal_burn] = Calcburn.[Calcsum]
from [dbo].[Daily_record] Dr
 inner join (select Dw.[UserID], Dw.[Date], sum(W.[Outtake]) Calcsum
from [dbo].[Daily_Workout] Dw inner join [dbo].[Workout] W
on Dw.[ExerciseID] = W.[ExerciseID] 
group by Dw.[UserID], Dw.[Date]) as Calcburn
on Calcburn.[UserID] = Dr.[UserID] and Calcburn.[Date] = Dr.[Date]

update [dbo].[Daily_record]
set [Calories_balance] = [Cal_in] - [Cal_burn]



--- SP for update tier after adding new record
GO
IF EXISTS(SELECT name FROM sysobjects
WHERE name='update_index' AND type='P')
DROP PROCEDURE update_index
GO
CREATE PROCEDURE update_index --- update calo balance --> update index
AS
BEGIN
select [UserID], max([Date]) as lasted_rec 
into new_rec from Daily_record group by [UserID]

alter table new_rec add lasted_calo int

update R
set R.[lasted_calo] = D.[Calories_balance]
from new_rec R
inner join Daily_record D
on D.[UserID] = R.[UserID] and D.[Date] = R.[lasted_rec]

update B
set B.[Calories_balance] = R.[lasted_calo]
from Body_index B
inner join new_rec R
on B.UserID = R.[UserID]

drop table new_rec

update Body_index
set [tier] = 1
where [BMI] < 18.5 and ([Calories_balance]-[Normal_cal_burn]) <50

update Body_index
set [tier] = 2
where [BMI] <18.5 and ([Calories_balance]-[Normal_cal_burn]) >= 50

update Body_index
set [tier] = 3
where [BMI] >= 18.5 and [BMI] <25

update Body_index
set [tier] = 4
where [BMI] >= 25 and ([Calories_balance]-[Normal_cal_burn]) <-50

update Body_index
set [tier] = 5
where [BMI] >=25 and ([Calories_balance]-[Normal_cal_burn]) >-50
END
GO

--- SP to update Body_index after changing Weight, Height, Age, TDEE
--- recalc BMI
--- recalc Normal_cal_burn
--- recalc Tier (using SP update_index)
GO
IF EXISTS(SELECT name FROM sysobjects
WHERE name='recalc_index' AND type='P')
DROP PROCEDURE recalc_index
GO 
CREATE PROCEDURE recalc_index 
AS
BEGIN
--- recalc BMI
update Body_index set [BMI] = [Weight]*10000/([Height]*[Height])
select * from [Body_index]

--- recalc Normal_cal_burn
Update Body_index ---- height in cm, weight in kg
set [Normal_cal_burn] = (6.25 *[Height] + 10*[Weight] - 4.92* [Age] + 5) * [TDEE] ---- for man
where [Sex] = 1

Update Body_index
set [Normal_cal_burn] = (6.25 *[Height] + 10*[Weight] - 4.92* [Age] -95) * [TDEE] ---- for woman
where [Sex] = 0

---recalc Tier
exec update_index

END
GO
