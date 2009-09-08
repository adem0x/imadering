{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit UtilsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, MMSystem, StrUtils, JvDesktopAlert, ShellApi,
  JvDesktopAlertForm, StdCtrls, VarsUnit, MainUnit, IcqProtoUnit, JvTrayIcon,
  WinSock, OverbyteIcsWSocket, CategoryButtons, JvZLibMultiple, JabberProtoUnit;

function Parse(Char, S: string; Count: Integer): string;
procedure ListFileDirHist(Path, Ext, Eext: string; FileList: TStrings);
procedure GetTreeDirs(Root: string; out OutString: TStringList);
function Hex2Text(hextext: string): string;
function Text2Hex(msg: string): string;
function RightStr(const Str: string; Size: Word): string;
function LeftStr(const Str: string; Size: Word): string;
function HexToInt(Value: string): LongWord;
function NextData(var Data: string; Count: integer): string;
function Swap16(Value: Word): Word; assembler;
function Swap32(Value: LongWord): LongWord; assembler;
function MD5PointerToHex(Buffer: Pointer): string;
function DeleteSpaces(const Value: string): string;
function DeleteLineBreaks(const S: string): string;
function exNormalizeScreenName(SN: string): string;
function exNormalizeIcqNumber(SN: string): string;
function NormalizeCellularNumber(const Value: string): string;
function AppendOrWriteTextToFile(FileName: TFilename; WriteText: string): boolean;
function DateTimeChatMess: string;
function SendFLAP(Channel, Data: string): boolean;
function SendFLAP_Avatar(Channel, Data: string): boolean;
function NumToIp(Addr: LongWord): string;
function UnixToDateTime(const AValue: Int64): TDateTime;
function GetTimeZone: integer;
function DecodeStr(msg: string): string;
function TailLineTail(aHistory: string; aLinesCount: Integer): string;
function BMSearch(StartPos: Integer; const S, P: string): Integer;
function StrToUTF8(Value: string): string;
function RTF2Plain(const aSource: string): string;
procedure FormFlash(hnd: hwnd);
function exIsValidCharactersText(Value: string): Boolean;
function exIsValidCharactersDigit(Value: string): Boolean;
function HexToInt64(Hex: string): int64;
function CalculateAge(Birthday, CurrentDate: TDate): Integer;
function SetClipboardText(Wnd: HWND; Value: string): Boolean;
//function Dump(data: string): string;
function chop(i: integer; var s: string): string; overload;
function chop(i, l: integer; var s: string): string; overload;
function chop(ss: string; var s: string): string; overload;
function ReadFromFile(FileName: string): string;
function IsolateTextString(const S: string; Tag1, Tag2: string): string;
function Int64ToHex(c: int64): string;
function Horospope(d, m: integer): integer;
function TranslitRus2Lat(const Str: string): string;
procedure DAShow(DAHead, DAText, DAID: string; DAIco, DAColor, DAVisible: integer);
function InitMixer: HMixer;
function UnicodeCharCode2ANSIString(aCode: Word): string;
function ICQ_BodySize1: integer;
function ICQ_BodySize2: integer;
function ICQ_BodySize3: integer;
function IsNotNull(StringsArr: array of string): boolean;
procedure DecorateURL(var Text: string);
function NameAndLast(UIN: string): string;
procedure Popup(Compon: TComponent; pm: TPopupMenu);
procedure Popup_down(Compon: TComponent; pm: TPopupMenu);
function InitBuildInfo: string;
procedure Zip_File(FileName: TStrings; SFileName: string);
procedure UnZip_File(FileName, SDir: string);
function GetFileSize(FileName: string): Longint;
procedure UnZip_Stream(FileName: TStream; SDir: string);
function PacketToHex(Buffer: Pointer; BufLen: Word): string;
function GetRandomHexBytes(BytesCount: Integer): string;
function ErrorHttpClient(ErrCode: integer): string;
function GetFullTag(AData: string): string;
procedure ImPlaySnd(Snd: integer);
function SearchNickInCash(cType, cId: string): string;
function CopyDir(const FromDir, ToDir: string): Boolean;
function NormalDir(const DirName: string): string;
function ClearDir(const Path: string; Delete: Boolean): Boolean;
procedure SetCustomWidthComboBox(CB: TComboBox);
procedure xShowForm(xForm: TForm);

implementation

procedure xShowForm(xForm: TForm);
begin
  //--Автоматизируем показ окон
  if xForm.Visible then ShowWindow(xForm.Handle, SW_RESTORE);
  xForm.Show;
  SetForeGroundWindow(xForm.Handle);
end;

function GetFileSize(FileName: string): Longint;
var
  SearchRec: TSearchRec;
begin
  Result := -1;
  if FindFirst(FileName, faAnyFile, SearchRec) = 0 then
  try
    Result := SearchRec.Size;
  finally
    FindClose(SearchRec);
  end;
end;

function NameAndLast(UIN: string): string;
//var
  //Ln, Lf: string;
begin
  {Result := '';
  if FileExists(MyPath + 'Users\Details\' + UIN + '.inf') then
  begin
    Uini := TIniFile.Create(MyPath + 'Users\Details\' + UIN + '.inf');
    //
    Ln := Uini.ReadString('Info', 'cFirst', '');
    Lf := Uini.ReadString('Info', 'cLast', '');
    if IsNotNull([Ln, Lf]) then
    begin
      if Ln > '' then Result := Result + Ln;
      if (Ln > '') and (Lf > '') then Result := Result + ' ' + Lf
      else if (Ln = '') and (Lf > '') then Result := Result + Lf;
    end;
    //
    Uini.Free;
  end;}
end;

procedure DecorateURL(var Text: string);
var
  s, Ltext: string;
begin
  Ltext := LowerCase(text);
  //
  if pos('http://', Ltext) > 0 then
  begin
    s := Ltext;
    delete(s, 1, pos('http://', s) - 1);
    if pos(' ', s) > 0 then
    begin
      s := copy(s, 1, pos(' ', s) - 1);
      if pos('<br>', s) > 0 then s := copy(s, 1, pos('<br>', s) - 1);
    end
    else
      if pos('<br>', s) > 0 then
      begin
        s := copy(s, 1, pos('<br>', s) - 1);
        if pos(' ', s) > 0 then s := copy(s, 1, pos(' ', s) - 1);
      end
      else s := copy(s, 1, length(s));
    text := StringReplace(Ltext, s, '<a href="' + s + '">' + s + '</a>', [rfReplaceall]);
    Exit;
  end;
  //
  if pos('https://', Ltext) > 0 then
  begin
    s := Ltext;
    delete(s, 1, pos('https://', s) - 1);
    if pos(' ', s) > 0 then
    begin
      s := copy(s, 1, pos(' ', s) - 1);
      if pos('<br>', s) > 0 then s := copy(s, 1, pos('<br>', s) - 1);
    end
    else
      if pos('<br>', s) > 0 then
      begin
        s := copy(s, 1, pos('<br>', s) - 1);
        if pos(' ', s) > 0 then s := copy(s, 1, pos(' ', s) - 1);
      end
      else s := copy(s, 1, length(s));
    text := StringReplace(Ltext, s, '<a href="' + s + '">' + s + '</a>', [rfReplaceall]);
    Exit;
  end;
  //
  if pos('www.', Ltext) > 0 then
  begin
    s := Ltext;
    delete(s, 1, pos('www.', s) - 1);
    if pos(' ', s) > 0 then
    begin
      s := copy(s, 1, pos(' ', s) - 1);
      if pos('<br>', s) > 0 then s := copy(s, 1, pos('<br>', s) - 1);
    end
    else
      if pos('<br>', s) > 0 then
      begin
        s := copy(s, 1, pos('<br>', s) - 1);
        if pos(' ', s) > 0 then s := copy(s, 1, pos(' ', s) - 1);
      end
      else s := copy(s, 1, length(s));
    text := StringReplace(Ltext, s, '<a href="' + s + '">' + s + '</a>', [rfReplaceall]);
    Exit;
  end;
  //
  if pos('ftp://', Ltext) > 0 then
  begin
    s := Ltext;
    delete(s, 1, pos('ftp://', s) - 1);
    if pos(' ', s) > 0 then
    begin
      s := copy(s, 1, pos(' ', s) - 1);
      if pos('<br>', s) > 0 then s := copy(s, 1, pos('<br>', s) - 1);
    end
    else
      if pos('<br>', s) > 0 then
      begin
        s := copy(s, 1, pos('<br>', s) - 1);
        if pos(' ', s) > 0 then s := copy(s, 1, pos(' ', s) - 1);
      end
      else s := copy(s, 1, length(s));
    text := StringReplace(Ltext, s, '<a href="' + s + '">' + s + '</a>', [rfReplaceall]);
    Exit;
  end;
end;

function IsNotNull(StringsArr: array of string): boolean;
var
  i: integer;
begin
  Result := True;
  for i := Low(StringsArr) to High(StringsArr) do
  begin
    if Trim(StringsArr[i]) <> '' then Exit;
  end;
  Result := False;
end;

function TranslitRus2Lat(const Str: string): string;
const
  RArrayL = 'абвгдеёжзийклмнопрстуфхцчшщьыъэюя';
  RArrayU = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ';
  colChar = 33;
  arr: array[1..2, 1..ColChar] of string =
  (('a', 'b', 'v', 'g', 'd', 'e', 'yo', 'zh', 'z', 'i', 'y',
    'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f',
    'kh', 'ts', 'ch', 'sh', 'shch', '''', 'y', '''', 'e', 'yu', 'ya'),
    ('A', 'B', 'V', 'G', 'D', 'E', 'Yo', 'Zh', 'Z', 'I', 'Y',
    'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F',
    'Kh', 'Ts', 'Ch', 'Sh', 'Shch', '''', 'Y', '''', 'E', 'Yu', 'Ya'));
var
  i: Integer;
  LenS: Integer;
  p: integer;
  d: byte;
begin
  result := '';
  LenS := length(str);
  for i := 1 to lenS do
  begin
    d := 1;
    p := pos(str[i], RArrayL);
    if p = 0 then
    begin
      p := pos(str[i], RArrayU);
      d := 2
    end;
    if p <> 0 then
      result := result + arr[d, p]
    else
      result := result + str[i];
  end;
end;

function Horospope(d, m: integer): integer;
begin
  Result := 0;
  if (m = 12) and (d >= 22) then Result := 32 * 9 //--Козерог
  else if (m = 1) and (d <= 20) then Result := 32 * 9 //--Козерог
  else if (m = 1) and (d >= 21) then Result := 32 * 10 //--Водолей
  else if (m = 2) and (d <= 18) then Result := 32 * 10 //--Водолей
  else if (m = 2) and (d >= 19) then Result := 32 * 11 //--Рыбы
  else if (m = 3) and (d <= 20) then Result := 32 * 11 //--Рыбы
  else if (m = 3) and (d >= 21) then Result := 0 //--Овен
  else if (m = 4) and (d <= 20) then Result := 0 //--Овен
  else if (m = 4) and (d >= 21) then Result := 32 //--Телец
  else if (m = 5) and (d <= 21) then Result := 32 //--Телец
  else if (m = 5) and (d >= 22) then Result := 32 * 2 //--Близнецы
  else if (m = 6) and (d <= 21) then Result := 32 * 2 //--Близнецы
  else if (m = 6) and (d >= 22) then Result := 32 * 3 //--Рак
  else if (m = 7) and (d <= 22) then Result := 32 * 3 //--Рак
  else if (m = 7) and (d >= 23) then Result := 32 * 4 //--Лев
  else if (m = 8) and (d <= 23) then Result := 32 * 4 //--Лев
  else if (m = 8) and (d >= 24) then Result := 32 * 5 //--Дева
  else if (m = 9) and (d <= 23) then Result := 32 * 5 //--Дева
  else if (m = 9) and (d >= 24) then Result := 32 * 6 //--Весы
  else if (m = 10) and (d <= 23) then Result := 32 * 6 //--Весы
  else if (m = 10) and (d >= 24) then Result := 32 * 7 //--Скорпион
  else if (m = 11) and (d <= 22) then Result := 32 * 7 //--Скорпион
  else if (m = 11) and (d >= 23) then Result := 32 * 8 //--Стрелец
  else if (m = 12) and (d <= 21) then Result := 32 * 8; //--Стрелец
end;

type Ti64 = record Lo, Hi: integer; end;

function Int64ToHex;
var
  Temp: string[17];
  b: byte;
  ch: byte;
  i64: Ti64 absolute c;
begin
  SetLength(Temp, 17);
  b := 17;
  repeat
    Ch := (i64.Lo and $0F) + Ord('0');
    if Ch > Ord('9') then Inc(Ch, Ord('A') - Ord('9') - 1);
    Temp[b] := Char(Ch);
    Dec(b);
    asm
      MOV     EAX,DWORD PTR [C+4];
      SHRD    DWORD PTR [C],EAX,4
      SHR     EAX,4
      MOV     DWORD PTR[C+4],EAX
    end;
  until (i64.Lo = 0) and (i64.Hi = 0);
  Temp[b] := '$';
  Result := Copy(Temp, b, 255);
end;

procedure DAShow(DAHead, DAText, DAID: string; DAIco, DAColor, DAVisible: integer);
var
  DA: TJvDesktopAlert;
  Ico: TIcon;
begin
  //--Применяем параметры для всплывающего окна
  if DAVisible = 0 then DAVisible := DATimeShow;
  DA := TJvDesktopAlert.Create(MainForm);
  DA.Options := FDAOptions;
  DA.AutoFree := true;
  DA.AutoFocus := false;
  DA.Location.Position := TJvDesktopAlertPosition(DAPos);
  DA.AlertStyle := TJvAlertStyle(DAStyle);
  DA.StyleHandler.DisplayDuration := DAVisible;
  DA.StyleHandler.StartInterval := 10;
  DA.StyleHandler.StartSteps := 10;
  DA.StyleHandler.EndInterval := 10;
  DA.StyleHandler.EndSteps := 10;
  //--Применяем цвет всплывающего окна
  case DAColor of
    0: //--Голубой
      begin
        DA.Colors.WindowFrom := TColor($00FFC688);
        DA.Colors.WindowTo := TColor($00FFE3C7);
      end;
    1: //--Жёлтый
      begin
        DA.Colors.WindowFrom := TColor($0092FFFF);
        DA.Colors.WindowTo := TColor($00B6FFFF);
      end;
    2: //--Красный
      begin
        DA.Colors.WindowFrom := TColor($009DCDFF);
        DA.Colors.WindowTo := TColor($00DAF4FF);
      end;
    3: //--Зелёный
      begin
        DA.Colors.WindowFrom := TColor($0092FF92);
        DA.Colors.WindowTo := TColor($00B6FFB6);
      end;
  end;
  //--Применяем иконку и текст сообщения
  Ico := TIcon.Create;
  MainForm.AllImageList.GetIcon(DAIco, Ico);
  DA.Image.Assign(Ico);
  DA.HeaderText := DAHead;
  DA.MessageText := DAText;
  DA.Hint := DAID;
  //--Вызываем непосредственно сам показ всплывающего окна
  DA.Execute;
end;

function IsolateTextString(const S: string; Tag1, Tag2: string): string;
var
  pScan, pEnd, pTag1, pTag2: PChar;
  foundText: string;
  searchtext: string;
begin
  Result := '';
  searchtext := Uppercase(S);
  Tag1 := Uppercase(Tag1);
  Tag2 := Uppercase(Tag2);
  pTag1 := PChar(Tag1);
  pTag2 := PChar(Tag2);
  pScan := PChar(searchtext);
  repeat
    pScan := StrPos(pScan, pTag1);
    if pScan <> nil then
    begin
      Inc(pScan, Length(Tag1));
      pEnd := StrPos(pScan, pTag2);
      if pEnd <> nil then
      begin
        SetString(foundText,
          Pchar(S) + (pScan - PChar(searchtext)),
          pEnd - pScan);
        Result := foundText;
        pScan := pEnd + Length(tag2);
      end
      else
        pScan := nil;
    end;
  until pScan = nil;
end;

function ReadFromFile(FileName: string): string;
begin
  with TStringList.create do
  try
    LoadFromFile(FileName);
    result := text;
  finally
    Free;
  end;
end;

function chop(ss: string; var s: string): string;
begin
  result := chop(pos(ss, s), length(ss), s);
end;

function chop(i: integer; var s: string): string;
begin
  result := chop(i, 1, s);
end;

function chop(i, l: integer; var s: string): string;
begin
  if i = 0 then
  begin
    result := s;
    s := '';
    exit;
  end;
  result := copy(s, 1, i - 1);
  delete(s, 1, i - 1 + l);
end;

function SetClipboardText(Wnd: HWND; Value: string): Boolean;
var
  hData: HGlobal;
  pData: pointer;
  Len: integer;
begin
  Result := True;
  if OpenClipboard(Wnd) then
  begin
    try
      Len := Length(Value) + 1;
      hData := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, Len);
      try
        pData := GlobalLock(hData);
        try
          Move(PChar(Value)^, pData^, Len);
          EmptyClipboard;
          SetClipboardData(CF_Text, hData);
        finally
          GlobalUnlock(hData);
        end;
      except
        GlobalFree(hData);
        raise
      end;
    finally
      CloseClipboard;
    end;
  end
  else
    Result := False;
end;

function CalculateAge(Birthday, CurrentDate: TDate): Integer;
var
  Month, Day, Year, CurrentYear, CurrentMonth, CurrentDay: Word;
begin
  DecodeDate(Birthday, Year, Month, Day);
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

function HexToInt64(Hex: string): int64;
const
  HexValues = '0123456789ABCDEF';
var
  i: integer;
begin
  Result := 0;
  case Length(Hex) of
    0: Result := 0;
    1..16: for i := 1 to Length(Hex) do
        Result := 16 * Result + Pos(Upcase(Hex[i]), HexValues) - 1;
  else for i := 1 to 16 do
      Result := 16 * Result + Pos(Upcase(Hex[i]), HexValues) - 1;
  end;
end;

function exIsValidCharactersText(Value: string): Boolean;
const
  ValidAsciiChars = ['a'..'z', 'A'..'Z'];
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(Value) do
    if not (Value[i] in ValidAsciiChars) then
    begin
      Result := False;
      Exit;
    end;
end;

function exIsValidCharactersDigit(Value: string): Boolean;
const
  ValidAsciiChars = ['0'..'9'];
var
  i: Integer;
begin
  Result := True;
  for i := 1 to Length(Value) do
    if not (Value[i] in ValidAsciiChars) then
    begin
      Result := False;
      Exit;
    end;
end;

procedure FormFlash(hnd: hwnd);
var
  rec: FLASHWINFO;
begin
  rec.cbSize := sizeOf(rec);
  rec.hwnd := hnd;
  rec.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
  rec.dwTimeout := 0;
  rec.uCount := dword(-1);
  flashWindowEx(rec);
end;

function UnicodeCharCode2ANSIString(aCode: Word): string;
var
  Buf: array[0..1] of Word;
begin
  Buf[0] := aCode;
  Buf[1] := 0;
  UnicodeCharCode2ANSIString := WideCharToString(@Buf[0])[1];
end;

function RTF2Plain(const aSource: string): string;
var
  Source: string;
  NChar: Integer;

  function ProcessGroupRecursevly: string;

    procedure SkipStar;
    var
      BracesOpened: Integer;
      Escaped: Boolean;
    begin
      BracesOpened := 1;
      Escaped := false;
      while BracesOpened > 0 do
      begin
        Inc(NChar);
        case Source[NChar] of
          '{': if Escaped then
              Escaped := false
            else
              Inc(BracesOpened);
          '}': if Escaped then
              Escaped := false
            else
              Dec(BracesOpened);
          '\': Escaped := not Escaped;
        else
          Escaped := false;
        end;
      end;
    end;

  var
    Control, NumericValue, TextValue: string;
  begin
    Result := '';
    Inc(NChar);
    while NChar <= Length(Source) do
      case Source[NChar] of
        '{': Result := Result + ProcessGroupRecursevly;
        '}':
          begin
            Inc(NChar);
            Break;
          end;
        '\':
          begin
            Inc(NChar);
            case Source[NChar] of
              '''':
                begin
                  Result := Result + Chr(HexToInt(Copy(Source, NChar + 1, 2)));
                  Inc(NChar, 3);
                end;
              '~': Result := Result + #$20;
              '*': SkipStar;
              'a'..'z':
                begin
                  Control := '';
                  while Source[NChar] in ['a'..'z'] do
                  begin
                    Control := Control + Source[NChar];
                    Inc(NChar);
                  end;
                  if Source[NChar] = '-' then
                  begin
                    NumericValue := Source[NChar];
                    Inc(NChar);
                  end
                  else
                    NumericValue := '';
                  while Source[NChar] in ['0'..'9'] do
                  begin
                    NumericValue := NumericValue + Source[NChar];
                    Inc(NChar);
                  end;
                  if Source[NChar] = '{' then
                    ProcessGroupRecursevly;
                  TextValue := '';
                  if not (Source[NChar] in ['a'..'z', '{', '}', '\']) then
                  begin
                    Inc(NChar);
                    while not (Source[NChar] in ['{', '}', '\']) do
                    begin
                      TextValue := TextValue + Source[NChar];
                      Inc(NChar);
                    end;
                  end;
                  if (Control = 'line') or (Control = 'par') then
                    Result := Result + #$0D#$0A
                  else if Control = 'tab' then
                    Result := Result + #$09
                  else if Control = 'u' then
                    Result := Result + UnicodeCharCode2ANSIString(StrToInt(NumericValue))
                  else if Control = 'colortbl' then
                    TextValue := '';
                  if Length(TextValue) > 0 then
                    if (not ((TextValue[Length(TextValue)] = ';') and (Source[NChar] = '}'))) then
                    begin
                      Result := Result + TextValue;
                      TextValue := '';
                    end;
                end;
            else
              begin
                Result := Result + Source[NChar];
                Inc(NChar);
              end;
            end;
          end;
      else
        begin
          Result := Result + Source[NChar];
          Inc(NChar);
        end;
      end;
  end;

  function InitSource: Boolean;
  var
    BracesCount: Integer;
    Escaped: Boolean;
  begin
    if Copy(aSource, 1, 5) <> '{\rtf' then
      InitSource := false
    else
    begin
      Source := '';
      BracesCount := 0;
      Escaped := false;
      NChar := 1;
      while (NChar <= Length(aSource)) and (BracesCount >= 0) do
      begin
        if not (aSource[NChar] in [#$0D, #$0A]) then
        begin
          Source := Source + aSource[NChar];
          case aSource[NChar] of
            '{': if not Escaped then
                Inc(BracesCount)
              else
                Escaped := false;
            '}': if not Escaped then
                Dec(BracesCount)
              else
                Escaped := false;
            '\': Escaped := true;
          else
            Escaped := false;
          end;
        end;
        Inc(NChar);
      end;
      InitSource := BracesCount = 0;
    end;
  end;

begin
  if InitSource then
  begin
    NChar := 1;
    Result := ProcessGroupRecursevly;
  end
  else
    Result := aSource;
end;

function StrToUTF8(Value: string): string;
var
  buffer: Pointer;
  BufLen: LongWord;
  lpBuf: Pointer;
begin
  BufLen := Length(Value) * 2 + 4;
  GetMem(buffer, BufLen);
  FillChar(buffer^, BufLen, 0);
  GetMem(lpBuf, BufLen);
  FillChar(lpBuf^, BufLen, 0);
  StringToWideChar(Value, buffer, BufLen);
  WideCharToMultiByte(CP_UTF8, 0, buffer, -1, lpBuf, BufLen, nil, nil);
  FreeMem(buffer, BufLen);
  Result := PChar(lpBuf);
  FreeMem(lpBuf, BufLen);
end;

function BMSearch(StartPos: Integer; const S, P: string): Integer;
type
  TBMTable = array[0..255] of Integer;
var
  Pos, lp, i: Integer;
  BMT: TBMTable;
begin
  Result := -1;
  if (S = EmptyStr) or (P = EmptyStr) then Exit;
  for i := 0 to 255 do
    BMT[i] := Length(P);
  for i := Length(P) downto 1 do
    if BMT[Byte(P[i])] = Length(P) then
      BMT[Byte(P[i])] := Length(P) - i;
  lp := Length(P);
  Pos := StartPos + lp - 1;
  while Pos <= Length(S) do
    if P[lp] <> S[Pos] then
      Pos := Pos + BMT[Byte(S[Pos])]
    else if lp = 1 then
    begin
      Result := Pos;
      Exit;
    end
    else
      for i := lp - 1 downto 1 do
        if P[i] <> S[Pos - lp + i] then
        begin
          Inc(Pos);
          Break;
        end
        else if i = 1 then
        begin
          Result := Pos - lp + 1;
          Exit;
        end;
  Result := -1;
end;

function TailLineTail(aHistory: string; aLinesCount: Integer): string;
var
  list: TStringList;
  i, f: integer;
begin
  //--Создаём стринглист для разбивки строк в истории
  list := TStringList.Create;
  try
    //--Заносим историю в лист
    list.Text := aHistory;
    //--Определяем макс количество строк в истории
    if aLinesCount > list.Count then f := list.Count
    else f := aLinesCount;
    //--Вычисляем обратный отсчёт
    f := list.Count - f;
    //--Запускаем цикл граббинда посдежних сообщений из истории
    for i := (list.Count - 1) downto f do Result := Result + list.Strings[i] + #13#10;
    //--Заносим результат снова в список
    list.Text := Result;
    //--Обнуляем результат
    Result := '';
    //--Переворачиваем строки в списке
    for i := (list.Count - 1) downto 0 do Result := Result + list.Strings[i] + #13#10;
  finally
    list.Free;
  end;
end;

function DecodeStr(msg: string): string;
const
  D0Set: set of char = [#$90..#$BF, #$81];
  D1Set: set of char = [#$80..#$8F, #$91];
var
  i: Integer;
begin
  i := 1;
  while i < length(MSG) do begin
    if msg[i] = #0
      then delete(msg, i, 1)
    else
      if msg[i] = #$04
        then begin
        if msg[i + 1] = #$01
          then msg[i + 1] := 'Ё'
        else
          if msg[i + 1] = #$51
            then msg[i + 1] := 'ё'
          else msg[i + 1] := chr(ord(msg[i + 1]) + $B0);
        delete(msg, i, 1);
      end
      else
        if (msg[i] = #$D0) and (msg[i + 1] in D0Set)
          then begin
          if msg[i + 1] = #$81
            then msg[i + 1] := 'Ё'
          else msg[i + 1] := chr(ord(msg[i + 1]) + $30);
          delete(msg, i, 1);
        end
        else
          if (msg[i] = #$D1) and (msg[i + 1] in D1Set)
            then begin
            if msg[i + 1] = #$91
              then msg[i + 1] := 'ё'
            else msg[i + 1] := chr(ord(msg[i + 1]) + $70);
            delete(msg, i, 1);
          end;
    inc(i);
  end;
  Result := msg;
end;

function GetTimeZone: integer;
var
  TimeZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TimeZone);
  Result := TimeZone.Bias div -60;
end;

function UnixToDateTime(const AValue: Int64): TDateTime;
const
  UnixDateDelta = 25569;
begin
  //--Вычисляем время из юникс представления времени
  Result := ((AValue / SecsPerDay) + UnixDateDelta) + GetTimeZone * Hour;
  //--Почему то + 1 час нужно добавить для точности
  Result := Result + Hour;
end;

function NumToIp(Addr: LongWord): string;
var
  inaddr: in_addr;
begin
  inaddr.S_addr := Addr;
  Result := inet_ntoa(inaddr);
end;

{function Dump(data: string): string;
const
  cols = 16;
var
  ofs, i: integer;
  s1, s2: string;
begin
  result := '';
  ofs := 0;
  while ofs < length(data) do
  begin
    s1 := '';
    s2 := '';
    for i := 1 to cols do
      if ofs + i <= length(data) then
      begin
        s1 := s1 + intToHex(ord(data[ofs + i]), 2);
        if i = 8 then s1 := s1 + '  '
        else s1 := s1 + ' ';
        if data[ofs + i] < #32 then s2 := s2 + '.'
        else s2 := s2 + data[ofs + i];
      end;
    s1 := s1 + stringOfChar(' ', cols * 3 + 4 - length(s1));
    result := result + s1 + s2 + #13#10;
    inc(ofs, cols);
  end;
end;}

function ICQ_BodySize1: integer;
var
  Header: string;
begin
  Header := ICQ_HexPkt[9] + ICQ_HexPkt[10] + ICQ_HexPkt[11] + ICQ_HexPkt[12];
  Result := HexToInt(Header) * 2;
end;

function ICQ_BodySize2: integer;
var
  Header: string;
begin
  Header := ICQ_RegUIN_HexPkt[9] + ICQ_RegUIN_HexPkt[10] + ICQ_RegUIN_HexPkt[11] + ICQ_RegUIN_HexPkt[12];
  Result := HexToInt(Header) * 2;
end;

function ICQ_BodySize3: integer;
var
  Header: string;
begin
  Header := ICQ_Avatar_HexPkt[9] + ICQ_Avatar_HexPkt[10] + ICQ_Avatar_HexPkt[11] + ICQ_Avatar_HexPkt[12];
  Result := HexToInt(Header) * 2;
end;

function SendFLAP(Channel, Data: string): boolean;
var
  Str: string;
  Len: integer;
begin
  Result := false;
  Len := Length(Hex2Text(Data));
  if MainForm.ICQWSocket.State <> wsConnected then Exit;
  Str := Hex2Text('2a0' + Channel + IntToHex(ICQ_Seq1, 4) + IntToHex(Len, 4) + Data);
  try
    while abs(now - ICQ_LastSendedFlap1) < DT2100miliseconds do
    begin
      //--делаем нано паузу :)
    end;
    MainForm.ICQWSocket.SendStr(Str);
    ICQ_LastSendedFlap1 := now;
    Inc(ICQ_Seq1);
  except
    //
  end;
  Result := true;
end;

function SendFLAP_Avatar(Channel, Data: string): boolean;
var
  Str: string;
  Len: integer;
begin
  Result := false;
  Len := Length(Hex2Text(Data));
  if MainForm.ICQAvatarWSocket.State <> wsConnected then Exit;
  Str := Hex2Text('2a0' + Channel + IntToHex(ICQ_Seq2, 4) + IntToHex(Len, 4) + Data);
  try
    while abs(now - ICQ_LastSendedFlap2) < DT2100miliseconds do
    begin
      //--делаем нано паузу :)
    end;
    MainForm.ICQAvatarWSocket.SendStr(Str);
    ICQ_LastSendedFlap2 := now;
    Inc(ICQ_Seq2);
  except
    //
  end;
  Result := true;
end;

function DateTimeChatMess: string;
begin
  //YYYYMMDDHHNNSS
  Result := FormatDateTime('HH:NN:SS', Time) + ' ' + FormatDateTime('DD.MM.YYYY', Date);
end;

{$HINTS OFF}

function AppendOrWriteTextToFile(FileName: TFilename; WriteText: string): boolean;
var
  f: Textfile;
begin
  Result := False;
  AssignFile(f, FileName);
  try
    if FileExists(FileName) = False then
      Rewrite(f)
    else
    begin
      Append(f);
    end;
    Writeln(f, WriteText);
    Result := True;
  finally
    CloseFile(f);
  end;
end;

{$HINTS ON}

function exNormalizeIcqNumber(SN: string): string;

  function DeleteDashes(const Value: string): string;
  var
    Counter, i: integer;
  begin
    Counter := 0;
    SetLength(Result, Length(Value));
    for i := 1 to Length(Value) do
      if Value[i] <> '-' then
      begin
        Inc(Counter);
        Result[Counter] := Value[i];
      end;
    SetLength(Result, Counter);
  end;

begin
  Result := DeleteDashes(SN);
end;

function exNormalizeScreenName(SN: string): string;

  function DeleteSpaces(const Value: string): string;
  var
    Counter, i: integer;
  begin
    Counter := 0;
    SetLength(Result, Length(Value));
    for i := 1 to Length(Value) do
      if Value[i] <> ' ' then
      begin
        Inc(Counter);
        Result[Counter] := Value[i];
      end;
    SetLength(Result, Counter);
  end;

begin
  Result := AnsiLowerCase(DeleteSpaces(SN));
end;

function DeleteSpaces(const Value: string): string;
var
  Counter, i: integer;
begin
  Counter := 0;
  SetLength(Result, Length(Value));
  for i := 1 to Length(Value) do
    if Value[i] <> ' ' then
    begin
      Inc(Counter);
      Result[Counter] := Value[i];
    end;
  SetLength(Result, Counter);
end;

function NormalizeCellularNumber(const Value: string): string;
var
  Counter, i: integer;
begin
  Counter := 0;
  SetLength(Result, Length(Value));
  for i := 1 to Length(Value) do
    if (Value[i] <> ' ') and (Value[i] <> '-') and (Value[i] <> '(')
      and (Value[i] <> ')') and (Value[i] <> 'S') and (Value[i] <> 'M') then
    begin
      Inc(Counter);
      Result[Counter] := Value[i];
    end;
  SetLength(Result, Counter);
end;

function DeleteLineBreaks(const S: string): string;
var
  Source, SourceEnd: PChar;
begin
  Source := Pointer(S);
  SourceEnd := Source + Length(S);
  while Source < SourceEnd do
  begin
    case Source^ of
      #10: Source^ := #32;
      #13: Source^ := #32;
    end;
    Inc(Source);
  end;
  Result := S;
end;

function HexToInt(Value: string): LongWord;
const
  HexStr: string = '0123456789ABCDEF';
var
  i: Word;
begin
  Result := 0;
  if Value = '' then Exit;
  for i := 1 to Length(Value) do
    Inc(Result, (Pos(Value[i], HexStr) - 1) shl ((Length(Value) - i) shl 2));
end;

function HexToChar(S: string): char;
var
  c: char;
begin
  c := char(StrToInt('$' + S));
  Result := c;
end;

function Hex2Text(hextext: string): string;
var
  i, x: integer;
  temp, msgtext: string;
begin
  for i := 1 to (length(hextext) div 2) do
  begin
    x := i * 2;
    temp := hextext[x - 1] + hextext[x];
    msgtext := msgtext + HextoChar(temp);
  end;
  result := msgtext;
end;

function Text2Hex(msg: string): string;
var
  msgline: string;
  i: integer;
begin
  for i := 1 to length(msg) do
  begin
    msgline := msgline + inttohex(ord(msg[i]), 2);
  end;
  Result := msgline;
end;

function RightStr(const Str: string; Size: Word): string;
var
  len: integer;
begin
  len := Length(Str);
  if Size > len then Size := len;
  Result := Copy(Str, len - Size + 1, Size);
end;

function LeftStr(const Str: string; Size: Word): string;
begin
  Result := Copy(Str, 1, Size);
end;

function NextData(var Data: string; Count: integer): string;
var
  blok: string;
begin
  if Count <= 0 then
  begin
    Result := '';
    Exit;
  end;
  if Count > Length(Data) then
  begin
    Result := Data;
    SetLength(Data, 0);
    Exit;
  end;
  blok := LeftStr(Data, Count);
  Data := RightStr(Data, Length(Data) - Count);
  Result := blok;
end;

function Swap16(Value: Word): Word; assembler;
asm
  rol   ax,8
end;

function Swap32(Value: LongWord): LongWord; assembler;
asm
  bswap eax
end;

function MD5PointerToHex(Buffer: Pointer): string;
var
  hash: string;
  i: Word;
begin
  for i := 0 to 15 do
  begin
    hash := hash + IntToHex(PByte(LongWord(Buffer) + i)^, 2);
  end;
  Result := hash;
end;

{$WARNINGS OFF}

procedure GetTreeDirs(Root: string; out OutString: TStringList);
var
  sResult: TSearchRec;
begin
  OutString := TStringList.Create();
  if not DirectoryExists(Root) then exit;
  Root := IncludeTrailingBackslash(Root);
  SetCurrentDir(Root);
  if FindFirst('*', faAnyFile, sResult) = 0 then
  begin
    repeat
      if (sResult.Name <> '.') and (sResult.Name <> '..') and
        ((sResult.attr and faDirectory) = faDirectory) then
        OutString.Add(sResult.Name);
    until FindNext(sResult) <> 0;
    FindClose(sResult);
  end;
end;

{$WARNINGS ON}

function InitMixer: HMixer;
var
  Err: MMRESULT;
begin
  Err := mixerOpen(@Result, 0, 0, 0, 0);
  if Err <> MMSYSERR_NOERROR then Result := 0;
end;

function Parse(Char, S: string; Count: Integer): string;
var
  I: Integer;
  T: string;
begin
  if S = '' then exit;
  if S[Length(S)] <> Char then
    S := S + Char;
  for I := 1 to Count do
  begin
    T := Copy(S, 0, Pos(Char, S) - 1);
    S := Copy(S, Pos(Char, S) + 1, Length(S));
  end;
  Result := T;
end;

procedure ListFileDirHist(Path, Ext, Eext: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if FindFirst(Path + '\' + Ext, faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        FileList.Add(Parse(Eext, SR.Name, 1));
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure Popup(Compon: TComponent; pm: TPopupMenu);
var
  xPoint: TPoint;
begin
  GetParentForm(TWinControl(Compon)).SendCancelMode(nil);
  pm.PopupComponent := TWinControl(Compon);
  xPoint := Point(TWinControl(Compon).Width, TWinControl(Compon).Top);
  with TWinControl(Compon).ClientToScreen(xPoint) do pm.Popup(x, y);
end;

procedure Popup_down(Compon: TComponent; pm: TPopupMenu);
var
  xPoint: TPoint;
begin
  GetParentForm(TWinControl(Compon)).SendCancelMode(nil);
  pm.PopupComponent := TWinControl(Compon);
  xPoint := Point(TWinControl(Compon).Width, TWinControl(Compon).Top);
  with TWinControl(Compon).ClientToScreen(xPoint) do pm.Popup(x - 14, y + 22);
end;

function InitBuildInfo: string;
var
  S, TS: string;
  h, sz, Len: DWORD;
  Buf: PChar;
  Value: Pointer;
begin
  Result := '';
  //
  S := Application.ExeName;
  sz := GetFileVersionInfoSize(PChar(S), h);
  if sz > 0 then
  begin
    try
      Buf := AllocMem(sz);
      GetFileVersionInfo(PChar(S), h, sz, Buf);
      VerQueryValue(Buf, '\VarFileInfo\Translation', Value, Len);
      TS := IntToHex(MakeLong(HiWord(Longint(Value^)), LoWord(Longint(Value^))), 8);
      //--Получаем номер билда
      VerQueryValue(Buf, PChar('StringFileInfo\' + TS + '\FileVersion'), Pointer(Value), Len);
      if Len > 1 then Result := StrPas(PChar(Value));
    except
    end;
  end;
end;

procedure Zip_File(FileName: TStrings; SFileName: string);
var
  z: TJvZlibMultiple;
begin
  //--Запаковывавем файл в указанную директорию
  z := TJvZlibMultiple.Create(nil);
  try
    z.CompressionLevel := 9;
    TMemoryStream(z.CompressFiles(FileName)).SaveToFile(SFileName);
  finally
    z.Free;
  end;
end;

procedure UnZip_File(FileName, SDir: string);
var
  z: TJvZlibMultiple;
begin
  //--Распаковываем файл в указанную директорию
  z := TJvZlibMultiple.Create(nil);
  try
    z.DecompressFile(FileName, SDir, true);
  finally
    z.Free;
  end;
end;

procedure UnZip_Stream(FileName: TStream; SDir: string);
var
  z: TJvZlibMultiple;
begin
  //--Распаковываем файл в указанную директорию
  z := TJvZlibMultiple.Create(nil);
  try
    z.DecompressStream(FileName, SDir, true);
  finally
    z.Free;
  end;
end;

{$WARNINGS OFF}

function PacketToHex(Buffer: Pointer; BufLen: Word): string;
var
  S: string;
  i: Integer;
begin
  for i := 1 to BufLen do
  begin
    S := S + IntToHex(PByte(LongWord(Buffer) + i - 1)^, 2);
  end;
  Result := S;
end;

{$WARNINGS ON}

function GetRandomHexBytes(BytesCount: Integer): string;
const
  Bit16 = '0123456789abcdef';
var
  I: Integer;
begin
  Result := '';
  for I := 0 to BytesCount do
  begin
    Result := Result + Bit16[Random(15) + 1];
  end;
end;

function ErrorHttpClient(ErrCode: integer): string;
begin
  case ErrCode of
    0: Result := SocketConnErrorInfo_1;
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
  else Result := SocketConnErrorInfo_1;
  end;
  Result := Result + #13#10 + Format(HttpSocketErrCodeL, [ErrCode]);
end;

function Min(const A, B: Integer): Integer;
begin
  if A < B then Result := A
  else Result := B;
end;

//--Thanks Exodus Project

function GetFullTag(AData: string): string;

  function RPos(find_data, in_data: string): cardinal;
  var
    lastpos, newpos: cardinal;
    mybuff: string;
    origlen: cardinal;
  begin
    lastpos := 0;
    newpos := 0;
    origlen := Length(AData);
    repeat
      mybuff := Copy(in_data, lastpos + 1, origlen - newpos);
      newpos := pos(find_data, mybuff);
      if (newpos > 0) then
      begin
        lastpos := lastpos + newpos;
      end;
    until (newpos <= 0);
    Result := lastpos;
  end;

var
  FRoot, sbuff, r, stag, etag, tmps: string;
  p, ls, le, e, l, ps, pe, ws, sp, tb, cr, nl, i: longint;
  _counter: integer;

begin
  FRoot := '';
  Result := '';
  _counter := 0;
  sbuff := AData;
  l := Length(sbuff);
  if (Trim(sbuff)) = '' then exit;
  p := Pos('<', sbuff);
  if p <= 0 then
  begin
    DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
    Exit;
  end;
  tmps := Copy(sbuff, p, l - p + 1);
  e := Pos('>', tmps);
  i := Pos('/>', tmps);
  if ((e = 0) and (i = 0)) then exit;
  if FRoot = '' then
  begin
    sp := Pos(' ', tmps);
    tb := Pos(#09, tmps);
    cr := Pos(#10, tmps);
    nl := Pos(#13, tmps);
    ws := sp;
    if (tb > 0) then ws := Min(ws, tb);
    if (cr > 0) then ws := Min(ws, cr);
    if (nl > 0) then ws := Min(ws, nl);
    if ((i > 0) and (i < ws)) then
      FRoot := Trim(Copy(sbuff, p + 1, i - 2))
    else if (e < ws) then
      FRoot := Trim(Copy(sbuff, p + 1, e - 2))
    else
      FRoot := Trim(Copy(sbuff, p + 1, ws - 2));
    if (FRoot = '?xml') or
      (FRoot = '!ENTITY') or
      (FRoot = '!--') or
      (FRoot = '!ATTLIST') or
      (FRoot = FRootTag) then
    begin
      r := Copy(sbuff, p, e);
      FRoot := '';
      Jabber_BuffPkt := Copy(sbuff, p + e, l - e - p + 1);
      Result := r;
      exit;
    end;
  end;
  if (e = (i + 1)) then
  begin
    r := Copy(sbuff, p, e);
    FRoot := '';
    Jabber_BuffPkt := Copy(sbuff, p + e, l - e - p + 1);
  end
  else
  begin
    i := p;
    stag := '<' + FRoot;
    etag := '</' + FRoot + '>';
    ls := length(stag);
    le := length(etag);
    r := '';
    repeat
      tmps := Copy(sbuff, i, l - i + 1);
      ps := Pos(stag, tmps);
      if (ps > 0) then
      begin
        _counter := _counter + 1;
        i := i + ps + ls - 1;
      end;
      tmps := Copy(sbuff, i, l - i + 1);
      pe := RPos(etag, tmps);
      if ((pe > 0) and ((ps > 0) and (pe > ps))) then
      begin
        _counter := _counter - 1;
        i := i + pe + le - 1;
        if (_counter <= 0) then
        begin
          r := Copy(sbuff, p, i - p);
          FRoot := '';
          Jabber_BuffPkt := Copy(sbuff, i, l - i + 1);
          break;
        end;
      end;
    until ((pe <= 0) or (ps <= 0) or (tmps = ''));
  end;
  result := r;
end;

procedure ImPlaySnd(Snd: integer);
begin
  //--Играем звуки imadering
  {
    0 - Старт программы
    1 - Входящее сообщение
  }
  try
    if SoundON then
    begin
      case Snd of
        0: if (SoundStartProg) and (FileExists(SoundStartProgPath)) then sndPlaySound(PChar(SoundStartProgPath), SND_ASYNC);
        1: if (SoundIncMsg) and (FileExists(SoundIncMsgPath)) then sndPlaySound(PChar(SoundIncMsgPath), SND_ASYNC);
      end;
    end;
  except
  end;
end;

function SearchNickInCash(cType, cId: string): string;
var
  i: integer;
begin
  Result := cId;
  try
    //--Проверяем создан ли список ников
    if Assigned(AccountToNick) then
    begin
      //--Находим ники в списке ников по учётной записи
      for i := 0 to AccountToNick.Count - 1 do
      begin
        if (cType + '_' + cId) = AccountToNick.Strings[i] then
        begin
          Result := AccountToNick.Strings[i + 1];
          //--Выходим из цикла
          Break;
        end;
      end;
    end;
  except
  end;
end;

function CopyDir(const FromDir, ToDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do begin
    wFunc := FO_COPY;
    fFlags := FOF_FILESONLY;
    pFrom := PChar(fromDir + #0);
    pTo := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;

function NormalDir(const DirName: string): string;
begin
  Result := DirName;
  if (Result <> '') and
    not (AnsiLastChar(Result)^ in [':', '\']) then
  begin
    if (Length(Result) = 1) and (UpCase(Result[1]) in ['A'..'Z']) then
      Result := Result + ':\'
    else Result := Result + '\';
  end;
end;

{$WARNINGS OFF}

function ClearDir(const Path: string; Delete: Boolean): Boolean;
const
  FileNotFound = 18;
var
  FileInfo: TSearchRec;
  DosCode: Integer;
begin
  Result := DirectoryExists(Path);
  if not Result then Exit;
  DosCode := FindFirst(NormalDir(Path) + '*.*', faAnyFile, FileInfo);
  try
    while DosCode = 0 do
    begin
      if (FileInfo.Name[1] <> '.') then
      begin
        if (FileInfo.Attr and faDirectory = faDirectory) then
          Result := ClearDir(NormalDir(Path) + FileInfo.Name, Delete) and Result
        else
        begin
          if (FileInfo.Attr and faReadOnly = faReadOnly) then
            FileSetAttr(NormalDir(Path) + FileInfo.Name, faArchive);
          Result := DeleteFile(NormalDir(Path) + FileInfo.Name) and Result;
        end;
      end;
      DosCode := FindNext(FileInfo);
    end;
  finally
    FindClose(FileInfo);
  end;
  if Delete and Result and (DosCode = FileNotFound) and
    not ((Length(Path) = 2) and (Path[2] = ':')) then
  begin
    RmDir(Path);
    Result := (IOResult = 0) and Result;
  end;
end;

{$WARNINGS ON}

procedure SetCustomWidthComboBox(CB: TComboBox);
var
  i, ItemWidth, CWidth: integer;
begin
  //--Выравниваем ширину списка по самой длинной строке
  ItemWidth := 0;
  with CB do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
      if CWidth > ItemWidth then ItemWidth := CWidth;
    end;
    if Items.Count > DropDownCount then Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0)
    else Perform(CB_SETDROPPEDWIDTH, ItemWidth + 8, 0);
  end;
end;

end.

