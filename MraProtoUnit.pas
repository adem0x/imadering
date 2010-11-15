﻿{ *******************************************************************************
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
  Messages,
  Classes,
  ContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  JvSimpleXml,
  StrUtils,
  OverbyteIcsMimeUtils;
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

  // Коды приватности
  MRA_Privat_Normal = '00'; // нормальный
  MRA_Privat_Invisible = '04'; // невидящий
  MRA_Privat_Visible = '08'; // видящий
  MRA_Privat_Ignore = '10'; // игнорируемый
  MRA_Privat_Ignore_Invisible = '14'; // игнорируемый и невидящий
  MRA_Privat_Ignore_Visible = '18'; // игнорируемый и видящий

{$ENDREGION}
{$REGION 'MRA_Client_Icons'}
  MRA_Client_Icons:
    packed array[0..13] of record
    Client_Name: string;
    Client_Img: string;
  end = ((Client_Name: 'imadering'; Client_Img: '0'), // 0
    (Client_Name: 'qip infium'; Client_Img: '103'), // 1
    (Client_Name: 'qip 2010'; Client_Img: '103'), // 2
    (Client_Name: 'qip pda'; Client_Img: '99'), // 3
    (Client_Name: 'miranda'; Client_Img: '98'), // 4
    (Client_Name: 'jimm'; Client_Img: '102'), // 5
    (Client_Name: 'webagent'; Client_Img: '125'), // 6
    (Client_Name: 'jagent'; Client_Img: '105'), // 7
    (Client_Name: 'sagent'; Client_Img: '105'), // 8
    (Client_Name: 'wmagent'; Client_Img: '105'), // 9
    (Client_Name: 'qutim'; Client_Img: '104'), // 10
    (Client_Name: 'magent'; Client_Img: '311'), // 11
    (Client_Name: 'agent'; Client_Img: '311'), // 12
    (Client_Name: 'bayanicq'; Client_Img: '202')); // 13
{$ENDREGION}
{$REGION 'Array Status Codes'}
  // Иконки для статусов
  MRA_Status_Icons:
    packed array[0..59] of record
    Status_Code: string;
    XStatus_Code: string;
    Status_Img: string;
  end = ((Status_Code: '01000000'; XStatus_Code: 'status_1'; Status_Img: '24;-1'), // 0
    (Status_Code: '02000000'; XStatus_Code: 'status_2'; Status_Img: '22;-1'), // 1
    (Status_Code: '03000000'; XStatus_Code: ''; Status_Img: '312;-1'), // 2
    (Status_Code: '04000000'; XStatus_Code: 'status_chat'; Status_Img: '26;-1'), // 3
    (Status_Code: '04000000'; XStatus_Code: 'status_dnd'; Status_Img: '27;-1'), // 4
    (Status_Code: '04000000'; XStatus_Code: 'status_4'; Status_Img: '24;63'), // 5
    (Status_Code: '04000000'; XStatus_Code: 'status_5'; Status_Img: '292;-1'), // 6
    (Status_Code: '04000000'; XStatus_Code: 'status_6'; Status_Img: '294;-1'), // 7
    (Status_Code: '04000000'; XStatus_Code: 'status_7'; Status_Img: '24;88'), // 8
    (Status_Code: '04000000'; XStatus_Code: 'status_8'; Status_Img: '24;73'), // 9
    (Status_Code: '04000000'; XStatus_Code: 'status_9'; Status_Img: '24;97'), // 10
    (Status_Code: '04000000'; XStatus_Code: 'status_10'; Status_Img: '295;-1'), // 11
    (Status_Code: '04000000'; XStatus_Code: 'status_11'; Status_Img: '24;111'), // 12
    (Status_Code: '04000000'; XStatus_Code: 'status_12'; Status_Img: '24;109'), // 13
    (Status_Code: '04000000'; XStatus_Code: 'status_13'; Status_Img: '24;110'), // 14
    (Status_Code: '04000000'; XStatus_Code: 'status_14'; Status_Img: '24;72'), // 15
    (Status_Code: '04000000'; XStatus_Code: 'status_15'; Status_Img: '24;46'), // 16
    (Status_Code: '04000000'; XStatus_Code: 'status_16'; Status_Img: '24;60'), // 17
    (Status_Code: '04000000'; XStatus_Code: 'status_17'; Status_Img: '24;101'), // 18
    (Status_Code: '04000000'; XStatus_Code: 'status_18'; Status_Img: '24;56'), // 19
    (Status_Code: '04000000'; XStatus_Code: 'status_19'; Status_Img: '24;53'), // 20
    (Status_Code: '04000000'; XStatus_Code: 'status_20'; Status_Img: '24;49'), // 21
    (Status_Code: '04000000'; XStatus_Code: 'status_21'; Status_Img: '24;54'), // 22
    (Status_Code: '04000000'; XStatus_Code: 'status_22'; Status_Img: '293;-1'), // 23
    (Status_Code: '04000000'; XStatus_Code: 'status_23'; Status_Img: '24;47'), // 24
    (Status_Code: '04000000'; XStatus_Code: 'status_24'; Status_Img: '24;59'), // 25
    (Status_Code: '04000000'; XStatus_Code: 'status_26'; Status_Img: '24;61'), // 26
    (Status_Code: '04000000'; XStatus_Code: 'status_27'; Status_Img: '24;94'), // 27
    (Status_Code: '04000000'; XStatus_Code: 'status_28'; Status_Img: '24;62'), // 28
    (Status_Code: '04000000'; XStatus_Code: 'status_29'; Status_Img: '24;58'), // 29
    (Status_Code: '04000000'; XStatus_Code: 'status_30'; Status_Img: '24;116'), // 30
    (Status_Code: '04000000'; XStatus_Code: 'status_32'; Status_Img: '24;117'), // 31
    (Status_Code: '04000000'; XStatus_Code: 'status_33'; Status_Img: '24;118'), // 32
    (Status_Code: '04000000'; XStatus_Code: 'status_34'; Status_Img: '291;-1'), // 33
    (Status_Code: '04000000'; XStatus_Code: 'status_35'; Status_Img: '24;122'), // 34
    (Status_Code: '04000000'; XStatus_Code: 'status_36'; Status_Img: '24;123'), // 35
    (Status_Code: '04000000'; XStatus_Code: 'status_37'; Status_Img: '24;124'), // 36
    (Status_Code: '04000000'; XStatus_Code: 'status_38'; Status_Img: '290;-1'), // 37
    (Status_Code: '04000000'; XStatus_Code: 'status_39'; Status_Img: '24;126'), // 38
    (Status_Code: '04000000'; XStatus_Code: 'status_40'; Status_Img: '24;76'), // 39
    (Status_Code: '04000000'; XStatus_Code: 'status_41'; Status_Img: '24;64'), // 40
    (Status_Code: '04000000'; XStatus_Code: 'status_42'; Status_Img: '24;127'), // 41
    (Status_Code: '04000000'; XStatus_Code: 'status_43'; Status_Img: '24;128'), // 42
    (Status_Code: '04000000'; XStatus_Code: 'status_44'; Status_Img: '24;130'), // 43
    (Status_Code: '04000000'; XStatus_Code: 'status_45'; Status_Img: '24;131'), // 44
    (Status_Code: '04000000'; XStatus_Code: 'status_46'; Status_Img: '296;-1'), // 45
    (Status_Code: '04000000'; XStatus_Code: 'status_47'; Status_Img: '24;90'), // 46
    (Status_Code: '04000000'; XStatus_Code: 'status_48'; Status_Img: '24;113'), // 47
    (Status_Code: '04000000'; XStatus_Code: 'status_49'; Status_Img: '24;129'), // 48
    (Status_Code: '04000000'; XStatus_Code: 'status_50'; Status_Img: '24;132'), // 49
    (Status_Code: '04000000'; XStatus_Code: 'status_51'; Status_Img: '24;106'), // 50
    (Status_Code: '04000000'; XStatus_Code: 'status_52'; Status_Img: '24;107'), // 51
    (Status_Code: '04000000'; XStatus_Code: 'status_53'; Status_Img: '24;55'), // 52
    (Status_Code: '01000000'; XStatus_Code: 'status_online'; Status_Img: '24;-1'), // 53 old clients
    (Status_Code: '02000000'; XStatus_Code: 'status_away'; Status_Img: '22;-1'), // 54 old clients
    (Status_Code: '01000000'; XStatus_Code: ''; Status_Img: '24;-1'), // 55
    (Status_Code: '02000000'; XStatus_Code: ''; Status_Img: '22;-1'), // 56
    (Status_Code: '04000000'; XStatus_Code: ''; Status_Img: '24;-1'), // 57
    (Status_Code: '01000080'; XStatus_Code: ''; Status_Img: '21;-1'), // 58
    (Status_Code: '01000080'; XStatus_Code: 'status_invisible'; Status_Img: '21;-1')); // 59

{$ENDREGION}
{$REGION 'Array Pkt Codes'}

  // Расшифровка пакетов для лога
  MRA_Pkt_Names:
    packed array[0..32] of record
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
    (Pkt_Code: $1038; Pkt_Name: 'LOGIN2'), // 30
    (Pkt_Code: $1039; Pkt_Name: 'SEND_SMS'), // 31
    (Pkt_Code: $1040; Pkt_Name: 'SMS_ACK')); // 32

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
procedure MRA_MessageRecv(PktData: string; K_Email: string = ''; K_Mess: string = '');
procedure MRA_SendMessageACK(ToEmail, M_Id: string);
procedure MRA_ParseStatus(PktData: string);
procedure MRA_ParseOfflineMess(PktData: string);
procedure MRA_SendSMS(ToPhone, Mess: string);
procedure MRA_GoOffline;
function MRA_StatusCodeToImg(KStatusCode, KXStatusCode: string): string;
function MRA_ClientToImg(KClient: string): string;
procedure MRA_ParseSMS_ACK(PktData: string);
{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  LogUnit,
  OverbyteIcsUrl,
  RosterUnit;
{$ENDREGION}
{$REGION 'MRA_StatusCodeToImg'}

function MRA_StatusCodeToImg(KStatusCode, KXStatusCode: string): string;
var
  i: Integer;
  s: string;
begin
  // Преобразуем коды статусов контакта в иконки статусов
  Result := '23;-1';
  s := WideLowerCase(KXStatusCode);
  for I := low(MRA_Status_Icons) to high(MRA_Status_Icons) do
    if (MRA_Status_Icons[I].Status_Code = KStatusCode) and (MRA_Status_Icons[I].XStatus_Code = s) then
    begin
      Result := MRA_Status_Icons[I].Status_Img;
      Break;
    end;
end;
{$ENDREGION}
{$REGION 'MRA_ClientToImg'}

function MRA_ClientToImg(KClient: string): string;
var
  i: Integer;
  s: string;
begin
  // Определяем иконку клиента
  Result := '-1';
  s := WideLowerCase(KClient);
  for I := low(MRA_Client_Icons) to high(MRA_Client_Icons) do
    if Pos(MRA_Client_Icons[I].Client_Name, s) > 0 then
    begin
      Result := MRA_Client_Icons[I].Client_Img;
      Break;
    end;
end;
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

procedure MRA_MessageRecv(PktData: string; K_Email: string = ''; K_Mess: string = '');
label
  A;
var
  S_Log, M_Id, M_Flag, M_From, Nick, Mess, MsgD, PopMsg, HistoryFile: string;
  I, Len: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Contact_Yes: Boolean;
begin
  // Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    Application.CreateForm(TChatForm, ChatForm);
  // Обрабатываем уже готовые сообщения
  if (K_Email <> EmptyStr) and (K_Mess <> EmptyStr) then
  begin
    M_From := K_Email;
    Mess := Text2XML(K_Mess);
    goto A;
  end;
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
    #define MESSAGE_FLAG_PHONE    	2000
    #define MESSAGE_FLAG_NOTIFY		  3000 }
  M_Flag := RightStr(Text2Hex(NextData(PktData, 4)), 4);
  // Получаем отправителя сообщения
  Len := HexToInt(Text2Hex(NextData(PktData, 4)));
  Len := Swap32(Len);
  M_From := NextData(PktData, Len);
  // Получаем текст сообщения
  if (M_Flag = '0001') or (M_Flag = '0004') or (M_Flag = '0040') or (M_Flag = '0080') or (M_Flag = '1000') or (M_Flag = '2000') then
  begin
    Len := HexToInt(Text2Hex(NextData(PktData, 4)));
    Len := Swap32(Len);
    if M_Flag = '2000' then
      Mess := Text2XML(NextData(PktData, Len))
    else
      Mess := Text2XML(UnicodeLEHex2Text(Text2Hex(NextData(PktData, Len))));
  end;
  // Обрабатываем сообщение и отображаем
  if (M_From <> EmptyStr) and (Mess <> EmptyStr) then
  begin
    // Отсылаем подтверждение о доставке
    if (M_Flag <> '0004') and (M_Flag <> '0400') and (M_Flag <> '3000') then
      MRA_SendMessageACK(M_From, M_Id);
    // Форматируем сообщение
    A: ;
    CheckMessage_BR(Mess);
    ChatForm.CheckMessage_ClearTag(Mess);
    PopMsg := Mess;
    // Ищем этот контакт в Ростере
    Contact_Yes := False;
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          // Ищем раздел MRA
          XML_Node := Root.Items.ItemNamed[C_Mra];
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
                  // Если нашли этот контакт
                  if Tri_Node.Properties.Value(C_Login) = UrlEncode(M_From) then
                  begin
                    Contact_Yes := True;
                    // Записываем входяшее сообщение
                    RosterUpdateProp(Tri_Node, C_InMess, UrlEncode(Mess));
                    // Ник контакта из Ростера
                    Nick := URLDecode(Tri_Node.Properties.Value(C_Nick));
                    // Дата сообщения
                    MsgD := Nick + C_BN + C_QN + DateTimeChatMess + C_EN;
                    // Ставим метку о непрочитанном сообщении
                    RosterUpdateProp(Tri_Node, C_Mess, C_XX);
                    // Прерываем цикл
                    Break;
                  end;
                end;
              end;
              // Если контакт в Ростере не нашли
              if not Contact_Yes then
              begin
                // Ищем его Ник в файле-кэше ников
                Nick := SearchNickInCash(C_Mra, M_From);
                // Дата сообщения
                MsgD := Nick + C_BN + C_QN + DateTimeChatMess + C_EN;
                // Добавляем этот контакт в эту группу
                Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(M_From));
                Tri_Node.Properties.Add(C_Group + C_Id, C_NoCL);
                Tri_Node.Properties.Add(C_Status, 312);
                Tri_Node.Properties.Add(C_Nick, URLEncode(Nick));
                Tri_Node.Properties.Add(C_InMess, UrlEncode(Mess));
                Tri_Node.Properties.Add(C_Mess, C_XX);
              end;
            end;
          end;
        end;
      end;
    end;
    // Записываем история в файл истории с этим контактов
    HistoryFile := V_ProfilePath + C_HistoryFolder + C_Mra + C_BN + MRA_LoginUIN + C_BN + M_From + C_Htm_Ext;
    Mess := Text2XML(Mess);
    CheckMessage_BR(Mess);
    DecorateURL(Mess);
    SaveTextInHistory(Format(C_HistoryIn, [MsgD, Mess]), HistoryFile);
    // Добавляем сообщение в текущий чат
    if not ChatForm.AddMessInActiveChat(Nick, PopMsg, UrlEncode(M_From), MsgD, Mess) then
      UpdateFullCL;
  end;
  // Пишем в лог
  if (K_Email <> EmptyStr) and (K_Mess <> EmptyStr) then
    Exit;
  S_Log := S_Log + C_Id + C_TN + C_BN + M_Id + C_LN + C_BN + 'Flag' + C_TN + C_BN + M_Flag + C_LN + C_BN + 'From' + C_TN + C_BN + M_From + C_LN + C_BN + 'Text' + C_TN + C_BN + Mess;
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[6].Pkt_Name, Trim(S_Log), C_Mra);
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
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[12].Pkt_Name, Trim(S_Log), C_Mra);
end;

{$ENDREGION}
{$REGION 'MRA_ParseCL'}

procedure MRA_ParseCL(PktData: string);
const
  Mask_u = 'u';
  Mask_s = 's';

var
  UL, S_Log, GMask, KMask, GId, GName, KEmail, KPhone, StatusIcons: string;
  KStatus, KXStatus, KXText, KClient, KGeo, GeoPkt, Unk: string;
  I, M, Len, GCount: Integer;
  KAuth: Boolean;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Получаем ошибки списка контактов
  UL := Text2Hex(NextData(PktData, 4));
  S_Log := S_Log + 'UL' + C_TN + C_BN + UL + C_RN;
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
          Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
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
          Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + WideLowerCase(C_Phone));
          Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[34].L_S));
          Tri_Node.Properties.Add(C_Id, C_Phone_m2);
          // Добавляем группу контактов с ошибочным идентификатором группы
          Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_AuthNone);
          Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[7].L_S));
          Tri_Node.Properties.Add(C_Id, C_AuthNone);
          // Получаем контакты
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
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
            StatusIcons := MRA_StatusCodeToImg(KStatus, KXStatus);
            Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(I));
            if KEmail = C_Phone_m1 then
            begin
              Tri_Node.Properties.Add(C_Login, URLEncode(KPhone));
              Tri_Node.Properties.Add(C_Group + C_Id, C_Phone_m2);
              Tri_Node.Properties.Add(C_Status, 275);
            end
            else
            begin
              Tri_Node.Properties.Add(C_Login, URLEncode(KEmail));
              Tri_Node.Properties.Add(C_Group + C_Id, IntToHex(Swap32(HexToInt(GId)), 4));
            end;
            // Записываем Ник
            if GName = EmptyStr then
              GName := KEmail;
            Tri_Node.Properties.Add(C_Nick, URLEncode(GName));
            // Записываем другие параметры
            if KEmail <> C_Phone_m1 then
            begin
              if KAuth then
              begin
                Tri_Node.Properties.Add(C_Auth, C_AuthBoth);
                Tri_Node.Properties.Add(C_Status, Parse(C_LN, StatusIcons, 1));
                Tri_Node.Properties.Add(C_Client, MRA_ClientToImg(KClient));
              end
              else
              begin
                Tri_Node.Properties.Add(C_Auth, C_AuthNone);
                Tri_Node.Properties.Add(C_Status, 23);
                Tri_Node.Properties.Add(C_Client, 220);
              end;
            end;
            Tri_Node.Properties.Add(C_Phone, URLEncode(KPhone));
            Tri_Node.Properties.Add(C_XStatus + C_Name, URLEncode(KXStatus));
            Tri_Node.Properties.Add(C_XStatus, Parse(C_LN, StatusIcons, 2));
            Tri_Node.Properties.Add(C_XText, URLEncode(KXText));
            Tri_Node.Properties.Add(C_Client + C_Name, URLEncode(KClient));
            Tri_Node.Properties.Add(C_Geo, URLEncode(KGeo));
            // Заполняем лог
            S_Log := S_Log + C_Contact + C_BN + C_PN + C_BN + C_Group + C_Id + C_TN + C_BN + GId + C_LN + C_BN + C_Login + C_TN + C_BN + KEmail + C_LN //
            + C_BN + C_Nick + C_TN + C_BN + GName + C_LN + C_BN + C_Auth + C_TN + C_BN + BoolToStr(KAuth) + C_LN + C_BN + C_Status //
            + C_TN + C_BN + KStatus + C_LN + C_BN + C_Phone + C_TN + C_BN + KPhone + C_LN + C_BN + C_XStatus + C_TN + C_BN + KXStatus //
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
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[29].Pkt_Name, Trim(S_Log), C_Mra);
end;
{$ENDREGION}
{$REGION 'MRA_GoOffline'}

procedure MRA_GoOffline;
var
  I: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
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
  // Обнуляем статусы в Ростере
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Ищем раздел MRA
        XML_Node := Root.Items.ItemNamed[C_Mra];
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
                if (Tri_Node.Properties.IntValue(C_Status) <> 275) and (Tri_Node.Properties.IntValue(C_Status) <> 312) then
                begin
                  RosterUpdateProp(Tri_Node, C_Status, '23');
                  RosterUpdateProp(Tri_Node, C_XStatus, '-1');
                  RosterUpdateProp(Tri_Node, C_XStatus + C_Name, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_XText, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_Client, '-1');
                  RosterUpdateProp(Tri_Node, C_Client + C_Name, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_Geo, EmptyStr);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  // Запускаем обработку CL
  UpdateFullCL;
end;

{$ENDREGION}
{$REGION 'MRA_ParseStatus'}

procedure MRA_ParseStatus(PktData: string);
var
  S_Log, StatusCode, XStatusCode, XStatusText, KEmail, Unk, KClient, StatusIcons: string;
  Get_Node: TJvSimpleXmlElem;

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
  S_Log := S_Log + C_Login + C_TN + C_BN + KEmail + C_RN;
  // Получаем неизвестные данные
  Unk := Text2Hex(NextData(PktData, 4));
  S_Log := S_Log + C_Unk + C_TN + C_BN + Unk + C_RN;
  // Получаем версию клиента контакта
  KClient := GetLastLS;
  S_Log := S_Log + C_Client + C_Name + C_TN + C_BN + KClient + C_RN;
  // Обновляем данные статуса пользователя в Ростере
  StatusIcons := MRA_StatusCodeToImg(StatusCode, XStatusCode);
  Get_Node := RosterGetItem(C_Mra, C_Contact + C_SS, C_Login, URLEncode(KEmail));
  if Get_Node <> nil then
  begin
    RosterUpdateProp(Get_Node, C_Status, Parse(C_LN, StatusIcons, 1));
    RosterUpdateProp(Get_Node, C_XStatus + C_Name, XStatusCode);
    RosterUpdateProp(Get_Node, C_XStatus, Parse(C_LN, StatusIcons, 2));
    RosterUpdateProp(Get_Node, C_XText, URLEncode(XStatusText));
    RosterUpdateProp(Get_Node, C_Client + C_Name, URLEncode(KClient));
    RosterUpdateProp(Get_Node, C_Client, MRA_ClientToImg(KClient));
  end;
  // Запускаем обработку КЛ
  MainForm.JvTimerList.Events[11].Enabled := False;
  MainForm.JvTimerList.Events[11].Enabled := True;
  // Пишем в лог данные пакета
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[9].Pkt_Name, Trim(S_Log), C_Mra);
end;
{$ENDREGION}
{$REGION 'MRA_ParseOfflineMess'}

procedure MRA_ParseOfflineMess(PktData: string);
const
  Content_Text_ULE = 'text/plain; charset=UTF-16LE';
  Content_Encoding_B64 = 'base64';
var
  M_id, Pkt, M_Body, M_From, M_Mess, M_Flag, M_Type, M_Cod, S_Log: string;
  Len: Integer;
begin
  // Получаем идентификатор оффлайн сообщения
  M_id := Text2Hex(NextData(PktData, 8));
  // Получаем тело сообщения
  Len := HexToInt(Text2Hex(NextData(PktData, 4)));
  Len := Swap32(Len);
  M_Body := NextData(PktData, Len);
  M_Body := ReplaceStr(M_Body, #$0A, C_RN);
  // Пишем в лог данные пакета
  S_Log := M_Body;
  // Парсим данные из тела сообщения
  if M_Body <> EmptyStr then
  begin
    // Получаем от кого пришло сообщение
    M_From := IsolateTextString(M_Body, 'From: ', #$0D);
    // Получаем тип сообщения
    M_Type := IsolateTextString(M_Body, 'Type: ', #$0D);
    // Получаем флаг сообщения
    M_Flag := IsolateTextString(M_Body, 'Flags: ', #$0D);
    // Получаем алгоритм шифрования сообщения
    M_Cod := IsolateTextString(M_Body, 'Encoding: ', #$0D);
    // Получаем сообщение
    if (M_Type = Content_Text_ULE) and (M_Flag = '00100000') and (M_Cod = Content_Encoding_B64) then
    begin
      NextData(M_Body, Pos('base64', M_Body) + 5);
      M_Mess := Trim(M_Body);
      if M_Mess <> EmptyStr then
      begin
        M_Mess := Base64Decode(M_Mess);
        M_Mess := UnicodeLEHex2Text(Text2Hex(M_Mess));
        // Инициируем событие получения онлайн сообщения
        MRA_MessageRecv(EmptyStr, M_From, M_Mess);
        S_Log := S_Log + C_RN + 'Decode' + C_TN + C_BN + M_Mess;
      end;
    end;
  end;
  // Пишем в лог
  XLog(C_Mra + C_BN + Log_Parsing + C_BN + MRA_Pkt_Names[17].Pkt_Name, S_Log, C_Mra);
  // Если идентификатор не пустой, то отправляем пакет удаления этого оффлайн сообщения с сервера
  if M_id <> EmptyStr then
  begin
    Pkt := MRA_Empty + M_Id;
    // Отправляем пакет
    Mra_SendPkt('1E100000', Pkt, False);
  end;
end;

{$ENDREGION}
{$REGION 'MRA_ParseSMS_ACK'}

procedure MRA_ParseSMS_ACK(PktData: string);
var
  Flag: string;
begin
  // Получаем подтверждение отсылки SMS
  Flag := Text2Hex(PktData);
  if Flag = '01000000' then
    DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[94].L_S, [C_Mra]), EmptyStr, 133, 3, 0);
end;
{$ENDREGION}

end.

