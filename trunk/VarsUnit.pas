{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit VarsUnit;

interface

{$REGION 'Uses'}

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
  Htmlview,
  Messages,
  ShellApi;

{$ENDREGION}

const

{$REGION 'SysConst'}

  C_RN = #13#10;
  C_BN = ' ';
  C_PN = ' | ';
  C_LN = '; ';
  C_TN = ': ';
  С_Hour = 3600000 / MSecsPerDay;
  C_DTseconds = 1 / (SecsPerDay);
  C_DblClickTime = 0.6 * C_DTseconds;
  C_WM_APPBAR = WM_USER + 1;

{$ENDREGION}
{$REGION 'FilesConst'}

  C_AnketaFolder = 'Contacts\';
  C_AvatarFolder = 'Avatars\';
  C_HistoryFolder = 'History\';
  C_GamesFolder = 'Games\';
  C_FlagsFolder = 'Icons\Flags\';
  C_SettingsFileName = 'Settings.xml';
  C_ProfilesFileName = 'Profiles.xml';
  C_GroupsFileName = 'Groups.xml';
  C_GamesCatalogFileName = 'Catalog.txt';
  C_LangPath = 'Langs\%s.xml';
  C_SmiliesPath = 'Smilies\%s\smilies.txt';
  C_ContactListFileName = 'Contacts.txt';
  C_Nick_BD_FileName = 'Nicks.txt';
  C_ReplyFileName = 'Reply.txt';

{$ENDREGION}
{$REGION 'AllConst'}

  // Команды смежного использования
  C_Icq = 'Icq';
  C_Icq_Avatar = 'Icq avatar';
  C_Jabber = 'Jabber';
  C_Mra = 'Mra';
  C_Twitter = 'Twitter';
  //
  C_NoCL = 'NoCL';
  C_UniqGT = 'gtrans';
  C_MaskPass = '----------------------';
  C_Login = 'login';
  C_Pass = 'password';
  C_SavePass = 'save_password';
  C_LangVars = 'vars';
  C_Infos = 'Infos';
  C_Lang = 'language';
  C_ExeName = 'Imadering.exe';
  C_Host = 'host';
  C_Port = 'port';
  C_Profiles = 'profiles';
  C_Cur = 'current';
  C_Auto = 'auto_login';
  //
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
  //
  C_IcqReg = 'http://www.icq.com/register';
  C_MraReg = 'http://win.mail.ru/cgi-bin/signup';
  C_SitePage = 'http://imadering.com';
  C_DownPage = 'http://imadering.com/download.htm';
  C_PostInTwit = 'http://twitter.com/statuses/update.xml?source=IMadering&status=%s&in_reply_to_status_id=';
  C_TwitSite = 'http://twitter.com/';
  C_TwitIncMess = 'http://twitter.com/statuses/mentions.xml?count=%d';
  C_TwitUserInfo = 'http://twitter.com/users/show/';
  C_TwitOpenLenta = 'http://twitter.com/statuses/friends_timeline/%s.xml?count=%d';
  C_GoogleCodeURL = 'http://imadering.googlecode.com/files/';

{$ENDREGION}

var

{$REGION 'GeneralVars'}

  // Переменные общие для всей программы
  V_MyPath: string;
  V_ProfilePath: string;
  V_Profile: string = '';
  V_CurrentIcons: string = 'Imadering';
  V_CurrentLang: string = 'ru';
  V_CurrentSmiles: string = 'Imadering';
  V_CurrentSounds: string = 'Imadering';
  V_ProgramCloseCommand: Boolean = False;
  V_FirstStart: Boolean = False;
  V_TrayProtoClickMenu: string;
  V_AccountToNick: TStringList;
  V_AvatarServiceDisable: Boolean = False;
  V_UpdateAuto: Boolean = True;
  V_UpdateVersionPath: string = 'Update_%s_%s.7z';
  V_FloatingFrm: TFloatingForm;
  V_LastClick: TDateTime;
  V_FullVersion: string;
  V_ProfileAuto: Boolean = False;
  V_FArchive: TJclCompressionArchive;

{$ENDREGION}
{$REGION 'CL_Vars'}

  // Переменные окна КЛ
  V_AlphaBlendInactive: Boolean = False;
  V_RoasterAlphaBlend: Boolean = False;
  V_RoasterAlphaValue: Integer = 255;
  V_GroupHeaderColor: TColor = $00FFDEFF;
  V_CollapseGroupsRestore: Boolean = True;
  V_PKeySearch: string;
  V_CurGroup: Integer;
  V_CurItem: Integer;

{$ENDREGION}
{$REGION 'HintSmiliesVars'}

  // Переменные подсказок над смайлами
  SH_TimerCount: Integer;
  SH_OldTitle: string;
  SH_HintWindow: THintWindow;
  SH_HintVisible: Boolean;
  SH_HTMLViewer: THTMLViewer;

{$ENDREGION}
{$REGION 'SnapVars'}

  // Переменные для Snap CL
  V_AppBarDataCL: TAppBarData;
  V_DockAppBar: Boolean = False;
  V_DockRigth: Boolean = False;
  V_DockLeft: Boolean = False;
  V_NoDockWigth: Integer = 0;
  V_NoDockHeigth: Integer = 0;

{$ENDREGION}
{$REGION 'StyleVars'}

  // Переменные стилей для HTML
  V_ChatCSS: string = '<style type="text/css">' + 'body, span { color: #000000; font: 12px tahoma, verdana; }' +
    'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' + '.a { font: bold 11px tahoma, verdana; color: blue; }' +
    '.b { font: bold 11px tahoma, verdana; color: red; }' + '.c { font: 12px tahoma, verdana; color: black; }' + '.d { font: bold 11px tahoma, verdana; color: green; }' + '</style>';
  V_DetailsCSS: string = '<style type="text/css">' + 'body, span { color: #000000; font: 12px tahoma, verdana; }' +
    'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' + '.cbold { font: bold 12px tahoma, verdana; }' + '.cdef { font: 12px tahoma, verdana; }' +
    '.cmargin { font: 11px tahoma, verdana; margin: 10px; }' + '</style>';

{$ENDREGION}
{$REGION 'TraficVars'}

  // Статистика трафика
  V_TrafSend: Real;
  V_TrafRecev: Real;
  V_SesDataTraf: TDateTime;
  V_AllTrafSend: Int64;
  V_AllTrafRecev: Int64;
  V_AllSesDataTraf: string;

{$ENDREGION}
{$REGION 'SoundsVars'}

  // Переменные звуков
  V_SoundON: Boolean = True;
  // 1
  V_SoundStartProg: Boolean;
  V_SoundStartProg_Name: string;
  V_SoundStartProg_Path: string;
  V_SoundStartProg_Mask: string = 'Sounds\%s\Start.wav';
  // 2
  V_SoundIncMsg: Boolean;
  V_SoundIncMsg_Name: string;
  V_SoundIncMsg_Path: string;
  V_SoundIncMsg_Mask: string = 'Sounds\%s\IncMsg.wav';
  // 3
  V_SoundMsgSend: Boolean;
  V_SoundMsgSend_Name: string;
  V_SoundMsgSend_Path: string;
  V_SoundMsgSend_Mask: string = 'Sounds\%s\MsgSend.wav';
  // 4
  V_SoungUserOnline: Boolean;
  V_SoungUserOnline_Name: string;
  V_SoungUserOnline_Path: string;
  V_SoungUserOnline_Mask: string = 'Sounds\%s\UserOnline.wav';
  // 5
  V_SoundEvent: Boolean;
  V_SoundEvent_Name: string;
  V_SoundEvent_Path: string;
  V_SoundEvent_Mask: string = 'Sounds\%s\Event.wav';
  // 6
  V_SoundFileSend: Boolean;
  V_SoundFileSend_Name: string;
  V_SoundFileSend_Path: string;
  V_SoundFileSend_Mask: string = 'Sounds\%s\FileSend.wav';
  // 7
  V_SoundError: Boolean;
  V_SoundError_Name: string;
  V_SoundError_Path: string;
  V_SoundError_Mask: string = 'Sounds\%s\Error.wav';
  // 8
  V_SoundOpen: Boolean;
  V_SoundOpen_Name: string;
  V_SoundOpen_Path: string;
  V_SoundOpen_Mask: string = 'Sounds\%s\Open.wav';

{$ENDREGION}
{$REGION 'HttpProxyVars'}

  // Http прокси для сокетов протоколов
  V_HttpProxy_Enable: Boolean = False;
  V_HttpProxy_Address: string;
  V_HttpProxy_Port: string;
  V_HttpProxy_Auth: Boolean = False;
  V_HttpProxy_Login: string;
  V_HttpProxy_Password: string;

{$ENDREGION}
{$REGION 'DAShowVars'}

  // Переменные оформления всплывающих подсказок
  V_FDAOptions: TJvDesktopAlertOptions;
  V_DACount: Integer = 0;
  V_DATimeShow: Integer = 7000;
  V_DAPos: Integer = 3;
  V_DAStyle: Integer = 0;

{$ENDREGION}
{$REGION 'ChatVars'}

  // Переменные для окна чата
  V_NoAvatar: TImage;
  V_OutMessage2: TMemoryStream;
  V_OutMessage3: TMemoryStream;
  V_XStatusImg: TBitmap;
  V_XStatusMem: TMemoryStream;
  V_ReplyAutoSend: Boolean = False;
  V_SmilesList: TStringList;
  V_InMessList: TStringList;
  V_TextSmilies: Boolean = False;
  V_YouAt: string = 'I';
  V_ChatFontSize: string = '9';
  V_GetCityPanel: string;
  V_GetAgePanel: string;
  V_GetFlagImage: string;
  V_GetGenderImage: string;

{$ENDREGION}
{$REGION 'LangVars'}

  // Переменные для языка | Lang_Vars[20].L_S
  Lang_Vars: array [0 .. 20] of record L_N: string;
  L_S: string;
end
= ((L_N: 'RestoreFromTray'; L_S: ''), // 0
  (L_N: 'HideInTray'; L_S: ''), // 1
  (L_N: 'RestoreProfileFromTray'; L_S: ''), // 2
  (L_N: 'HideProfileInTray'; L_S: ''), // 3
  (L_N: 'Version'; L_S: ''), // 4
  (L_N: 'ProfileError'; L_S: ''), // 5
  (L_N: 'DevelMess'; L_S: ''), // 6
  (L_N: 'Next'; L_S: ''), // 7
  (L_N: 'Close'; L_S: ''), // 8
  (L_N: 'Cancel'; L_S: ''), // 9
  (L_N: 'Apply'; L_S: ''), // 10
  (L_N: 'ProtoSelectAlert'; L_S: ''), // 11
  (L_N: 'Empty'; L_S: ''), // 12
  (L_N: 'NewVerYES'; L_S: ''), // 13
  (L_N: 'NewVerNO'; L_S: ''), // 14
  (L_N: 'NewVerErr'; L_S: ''), // 15
  (L_N: 'InfoHead'; L_S: ''), // 16
  (L_N: 'ErrorHead'; L_S: ''), // 17
  (L_N: 'AlertHead'; L_S: ''), // 18
  (L_N: 'WarningHead'; L_S: ''), // 19
  (L_N: 'Account'; L_S: '')); // 20

ICQAccountInfo_1 :
string = 'Перед тем как подключиться к ICQ серверу, сначала укажите в настройках свой ICQ номер и пароль!';
JabberAccountInfo_1 :
string = 'Перед тем как подключиться к Jabber серверу, сначала укажите в настройках свой JID аккаунт и пароль!';
MRAAccountInfo :
string = 'Учётная запись MRA:';
MRAAccountInfo_1 :
string = 'Перед тем как подключиться к MRA серверу, сначала укажите в настройках свой Email и пароль!';
PassLabelInfo :
string = 'Пароль:';
ParsingPktError :
string = 'Неудалось произвести разбор пакета данных полученных от сервера.';
SocketConnErrorInfo_1 :
string = 'Соединение не установлено.';
RegNewAlert_1 :
string = 'Укажите пароль для новой учётной записи.';
UnknownError :
string = 'Неизвестная ошибка';
AddContactError :
string = 'Ошибка при добавлении контакта.';
AddGroupError :
string = 'Ошибка при добавлении группы.';
DelGroupError :
string = 'Ошибка при удалении группы.';
ICQxUIN :
string = 'Ваш номер ICQ используется на другом компьютере.';
PassChangeAlert_1 :
string = 'Пароль не был изменён. Текущий или новый пароль введён неверно.';
PassChangeAlert_2 :
string = 'Пароль изменён.';
OnlineAlert :
string = 'Для выполнения этого действия необходимо подключиться.';
HideContactGroupCaption :
string = 'Временные';
NoInListGroupCaption :
string = 'Не в списке';
PhoneGroupCaption :
string = 'Телефонные';
ConnTimeL :
string = 'Подключён:';
RegDateL :
string = 'Рег. дата:';
ChatDateL :
string = 'Последний чат:';
ProtoVerL :
string = 'Версия протокола:';
ClientVariableL :
string = 'Возможный клиент:';
CellularPhoneL :
string = 'Сотовый:';
NoteL :
string = 'Заметка:';
EmailL :
string = 'Email:';
ConnectFlagL :
string = 'Флаг подключения:';
UpDate1L :
string = 'Обновить версию автоматически?';
UpDate2L :
string = 'На официальном сайте www.imadering.com доступно обновление программы IMadering';
UpDate3L :
string = 'Обновление';
QReply1L :
string = 'Привет!';
QReply2L :
string = 'Как дела?';
QReply3L :
string = 'Пока';
HistoryDelL :
string = 'Вы действительно хотите удалить историю сообщений?';
CloseChatWindowsL :
string = 'Собеседник закрыл окно чата!';
TypingTextL :
string = 'Печатает...';
ClientL :
string = 'Клиент:';
StatusL :
string = 'Статус:';
OnlineInfo1L :
string = 'Дата начала сбора статистики';
OnlineInfo2L :
string = 'Дней проведено в сети';
OnlineInfo3L :
string = 'Всего отправлено Away сообщений';
OnlineInfo4L :
string = 'URL ссылки от сервера';
OnlineInfo5L :
string = 'IP адрес ICQ сервера';
OnlineInfo6L :
string = 'Hash аватара';
OnlineInfo7L :
string = 'Записей в серверном списке контактов';
PassChangeOKL :
string = 'Пароль изменён';
AnketaSaveOKL :
string = 'Ваши данные успешно обновлены на сервере.';
InfoOKL :
string = 'Информация о контакте найдена!';
InfoReqL :
string = 'Получение информации...';
InfoCaptionL :
string = 'Информация о контакте';
InfoNickL :
string = 'Ник:';
InfoNameL :
string = 'Имя:';
InfoHomeL :
string = 'Дом:';
InfoAdressL :
string = 'Адрес:';
InfoStateL :
string = 'Штат:';
InfoZipL :
string = 'Индекс:';
InfoGenderL :
string = 'Пол:';
InfoGender1L :
string = 'Женский';
InfoGender2L :
string = 'Мужской';
InfoAgeL :
string = 'Возраст:';
InfoBirDate :
string = 'Дата рождения:';
InfoOHomeL :
string = 'Место рождения:';
InfoWorkL :
string = 'Работа:';
InfoCompanyL :
string = 'Компания:';
InfoDeportL :
string = 'Отдел:';
InfoPositionL :
string = 'Должность:';
InfoOccupationL :
string = 'Профессия:';
InfoWebSiteL :
string = 'Сайт:';
InfoPhoneL :
string = 'Телефон:';
InfoFaxL :
string = 'Факс:';
InfoCellularL :
string = 'Сотовый:';
InfowPhoneL :
string = 'Рабочий телефон:';
InfowFaxL :
string = 'Рабочий факс:';
InfoInterestsL :
string = 'Интересы:';
InfoAboutL :
string = 'О себе:';
InfoHomePageL :
string = 'Домашняя страничка:';
InfoLastUpDateL :
string = 'Дата последнего обновления данных:';
InfoLangL :
string = 'Владение языками:';
InfoMaritalL :
string = 'Брак:';
InfoSexualL :
string = 'Сексуальная ориентация:';
InfoHeightL :
string = 'Рост:';
InfoReligL :
string = 'Религия:';
InfoSmokL :
string = 'Курение:';
InfoHairL :
string = 'Цвет волос:';
InfoChildrenL1 :
string = 'Детей:';
DellContactL :
string = 'Контакт "%s" будет удалён. Вы уверены?';
DellGroupL :
string = 'Группа "%s" будет удалёна. Вы уверены?';
DellYourSelfL :
string = 'Удалить себя из списка контакта: %s. Вы уверены?';
HistoryNotFileL :
string = 'История сообщений с этим контактом отсутствует';
GroupInv :
string = ' из ';
HistorySearchNoL :
string = 'Такой текст не найден.';
HistoryLoadFileL :
string = 'Загружается история...';
S_UpDateStart :
string;
S_UpDateAbort :
string;
S_UpDateLoad :
string;
S_UpDateUn :
string;
S_UpDateOK :
string;
ProxyConnectErrL1 :
string = 'Неверный логин или пароль для прокси.';
ProxyConnectErrL2 :
string = 'Неизвестная прокси ошибка.';
JabberLoginErrorL :
string = 'Неправильный JID или пароль.';
MraLoginErrorL :
string = 'Неправильный Email или пароль.';
HttpSocketErrCodeL :
string = 'Код ошибки: %d';
SelectDirL :
string = 'Выберите папку для хранения вашего профиля';
DelProfile :
string = 'Удалить старый профиль?';
URLOpenErrL :
string = 'Браузер для открытия ссылки не найден.' + C_RN + 'Ссылка скопирована в буфер обмена.';
SearchInfoGoL :
string = 'Идёт поиск ...';
SearchInfoEndL :
string = 'Поиск завершён';
SearchInfoNoL :
string = 'Не найден';
SearchInfoAuthL :
string = 'Авторизация';
SearchInfoAuthNoL :
string = 'Не нужна';
SearchNextPage1 :
string = 'Далее';
SearchNextPage2 :
string = 'Страница - %d';
S_SearchQMess :
string;
AddContactErr1 :
string = 'Такой контакт уже существует в вашем списке контактов.';
AddContactErr2 :
string = 'Пожалуйста, дождитесь окончания предыдущей операции с серверным списком контактов.';
AddContactErr3 :
string = 'Сначала создайте хоть одну группу';
AddContactErr4 :
string = 'Ошибка при добавлении контакта.';
AddContactOKL :
string = 'Контакт успешно добавлен в ваш список контактов!';
AddNewGroupL :
string = 'Новая группа';
AddNewGroupErr1 :
string = 'Такая группа уже существует в вашем списке контактов.';
AddNewGroupErr2 :
string = 'Ошибка при добавлении группы.';
DellGroupErrL :
string = 'Ошибка при удалении группы.';
DellGroupOKL :
string = 'Группа успешно удалена из вашего списка контактов!';
AddNewGroupOKL :
string = 'Группа успешно добавлена в ваш список контактов!';
JabberNullGroup :
string = 'Общая';
S_FileTransfer1 :
string;
S_FileTransfer2 :
string;
S_FileTransfer3 :
string;
S_FileTransfer4 :
string;
S_FileTransfer5 :
string;
S_FileTransfer6 :
string;
SocketL :
string = 'Сокет:';
HistoryCompressedL :
string = 'Создан архив с историей сообщений. Для просмотра предыдущей истории сообщений откройте архив в окне просмотра истории.';
GtransProcessL :
string = 'Перевод ...';
GtransOKL :
string = 'Переведено';
GtransErrL :
string = 'Ошибка перевода: %s';
S_GtransErr2 :
string;
NewProgErrL :
string = 'Ошибка запуска другого профиля программы.';
S_DownCount :
string;
S_UnPackErr :
string = 'У вас нет прав на запись файлов!_r_Необходимы права администратора.';
S_CharsCount :
string = '%d из %d';
S_PostInTwitter :
string;
S_TwitPostOK :
string;
EmailMessagesL :
string = 'У вас в ящике %s непрочитанных писем!' + C_RN + C_RN + 'Всего в ящике %s писем.';
S_Game :
string = 'Игра %s';

{$ENDREGION}
{$REGION 'ICQ_Connect_Errors_Vars'}

// Ошибки подключения ICQ протокола
ConnectErrors_0001 :
string = 'Неправильный номер ICQ или пароль.';
ConnectErrors_0002 :
string = 'Сервис временно недоступен.';
ConnectErrors_0003 :
string = 'Ошибка авторизации.';
ConnectErrors_0004 :
string = 'Неверный номер ICQ или пароль.';
ConnectErrors_0005 :
string = 'Неверный номер ICQ или пароль.';
ConnectErrors_0006 :
string = 'Внутренняя ошибка.';
ConnectErrors_0007 :
string = 'Это неверная учётная запись.';
ConnectErrors_0008 :
string = 'Эта учётная запись была удалена.';
ConnectErrors_0009 :
string = 'Это просроченная учётная запись.';
ConnectErrors_000A :
string = 'Нет доступа к базе.';
ConnectErrors_000B :
string = 'Нет доступа к резольверу.';
ConnectErrors_000C :
string = 'Неверные поля в базе данных.';
ConnectErrors_000D :
string = 'Неверный статус базы.';
ConnectErrors_000E :
string = 'Неверный статус резольвера.';
ConnectErrors_000F :
string = 'Внутренняя серверная ошибка.';
ConnectErrors_0010 :
string = 'Сервис временно отключён.';
ConnectErrors_0011 :
string = 'Обслуживание этой учётной записи приостановлено.';
ConnectErrors_0012 :
string = 'Ошибка перенаправления в базе.';
ConnectErrors_0013 :
string = 'Ошибка линковки в базе.';
ConnectErrors_0014 :
string = 'Ошибка резервной схемы.';
ConnectErrors_0015 :
string = 'Ошибка резервной линковки.';
ConnectErrors_0016 :
string = 'Достигнут предел подключений с этого IP-адреса.';
ConnectErrors_0017 :
string = 'Достигнут предел подключений с этого IP-адреса.';
ConnectErrors_0018 :
string = 'Превышен лимит подключений! Попробуйте подключиться позже.';
ConnectErrors_0019 :
string = 'Эта учётная запись имеет наивысший уровень предупреждений. Попробуйте позже.';
ConnectErrors_001A :
string = 'Превышен интервал резервации в базе.';
ConnectErrors_001B :
string = 'Вы используете старую версию клиента. Обновите версию.';
ConnectErrors_001C :
string = 'Вы используете старую версию клиента. Рекомендуется обновить версию.';
ConnectErrors_001D :
string = 'Превышен лимит подключений! Попробуйте подключиться позже.';
ConnectErrors_001E :
string = 'Невозможно зарегистрироваться в сети. Попробуйте позже.';
ConnectErrors_0020 :
string = 'Неверный SecureID.';
ConnectErrors_0022 :
string = 'Эта учётная запись недоступна из-за вашего возраста (меньше 13).';

{$ENDREGION}
{$REGION 'StatusesLangVars'}

// Основные статусы плюс расширенные из QIP
S_Status1 :
string; // Готов поболтать
S_Status2 :
string; // Злой
S_Status3 :
string; // Депрессия
S_Status4 :
string; // Дома
S_Status5 :
string; // На работе
S_Status6 :
string; // Кушаю
S_Status7 :
string; // Отошёл
S_Status8 :
string; // Недоступен
S_Status9 :
string; // Занят
S_Status10 :
string; // Не беспокоить
S_Status11 :
string; // В сети
S_Status12 :
string; // Невидимый
S_Status13 :
string; // Невидимый для всех
S_Status14 :
string; // Не в сети
S_Status15 :
string; // Неопределённый
S_Status16 :
string; // Необходима авторизация

{$ENDREGION}
{$REGION 'HTTP_Errors_Vars'}

// Ошибки http сокетов
Err400 :
string = 'Неверный запрос.';
Err401 :
string = 'Несанкционированно.';
Err402 :
string = 'Требуется оплата.';
Err403 :
string = 'Запрещено.';
Err404 :
string = 'Не найдено.';
Err405 :
string = 'Метод не допускается.';
Err406 :
string = 'Не приемлемо.';
Err407 :
string = 'Требуется авторизация на прокси.';
Err408 :
string = 'Время ожидания запроса истекло.';
Err409 :
string = 'Конфликт.';
Err410 :
string = 'Удален.';
Err411 :
string = 'Требуется длина.';
Err412 :
string = 'Предусловие неверно.';
Err413 :
string = 'Объект запроса слишком большой.';
Err414 :
string = 'URI запроса слишком большой.';
Err415 :
string = 'Неподдерживаемый тип медиа.';
Err416 :
string = 'Диапазон не отвечает требованиям.';
Err417 :
string = 'Результат не соответствует ожидаемому.';
Err500 :
string = 'Внутренняя ошибка сервера.';
Err501 :
string = 'Не реализовано.';
Err502 :
string = 'Ошибка шлюза.';
Err503 :
string = 'Сервис недоступен.';
Err504 :
string = 'Истекло время ожидания от шлюза.';
Err505 :
string = 'Не поддерживаемая версия HTTP.';

{$ENDREGION}
{$REGION 'LogLangVars'}

// Для Лога
LogMyPath :
string = 'Путь к программе: ';
LogProfile :
string = 'Путь к профилю: ';
LogIconCount :
string = 'Загружено %d иконок';
LogNickCash :
string = 'Количество ников в файле кэша: ';
LogSmiliesCount :
string = 'Количество загруженных смайликов: ';
LogRosterCount :
string = 'Количество записей в файле кэша списка контактов: ';
Log_Connect :
string = 'Подключение к серверу: ';
Log_HTTP_Proxy_Connect :
string = 'Подключение к прокси: ';
Log_Login :
string = 'Логин для авторизации: ';
Log_Set_Status :
string = 'Выбран статус: ';
Log_Jabber_Plain :
string = 'Jabber | Авторизация по механизму PLAIN';
Log_MD5_Nonce :
string = 'Получен ключ для MD5 авторизации: ';
Log_Clear :
string = 'Лог событий автоматически очищен.';
Log_Exception1 :
string = 'В программе произошла ошибка:' + C_RN;
Log_Exception2 :
string = C_RN + 'Вы можете скопировать её от сюда и выложить для разработчиков на форуме проекта IMadering ' +
  'c описанием действий в следствии которых возникла данная ошибка. Или уведомить об ошибке любым другим способом.';
Log_Proxy_OK :
string = 'Подключение к прокси установлено успешно.';
Log_Server_Hello :
string = 'Получено приглашение сервера.';
Log_Get_Server :
string = 'Получен адрес сервера: ';
Log_Unk_Data :
string = 'Получены неизвестные или неважные данные:';
Log_Close_Server :
string = 'Сеанс связи с сервером заверщён.';
Log_Get_CL :
string = 'Получен список контактов.';
Log_ConnTime :
string = 'Время подключения: ';
Log_UIN_RegTime :
string = 'Дата регистрации: ';
Log_Ext_IP :
string = 'Внешний IP: ';
Log_Int_IP :
string = 'Внутренний IP: ';
Log_Icon_Hash :
string = 'Хэш аватар:';
Log_User_Online_Event :
string = 'Получен пакет онлайн статуса от контакта: ';
Log_User_Offline_Event :
string = 'Получен пакет оффлайн статуса от контакта: ';
Log_UserClass :
string = 'Класс контакта: ';
Log_ConnFlag :
string = 'Флаг подключения: ';
Log_ProtoVer :
string = 'Версия протокола: ';
Log_Status :
string = 'Код статуса: ';
Log_TimeInOnline :
string = 'Время проведённое в онлайн: ';
Log_ReqMessage :
string = 'Получен пакет с сообщением от контакта: ';
Log_Msg_Chanel :
string = 'Канал сообщения: ';
Log_Msg_Type :
string = 'Тип сообщения: ';
Log_Msg_Text :
string = 'Текст сообщения:';
Log_Connect_Count :
string = 'Количество подключений к серверу: ';
Log_Lang_Code :
string = 'Код языка системы: ';
Log_Contact_Info :
string = 'Получен пакет информации о контакте: ';
Log_Gtrans_Req :
string = 'Получены данные перевода: %s на %s';
Log_Gtrans_URL :
string = 'Запрос для перевода: %s на %s';
Log_Get :
string = ' get | ';
Log_Send :
string = ' send | ';
Log_Parsing :
string = ' parsing | ';
Log_SetLang :
string = 'Перевод формы: ';
Log_WinVer :
string = 'Версия Windows: %u.%u.%u %s';

{$ENDREGION}

procedure SetLangVars;

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  MainUnit;

{$ENDREGION}
{$REGION 'SetLangVars'}

// Устанавливаем язык для переменных
procedure SetLangVars;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
          begin
            // Загружаем переменные из файла языка
            LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_LangVars];
                if XML_Node <> nil then
                  begin
                    for I := 0 to Length(Lang_Vars) - 1 do
                      begin
                        Sub_Node := XML_Node.Items.ItemNamed[Lang_Vars[I].L_N];
                        if Sub_Node <> nil then
                          Lang_Vars[I].L_S := CheckText_RN(Sub_Node.Properties.Value('c'));
                      end;
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}

end.
