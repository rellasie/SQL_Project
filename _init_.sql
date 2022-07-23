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

create table Daily_record(
	[UserID] int,
	[Date] date,
	[Cal_in] int,
	[Cal_burn] int,
	[Calories_balance] int, /* Calo_balance = Sum(Intake) - Sum(Outtake)*/
	constraint keyrecord primary key ([UserID], [Date]),
	constraint DailyData foreign key ([UserID]) references Users([UserID]) 
);


create table Food_list(
	[FoodID] int identity(1,1),
	[Food_name] varchar(255) not null unique,
	[Calories] int not null, /* The average amount of taken calories for each 100g*/
	constraint keyfood primary key ([FoodID])
);

create table Menu(
<<<<<<< HEAD
	[MenuID] int identity (1,1),
=======
	[MenuID] int identity(1,1),
>>>>>>> f9e5738d2e0b1ebaad5a7f80664034e057f2fc3e
	[FoodID] int not null,
	[Amount] int not null, 
	[Intake] int, /* Intake calories = Food(Calories) * Amount*/
	constraint PK_Menu primary key ([MenuID]),
	constraint FK_Menu foreign key ([FoodID]) references Food_list([FoodID])
);

create table Daily_Menu(
	[UserID] int,
	[Date] date,
	[MenuID] int,
	[cal_in] int,
	constraint Daily_menu_record primary key ([UserID],[Date],[MenuID]),
	constraint User_date_m foreign key ([UserID],[Date]) references Daily_record([UserID],[Date]),
	constraint Example_menu foreign key ([MenuID]) references Menu([MenuID])
);

create table Activity_list(
	[ActivityID] int identity(1,1),
	[Activity_name] varchar(255) not null unique,
	[Calories] int not null, /* The average amount of burnt calories for each min*/
	constraint keyact primary key ([ActivityID])
);

create table Workout(
<<<<<<< HEAD
	[ExerciseID] int identity (1,1),
=======
	[ExerciseID] int identity(1,1),
>>>>>>> f9e5738d2e0b1ebaad5a7f80664034e057f2fc3e
	[ActivityID] int not null,
	[Duration] int not null, /* time for each activity*/
	[Outtake] int, /* Outtake = Activity * duration */
	constraint PK_Workout primary key ([ExerciseID]),
	constraint FK_Workout foreign key ([ActivityID]) references  Activity_list([ActivityID])
);

create table Daily_Workout(
	[UserID] int,
	[Date] date,
	[ExerciseID] int,
	[cal_burn] int,
	constraint Daily_workout_record primary key ([UserID],[Date],[ExerciseID]),
	constraint User_date_w foreign key ([UserID],[Date]) references Daily_record([UserID],[Date]),
	constraint Example_Exercise foreign key ([ExerciseID]) references Workout([ExerciseID])
);

create table Suggestions(
	[Tier] int, /* 1 2 3 4 5*/
	[Message] varchar(255),
	constraint key_suggest primary key ([Tier])
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
	constraint foreignkey1 foreign key ([UserID]) references Users([UserID]),
	constraint foreignkey2 foreign key ([Tier]) references Suggestions([Tier])
);

