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
  Buttons,
  StrUtils, Menus;

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
    SendEmailSpeedButton: TSpeedButton;
    RosterSpeedButton: TSpeedButton;
    LogPopupMenu: TPopupMenu;
    HexToText_Menu: TMenuItem;
    CopySelText_Menu: TMenuItem;
    CopyAllText_Menu: TMenuItem;
    HexToUtf8Text_Menu: TMenuItem;
    HexToLEText_Menu: TMenuItem;
    HexToBEText_Menu: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ClearLogSpeedButtonClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SaveLogSpeedButtonClick(Sender: TObject);
    procedure SearchSpeedButtonClick(Sender: TObject);
    procedure LogFindDialogFind(Sender: TObject);
    procedure RosterSpeedButtonClick(Sender: TObject);
    procedure SendEmailSpeedButtonClick(Sender: TObject);
    procedure HexToText_MenuClick(Sender: TObject);
    procedure LogPopupMenuPopup(Sender: TObject);
    procedure CopySelText_MenuClick(Sender: TObject);
    procedure CopyAllText_MenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HexToUtf8Text_MenuClick(Sender: TObject);
    procedure HexToLEText_MenuClick(Sender: TObject);
    procedure HexToBEText_MenuClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
    procedure LoadStartLog;
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
  OverbyteIcsUrl,
  OverbyteIcsUtils;

const
  C_log = ' log';

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
        'A'..'Z', 'А'..'Я': Result[I] := Chr(Ord(S[I]) + 32);
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
  // Переводим меню
  HexToText_Menu.Caption := Format(Lang_Vars[48].L_S, ['ANSI']);
  HexToUtf8Text_Menu.Caption := Format(Lang_Vars[48].L_S, ['UTF-8']);
  HexToLEText_Menu.Caption := Format(Lang_Vars[48].L_S, ['U-LE']);
  HexToBEText_Menu.Caption := Format(Lang_Vars[48].L_S, ['U-BE']);
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Высвобождаем окно при закрытии
  Action := caFree;
  LogForm := nil;
end;

procedure TLogForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем иконки окна лога
  with MainForm.AllImageList do
  begin
    GetIcon(245, Icon);
    GetBitmap(159, ClearLogSpeedButton.Glyph);
    GetBitmap(81, ICQDumpSpeedButton.Glyph);
    GetBitmap(43, JabberDumpSpeedButton.Glyph);
    GetBitmap(66, MRADumpSpeedButton.Glyph);
    GetBitmap(249, WriteLogSpeedButton.Glyph);
    GetBitmap(268, TwitDumpSpeedButton.Glyph);
    GetBitmap(225, SaveLogSpeedButton.Glyph);
    GetBitmap(221, SearchSpeedButton.Glyph);
    GetBitmap(185, SendEmailSpeedButton.Glyph);
    GetBitmap(1, RosterSpeedButton.Glyph);
  end;
  // Переводим окно на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Подгружаем стартовый лог
  LoadStartLog;
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

procedure TLogForm.CopySelText_MenuClick(Sender: TObject);
begin
  // Копируем выделенный текст в буфер обмена
  LogMemo.CopyToClipboard;
end;

procedure TLogForm.CopyAllText_MenuClick(Sender: TObject);
begin
  // Копируем весь текст в буфер обмена
  LogMemo.SelectAll;
  LogMemo.CopyToClipboard;
end;

procedure TLogForm.HexToBEText_MenuClick(Sender: TObject);
var
  s: string;
begin
  // Преобразовываем HEX в BE строку текста
  try
    s := UnicodeBEHex2Text(Trim(DeleteSpaces(LogMemo.SelText)));
    MessageBox(Handle, PChar(s), PChar(Application.Title), MB_OK);
  except
  end;
end;

procedure TLogForm.HexToLEText_MenuClick(Sender: TObject);
var
  s: string;
begin
  // Преобразовываем HEX в LE строку текста
  try
    s := UnicodeLEHex2Text(Trim(DeleteSpaces(LogMemo.SelText)));
    MessageBox(Handle, PChar(s), PChar(Application.Title), MB_OK);
  except
  end;
end;

procedure TLogForm.HexToText_MenuClick(Sender: TObject);
var
  s: string;
begin
  // Преобразовываем HEX в ANSI строку текста
  try
    s := Hex2Text(Trim(DeleteSpaces(LogMemo.SelText)));
    MessageBox(Handle, PChar(s), PChar(Application.Title), MB_OK);
  except
  end;
end;

procedure TLogForm.HexToUtf8Text_MenuClick(Sender: TObject);
var
  s: string;
begin
  // Преобразовываем HEX в UTF8 строку текста
  try
    s := Hex2Text(Trim(DeleteSpaces(LogMemo.SelText)));
    s := UTF8ToString(s);
    MessageBox(Handle, PChar(s), PChar(Application.Title), MB_OK);
  except
  end;
end;

procedure TLogForm.LogFindDialogFind(Sender: TObject);
begin
  // Ищем текст в логе
  if not FindInMemo(LogMemo, LogFindDialog.FindText, FrDown in LogFindDialog.Options, FrMatchCase in LogFindDialog.Options) then
    MessageBox(Handle, PChar(Lang_Vars[26].L_S), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
end;

procedure TLogForm.LogPopupMenuPopup(Sender: TObject);
begin
  // Управляем активностью пунктов меню
  if LogMemo.SelText = EmptyStr then
  begin
    CopySelText_Menu.Enabled := False;
    CopyAllText_Menu.Enabled := False;
    HexToText_Menu.Enabled := False;
    HexToUtf8Text_Menu.Enabled := False;
    HexToLEText_Menu.Enabled := False;
    HexToBEText_Menu.Enabled := False;
  end
  else
  begin
    CopySelText_Menu.Enabled := True;
    CopyAllText_Menu.Enabled := True;
    HexToText_Menu.Enabled := True;
    HexToUtf8Text_Menu.Enabled := True;
    HexToLEText_Menu.Enabled := True;
    HexToBEText_Menu.Enabled := True;
  end;
end;

procedure TLogForm.RosterSpeedButtonClick(Sender: TObject);
begin
  // Сохраняем Ростер
  if V_Roster <> nil then
  begin
    with MainForm do
    begin
      SaveTextAsFileDialog.FileName := C_ContactListFileName;
      SaveTextAsFileDialog.FilterIndex := 2;
      if SaveTextAsFileDialog.Execute then
        V_Roster.SaveToFile(SaveTextAsFileDialog.FileName);
    end;
  end;
end;

procedure TLogForm.SaveLogSpeedButtonClick(Sender: TObject);
begin
  // Сохраняем данные лога в файл
  with MainForm do
  begin
    SaveTextAsFileDialog.FileName := C_IMadering + C_log;
    SaveTextAsFileDialog.FilterIndex := 1;
    if SaveTextAsFileDialog.Execute then
      LogMemo.Lines.SaveToFile(SaveTextAsFileDialog.FileName, TEncoding.Unicode);
  end;
end;

procedure TLogForm.SearchSpeedButtonClick(Sender: TObject);
begin
  // Открываем диалог поиска текста в логе
  LogFindDialog.Execute;
end;

procedure TLogForm.SendEmailSpeedButtonClick(Sender: TObject);
var
  s, v: string;
begin
  // Открываем форму отправки письма с логом для разработчиков
  if LogMemo.SelLength = 0 then
    s := LogMemo.Text
  else
    s := LogMemo.SelText;
  v := WideLowerCase(Format(Lang_Vars[4].L_S, [V_FullVersion]));
  OpenURL(C_MailTo + Format(C_MailText, [C_IMadering + C_log, C_IMadering + C_BN + v + ReplaceStr(C_RN + C_RN + s, C_RN, C_MN)]));
end;

procedure TLogForm.LoadStartLog;
begin
  // Подгружаем стартовый лог
  LogMemo.Clear;
  LogMemo.Lines.Add(V_StartLog + C_RN + C_MaskPass + C_MaskPass + C_MaskPass + C_MaskPass);
end;
{$ENDREGION}

end.

