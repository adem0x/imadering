{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit VarsUnit;

interface

uses
  SysUtils, Classes, ExtCtrls, JvDesktopAlert, Graphics;

const
  Bild_Version = '5.0.0 alpha';
  Update_Version = 500;
  PassKey = 12345;

const
  SecsPerDay = 86400;
  Hour = 3600000 / MSecsPerDay;
  Minute = 60000 / MSecsPerDay;
  Second = 1000 / MSecsPerDay;
  DTseconds = 1 / (SecsPerDay);
  dblClickTime = 0.6 * DTseconds;

var
  //--Переменные общие для всей программы
  MyPath: string;
  ProfilePath: string;
  ProgramKey: string = '\SoftWare\IMadering';
  cProfile: string = 'ProfilePath';
  CurrentIcons: string = 'Imadering';
  CurrentLang: string = 'Russian';
  CurrentSmiles: string = 'Imadering';
  CurrentSounds: string = 'Imadering';
  ProgramCloseCommand: boolean = false;
  FirstStart: boolean = false;
  TrayProtoClickMenu: string;
  AlphaBlendInactive: boolean = false;
  RoasterAlphaBlend: boolean = false;
  RoasterAlphaValue: integer = 255;
  AccountToNick: TStringList;
  AvatarServiceDisable: boolean = false;
  UpdateAuto: boolean = true;
  SettingsFileName: string = 'Profile\IMadeSettings.xml';
  UpdateVersionPath: string = 'Update_%s_%s.z';
  UpdateFile: TMemoryStream;
  NoReSave: boolean = true;
  ZipThreadStop: boolean = false;
  GroupHeaderColor: TColor = $00FFEAFF;
  RoasterReady: boolean = false;

  //--Статистика трафика
  TrafSend: real;
  TrafRecev: real;
  SesDataTraf: TDateTime;
  AllTrafSend: real;
  AllTrafRecev: real;
  AllSesDataTraf: string;

  //--Переменные звуков
  SoundON: boolean = true;
  SoundStartProg: boolean = true;
  SoundStartProgPath: string = '';
  SoundIncMsg: boolean = true;
  SoundIncMsgPath: string = '';

  //--Переменные для языка
  RestoreFromTrayStr: string = 'Показать IMadering';
  HideInTrayStr: string = 'Скрыть IMadering';
  DevelMess: string = 'Данная функция находится в разработке! Следите за обновлениями проекта.';
  SoundOnHint: string = '<b>Включить звуки</b>';
  SoundOffHint: string = '<b>Отключить звуки</b>';
  OnlyOnlineOn: string = '<b>Показать оффлайн контакты</b>';
  OnlyOnlineOff: string = '<b>Скрыть оффлайн контакты</b>';
  GroupCLOn: string = '<b>Показывать группы контактов</b>';
  GroupCLOff: string = '<b>Скрывать группы контактов</b>';
  TopPanelOn: string = '<b>Показать верхнюю панель</b>';
  TopPanelOff: string = '<b>Скрыть верхнюю панель</b>';
  FirstStartNextButton: string = 'Далее';
  FirstStartProtoSelectAlert: string = 'Не выбран ни один протокол! В таком случае протокол ICQ будет выбран автоматически.';
  NewVersionIMaderingYES1: string = 'Доступна новая версия IMadering.' + #13#10 + #13#10 + 'Для ознакомления зайдите на сайт www.imadering.com';
  NewVersionIMaderingYES2: string = 'Доступна новая сборка IMadering.' + #13#10 + #13#10 + 'Для ознакомления зайдите на сайт www.imadering.com';
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
  DellYourSelfL: string = 'Удалить себя из списка контакта: %s. Вы уверены?';
  HistoryNotFileL: string = 'История сообщений с этим контактом отсутствует';
  GroupInv: string = ' из ';
  HistorySearchNoL: string = 'Такой текст не найден.';
  HistoryLoadFileL: string = 'Загружается история...';
  UpDateStartL: string = 'Загрузка обновления...';
  UpDateAbortL: string = 'Загрузка обновления прервана.';
  UpDateLoadL: string = 'Файл обновления успешно получен.';
  UpDateUnL: string = 'Установка обновления...';
  UpDateOKL: string = 'Установка обновления завершена.' + #13#10 + #13#10 + 'Для завершения обновления необходимо перезапустить программу IMadering!';
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

  //--Ошибки http сокетов
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

  //--Переменные оформления всплывающих подсказок
  FDAOptions: TJvDesktopAlertOptions;
  DACount: integer = 0;
  DATimeShow: integer = 7000;
  DAPos: integer = 3;
  DAStyle: integer = 0;

  //--Переменные для окна чата
  NoAvatar: TImage;
  OutMessage2: TMemoryStream;
  OutMessage3: TMemoryStream;
  QReplyAutoSend: boolean = false;
  SmilesList: TStringList;
  InMessList: TStringList;
  TextSmilies: boolean = false;
  YouAt: string = 'Я';
  ChatFontSize: string = '9';

  //--Список для отображения в About
  AboutList: array[1..14] of string = (
    'Автор проекта и ведущий программист;Эдуард Толмачёв',
    'Программирование;Максим Нижник',
    'Программирование;Francois PIETTE (Ics components)',
    'Программирование;David Baldwin (HTML components)',
    'Программирование;Project Jedi (jvcl components)',
    'Программирование;Михаил Власов (SimpleXML компонент)',
    'Программирование;Polaris Software (rXML компонент)',
    'Программирование;Anders Melander (GIFImage component)',
    'Дизайн;Пётр Степанов',
    'Дизайн;Michael Niedermayr (www.greensmilies.com)',
    'Тестирование и поддержка;Павел Новиков',
    'Специальная благодарность;Маргарита Евдокимова',
    'Специальная благодарность;Светлана Пономарева',
    'IMadering;Спасибо всем!'
    );

  //--Http прокси для сокетов протоколов
  HttpProxy_Enable: boolean = false;
  HttpProxy_Address: string;
  HttpProxy_Port: string;
  HttpProxy_Auth: boolean = false;
  HttpProxy_Login: string;
  HttpProxy_Password: string;

implementation

end.

