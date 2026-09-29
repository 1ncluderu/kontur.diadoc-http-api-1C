// Copyright 2026 Alexander Smirnov
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
//
// URL:    https://github.com/1ncluderu/kontur.diadoc-http-api-1C
// e-mail: fen1xfsg@ymail.com
// Версия: -

//@skip-check undefined-variable

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#Область БазовыеОбъекты

Перем CURRENT_ORGANIZATION;
Перем CURRENT_CERTIFICATE;
Перем CURRENT_CERIFICATE_PASSWORD;

#КонецОбласти

#Область КонстантыДополнительнойИнформации

Перем ORGANIZATION_INFO;

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Версия интерфейса.
// 
// Возвращаемое значение:
//  Строка - Версия интерфейса
Функция ВерсияИнтерфейса() Экспорт
	
	Возврат "1";
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Криптография

Функция МенеджерКриптографии_Новый()
	
	ПутиМодуляКриптографии = Новый Соответствие();
	ПутиМодуляКриптографии.Вставить(ТипПлатформы.Linux_x86, "/opt/cprocsp/lib/ia32/libcapi20.so:/opt/cprocsp/lib/ia32/libcapi10.so");
	ПутиМодуляКриптографии.Вставить(ТипПлатформы.Linux_x86_64, "/opt/cprocsp/lib/amd64/libcapi20.so:/opt/cprocsp/lib/amd64/libcapi10.so");
	ПутиМодуляКриптографии.Вставить(ТипПлатформы.MacOS_x86, "/opt/cprocsp/lib/libcapi20.dylib:/opt/cprocsp/lib/libcapi10.dylib");
	ПутиМодуляКриптографии.Вставить(ТипПлатформы.MacOS_x86_64, "/opt/cprocsp/lib/libcapi20.dylib:/opt/cprocsp/lib/libcapi10.dylib");
	
	СистемнаяИнформация = Новый СистемнаяИнформация;
	ПутьМодуляКриптографии = ПутиМодуляКриптографии[СистемнаяИнформация.ТипПлатформы];
	Если ПутьМодуляКриптографии = Неопределено Тогда
		ПутьМодуляКриптографии = "";
	КонецЕсли;
	
	НовыйМенеджерКриптографии = Новый МенеджерКриптографии("", ПутьМодуляКриптографии, 80, ИспользованиеИнтерактивногоРежимаКриптографии.НеИспользовать);
	
	Если ЗначениеЗаполнено(CURRENT_CERIFICATE_PASSWORD) Тогда
		НовыйМенеджерКриптографии.ПарольДоступаКЗакрытомуКлючу = CURRENT_CERIFICATE_PASSWORD;
	КонецЕсли;
	 
	Возврат НовыйМенеджерКриптографии;

КонецФункции

Функция МенеджерКриптографии_Подписать(ДвоичныеДанные)

	МенеджерКриптографии = МенеджерКриптографии_Новый();
	Возврат МенеджерКриптографии.Подписать(ДвоичныеДанные, CURRENT_CERTIFICATE);
	
КонецФункции

Функция МенеджерКриптографии_Расшифровать(ДвоичныеДанные)

	МенеджерКриптографии = МенеджерКриптографии_Новый();
	Возврат МенеджерКриптографии.Расшифровать(ДвоичныеДанные, CURRENT_CERTIFICATE);
	
КонецФункции

#КонецОбласти

#Область Окружение

Процедура ОчиститьОкружение()
	
	CURRENT_ORGANIZATION = Неопределено;
	CURRENT_CERTIFICATE = Неопределено;
	CURRENT_CERIFICATE_PASSWORD = Неопределено;
	ORGANIZATION_INFO = Неопределено;
	
КонецПроцедуры

Процедура ИнициализироватьОкружение()
	
	// Заменить на свой алгоритм инициализации
	
	//	

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область Инициализация

Если CURRENT_ORGANIZATION <> Организация Тогда
	
	ОчиститьОкружение();
	
	Если ЗначениеЗаполнено(Организация) Тогда
		ИнициализироватьОкружение();
	КонецЕсли;
	
КонецЕсли;

#КонецОбласти

#КонецЕсли