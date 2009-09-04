{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit JabberProtoUnit;

interface

uses
  Windows, MainUnit, SysUtils, JvTrayIcon, Dialogs, OverbyteIcsWSocket,
  ChatUnit, MmSystem, Forms, ComCtrls, Messages, Classes, IcqContactInfoUnit,
  Code, VarsUnit, Graphics, CategoryButtons, rXML, JvZLibMultiple,
  OverbyteIcsMD5, OverbyteIcsMimeUtils, JabberOptionsUnit, RosterUnit;

var
  Jabber_BuffPkt: string = '';
  Jabber_JID: string = '';
  Jabber_LoginUIN: string = '';
  Jabber_LoginPassword: string = '';
  Jabber_ServerAddr: string = '';
  Jabber_ServerPort: string = '5222';
  Jabber_Reconnect: boolean = false;
  Jabber_KeepAlive: boolean = true;
  Jabber_myBeautifulSocketBuffer: string;
  Jabber_CurrentStatus: integer = 30;
  Jabber_CurrentStatus_bac: integer = 30;
  Jabber_Seq: word = 0;
  JabberResurs: string = 'IMadering';
  JabberPriority: string = '30';
  //--Фазы работы начало
  Jabber_Connect_Phaze: boolean = false;
  Jabber_HTTP_Connect_Phaze: boolean = false;
  Jabber_Work_Phaze: boolean = false;
  Jabber_Offline_Phaze: boolean = true;
  //--Фазы работы конец
  StreamHead: string = '<?xml version=''1.0'' encoding=''UTF-8''?>' +
  '<stream:stream to=''%s'' xmlns=''jabber' +
    ':client'' xmlns:stream=''http://etherx.jabber.org/streams'' xm' +
    'l:lang=''ru'' version=''1.0''>';
  IqTypeSet: string = '<iq type=''set'' id=''imadering_%d''>';
  IqTypeGet: string = '<iq type=''get'' id=''imadering_%d''>';
  FRootTag: string = 'stream:stream';
  Iq_Roster: string = 'jabber:iq:roster';
  JmessHead: string = '<message type=''chat'' to=''%s'' id=''%d''>';

function JabberDIGESTMD5_Auth(User, Host, Password, nonce, cnonce: string): string;
procedure Jabber_GoOffline;
function Jabber_SetBind: string;
function Jabber_SetSession: string;
function Jabber_GetRoster: string;
function Jabber_SetStatus(jStatus: integer): string;
procedure Jabber_ParseRoster(XmlData: string);
procedure Jabber_ParseFeatures(XmlData: string);
procedure Jabber_ParseIQ(XmlData: string);
procedure Jabber_ParsePresence(XmlData: string);
procedure Jabber_ParseMessage(XmlData: string);
procedure Jabber_SendMessage(mJID, Msg: string);

implementation

uses
  UtilsUnit;

function GenResponse(UserName, realm, digest_uri, Pass, nonce, cnonce: string): string;
const
  nc = '00000001';
  gop = 'auth';
var
  A2, HA1, HA2, sJID: string;
  Razdel: Byte;
  Context: TMD5Context;
  DigestJID: TMD5Digest;
  DigestHA1: TMD5Digest;
  DigestHA2: TMD5Digest;
  DigestResponse: TMD5Digest;
begin
  Razdel := Ord(':');
  //--Вычисляем А1 по формуле RFC 2831
  sJID := format('%S:%S:%S', [username, realm, Pass]);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@sJID[1]), Length(sJID));
  MD5Final(DigestJID, Context);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@DigestJID), SizeOf(TMD5Digest));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@nonce[1]), Length(nonce));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@cnonce[1]), Length(cnonce));
  MD5Final(DigestHA1, Context);
  //--Вычисляем А2 по формуле RFC 2831
  A2 := format('AUTHENTICATE:%S', [digest_uri]);
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@A2[1]), Length(A2));
  MD5Final(DigestHA2, Context);
  //--Вычисляем RESPONSE по формуле RFC 2831
  HA1 := LowerCase(PacketToHex(@DigestHA1, SizeOf(TMD5Digest)));
  HA2 := LowerCase(PacketToHex(@DigestHA2, SizeOf(TMD5Digest)));
  MD5Init(Context);
  MD5UpdateBuffer(Context, PByteArray(@HA1[1]), Length(HA1));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@nonce[1]), Length(nonce));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@nc[1]), Length(nc));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@cnonce[1]), Length(cnonce));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@gop[1]), Length(gop));
  MD5UpdateBuffer(Context, @Razdel, SizeOf(Razdel));
  MD5UpdateBuffer(Context, PByteArray(@HA2[1]), Length(HA2));
  MD5Final(DigestResponse, Context);
  Result := LowerCase(PacketToHex(@DigestResponse, SizeOf(TMD5Digest)))
end;

function JabberDIGESTMD5_Auth(User, Host, Password, nonce, cnonce: string): string;
var
  Str, Response: string;
begin
{ username   - имя JIDNode
  realm      - хост машины
  nonce      - уникальная строка присланная нам ранее сервером
  cnonce     - 64 бит уникальный отпечаток
  digest-uri - Название службы к которому клинт хотел бы подключится, образуется из хоста и типа протокола
  response   - пароль (Комбинация из 32 цифр HEX -  вычисляется) }
  //--Вычиляем пароль
  Response := GenResponse(User, Host, 'xmpp/' + host, Password, nonce, cnonce);
  //--Формируем строку в формате UTF-8
  Str := UTF8Encode(Format('username="%s",realm="%s",nonce="%s",cnonce="%s",nc=00000001,' +
    'qop=auth,digest-uri="xmpp/%s",charset=utf-8,response=%s', [User, Host, nonce, cnonce, host, Response]));
  //--Шифруем строку алгоритмом Base64
  Str := Base64Encode(Str);
  Result := Format('<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''>%s</response>', [Str]);
end;

procedure Jabber_GoOffline;
var
  i: integer;
begin
  //--Отключаем таймер пингов
  with MainForm.JvTimerList do
  begin
    Events[9].Enabled := false;
  end;
  //--Если существует форма настроек протокола Jabber, то блокируем там контролы
  if Assigned(JabberOptionsForm) then
  begin
    with JabberOptionsForm do
    begin
      JabberJIDEdit.Enabled := true;
      JabberJIDEdit.Color := clWindow;
      PassEdit.Enabled := true;
      PassEdit.Color := clWindow;
    end;
  end;
  //--Активируем фазу оффлайн и обнуляем буферы пакетов
  Jabber_Connect_Phaze := false;
  Jabber_HTTP_Connect_Phaze := false;
  Jabber_Work_Phaze := false;
  Jabber_Offline_Phaze := true;
  Jabber_myBeautifulSocketBuffer := EmptyStr;
  Jabber_BuffPkt := EmptyStr;
  Jabber_Seq := 0;
  //--Если сокет подключён, то отсылаем пакет "до свидания"
  with MainForm do
  begin
    if JabberWSocket.State = wsConnected then JabberWSocket.SendStr('</stream:stream>');
    //--Закрываем сокет
    JabberWSocket.Abort;
    //--Ставим иконку и значение статуса оффлайн
    Jabber_CurrentStatus := 30;
    JabberToolButton.ImageIndex := Jabber_CurrentStatus;
    JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
    //--Подсвечиваем в меню статуса Jabber статус оффлайн
    JabberStatusOffline.Default := true;
  end;
  //--Активируем флаг остановки потока сжатия истории
  ZipThreadStop := true;
  //--Если поток сжатия истории не остановился ещё, то ждём его остановки
  while not MainForm.ZipHistoryThread.Terminated do Sleep(10);
  //--Сохраняем историю сообщений, но уже не в потоке
  ZipThreadStop := false;
  MainForm.ZipHistory;
  //--Обнуляем события и переменные в Ростере
  with RosterForm.RosterJvListView do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      if Items[i].SubItems[3] = 'Jabber' then
      begin
        if Items[i].SubItems[6] <> '42' then Items[i].SubItems[6] := '30';
        Items[i].SubItems[7] := '-1';
        Items[i].SubItems[8] := '-1';
        Items[i].SubItems[13] := '';
        Items[i].SubItems[15] := '';
        Items[i].SubItems[16] := '';
        Items[i].SubItems[18] := '0';
        Items[i].SubItems[19] := '0';
        Items[i].SubItems[35] := '0';
      end;
    end;
  end;
  //--Запускаем обработку Ростера
  RosterForm.UpdateFullCL;
end;

function Jabber_SetBind: string;
begin
  Result := Format(IqTypeSet, [Jabber_Seq]) + '<bind xmlns=''urn:ietf:params:xml:ns:xmpp-bind''>' +
    '<resource>' + JabberResurs + '</resource></bind></iq>';
  //--Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

function Jabber_SetSession: string;
begin
  Result := Format(IqTypeSet, [Jabber_Seq]) + '<session xmlns=''urn:ietf:params:xml:ns:xmpp-session''/>' +
    '</iq>';
  //--Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

function Jabber_GetRoster: string;
begin
  Result := Format(IqTypeGet, [Jabber_Seq]) + '<query xmlns=''jabber:iq:roster''/></iq>';
  //--Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

function Jabber_SetStatus(jStatus: integer): string;
var
  st: string;
begin
  //--Формируем статус строку
  case jStatus of
    29: st := '<show>away</show>';
    32: st := '<show>dnd</show><x xmlns=''qip:x:status'' value=''8''/>';
    33: st := '<show>dnd</show>';
    34: st := '<show>xa</show>';
    35: st := '<show>away</show><x xmlns=''qip:x:status'' value=''10''/>';
    36: st := '<show>chat</show>';
    37: st := '<x xmlns=''qip:x:status'' value=''5''/>';
    38: st := '<x xmlns=''qip:x:status'' value=''4''/>';
    39: st := '<x xmlns=''qip:x:status'' value=''6''/>';
    40: st := '<x xmlns=''qip:x:status'' value=''7''/>';
  else st := '';
  end;
  //--Формируем пакет
  Result := '<presence><priority>' + JabberPriority + '</priority>' +
    '<c xmlns=''http://jabber.org/protocol/caps'' node=''http://imadering.com/caps'' ver=''0.5.0.0''/>' +
    st + '</presence>';
end;

procedure Jabber_ParseRoster(XmlData: string);
var
  cnt, i: integer;
  ListItemD: TListItem;
begin
  cnt := 0;
  //--Инициализируем XML
  with TrXML.Create() do
  try
    begin
      Text := XmlData;
      if OpenKey('query') then
      try
        cnt := GetKeyCount('item');
      finally
        CloseKey();
      end;
      //--Разбираем список контктов Jabber
      //--Начинаем добаление записей контактов в Ростер
      RosterForm.RosterJvListView.Items.BeginUpdate;
      for i := 0 to cnt - 1 do
      begin
        if OpenKey('query\item', false, i) then
        try
          ListItemD := RosterForm.RosterJvListView.Items.Add;
          ListItemD.Caption := ReadString('jid');
          //--Подготавиливаем все значения
          RosterForm.RosterItemSetFull(ListItemD);
          //--Обновляем субстроки
          ListItemD.SubItems[0] := ReadString('name');
          ListItemD.SubItems[2] := ReadString('subscription');
          //--Открываем ключ группы
          OpenKey('group', false, 0);
          ListItemD.SubItems[1] := GetKeyText;
          ListItemD.SubItems[3] := 'Jabber';
          ListItemD.SubItems[6] := '30';
        finally
          CloseKey();
        end;
      end;
    end;
  finally
    Free();
    //--Заканчиваем добаление записей контактов в Ростер
    RosterForm.RosterJvListView.Items.EndUpdate;
  end;
  //--Запускаем обработку Ростера
  RosterForm.UpdateFullCL;
end;

procedure Jabber_ParseFeatures(XmlData: string);
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    begin
      Text := XmlData;
      if OpenKey('stream:features\bind') then
      try
        //--Устанавливаем bind
        MainForm.JabberWSocket.SendStr(UTF8Encode(Jabber_SetBind));
      finally
        CloseKey();
      end;
      if OpenKey('stream:features\session') then
      try
        //--Устанавливаем session
        MainForm.JabberWSocket.SendStr(UTF8Encode(Jabber_SetSession));
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

procedure Jabber_ParseIQ(XmlData: string);
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    begin
      Text := XmlData;
      if OpenKey('iq\session') then
      try
        begin
          //--Запрашиваем список контактов
          MainForm.JabberWSocket.SendStr(UTF8Encode(Jabber_GetRoster));
          //--Устанавливаем статус
          MainForm.JabberWSocket.SendStr(UTF8Encode(Jabber_SetStatus(Jabber_CurrentStatus)));
        end;
      finally
        CloseKey();
      end
      else if OpenKey('iq\query') then
      try
        begin
          //--Разбираем список контктов Jabber
          if ReadString('xmlns') = Iq_Roster then Jabber_ParseRoster(GetKeyXML);
        end;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

procedure Jabber_SendMessage(mJID, Msg: string);
var
  m: string;
begin
  //--Отправляем сообщение для jabber контакта
  m := Format(JmessHead, [mJID, Jabber_Seq]) + '<body>' + Msg + '</body></message>';
  MainForm.JabberWSocket.SendStr(UTF8Encode(m));
  //--Увеличиваем счётчик исходящих jabber пакетов
  Inc(Jabber_Seq);
end;

procedure Jabber_ParsePresence(XmlData: string);
var
  pJID: string;
  RosterItem: TListItem;
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    begin
      Text := XmlData;
      if OpenKey('presence') then
      try
        begin
          pJID := ReadString('from');
          if pJID <> EmptyStr then
          begin
            //--Отделяем ресурс
            pJID := Parse('/', pJID, 1);
            //--Ищем эту запись в Ростере
            RosterItem := RosterForm.ReqRosterItem(pJID);
            if RosterItem <> nil then
            begin
              //--Выставляем параметры этой записи
              with RosterItem do
              begin
                if ReadString('type') = 'unavailable' then
                begin
                  SubItems[18] := '0';
                  if (SubItems[6] <> '30') and (SubItems[6] <> '41') and
                    (SubItems[6] <> '42') then SubItems[19] := '20'
                  else SubItems[19] := '0';
                  SubItems[6] := '30';
                end
                else
                begin
                  if SubItems[6] = '30' then SubItems[18] := '20'
                  else SubItems[18] := '0';
                  SubItems[19] := '0';
                  SubItems[6] := '28';
                end;
                //--Запускаем таймер задержку событий Ростера
                MainForm.JvTimerList.Events[11].Enabled := false;
                MainForm.JvTimerList.Events[11].Enabled := true;
              end;
            end;
          end;
        end;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

procedure Jabber_ParseMessage(XmlData: string);
var
  pJID, InMsg, Nick, Mess, msgD, PopMsg: string;
  RosterItem: TListItem;
begin
  //--Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then ChatForm := TChatForm.Create(MainForm);
  //--Инициализируем XML
  with TrXML.Create() do
  try
    begin
      Text := XmlData;
      if OpenKey('message') then
      try
        begin
          pJID := ReadString('from');
          OpenKey('body', false, 0);
          InMsg := GetKeyText;
          if (pJID <> EmptyStr) and (InMsg <> EmptyStr) then
          begin
            //--Отделяем ресурс
            pJID := Parse('/', pJID, 1);
            //--Обрабатываем сообщение
            Mess := InMsg;
            ChatForm.CheckMessage_BR(Mess);
            ChatForm.CheckMessage_ClearTag(Mess);
            PopMsg := Mess;
            ChatForm.CheckMessage_BR(Mess);
            DecorateURL(Mess);
            //--Ищем эту запись в Ростере
            RosterItem := RosterForm.ReqRosterItem(pJID);
            if RosterItem <> nil then
            begin
              //--Выставляем параметры сообщения в этой записи
              with RosterItem do
              begin
                //--Ник контакта из Ростера
                Nick := SubItems[0];
                //--Дата сообщения
                msgD := Nick + ' [' + DateTimeChatMess + ']';
                //--Записываем историю в этот контакт если он уже найден в списке контактов
                SubItems[17] := 'X';
                SubItems[35] := '0';
                SubItems[15] := PopMsg;
                //--Добавляем историю в эту запись
                RosterForm.AddHistory(RosterItem, msgD, Mess);
              end;
            end
            else //--Если такой контакт не найден в Ростере, то добавляем его
            begin
              //--Если ник не нашли в Ростере, то ищем его в файле-кэше ников
              Nick := SearchNickInCash('Jabber', pJID);
              //--Дата сообщения
              msgD := Nick + ' [' + DateTimeChatMess + ']';
              //--Ищем группу "Не в списке" в Ростере
              RosterItem := RosterForm.ReqRosterItem('NoCL');
              if RosterItem = nil then //--Если группу не нашли
              begin
                //--Добавляем такую группу в Ростер
                RosterItem := RosterForm.RosterJvListView.Items.Add;
                RosterItem.Caption := 'NoCL';
                //--Подготавиливаем все значения
                RosterForm.RosterItemSetFull(RosterItem);
                RosterItem.SubItems[1] := NoInListGroupCaption;
              end;
              //--Добавляем этот контакт в Ростер
              RosterItem := RosterForm.RosterJvListView.Items.Add;
              with RosterItem do
              begin
                Caption := pJID;
                //--Подготавиливаем все значения
                RosterForm.RosterItemSetFull(RosterItem);
                //--Обновляем субстроки
                SubItems[0] := Nick;
                SubItems[1] := 'NoCL';
                SubItems[2] := 'none';
                SubItems[3] := 'Jabber';
                SubItems[6] := '214';
                SubItems[17] := 'X';
                SubItems[35] := '0';
                SubItems[15] := PopMsg;
                //--Добавляем историю в эту запись
                RosterForm.AddHistory(RosterItem, msgD, Mess);
              end;
            end;
            //--Добавляем сообщение в текущий чат
            ChatForm.AddMessInActiveChat(Nick, PopMsg, pJID, msgD, Mess);
            //--Если в списке очереди входящих сообщений нет этого контакта, то добавляем его туда
            if InMessList.IndexOf(pJID) = -1 then InMessList.Add(pJID);
            //--Играем звук входящего сообщения
            ImPlaySnd(1);
          end;
        end;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

end.

