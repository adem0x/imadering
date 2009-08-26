unit JabberProtoUnit;

interface

uses
  Windows, MainUnit, SysUtils, JvTrayIcon, Dialogs, OverbyteIcsWSocket,
  ChatUnit, MmSystem, Forms, ComCtrls, Messages, Classes, IcqContactInfoUnit,
  Code, VarsUnit, Graphics, CategoryButtons, rXML, JvZLibMultiple,
  OverbyteIcsMD5, OverbyteIcsMimeUtils, JabberOptionsUnit, RosterUnit;

var
  Jabber_BuffPkt: string = '';
  Jabber_LoginUIN: string = '';
  Jabber_LoginPassword: string = '';
  Jabber_ServerAddr: string = 'jabber.ru';
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
  i, ii: integer;
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
  //--Сбрасываем иконки контактов в КЛ в оффлайн
  with MainForm.ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      if Categories[i].GroupType = 'Jabber' then
      begin
        if (Categories[i].GroupId = 'NoCL') or (Categories[i].Items.Count = 0) then Continue;
        //--Сбросим количесво онлайн-контактов в группах локального КЛ
        Categories[i].Caption := Categories[i].GroupCaption + ' - ' + '0' + GroupInv + IntToStr(Categories[i].Items.Count);
        //--Сбросим статусы
        for ii := 0 to Categories[i].Items.Count - 1 do
        begin
          if (Categories[i].Items[ii].Status = 30) and
            (Categories[i].Items[ii].ImageIndex = 30) then Continue
          else
          begin
            Categories[i].Items[ii].Status := 30;
            Categories[i].Items[ii].ImageIndex := 30;
          end;
          Categories[i].Items[ii].ImageIndex1 := -1;
          //--Не замораживаем интерфейс
          Application.ProcessMessages;
        end;
      end;
    end;
  end;
  //--Если окно чата существует, сбрасываем иконки во вкладках в оффлайн
  if Assigned(ChatForm) then
  begin
    with ChatForm.ChatPageControl do
    begin
      if Visible then
      begin
        for i := 0 to PageCount - 1 do
        begin
          if Pages[i].Tag = 30 then Continue
          else if (Pages[i].Tag > 27) and (Pages[i].Tag < 41) then
          begin
            Pages[i].Tag := 30;
            Pages[i].ImageIndex := 30;
          end;
          //--Не замораживаем интерфейс
          Application.ProcessMessages;
        end;
      end;
    end
  end;
  //--Сохраняем историю сообщений, но уже не в потоке
  MainForm.ZipHistory;
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
          ListItemD.SubItems.Add(ReadString('name'));
          ListItemD.SubItems.Add('');
          ListItemD.SubItems.Add(ReadString('subscription'));
          //--Открываем ключ группы
          OpenKey('group', false, 0);
          ListItemD.SubItems.Strings[1] := GetKeyText;
          ListItemD.SubItems.Add('Jabber');
        finally
          CloseKey();
        end;
        //--Размораживаем фэйс
        Application.ProcessMessages;
      end;
      //--Заканчиваем добаление записей контактов в Ростер
      RosterForm.RosterJvListView.Items.EndUpdate;
      //--Запускаем обработку Ростера
      RosterForm.UpdateFullCL;
    end;
  finally
    Free();
  end;
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

end.

