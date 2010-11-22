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
  StrUtils,
  Menus, Htmlview;

type
  TLogForm = class(TForm)
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
    ToUtf8Text_Menu: TMenuItem;
    HTMLLogViewer: THTMLViewer;
    HTTP_DumpSpeedButton: TSpeedButton;
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
    procedure WriteLogSpeedButtonClick(Sender: TObject);
    procedure ToUtf8Text_MenuClick(Sender: TObject);
    procedure HTMLLogViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    HTMLStyle: string;
  public
    { Public declarations }
    procedure TranslateForm;
    procedure LoadStartLog;
    procedure AddLogText(Pkt_Head, Pkt_Text: string; PktIn: Boolean);
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
  C_log = 'log';

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TLogForm.TranslateForm;
const
  h = 'HEX';
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Переводим меню
  HexToText_Menu.Caption := Format(Lang_Vars[48].L_S, [C_BN + h, 'ANSI']);
  ToUtf8Text_Menu.Caption := Format(Lang_Vars[48].L_S, [EmptyStr, 'UTF-8']);
  HexToUtf8Text_Menu.Caption := Format(Lang_Vars[48].L_S, [C_BN + h, 'UTF-8']);
  HexToLEText_Menu.Caption := Format(Lang_Vars[48].L_S, [C_BN + h, 'U-LE']);
  HexToBEText_Menu.Caption := Format(Lang_Vars[48].L_S, [C_BN + h, 'U-BE']);
end;
{$ENDREGION}
{$REGION 'AddLogText'}

procedure TLogForm.AddLogText(Pkt_Head, Pkt_Text: string; PktIn: Boolean);
var
  Doc: string;
begin
  Doc := UTF8ToString(HTMLLogViewer.DocumentSource);
  Pkt_Head := C_QN + DateTimeToStr(Now) + C_EN + C_BN + Pkt_Head;
  if PktIn then
    Doc := Doc + '<IMG NAME="I" SRC="./Icons/' + V_CurrentIcons + '/inpkt.gif" ALIGN="ABSMIDDLE" BORDER="0"><span class=b> ' + Pkt_Head + '</span><br>'
  else
    Doc := Doc + '<IMG NAME="I" SRC="./Icons/' + V_CurrentIcons + '/outpkt.gif" ALIGN="ABSMIDDLE" BORDER="0"><span class=a> ' + Pkt_Head + '</span><br>';
  Pkt_Text := Text2XML(Pkt_Text);
  CheckMessage_BR(Pkt_Text);
  Doc := Doc + '<span class=c>' + Pkt_Text + '</span><br><br>';
  LoadHTMLStrings(HTMLLogViewer, Doc);
  // Ставим каретку в самый низ текста
  HTMLLogViewer.VScrollBarPosition := HTMLLogViewer.VScrollBar.Max;
end;
{$ENDREGION}
{$REGION 'FormCreate'}

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
    GetBitmap(223, WriteLogSpeedButton.Glyph);
    GetBitmap(268, TwitDumpSpeedButton.Glyph);
    GetBitmap(225, SaveLogSpeedButton.Glyph);
    GetBitmap(221, SearchSpeedButton.Glyph);
    GetBitmap(185, SendEmailSpeedButton.Glyph);
    GetBitmap(1, RosterSpeedButton.Glyph);
    GetBitmap(267, HTTP_DumpSpeedButton.Glyph);
  end;
  // Переводим окно на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Подгружаем стартовый лог
  HTMLLogViewer.DoubleBuffered := True;
  HTMLStyle := Format(C_HTML_head, [V_ChatCSS, C_IMadering]);
  LoadHTMLStrings(HTMLLogViewer, HTMLStyle);
  LoadStartLog;
end;
{$ENDREGION}
{$REGION 'Other'}

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Высвобождаем окно при закрытии
  Action := caFree;
  LogForm := nil;
end;

procedure TLogForm.WriteLogSpeedButtonClick(Sender: TObject);
begin
  // Меняем иконки на кнопке паузы записи в лог
  WriteLogSpeedButton.Glyph.Assign(nil);
  if WriteLogSpeedButton.Down then
    MainForm.AllImageList.GetBitmap(224, WriteLogSpeedButton.Glyph)
  else
    MainForm.AllImageList.GetBitmap(223, WriteLogSpeedButton.Glyph);
end;

procedure TLogForm.ToUtf8Text_MenuClick(Sender: TObject);
var
  s: string;
begin
  // Преобразовываем текст в UTF8 строку текста
  try
    s := UTF8ToString(HTMLLogViewer.SelText);
    MessageBox(Handle, PChar(s), PChar(Application.Title), MB_OK);
  except
  end;
end;

procedure TLogForm.ClearLogSpeedButtonClick(Sender: TObject);
begin
  // Очищаем лог
  HTMLLogViewer.Clear;
  LoadHTMLStrings(HTMLLogViewer, HTMLStyle);
end;

procedure TLogForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TLogForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Открываем поиск по тексту
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 70) then
    SearchSpeedButtonClick(nil);
end;

procedure TLogForm.CopySelText_MenuClick(Sender: TObject);
begin
  // Копируем выделенный текст в буфер обмена
  HTMLLogViewer.CopyToClipboard;
end;

procedure TLogForm.CopyAllText_MenuClick(Sender: TObject);
begin
  // Копируем весь текст в буфер обмена
  HTMLLogViewer.SelectAll;
  HTMLLogViewer.CopyToClipboard;
end;

procedure TLogForm.HexToBEText_MenuClick(Sender: TObject);
var
  s: string;
begin
  // Преобразовываем HEX в BE строку текста
  try
    s := UnicodeBEHex2Text(Trim(DeleteSpaces(HTMLLogViewer.SelText)));
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
    s := UnicodeLEHex2Text(Trim(DeleteSpaces(HTMLLogViewer.SelText)));
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
    s := Hex2Text(Trim(DeleteSpaces(HTMLLogViewer.SelText)));
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
    s := Hex2Text(Trim(DeleteSpaces(HTMLLogViewer.SelText)));
    s := UTF8ToString(s);
    MessageBox(Handle, PChar(s), PChar(Application.Title), MB_OK);
  except
  end;
end;

procedure TLogForm.HTMLLogViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При нажатии комбинации клавиш Ctrl + C в истории чата копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
    HTMLLogViewer.CopyToClipboard;
end;

procedure TLogForm.LogFindDialogFind(Sender: TObject);
var
  SDown: Boolean;
begin
  // Снимаем предыдущее выделение текста
  HTMLLogViewer.SelLength := 0;
  // Ищем текст в логе
  SDown := FrDown in LogFindDialog.Options;
  if not HTMLLogViewer.FindEx(LogFindDialog.FindText, FrMatchCase in LogFindDialog.Options, not SDown) then
    MessageBox(Handle, PChar(Lang_Vars[26].L_S), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
end;

procedure TLogForm.LogPopupMenuPopup(Sender: TObject);
begin
  // Управляем активностью пунктов меню
  if HTMLLogViewer.SelLength = 0 then
  begin
    CopySelText_Menu.Enabled := False;
    CopyAllText_Menu.Enabled := False;
    HexToText_Menu.Enabled := False;
    ToUtf8Text_Menu.Enabled := False;
    HexToUtf8Text_Menu.Enabled := False;
    HexToLEText_Menu.Enabled := False;
    HexToBEText_Menu.Enabled := False;
  end
  else
  begin
    CopySelText_Menu.Enabled := True;
    CopyAllText_Menu.Enabled := True;
    HexToText_Menu.Enabled := True;
    ToUtf8Text_Menu.Enabled := True;
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
var
  S: string;
  SL: TStringList;
begin
  // Сохраняем данные лога в файл
  with MainForm do
  begin
    SaveTextAsFileDialog.FileName := C_IMadering + C_BN + C_log;
    SaveTextAsFileDialog.FilterIndex := 1;
    if SaveTextAsFileDialog.Execute then
    begin
      // Получаем текст лога
      if HTMLLogViewer.SelLength = 0 then
      begin
        HTMLLogViewer.SelectAll;
        S := HTMLLogViewer.SelText;
        HTMLLogViewer.SelLength := 0;
      end
      else
        S := HTMLLogViewer.SelText;
      // Создаём лист строк
      SL := TStringList.Create;
      try
        SL.Text := Trim(S);
        SL.SaveToFile(SaveTextAsFileDialog.FileName, TEncoding.UTF8);
      finally
        SL.Free;
      end;
    end;
  end;
end;

procedure TLogForm.SearchSpeedButtonClick(Sender: TObject);
begin
  // Открываем диалог поиска текста в логе
  LogFindDialog.Execute;
end;

procedure TLogForm.SendEmailSpeedButtonClick(Sender: TObject);
var
  S, V: string;
begin
  // Открываем форму отправки письма с логом для разработчиков
  if HTMLLogViewer.SelLength = 0 then
  begin
    HTMLLogViewer.SelectAll;
    S := HTMLLogViewer.SelText;
    HTMLLogViewer.SelLength := 0;
  end
  else
    S := HTMLLogViewer.SelText;
  V := WideLowerCase(Format(Lang_Vars[4].L_S, [V_FullVersion]));
  OpenURL(C_MailTo + Format(C_MailText, [C_IMadering + C_BN + C_log, C_IMadering + C_BN + V + ReplaceStr(C_RN + C_RN + Trim(S), C_RN, C_MN)]));
end;

procedure TLogForm.LoadStartLog;
begin
  // Подгружаем стартовый лог
  HTMLLogViewer.Clear;
  LoadHTMLStrings(HTMLLogViewer, HTMLStyle);
  AddLogText(C_IMadering, V_StartLog, True);
end;
{$ENDREGION}

end.

