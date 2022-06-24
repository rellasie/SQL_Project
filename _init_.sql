create database weight_tracker
use weight_tracker

create table Users(
	UserID int identity(1,1),
	username varchar(255) not null unique,
	email varchar(255) not null,
	passwrd varchar(255) not null,
	constraint keyuser primary key (UserID)
);

create table Body_index(
	[UserID] int unique,
	[Sex] bit not null, /* 1 represent male, 0 represent female*/
	[Age] int not null,
	[Height] int not null,
	[Weight] int not null,
	[BMI] float,
	[TDEE] float not null,
	Normal_cal_burn int
	constraint keyindex primary key ([UserID]),
	constraint foreignkey1 foreign key ([UserID]) references Users([UserID])
);

create table Food_list(
	[FoodID] int identity(1,1),
	[Food_name] varchar(255) not null,
	[Calories] int not null, /* The average amount of taken calories for each 100g*/
	constraint keyfood primary key ([FoodID])
);


create table Menu(
	[MenuID] int not null,
	[FoodID] int not null,
	[Amount] int not null, 
	[Intake] int, /* Intake calories = Food(Calories) * Amount*/
	constraint key_menu primary key ([MenuID]),
	constraint foreign_food_key foreign key ([FoodID]) references Food_list([FoodID])
);

create table Activity_list(
	[ActivityID] int identity(1,1),
	[Activity_name] varchar(255) not null,
	[Calories] int not null, /* The average amount of burnt calories for each min*/
	constraint keyact primary key ([ActivityID])
);

create table Workout(
	[ExerciseID] int not null,
	[ActivityID] int not null,
	[Duration] int not null, /* time for each activity*/
	[Outtake] int, /* Outtake = Activity * duration */
	constraint key_workout primary key ([ExerciseID]),
	constraint foreign_act_key foreign key ([ActivityID]) references Activity_list([ActivityID])
);

create table Daily_record(
	[UserID] int,
	[Date] date not null,
	[MenuID] int not null,
	[ExerciseID] int not null,
	[Calories_balance] int, /* Calo_balance = Sum(Intake) - Sum(Outtake)*/
	constraint keyrecord primary key ([UserID], [Date]),
	constraint foreignkey_daily foreign key ([UserID]) references Users([UserID]),
	constraint foreignkey_menu foreign key ([MenuID]) references Menu([MenuID]),
	constraint foreignkey_workout foreign key ([ExerciseID]) references Workout([ExerciseID])
);

create table Suggestions(
	[Tier] int, /* 1 2 3 4 5*/
	[Message] varchar(255),
	constraint key_suggest primary key ([Tier])
);

create table Sort_tier(
	[UserID] int unique,
	[Date] date not null,
	[BMI] float not null,
	[Calories_balance] int not null,
	[Normal_cal_burn] int not null,
	[Tier] int,
	constraint key_sort primary key ([UserID],[Date]),
	constraint foreign_sort_index foreign key ([UserID]) references Body_index([UserID]),
	constraint foreign_sort_daily foreign key ([UserID], [Date]) references Daily_record([UserID], [Date])
);