#Использовать asserts
#Использовать json
#Использовать "../src/"




Перем Логин Экспорт, Пароль Экспорт, АдресСистемы Экспорт, КукиДоступа Экспорт;
Перем СоотРеализованыхЗапросов;



Перем юТест;

Функция ПолучитьСписокТестов(Знач Тестирование) Экспорт
	
	юТест = Тестирование;
	
	ИменаТестов = Новый Массив;
	
	ИменаТестов.Добавить("ТестДолжен_ПроверитьИнициализациюКлассаПроект");
	ИменаТестов.Добавить("ТестДолжен_ПроверитьУстановкуДанныхВПроектПакетомJSON");
	
	
	Возврат ИменаТестов;
	
КонецФункции

Процедура ТестДолжен_ПроверитьИнициализациюКлассаПроект() Экспорт
	
	Проект = Новый Проект();
	Ожидаем.Что(ТипЗнч(Проект) = Тип("Проект")).Равно(Истина);
	Ожидаем.Что(Проект.key).ИмеетТип("Строка").Не_().Заполнено();
	Ожидаем.Что(Проект.id).ИмеетТип("Строка").Не_().Заполнено();
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьУстановкуДанныхВПроектПакетомJSON() Экспорт
	
	Проект = Новый Проект();
	
	ЭталонныйПакетJSON = "{
		|        ""expand"": ""description,lead,url,projectKeys"",
		|        ""self"": ""https://jira.zolotoy.ru/rest/api/2/project/11200"",
		|        ""id"": ""11200"",
		|        ""key"": ""TEST"",
		|        ""description"": """",
		|        ""lead"": {
		|            ""self"": ""https://jira.zolotoy.ru/rest/api/2/user?username=Buzmakov.Kirill"",
		|            ""key"": ""buzmakov.kirill"",
		|            ""name"": ""Buzmakov.Kirill"",
		|            ""avatarUrls"": {
		|                ""48x48"": ""https://jira.zolotoy.ru/secure/useravatar?ownerId=buzmakov.kirill&avatarId=11314"",
		|                ""24x24"": ""https://jira.zolotoy.ru/secure/useravatar?size=small&ownerId=buzmakov.kirill&avatarId=11314"",
		|                ""16x16"": ""https://jira.zolotoy.ru/secure/useravatar?size=xsmall&ownerId=buzmakov.kirill&avatarId=11314"",
		|                ""32x32"": ""https://jira.zolotoy.ru/secure/useravatar?size=medium&ownerId=buzmakov.kirill&avatarId=11314""
		|            },
		|            ""displayName"": ""Бузмаков Кирилл Васильевич"",
		|            ""active"": true
		|        },
		|        ""name"": ""Тестовый проект"",
		|        ""avatarUrls"": {
		|            ""48x48"": ""https://jira.zolotoy.ru/secure/projectavatar?avatarId=10324"",
		|            ""24x24"": ""https://jira.zolotoy.ru/secure/projectavatar?size=small&avatarId=10324"",
		|            ""16x16"": ""https://jira.zolotoy.ru/secure/projectavatar?size=xsmall&avatarId=10324"",
		|            ""32x32"": ""https://jira.zolotoy.ru/secure/projectavatar?size=medium&avatarId=10324""
		|        },
		|        ""projectKeys"": [
		|            ""TEST""
		|        ],
		|        ""projectTypeKey"": ""business""
		|    }";
		
	
	Проект.УстановитьДанные(ЭталонныйПакетJSON);
	
	Ожидаем.Что(Проект.id).ИмеетТип("Строка").Равно("11200");
	Ожидаем.Что(Проект.key).ИмеетТип("Строка").Равно("TEST");
	
	Ожидаем.Что(Проект.lead.name).ИмеетТип("Строка").Равно("Buzmakov.Kirill");
	
	
КонецПроцедуры