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
  JvSimpleXml;

type
  TAboutForm = class(TForm)
    VersionLabel: TLabel;
    URLLabel: TLabel;
    SiteLabel: TLabel;
    DataLabel: TLabel;
    HeadLabel: TLabel;
    CheckUpdateBitBtn: TBitBtn;
    Bevel1: TBevel;
    DonateBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    LogoImage: TImage;
    HeadJvBehaviorLabel: TJvBehaviorLabel;
    SubJvBehaviorLabel: TJvBehaviorLabel;
    HistoryLabel: TLabel;
    LegalLabel: TLabel;
    AboutRichEdit: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure URLLabelMouseEnter(Sender: TObject);
    procedure URLLabelMouseLeave(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
    procedure CheckUpdateBitBtnClick(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure DonateBitBtnClick(Sender: TObject);
    procedure HeadJvBehaviorLabelStart(Sender: TObject);
    procedure HeadJvBehaviorLabelStop(Sender: TObject);
    procedure SubJvBehaviorLabelStart(Sender: TObject);
    procedure SubJvBehaviorLabelStop(Sender: TObject);
    procedure HistoryLabelClick(Sender: TObject);
    procedure LegalLabelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    AboutLen: Integer;
    AboutList: array [1 .. 10] of string;
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
  VarsUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_InfoAbout = 'About';
  C_InfoDev = 'Devels';

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TAboutForm.TranslateForm;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        // Загружаем настройки
        if FileExists(MyPath + Format(LangPath, [CurrentLang])) then
          begin
            // Загружаем файл языка
            LoadFromFile(MyPath + Format(LangPath, [CurrentLang]));
            if Root <> nil then
              begin
                // Загружаем "о программе"
                XML_Node := Root.Items.ItemNamed[C_Infos];
                if XML_Node <> nil then
                  begin
                    XML_Node := Root.Items.ItemNamed[C_Infos].Items.ItemNamed[C_InfoAbout];
                    if XML_Node <> nil then
                      AboutRichEdit.Lines.Text := CheckText_RN(XML_Node.Properties.Value('c'));
                  end;
                // Загружаем список разработчиков
                XML_Node := Root.Items.ItemNamed[C_InfoDev];
                if XML_Node <> nil then
                  for I := 1 to Length(AboutList) do
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
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TAboutForm.OKBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
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
  if AboutLen > Length(AboutList) then
    AboutLen := 1;
  // Запустили таймер
  MainForm.JvTimerList.Events[13].Enabled := True;
end;

procedure TAboutForm.URLLabelClick(Sender: TObject);
begin
  // Открываем сайт в браузере по умолчанию
  OpenURL(C_SitePage);
end;

procedure TAboutForm.URLLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TAboutForm.URLLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

procedure TAboutForm.CheckUpdateBitBtnClick(Sender: TObject);
begin
  // Запускаем проверку обновлений программы на сайте
  MainForm.JvTimerListEvents2Timer(nil);
end;

procedure TAboutForm.DonateBitBtnClick(Sender: TObject);
begin
  // Поддержим проект
  OpenURL('http://imadering.mybb.ru/viewtopic.php?id=81');
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
  MainForm.AllImageList.GetBitmap(185, DonateBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  // Переводим форму на другие языки
  TranslateForm;
  // Загружаем логотип программы
  LogoFile := MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif';
  if FileExists(LogoFile) then
    LogoImage.Picture.LoadFromFile(LogoFile);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Сведения о версии программы
  VersionLabel.Caption := Format(S_Version, [FullVersion]);
  // Получаем дату компиляци файла
  DataLabel.Caption := DataLabel.Caption + C_BN + DateToStr(GetFileDateTime(MyPath + 'Imadering.exe'));
  // Присваиваем начальное значение длинны списка титров
  AboutLen := 1;
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
  OpenURL(MyPath + 'Changes.txt');
end;

procedure TAboutForm.LegalLabelClick(Sender: TObject);
begin
  // Открываем на просмотр файл лицензии
  OpenURL(MyPath + 'GPL_' + CurrentLang + '.txt');
end;

{$ENDREGION}

end.
