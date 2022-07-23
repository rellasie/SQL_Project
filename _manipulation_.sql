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

/*Update Calorie Balance in table Daily Record */
select M.MenuID, sum(M.Intake) as cal_result 
into new_cal 
from Menu as M group by M.MenuID

update D
set D.[Calories_balance] = N.[cal_result]
from Daily_record D
inner join new_cal N
on D.MenuID = N.MenuID

drop table new_cal

select * from new_cal
select * from Daily_record

/*Update Calories_balance in Body_index table*/
select [UserID], max([Date]) as lasted_rec 
into new_rec from Daily_record group by [UserID]

select * from new_rec

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

/*Add a new excercise*/

/*Add a new daily record*/