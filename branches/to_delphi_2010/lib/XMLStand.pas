// Изменения для проекта IMadering

unit XMLStand;

interface

uses
  SysUtils;

type
  TCharSet = TSysCharSet;

function WordCount(const S: string; const WordDelims: TCharSet): Integer;

function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet): string;

const
  DateSeparatorFix: Char = '.';
  TimeSeparatorFix: Char = ':';
  ShortDateFormatFix = 'dd.mm.yyyy';
  ShortTimeFormatFix = 'hh:nn:ss';

function IIF(Switch: Boolean; Var1, Var2: Variant): Variant;

{$IFDEF POLARIS_D4} overload;
function IIF(Switch: Boolean; Var1, Var2: string): string; overload;

{$ENDIF}

function StrToDateFix(const S: string): TDateTime;
function StrToTimeFix(const S: string): TDateTime;
function StrToDateTimeFix(const S: string): TDateTime;
function DateToStrFix(Date: TDateTime): string;
function TimeToStrFix(Time: TDateTime): string;
function DateTimeToStrFix(DateTime: TDateTime): string;

implementation

function WordPosition(const N: Integer; const S: string; const WordDelims: TCharSet): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do
  begin
    { skip over delimiters }
    while (I <= Length(S)) and (CharInSet(S[I], WordDelims)) do
      Inc(I);
    { if we're not beyond end of S, we're at the start of a word }
    if I <= Length(S) then
      Inc(Count);
    { if not finished, find the end of the current word }
    if Count <> N then
      while (I <= Length(S)) and not(CharInSet(S[I], WordDelims)) do
        Inc(I)
      else
        Result := I;
  end;
end;

function WordCount(const S: string; const WordDelims: TCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do
  begin
    while (I <= SLen) and (CharInSet(S[I], WordDelims)) do
      Inc(I);
    if I <= SLen then
      Inc(Result);
    while (I <= SLen) and not(CharInSet(S[I], WordDelims)) do
      Inc(I);
  end;
end;

function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet): string;
var
  I: Integer;
  Len: Integer;
begin
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  if I <> 0 then
    { find the end of the current word }
    while (I <= Length(S)) and not(CharInSet(S[I], WordDelims)) do
    begin
      { add the I'th character to result }
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

function IIF(Switch: Boolean; Var1, Var2: Variant): Variant;

{$IFDEF POLARIS_D4} overload; {$ENDIF}

begin
  if Switch then
    Result := Var1
  else
    Result := Var2;
end;

{$IFDEF POLARIS_D4}

function IIF(Switch: Boolean; Var1, Var2: string): string; overload;
begin
  if Switch then
    Result := Var1
  else
    Result := Var2;
end;

{$ENDIF}

function StrToDateFix(const S: string): TDateTime;
var
  oldSep1: Char;
  oldFormat1: string;
begin
  oldSep1 := DateSeparator;
  oldFormat1 := ShortDateFormat;
  DateSeparator := DateSeparatorFix;
  ShortDateFormat := ShortDateFormatFix;
  try
    Result := StrToDate(S);
  finally
    DateSeparator := oldSep1;
    ShortDateFormat := oldFormat1;
  end;
end;

function StrToTimeFix(const S: string): TDateTime;
var
  oldSep1: Char;
  oldFormat1: string;
begin
  oldSep1 := TimeSeparator;
  oldFormat1 := ShortTimeFormat;
  TimeSeparator := TimeSeparatorFix;
  ShortTimeFormat := ShortTimeFormatFix;
  try
    Result := StrToTime(S);
  finally
    TimeSeparator := oldSep1;
    ShortTimeFormat := oldFormat1;
  end;
end;

function StrToDateTimeFix(const S: string): TDateTime;
var
  oldSep1, oldSep2: Char;
  oldFormat1, oldFormat2: string;
begin
  oldSep1 := DateSeparator;
  oldFormat1 := ShortDateFormat;
  oldSep2 := TimeSeparator;
  oldFormat2 := ShortTimeFormat;
  DateSeparator := DateSeparatorFix;
  ShortDateFormat := ShortDateFormatFix;
  TimeSeparator := TimeSeparatorFix;
  ShortTimeFormat := ShortTimeFormatFix;
  try
    Result := StrToDateTime(S);
  finally
    DateSeparator := oldSep1;
    ShortDateFormat := oldFormat1;
    TimeSeparator := oldSep2;
    ShortTimeFormat := oldFormat2;
  end;
end;

function DateToStrFix(Date: TDateTime): string;
var
  oldSep1: Char;
  oldFormat1: string;
begin
  oldSep1 := DateSeparator;
  oldFormat1 := ShortDateFormat;
  DateSeparator := DateSeparatorFix;
  ShortDateFormat := ShortDateFormatFix;
  try
    Result := DateToStr(Date);
  finally
    DateSeparator := oldSep1;
    ShortDateFormat := oldFormat1;
  end;
end;

function TimeToStrFix(Time: TDateTime): string;
var
  oldSep1: Char;
  oldFormat1: string;
begin
  oldSep1 := TimeSeparator;
  oldFormat1 := ShortTimeFormat;
  TimeSeparator := TimeSeparatorFix;
  ShortTimeFormat := ShortTimeFormatFix;
  try
    Result := TimeToStr(Time);
  finally
    TimeSeparator := oldSep1;
    ShortTimeFormat := oldFormat1;
  end;
end;

function DateTimeToStrFix(DateTime: TDateTime): string;
var
  oldSep1, oldSep2: Char;
  oldFormat1, oldFormat2: string;
begin
  oldSep1 := DateSeparator;
  oldFormat1 := ShortDateFormat;
  oldSep2 := TimeSeparator;
  oldFormat2 := ShortTimeFormat;
  DateSeparator := DateSeparatorFix;
  ShortDateFormat := ShortDateFormatFix;
  TimeSeparator := TimeSeparatorFix;
  ShortTimeFormat := ShortTimeFormatFix;
  try
    Result := DateTimeToStr(DateTime);
  finally
    DateSeparator := oldSep1;
    ShortDateFormat := oldFormat1;
    TimeSeparator := oldSep2;
    ShortTimeFormat := oldFormat2;
  end;
end;

end.
