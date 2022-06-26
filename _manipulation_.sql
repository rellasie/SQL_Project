use weight_tracker

/*Update BMI index = weight /(height^2) with weight in kg, height in m*/
update Body_index set [BMI] = [Weight]*10000/([Height]*[Height])
select * from [Body_index]

/*Update calorie balance for table daily record*/
select [MenuID] from Daily_record
select * from Menu

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

/*Update Calories_balance*/
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
