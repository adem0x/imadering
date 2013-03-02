unit BugReportUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, JvSimpleXml, StrUtils;

type
  TBugReportForm = class(TForm)
    BugReportMemo: TMemo;
    BugInfoRichEdit: TRichEdit;
    SendBugReportBitBtn: TBitBtn;
    AppTerminateBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    procedure FormDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AppTerminateBitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure SendBugReportBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  BugReportForm: TBugReportForm;

implementation

uses
  MainUnit,
  VarsUnit,
  UtilsUnit;

{$R *.dfm}

{$REGION 'FormCreate'}

procedure TBugReportForm.FormCreate(Sender: TObject);
var
  VI: TOSVersionInfo;
  Lang: Word;
  Language: array[0..100] of char;
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(245, Icon);
  MainForm.AllImageList.GetBitmap(185, SendBugReportBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(139, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(3, AppTerminateBitBtn.Glyph);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Узнаём версию Windows
  VI.DwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VI);
  V_StartLog := Format(Log_WinVer, [VI.DwMajorVersion, VI.DwMinorVersion, VI.DwBuildNumber, VI.SzCSDVersion]) + C_RN;
  // Пишем в лог код локального языка системы
  Lang := GetSystemDefaultLangID;
  VerLanguageName(Lang, Language, 100);
  V_StartLog := V_StartLog + Log_Lang_Code + ':' + ' ' + string(Language) + ' ' + '[' + IntToStr(Lang) + ']' + C_RN;
  // Пишем в лог путь к программе
  V_StartLog := V_StartLog + LogMyPath + ':' + ' ' + V_MyPath;
  V_StartLog := V_StartLog + C_RN + LogProfile + ':' + ' ' + V_ProfilePath;
  BugReportMemo.Lines.Add(V_StartLog);
  BugReportMemo.Lines.Add(C_MaskPass + C_MaskPass + C_MaskPass + C_MaskPass);
end;
{$ENDREGION}
{$REGION 'Other'}

procedure TBugReportForm.CancelBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TBugReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Высвобождаем окно при закрытии
  Action := caFree;
  BugReportForm := nil;
end;

procedure TBugReportForm.AppTerminateBitBtnClick(Sender: TObject);
begin
  // Уничтожаем приложение
  Application.Terminate;
end;

procedure TBugReportForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'SendBugReportBitBtnClick'}

  procedure TBugReportForm.SendBugReportBitBtnClick(Sender: TObject);
  var
    S, V: string;
  begin
    // Открываем форму отправки письма с логом для разработчиков
    if BugReportMemo.SelLength = 0 then
      S := BugReportMemo.Text
    else
      S := BugReportMemo.SelText;
    V := WideLowerCase(Format(Lang_Vars[4].L_S, [V_FullVersion]));
    OpenURL(C_MailTo + Format(C_MailText, [C_IMadering + ' ' + 'b' + 'u' + 'g' + ' ' + 'r' + 'e' + 'p' + 'o' + 'r' + 't', //
      C_IMadering + ' ' + V + ReplaceStr(C_RN + C_RN + Trim(S), C_RN, C_MN)]));
  end;
{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TBugReportForm.TranslateForm;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  AppTerminateBitBtn.Caption := Lang_Vars[8].L_S + ' ' + C_IMadering;
  CancelBitBtn.Caption := Lang_Vars[9].L_S;
  BugInfoRichEdit.Lines.Text := EmptyStr;
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем текущий файл языка
      if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
      begin
        // Загружаем файл языка
        LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Infos];
          if XML_Node <> nil then
          begin
            // Загружаем инфы
            Sub_Node := XML_Node.Items.ItemNamed[BugInfoRichEdit.Name];
            if Sub_Node <> nil then
              BugInfoRichEdit.Lines.Strings[0] := CheckText_RN(Sub_Node.Properties.Value('c'));
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}

end.

