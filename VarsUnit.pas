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
  Controls,
  SysUtils,
  Classes,
  ExtCtrls,
  JvDesktopAlert,
  Graphics,
  GifImg,
  FloatingUnit,
  JvSimpleXml,
  JclCompression,
  Htmlview;

const
  C_RN = #13#10;
  C_BN = ' ';
  С_Hour = 3600000 / MSecsPerDay;
  C_DTseconds = 1 / (SecsPerDay);
  C_DblClickTime = 0.6 * C_DTseconds;

  SettingsFileName: string = 'Settings.xml';
  ProfilesFileName: string = 'Profiles.xml';
  GroupsFileName: string = 'Groups.xml';
  AnketaFileName: string = 'Contacts\';
  AvatarFileName: string = 'Avatars\';
  HistoryFileName: string = 'History\';
  LangPath: string = 'Langs\%s.xml';
  SmiliesPath: string = 'Smilies\%s\smilies.txt';
  ContactListFileName: string = 'Contacts.txt';
  Nick_BD_FileName: string = 'Nicks.txt';
  QReplyFileName: string = 'QReply.txt';

  // Команды смежного использования
  C_NoCL = 'NoCL';
  C_Icq = 'Icq';
  S_Icq_Avatar = 'Icq avatar';
  S_Jabber = 'Jabber';
  S_Mra = 'Mra';
  S_Twitter = 'Twitter';
  C_UniqGT = 'gtrans';
  C_NameInfo = 'name_info';
  C_Nick = 'nick';
  C_First = 'first';
  C_Last = 'last';
  C_PerInfo = 'personal_info';
  C_Gender = 'gender';
  C_Auth = 'auth';
  C_WebAware = 'web_aware';
  C_HomePage = 'home_page';
  C_LastChange = 'last_change';
  C_HomeInfo = 'home_info';
  C_Address = 'address';
  C_City = 'city';
  C_State = 'state';
  C_Zip = 'zip';
  C_Country = 'country';
  C_OHomeInfo = 'orig_home_info';
  C_LangInfo = 'lang_info';
  C_Lang1 = 'lang1';
  C_Lang2 = 'lang2';
  C_Lang3 = 'lang3';
  C_PhoneInfo = 'phone_info';
  C_Phone1 = 'phone1';
  C_Phone2 = 'phone2';
  C_Phone3 = 'phone3';
  C_Phone4 = 'phone4';
  C_Phone5 = 'phone5';
  C_WorkInfo = 'work_info';
  C_Corp = 'corp';
  C_Dep = 'dep';
  C_Prof = 'prof';
  C_Site = 'site';
  C_Occup = 'occup';
  C_IntInfo = 'interests_info';
  C_Int1 = 'int1';
  C_Int2 = 'int2';
  C_Int3 = 'int3';
  C_Int4 = 'int4';
  C_AboutInfo = 'about_info';
  C_AgeInfo = 'age_info';
  C_Age = 'age';
  C_Day = 'day';
  C_Month = 'month';
  C_Year = 'year';
  C_EmailsInfo = 'emails_info';
  C_Email0 = 'email0';
  C_Email1 = 'email1';
  C_Email2 = 'email2';
  C_Email3 = 'email3';
  C_IntIdInfo = 'interests_id_info';
  C_IntId1 = 'int_id1';
  C_IntId2 = 'int_id2';
  C_IntId3 = 'int_id3';
  C_IntId4 = 'int_id4';
  C_PersInfo = 'personal_x_info';
  C_Marital = 'marital';
  C_Sexual = 'sexual';
  C_Height = 'height';
  C_Relig = 'relig';
  C_Smok = 'smok';
  C_Hair = 'hair';
  C_Children = 'children';
  C_IcqReg = 'http://www.icq.com/register';
  C_MraReg = 'http://win.mail.ru/cgi-bin/signup';
  C_SitePage = 'http://imadering.com';
  C_DownPage = 'http://imadering.com/download.htm';
  C_MaskPass = '----------------------';
  C_Login = 'login';
  C_Pass = 'password';
  C_SavePass = 'save_password';
  C_LangVars = 'vars';
  C_Infos = 'Infos';
  C_Lang = 'language';
  C_ExeName = 'Imadering.exe';
  C_PostInTwit = 'http://twitter.com/statuses/update.xml?source=IMadering&status=%s&in_reply_to_status_id=';
  C_TwitSite = 'http://twitter.com/';
  C_TwitIncMess = 'http://twitter.com/statuses/mentions.xml?count=%d';
  C_TwitUserInfo = 'http://twitter.com/users/show/';
  C_TwitOpenLenta = 'http://twitter.com/statuses/friends_timeline/%s.xml?count=%d';
  C_Host = 'host';
  C_Port = 'port';
  C_Profiles = 'profiles';
  C_Cur = 'current';
  C_Auto = 'auto_login';

var
  // Переменные общие для всей программы
  MyPath: string;
  ProfilePath: string;
  Profile: string = '';
  CurrentIcons: string = 'Imadering';
  CurrentLang: string = 'ru';
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
  UpdateVersionPath: string = 'Update_%s_%s.7z';
  UpdateFile: TMemoryStream;
  GroupHeaderColor: TColor = $00FFDEFF;
  CollapseGroupsRestore: Boolean = True;
  CompresHistoryProcess: Boolean = False;
  FloatingFrm: TFloatingForm;
  LastClick: Tdatetime;
  PKeySearch: string;
  CurGroup: integer;
  CurItem: integer;
  FullVersion: string;
  ProfileAuto: boolean = False;
  FArchive: TJclCompressionArchive;
  SH_TimerCount: Integer;
  SH_OldTitle: string;
  SH_HintWindow: THintWindow;
  SH_HintVisible: Boolean;
  SH_HTMLViewer: THTMLViewer;

  // Переменные стилей для HTML
  ChatCSS: string = '<style type="text/css">' + 'body, span { color: #000000; font: 12px tahoma, verdana; }' + 'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' +
    '.a { font: bold 11px tahoma, verdana; color: blue; }' + '.b { font: bold 11px tahoma, verdana; color: red; }' + '.c { font: 12px tahoma, verdana; color: black; }' +
    '.d { font: bold 11px tahoma, verdana; color: green; }' + '</style>';
  DetailsCSS: string = '<style type="text/css">' + 'body, span { color: #000000; font: 12px tahoma, verdana; }' + 'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' +
    '.cbold { font: bold 12px tahoma, verdana; }' + '.cdef { font: 12px tahoma, verdana; }' + '.cmargin { font: 11px tahoma, verdana; margin: 10px; }' + '</style>';

  // Переменные Twitter
  Twit_Login: string;
  Twit_Password: string;
  Twit_IncMess_Count: integer = 5;
  Twit_MyMess_Count: integer = 5;

  // Статистика трафика
  TrafSend: Real;
  TrafRecev: Real;
  SesDataTraf: TDateTime;
  AllTrafSend: Int64;
  AllTrafRecev: Int64;
  AllSesDataTraf: string;

  // Переменные звуков
  SoundON: Boolean = True;
  // 1
  SoundStartProg: Boolean;
  SoundStartProg_Name: string;
  SoundStartProg_Path: string;
  SoundStartProg_Mask: string = 'Sounds\%s\Start.wav';
  // 2
  SoundIncMsg: Boolean;
  SoundIncMsg_Name: string;
  SoundIncMsg_Path: string;
  SoundIncMsg_Mask: string = 'Sounds\%s\IncMsg.wav';
  // 3
  SoundMsgSend: Boolean;
  SoundMsgSend_Name: string;
  SoundMsgSend_Path: string;
  SoundMsgSend_Mask: string = 'Sounds\%s\MsgSend.wav';
  // 4
  SoungUserOnline: Boolean;
  UserOnline_Name: string;
  UserOnline_Path: string;
  UserOnline_Mask: string = 'Sounds\%s\UserOnline.wav';
  // 5
  SoundEvent: Boolean;
  SoundEvent_Name: string;
  SoundEvent_Path: string;
  SoundEvent_Mask: string = 'Sounds\%s\Event.wav';
  // 6
  SoundFileSend: Boolean;
  SoundFileSend_Name: string;
  SoundFileSend_Path: string;
  SoundFileSend_Mask: string = 'Sounds\%s\FileSend.wav';
  // 7
  SoundError: Boolean;
  SoundError_Name: string;
  SoundError_Path: string;
  SoundError_Mask: string = 'Sounds\%s\Error.wav';
  // 8
  SoundOpen: Boolean;
  SoundOpen_Name: string;
  SoundOpen_Path: string;
  SoundOpen_Mask: string = 'Sounds\%s\Open.wav';

  // Http прокси для сокетов протоколов
  HttpProxy_Enable: Boolean = False;
  HttpProxy_Address: string;
  HttpProxy_Port: string;
  HttpProxy_Auth: Boolean = False;
  HttpProxy_Login: string;
  HttpProxy_Password: string;

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
  XStatusMem: TMemoryStream;
  QReplyAutoSend: Boolean = False;
  SmilesList: TStringList;
  InMessList: TStringList;
  TextSmilies: Boolean = False;
  YouAt: string = 'I';
  ChatFontSize: string = '9';
  GetCityPanel: string;
  GetAgePanel: string;
  GetFlagImage: string;
  GetGenderImage: string;

  // Переменные для языка
  S_RestoreFromTray: string;
  S_HideInTray: string;
  S_RestoreProfileFromTray: string;
  S_HideProfileInTray: string;
  S_Version: string;
  S_ProfileError: string;
  S_DevelMess: string;
  S_Next: string;
  S_Close: string;
  S_Cancel: string;
  S_Apply: string;
  S_ProtoSelectAlert: string;
  S_Empty: string;
  S_NewVerYES: string;
  S_NewVerNO: string;
  S_NewVerErr: string;
  S_InfoHead: string;
  S_ErrorHead: string;
  S_AlertHead: string;
  S_WarningHead: string;
  ICQAccountInfo: string = 'Учётная запись ICQ:';
  ICQAccountInfo_1: string = 'Перед тем как подключиться к ICQ серверу, сначала укажите в настройках свой ICQ номер и пароль!';
  JabberAccountInfo: string = 'Учётная запись JID:';
  JabberAccountInfo_1: string = 'Перед тем как подключиться к Jabber серверу, сначала укажите в настройках свой JID аккаунт и пароль!';
  MRAAccountInfo: string = 'Учётная запись MRA:';
  MRAAccountInfo_1: string = 'Перед тем как подключиться к MRA серверу, сначала укажите в настройках свой Email и пароль!';
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
  PhoneGroupCaption: string = 'Телефонные';
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
  DellContactL: string = 'Контакт "%s" будет удалён. Вы уверены?';
  DellGroupL: string = 'Группа "%s" будет удалёна. Вы уверены?';
  DellYourSelfL: string = 'Удалить себя из списка контакта: %s. Вы уверены?';
  HistoryNotFileL: string = 'История сообщений с этим контактом отсутствует';
  GroupInv: string = ' из ';
  HistorySearchNoL: string = 'Такой текст не найден.';
  HistoryLoadFileL: string = 'Загружается история...';
  S_UpDateStart: string;
  S_UpDateAbort: string;
  S_UpDateLoad: string;
  S_UpDateUn: string;
  S_UpDateOK: string;
  ProxyConnectErrL1: string = 'Неверный логин или пароль для прокси.';
  ProxyConnectErrL2: string = 'Неизвестная прокси ошибка.';
  JabberLoginErrorL: string = 'Неправильный JID или пароль.';
  MraLoginErrorL: string = 'Неправильный Email или пароль.';
  HttpSocketErrCodeL: string = 'Код ошибки: %d';
  SelectDirL: string = 'Выберите папку для хранения вашего профиля';
  DelProfile: string = 'Удалить старый профиль?';
  URLOpenErrL: string = 'Браузер для открытия ссылки не найден.' + C_RN + 'Ссылка скопирована в буфер обмена.';
  SearchInfoGoL: string = 'Идёт поиск ...';
  SearchInfoEndL: string = 'Поиск завершён';
  SearchInfoNoL: string = 'Не найден';
  SearchInfoAuthL: string = 'Авторизация';
  SearchInfoAuthNoL: string = 'Не нужна';
  SearchNextPage1: string = 'Далее';
  SearchNextPage2: string = 'Страница - %d';
  S_SearchQMess: string;
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
  S_FileTransfer1: string;
  S_FileTransfer2: string;
  S_FileTransfer3: string;
  S_FileTransfer4: string;
  S_FileTransfer5: string;
  S_FileTransfer6: string;
  SocketL: string = 'Сокет:';
  HistoryCompressedL: string = 'Создан архив с историей сообщений. Для просмотра предыдущей истории сообщений откройте архив в окне просмотра истории.';
  GtransProcessL: string = 'Перевод ...';
  GtransOKL: string = 'Переведено';
  GtransErrL: string = 'Ошибка перевода: %s';
  S_GtransErr2: string;
  NewProgErrL: string = 'Ошибка запуска другого профиля программы.';
  S_DownCount: string;
  S_UnPackErr: string = 'У вас нет прав на запись файлов!_r_Необходимы права администратора.';
  S_CharsCount: string = '%d из %d';
  S_PostInTwitter: string;
  S_TwitPostOK: string;
  EmailMessagesL: string = 'У вас в ящике %s непрочитанных писем!' + C_RN + C_RN + 'Всего в ящике %s писем.';

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
  S_Status1: string; // Готов поболтать
  S_Status2: string; // Злой
  S_Status3: string; // Депрессия
  S_Status4: string; // Дома
  S_Status5: string; // На работе
  S_Status6: string; // Кушаю
  S_Status7: string; // Отошёл
  S_Status8: string; // Недоступен
  S_Status9: string; // Занят
  S_Status10: string; // Не беспокоить
  S_Status11: string; // В сети
  S_Status12: string; // Невидимый
  S_Status13: string; // Невидимый для всех
  S_Status14: string; // Не в сети
  S_Status15: string; // Неопределённый
  S_Status16: string; // Необходима авторизация

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

  // Для Лога
  Log_Bevel: string = ' | ';
  Log_Next: string = '; ';
  LogMyPath: string = 'Путь к программе: ';
  LogProfile: string = 'Путь к профилю: ';
  LogIconCount: string = 'Загружено %d иконок';
  LogNickCash: string = 'Количество ников в файле кэша: ';
  LogSmiliesCount: string = 'Количество загруженных смайликов: ';
  LogRosterCount: string = 'Количество записей в файле кэша списка контактов: ';
  Log_Connect: string = 'Подключение к серверу: ';
  Log_HTTP_Proxy_Connect: string = 'Подключение к прокси: ';
  Log_Login: string = 'Логин для авторизации: ';
  Log_Set_Status: string = 'Выбран статус: ';
  Log_Jabber_Plain: string = 'Jabber | Авторизация по механизму PLAIN';
  Log_MD5_Nonce: string = 'Получен ключ для MD5 авторизации: ';
  Log_Clear: string = 'Лог событий автоматически очищен.';
  Log_Exception1: string = 'В программе произошла ошибка:' + C_RN;
  Log_Exception2: string = C_RN + 'Вы можете скопировать её от сюда и выложить для разработчиков на форуме проекта IMadering ' +
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
  Log_Lang_Code: string = 'Код языка системы: ';
  Log_Contact_Info: string = 'Получен пакет информации о контакте: ';
  Log_Gtrans_Req: string = 'Получены данные перевода: %s на %s';
  Log_Gtrans_URL: string = 'Запрос для перевода: %s на %s';
  Log_Get: string = ' get | ';
  Log_Send: string = ' send | ';
  Log_Parsing: string = ' parsing | ';
  Log_SetLang: string = 'Перевод формы: ';

procedure SetLangVars;

implementation

uses
  UtilsUnit,
  MainUnit;

// Устанавливаем язык для переменных
procedure SetLangVars;
var
  I: Integer;
  List: Tstringlist;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  List := Tstringlist.Create;
  try
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
        begin
          if FileExists(MyPath + Format(LangPath, [CurrentLang])) then
            begin
              // Загружаем переменные из файла языка
              LoadFromFile(MyPath + Format(LangPath, [CurrentLang]));
              if Root <> nil then
                begin
                  XML_Node := Root.Items.ItemNamed[C_LangVars];
                  if XML_Node <> nil then
                    List.Text := XML_Node.SaveToString;
                end;
            end;
        end;
    finally
      JvXML.Free;
    end;
    // Присваиваем переменные в цикле (для переноса строк CheckText_RN)
    for I := 0 to List.Count - 1 do
      begin
        if IsolateTextString(List.Strings[I], '<', ' ') = 'S_RestoreFromTray' then
          S_RestoreFromTray := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_HideInTray' then
          S_HideInTray := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_RestoreProfileFromTray' then
          S_RestoreProfileFromTray := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_HideProfileInTray' then
          S_HideProfileInTray := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Version' then
          S_Version := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_ProfileError' then
          S_ProfileError := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_DevelMess' then
          S_DevelMess := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Next' then
          S_Next := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_ProtoSelectAlert' then
          S_ProtoSelectAlert := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_InfoHead' then
          S_InfoHead := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_ErrorHead' then
          S_ErrorHead := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_AlertHead' then
          S_AlertHead := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_WarningHead' then
          S_WarningHead := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Close' then
          S_Close := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Cancel' then
          S_Cancel := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_SearchQMess' then
          S_SearchQMess := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_FileTransfer1' then
          S_FileTransfer1 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_FileTransfer2' then
          S_FileTransfer2 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_FileTransfer3' then
          S_FileTransfer3 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_FileTransfer4' then
          S_FileTransfer4 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_FileTransfer5' then
          S_FileTransfer5 := CheckText_RN(IsolateTextString(List.Strings[I], 'c="', '"'))
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_FileTransfer6' then
          S_FileTransfer6 := CheckText_RN(IsolateTextString(List.Strings[I], 'c="', '"'))
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status1' then
          S_Status1 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status2' then
          S_Status2 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status3' then
          S_Status3 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status4' then
          S_Status4 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status5' then
          S_Status5 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status6' then
          S_Status6 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status7' then
          S_Status7 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status8' then
          S_Status8 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status9' then
          S_Status9 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status10' then
          S_Status10 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status11' then
          S_Status11 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status12' then
          S_Status12 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status13' then
          S_Status13 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status14' then
          S_Status14 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status15' then
          S_Status15 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Status16' then
          S_Status16 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_GtransErr2' then
          S_GtransErr2 := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Apply' then
          S_Apply := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_Empty' then
          S_Empty := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_NewVerYES' then
          S_NewVerYES := CheckText_RN(IsolateTextString(List.Strings[I], 'c="', '"'))
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_NewVerNO' then
          S_NewVerNO := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_NewVerErr' then
          S_NewVerErr := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_DownCount' then
          S_DownCount := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_UpDateStart' then
          S_UpDateStart := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_UpDateAbort' then
          S_UpDateAbort := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_UpDateLoad' then
          S_UpDateLoad := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_UpDateUn' then
          S_UpDateUn := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_UpDateOK' then
          S_UpDateOK := CheckText_RN(IsolateTextString(List.Strings[I], 'c="', '"'))
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundStartProg_Name' then
          SoundStartProg_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundIncMsg_Name' then
          SoundIncMsg_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundMsgSend_Name' then
          SoundMsgSend_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'UserOnline_Name' then
          UserOnline_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundEvent_Name' then
          SoundEvent_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundFileSend_Name' then
          SoundFileSend_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundError_Name' then
          SoundError_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'SoundOpen_Name' then
          SoundOpen_Name := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_PostInTwitter' then
          S_PostInTwitter := IsolateTextString(List.Strings[I], 'c="', '"')
        else if IsolateTextString(List.Strings[I], '<', ' ') = 'S_TwitPostOK' then
          S_TwitPostOK := IsolateTextString(List.Strings[I], 'c="', '"');





      end;
  finally
    List.Free;
  end;
end;

end.
