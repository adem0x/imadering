{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit AboutUnit;

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
  ShellApi,
  Buttons,
  ExtCtrls,
  GIFImg,
  JvExStdCtrls,
  JvBehaviorLabel,
  UtilsUnit,
  ComCtrls,
  JvSimpleXml, Menus;

type
  TAboutForm = class(TForm)
    VersionLabel: TLabel;
    URLLabel: TLabel;
    SiteLabel: TLabel;
    DataLabel: TLabel;
    HeadLabel: TLabel;
    CheckUpdateBitBtn: TBitBtn;
    BottomBevel: TBevel;
    ForumBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    LogoImage: TImage;
    HeadJvBehaviorLabel: TJvBehaviorLabel;
    SubJvBehaviorLabel: TJvBehaviorLabel;
    HistoryLabel: TLabel;
    LegalLabel: TLabel;
    AboutRichEdit: TRichEdit;
    SVNLabel: TLabel;
    FlagImage: TImage;
    RichPopupMenu: TPopupMenu;
    CopyRichText: TMenuItem;
    EmailBitBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure URLLabelMouseEnter(Sender: TObject);
    procedure URLLabelMouseLeave(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
    procedure CheckUpdateBitBtnClick(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure ForumBitBtnClick(Sender: TObject);
    procedure HeadJvBehaviorLabelStart(Sender: TObject);
    procedure HeadJvBehaviorLabelStop(Sender: TObject);
    procedure SubJvBehaviorLabelStart(Sender: TObject);
    procedure SubJvBehaviorLabelStop(Sender: TObject);
    procedure HistoryLabelClick(Sender: TObject);
    procedure LegalLabelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SVNLabelClick(Sender: TObject);
    procedure RichPopupMenuPopup(Sender: TObject);
    procedure CopyRichTextClick(Sender: TObject);
    procedure EmailBitBtnClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    AboutLen: Integer;
    AboutList: array of string;
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  VarsUnit,
  OverbyteIcsUrl;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_InfoDev = 'Devels';

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TAboutForm.TranslateForm;
const
  ReadMe = 'ReadMe.txt';
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  AboutRichEdit.Lines.Text := EmptyStr;
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
      begin
        // Загружаем файл языка
        LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
        if Root <> nil then
        begin
          // Загружаем "о программе"
          XML_Node := Root.Items.ItemNamed[C_Infos];
          if XML_Node <> nil then
          begin
            XML_Node := Root.Items.ItemNamed[C_Infos].Items.ItemNamed[AboutRichEdit.Name];
            if XML_Node <> nil then
              AboutRichEdit.Lines.Text := CheckText_RN(XML_Node.Properties.Value('c'));
          end;
          // Загружаем список разработчиков
          XML_Node := Root.Items.ItemNamed[C_InfoDev];
          if XML_Node <> nil then
            // Устанавливаем длинну массива
            SetLength(AboutList, XML_Node.Items.Count);
          // Загружаем строки в массив
          for I := 0 to Length(AboutList) - 1 do
          begin
            XML_Node := Root.Items.ItemNamed[C_InfoDev].Items.ItemNamed['c' + IntToStr(I)];
            if XML_Node <> nil then
              AboutList[I] := XML_Node.Properties.Value('c');
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Дополняем информацией из файла ReadMe
  if FileExists(V_MyPath + ReadMe) then
    AboutRichEdit.Lines.Text := AboutRichEdit.Lines.Text + C_RN + ReadFromFile(V_MyPath + ReadMe, false);
end;
{$ENDREGION}
{$REGION 'Other'}

procedure TAboutForm.OKBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TAboutForm.RichPopupMenuPopup(Sender: TObject);
begin
  // Управляем пунктами меню
  if AboutRichEdit.SelLength = 0 then
    CopyRichText.Enabled := False
  else
    CopyRichText.Enabled := True;
end;

procedure TAboutForm.SubJvBehaviorLabelStart(Sender: TObject);
begin
  // Берём заголовок строки из списка About
  SubJvBehaviorLabel.Caption := Parse(';', AboutList[AboutLen], 2);
end;

procedure TAboutForm.SubJvBehaviorLabelStop(Sender: TObject);
begin
  // Увеличиваем значение длинны списка титров
  Inc(AboutLen);
  // Если список титров не закончился, то продолжаем показ
  if AboutLen >= Length(AboutList) then
    AboutLen := 0;
  // Запустили таймер
  MainForm.JvTimerList.Events[13].Enabled := True;
end;

procedure TAboutForm.SVNLabelClick(Sender: TObject);
begin
  // Открываем SVN репозиторий проекта
  OpenURL('http://code.google.com/p/imadering/source/list');
end;

procedure TAboutForm.URLLabelClick(Sender: TObject);
begin
  // Открываем сайт в браузере по умолчанию
  OpenURL(C_SitePage);
end;

procedure TAboutForm.URLLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClBlue;
end;

procedure TAboutForm.URLLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClNavy;
end;

procedure TAboutForm.CheckUpdateBitBtnClick(Sender: TObject);
begin
  // Запускаем проверку обновлений программы на сайте
  MainForm.JvTimerListEvents2Timer(nil);
end;

procedure TAboutForm.ForumBitBtnClick(Sender: TObject);
begin
  // Поддержим проект
  OpenURL(C_SitePage);
end;

procedure TAboutForm.CopyRichTextClick(Sender: TObject);
begin
  // Копируем выделенный текст из RichEdit в буфер обмена
  AboutRichEdit.CopyToClipboard;
end;

procedure TAboutForm.EmailBitBtnClick(Sender: TObject);
begin
  // Открываем форму отправки письма
  OpenURL(C_MailTo + Format(C_MailText, [C_IMadering, C_IMadering + ' ' + WideLowerCase(VersionLabel.Caption) + C_MN]));
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Указываем уничтожаться окну при закрытии
  Action := CaFree;
  AboutForm := nil;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TAboutForm.FormCreate(Sender: TObject);
var
  LogoFile: string;
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(0, Icon);
  MainForm.AllImageList.GetBitmap(6, CheckUpdateBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(271, ForumBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(185, EmailBitBtn.Glyph);
  // Переводим форму на другие языки
  TranslateForm;
  // Загружаем логотип программы
  LogoFile := V_MyPath + C_IconsFolder + V_CurrentIcons + '\' + C_NoAvatarFileName;
  if FileExists(LogoFile) then
    LogoImage.Picture.LoadFromFile(LogoFile);
  LogoFile := V_MyPath + C_FlagsFolder + GetFlagFile(V_MyPath + C_FlagsFolder, EmptyStr, 'ru');
  if FileExists(LogoFile) then
    FlagImage.Picture.LoadFromFile(LogoFile);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Сведения о версии программы
  VersionLabel.Caption := Format(Lang_Vars[4].L_S, [V_FullVersion]);
  // Получаем дату компиляци файла
  DataLabel.Caption := Lang_Vars[166].L_S + ':' + ' ' + DateToStr(GetFileDateTime(V_MyPath + C_ExeName));
  // Присваиваем начальное значение длинны списка титров
  AboutLen := 0;
  // Стартуем показ титров
  HeadJvBehaviorLabel.BehaviorOptions.Active := True;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TAboutForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  // Прокручиваем рич в верх против глюка в вайн
  AboutRichEdit.SelStart := 0;
  SendMessage(AboutRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
end;

procedure TAboutForm.HeadJvBehaviorLabelStart(Sender: TObject);
begin
  // Берём заголовок строки из списка About
  HeadJvBehaviorLabel.Hint := Parse(';', AboutList[AboutLen], 1);
  HeadJvBehaviorLabel.Caption := HeadJvBehaviorLabel.Hint;
end;

procedure TAboutForm.HeadJvBehaviorLabelStop(Sender: TObject);
begin
  // Стартуем вторую строку титров
  SubJvBehaviorLabel.BehaviorOptions.Active := True;
end;

procedure TAboutForm.HistoryLabelClick(Sender: TObject);
begin
  // Открываем на просмотр файл истории изменений
  OpenURL(V_MyPath + 'Changes.txt');
end;

procedure TAboutForm.LegalLabelClick(Sender: TObject);
begin
  // Открываем на просмотр файл лицензии
  OpenURL(V_MyPath + 'GPL ' + V_CurrentLang + '.txt');
end;

{$ENDREGION}

end.

