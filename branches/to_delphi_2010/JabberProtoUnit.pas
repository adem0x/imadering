{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit JabberProtoUnit;

interface

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
  RXML,
  OverbyteIcsMimeUtils,
  JabberOptionsUnit,
  RosterUnit;

{ const
  CONST_Jabber_DefaultServerSSLPort: string = '5223';
  CONST_Jabber_DefaultServerNoSecurePort: string = '5222'; }

var
  Jabber_UseSSL: Boolean = False;
  Jabber_BuffPkt: string = '';
  Jabber_JID: string = '';
  Jabber_LoginUIN: string = '';
  Jabber_LoginPassword: string = '';
  Jabber_ServerAddr: string = '';
  Jabber_ServerPort: string = '5222';
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
  StreamHead: string = '<?xml version=''1.0'' encoding=''UTF-8''?>' + '<stream:stream to=''%s'' xmlns=''jabber' +
    ':client'' xmlns:stream=''http://etherx.jabber.org/streams'' xm' + 'l:lang=''ru'' version=''1.0''>';
  IqTypeSet: string = '<iq type=''set'' id=''imadering_%d''>';
  IqTypeGet: string = '<iq type=''get'' id=''imadering_%d''>';
  FRootTag: string = 'stream:stream';
  Iq_Roster: string = 'jabber:iq:roster';
  JmessHead: string = '<message type=''chat'' to=''%s'' id=''%d''>';
  JPlainMechanism: string = '<auth xmlns=''urn:ietf:params:xml:ns:xmpp-sasl'' mechanism=''PLAIN''>%s</auth>';
  JSessionId: string;

function JabberDIGESTMD5_Auth(User, Host, Password, Nonce, Cnonce: string): string;
function JabberPlain_Auth: string;
procedure Jabber_GoOffline;
function Jabber_SetBind: string;
function Jabber_SetSession: string;
function Jabber_GetRoster: string;
function Jabber_SetStatus(JStatus: Integer): string;
procedure Jabber_ParseRoster(XmlData: string);
procedure Jabber_ParseFeatures(XmlData: string);
procedure Jabber_ParseIQ(XmlData: string);
procedure Jabber_ParsePresence(XmlData: string);
procedure Jabber_ParseMessage(XmlData: string);
procedure Jabber_SendMessage(MJID, Msg: string);

implementation

uses
  UtilsUnit,
  OverbyteIcsMD5;

function JabberPlain_Auth: string;
var
  Uu, Upass, Ujid, C, Buff: string;
begin
  XLog(Log_Jabber_Plain);
  Ujid := Jabber_JID;
  Uu := Jabber_LoginUIN;
  Upass := Jabber_LoginPassword;
  // Записываем в память параметры логина
  Buff := Ujid + ''#0 + Uu + ''#0 + Upass;
  // Кодируем в строку
  C := Base64Encode(Buff);
  Result := C;
end;

function GenResponse(UserName, Realm, Digest_uri, Pass, Nonce, Cnonce: RawByteString): string;
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
  XLog('Jabber parsing | ' + Log_MD5_Nonce + Nonce);
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

function JabberDIGESTMD5_Auth(User, Host, Password, Nonce, Cnonce: string): string;
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
  Response := GenResponse(User, Host, 'xmpp/' + Host, Password, Nonce, Cnonce);
  // Формируем строку в формате UTF-8
  Str := Format('username="%s",realm="%s",nonce="%s",cnonce="%s",nc=00000001,' + 'qop=auth,digest-uri="xmpp/%s",charset=utf-8,response=%s',
    [User, Host, Nonce, Cnonce, Host, Response]);
  // Шифруем строку алгоритмом Base64
  Str := Base64Encode(Str);
  Result := Format('<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''>%s</response>', [Str]);
end;

procedure Jabber_GoOffline;
var
  I: Integer;
begin
  // Отключаем таймер пингов
  MainForm.UnstableJabberStatus.Checked := False;
  with MainForm.JvTimerList do
    begin
      Events[9].Enabled := False;
    end;
  // Если существует форма настроек протокола Jabber, то блокируем там контролы
  if Assigned(JabberOptionsForm) then
    begin
      with JabberOptionsForm do
        begin
          JabberJIDEdit.Enabled := True;
          JabberJIDEdit.Color := ClWindow;
          PassEdit.Enabled := True;
          PassEdit.Color := ClWindow;
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
        Sendflap_jabber('</stream:stream>');
      // Закрываем сокет
      JabberWSocket.Abort;
      // Ставим иконку и значение статуса оффлайн
      Jabber_CurrentStatus := 30;
      JabberToolButton.ImageIndex := Jabber_CurrentStatus;
      JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
      // Подсвечиваем в меню статуса Jabber статус оффлайн
      JabberStatusOffline.default := True;
    end;
  // Обнуляем события и переменные в Ростере
  with RosterForm.RosterJvListView do
    begin
      for I := 0 to Items.Count - 1 do
        begin
          if Items[I].SubItems[3] = S_Jabber then
            begin
              if Items[I].SubItems[6] <> '42' then
                Items[I].SubItems[6] := '30';
              Items[I].SubItems[7] := '-1';
              Items[I].SubItems[8] := '-1';
              Items[I].SubItems[13] := '';
              Items[I].SubItems[15] := '';
              Items[I].SubItems[16] := '';
              Items[I].SubItems[18] := '0';
              Items[I].SubItems[19] := '0';
              Items[I].SubItems[35] := '0';
            end;
        end;
    end;
  // Запускаем обработку Ростера
  RosterForm.UpdateFullCL;
end;

function Jabber_SetBind: string;
begin
  Result := Format(IqTypeSet, [Jabber_Seq]) + '<bind xmlns=''urn:ietf:params:xml:ns:xmpp-bind''>' + '<resource>' + JabberResurs +
    '</resource></bind></iq>';
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

function Jabber_SetSession: string;
begin
  Result := Format(IqTypeSet, [Jabber_Seq]) + '<session xmlns=''urn:ietf:params:xml:ns:xmpp-session''/>' + '</iq>';
  // Запоминаем Id для запроса сессии (google talk)
  JSessionId := Format('imadering_%d', [Jabber_Seq]);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

function Jabber_GetRoster: string;
begin
  Result := Format(IqTypeGet, [Jabber_Seq]) + '<query xmlns=''jabber:iq:roster''/></iq>';
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

function Jabber_SetStatus(JStatus: Integer): string;
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
  else St := '';
  end;
  // Формируем пакет
  Result := '<presence><priority>' + JabberPriority + '</priority>' +
    '<c xmlns=''http://jabber.org/protocol/caps'' node=''http://imadering.com/caps'' ver=''0.5.0.0''/>' + St + '</presence>';
end;

procedure Jabber_ParseRoster(XmlData: string);
var
  Cnt, I: Integer;
  ListItemD: TListItem;
  XmlDoc: TrXML;
begin
  Cnt := 0;
  // Инициализируем XML
  XmlDoc := TrXML.Create;
  // Начинаем добаление записей контактов в Ростер
  RosterForm.RosterJvListView.Items.BeginUpdate;
  try
    with XmlDoc do
      begin
        Text := XmlData;
        if OpenKey('query') then
          try
            Cnt := GetKeyCount('item');
          finally
            CloseKey;
          end;
        // Разбираем список контктов Jabber
        for I := 0 to Cnt - 1 do
          begin
            if OpenKey('query\item', False, I) then
              try
                ListItemD := RosterForm.RosterJvListView.Items.Add;
                ListItemD.Caption := ReadString('jid');
                // Подготавиливаем все значения
                RosterForm.RosterItemSetFull(ListItemD);
                // Обновляем субстроки
                ListItemD.SubItems[0] := ReadString('name');
                if ListItemD.SubItems[0] = EmptyStr then
                  ListItemD.SubItems[0] := ListItemD.Caption;
                ListItemD.SubItems[2] := ReadString('subscription');
                // Открываем ключ группы
                OpenKey('group', False, 0);
                ListItemD.SubItems[1] := GetKeyText;
                if ListItemD.SubItems[1] = EmptyStr then
                  ListItemD.SubItems[1] := JabberNullGroup;
                ListItemD.SubItems[3] := S_Jabber;
                ListItemD.SubItems[6] := '30';
              finally
                CloseKey;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlDoc);
    // Заканчиваем добаление записей контактов в Ростер
    RosterForm.RosterJvListView.Items.EndUpdate;
  end;
  // Запускаем обработку Ростера
  CollapseGroupsRestore := True;
  RosterForm.UpdateFullCL;
end;

procedure Jabber_ParseFeatures(XmlData: string);
var
  XmlDoc: TrXML;
begin
  // Инициализируем XML
  XmlDoc := TrXML.Create;
  try
    with XmlDoc do
      begin
        Text := XmlData;
        if OpenKey('stream:features\bind') then
          try
            // Устанавливаем bind
            Sendflap_jabber(Jabber_SetBind);
          finally
            CloseKey;
          end;
        if OpenKey('stream:features\session') then
          try
            // Устанавливаем session
            Sendflap_jabber(Jabber_SetSession);
          finally
            CloseKey;
          end;
      end;
  finally
    FreeAndNil(XmlDoc);
  end;
end;

procedure Jabber_ParseIQ(XmlData: string);
var
  XmlDoc: TrXML;
begin
  // Инициализируем XML
  XmlDoc := TrXML.Create;
  try
    with XmlDoc do
      begin
        Text := XmlData;
        if OpenKey('iq\session') then
          try
            begin
              // Запрашиваем список контактов
              Sendflap_jabber(Jabber_GetRoster);
              // Устанавливаем статус
              Sendflap_jabber(Jabber_SetStatus(Jabber_CurrentStatus));
            end;
          finally
            CloseKey;
          end
        else if OpenKey('iq\query') then
          try
            begin
              // Разбираем список контктов Jabber
              if ReadString('xmlns') = Iq_Roster then
                Jabber_ParseRoster(GetKeyXML);
            end;
          finally
            CloseKey;
          end
        else
        // Такое можно было ожидать только от google talk
          if OpenKey('iq') then
          try
            begin
              if (ReadString('type') = 'result') and (ReadString('id') = JSessionId) then
                begin
                  // Запрашиваем список контактов
                  Sendflap_jabber(Jabber_GetRoster);
                  // Устанавливаем статус
                  Sendflap_jabber(Jabber_SetStatus(Jabber_CurrentStatus));
                end;
            end;
          finally
            CloseKey;
          end;
      end;
  finally
    FreeAndNil(XmlDoc);
  end;
end;

procedure Jabber_SendMessage(MJID, Msg: string);
var
  M: string;
begin
  // Отправляем сообщение для jabber контакта
  M := Format(JmessHead, [MJID, Jabber_Seq]) + '<body>' + Msg + '</body></message>';
  Sendflap_jabber(M);
  // Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

procedure Jabber_ParsePresence(XmlData: string);
var
  PJID: string;
  RosterItem: TListItem;
  XmlDoc: TrXML;
begin
  // Инициализируем XML
  XmlDoc := TrXML.Create;
  try
    with XmlDoc do
      begin
        Text := XmlData;
        if OpenKey('presence') then
          try
            begin
              PJID := ReadString('from');
              if PJID <> EmptyStr then
                begin
                  // Отделяем ресурс
                  PJID := Parse('/', PJID, 1);
                  // Ищем эту запись в Ростере
                  RosterItem := RosterForm.ReqRosterItem(PJID);
                  if RosterItem <> nil then
                    begin
                      // Выставляем параметры этой записи
                      with RosterItem do
                        begin
                          if ReadString('type') = 'unavailable' then
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
                    end;
                end;
            end;
          finally
            CloseKey;
          end;
      end;
  finally
    FreeAndNil(XmlDoc);
  end;
end;

procedure Jabber_ParseMessage(XmlData: string);
var
  PJID, InMsg, Nick, Mess, MsgD, PopMsg: string;
  RosterItem: TListItem;
  XmlDoc: TrXML;
begin
  // Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    ChatForm := TChatForm.Create(MainForm);
  // Инициализируем XML
  XmlDoc := TrXML.Create;
  try
    with XmlDoc do
      begin
        Text := XmlData;
        if OpenKey('message') then
          try
            begin
              PJID := ReadString('from');
              OpenKey('body', False, 0);
              InMsg := GetKeyText;
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
                  CheckMessage_BR(Mess);
                  DecorateURL(Mess);
                  // Ищем эту запись в Ростере
                  RosterItem := RosterForm.ReqRosterItem(PJID);
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
                          SubItems[17] := 'X';
                          SubItems[35] := '0';
                          // Добавляем историю в эту запись
                          // RosterForm.AddHistory(RosterItem, MsgD, Mess);
                        end;
                    end
                  else // Если такой контакт не найден в Ростере, то добавляем его
                    begin
                      // Если ник не нашли в Ростере, то ищем его в файле-кэше ников
                      Nick := SearchNickInCash(S_Jabber, PJID);
                      // Дата сообщения
                      MsgD := Nick + ' [' + DateTimeChatMess + ']';
                      // Ищем группу "Не в списке" в Ростере
                      RosterItem := RosterForm.ReqRosterItem(S_NoCL);
                      if RosterItem = nil then // Если группу не нашли
                        begin
                          // Добавляем такую группу в Ростер
                          RosterItem := RosterForm.RosterJvListView.Items.Add;
                          RosterItem.Caption := S_NoCL;
                          // Подготавиливаем все значения
                          RosterForm.RosterItemSetFull(RosterItem);
                          RosterItem.SubItems[1] := NoInListGroupCaption;
                        end;
                      // Добавляем этот контакт в Ростер
                      RosterItem := RosterForm.RosterJvListView.Items.Add;
                      with RosterItem do
                        begin
                          Caption := PJID;
                          // Подготавиливаем все значения
                          RosterForm.RosterItemSetFull(RosterItem);
                          // Обновляем субстроки
                          SubItems[0] := Nick;
                          SubItems[1] := S_NoCL;
                          SubItems[2] := 'none';
                          SubItems[3] := S_Jabber;
                          SubItems[6] := '214';
                          SubItems[15] := PopMsg;
                          SubItems[17] := 'X';
                          SubItems[35] := '0';
                          // Добавляем историю в эту запись
                          // RosterForm.AddHistory(RosterItem, MsgD, Mess);
                        end;
                    end;
                  // Добавляем сообщение в текущий чат
                  if ChatForm.AddMessInActiveChat(Nick, PopMsg, PJID, MsgD, Mess) then
                    RosterItem.SubItems[36] := EmptyStr;
                end;
            end;
          finally
            CloseKey;
          end;
      end;
  finally
    FreeAndNil(XmlDoc);
  end;
end;

end.
