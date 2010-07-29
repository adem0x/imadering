{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MraProtoUnit;

interface

{$REGION 'Uses'}
uses
  Windows,
  MainUnit,
  MraOptionsUnit,
  SysUtils,
  JvTrayIcon,
  Dialogs,
  OverbyteIcsWSocket,
  ChatUnit,
  MmSystem,
  Forms,
  ComCtrls,
  Messages,
  Classes,
  IcqContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  JvSimpleXml;
{$ENDREGION}
{$REGION 'Const'}
const
  // Длинна заголовка в MRA пакетах
  MRA_FLAP_HEAD_SIZE = 44;
  // Пустой набор from и fromport и 16 ресерв
  MRA_Empty = '000000000000000000000000000000000000000000000000';
  // Магический ключ пакетов MRA
  MRA_MagKey = 'EFBEADDE';
  // Версия протокола пакетов MRA
  MRA_ProtoVer = '13000100';

{$ENDREGION}
{$REGION 'Array Status Codes'}
  // Иконки для статусов
  MRA_Status_Icons:
    packed array[0..52] of record
    Status_Code: string;
    XStatus_Code: string;
    Status_Img: Integer;
  end = ((Status_Code: '01000000'; XStatus_Code: 'status_1'; Status_Img: 24), // 0
    (Status_Code: '02000000'; XStatus_Code: 'status_2'; Status_Img: 22), // 1
    (Status_Code: '03000000'; XStatus_Code: ''; Status_Img: 312), // 2
    (Status_Code: '04000000'; XStatus_Code: 'status_chat'; Status_Img: 26), // 3
    (Status_Code: '04000000'; XStatus_Code: 'status_dnd'; Status_Img: 27), // 4
    (Status_Code: '04000000'; XStatus_Code: 'status_4'; Status_Img: 63), // 5
    (Status_Code: '04000000'; XStatus_Code: 'status_5'; Status_Img: 292), // 6
    (Status_Code: '04000000'; XStatus_Code: 'status_6'; Status_Img: 294), // 7
    (Status_Code: '04000000'; XStatus_Code: 'status_7'; Status_Img: 88), // 8
    (Status_Code: '04000000'; XStatus_Code: 'status_8'; Status_Img: 73), // 9
    (Status_Code: '04000000'; XStatus_Code: 'status_9'; Status_Img: 97), // 10
    (Status_Code: '04000000'; XStatus_Code: 'status_10'; Status_Img: 295), // 11
    (Status_Code: '04000000'; XStatus_Code: 'status_11'; Status_Img: 111), // 12
    (Status_Code: '04000000'; XStatus_Code: 'status_12'; Status_Img: 109), // 13
    (Status_Code: '04000000'; XStatus_Code: 'status_13'; Status_Img: 110), // 14
    (Status_Code: '04000000'; XStatus_Code: 'status_14'; Status_Img: 72), // 15
    (Status_Code: '04000000'; XStatus_Code: 'status_15'; Status_Img: 46), // 16
    (Status_Code: '04000000'; XStatus_Code: 'status_16'; Status_Img: 60), // 17
    (Status_Code: '04000000'; XStatus_Code: 'status_17'; Status_Img: 101), // 18
    (Status_Code: '04000000'; XStatus_Code: 'status_18'; Status_Img: 56), // 19
    (Status_Code: '04000000'; XStatus_Code: 'status_19'; Status_Img: 53), // 20
    (Status_Code: '04000000'; XStatus_Code: 'status_20'; Status_Img: 49), // 21
    (Status_Code: '04000000'; XStatus_Code: 'status_21'; Status_Img: 54), // 22
    (Status_Code: '04000000'; XStatus_Code: 'status_22'; Status_Img: 293), // 23
    (Status_Code: '04000000'; XStatus_Code: 'status_23'; Status_Img: 47), // 24
    (Status_Code: '04000000'; XStatus_Code: 'status_24'; Status_Img: 59), // 25
    (Status_Code: '04000000'; XStatus_Code: 'status_26'; Status_Img: 61), // 26
    (Status_Code: '04000000'; XStatus_Code: 'status_27'; Status_Img: 94), // 27
    (Status_Code: '04000000'; XStatus_Code: 'status_28'; Status_Img: 62), // 28
    (Status_Code: '04000000'; XStatus_Code: 'status_29'; Status_Img: 58), // 29
    (Status_Code: '04000000'; XStatus_Code: 'status_30'; Status_Img: 116), // 30
    (Status_Code: '04000000'; XStatus_Code: 'status_32'; Status_Img: 117), // 31
    (Status_Code: '04000000'; XStatus_Code: 'status_33'; Status_Img: 118), // 32
    (Status_Code: '04000000'; XStatus_Code: 'status_34'; Status_Img: 291), // 33
    (Status_Code: '04000000'; XStatus_Code: 'status_35'; Status_Img: 122), // 34
    (Status_Code: '04000000'; XStatus_Code: 'status_36'; Status_Img: 123), // 35
    (Status_Code: '04000000'; XStatus_Code: 'status_37'; Status_Img: 124), // 36
    (Status_Code: '04000000'; XStatus_Code: 'status_38'; Status_Img: 290), // 37
    (Status_Code: '04000000'; XStatus_Code: 'status_39'; Status_Img: 126), // 38
    (Status_Code: '04000000'; XStatus_Code: 'status_40'; Status_Img: 76), // 39
    (Status_Code: '04000000'; XStatus_Code: 'status_41'; Status_Img: 64), // 40
    (Status_Code: '04000000'; XStatus_Code: 'status_42'; Status_Img: 127), // 41
    (Status_Code: '04000000'; XStatus_Code: 'status_43'; Status_Img: 128), // 42
    (Status_Code: '04000000'; XStatus_Code: 'status_44'; Status_Img: 130), // 43
    (Status_Code: '04000000'; XStatus_Code: 'status_45'; Status_Img: 131), // 44
    (Status_Code: '04000000'; XStatus_Code: 'status_46'; Status_Img: 296), // 45
    (Status_Code: '04000000'; XStatus_Code: 'status_47'; Status_Img: 90), // 46
    (Status_Code: '04000000'; XStatus_Code: 'status_48'; Status_Img: 113), // 47
    (Status_Code: '04000000'; XStatus_Code: 'status_49'; Status_Img: 129), // 48
    (Status_Code: '04000000'; XStatus_Code: 'status_50'; Status_Img: 132), // 49
    (Status_Code: '04000000'; XStatus_Code: 'status_51'; Status_Img: 106), // 50
    (Status_Code: '04000000'; XStatus_Code: 'status_52'; Status_Img: 107), // 51
    (Status_Code: '04000000'; XStatus_Code: 'status_53'; Status_Img: 55)); // 52
{$ENDREGION}
{$REGION 'Array Pkt Codes'}

  // Расшифровка пакетов для лога
  MRA_Pkt_Names:
    packed array[0..30] of record
    Pkt_Code: Integer;
    Pkt_Name: string;
  end = ((Pkt_Code: $1001; Pkt_Name: 'HELLO'), // 0
    (Pkt_Code: $1002; Pkt_Name: 'HELLO_ACK'), // 1
    (Pkt_Code: $1004; Pkt_Name: 'LOGIN_ACK'), // 2
    (Pkt_Code: $1005; Pkt_Name: 'LOGIN_REJ'), // 3
    (Pkt_Code: $1006; Pkt_Name: 'PING'), // 4
    (Pkt_Code: $1008; Pkt_Name: 'SEND_MESSAGE'), // 5
    (Pkt_Code: $1009; Pkt_Name: 'MESSAGE_ACK'), // 6
    (Pkt_Code: $1011; Pkt_Name: 'MESSAGE_RECV'), // 7
    (Pkt_Code: $1012; Pkt_Name: 'MESSAGE_STATUS'), // 8
    (Pkt_Code: $100F; Pkt_Name: 'USER_STATUS'), // 9
    (Pkt_Code: $1013; Pkt_Name: 'LOGOUT'), // 10
    (Pkt_Code: $1014; Pkt_Name: 'CONNECTION_PARAMS'), // 11
    (Pkt_Code: $1015; Pkt_Name: 'USER_INFO'), // 12
    (Pkt_Code: $1019; Pkt_Name: 'ADD_CONTACT'), // 13
    (Pkt_Code: $101A; Pkt_Name: 'ADD_CONTACT_ACK'), // 14
    (Pkt_Code: $101B; Pkt_Name: 'MODIFY_CONTACT'), // 15
    (Pkt_Code: $101C; Pkt_Name: 'MODIFY_CONTACT_ACK'), // 16
    (Pkt_Code: $101D; Pkt_Name: 'OFFLINE_MESSAGE_ACK'), // 17
    (Pkt_Code: $101E; Pkt_Name: 'DELETE_OFFLINE_MESSAGE'), // 18
    (Pkt_Code: $1020; Pkt_Name: 'AUTHORIZE'), // 19
    (Pkt_Code: $1021; Pkt_Name: 'AUTHORIZE_ACK'), // 20
    (Pkt_Code: $1022; Pkt_Name: 'CHANGE_STATUS'), // 21
    (Pkt_Code: $1024; Pkt_Name: 'GET_MPOP_SESSION'), // 22
    (Pkt_Code: $1025; Pkt_Name: 'MPOP_SESSION'), // 23
    (Pkt_Code: $1026; Pkt_Name: 'FILE_TRANSFER'), // 24
    (Pkt_Code: $1027; Pkt_Name: 'FILE_TRANSFER_ACK'), // 25
    (Pkt_Code: $1029; Pkt_Name: 'WP_REQUEST'), // 26
    (Pkt_Code: $1028; Pkt_Name: 'ANKETA_INFO'), // 27
    (Pkt_Code: $1033; Pkt_Name: 'MAILBOX_STATUS'), // 28
    (Pkt_Code: $1037; Pkt_Name: 'CONTACT_LIST2'), // 29
    (Pkt_Code: $1038; Pkt_Name: 'LOGIN2')); // 30

{$ENDREGION}
{$REGION 'Vars'}

var
  MRA_Bos_IP: string;
  MRA_Bos_Port: string;
  MRA_myBeautifulSocketBuffer: string;
  MRA_LoginServerAddr: string;
  MRA_LoginServerPort: string;
  MRA_BuffPkt: string;
  MRA_LoginUIN: string;
  MRA_LoginPassword: string;
  MRA_Ident_Client: string = 'client="IMadering" version="5.0" build="0224"';
  MRA_Ident: string = 'IMR 5.0 (build 0224);';
  MRA_Seq: LongWord = 1;
  // Фазы работы начало
  MRA_Connect_Phaze: Boolean = False;
  MRA_HTTP_Connect_Phaze: Boolean = False;
  MRA_BosConnect_Phaze: Boolean = False;
  MRA_Work_Phaze: Boolean = False;
  MRA_Offline_Phaze: Boolean = True;
  // Фазы работы конец
  MRA_CurrentStatus: Integer = 23;
  MRA_CurrentStatus_bac: Integer = 23;
  MRA_Reconnect: Boolean = False;
  // Другие переменные протокола
  MRA_Bos_Addr: string;
  MRA_Server_Proto_Ver: string;
  MRA_Email_Total: string;
  MRA_Email_Unread: string;
  MRA_MyNick: string;

{$ENDREGION}
{$REGION 'Procedures and Functions'}

procedure MRA_Login_1;
procedure MRA_Login_2;
procedure MRA_AlivePkt;
procedure MRA_ParseUserInfo(PktData: string);
procedure MRA_ParseCL(PktData: string);
procedure MRA_SendMessage(ToEmail, Msg: string);
procedure MRA_MessageRecv(PktData: string);
procedure MRA_SendMessageACK(ToEmail, M_Id: string);
procedure MRA_ParseStatus(PktData: string);
procedure MRA_ParseOfflineMess(PktData: string);
procedure MRA_SendSMS(ToPhone, Mess: string);
procedure MRA_GoOffline;

{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  LogUnit,
  OverbyteIcsUrl,
  RosterUnit;

{$ENDREGION}
{$REGION 'MRA_Login_1'}

procedure MRA_Login_1;
var
  Pkt: string;
begin
  // Формируем пакет первичного логина
  Pkt := MRA_Empty;
  // Отправляем пакет
  Mra_SendPkt('01100000', Pkt, True);
end;

{$ENDREGION}
{$REGION 'MRA_Login_2'}

procedure MRA_Login_2;
var
  Pkt: string;
begin
  // Формируем пакет авторизации на сервере
  Pkt := MRA_Empty + IntToHex(Swap32(Length(MRA_LoginUIN)), 8) + Text2Hex(MRA_LoginUIN) // Логин
  + IntToHex(Swap32(Length(MRA_LoginPassword)), 8) + Text2Hex(MRA_LoginPassword) // Пароль
  + '010000000d0000005354415455535f4f4e4c494e450c0000004f006e006c0069006e00650000000000ff030000' // Пока фиксированная строка статуса при подключении
  + IntToHex(Swap32(Length(MRA_Ident_Client)), 8) + Text2Hex(MRA_Ident_Client) // Идентификатор клиента
  + '02000000' + Text2Hex(V_CurrentLang) // Язык
  + IntToHex(Swap32(Length(MRA_Ident)), 8) + Text2Hex(MRA_Ident); // Официальный идентификатор
  // Отправляем пакет
  Mra_SendPkt('38100000', Pkt, False);
end;

{$ENDREGION}
{$REGION 'MRA_SendMessage'}

procedure MRA_SendMessage(ToEmail, Msg: string);
var
  Pkt: string;
begin
  Pkt := MRA_Empty + '00001000' + IntToHex(Swap32(Length(ToEmail)), 8) + Text2Hex(ToEmail) // Флаг мультисообщения и кому
  + IntToHex(Swap32(Length(Msg) * SizeOf(Char)), 8) + Text2UnicodeLEHex(Msg) + '00000000'; // тест сообщения в UnicodeLE и пустой rtf
  // Отправляем пакет
  Mra_SendPkt('08100000', Pkt, False);
end;

{$ENDREGION}
{$REGION 'MRA_MessageRecv'}

procedure MRA_MessageRecv(PktData: string);
var
  S_Log, M_Id, M_Flag, M_From, Nick, Mess, MsgD, PopMsg, HistoryFile: string;
  Len: Integer;
  RosterItem: TListItem;
begin
  // Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    Application.CreateForm(TChatForm, ChatForm);
  // Получаем Id сообщения
  M_Id := Text2Hex(NextData(PktData, 4));
  // Получаем флаг сообщения
  { #define MESSAGE_FLAG_OFFLINE		0001
    #define MESSAGE_FLAG_NORECV		  0004
    #define MESSAGE_FLAG_AUTHORIZE	0008
    #define MESSAGE_FLAG_SYSTEM		  0040
    #define MESSAGE_FLAG_RTF		    0080
    #define MESSAGE_FLAG_CONTACT		0200
    #define MESSAGE_FLAG_NOTIFY		  0400
    #define MESSAGE_FLAG_MULTICAST	1000
    #define MESSAGE_FLAG_NOTIFY		  3000 }
  M_Flag := RightStr(Text2Hex(NextData(PktData, 4)), 4);
  // Получаем отправителя сообщения
  Len := HexToInt(Text2Hex(NextData(PktData, 4)));
  Len := Swap32(Len);
  M_From := NextData(PktData, Len);
  // Получаем текст сообщения
  if (M_Flag = '0001') or (M_Flag = '0004') or (M_Flag = '0040') or (M_Flag = '0080') or (M_Flag = '1000') then
  begin
    Len := HexToInt(Text2Hex(NextData(PktData, 4)));
    Len := Swap32(Len);
    Mess := Text2XML(UnicodeLEHex2Text(Text2Hex(NextData(PktData, Len))));
  end;
  // Обрабатываем сообщение и отображаем
  if (M_From <> EmptyStr) and (Mess <> EmptyStr) then
  begin
    // Отсылаем подтверждение о доставке
    if (M_Flag <> '0004') and (M_Flag <> '0400') and (M_Flag <> '3000') then
      MRA_SendMessageACK(M_From, M_Id);
    // Форматируем сообщение
    CheckMessage_BR(Mess);
    ChatForm.CheckMessage_ClearTag(Mess);
    PopMsg := Mess;
    // Ищем эту запись в Ростере
    {RosterItem := RosterForm.ReqRosterItem(M_From);
    if RosterItem <> nil then
    begin
      // Выставляем параметры сообщения в этой записи
      with RosterItem do
      begin
        // Ник контакта из Ростера
        Nick := URLDecode(SubItems[0]);
        // Дата сообщения
        MsgD := Nick + ' [' + DateTimeChatMess + ']';
        // Записываем историю в этот контакт если он уже найден в списке контактов
        SubItems[15] := URLEncode(PopMsg);
        SubItems[35] := '0';
      end;
    end
    else // Если такой контакт не найден в Ростере, то добавляем его
    begin
      // Если ник не нашли в Ростере, то ищем его в файле-кэше ников
      Nick := SearchNickInCash(C_Mra, M_From);
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
        Caption := M_From;
        // Подготавиливаем все значения
        RosterForm.RosterItemSetFull(RosterItem);
        // Обновляем субстроки
        SubItems[0] := URLEncode(Nick);
        SubItems[1] := C_NoCL;
        SubItems[2] := 'none';
        SubItems[3] := C_Mra;
        SubItems[6] := '25';
        SubItems[15] := URLEncode(PopMsg);
        SubItems[35] := '0';
      end;
      // Запускаем таймер задержку событий Ростера
      MainForm.JvTimerList.Events[11].Enabled := False;
      MainForm.JvTimerList.Events[11].Enabled := True;
    end;}
    // Записываем история в файл истории с этим контактов
    HistoryFile := V_ProfilePath + C_HistoryFolder + C_Mra + C_BN + MRA_LoginUIN + C_BN + M_From + C_HtmExt;
    Mess := Text2XML(Mess);
    CheckMessage_BR(Mess);
    DecorateURL(Mess);
    SaveTextInHistory(Format(C_HistoryIn, [MsgD, Mess]), HistoryFile);
    // Добавляем сообщение в текущий чат
    {RosterItem.SubItems[36] := 'X';
    if ChatForm.AddMessInActiveChat(Nick, PopMsg, M_From, MsgD, Mess) then
      RosterItem.SubItems[36] := EmptyStr;}
  end;
  // Пишем в лог
  S_Log := S_Log + 'Id: ' + M_Id + C_LN + 'Flag: ' + M_Flag + C_LN + 'From: ' + M_From + C_LN + 'Text: ' + Mess;
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[6].Pkt_Name + C_RN + Trim(S_Log), C_Mra);
end;

{$ENDREGION}
{$REGION 'MRA_SendMessageACK'}

procedure MRA_SendMessageACK(ToEmail, M_Id: string);
var
  Pkt: string;
begin
  // Формируем пакет подтверждения о получении сообщения
  Pkt := MRA_Empty + IntToHex(Swap32(Length(ToEmail)), 8) + Text2Hex(ToEmail) // Кому отсылаем подтверждение
  + M_Id;
  // Отправляем пакет
  Mra_SendPkt('11100000', Pkt, False);
end;

{$ENDREGION}
{$REGION 'MRA_SendSMS'}

procedure MRA_SendSMS(ToPhone, Mess: string);
var
  Pkt: string;
begin
  // Формируем пакет подтверждения о получении сообщения
  Pkt := MRA_Empty + '00000000' + IntToHex(Swap32(Length(ToPhone)), 8) + Text2Hex(ToPhone) // Кому отсылаем Телефон +7...
  + IntToHex(Swap32(Length(Mess) * SizeOf(Char)), 8) + Text2UnicodeLEHex(Mess); // Текст SMS сообщения 41 символ
  // Отправляем пакет
  Mra_SendPkt('39100000', Pkt, False);
end;

{$ENDREGION}
{$REGION 'MRA_AlivePkt'}

procedure MRA_AlivePkt;
var
  Pkt: string;
begin
  // Формируем пакет Ping
  Pkt := MRA_Empty;
  // Отправляем пакет
  Mra_SendPkt('06100000', Pkt, True);
end;

{$ENDREGION}
{$REGION 'MRA_ParseUserInfo'}

procedure MRA_ParseUserInfo(PktData: string);
var
  S_Log, S: string;
  Len: Integer;

  function GetLastLS: string;
  var
    Len: Integer;
    S: string;
  begin
    Result := EmptyStr;
    Len := HexToInt(Text2Hex(NextData(PktData, 4)));
    Len := Swap32(Len);
    S := NextData(PktData, Len);
    if IsValidUnicode(S, True) then
      S := UnicodeLEHex2Text(Text2Hex(S));
    Result := S;
  end;

begin
  // Разбираем все данные пакета
  while Length(PktData) > 0 do
  begin
    // Получаем текущие данные
    S := GetLastLS;
    // Для лога
    S_Log := S_Log + S + C_RN;
    // Получаем информацию
    if S = 'MESSAGES.TOTAL' then
    begin
      MRA_Email_Total := GetLastLS;
      S_Log := S_Log + MRA_Email_Total + C_RN;
    end
    else if S = 'MESSAGES.UNREAD' then
    begin
      MRA_Email_Unread := GetLastLS;
      S_Log := S_Log + MRA_Email_Unread + C_RN;
      // Сообщаем всплывашкой сколько Email сообщений
      if MRA_Email_Unread <> '0' then
        DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[59].L_S, [MRA_Email_Unread, MRA_Email_Total]), EmptyStr, 133, 3, 60000);
    end
    else if S = 'MRIM.NICKNAME' then
    begin
      MRA_MyNick := GetLastLS;
      S_Log := S_Log + MRA_MyNick + C_RN;
    end;
  end;
  // Пишем в лог данные пакета
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[12].Pkt_Name + C_RN + Trim(S_Log), C_Mra);
end;

{$ENDREGION}
{$REGION 'MRA_ParseCL'}

procedure MRA_ParseCL(PktData: string);
const
  Mask_u = 'u';
  Mask_s = 's';

var
  UL, S_Log, GMask, KMask, GId, GName, KEmail, KPhone: string;
  KStatus, KXStatus, KXText, KClient, KGeo, GeoPkt, Unk: string;
  I, M, Len, GCount: Integer;
  KAuth: Boolean;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Получаем ошибки списка контактов
  UL := Text2Hex(NextData(PktData, 4));
  S_Log := S_Log + 'UL: ' + UL + C_RN;
  // Если ошибок в списке контактов нет
  if UL = '00000000' then
  begin
    // Начинаем добаление записей контактов в Ростер
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          // Очищаем раздел MRA если он есть
          XML_Node := Root.Items.ItemNamed[C_Mra];
          if XML_Node <> nil then
            XML_Node.Clear
          else
            XML_Node := Root.Items.Add(C_Mra);
          // Получаем количество групп
          GCount := HexToInt(Text2Hex(NextData(PktData, 4)));
          GCount := Swap32(GCount);
          S_Log := S_Log + C_Group + C_BN + C_Count + C_TN + C_BN + IntToStr(GCount) + C_RN;
          // Получаем маску группы
          Len := HexToInt(Text2Hex(NextData(PktData, 4)));
          Len := Swap32(Len);
          GMask := NextData(PktData, Len);
          S_Log := S_Log + C_Group + C_BN + C_Mask + C_TN + C_BN + GMask + C_RN;
          // Получаем маску контакта
          Len := HexToInt(Text2Hex(NextData(PktData, 4)));
          Len := Swap32(Len);
          KMask := NextData(PktData, Len);
          S_Log := S_Log + C_Contact + C_BN + C_Mask + C_TN + C_BN + KMask + C_RN;
          // В цикле получаем группы
          Sub_Node := XML_Node.Items.Add(C_Group + C_SS);
          for I := 0 to GCount - 1 do
          begin
            GId := EmptyStr;
            GName := EmptyStr;
            Unk := EmptyStr;
            for M := 1 to Length(GMask) do
            begin
              case GMask[M] of
                Mask_u:
                  begin
                    if M = 1 then
                      GId := Text2Hex(NextData(PktData, 4))
                    else
                      Unk := Unk + C_QN + Mask_u + IntToStr(M) + C_EN + C_BN + Text2Hex(NextData(PktData, 4)) + C_LN + C_BN;
                  end;
                Mask_s:
                  begin
                    Len := HexToInt(Text2Hex(NextData(PktData, 4)));
                    Len := Swap32(Len);
                    if M = 2 then
                      GName := UnicodeLEHex2Text(Text2Hex(NextData(PktData, Len)))
                    else
                      Unk := Unk + C_QN + Mask_s + IntToStr(M) + C_EN + C_BN + Text2Hex(NextData(PktData, Len)) + C_LN + C_BN;
                  end;
              end;
            end;
            // Записываем в Ростер
            Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + IntToStr(I));
            Tri_Node.Properties.Add(C_Name, URLEncode(GName));
            Tri_Node.Properties.Add(C_Id, GId);
            // Заполняем лог
            S_Log := S_Log + C_Group + C_BN + C_PN + C_BN + C_Id + C_TN + C_BN + GId + C_LN + C_BN + C_Name + C_TN + C_BN + GName + C_LN + C_BN + C_Unk + C_TN + C_BN + Unk + C_RN;
          end;
          // Добавляем группу для телефонных контактов
          Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_Phone);
          Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[34].L_S));
          Tri_Node.Properties.Add(C_Id, LeftStr(C_Phone, 4));
          // Добавляем группу контактов с ошибочным идентификатором группы
          Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_AuthNone);
          Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[7].L_S));
          Tri_Node.Properties.Add(C_Id, C_AuthNone);
          // Получаем контакты
          Sub_Node := XML_Node.Items.Add(C_Contact + C_SS);
          I := -1;
          while Length(PktData) > 0 do
          begin
            Inc(I);
            GId := EmptyStr;
            KEmail := EmptyStr;
            GName := EmptyStr;
            KAuth := True;
            KStatus := EmptyStr;
            KXStatus := EmptyStr;
            KXText := EmptyStr;
            KClient := EmptyStr;
            KGeo := EmptyStr;
            GeoPkt := EmptyStr;
            Unk := EmptyStr;
            for M := 1 to Length(KMask) do
            begin
              case KMask[M] of
                Mask_u:
                  begin
                    if M = 2 then
                      GId := Text2Hex(NextData(PktData, 4))
                    else if M = 5 then
                    begin
                      if Text2Hex(NextData(PktData, 4)) = '01000000' then
                        KAuth := False;
                    end
                    else if M = 6 then
                      KStatus := Text2Hex(NextData(PktData, 4))
                    else
                      Unk := Unk + C_QN + Mask_u + IntToStr(M) + C_EN + C_BN + Text2Hex(NextData(PktData, 4)) + C_LN + C_BN;
                  end;
                Mask_s:
                  begin
                    Len := HexToInt(Text2Hex(NextData(PktData, 4)));
                    Len := Swap32(Len);
                    if M = 3 then
                      KEmail := NextData(PktData, Len)
                    else if M = 4 then
                      GName := UnicodeLEHex2Text(Text2Hex(NextData(PktData, Len)))
                    else if M = 7 then
                      KPhone := NextData(PktData, Len)
                    else if M = 8 then
                      KXStatus := NextData(PktData, Len)
                    else if M = 9 then
                      KXText := UnicodeLEHex2Text(Text2Hex(NextData(PktData, Len)))
                    else if M = 12 then
                      KClient := NextData(PktData, Len)
                    else if M = 19 then
                    begin
                      GeoPkt := NextData(PktData, Len);
                      // Разбираем GEO инфу контакта

                    end
                    else
                      Unk := Unk + C_QN + Mask_s + IntToStr(M) + C_EN + C_BN + Text2Hex(NextData(PktData, Len)) + C_LN + C_BN;
                  end;
              end;
            end;
            // Записываем в Ростер
            Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(I));
            if KEmail = C_Phone then
            begin
              Tri_Node.Properties.Add(C_Email, URLEncode(KEmail + C_TN + KPhone));
              Tri_Node.Properties.Add(C_Group + C_Id, LeftStr(C_Phone, 4));
              Tri_Node.Properties.Add(C_Status, 275);
            end
            else
            begin
              Tri_Node.Properties.Add(C_Email, URLEncode(KEmail));
              Tri_Node.Properties.Add(C_Group + C_Id, IntToHex(Swap32(HexToInt(GId)), 4));
            end;
            Tri_Node.Properties.Add(UpCaseOne(C_Nick), URLEncode(GName));
            if KEmail <> C_Phone then
            begin
              if KAuth then
              begin
                Tri_Node.Properties.Add(UpCaseOne(C_Auth), C_AuthBoth);
                Tri_Node.Properties.Add(C_Status, 23);
                Tri_Node.Properties.Add(C_Client, -1);
              end
              else
              begin
                Tri_Node.Properties.Add(UpCaseOne(C_Auth), C_AuthNone);
                Tri_Node.Properties.Add(C_Status, 25);
                Tri_Node.Properties.Add(C_Client, 220);
              end;
            end;
            Tri_Node.Properties.Add(UpCaseOne(C_Phone), URLEncode(KPhone));
            Tri_Node.Properties.Add(C_XStatus, URLEncode(KXStatus));
            Tri_Node.Properties.Add(C_XText, URLEncode(KXText));
            Tri_Node.Properties.Add(C_Client + C_Name, URLEncode(KClient));
            Tri_Node.Properties.Add(C_Geo, URLEncode(KGeo));
            // Заполняем лог
            S_Log := S_Log + C_Contact + C_BN + C_PN + C_BN + C_Group + C_Id + C_TN + C_BN + GId + C_LN + C_BN + C_Email + C_TN + C_BN + KEmail + C_LN //
            + C_BN + UpCaseOne(C_Nick) + C_TN + C_BN + GName + C_LN + C_BN + UpCaseOne(C_Auth) + C_TN + C_BN + BoolToStr(KAuth) + C_LN + C_BN + C_Status //
            + C_TN + C_BN + KStatus + C_LN + C_BN + UpCaseOne(C_Phone) + C_TN + C_BN + KPhone + C_LN + C_BN + C_XStatus + C_TN + C_BN + KXStatus //
            + C_LN + C_BN + C_XText + C_TN + C_BN + KXText + C_LN + C_BN + C_Client + C_Name + C_TN + C_BN + KClient + C_LN + C_BN //
            + C_Geo + C_TN + C_BN + Text2Hex(GeoPkt) + C_LN + C_BN + C_Unk + C_TN + C_BN + Unk + C_RN;
          end;
          // Запускаем обработку Ростера
          V_CollapseGroupsRestore := True;
          UpdateFullCL;
        end;
      end;
    end;
  end;
  // Пишем в лог данные пакета
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[29].Pkt_Name + C_RN + Trim(S_Log), C_Mra);
end;
{$ENDREGION}
{$REGION 'MRA_GoOffline'}

procedure MRA_GoOffline;
var
  I: Integer;
begin
  // Отключаем таймер факстатуса, пингов
  MainForm.UnstableMRAStatus.Checked := False;
  with MainForm.JvTimerList do
  begin
    Events[10].Enabled := False;
  end;
  // Если существует форма настроек протокола MRA, то блокируем там контролы
  if Assigned(MraOptionsForm) then
  begin
    with MraOptionsForm do
    begin
      MRAEmailEdit.Enabled := True;
      MRAEmailEdit.Color := ClWindow;
      PassEdit.Enabled := True;
      PassEdit.Color := ClWindow;
      MRAEmailComboBox.Enabled := True;
    end;
  end;
  // Активируем фазу оффлайн и обнуляем буферы пакетов
  MRA_Connect_Phaze := False;
  MRA_HTTP_Connect_Phaze := False;
  MRA_BosConnect_Phaze := False;
  MRA_Work_Phaze := False;
  MRA_Offline_Phaze := True;
  MRA_myBeautifulSocketBuffer := EmptyStr;
  MRA_BuffPkt := EmptyStr;
  // Отключаем сокет
  with MainForm do
  begin
    MRAWSocket.Abort;
    // Ставим иконку и значение статуса оффлайн
    MRA_CurrentStatus := 23;
    MRAToolButton.ImageIndex := MRA_CurrentStatus;
    // Подсвечиваем в меню статуса MRA статус оффлайн
    MRAStatusOffline.default := True;
  end;
  // Обнуляем счётчики пакетов
  MRA_Seq := 1;
  // Обнуляем события и переменные в Ростере
  {with RosterForm.RosterJvListView do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      if Items[I].SubItems[3] = C_Mra then
      begin
        if Items[I].SubItems[6] <> '275' then
          Items[I].SubItems[6] := '23';
        Items[I].SubItems[7] := '-1';
        Items[I].SubItems[8] := '-1';
        Items[I].SubItems[15] := '';
        Items[I].SubItems[16] := '';
        Items[I].SubItems[18] := '0';
        Items[I].SubItems[19] := '0';
        Items[I].SubItems[35] := '0';
      end;
    end;
  end;
  // Запускаем обработку Ростера
  RosterForm.UpdateFullCL;}
end;

{$ENDREGION}
{$REGION 'MRA_ParseStatus'}

procedure MRA_ParseStatus(PktData: string);
var
  S_Log, StatusCode, XStatusCode, XStatusText, KEmail, Unk: string;
  Len: Integer;

  function GetLastLS: string;
  var
    Len: Integer;
    S: string;
  begin
    Result := EmptyStr;
    Len := HexToInt(Text2Hex(NextData(PktData, 4)));
    Len := Swap32(Len);
    S := NextData(PktData, Len);
    if IsValidUnicode(S, True) then
      S := UnicodeLEHex2Text(Text2Hex(S));
    Result := S;
  end;

begin
  // Получаем код статуса
  StatusCode := Text2Hex(NextData(PktData, 4));
  S_Log := S_Log + C_Status + C_TN + C_BN + StatusCode + C_RN;
  // Получаем код дополнительного статуса
  XStatusCode := GetLastLS;
  S_Log := S_Log + C_XStatus + C_TN + C_BN + XStatusCode + C_RN;
  // Получаем подпись дополнительного статуса
  XStatusText := GetLastLS;
  S_Log := S_Log + C_XText + C_TN + C_BN + XStatusText + C_RN;
  // Получаем неизвестные данные
  Unk := GetLastLS;
  S_Log := S_Log + C_Unk + C_TN + C_BN + Unk + C_RN;
  // Получаем Email от кого пришёл статус
  KEmail := GetLastLS;
  S_Log := S_Log + C_Email + C_TN + C_BN + KEmail + C_RN;

  // Пишем в лог данные пакета
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[9].Pkt_Name + C_RN + Trim(S_Log), C_Mra);
end;
{$ENDREGION}
{$REGION 'MRA_ParseOfflineMess'}

procedure MRA_ParseOfflineMess(PktData: string);
begin

end;

{$ENDREGION}

end.

