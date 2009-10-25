﻿{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqProtoUnit;

interface

uses
  Windows,
  MainUnit,
  IcqOptionsUnit,
  SysUtils,
  JvTrayIcon,
  Dialogs,
  OverbyteIcsWSocket,
  ChatUnit,
  MmSystem,
  Forms,
  IcqSearchUnit,
  ComCtrls,
  Messages,
  Classes,
  IcqContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  RXML,
  RosterUnit,
  OverbyteIcsMimeUtils;

const
  DT2100miliseconds = 1 / (SecsPerDay * 10);

const
  // Capabilities
  CAP_AIM_INTEROPERATE = '0946134D4C7F11D18222444553540000';
  CAP_AIM2 = '094600004C7F11D18222444553540000';
  CAP_AIM_ISICQ = '094613444C7F11D18222444553540000';
  CAP_AIM_SERVERRELAY = '094613494C7F11D18222444553540000';
  CAP_UTF8 = '0946134E4C7F11D18222444553540000';
  CAP_TYPING_NOTIFICATION = '563FC8090B6F41BD9F79422609DFA2F3';
  CAP_IMADERING = '494D61646572696E6720436C69656E74';
  CAP_AIM_VOICE = '094613414C7F11D18222444553540000';
  CAP_AIM_SENDFILE = '094613434C7F11D18222444553540000';
  CAP_AIM_IMIMAGE = '094613454C7F11D18222444553540000';
  CAP_AIM_BUDDYICON = '094613464C7F11D18222444553540000';
  CAP_AIM_STOCKS = '094613474C7F11D18222444553540000';
  CAP_AIM_GETFILE = '094613484C7F11D18222444553540000';
  CAP_AIM_GAMES = '0946134A4C7F11D18222444553540000';
  CAP_AIM_SBUD = '0946134B4C7F11D18222444553540000';
  CAP_RTFMSGS = '97B12751243C4334AD22D6ABF73F1492';
  CAP_STR_2001 = 'A0E93F374C7F11D18222444553540000';
  CAP_STR_2002 = '10CF40D14C7F11D18222444553540000';
  CAP_IS_2001 = '2E7A6475FADF4DC8886FEA3595FDB6DF';
  CAP_IS_WEB = '563FC8090B6F41BD9F79422609DFA2F3';
  CAP_LICQ = '094913494C7F11D18222444553540000';
  CAP_AIM_CHAT = '748F2420628711D18222444553540000';
  CAP_TRILL_CRYPT = 'F2E7C7F4FEAD4DFBB23536798BDF0000';
  CAP_TRILL_UNK = '97B12751243C4334AD22D6ABF73F1409';
  CAP_MACICQ = 'DD16F20284E611D490DB00104B9B4B7D';
  CAP_KXICQ = '094913444C7F11D18222444553540000';
  CAP_ICQ_XTRAZ_SUPPORT = '1A093C6CD7FD4EC59D51A6474E34F5A0';
  CAP_RAMBLER_RU = '7E11B778A3534926A80244735208C42A';
  CAP_MIRANDA = '4D6972616E64614D0006000B80030802';
  CAP_QIP = '563FC8090B6F41514950203230303561';
  CAP_QIP_PROTECTMSG = 'D3D453198B32403BACC7D1A9E2B5813E';
  CAP_ICQDEVILS = '0946134C4C7F11D18222444553540000';
  CAP_ANDRQ = '265251696E7369646510040900000000';
  CAP_PUSH2TALK = 'E362C1E9121A4B94A6267A74DE24270D';
  CAP_VOICE_CHAT = 'B99708B53A924202B069F1E757BB2E17';
  CAP_ICQLITE = '178C2D9BDAA545BB8DDBF3BDBD53A10A';
  CAP_MULTI_USER = '67361515612D4C078F3DBDE6408EA041';
  CAP_LICQ2 = '4C69637120636C69656E740000000020';
  CAP_JIMM = '4A696D6D20302E362E31000000000000';
  CAP_IMPLUS = '8ECD90E74F1828F802ECD618A4E9DE68';
  CAP_NETVIGATOR = '4C6B90A33D2D480E89D62E4B2C10D99F';
  CAP_KOPETE = '4B6F70657465204943512020000A0300';
  CAP_MCHAT = '6D436861742069637120000000000000';
  CAP_SIM = '53494D20636C69656E74202000090540';
  CAP_QIP_INFIUM = '7C737502C3BE4F3EA69F015313431E1A';
  CAP_RNQ = 'D6687F4F3DC34BDB8A8C4C1A572763CD';

const
  // XStatuses
  XS1 = '01D8D7EEAC3B492AA58DD3D877E66B92'; // (Angry)
  XS2 = '5A581EA1E580430CA06F612298B7E4C7'; // (Duck)
  XS3 = '83C9B78E77E74378B2C5FB6CFCC35BEC'; // (Tired)
  XS4 = 'E601E41C33734BD1BC06811D6C323D81'; // (Party)
  XS5 = '8C50DBAE81ED4786ACCA16CC3213C7B7'; // (Beer)
  XS6 = '3FB0BD36AF3B4A609EEFCF190F6A5A7F'; // (Thinking)
  XS7 = 'F8E8D7B282C4414290F810C6CE0A89A6'; // (Eating)
  XS8 = '80537DE2A4674A76B3546DFD075F5EC6'; // (TV)
  XS9 = 'F18AB52EDC57491D99DC6444502457AF'; // (Friends)
  XS10 = '1B78AE31FA0B4D3893D1997EEEAFB218'; // (Coffee)
  XS11 = '61BEE0DD8BDD475D8DEE5F4BAACF19A7'; // (Music)
  XS12 = '488E14898ACA4A0882AA77CE7A165208'; // (Business)
  XS13 = '107A9A1812324DA4B6CD0879DB780F09'; // (Camera)
  XS14 = '6F4930984F7C4AFFA27634A03BCEAEA7'; // (Funny)
  XS15 = '1292E5501B644F66B206B29AF378E48D'; // (Phone)
  XS16 = 'D4A611D08F014EC09223C5B6BEC6CCF0'; // (Games)
  XS17 = '609D52F8A29A49A6B2A02524C5E9D260'; // (College)
  XS18 = '63627337A03F49FF80E5F709CDE0A4EE'; // (Shopping)
  XS19 = '1F7A4071BF3B4E60BC324C5787B04CF1'; // (Sick)
  XS20 = '785E8C4840D34C65886F04CF3F3F43DF'; // (Sleeping)
  XS21 = 'A6ED557E6BF744D4A5D4D2E7D95CE81F'; // (Surfing)
  XS22 = '12D07E3EF885489E8E97A72A6551E58D'; // (@)
  XS23 = 'BA74DB3E9E24434B87B62F6B8DFEE50F'; // (Engineering)
  XS24 = '634F6BD8ADD24AA1AAB9115BC26D05A1'; // (Typing)
  XS25 = '2CE0E4E57C6443709C3A7A1CE878A7DC'; // (China1)
  XS26 = '101117C9A3B040F981AC49E159FBD5D4'; // (China2)
  XS27 = '160C60BBDD4443F39140050F00E6C009'; // (China3)
  XS28 = '6443C6AF22604517B58CD7DF8E290352'; // (China4)
  XS29 = '16F5B76FA9D240358CC5C084703C98FA'; // (China5)
  XS30 = '631436FF3F8A40D0A5CB7B66E051B364'; // (De1)
  XS31 = 'B70867F538254327A1FFCF4CC1939797'; // (De2)
  XS32 = 'DDCF0EA971954048A9C6413206D6F280'; // (De3)
  XS33 = 'D4E2B0BA334E4FA598D0117DBF4D3CC8'; // (RuSearch)
  XS34 = 'CD5643A2C94C4724B52CDC0124A1D0CD'; // (RuLove)
  XS35 = '0072D9084AD143DD91996F026966026F'; // (RuJournal)
  // Custom + XStatuses
  XS36 = '3FB0BD36AF3B4A609EEFCF190F6A5A7E'; // (Smoke)
  XS37 = 'E601E41C33734BD1BC06811D6C323D82'; // (Sex)

  // XStatuses Codes
  XSC1 = 'icqmood23';
  XSC2 = 'icqmood1';
  XSC3 = 'icqmood2';
  XSC4 = 'icqmood3';
  XSC5 = 'icqmood4';
  XSC6 = 'icqmood5';
  XSC7 = 'icqmood6';
  XSC8 = 'icqmood7';
  XSC9 = 'icqmood8';
  XSC10 = 'icqmood9';
  XSC11 = 'icqmood10';
  XSC12 = 'icqmood11';
  XSC13 = 'icqmood12';
  XSC14 = 'icqmood13';
  XSC15 = 'icqmood14';
  XSC16 = 'icqmood15';
  XSC17 = 'icqmood16';
  XSC18 = 'icqmood0';
  XSC19 = 'icqmood17';
  XSC20 = 'icqmood18';
  XSC21 = 'icqmood19';
  XSC22 = 'icqmood20';
  XSC23 = 'icqmood21';
  XSC24 = 'icqmood22';
  XSC25 = 'icqmood24';
  XSC26 = 'icqmood25';
  XSC27 = 'icqmood26';
  XSC28 = 'icqmood27';
  XSC29 = 'icqmood28';
  XSC30 = 'icqmood29';
  XSC31 = 'icqmood30';
  XSC32 = 'icqmood31';
  XSC33 = 'icqmood32';
  XSC34 = 'icqmood33';
  XSC35 = 'icqmood34';
  XSC36 = 'icqmood35';
  XSC37 = 'icqmood36';

  // Типы BART_ID
  BUDDY_ICON_SMALL = 0;
  BUDDY_ICON = 1;
  STATUS_STR = 2;
  ARRIVE_SOUND = 3;
  RICH_TEXT = 4;
  SUPERBUDDY_ICON = 5;
  RADIO_STATION = 6;
  BUDDY_ICON_BIG = 12;
  STATUS_STR_TOD = 13;
  STATUS_MOOD = 14;
  CURRENT_AV_TRACK = 15;
  DEPART_SOUND = 96;
  IM_CHROME = 129;
  IM_SOUND = 131;
  IM_CHROME_XML = 136;
  IM_CHROME_IMMERS = 137;
  EMOTICON_SET = 1024;
  ENCR_CERT_CHAIN = 1026;
  SIGN_CERT_CHAIN = 1027;
  GATEWAY_CERT = 1028;

const
  BUDDY_NORMAL = $0000; // normal contact list entry
  BUDDY_GROUP = $0001; // larger group header
  BUDDY_VISIBLE = $0002; // contact on the visible list
  BUDDY_INVISIBLE = $0003; // contact on the invisible list
  BUDDY_UPGROUP = $0004; // update group
  BUDDY_PRESENCEINFO = $0005; // presence info
  BUDDY_IGNORE = $000E; // contact on the ignore list
  BUDDY_IMPORTTIME = $0013; // import time
  BUDDY_AVATARINFO = $0014; // avatar info
  BUDDY_LASTUPDATE = $000F; // last update date
  BUDDY_AUTORIZ = $001B; // deletes contact
  BUDDY_VANITY = $001D; // vanity info
  BUDDY_DELETE = $0019; // deletes contact
  BUDDY_ICQMDIR = $0020; // icq mdir

  // Users online statuses
  ICQ_Status_ONLINE = '0000'; // Online 7
  ICQ_Status_INVISIBLE = '0100'; // Invisible 10
  ICQ_Status_AWAY = '0001'; // Away 8
  ICQ_Status_NA = '0004'; // NA 14
  ICQ_Status_NA1 = '0005'; // NA 14
  ICQ_Status_OCCUPIED = '0010'; // Occupied 12
  ICQ_Status_OCCUPIED1 = '0011'; // Occupied 12
  ICQ_Status_DND = '0002'; // Do Not Disturb 13
  ICQ_Status_DND1 = '0012'; // Do Not Disturb 13
  ICQ_Status_DND2 = '0013'; // Do Not Disturb 13
  ICQ_Status_FFC = '0020'; // Free For Chat 16
  ICQ_Status_EVIL = '3000'; // Evil [qip] 18
  ICQ_Status_DEPRESSION = '4000'; // Depression [qip] 17
  ICQ_Status_ATHOME = '5000'; // Home [qip] 19
  ICQ_Status_ATWORK = '6000'; // Work [qip] 20
  ICQ_Status_LUNCH = '2001'; // Lunch [qip] 15
  ICQ_Status_OFFLINE = 'FFFF'; // Set status to offline 9
  ICQ_Status_UNK = '8888'; // Unknown status 214
  // Не авторизован статус и иконка номер 80 предупредительная иконка номер 220

  M_PLAIN = $01; // Plain message
  M_CHAT = $02; // Chat request
  M_FILE = $03; // File request
  M_URL = $04; // URL
  M_AUTH_REQ = $06; // Auth request
  M_AUTH_DENIED = $07; // Deny auth
  M_AUTH_GIVEN = $08; // Authorize
  M_SERVER = $09; // Message from OSCAR server
  M_WEB_PAGE = $0D; // Web pager message
  M_EMAIL_EXPRESS = $0E; // Email express message
  M_CONTACTS = $13; // Contact list message
  M_ADVANCED = $1A; // Plugin message described by text string
  M_AUTOAWAY = $E8; // Auto away message
  M_AUTOBUSY = $E9; // Auto occupied message
  M_AUTONA = $EA; // Auto not available message
  M_AUTODND = $EB; // Auto do not disturb message
  M_AUTOFFC = $EC; // Auto free for chat message

  ICQ_FLAP_HEAD_SIZE = 6;

var
  ICQ_Bos_IP: string;
  ICQ_Bos_Port: string;
  ICQ_myBeautifulSocketBuffer: string;
  ICQ_LoginServerAddr: string = 'login.icq.com';
  ICQ_LoginServerPort: string = '5190';
  ICQ_BuffPkt: string;
  // ICQ_RegUIN_HexPkt: string;
  ICQ_Avatar_HexPkt: string;
  ICQ_LoginUIN: string = '';
  ICQ_LoginPassword: string = '';
  ICQ_ChangePassword: string = '';
  // Фазы работы начало
  ICQ_Connect_Phaze: Boolean = False;
  ICQ_HTTP_Connect_Phaze: Boolean = False;
  ICQ_BosConnect_Phaze: Boolean = False;
  ICQ_Work_Phaze: Boolean = False;
  ICQ_Offline_Phaze: Boolean = True;
  // Фазы работы конец
  ICQ_CurrentStatus: Integer = 9;
  ICQ_CurrentStatus_bac: Integer = 9;
  ICQ_X_CurrentStatus: Integer = 0;
  ICQ_X_CurrentStatus_Cap: string = '';
  ICQ_X_CurrentStatus_Code: string = '';
  ICQ_X_CurrentStatus_Text: string = '';
  ICQ_Seq: Word = $1000;
  ICQ_Avatar_Seq: Word = $2000;
  ICQ_Bos_Cookie: string;
  ICQ_Online_IP: string;
  ICQ_MyUIN_RegTime: string;
  ICQ_Show_HideContacts: Boolean = False;
  ICQ_CollSince, ICQ_SendMess, ICQ_OnlineTime, ICQ_AwayMess, ICQ_RecMess, ICQ_LastActive: string; // Vanity info
  ICQ_MyIcon_Hash: string;
  ICQ_KeepAlive: Boolean = True;
  ICQ_Reconnect: Boolean = False;
  ICQ_SSI_Phaze: Boolean = False;
  ICQ_Add_Contact_Phaze: Boolean = False;
  ICQ_Add_UIN, ICQ_Add_GroupId, ICQ_Add_cId, ICQ_Add_Nick: string;
  ICQ_Group_Delete_Phaze: Boolean = False;
  ICQ_Add_Group_Phaze: Boolean = False;
  ICQ_ReqInfo_UIN: string;
  ICQ_Avatar_Connect_Phaze: Boolean = False;
  ICQ_Avatar_Work_Phaze: Boolean = False;
  ICQ_Avatar_Cookie: string = '';
  ICQ_GetAvatar_UIN: string = '';
  ICQ_GetAvatar_Hash: string = '';
  ICQ_WebAware_Enabled: Boolean = False;
  ICQ_BirthDay_Enabled: Boolean = False;
  ICQ_PrivatStatus_Enabled: Boolean = True;
  ICQ_UpdatePrivateGroup_Code: string;
  MyConnTime: string;
  NewKL: Boolean;
  ICQ_Bos_Addr: string = '';
  ICQ_CL_Count: Integer = 0;

procedure ICQ_NotifyUserStatus(UIN, IStatus, IClient: string; IColor: Integer);
procedure ICQ_GoOffline;
function ICQ_MD5CliLoginPkt(cPass, cKey: RawByteString): string;
function ICQ_NotifyAuthCookieError(ErrCode: string): string;
function ICQ_CliCookiePkt(Cookie: string): string;
function ICQ_CliFamilyPkt: string;
procedure ICQ_Parse_010F(PktData: string);
function ICQ_Parse_1306(PktData: string): Boolean;
function ICQ_GenerateClientCaps(ClientName, CVer: string): string;
function ICQ_CliSetFirstOnlineInfoPkt(XClient, XVer, XStatusCap, Cap1, Cap2, Cap3: string): string;
function ICQ_CliSetICBMparametersPkt: string;
function ICQ_CliSetFirstStatusPkt: string;
function ICQ_StatusImgId2Code(ImgId: Integer): string;
function ICQ_CliClientReadyPkt: string;
function ICQ_CreateShortStatusPkt: string;
procedure ICQ_UserUnkStatus_030A(PktData: string);
procedure ICQ_UserOnline_Event(UIN, Status, UserClass, IntIP, IntPort, ExtIP, ConnFlag, ProtoVer, TimeReg, CapsId, Caps, IconHash,
  ConnTime: string);
function ICQ_StatusCode2ImgId(StatusCode: string): Integer;
procedure ICQ_UserOnline_030B(PktData: string; CheckStatus: Boolean);
procedure ICQ_UserOffline_030C(PktData: string);
procedure ICQ_SendMessage_0406(SUIN, SMsg: string; Old: Boolean);
procedure ICQ_ReqMessage_0407(PktData: string);
procedure ICQ_ReqMsgNotify(UIN, Msg, Status, UserClass, IntIP, IntPort, ExtIP, TimeReg, IconHash, ConnTime: string);
// procedure ICQ_SendRegNewUIN(Pass, ImgWord: string);
procedure ICQ_SearchPoUIN_new(SUIN: string);
procedure ICQ_SearchPoEmail_new(SEmail: string);
procedure ICQ_SearchPoText_new(SText: string; OnlyOn: Boolean);
procedure ICQ_Parse_SNAC_1503(PktData: string);
procedure ICQ_NotifyAddSearchResults(AUIN, ANick, AFirst, ALast, AAge, AEmail, ACountry, ACity: string; AGender, AStatus: Integer;
  AAuth, AEndSearch: Boolean);
procedure ICQ_ReqStatus0215(UIN: string);
procedure ICQ_SetInfoP;
procedure ICQ_SetStatusXText(XText, XCode: string);
procedure ICQ_DeleteTempContact(UIN, CId, CType, TimeId: string);
procedure ICQ_AddStart;
procedure ICQ_AddEnd;
procedure ICQ_DeleteContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
procedure ICQ_SendGrandAuth(UIN: string);
procedure ICQ_SendYouAdded(UIN: string);
procedure ICQ_DellMyFromCL(UIN: string);
procedure ICQ_AddContact(UIN, GroupId, CId, Nick: string; NoAuth: Boolean);
procedure ICQ_Parse_130E_UpdateAck(PktData: string);
procedure ICQ_UpdateGroup_AddContact(GrCaption, IGroupId: string; CiDlist: TStringList);
procedure ICQ_DeleteGroup(GName, GId: string);
procedure ICQ_UpdateGroup_AddGroup(GiDlist: TStringList);
procedure ICQ_AddGroup(GName, GId: string);
procedure ICQ_RenameAndEditContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
procedure ICQ_DeleteTempContactMulti(TCList: TStringList);
procedure ICQ_ReqAuthSend(UIN, Mess: string);
procedure ICQ_ReqInfo_New_Pkt(SUIN: string);
// procedure ICQ_ReqInfo_New_Pkt_1(sUIN: string);
procedure ICQ_SaveNew_InfoPkt(CUIN, CNick, CFirst, CLast, CGender, CAddress, CCity, CState, CZip, OCity, OState, Phone1, Phone2, Phone3,
  Phone4, Phone5, CHomePage, WCity, WState, WZip, WAddress, WCorp, WDep, WProf, WSite, Int1, Int2, Int3, Int4, CAbout, CDay, CMon, CYear,
  CEmail1, CEmail2, CEmail3: string; CCountry, OCountry, Lang1, Lang2, Lang3, WCountry, WOccup, Int_id1, Int_id2, Int_id3, Int_id4,
  CMarital, CSexual, CHeight, CRelig, CSmok, CHair, CChildren: Integer);
procedure ICQ_UserSentTyping_0414(PktData: string);
procedure ICQ_SRV_MSGACK_ADVANCED(PktData: string; ClientOk: Boolean);
procedure ICQ_Send_SMS(CNumber, Smstext: string);
function ICQ_StatusCode2String(StatusCode: string): string;
function ICQ_ClientCap2String(ClientCap: string): string;
procedure ICQ_SearchNewBase(NickName, FirstName, LastName, City, Keywords: string; Gender, AgeRange, Marital, Country, Language,
  PageIndex: Integer; OnlineOnly: Boolean);
procedure ICQ_GetAvatarBosServer;
procedure ICQ_Parse_0105(PktData: string);
procedure ICQ_GetAvatarImage(AUIN, AHash: string);
procedure ICQ_Parse_UserAvatar(PktData: string);
procedure ICQ_SaveInfo_Auth_WebAvare(IAuth, IWebAvare: Boolean);
procedure ICQ_UpdatePrivate_Group(InvizStatus: string);
procedure ICQ_PassChange(Pass: string);
function ICQ_CreateHint(RosterItem: TListItem): string;

implementation

uses
  UtilsUnit,
  OverbyteIcsMD5;

procedure ICQ_PassChange(Pass: string);
var
  Len: Integer;
  Pkt, Pkt1: string;
begin
  // Собираем пакет для смены пароля
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'd007' + IntToHex(Random($9000), 4) + '2e04' + IntToHex(Swap16(Length(Pass)), 4)
    + Text2Hex(Pass) + '00';
  Len := Length(Hex2Text(Pkt1));
  Pkt1 := IntToHex((Len + 2), 4) + IntToHex(Swap16(Len), 4) + Pkt1;
  Pkt := '00150002000000000000' + '0001' + Pkt1;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_SaveInfo_Auth_WebAvare(IAuth, IWebAvare: Boolean);
var
  Pkt, Pkt1, Pkt2, Pkt3, IA, IW: string;
  Len, Len1, Len2: Integer;
begin
  // Собираем пакет для сохранения настройки авторизации и вебаваре статуса
  if IAuth then
    IA := '0000'
  else
    IA := '0001';
  if IWebAvare then
    IW := '01'
  else
    IW := '00';
  Randomize;
  Pkt3 := '019A0002' + IA + '02120001' + IW;
  Len2 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B90FD2000000000000000004E3000000020003' + IntToHex(Len2, 4) + Pkt3;
  Len1 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'D20F' + IntToHex(Swap16(Len1), 4) + Pkt2;
  Len := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000004' + '0001' + IntToHex(Len + 2, 4) + IntToHex(Swap16(Len), 4) + Pkt1;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_Parse_UserAvatar(PktData: string);
{ var
  aUIN, ImageStr, ImageHex, iHash, ImageType: string;
  Len: integer;
  ImageData: TMemoryStream; }
begin
  { Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    aUIN := Hex2Text(NextData(PktData, Len));
    NextData(PktData, 4); //--skip 0001
    NextData(PktData, 2); //--skip xx
    Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    iHash := NextData(PktData, Len); //--get hash
    NextData(PktData, 2); //--skip xx
    NextData(PktData, 4); //--skip 0001
    NextData(PktData, 2); //--skip xx
    Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    NextData(PktData, Len); //--skip hash
    //
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    ImageHex := NextData(PktData, Len);
    ImageStr := Hex2Text(ImageHex);
    if ImageHex > EmptyStr then
    begin
    ImageData := TMemoryStream.Create;
    try
    ImageData.Write(ImageStr[1], Length(ImageStr));
    ImageType := NextData(ImageHex, 4);
    if ImageType = 'FFD8' then
    ImageData.SaveToFile(MyPath + 'Users\Avatars\' + iHash + '.jpg')
    else if ImageType = '4749' then
    ImageData.SaveToFile(MyPath + 'Users\Avatars\' + iHash + '.gif')
    else if ImageType = '424D' then
    ImageData.SaveToFile(MyPath + 'Users\Avatars\' + iHash + '.bmp');
    finally
    ImageData.Free;
    end;
    end; }
end;

procedure ICQ_GetAvatarImage(AUIN, AHash: string);
{ var
  Pkt: string; }
begin
  { //--Собираем пакет запроса аватара контакта
    Pkt := '00100006000050000006' + IntToHex(Length(aUIN), 2) + Text2Hex(aUIN) +
    '0100010010' + aHash;
    //--Отсылаем пакет
    SendFLAP_Avatar('2', Pkt); }
end;

procedure ICQ_Parse_0105(PktData: string);
{ var
  Len: integer;
  BosIP: string; }
begin
  { NextData(PktData, 16);
    while Length(PktData) > 0 do
    begin
    case HexToInt(NextData(PktData, 4)) of
    $0005:
    begin
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    BosIP := Hex2Text(NextData(PktData, Len));
    end;
    $0006:
    begin
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    ICQ_Avatar_Cookie := NextData(PktData, Len);
    end
    else
    begin
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    NextData(PktData, Len);
    end;
    end;
    end;
    //
    if (BosIP > EmptyStr) and (ICQ_Avatar_Cookie > EmptyStr) then
    begin
    try
    ICQ_Avatar_Work_Phaze := false;
    //
    MainForm.ICQAvatarWSocket.Addr := BosIP;
    MainForm.ICQAvatarWSocket.Port := '5190';
    MainForm.ICQAvatarWSocket.Proto := 'tcp';
    //
    MainForm.ICQAvatarWSocket.Connect;
    except
    on E: Exception do
    TLogger.Instance.WriteMessage(E);
    end;
    end; }
end;

procedure ICQ_GetAvatarBosServer;
begin
  // Отсылаем запрос адреса сервера аватар
  // SendFLAP('2', '00010004000048C40004' + '0010');
end;

procedure ICQ_SearchNewBase(NickName, FirstName, LastName, City, Keywords: string; Gender, AgeRange, Marital, Country, Language,
  PageIndex: Integer; OnlineOnly: Boolean);
var
  Pkt, PktSub, Utf8_Nick, Utf8_First, Utf8_Last, Utf8_City, Utf8_Key: string;
  Len: Integer;
begin
  // Преобразуем строки в UTF-8
  Utf8_Nick := StrToUtf8(NickName);
  Utf8_First := StrToUtf8(FirstName);
  Utf8_Last := StrToUtf8(LastName);
  Utf8_City := StrToUtf8(City);
  Utf8_Key := StrToUtf8(Keywords);
  // Обнуляем переменные
  Pkt := EmptyStr;
  PktSub := EmptyStr;
  // Формируем код возраста
  case AgeRange of
    1: PktSub := '0011000D';
    2: PktSub := '00160012';
    3: PktSub := '001D0017';
    4: PktSub := '0027001E';
    5: PktSub := '00310028';
    6: PktSub := '003B0032';
    7: PktSub := '0078003C';
  end;
  if PktSub <> EmptyStr then
    PktSub := '01540004' + PktSub;
  // Формируем основной пакет
  if NickName <> EmptyStr then
    Pkt := '0078' + IntToHex(Length(Utf8_Nick), 4) + Text2Hex(Utf8_Nick);
  if FirstName <> EmptyStr then
    Pkt := Pkt + '0064' + IntToHex(Length(Utf8_First), 4) + Text2Hex(Utf8_First);
  if LastName <> EmptyStr then
    Pkt := Pkt + '006E' + IntToHex(Length(Utf8_Last), 4) + Text2Hex(Utf8_Last);
  if City <> EmptyStr then
    Pkt := Pkt + '00A0' + IntToHex(Length(Utf8_City), 4) + Text2Hex(Utf8_City);
  if Gender > -1 then
    Pkt := Pkt + '00820001' + IntToHex(Gender, 2);
  if Marital > -1 then
    Pkt := Pkt + '012C0002' + IntToHex(Marital, 4);
  if Country > -1 then
    Pkt := Pkt + '00BE0004' + IntToHex(Country, 8);
  Pkt := Pkt + PktSub;
  if Language > -1 then
    Pkt := Pkt + '00FA0002' + IntToHex(Language, 4);
  if OnlineOnly then
    Pkt := Pkt + '013600020001';
  if Keywords <> EmptyStr then
    Pkt := Pkt + '017C' + IntToHex(Length(Utf8_Key), 4) + Text2Hex(Utf8_Key);
  Pkt := '05B90FA0000000000000000004E3000000020002' + IntToHex(PageIndex, 4) + '0001' + IntToHex(Length(Hex2Text(Pkt)), 4) + Pkt;
  Pkt := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'A00F' + IntToHex(Length(Hex2Text(Pkt)), 4)
    + Pkt;
  Len := Length(Hex2Text(Pkt));
  Pkt := '00150002000000000002' + '0001' + IntToHex(Len + 2, 4) + IntToHex(Swap16(Len), 4) + Pkt;
  // Отправляем пакет
  ICQ_ReqInfo_UIN := EmptyStr;
  SendFLAP('2', Pkt);
end;

function ICQ_ClientCap2String(ClientCap: string): string;
begin
  Result := EmptyStr;
  // Определяем клиент по капабилитисам
  if BMSearch(0, ClientCap, CAP_IMADERING) > -1 then
    Result := 'IMadering'
  else if BMSearch(0, ClientCap, CAP_QIP) > -1 then
    Result := 'QIP 2005'
  else if BMSearch(0, Hex2Text(ClientCap), 'MirandaM') > -1 then
    Result := 'Miranda'
  else if BMSearch(0, Hex2Text(ClientCap), '&RQinside') > -1 then
    Result := '&RQ'
  else if BMSearch(0, Hex2Text(ClientCap), 'Smaper') > -1 then
    Result := 'Smaper'
  else if BMSearch(0, ClientCap, CAP_RNQ) > -1 then
    Result := 'R&Q'
  else if BMSearch(0, ClientCap, CAP_MACICQ) > -1 then
    Result := 'MacICQ'
  else if BMSearch(0, ClientCap, CAP_KXICQ) > -1 then
    Result := 'KXICQ'
  else if BMSearch(0, ClientCap, CAP_PUSH2TALK) > -1 then
    Result := 'ICQ 5.1'
  else if BMSearch(0, ClientCap, CAP_ICQLITE) > -1 then
    Result := 'ICQ Lite'
  else if BMSearch(0, ClientCap, CAP_NETVIGATOR) > -1 then
    Result := 'Netvigator'
  else if BMSearch(0, ClientCap, CAP_IMPLUS) > -1 then
    Result := 'IM +'
  else if BMSearch(0, Hex2Text(ClientCap), 'Jimm') > -1 then
    Result := 'Jimm'
  else if BMSearch(0, Hex2Text(ClientCap), 'Kopete') > -1 then
    Result := 'Kopete'
  else if BMSearch(0, Hex2Text(ClientCap), 'Licq client') > -1 then
    Result := 'LICQ'
  else if BMSearch(0, Hex2Text(ClientCap), 'mChat icq') > -1 then
    Result := 'mChat'
  else if BMSearch(0, ClientCap, CAP_RAMBLER_RU) > -1 then
    Result := 'Rambler ICQ'
  else if BMSearch(0, Hex2Text(ClientCap), 'SIM client') > -1 then
    Result := 'SIM'
  else if BMSearch(0, ClientCap, CAP_TRILL_CRYPT) > -1 then
    Result := 'Trillian'
  else if BMSearch(0, ClientCap, CAP_QIP_INFIUM) > -1 then
    Result := 'QIP Infium';
end;

function ICQ_StatusCode2String(StatusCode: string): string;
var
  ShortStatus: string;
begin
  // Обрезаем статус до 4 символов для чистоты распознавания статуса
  ShortStatus := RightStr(StatusCode, 4);
  //
  Result := LStatus15;
  if ShortStatus = ICQ_Status_ONLINE then
    Result := LStatus11
  else if ShortStatus = ICQ_Status_AWAY then
    Result := LStatus7
  else if ShortStatus = ICQ_Status_OFFLINE then
    Result := LStatus14
  else if ShortStatus = ICQ_Status_INVISIBLE then
    Result := LStatus12
  else if ShortStatus = ICQ_Status_OCCUPIED then
    Result := LStatus9
  else if ShortStatus = ICQ_Status_OCCUPIED1 then
    Result := LStatus9
  else if ShortStatus = ICQ_Status_DND then
    Result := LStatus10
  else if ShortStatus = ICQ_Status_DND1 then
    Result := LStatus10
  else if ShortStatus = ICQ_Status_DND2 then
    Result := LStatus10
  else if ShortStatus = ICQ_Status_NA then
    Result := LStatus8
  else if ShortStatus = ICQ_Status_NA1 then
    Result := LStatus8
  else if ShortStatus = ICQ_Status_LUNCH then
    Result := LStatus6
  else if ShortStatus = ICQ_Status_FFC then
    Result := LStatus1
  else if ShortStatus = ICQ_Status_DEPRESSION then
    Result := LStatus3
  else if ShortStatus = ICQ_Status_EVIL then
    Result := LStatus2
  else if ShortStatus = ICQ_Status_ATHOME then
    Result := LStatus4
  else if ShortStatus = ICQ_Status_ATWORK then
    Result := LStatus5
  else if ShortStatus = ICQ_Status_UNK then
    Result := LStatus15;
end;

function ICQ_CreateHint(RosterItem: TListItem): string;
var
  LnLf: string;
begin
  // Формируем всплывающую подсказку для контакта ICQ
  if RosterItem <> nil then
    begin
      // Учётная запись
      Result := '<b>UIN: ' + RosterItem.Caption + '</b>';
      // Ник
      if RosterItem.SubItems[0] <> RosterItem.Caption then
        Result := Result + '<br><b>' + RosterItem.SubItems[0] + '</b>';
      Result := Result + '<br>';
      // Имя и Фамилия
      LnLf := NameAndLast(RosterItem.Caption, RosterItem.SubItems[3]);
      if LnLf <> EmptyStr then
        Result := Result + '<b>' + LnLf + '</b><br>';
      // Если стасут оффлайн или неизвестный, то пишем "Не в сети"
      if (RosterItem.SubItems[6] = '9') or (RosterItem.SubItems[6] = '214') then
        Result := Result + '<font color=clred>' + ICQ_StatusCode2String(ICQ_StatusImgId2Code(9))
        // Если статус требует авторизации, то пишем об этом
      else if RosterItem.SubItems[6] = '80' then
        Result := Result + '<font color=clred>' + LStatus17
        // Определяем статус и пишем его словами
      else
        Result := Result + '<font color=clblue>' + ICQ_StatusCode2String(ICQ_StatusImgId2Code(StrToInt(RosterItem.SubItems[6])));
      Result := Result + '</font>';
      // Если есть текст доп. статуса, то пишем его
      if RosterItem.SubItems[31] <> EmptyStr then
        Result := Result + '<br><font color=clred>' + RosterItem.SubItems[31] + '</font>';
      // Время подключения
      if RosterItem.SubItems[30] <> EmptyStr then
        Result := Result + '<br>' + ConnTimeL + ' ' + RosterItem.SubItems[30];
      // Дата регистрации UIN
      if RosterItem.SubItems[26] <> EmptyStr then
        Result := Result + '<br>' + RegDateL + ' ' + RosterItem.SubItems[26];
      // Версия протокола
      if RosterItem.SubItems[25] <> EmptyStr then
        Result := Result + '<br>' + ProtoVerL + ' ' + RosterItem.SubItems[25];
      // Клиент
      if RosterItem.SubItems[32] <> EmptyStr then
        Result := Result + '<br>' + ClientVariableL + ' ' + RosterItem.SubItems[32];
      // Телефон
      if RosterItem.SubItems[9] <> EmptyStr then
        Result := Result + '<br>' + CellularPhoneL + ' ' + RosterItem.SubItems[9];
      // Заметка
      if RosterItem.SubItems[10] <> EmptyStr then
        Result := Result + '<br>' + NoteL + ' ' + RosterItem.SubItems[10];
      // Email
      if RosterItem.SubItems[11] <> EmptyStr then
        Result := Result + '<br>' + EmailL + ' ' + RosterItem.SubItems[11];
      // Флаг подключения
      if RosterItem.SubItems[24] <> EmptyStr then
        Result := Result + '<br>' + ConnectFlagL + ' ' + RosterItem.SubItems[20] + ' ' + RosterItem.SubItems[24];
    end;
end;

procedure ICQ_Send_SMS(CNumber, Smstext: string);
{ var
  Pkt: string;
  Utf8Mess: string;
  CoocId: string; }
begin
  { //--Собираем пакет для отправки SMS (в россии перехватывает рамблер)
    Utf8Mess := StrToUtf8(smstext);
    Randomize;
    CoocId := IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4) +
    IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4);
    Pkt := '00040006000000000006' + CoocId +
    '0001' + IntToHex(Length(cNumber), 2) + Text2Hex(cNumber) + '0002' + IntToHex((Length(Utf8Mess) + 13), 4) + '05010001010101' +
    IntToHex((Length(Utf8Mess) + 4), 4) + '00000000' + Text2Hex(Utf8Mess) + '0003000000060000';
    //--Отсылаем пакет
    SendFLAP('2', Pkt); }
end;

procedure ICQ_SRV_MSGACK_ADVANCED(PktData: string; ClientOk: Boolean);
var
  UIN: string;
  Len: Integer;
begin
  // Пропускаем 16 символов кукисов и 4 символа канала
  NextData(PktData, 20);
  // Получаем длинну UIN получателя сообщения
  Len := HexToInt(NextData(PktData, 2));
  Len := Len * 2;
  // Получаем UIN
  UIN := Hex2Text(NextData(PktData, Len));
  // Если окно чата создано и UIN совпадает с активной закладкой, то заменяем иконку сообщения
  if Assigned(ChatForm) then
    begin
      // Если UIN активной вкладки совпадает с UIN из подтверждения
      if ChatForm.InfoPanel2.Caption = UIN then
        begin
          if not ClientOk then
            // Заменяем последнюю икоку исходящих сообщений на зелёную
            ChatForm.HTMLChatViewer.ReplaceImage('o' + IntToStr(ChatForm.OutMessIndex), OutMessage2)
          else
            // Если это уже подтвержение от клиента, то заменяем на зелёную с галочкой
            ChatForm.HTMLChatViewer.ReplaceImage('o' + IntToStr(ChatForm.OutMessIndex), OutMessage3);
        end;
    end;
end;

procedure ICQ_UserSentTyping_0414(PktData: string);
{ label
  x, y;
  var
  UIN, Doc: string;
  Typing, CloseW: boolean;
  Len, i, ii: integer; }
begin
  { Typing := false;
    CloseW := false;
    //--Пропускаем кукисы 16 символов и канал 4 символа
    NextData(PktData, 20);
    //--Получаем длинну UIN отправителям нотификации о печати сообщения
    Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    //--Получаем UIN
    UIN := Hex2Text(NextData(PktData, Len));
    case HexToInt(NextData(PktData, 4)) of
    $0001: Typing := true; //--Начал печатать
    $0002: Typing := true; //--Печатает
    $000F: CloseW := true; //--Закрыл окно чата ICQ6
    else
    begin
    Typing := false;
    CloseW := false;
    end;
    end;
    //--Ставим иконку о печати сообщения в КЛ
    with MainForm.ContactList do
    begin
    //--Сканируем контакты в поиске совпадающего UIN
    for i := 0 to Categories.Count - 1 do
    begin
    for ii := 0 to Categories[i].Items.Count - 1 do
    begin
    if Categories[i].Items[ii].UIN = UIN then
    begin
    if Typing then
    begin
    //--Ставим флаг о печати сообщения
    Categories[i].Items[ii].Typing := true;
    Categories[i].Items[ii].TypingTime := 0;
    end
    else
    begin
    //--Снимаем флаг о печати сообщения
    Categories[i].Items[ii].Typing := false;
    Categories[i].Items[ii].TypingTime := 0;
    end;
    //--Выходим из цыкла
    goto x;
    end;
    end;
    end;
    end;
    //--Set Chat typing ico
    x: ;
    if Assigned(ChatForm) then
    begin
    with ChatForm.ChatPageControl do
    begin
    if Visible then
    begin
    //--Отображаем в текущем чате сообщение о закрытии окна чата
    if (ActivePage.HelpKeyword = UIN) and (CloseW) then
    begin
    //--Добавляем в чат сообщение о закрытиеи чата собеседником
    Doc := ChatForm.HTMLChatViewer.DocumentSource;
    Doc := Doc + '<span class=d>' + CloseChatWindowsL + '</span><br><br>';
    ChatForm.HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
    //--Прокручиваем чат до конца
    ChatForm.HTMLChatViewer.VScrollBarPosition := ChatForm.HTMLChatViewer.VScrollBar.Max;
    end;
    //--Если активная вкладка совпадает с этим UIN
    if ActivePage.HelpKeyword = UIN then
    begin
    if Typing then
    begin
    //--Ставим флаг о печати сообщения
    ActivePage.Margins.Top := 1;
    ActivePage.Margins.Right := 0;
    //--Ставим сообщение о наборе текста
    ChatForm.NotifyPanel.Font.Color := clBlue;
    ChatForm.NotifyPanel.Caption := TypingTextL;
    end
    else
    begin
    //--Снимаем флаг о печати сообщения
    ActivePage.Margins.Top := 0;
    ActivePage.Margins.Right := 0;
    //--Сбрасываем сообщение о наборе текста
    ChatForm.NotifyPanel.Font.Color := clWindowText;
    ChatForm.NotifyPanel.Caption := '...';
    end;
    goto y;
    end;
    //--Сканируем вкладки в поиске совпадающего UIN
    for i := 0 to PageCount - 1 do
    begin
    if Pages[i].HelpKeyword = UIN then
    begin
    if Typing then
    begin
    //--Ставим флаг о печати сообщения
    Pages[i].Margins.Top := 1;
    Pages[i].Margins.Right := 0;
    end
    else
    begin
    //--Снимаем флаг о печати сообщения
    Pages[i].Margins.Top := 0;
    Pages[i].Margins.Right := 0;
    end;
    //--Выходим из цыкла
    goto y;
    end;
    end;
    end;
    end;
    end;
    y: ;
    //--Выводим нотификации о печати и закрытии окна чата всплывающими сообщениями
    }
end;

procedure ICQ_SaveNew_InfoPkt(CUIN, CNick, CFirst, CLast, CGender, CAddress, CCity, CState, CZip, OCity, OState, Phone1, Phone2, Phone3,
  Phone4, Phone5, CHomePage, WCity, WState, WZip, WAddress, WCorp, WDep, WProf, WSite, Int1, Int2, Int3, Int4, CAbout, CDay, CMon, CYear,
  CEmail1, CEmail2, CEmail3: string; CCountry, OCountry, Lang1, Lang2, Lang3, WCountry, WOccup, Int_id1, Int_id2, Int_id3, Int_id4,
  CMarital, CSexual, CHeight, CRelig, CSmok, CHair, CChildren: Integer);
{ var
  Pkt, Pkt1, Pkt2, Pkt3: string;
  Len, Len1, Len2: integer;

  function Nick_First_Last: string;
  var
  iPkt, utf8_Nick, utf8_First, utf8_Last: string;
  begin
  utf8_Nick := StrToUtf8(cNick);
  utf8_First := StrToUtf8(cFirst);
  utf8_Last := StrToUtf8(cLast);
  iPkt := '0078' + IntToHex(Length(utf8_Nick), 4) + Text2Hex(utf8_Nick) +
  '0064' + IntToHex(Length(utf8_First), 4) + Text2Hex(utf8_First) +
  '006E' + IntToHex(Length(utf8_Last), 4) + Text2Hex(utf8_Last);
  Result := iPkt;
  end;

  function Gender_Addres: string;
  var
  iPkt, iPkt1, utf8_Address, utf8_City, utf8_State, utf8_Zip: string;
  iLen: integer;
  begin
  utf8_Address := StrToUtf8(cAddress);
  utf8_City := StrToUtf8(cCity);
  utf8_State := StrToUtf8(cState);
  utf8_Zip := StrToUtf8(cZip);
  iPkt1 := '0064' + IntToHex(Length(utf8_Address), 4) + Text2Hex(utf8_Address) +
  '006E' + IntToHex(Length(utf8_City), 4) + Text2Hex(utf8_City) + '0078' +
  IntToHex(Length(utf8_State), 4) + Text2Hex(utf8_State) + '0082' +
  IntToHex(Length(utf8_Zip), 4) + Text2Hex(utf8_Zip) + '008C0004' +
  IntToHex(cCountry, 8);
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '008200010' + cGender + '0096' + IntToHex(iLen + 4, 4) + '0001' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Original_Address: string;
  var
  iPkt, iPkt1, utf8_City, utf8_State: string;
  iLen: integer;
  begin
  utf8_City := StrToUtf8(oCity);
  utf8_State := StrToUtf8(oState);
  iPkt1 := '00640000' +
  '006E' + IntToHex(Length(utf8_City), 4) + Text2Hex(utf8_City) + '0078' +
  IntToHex(Length(utf8_State), 4) + Text2Hex(utf8_State) + '00820000' +
  '008C0004' + IntToHex(oCountry, 8);
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '00A0' + IntToHex(iLen + 4, 4) + '0001' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Langs: string;
  var
  iPkt: string;
  begin
  iPkt := '00AA0002' + IntToHex(Lang1, 4) + '00B40002' + IntToHex(Lang2, 4) +
  '00BE0002' + IntToHex(Lang3, 4);
  Result := iPkt;
  end;

  function Phones: string;
  var
  iPkt, iPkt1, utf8_Phone1, utf8_Phone2, utf8_Phone3, utf8_Phone4, utf8_Phone5: string;
  Phone1_Pkt, Phone2_Pkt, Phone3_Pkt, Phone4_Pkt, Phone5_Pkt: string;
  iLen, Phone1_Len, Phone2_Len, Phone3_Len, Phone4_Len, Phone5_Len: integer;
  begin
  utf8_Phone1 := StrToUtf8(Phone1);
  utf8_Phone2 := StrToUtf8(Phone2);
  utf8_Phone3 := StrToUtf8(Phone3);
  utf8_Phone4 := StrToUtf8(Phone4);
  utf8_Phone5 := StrToUtf8(Phone5);
  //
  Phone1_Pkt := Text2Hex(utf8_Phone1) + '006E00020001';
  Phone1_Len := Length(utf8_Phone1);
  Phone2_Pkt := Text2Hex(utf8_Phone2) + '006E00020004';
  Phone2_Len := Length(utf8_Phone2);
  Phone3_Pkt := Text2Hex(utf8_Phone3) + '006E00020003';
  Phone3_Len := Length(utf8_Phone3);
  Phone4_Pkt := Text2Hex(utf8_Phone4) + '006E00020002';
  Phone4_Len := Length(utf8_Phone4);
  Phone5_Pkt := Text2Hex(utf8_Phone5) + '006E00020005';
  Phone5_Len := Length(utf8_Phone5);
  //
  iPkt1 := '0006' + IntToHex(Phone1_Len + 10, 4) + '0064' + IntToHex(Phone1_Len, 4) + Phone1_Pkt +
  IntToHex(Phone2_Len + 10, 4) + '0064' + IntToHex(Phone2_Len, 4) + Phone2_Pkt +
  IntToHex(Phone3_Len + 10, 4) + '0064' + IntToHex(Phone3_Len, 4) + Phone3_Pkt +
  IntToHex(Phone4_Len + 10, 4) + '0064' + IntToHex(Phone4_Len, 4) + Phone4_Pkt +
  IntToHex(Phone5_Len + 10, 4) + '0064' + IntToHex(Phone5_Len, 4) + Phone5_Pkt +
  '000A00640000006E00020006';
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '00C8' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function HomePage: string;
  var
  iPkt, utf8_HomePage: string;
  begin
  utf8_HomePage := cHomePage;
  iPkt := '00FA' + IntToHex(Length(utf8_HomePage), 4) + Text2Hex(utf8_HomePage);
  Result := iPkt;
  end;

  function Works: string;
  var
  iPkt, iPkt1, utf8_City, utf8_State, utf8_Zip, utf8_Address, utf8_Corp, utf8_Dep, utf8_Prof, utf8_Site: string;
  iLen: integer;
  begin
  utf8_City := StrToUtf8(wCity);
  utf8_State := StrToUtf8(wState);
  utf8_Zip := StrToUtf8(wZip);
  utf8_Address := StrToUtf8(wAddress);
  utf8_Corp := StrToUtf8(wCorp);
  utf8_Dep := StrToUtf8(wDep);
  utf8_Prof := StrToUtf8(wProf);
  utf8_Site := StrToUtf8(wSite);
  //
  iPkt1 := '0064' + IntToHex(Length(utf8_Prof), 4) + Text2Hex(utf8_Prof) +
  '006E' + IntToHex(Length(utf8_Corp), 4) + Text2Hex(utf8_Corp) + '007D' +
  IntToHex(Length(utf8_Dep), 4) + Text2Hex(utf8_Dep) + '0078' +
  IntToHex(Length(utf8_Site), 4) + Text2Hex(utf8_Site) + '00820002' +
  IntToHex(wOccup, 4) + '008C00020000' + '00960008000000000000000000a000080000000000000000' +
  '00AA' + IntToHex(Length(utf8_Address), 4) + Text2Hex(utf8_Address) +
  '00B4' + IntToHex(Length(utf8_City), 4) + Text2Hex(utf8_City) + '00BE' +
  IntToHex(Length(utf8_State), 4) + Text2Hex(utf8_State) + '00C8' +
  IntToHex(Length(utf8_Zip), 4) + Text2Hex(utf8_Zip) + '00D20004' + IntToHex(wCountry, 8);
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '0118' + IntToHex(iLen + 4, 4) + '0001' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Interest: string;
  var
  iPkt, iPkt1, utf8_Int1, utf8_Int2, utf8_Int3, utf8_Int4: string;
  Int1_Pkt, Int2_Pkt, Int3_Pkt, Int4_Pkt: string;
  iLen, Int1_Len, Int2_Len, Int3_Len, Int4_Len: integer;
  begin
  utf8_Int1 := StrToUtf8(Int1);
  utf8_Int2 := StrToUtf8(Int2);
  utf8_Int3 := StrToUtf8(Int3);
  utf8_Int4 := StrToUtf8(Int4);
  //
  Int1_Pkt := Text2Hex(utf8_Int1) + '006E0002' + IntToHex(Int_id1, 4);
  Int1_Len := Length(utf8_Int1);
  Int2_Pkt := Text2Hex(utf8_Int2) + '006E0002' + IntToHex(Int_id2, 4);
  Int2_Len := Length(utf8_Int2);
  Int3_Pkt := Text2Hex(utf8_Int3) + '006E0002' + IntToHex(Int_id3, 4);
  Int3_Len := Length(utf8_Int3);
  Int4_Pkt := Text2Hex(utf8_Int4) + '006E0002' + IntToHex(Int_id4, 4);
  Int4_Len := Length(utf8_Int4);
  //
  iPkt1 := '0004' + IntToHex(Int1_Len + 10, 4) + '0064' + IntToHex(Int1_Len, 4) + Int1_Pkt +
  IntToHex(Int2_Len + 10, 4) + '0064' + IntToHex(Int2_Len, 4) + Int2_Pkt +
  IntToHex(Int3_Len + 10, 4) + '0064' + IntToHex(Int3_Len, 4) + Int3_Pkt +
  IntToHex(Int4_Len + 10, 4) + '0064' + IntToHex(Int4_Len, 4) + Int4_Pkt;
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '0122' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Marital_About: string;
  var
  iPkt, utf8_About: string;
  begin
  utf8_About := StrToUtf8(cAbout);
  iPkt := '012C0002' + IntToHex(cMarital, 4) + '0186' + IntToHex(Length(utf8_About), 4) + Text2Hex(utf8_About);
  Result := iPkt;
  end;

  function Birg: string;
  var
  Date64: Int64;
  sDate64: TDateTime absolute Date64;
  iPkt, DateHex: string;
  begin
  if (cDay > EmptyStr) and (cMon > EmptyStr) and (cYear > EmptyStr) then
  begin
  sDate64 := StrToDate(cDay + '.' + cMon + '.' + cYear);
  sDate64 := sDate64 - 48 * Hour; //--fuck + 2 days :(
  DateHex := Int64ToHex(Date64);
  NextData(DateHex, 1); //--skip $
  iPkt := '01A40008' + DateHex;
  end
  else iPkt := '01A40008' + '0000000000000000';
  Result := iPkt;
  end;

  function Sexual_Height_Relig_Smok_Hair_Children: string;
  var
  iPkt: string;
  begin
  iPkt := '01540002' + IntToHex(cSexual, 4) + '01680002' + IntToHex(cHeight, 4) +
  '014A0002' + IntToHex(cRelig, 4) + '015E0002' + IntToHex(cSmok, 4) +
  '01720002' + IntToHex(cHair, 4) + '01400002' + IntToHex(cChildren, 4);
  Result := iPkt;
  end;

  function Emails: string;
  var
  iPkt, iPkt1, utf8_Email1, utf8_Email2, utf8_Email3: string;
  Email1_Pkt, Email2_Pkt, Email3_Pkt: string;
  iLen, Email1_Len, Email2_Len, Email3_Len: integer;
  begin
  utf8_Email1 := StrToUtf8(cEmail1);
  utf8_Email2 := StrToUtf8(cEmail2);
  utf8_Email3 := StrToUtf8(cEmail3);
  //
  Email1_Len := Length(utf8_Email1);
  Email1_Pkt := IntToHex(Email1_Len + 10, 4) + '00780002FFFF0064' +
  IntToHex(Email1_Len, 4) + Text2Hex(utf8_Email1);
  Email2_Len := Length(utf8_Email2);
  Email2_Pkt := IntToHex(Email2_Len + 10, 4) + '0078000200000064' +
  IntToHex(Email2_Len, 4) + Text2Hex(utf8_Email2);
  Email3_Len := Length(utf8_Email3);
  Email3_Pkt := IntToHex(Email3_Len + 10, 4) + '0078000200000064' +
  IntToHex(Email3_Len, 4) + Text2Hex(utf8_Email3);
  //
  iPkt1 := '0003' + Email1_Pkt + Email2_Pkt + Email3_Pkt;
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '008C' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end; }

begin
  { Randomize;
    Pkt3 := Nick_First_Last + Gender_Addres + Original_Address + Langs + Phones +
    HomePage + Works + Interest + Marital_About + Birg + Emails +
    Sexual_Height_Relig_Smok_Hair_Children + '01F900020000';
    Len2 := Length(Hex2Text(Pkt3));
    Pkt2 := '05B90FD2000000000000000004E3000000020003' + IntToHex(Len2, 4) + Pkt3;
    Len1 := Length(Hex2Text(Pkt2));
    Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) +
    'D20F' + IntToHex(Swap16(Len1), 4) + Pkt2;
    Len := Length(Hex2Text(Pkt1));
    Pkt := '00150002000000000004' + '0001' + IntToHex(Len + 2, 4) + IntToHex(Swap16(Len), 4) + Pkt1;
    //
    SendFLAP('2', Pkt); }
end;

procedure ICQ_ReqInfo_New_Pkt(SUIN: string);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
begin
  // Составляем пакет с запросом инфы о контакте (новый способ QIP)
  Pkt3 := '0032' + IntToHex(Length(SUIN), 4) + Text2Hex(SUIN);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B90FA0000000000000000004E300000002000300000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'A00F' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '001500020000' + IntToHex(StrToInt(SUIN), 8) + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Запоминаем UIN кого мы запрашивали
  ICQ_ReqInfo_UIN := SUIN;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

{ procedure ICQ_ReqInfo_New_Pkt_1(sUIN: string);
  var
  Len1, Len2, Len3: integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
  begin
  //--Составляем пакет с запросом инфы о контакте (новый способ ICQ6)
  Pkt3 := '0032' + IntToHex(Length(sUIN), 4) + Text2Hex(sUIN);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B900028000000000000006000100020002000004E300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) +
  'A00F' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '001500020000' + IntToHex(StrToInt(sUIN), 8) + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  //--Запоминаем UIN кого мы запрашивали
  ICQ_ReqInfo_UIN := sUIN;
  //--Отсылаем пакет
  SendFLAP('2', Pkt);
  end; }

procedure ICQ_ReqAuthSend(UIN, Mess: string);
var
  Pkt, Utf8Mess: string;
begin
  // Собираем пакет запроса авторизации
  Utf8Mess := StrToUtf8(Mess);
  Pkt := '00130018000000000018' + IntToHex(Length(UIN), 2) + Text2Hex(UIN) + IntToHex(Length(Utf8Mess), 4) + Text2Hex(Utf8Mess) + '0000';
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_DeleteTempContactMulti(TCList: TStringList);
var
  Pkt, Pkt1, Pkt2: string;
  ZTCL: TStringList;

function CreateDelTempContsPkt: string;
label
  X;
var
  I, C, A, ZLen: Integer;
  ZUIN, ZId, ZType, ZTimeId: string;
begin
  Pkt := EmptyStr;
  Pkt1 := EmptyStr;
  Pkt2 := EmptyStr;
  if ZTCL.Count > 50 then
    C := 50
  else
    C := ZTCL.Count - 1;
  for I := 0 to C do
    begin
      ZUIN := EmptyStr;
      ZId := EmptyStr;
      ZType := EmptyStr;
      ZTimeId := EmptyStr;
      Pkt2 := EmptyStr;
      ZUIN := Parse(';', ZTCL.Strings[I], 1);
      ZId := Parse(';', ZTCL.Strings[I], 2);
      ZType := Parse(';', ZTCL.Strings[I], 3);
      ZTimeId := Parse(';', ZTCL.Strings[I], 4);
      Pkt2 := '006d' + ZTimeId;
      if ZTimeId = EmptyStr then
        Pkt2 := Pkt2 + '000100';
      ZLen := Length(Hex2Text(Pkt2));
      Pkt1 := Pkt1 + IntToHex(Length(ZUIN), 4) + Text2Hex(ZUIN) + '0000' + ZId + ZType + IntToHex(ZLen, 4) + Pkt2;
    end;
  A := 0;
X :;
  if A <= C then
    begin
      ZTCL.Delete(0);
      A := A + 1;
      goto X;
    end;
  Pkt := '0013000A00000000000A' + Pkt1;
  Result := Pkt;
end;

begin
  ZTCL := TStringList.Create;
  //
  try
    ZTCL.Assign(TCList);
    while ZTCL.Count > 0 do
      begin
        SendFLAP('2', CreateDelTempContsPkt);
      end;
    //
  finally
    ZTCL.Free;
  end;
end;

procedure ICQ_DellMyFromCL(UIN: string);
var
  Pkt: string;
begin
  // Формируем пакет
  Pkt := '00130016000000000016' + IntToHex(Length(UIN), 2) + Text2Hex(UIN);
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_SendYouAdded(UIN: string);
var
  Pkt, Rand1, Rand2, Rand3: string;
begin
  // Создаём рандомные куки
  Rand1 := IntToHex(Random($AAAA), 4);
  Rand2 := IntToHex(Random($AAAA), 4);
  Rand3 := IntToHex(Random($AAAA), 4);
  // Формируем пакет
  Pkt := '00040006000000000006' + '0000' + Rand1 + Rand2 + '00000002' + IntToHex(Length(UIN), 2) + Text2Hex(UIN)
    + '0005005E00000000' + Rand1 + Rand2 + '0000094613494C7F11D18222444553540000000A00020001000F0000271100361B000A00000' +
    '0000000000000000000000000000000000300000000' + Rand3 + '0E00' + Rand3 + '0000000000000000000000000C000000040001000000030000';
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_SendGrandAuth(UIN: string);
var
  Pkt: string;
begin
  // Формируем пакет Гранд авторизации
  Pkt := '00130014000000000014' + IntToHex(Length(UIN), 2) + Text2Hex(UIN) + '00000000';
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_AddStart;
begin
  // Открываем сессию работы с серверным КЛ
  SendFLAP('2', '00130011000000000011');
end;

procedure ICQ_AddEnd;
begin
  // Закрываем сессию работы с серверным КЛ
  SendFLAP('2', '00130012000000000012');
end;

procedure ICQ_UpdateGroup_AddContact(GrCaption, IGroupId: string; CiDlist: TStringList);
var
  I, Len1, Len2: Integer;
  Pkt, Pkt1, Pkt2: string;
  Utf8Capt: string;
begin
  // Обновляем группу при добавлении контакта в серверном КЛ
  Utf8Capt := StrToUtf8(GrCaption);
  for I := 0 to CiDlist.Count - 1 do
    begin
      Pkt2 := Pkt2 + CiDlist.Strings[I];
    end;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := '00C8' + IntToHex(Len2, 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00130009000000000009' + IntToHex(Length(Utf8Capt), 4) + Text2Hex(Utf8Capt) + IGroupId + '00000001' + IntToHex(Len1, 4) + Pkt1;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_DeleteGroup(GName, GId: string);
var
  Pkt: string;
  Utf8Name: string;
begin
  // Формируем пакет удаления группы
  Utf8Name := StrToUtf8(GName);
  Pkt := '0013000A00000000000A' + IntToHex(Length(Utf8Name), 4) + Text2Hex(Utf8Name) + GId + '00000001000400C80000';
  // Открываем сессию
  ICQ_AddStart;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_UpdateGroup_AddGroup(GiDlist: TStringList);
var
  I, Len1, Len2: Integer;
  Pkt, Pkt1, Pkt2: string;
begin
  // Обновляем группу при добавлении группы в серверном КЛ
  for I := 0 to GiDlist.Count - 1 do
    begin
      Pkt2 := Pkt2 + GiDlist.Strings[I];
    end;
  Pkt2 := Pkt2 + ICQ_Add_GroupId;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := '00c8' + IntToHex(Len2, 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00130009000000000009' + '0000000000000001' + IntToHex(Len1, 4) + Pkt1;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_AddGroup(GName, GId: string);
var
  Pkt: string;
  Utf8Name: string;
begin
  // Формируем пакет добавления группы в серверный КЛ
  Utf8Name := StrToUtf8(GName);
  Pkt := '00130008000000000008' + IntToHex(Length(Utf8Name), 4) + Text2Hex(Utf8Name) + GId + '00000001000400C80000';
  // Открываем сессию
  ICQ_AddStart;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_RenameAndEditContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
var
  Len: Integer;
  Pkt, Pkt1: string;
  Utf8Nick, Utf8Cell, Utf8Email, Utf8Zametka: string;
begin
  // Переводим в UTF-8
  Utf8Nick := StrToUtf8(Nick);
  Utf8Cell := StrToUtf8(Cell);
  Utf8Email := StrToUtf8(Email);
  Utf8Zametka := StrToUtf8(Zametka);
  // Формируем пакет
  Pkt1 := '0131' + IntToHex(Length(Utf8Nick), 4) + Text2Hex(Utf8Nick) + '013A' + IntToHex(Length(Utf8Cell), 4) + Text2Hex(Utf8Cell)
    + '013C' + IntToHex(Length(Utf8Zametka), 4) + Text2Hex(Utf8Zametka) + '0137' + IntToHex(Length(Utf8Email), 4) + Text2Hex(Utf8Email);
  Len := Length(Hex2Text(Pkt1));
  Pkt := '00130009000000000009' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + GroupId + Id + '0000' + IntToHex(Len, 4) + Pkt1;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_Parse_130E_UpdateAck(PktData: string);
var
  I: Integer;
  CliDL: TStringList;
  GrCap: string;
  ListItemD: TListItem;
begin
  // Если это не фаза работы с серверным КЛ, то выходим
  if not ICQ_SSI_Phaze then
    Exit;
  // Пропускаем ненужные значения
  NextData(PktData, 18);
  // Если это фаза добавления контакта
  if ICQ_Add_Contact_Phaze then
    begin
      // Смотрим на ответ сервера
      case HexToInt(NextData(PktData, 2)) of
        $00: begin
            // Создаём список для занесения в него всех идентификаторов контактов
            CliDL := TStringList.Create;
            try
              // Заносим в список все идентификаторы контактов из этой группы
              with RosterForm.RosterJvListView do
                begin
                  for I := 0 to Items.Count - 1 do
                    begin
                      // Если идентификатор группы в которую добавляем новый контакт совпадает
                      // с идентификатором группы контактов в списке, то добавляем их идентификаторы в список
                      if (Items[I].SubItems[1] = ICQ_Add_GroupId) and (Items[I].SubItems[3] = 'Icq') then
                        CliDL.Add(Items[I].SubItems[4]);
                      // Получаем название группы в которую добавляем контакт
                      if Items[I].Caption = ICQ_Add_GroupId then
                        GrCap := Items[I].SubItems[1];
                    end;
                end;
              // Добавляем в список новый идентификатор контакта
              CliDL.Add(ICQ_Add_cId);
              // Обновляем группу в серверном КЛ
              ICQ_UpdateGroup_AddContact(GrCap, ICQ_Add_GroupId, CliDL);
            finally
              CliDL.Free;
            end;
            // Закрываем сессию добавления контакта
            ICQ_AddEnd;
            ICQ_Add_Contact_Phaze := False;
            ICQ_SSI_Phaze := False;
            // Успешно добавляем контакт в локальный список контактов
            ListItemD := RosterForm.RosterJvListView.Items.Add;
            with ListItemD do
              begin
                Caption := ICQ_Add_UIN;
                // Подготавиливаем все значения
                RosterForm.RosterItemSetFull(ListItemD);
                // Обновляем субстроки
                SubItems[0] := ICQ_Add_Nick;
                SubItems[1] := ICQ_Add_GroupId;
                SubItems[2] := 'both';
                SubItems[3] := 'Icq';
                SubItems[4] := ICQ_Add_cId;
                SubItems[5] := '0000';
                SubItems[6] := '9';
              end;
            // Строим локальный КЛ
            RosterForm.UpdateFullCL;
            // Сообщаем об успешном добавлении контакта
            DAShow(InformationHead, AddContactOKL, EmptyStr, 133, 3, 0);
          end;
        $0E: begin
            // Создаём список для занесения в него всех идентификаторов контактов
            CliDL := TStringList.Create;
            try
              // Заносим в список все идентификаторы контактов из этой группы
              with RosterForm.RosterJvListView do
                begin
                  for I := 0 to Items.Count - 1 do
                    begin
                      // Если идентификатор группы в которую добавляем новый контакт совпадает
                      // с идентификатором группы контактов в списке, то добавляем их идентификаторы в список
                      if (Items[I].SubItems[1] = ICQ_Add_GroupId) and (Items[I].SubItems[3] = 'Icq') then
                        CliDL.Add(Items[I].SubItems[4]);
                      // Получаем название группы в которую добавляем контакт
                      if Items[I].Caption = ICQ_Add_GroupId then
                        GrCap := Items[I].SubItems[1];
                    end;
                end;
              // Обновляем группу в серверном КЛ
              ICQ_UpdateGroup_AddContact(GrCap, ICQ_Add_GroupId, CliDL);
              // Закрываем сессию
              ICQ_AddEnd;
              // Добавляем контакт уже как неавторизованный
              ICQ_AddContact(ICQ_Add_UIN, ICQ_Add_GroupId, ICQ_Add_cId, ICQ_Add_Nick, True);
              // Добавляем в список новый идентификатор контакта
              CliDL.Add(ICQ_Add_cId);
              // Обновляем группу в серверном КЛ
              ICQ_UpdateGroup_AddContact(GrCap, ICQ_Add_GroupId, CliDL);
            finally
              CliDL.Free;
            end;
            // Закрываем сессию добавления контакта
            ICQ_AddEnd;
            ICQ_Add_Contact_Phaze := False;
            ICQ_SSI_Phaze := False;
            // Успешно добавляем контакт в локальный список контактов
            ListItemD := RosterForm.RosterJvListView.Items.Add;
            with ListItemD do
              begin
                Caption := ICQ_Add_UIN;
                // Подготавиливаем все значения
                RosterForm.RosterItemSetFull(ListItemD);
                // Обновляем субстроки
                SubItems[0] := ICQ_Add_Nick;
                SubItems[1] := ICQ_Add_GroupId;
                SubItems[2] := 'none';
                SubItems[3] := 'Icq';
                SubItems[4] := ICQ_Add_cId;
                SubItems[5] := '0000';
                SubItems[6] := '80';
                SubItems[8] := '220';
              end;
            // Строим локальный КЛ
            RosterForm.UpdateFullCL;
            // Сообщаем об успешном добавлении контакта
            DAShow(InformationHead, AddContactOKL, EmptyStr, 133, 3, 0);
          end
        else
          begin
            // Закрываем сессию добавления контакта
            ICQ_AddEnd;
            ICQ_Add_Contact_Phaze := False;
            ICQ_SSI_Phaze := False;
            // Сообщаем об ошибке добавления нового контакта в серверный КЛ
            DAShow(ErrorHead, AddContactErr4, EmptyStr, 134, 2, 0);
          end;
      end;
    end
    // Если это фаза добавления группы
  else if ICQ_Add_Group_Phaze then
    begin
      case HexToInt(NextData(PktData, 2)) of
        $00: begin
            // Создаём список для занесения в него идентификаторов групп
            CliDL := TStringList.Create;
            try
              // Заносим в список идентификаторы групп
              with RosterForm.RosterJvListView do
                begin
                  for I := 0 to Items.Count - 1 do
                    begin
                      // Добавляем идентификаторы групп в список
                      if (Items[I].Caption = 'NoCL') or (Items[I].Caption = '0000') then
                        Continue;
                      if (Items[I].SubItems[3] = 'Icq') and (Length(Items[I].Caption) = 4) then
                        CliDL.Add(Items[I].Caption);
                    end;
                end;
              // Обновляем группы на сервере и закрываем сессию
              ICQ_UpdateGroup_AddGroup(CliDL);
              ICQ_AddEnd;
              ICQ_Add_Group_Phaze := False;
              ICQ_SSI_Phaze := False;
            finally
              CliDL.Free;
            end;
            // Добавляем группу в локальный КЛ
            ListItemD := RosterForm.RosterJvListView.Items.Add;
            with ListItemD do
              begin
                Caption := ICQ_Add_GroupId;
                // Подготавиливаем все значения
                RosterForm.RosterItemSetFull(ListItemD);
                // Обновляем субстроки
                SubItems[1] := ICQ_Add_Nick;
                SubItems[3] := 'Icq';
                SubItems[4] := ICQ_Add_GroupId;
              end;
            // Строим локальный КЛ
            RosterForm.UpdateFullCL;
            // Сообщаем об успешном добавлении группы
            DAShow(InformationHead, AddNewGroupOKL, EmptyStr, 133, 3, 0);
          end
        else
          begin
            // Закрываем сессию добавления группы
            ICQ_AddEnd;
            ICQ_Add_Group_Phaze := False;
            ICQ_SSI_Phaze := False;
            // Сообщаем об ошибке добавления новой группы в серверный КЛ
            DAShow(ErrorHead, AddNewGroupErr2, EmptyStr, 134, 2, 0);
          end;
      end;
    end
    // Если это фаза удаления группы
  else if ICQ_Group_Delete_Phaze then
    begin
      case HexToInt(NextData(PktData, 2)) of
        $00: begin
            CliDL := TStringList.Create;
            try
              // Заносим в список идентификаторы групп
              with RosterForm.RosterJvListView do
                begin
                  for I := 0 to Items.Count - 1 do
                    begin
                      // Добавляем идентификаторы групп в список
                      if (Items[I].Caption = 'NoCL') or (Items[I].Caption = '0000') then
                        Continue;
                      if (Items[I].SubItems[3] = 'Icq') and (Length(Items[I].Caption) = 4) then
                        CliDL.Add(Items[I].Caption);
                    end;
                end;
              // Обновляем группы на сервере
              ICQ_UpdateGroup_AddGroup(CliDL);
              ICQ_AddEnd;
            finally
              CliDL.Free;
            end;
            // Закрываем сесиию удаления группы
            ICQ_Group_Delete_Phaze := False;
            ICQ_SSI_Phaze := False;
            // Сообщаем об успешном добавлении группы
            DAShow(InformationHead, DellGroupOKL, EmptyStr, 133, 3, 0);
          end
        else
          begin
            // Закрываем сессию удаления группы
            ICQ_AddEnd;
            ICQ_Group_Delete_Phaze := False;
            ICQ_SSI_Phaze := False;
            DAShow(ErrorHead, DellGroupErrL, EmptyStr, 134, 2, 0);
          end;
      end;
    end;
end;

procedure ICQ_AddContact(UIN, GroupId, CId, Nick: string; NoAuth: Boolean);
var
  Len: Integer;
  Pkt, Pkt1: string;
  Utf8Nick: string;
begin
  // Формируем пакет для добавления нового контакта в серверный КЛ
  Utf8Nick := StrToUtf8(Nick);
  Pkt1 := '0131' + IntToHex(Length(Utf8Nick), 4) + Text2Hex(Utf8Nick) + '013A0000013C000001370000';
  if NoAuth then
    Pkt1 := Pkt1 + '00660000';
  Len := Length(Hex2Text(Pkt1));
  Pkt := '00130008000000000008' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + GroupId + CId + '0000' + IntToHex(Len, 4) + Pkt1;
  // Запоминаем переменные нового контакта
  ICQ_Add_UIN := UIN;
  ICQ_Add_GroupId := GroupId;
  ICQ_Add_cId := CId;
  ICQ_Add_Nick := Nick;
  // Открываем сессию
  ICQ_AddStart;
  // Отправляем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_DeleteContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
var
  Len: Integer;
  Pkt, Pkt1: string;
  Utf8Nick, Utf8Cell, Utf8Email, Utf8Zametka: string;
begin
  // Переводим все в кодировку UTF-8
  Utf8Nick := StrToUtf8(Nick);
  Utf8Cell := StrToUtf8(Cell);
  Utf8Email := StrToUtf8(Email);
  Utf8Zametka := StrToUtf8(Zametka);
  // Формируем пакет
  Pkt1 := '0131' + IntToHex(Length(Utf8Nick), 4) + Text2Hex(Utf8Nick) + '013A' + IntToHex(Length(Utf8Cell), 4) + Text2Hex(Utf8Cell)
    + '013C' + IntToHex(Length(Utf8Zametka), 4) + Text2Hex(Utf8Zametka) + '0137' + IntToHex(Length(Utf8Email), 4) + Text2Hex(Utf8Email);
  Len := Length(Hex2Text(Pkt1));
  Pkt := '0013000A00000000000A' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + GroupId + Id + '0000' + IntToHex(Len, 4) + Pkt1;
  // Открываем сессию для работы с серверным списком контактов
  ICQ_AddStart;
  // Отправляем пакет
  SendFLAP('2', Pkt);
  // Закрываем сессию
  ICQ_AddEnd;
end;

procedure ICQ_DeleteTempContact(UIN, CId, CType, TimeId: string);
var
  Len: Integer;
  Pkt, Pkt1, Tid: string;
begin
  // Формируем пакет удаления временных контактов из списка
  Tid := Hex2Text(TimeId);
  Pkt1 := '006D' + IntToHex(Length(Tid), 4) + Text2Hex(Tid);
  Len := Length(Hex2Text(Pkt1));
  Pkt := '0013000A00000000000A' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + '0000' + CId + CType + IntToHex(Len, 4) + Pkt1;
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_SetStatusXText(XText, XCode: string);
var
  Len: Integer;
  Pkt, Pkt1: string;
  Utf8XText: string;
begin
  // Формируем пакет установки доп. статуса и подписи к нему
  if XText <> EmptyStr then
    begin
      Utf8XText := StrToUtf8(XText);
      Pkt1 := '0002' + '04' + IntToHex(Length(Utf8XText) + 4, 2) + IntToHex(Length(Utf8XText), 4) + Text2Hex(Utf8XText)
        + '0000' + '000E' + IntToHex(Length(XCode), 4) + Text2Hex(XCode);
    end
  else
    Pkt1 := '00020000000E0000';
  Len := Length(Hex2Text(Pkt1));
  Pkt := '0001001e00000000001e' + '001D' + IntToHex(Len, 4) + Pkt1;
  // Отправляем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_SetInfoP;
var
  Pkt: string;
begin
  Pkt := '00020004000000000004' + '00040000';
  // Отправляем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_ReqStatus0215(UIN: string);
var
  Pkt: string;
begin
  // Составляем пакет для принудительного запроса статуса контакта
  Pkt := '000200150000' + '00000000' + '00000005' + IntToHex(Length(UIN), 2) + Text2Hex(UIN);
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

procedure ICQ_NotifyAddSearchResults(AUIN, ANick, AFirst, ALast, AAge, AEmail, ACountry, ACity: string; AGender, AStatus: Integer;
  AAuth, AEndSearch: Boolean);
var
  ListItemD: TListItem;
  Gend: string;
  I: Integer;
begin
  if Assigned(IcqSearchForm) then
    begin
      with IcqSearchForm do
        begin
          // Если UIN пустой и конец поиска, то сообщаем, что не найден
          if (AUIN = EmptyStr) and (AEndSearch) then
            begin
              StatusPanel.Caption := SearchInfoNoL;
              Exit;
            end;
          // Если конец поиска, то сообщаем, что поиск завершён
          if AEndSearch then
            StatusPanel.Caption := SearchInfoEndL;
          // Проверяем есть ли уже такой контакт в списке найденных
          for I := 0 to SearchResultJvListView.Items.Count - 1 do
            begin
              // Если нашли, то выходим
              if SearchResultJvListView.Items[I].SubItems[1] = AUIN then
                Exit;
            end;
          // Начинаем добавление записи в список найденных
          SearchResultJvListView.Items.BeginUpdate;
          try
            ListItemD := SearchResultJvListView.Items.Add;
            with ListItemD do
              begin
                Checked := False;
                Caption := EmptyStr; // Иконка анкеты
                SubItems.Add(EmptyStr); // Иконка чата
                SubItems.Add(AUIN);
                case AStatus of
                  0: SubItemImages[1] := 241;
                  1: SubItemImages[1] := 242;
                  2: SubItemImages[1] := 243
                  else
                    SubItemImages[1] := 243;
                end;
                SubItems.Add(ANick);
                SubItems.Add(AFirst);
                SubItems.Add(ALast);
                case AGender of
                  0: Gend := EmptyStr;
                  1: Gend := GenderComboBox.Items.Strings[1];
                  2: Gend := GenderComboBox.Items.Strings[2];
                end;
                if (Gend <> EmptyStr) and (AAge <> '0') then
                  Gend := Gend + ' - ' + AAge
                else if AAge <> '0' then
                  Gend := AAge;
                SubItems.Add(Gend);
                if AAuth then
                  SubItems.Add(SearchInfoAuthL)
                else
                  SubItems.Add(SearchInfoAuthNoL);
                SubItems.Add(EmptyStr); // Иконка быстрых сообщений
                SubItems.Add(ACountry);
                SubItems.Add(ACity);
                SubItems.Add(AEmail);
              end;
          finally
            SearchResultJvListView.Items.EndUpdate;
          end;
        end;
    end;
end;

procedure ICQ_Parse_SNAC_1503(PktData: string);
label
  X,
  Y;
var
  UIN, Nick, First, Last, City, State, Phone, Fax, Address: string;
  Cellular, WPhone, WFax, Zip, HomePage, OCity, OState: string;
  Country, Gender, Lang1, Lang2, Lang3, Relig, Sexual: Word;
  Company, Department, Position, About, Int1, Int2, Int3, Int4: string;
  OCountry, WCountry, Occupation, I1, I2, I3, I4, Marital, Children: Word;
  Email, Email1, Email2, Email3, WSite, WAddress, WCity, WState, WZip: string;
  Smok, Height, Hair: Word;
  IYear, IMonth, IDay: Word;
  I, Ii, MsgLen, Count, Age, SStatus, BMRes: Integer;
  Auth, EndSearch, WebAware: Boolean;
  Date64: Int64;
  SDate64: TDateTime absolute Date64;
  SubPkt, LastUpdateInfo, ACountry: string;
begin
  // Сканируем тело пакета на нужные нам TLV
  case HexToInt(NextData(PktData, 4)) of
    $AA00: // Пароль на учётную запись успешно изменён
      begin
        if HexToInt(NextData(PktData, 2)) = $0A then
          begin
            ICQ_LoginPassword := ICQ_ChangePassword;
            // Информируем об успешной смене пароля
            DAShow(InformationHead, PassChangeOKL, EmptyStr, 133, 3, 0);
            Exit;
          end;
      end;
    $DC0F: // Анкетная информация успешно изменена
      begin
        if HexToInt(NextData(PktData, 2)) = $0A then
          begin
            SendFLAP('2', ICQ_CreateShortStatusPkt);
            DAShow(InformationHead, AnketaSaveOKL, EmptyStr, 133, 3, 0);
            Exit;
          end;
      end;
    $B40F, $AA0F: // Большая информация о контакте и в поиске тоже она же
      begin
        // Проверяем метку о наличие положительных данных 1
        if HexToInt(NextData(PktData, 2)) <> $0A then
          begin
            // Заканчиваем поиск
            EndSearch := True;
            ICQ_NotifyAddSearchResults(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, 0, 0, False,
              EndSearch);
            Exit;
          end;
        // Сбрасываем флаг об авторизации
        Auth := False;
        // Проверяем метку о наличие положительных данных 2
        if HexToInt(NextData(PktData, 4)) = $1D00 then
          begin
            // Заканчиваем поиск
            EndSearch := True;
            ICQ_NotifyAddSearchResults(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, 0, 0, False,
              EndSearch);
            Exit;
          end;
        // Делаем поиск с целью найти конец непонятных данных и обрезаем пакет по это место
        BMRes := BMSearch(0, PktData, '003200');
        if BMRes > -1 then
          NextData(PktData, BMRes - 1)
        else
          Exit;
        // Сбрасываем все переменные
        Age := 0;
        Gender := 0;
        SStatus := 0;
        Country := 0;
        Lang1 := 0;
        Lang2 := 0;
        Lang3 := 0;
        OCountry := 0;
        Marital := 0;
        Children := 0;
        Relig := 0;
        Sexual := 0;
        Smok := 0;
        Height := 0;
        Hair := 0;
        I1 := 0;
        I2 := 0;
        I3 := 0;
        I4 := 0;
        WCountry := 0;
        Occupation := 0;
        IYear := 0;
        IMonth := 0;
        IDay := 0;
        WebAware := False;
        // Начинаем сканировать нужные нам TLV пока длинна пакета больше нуля
        while Length(PktData) > 0 do
          begin
            case HexToInt(NextData(PktData, 4)) of
              $0032: // Получаем UIN
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  UIN := Hex2Text(NextData(PktData, MsgLen));
                end;
              $0050: // Получаем Email
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Email := Hex2Text(NextData(PktData, MsgLen));
                end;
              $0064: // Получаем Имя
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  First := Hex2Text(NextData(PktData, MsgLen));
                end;
              $006E: // Получаем Фамилию
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Last := Hex2Text(NextData(PktData, MsgLen));
                end;
              $0078: // Получаем Ник
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Nick := Hex2Text(NextData(PktData, MsgLen));
                end;
              $0082: // Получаем Пол
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Gender := HexToInt(NextData(PktData, MsgLen));
                end;
              $0190: // Получаем Статус
                begin
                  NextData(PktData, 6);
                  SStatus := HexToInt(NextData(PktData, 2));
                end;
              $01A4: // Получаем Дату рождения в 64 битном формате
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Date64 := HexToInt64(NextData(PktData, MsgLen));
                  if Date64 > 0 then
                    begin
                      SDate64 := SDate64 + (48 * Hour);
                      // Вычисляем возраст
                      Age := CalculateAge(SDate64, Date);
                      // Разбираем дату на день - месяц - год
                      DecodeDate(SDate64, IYear, IMonth, IDay);
                    end;
                end;
              $0096: // Получаем суб TLV с инфой о месте жительства
                begin
                  // Получаем длинну суб TLV
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  // Если данные не пустые
                  if MsgLen > 4 then
                    begin
                      SubPkt := NextData(PktData, MsgLen);
                      // Пропускаем данные
                      NextData(SubPkt, 8);
                      // Сканируем на нужные нам TLV
                      while Length(SubPkt) > 0 do
                        begin
                          case HexToInt(NextData(SubPkt, 4)) of
                            $008C: // Получаем код Страны
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                Country := HexToInt(NextData(SubPkt, MsgLen));
                              end;
                            $0078: // Получаем Штат
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                State := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $006E: // Получаем Город
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                City := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $0064: // Получаем Адрес
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                Address := Hex2Text(NextData(SubPkt, MsgLen));
                              end
                            else
                              begin
                                // Пропускаем все другие TLV
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                NextData(SubPkt, MsgLen);
                              end;
                          end;
                        end;
                    end
                    // Пропускаем пустые данные
                  else
                    NextData(PktData, MsgLen);
                end;
              $00AA: // Получаем Язык 1
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Lang1 := HexToInt(NextData(PktData, MsgLen));
                end;
              $00B4: // Получаем Язык 2
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Lang2 := HexToInt(NextData(PktData, MsgLen));
                end;
              $00BE: // Получаем Язык 3
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Lang3 := HexToInt(NextData(PktData, MsgLen));
                end;
              $012C: // Получаем статус Брака (холост, женат и т.д.)
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Marital := HexToInt(NextData(PktData, MsgLen));
                end;
              $0140: // Получаем количество Детей
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Children := HexToInt(NextData(PktData, MsgLen));
                end;
              $014A: // Получаем Религию
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Relig := HexToInt(NextData(PktData, MsgLen));
                end;
              $0154: // Получаем Сексуальную ориентацию
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Sexual := HexToInt(NextData(PktData, MsgLen));
                end;
              $015E: // Получаем Курительный статус
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Smok := HexToInt(NextData(PktData, MsgLen));
                end;
              $0168: // Получаем Рост
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Height := HexToInt(NextData(PktData, MsgLen));
                end;
              $0172: // Получаем Цвет волос
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Hair := HexToInt(NextData(PktData, MsgLen));
                end;
              $0186: // Получаем "О себе..."
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  About := Hex2Text(NextData(PktData, MsgLen));
                end;
              $00A0: // Получаем суб TLV о месте рождения
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  // Если данные не пустые
                  if MsgLen > 4 then
                    begin
                      SubPkt := NextData(PktData, MsgLen);
                      // Пропускаем данные
                      NextData(SubPkt, 8);
                      // Сканируем на нужные TLV
                      while Length(SubPkt) > 0 do
                        begin
                          case HexToInt(NextData(SubPkt, 4)) of
                            $008C: // Получаем код Страны
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                OCountry := HexToInt(NextData(SubPkt, MsgLen));
                              end;
                            $0078: // Получаем Штат
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                OState := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $006E: // Получаем Город
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                OCity := Hex2Text(NextData(SubPkt, MsgLen));
                              end
                            else
                              begin
                                // Пропускаем все другие TLV
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                NextData(SubPkt, MsgLen);
                              end;
                          end;
                        end;
                    end
                    // Пропускаем пустые данные
                  else
                    NextData(PktData, MsgLen);
                end;
              $0118: // Получаем суб TLV о месте работы
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  // Если данные не пустые
                  if MsgLen > 4 then
                    begin
                      SubPkt := NextData(PktData, MsgLen);
                      // Пропускаем данные
                      NextData(SubPkt, 8);
                      // Сканируем на нужные TLV
                      while Length(SubPkt) > 0 do
                        begin
                          case HexToInt(NextData(SubPkt, 4)) of
                            $00D2: // Получаем код Страны
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                WCountry := HexToInt(NextData(SubPkt, MsgLen));
                              end;
                            $00C8: // Получаем Зип
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                WZip := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $00BE: // Получаем Штат
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                WState := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $00B4: // Получаем Город
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                WCity := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $00AA: // Получаем Адрес
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                WAddress := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $0082: // Получаем Профессию
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                Occupation := HexToInt(NextData(SubPkt, MsgLen));
                              end;
                            $0078: // Получаем Сайт
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                WSite := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $007D: // Получаем Отдел
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                Department := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $006E: // Получаем Компанию
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                Company := Hex2Text(NextData(SubPkt, MsgLen));
                              end;
                            $0064: // Получаем Позицию
                              begin
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                Position := Hex2Text(NextData(SubPkt, MsgLen));
                              end
                            else
                              begin
                                // Пропускаем другие TLV
                                MsgLen := HexToInt(NextData(SubPkt, 4));
                                MsgLen := MsgLen * 2;
                                NextData(SubPkt, MsgLen);
                              end;
                          end;
                        end;
                    end
                    // Пропускаем пустые данные
                  else
                    NextData(PktData, MsgLen);
                end;
              $008C: // Получаем суб TLV с Email ящиками
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  // Если данные не пустые
                  if MsgLen > 4 then
                    begin
                      SubPkt := NextData(PktData, MsgLen);
                      // В цикле смотрим сколько ящиков указано
                      for I := 1 to HexToInt(NextData(SubPkt, 4)) do
                        begin
                          NextData(SubPkt, 8);
                          MsgLen := HexToInt(NextData(SubPkt, 4));
                          MsgLen := MsgLen * 2;
                          if I = 1 then
                            Email1 := Hex2Text(NextData(SubPkt, MsgLen));
                          if I = 2 then
                            Email2 := Hex2Text(NextData(SubPkt, MsgLen));
                          if I = 3 then
                            Email3 := Hex2Text(NextData(SubPkt, MsgLen));
                          // Пропускаем какие-то данные
                          NextData(SubPkt, 24);
                        end;
                    end
                    // Пропускаем пустые данные
                  else
                    NextData(PktData, MsgLen);
                end;
              $0122: // Получаем суб TLV c Интересами
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  // Если данные не пустые
                  if MsgLen > 4 then
                    begin
                      SubPkt := NextData(PktData, MsgLen);
                      // Смотрим в цикле сколько указано интересов
                      for I := 1 to HexToInt(NextData(SubPkt, 4)) do
                        begin
                          NextData(SubPkt, 8);
                          MsgLen := HexToInt(NextData(SubPkt, 4));
                          MsgLen := MsgLen * 2;
                          if I = 1 then
                            begin
                              Int1 := Hex2Text(NextData(SubPkt, MsgLen));
                              NextData(SubPkt, 8);
                              I1 := HexToInt(NextData(SubPkt, 4));
                            end;
                          if I = 2 then
                            begin
                              Int2 := Hex2Text(NextData(SubPkt, MsgLen));
                              NextData(SubPkt, 8);
                              I2 := HexToInt(NextData(SubPkt, 4));
                            end;
                          if I = 3 then
                            begin
                              Int3 := Hex2Text(NextData(SubPkt, MsgLen));
                              NextData(SubPkt, 8);
                              I3 := HexToInt(NextData(SubPkt, 4));
                            end;
                          if I = 4 then
                            begin
                              Int4 := Hex2Text(NextData(SubPkt, MsgLen));
                              NextData(SubPkt, 8);
                              I4 := HexToInt(NextData(SubPkt, 4));
                            end;
                        end;
                    end
                    // Пропускаем пустые данные
                  else
                    NextData(PktData, MsgLen);
                end;
              $00C8: // Получаем суб TLV с телефонами
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  // Если данные не пустые
                  if MsgLen > 4 then
                    begin
                      SubPkt := NextData(PktData, MsgLen);
                      // В цикле смотрим сколько указано телефонов
                      for I := 1 to HexToInt(NextData(SubPkt, 4)) do
                        begin
                          NextData(SubPkt, 8);
                          MsgLen := HexToInt(NextData(SubPkt, 4));
                          MsgLen := MsgLen * 2;
                          if I = 1 then
                            Phone := Hex2Text(NextData(SubPkt, MsgLen));
                          if I = 2 then
                            Fax := Hex2Text(NextData(SubPkt, MsgLen));
                          if I = 3 then
                            Cellular := Hex2Text(NextData(SubPkt, MsgLen));
                          if I = 4 then
                            WPhone := Hex2Text(NextData(SubPkt, MsgLen));
                          if I = 5 then
                            WFax := Hex2Text(NextData(SubPkt, MsgLen));
                          // Пропускаем какие-то данные
                          NextData(SubPkt, 12);
                        end;
                    end
                    // Пропускаем пустые данные
                  else
                    NextData(PktData, MsgLen);
                end;
              $00FA: // Получаем Домашнюю страничку
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  HomePage := Hex2Text(NextData(PktData, MsgLen));
                end;
              $0212: // Получаем ВебАваре флаг
                begin
                  NextData(PktData, 4);
                  if HexToInt(NextData(PktData, 2)) = $01 then
                    WebAware := True;
                end;
              $019A: // Получаем флаг авторизации
                begin
                  NextData(PktData, 6);
                  if HexToInt(NextData(PktData, 2)) = $00 then
                    Auth := True;
                end;
              $01CC: // Получаем Время последнего изменения инфы
                begin
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  Date64 := HexToInt64(NextData(PktData, MsgLen));
                  if Date64 > 0 then
                    begin
                      SDate64 := SDate64 + (48 * Hour);
                      LastUpdateInfo := DateTimeToStr(SDate64);
                    end;
                end
              else
                begin
                  // Пропускаем все другие TLV
                  MsgLen := HexToInt(NextData(PktData, 4));
                  MsgLen := MsgLen * 2;
                  NextData(PktData, MsgLen);
                end;
            end;
          end;
        // Начинаем обработку данных полученных из пакета с инфой
        // Проверяем делали ли мы запрос на информацию о контакте или это был поиск
        // При поиске контактов запрошенный UIN должен быть пустой
        if ICQ_ReqInfo_UIN <> EmptyStr then
          begin
            // Добавляем ник контакта в список ников
            if Assigned(AccountToNick) then
              begin
                // Если такого контакта ещё нет в списке ников, то добавляем его ник
                if AccountToNick.IndexOf('Icq_' + UIN) = -1 then
                  begin
                    // Если ник не пустой и ник не равен UIN
                    if (Nick > EmptyStr) and (Nick <> UIN) then
                      begin
                        AccountToNick.Add('Icq_' + UIN);
                        AccountToNick.Add(Nick);
                        AccountToNick.SaveToFile(ProfilePath + 'Profile\' + 'Nicks.txt');
                      end;
                  end;
              end;
            // Если ник не пустой и ник не равен UIN
            if (Nick > EmptyStr) and (Nick <> UIN) then
              begin
                // Присваиваем этот ник контакту не из нашего КЛ
                with MainForm.ContactList do
                  begin
                    for I := 0 to Categories.Count - 1 do
                      begin
                        if (Categories.Items[I].GroupId = '0000') or (Categories.Items[I].GroupId = 'NoCL') then
                          begin
                            for Ii := 0 to Categories[I].Items.Count - 1 do
                              begin
                                if Categories[I].Items[Ii].UIN = UIN then
                                  begin
                                    Categories[I].Items[Ii].Caption := Nick;
                                    // Выходим из цыклов
                                    goto Y;
                                  end;
                              end;
                          end;
                      end;
                  end;
              Y :;
                // Ищем вкладку в окне чата и ей присваиваем Ник
                if Assigned(ChatForm) then
                  begin
                    with ChatForm.ChatPageControl do
                      begin
                        if Visible then
                          begin
                            for I := 0 to PageCount - 1 do
                              begin
                                if Pages[I].HelpKeyword = UIN then
                                  begin
                                    Pages[I].Caption := Nick;
                                    // Выходим из цыкла
                                    Break;
                                  end;
                              end;
                          end;
                      end;
                  end;
              end;
            // Сохраняем полученные данные в локальный файл инфы о контакте
            with TrXML.Create() do
              try
                if OpenKey('profile\name-info', True) then
                  try
                    WriteString('nick', Nick);
                    WriteString('first', First);
                    WriteString('last', Last);
                  finally
                    CloseKey;
                  end;
                if OpenKey('profile\personal-info', True) then
                  try
                    WriteInteger('gender', Gender);
                    WriteBool('auth', Auth);
                    WriteBool('webaware', WebAware);
                    WriteString('homapage', HomePage);
                    WriteString('lastchange', LastUpdateInfo);
                  finally
                    CloseKey;
                  end;
                if OpenKey('profile\home-info', True) then
                  try
                    WriteString('address', Address);
                    WriteString('city', City);
                    WriteString('state', State);
                    WriteString('zip', Zip);
                    WriteInteger('country', Country);
                  finally
                    CloseKey;
                  end;
                if OpenKey('profile\orig-home-info', True) then
                  try
                    WriteInteger('country', OCountry);
                    WriteString('city', OCity);
                    WriteString('state', OState);
                  finally
                    CloseKey;
                  end;
                if OpenKey('profile\lang-info', True) then
                  try
                    WriteInteger('lang1', Lang1);
                    WriteInteger('lang2', Lang2);
                    WriteInteger('lang3', Lang3);
                  finally
                    CloseKey;
                  end;
                if OpenKey('profile\phone-info', True) then
                  try
                    WriteString('phone1', Phone);
                    WriteString('phone2', Fax);
                    WriteString('phone3', Cellular);
                    WriteString('phone4', WPhone);
                    WriteString('phone5', WFax);
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\work-info', True) then
                  try
                    WriteString('city', WCity);
                    WriteString('state', WState);
                    WriteString('zip', WZip);
                    WriteString('address', WAddress);
                    WriteString('corp', Company);
                    WriteString('dep', Department);
                    WriteString('prof', Position);
                    WriteString('site', WSite);
                    WriteInteger('country', WCountry);
                    WriteInteger('occup', Occupation);
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\interests-info', True) then
                  try
                    WriteString('int1', Int1);
                    WriteString('int2', Int2);
                    WriteString('int3', Int3);
                    WriteString('int4', Int4);
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\about-info', True) then
                  try
                    WriteString('info', Base64Encode(About));
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\age-info', True) then
                  try
                    WriteInteger('age', Age);
                    WriteInteger('day', IDay);
                    WriteInteger('month', IMonth);
                    WriteInteger('year', IYear);
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\emails-info', True) then
                  try
                    WriteString('email1', Email1);
                    WriteString('email2', Email2);
                    WriteString('email3', Email3);
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\interests-id-info', True) then
                  try
                    WriteInteger('int_id1', I1);
                    WriteInteger('int_id2', I2);
                    WriteInteger('int_id3', I3);
                    WriteInteger('int_id4', I4);
                  finally
                    CloseKey();
                  end;
                if OpenKey('profile\personal-x-info', True) then
                  try
                    WriteInteger('marital', Marital);
                    WriteInteger('sexual', Sexual);
                    WriteInteger('height', Height);
                    WriteInteger('relig', Relig);
                    WriteInteger('smok', Smok);
                    WriteInteger('hair', Hair);
                    WriteInteger('children', Children);
                  finally
                    CloseKey();
                  end;
                // Создаём необходимые папки
                ForceDirectories(ProfilePath + AnketaFileName);
                // Записываем сам файл
                SaveToFile(ProfilePath + AnketaFileName + 'Icq_' + UIN + '.xml');
              finally
                Free();
              end;
            // Отображаем в окне информации о контакте полученные данные
            if Assigned(IcqContactInfoForm) then
              begin
                if IcqContactInfoForm.ReqUIN = UIN then
                  IcqContactInfoForm.LoadUserUnfo;
              end;
            // Отображаем параметры настройки Авторизации и Вебаваре статуса в настройках ICQ
            if Assigned(IcqOptionsForm) then
              begin
                if UIN = ICQ_LoginUIN then
                  begin
                    IcqOptionsForm.NoAutoAuthRadioButton.Checked := Auth;
                    if not IcqOptionsForm.NoAutoAuthRadioButton.Checked then
                      IcqOptionsForm.YesAutoAuthRadioButton.Checked := True;
                    IcqOptionsForm.ShowWebAwareCheckBox.Checked := WebAware;
                  end;
              end;
            // Активируем статус Вебаваре если он включён
            if UIN = ICQ_LoginUIN then
              begin
                if WebAware then
                  ICQ_WebAware_Enabled := True
                else
                  ICQ_WebAware_Enabled := False;
                SendFLAP('2', ICQ_CreateShortStatusPkt);
              end;
          end
        else
          begin
            // Получаем текст страны из кода
            if Assigned(IcqOptionsForm) then
              ACountry := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf
                (IntToStr(Country))];
            // Обрабатываем результаты поиска
            ICQ_NotifyAddSearchResults(UIN, Nick, First, Last, IntToStr(Age), Email, ACountry, City, Gender, SStatus, Auth, True);
          end;
      end;
  end;
end;

procedure ICQ_SearchPoText_new(SText: string; OnlyOn: Boolean);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
  Online: string;
begin
  { 0136-0002-0001 }// Добавочный к пакету TLV "только в сети"
  // Формируем пакет поиска по ключевым словам
  if OnlyOn then
    Online := '013600020001'
  else
    Online := EmptyStr;
  Pkt3 := '017c' + IntToHex(Length(SText), 4) + Text2Hex(SText) + Online;
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05b90fa0000000000000000004e300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'a00f' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000000' + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Обнуляем флаг запроса анкеты контакта
  ICQ_ReqInfo_UIN := EmptyStr;
  SendFLAP('2', Pkt);
end;

procedure ICQ_SearchPoEmail_new(SEmail: string);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
begin
  // Формируем пакет поиска по Email
  Pkt3 := '0050' + IntToHex(Length(SEmail), 4) + Text2Hex(SEmail);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05b90fa0000000000000000004e300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'a00f' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000000' + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Обнуляем флаг запроса анкеты контакта
  ICQ_ReqInfo_UIN := EmptyStr;
  SendFLAP('2', Pkt);
end;

procedure ICQ_SearchPoUIN_new(SUIN: string);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
begin
  // Делаем поиск контакта по UIN
  Pkt3 := '0032' + IntToHex(Length(SUIN), 4) + Text2Hex(SUIN);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B90FA0000000000000000004E300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'A00F' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000000' + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Обнуляем флаг запроса анкеты контакта
  ICQ_ReqInfo_UIN := EmptyStr;
  SendFLAP('2', Pkt);
end;

{ procedure ICQ_SendRegNewUIN(Pass, ImgWord: string);
  var
  Len: integer;
  Pkt, Pkt1, Pkt2: string;
  begin
  //--Упаковываем рег данные в TLV 0009
  Pkt2 := '0009' + IntToHex(Length(ImgWord), 4) + Text2Hex(ImgWord);
  //--Повторяем основную структуру пакета
  Pkt1 := '00000000280000000000000000000000000000000000000000000000' +
  '000000000000000000000000' + IntToHex(Swap16(Length(Pass) + 1), 4) + Text2Hex(Pass) +
  '0000000000e3070000';
  //--Длинна пакета
  Len := Length(Hex2Text(Pkt1));
  //--Окончательный вариант пакета
  Pkt := '00170004000000000000' + '0001' + IntToHex(Len, 4) + Pkt1 + Pkt2;
  //--Отправка в сокет
  SendFLAP_Reg('2', Pkt);
  end; }

function ICQ_StatusCode2ImgId(StatusCode: string): Integer;
var
  ShortStatus: string;
begin
  ShortStatus := RightStr(StatusCode, 4);
  Result := 7;
  if ShortStatus = ICQ_Status_ONLINE then
    Result := 7
  else if ShortStatus = ICQ_Status_AWAY then
    Result := 8
  else if ShortStatus = ICQ_Status_OFFLINE then
    Result := 9
  else if ShortStatus = ICQ_Status_INVISIBLE then
    Result := 10
  else if ShortStatus = ICQ_Status_OCCUPIED then
    Result := 12
  else if ShortStatus = ICQ_Status_OCCUPIED1 then
    Result := 12
  else if ShortStatus = ICQ_Status_DND then
    Result := 13
  else if ShortStatus = ICQ_Status_DND1 then
    Result := 13
  else if ShortStatus = ICQ_Status_DND2 then
    Result := 13
  else if ShortStatus = ICQ_Status_NA then
    Result := 14
  else if ShortStatus = ICQ_Status_NA1 then
    Result := 14
  else if ShortStatus = ICQ_Status_LUNCH then
    Result := 15
  else if ShortStatus = ICQ_Status_FFC then
    Result := 16
  else if ShortStatus = ICQ_Status_DEPRESSION then
    Result := 17
  else if ShortStatus = ICQ_Status_EVIL then
    Result := 18
  else if ShortStatus = ICQ_Status_ATHOME then
    Result := 19
  else if ShortStatus = ICQ_Status_ATWORK then
    Result := 20
  else if ShortStatus = ICQ_Status_UNK then
    Result := 214;
end;

procedure ICQ_SendMessage_0406(SUIN, SMsg: string; Old: Boolean);
const
  Cap = '094613494c7f11d18222444553540000';
  Cap1 = '{0946134E-4C7F-11D1-8222-444553540000}';
var
  Len1, Len2: Integer;
  Pkt, Pkt1, Pkt2: string;
  OrigMsg, Utf8Mess, AnsiMsg: string;
  CoocId: string;
  CoocId1: string;
begin
  // Запоминаем текст сообщения
  OrigMsg := SMsg;
  // Отправляем сообщение кусками (ограничения протокола)
  while Length(OrigMsg) > 0 do
    begin
      if Old then
        AnsiMsg := NextData(OrigMsg, 1200)
      else
        Utf8Mess := StrToUtf8(NextData(OrigMsg, 3000));
      Randomize;
      CoocId := IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4);
      CoocId1 := IntToHex(Random($AAAA), 4);
      // Старый формат сообщений (анси кодировка)
      if Old then
        begin
          Pkt := '00040006000000000006' + CoocId + '0001' + IntToHex(Length(SUIN), 2) + Text2Hex(SUIN) + '0002' + IntToHex
            ((Length(AnsiMsg) + 13), 4) + '05010001010101' + IntToHex((Length(AnsiMsg) + 4), 4) + '00000000' + Text2Hex(AnsiMsg)
            + '00060000';
        end
      else
        begin
          // Новый формат сообщений (UTF-8 кодировка)
          Pkt2 := '1b000a000000000000000000000000000000000000000300000000' + CoocId1 + '0e00' + CoocId1 +
            '00000000000000000000000001000000' + '0400' + IntToHex(Swap16((Length(Utf8Mess) + 1)), 4) + Text2Hex(Utf8Mess)
            + '0000000000ffffff0026000000' + Text2Hex(Cap1);
          Len2 := Length(Hex2Text(Pkt2));
          Pkt1 := '0000' + CoocId + Cap + '000a00020001' + '000f0000' + '2711' + IntToHex(Len2, 4) + Pkt2;
          Len1 := Length(Hex2Text(Pkt1));
          Pkt := '00040006000000000006' + CoocId + '0002' + IntToHex(Length(SUIN), 2) + Text2Hex(SUIN) + '0005' + IntToHex(Len1, 4)
            + Pkt1 + '00030000';
        end;
      // Отправляем пакет
      SendFLAP('2', Pkt);
    end;
end;

procedure ICQ_ReqMsgNotify(UIN, Msg, Status, UserClass, IntIP, IntPort, ExtIP, TimeReg, IconHash, ConnTime: string);
var
  Nick, Mess, MsgD, PopMsg: string;
  RosterItem: TListItem;
begin
  // Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    ChatForm := TChatForm.Create(MainForm);
  // Если сообщение пустое, то выходим
  if Msg = EmptyStr then
    Exit;
  // Обрабатываем сообщение
  Mess := Msg;
  CheckMessage_BR(Mess);
  ChatForm.CheckMessage_ClearTag(Mess);
  PopMsg := Mess;
  CheckMessage_BR(Mess);
  DecorateURL(Mess);
  // Ищем эту запись в Ростере
  RosterItem := RosterForm.ReqRosterItem(UIN);
  if RosterItem <> nil then
    begin
      // Выставляем параметры сообщения в этой записи
      with RosterItem do
        begin
          // Ник контакта из Ростера
          Nick := SubItems[0];
          // Дата сообщения
          MsgD := Nick + ' [' + DateTimeChatMess + ']';
          // Записываем историю в этот контакт если он уже найден в списке контактов
          SubItems[15] := PopMsg;
          SubItems[35] := '0';
          // Добавляем историю в эту запись
          RosterForm.AddHistory(RosterItem, MsgD, Mess);
        end;
    end
  else // Если такой контакт не найден в Ростере, то добавляем его
    begin
      // Если ник не нашли в Ростере, то ищем его в файле-кэше ников
      Nick := SearchNickInCash('Icq', UIN);
      // Дата сообщения
      MsgD := Nick + ' [' + DateTimeChatMess + ']';
      // Ищем группу "Не в списке" в Ростере
      RosterItem := RosterForm.ReqRosterItem('NoCL');
      if RosterItem = nil then // Если группу не нашли
        begin
          // Добавляем такую группу в Ростер
          RosterItem := RosterForm.RosterJvListView.Items.Add;
          RosterItem.Caption := 'NoCL';
          // Подготавиливаем все значения
          RosterForm.RosterItemSetFull(RosterItem);
          RosterItem.SubItems[1] := NoInListGroupCaption;
        end;
      // Добавляем этот контакт в Ростер
      RosterItem := RosterForm.RosterJvListView.Items.Add;
      with RosterItem do
        begin
          Caption := UIN;
          // Подготавиливаем все значения
          RosterForm.RosterItemSetFull(RosterItem);
          // Обновляем субстроки
          SubItems[0] := Nick;
          SubItems[1] := 'NoCL';
          SubItems[2] := 'none';
          SubItems[3] := 'Icq';
          SubItems[6] := '214';
          SubItems[15] := PopMsg;
          SubItems[35] := '0';
          // Добавляем историю в эту запись
          RosterForm.AddHistory(RosterItem, MsgD, Mess);
          // Запрашиваем анкету неопознанных контактов
          // if Nick = UIN then if ICQ_Work_Phaze then ICQ_ReqInfo_New_Pkt(UIN);
        end;
    end;
  // Добавляем сообщение в текущий чат
  if ChatForm.AddMessInActiveChat(Nick, PopMsg, UIN, MsgD, Mess) then
    RosterItem.SubItems[36] := EmptyStr;
end;

procedure ICQ_ReqMessage_0407(PktData: string);
label
  X,
  Y,
  Z;
var
  UIN, Msg, UserClass, Status, TimeReg, IconHash, ConnTime: string;
  SubData, ExtIP, IntPort, IntIP, Desc, URL: string;
  I, Count, MsgLen: Integer;
  Len, ULen: Word;
  FSize: LongWord;
  MsgType: Word;
begin
  // Пропускаем раздел куков
  NextData(PktData, 16);
  // Начинаем разбор входящего сообщения
  case HexToInt(NextData(PktData, 4)) of
    $0001: begin
        Len := HexToInt(NextData(PktData, 2));
        Len := Len * 2;
        UIN := Hex2Text(NextData(PktData, Len));
        NextData(PktData, 4);
        Count := HexToInt(NextData(PktData, 4));
        if Count < 1 then
          goto X;
        for I := 0 to Count - 1 do
          begin
            case HexToInt(NextData(PktData, 4)) of
              $0001: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  UserClass := NextData(PktData, Len);
                end;
              $0006: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  Status := NextData(PktData, Len);
                end;
              $0005: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
                end;
              $001D: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  IconHash := NextData(PktData, Len);
                end;
              $000F: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
              $0003: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
                end
              else
                begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
            end;
          end;
      X :;
        while Length(PktData) > 0 do
          begin
            // 0000: US-ASCII
            // 0001: Plain
            // 0002: UCS-2BE
            // 0003: local 8bit encoding, iso-8859-1, cp-1257, cp-1251
            case HexToInt(NextData(PktData, 4)) of
              $0002: begin
                  NextData(PktData, 8); // TLV length + Unknown const
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len); // Counts of following bytes + following bytes
                  NextData(PktData, 4); // x0101, Unknown, constant
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  ULen := Len - 8; // Length of the message + 4
                  // CharsetNumber := HexToInt(NextData(PktData, 4)); //The encoding used for the message
                  NextData(PktData, 4); // The encoding used for the message
                  // CharsetSubset := HexToInt(NextData(PktData, 4)); //Unknown; seen: 0x0000 = 0, 0xffff = -1
                  NextData(PktData, 4);
                  Msg := Hex2Text(NextData(PktData, ULen));
                  // if CharsetNumber = $0002 then Msg := UCS2BEToStr(Msg);
                  Msg := RTF2Plain(Msg);
                end;
              $000B: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
              $0016: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
              $0013: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end
              else
                begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
            end;
          end;
      end;
    $0002, $0005, $0006: begin
        Len := HexToInt(NextData(PktData, 2));
        Len := Len * 2;
        UIN := Hex2Text(NextData(PktData, Len));
        NextData(PktData, 4);
        Count := HexToInt(NextData(PktData, 4));
        if Count < 1 then
          goto Y;
        for I := 0 to Count - 1 do
          begin
            case HexToInt(NextData(PktData, 4)) of
              $0001: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  UserClass := NextData(PktData, Len);
                end;
              $0006: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  Status := NextData(PktData, Len);
                end;
              $0005: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
                end;
              $001D: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  IconHash := NextData(PktData, Len);
                end;
              $000F: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
              $0003: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
                end
              else
                begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
            end;
          end;
      Y :;
        while Length(PktData) > 0 do
          begin
            case HexToInt(NextData(PktData, 4)) of
              $0005: begin
                  FSize := HexToInt(NextData(PktData, 4));
                  if HexToInt(NextData(PktData, 4)) <> 0 then
                    begin
                      NextData(PktData, (FSize * 2) - 4);
                      Continue;
                    end;
                  NextData(PktData, 16);
                  NextData(PktData, 32);
                  while Length(PktData) > 0 do
                    begin
                      case HexToInt(NextData(PktData, 4)) of
                        $0003: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            IntIP := NumToIp(Swap32(HexToInt(NextData(PktData, Len))));
                          end;
                        $0004: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            ExtIP := NumToIp(Swap32(HexToInt(NextData(PktData, Len))));
                          end;
                        $0005: begin
                            IntPort := IntToStr(HexToInt(NextData(PktData, 8)));
                            // Internal port
                          end;
                        $000A: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            NextData(PktData, Len);
                          end;
                        $000F: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            NextData(PktData, Len);
                          end;
                        $2711: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            SubData := NextData(PktData, Len);
                            if HexToInt(NextData(SubData, 2)) <> $1B then
                              Exit; // If this value is not present, this is not a message packet.
                            // Also, ICQ2001b does not send an ACK, SNAC(4,B), if this is not 0x1B.
                            NextData(SubData, 52);
                            NextData(SubData, 4); // FFSeq
                            NextData(SubData, 32);
                            MsgType := HexToInt(NextData(SubData, 2));
                            // MsgFlag := HexToInt(NextData(SubData, 2));
                            NextData(SubData, 2); // MsgFlag
                            NextData(SubData, 4); // status code
                            NextData(SubData, 4); // priority code
                            if MsgType = M_FILE then // File request
                              begin
                                Exit;
                              end
                            else if MsgType = M_CONTACTS then
                              // Contact list message
                              begin
                                Exit;
                              end
                            else if MsgType = M_ADVANCED then
                              begin
                                Exit;
                              end
                            else
                              begin
                                MsgLen := Swap16(HexToInt(NextData(SubData, 4)));
                                Dec(MsgLen);
                                MsgLen := MsgLen * 2;
                                Msg := Hex2Text(NextData(SubData, MsgLen));
                                if Length(Msg) > 0 then
                                  begin
                                    if MsgType = M_PLAIN then
                                      begin
                                        Msg := RTF2Plain(Msg);
                                        // Convert message from RTF to plaintext when needed
                                      end
                                    else if MsgType = M_URL then
                                      begin
                                        Desc := Copy(Msg, 0, Pos(#$FE, Msg) - 1);
                                        URL := Copy(Msg, Pos(#$FE, Msg) + 1, Length(Msg) - Pos(#$FE, Msg));
                                        Msg := URL + #13#10 + Desc;
                                      end;
                                  end;
                              end;
                          end;
                        $000B: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            NextData(PktData, Len);
                          end;
                        $0016: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            NextData(PktData, Len);
                          end;
                        $0013: begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            NextData(PktData, Len);
                          end
                        else
                          begin
                            Len := HexToInt(NextData(PktData, 4));
                            Len := Len * 2;
                            NextData(PktData, Len);
                          end;
                      end;
                    end;
                end
              else
                begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
            end;
          end;
      end;
    $0004: begin
        Len := HexToInt(NextData(PktData, 2));
        Len := Len * 2;
        UIN := Hex2Text(NextData(PktData, Len));
        NextData(PktData, 4);
        Count := HexToInt(NextData(PktData, 4));
        if Count < 1 then
          goto Z;
        for I := 0 to Count - 1 do
          begin
            case HexToInt(NextData(PktData, 4)) of
              $0001: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  UserClass := NextData(PktData, Len);
                end;
              $0006: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  Status := NextData(PktData, Len);
                end;
              $0005: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
                end;
              $001D: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  IconHash := NextData(PktData, Len);
                end;
              $000F: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
              $0003: begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
                end
              else
                begin
                  Len := HexToInt(NextData(PktData, 4));
                  Len := Len * 2;
                  NextData(PktData, Len);
                end;
            end;
          end;
      Z :;
        if HexToInt(NextData(PktData, 4)) = $0005 then
          begin
            NextData(PktData, 4);
            NextData(PktData, 8); // UIN
            MsgType := HexToInt(NextData(SubData, 2));
            // MsgFlag := HexToInt(NextData(SubData, 2));
            NextData(SubData, 2); // MsgFlag
            MsgLen := Swap16(HexToInt(NextData(SubData, 4)));
            Dec(MsgLen);
            MsgLen := MsgLen * 2;
            Msg := Hex2Text(NextData(SubData, MsgLen));
            if Length(Msg) > 0 then
              begin
                if MsgType = M_PLAIN then
                  begin
                    Msg := RTF2Plain(Msg); // Convert message from RTF to plaintext when needed
                  end
                else if MsgType = M_URL then
                  begin
                    Desc := Copy(Msg, 0, Pos(#$FE, Msg) - 1);
                    URL := Copy(Msg, Pos(#$FE, Msg) + 1, Length(Msg) - Pos(#$FE, Msg));
                    Msg := URL + #13#10 + Desc;
                  end
                else if MsgType = M_WEB_PAGE then
                  begin
                    Exit;
                  end;
              end;
          end;
      end
    else
      Msg := PktData;
  end;
  // Передаём полученные данные для события входящего сообщения
  ICQ_ReqMsgNotify(UIN, Msg, Status, UserClass, IntIP, IntPort, ExtIP, TimeReg, IconHash, ConnTime);
end;

procedure ICQ_UserOnline_Event(UIN, Status, UserClass, IntIP, IntPort, ExtIP, ConnFlag, ProtoVer, TimeReg, CapsId, Caps, IconHash,
  ConnTime: string);

function IsBartHasFlags(BartID: Word): Boolean;
begin
  Result := True;
  if BartID = 15 then
    Result := False;
end;

var
  StatusIcoInd, IXStat, IClient: Integer;
  BartID, BartLength, BartSubLen: Integer;
  Utf8Sup: Boolean;
  IHash, IXText, { ChatHint, } PClient, IXStatNew: string;
  RosterItem: TListItem;
begin
  // Получаем номер иконки из статуса
  StatusIcoInd := ICQ_StatusCode2ImgId(Status);
  // По умолчанию нет поддержки UTF-8 сообщений
  Utf8Sup := False;
  // Доп. статус и клиент по умолчанию
  IXStat := -1;
  IClient := -1;
  // Разбираем субпакет с хэш аватары и доп. статусами
  while Length(IconHash) > 0 do
    begin
      // Получаем идентификатор Bart_ID
      BartID := HexToInt(NextData(IconHash, 4));
      // Проверяем флаг
      if IsBartHasFlags(BartID) then
        HexToInt(NextData(IconHash, 2));
      // Получаем длинну барт данных
      BartLength := HexToInt(NextData(IconHash, 2));
      BartLength := BartLength * 2;
      // Если длинная барт данных больше нуля, то сканируем на нужные нам TLV
      if BartLength <> 0 then
        begin
          case BartID of
            BUDDY_ICON: IHash := Hex2Text(NextData(IconHash, BartLength));
            // Хэш-аватара
            STATUS_MOOD: // Название x-статуса (картинка)
              begin
                IXStatNew := Hex2Text(NextData(IconHash, BartLength));
                // Преобразуем новый тип доп. статуса в номер иконки
                NextData(IXStatNew, 7);
                IXStat := StrToInt(IXStatNew);
              end;
            STATUS_STR: // Текст x-статуса
              begin
                BartSubLen := HexToInt(NextData(IconHash, 4));
                BartSubLen := BartSubLen * 2;
                IXText := Hex2Text(NextData(IconHash, BartSubLen));
                if BartLength - BartSubLen > 0 then
                  NextData(IconHash, BartLength - BartSubLen); // Тупые байты
              end;
          else begin
              NextData(IconHash, BartLength);
            end;
          end;
        end;
    end;
  // Ищем доп. статус в капабилитисах (старый способ передачи доп. статусов)
  if BMSearch(0, Caps, XS1) > -1 then
    IXStat := 1
  else if BMSearch(0, Caps, XS2) > -1 then
    IXStat := 2
  else if BMSearch(0, Caps, XS3) > -1 then
    IXStat := 3
  else if BMSearch(0, Caps, XS4) > -1 then
    IXStat := 4
  else if BMSearch(0, Caps, XS5) > -1 then
    IXStat := 5
  else if BMSearch(0, Caps, XS6) > -1 then
    IXStat := 6
  else if BMSearch(0, Caps, XS7) > -1 then
    IXStat := 7
  else if BMSearch(0, Caps, XS8) > -1 then
    IXStat := 8
  else if BMSearch(0, Caps, XS9) > -1 then
    IXStat := 9
  else if BMSearch(0, Caps, XS10) > -1 then
    IXStat := 10
  else if BMSearch(0, Caps, XS11) > -1 then
    IXStat := 11
  else if BMSearch(0, Caps, XS12) > -1 then
    IXStat := 12
  else if BMSearch(0, Caps, XS13) > -1 then
    IXStat := 13
  else if BMSearch(0, Caps, XS14) > -1 then
    IXStat := 14
  else if BMSearch(0, Caps, XS15) > -1 then
    IXStat := 15
  else if BMSearch(0, Caps, XS16) > -1 then
    IXStat := 16
  else if BMSearch(0, Caps, XS17) > -1 then
    IXStat := 17
  else if BMSearch(0, Caps, XS18) > -1 then
    IXStat := 18
  else if BMSearch(0, Caps, XS19) > -1 then
    IXStat := 19
  else if BMSearch(0, Caps, XS20) > -1 then
    IXStat := 20
  else if BMSearch(0, Caps, XS21) > -1 then
    IXStat := 21
  else if BMSearch(0, Caps, XS22) > -1 then
    IXStat := 22
  else if BMSearch(0, Caps, XS23) > -1 then
    IXStat := 23
  else if BMSearch(0, Caps, XS24) > -1 then
    IXStat := 24
  else if BMSearch(0, Caps, XS25) > -1 then
    IXStat := 25
  else if BMSearch(0, Caps, XS26) > -1 then
    IXStat := 26
  else if BMSearch(0, Caps, XS27) > -1 then
    IXStat := 27
  else if BMSearch(0, Caps, XS28) > -1 then
    IXStat := 28
  else if BMSearch(0, Caps, XS29) > -1 then
    IXStat := 29
  else if BMSearch(0, Caps, XS30) > -1 then
    IXStat := 30
  else if BMSearch(0, Caps, XS31) > -1 then
    IXStat := 31
  else if BMSearch(0, Caps, XS32) > -1 then
    IXStat := 32
  else if BMSearch(0, Caps, XS33) > -1 then
    IXStat := 33
  else if BMSearch(0, Caps, XS34) > -1 then
    IXStat := 34
  else if BMSearch(0, Caps, XS35) > -1 then
    IXStat := 35
  else if BMSearch(0, Caps, XS36) > -1 then
    IXStat := 179
  else if BMSearch(0, Caps, XS37) > -1 then
    IXStat := 180;
  // Ищем идентификаторы клиентов в капабилитисах
  if BMSearch(0, Caps, CAP_IMADERING) > -1 then
    begin
      IClient := 1;
      PClient := 'IMadering';
    end
  else if BMSearch(0, Caps, CAP_QIP) > -1 then
    begin
      IClient := 2;
      PClient := 'QIP';
    end
  else if BMSearch(0, Hex2Text(Caps), 'Smaper') > -1 then
    begin
      IClient := 8;
      PClient := 'Smaper';
    end
  else if BMSearch(0, Hex2Text(Caps), 'MirandaM') > -1 then
    begin
      IClient := 3;
      PClient := 'Miranda';
    end
  else if BMSearch(0, Hex2Text(Caps), '&RQinside') > -1 then
    begin
      IClient := 4;
      PClient := '&RQ';
    end
  else if BMSearch(0, Caps, CAP_RNQ) > -1 then
    begin
      IClient := 5;
      PClient := 'R&Q';
    end
  else if BMSearch(0, Caps, CAP_MACICQ) > -1 then
    begin
      IClient := 10;
      PClient := 'MacICQ';
    end
  else if BMSearch(0, Caps, CAP_KXICQ) > -1 then
    begin
      IClient := 12;
      PClient := 'KXICQ';
    end
  else if BMSearch(0, Caps, CAP_PUSH2TALK) > -1 then
    begin
      IClient := 14;
      PClient := 'ICQ Lite';
    end
  else if BMSearch(0, Caps, CAP_ICQLITE) > -1 then
    begin
      IClient := 15;
      PClient := 'ICQ Lite';
    end
  else if BMSearch(0, Caps, CAP_NETVIGATOR) > -1 then
    begin
      IClient := 16;
      PClient := 'ICQ Net';
    end
  else if BMSearch(0, Caps, CAP_IMPLUS) > -1 then
    begin
      IClient := 18;
      PClient := 'IM plus';
    end
  else if BMSearch(0, Hex2Text(Caps), 'Jimm') > -1 then
    begin
      IClient := 19;
      PClient := 'Jimm';
    end
  else if BMSearch(0, Hex2Text(Caps), 'Kopete') > -1 then
    begin
      IClient := 20;
      PClient := 'Kopete';
    end
  else if BMSearch(0, Hex2Text(Caps), 'Licq client') > -1 then
    begin
      IClient := 21;
      PClient := 'Licq';
    end
  else if BMSearch(0, Hex2Text(Caps), 'mChat icq') > -1 then
    begin
      IClient := 22;
      PClient := 'mChat';
    end
  else if BMSearch(0, Caps, CAP_RAMBLER_RU) > -1 then
    begin
      IClient := 23;
      PClient := 'Rambler ICQ';
    end
  else if BMSearch(0, Hex2Text(Caps), 'SIM client') > -1 then
    begin
      IClient := 24;
      PClient := 'SIM';
    end
  else if BMSearch(0, Caps, CAP_TRILL_CRYPT) > -1 then
    begin
      IClient := 25;
      PClient := 'Trillian';
    end
  else if BMSearch(0, Caps, CAP_QIP_INFIUM) > -1 then
    begin
      IClient := 26;
      PClient := 'QIP Infium';
    end;
  // Ищем поддержку UTF-8 сообщений
  if (BMSearch(0, Caps, CAP_UTF8) > -1) or (BMSearch(0, CapsId, '134E') > -1) then
    Utf8Sup := True;
  // Обновляем отображение контакта в Ростере
  RosterItem := RosterForm.ReqRosterItem(UIN);
  if RosterItem <> nil then
    begin
      with RosterItem do
        begin
          // Если контакт не требует авторизации, то назначаем иконку статуса
          if SubItems[2] = 'both' then
            SubItems[6] := IntToStr(StatusIcoInd)
          else
            begin
              // Если контакт не авторизован, но пришел его статус, то считаем что он уже авторизован
              // и назначаем ему иконку статуса
              if (SubItems[2] = 'none') and (StatusIcoInd <> 9) then
                begin
                  SubItems[6] := IntToStr(StatusIcoInd);
                  // Снимаем флаг о необходимости авторизации и иконку предупреждения об этом
                  SubItems[2] := 'both';
                  SubItems[8] := '-1';
                end;
            end;
          // Ставим иконки доп. статуса
          if IXStat > -1 then
            SubItems[7] := IntToStr(IXStat + 44)
          else
            SubItems[7] := '-1';
          // Ставим иконку клиента
          if IClient > -1 then
            SubItems[8] := IntToStr(IClient + 186)
          else
            SubItems[8] := '-1';
          // Присваиваем онлайн переменные контакту
          SubItems[20] := UserClass;
          SubItems[21] := IntIP;
          SubItems[22] := IntPort;
          SubItems[23] := ExtIP;
          SubItems[24] := ConnFlag;
          SubItems[25] := ProtoVer;
          // Если протокол версия ноль, то отправляем сообщения в старом формате
          if ProtoVer = '0' then
            Utf8Sup := False;
          SubItems[26] := TimeReg;
          SubItems[27] := CapsId;
          SubItems[28] := Caps;
          SubItems[29] := Text2Hex(IHash);
          SubItems[30] := ConnTime;
          SubItems[31] := IXText;
          SubItems[32] := PClient;
          if Utf8Sup then
            SubItems[33] := 'X'
          else
            SubItems[33] := EmptyStr;
          // Создаём всплывающую подсказку для этого контакта
          // SubItems[34] := ICQ_CreateHint(RosterItem);
        end;
    end;
  // Запускаем таймер задержку событий Ростера
  MainForm.JvTimerList.Events[11].Enabled := False;
  MainForm.JvTimerList.Events[11].Enabled := True;
end;

procedure ICQ_UserUnkStatus_030A(PktData: string);
var
  UIN: string;
  Len: Integer;
begin
  // Получаем длинну UIN
  Len := HexToInt(NextData(PktData, 2));
  Len := Len * 2;
  UIN := Hex2Text(NextData(PktData, Len));
  // Запускаем событие контакт онлайн с неизвестным статусом номер иконки 214
  ICQ_UserOnline_Event(UIN, '88888888', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr,
    EmptyStr);
end;

procedure ICQ_UserOnline_030B(PktData: string; CheckStatus: Boolean);
label
  X;
var
  UIN, IconHash, UserClass, TimeReg, ConnTime, Status: string;
  CapsId, Caps, IntPort, ProtoVer, IntIP, ExtIP, ConnFlag: string;
  Count, I: Word;
  Len: Integer;
begin
  // Назначаем по умолчанию дефолтный статус
  Status := 'FFFFFFFF';
  // Получаем длинну UIN
  Len := HexToInt(NextData(PktData, 2));
  Len := Len * 2;
  // Получаем UIN чей статус нам прислал сервак
  UIN := Hex2Text(NextData(PktData, Len));
  // Пропускаем варнинглэвел (в icq всегда равен нулю)
  NextData(PktData, 4);
  // Получаем количество вложенных в пакет TLV
  Count := HexToInt(NextData(PktData, 4));
  // Если ноль TLV, то прыгаем в конец процедуры
  if Count < 1 then
    goto X;
  // Сканируем TLV в цикле
  for I := 0 to Count - 1 do
    begin
      case HexToInt(NextData(PktData, 4)) of
        $0001: // Класс контакта (вдруг админ постучит)
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            UserClass := NextData(PktData, Len);
          end;
        $000C: // DC информация
          begin
            // Пропускаем длинну пакета так как она всегда равна 37
            NextData(PktData, 4);
            IntIP := NumToIp(Swap32(HexToInt(NextData(PktData, 8))));
            // Внутрений IP адрес
            IntPort := IntToStr(HexToInt(NextData(PktData, 8)));
            // Внутрений порт
            ConnFlag := NextData(PktData, 2); // Флаг подключения
            ProtoVer := IntToStr(HexToInt(NextData(PktData, 4)));
            // Версия протокола
            NextData(PktData, 8); // Кукис для подключения
            NextData(PktData, 16); // Пропускаем
            NextData(PktData, 8); // Пропускаем
            NextData(PktData, 8); // Пропускаем
            NextData(PktData, 12); // Пропускаем
          end;
        $000A: // Внешний IP адрес
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            ExtIP := NumToIp(Swap32(HexToInt(NextData(PktData, Len))));
          end;
        $0006: // Статус
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            Status := NextData(PktData, Len);
          end;
        $0005: // Дата регистраций UIN
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
          end;
        $0019: // Укороченные капабилитисы
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            CapsId := NextData(PktData, Len);
          end;
        $000D: // Полные капабилитисы
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            Caps := NextData(PktData, Len);
          end;
        $001D: // Аватар хэш и другие доп. статусы
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            IconHash := NextData(PktData, Len);
          end;
        $000F: // Время в сети
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            NextData(PktData, Len);
          end;
        $0003: // Время подключения
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(NextData(PktData, Len))));
          end;
        $0004: // ?
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            NextData(PktData, Len);
          end;
        $0029: // ?
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            NextData(PktData, Len);
          end;
        $0026: // ?
          begin
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            NextData(PktData, Len);
          end
        else
          begin
            // Если есть другие TLV, то пропускаем их
            Len := HexToInt(NextData(PktData, 4));
            Len := Len * 2;
            NextData(PktData, Len);
          end;
      end;
    end;
X :;
  // Если это была проверка статуса то выводим сообщение
  if CheckStatus then
    begin
      if Status <> 'FFFFFFFF' then
        ICQ_NotifyUserStatus(UIN, ICQ_StatusCode2String(Status), ICQ_ClientCap2String(Caps), 0)
      else
        ICQ_NotifyUserStatus(UIN, ICQ_StatusCode2String(Status), EmptyStr, 2);
    end
  else
    begin
      // Передаём полученные данные другой процедуре для их финальной обработки
      ICQ_UserOnline_Event(UIN, Status, UserClass, IntIP, IntPort, ExtIP, ConnFlag, ProtoVer, TimeReg, CapsId, Caps, IconHash, ConnTime);
    end;
end;

procedure ICQ_UserOffline_030C(PktData: string);
var
  UIN: string;
  Len: Integer;
begin
  // Получаем длинну UIN
  Len := HexToInt(NextData(PktData, 2));
  Len := Len * 2;
  UIN := Hex2Text(NextData(PktData, Len));
  // Запускаем событие контакт онлайн со статусом оффлайн номер иконки 9
  ICQ_UserOnline_Event(UIN, 'FFFFFFFF', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr,
    EmptyStr);
end;

function ICQ_CliClientReadyPkt: string;
var
  Pkt: string;
begin
  Pkt := '00010002000000000002' + '002200010110164f000100040110164f' + '001300040110164f000200010110164f' +
    '000300010110164f001500010110164f' + '000400010110164f000600010110164f' + '000900010110164f000a00010110164f' + '000b00010110164f';
  Result := Pkt;
end;

function ICQ_StatusImgId2Code(ImgId: Integer): string;
var
  Xxxx, Ffff: string;
begin
  // Назначаем первую половину статуса (четыре первых символа)
  Xxxx := '1000';
  Ffff := 'FFFF';
  // Формируем флаги для первой половины статуса
  if ICQ_WebAware_Enabled then
    Xxxx := '1001';
  if ICQ_BirthDay_Enabled then
    Xxxx := '1008';
  if (ICQ_WebAware_Enabled) and (ICQ_BirthDay_Enabled) then
    Xxxx := '1009';
  // Формируем флаги для второй половины статуса
  case ImgId of
    7: Result := Xxxx + ICQ_Status_ONLINE;
    8: Result := Xxxx + ICQ_Status_AWAY;
    9: Result := Ffff + ICQ_Status_OFFLINE;
    10: Result := Xxxx + ICQ_Status_INVISIBLE;
    11: Result := Xxxx + ICQ_Status_INVISIBLE;
    12: Result := Xxxx + ICQ_Status_OCCUPIED;
    13: Result := Xxxx + ICQ_Status_DND;
    14: Result := Xxxx + ICQ_Status_NA;
    15: Result := Xxxx + ICQ_Status_LUNCH;
    16: Result := Xxxx + ICQ_Status_FFC;
    17: Result := Xxxx + ICQ_Status_DEPRESSION;
    18: Result := Xxxx + ICQ_Status_EVIL;
    19: Result := Xxxx + ICQ_Status_ATHOME;
    20: Result := Xxxx + ICQ_Status_ATWORK;
  else Result := Xxxx + ICQ_Status_ONLINE;
  end;
end;

procedure ICQ_UpdatePrivate_Group(InvizStatus: string);
var
  Pkt: string;
begin
  // Если код приватных групп пустой, то выходим
  if ICQ_UpdatePrivateGroup_Code = EmptyStr then
    Exit;
  // Формируем пакет
  Pkt := '00130009000000000009' + '00000000' + ICQ_UpdatePrivateGroup_Code + '0004002100CA0001' + InvizStatus +
    '00CB0004FFFFFFFF00D000010100D10001' + '0100D200010100D3000101';
  // Отсылаем пакет
  SendFLAP('2', Pkt);
end;

function ICQ_CreateShortStatusPkt: string;
var
  Pkt: string;
begin
  // В зависимости от приватного статуса отсылаем пакет видимости для групп
  if (ICQ_CurrentStatus = 10) or (ICQ_CurrentStatus = 11) then
    begin
      ICQ_PrivatStatus_Enabled := True;
      if ICQ_CurrentStatus = 10 then
        ICQ_UpdatePrivate_Group('03');
      if ICQ_CurrentStatus = 11 then
        ICQ_UpdatePrivate_Group('02');
    end
  else if ICQ_PrivatStatus_Enabled then
    begin
      ICQ_PrivatStatus_Enabled := False;
      ICQ_UpdatePrivate_Group('04');
    end;
  // Формируем пакет
  Pkt := '0001001E000000000000' + '00060004' + ICQ_StatusImgId2Code(ICQ_CurrentStatus);
  Result := Pkt;
end;

function ICQ_CliSetFirstStatusPkt: string;
var
  Pkt: string;
begin
  Pkt := '0001001E00000000001E' + '00060004' + ICQ_StatusImgId2Code(ICQ_CurrentStatus_bac) + '000800020A06000C' +
    '002500000000000000000000090000000000000000000000000000000000000000000000000000001D0008000E000000020000001F00020000';
  Result := Pkt;
end;

function ICQ_CliSetICBMparametersPkt: string;
var
  Pkt: string;
begin
  Pkt := '00040002000000000002' + '00000000070B1F4003E703E700000000';
  Result := Pkt;
end;

function ICQ_CliSetFirstOnlineInfoPkt(XClient, XVer, XStatusCap, Cap1, Cap2, Cap3: string): string;
var
  Pkt, Caps: string;
begin
  Caps := ICQ_GenerateClientCaps(XClient, XVer);
  Caps := Caps + XStatusCap + Text2Hex(Cap1 + Cap2 + Cap3);
  Pkt := '00020004000000000004' + '0005' + IntToHex(Length(Hex2Text(Caps)), 4) + Caps;
  Result := Pkt;
end;

function ICQ_Parse_1306(PktData: string): Boolean;
var
  Len, Count, I: Integer;
  CLTimeStamp: DWord;
  SubData, QSN, QGroupId, QID, QType, QTimeId, Rsu, QNick, TLV: string;
  Dt: TDateTime;
  Hour, Min, Sec, MSec: Word;
  ListItemD: TListItem;
begin
  // Ставим не законченный результат разбора пакета (пока все части пакета не придут нужно ждать их от сервера)
  Result := False;
  // Пропускаем версию КЛ
  NextData(PktData, 1);
  // Получаем количесво записей в нашем КЛ
  Count := HexToInt(Text2Hex(NextData(PktData, 2)));
  ICQ_CL_Count := ICQ_CL_Count + Count;
  // Разбираем записи
  // Начинаем добаление записей контактов в Ростер
  RosterForm.RosterJvListView.Items.BeginUpdate;
  try
    for I := 0 to Count - 1 do
      begin
        // Длинна записи
        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
        // Получаем имя записи
        QSN := Utf8Decode(NextData(PktData, Len));
        // Получаем идентификатор группы
        QGroupId := Text2Hex(NextData(PktData, 2));
        // Идентификатор записи
        QID := Text2Hex(NextData(PktData, 2));
        // Тип записи
        QType := Text2Hex(NextData(PktData, 2));
        // Длинна TLV записи
        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
        // Получаем субпакет записи
        SubData := NextData(PktData, Len);
        // Определяем действие по типу записи
        case HexToInt(QType) of
          BUDDY_NORMAL: // Нормальный контакт
            begin
              // Добавляем контакт в Ростер
              ListItemD := RosterForm.RosterJvListView.Items.Add;
              with ListItemD do
                begin
                  Caption := QSN;
                  // Подготавиливаем все значения
                  RosterForm.RosterItemSetFull(ListItemD);
                  // Обновляем субстроки
                  SubItems[0] := QSN;
                  SubItems[1] := QGroupId;
                  SubItems[2] := 'both';
                  SubItems[3] := 'Icq';
                  SubItems[4] := QID;
                  SubItems[5] := QType;
                  SubItems[6] := '9';
                  // Сканируем субпакет на наличие нужных нам TLV пока длинна пакета больше нуля
                  while Length(SubData) > 0 do
                    begin
                      TLV := Text2Hex(SubData[1] + SubData[2]);
                      case HexToInt(Text2Hex(NextData(SubData, 2))) of
                        $0131: // Ник контакта
                          begin
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            QNick := Utf8Decode(NextData(SubData, Len));
                            if QNick <> EmptyStr then
                              SubItems[0] := QNick;
                          end;
                        $013A: // Номер сотового телефона
                          begin
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            SubItems[9] := NextData(SubData, Len);
                          end;
                        $0066: // Авторизован ли контакт для нашего КЛ
                          begin
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            NextData(SubData, Len);
                            // Ставим флаг что контакт требует авторизации и ставим предупредительную иконку и жёлтый статус
                            SubItems.Strings[2] := 'none';
                            SubItems.Strings[6] := '80';
                            SubItems.Strings[8] := '220';
                          end;
                        $013C: // Заметка о контакте
                          begin
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            SubItems[10] := NextData(SubData, Len);
                          end;
                        $0137: // Email контакта
                          begin
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            SubItems[11] := NextData(SubData, Len);
                          end;
                        $006D: // TimeId
                          begin
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            QTimeId := Text2Hex(NextData(SubData, Len));
                            SubItems[12] := QTimeId;
                            // DateTimeToStr(UnixToDateTime(HexToInt(LeftStr(qTimeId, 8))));
                          end
                        else
                          begin
                            // Если пакет содержит другие TLV, то пропускаем их
                            Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                            xLog('ICQ parsing | ' + Log_Unk_Data + RN + 'TLV: ' + TLV + ' Value: ' + Trim(Dump(NextData(SubData, Len))));
                          end;
                      end;
                    end;
                end;
            end;
          BUDDY_GROUP: // Группа
            begin
              // Нулевая группа для временных контактов в серверном КЛ
              if QGroupId = '0000' then
                begin
                  // Добавляем группу в Ростер
                  ListItemD := RosterForm.RosterJvListView.Items.Add;
                  with ListItemD do
                    begin
                      Caption := QGroupId;
                      // Подготавиливаем все значения
                      RosterForm.RosterItemSetFull(ListItemD);
                      // Обновляем субстроки
                      SubItems[1] := HideContactGroupCaption;
                      SubItems[3] := 'Icq';
                      SubItems[4] := QGroupId;
                    end;
                end
                // Стандартная група
              else if QGroupId <> '0000' then
                begin
                  // Если есть хоть одна группа, то отключаем режим "нового" КЛ
                  NewKL := False;
                  // Добавляем группу в Ростер
                  ListItemD := RosterForm.RosterJvListView.Items.Add;
                  with ListItemD do
                    begin
                      Caption := QGroupId;
                      // Подготавиливаем все значения
                      RosterForm.RosterItemSetFull(ListItemD);
                      // Обновляем субстроки
                      SubItems[1] := QSN;
                      SubItems[3] := 'Icq';
                      SubItems[4] := QGroupId;
                    end;
                end;
            end;
          BUDDY_UPGROUP: // Код для приватных групп
            begin
              ICQ_UpdatePrivateGroup_Code := QID;
            end;
          BUDDY_IGNORE: // Игнорируемые контакты
            begin
              //
            end;
          BUDDY_INVISIBLE: // Невидящие контакты
            begin
              //
            end;
          BUDDY_VISIBLE: // Видящие контакты
            begin
              //
            end;
          BUDDY_DELETE, BUDDY_AUTORIZ: // Временные контакты из нулевой группы
            begin
              {ListItemD := RosterForm.RosterJvListView.Items.Add;
              with ListItemD do
                begin
                  Caption := QSN;
                  // Подготавиливаем все значения
                  RosterForm.RosterItemSetFull(ListItemD);
                  // Обновляем субстроки
                  // Делаем поиск ника в кэше ников
                  if ICQ_Show_HideContacts then
                    SubItems[0] := SearchNickInCash('Icq', QSN)
                  else
                    SubItems[0] := QSN;
                  SubItems[1] := QGroupId;
                  SubItems[2] := 'none';
                  SubItems[3] := 'Icq';
                  SubItems[4] := QID;
                  SubItems[5] := QType;
                  // Назначаем такому контакту серый неизвестный статус и иконку
                  SubItems[6] := '214';
                  // Сканируем пакет на нужные нам TLV
                  while Length(SubData) > 0 do
                    begin
                      case HexToInt(NextData(SubData, 4)) of
                        $006D: // TimeId
                          begin
                            Len := HexToInt(NextData(SubData, 4));
                            Len := Len * 2;
                            QTimeId := NextData(SubData, Len);
                            SubItems[12] := QTimeId;
                            // DateTimeToStr(UnixToDateTime(HexToInt(LeftStr(qTimeId, 8))));
                          end
                        else
                          begin
                            // Если пакет содержит другие TLV, то пропускаем их
                            Len := HexToInt(NextData(SubData, 4));
                            Len := Len * 2;
                            NextData(SubData, Len);
                          end;
                      end;
                    end;
                end;}
            end;
          BUDDY_VANITY: // Информация о нашей деятельности на этом UIN
            begin
              // Сканируем пакет на нужные нам TLV
              {while Length(SubData) > 0 do
                begin
                  case HexToInt(NextData(SubData, 4)) of
                    $0067: // Начало сбора статистики
                      begin
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        ICQ_CollSince := DateTimeToStr(UnixToDateTime(HexToInt(NextData(SubData, Len))));
                      end;
                    $0150: // Всего отправлено сообщений
                      begin
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        ICQ_SendMess := IntToStr(HexToInt(NextData(SubData, Len)));
                      end;
                    $0151: // Дней проведено в сети
                      begin
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        Dt := HexToInt(NextData(SubData, Len)) / 86400;
                        if Trunc(Dt) > 0 then
                          begin
                            Rsu := IntToStr(Trunc(Dt)) + ' day';
                            if Trunc(Dt) > 1 then
                              Rsu := Rsu + 's';
                            Rsu := Rsu + ', ';
                          end;
                        DecodeTime(Dt, Hour, Min, Sec, MSec);
                        if Hour > 0 then
                          Rsu := Rsu + Format('%d h, ', [Hour]);
                        if Min > 0 then
                          Rsu := Rsu + Format('%d m, ', [Min]);
                        if Sec > 0 then
                          Rsu := Rsu + Format('%d s, ', [Sec]);
                        Delete(Rsu, Length(Rsu) - 1, 2);
                        ICQ_OnlineTime := Rsu;
                      end;
                    $0152: // Всего отправлено Away сообщений
                      begin
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        ICQ_AwayMess := IntToStr(HexToInt(NextData(SubData, Len)));
                      end;
                    $0153: // Всего получено сообщений
                      begin
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        ICQ_RecMess := IntToStr(HexToInt(NextData(SubData, Len)));
                      end;
                    $0160: // Активность
                      begin
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        ICQ_LastActive := DateTimeToStr(UnixToDateTime(HexToInt(NextData(SubData, Len))));
                      end
                    else
                      begin
                        // Если пакет содержит другие TLV, то пропускаем их
                        Len := HexToInt(NextData(SubData, 4));
                        Len := Len * 2;
                        NextData(SubData, Len);
                      end;
                  end;
                end;
              // Отображаем эти переменные в окне настроек ICQ
              if Assigned(IcqOptionsForm) then
                IcqOptionsForm.SetOnlineVars;}
            end;
        end;
      end;
  finally
    // Заканчиваем добаление записей контактов в Ростер
    RosterForm.RosterJvListView.Items.EndUpdate;
  end;
  // Финальное время контакт листа
  CLTimeStamp := HexToInt(Text2Hex(NextData(PktData, 4)));
  // Если время больше нуля, то заканчиваем с наполнением КЛ
  if CLTimeStamp <> 0 then
    begin
      // Если это обсолютно пустой и новый КЛ, то создаём первую в его жизни группу (обязательное условие)
      if NewKL then
        begin
          // Стартуем фазу добавления группы
          ICQ_Add_Nick := 'General';
          // Рандомизируем случайный идентификатор
          Randomize;
          ICQ_Add_GroupId := IntToHex(Random($7FFF), 4);
          ICQ_Add_Group_Phaze := True;
          ICQ_SSI_Phaze := True;
          ICQ_AddGroup('General', ICQ_Add_GroupId);
        end;
      // Объявляем финальный результат разбора всего пакета
      Result := True;
      // Запускаем обработку Ростера
      CollapseGroupsRestore := True;
      RosterForm.UpdateFullCL;
    end;
end;

procedure ICQ_Parse_010F(PktData: string);
var
  Len, Count, I: Integer;
  TLV: string;
begin
  // Если пакет пустой, то выходим
  if PktData = EmptyStr then
    Exit;
  // При ошибочных данных инкапсулированных в пакет O_o
  if Ord(PktData[1]) = $00 then xLog('ICQ parsing | ' + Log_Unk_Data + RN + Trim(Dump(NextData(PktData, 8))));
  // Пропускаем наш UIN и уровень предупреждений (в icq протоколе всегда равен 0)
  NextData(PktData, Ord(PktData[1]) + 3);
  // Получаем количесво вложенных в пакет TLV
  Count := HexToInt(Text2Hex(NextData(PktData, 2)));
  for I := 0 to Count - 1 do
    begin
      NextData(PktData, 1);
      // Сканируем пакет на наличие нужных нам TLV
      case Ord(PktData[1]) of
        $03: // Время подключения
          begin
            NextData(PktData, 1);
            Len := HexToInt(Text2Hex(NextData(PktData, 2)));
            MyConnTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
            xLog('ICQ parsing | ' + MyConnTime);
            // Отображаем это в окне настроек ICQ
            if Assigned(IcqOptionsForm) then
              IcqOptionsForm.ConnectTimeInfoEdit.Text := MyConnTime;
          end;
        $05: // Дата регистрации нашего UIN
          begin
            NextData(PktData, 1);
            Len := HexToInt(Text2Hex(NextData(PktData, 2)));
            ICQ_MyUIN_RegTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
            xLog('ICQ parsing | ' + ICQ_MyUIN_RegTime);
            // Отображаем это в окне настроек ICQ
            if Assigned(IcqOptionsForm) then
              IcqOptionsForm.RegDateInfoEdit.Text := ICQ_MyUIN_RegTime;
          end;
        $0A: // Наш внешний IP адрес
          begin
            NextData(PktData, 1);
            Len := HexToInt(Text2Hex(NextData(PktData, 2)));
            ICQ_Online_IP := NumToIp(Swap32(HexToInt(Text2Hex(NextData(PktData, Len)))));
            xLog('ICQ parsing | ' + ICQ_Online_IP);
            // Отображаем это в окне настроек ICQ
            if Assigned(IcqOptionsForm) then
              IcqOptionsForm.ExternalIPInfoEdit.Text := ICQ_Online_IP;
          end
        else
          begin
            // Если пакет содержит другие TLV, то пропускаем их
            TLV := '00' + Text2Hex(NextData(PktData, 1));
            Len := HexToInt(Text2Hex(NextData(PktData, 2)));
            xLog('ICQ parsing | ' + Log_Unk_Data + RN + 'TLV: ' + TLV + ' Value: ' + Trim(Dump(NextData(PktData, Len))));
          end;
      end;
    end;
end;

function ICQ_CliFamilyPkt: string;
var
  Pkt: string;
begin
  Pkt := '00010017000000000017' + '002200010001000400130004000200010003000' + '100150001000400010006000100090001000A0001000B0001';
  Result := Pkt;
end;

function ICQ_CliCookiePkt(Cookie: string): string;
var
  Pkt: string;
begin
  Pkt := '000000010006' + IntToHex(Length(Hex2Text(Cookie)), 4) + Cookie + '0003' + IntToHex(Length('ICQ Client'), 4) + Text2Hex
    ('ICQ Client') + '00170002' + IntToHex(6, 4) + '00180002' + IntToHex(5, 4) + '00190002' + IntToHex(0, 4) + '001a0002' + IntToHex
    (102, 4) + '00160002' + IntToHex(266, 4) + '00140004' + IntToHex(30007, 8) + '000f' + IntToHex(Length('ru'), 4) + Text2Hex('ru')
    + '000e' + IntToHex(Length('ru'), 4) + Text2Hex('ru') + '0094000100' + '8003000400100000';
  Result := Pkt;
end;

function ICQ_MD5CliLoginPkt(cPass, cKey: RawByteString): string;
var
  CLIENT_MD5_STRING: RawByteString;
  MD5hash: string;
  State: TMd5Context;
  Digest: TMD5Digest;
begin
  xLog('ICQ parsing | ' + Log_MD5_Nonce + cKey);
  // Уменьшаем длинну пароля до 8 символов (ограничение протокола ICQ)
  if Length(ICQ_LoginPassword) > 8 then
    Setlength(ICQ_LoginPassword, 8);
  // Вычисляем MD5 хэш пароля
  CLIENT_MD5_STRING := 'AOL Instant Messenger (SM)';
  MD5Init(State);
  MD5UpdateBuffer(State, PByteArray(@cPass[1]), Length(cPass));
  MD5Final(Digest, State);
  MD5Init(State);
  MD5UpdateBuffer(State, PByteArray(@cKey[1]), Length(cKey));
  MD5UpdateBuffer(State, PByteArray(@Digest), SizeOf(TMD5Digest));
  MD5UpdateBuffer(State, PByteArray(@CLIENT_MD5_STRING[1]), Length(CLIENT_MD5_STRING));
  MD5Final(Digest, State);
  MD5hash := PacketToHex(@Digest, SizeOf(TMD5Digest));
  // Формируем пакет
  Result := '00170002000000000000' + '0001' + IntToHex(Length(ICQ_LoginUIN), 4) + Text2Hex(ICQ_LoginUIN)
    + '00250010' + MD5hash + '004C0000' + '0003' + IntToHex(Length('ICQ Client'), 4) + Text2Hex('ICQ Client') + '00170002' + IntToHex(6, 4)
    + '00180002' + IntToHex(5, 4) + '00190002' + IntToHex(0, 4) + '001A0002' + IntToHex(102, 4) + '00160002' + IntToHex(266, 4)
    + '00140004' + IntToHex(30007, 8) + '000F' + IntToHex(Length('ru'), 4) + Text2Hex('ru') + '000E' + IntToHex(Length('ru'), 4) + Text2Hex
    ('ru') + '0094000100';
end;

procedure ICQ_NotifyUserStatus(UIN, IStatus, IClient: string; IColor: Integer);
var
  Client, Nick: string;
  RosterItem: TListItem;
begin
  // Ищем ник этой учётной записи в КЛ
  RosterItem := RosterForm.ReqRosterItem(UIN);
  if RosterItem <> nil then
    Nick := RosterItem.SubItems[0];
  if Nick > EmptyStr then
    Nick := InfoNickL + ' ' + Nick;
  if IClient > EmptyStr then
    Client := ClientL + ' ' + IClient;
  // Отображаем всплывающим сообщением статус контакта
  DAShow(InformationHead, Nick + #13#10 + 'ICQ#: ' + UIN + #13#10 + StatusL + ' ' + IStatus + #13#10 + Client, EmptyStr, 133, IColor, 0);
end;

function ICQ_NotifyAuthCookieError(ErrCode: string): string;
begin
  // Пытаемся узнать расшифровку кода ошибки
  if ErrCode = '0001' then
    Result := ConnectErrors_0001
  else if ErrCode = '0002' then
    Result := ConnectErrors_0002
  else if ErrCode = '0003' then
    Result := ConnectErrors_0003
  else if ErrCode = '0004' then
    Result := ConnectErrors_0004
  else if ErrCode = '0005' then
    Result := ConnectErrors_0005
  else if ErrCode = '0006' then
    Result := ConnectErrors_0006
  else if ErrCode = '0007' then
    Result := ConnectErrors_0007
  else if ErrCode = '0008' then
    Result := ConnectErrors_0008
  else if ErrCode = '0009' then
    Result := ConnectErrors_0009
  else if ErrCode = '000A' then
    Result := ConnectErrors_000A
  else if ErrCode = '000B' then
    Result := ConnectErrors_000B
  else if ErrCode = '000C' then
    Result := ConnectErrors_000C
  else if ErrCode = '000D' then
    Result := ConnectErrors_000D
  else if ErrCode = '000E' then
    Result := ConnectErrors_000E
  else if ErrCode = '000F' then
    Result := ConnectErrors_000F
  else if ErrCode = '0010' then
    Result := ConnectErrors_0010
  else if ErrCode = '0011' then
    Result := ConnectErrors_0011
  else if ErrCode = '0012' then
    Result := ConnectErrors_0012
  else if ErrCode = '0013' then
    Result := ConnectErrors_0013
  else if ErrCode = '0014' then
    Result := ConnectErrors_0014
  else if ErrCode = '0015' then
    Result := ConnectErrors_0015
  else if ErrCode = '0016' then
    Result := ConnectErrors_0016
  else if ErrCode = '0017' then
    Result := ConnectErrors_0017
  else if ErrCode = '0018' then
    Result := ConnectErrors_0018
  else if ErrCode = '0019' then
    Result := ConnectErrors_0019
  else if ErrCode = '001A' then
    Result := ConnectErrors_001A
  else if ErrCode = '001B' then
    Result := ConnectErrors_001B
  else if ErrCode = '001C' then
    Result := ConnectErrors_001C
  else if ErrCode = '001D' then
    Result := ConnectErrors_001D
  else if ErrCode = '001E' then
    Result := ConnectErrors_001E
  else if ErrCode = '0020' then
    Result := ConnectErrors_0020
  else if ErrCode = '0022' then
    Result := ConnectErrors_0022
  else
    Result := UnknownError + ' (' + ErrCode + ')';
  xLog('ICQ | ' + Result);
end;

procedure ICQ_GoOffline;
var
  I: Integer;
begin
  // Отключаем таймер факстатуса, пингов
  MainForm.UnstableICQStatus.Checked := False;
  with MainForm.JvTimerList do
    begin
      Events[4].Enabled := False;
      Events[5].Enabled := False;
    end;
  // Если существует форма настроек протокола ICQ, то блокируем там контролы
  if Assigned(IcqOptionsForm) then
    begin
      with IcqOptionsForm do
        begin
          NoAutoAuthRadioButton.Enabled := False;
          YesAutoAuthRadioButton.Enabled := False;
          ShowWebAwareCheckBox.Enabled := False;
          ICQUINEdit.Enabled := True;
          ICQUINEdit.Color := ClWindow;
          PassEdit.Enabled := True;
          PassEdit.Color := ClWindow;
        end;
    end;
  // Активируем фазу оффлайн и обнуляем буферы пакетов
  ICQ_Connect_Phaze := False;
  ICQ_HTTP_Connect_Phaze := False;
  ICQ_BosConnect_Phaze := False;
  ICQ_Work_Phaze := False;
  ICQ_Offline_Phaze := True;
  ICQ_SSI_Phaze := False;
  ICQ_myBeautifulSocketBuffer := EmptyStr;
  ICQ_BuffPkt := EmptyStr;
  // Обнуляем переменные протокола
  ICQ_Online_IP := EmptyStr;
  ICQ_MyUIN_RegTime := EmptyStr;
  ICQ_MyIcon_Hash := EmptyStr;
  ICQ_UpdatePrivateGroup_Code := EmptyStr;
  ICQ_CollSince := EmptyStr;
  ICQ_SendMess := EmptyStr;
  ICQ_OnlineTime := EmptyStr;
  ICQ_AwayMess := EmptyStr;
  ICQ_RecMess := EmptyStr;
  ICQ_LastActive := EmptyStr;
  // Если сокет подключён, то отсылаем пакет "до свидания"
  with MainForm do
    begin
      if ICQWSocket.State = WsConnected then
        ICQWSocket.SendStr(Hex2Text('2A04' + IntToHex(ICQ_Seq, 4) + '0000'));
      // Закрываем сокет
      ICQWSocket.Abort;
      // Ставим иконку и значение статуса оффлайн
      ICQ_CurrentStatus := 9;
      ICQToolButton.ImageIndex := ICQ_CurrentStatus;
      ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
      // Подсвечиваем в меню статуса ICQ статус оффлайн
      ICQStatusOffline.default := True;
    end;
  // Обнуляем счётчики пакетов
  ICQ_Seq := $1000;
  ICQ_Avatar_Seq := $2000;
  // Обнуляем события и переменные в Ростере
  with RosterForm.RosterJvListView do
    begin
      for I := 0 to Items.Count - 1 do
        begin
          if Items[I].SubItems[3] = 'Icq' then
            begin
              if Items[I].SubItems[6] <> '214' then
                Items[I].SubItems[6] := '9';
              Items[I].SubItems[7] := '-1';
              Items[I].SubItems[8] := '-1';
              Items[I].SubItems[13] := '';
              Items[I].SubItems[15] := '';
              Items[I].SubItems[16] := '';
              Items[I].SubItems[18] := '0';
              Items[I].SubItems[19] := '0';
              Items[I].SubItems[20] := '';
              Items[I].SubItems[24] := '';
              Items[I].SubItems[25] := '';
              Items[I].SubItems[30] := '';
              Items[I].SubItems[31] := '';
              Items[I].SubItems[32] := '';
              Items[I].SubItems[35] := '0';
            end;
        end;
    end;
  // Запускаем обработку Ростера
  RosterForm.UpdateFullCL;
end;

function ICQ_GenerateClientCaps(ClientName, CVer: string): string;
begin
  Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY;
  if ClientName = 'IMadering' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION + CAP_IMADERING;
    end
  else if ClientName = 'QIP 2005' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION + CAP_QIP +
        CAP_ICQDEVILS + CAP_QIP_PROTECTMSG + CAP_ICQ_XTRAZ_SUPPORT;
    end
  else if ClientName = 'Miranda' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION + CAP_MIRANDA;
    end
  else if ClientName = '&RQ' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_ANDRQ;
    end
  else if ClientName = 'R&Q' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_RNQ;
    end
  else if ClientName = 'AIM' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY;
    end
  else if ClientName = 'Compad' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION;
    end
  else if ClientName = 'QIP mobile' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY;
    end
  else if ClientName = 'ICQ 6.0' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY;
    end
  else if ClientName = 'MacICQ' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_MACICQ;
    end
  else if ClientName = 'Pidgin' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY;
    end
  else if ClientName = 'ICQKX' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_KXICQ;
    end
  else if ClientName = 'ICQ 2001' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY;
    end
  else if ClientName = 'ICQ 5.1' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION +
        CAP_PUSH2TALK + CAP_ICQDEVILS + CAP_ICQ_XTRAZ_SUPPORT;
    end
  else if ClientName = 'ICQ lite' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_ICQLITE;
    end
  else if ClientName = 'ICQnet' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_IS_WEB + CAP_PUSH2TALK +
        CAP_MULTI_USER + CAP_ICQ_XTRAZ_SUPPORT + CAP_NETVIGATOR;
    end
  else if ClientName = 'icq2go' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION;
    end
  else if ClientName = 'ImPlus' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_IS_WEB + CAP_IMPLUS;
    end
  else if ClientName = 'jimm' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_JIMM + CAP_TYPING_NOTIFICATION;
    end
  else if ClientName = 'Kopete' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_ICQ_XTRAZ_SUPPORT + CAP_KOPETE;
    end
  else if ClientName = 'Licq' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_LICQ2;
    end
  else if ClientName = 'mChat' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_MCHAT;
    end
  else if ClientName = 'Rambler ICQ' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_TYPING_NOTIFICATION +
        CAP_RAMBLER_RU + CAP_ICQDEVILS + CAP_ICQ_XTRAZ_SUPPORT;
    end
  else if ClientName = 'SIM' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_UTF8 + CAP_SIM;
    end
  else if ClientName = 'Trillian' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_TRILL_UNK + CAP_TRILL_CRYPT;
    end
  else if ClientName = 'QIP infium' then
    begin
      Result := CAP_AIM_INTEROPERATE + CAP_AIM2 + CAP_AIM_ISICQ + CAP_AIM_SERVERRELAY + CAP_QIP_INFIUM;
    end;
end;

end.
