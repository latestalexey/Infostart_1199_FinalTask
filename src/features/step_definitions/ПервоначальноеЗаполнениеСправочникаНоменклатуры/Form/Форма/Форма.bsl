﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюДанныеВСправочникиИзФикстур()","ЯЗагружаюДанныеВСправочникиИзФикстур","Допустим Я загружаю данные в справочники из фикстур");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗагружаюДанныеВСправочникНоменклатурыИзФикстур()","ЯЗагружаюДанныеВСправочникНоменклатурыИзФикстур","Допустим Я загружаю данные в справочник номенклатуры из фикстур");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим Я загружаю данные в справочники из фикстур
//@ЯЗагружаюДанныеВСправочникНоменклатурыИзФикстур()
Процедура ЯЗагружаюДанныеВСправочникНоменклатурыИзФикстур() Экспорт
	
	ПутьДоФикстуры = ПолучитьПутьОтносительноКаталогаFeatures("fixtures\Номенклатура.xml");
	ЗагрузитьFixtureИзФайла(ПутьДоФикстуры);
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьПутьОтносительноКаталогаFeatures(ИмяФайлаСРасширением)
	
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	
	ПутьКТекущемуFeatureФайлу = СостояниеVanessaBehavior.ТекущаяФича.ПолныйПуть;
	
	Путь = Лев(ПутьКТекущемуFeatureФайлу, СтрНайти(ПутьКТекущемуFeatureФайлу, "features" ) - 1) + ИмяФайлаСРасширением;
	
	Возврат Путь;
	
КонецФункции

&НаКлиенте
Процедура ЗагрузитьFixtureИзФайла(ИмяФайла)
	
	Ванесса.ЗапретитьВыполнениеШагов();
	
	НачальноеИмяФайла = ПолучитьПутьОтносительноКаталогаFeatures("tools\Выгрузка и загрузка данных XML.epf");
	
	Адрес = "";
	
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗагрузитьFixtureИзФайлаЗавершение", ЭтотОбъект, ИмяФайла), Адрес, НачальноеИмяФайла, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьFixtureИзФайлаЗавершение(УдалосьПоместитьФайл, Адрес, ВыбранноеИмяФайла, ИмяФайла) Экспорт
	
	ЗагрузитьFixtureИзФайлаЗавершениеНаСервере(Адрес, ИмяФайла);
	
	Ванесса.ПродолжитьВыполнениеШагов();
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьFixtureИзФайлаЗавершениеНаСервере(Адрес, ИмяФайла)
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяВременногоФайла);
	
	ВнешняяОбработка = ВнешниеОбработки.Создать(ИмяВременногоФайла, Ложь);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
		
	ВременныйДокумент = Новый ТекстовыйДокумент;
	ВременныйДокумент.Прочитать(ИмяФайла);
	ВременныйДокумент.Записать(ИмяВременногоФайла, КодировкаТекста.UTF8 );
	
	ВнешняяОбработка.ВыполнитьЗагрузку(ИмяВременногоФайла);
	
КонецПроцедуры
//окончание текста модуля
