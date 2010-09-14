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
  C_MN = '%0D%0A';
  C_BR = '<br>';
  C_HR = '<HR>';
  C_BN = ' ';
  C_PN = '|';
  C_LN = ';';
  C_TN = ':';
  C_SN = '\';
  C_QN = '[';
  C_EN = ']';
  C_EE = '@';
  C_DD = '_';
  C_XX = 'X';
  С_Hour = 3600000 / MSecsPerDay;
  C_DTseconds = 1 / (SecsPerDay);
  C_DblClickTime = 0.6 * C_DTseconds;
  C_WM_APPBAR = WM_USER + 1;
{$ENDREGION}
{$REGION 'FilesConst'}
  C_Profiles = 'Profiles\';
  C_AnketaFolder = 'Contacts\';
  C_AvatarFolder = 'Avatars\';
  C_HistoryFolder = 'History\';
  C_GamesFolder = 'Games\';
  C_FlagsFolder = 'Flags\';
  C_SmiliesFolder = 'Smilies\';
  C_IconsFolder = 'Icons\';
  C_SoundsFolder = 'Sounds\';
  C_LangsFolder = 'Langs\';
  C_SettingsFileName = 'Settings.xml';
  C_ProfilesFileName = 'Profiles.xml';
  C_GamesCatalogFileName = 'Catalog.txt';
  C_LangPath = 'Langs\%s.xml';
  C_SmiliesPath = 'Smilies\%s\smilies.txt';
  C_IconsPath = 'Icons\%s\icons.bmp';
  C_ContactListFileName = 'Roster.xml';
  C_Nick_BD_FileName = 'Nicks.txt';
  C_ReplyFileName = 'Reply.txt';
  C_NoAvatarFileName = '\noavatar.gif';
  C_ImaderingOld = 'Imadering.old';
  C_XML_Files = '*.xml';
  C_GIF_Ext = '.gif';
  C_JPG_Ext = '.jpg';
  C_JPEG_Ext = '.jpeg';
  C_PNG_Ext = '.png';
  C_BMP_Ext = '.bmp';
  C_XML_Ext = '.xml';
  C_Htm_Ext = '.htm';
{$ENDREGION}
{$REGION 'CommandsConst'}
  // Команды протоколов
  C_IMadering = 'IMadering';
  C_Icq = 'ICQ';
  C_Jabber = 'Jabber';
  C_Mra = 'MRA';
  C_Twitter = 'Twitter';
  // Команды смежного использования
  C_TLV = 'TLV';
  C_Value = ' Value';
  C_NoCL = 'nocl';
  C_IgCL = 'igcl';
  C_Gtrans = 'Gtrans';
  C_MaskPass = '----------------------';
  C_Login = 'Login';
  C_Pass = 'Pass';
  C_SavePass = 'Save_pass';
  C_LangVars = 'Vars';
  C_Infos = 'Infos';
  C_Lang = 'Language';
  C_ExeName = 'Imadering.exe';
  C_Host = 'Host';
  C_Port = 'Port';
  C_Profile = 'Profile';
  C_Cur = 'Current';
  C_Auto = 'Auto_login';
  C_AutoDell = 'Auto_dellete';
  C_Email = 'Email';
  C_MailTo = 'mailto:';
  C_MailText = 'imadering@mail.ru?subject=%s&body=%s';
  C_CustomServer = 'Custom_server';
  C_SocketProto = 'tcp';
  C_HistoryIn = '<span class=b>%s</span><br><span class=c>%s</span><br><br>';
  C_HistoryOut = '<span class=a>%s</span><br><span class=c>%s</span><br><br>';
  C_HistoryInfo = '<span class=d>%s</span><br><br>';
  C_HistoryX = '<IMG NAME=X SRC="" ALIGN=ABSMIDDLE BORDER=0> ';
  C_Group = 'Group';
  C_Contact = 'Contact';
  C_Count = 'count';
  C_Mask = 'mask';
  C_Id = 'Id';
  C_Name = 'Name';
  C_Unk = 'Unk';
  C_Phone = 'Phone';
  C_Phone_m1 = 'phone';
  C_Phone_m2 = 'phon';
  C_Status = 'Status';
  C_Client = 'Client';
  C_Auth = 'Auth';
  C_AuthBoth = 'both';
  C_AuthNone = 'none';
  C_XStatus = 'XStatus';
  C_XText = 'XText';
  C_Geo = 'Geo';
  C_InMess = 'InMess';
  C_OutMess = 'OutMess';
  C_Mess = 'Mess';
  C_Sounds = 'Sounds';
  // Команды для информации
  C_NameInfo = 'Name_info';
  C_Nick = 'Nick';
  C_First = 'First';
  C_Last = 'Last';
  C_PerInfo = 'Personal_info';
  C_Gender = 'Gender';
  C_WebAware = 'WEB_aware';
  C_HomePage = 'Home_page';
  C_LastChange = 'Last_change';
  C_HomeInfo = 'Home_info';
  C_Address = 'Address';
  C_City = 'City';
  C_State = 'State';
  C_Zip = 'Zip';
  C_Country = 'Country';
  C_OHomeInfo = 'Orig_home_info';
  C_LangInfo = 'Lang_info';
  C_PhoneInfo = 'Phone_info';
  C_WorkInfo = 'Work_info';
  C_Corp = 'Corp';
  C_Dep = 'Dep';
  C_Prof = 'Prof';
  C_Site = 'Site';
  C_Occup = 'Occup';
  C_IntInfo = 'Interests_info';
  C_AboutInfo = 'About_info';
  C_AgeInfo = 'Age_info';
  C_Age = 'Age';
  C_Day = 'Day';
  C_Month = 'Month';
  C_Year = 'Year';
  C_EmailsInfo = 'Emails_info';
  C_IntIdInfo = 'Interests_id_info';
  C_PersInfo = 'Personal_x_info';
  C_Marital = 'Marital';
  C_Sexual = 'Sexual';
  C_Height = 'Height';
  C_Relig = 'Relig';
  C_Smok = 'Smok';
  C_Hair = 'Hair';
  C_Children = 'Children';
  // URL ссылки
  C_IcqReg = 'http://www.icq.com/register';
  C_MraReg = 'http://win.mail.ru/cgi-bin/signup';
  C_SitePage = 'http://imadering.com';
  C_DownPage = 'http://imadering.com/download.htm';
  C_PostInTwit = 'http://twitter.com/statuses/update.xml?source=IMadering&status=%s&in_reply_to_status_id=';
  C_GoogleCodeURL = 'http://imadering.googlecode.com/files/';
  C_UpdateURL = 'http://imadering.googlecode.com/files/version.txt';
  // Другие команды
  C_FT = 'Top';
  C_FL = 'Left';
  C_FH = 'Height';
  C_FW = 'Width';
  C_TS = 'Send';
  C_TR = 'Received';
  C_TD = 'Start_date';
  C_PB = 'Button';
  C_CS = 'c';
  C_HS = 'h';
  C_SS = 's';
  // Ответы прокси
  C_Proxy_0_OK = 'HTTP/1.0 200';
  C_Proxy_1_OK = 'HTTP/1.1 200';
  C_Proxy_S0_OK = 'HTTPS/1.0 200';
  C_Proxy_S1_OK = 'HTTPS/1.1 200';
  C_Proxy_0_Err = 'HTTP/1.0 407';
  C_Proxy_1_Err = 'HTTP/1.1 407';
  C_Proxy_S0_Err = 'HTTPS/1.0 407';
  C_Proxy_S1_Err = 'HTTPS/1.1 407';
{$ENDREGION}
{$REGION 'LogLangVars'}

  // Для Лога
  LogMyPath: string = 'Program path';
  LogProfile: string = 'Profile path';
  LogIconCount: string = 'Uploaded %d icons';
  Log_WinVer: string = 'Windows version: %u.%u.%u %s';
  Log_Lang_Code: string = 'System language';
  Log_Get: string = 'get';
  Log_Send: string = 'send';
  Log_Parsing: string = 'parsing';
  Log_Set_Status: string = 'Set status';
  Log_Connect: string = 'Connecting to the server';
  Log_HTTP_Proxy_Connect: string = 'Connecting to the proxy';
  Log_Proxy_OK: string = 'Connecting to proxy OK.';
  Log_Unk_Data: string = 'Get unknown or unimportant data';
  Log_Gtrans_Req: string = 'The data translation: %s into %s';
  Log_Gtrans_URL: string = 'Request for translation: %s into %s';
  Log_Socket: string = 'Socket';
  Log_BosServer: string = 'BosServer';
  Log_PingInterval: string = 'Ping interval';

{$ENDREGION}

var

{$REGION 'GeneralVars'}

  // Переменные общие для всей программы
  V_MyPath: string;
  V_ProfilePath: string;
  V_Profile: string = '';
  V_CurrentIcons: string = 'Imadering';
  V_CurrentLang: string = 'en';
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
  V_AutoDellProfile: Boolean = False;
  V_Roster: TJvSimpleXml;
  V_StartLog: string;

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
  V_SoundConnect: Boolean;
  V_SoundConnect_Name: string;
  V_SoundConnect_Path: string;
  V_SoundConnect_Mask: string = 'Sounds\%s\Connect.wav';
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
  // 11
  V_SoundUserOffline: Boolean;
  V_SoundUserOffline_Name: string;
  V_SoundUserOffline_Path: string;
  V_SoundUserOffline_Mask: string = 'Sounds\%s\UserOffline.wav';
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

{$ENDREGION}
{$REGION 'LangVars'}

  // Переменные для языка | Lang_Vars[127].L_S
  Lang_Vars: packed array[0..127] of record
    L_N, L_S: string;
  end = ((L_N: 'RestoreFromTray'; L_S: ''), // 0
    (L_N: 'HideInTray'; L_S: ''), // 1
    (L_N: 'QuitProgram'; L_S: ''), // 2
    (L_N: 'LinkCompress'; L_S: ''), // 3
    (L_N: 'Version'; L_S: ''), // 4
    (L_N: 'ProfileError'; L_S: ''), // 5
    (L_N: 'DevelMess'; L_S: ''), // 6
    (L_N: 'NotInGroups'; L_S: ''), // 7
    (L_N: 'Close'; L_S: ''), // 8
    (L_N: 'Cancel'; L_S: ''), // 9
    (L_N: 'Apply'; L_S: ''), // 10
    (L_N: 'DumpProto'; L_S: ''), // 11
    (L_N: 'Empty'; L_S: ''), // 12
    (L_N: 'NewVerYES'; L_S: ''), // 13
    (L_N: 'NewVerNO'; L_S: ''), // 14
    (L_N: 'NewVerErr'; L_S: ''), // 15
    (L_N: 'InfoHead'; L_S: ''), // 16
    (L_N: 'ErrorHead'; L_S: ''), // 17
    (L_N: 'AlertHead'; L_S: ''), // 18
    (L_N: 'WarningHead'; L_S: ''), // 19
    (L_N: 'Account'; L_S: ''), // 20
    (L_N: 'LoginError'; L_S: ''), // 21
    (L_N: 'ParsingPktError'; L_S: ''), // 22
    (L_N: 'ConnectError'; L_S: ''), // 23
    (L_N: 'UnknownError'; L_S: ''), // 24
    (L_N: 'DellYourSelf'; L_S: ''), // 25
    (L_N: 'HistorySearchNo'; L_S: ''), // 26
    (L_N: 'HttpErrCode'; L_S: ''), // 27
    (L_N: 'AccountX'; L_S: ''), // 28
    (L_N: 'NoPassChange'; L_S: ''), // 29
    (L_N: 'OkPassChange'; L_S: ''), // 30
    (L_N: 'OnlineAlert'; L_S: ''), // 31
    (L_N: 'TempGroupCaption'; L_S: ''), // 32
    (L_N: 'NoCLGroupCaption'; L_S: ''), // 33
    (L_N: 'PhoneGroupCaption'; L_S: ''), // 34
    (L_N: 'ConnectTime'; L_S: ''), // 35
    (L_N: 'RegDate'; L_S: ''), // 36
    (L_N: 'ProtoVersion'; L_S: ''), // 37
    (L_N: 'ClientVariable'; L_S: ''), // 38
    (L_N: 'CellularPhone'; L_S: ''), // 39
    (L_N: 'Note'; L_S: ''), // 40
    (L_N: 'UpDateAuto'; L_S: ''), // 41
    (L_N: 'UpDateCaption'; L_S: ''), // 42
    (L_N: 'QReply'; L_S: ''), // 43
    (L_N: 'HistoryDell'; L_S: ''), // 44
    (L_N: 'UserCloseChat'; L_S: ''), // 45
    (L_N: 'UserTyping'; L_S: ''), // 46
    (L_N: 'UserStatus'; L_S: ''), // 47
    (L_N: 'HexToText'; L_S: ''), // 48
    (L_N: '---'; L_S: ''), // 49
    (L_N: '---'; L_S: ''), // 50
    (L_N: '---'; L_S: ''), // 51
    (L_N: '---'; L_S: ''), // 52
    (L_N: '---'; L_S: ''), // 53
    (L_N: 'InfoSaveOK'; L_S: ''), // 54
    (L_N: 'UserInfoOK'; L_S: ''), // 55
    (L_N: 'UserInfoReq'; L_S: ''), // 56
    (L_N: 'UserInfoCap'; L_S: ''), // 57
    (L_N: 'GameCaption'; L_S: ''), // 58
    (L_N: 'EmailCount'; L_S: ''), // 59
    (L_N: 'TwitPostOK'; L_S: ''), // 60
    (L_N: 'PostInTwitter'; L_S: ''), // 61
    (L_N: 'CharsCount'; L_S: ''), // 62
    (L_N: 'NoAdmin'; L_S: ''), // 63
    (L_N: 'DownCount'; L_S: ''), // 64
    (L_N: 'NewProgErr'; L_S: ''), // 65
    (L_N: 'HistoryCompressed'; L_S: ''), // 66
    (L_N: 'Status1'; L_S: ''), // 67 Готов поболтать
    (L_N: 'Status2'; L_S: ''), // 68 Злой
    (L_N: 'Status3'; L_S: ''), // 69 Депрессия
    (L_N: 'Status4'; L_S: ''), // 70 Дома
    (L_N: 'Status5'; L_S: ''), // 71 На работе
    (L_N: 'Status6'; L_S: ''), // 72 Кушаю
    (L_N: 'Status7'; L_S: ''), // 73 Отошёл
    (L_N: 'Status8'; L_S: ''), // 74 Недоступен
    (L_N: 'Status9'; L_S: ''), // 75 Занят
    (L_N: 'Status10'; L_S: ''), // 76 Не беспокоить
    (L_N: 'Status11'; L_S: ''), // 77 В сети
    (L_N: 'Status12'; L_S: ''), // 78 Невидимый
    (L_N: 'Status13'; L_S: ''), // 79 Невидимый для всех
    (L_N: 'Status14'; L_S: ''), // 80 Не в сети
    (L_N: 'Status15'; L_S: ''), // 81 Неопределённый
    (L_N: 'Status16'; L_S: ''), // 82 Необходима авторизация
    (L_N: 'DellContact'; L_S: ''), // 83
    (L_N: 'GtransErr_2'; L_S: ''), // 84
    (L_N: 'GtransErr_1'; L_S: ''), // 85
    (L_N: 'GtransOK'; L_S: ''), // 86
    (L_N: 'GtransProcess'; L_S: ''), // 87
    (L_N: 'FileTransfer_1'; L_S: ''), // 88
    (L_N: 'FileTransfer_2'; L_S: ''), // 89
    (L_N: 'FileTransfer_3'; L_S: ''), // 90
    (L_N: 'FileTransfer_4'; L_S: ''), // 91
    (L_N: 'FileTransfer_5'; L_S: ''), // 92
    (L_N: 'FileTransfer_6'; L_S: ''), // 93
    (L_N: '---'; L_S: ''), // 94
    (L_N: 'JabberNullGroup'; L_S: ''), // 95
    (L_N: 'AddNewGroup'; L_S: ''), // 96
    (L_N: 'AddGroupErr_1'; L_S: ''), // 97
    (L_N: 'AddGroupErr_2'; L_S: ''), // 98
    (L_N: 'DellGroupErr'; L_S: ''), // 99
    (L_N: 'DellGroupOK'; L_S: ''), // 100
    (L_N: 'AddGroupOK'; L_S: ''), // 101
    (L_N: 'SearchQMess'; L_S: ''), // 102
    (L_N: 'AddContactErr_1'; L_S: ''), // 103
    (L_N: 'AddContactErr_2'; L_S: ''), // 104
    (L_N: 'AddContactErr_3'; L_S: ''), // 105
    (L_N: 'AddContactErr_4'; L_S: ''), // 106
    (L_N: 'AddContactOK'; L_S: ''), // 107
    (L_N: 'URLOpenErr'; L_S: ''), // 108
    (L_N: 'HistoryNotFile'; L_S: ''), // 109
    (L_N: 'UpDateStart'; L_S: ''), // 110
    (L_N: 'UpDateAbort'; L_S: ''), // 111
    (L_N: 'UpDateLoad'; L_S: ''), // 112
    (L_N: 'UpDateUn'; L_S: ''), // 113
    (L_N: 'UpDateOK'; L_S: ''), // 114
    (L_N: 'GroupContacts'; L_S: ''), // 115
    (L_N: 'HistoryLoading'; L_S: ''), // 116
    (L_N: 'DellGroup'; L_S: ''), // 117
    (L_N: 'ProxyConErr_1'; L_S: ''), // 118
    (L_N: 'ProxyConErr_2'; L_S: ''), // 119
    (L_N: 'LoginError'; L_S: ''), // 120
    (L_N: 'SearchGo'; L_S: ''), // 121
    (L_N: 'SearchEnd'; L_S: ''), // 122
    (L_N: 'SearchNo'; L_S: ''), // 123
    (L_N: 'SearchAuth'; L_S: ''), // 124
    (L_N: 'SearchAuthNo'; L_S: ''), // 125
    (L_N: 'SearchNextPage'; L_S: ''), // 126
    (L_N: 'DellProfile'; L_S: '')); // 127

  Log_Exception1: string = 'В программе произошла ошибка' + C_RN;

  Log_Exception2: string = C_RN + 'Вы можете скопировать её от сюда и выложить для разработчиков на форуме проекта IMadering ' +
    'c описанием действий в следствии которых возникла данная ошибка. Или уведомить об ошибке любым другим способом.';

  InfoNickL:
    string = 'Ник:';
  InfoNameL:
    string = 'Имя:';
  InfoHomeL:
    string = 'Дом:';
  InfoAdressL:
    string = 'Адрес:';
  InfoStateL:
    string = 'Штат:';
  InfoZipL:
    string = 'Индекс:';
  InfoGenderL:
    string = 'Пол:';
  InfoGender1L:
    string = 'Женский';
  InfoGender2L:
    string = 'Мужской';
  InfoAgeL:
    string = 'Возраст:';
  InfoBirDate:
    string = 'Дата рождения:';
  InfoOHomeL:
    string = 'Место рождения:';
  InfoWorkL:
    string = 'Работа:';
  InfoCompanyL:
    string = 'Компания:';
  InfoDeportL:
    string = 'Отдел:';
  InfoPositionL:
    string = 'Должность:';
  InfoOccupationL:
    string = 'Профессия:';
  InfoWebSiteL:
    string = 'Сайт:';
  InfoPhoneL:
    string = 'Телефон:';
  InfoFaxL:
    string = 'Факс:';
  InfoCellularL:
    string = 'Сотовый:';
  InfowPhoneL:
    string = 'Рабочий телефон:';
  InfowFaxL:
    string = 'Рабочий факс:';
  InfoInterestsL:
    string = 'Интересы:';
  InfoAboutL:
    string = 'О себе:';
  InfoHomePageL:
    string = 'Домашняя страничка:';
  InfoLastUpDateL:
    string = 'Дата последнего обновления данных:';
  InfoLangL:
    string = 'Владение языками:';
  InfoMaritalL:
    string = 'Брак:';
  InfoSexualL:
    string = 'Сексуальная ориентация:';
  InfoHeightL:
    string = 'Рост:';
  InfoReligL:
    string = 'Религия:';
  InfoSmokL:
    string = 'Курение:';
  InfoHairL:
    string = 'Цвет волос:';
  InfoChildrenL1:
    string = 'Детей:';

{$ENDREGION}
{$REGION 'ICQ_Connect_Errors_Vars'}

  // Ошибки подключения ICQ протокола
  ConnectErrors_0001:
    string = 'Неправильный номер ICQ или пароль.';
  ConnectErrors_0002:
    string = 'Сервис временно недоступен.';
  ConnectErrors_0003:
    string = 'Ошибка авторизации.';
  ConnectErrors_0004:
    string = 'Неверный номер ICQ или пароль.';
  ConnectErrors_0005:
    string = 'Неверный номер ICQ или пароль.';
  ConnectErrors_0006:
    string = 'Внутренняя ошибка.';
  ConnectErrors_0007:
    string = 'Это неверная учётная запись.';
  ConnectErrors_0008:
    string = 'Эта учётная запись была удалена.';
  ConnectErrors_0009:
    string = 'Это просроченная учётная запись.';
  ConnectErrors_000A:
    string = 'Нет доступа к базе.';
  ConnectErrors_000B:
    string = 'Нет доступа к резольверу.';
  ConnectErrors_000C:
    string = 'Неверные поля в базе данных.';
  ConnectErrors_000D:
    string = 'Неверный статус базы.';
  ConnectErrors_000E:
    string = 'Неверный статус резольвера.';
  ConnectErrors_000F:
    string = 'Внутренняя серверная ошибка.';
  ConnectErrors_0010:
    string = 'Сервис временно отключён.';
  ConnectErrors_0011:
    string = 'Обслуживание этой учётной записи приостановлено.';
  ConnectErrors_0012:
    string = 'Ошибка перенаправления в базе.';
  ConnectErrors_0013:
    string = 'Ошибка линковки в базе.';
  ConnectErrors_0014:
    string = 'Ошибка резервной схемы.';
  ConnectErrors_0015:
    string = 'Ошибка резервной линковки.';
  ConnectErrors_0016:
    string = 'Достигнут предел подключений с этого IP-адреса.';
  ConnectErrors_0017:
    string = 'Достигнут предел подключений с этого IP-адреса.';
  ConnectErrors_0018:
    string = 'Превышен лимит подключений! Попробуйте подключиться позже.';
  ConnectErrors_0019:
    string = 'Эта учётная запись имеет наивысший уровень предупреждений. Попробуйте позже.';
  ConnectErrors_001A:
    string = 'Превышен интервал резервации в базе.';
  ConnectErrors_001B:
    string = 'Вы используете старую версию протокола ICQ. Обновите версию.';
  ConnectErrors_001C:
    string = 'Вы используете старую версию клиента. Рекомендуется обновить версию.';
  ConnectErrors_001D:
    string = 'Превышен лимит подключений! Попробуйте подключиться позже.';
  ConnectErrors_001E:
    string = 'Невозможно зарегистрироваться в сети. Попробуйте позже.';
  ConnectErrors_0020:
    string = 'Неверный SecureID.';
  ConnectErrors_0022:
    string = 'Эта учётная запись недоступна из-за вашего возраста (меньше 13).';

{$ENDREGION}
{$REGION 'HTTP_Errors_Vars'}

  // Ошибки http сокетов
  Err400:
    string = 'Неверный запрос.';
  Err401:
    string = 'Несанкционированно.';
  Err402:
    string = 'Требуется оплата.';
  Err403:
    string = 'Запрещено.';
  Err404:
    string = 'Не найдено.';
  Err405:
    string = 'Метод не допускается.';
  Err406:
    string = 'Не приемлемо.';
  Err407:
    string = 'Требуется авторизация на прокси.';
  Err408:
    string = 'Время ожидания запроса истекло.';
  Err409:
    string = 'Конфликт.';
  Err410:
    string = 'Удален.';
  Err411:
    string = 'Требуется длина.';
  Err412:
    string = 'Предусловие неверно.';
  Err413:
    string = 'Объект запроса слишком большой.';
  Err414:
    string = 'URI запроса слишком большой.';
  Err415:
    string = 'Неподдерживаемый тип медиа.';
  Err416:
    string = 'Диапазон не отвечает требованиям.';
  Err417:
    string = 'Результат не соответствует ожидаемому.';
  Err500:
    string = 'Внутренняя ошибка сервера.';
  Err501:
    string = 'Не реализовано.';
  Err502:
    string = 'Ошибка шлюза.';
  Err503:
    string = 'Сервис недоступен.';
  Err504:
    string = 'Истекло время ожидания от шлюза.';
  Err505:
    string = 'Не поддерживаемая версия HTTP.';

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
                Lang_Vars[I].L_S := XML2Text(CheckText_RN(Sub_Node.Properties.Value(C_CS)));
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

