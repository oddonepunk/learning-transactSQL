create table Category (
	CategoryId int identity(1,1) primary key,
	CategoryName nvarchar(100)
)

create table Product (
	ProductId int identity(1,1) primary key,
	ProductName nvarchar(50),
	CategoryId int foreign key references Category(CategoryId),
	Price decimal(10,2),
	StockQuantity int
)
insert into Category values 
	('Смартфоны'),
	('Ноутбуки'),
	('Телевизоры'),
	('Холодильники'),
	('Кондиционеры'),
	('Игровые консоли'),
	('Видеоигры'),
	('Смартфоны'),
	('Ноутбуки')

insert into Product (	
	ProductName,
	CategoryId,
	Price,
	StockQuantity
) values 
	('Apple iPhone 15 Pro Max', 1, 119999.99, 26),
	('MacBook Air M3', 2, 149999.99, 20),
	('LG OLED C3 65', 3, 78999.99, 11),
	('Samsung Bespoke AI', 4, 99999.99, 20),
	('Daikin FTXM', 5, 44999.99, 50),
	('Sony PlayStation 5 Slim', 6, 51999.99, 27),
	('Cyberpunk 2077: Phantom Liberty', 7, 3499.99, 20),
	('Samsung Galaxy S24 Ultra', 1, 82999.99, 23)

--Выбрать все товары категории "Смартфоны".

select 
	ProductName,
	CategoryId, 
	Price
from Product
where CategoryId = 1

--Выбрать товары с ценой от 50000 до 100000.

select 
	p.ProductName,
	c.CategoryName,
	p.Price
from Product p
join Category c (nolock) on c.CategoryId = p.CategoryId
where p.Price between 50000 and 100000

--Выбрать топ-3 самых дорогих товара.
select top 3
	ProductName,
	Price
from Product
order by price desc

--Выбрать товары, у которых на складе меньше 21 единиц.
select 
	ProductName,
	StockQuantity
from Product
where StockQuantity < 21

--Выбрать уникальные категории товаров (используйте DISTINCT).
select distinct
	CategoryName
from Category

/* Допустим, у нас есть таблица Category с миллионом записей, 
среди которых дубликаты названий. И есть Product, который ссылается на CategoryId. Правильный алгоритм:*/

--Для каждого название оставляем минимальный CategoryId (самый старый/первый)

;with Duplicates as(
	select 
		CategoryName,
		min(CategoryId) KeepId
	from Category
	group by CategoryName
	Having count(*) > 1 --только те, у которых есть дубликаты
)
--Шаг 2 - переназначить товары с дублирующими id на "живой" id

update p set
	CategoryId = d.keepId
from Product p
join category c on c.CategoryId = p.CategoryId
join Duplicates d on c.CategoryName = d.CategoryName
where c.CategoryId != d.KeepId --перепривязка только тех товаров, что висят в лишних категориях


--Шаг 3 удаляем дубликаты из таблицы категорий
;with Duplicates as (
	select 
		CategoryName,
		min(CategoryId) keepId
	from Category 
	group by CategoryName 
	having count(*) > 1
)
delete from Category
where CategoryId in(
	select CategoryId
	from Category c
	join Duplicates d on d.CategoryName = c.CategoryName
	where c.CategoryId != d.KeepId
)

--вешаем уникальный индекс
alter table Category 
add constraint  UQ_Category_Name UNIQUE (CategoryName)


--Выбрать товары, название которых начинается на букву "С" (используйте LIKE 'С%').

select 
	ProductName
from Product
where ProductName like 'C%'

--Пометка, процент в like  работает так, если ставишь перед ним, то будет...объясни короче, или это в другом уроке будет?

--Выбрать товары, отсортированные сначала по категории (A-Z), а затем по убыванию цены

select 
	p.ProductName,
	c.CategoryName
from Product p
join Category c (nolock) on c.CategoryId = p.CategoryId
order by CategoryName asc, price desc

/*Напишите один запрос, который покажет: ProductName, Price и новую колонку PriceWithVAT = Price * 1.20.
Отфильтруйте так, чтобы остались только товары с ценой после НДС > 10008*/

select *
from (
	select
		ProductName,
		Price,
		Price * 1.20 PriceWithVAT
	from Product
) pn
where PriceWithVAT > 90000
