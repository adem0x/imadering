{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit JabberProtoUnit;

interface

{$REGION 'Uses'}

uses
  Windows,
  MainUnit,
  SysUtils,
  JvTrayIcon,
  Dialogs,
  OverbyteIcsWSocket,
  ChatUnit,
  Forms,
  ComCtrls,
  Messages,
  Classes,
  ContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  OverbyteIcsMimeUtils,
  JabberOptionsUnit,
  JvSimpleXml,
  OverbyteIcsUrl,
  OverbyteIcsUtils,
  StrUtils;

{$ENDREGION}
{$REGION 'Const'}
const
  J_RootNode = '<' + C_Jabber + '>' + C_VS + '<' + '/' + C_Jabber + '>';



  // old
  Iq_TypeSet = '<iq type=''set'' id=''%d''>';
  Iq_TypeGet = '<iq type=''get'' id=''%d''>';
  Iq_Roster = 'jabber:iq:roster';
  J_MessHead = '<message type=''%s'' to=''%s'' id=''%d''>';
  J_GetInfoHead = '<iq type=''get'' to=''%s'' id=''%d''><vCard xmlns=''vcard-temp'' prodid=''-//HandGen//NONSGML vGen v1.0//EN'' version=''2.0''/></iq>';
  J_GetServices = '<iq type=''get'' to=''%s'' id=''%d''><query xmlns=''http://jabber.org/protocol/disco#items''/></iq>';
  J_GetServicesInfo = '<iq type=''get'' to=''%s'' id=''%d''><query xmlns=''http://jabber.org/protocol/disco#info''/></iq>';
  J_DellAccount = '<iq type=''set'' to=''%s'' id=''%d''><query xmlns="jabber:iq:register"><remove /></query></iq>';
  J_RegAccount = '<iq type=''set'' id=''%d''><query xmlns=''jabber:iq:register''><username>%s</username><password>%s</password></query></iq>';
  J_SearchUser = '<iq type=''set'' to=''%s'' id=''%d'' xml:lang=''en''><query xmlns=''jabber:iq:search''><x xmlns=''jabber:x:data'' type=''submit''>%s</x></query></iq>';
  J_PassChange = '<iq type=''set'' to=''%s'' id=''%d''><query xmlns="jabber:iq:register"><username>%s</username><password>%s</password></query></iq>';
  J_RootTag = 'stream:stream';
  J_SessionEnd = '</stream:stream>';
  J_Features = 'stream:features';
  J_Iq = 'iq';
  J_Presence = 'presence';
  J_Message = 'message';
  J_Session = 'session';
  J_Query = 'query';
  J_StreamHead = '<?xml version=''1.0'' encoding=''UTF-8''?>' //
  + '<stream:stream to=''%s'' xmlns=''jabber:client'' xmlns:stream=''http://etherx.jabber.org/streams'' xml:lang=''%s'' version=''1.0''>';
  J_PlainMechanism = '<auth xmlns=''urn:ietf:params:xml:ns:xmpp-sasl'' mechanism=''PLAIN''>%s</auth>';
  J_MD5Mechanism = '<auth xmlns=''urn:ietf:params:xml:ns:xmpp-sasl'' mechanism=''DIGEST-MD5''/>';
  J_ChallengeOK = '<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''/>';
  J_From = 'from';
  J_ChatType = 'chat';
  J_GroupChatType = 'groupchat';
  J_JoinInConf = '<presence to=''%s''><priority>%s</priority><x xmlns=''http://jabber.org/protocol/muc''/>' //
  + '<c xmlns=''http://jabber.org/protocol/caps'' node=''http://imadering.com/caps'' ver=''5.0.1.399''/></presence>';

  // Значение нод для информации о контакте
  Node_JID = 'JID';
  Node_FN = 'FN';
  Node_N = 'N';
  Node_GIVEN = 'GIVEN';
  Node_FAMILY = 'FAMILY';
  Node_NICKNAME = 'NICKNAME';
  Node_BDAY = 'BDAY';
  Node_GENDER = 'GENDER';
  Node_EMAIL = 'EMAIL';
  Node_USERID = 'USERID';
  Node_ADR = 'ADR';
  Node_HOME = 'HOME';
  Node_STREET = 'STREET';
  Node_EXTADR = 'EXTADR';
  Node_EXTADD = 'EXTADD';
  Node_LOCALITY = 'LOCALITY';
  Node_REGION = 'REGION';
  Node_PCODE = 'PCODE';
  Node_CTRY = 'CTRY';
  Node_COUNTRY = 'COUNTRY';
  Node_WORK = 'WORK';
  Node_ORG = 'ORG';
  Node_ORGNAME = 'ORGNAME';
  Node_ORGUNIT = 'ORGUNIT';
  Node_TITLE = 'TITLE';
  Node_ROLE = 'ROLE';
  Node_URL = 'URL';
  Node_DESC = 'DESC';
  Node_TEL = 'TEL';
  Node_NUMBER = 'NUMBER';
  Node_PHOTO = 'PHOTO';
  Node_TYPE = 'TYPE';
  Node_BINVAL = 'BINVAL';

{$ENDREGION}
{$REGION 'Jabber_Client_Icons'}
  J_Client_Icons:
    packed array[0..50] of record
    Client_Caps: string;
    Client_Name: string;
    Client_Img: string;
  end = ((Client_Caps: 'http://qip.ru/caps'; Client_Name: 'QIP'; Client_Img: '103'), // 0
    (Client_Caps: 'http://pda.qip.ru/caps'; Client_Name: 'QIP PDA'; Client_Img: '99'), // 1
    (Client_Caps: 'http://miranda-im.org/caps'; Client_Name: 'Miranda'; Client_Img: '98'), // 2
    (Client_Caps: 'http://gajim.org'; Client_Name: 'Gajim'; Client_Img: '-1'), // 3
    (Client_Caps: 'http://tkabber.jabber.ru/'; Client_Name: 'Tkabber'; Client_Img: '-1'), // 4
    (Client_Caps: 'http://psi-im.org/caps'; Client_Name: 'Psi'; Client_Img: '-1'), // 5
    (Client_Caps: 'http://psi-dev.googlecode.com/caps'; Client_Name: 'Psi Dev'; Client_Img: '-1'), // 6
    (Client_Caps: 'http://pidgin.im/caps'; Client_Name: 'Pidgin'; Client_Img: '-1'), // 7
    (Client_Caps: 'http://pidgin.im/caps'; Client_Name: 'Adium'; Client_Img: '-1'), // 8
    (Client_Caps: 'http://pidgin.im/'; Client_Name: 'Pidgin'; Client_Img: '-1'), // 9
    (Client_Caps: 'http://www.google.com/xmpp/client/caps'; Client_Name: 'Talkonaut'; Client_Img: '90'), // 10
    (Client_Caps: 'http://online.yandex.ru/caps'; Client_Name: 'Я Онлайн'; Client_Img: '-1'), // 11
    (Client_Caps: 'http://qutim.org'; Client_Name: 'qutIM'; Client_Img: '104'), // 12
    (Client_Caps: 'http://www.barobin.com/caps'; Client_Name: 'BayanICQ'; Client_Img: '202'), // 13
    (Client_Caps: 'http://bombusmod.net.ru/caps'; Client_Name: 'Bombus'; Client_Img: '212'), // 14
    (Client_Caps: 'http://bombus-im.org/java'; Client_Name: 'Bombus'; Client_Img: '212'), // 15
    (Client_Caps: 'http://bombus-im.org/ng'; Client_Name: 'Bombus'; Client_Img: '212'), // 16
    (Client_Caps: 'http://voffk.org.ru/bombus'; Client_Name: 'Bombus'; Client_Img: '212'), // 17
    (Client_Caps: 'http://bombusmod-qd.wen.ru/caps'; Client_Name: 'Bombus'; Client_Img: '212'), // 18
    (Client_Caps: 'http://bombus.pl/caps'; Client_Name: 'Bombus'; Client_Img: '212'), // 19
    (Client_Caps: 'http://exodus.jabberstudio.org/caps'; Client_Name: 'Exodus'; Client_Img: '-1'), // 20
    (Client_Caps: 'http://gaim.sf.net/caps'; Client_Name: 'Gaim'; Client_Img: '-1'), // 21
    (Client_Caps: 'http://www.google.com/xmpp/client/caps'; Client_Name: 'GTalk'; Client_Img: '77'), // 22
    (Client_Caps: 'http://mail.google.com/xmpp/client/caps'; Client_Name: 'GMail'; Client_Img: '77'), // 23
    (Client_Caps: 'http://talk.google.com/xmpp/bot/caps'; Client_Name: 'GMail'; Client_Img: '77'), // 24
    (Client_Caps: 'http://www.apple.com/ichat/caps'; Client_Name: 'iChat'; Client_Img: '-1'), // 25
    (Client_Caps: 'http://dev.jabbim.cz/jabbim/caps'; Client_Name: 'JabbIM'; Client_Img: '-1'), // 26
    (Client_Caps: 'http://jajc.jrudevels.org/caps'; Client_Name: 'JAJC'; Client_Img: '-1'), // 27
    (Client_Caps: 'http://kopete.kde.org/jabber/caps'; Client_Name: 'Kopete'; Client_Img: '-1'), // 28
    (Client_Caps: 'http://mcabber.lilotux.net/caps'; Client_Name: 'Mcabber'; Client_Img: '-1'), // 29
    (Client_Caps: 'http://mcabber.com/caps'; Client_Name: 'Mcabber'; Client_Img: '-1'), // 30
    (Client_Caps: 'http://coccinella.sourceforge.net/protocol/caps'; Client_Name: 'Coccinella'; Client_Img: '-1'), // 31
    (Client_Caps: 'http://mchat.mgslab.com/'; Client_Name: 'mChat'; Client_Img: '200'), // 32
    (Client_Caps: 'nimbuzz:caps'; Client_Name: 'Nimbuzz'; Client_Img: '209'), // 33
    (Client_Caps: 'http://palringo.com/caps'; Client_Name: 'Palringo'; Client_Img: '-1'), // 34
    (Client_Caps: 'http://bitlbee.org/xmpp/caps'; Client_Name: 'Bitlbee'; Client_Img: '-1'), // 35
    (Client_Caps: 'Digsby'; Client_Name: 'Digsby'; Client_Img: '-1'), // 36
    (Client_Caps: 'http://trillian.im/caps'; Client_Name: 'Trillian'; Client_Img: '206'), // 37
    (Client_Caps: 'MobileAgent'; Client_Name: 'Mail.ru Agent'; Client_Img: '105'), // 38
    (Client_Caps: 'Slick'; Client_Name: 'Slick'; Client_Img: '-1'), // 39
    (Client_Caps: 'Siemens Native Jabber Client'; Client_Name: 'Siemens Jabber Client'; Client_Img: '-1'), // 40
    (Client_Caps: 'http://jimm.net.ru/caps'; Client_Name: 'Jimm'; Client_Img: '102'), // 41
    (Client_Caps: 'YandexMail'; Client_Name: 'Я Онлайн'; Client_Img: '-1'), // 42
    (Client_Caps: 'http://pandion.im/'; Client_Name: 'Pandion'; Client_Img: '-1'), // 43
    (Client_Caps: 'Virtus'; Client_Name: 'Virtus'; Client_Img: '-1'), // 44
    (Client_Caps: 'Mblogi.qip.ru'; Client_Name: 'Blogi QIP'; Client_Img: '-1'), // 45
    (Client_Caps: 'http://juick.com/caps'; Client_Name: 'Juick'; Client_Img: '-1'), // 46
    (Client_Caps: 'http://dev.jabbim.cz/jdisk/'; Client_Name: 'Jdisk'; Client_Img: '-1'), // 47
    (Client_Caps: 'http://vacuum-im.googlecode.com'; Client_Name: 'Vacuum IM'; Client_Img: '-1'), // 48
    (Client_Caps: 'http://2010.qip.ru/caps'; Client_Name: 'QIP 2010'; Client_Img: '103'), // 49
    (Client_Caps: 'http://imadering.com/caps'; Client_Name: 'IMadering Client'; Client_Img: '0')); // 50

{$ENDREGION}
{$REGION 'Vars'}

var
  Jabber_UseSSL: Boolean = False;
  Jabber_BuffPkt: string;
  Jabber_JID: string;
  Jabber_LoginUIN: string;
  Jabber_LoginPassword: string;
  Jabber_ChangePassword: string;
  Jabber_ServerAddr: string;
  Jabber_ServerPort: string;
  Jabber_Reconnect: Boolean = False;
  Jabber_myBeautifulSocketBuffer: string;
  Jabber_CurrentStatus: Integer = 30;
  Jabber_CurrentStatus_bac: Integer = 30;
  Jabber_Seq: Word = 0;
  JabberResurs: string = 'IMadering';
  JabberPriority: string = '30';
  // Фазы работы начало
  Jabber_Connect_Phaze: Boolean = False;
  Jabber_HTTP_Connect_Phaze: Boolean = False;
  Jabber_Work_Phaze: Boolean = False;
  Jabber_Offline_Phaze: Boolean = True;
  // Фазы работы конец
  J_SessionId: string;
  J_PassChangeId: string;
  // SSI begin
  Jab_SSI_Phaze: Boolean = False;
  Jab_Add_Contact_Phaze: Boolean = False;
  Jab_Ren_Contact_Phaze: Boolean = False;
  Jab_Dell_Contact_Phaze: Boolean = False;
  Jab_Add_JID, Jab_Add_Group_Name: string;
  Jab_Add_Group_Phaze: Boolean = False;
  Jab_Ren_Group_Phaze: Boolean = False;
  Jab_Dell_Group_Phaze: Boolean = False;
  // SSI end
  Jab_Server_Name: string;
  Jab_VJID_Server: string;
  Jab_Conference_Server: string;
  Jab_RegNewAccount: Boolean = False;
  Jab_Service_List: string;

{$ENDREGION}
{$REGION 'Procedures and Functions'}

function Jab_DigestMD5_Auth(User, Host, Password, Nonce, Cnonce: string): string;
function Jab_Plain_Auth: string;
procedure Jab_GoOffline;
function Jab_SetBind: string;
function Jab_SetSession: string;
function Jab_GetRoster: string;
function Jab_SetStatus(JStatus: Integer): string;
procedure Jab_ParseRoster(PktData: TJvSimpleXmlElem);
procedure Jab_ParseFeatures(PktData: TJvSimpleXmlElem);
procedure Jab_ParseIQ(PktData: TJvSimpleXmlElem);
procedure Jab_ParsePresence(PktData: TJvSimpleXmlElem);
procedure Jab_ParseMessage(PktData: TJvSimpleXmlElem; GJID: string = ''; GMsg: string = '');
procedure Jab_SendMessage(MType, MJID, Msg: string);
procedure Jab_GetUserInfo(MJID: string);
procedure Jab_ParseUserInfo(MJID: string; PktData: TJvSimpleXmlElem);
procedure Jab_AddContact(CJID, CNick, CGroup: string);
procedure Jab_DellContact(CJID: string);
function Jab_StatusImgId2String(ImgId: string): string;
function Jab_CreateHint(XML_Node: TJvSimpleXmlElem): string;
procedure Jab_GetServices;
procedure Jab_GetServicesInfo(SJID: string);
procedure Jab_ParseServices(PktData: TJvSimpleXmlElem);
procedure Jab_ParseServicesInfo(PktData: TJvSimpleXmlElem);
procedure Jab_Account_Delete;
procedure Jab_Account_Reg(AName, APass: string);
procedure Jab_UserSearch(S_Nick, S_Name, S_Last, S_City, S_Country, S_Email: string);
procedure Jab_ParseUsersSearch(PktData: TJvSimpleXmlElem);
procedure Jab_PassChange(NewPass: string);
procedure Jab_JoinInConf(Conf: string);

{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  OverbyteIcsMD5,
  RosterUnit,
  ContactSearchUnit;

{$ENDREGION}
{$REGION 'Jab_Plain_Auth'}

function Jab_Plain_Auth: string;
var
  Uu, Upass, Ujid, C, Buff: string;
begin
  Ujid := Jabber_JID;
  Uu := Jabber_LoginUIN;
  Upass := Jabber_LoginPassword;
  // Записываем в память параметры логина
  Buff := Ujid + ''#0 + Uu + ''#0 + Upass;
  // Кодируем в строку
  C := Base64Encode(UnicodeToAnsi(Buff, CP_UTF8));
  Result := C;
end;

{$ENDREGION}
{$REGION 'Jab_GenResponse'}

function Jab_GenResponse(UserName, Realm, Digest_uri, Pass, Nonce, Cnonce: RawByteString): string;
var
  A2, HA1, HA2, SJID, Nc, Gop: RawByteString;
  Razdel: Byte;
  Context: TMD5Context;
  DigestJID: TMD5Digest;
  DigestHA1: TMD5Digest;
  DigestHA2: TMD5Digest;
  DigestResponse: TMD5Digest;
begin
  Nc := '00000001';
  Gop := 'auth';
  Razdel := Ord(':');
  // Вычисляем А1 по формуле RFC 2831
  SJID := Format('%S:%S:%S', [UserName, Realm, Pass]);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@SJID[1]), Length(SJID));
  MD5Final(DigestJID, Context);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@DigestJID), SizeOf(TMD5Digest));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@Nonce[1]), Length(Nonce));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@Cnonce[1]), Length(Cnonce));
  MD5Final(DigestHA1, Context);
  // Вычисляем А2 по формуле RFC 2831
  A2 := Format('AUTHENTICATE:%S', [Digest_uri]);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@A2[1]), Length(A2));
  MD5Final(DigestHA2, Context);
  // Вычисляем RESPONSE по формуле RFC 2831
  HA1 := LowerCase(PacketToHex(@DigestHA1, SizeOf(TMD5Digest)));
  HA2 := LowerCase(PacketToHex(@DigestHA2, SizeOf(TMD5Digest)));
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@HA1[1]), Length(HA1));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@Nonce[1]), Length(Nonce));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@Nc[1]), Length(Nc));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@Cnonce[1]), Length(Cnonce));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@Gop[1]), Length(Gop));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@HA2[1]), Length(HA2));
  MD5Final(DigestResponse, Context);
  Result := LowerCase(PacketToHex(@DigestResponse, SizeOf(TMD5Digest)));
end;

{$ENDREGION}
{$REGION 'Jab_DigestMD5_Auth'}

function Jab_DigestMD5_Auth(User, Host, Password, Nonce, Cnonce: string): string;
var
  Str, Response: string;
begin
  { username   - имя JIDNode
    realm      - хост машины
    nonce      - уникальная строка присланная нам ранее сервером
    cnonce     - 64 бит уникальный отпечаток
    digest-uri - Название службы к которому клинт хотел бы подключится, образуется из хоста и типа протокола
    response   - пароль (Комбинация из 32 цифр HEX - вычисляется) }
  // Вычиляем пароль
  Response := Jab_GenResponse(User, Host, 'xmpp/' + Host, Password, Nonce, Cnonce);
  // Формируем строку в формате UTF-8
  Str := Format('username="%s",realm="%s",nonce="%s",cnonce="%s",nc=00000001,' //
    + 'qop=auth,digest-uri="xmpp/%s",charset=utf-8,response=%s', [User, Host, Nonce, Cnonce, Host, Response]);
  // Шифруем строку алгоритмом Base64
  Str := Base64Encode(Str);
  Result := Format('<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''>%s</response>', [Str]);
end;

{$ENDREGION}
{$REGION 'Jab_GoOffline'}

procedure Jab_GoOffline;
var
  I: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Отключаем таймер пингов
  //MainForm.UnstableJabberStatus.Checked := False;
  with MainForm.JvTimerList do
  begin
    if not Jabber_Reconnect then
      Events[9].Enabled := False;
  end;
  // Если существует форма настроек протокола Jabber, то разблокируем там контролы
  if Assigned(JabberOptionsForm) then
  begin
    with JabberOptionsForm do
    begin
      JabberJIDEdit.Enabled := True;
      JabberJIDEdit.Color := ClWindow;
      PassEdit.Enabled := True;
      PassEdit.Color := ClWindow;
      JIDonserverLabel.Enabled := True;
      RegNewAccountLabel.Enabled := True;
    end;
  end;
  // Активируем фазу оффлайн и обнуляем буферы пакетов
  Jabber_Connect_Phaze := False;
  Jabber_HTTP_Connect_Phaze := False;
  Jabber_Work_Phaze := False;
  Jabber_Offline_Phaze := True;
  Jabber_myBeautifulSocketBuffer := EmptyStr;
  Jabber_BuffPkt := EmptyStr;
  Jabber_Seq := 0;
  Jab_SSI_Phaze := False;
  Jab_Server_Name := EmptyStr;
  Jab_VJID_Server := EmptyStr;
  Jab_Conference_Server := EmptyStr;
  Jab_RegNewAccount := False;
  Jab_Service_List := EmptyStr;
  // Если сокет подключён, то отсылаем пакет "до свидания"
  with MainForm do
  begin
    if JabberWSocket.State = WsConnected then
      Jab_SendPkt(J_SessionEnd);
    // Закрываем сокет
    JabberWSocket.Abort;
    // Ставим иконку и значение статуса оффлайн
    Jabber_CurrentStatus := 30;
    JabberToolButton.ImageIndex := Jabber_CurrentStatus;
    //JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
    // Подсвечиваем в меню статуса Jabber статус оффлайн
    JabberStatusOffline.default := True;
  end;
  // Обнуляем статусы в Ростере
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Ищем раздел Jabber
        XML_Node := Root.Items.ItemNamed[C_Jabber];
        if XML_Node <> nil then
        begin
          // Ищем раздел контактов
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + 's'];
          if Sub_Node <> nil then
          begin
            for I := 0 to Sub_Node.Items.Count - 1 do
            begin
              Tri_Node := Sub_Node.Items.Item[i];
              if Tri_Node <> nil then
              begin
                if Tri_Node.Properties.Value(C_Group + C_Id) <> C_NoCL then
                begin
                  RosterUpdateProp(Tri_Node, C_Status, '30');
                  RosterUpdateProp(Tri_Node, 'X' + C_Status, '-1');
                  RosterUpdateProp(Tri_Node, 'X' + C_Status + C_Name, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_XText, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_Client, '-1');
                  RosterUpdateProp(Tri_Node, C_Client + C_Name, EmptyStr);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  // Запускаем обработку Ростера
  UpdateFullCL;
end;

{$ENDREGION}
{$REGION 'Jab_SetBind'}

function Jab_SetBind: string;
begin
  Result := Format(Iq_TypeSet, [Jabber_Seq]) + '<bind xmlns=''urn:ietf:params:xml:ns:xmpp-bind''>' + '<resource>' + JabberResurs + '</resource></bind></iq>';
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

{$ENDREGION}
{$REGION 'Jab_SetSession'}

function Jab_SetSession: string;
begin
  Result := Format(Iq_TypeSet, [Jabber_Seq]) + '<session xmlns=''urn:ietf:params:xml:ns:xmpp-session''/>' + '</iq>';
  // Запоминаем Id для запроса сессии (google talk)
  J_SessionId := IntToStr(Jabber_Seq);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

{$ENDREGION}
{$REGION 'Jab_GetRoster'}

function Jab_GetRoster: string;
begin
  Result := Format(Iq_TypeGet, [Jabber_Seq]) + '<query xmlns=''jabber:iq:roster''/></iq>';
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

{$ENDREGION}
{$REGION 'Jab_SetStatus'}

function Jab_SetStatus(JStatus: Integer): string;
var
  St: string;
begin
  // Формируем статус строку
  case JStatus of
    29: St := '<show>away</show>';
    32: St := '<show>dnd</show><x xmlns=''qip:x:status'' value=''8''/>';
    33: St := '<show>dnd</show>';
    34: St := '<show>xa</show>';
    35: St := '<show>away</show><x xmlns=''qip:x:status'' value=''10''/>';
    36: St := '<show>chat</show>';
    37: St := '<x xmlns=''qip:x:status'' value=''5''/>';
    38: St := '<x xmlns=''qip:x:status'' value=''4''/>';
    39: St := '<x xmlns=''qip:x:status'' value=''6''/>';
    40: St := '<x xmlns=''qip:x:status'' value=''7''/>';
  else
    St := '';
  end;
  // Формируем пакет
  Result := '<presence><priority>' + JabberPriority + '</priority>' + '<c xmlns=''http://jabber.org/protocol/caps'' node=''http://imadering.com/caps'' ver=''0.5.0.0''/>' + St + '</presence>';
end;

{$ENDREGION}
{$REGION 'Jab_ParseRoster'}

procedure Jab_ParseRoster(PktData: TJvSimpleXmlElem);
label
  X;
var
  Cnt, I: Integer;
  Item_Node, XML_Node, Sub_Node, Tri_Node, Group_Node: TJvSimpleXmlElem;
  JID, Nick, Group: string;
begin
  // Начинаем добаление записей контактов в Ростер
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Если это фаза работы с серверным КЛ
        if Jab_SSI_Phaze then
        begin
          // Если это фаза добавления контакта
          if Jab_Add_Contact_Phaze then
          begin
            Jab_Add_Contact_Phaze := False;
            // Сообщаем об успешном добавлении контакта
            DAShow(Lang_Vars[16].L_S + ' ' + C_Jabber, Lang_Vars[107].L_S, EmptyStr, 133, 3, 0);
            // Добавляем контакт в Ростер
            goto X;
          end
          else if Jab_Dell_Contact_Phaze then
          begin
            Jab_Dell_Contact_Phaze := False;
            // Сообщаем об успешном удалении контакта
            DAShow(Lang_Vars[16].L_S + ' ' + C_Jabber, Lang_Vars[162].L_S, EmptyStr, 133, 3, 0);
          end
          else if Jab_Dell_Group_Phaze then
          begin
            Jab_Dell_Group_Phaze := False;
            // Сообщаем об успешном удалении группы
            DAShow(Lang_Vars[16].L_S + ' ' + C_Jabber, Lang_Vars[100].L_S, EmptyStr, 133, 3, 0);
          end;
          // Закрываем сесиию работы с серверным КЛ
          Jab_SSI_Phaze := False;
        end
        else
        begin
          X: ;
          // Открываем раздел Jabber если он есть
          XML_Node := Root.Items.ItemNamed[C_Jabber];
          // Добавляем раздел групп
          Sub_Node := XML_Node.Items.ItemNamed[C_Group + 's'];
          if Sub_Node = nil then
            Sub_Node := XML_Node.Items.Add(C_Group + 's');
          // Добавляем группу контактов с ошибочным идентификатором группы
          Tri_Node := Sub_Node.Items.ItemNamed[C_Group + '_' + C_AuthNone];
          if Tri_Node = nil then
          begin
            Tri_Node := Sub_Node.Items.Add(C_Group + '_' + C_AuthNone);
            Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[7].L_S));
            Tri_Node.Properties.Add(C_Id, C_AuthNone);
          end;
          // Открываем раздел контактов
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + 's'];
          // Получаем количество записей с контактами
          Cnt := PktData.Items.Count;
          // Разбираем список контактов в пакете
          for I := 0 to Cnt - 1 do
          begin
            Item_Node := PktData.Items[I];
            if Item_Node <> nil then
            begin
              // Если это не удаление записи на сервере
              if Item_Node.Properties.Value('subscription') <> 'remove' then
              begin
                // Логин контакта
                Tri_Node := Sub_Node.Items.Add(C_Contact + '_' + IntToStr(I));
                JID := UTF8ToString(Item_Node.Properties.Value('jid'));
                Tri_Node.Properties.Add(C_Login, URLEncode(JID));
                // Ник контакта
                Nick := XML2Text(UTF8ToString(Item_Node.Properties.Value('name')));
                if Nick = EmptyStr then
                  Nick := JID;
                Tri_Node.Properties.Add(C_Nick, URLEncode(Nick));
                // Авторизация
                Tri_Node.Properties.Add(C_Auth, Item_Node.Properties.Value('subscription'));
                // Группа контакта
                Group := EmptyStr;
                Group_Node := Item_Node.Items.ItemNamed['group'];
                if Group_Node <> nil then
                begin
                  Group := XML2Text(UTF8ToString(Group_Node.Value));
                  Tri_Node.Properties.Add(C_Group + C_Id, URLEncode(Group));
                end;
                if Group = EmptyStr then
                  Tri_Node.Properties.Add(C_Group + C_Id, C_AuthNone);
                // Начальный статус
                Tri_Node.Properties.Add(C_Status, 30);
              end;
            end;
          end;
          // Запускаем обработку Ростера
          V_CollapseGroupsRestore := True;
          UpdateFullCL;
        end;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'Jab_ParseFeatures'}

procedure Jab_ParseFeatures(PktData: TJvSimpleXmlElem);
var
  XML_Node: TJvSimpleXmlElem;
begin
  // Ищем бинд
  XML_Node := PktData.Items.ItemNamed['bind'];
  if XML_Node <> nil then
    Jab_SendPkt(Jab_SetBind);
  // Ищем сессию
  XML_Node := PktData.Items.ItemNamed[J_Session];
  if XML_Node <> nil then
    Jab_SendPkt(Jab_SetSession);
end;

{$ENDREGION}
{$REGION 'Jab_ParseIQ'}

procedure Jab_ParseIQ(PktData: TJvSimpleXmlElem);
var
  XML_Node: TJvSimpleXmlElem;
  FJID, QueryTLV: string;

  procedure GetOnlineParams;
  begin
    // Запрашиваем список контактов
    Jab_SendPkt(Jab_GetRoster);
    // Устанавливаем статус
    Jab_SendPkt(Jab_SetStatus(Jabber_CurrentStatus));
    // Запрашиваем свою инфу
    Jab_GetUserInfo(Jabber_JID);
    // Запрашиваем список сервисов сервера
    Jab_GetServices;
  end;

begin
  if PktData <> nil then
  begin
    // Если къюри :)
    XML_Node := PktData.Items.ItemNamed[J_Query];
    if XML_Node <> nil then
    begin
      QueryTLV := XML_Node.Properties.Value('xmlns');
      if QueryTLV = Iq_Roster then // Если это список контактов
        Jab_ParseRoster(XML_Node)
      else if QueryTLV = 'http://jabber.org/protocol/disco#items' then
        Jab_ParseServices(XML_Node)
      else if QueryTLV = 'http://jabber.org/protocol/disco#info' then
        Jab_ParseServicesInfo(PktData)
      else if QueryTLV = 'jabber:iq:search' then
        Jab_ParseUsersSearch(XML_Node)
      else if QueryTLV = 'jabber:iq:register' then
        if PktData.Properties.Value('id') = J_PassChangeId then
        begin
          Jabber_LoginPassword := Jabber_ChangePassword;
          // Информируем об успешной смене пароля
          DAShow(Lang_Vars[16].L_S + ' ' + C_Jabber, Format(Lang_Vars[30].L_S, ['JID' + ':' + ' ' + Jabber_JID]), EmptyStr, 133, 3, 0);
        end;
      Exit;
    end;
    // Если это информация о контакте
    XML_Node := PktData.Items.ItemNamed['vCard'];
    if XML_Node <> nil then
    begin
      FJID := PktData.Properties.Value(J_From);
      // Отделяем ресурс
      if Pos('/', FJID) > 0 then
        FJID := Parse('/', FJID, 1);
      Jab_ParseUserInfo(FJID, XML_Node);
      Exit;
    end;
    // Если сессия открылась
    XML_Node := PktData.Items.ItemNamed[J_Session];
    if XML_Node <> nil then
    begin
      GetOnlineParams;
      // Выходим
      Exit;
    end;
    // Такое можно было ожидать только от google talk
    if (PktData.Properties.Value('type') = 'result') and (PktData.Properties.Value('id') = J_SessionId) then
      GetOnlineParams;
  end;
end;

{$ENDREGION}
{$REGION 'Jab_SendMessage'}

procedure Jab_SendMessage(MType, MJID, Msg: string);
var
  M: string;
begin
  // Отправляем сообщение для jabber контакта
  M := Format(J_MessHead, [MType, MJID, Jabber_Seq]) + '<body>' + Text2XML(Msg) + '</body></message>';
  Jab_SendPkt(M);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

{$ENDREGION}
{$REGION 'Jab_ParsePresence'}

procedure Jab_ParsePresence(PktData: TJvSimpleXmlElem);
var
  V: Integer;
  PJID, KStatus, KClient_Icon, KClient_Name, KLogin, KResurs: string;
  XML_Node, Get_Node: TJvSimpleXmlElem;
begin
  PJID := WideLowerCase(UTF8ToString(PktData.Properties.Value(J_From)));
  if PJID <> EmptyStr then
  begin
    // Определяем пресед конференции это или нет
    XML_Node := PktData.Items.ItemNamed['X'];
    if XML_Node <> nil then
    begin
      if XML_Node.Properties.Value('xmlns') = 'http://jabber.org/protocol/muc#user' then
      begin

        Exit;
      end;
    end;
    // Отделяем ресурс
    if Pos('/', PJID) > 0 then
    begin
      KLogin := Parse('/', PJID, 1);
      KResurs := Parse('/', PJID, 2);
    end
    else
      KLogin := PJID;
    // Оффлайн статус или нет
    KStatus := '28';
    if WideLowerCase(PktData.Properties.Value(C_Type)) = 'unavailable' then
      KStatus := '30';
    // Определяем клиент
    KClient_Name := EmptyStr;
    KClient_Icon := '-1';
    XML_Node := PktData.Items.ItemNamed['c'];
    if XML_Node <> nil then
    begin
      KClient_Name := XML_Node.Properties.Value('node');
      for V := Low(J_Client_Icons) to High(J_Client_Icons) do
      begin
        if Pos(J_Client_Icons[V].Client_Caps, KClient_Name) > 0 then
        begin
          KClient_Name := J_Client_Icons[V].Client_Name;
          KClient_Icon := J_Client_Icons[V].Client_Img;
          Break;
        end;
      end;
    end;
    // Обновляем параметры этого контакта в Ростере
    Get_Node := RosterGetItem(C_Jabber, C_Contact + 's', C_Login, URLEncode(KLogin));
    if Get_Node <> nil then
    begin
      RosterUpdateProp(Get_Node, C_Status, KStatus);
      //RosterUpdateProp(Get_Node, C_XStatus + C_Name, XStatusCode);
      //RosterUpdateProp(Get_Node, C_XStatus, KXStatus);
      //RosterUpdateProp(Get_Node, C_XText, URLEncode(XStatusText));
      RosterUpdateProp(Get_Node, C_Client + C_Name, URLEncode(KClient_Name));
      RosterUpdateProp(Get_Node, C_Client, KClient_Icon);
    end;
    // Запускаем обработку КЛ
    MainForm.JvTimerList.Events[11].Enabled := False;
    MainForm.JvTimerList.Events[11].Enabled := True;
  end;
end;

{$ENDREGION}
{$REGION 'Jab_ParseMessage'}

procedure Jab_ParseMessage(PktData: TJvSimpleXmlElem; GJID: string = ''; GMsg: string = '');
label
  X;
var
  PJID, Nick, Mess, MsgD, PopMsg, HistoryFile: string;
  I: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Contact_Yes: Boolean;
  GtransMsg: Boolean;
  JvXML: TJvSimpleXml;
begin
  GtransMsg := False;
  // Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    Application.CreateForm(TChatForm, ChatForm);
  // Если это сообщение с переводом, то переходим дальше
  if (GJID <> EmptyStr) and (GMsg <> EmptyStr) then
  begin
    PJID := GJID;
    Mess := GMsg;
    goto X;
  end;
  // Получаем логин от кого пришло сообщение
  PJID := WideLowerCase(UTF8ToString(PktData.Properties.Value(J_From)));
  // Получаем текст сообщения
  XML_Node := PktData.Items.ItemNamed['body'];
  if XML_Node <> nil then
    Mess := UTF8ToString(XML_Node.Value);
  // Обрабатываем сообщение и отображаем
  if (PJID <> EmptyStr) and (Mess <> EmptyStr) then
  begin
    // Отделяем ресурс
    if Pos('/', PJID) > 0 then
      PJID := Parse('/', PJID, 1);


    // Если это сообщение конференции
    if PktData.Properties.Value('type') = J_GroupChatType then
    begin

      Exit;
    end;


    // Если для этого контакта активна функция перевода, то отправляем сообщение в список буфера для автоматического перевода
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + C_Jabber + ' ' + PJID + C_XML_Ext) then
        begin
          LoadFromFile(V_ProfilePath + C_AnketaFolder + C_Jabber + ' ' + PJID + C_XML_Ext);
          if Root <> nil then
          begin
            XML_Node := Root.Items.ItemNamed[C_Gtrans];
            if XML_Node <> nil then
              GtransMsg := XML_Node.BoolValue;
          end;
        end;
      end;
    finally
      JvXML.Free;
    end;
    if GtransMsg then
    begin
      {if not Assigned(GTransForm) then
        Application.CreateForm(TGTransForm, GTransForm);
      with GTransForm.GtransListView.Items.Add do
      begin
        // Изменяем направление перевода для исходящих и входящих сообщений
        ImageIndex := 213;
        SubItems.Add(PJID);
        SubItems.Add(Mess);
        SubItems.Add(C_Jabber);
      end;}
      // Выходим
      Exit;
    end;
    // Форматируем сообщение
    X: ;
    CheckMessage_BR(Mess);
    CheckMessage_ClearTag(Mess);
    PopMsg := Mess;
    // Ищем этот контакт в Ростере
    Contact_Yes := False;
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          // Ищем раздел Jabber
          XML_Node := Root.Items.ItemNamed[C_Jabber];
          if XML_Node <> nil then
          begin
            // Открываем раздел групп
            Sub_Node := XML_Node.Items.ItemNamed[C_Group + 's'];
            if Sub_Node = nil then
              Sub_Node := XML_Node.Items.Add(C_Group + 's');
            // Добавляем группу для контактов "не в списке"
            Tri_Node := Sub_Node.Items.ItemNamed[C_Group + '_' + C_NoCL];
            if Tri_Node = nil then
            begin
              Tri_Node := Sub_Node.Items.Add(C_Group + '_' + C_NoCL);
              Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[33].L_S));
              Tri_Node.Properties.Add(C_Id, C_NoCL);
            end;
            // Ищем раздел контактов
            Sub_Node := XML_Node.Items.ItemNamed[C_Contact + 's'];
            if Sub_Node <> nil then
            begin
              for I := 0 to Sub_Node.Items.Count - 1 do
              begin
                Tri_Node := Sub_Node.Items.Item[i];
                if Tri_Node <> nil then
                begin
                  // Если нашли этот контакт
                  if Tri_Node.Properties.Value(C_Login) = UrlEncode(PJID) then
                  begin
                    Contact_Yes := True;
                    // Записываем входяшее сообщение
                    RosterUpdateProp(Tri_Node, C_InMess, UrlEncode(Mess));
                    // Ник контакта из Ростера
                    Nick := URLDecode(Tri_Node.Properties.Value(C_Nick));
                    // Дата сообщения
                    MsgD := Nick + ' ' + '[' + DateTimeChatMess + ']';
                    // Ставим метку о непрочитанном сообщении
                    RosterUpdateProp(Tri_Node, C_Mess, 'X');
                    // Прерываем цикл
                    Break;
                  end;
                end;
              end;
              // Если контакт в Ростере не нашли
              if not Contact_Yes then
              begin
                // Ищем его Ник в файле-кэше ников
                Nick := SearchNickInCash(C_Jabber, PJID);
                // Дата сообщения
                MsgD := Nick + ' ' + '[' + DateTimeChatMess + ']';
                // Добавляем этот контакт в эту группу
                Tri_Node := Sub_Node.Items.Add(C_Contact + '_' + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(PJID));
                Tri_Node.Properties.Add(C_Group + C_Id, C_NoCL);
                Tri_Node.Properties.Add(C_Status, 42);
                Tri_Node.Properties.Add(C_Nick, URLEncode(Nick));
                Tri_Node.Properties.Add(C_InMess, UrlEncode(Mess));
                Tri_Node.Properties.Add(C_Mess, 'X');
              end;
              // Записываем история в файл истории с этим контактом
              ForceDirectories(V_ProfilePath + C_HistoryFolder + C_Jabber + '\' + Jabber_JID + '\');
              HistoryFile := V_ProfilePath + C_HistoryFolder + C_Jabber + '\' + Jabber_JID + '\' + PJID + C_Htm_Ext;
              Mess := Text2XML(Mess);
              CheckMessage_BR(Mess);
              DecorateURL(Mess);
              SaveTextInHistory(Format(C_HistoryIn, [MsgD, Mess]), HistoryFile);
              // Добавляем сообщение в текущий чат
              if not ChatForm.AddMessInActiveChat(Nick, PopMsg, UrlEncode(PJID), MsgD, Mess) then
                UpdateFullCL
              else
              begin
                // Снимаем метку о непрочитанном сообщении
                if Tri_Node <> nil then
                  RosterUpdateProp(Tri_Node, C_Mess, EmptyStr);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'Jab_GetUserInfo'}

procedure Jab_GetUserInfo(MJID: string);
var
  P: string;
begin
  // Запрашиваем информацию о контакте
  P := Format(J_GetInfoHead, [MJID, Jabber_Seq]);
  Jab_SendPkt(P);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

{$ENDREGION}
{$REGION 'Jab_ParseUserInfo'}

procedure Jab_ParseUserInfo(MJID: string; PktData: TJvSimpleXmlElem);
const
  T1 = '.';
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
  Nick, First, Last, Gender, HomePage, Address1, Address2, BirgDate: string;
  City, State, Zip, Country, WCity, WState, WZip, WAddress1, WAddress2: string;
  Company, Department, Position, WCountry, Occupation, About: string;
  Email, Email1, Email2, Email3, FullName, ImageType: string;
  Phone1, Phone2, Phone3, Phone4, Phone5: string;
  I, Age, IDay, IMonth, IYear: Integer;
  ImageData: TMemoryStream;
  Photo: AnsiString;
begin
  Gender := '0';
  IDay := 0;
  IMonth := 0;
  IYear := 0;
  Age := 0;
  // Разбираем и записываем информацию о контакте
  for I := 0 to PktData.Items.Count - 1 do
  begin
    XML_Node := PktData.Items[I];
    if XML_Node <> nil then
    begin
      // <FN>
      if XML_Node.FullName = Node_FN then
      begin
        FullName := Utf8ToString(XML_Node.Value);
        Continue;
      end;
      // <N>
      if XML_Node.FullName = Node_N then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_GIVEN];
        if Sub_Node <> nil then
          First := Utf8ToString(Sub_Node.Value);
        Sub_Node := XML_Node.Items.ItemNamed[Node_FAMILY];
        if Sub_Node <> nil then
          Last := Utf8ToString(Sub_Node.Value);
        Continue;
      end;
      // <NICKNAME>
      if XML_Node.FullName = Node_NICKNAME then
      begin
        Nick := Utf8ToString(XML_Node.Value);
        Continue;
      end;
      // <BDAY>
      if XML_Node.FullName = Node_BDAY then
      begin
        BirgDate := Utf8ToString(XML_Node.Value);
        BirgDate := ReplaceStr(BirgDate, '-', T1);
        // Разбираем дату
        if Pos(T1, BirgDate) > 0 then
        begin
          IDay := StrToInt(NormalizeIcqNumber(Parse(T1, BirgDate, 1)));
          if IDay > 999 then
          begin
            IYear := IDay;
            IMonth := StrToInt(NormalizeIcqNumber(Parse(T1, BirgDate, 2)));
            IDay := StrToInt(NormalizeIcqNumber(Parse(T1, BirgDate, 3)));
          end
          else
          begin
            IMonth := StrToInt(NormalizeIcqNumber(Parse(T1, BirgDate, 2)));
            IYear := StrToInt(NormalizeIcqNumber(Parse(T1, BirgDate, 3)));
          end;
        end;
        // Вычисляем возраст
        if (IDay <> 0) and (IMonth <> 0) and (IYear <> 0) then
          Age := CalculateAge(EncodeDate(IYear, IMonth, IDay), Date);
        Continue;
      end;
      // <GENDER>
      if XML_Node.FullName = Node_GENDER then
      begin
        Gender := Utf8ToString(XML_Node.Value);
        if Gender = 'Female' then
          Gender := '1'
        else if Gender = 'Male' then
          Gender := '2'
        else
          Gender := '0';
        Continue;
      end;
      // <EMAIL>
      if XML_Node.FullName = Node_EMAIL then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_USERID];
        if Sub_Node <> nil then
        begin
          if Email = EmptyStr then
            Email := Utf8ToString(Sub_Node.Value)
          else if Email1 = EmptyStr then
            Email1 := Utf8ToString(Sub_Node.Value)
          else if Email2 = EmptyStr then
            Email2 := Utf8ToString(Sub_Node.Value)
          else if Email3 = EmptyStr then
            Email3 := Utf8ToString(Sub_Node.Value);
        end;
        Continue;
      end;
      // <ADR> <HOME/>
      if XML_Node.FullName = Node_ADR then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_HOME];
        if Sub_Node <> nil then
        begin
          Sub_Node := XML_Node.Items.ItemNamed[Node_STREET];
          if Sub_Node <> nil then
            Address1 := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_EXTADR];
          if Sub_Node <> nil then
            Address2 := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_LOCALITY];
          if Sub_Node <> nil then
            City := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_REGION];
          if Sub_Node <> nil then
            State := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_PCODE];
          if Sub_Node <> nil then
            Zip := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_COUNTRY];
          if Sub_Node <> nil then
            Country := Utf8ToString(Sub_Node.Value);
          Continue;
        end;
      end;
      // <ADR> <WORK/>
      if XML_Node.FullName = Node_ADR then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_WORK];
        if Sub_Node <> nil then
        begin
          Sub_Node := XML_Node.Items.ItemNamed[Node_STREET];
          if Sub_Node <> nil then
            WAddress1 := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_EXTADR];
          if Sub_Node <> nil then
            WAddress2 := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_LOCALITY];
          if Sub_Node <> nil then
            WCity := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_REGION];
          if Sub_Node <> nil then
            WState := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_PCODE];
          if Sub_Node <> nil then
            WZip := Utf8ToString(Sub_Node.Value);
          Sub_Node := XML_Node.Items.ItemNamed[Node_COUNTRY];
          if Sub_Node <> nil then
            WCountry := Utf8ToString(Sub_Node.Value);
          Continue;
        end;
      end;
      // <ORG>
      if XML_Node.FullName = Node_ORG then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_ORGNAME];
        if Sub_Node <> nil then
          Company := Utf8ToString(Sub_Node.Value);
        Sub_Node := XML_Node.Items.ItemNamed[Node_ORGUNIT];
        if Sub_Node <> nil then
          Department := Utf8ToString(Sub_Node.Value);
        Continue;
      end;
      // <TITLE>
      if XML_Node.FullName = Node_TITLE then
      begin
        Position := Utf8ToString(XML_Node.Value);
        Continue;
      end;
      // <ROLE>
      if XML_Node.FullName = Node_ROLE then
      begin
        Occupation := Utf8ToString(XML_Node.Value);
        Continue;
      end;
      // <URL>
      if XML_Node.FullName = Node_URL then
      begin
        HomePage := Utf8ToString(XML_Node.Value);
        Continue;
      end;
      // <DESC>
      if XML_Node.FullName = Node_DESC then
      begin
        About := Utf8ToString(XML_Node.Value);
        Continue;
      end;
      // <TEL>
      if XML_Node.FullName = Node_TEL then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_NUMBER];
        if Sub_Node <> nil then
        begin
          if Phone1 = EmptyStr then
            Phone1 := Utf8ToString(Sub_Node.Value)
          else if Phone2 = EmptyStr then
            Phone2 := Utf8ToString(Sub_Node.Value)
          else if Phone3 = EmptyStr then
            Phone3 := Utf8ToString(Sub_Node.Value)
          else if Phone4 = EmptyStr then
            Phone4 := Utf8ToString(Sub_Node.Value)
          else if Phone5 = EmptyStr then
            Phone5 := Utf8ToString(Sub_Node.Value);
        end;
        Continue;
      end;
      // <PHOTO>
      if XML_Node.FullName = Node_PHOTO then
      begin
        Sub_Node := XML_Node.Items.ItemNamed[Node_BINVAL];
        if Sub_Node <> nil then
        begin
          Photo := Base64Decode(Sub_Node.Value);
          ImageData := TMemoryStream.Create;
          try
            ImageData.Write(Photo[1], Length(Photo));
            ImageType := Text2Hex(LeftStr(Photo, 2));
            if ImageType = 'FFD8' then
              ImageData.SaveToFile(V_ProfilePath + C_AvatarFolder + C_Jabber + ' ' + MJID + C_JPG_Ext)
            else if ImageType = '4749' then
              ImageData.SaveToFile(V_ProfilePath + C_AvatarFolder + C_Jabber + ' ' + MJID + C_GIF_Ext)
            else if ImageType = '424D' then
              ImageData.SaveToFile(V_ProfilePath + C_AvatarFolder + C_Jabber + ' ' + MJID + C_BMP_Ext)
            else if ImageType = '8950' then
              ImageData.SaveToFile(V_ProfilePath + C_AvatarFolder + C_Jabber + ' ' + MJID + C_PNG_Ext);
          finally
            ImageData.Free;
          end;
        end;
        Continue;
      end;
    end;
  end;
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем файл и инфой о контакте
      if FileExists(V_ProfilePath + C_AnketaFolder + C_Jabber + ' ' + MJID + C_XML_Ext) then
        LoadFromFile(V_ProfilePath + C_AnketaFolder + C_Jabber + ' ' + MJID + C_XML_Ext);
      if Root <> nil then
      begin
        // Очищаем раздел инфы контакта
        XML_Node := Root.Items.ItemNamed[C_Infos];
        if XML_Node = nil then
          XML_Node := Root.Items.Add(C_Infos);
        XML_Node.Clear;
        // Записываем имена ----------------------------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_NameInfo);
        Sub_Node.Properties.Add(C_Nick, URLEncode(Nick));
        Sub_Node.Properties.Add(C_Name, URLEncode(FullName));
        Sub_Node.Properties.Add(C_First, URLEncode(First));
        Sub_Node.Properties.Add(C_Last, URLEncode(Last));
        // Записываем персональную информацию ----------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_PerInfo);
        Sub_Node.Properties.Add(C_HomePage, URLEncode(HomePage));
        Sub_Node.Properties.Add(C_Gender, Gender);
        // Записываем место проживания ----------------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_HomeInfo);
        Sub_Node.Properties.Add(C_Address, URLEncode(Address1 + ' ' + Address2));
        Sub_Node.Properties.Add(C_City, URLEncode(City));
        Sub_Node.Properties.Add(C_State, URLEncode(State));
        Sub_Node.Properties.Add(C_Zip, URLEncode(Zip));
        Sub_Node.Properties.Add(C_Country, URLEncode(Country));
        // Записываем телефоны -------------------------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_PhoneInfo);
        Sub_Node.Properties.Add(C_Phone + '1', URLEncode(Phone1));
        Sub_Node.Properties.Add(C_Phone + '2', URLEncode(Phone2));
        Sub_Node.Properties.Add(C_Phone + '3', URLEncode(Phone3));
        Sub_Node.Properties.Add(C_Phone + '4', URLEncode(Phone4));
        Sub_Node.Properties.Add(C_Phone + '5', URLEncode(Phone5));
        // Записываем инфу о работе --------------------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_WorkInfo);
        Sub_Node.Properties.Add(C_City, URLEncode(WCity));
        Sub_Node.Properties.Add(C_State, URLEncode(WState));
        Sub_Node.Properties.Add(C_Zip, URLEncode(WZip));
        Sub_Node.Properties.Add(C_Address, URLEncode(WAddress1 + ' ' + WAddress2));
        Sub_Node.Properties.Add(C_Corp, URLEncode(Company));
        Sub_Node.Properties.Add(C_Dep, URLEncode(Department));
        Sub_Node.Properties.Add(C_Prof, URLEncode(Position));
        Sub_Node.Properties.Add(C_Country, URLEncode(WCountry));
        Sub_Node.Properties.Add(C_Occup, URLEncode(Occupation));
        // Записываем "О себе" -------------------------------------------------------------
        XML_Node.Items.Add(C_AboutInfo, URLEncode(About));
        // Записываем дату рождения --------------------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_AgeInfo);
        Sub_Node.Properties.Add(C_Age, Age);
        Sub_Node.Properties.Add(C_Day, IDay);
        Sub_Node.Properties.Add(C_Month, IMonth);
        Sub_Node.Properties.Add(C_Year, IYear);
        // Записываем Email адреса ---------------------------------------------------------
        Sub_Node := XML_Node.Items.Add(C_EmailsInfo);
        Sub_Node.Properties.Add(C_Email + '0', URLEncode(Email));
        Sub_Node.Properties.Add(C_Email + '1', URLEncode(Email1));
        Sub_Node.Properties.Add(C_Email + '2', URLEncode(Email2));
        Sub_Node.Properties.Add(C_Email + '3', URLEncode(Email3));
      end;
      // Создаём необходимые папки
      ForceDirectories(V_ProfilePath + C_AnketaFolder);
      // Записываем сам файл
      SaveToFile(V_ProfilePath + C_AnketaFolder + C_Jabber + ' ' + MJID + C_XML_Ext);
    end;
  finally
    JvXML.Free;
  end;
  // Отображаем в окне информации о контакте полученные данные
  if Assigned(ContactInfoForm) then
  begin
    if ContactInfoForm.ReqUIN = MJID then
      ContactInfoForm.LoadUserUnfo;
  end;
end;
{$ENDREGION}
{$REGION 'Jab_AddContact'}

procedure Jab_AddContact(CJID, CNick, CGroup: string);
var
  Pkt: string;
begin
  // Добавляем контакт
  Pkt := Format(Iq_TypeSet, [Jabber_Seq]) + '<query xmlns=''' + Iq_Roster + '''>' //
  + '<item jid=''' + CJID + ''' name=''' + CNick + '''><group>' + CGroup + '</group></item></query></iq>';
  Jab_SendPkt(Pkt);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
  // Запрашиваем авторизацию
  Pkt := '<presence to=''' + CJID + ''' type=''subscribe''/>';
  Jab_SendPkt(Pkt);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_DellContact'}

procedure Jab_DellContact(CJID: string);
var
  Pkt: string;
begin
  // Удаляем контакт
  Pkt := Format(Iq_TypeSet, [Jabber_Seq]) + '<query xmlns=''' + Iq_Roster + '''>' //
  + '<item jid=''' + CJID + ''' subscription=''remove'' /></query></iq>';
  Jab_SendPkt(Pkt);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_StatusImgId2String'}

function Jab_StatusImgId2String(ImgId: string): string;
begin
  // Распознаём текст статуса из картинки
  Result := Lang_Vars[81].L_S;
  if ImgId = '36' then
    Result := Lang_Vars[67].L_S
  else if ImgId = '38' then
    Result := Lang_Vars[68].L_S
  else if ImgId = '37' then
    Result := Lang_Vars[69].L_S
  else if ImgId = '39' then
    Result := Lang_Vars[70].L_S
  else if ImgId = '40' then
    Result := Lang_Vars[71].L_S
  else if ImgId = '35' then
    Result := Lang_Vars[72].L_S
  else if ImgId = '29' then
    Result := Lang_Vars[73].L_S
  else if ImgId = '34' then
    Result := Lang_Vars[74].L_S
  else if ImgId = '32' then
    Result := Lang_Vars[75].L_S
  else if ImgId = '33' then
    Result := Lang_Vars[76].L_S
  else if ImgId = '28' then
    Result := Lang_Vars[77].L_S
  else if ImgId = '31' then
    Result := Lang_Vars[78].L_S
  else if ImgId = '30' then
    Result := Lang_Vars[80].L_S
  else if ImgId = '42' then
    Result := Lang_Vars[81].L_S;
end;

{$ENDREGION}
{$REGION 'Jab_CreateHint'}

function Jab_CreateHint(XML_Node: TJvSimpleXmlElem): string;
var
  XText: string;
begin
  // Формируем всплывающую подсказку для контакта Jabber
  if XML_Node <> nil then
  begin
    // Учётная запись
    Result := Format(C_AS, ['JID' + ':' + ' ' + URLDecode(XML_Node.Properties.Value(C_Login))]);
    // Ник
    if XML_Node.Properties.Value(C_Nick) <> XML_Node.Properties.Value(C_Login) then
      Result := Result + C_BR + Format(C_AS, [URLDecode(XML_Node.Properties.Value(C_Nick))]);
    Result := Result + C_BR;
    // Статус
    if XML_Node.Properties.Value(C_Client) = '220' then // Если статус требует авторизации, то пишем об этом
      Result := Result + Lang_Vars[47].L_S + ':' + ' ' + C_HTML_Font_Red + Lang_Vars[82].L_S
    else if (XML_Node.Properties.Value(C_Status) = '30') then // Если статус "Не в сети"
      Result := Result + Lang_Vars[47].L_S + ':' + ' ' + C_HTML_Font_Red + MainForm.JabberStatusOffline.Caption
    else // Определяем статус и пишем его словами
      Result := Result + Lang_Vars[47].L_S + ':' + ' ' + C_HTML_Font_Blue + Jab_StatusImgId2String(XML_Node.Properties.Value(C_Status));
    Result := Result + C_HTML_Font_End;
    // Если есть текст доп. статуса, то пишем его
    if XML_Node.Properties.Value(C_XText) <> EmptyStr then
    begin
      XText := URLDecode(XML_Node.Properties.Value(C_XText));
      if Length(XText) > 30 then
        XText := Copy(XText, 1, 30) + '...';
      Result := Result + C_BR + C_HTML_Font_Red + XText + C_HTML_Font_End;
    end;
    // Клиент
    if XML_Node.Properties.Value(C_Client + C_Name) <> EmptyStr then
      Result := Result + C_BR + Lang_Vars[38].L_S + ':' + ' ' + URLDecode(XML_Node.Properties.Value(C_Client + C_Name));
  end;
end;

{$ENDREGION}
{$REGION 'Jab_GetServises'}

procedure Jab_GetServices;
var
  P: string;
begin
  // Запрашиваем сервисы сервера
  P := Format(J_GetServices, [Parse('@', Jabber_JID, 2), Jabber_Seq]);
  Jab_SendPkt(P);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_GetServicesInfo'}

procedure Jab_GetServicesInfo(SJID: string);
var
  P: string;
begin
  // Запрос информации о сервисе
  // Запрашиваем сервисы сервера
  P := Format(J_GetServicesInfo, [SJID, Jabber_Seq]);
  Jab_SendPkt(P);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_ParseServices'}

procedure Jab_ParseServices(PktData: TJvSimpleXmlElem);
var
  I: Integer;
  XML_Node: TJvSimpleXmlElem;
begin
  // Разбираем сервисы поддерживаемые сервером
  if PktData <> nil then
  begin
    for I := 0 to PktData.Items.Count - 1 do
    begin
      XML_Node := PktData.Items[I];
      if XML_Node <> nil then
        Jab_GetServicesInfo(XML_Node.Properties.Value('jid'));
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Jab_ParseServicesInfo'}

procedure Jab_ParseServicesInfo(PktData: TJvSimpleXmlElem);
var
  XML_Node, Sub_Node: TJvSimpleXmlElem;
  Cat, SJID, T: string;
begin
  // Разбираем информацию о сервисе
  if PktData <> nil then
  begin
    SJID := PktData.Properties.Value('from');
    XML_Node := PktData.Items.ItemNamed[J_Query];
    if XML_Node <> nil then
    begin
      Sub_Node := XML_Node.Items.ItemNamed['identity'];
      if Sub_Node <> nil then
      begin
        Cat := Sub_Node.Properties.Value('category');
        T := Sub_Node.Properties.Value('type');
        Jab_Service_List := Jab_Service_List + SJID + ' ' + '-' + ' ' + UTF8ToString(Sub_Node.Properties.Value('name')) + C_RN;
        if (Cat = 'directory') and (T = 'user') then // Адрес сервиса для поиска контактов
          Jab_VJID_Server := SJID
        else if (Cat = 'conference') and (T = 'text') then // Адрес сервиса конференций
          Jab_Conference_Server := SJID;
      end;
    end;
    // Обновляем параметры в списке
    JabberOptionsForm.SetOnlineVars;
  end;
end;
{$ENDREGION}
{$REGION 'Jab_Account_Delete'}

procedure Jab_Account_Delete;
var
  P: string;
begin
  // Посылаем пакет удаления аккаунта
  P := Format(J_DellAccount, [Jabber_JID, Jabber_Seq]);
  Jab_SendPkt(P);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_Account_Reg'}

procedure Jab_Account_Reg(AName, APass: string);
var
  P: string;
begin
  // Посылаем пакет регистрации аккаунта
  P := Format(J_RegAccount, [Jabber_Seq, AName, APass]);
  Jab_SendPkt(P);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_UserSearch'}

procedure Jab_UserSearch(S_Nick, S_Name, S_Last, S_City, S_Country, S_Email: string);
const
  N = '<field var=''%s''><value>%s</value></field>';
var
  P, F: string;
begin
  // Формируем ноды с параметрами поиска (ejabberd)
  if S_Nick <> EmptyStr then
    F := F + Format(N, ['nick', S_Nick]);
  if S_Name <> EmptyStr then
    F := F + Format(N, ['first', S_Name]);
  if S_Last <> EmptyStr then
    F := F + Format(N, ['last', S_Last]);
  if S_City <> EmptyStr then
    F := F + Format(N, ['locality', S_City]);
  if S_Country <> EmptyStr then
    F := F + Format(N, ['ctry', S_Country]);
  if S_Email <> EmptyStr then
    F := F + Format(N, ['email', S_Email]);
  // Формируем ноды с параметрами поиска (Openfire)
  if S_Nick <> EmptyStr then
    F := F + Format(N, ['search', S_Nick])
  else if S_Name <> EmptyStr then
    F := F + Format(N, ['search', S_Name])
  else if S_Email <> EmptyStr then
    F := F + Format(N, ['search', S_Email]);
  F := F + Format(N, ['Username', '1']);
  F := F + Format(N, ['Name', '1']);
  F := F + Format(N, ['Email', '1']);
  // Ищем контакты на сервере по параметрам
  P := Format(J_SearchUser, [Jab_VJID_Server, Jabber_Seq, F]);
  Jab_SendPkt(P);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;
{$ENDREGION}
{$REGION 'Jab_ParseUsersSearch'}

procedure Jab_ParseUsersSearch(PktData: TJvSimpleXmlElem);
var
  I, F: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  ListItemD: TListItem;
  S, SJID, SFN, SNick, SName, SLast, SBDay, SCountry, SCity, SEmail: string;
begin
  if Assigned(ContactSearchForm) then
  begin
    // Разбираем пакет поиска контактов
    if PktData <> nil then
    begin
      with ContactSearchForm do
      begin
        // Поиск заверщён
        StatusPanel.Caption := Lang_Vars[122].L_S;
        // Начинаем добавление записи в список найденных
        SearchResultJvListView.Items.BeginUpdate;
        try
          XML_Node := PktData.Items.ItemNamed['x'];
          if XML_Node <> nil then
          begin
            for I := 0 to XML_Node.Items.Count - 1 do
            begin
              Sub_Node := XML_Node.Items[I];
              if Sub_Node <> nil then
              begin
                if Sub_Node.Name = 'item' then
                begin
                  ListItemD := SearchResultJvListView.Items.Add;
                  with ListItemD do
                  begin
                    Checked := False;
                    Caption := EmptyStr; // Иконка анкеты
                    SubItems.Add(EmptyStr); // Иконка чата
                    for F := 0 to Sub_Node.Items.Count - 1 do
                    begin
                      Tri_Node := Sub_Node.Items[F];
                      if Tri_Node <> nil then
                      begin
                        S := UpperCase(Tri_Node.Properties.Value('var'));
                        if S = Node_JID then
                          SJID := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = Node_FN then
                          SFN := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = 'USERNAME' then
                          SNick := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = 'NICK' then
                          SNick := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = 'FIRST' then
                          SName := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = 'NAME' then
                          SName := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = 'LAST' then
                          SLast := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = Node_BDAY then
                          SBDay := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = Node_CTRY then
                          SCountry := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = Node_LOCALITY then
                          SCity := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value)
                        else if S = Node_EMAIL then
                          SEmail := UTF8ToString(Tri_Node.Items.ItemNamed['value'].Value);
                      end;
                    end;
                    SubItems.Add(SJID);
                    SubItems.Add(SNick);
                    SubItems.Add(SName);
                    SubItems.Add(SLast);
                    SubItems.Add(SBDay);
                    SubItems.Add(Lang_Vars[124].L_S);
                    SubItems.Add(EmptyStr); // Иконка быстрых сообщений
                    SubItems.Add(SCountry);
                    SubItems.Add(SCity);
                    SubItems.Add(SEmail);
                  end;
                end;
              end;
            end;
          end;
        finally
          SearchResultJvListView.Items.EndUpdate;
        end;
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Jab_PassChange'}
  procedure Jab_PassChange(NewPass: string);
  var
    P: string;
  begin
    // Запоминаем Id запроса
    J_PassChangeId := IntToStr(Jabber_Seq);
    // Меняем пароль
    P := Format(J_PassChange, [Parse('@', Jabber_JID, 2), Jabber_Seq, Jabber_LoginUIN, NewPass]);
    Jab_SendPkt(P);
    // Увеличиваем счётчик исходящих jabber пакетов
    Inc(Jabber_Seq);
  end;
{$ENDREGION}
{$REGION 'Jab_JoinInConf'}
  procedure Jab_JoinInConf(Conf: string);
  var
    P: string;
  begin
    // Заходим в конференцию
    P := Format(J_JoinInConf, [Conf, '30']);
    Jab_SendPkt(P);
    // Увеличиваем счётчик исходящих jabber пакетов
    Inc(Jabber_Seq);
  end;
{$ENDREGION}

end.

