{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit BimoidProtoUnit;

interface

{$REGION 'Uses'}
uses
  Windows,
  MainUnit,
  BimoidOptionsUnit,
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
//const

{$ENDREGION}
{$REGION 'Array Status Codes'}
// Иконки для статусов

{$ENDREGION}
{$REGION 'Array Pkt Codes'}
// Расшифровка пакетов для лога

{$ENDREGION}
{$REGION 'Vars'}

var
  BimoidWSocket: TWSocket;
  //Bim_myBeautifulSocketBuffer: string;
  Bim_LoginServerAddr: string;
  Bim_LoginServerPort: string;
  //Bim_BuffPkt: string;
  Bim_LoginUIN: string;
  Bim_LoginPassword: string;
  //Bim_Seq: LongWord = 0;
  // Фазы работы начало
  Bim_Connect_Phaze: Boolean = False;
  Bim_HTTP_Connect_Phaze: Boolean = False;
  Bim_Work_Phaze: Boolean = False;
  Bim_Offline_Phaze: Boolean = True;
  // Фазы работы конец
  {Bim_CurrentStatus: Integer = 298;
  Bim_CurrentStatus_bac: Integer = 298;
  Bim_Reconnect: Boolean = False;}
  // Другие переменные протокола

{$ENDREGION}
{$REGION 'Procedures and Functions'}

procedure Bim_Socket_Create;
procedure Bim_Socket_Free;

{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  OverbyteIcsUrl,
  RosterUnit;

{$ENDREGION}
{$REGION 'Bim_Socket_Create'}

procedure Bim_Socket_Create;
begin
  // Создаём сокет
  BimoidWSocket := TWSocket.Create(nil);
  // Назначаем сокету события

end;
{$ENDREGION}
{$REGION 'Bim_Socket_Free'}

procedure Bim_Socket_Free;
begin
  // Освобождаем события сокета

  // Уничтожаем сокет
  if Assigned(BimoidWSocket) then
    FreeAndNil(BimoidWSocket);
end;
{$ENDREGION}

end.

