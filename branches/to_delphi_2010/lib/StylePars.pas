// Изменения для проекта IMadering

{ Version 9.46 }
{ ********************************************************* }
{ *                    STYLEPARS.PAS                      * }
{ ********************************************************* }
{
  Copyright (c) 1995-2008 by L. David Baldwin

  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  Note that the source modules, HTMLGIF1.PAS, PNGZLIB1.PAS, DITHERUNIT.PAS, and
  URLCON.PAS are covered by separate copyright notices located in those modules.
}

{$I htmlcons.inc}

unit StylePars;

interface

uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Controls,
  Dialogs,
  StdCtrls,
  StyleUn;

type
  CharFunction = function: Char;

procedure DoStyle(Styles: TStyleList; var C: Char; GC: CharFunction; const APath: string; FromLink: Boolean);
procedure ParsePropertyStr(const PropertyStr: string; var Propty: TProperties);
function SortContextualItems(S: string): string;

implementation

uses
  Graphics,
  ReadHTML,
  UrlSubs,
  Htmlun2;

const
  NeedPound = True;
  EofChar = #0;

type
  TProcessProc = procedure(Obj: TObject; Selectors: TStringList; Prop, Value: string);

var
  LCh, Back: Char;
  Get: CharFunction;
  LinkPath: string;

function GetC: Char;
begin
  if Back <> #0 then
    begin
      Result := Back;
      Back := #0;
    end
  else
    Result := Get;
  if Result = ^M then
    Result := ' ';
end;

procedure GetCh;
var
  Comment: Boolean;
  NextCh, LastCh: Char;
begin
  repeat { in case a comment immediately follows another comment }
    Comment := False;
    LCh := GetC;
    if LCh = '/' then
      begin
        NextCh := GetC;
        if NextCh = '*' then
          repeat
            Comment := True;
            LastCh := LCh;
            LCh := GetC;
          until ((LCh = '/') and (LastCh = '*')) or (LCh = EofChar) or (LCh = '<') else Back := NextCh; { put character back }
        end;
        until not Comment;
      end;

    { -------------SkipWhiteSpace }
    procedure SkipWhiteSpace;
    begin
      while CharInSet(LCh, [' ']) do
        GetCh;
    end;

    { ----------------RemoveQuotes }
    function RemoveQuotes(const S: string): string;
    { if string is a quoted string, remove the quotes (either ' or ") }
    begin
      if (Length(S) >= 2) and (CharInSet(S[1], ['''', '"'])) and (S[Length(S)] = S[1]) then
        Result := Copy(S, 2, Length(S) - 2)
      else
        Result := S;
    end;

    { ----------------AddPath }
    function AddPath(S: string): string;
    { for <link> styles, the path is relative to that of the stylesheet directory
      and must be added now }
    begin
      S := ReadUrl(S); { extract the info from url(....) }
      if (Pos('://', LinkPath) > 0) then { it's TFrameBrowser and URL }
        if not IsFullUrl(S) then
          Result := Combine(LinkPath, S)
        else
          ReSult := S
        else
          begin
            S := HTMLToDos(S);
            if (Pos(':', S) <> 2) and (Pos('\\', Result) <> 1) then
              Result := LinkPath + S
            else
              Result := S;
          end;
      Result := 'url(' + Result + ')';
    end;

    { ----------------ProcessProperty }
    procedure ProcessProperty(Styles: TObject; Selectors: TStringList; Prop, Value: string);
    var
      I: Integer;
    begin
      for I := 0 to Selectors.Count - 1 do (Styles as TStyleList)
        .AddModifyProp(Selectors[I], Prop, Value);
    end;

    { ---------  Detect Shorthand syntax }
    type
      ShortIndex = (MarginX, PaddingX, BorderWidthX, BorderX, BorderTX, BorderRX, BorderBX, BorderLX, FontX, BackgroundX, ListStyleX,
        BorderColorX, BorderStyleX);

    var
      ShortHands: array [ low(ShortIndex) .. high(ShortIndex)] of string = ('margin', 'padding', 'border-width', 'border', 'border-top',
        'border-right', 'border-bottom', 'border-left', 'font', 'background', 'list-style', 'border-color', 'border-style');

    function FindShortHand(S: string; var index: ShortIndex): Boolean;
    var
      I: ShortIndex;
    begin
      for I := low(ShortIndex) to high(ShortIndex) do
        if S = ShortHands[I] then
          begin
            Result := True;
            index := I;
            Exit;
          end;
      Result := False;
    end;

    procedure SplitString(Src: string; var Dest: array of string; var Count: Integer);
    { Split a Src string into pieces returned in the Dest string array.  Splitting
      is on spaces with spaces within quotes being ignored.  String containing a '/'
      are also split to allow for the "size/line-height" Font construct. }
    var
      I, Q, Q1, N: Integer;
      Z: string;
      Done: Boolean;
      Match: Char;
    begin
      Src := Trim(Src);
      I := Pos('  ', Src);
      while I > 0 do { simplify operation by removing extra white space }
        begin
          Delete(Src, I + 1, 1);
          I := Pos('  ', Src);
        end;
      I := Pos(', ', Src);
      while I > 0 do { simplify operation by removing spaces after commas }
        begin
          Delete(Src, I + 1, 1);
          I := Pos(', ', Src);
        end;

      N := 0;
      while (N <= high(Dest)) and (Src <> '') do
        begin
          Z := '';
          repeat
            Done := True;
            I := Pos(' ', Src);
            Q := Pos('"', Src);
            Q1 := Pos('''', Src);
            if (Q1 > 0) and ((Q > 0) and (Q1 < Q) or (Q = 0)) then
              begin
                Q := Q1;
                Match := ''''; { the matching quote char }
              end
            else
              Match := '"';
            if I = 0 then
              begin
                Z := Z + Src;
                Src := '';
              end
            else if (Q = 0) or (I < Q) then
              begin
                Z := Z + Copy(Src, 1, I - 1);
                Delete(Src, 1, I);
              end
            else { Q<I }  { quoted string found }
              begin
                Z := Z + Copy(Src, 1, Q); { copy to quote }
                Delete(Src, 1, Q);
                Q := Pos(Match, Src); { find next quote }
                if Q > 0 then
                  begin
                    Z := Z + Copy(Src, 1, Q); { copy to second quote }
                    Delete(Src, 1, Q);
                    Done := False; { go back and find the space }
                  end
                else { oops, missing second quote, copy remaining }
                  begin
                    Z := Z + Src;
                    Src := '';
                  end;
              end;
          until Done;
          I := Pos('/', Z); { look for splitter for Line-height }
          if I >= 2 then
            begin { this part is font size }
              Dest[N] := Copy(Z, 1, I - 1);
              Delete(Z, 1, I - 1);
              Inc(N);
            end;
          if N <= high(Dest) then
            Dest[N] := Z;
          Inc(N);
        end;
      Count := N;
    end;

    procedure ExtractParn(var Src: string; var Dest: array of string; var Count: Integer);
    { Look for strings in parenthesis like "url(....)" or rgb(...)".  Return these in
      Dest Array.  Return Src without the extracted string }
    var
      I, J: Integer;

    begin
      Count := 0;
      while (Count <= high(Dest)) and (Src <> '') do
        begin
          I := Pos('url(', Src);
          if I = 0 then
            I := Pos('rgb(', Src);
          if I = 0 then
            Exit;
          J := Pos(')', Src);
          if (J = 0) or (J < I) then
            Exit;
          Dest[Count] := Copy(Src, I, J - I + 1);
          Delete(Src, I, J - I + 1);
          Inc(Count);
        end;
    end;

{$IFNDEF ver120_plus}

    { Delphi 3 doesn't like this to be inside DoFont }
    type
      FontEnum = (Italic, Oblique, Normal, Bolder, Lighter, Bold, Smallcaps, Larger, Smaller, Xxsmall, Xsmall, Small, Medium, Large,
        Xlarge, Xxlarge);

    const
      FontWords: array [Italic .. Xxlarge] of string = ('italic', 'oblique', 'normal', 'bolder', 'lighter', 'bold', 'small-caps', 'larger',
        'smaller', 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large');

{$ENDIF}

    procedure DoFont(Styles: TObject; Selectors: TStringList; Prop, Value: string; Process: TProcessProc);
    { do the Font shorthand property specifier }

{$IFDEF ver120_plus}

    type
      FontEnum = (Italic, Oblique, Normal, Bolder, Lighter, Bold, Smallcaps, Larger, Smaller, Xxsmall, Xsmall, Small, Medium, Large,
        Xlarge, Xxlarge);
    const
      FontWords: array [Italic .. Xxlarge] of string = ('italic', 'oblique', 'normal', 'bolder', 'lighter', 'bold', 'small-caps', 'larger',
        'smaller', 'xx-small', 'x-small', 'small', 'medium', 'large', 'x-large', 'xx-large');

{$ENDIF}

    var
      S: array [0 .. 6] of string;
      Count, I: Integer;
      index: FontEnum;

    function FindWord(const S: string; var index: FontEnum): Boolean;
    var
      I: FontEnum;
    begin
      Result := False;
      for I := low(FontEnum) to high(FontEnum) do
        if FontWords[I] = S then
          begin
            Result := True;
            index := I;
            Exit;
          end;
    end;

    begin
      SplitString(Value, S, Count);
      for I := 0 to Count - 1 do
        begin
          if S[I, 1] = '/' then
            begin
              Process(Styles, Selectors, 'line-height', Copy(S[I], 2, Length(S[I]) - 1));
              Continue;
            end;
          if FindWord(S[I], index) then
            begin
              case index of
                Italic, Oblique: Process(Styles, Selectors, 'font-style', S[I]);
                Normal .. Bold: Process(Styles, Selectors, 'font-weight', S[I]);
                Smallcaps: Process(Styles, Selectors, 'font-variant', S[I]);
                Larger .. Xxlarge: Process(Styles, Selectors, 'font-size', S[I]);
              end;
              Continue;
            end;
          if CharInSet(S[I, 1], ['0' .. '9']) then
            begin
              { the following will pass 100pt, 100px, but not 100 or larger }
              if StrToIntDef(S[I], -1) < 100 then
                Process(Styles, Selectors, 'font-size', S[I]);
            end
          else
            Process(Styles, Selectors, 'font-family', S[I])
        end;
    end;

    procedure DoBackground(Styles: TObject; Selectors: TStringList; Prop, Value: string; Process: TProcessProc);
    { do the Background shorthand property specifier }
    var
      S: array [0 .. 6] of string;
      S1: string;
      Count, I, N: Integer;
      Dummy: TColor;

    begin
      ExtractParn(Value, S, Count);
      for I := 0 to Count - 1 do
        begin
          if Pos('rgb(', S[I]) > 0 then
            Process(Styles, Selectors, 'background-color', S[I])
          else if (Pos('url(', S[I]) > 0) then
            begin
              if LinkPath <> '' then { path added now only for <link...> }
                S[I] := AddPath(S[I]);
              Process(Styles, Selectors, 'background-image', S[I]);
            end;
        end;
      SplitString(Value, S, Count);
      for I := 0 to Count - 1 do
        if ColorFromString(S[I], NeedPound, Dummy) then
          begin
            Process(Styles, Selectors, 'background-color', S[I]);
            S[I] := '';
          end
        else if S[I] = 'none' then
          begin
            Process(Styles, Selectors, 'background-image', S[I]);
            Process(Styles, Selectors, 'background-color', 'transparent'); { 9.41 }
            S[I] := '';
          end;
      for I := 0 to Count - 1 do
        if Pos('repeat', S[I]) > 0 then
          begin
            Process(Styles, Selectors, 'background-repeat', S[I]);
            S[I] := '';
          end;
      for I := 0 to Count - 1 do
        if (S[I] = 'fixed') or (S[I] = 'scroll') then
          begin
            Process(Styles, Selectors, 'background-attachment', S[I]);
            S[I] := '';
          end;
      N := 0;
      S1 := ''; { any remaining are assumed to be position info }
      for I := Count - 1 downto 0 do
        if S[I] <> '' then
          begin
            S1 := S[I] + ' ' + S1;
            Inc(N);
            if N >= 2 then
              Break; { take only last two }
          end;
      if S1 <> '' then
        Process(Styles, Selectors, 'background-position', S1);
    end;

    procedure DoBorder(Styles: TObject; Selectors: TStringList; Prop, Value: string; Process: TProcessProc);
    { do the Border, Border-Top/Right/Bottom/Left shorthand properties.  However, there
      currently is only one style and color supported for all border sides }
    var
      S: array [0 .. 6] of string;
      Count, I: Integer;
      Dummy: TColor;

    function FindStyle(const S: string): Boolean;
    const
      Ar: array [1 .. 9] of string = ('none', 'solid', 'dashed', 'dotted', 'double', 'groove', 'inset', 'outset', 'ridge');
    var
      I: Integer;
    begin
      for I := 1 to 9 do
        if S = Ar[I] then
          begin
            Result := True;
            Exit;
          end;
      Result := False;
    end;

    begin
      ExtractParn(Value, S, Count);
      for I := 0 to Count - 1 do
        if ColorFromString(S[I], NeedPound, Dummy) then
          Process(Styles, Selectors, Prop + '-color', S[I]);

      SplitString(Value, S, Count);
      for I := 0 to Count - 1 do
        begin
          if ColorFromString(S[I], NeedPound, Dummy) then
            Process(Styles, Selectors, Prop + '-color', S[I])
          else if FindStyle(S[I]) then
            Process(Styles, Selectors, Prop + '-style', S[I]) { Border-Style will change all four sides }
          else if Prop = 'border' then
            begin
              Process(Styles, Selectors, 'border-top-width', S[I]);
              Process(Styles, Selectors, 'border-right-width', S[I]);
              Process(Styles, Selectors, 'border-bottom-width', S[I]);
              Process(Styles, Selectors, 'border-left-width', S[I]);
            end
          else
            Process(Styles, Selectors, Prop + '-width', S[I]);
        end;
    end;

    procedure DoListStyle(Styles: TObject; Selectors: TStringList; Prop, Value: string; Process: TProcessProc);
    { do the List-Style shorthand property specifier }
    var
      S: array [0 .. 6] of string;
      Count, I: Integer;

    begin
      SplitString(Value, S, Count);
      for I := 0 to Count - 1 do
        begin
          if Pos('url(', S[I]) > 0 then
            begin
              if LinkPath <> '' then { path added now only for <link...> }
                S[I] := AddPath(S[I]);
              Process(Styles, Selectors, 'list-style-image', S[I])
            end
          else
            Process(Styles, Selectors, 'list-style-type', S[I]);
          { should also do List-Style-Position }
        end;
    end;

    { ----------------DoMarginItems }
    procedure DoMarginItems(X: ShortIndex; Styles: TObject; Selectors: TStringList; Prop, Value: string; Process: TProcessProc);
    { Do the Margin, Border, Padding shorthand property specifiers }
    var
      S: array [0 .. 3] of string;
      I, Count: Integer;
      index: array [0 .. 3] of PropIndices;

    procedure DoIndex(Ix: PropIndices; const AValue: string);
    begin
      Process(Styles, Selectors, PropWords[Ix], AValue);
    end;

    begin
      if Value = '' then
        Exit;

      SplitString(Value, S, Count); { split Value into parts }

      case X of
        MarginX: index[0] := MarginTop;
        PaddingX: index[0] := PaddingTop;
        BorderWidthX: index[0] := BorderTopWidth;
        BorderColorX: index[0] := BorderTopColor;
        BorderStyleX: index[0] := BorderTopStyle;
      end;

      for I := 1 to 3 do
        index[I] := Succ(index[I - 1]);

      DoIndex(index[0], S[0]);
      case Count of
        1: for I := 1 to 3 do
            DoIndex(index[I], S[0]);
        2: begin
            DoIndex(index[2], S[0]);
            DoIndex(index[1], S[1]);
            DoIndex(index[3], S[1]);
          end;
        3: begin
            DoIndex(index[2], S[2]);
            DoIndex(index[1], S[1]);
            DoIndex(index[3], S[1]);
          end;
        4: begin
            DoIndex(index[1], S[1]);
            DoIndex(index[2], S[2]);
            DoIndex(index[3], S[3]);
          end;
      end;
    end;

    { ----------------SortContextualItems }
    function SortContextualItems(S: string): string;
    { Put a string of contextual items in a standard form for comparison purposes.
      div.ghi#def:hover.abc
      would become
      div.abc.ghi:hover#def
      Enter with S as lowercase
    }
    const
      Eos = #0;
    var
      Ch, C: Char;
      SS: string;
      SL: TStringList;
      Done: Boolean;
      I: Integer;

    procedure GetCh;
    begin
      if I <= Length(S) then
        Ch := S[I]
      else
        Ch := Eos;
      Inc(I);
    end;

    begin
      Result := '';
      SL := TStringList.Create; { TStringlist to do sorting }
      try
        SL.Sorted := True;
        Done := False;
        I := 1;
        GetCh;
        while not Done do
          begin
            if Ch = Eos then
              Done := True
            else
              begin
                case Ch of { add digit to sort item }
                  '.': C := '1';
                  ':': C := '2';
                  '#': C := '3';
                else C := '0';
                end;
                SS := C + Ch;
                GetCh;
                while CharInSet(Ch, ['a' .. 'z', '0' .. '9', '_', '-']) do
                  begin
                    SS := SS + Ch;
                    GetCh;
                  end;
                SL.Add(SS);
              end;
          end;
        for I := 0 to SL.Count - 1 do
          Result := Result + Copy(SL.Strings[I], 2, Length(SL.Strings[I]) - 1);
      finally
        SL.Free;
      end;
    end;

    { ----------------GetSelectors }
    procedure GetSelectors(Styles: TStyleList; Selectors: TStringList);
    { Get a series of selectors seperated by ',', like:  H1, H2, .foo }
    var
      S: string;
      Sort: Boolean;
      Cnt: Integer;

    function FormatContextualSelector(S: string; Sort: Boolean): string;
    { Takes a contextual selector and reverses the order.  Ex: 'div p em' will
      change to 'em Np div'.   N is a number added.  The first digit of N is
      the number of extra selector items.  The remainder of the number is a sequnce
      number which serves to sort entries by time parsed. }
    var
      I, Cnt: Integer;
      Tmp: string;

    function DoSort(St: string): string;
    begin
      if Sort then
        Result := SortContextualItems(St)
      else
        Result := St;
    end;

    begin
      Result := '';
      Cnt := 0;
      { make sure a space follows '>' and there are none preceding a '>' }
      I := 1;
      while I <= Length(S) do
        begin
          if S[I] = '>' then
            if (I = 1) or (I = Length(S)) then
              begin
                Delete(S, I, 1);
                Dec(I);
              end
            else
              begin
                if S[I + 1] <> ' ' then
                  Insert(' ', S, I + 1);
                while (I > 1) and (S[I - 1] = ' ') do
                  begin
                    Delete(S, I - 1, 1);
                    Dec(I);
                  end;
              end;
          Inc(I);
        end;

      I := Pos(' ', S);
      if (I > 0) and (Cnt <= 8) then
        begin
          while I > 0 do
            begin
              Inc(Cnt);
              Insert(DoSort(Copy(S, 1, I - 1)) + ' ', Result, 1);
              S := Trim(Copy(S, I + 1, Length(S)));
              I := Pos(' ', S);
            end;
          if S <> '' then
            Result := DoSort(S) + ' ' + Result;
          I := Pos(' ', Result);
          Str(Cnt, Tmp);
          Insert(Tmp + Styles.GetSeqNo, Result, I + 1);
        end
      else
        Result := DoSort(S);
    end;

    begin
      repeat
        if LCh = ',' then
          GetCh;
        SkipWhiteSpace;
        S := '';
        Sort := False;
        Cnt := 0;
        while CharInSet(LCh, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', ' ', '.', ':', '#', '-', '_', '*', '>']) do
          begin
            case LCh of
              '.', ':', '#': { 2 or more of these in an item will require a sort to put
                  in standard form }
                begin
                  Inc(Cnt);
                  if Cnt = 2 then
                    Sort := True;
                end;
              ' ': Cnt := 0;
              '*': LCh := ' ';
            end;
            S := S + LCh;
            GetCh;
          end;
        S := Trim(Lowercase(S));
        S := FormatContextualSelector(S, Sort);
        Selectors.Add(S);
      until LCh <> ',';
      while not CharInSet(LCh, ['{', '<', EofChar]) do
        GetCh;
    end;

    { ----------------GetCollection }
    procedure GetCollection(Styles: TStyleList; Selectors: TStringList);
    // Read a series of property, value pairs such as "Text-Align: Center;" between
    // '{', '}'  brackets. Add these to the Styles list for the specified selectors
    var
      Prop, Value, Value1: string;
      index: ShortIndex;
    begin
      if LCh <> '{' then
        Exit;
      GetCh;
      repeat
        Prop := '';
        SkipWhiteSpace;
        while CharInSet(LCh, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-']) do
          begin
            Prop := Prop + LCh;
            GetCh;
          end;
        Prop := Trim(LowerCase(Prop));
        SkipWhiteSpace;
        if CharInSet(LCh, [':', '=']) then
          begin
            GetCh;
            Value := '';
            while not CharInSet(LCh, [';', '}', '<', EofChar]) do
              begin
                Value := Value + LCh;
                GetCh;
              end;
            Value1 := Trim(Lowercase(Value)); { leave quotes on for font: }
            Value := RemoveQuotes(Value1);
            if FindShortHand(Prop, index) then
              case index of
                MarginX, BorderWidthX, PaddingX, BorderColorX, BorderStyleX:
                  DoMarginItems(index, Styles, Selectors, Prop, Value, ProcessProperty);
                FontX: DoFont(Styles, Selectors, Prop, Value1, ProcessProperty);
                BackgroundX: DoBackground(Styles, Selectors, Prop, Value, ProcessProperty);
                ListStyleX: DoListStyle(Styles, Selectors, Prop, Value, ProcessProperty);
                BorderX .. BorderLX: DoBorder(Styles, Selectors, Prop, Value, ProcessProperty);
              end
            else
              begin
                if (LinkPath <> '') and (Pos('url(', Value) > 0) then
                  Value := AddPath(Value);
                ProcessProperty(Styles, Selectors, Prop, Value);
              end;
          end;
        SkipWhiteSpace;
        if LCh = ';' then
          GetCh;
        while not CharInSet(LCh, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '}', '<', EofChar]) do
          GetCh;
      until CharInSet(LCh, ['}', '<', EofChar]);
      if LCh = '}' then
        GetCh;
    end;

    { ----------------DoStyle }
    procedure DoStyle(Styles: TStyleList; var C: Char; GC: CharFunction; const APath: string; FromLink: Boolean);
    var
      Selectors: TStringList;

    procedure ReadAt; { read thru @import or some other @ }
    var
      Media: string;

    procedure Brackets;
    begin
      if Pos('screen', Lowercase(Media)) > 0 then
        begin { parse @ media screen }
          GetCh;
          repeat
            Selectors.Clear;
            GetSelectors(Styles, Selectors);
            GetCollection(Styles, Selectors);
            SkipWhiteSpace;
          until CharInSet(LCh, ['}', '<', EOFChar]);
        end
      else
        repeat // read thru nested '{...}' pairs
          GetCh;
          if LCh = '{' then
            Brackets;
        until CharInSet(LCh, ['}', '<', EOFChar]);
        if LCh = '}' then
          GetCh;
    end;

    begin
      Media := ''; { read the Media string }
      repeat
        GetCh;
        Media := Media + LCh;
      until CharInSet(LCh, ['{', ';', '<', EOFChar]);
      if LCh = '{' then
        Brackets
      else if LCh = ';' then
        GetCh;
    end;

    begin
      Get := GC;
      LinkPath := APath;
      { enter with the first character in C }
      if C = ^M then
        C := ' ';

      LCh := ' '; { This trick is needed if the first char is part of comment, '/*' }
      Back := C;

      Selectors := TStringList.Create;

      try
        while CharInSet(LCh, [' ', '<', '>', '!', '-']) do { '<' will probably be present from <style> }
          GetCh;
        repeat
          if LCh = '@' then
            ReadAt
          else if LCh = '<' then
            begin { someone left a tag here, ignore it }
              repeat
                GetCh;
              until CharInSet(LCh, [' ', EOFChar]);
              SkipWhiteSpace;
            end
          else
            begin
              Selectors.Clear;
              GetSelectors(Styles, Selectors);
              GetCollection(Styles, Selectors);
            end;
          while CharInSet(LCh, [' ', '-', '>']) do
            GetCh;
        until (LCh = EOFChar) or ((LCh = '<') and not FromLink);
        C := UpCase(LCh);
      finally
        Selectors.Free;
      end;
    end;

    // The following is to process the Style=  attribute strings

    { ----------------MyProcess }
    procedure MyProcess(Propty: TObject; Selectors: TStringList; Prop, Value: string);
    begin (Propty as TProperties)
      .AddPropertyByName(Prop, Value);
    end;

    { ----------------ParsePropertyStr }
    procedure ParsePropertyStr(const PropertyStr: string; var Propty: TProperties);
    var
      Prop, Value, Value1, S: string;
      LCh: Char;
      I: Integer;
      index: ShortIndex;

    procedure GetCh;
    begin
      if I <= Length(S) then
        begin
          LCh := S[I];
          Inc(I);
          if LCh = ^M then
            LCh := ' ';
        end
      else
        LCh := EofChar;
    end;

    procedure SkipWhiteSpace;
    begin
      while CharInSet(LCh, [' ']) do
        GetCh;
    end;

    begin
      LinkPath := '';
      S := Lowercase(PropertyStr);
      I := 1;
      GetCh;
      repeat
        Prop := '';
        SkipWhiteSpace;
        while CharInSet(LCh, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-']) do
          begin
            Prop := Prop + LCh;
            GetCh;
          end;
        Prop := Trim(Prop);
        SkipWhiteSpace;
        if CharInSet(LCh, [':', '=']) then
          begin
            GetCh;
            Value := '';
            while not CharInSet(LCh, [';', EofChar]) do
              begin
                Value := Value + LCh;
                GetCh;
              end;
            Value1 := Trim(Value); { leave quotes on for font }
            Value := RemoveQuotes(Value1);

            if FindShortHand(Prop, index) then
              case index of
                MarginX, BorderWidthX, PaddingX, BorderColorX, BorderStyleX: DoMarginItems(index, Propty, nil, Prop, Value, MyProcess);
                FontX: DoFont(Propty, nil, Prop, Value1, MyProcess);
                BackgroundX: DoBackground(Propty, nil, Prop, Value, MyProcess);
                BorderX .. BorderLX: DoBorder(Propty, nil, Prop, Value, MyProcess);
                ListStyleX: DoListStyle(Propty, nil, Prop, Value, MyProcess);
              end
            else
              Propty.AddPropertyByName(Prop, Value);
          end;
        SkipWhiteSpace;
        if LCh = ';' then
          GetCh;
        while not CharInSet(LCh, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', EofChar]) do
          GetCh;
      until CharInSet(LCh, [EofChar]);
    end;

end.
