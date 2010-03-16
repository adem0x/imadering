{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit TwitProtoUnit;

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
  MmSystem,
  Forms,
  ComCtrls,
  Messages,
  Classes,
  IcqContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  RosterUnit;

{$ENDREGION}
{$REGION 'Vars'}

var
  Twit_Login: string;
  Twit_Password: string;
  Twit_IncMess_Count: Integer = 5;
  Twit_MyMess_Count: Integer = 5;

{$ENDREGION}
{$REGION 'Procedures and Functions'}

{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  LogUnit,
  OverbyteIcsUrl;

{$ENDREGION}

end.
