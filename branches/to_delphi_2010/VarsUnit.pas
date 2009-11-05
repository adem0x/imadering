{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit VarsUnit;

interface

uses
  SysUtils,
  Classes,
  ExtCtrls,
  JvDesktopAlert,
  Graphics,
  GifImg,
  FloatingUnit;

const
  SecsPerDay = 86400;
  Hour = 3600000 / MSecsPerDay;
  Minute = 60000 / MSecsPerDay;
  Second = 1000 / MSecsPerDay;
  DTseconds = 1 / (SecsPerDay);
  DblClickTime = 0.6 * DTseconds;
  RN = #13#10;

  ProgramKey: string = '\SoftWare\IMadering';
  CProfile: string = 'ProfilePath';
  SettingsFileName: string = 'Profile\Settings.xml';
  GroupsFileName: string = 'Profile\Groups.xml';
  AnketaFileName: string = 'Profile\Contacts\';
  AvatarFileName: string = 'Profile\Avatars\';
  HistoryFileName: string = 'Profile\History\';

var
  // Переменные общие для всей программы
  MyPath: string;
  ProfilePath: string;
  CurrentIcons: string = 'Imadering';
  CurrentLang: string = 'Russian';
  CurrentSmiles: string = 'Imadering';
  CurrentSounds: string = 'Imadering';
  ProgramCloseCommand: Boolean = False;
  FirstStart: Boolean = False;
  TrayProtoClickMenu: string;
  AlphaBlendInactive: Boolean = False;
  RoasterAlphaBlend: Boolean = False;
  RoasterAlphaValue: Integer = 255;
  AccountToNick: TStringList;
  AvatarServiceDisable: Boolean = False;
  UpdateAuto: Boolean = True;
  UpdateVersionPath: string = 'Update_%s_%s.z';
  UpdateFile: TMemoryStream;
  NoReSave: Boolean = True;
  GroupHeaderColor: TColor = $00FFDEFF;
  RoasterReady: Boolean = False;
  CollapseGroupsRestore: Boolean = True;
  CompresHistoryProcess: boolean = false;
  FloatingFrm: TFloatingForm;

  // Статистика трафика
  TrafSend: Real;
  TrafRecev: Real;
  SesDataTraf: TDateTime;
  AllTrafSend: Real;
  AllTrafRecev: Real;
  AllSesDataTraf: string;

  // Переменные звуков
  SoundON: Boolean = True;
  SoundStartProg: Boolean = True;
  SoundStartProgPath: string = '';
  SoundIncMsg: Boolean = True;
  SoundIncMsgPath: string = '';

  // Переменные для языка
  RestoreFromTrayStr: string = 'Показать IMadering';
  HideInTrayStr: string = 'Скрыть IMadering';
  DevelMess: string = 'Данная функция находится в разработке! Следите за обновлениями проекта.';
  FirstStartNextButton: string = 'Далее';
  FirstStartProtoSelectAlert: string = 'Не выбран ни один протокол! В таком случае протокол ICQ будет выбран автоматически.';
  NewVersionIMaderingYES1: string = 'Доступна новая версия IMadering.' + #13#10 + #13#10 +
    'Для ознакомления зайдите на сайт www.imadering.com';
  NewVersionIMaderingYES2: string = 'Доступна новая сборка IMadering.' + #13#10 + #13#10 +
    'Для ознакомления зайдите на сайт www.imadering.com';
  NewVersionIMaderingNO: string = 'Новой версии не обнаружено.';
  NewVersionIMaderingErr: string = 'Ошибка получения данных о новой версии.';
  InformationHead: string = 'Информация';
  ErrorHead: string = 'Ошибка';
  AlertHead: string = 'Действие невозможно';
  WarningHead: string = 'Внимание!';
  ICQAccountInfo: string = 'Учётная запись ICQ#:';
  ICQAccountInfo_1: string = 'Перед тем как подключиться к ICQ серверу, сначала укажите в настройках свой ICQ номер и пароль!';
  JabberAccountInfo: string = 'Учётная запись JID:';
  JabberAccountInfo_1: string = 'Перед тем как подключиться к Jabber серверу, сначала укажите в настройках свой JID аккаунт и пароль!';
  PassLabelInfo: string = 'Пароль:';
  ParsingPktError: string = 'Неудалось произвести разбор пакета данных полученных от сервера.';
  SocketConnErrorInfo_1: string = 'Соединение не установлено.';
  RegNewAlert_1: string = 'Укажите пароль для новой учётной записи.';
  UnknownError: string = 'Неизвестная ошибка';
  AddContactError: string = 'Ошибка при добавлении контакта.';
  AddGroupError: string = 'Ошибка при добавлении группы.';
  DelGroupError: string = 'Ошибка при удалении группы.';
  ICQxUIN: string = 'Ваш номер ICQ используется на другом компьютере.';
  PassChangeAlert_1: string = 'Пароль не был изменён. Текущий или новый пароль введён неверно.';
  PassChangeAlert_2: string = 'Пароль изменён.';
  OnlineAlert: string = 'Для выполнения этого действия необходимо подключиться.';
  HideContactGroupCaption: string = 'Временные';
  NoInListGroupCaption: string = 'Не в списке';
  ConnTimeL: string = 'Подключён:';
  RegDateL: string = 'Рег. дата:';
  ChatDateL: string = 'Последний чат:';
  ProtoVerL: string = 'Версия протокола:';
  ClientVariableL: string = 'Возможный клиент:';
  CellularPhoneL: string = 'Сотовый:';
  NoteL: string = 'Заметка:';
  EmailL: string = 'Email:';
  ConnectFlagL: string = 'Флаг подключения:';
  UpDate1L: string = 'Обновить версию автоматически?';
  UpDate2L: string = 'На официальном сайте www.imadering.com доступно обновление программы IMadering';
  UpDate3L: string = 'Обновление';
  QReply1L: string = 'Привет!';
  QReply2L: string = 'Как дела?';
  QReply3L: string = 'Пока';
  HistoryDelL: string = 'Вы действительно хотите удалить историю сообщений?';
  CloseChatWindowsL: string = 'Собеседник закрыл окно чата!';
  TypingTextL: string = 'Печатает...';
  ClientL: string = 'Клиент:';
  StatusL: string = 'Статус:';
  OnlineInfo1L: string = 'Дата начала сбора статистики';
  OnlineInfo2L: string = 'Дней проведено в сети';
  OnlineInfo3L: string = 'Всего отправлено Away сообщений';
  OnlineInfo4L: string = 'URL ссылки от сервера';
  OnlineInfo5L: string = 'IP адрес ICQ сервера';
  OnlineInfo6L: string = 'Hash аватара';
  OnlineInfo7L: string = 'Записей в серверном списке контактов';
  PassChangeOKL: string = 'Пароль изменён';
  AnketaSaveOKL: string = 'Ваши данные успешно обновлены на сервере.';
  InfoOKL: string = 'Информация о контакте найдена!';
  InfoReqL: string = 'Получение информации...';
  InfoCaptionL: string = 'Информация о контакте';
  InfoNickL: string = 'Ник:';
  InfoNameL: string = 'Имя:';
  InfoHomeL: string = 'Дом:';
  InfoAdressL: string = 'Адрес:';
  InfoStateL: string = 'Штат:';
  InfoZipL: string = 'Индекс:';
  InfoGenderL: string = 'Пол:';
  InfoGender1L: string = 'Женский';
  InfoGender2L: string = 'Мужской';
  InfoAgeL: string = 'Возраст:';
  InfoBirDate: string = 'Дата рождения:';
  InfoOHomeL: string = 'Место рождения:';
  InfoWorkL: string = 'Работа:';
  InfoCompanyL: string = 'Компания:';
  InfoDeportL: string = 'Отдел:';
  InfoPositionL: string = 'Должность:';
  InfoOccupationL: string = 'Профессия:';
  InfoWebSiteL: string = 'Сайт:';
  InfoPhoneL: string = 'Телефон:';
  InfoFaxL: string = 'Факс:';
  InfoCellularL: string = 'Сотовый:';
  InfowPhoneL: string = 'Рабочий телефон:';
  InfowFaxL: string = 'Рабочий факс:';
  InfoInterestsL: string = 'Интересы:';
  InfoAboutL: string = 'О себе:';
  InfoHomePageL: string = 'Домашняя страничка:';
  InfoLastUpDateL: string = 'Дата последнего обновления данных:';
  InfoLangL: string = 'Владение языками:';
  InfoMaritalL: string = 'Брак:';
  InfoSexualL: string = 'Сексуальная ориентация:';
  InfoHeightL: string = 'Рост:';
  InfoReligL: string = 'Религия:';
  InfoSmokL: string = 'Курение:';
  InfoHairL: string = 'Цвет волос:';
  InfoChildrenL1: string = 'Детей:';
  InfoChildrenL2: string = 'Более, чем 8';
  InfoChildrenL3: string = 'Нет';
  DellContactL: string = 'Контакт "%s" будет удалён. Вы уверены?';
  DellGroupL: string = 'Группа "%s" будет удалёна. Вы уверены?';
  DellYourSelfL: string = 'Удалить себя из списка контакта: %s. Вы уверены?';
  HistoryNotFileL: string = 'История сообщений с этим контактом отсутствует';
  GroupInv: string = ' из ';
  HistorySearchNoL: string = 'Такой текст не найден.';
  HistoryLoadFileL: string = 'Загружается история...';
  UpDateStartL: string = 'Загрузка обновления...';
  UpDateAbortL: string = 'Загрузка обновления прервана.';
  UpDateLoadL: string = 'Файл обновления успешно получен.';
  UpDateUnL: string = 'Установка обновления...';
  UpDateOKL: string = 'Установка обновления завершена.' + #13#10 + #13#10 +
    'Для завершения обновления необходимо перезапустить программу IMadering!';
  ProxyConnectErrL1: string = 'Неверный логин или пароль для прокси.';
  ProxyConnectErrL2: string = 'Неизвестная прокси ошибка.';
  JabberLoginErrorL: string = 'Неправильный JID или пароль.';
  HttpSocketErrCodeL: string = 'Код ошибки: %d';
  SelectDirL: string = 'Выберите папку для хранения вашего профиля';
  DelProfile: string = 'Удалить старый профиль?';
  URLOpenErrL: string = 'Браузер для открытия ссылки не найден.' + #13#10 + 'Ссылка скопирована в буфер обмена.';
  SearchInfoGoL: string = 'Идёт поиск ...';
  SearchInfoEndL: string = 'Поиск завершён';
  SearchInfoNoL: string = 'Не найден';
  SearchInfoAuthL: string = 'Авторизация';
  SearchInfoAuthNoL: string = 'Не нужна';
  SearchNextPage1: string = 'Далее';
  SearchNextPage2: string = 'Страница - %d';
  SearchQMessL: string = 'Быстрое сообщение';
  AddContactErr1: string = 'Такой контакт уже существует в вашем списке контактов.';
  AddContactErr2: string = 'Пожалуйста, дождитесь окончания предыдущей операции с серверным списком контактов.';
  AddContactErr3: string = 'Сначала создайте хоть одну группу';
  AddContactErr4: string = 'Ошибка при добавлении контакта.';
  AddContactOKL: string = 'Контакт успешно добавлен в ваш список контактов!';
  AddNewGroupL: string = 'Новая группа';
  AddNewGroupErr1: string = 'Такая группа уже существует в вашем списке контактов.';
  AddNewGroupErr2: string = 'Ошибка при добавлении группы.';
  DellGroupErrL: string = 'Ошибка при удалении группы.';
  DellGroupOKL: string = 'Группа успешно удалена из вашего списка контактов!';
  AddNewGroupOKL: string = 'Группа успешно добавлена в ваш список контактов!';
  JabberNullGroup: string = 'Общая';
  FileTransfer1L: string = 'Отправка для:';
  FileTransfer2L: string = 'Передача файла ...';
  FileTransfer3L: string = 'Передача файла завершена';
  FileTransfer4L: string = 'Передача файла отменена';
  FileTransfer5L: string = 'Ссылка для скачивания файла: %s' + RN + '%s' + RN + '[ Файл отправлен через %s. Подробнее на сайте: %s ]';
  SocketL: string = 'Сокет:';
  HistoryCompressedL: string = 'Создан архив с историей сообщений. Для просмотра предыдущей истории сообщений откройте архив в окне просмотра истории.';

  // Ошибки подключения ICQ протокола
  ConnectErrors_0001: string = 'Неправильный номер ICQ или пароль.';
  ConnectErrors_0002: string = 'Сервис временно недоступен.';
  ConnectErrors_0003: string = 'Ошибка авторизации.';
  ConnectErrors_0004: string = 'Неверный номер ICQ или пароль.';
  ConnectErrors_0005: string = 'Неверный номер ICQ или пароль.';
  ConnectErrors_0006: string = 'Внутренняя ошибка.';
  ConnectErrors_0007: string = 'Это неверная учётная запись.';
  ConnectErrors_0008: string = 'Эта учётная запись была удалена.';
  ConnectErrors_0009: string = 'Это просроченная учётная запись.';
  ConnectErrors_000A: string = 'Нет доступа к базе.';
  ConnectErrors_000B: string = 'Нет доступа к резольверу.';
  ConnectErrors_000C: string = 'Неверные поля в базе данных.';
  ConnectErrors_000D: string = 'Неверный статус базы.';
  ConnectErrors_000E: string = 'Неверный статус резольвера.';
  ConnectErrors_000F: string = 'Внутренняя серверная ошибка.';
  ConnectErrors_0010: string = 'Сервис временно отключён.';
  ConnectErrors_0011: string = 'Обслуживание этой учётной записи приостановлено.';
  ConnectErrors_0012: string = 'Ошибка перенаправления в базе.';
  ConnectErrors_0013: string = 'Ошибка линковки в базе.';
  ConnectErrors_0014: string = 'Ошибка резервной схемы.';
  ConnectErrors_0015: string = 'Ошибка резервной линковки.';
  ConnectErrors_0016: string = 'Достигнут предел подключений с этого IP-адреса.';
  ConnectErrors_0017: string = 'Достигнут предел подключений с этого IP-адреса.';
  ConnectErrors_0018: string = 'Превышен лимит подключений! Попробуйте подключиться позже.';
  ConnectErrors_0019: string = 'Эта учётная запись имеет наивысший уровень предупреждений. Попробуйте позже.';
  ConnectErrors_001A: string = 'Превышен интервал резервации в базе.';
  ConnectErrors_001B: string = 'Вы используете старую версию клиента. Обновите версию.';
  ConnectErrors_001C: string = 'Вы используете старую версию клиента. Рекомендуется обновить версию.';
  ConnectErrors_001D: string = 'Превышен лимит подключений! Попробуйте подключиться позже.';
  ConnectErrors_001E: string = 'Невозможно зарегистрироваться в сети. Попробуйте позже.';
  ConnectErrors_0020: string = 'Неверный SecureID.';
  ConnectErrors_0022: string = 'Эта учётная запись недоступна из-за вашего возраста (меньше 13).';

  // Основные статусы плюс расширенные из QIP
  LStatus1: string = 'Готов поболтать';
  LStatus2: string = 'Злой';
  LStatus3: string = 'Депрессия';
  LStatus4: string = 'Дома';
  LStatus5: string = 'На работе';
  LStatus6: string = 'Кушаю';
  LStatus7: string = 'Отошёл';
  LStatus8: string = 'Недоступен';
  LStatus9: string = 'Занят';
  LStatus10: string = 'Не беспокоить';
  LStatus11: string = 'В сети';
  LStatus12: string = 'Невидимый';
  LStatus13: string = 'Невидимый для всех';
  LStatus14: string = 'Не в сети';
  LStatus15: string = 'Неопределённый';
  LStatus16: string = 'Нестабильный';
  LStatus17: string = 'Необходима авторизация';

  // Ошибки http сокетов
  Err400: string = 'Неверный запрос.';
  Err401: string = 'Несанкционированно.';
  Err402: string = 'Требуется оплата.';
  Err403: string = 'Запрещено.';
  Err404: string = 'Не найдено.';
  Err405: string = 'Метод не допускается.';
  Err406: string = 'Не приемлемо.';
  Err407: string = 'Требуется авторизация на прокси.';
  Err408: string = 'Время ожидания запроса истекло.';
  Err409: string = 'Конфликт.';
  Err410: string = 'Удален.';
  Err411: string = 'Требуется длина.';
  Err412: string = 'Предусловие неверно.';
  Err413: string = 'Объект запроса слишком большой.';
  Err414: string = 'URI запроса слишком большой.';
  Err415: string = 'Неподдерживаемый тип медиа.';
  Err416: string = 'Диапазон не отвечает требованиям.';
  Err417: string = 'Результат не соответствует ожидаемому.';
  Err500: string = 'Внутренняя ошибка сервера.';
  Err501: string = 'Не реализовано.';
  Err502: string = 'Ошибка шлюза.';
  Err503: string = 'Сервис недоступен.';
  Err504: string = 'Истекло время ожидания от шлюза.';
  Err505: string = 'Не поддерживаемая версия HTTP.';

  // Переменные оформления всплывающих подсказок
  FDAOptions: TJvDesktopAlertOptions;
  DACount: Integer = 0;
  DATimeShow: Integer = 7000;
  DAPos: Integer = 3;
  DAStyle: Integer = 0;

  // Переменные для окна чата
  NoAvatar: TImage;
  OutMessage2: TMemoryStream;
  OutMessage3: TMemoryStream;
  XStatusImg: TBitmap;
  XStatusGif: TGifImage;
  XStatusMem: TMemoryStream;
  QReplyAutoSend: Boolean = False;
  SmilesList: TStringList;
  InMessList: TStringList;
  TextSmilies: Boolean = False;
  YouAt: string = 'Я';
  ChatFontSize: string = '9';
  GetCityPanel: string;
  GetAgePanel: string;

  // Список для отображения в About
  AboutList: array [1 .. 14] of string = (
    'Автор проекта и ведущий программист;Эдуард Толмачёв',
    'Программирование;Максим Нижник',
    'Программирование;Francois PIETTE (Ics components)',
    'Программирование;David Baldwin (HTML components)',
    'Программирование;Project Jedi (jvcl components)',
    'Программирование;Михаил Власов (SimpleXML компонент)',
    'Программирование;Polaris Software (rXML компонент)',
    'Программирование;Igor Pavlov (7-Zip компонент)',
    'Дизайн;Пётр Степанов',
    'Дизайн;Michael Niedermayr (www.greensmilies.com)',
    'Тестирование и поддержка;Павел Новиков',
    'Специальная благодарность;Маргарита Евдокимова',
    'Специальная благодарность;Светлана Пономарева',
    'IMadering;Спасибо всем!'
  );

  // Http прокси для сокетов протоколов
  HttpProxy_Enable: Boolean = False;
  HttpProxy_Address: string;
  HttpProxy_Port: string;
  HttpProxy_Auth: Boolean = False;
  HttpProxy_Login: string;
  HttpProxy_Password: string;

  // Для Лога
  LogMyPath: string = 'Путь к программе: ';
  LogProfile: string = 'Путь к профилю: ';
  LogIconCount: string = 'Загружено %d иконок';
  LogNickCash: string = 'Количество ников в файле кэша: ';
  LogSmiliesCount: string = 'Количество загруженных смайликов: ';
  LogRosterCount: string = 'Количество записей в файле кэша списка контактов: ';
  Log_Jabber_Connect: string = 'Jabber | Подключение к jabber серверу: ';
  Log_ICQ_Connect: string = 'ICQ | Подключение к ICQ серверу: ';
  Log_MRA_Connect: string = 'MRA | Подключение к MRA серверу: ';
  Log_HTTP_Proxy_Connect: string = 'Подключение к прокси: ';
  Log_Login: string = 'Логин для авторизации: ';
  Log_Set_Status: string = 'Выбран статус: ';
  Log_Jabber_Plain: string = 'Jabber | Авторизация по механизму PLAIN';
  Log_MD5_Nonce: string = 'Получен ключ для MD5 авторизации: ';
  Log_Clear: string = 'Лог событий автоматически очищен.';
  Log_Exception1: string = 'В программе произошла ошибка:' + RN;
  Log_Exception2: string = RN + 'Вы можете скопировать её от сюда и выложить для разработчиков на форуме проекта IMadering ' +
    'c описанием действий в следствии которых возникла данная ошибка. Или уведомить об ошибке любым другим способом.';
  Log_Proxy_OK: string = 'Подключение к прокси установлено успешно.';
  Log_Server_Hello: string = 'Получено приглашение сервера.';
  Log_Get_Server: string = 'Получен адрес сервера: ';
  Log_Unk_Data: string = 'Получены неизвестные или неважные данные:';
  Log_Close_Server: string = 'Сеанс связи с сервером заверщён.';
  Log_Get_CL: string = 'Получен список контактов.';
  Log_ConnTime: string = 'Время подключения: ';
  Log_UIN_RegTime: string = 'Дата регистрации: ';
  Log_Ext_IP: string = 'Внешний IP: ';
  Log_Int_IP: string = 'Внутренний IP: ';
  Log_Icon_Hash: string = 'Хэш аватар:';
  Log_User_Online_Event: string = 'Получен пакет онлайн статуса от контакта: ';
  Log_User_Offline_Event: string = 'Получен пакет оффлайн статуса от контакта: ';
  Log_UserClass: string = 'Класс контакта: ';
  Log_ConnFlag: string = 'Флаг подключения: ';
  Log_ProtoVer: string = 'Версия протокола: ';
  Log_Status: string = 'Код статуса: ';
  Log_TimeInOnline: string = 'Время проведённое в онлайн: ';
  Log_ReqMessage: string = 'Получен пакет с сообщением от контакта: ';
  Log_Msg_Chanel: string = 'Канал сообщения: ';
  Log_Msg_Type: string = 'Тип сообщения: ';
  Log_Msg_Text: string = 'Текст сообщения:';
  Log_Connect_Count: string = 'Количество подключений к серверу: ';

  // Подсказки <b></b><br>
  H_Log_Clear: string = '<b>Очистить</b><br>Удалить все сообщения лога';
  H_Log_Write: string = '<b>Запись в лог</b><br>Разрешить или приостановить запись событий в лог';
  H_Log_ICQ: string = '<b>Дампы ICQ</b><br>Включить или выключить<br>отображение в логе данных протокола';
  H_Log_Jabber: string = '<b>Дампы Jabber</b><br>Включить или выключить<br>отображение в логе данных протокола';
  H_Log_MRA: string = '<b>Дампы MRA</b><br>Включить или выключить<br>отображение в логе данных протокола';
  H_Sound: string = '<b>Звуки</b><br>Включить или выключить озвучивание событий';
  H_OnlyOnline: string = '<b>Оффлайн контакты</b><br>Показывать или скрывать отключенные контакты';
  H_GroupCL: string = '<b>Группы контактов</b><br>Показывать или скрывать группы';
  H_TopPanel: string = '<b>Верхняя панель</b><br>Показать или скрыть панель';
  H_Main_Button: string = '<b>Главное меню</b><br>Доступ к основным пунктам';
  H_Privat_Button: string = '<b>Приватные списки</b><br>Управление списками приватности';
  H_History_Button: string = '<b>История сообщений</b><br>Просмотр архивов переписки';
  H_Setting_Button: string = '<b>Настройки</b><br>Открыть окно настроек программы';
  H_Traf_Button: string = '<b>Трафик</b><br>Открыть статистику потраченного трафика';
  H_Smilies_Button: string = '<b>Смайлы</b><br>Открыть окно выбора смайлика';
  H_Q_Button: string = '<b>Цитировать</b><br>Вставить последнее полученное сообщение';
  H_Qrep_Button: string = '<b>Готовые ответы</b><br>Открыть меню выбора шаблона ответа';
  H_Chat_History_Button: string = '<b>История сообщений</b><br>Просмотр архивов переписки<br><br>' +
    'Клик правой клавишей мыши откроет меню<br>выбора подгрузки истории сообщений в чат';
  H_FileSend_Button: string = '<b>Отправить файл</b><br>Открыть меню выбора способа передачи файла';
  H_Chat_Clear_Button: string = '<b>Очистить</b><br>Скрыть сообщения текущего чата';
  H_Info_Button: string = '<b>Анкета</b><br>Открыть анкетную информацию о контакте';
  H_CEdit_Button: string = '<b>Редактировать</b><br>Изменить параметры контакта';
  H_Font_Button: string = '<b>Текст</b><br>Настройки шрифта и цвета текста';
  H_CMenu_Chat: string = '<b>Меню контакта</b><br>Управление текущим контактом';
  H_Chat_Setting: string = '<b>Настройки</b><br>Открыть настройки окна чата';
  H_Send_Enter: string = '<b>Отправлять по Enter</b><br>Включить или выключить отправку сообщения клавишей Enter<br><br>' +
    'Иначе отправка сообщения по нажатию клавиш Ctrl + Enter';
  H_Typing_Notify: string = '<b>Уведомлять о наборе</b><br>Включить или выключить отправку<br>собеседнику уведомлений о наборе текста';
  H_Sound_Key: string = '<b>Звук набора</b><br>Включить или выключить озвучку нажатия клавиш';
  H_GTrans_Button: string = '<b>Переводчик</b><br>Автоматически переводить сообщения на иностранные языки<br>используя онлайн сервис Google переводчик';

  // Информационные поля
  Info_About: string = 'Эта программа создана для изучения и тестирования возможности взаимодействия с популярными протоколами передачи мгновенных сообщений в сети интернет.' +
    RN + 'Проект с открытым исходным кодом.';
  Info_SendICQDump: string = 'Внимание! Эта функция предназначена для очень опытных пользователей. Используйте её только если вы точно знаете, что вы делаете. Последствия могут быть непредсказуемые.';

implementation

end.
