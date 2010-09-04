{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit UtilsUnit;

interface

{$REGION 'Uses'}

uses
  Windows,
  Messages,
  Sysutils,
  Variants,
  Classes,
  ExtCtrls,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  Mmsystem,
  StrUtils,
  JvDesktopAlert,
  ShellApi,
  JvDesktopAlertForm,
  Stdctrls,
  VarsUnit,
  MainUnit,
  IcqProtoUnit,
  JvTrayIcon,
  WinSock,
  OverbyteIcsWsocket,
  CategoryButtons,
  JabberProtoUnit,
  Registry,
  MraProtoUnit,
  LogUnit,
  JclCompression,
  Buttons,
  TypInfo,
  OverbyteIcsUrl,
  JvListView,
  ComCtrls,
  JvSimpleXml,
  ButtonGroup,
  UpdateUnit,
  DateUtils,
  Htmlview;

{$ENDREGION}
{$REGION 'Procedures and Functions'}

function Parse(Char, S: string; Count: Integer): string;
procedure ListFileInDir(Path, Eext: string; FileList: TStrings);
function Hex2Text(HexText: string): string;
function Text2Hex(Msg: RawByteString): string;
function RightStr(const Str: string; Size: Word): string;
function LeftStr(const Str: string; Size: Word): string;
function HexToInt(Value: string): Longword;
function NextData(var Data: string; Count: Integer): string;
function Swap16(Value: Word): Word;
assembler;
function Swap32(Value: Longword): Longword;
assembler;
function DeleteSpaces(const Value: string): string;
function DeleteLineBreaks(const S: string): string;
function NormalizeScreenName(Sn: string): string;
function NormalizeIcqNumber(Sn: string): string;
function DateTimeChatMess: string;
procedure ICQ_SendPkt(Channel, Data: string);
procedure ICQA_SendPkt(Channel, Data: string);
function NumToIp(Addr: LongWord): string;
function UnixToDateTime(const Avalue: Int64): TDateTime;
function GetTimeZone: Integer;
function TailLineTail(Ahistory: string; AlinesCount: Integer): string;
procedure FormFlash(Hnd: Hwnd);
function ExisValidCharactersText(Value: string): Boolean;
function ExisValidCharactersDigit(Value: string): Boolean;
function HexToInt64(Hex: string): Int64;
function CalculateAge(BirthDay, CurrentDate: Tdate): Integer;
procedure SetClipboardText(Value: string);
function Dump(Data: RawByteString): string;
function Chop(I: Integer; var S: string): string; overload;
function Chop(I, L: Integer; var S: string): string; overload;
function Chop(Ss: string; var S: string): string; overload;
function ReadFromFile(FileName: string; AsUnicode: boolean): string;
function IsolateTextString(const S: string; Tag1, Tag2: string): string;
function Int64ToHex(C: Int64): string;
function Horospope(D, M: Integer): Integer;
// function TranslitRus2Lat(const Str: string): string;
procedure DaShow(DaHead, DaText, DaId: string; DaIco, DaColor, DaVisible: Integer);
function InitMixer: Hmixer;
function Icq_BodySize(Pkt: string): Integer;
function Mra_BodySize(Pkt: string): Integer;
function IsNotNull(StringsArr: array of string): Boolean;
procedure DecorateURL(var Text: string);
function NameAndLast(CId, CProto: string): string;
procedure PopUp_Top(Compon: TComponent; Pm: TPopupMenu);
procedure PopUp_Down(Compon: TComponent; Pm: TPopupMenu);
function InitBuildInfo: string;
function GetFileSize(FileName: string): Longint;
function PacketToHex(Buffer: Pointer; BufLen: Word): string;
function GetRandomHexBytes(BytesCount: Integer): string;
function ErrorHttpClient(ErrCode: Integer): string;
function GetFullTag(AData: string): string;
procedure ImPlaySnd(Snd: Integer);
function SearchNickInCash(CType, CId: string): string;
procedure SetCustomWidthComboBox(Cb: TComboBox);
procedure XShowForm(XForm: TForm);
procedure OpenURL(URL: string);
function ChangeSpaces(const Value: string): string;
function ChangeSlash(const Value: string): string;
procedure Mra_SendPkt(PktType, Data: string; NoLen: Boolean = False);
function GetFileName(FileName: string): string;
procedure CheckMessage_BR(var Msg: string);
procedure CheckMessage_GAPI(var Msg: string);
function CheckText_RN(Msg: string): string;
function NotProtoOnline(Proto: string): Boolean;
function GetFileDateTime(FileName: string): TDateTime;
procedure Jab_SendPkt(XmlData: string);
procedure XLog(XLogData, Proto: string);
function RafinePath(const Path: string): string;
function NotifyConnectError(SName: string; ErrCode: Integer): string;
function CreateHistoryArhive(HFile: string): Boolean;
procedure SaveTextInHistory(HString: string; HFileName: string);
// procedure CreateLang(Xform: Tform);
procedure SetLang(Xform: Tform);
procedure CheckMessage_Smilies(var Msg: string);
function ChangeCP(const Value: string): string;
function CheckText_Hint(Msg: string): string;
function Text2UnicodeBEHex(Msg: string): string;
function UnicodeBEHex2Text(HexText: string): string;
procedure JvXML_Create(var JvXML: TJvSimpleXml);
procedure JvXML_LoadStr(var JvXML: TJvSimpleXml; DataStr: string);
function StrArrayToStr(StrArr: array of string): string;
function UnpackArhive(HFile: string): Boolean;
function HtmlStrToString(const HtmlText: string): string;
// function Twit_ParseDateTime(Sdate: string): TDateTime;
function ReverseHexUnicodeChar(S: string): string;
function Text2UnicodeLEHex(Msg: string): string;
function UnicodeLEHex2Text(HexText: string): string;
function IsValidUnicode(Str: string; LE: Boolean): Boolean;
procedure FormShowInWorkArea(XForm: TForm);
procedure FormSetInWorkArea(XForm: TForm);
procedure LoadHTMLStrings(HtmlV: THTMLViewer; HtmlS: string);
procedure CloseSmiliesHint;
procedure ShowSmiliesHint(HtmlV: THTMLViewer);
procedure AppBarCreate;
procedure AppBarSetPos(const Left: boolean);
procedure AppBarDestroy;
function ExtractUrlFileName(const AUrl: string): string;
function Text2XML(Str: string): string;
function XML2Text(Str: string): string;
function GetFlagFile(Path, CountryCode, CountryName: string): string;
function ReverseString(s: string): string;

{$ENDREGION}

implementation

{$REGION 'ReverseString'}

function ReverseString(s: string): string;
var
  i: integer;
begin
  Result := EmptyStr;
  if Trim(s) <> EmptyStr then
    for i := Length(s) downto 1 do
      Result := Result + s[i];
end;
{$ENDREGION}
{$REGION 'GetFlagFile'}

function GetFlagFile(Path, CountryCode, CountryName: string): string;
const
  FileExt = '.gif';
var
  SearchRec: TSearchRec;
  FileMask: string;
begin
  Result := EmptyStr;
  if CountryCode <> EmptyStr then
    FileMask := Path + CountryCode + '_*' + FileExt
  else if CountryName <> EmptyStr then
    FileMask := Path + '*_' + CountryName + FileExt;
  if FindFirst(FileMask, FaAnyFile, SearchRec) = 0 then
    try
      Result := SearchRec.Name;
    finally
      FindClose(SearchRec);
    end;
end;
{$ENDREGION}
{$REGION 'XML and Text'}

function Text2XML(Str: string): string;
begin
  Result := Str;
  Result := ReplaceStr(Result, '&', '&amp;');
  Result := ReplaceStr(Result, '<', '&lt;');
  Result := ReplaceStr(Result, '>', '&gt;');
  Result := ReplaceStr(Result, '"', '&quot;');
  Result := ReplaceStr(Result, '''', '&apos;');
end;

function XML2Text(Str: string): string;
begin
  Result := Str;
  Result := ReplaceStr(Result, '&amp;', '&');
  Result := ReplaceStr(Result, '&lt;', '<');
  Result := ReplaceStr(Result, '&gt;', '>');
  Result := ReplaceStr(Result, '&quot;', '"');
  Result := ReplaceStr(Result, '&apos;', '''');
end;

{$ENDREGION}
{$REGION 'ExtractUrlFileName'}

function ExtractUrlFileName(const AUrl: string): string;
var
  i: Integer;
begin
  i := LastDelimiter('/', AUrl);
  Result := Copy(AUrl, i + 1, Length(AUrl) - (i));
end;

{$ENDREGION}
{$REGION 'AppBar Tools'}

procedure AppBarCreate;
begin
  V_AppBarDataCL.cbSize := SizeOf(TAppBarData);
  V_AppBarDataCL.hWnd := MainForm.Handle;
  V_AppBarDataCL.uCallbackMessage := C_WM_APPBAR;
  // Register the application bar within the system
  if SHAppBarMessage(ABM_NEW, V_AppBarDataCL) <> 0 then
    SetWindowPos(V_AppBarDataCL.hWnd, V_AppBarDataCL.hWnd, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOACTIVATE or SWP_NOSIZE or SWP_SHOWWINDOW);
end;

procedure AppBarSetPos(const Left: boolean);
var
  W: Integer;
begin
  if Left then
    V_AppBarDataCL.uEdge := ABE_LEFT
  else
    V_AppBarDataCL.uEdge := ABE_RIGHT;
  W := MainForm.Width;
  V_AppBarDataCL.rc.Right := GetSystemMetrics(SM_CXSCREEN);
  V_AppBarDataCL.rc.Bottom := GetSystemMetrics(SM_CYSCREEN);
  if V_AppBarDataCL.uEdge = ABE_LEFT then
    V_AppBarDataCL.rc.Left := 0
  else
    V_AppBarDataCL.rc.Left := GetSystemMetrics(SM_CXSCREEN) - W + 40;
  V_AppBarDataCL.rc.Top := 0;
  if SHAppBarMessage(ABM_QUERYPOS, V_AppBarDataCL) <> 0 then
    case V_AppBarDataCL.uEdge of
      ABE_LEFT:
        V_AppBarDataCL.rc.Right := V_AppBarDataCL.rc.Left + W;
      ABE_RIGHT:
        V_AppBarDataCL.rc.Left := V_AppBarDataCL.rc.Right - W;
    end;
  // Set the new size
  SHAppBarMessage(ABM_SETPOS, V_AppBarDataCL);
end;

procedure AppBarDestroy;
begin
  // Remove the application bar
  SHAppBarMessage(ABM_REMOVE, V_AppBarDataCL);
end;
{$ENDREGION}
{$REGION 'FormShowInWorkArea'}

procedure FormShowInWorkArea(XForm: TForm);
var
  FCursor: TPoint;
begin
  // Вычисляем позицию окна от позиции курсора
  GetCursorPos(FCursor);
  with XForm do
  begin
    Top := FCursor.Y - (Height div 2);
    Left := FCursor.X - (Width div 2);
    // Определяем не находится ли окно за пределами экрана
    if Top < Screen.WorkAreaTop then
      Top := Screen.WorkAreaTop;
    if Left + Width > (Screen.WorkAreaLeft + Screen.WorkAreaWidth) then
      Left := (Screen.WorkAreaLeft + Screen.WorkAreaWidth) - Width;
    if Left < Screen.WorkAreaLeft then
      Left := Screen.WorkAreaLeft;
    // Показываем окно доп. статуса
    XShowForm(XForm);
  end;
end;

{$ENDREGION}
{$REGION 'FormSetInWorkArea'}

procedure FormSetInWorkArea(XForm: TForm);
begin
  with XForm do
  begin
    // Определяем не находится ли окно за пределами экрана
    if Top < Screen.WorkAreaTop then
      Top := Screen.WorkAreaTop;
    if Top + Height > (Screen.WorkAreaTop + Screen.WorkAreaHeight) then
      Top := (Screen.WorkAreaTop + Screen.WorkAreaHeight) - Height;
    if Left + Width > (Screen.WorkAreaLeft + Screen.WorkAreaWidth) then
      Left := (Screen.WorkAreaLeft + Screen.WorkAreaWidth) - Width;
    if Left < Screen.WorkAreaLeft then
      Left := Screen.WorkAreaLeft;
  end;
end;

{$ENDREGION}
{$REGION 'IsValidUnicode'}

function IsValidUnicode(Str: string; LE: Boolean): Boolean;
var
  HexStr: string;
  I, Count, S, U: Integer;
begin
  // Проверяем юникод или нет (ограниченный способ)
  Result := False;
  if Str = EmptyStr then
    Exit;
  HexStr := Text2Hex(Str);
  if Length(HexStr) < 4 then
    Exit;
  Count := Length(HexStr) div 4;
  U := 0;
  // BE или LE стиль юникода
  if not LE then
    S := 1
  else
    S := 3;
  // Начинаем проверку
  for I := 1 to Count do
  begin
    if HexStr[S] = '0' then
      Inc(U);
    Inc(S, 4);
  end;
  if U = Count then
    Result := True;
end;

{$ENDREGION}
{$REGION 'ReverseHexUnicodeChar'}

function ReverseHexUnicodeChar(S: string): string;
var
  I: Integer;
begin
  I := HexToInt(S);
  Result := IntToHex(Swap16(I), 4);
end;

{$ENDREGION}
{$REGION 'Text2UnicodeLEHex'}

function Text2UnicodeLEHex(Msg: string): string;
var
  I: Integer;
begin
  Result := EmptyStr;
  if Msg = EmptyStr then
    Exit;
  for I := 1 to Length(Msg) do
  begin
    Result := Result + ReverseHexUnicodeChar(IntToHex(Ord(Msg[I]), 4));
  end;
end;

{$ENDREGION}
{$REGION 'UnicodeLEHex2Text'}

function UnicodeLEHex2Text(HexText: string): string;
var
  I: Integer;
begin
  Result := EmptyStr;
  if HexText = EmptyStr then
    Exit;
  for I := 1 to Length(HexText) div 4 do
    Result := Result + Char(StrToInt('$' + ReverseHexUnicodeChar(Copy(HexText, ((I - 1) * 4) + 1, 4))));
end;

{$ENDREGION}
{$REGION 'StrArrayToStr'}

function StrArrayToStr(StrArr: array of string): string;
var
  I: Integer;
  S, Ss: string;
begin
  Result := EmptyStr;
  for I := low(StrArr) to high(StrArr) do
  begin
    S := StrArr[I];
    if (S > EmptyStr) and (Ss > EmptyStr) then
      Ss := Ss + ', ' + S
    else if (S > EmptyStr) and (Ss = EmptyStr) then
      Ss := S;
  end;
  Result := Ss;
end;

{$ENDREGION}
{$REGION 'JvXML_Create'}

procedure JvXML_Create(var JvXML: TJvSimpleXml);
var
  FOptions: TJvSimpleXMLOptions;
begin
  // Создаём XML объект и выставляем его параметры
  JvXML := TJvSimpleXml.Create(MainForm);
  FOptions := [];
  Include(FOptions, SxoAutoIndent);
  //Include(FOptions, sxoAutoEncodeValue);
  //Include(FOptions, sxoAutoEncodeEntity);
  JvXML.Options := FOptions;
  JvXML.Prolog.Encoding := 'UTF-8';
  JvXML.Root.name := 'root';
  JvXML.IndentString := C_BN + C_BN;
end;

{$ENDREGION}
{$REGION 'JvXML_LoadStr'}

procedure JvXML_LoadStr(var JvXML: TJvSimpleXml; DataStr: string);
begin
  // Загружаем xml данные и выставляем параметры
  DataStr := #$EF + #$BB + #$BF + UTF8Encode('<?xml version="1.0" encoding="UTF-8" ?>' + DataStr);
  JvXML.LoadFromString(DataStr);
end;

{$ENDREGION}
{$REGION 'Text2UnicodeBEHex'}

function Text2UnicodeBEHex(Msg: string): string;
var
  I: LongInt;
begin
  Result := EmptyStr;
  if Msg = EmptyStr then
    Exit;
  for I := 1 to Length(Msg) do
  begin
    Result := Result + IntToHex(Ord(Msg[I]), 4);
  end;
end;

{$ENDREGION}
{$REGION 'UnicodeBEHex2Text'}

function UnicodeBEHex2Text(HexText: string): string;
var
  I: LongInt;
begin
  Result := EmptyStr;
  if HexText = EmptyStr then
    Exit;
  for I := 1 to Length(HexText) div 4 do
    Result := Result + Char(StrToInt('$' + Copy(HexText, ((I - 1) * 4) + 1, 4)));
end;

{$ENDREGION}
{$REGION 'SetLang'}

procedure SetLang(Xform: Tform);
var
  I, II, M: Integer;
  List: Tstringlist;
  PropInfo: PPropInfo;
  TK: TTypeKind;
  Str: string;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  //Xlog(Xform.name, EmptyStr);
  List := Tstringlist.Create;
  try
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
        begin
          // Загружаем файл языка
          LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
          if Root <> nil then
          begin
            // Переводим заголовок формы и получаем все остальные пункты
            XML_Node := Root.Items.ItemNamed[Xform.name];
            if XML_Node <> nil then
            begin
              Xform.Caption := XML_Node.Properties.Value('c');
              List.Text := XML_Node.SaveToString;
            end;
          end;
        end;
      end;
    finally
      JvXML.Free;
    end;
    // Переводим компоненты формы с Caption
    with Xform do
      for I := 0 to ComponentCount - 1 do
      begin
        // Если этот компонент меню
        if (Components[I] is TPopupMenu) then
        begin
          for M := 0 to (Components[I] as TPopupMenu).Items.Count - 1 do
          begin
            for II := 0 to List.Count - 1 do
            begin
              if (Components[I] as TPopupMenu).Items[M].name = IsolateTextString(List.Strings[II], '<', C_BN) then
              begin
                (Components[I] as TPopupMenu)
                  .Items[M].Caption := IsolateTextString(List.Strings[II], 'c="', '"');
                Break;
              end;
            end;
          end;
          Continue;
        end;
        // Если этот компонент ЛистВиев
        if (Xform.Components[I] is TJvListView) then
        begin
          for M := 0 to (Xform.Components[I] as TJvListView).Columns.Count - 1 do
          begin
            for II := 0 to List.Count - 1 do
            begin
              if (Xform.Components[I].name + '_' + IntToStr((Xform.Components[I] as TJvListView).Columns[M].index)) = IsolateTextString(List.Strings[II], '<', C_BN) then
              begin
                (Components[I] as TJvListView)
                  .Columns[M].Caption := IsolateTextString(List.Strings[II], 'c="', '"');
                Break;
              end;
            end;
          end;
          Continue;
        end;
        if (Xform.Components[I] is TListView) then
        begin
          for M := 0 to (Xform.Components[I] as TListView).Columns.Count - 1 do
          begin
            for II := 0 to List.Count - 1 do
            begin
              if (Xform.Components[I].name + '_' + IntToStr((Xform.Components[I] as TListView).Columns[M].index)) = IsolateTextString(List.Strings[II], '<', C_BN) then
              begin
                (Components[I] as TListView)
                  .Columns[M].Caption := IsolateTextString(List.Strings[II], 'c="', '"');
                Break;
              end;
            end;
          end;
          Continue;
        end;
        // Если этот компонент Категория кнопок
        if (Xform.Components[I] is TButtonGroup) then
        begin
          for M := 0 to (Xform.Components[I] as TButtonGroup).Items.Count - 1 do
          begin
            for II := 0 to List.Count - 1 do
            begin
              if (Xform.Components[I].name + '_' + IntToStr((Xform.Components[I] as TButtonGroup).Items[M].index)) = IsolateTextString(List.Strings[II], '<', C_BN) then
              begin
                (Components[I] as TButtonGroup)
                  .Items[M].Caption := IsolateTextString(List.Strings[II], 'c="', '"');
                Break;
              end;
            end;
          end;
          Continue;
        end;
        // Ищем компонент в списке по имени
        for II := 0 to List.Count - 1 do
        begin
          if Components[I].name = IsolateTextString(List.Strings[II], '<', C_BN) then
          begin
            // Устанавливаем Caption через технологию RTTI
            Str := EmptyStr;
            Str := IsolateTextString(List.Strings[II], 'c="', '"');
            if Str <> EmptyStr then
            begin
              PropInfo := GetPropInfo(Components[I].ClassInfo, 'Caption');
              if PropInfo <> nil then
              begin
                TK := PropInfo^.PropType^.Kind;
                if (TK = TkString) or (TK = TkLString) or (TK = TkWString) or (TK = TkUString) then
                  SetStrProp(Components[I], PropInfo, Str);
              end;
            end;
            // Устанавливаем Hint через технологию RTTI
            Str := EmptyStr;
            Str := IsolateTextString(List.Strings[II], 'h="', '"');
            if Str <> EmptyStr then
            begin
              PropInfo := GetPropInfo(Components[I].ClassInfo, 'Hint');
              if PropInfo <> nil then
              begin
                TK := PropInfo^.PropType^.Kind;
                if (TK = TkString) or (TK = TkLString) or (TK = TkWString) or (TK = TkUString) then
                  SetStrProp(Components[I], PropInfo, CheckText_Hint(Str));
              end;
            end;
            Break;
          end;
        end;
      end;
  finally
    List.Free;
  end;
end;

{$ENDREGION}
{$REGION 'CreateLang'}

{ procedure CreateLang(Xform: Tform);
  var
  I, MI: Integer;
  PropInfo: PPropInfo;
  TK: TTypeKind;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
  begin
  // Создаём необходимые папки
  ForceDirectories(MyPath + 'Langs\Forms\');
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
  with JvXML do
  begin
  // Записываем заголовок формы
  XML_Node := Root.Items.Add(Xform.name);
  XML_Node.Properties.Add('c', Xform.Caption);
  // Просматриваем все контролы на форме
  for I := 0 to Xform.ComponentCount - 1 do
  begin
  // Пишем в файл всплывающие меню
  if (Xform.Components[I] is TPopupMenu) then
  begin
  for MI := 0 to (Xform.Components[I] as TPopupMenu).Items.Count - 1 do
  XML_Node.Items.Add((Xform.Components[I] as TPopupMenu).Items[MI].name).Properties.Add('c', (Xform.Components[I] as TPopupMenu).Items[MI].Caption);
  Continue;
  end;
  // Пишем в файл ЛистВиев
  if (Xform.Components[I] is TJvListView) then
  begin
  for MI := 0 to (Xform.Components[I] as TJvListView).Columns.Count - 1 do
  XML_Node.Items.Add(Xform.Components[I].name + '_' + IntToStr((Xform.Components[I] as TJvListView).Columns[MI].index)).Properties.Add('c',
  (Xform.Components[I] as TJvListView).Columns[MI].Caption);
  Continue;
  end;
  if (Xform.Components[I] is TListView) then
  begin
  for MI := 0 to (Xform.Components[I] as TListView).Columns.Count - 1 do
  XML_Node.Items.Add(Xform.Components[I].name + '_' + IntToStr((Xform.Components[I] as TListView).Columns[MI].index)).Properties.Add('c',
  (Xform.Components[I] as TListView).Columns[MI].Caption);
  Continue;
  end;
  // Пишем в файл Категории кнопок
  if (Xform.Components[I] is TButtonGroup) then
  begin
  for MI := 0 to (Xform.Components[I] as TButtonGroup).Items.Count - 1 do
  XML_Node.Items.Add(Xform.Components[I].name + '_' + IntToStr((Xform.Components[I] as TButtonGroup).Items[MI].index)).Properties.Add('c',
  (Xform.Components[I] as TButtonGroup).Items[MI].Caption);
  Continue;
  end;
  // Пишем в файл все компоненты которые имеют Caption
  PropInfo := GetPropInfo(Xform.Components[I].ClassInfo, 'Caption');
  if PropInfo <> nil then
  begin
  TK := PropInfo^.PropType^.Kind;
  if (TK = TkString) or (TK = TkLString) or (TK = TkWString) or (TK = TkUString) then
  XML_Node.Items.Add(Xform.Components[I].name).Properties.Add('c', GetStrProp(Xform.Components[I], PropInfo));
  end;
  end;
  // Записываем сам файл
  SaveToFile(MyPath + 'Langs\Forms\' + Xform.name + '.xml');
  end;
  finally
  JvXML.Free;
  end;
  end; }

{$ENDREGION}
{$REGION 'SaveTextInHistory'}

procedure SaveTextInHistory(HString: string; HFileName: string);
var
  F: TFileStream;
  PStr: PChar;
  LengthLogString: Integer;
begin
  LengthLogString := (Length(HString) + 2) * SizeOf(Char);
  HString := HString + C_RN;
  PStr := StrAlloc(LengthLogString + 1);
  StrPCopy(PStr, HString);
  if FileExists(HFileName) then
    F := TFileStream.Create(HFileName, FmOpenWrite)
  else
    F := TFileStream.Create(HFileName, FmCreate);
  F.Position := F.Size;
  F.write(PStr^, LengthLogString);
  StrDispose(PStr);
  F.Free;
end;

{$ENDREGION}
{$REGION 'NotifyConnectError'}

function NotifyConnectError(SName: string; Errcode: Integer): string;
begin
  // Определяем что за ошибка произошла при подключении
  Result := Format(Lang_Vars[23].L_S, [SName]) + C_RN + WSocketErrorDesc(Errcode) + C_RN + Format(Lang_Vars[27].L_S, [Errcode]);
end;

{$ENDREGION}
{$REGION 'RafinePath'}

// На случай, если в имени контакта символы, не поддерживаемые ФС

function RafinePath(const Path: string): string;
begin
  Result := Path;
  Result := ReplaceStr(Result, '*', '_');
  Result := ReplaceStr(Result, '?', '_');
  Result := ReplaceStr(Result, '/', '_');
  Result := ReplaceStr(Result, '\', '_');
  Result := ReplaceStr(Result, '|', '_');
  Result := ReplaceStr(Result, '<', '_');
  Result := ReplaceStr(Result, '>', '_');
  Result := ReplaceStr(Result, '"', '_');
  Result := ReplaceStr(Result, ':', '_');
end;

{$ENDREGION}
{$REGION 'XLog'}

procedure XLog(XLogData, Proto: string);
begin
  // Если окно лога не создано, то выходим
  if not Assigned(LogForm) then
    Exit;
  // Если запись лога выключена, то выходим
  with LogForm do
  begin
    if WriteLogSpeedButton.Down then
      Exit;
    // Проверяем какой протокол
    if ((Proto = C_Icq) and ICQDumpSpeedButton.Down) //
    or ((Proto = C_Jabber) and JabberDumpSpeedButton.Down) //
    or ((Proto = C_Mra) and MRADumpSpeedButton.Down) //
    or ((Proto = C_Twitter) and TwitDumpSpeedButton.Down) //
    or (Proto = EmptyStr) then
    begin
      // Если количество строк в логе слишком большое, то очищаем его
      if LogMemo.Lines.Count > 5000 then
        LogMemo.Clear;
      // Добавляем в лог новое сообщение
      LogMemo.Lines.Add(DateTimeToStr(Now) + C_TN + C_BN + XLogData);
      LogMemo.Lines.Add(C_MaskPass + C_MaskPass + C_MaskPass + C_MaskPass);
    end;
  end;
end;

{$ENDREGION}
{$REGION 'Jab_SendPkt'}

procedure Jab_SendPkt(Xmldata: string);
var
  JvXML: TJvSimpleXml;
  Pkt, S: string;
begin
  S := Copy(Xmldata, 2, 1);
  if (S <> '?') and (S <> '/') and (S <> #09) then
  begin
    // Форматируем данные пакета
    Pkt := '<xml>' + Xmldata + '</xml>';
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        JvXML_LoadStr(JvXML, Pkt);
        // Пишем в лог данные пакета
        XLog(C_Jabber + Log_Send + C_RN + Trim(Copy(XMLData, 4, Length(XMLData))), C_Jabber);
      end;
    finally
      JvXML.Free;
    end;
  end
  else
    XLog(C_Jabber + Log_Send + C_RN + XMLData, C_Jabber);
  // Отправляем данные через сокет
  Mainform.JabberWSocket.SendStr(Utf8Encode(Xmldata));
end;

{$ENDREGION}
{$REGION 'GetFileDateTime'}
{$WARNINGS OFF}

function GetFileDateTime(Filename: string): Tdatetime;
var
  IntFileAge: Longint;
begin
  Intfileage := FileAge(Filename);
  if Intfileage = -1 then
    Result := 0
  else
    Result := FileDateToDateTime(IntFileAge);
end;

{$WARNINGS ON}
{$ENDREGION}
{$REGION 'NotProtoOnline'}

function NotProtoOnline(Proto: string): Boolean;
begin
  Result := False;
  // Проверяем онлайн ли клиент для этого протокола
  if (Proto = C_Icq) and (not Icq_work_phaze) then
  begin
    Proto := UpperCase(Proto);
    Result := True;
  end
  else if (Proto = C_Jabber) and (not Jabber_work_phaze) then
    Result := True
  else if (Proto = C_Mra) and (not Mra_work_phaze) then
  begin
    Proto := UpperCase(Proto);
    Result := True;
  end;
  if Result then
    Dashow(Lang_Vars[18].L_S, Format(Lang_Vars[31].L_S, [Proto]), EmptyStr, 133, 3, 0);
end;

{$ENDREGION}
{$REGION 'CheckMessage_BR'}

procedure CheckMessage_BR(var Msg: string);
begin
  // Заменяем все переходы на новую строку в сообщении на соответствующий тэг
  Msg := ReplaceStr(Msg, C_RN, C_BR);
  Msg := ReplaceStr(Msg, #10, C_BR);
  Msg := ReplaceStr(Msg, C_BR + C_BN, C_BR + '&nbsp;');
  Msg := ReplaceStr(Msg, C_BN + C_BN, '&nbsp;&nbsp;');
end;

{$ENDREGION}
{$REGION 'CheckMessage_GAPI'}

procedure CheckMessage_GAPI(var Msg: string);
begin
  // Заменяем все коды спецсимволов в сообщении на соответствующий символ
  Msg := ReplaceStr(Msg, '\u0026lt;', '<');
  Msg := ReplaceStr(Msg, '\u0026gt;', '>');
  Msg := ReplaceStr(Msg, '\u0026#39;', '''');
  Msg := ReplaceStr(Msg, '\u003d', '=');
  Msg := ReplaceStr(Msg, '\u0026quot;', '"');
  Msg := ReplaceStr(Msg, '\u0026amp;', '&');
  Msg := ReplaceStr(Msg, '\\\', '');
end;

{$ENDREGION}
{$REGION 'CheckText_RN'}

function CheckText_RN(Msg: string): string;
begin
  // Заменяем все переходы на новую строку в сообщении на соответствующий тэг
  Result := ReplaceStr(Msg, '_r_', C_RN);
end;

{$ENDREGION}
{$REGION 'CheckText_Hint'}

function CheckText_Hint(Msg: string): string;
var
  S: string;
begin
  // Заменяем все переходы на новую строку в сообщении на соответствующий тэг
  S := ReplaceStr(Msg, '_b_', '<b>');
  S := ReplaceStr(S, '_d_', '</b>');
  Result := ReplaceStr(S, '_r_', '<br>');
end;

{$ENDREGION}
{$REGION 'XShowForm'}

procedure XShowForm(Xform: Tform);
begin
  // Автоматизируем показ окон
  Xform.Show;
  ShowWindow(Xform.Handle, SW_SHOW);
  if Xform.WindowState = wsMinimized then
    ShowWindow(Xform.Handle, SW_Restore);
  SetForeGroundWindow(Xform.Handle);
end;

{$ENDREGION}
{$REGION 'GetFileSize'}

function GetFileSize(FileName: string): Longint;
var
  SearchRec: TSearchRec;
begin
  Result := -1;
  if FindFirst(FileName, FaAnyFile, SearchRec) = 0 then
    try
      Result := SearchRec.Size;
    finally
      FindClose(SearchRec);
    end;
end;

{$ENDREGION}
{$REGION 'GetFileName'}

function GetFileName(FileName: string): string;
var
  SearchRec: TSearchRec;
begin
  Result := EmptyStr;
  if FindFirst(FileName, FaAnyFile, SearchRec) = 0 then
    try
      Result := SearchRec.name;
    finally
      FindClose(SearchRec);
    end;
end;

{$ENDREGION}
{$REGION 'NameAndLast'}

function NameAndLast(CId, CProto: string): string;
const
  NoVal = '---';
var
  AFile, Ln, Lf, La: string;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  Result := EmptyStr;
  V_GetCityPanel := NoVal;
  V_GetAgePanel := NoVal;
  V_GetFlagImage := EmptyStr;
  V_GetGenderImage := EmptyStr;
  // Ищем файл с анкетой этого контакта
  AFile := V_ProfilePath + C_AnketaFolder + CProto + C_BN + CId + '.xml';
  if FileExists(AFile) then
  begin
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        LoadFromFile(AFile);
        if Root <> nil then
        begin
          // Загружаем Имя и Фамилию
          XML_Node := Root.Items.ItemNamed[C_NameInfo];
          if XML_Node <> nil then
          begin
            Ln := URLDecode(XML_Node.Properties.Value(C_First));
            Lf := URLDecode(XML_Node.Properties.Value(C_Last));
          end;
          // Загружаем Город и Страну для флага
          XML_Node := Root.Items.ItemNamed[C_HomeInfo];
          if XML_Node <> nil then
          begin
            V_GetCityPanel := URLDecode(XML_Node.Properties.Value(C_City));
            V_GetFlagImage := XML_Node.Properties.Value(C_Country);
          end;
          if V_GetCityPanel = EmptyStr then
            V_GetCityPanel := NoVal;
          // Загружаем Возраст
          XML_Node := Root.Items.ItemNamed[C_AgeInfo];
          if XML_Node <> nil then
          begin
            La := XML_Node.Properties.Value(C_Age);
            if La <> '0' then
              V_GetAgePanel := Infoagel + C_BN + La;
          end;
          // Загружаем иконку пола
          XML_Node := Root.Items.ItemNamed[C_PerInfo];
          if XML_Node <> nil then
          begin
            V_GetGenderImage := XML_Node.Properties.Value(C_Gender);
            case V_GetGenderImage[1] of
              '1': V_GetGenderImage := 'girl';
              '2': V_GetGenderImage := 'boy';
            end;
          end;
        end;
      end;
    finally
      JvXML.Free;
    end;
    // Формируем строку
    if Ln > EmptyStr then
      Result := Result + Ln;
    if (Ln > EmptyStr) and (Lf > EmptyStr) then
      Result := Result + C_BN + Lf
    else if (Ln = EmptyStr) and (Lf > EmptyStr) then
      Result := Result + Lf;
  end;
end;

{$ENDREGION}
{$REGION 'DecorateURL'}

procedure DecorateURL(var Text: string);
label
  A;
var
  P, B, R: Integer;
  Str, FinalText, UrlText: string;
begin
  // Начинаем искать ссылки и заменяем их заголовки
  Text := Stringreplace(Text, 'http://', ' <a href="http://', [RfReplaceAll, RfIgnoreCase]);
  Text := Stringreplace(Text, 'https://', ' <a href="https://', [RfReplaceAll, RfIgnoreCase]);
  Text := Stringreplace(Text, 'ftp://', ' <a href="ftp://', [RfReplaceAll, RfIgnoreCase]);
  Text := Stringreplace(Text, 'www.', ' <a href="www.', [RfReplaceAll, RfIgnoreCase]);
  //
  Str := Text;
  A: ;
  P := Pos('href="', Str);
  if P > 0 then
  begin
    FinalText := FinalText + NextData(Str, P + 5);
    B := Pos(' ', Str);
    R := Pos('<br>', Str);
    if (B > 0) or (R > 0) then
    begin
      if (B > 0) and (B < R) then
      begin
        UrlText := NextData(Str, B - 1);
        FinalText := FinalText + UrlText + '">' + UrlText + '</a>';
      end
      else if (B > 0) and (B > R) and (R <> 0) then
      begin
        UrlText := NextData(Str, R - 1);
        FinalText := FinalText + UrlText + '">' + UrlText + '</a>';
      end
      else if (R > 0) and (R < B) then
      begin
        UrlText := NextData(Str, R - 1);
        FinalText := FinalText + UrlText + '">' + UrlText + '</a>';
      end
      else if (B > 0) and (R = 0) then
      begin
        UrlText := NextData(Str, B - 1);
        FinalText := FinalText + UrlText + '">' + UrlText + '</a>';
      end;
    end
    else
    begin
      UrlText := NextData(Str, Length(Str));
      FinalText := FinalText + UrlText + '">' + UrlText + '</a>';
    end;
    goto A;
  end;
  Text := FinalText + Str;
end;

{$ENDREGION}
{$REGION 'IsNotNull'}

function IsNotNull(StringsArr: array of string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := low(StringsArr) to high(StringsArr) do
  begin
    if Trim(StringsArr[I]) <> EmptyStr then
      Exit;
  end;
  Result := False;
end;

{$ENDREGION}
{$REGION 'TranslitRus2Lat'}

{ function TranslitRus2Lat(const Str: string): string;
  const
  Rarrayl = 'абвгдеёжзийклмнопрстуфхцчшщьыъэюя';
  Rarrayu = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ';
  Colchar = 33;
  Arr: array [1 .. 2, 1 .. Colchar] of string = (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'kh', 'ts', 'ch', 'sh', 'shch', '''',
  'y', '''', 'e', 'yu', 'ya'), ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''',
  'E', 'Yu', 'Ya'));
  var
  I: Integer;
  Lens: Integer;
  P: Integer;
  D: Byte;
  begin
  Result := EmptyStr;
  Lens := Length(Str);
  for I := 1 to Lens do
  begin
  D := 1;
  P := Pos(Str[I], Rarrayl);
  if P = 0 then
  begin
  P := Pos(Str[I], Rarrayu);
  D := 2
  end;
  if P <> 0 then
  Result := Result + Arr[D, P]
  else
  Result := Result + Str[I];
  end;
  end; }

{$ENDREGION}
{$REGION 'Horospope'}

function Horospope(D, M: Integer): Integer;
begin
  Result := 0;
  if (M = 12) and (D >= 22) then
    Result := 32 * 9 // Козерог
  else if (M = 1) and (D <= 20) then
    Result := 32 * 9 // Козерог
  else if (M = 1) and (D >= 21) then
    Result := 32 * 10 // Водолей
  else if (M = 2) and (D <= 18) then
    Result := 32 * 10 // Водолей
  else if (M = 2) and (D >= 19) then
    Result := 32 * 11 // Рыбы
  else if (M = 3) and (D <= 20) then
    Result := 32 * 11 // Рыбы
  else if (M = 3) and (D >= 21) then
    Result := 0 // Овен
  else if (M = 4) and (D <= 20) then
    Result := 0 // Овен
  else if (M = 4) and (D >= 21) then
    Result := 32 // Телец
  else if (M = 5) and (D <= 21) then
    Result := 32 // Телец
  else if (M = 5) and (D >= 22) then
    Result := 32 * 2 // Близнецы
  else if (M = 6) and (D <= 21) then
    Result := 32 * 2 // Близнецы
  else if (M = 6) and (D >= 22) then
    Result := 32 * 3 // Рак
  else if (M = 7) and (D <= 22) then
    Result := 32 * 3 // Рак
  else if (M = 7) and (D >= 23) then
    Result := 32 * 4 // Лев
  else if (M = 8) and (D <= 23) then
    Result := 32 * 4 // Лев
  else if (M = 8) and (D >= 24) then
    Result := 32 * 5 // Дева
  else if (M = 9) and (D <= 23) then
    Result := 32 * 5 // Дева
  else if (M = 9) and (D >= 24) then
    Result := 32 * 6 // Весы
  else if (M = 10) and (D <= 23) then
    Result := 32 * 6 // Весы
  else if (M = 10) and (D >= 24) then
    Result := 32 * 7 // Скорпион
  else if (M = 11) and (D <= 22) then
    Result := 32 * 7 // Скорпион
  else if (M = 11) and (D >= 23) then
    Result := 32 * 8 // Стрелец
  else if (M = 12) and (D <= 21) then
    Result := 32 * 8; // Стрелец
end;

{$ENDREGION}
{$REGION 'Int64ToHex'}

type
  Ti64 = record
    Lo, Hi: Integer;
  end;

function Int64ToHex;
var
  Temp: string[17];
  B: Byte;
  Ch: Byte;
  I64: Ti64 absolute C;
begin
  SetLength(Temp, 17);
  B := 17;
  repeat
    Ch := (I64.Lo and $0F) + Ord('0');
    if Ch > Ord('9') then
      Inc(Ch, Ord('A') - Ord('9') - 1);
    Temp[B] := AnsiChar(Ch);
    Dec(B);
    asm
        MOV     EAX,DWORD PTR [C+4];
        SHRD    DWORD PTR [C],EAX,4
        SHR     EAX,4
        MOV     DWORD PTR[C+4],EAX
    end
    ;
  until (I64.Lo = 0) and (I64.Hi = 0);
  Temp[B] := '$';
  Result := Copy(Temp, B, 255);
end;

{$ENDREGION}
{$REGION 'DaShow'}

procedure DaShow(DaHead, DaText, DaId: string; DaIco, DaColor, DaVisible: Integer);
var
  Da: TJvDesktopAlert;
  Ico: TIcon;
begin
  // Применяем параметры для всплывающего окна
  if DaVisible = 0 then
    DaVisible := V_DATimeShow;
  Da := TJvDesktopAlert.Create(MainForm);
  Da.Options := V_FDAOptions;
  Da.AutoFree := True;
  Da.AutoFocus := False;
  Da.Location.Position := TJvDesktopAlertPosition(V_DAPos);
  Da.AlertStyle := TJvAlertStyle(V_DaStyle);
  Da.StyleHandler.DisplayDuration := DaVisible;
  Da.StyleHandler.StartInterval := 10;
  Da.StyleHandler.StartSteps := 10;
  Da.StyleHandler.EndInterval := 10;
  Da.StyleHandler.EndSteps := 10;
  // Применяем цвет всплывающего окна
  case DaColor of
    0: // Голубой
      begin
        Da.Colors.WindowFrom := TColor($00FFC688);
        Da.Colors.WindowTo := TColor($00FFE3C7);
        // Воспроизводим звук события
        ImPlaySnd(5);
      end;
    1: // Жёлтый
      begin
        Da.Colors.WindowFrom := TColor($0092FFFF);
        Da.Colors.WindowTo := TColor($00B6FFFF);
        // Воспроизводим звук входящего сообщения
        ImPlaySnd(2);
      end;
    2: // Красный
      begin
        Da.Colors.WindowFrom := TColor($009DCDFF);
        Da.Colors.WindowTo := TColor($00DAF4FF);
        // Воспроизводим звук ошибки
        ImPlaySnd(7);
        // Пишем в окно лога
        Xlog(DaHead + C_RN + DaText, EmptyStr);
      end;
    3: // Зелёный
      begin
        Da.Colors.WindowFrom := TColor($0092FF92);
        Da.Colors.WindowTo := TColor($00B6FFB6);
        // Воспроизводим звук события
        ImPlaySnd(5);
      end;
  end;
  // Применяем иконку и текст сообщения
  Ico := TIcon.Create;
  MainForm.AllImageList.GetIcon(DaIco, Ico);
  Da.Image.Assign(Ico);
  Da.HeaderText := DaHead;
  Da.MessageText := DaText;
  Da.Hint := DaId;
  // Вызываем показ всплывающего окна
  Da.Execute;
end;

{$ENDREGION}
{$REGION 'IsoLateTextString'}

function IsoLateTextString(const S: string; Tag1, Tag2: string): string;
var
  PScan, PEnd, PTag1, PTag2: PChar;
  FoundText: string;
  SearchText: string;
begin
  Result := EmptyStr;
  SearchText := UpperCase(S);
  Tag1 := UpperCase(Tag1);
  Tag2 := UpperCase(Tag2);
  PTag1 := PChar(Tag1);
  PTag2 := PChar(Tag2);
  PScan := PChar(SearchText);
  repeat
    PScan := StrPos(PScan, PTag1);
    if PScan <> nil then
    begin
      Inc(PScan, Length(Tag1));
      PEnd := StrPos(PScan, PTag2);
      if PEnd <> nil then
      begin
        SetString(FoundText, PChar(S) + (PScan - PChar(SearchText)), PEnd - PScan);
        Result := FoundText;
        PScan := PEnd + Length(Tag2);
      end
      else
        PScan := nil;
    end;
  until PScan = nil;
end;

{$ENDREGION}
{$REGION 'ReadFromFile'}

function ReadFromFile(FileName: string; AsUnicode: boolean): string;
begin
  with TStringList.Create do
    try
      if AsUnicode then
        LoadFromFile(Filename, TEncoding.Unicode)
      else
        LoadFromFile(Filename, TEncoding.UTF8);
      Result := Text;
    finally
      Free;
    end;
end;

{$ENDREGION}
{$REGION 'Chop'}

function Chop(Ss: string; var S: string): string;
begin
  Result := Chop(Pos(Ss, S), Length(Ss), S);
end;

function Chop(I: Integer; var S: string): string;
begin
  Result := Chop(I, 1, S);
end;

function Chop(I, L: Integer; var S: string): string;
begin
  if I = 0 then
  begin
    Result := S;
    S := EmptyStr;
    Exit;
  end;
  Result := Copy(S, 1, I - 1);
  Delete(S, 1, I - 1 + L);
end;

{$ENDREGION}
{$REGION 'SetClipBoardText'}

procedure SetClipBoardText(Value: string);
begin
  // Копируем строку в буфер обмена вот таким способом (тупо и универсально для wine)
  with TEdit.Create(nil) do
  begin
    try
      Visible := False;
      Parent := LogForm;
      Text := Value;
      SelectAll;
      CopyToClipboard;
    finally
      Free;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'CalculateAge'}

function CalculateAge(BirthDay, CurrentDate: TDate): Integer;
var
  Month, Day, Year, CurrentYear, CurrentMonth, CurrentDay: Word;
begin
  DecodeDate(BirthDay, Year, Month, Day);
  DecodeDate(CurrentDate, CurrentYear, CurrentMonth, CurrentDay);
  if (Year = CurrentYear) and (Month = CurrentMonth) and (Day = CurrentDay) then
  begin
    Result := 0;
  end
  else
  begin
    Result := CurrentYear - Year;
    if (Month > CurrentMonth) then
      Dec(Result)
    else
    begin
      if Month = CurrentMonth then
        if (Day > CurrentDay) then
          Dec(Result);
    end;
  end;
end;

{$ENDREGION}
{$REGION 'HexToInt64'}

function HexToInt64(Hex: string): Int64;
const
  HexValues = '0123456789ABCDEF';
var
  I: Integer;
begin
  Result := 0;
  case Length(Hex) of
    0: Result := 0;
    1..16: for I := 1 to Length(Hex) do
        Result := 16 * Result + Pos(UpCase(Hex[I]), HexValues) - 1;
  else
    for I := 1 to 16 do
      Result := 16 * Result + Pos(UpCase(Hex[I]), HexValues) - 1;
  end;
end;

{$ENDREGION}
{$REGION 'ExisValidCharactersText'}

function ExisValidCharactersText(Value: string): Boolean;
const
  ValidChars = ['a'..'z', 'A'..'Z'];
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(Value) do
    if not CharInSet(Value[I], ValidChars) then
    begin
      Result := False;
      Exit;
    end;
end;

{$ENDREGION}
{$REGION 'ExisValidCharactersDigit'}

function ExisValidCharactersDigit(Value: string): Boolean;
const
  ValidChars = ['0'..'9'];
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(Value) do
    if not CharInSet(Value[I], ValidChars) then
    begin
      Result := False;
      Exit;
    end;
end;

{$ENDREGION}
{$REGION 'FormFlash'}

procedure FormFlash(Hnd: Hwnd);
var
  Rec: FlashWinFo;
begin
  Rec.CbSize := SizeOf(Rec);
  Rec.Hwnd := Hnd;
  Rec.DwFlags := FlasHw_tray or FlasHw_timerNofg;
  Rec.DwTimeout := 0;
  Rec.Ucount := DWORD(-1);
  FlashWindowEx(Rec);
end;

{$ENDREGION}
{$REGION 'TailLineTail'}

function TailLineTail(AHistory: string; AlinesCount: Integer): string;
var
  List: TStringList;
  I, F: Integer;
begin
  // Создаём стринглист для разбивки строк в истории
  List := TStringList.Create;
  try
    // Заносим историю в лист
    List.Text := AHistory;
    // Определяем макс количество строк в истории
    if AlinesCount > List.Count then
      F := List.Count
    else
      F := AlinesCount;
    // Вычисляем обратный отсчёт
    F := List.Count - F;
    // Запускаем цикл граббинда посдежних сообщений из истории
    for I := List.Count - 1 downto F do
      Result := Result + List.Strings[I] + C_RN;
    // Заносим результат снова в список
    List.Text := Result;
    // Обнуляем результат
    Result := EmptyStr;
    // Переворачиваем строки в списке
    for I := List.Count - 1 downto 0 do
      Result := Result + List.Strings[I] + C_RN;
  finally
    List.Free;
  end;
end;

{$ENDREGION}
{$REGION 'GetTimeZone'}

function GetTimeZone: Integer;
var
  TimeZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TimeZone);
  Result := TimeZone.Bias div -60;
end;

{$ENDREGION}
{$REGION 'UnixToDateTime'}

function UnixToDateTime(const Avalue: Int64): TDateTime;
begin
  // Вычисляем время из юникс представления времени
  Result := ((Avalue / SecsPerDay) + UnixDateDelta) + GetTimeZone * С_Hour;
  // Почему то + 1 час нужно добавить для точности
  Result := Result + С_Hour;
end;

{$ENDREGION}
{$REGION 'NumToIp'}

function NumToIp(Addr: Longword): string;
var
  Inaddr: In_addr;
begin
  Inaddr.S_addr := Addr;
  Result := Inet_ntoa(Inaddr);
end;

{$ENDREGION}
{$REGION 'Dump'}

function Dump(Data: RawByteString): string;
const
  Cols = 16;
var
  Ofs, I: Integer;
  S1, S2: string;
begin
  Result := EmptyStr;
  Ofs := 0;
  while Ofs < Length(Data) do
  begin
    S1 := EmptyStr;
    S2 := EmptyStr;
    for I := 1 to Cols do
      if Ofs + I <= Length(Data) then
      begin
        S1 := S1 + IntToHex(Ord(Data[Ofs + I]), 2);
        if I = 8 then
          S1 := S1 + C_BN + C_BN
        else
          S1 := S1 + C_BN;
        if Data[Ofs + I] < #32 then
          S2 := S2 + '.'
        else
          S2 := S2 + Data[Ofs + I];
      end;
    S1 := S1 + StringOfChar(C_BN, Cols * 3 + 4 - Length(S1));
    Result := Result + S1 + S2 + C_RN;
    Inc(Ofs, Cols);
  end;
end;

{$ENDREGION}
{$REGION 'Icq_BodySize'}

function Icq_BodySize(Pkt: string): Integer;
begin
  Result := HexToInt(Text2Hex(Pkt[5] + Pkt[6]));
end;

{$ENDREGION}
{$REGION 'Mra_BodySize'}

function Mra_BodySize(Pkt: string): Integer;
var
  Header: string;
begin
  Header := Text2Hex(Pkt[17] + Pkt[18] + Pkt[19] + Pkt[20]);
  Result := Swap32(HexToInt(Header));
end;

{$ENDREGION}
{$REGION 'ICQ_SendPkt'}

procedure ICQ_SendPkt(Channel, Data: string);
var
  Str: RawByteString;
  I, Len, PktType: Integer;
  S_Name: string;
begin
  // Вычисляем длинну данных
  Len := Length(Hex2text(Data));
  // Преобразуем данные в бинарный формат
  Str := Hex2text('2A0' + Channel + IntToHex(Icq_seq, 4) + IntToHex(Len, 4) + Data);
  // Пишем в лог данные пакета
  if LogForm.ICQDumpSpeedButton.Down then
  begin
    if Length(Str) >= 10 then
      PktType := HexToInt(Text2Hex(Str[8] + Str[10]))
    else
      PktType := 0;
    for I := low(ICQ_Pkt_Names) to high(ICQ_Pkt_Names) do
      if ICQ_Pkt_Names[I].Pkt_Code = PktType then
      begin
        if (PktType = $0001) or (PktType = 0) then
          S_Name := ICQ_Pkt_Names[I + 1].Pkt_Name
        else
          S_Name := ICQ_Pkt_Names[I].Pkt_Name;
        Break;
      end;
    XLog(C_Icq + Log_Send + S_Name + C_RN + Trim(Dump(Str)), C_Icq);
  end;
  // Отсылаем данные по сокету
  MainForm.IcqWSocket.SendStr(Str);
  // Увеличиваем счётчик пакетов
  Inc(Icq_seq);
end;

{$ENDREGION}
{$REGION 'ICQA_SendPkt'}

procedure ICQA_SendPkt(Channel, Data: string);
var
  Str: RawByteString;
  Len: Integer;
begin
  // Вычисляем длинну данных
  Len := Length(Hex2text(Data));
  // Преобразуем данные в бинарный формат
  Str := Hex2text('2A0' + Channel + IntToHex(ICQ_Avatar_Seq, 4) + IntToHex(Len, 4) + Data);
  // Пишем в лог данные пакета
  XLog(C_Icq + 'A' + Log_Send + C_RN + Trim(Dump(Str)), C_Icq);
  // Отсылаем данные по сокету
  Mainform.IcqAvatarWSocket.SendStr(Str);
  // Увеличиваем счётчик пакетов
  Inc(ICQ_Avatar_Seq);
end;

{$ENDREGION}
{$REGION 'Mra_SendPkt'}

procedure Mra_SendPkt(PktType, Data: string; Nolen: Boolean = False);
var
  Str: RawByteString;
  I, Len, C: Integer;
  S_Name: string;
begin
  // Вычисляем длинну данных
  if not Nolen then
    Len := Length(Hex2text(Data)) - 24
  else
    Len := 0;
  // Преобразуем данные в бинарный формат
  Str := Hex2text(Mra_magkey + Mra_protover + IntToHex(Swap32(Mra_seq), 8) + PktType + IntToHex(Swap32(Len), 8) + Data);
  // Пишем в лог данные пакета
  if Assigned(LogForm) then
    if LogForm.MRADumpSpeedButton.Down then
    begin
      C := Swap16(HexToInt(LeftStr(PktType, 4)));
      for I := low(MRA_Pkt_Names) to high(MRA_Pkt_Names) do
        if MRA_Pkt_Names[I].Pkt_Code = C then
        begin
          S_Name := MRA_Pkt_Names[I].Pkt_Name;
          Break;
        end;
      XLog(C_Mra + C_BN + Log_Send + C_BN + S_Name + C_RN + Trim(Dump(Str)), C_Mra);
    end;
  // Отсылаем данные по сокету
  Mainform.MraWSocket.SendStr(Str);
  // Увеличиваем счётчик пакетов
  Inc(Mra_seq);
end;

{$ENDREGION}
{$REGION 'DateTimeChatMess'}

function DateTimeChatMess: string;
begin
  // YYYYMMDDHHNNSS
  Result := FormatDateTime('HH:NN:SS', Time) + C_BN + FormatDateTime('DD.MM.YYYY', Date);
end;

{$ENDREGION}
{$REGION 'NormalizeIcqNumber'}

function NormalizeIcqNumber(Sn: string): string;
const
  ValidChars = ['0'..'9'];
var
  I: Integer;
begin
  Result := EmptyStr;
  for I := 1 to Length(Sn) do
    if (Sn[I] <> '-') and (CharInSet(Sn[I], ValidChars)) then
      Result := Result + Sn[I];
end;

{$ENDREGION}
{$REGION 'ChangeSpaces'}

function ChangeSpaces(const Value: string): string;
begin
  Result := ReplaceStr(Value, C_BN, '%20');
end;

{$ENDREGION}
{$REGION 'ChangeSlash'}

function ChangeSlash(const Value: string): string;
begin
  Result := ReplaceStr(Value, '\', '/');
end;

{$ENDREGION}
{$REGION 'ChangeCP'}

function ChangeCP(const Value: string): string;
begin
  Result := ReplaceStr(Value, '%', '_');
end;

{$ENDREGION}
{$REGION 'DeleteSpaces'}

function DeleteSpaces(const Value: string): string;
begin
  Result := ReplaceStr(Value, C_BN, EmptyStr);
end;

{$ENDREGION}
{$REGION 'NormalizeScreenName'}

function NormalizeScreenName(Sn: string): string;
begin
  Result := LowerCase(DeleteSpaces(Sn));
end;

{$ENDREGION}
{$REGION 'DeleteLineBreaks'}

function DeleteLineBreaks(const S: string): string;
begin
  Result := ReplaceStr(S, C_RN, EmptyStr);
end;

{$ENDREGION}
{$REGION 'HexToInt'}

function HexToInt(Value: string): Longword;
const
  Hexstr: string = '0123456789ABCDEF';
var
  I: Word;
begin
  Result := 0;
  if Value = EmptyStr then
    Exit;
  for I := 1 to Length(Value) do
    Inc(Result, (Pos(Upcase(Value[I]), Hexstr) - 1) shl ((Length(Value) - I) shl 2));
end;

{$ENDREGION}
{$REGION 'Hex2Text'}

function Hex2Text(HexText: string): string;
var
  I: LongInt;
begin
  Result := EmptyStr;
  for I := 1 to Length(HexText) div 2 do
    Result := Result + AnsiChar(StrToInt('$' + Copy(HexText, (I - 1) * 2 + 1, 2)));
end;

{$ENDREGION}
{$REGION 'Text2Hex'}

function Text2Hex(Msg: RawByteString): string;
var
  I: LongInt;
begin
  Result := EmptyStr;
  if Length(Msg) = 0 then
    Exit;
  for I := 1 to Length(Msg) do
  begin
    Result := Result + IntToHex(Ord(Msg[I]), 2);
  end;
end;

{$ENDREGION}
{$REGION 'RightStr'}

function RightStr(const Str: string; Size: Word): string;
var
  Len: Integer;
begin
  if Str = EmptyStr then
    Exit;
  Len := Length(Str);
  if Size > Len then
    Size := Len;
  Result := Copy(Str, Len - Size + 1, Size);
end;

{$ENDREGION}
{$REGION 'LeftStr'}

function LeftStr(const Str: string; Size: Word): string;
begin
  if Str = EmptyStr then
    Exit;
  Result := Copy(Str, 1, Size);
end;

{$ENDREGION}
{$REGION 'NextData'}

function NextData(var Data: string; Count: Integer): string;
var
  Blok: string;
begin
  if Count <= 0 then
  begin
    Result := EmptyStr;
    Exit;
  end;
  if Count > Length(Data) then
  begin
    Result := Data;
    SetLength(Data, 0);
    Exit;
  end;
  Blok := Leftstr(Data, Count);
  Data := Rightstr(Data, Length(Data) - Count);
  Result := Blok;
end;

{$ENDREGION}
{$REGION 'Swap16'}

function Swap16(Value: Word): Word;
  assembler;
asm
    rol   ax,8
end;

{$ENDREGION}
{$REGION 'Swap32'}

function Swap32(Value: Longword): Longword;
  assembler;
asm
    bswap eax
end;

{$ENDREGION}
{$REGION 'Parse'}

function Parse(Char, S: string; Count: Integer): string;
var
  I: Integer;
  T: string;
begin
  if S = EmptyStr then
    Exit;
  if S[Length(S)] <> Char then
    S := S + Char;
  for I := 1 to Count do
  begin
    T := Copy(S, 0, Pos(Char, S) - 1);
    S := Copy(S, Pos(Char, S) + 1, Length(S));
  end;
  Result := T;
end;

{$ENDREGION}
{$REGION 'ListFileInDir'}

procedure ListFileInDir(Path, Eext: string; FileList: TStrings);
var
  Sr: TSearchRec;
begin
  if FindFirst(Path, FaAnyFile, Sr) = 0 then
  begin
    repeat
      if (Sr.Attr <> FaDirectory) then
      begin
        FileList.Add(Parse(Eext, Sr.name, 1));
      end;
    until FindNext(Sr) <> 0;
    FindClose(Sr);
  end;
end;

{$ENDREGION}
{$REGION 'PopUp_Top'}

procedure PopUp_Top(Compon: TComponent; Pm: TPopupMenu);
var
  XPoint: TPoint;
begin
  GetParentForm(TWinControl(Compon)).SendCancelMode(nil);
  Pm.PopUpComponent := TWinControl(Compon);
  XPoint := Point(TWinControl(Compon).Width, TWinControl(Compon).Top);
  with TWinControl(Compon).ClientToScreen(XPoint) do
    Pm.PopUp(X, Y);
end;

{$ENDREGION}
{$REGION 'PopUp_Down'}

procedure PopUp_Down(Compon: TComponent; Pm: TPopupMenu);
var
  XPoint: TPoint;
begin
  GetParentForm(TWinControl(Compon)).SendCancelMode(nil);
  Pm.PopUpComponent := TWinControl(Compon);
  XPoint := Point(TWinControl(Compon).Width, TWinControl(Compon).Top);
  with TWinControl(Compon).ClientToScreen(XPoint) do
    Pm.PopUp(X - 14, Y + 22);
end;

{$ENDREGION}
{$REGION 'InitBuildInfo'}

function InitBuildInfo: string;
var
  S, Ts: string;
  H, Sz, Len: DWORD;
  Buf: PChar;
  Value: Pointer;
begin
  Result := EmptyStr;
  S := Application.Exename;
  Sz := GetFileVersionInfoSize(PChar(S), H);
  if Sz > 0 then
  begin
    try
      Buf := Allocmem(Sz);
      GetFileVersionInfo(PChar(S), H, Sz, Buf);
      VerQueryValue(Buf, '\VarFileInfo\Translation', Value, Len);
      Ts := IntToHex(Makelong(Hiword(Longint(Value^)), Loword(Longint(Value^))), 8);
      // Получаем номер билда
      VerQueryValue(Buf, PChar('StringFileInfo\' + Ts + '\FileVersion'), Pointer(Value), Len);
      if Len > 1 then
        Result := StrPas(PChar(Value));
    except
    end;
  end;
end;

{$ENDREGION}
{$REGION 'PacketToHex'}
{$WARNINGS OFF}

function PacketToHex(Buffer: Pointer; Buflen: Word): string;
var
  S: string;
  I: Integer;
begin
  for I := 1 to Buflen do
  begin
    S := S + IntToHex(Pbyte(Longword(Buffer) + I - 1)^, 2);
  end;
  Result := S;
end;

{$WARNINGS ON}
{$ENDREGION}
{$REGION 'GetRandomHexBytes'}

function GetRandomHexBytes(BytesCount: Integer): string;
const
  Bit16 = '0123456789abcdef';
var
  I: Integer;
begin
  Result := EmptyStr;
  for I := 0 to BytesCount do
  begin
    Result := Result + Bit16[Random(15) + 1];
  end;
end;

{$ENDREGION}
{$REGION 'ErrorHttpClient'}

function ErrorHttpClient(ErrCode: Integer): string;
begin
  case Errcode of
    0: Result := Lang_Vars[23].L_S;
    400: Result := Err400;
    401: Result := Err401;
    402: Result := Err402;
    403: Result := Err403;
    404: Result := Err404;
    405: Result := Err405;
    406: Result := Err406;
    407: Result := Err407;
    408: Result := Err408;
    409: Result := Err409;
    410: Result := Err410;
    411: Result := Err411;
    412: Result := Err412;
    413: Result := Err413;
    414: Result := Err414;
    415: Result := Err415;
    416: Result := Err416;
    417: Result := Err417;
    500: Result := Err500;
    501: Result := Err501;
    502: Result := Err502;
    503: Result := Err503;
    504: Result := Err504;
    505: Result := Err505
  else
    Result := Lang_Vars[23].L_S;
  end;
  Result := Result + '%s' + '[ ' + Format(Lang_Vars[27].L_S, [Errcode]) + ' ]';
end;

{$ENDREGION}
{$REGION 'Min'}

function Min(const A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

{$ENDREGION}
{$REGION 'GetFullTag'}

// Thanks Exodus Project

function GetFullTag(Adata: string): string;

  function Rpos(Find_data, In_data: string): Cardinal;
  var
    Lastpos, Newpos: Cardinal;
    Mybuff: string;
    Origlen: Cardinal;
  begin
    Lastpos := 0;
    Newpos := 0;
    Origlen := Length(Adata);
    repeat
      Mybuff := Copy(In_data, Lastpos + 1, Origlen - Newpos);
      Newpos := Pos(Find_data, Mybuff);
      if (Newpos > 0) then
      begin
        Lastpos := Lastpos + Newpos;
      end;
    until (Newpos <= 0);
    Result := Lastpos;
  end;

var
  Froot, Sbuff, R, Stag, Etag, Tmps: string;
  P, Ls, Le, E, L, Ps, Pe, Ws, Sp, Tb, Cr, Nl, I: Longint;
  _counter: Integer;
begin
  Froot := EmptyStr;
  Result := EmptyStr;
  _counter := 0;
  Sbuff := Adata;
  L := Length(Sbuff);
  if (Trim(Sbuff)) = EmptyStr then
    Exit;
  P := Pos('<', Sbuff);
  if P <= 0 then
  begin
    Dashow(Lang_Vars[17].L_S, Lang_Vars[22].L_S, EmptyStr, 134, 2, 0);
    Exit;
  end;
  Tmps := Copy(Sbuff, P, L - P + 1);
  E := Pos('>', Tmps);
  I := Pos('/>', Tmps);
  if ((E = 0) and (I = 0)) then
    Exit;
  if Froot = EmptyStr then
  begin
    Sp := Pos(C_BN, Tmps);
    Tb := Pos(#09, Tmps);
    Cr := Pos(#10, Tmps);
    Nl := Pos(#13, Tmps);
    Ws := Sp;
    if (Tb > 0) then
      Ws := Min(Ws, Tb);
    if (Cr > 0) then
      Ws := Min(Ws, Cr);
    if (Nl > 0) then
      Ws := Min(Ws, Nl);
    if ((I > 0) and (I < Ws)) then
      Froot := Trim(Copy(Sbuff, P + 1, I - 2))
    else if (E < Ws) then
      Froot := Trim(Copy(Sbuff, P + 1, E - 2))
    else
      Froot := Trim(Copy(Sbuff, P + 1, Ws - 2));
    if (Froot = '?xml') or (Froot = '!ENTITY') or (Froot = '!--') or (Froot = '!ATTLIST') or (Froot = J_RootTag) then
    begin
      R := Copy(Sbuff, P, E);
      Froot := EmptyStr;
      Jabber_buffpkt := Copy(Sbuff, P + E, L - E - P + 1);
      Result := R;
      Exit;
    end;
  end;
  if (E = (I + 1)) then
  begin
    R := Copy(Sbuff, P, E);
    Froot := EmptyStr;
    Jabber_buffpkt := Copy(Sbuff, P + E, L - E - P + 1);
  end
  else
  begin
    I := P;
    Stag := '<' + Froot;
    Etag := '</' + Froot + '>';
    Ls := Length(Stag);
    Le := Length(Etag);
    R := EmptyStr;
    repeat
      Tmps := Copy(Sbuff, I, L - I + 1);
      Ps := Pos(Stag, Tmps);
      if (Ps > 0) then
      begin
        _counter := _counter + 1;
        I := I + Ps + Ls - 1;
      end;
      Tmps := Copy(Sbuff, I, L - I + 1);
      Pe := Rpos(Etag, Tmps);
      if ((Pe > 0) and ((Ps > 0) and (Pe > Ps))) then
      begin
        _counter := _counter - 1;
        I := I + Pe + Le - 1;
        if (_counter <= 0) then
        begin
          R := Copy(Sbuff, P, I - P);
          Froot := EmptyStr;
          Jabber_buffpkt := Copy(Sbuff, I, L - I + 1);
          Break;
        end;
      end;
    until ((Pe <= 0) or (Ps <= 0) or (Tmps = EmptyStr));
  end;
  Result := R;
end;

{$ENDREGION}
{$REGION 'InitMixer'}

function InitMixer: Hmixer;
var
  Err: MmResult;
begin
  Err := MixerOpen(@Result, 0, 0, 0, 0);
  if Err <> MmSysErr_NoError then
    Result := 0;
end;

{$ENDREGION}
{$REGION 'ImPlaySnd'}

procedure ImPlaySnd(Snd: Integer);
const
  f_ext = '.wav';
var
  SFilePath: string;
begin
  // Играем звуки IMadering
  { 1 - Подключение протокола
    2 - Входящее сообщение
    3 - Сообщение отправлено
    4 - Контакт вошёл в сеть
    5 - Сервисные оповещения
    6 - Передача файла завершена
    7 - Оповещение об ошибке
    ------------------------
    8 - Набор текста
    9 - Удаление текста
    10 - Отправка текста
    ------------------------
    11 - Контакт отключился }
  if V_SoundON then
  begin
    case Snd of
      1: if (V_SoundConnect) and (FileExists(V_SoundConnect_Path)) then
          Sndplaysound(PChar(V_SoundConnect_Path), Snd_async);
      2: if (V_SoundIncMsg) and (FileExists(V_SoundIncMsg_Path)) then
          Sndplaysound(PChar(V_SoundIncMsg_Path), Snd_async);
      3: if (V_SoundMsgSend) and (FileExists(V_SoundMsgSend_Path)) then
          Sndplaysound(PChar(V_SoundMsgSend_Path), Snd_async);
      4: if (V_SoungUserOnline) and (FileExists(V_SoungUserOnline_Path)) then
          Sndplaysound(PChar(V_SoungUserOnline_Path), Snd_async);
      5: if (V_SoundEvent) and (FileExists(V_SoundEvent_Path)) then
          Sndplaysound(PChar(V_SoundEvent_Path), Snd_async);
      6: if (V_SoundFileSend) and (FileExists(V_SoundFileSend_Path)) then
          Sndplaysound(PChar(V_SoundFileSend_Path), Snd_async);
      7: if (V_SoundError) and (FileExists(V_SoundError_Path)) then
          Sndplaysound(PChar(V_SoundError_Path), Snd_async);
      8:
        begin
          SFilePath := V_MyPath + C_SoundsFolder + V_CurrentSounds + C_SN + 'Type' + f_ext;
          if (FileExists(SFilePath)) then
            Sndplaysound(PChar(SFilePath), Snd_async);
        end;
      9:
        begin
          SFilePath := V_MyPath + C_SoundsFolder + V_CurrentSounds + C_SN + 'Back' + f_ext;
          if (FileExists(SFilePath)) then
            Sndplaysound(PChar(SFilePath), Snd_async);
        end;
      10:
        begin
          if (V_SoundON) and (V_SoundMsgSend) then
            Exit;
          SFilePath := V_MyPath + C_SoundsFolder + V_CurrentSounds + C_SN + 'MsgSend' + f_ext;
          if (FileExists(SFilePath)) then
            Sndplaysound(PChar(SFilePath), Snd_async);
        end;
      11: if (V_SoundUserOffline) and (FileExists(V_SoundUserOffline_Path)) then
          Sndplaysound(PChar(V_SoundUserOffline_Path), Snd_async);
    end;
  end;
end;

{$ENDREGION}
{$REGION 'SearchNickInCash'}

function SearchNickInCash(CType, CId: string): string;
begin
  Result := CId;
  // Проверяем создан ли список ников
  if Assigned(V_AccountToNick) then
  begin
    // Находим ники в списке ников по учётной записи
    Result := V_AccountToNick.Values[Ctype + C_BN + Cid];
  end;
end;

{$ENDREGION}
{$REGION 'SetCustomWidthComboBox'}

procedure SetCustomWidthComboBox(Cb: TComboBox);
var
  I, ItemWidth, CWidth: Integer;
begin
  // Выравниваем ширину списка по самой длинной строке
  ItemWidth := 0;
  with Cb do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[I]);
      if CWidth > ItemWidth then
        ItemWidth := CWidth;
    end;
    if Items.Count > DropDownCount then
      Perform(Cb_SetDroppedWidth, Itemwidth + 25, 0)
    else
      Perform(Cb_SetDroppedWidth, Itemwidth + 8, 0);
  end;
end;

{$ENDREGION}
{$REGION 'OpenURL'}

procedure OpenURL(URL: string);
var
  Ts: string;
begin
  // Ищем в реестре браузер по умолчанию
  with Tregistry.Create do
    try
      Rootkey := Hkey_classes_root;
      OpenKey('\http\shell\open\command', False);
      try
        Ts := ReadString(EmptyStr);
      except
        Ts := EmptyStr;
      end;
      CloseKey;
    finally
      Free;
    end;
  if Ts = EmptyStr then
  begin
    SetClipBoardText(Url);
    Dashow(Lang_Vars[17].L_S, Lang_Vars[108].L_S, EmptyStr, 134, 2, 0);
    Exit;
  end;
  if Pos('"', Ts) > 0 then
    Ts := Parse('"', Ts, 2);
  // Проверяем под wine запущена программа или нет
  if Pos('winebrowser.exe', Ts) = 0 then
  begin
    Url := ChangeSpaces(Url); // Преобразуем пробелы в %20
    // Проверяем мыло это или ссылка
    if Copy(URL, 1, 7) = C_MailTo then
    begin
      Ts := URL;
      URL := EmptyStr;
    end;
  end
  else
  begin
    if Pos(':\', Url) > 0 then
      Url := '"' + ChangeSlash(Url) + '"'; // Для открытия в winebrowser
  end;
  ShellExecute(0, 'open', PChar(Ts), PChar(Url), nil, SW_Show);
end;

{$ENDREGION}
{$REGION 'CreateHistoryArhive'}

function CreateHistoryArhive(HFile: string): Boolean;
var
  AFormat: TJclCompressArchiveClass;
  FCompressionLevel: IJclArchiveCompressionLevel;
  FCompressHeader: IJclArchiveCompressHeader;
  FSaveCreationDateTime: IJclArchiveSaveCreationDateTime;
  FSaveLastAccessDateTime: IJclArchiveSaveLastAccessDateTime;
  HArhFile: string;
  N: Integer;
begin
  Result := False;
  // Проверяем размер файла истории
  if Getfilesize(HFile) > 1000000 then
  begin
    FreeAndNil(V_FArchive);
    // Проверяем какой номер архива свободен
    N := 1;
    HArhFile := Copy(HFile, 1, Length(HFile) - 4);
    while FileExists(HArhFile + ' [' + IntToStr(N) + '].7z') do
      Inc(N);
    HArhFile := HArhFile + ' [' + IntToStr(N) + '].7z';
    // Инициализируем архиватор по расширению 7z
    AFormat := GetArchiveFormats.FindCompressFormat(HArhFile);
    if AFormat <> nil then
    begin
      // Устанавливаем параметры архивирования
      V_FArchive := AFormat.Create(HArhFile);
      V_FArchive.Password := EmptyStr;
      (V_FArchive as TJclCompressArchive)
        .AddFile(ExtractFileName(HFile), HFile);
      Supports(IUnknown(V_FArchive), IJclArchiveCompressionLevel, FCompressionLevel);
      Supports(IUnknown(V_FArchive), IJclArchiveCompressHeader, FCompressHeader);
      Supports(IUnknown(V_FArchive), IJclArchiveSaveCreationDateTime, FSaveCreationDateTime);
      Supports(IUnknown(V_FArchive), IJclArchiveSaveLastAccessDateTime, FSaveLastAccessDateTime);
      FCompressionLevel.CompressionLevel := 9;
      FCompressHeader.CompressHeader := True;
      FCompressHeader.CompressHeaderFull := True;
      FSaveLastAccessDateTime.SaveLastAccessDateTime := False;
      FSaveCreationDateTime.SaveCreationDateTime := False;
      // Упаковываем файл архиватором 7zip
      (V_FArchive as TJclCompressArchive).Compress;
      // Завершаем процесс архивирования
      FreeAndNil(V_FArchive);
      Result := True;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'UnpackArhive'}

function UnpackArhive(HFile: string): Boolean;
var
  ArchiveFileName: string;
  AFormat: TJclDecompressArchiveClass;
begin
  // Распаковываем архив
  Result := False;
  FreeAndNil(V_FArchive);
  ArchiveFileName := HFile;
  AFormat := GetArchiveFormats.FindDecompressFormat(ArchiveFileName);
  if AFormat <> nil then
  begin
    V_FArchive := AFormat.Create(ArchiveFileName);
    V_FArchive.Password := EmptyStr;
    V_FArchive.OnProgress := UpdateForm.ArchiveProgress;
    if V_FArchive is TJclDecompressArchive then
    begin
      TJclDecompressArchive(V_FArchive).ListFiles;
      TJclDecompressArchive(V_FArchive).ExtractAll(V_MyPath, True);
    end;
    Result := True;
  end;
end;

{$ENDREGION}
{$REGION 'CheckMessage_Smilies'}

procedure CheckMessage_Smilies(var Msg: string);
var
  ImgTag, Cod: string;
  I, II: Integer;

  function GenTag(Path, Alt: string): string;
  begin
    Result := Format(ImgTag, [Path, Alt]);
  end;

begin
  // Определяем html тэги для вставки смайлов заместо их текстовых обозначений
  ImgTag := '<img src="./Smilies/' + V_CurrentSmiles + '/%s" ALIGN="ABSMIDDLE" vspace="3" BORDER="0" alt="%s">';
  // Сканируем список кодов смайлов на совпадения
  for I := 1 to V_SmilesList.Count - 1 do
  begin
    for II := 1 to 20 do
    begin
      Cod := Parse(',', V_SmilesList.Strings[I], II);
      if Cod > EmptyStr then
      begin
        if Pos(Cod, Msg) > 0 then
          Msg := ReplaceText(Msg, Cod, GenTag(IntToStr(I) + '.gif', Cod));
      end
      else
        Break;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'HtmlStrToString'}

function HtmlStrToString(const HtmlText: string): string;
var
  I, J, HtmlLength: Integer;
begin
  I := 1;
  HtmlLength := Length(HtmlText);
  while I <= HtmlLength do
  begin
    if (HtmlText[I] = '&') and (HtmlText[I + 1] = '#') then
    begin
      for J := I + 2 to HtmlLength do
        if HtmlText[J] = ';' then
        begin
          Result := Result + Char(StrToIntDef(Copy(HTMLText, I + 2, J - (I + 2)), 0));
          I := J;
          Break;
        end;
    end
    else
      Result := Result + HtmlText[I];
    Inc(I);
  end;
end;

{$ENDREGION}
{$REGION 'Twit_ParseDateTime'}

{ function Twit_ParseDateTime(Sdate: string): TDateTime;
  var
  DayOfWeek, Smonth, DayInMonth, Time, Offset, Year: string;
  Hour, Minute, Second: string;
  Month, I: Integer;
  begin
  Result := now;
  // Разбираем фиксированную структуру даты в твите
  DayOfWeek := Trim(Copy(Sdate, 0, 3));
  Smonth := Trim(Copy(Sdate, 5, 3));
  DayInMonth := Trim(Copy(Sdate, 9, 2));
  Offset := Trim(Copy(Sdate, 20, 6));
  Year := Trim(Copy(Sdate, 27, 5));
  Time := Trim(Copy(Sdate, 11, 9));
  Hour := Trim(Copy(Time, 1, 2));
  Minute := Trim(Copy(Time, 4, 2));
  Second := Trim(Copy(Time, 7, 2));
  // Вычисляем месяц
  Month := 1;
  for I := 1 to 12 do
  begin
  if ShortMonthNames[I] = Smonth then
  Month := I
  end;
  // Преобразуем полученные данные в нормальный формат
  Result := EncodeDateTime(StrToInt(Year), Month, StrToInt(DayInMonth), StrToInt(Hour), StrToInt(Minute), StrToInt(Second), 0);
  end; }

{$ENDREGION}
{$REGION 'LoadHTMLStrings'}

procedure LoadHTMLStrings(HtmlV: THTMLViewer; HtmlS: string);
begin
  // Объявляем текущую папку
  SetCurrentDir(V_MyPath);
  // Подгружаем текст в компонент HTML
  HtmlV.LoadFromBuffer(PChar(HtmlS), Length(HtmlS), EmptyStr);
end;

{$ENDREGION}
{$REGION 'CloseSmiliesHint'}

procedure CloseSmiliesHint;
begin
  // Убираем подсказки
  MainForm.JvTimerList.Events[14].Enabled := False;
  SH_HintWindow.ReleaseHandle;
  SH_HintVisible := False;
end;

{$ENDREGION}
{$REGION 'ShowSmiliesHint'}

procedure ShowSmiliesHint(HtmlV: THTMLViewer);
const
  StartCount = 2;
  EndCount = 20;
var
  Pt, Pt1: TPoint;
  ARect: TRect;
  TitleStr: string;
begin
  // Определяем показывать ли всплывающие подсказки
  if Assigned(SH_HintWindow) then
  begin
    Inc(SH_TimerCount);
    GetCursorPos(Pt);
    Pt1 := HtmlV.ScreenToClient(Pt);
    TitleStr := HtmlV.TitleAttr;
    if (TitleStr = EmptyStr) or not PtInRect(HtmlV.ClientRect, Pt1) then
    begin
      SH_OldTitle := EmptyStr;
      CloseSmiliesHint;
      Exit;
    end;
    if TitleStr <> SH_OldTitle then
    begin
      SH_TimerCount := 0;
      SH_OldTitle := TitleStr;
      SH_HintWindow.ReleaseHandle;
      SH_HintVisible := False;
      Exit;
    end;
    if SH_TimerCount > EndCount then
      CloseSmiliesHint
    else if (SH_TimerCount >= StartCount) and not SH_HintVisible then
    begin
      ARect := SH_HintWindow.CalcHintRect(300, TitleStr, nil);
      with ARect do
        SH_HintWindow.ActivateHint(Rect(Pt.X, Pt.Y + 18, Pt.X + Right, Pt.Y + 18 + Bottom), TitleStr);
      SH_HintVisible := True;
    end;
  end;
end;

{$ENDREGION}

end.

