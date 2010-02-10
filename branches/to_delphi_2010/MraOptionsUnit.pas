{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MraOptionsUnit;

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
  Buttons,
  ButtonGroup,
  ExtCtrls,
  ComCtrls,
  JvPageList,
  JvExControls;

type
  TMraOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    MRAOptionButtonGroup: TButtonGroup;
    OptionPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    ReqPassLabel: TLabel;
    MRAEmailLabel: TLabel;
    PassLabel: TLabel;
    MRAEmailEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    RegNewEmailLabel: TLabel;
    OptionGroupBox: TGroupBox;
    ConnectPage: TJvStandardPage;
    GroupBox1: TGroupBox;
    MraLoginServerLabel: TLabel;
    MraLoginServerComboBox: TComboBox;
    MraLoginServerPortLabel: TLabel;
    MraLoginServerPortEdit: TEdit;
    OptionsPage: TJvStandardPage;
    IDClientPage: TJvStandardPage;
    ConsolePage: TJvStandardPage;
    MRAEmailComboBox: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure MRAonserverLabelMouseEnter(Sender: TObject);
    procedure MRAonserverLabelMouseLeave(Sender: TObject);
    procedure RegNewEmailLabelClick(Sender: TObject);
    procedure ReqPassLabelClick(Sender: TObject);
    procedure MRAEmailEditChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure MRAOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure MRAOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
    procedure LoadSettings;

  public
    { Public declarations }
    procedure ApplySettings;
    procedure TranslateForm;
  end;

var
  MraOptionsForm: TMraOptionsForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  MraProtoUnit,
  RosterUnit,
  OverbyteIcsMimeUtils;

procedure TMraOptionsForm.ApplyButtonClick(Sender: TObject);
begin
//
end;

procedure TMraOptionsForm.ApplySettings;
begin
//
end;

procedure TMraOptionsForm.LoadSettings;
begin
//
end;

procedure TMraOptionsForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := S_Cancel;
  ApplyButton.Caption := S_Apply;
end;

procedure TMraOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TMraOptionsForm.FormCreate(Sender: TObject);
begin
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(66, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Переводим форму на другие языки
  TranslateForm;
  // Загружаем настройки
  LoadSettings;
  // Применяем настройки
  ApplySettings;
end;

procedure TMraOptionsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TMraOptionsForm.MRAEmailEditChange(Sender: TObject);
begin
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TMraOptionsForm.MRAonserverLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TMraOptionsForm.MRAonserverLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

procedure TMraOptionsForm.MRAOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := index;
end;

procedure TMraOptionsForm.MRAOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if MRAOptionButtonGroup.ItemIndex <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := MRAOptionButtonGroup.ItemIndex;
end;

procedure TMraOptionsForm.OKButtonClick(Sender: TObject);
begin
//
end;

procedure TMraOptionsForm.RegNewEmailLabelClick(Sender: TObject);
begin
  // Открываем регистрацию на веб сайте mail.ru
  OpenURL('http://win.mail.ru/cgi-bin/signup');
end;

procedure TMraOptionsForm.ReqPassLabelClick(Sender: TObject);
begin
  // Открываем ссылку воостановления пароля
  OpenURL('http://win.mail.ru/cgi-bin/passremind');
end;

procedure TMraOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
begin
//
end;

end.
