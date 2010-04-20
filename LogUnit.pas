{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit LogUnit;

interface

{$REGION 'Uses'}

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Buttons;

type
  TLogForm = class(TForm)
    LogMemo: TMemo;
    BottomPanel: TPanel;
    ClearLogSpeedButton: TSpeedButton;
    Bevel: TBevel;
    ICQDumpSpeedButton: TSpeedButton;
    JabberDumpSpeedButton: TSpeedButton;
    MRADumpSpeedButton: TSpeedButton;
    WriteLogSpeedButton: TSpeedButton;
    TwitDumpSpeedButton: TSpeedButton;
    SaveLogSpeedButton: TSpeedButton;
    SearchSpeedButton: TSpeedButton;
    LogFindDialog: TFindDialog;
    procedure FormCreate(Sender: TObject);
    procedure ClearLogSpeedButtonClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SaveLogSpeedButtonClick(Sender: TObject);
    procedure SearchSpeedButtonClick(Sender: TObject);
    procedure LogFindDialogFind(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  LogForm: TLogForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  RosterUnit;

{$ENDREGION}
{$REGION 'FindInMemo'}

function FindInMemo(Memo: TMemo; const FindText: string; FindDown, MatchCase: Boolean): Boolean;

function PosR2L(const FindStr, SrcStr: string): Integer;
var
  Ps, L: Integer;

function InvertSt(const S: string): string;
var
  I: Integer;
begin
  L := Length(S);
  SetLength(Result, L);
  for I := 1 to L do
    Result[I] := S[L - I + 1];
end;

begin
  Ps := Pos(InvertSt(FindStr), InvertSt(SrcStr));
  if Ps <> 0 then
    Result := Length(SrcStr) - Length(FindStr) - Ps + 2
  else
    Result := 0;
end;

function MCase(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := 1 to Length(S) do
    begin
      case S[I] of
        'A' .. 'Z', 'А' .. 'Я': Result[I] := Chr(Ord(S[I]) + 32);
        'Ё': Result[I] := 'ё';
        'Ѓ': Result[I] := 'ѓ';
        'Ґ': Result[I] := 'ґ';
        'Є': Result[I] := 'є';
        'Ї': Result[I] := 'ї';
        'І': Result[I] := 'і';
        'Ѕ': Result[I] := 'ѕ';
      end;
    end;
end;

var
  Y, X, SkipChars: Integer;
  FindS, SrcS: string;
  P: TPoint;
begin
  Result := False;
  if MatchCase then
    FindS := FindText
  else
    FindS := MCase(FindText);
  P := Memo.CaretPos;
  if FindDown then
    for Y := P.Y to Memo.Lines.Count do
      begin
        if Y <> P.Y then
          SrcS := Memo.Lines[Y]
        else
          SrcS := Copy(Memo.Lines[Y], P.X + 1, Length(Memo.Lines[Y]) - P.X + 1);
        if not MatchCase then
          SrcS := MCase(SrcS);
        X := Pos(FindS, SrcS);
        if X <> 0 then
          begin
            if Y = P.Y then
              Inc(X, P.X);
            P := Point(X, Y);
            Result := True;
            Break;
          end
      end
    else
      for Y := P.Y downto 0 do
        begin
          if Y <> P.Y then
            SrcS := Memo.Lines[Y]
          else
            SrcS := Copy(Memo.Lines[Y], 1, P.X - Memo.SelLength);
          if not MatchCase then
            SrcS := MCase(SrcS);
          X := PosR2L(FindS, SrcS);
          if X <> 0 then
            begin
              P := Point(X, Y);
              Result := True;
              Break;
            end
        end;
  if Result then
    begin
      SkipChars := 0;
      for Y := 0 to P.Y - 1 do
        Inc(SkipChars, Length(Memo.Lines[Y]));
      Memo.SelStart := SkipChars + (P.Y * 2) + P.X - 1;
      Memo.SelLength := Length(FindText);
    end;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TLogForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TLogForm.FormCreate(Sender: TObject);
begin
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TLogForm.ClearLogSpeedButtonClick(Sender: TObject);
begin
  // Очищаем лог
  LogMemo.Clear;
end;

procedure TLogForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TLogForm.LogFindDialogFind(Sender: TObject);
begin
  // Ищем текст в логе
  if not FindInMemo(LogMemo, LogFindDialog.FindText, FrDown in LogFindDialog.Options, FrMatchCase in LogFindDialog.Options) then
    MessageBox(Handle, PChar(Lang_Vars[26].L_S), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
end;

procedure TLogForm.SaveLogSpeedButtonClick(Sender: TObject);
begin
  // Сохраняем данные лога в файл
  with MainForm do
    begin
      SaveTextAsFileDialog.FileName := 'IMadering Log';
      if SaveTextAsFileDialog.Execute then
        LogMemo.Lines.SaveToFile(SaveTextAsFileDialog.FileName, TEncoding.Unicode);
    end;
end;

procedure TLogForm.SearchSpeedButtonClick(Sender: TObject);
begin
  // Открываем диалог поиска текста в логе
  LogFindDialog.Execute;
end;

{$ENDREGION}

end.
