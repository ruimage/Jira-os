#Использовать asserts
#Использовать logos
#Использовать "../src"



Перем юТест;
Перем Лог;

Перем КлассJira;

Функция ПолучитьСтруктуруНастроек(ИмяФайлаНастроек)
	
	СтруктураНастроек = Новый Структура;
	
	ВыбФайл = Новый Файл(ИмяФайлаНастроек);
	
	Если ВыбФайл.Существует() Тогда
		ФайлОписания = Новый ТекстовыйДокумент;
		ФайлОписания.Прочитать(ИмяФайлаНастроек, КодировкаТекста.UTF8NoBOM);
		ТекстОписания = ФайлОписания.ПолучитьТекст();
		_преобразовательJSON = Новый ПарсерJSON();
		
		СтруктураНастроек = _преобразовательJSON.ПрочитатьJSON(ТекстОписания, , , Истина);
		
	КонецЕсли;
	

	Возврат СтруктураНастроек;
КонецФункции


Функция ПолучитьСписокТестов(Знач Тестирование) Экспорт
	
	юТест = Тестирование;
	
	ИменаТестов = Новый Массив;
	
	ИменаТестов.Добавить("ТестДолжен_ПроверитьИнициализациюКласса");
	
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьПолучитьIDПроектаПоИмени");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьПолучитьIDТипЗадачиИзПроектаПоИмени");
	
	
	ИменаТестов.Добавить("ТестДолжен_ПроверитьПоискJQL");
	ИменаТестов.Добавить("ТестДолжен_ПроверитьПолучитьПроблему");
	
	
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьСоздатьПроблему");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьНазначитьПроблему");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьУдалитьПроблему");
	
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьОтключитьУведомления");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьВключитьУведомления");
	
	
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьДобавитьКомментарий");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьПолучитьКомментарийПоКлючу");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьРедактироватьКомментарийПоКлючу");
	
	// ИменаТестов.Добавить("ТестДолжен_ПолучитьДоступныеПереходы");
	// ИменаТестов.Добавить("ТестДолжен_ОтправитьПроблемуПоПереходу");
	
	// ИменаТестов.Добавить("ТестДолжен_СоздатьПроект");
	// ИменаТестов.Добавить("ТестДолжен_УдалитьПроект");
	
	// ИменаТестов.Добавить("ТестДолжен_ДобавитьВложение");
	// ИменаТестов.Добавить("ТестДолжен_УдалитьВложение");
	
	
	
	Возврат ИменаТестов;
	
КонецФункции

Процедура ТестДолжен_ПроверитьИнициализациюКласса() Экспорт
	
	КлассJira = Новый Jira();
	СтруктураНастроек = ПолучитьСтруктуруНастроек("ConnSettings.json");
	
	Ожидаем.Что(ТипЗнч(КлассJira) = Тип("Jira")).Равно(Истина);
	Ожидаем.Что(КлассJira.АдресСистемы).Равно(СтруктураНастроек.АдресПодключения);
	Ожидаем.Что(КлассJira.Логин).Равно(СтруктураНастроек.Пользователь);
	Ожидаем.Что(КлассJira.Пароль).Равно(СтруктураНастроек.Пароль);
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьПоискJQL() Экспорт
	
	Если ТипЗнч(КлассJira) <> Тип("Jira") Тогда
		КлассJira = Новый Jira();
	КонецЕсли;
	
	СтрокаЗапросаJQL = "project = TEST AND status = ""To Do"" AND resolution = Unresolved ORDER BY key, updated DESC";
	
	МассивИменПолейОтбора = Новый Массив();
	МассивИменПолейОтбора.Добавить("key");
	МассивИменПолейОтбора.Добавить("summary");
	МассивИменПолейОтбора.Добавить("customfield_10901");
	
	Результат = КлассJira.НайтиПроблемыИспользуяJQL(СтрокаЗапросаJQL, МассивИменПолейОтбора, 1);
	
	Ожидаем.Что(Результат.issues[0].key).Равно("TEST-2");
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьПолучитьПроблему() Экспорт
	
	Если ТипЗнч(КлассJira) <> Тип("Jira") Тогда
		КлассJira = Новый Jira();
	КонецЕсли;
	
	КлючПроблемы = "TEST-2";
	Проблема = КлассJira.ПолучитьПроблему(КлючПроблемы);
	Ожидаем.Что(Проблема.fields.summary).ИмеетТип("Строка").Равно("Тест редактирование 4");
	
	КлючПроблемы = "TEST-2";
	Проблема = КлассJira.ПолучитьПроблему(КлючПроблемы, Новый Структура("fields", "summary,key,description"));
	
	Ожидаем.Что(Проблема.fields.summary).ИмеетТип("Строка").Равно("Тест редактирование 4");
	Ожидаем.Что(Проблема.key).ИмеетТип("Строка").Равно("TEST-2");
	Ожидаем.Что(Проблема.fields.description).ИмеетТип("Строка").Равно("тест описания ");
	
КонецПроцедуры


// Процедура ТестДолжен_ПроверитьСоздатьПроблему() Экспорт

// 	Если ТипЗнч(КлассJira) <> Тип("Jira") Тогда
// 		КлассJira = Новый Jira();
// 	КонецЕсли;

// 	ПараметрыПроблемы = Новый Структура();
// 	ПараметрыПроблемы.Вставить("ИмяПроекта" , "TEST");
// 	ПараметрыПроблемы.Вставить("ИмяТипаЗадачи" , "Задача");
// 	ПараметрыПроблемы.Вставить("ТемаПроблемы" , "Заголовок автоматичски созданный");


// 	Результат = КлассJira.СоздатьПроблему(ИмяПроекта, ТипЗадачи, ТемаПроблемы);
// 	Ожидаем.Что(Результат).ИмеетТип("Структура");
// 	Ожидаем.Что(Результат.Количество()).Равно(3);
// 	Ожидаем.Что(Результат.id).Заполнено();
// 	Ожидаем.Что(Результат.key).Заполнено();
// 	Ожидаем.Что(Результат.self).Заполнено();

// 	СозданнаяПроблема = КлассJira.ПолучитьПроблему(Результат.key);
// 	Ожидаем.Что(Результат.fields.summary).ИмеетТип("Строка").Равно("ТемаПроблемы");

// КонецПроцедуры

Процедура ТестДолжен_ПроверитьПолучитьIDПроектаПоИмени() Экспорт
	Если ТипЗнч(КлассJira) <> Тип("Jira") Тогда
		КлассJira = Новый Jira();
	КонецЕсли;

	ИмяПроекта = "TEST";
	Результат = КлассJira.ПолучитьIDПроектаПоИмени(ИмяПроекта);
	Ожидаем.Что(Результат).ИмеетТип("Строка").Равно("11200");
КонецПроцедуры

Процедура ТестДолжен_ПроверитьПолучитьIDТипЗадачиИзПроектаПоИмени() Экспорт
	Если ТипЗнч(КлассJira) <> Тип("Jira") Тогда
		КлассJira = Новый Jira();
	КонецЕсли;

	ИмяПроекта = "TEST";
	ИмяТипаЗадачи = "Задача";
	Результат = КлассJira.ПолучитьIDТипЗадачиИзПроектаПоИмени(ИмяПроекта , ИмяТипаЗадачи);
	Ожидаем.Что(Результат).ИмеетТип("Строка").Равно("10100");
КонецПроцедуры

ТестДолжен_ПроверитьИнициализациюКласса()