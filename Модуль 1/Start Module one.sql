create database StudyT_SQL

use StudyT_SQL

create table Department (
	DepartmentId int identity(1,1) primary key,
	DepartmentName nvarchar(100)
)

create table Employee (
	EmployeeID int identity(1,1) primary key,
	Firstname nvarchar(50),
	LastName nvarchar(50),
	HireDate date,
	Salary decimal(10),
	DepartmentId int foreign key references Department(DepartmentId) 
)

insert into Department (DepartmentName) values 
	('Отдел развития и сопровождения информационных технологий'),
	('Отдел планирования производства ГАТ')

insert into Employee (
	Firstname, LastName, HireDate, Salary, DepartmentId
) values 
	('Николас', 'Грузных', '2004-12-02', 120000, 2),
	('Даниил', 'Кранчев', '1974-07-25', 200000, 2),
	('Регина', 'Пенчинских', '1985-02-08', 150000, 3)

--Пример 1: все сотрудники из IT
select 
	Firstname,
	LastName,
	Salary,
	DepartmentId
from Employee
where DepartmentId = 2

--Пример 2: top-2 по зарплате в целом
select top 2
	Firstname,
	LastName,
	Salary,
	DepartmentId
from Employee
order by salary desc

--Пример 3: все с зарплатой > 120000, отсортированные по дате найма
select 
	Firstname,
	LastName,
	Salary,
	HireDate
from Employee
where Salary > 120000
order by HireDate



