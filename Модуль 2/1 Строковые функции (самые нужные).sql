---Модуль 2: Функции, NULL и приведение типов

/*
	Чистить и трансформировать строки, даты, числа

	Грамотно работать с NULL (это ловит 90% новичков)

	Переводить данные из одного типа в другой
*/

--Строковые функции (самые нужные)

--Len() - длина строки
select 
	ProductName,
	Len(ProductName) NameLength
from Product

--upper()/ lower() - регистр

select 
	upper(ProductName) upName,
	lower(ProductName) lowName
from Product

--left()/right() -первые/последние N символов

select
	left(ProductName, 5) leftName,
	right(ProductName, 3) rightName
from Product


--substring() - вырезаем из середины. substring(строка, начальная позиция, длина)
select 
	ProductName,
	SUBSTRING(ProductName, 7, 6) sub
from Product
where ProductName like 'Apple%'

--charindex() - позиция подстроки

select 
	ProductName,
	CHARINDEX(' ', ProductName) firstSpacePosition
from Product

--replace() - замена

select 
	REPLACE(ProductName, ' ', '_') withUnderscore
from Product

--Trim() - убираем пробелы по краям

select TRIM('   ODDONE   ') unSpace

--CONCAT() - безопасное склеинвание (не боится NULL)

select 
	CONCAT(ProductName, ' (цена: ', Price, ')') FullDescr
from Product