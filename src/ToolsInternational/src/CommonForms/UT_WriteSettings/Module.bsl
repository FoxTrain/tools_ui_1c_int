#Область ОписаниеПеременных

&НаКлиенте
Перем мПоследнийUUID;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	UT_CommonClientServer.SetOnFormWriteParameters(ЭтотОбъект, Параметры.ПараметрыЗаписи, "");
	
	UT_CodeEditorServer.ФормаПриСозданииНаСервере(ЭтотОбъект);
	UT_CodeEditorServer.СоздатьЭлементыРедактораКода(ЭтотОбъект, "Редактор", Элементы.ПолеАлгоритмаПередЗаписью);
	
	Если Параметры.Свойство("ТипОбъекта") Тогда
		ТипОбъекта = Параметры.ТипОбъекта;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ПриОткрытии(Отказ)
	UT_CodeEditorClient.FormOnOpen(ЭтотОбъект, Новый ОписаниеОповещения("ПриОткрытииЗавершение",ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт

КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Применить(Команда)
<<<<<<< HEAD
	ПроцедураПередЗаписью = UT_CodeEditorClient.ТекстКодаРедактора(ЭтотОбъект, "Редактор");
<<<<<<< HEAD
<<<<<<< HEAD
=======
	ПроцедураПередЗаписью = UT_CodeEditorClient.EditorCodeText(ЭтотОбъект, "Редактор");
>>>>>>> parent of 962f542 (Merge remote-tracking branch 'origin/develop' into develop)
=======
>>>>>>> parent of 099b94f (Merge branch 'i-neti:develop' into develop)
=======
>>>>>>> parent of 099b94f (Merge branch 'i-neti:develop' into develop)
	Закрыть(UT_CommonClientServer.ПараметрыЗаписиФормы(ЭтотОбъект, ""));
КонецПроцедуры

&НаКлиенте
Процедура ВставитьУникальныйИдентификатор(Команда)
	ТекДанные = Элементы.ДополнительныеСвойства.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ДопПараметрыОповещения=Новый Структура;
	ДопПараметрыОповещения.Вставить("ТекущаяСтрока", Элементы.ДополнительныеСвойства.ТекущаяСтрока);

	ПоказатьВводСтроки(Новый ОписаниеОповещения("ОбработатьВводУникальногоИдентификатора", ЭтаФорма,
		ДопПараметрыОповещения), мПоследнийUUID, "Введите уникальный идентификатор", , Ложь);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработатьВводУникальногоИдентификатора(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;

	Попытка
		пЗначение = Новый УникальныйИдентификатор(Результат);
		мПоследнийUUID = Результат;
	Исключение
		ПоказатьПредупреждение( , "Значение не может быть преобразовано в Уникальный идентификатор!", 20);
		Возврат;
	КонецПопытки;

	ТекДанные = ДополнительныеПараметры.НайтиПоИдентификатору(ДополнительныеПараметры.ТекущаяСтрока);
	Если ТекДанные <> Неопределено Тогда
		ТекДанные.Значение = пЗначение;
	КонецЕсли;
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораДокументСформирован(Элемент)
	UT_CodeEditorClient.HTMLEditorFieldDocumentGenerated(ЭтотОбъект, Элемент);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	UT_CodeEditorClient.HTMLEditorFieldOnClick(ЭтотОбъект, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяИнициализацияРедакторов()
	UT_CodeEditorClient.CodeEditorDeferredInitializingEditors(ЭтотОбъект);
КонецПроцедуры

//@skip-warning
&НаКлиенте 
Процедура Подключаемый_РедакторКодаЗавершениеИнициализации() Экспорт
	UT_CodeEditorClient.SetEditorText(ЭтотОбъект, "Редактор", ПроцедураПередЗаписью);
	
	ДобавляемыйКонтекст = Новый Структура;
	Если ТипОбъекта <> Новый ОписаниеТипов Тогда
		ДобавляемыйКонтекст.Вставить("Объект", ТипОбъекта.Типы()[0]);
	Иначе
		ДобавляемыйКонтекст.Вставить("Объект");
	КонецЕсли;
	UT_CodeEditorClient.AddCodeEditorContext(ЭтотОбъект, "Редактор", ДобавляемыйКонтекст);
КонецПроцедуры

#КонецОбласти




