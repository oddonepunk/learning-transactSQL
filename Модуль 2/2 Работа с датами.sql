--2 Работа с датами


/*
	Сразу скажу, нельзя создавать таблицы и сущности во множественном ключе, 
	правило хорошего тона, в данном случае было сделано исключение, т.к системное слово
*/
create table Orders (

	OrderId int primary key identity(1,1),
	ProductId int foreign key references Product(ProductId),
	OrderDate datetime default getdate(),
	Quantity int
)

insert into Orders values 
(1,'2024-01-15 10:30:00', 2),
(2, '2024-02-20 14:45:00', 1),
(3, '2024-03-10 09:00:00', 5),
(4, '2025-06-14 16:20:00', 3);

select * from Orders