create database weight_tracker /*Run this first*/
use weight_tracker /*After that, run this*/

/*Then run all lines below to create tables*/

create table Users(
	UserID int identity(1,1),
	username varchar(255) not null unique,
	email varchar(255) not null,
	passwrd varchar(255) not null,
	constraint keyuser primary key (UserID)
);

create table Body_index(
	[UserID] int identity(1,1),
	[Name] varchar (255) not null unique,
	[Sex] bit not null, /* 1 represent male, 0 represent female*/
	[Age] int not null,
	[Height] int not null,
	[Weight] int not null,
	[BMI] float, 
	[TDEE] float not null,
	[Normal_cal_burn] int,
	/* = (6.25*H + 10*W - 4.92*A + 5) * TDEE for male
	= (6.25*H + 10*W - 4.92*A -95) * TDEE for female */
	[Calories_balance] int, /*Update from the lastest daily record*/
	[Tier] int, /* 1 - 2 - 3 - 4 - 5, also update from Calories_balance*/
	constraint keyindex primary key ([UserID]),
	constraint foreignkey1 foreign key ([UserID]) references Users([UserID])
);

create table Food_list(
	[FoodID] int identity(1,1),
	[Food_name] varchar(255) not null unique,
	[Calories] int not null, /* The average amount of taken calories for each 100g*/
	constraint keyfood primary key ([FoodID])
);


create table Menu(
	[MenuID] int not null,
	[FoodID] int not null,
	[Amount] int not null, 
	[Intake] int, /* Intake calories = Food(Calories) * Amount*/
);


create table Activity_list(
	[ActivityID] int identity(1,1),
	[Activity_name] varchar(255) not null unique,
	[Calories] int not null, /* The average amount of burnt calories for each min*/
	constraint keyact primary key ([ActivityID])
);

create table Workout(
	[ExerciseID] int not null,
	[ActivityID] int not null,
	[Duration] int not null, /* time for each activity*/
	[Outtake] int, /* Outtake = Activity * duration */
);

create table Daily_record(
	[UserID] int,
	[Date] date not null,
	[MenuID] int not null, /*Can choose from menu list, or create a new one*/
	[ExerciseID] int not null, /*Can choose from workout list, or create a new one*/
	[Calories_balance] int, /* Calo_balance = Sum(Intake) - Sum(Outtake)*/
	constraint keyrecord primary key ([UserID], [Date])
);

create table Suggestions(
	[Tier] int, /* 1 2 3 4 5*/
	[Message] varchar(255),
	constraint key_suggest primary key ([Tier])
);
