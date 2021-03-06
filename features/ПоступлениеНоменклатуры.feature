﻿# encoding: utf-8
# language: ru

@tree

Функционал: Оформление поступления номенклатуры

Как Оператор
Я хочу Оформлять документы Покупки в базе 
Чтобы Вести учет поступившей номенклатуры 

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Оформление поступления номенклатуры
 
	Допустим В справочнике Номенклатура есть элементы
		Когда Я нажимаю кнопку командного интерфейса "Номенклатура"
		Тогда таблица формы с именем "Список" стала равной:
			| 'Код'       | 'Наименование'        |
			| '000000002' | 'Вафли 'Счестье''     |
			| '000000004' | 'Зефир 'Радуга''      |
			| '000000001' | 'Конфеты 'Радость''   |
			| '000000003' | 'Пастила 'Благодать'' |
			
		Когда открылось окно "Номенклатура"
		Тогда Я закрываю окно "Номенклатура"
		
	Теперь Я удалю все документы поступления
		Допустим Я удаляю все документы вида "Покупка"
		
	Теперь Я создаю новый документ Покупка
		Когда Я нажимаю кнопку командного интерфейса "Покупка"
		Тогда открылось окно "Покупка"
		И Я нажимаю на кнопку "Создать"
		
	Затем Я добавляю в документ поступившую номенклатуру
		Когда открылось окно "Покупка (создание)"
		И в ТЧ "Состав" я нажимаю на кнопку "Добавить"
		И в ТЧ "Состав" я выбираю значение реквизита "Номенклатура" из формы списка
		
		Тогда открылось окно "Номенклатура"
		И В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'      |
		| '000000001' | 'Конфеты 'Радость'' |
		И     я нажимаю на кнопку "Выбрать"
		
		Тогда открылось окно "Покупка (создание) *"
		И в ТЧ "Состав" я активизирую поле "Количество"
		И в ТЧ "Состав" в поле "Количество" я ввожу текст "11"
		И я перехожу к следующему реквизиту
		И в ТЧ "Состав" я активизирую поле "Сумма"
		И в ТЧ "Состав" в поле "Сумма" я ввожу текст "110"
		И в форме "Покупка (создание) *" в ТЧ "Состав" я завершаю редактирование строки
		
		Когда в ТЧ "Состав" я нажимаю на кнопку "Добавить"
		И в ТЧ "Состав" я выбираю значение реквизита "Номенклатура" из формы списка
		
		Тогда открылось окно "Номенклатура"
		И в форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000004' | 'Зефир 'Радуга'' |
		И я нажимаю на кнопку "Выбрать"
		
		Тогда открылось окно "Покупка (создание) *"
		И в ТЧ "Состав" я активизирую поле "Количество"
		И в ТЧ "Состав" в поле "Количество" я ввожу текст "22"
		И я перехожу к следующему реквизиту
		И в ТЧ "Состав" я активизирую поле "Сумма"
		И в ТЧ "Состав" в поле "Сумма" я ввожу текст "440"
		И в форме "Покупка (создание) *" в ТЧ "Состав" я завершаю редактирование строки
		
	И Провожу документ
	
		Когда открылось окно "Покупка (создание) *"
		И я нажимаю на кнопку "Провести"
	
	Тогда Данные успешно отразились в базе
	
		Когда открылось окно "Покупка * от *"
		И в текущем окне я нажимаю кнопку командного интерфейса "Остатки номенклатуры"
		
		Тогда таблица формы с именем "Список" стала равной:
		| 'Номенклатура'          | 'Номер строки' | 'Сумма'  | 'Количество' |
		| 'Конфеты 'Радость''     | '1'            | '110,00' | '11,00'      |
		| 'Зефир 'Радуга''        | '2'            | '440,00' | '22,00'      |
		
		И я закрываю окно "Покупка * от *"


	