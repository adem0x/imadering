{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit AboutUnit;

interface

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
  ComCtrls;

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
    AboutListTimer: TTimer;
    Label1: TLabel;
    Label2: TLabel;
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
    procedure AboutListTimerTimer(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    AboutLen: Integer;

  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  VarsUnit;

procedure TAboutForm.TranslateForm;
begin
  // Присваиваем текстовые значения
  AboutRichEdit.Lines.Append(Info_About);
end;

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
  AboutListTimer.Enabled := True;
end;

procedure TAboutForm.URLLabelClick(Sender: TObject);
begin
  // Открываем сайт в браузере по умолчанию
  OpenURL('http://imadering.com');
end;

procedure TAboutForm.URLLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TAboutForm.URLLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

procedure TAboutForm.AboutListTimerTimer(Sender: TObject);
begin
  AboutListTimer.Enabled := False;
  // Очищаем поля титров
  SubJvBehaviorLabel.Caption := EmptyStr;
  // Стартуем показ титров
  if HeadJvBehaviorLabel.Hint <> Parse(';', AboutList[AboutLen], 1) then
    begin
      HeadJvBehaviorLabel.Caption := EmptyStr;
      HeadJvBehaviorLabel.BehaviorOptions.Active := True;
    end
  else
    SubJvBehaviorLabel.BehaviorOptions.Active := True;
end;

procedure TAboutForm.CheckUpdateBitBtnClick(Sender: TObject);
begin
  // Запускаем проверку обновлений программы на сайте
  MainForm.JvTimerListEvents2Timer(nil);
end;

procedure TAboutForm.DonateBitBtnClick(Sender: TObject);
begin
  // Поддержим проект открытием официального сайта
  URLLabelClick(Self);
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Указываем уничтожаться окну при закрытии
  Action := CaFree;
  AboutForm := nil;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(0, Icon);
  MainForm.AllImageList.GetBitmap(6, CheckUpdateBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(185, DonateBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  // Переводим форму на другие языки
  TranslateForm;
  // Загружаем логотип программы
  if FileExists(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif') then
    LogoImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif');
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Сведения о версии программы
  VersionLabel.Caption := Format(VersionL, [InitBuildInfo]);
  // Получаем дату компиляци файла
  DataLabel.Caption := DataLabel.Caption + ' ' + DateToStr(GetFileDateTime(MyPath + 'Imadering.exe'));
  // Присваиваем начальное значение длинны списка титров
  AboutLen := 1;
  // Стартуем показ титров
  HeadJvBehaviorLabel.BehaviorOptions.Active := True;
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

procedure TAboutForm.Label1Click(Sender: TObject);
begin
  // Открываем на просмотр файл истории изменений
  OpenURL(MyPath + 'Changes.txt');
end;

procedure TAboutForm.Label2Click(Sender: TObject);
begin
  // Открываем на просмотр файл лицензии
  OpenURL(MyPath + 'GPL_ru.txt');
end;

end.
