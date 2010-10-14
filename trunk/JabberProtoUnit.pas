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
  IcqContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  OverbyteIcsMimeUtils,
  JabberOptionsUnit,
  JvSimpleXml,
  OverbyteIcsUrl;

{$ENDREGION}
{$REGION 'Const'}

const
  J_RootNode = '<root>%s</root>';
  Iq_TypeSet = '<iq type=''set'' id=''imadering_%d''>';
  Iq_TypeGet = '<iq type=''get'' id=''imadering_%d''>';
  Iq_Roster = 'jabber:iq:roster';
  J_MessHead = '<message type=''chat'' to=''%s'' id=''%d''>';
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

{$ENDREGION}
{$REGION 'Vars'}

var
  Jabber_UseSSL: Boolean = False;
  Jabber_BuffPkt: string;
  Jabber_JID: string;
  Jabber_LoginUIN: string;
  Jabber_LoginPassword: string;
  Jabber_ServerAddr: string;
  Jabber_ServerPort: string;
  Jabber_Reconnect: Boolean = False;
  Jabber_KeepAlive: Boolean = True;
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
procedure Jab_ParseMessage(PktData: TJvSimpleXmlElem);
procedure Jab_SendMessage(MJID, Msg: string);

{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  OverbyteIcsMD5,
  RosterUnit;

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
  C := Base64Encode(Buff);
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
  MainForm.UnstableJabberStatus.Checked := False;
  with MainForm.JvTimerList do
  begin
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
      DeleteAccountLabel.Enabled := True;
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
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
          if Sub_Node <> nil then
          begin
            for I := 0 to Sub_Node.Items.Count - 1 do
            begin
              Tri_Node := Sub_Node.Items.Item[i];
              if Tri_Node <> nil then
              begin
                if Tri_Node.Properties.IntValue(C_Status) <> 42 then
                begin
                  RosterUpdateProp(Tri_Node, C_Status, '30');
                  RosterUpdateProp(Tri_Node, C_XStatus, '-1');
                  RosterUpdateProp(Tri_Node, C_XStatus + C_Name, EmptyStr);
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
  J_SessionId := Format('imadering_%d', [Jabber_Seq]);
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
        // Очищаем раздел Jabber если он есть
        XML_Node := Root.Items.ItemNamed[C_Jabber];
        // Добавляем раздел групп
        Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
        if Sub_Node = nil then
          Sub_Node := XML_Node.Items.Add(C_Group + C_SS);
        // Добавляем группу контактов с ошибочным идентификатором группы
        Tri_Node := Sub_Node.Items.ItemNamed[C_Group + C_DD + C_AuthNone];
        if Tri_Node = nil then
        begin
          Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_AuthNone);
          Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[7].L_S));
          Tri_Node.Properties.Add(C_Id, C_AuthNone);
        end;
        // Получаем количество записей с контактами
        Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
        Cnt := PktData.Items.Count;
        // Разбираем список контактов в пакете
        for I := 0 to Cnt - 1 do
        begin
          Item_Node := PktData.Items[I];
          if Item_Node <> nil then
          begin
            // Логин контакта
            Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(I));
            JID := Item_Node.Properties.Value('jid');
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
        // Запускаем обработку Ростера
        V_CollapseGroupsRestore := True;
        UpdateFullCL;
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
  QueryTLV: string;
begin
  // Если къюри :)
  XML_Node := PktData.Items.ItemNamed[J_Query];
  if XML_Node <> nil then
  begin
    QueryTLV := XML_Node.Properties.Value('xmlns');
    if QueryTLV = Iq_Roster then // Если это список контактов
      Jab_ParseRoster(XML_Node);
  end;
  // Если сессия открылась
  XML_Node := PktData.Items.ItemNamed[J_Session];
  if XML_Node <> nil then
  begin
    // Запрашиваем список контактов
    Jab_SendPkt(Jab_GetRoster);
    // Устанавливаем статус
    Jab_SendPkt(Jab_SetStatus(Jabber_CurrentStatus));
    // Выходим
    Exit;
  end;
  // Такое можно было ожидать только от google talk
  if (PktData.Properties.Value('type') = 'result') and (PktData.Properties.Value('id') = J_SessionId) then
  begin
    // Запрашиваем список контактов
    Jab_SendPkt(Jab_GetRoster);
    // Устанавливаем статус
    Jab_SendPkt(Jab_SetStatus(Jabber_CurrentStatus));
  end;
end;

{$ENDREGION}
{$REGION 'Jab_SendMessage'}

procedure Jab_SendMessage(MJID, Msg: string);
var
  M: string;
begin
  // Отправляем сообщение для jabber контакта
  M := Format(J_MessHead, [MJID, Jabber_Seq]) + '<body>' + Text2XML(Msg) + '</body></message>';
  Jab_SendPkt(M);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

{$ENDREGION}
{$REGION 'Jab_ParsePresence'}

procedure Jab_ParsePresence(PktData: TJvSimpleXmlElem);
var
  PJID: string;
  RosterItem: TListItem;
  JvXML: TJvSimpleXml;
begin
  (*// Инициализируем XML
  JvXML_Create(JvXML);
  try
    // Загружаем xml данные
    JvXML_LoadStr(JvXML, PktData);
    with JvXML do
    begin
      if Root <> nil then
      begin
        PJID := Root.Properties.Value('from');
        if PJID <> EmptyStr then
        begin
          // Отделяем ресурс
          if Pos('/', PJID) > 0 then
            PJID := Parse('/', PJID, 1);
          // Ищем эту запись в Ростере
          {RosterItem := RosterForm.ReqRosterItem(PJID);
          if RosterItem <> nil then
            begin
              // Выставляем параметры этой записи
              with RosterItem do
                begin
                  if Root.Properties.Value('type') = 'unavailable' then
                    begin
                      SubItems[18] := '0';
                      if (SubItems[6] <> '30') and (SubItems[6] <> '41') and (SubItems[6] <> '42') then
                        SubItems[19] := '20'
                      else
                        SubItems[19] := '0';
                      SubItems[6] := '30';
                    end
                  else
                    begin
                      if SubItems[6] = '30' then
                        SubItems[18] := '20'
                      else
                        SubItems[18] := '0';
                      SubItems[19] := '0';
                      SubItems[6] := '28';
                    end;
                  // Запускаем таймер задержку событий Ростера
                  MainForm.JvTimerList.Events[11].Enabled := False;
                  MainForm.JvTimerList.Events[11].Enabled := True;
                end;
            end;}
        end;

      end;
    end;
  finally
    JvXML.Free;
  end;*)
end;

{$ENDREGION}
{$REGION 'Jab_ParseMessage'}

procedure Jab_ParseMessage(PktData: TJvSimpleXmlElem);
var
  PJID, InMsg, Nick, Mess, MsgD, PopMsg, HistoryFile: string;
  RosterItem: TListItem;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  (*// Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    ChatForm := TChatForm.Create(MainForm);
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    // Загружаем xml данные
    JvXML_LoadStr(JvXML, PktData);
    with JvXML do
    begin
      if Root <> nil then
      begin
        PJID := Root.Properties.Value('from');
        XML_Node := Root.Items.ItemNamed['body'];
        if XML_Node <> nil then
          InMsg := UTF8ToString(XML_Node.Value);
        if (PJID <> EmptyStr) and (InMsg <> EmptyStr) then
        begin
          // Отделяем ресурс
          if Pos('/', PJID) > 0 then
            PJID := Parse('/', PJID, 1);
          // Обрабатываем сообщение
          Mess := InMsg;
          CheckMessage_BR(Mess);
          ChatForm.CheckMessage_ClearTag(Mess);
          PopMsg := Mess;
          // Ищем эту запись в Ростере
          {RosterItem := RosterForm.ReqRosterItem(PJID);
          if RosterItem <> nil then
            begin
              // Выставляем параметры сообщения в этой записи
              with RosterItem do
                begin
                  // Ник контакта из Ростера
                  Nick := URLDecode(SubItems[0]);
                  // Дата сообщения
                  MsgD := Nick + ' [' + DateTimeChatMess + ']';
                  // Записываем сообщение в этот контакт если он уже найден в списке контактов
                  SubItems[15] := URLEncode(PopMsg);
                  SubItems[35] := '0';
                end;
            end
          else // Если такой контакт не найден в Ростере, то добавляем его
            begin
              // Если ник не нашли в Ростере, то ищем его в файле-кэше ников
              Nick := SearchNickInCash(C_Jabber, PJID);
              // Дата сообщения
              MsgD := Nick + ' [' + DateTimeChatMess + ']';
              // Ищем группу "Не в списке" в Ростере
              RosterItem := RosterForm.ReqRosterItem(C_NoCL);
              if RosterItem = nil then // Если группу не нашли
                begin
                  // Добавляем такую группу в Ростер
                  RosterItem := RosterForm.RosterJvListView.Items.Add;
                  RosterItem.Caption := C_NoCL;
                  // Подготавиливаем все значения
                  RosterForm.RosterItemSetFull(RosterItem);
                  RosterItem.SubItems[1] := URLEncode(Lang_Vars[33].L_S);
                end;
              // Добавляем этот контакт в Ростер
              RosterItem := RosterForm.RosterJvListView.Items.Add;
              with RosterItem do
                begin
                  Caption := PJID;
                  // Подготавиливаем все значения
                  RosterForm.RosterItemSetFull(RosterItem);
                  // Обновляем субстроки
                  SubItems[0] := URLEncode(Nick);
                  SubItems[1] := C_NoCL;
                  SubItems[2] := 'none';
                  SubItems[3] := C_Jabber;
                  SubItems[6] := '42';
                  SubItems[15] := URLEncode(PopMsg);
                  SubItems[35] := '0';
                end;
              // Запускаем таймер задержку событий Ростера
              MainForm.JvTimerList.Events[11].Enabled := False;
              MainForm.JvTimerList.Events[11].Enabled := True;
            end;}
          // Записываем история в файл истории с этим контактов
          HistoryFile := V_ProfilePath + C_HistoryFolder + C_Jabber + C_BN + Jabber_LoginUIN + C_BN + PJID + '.htm';
          Mess := Text2XML(Mess);
          CheckMessage_BR(Mess);
          DecorateURL(Mess);
          SaveTextInHistory('<span class=b>' + MsgD + '</span><br><span class=c>' + Mess + '</span><br><br>', HistoryFile);
          // Добавляем сообщение в текущий чат
          RosterItem.SubItems[36] := 'X';
          if ChatForm.AddMessInActiveChat(Nick, PopMsg, PJID, MsgD, Mess) then
            RosterItem.SubItems[36] := EmptyStr;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;*)
end;

{$ENDREGION}

end.

