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
  JvExControls,
  RXML;

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
    ICQUINLabel: TLabel;
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
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure MRAonserverLabelMouseEnter(Sender: TObject);
    procedure MRAonserverLabelMouseLeave(Sender: TObject);
    procedure RegNewEmailLabelClick(Sender: TObject);
    procedure ReqPassLabelClick(Sender: TObject);
    procedure MRAEmailEditChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure MRAOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure MRAOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

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
  // Применяем настройки
  ApplySettings;
end;

// APPLY SETTINGS--------------------------------------------------------------

procedure TMraOptionsForm.ApplySettings;
var
  XmlFile: TrXML;
begin
  // Применяем настройки MRA протокола
  // Нормализуем MRA логин
  MRAEmailEdit.Text := Trim(MRAEmailEdit.Text);
  MRAEmailEdit.Text := ExNormalizeScreenName(MRAEmailEdit.Text);
  // Обновляем данные логина в протоколе
  if MRAEmailEdit.Enabled then
    begin
      if MRAEmailEdit.Text <> MRA_LoginUIN then
        RosterForm.ClearMRAClick(Self); // Очищаем контакты
      MRA_LoginUIN := MRAEmailEdit.Text;
      if PassEdit.Text <> '----------------------' then
        begin
          PassEdit.Hint := PassEdit.Text;
          MRA_LoginPassword := PassEdit.Hint;
        end;
    end;
  // Обновляем данные сервера подключения
  MRA_LoginServerAddr := MraLoginServerComboBox.Text;
  MRA_LoginServerPort := MraLoginServerPortEdit.Text;
  // --------------------------------------------------------------------------
  // Записываем настройки MRA протокола в файл
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        // Данные логина
        if OpenKey('settings\mra\account', True) then
          try
            WriteString('login', MRAEmailEdit.Text);
            WriteBool('save-password', SavePassCheckBox.Checked);
            if (SavePassCheckBox.Checked) and (PassEdit.Text <> '----------------------') then
              WriteString('password', Base64Encode(PassEdit.Hint))
            else
              WriteString('password', EmptyStr);
            // Маскируем пароль
            if PassEdit.Text <> EmptyStr then
              PassEdit.Text := '----------------------';
          finally
            CloseKey;
          end;
        // Данные сервера подключения
        if OpenKey('settings\mra\server', True) then
          try
            WriteString('login-server', MraLoginServerComboBox.Text);
            WriteString('login-port', MraLoginServerPortEdit.Text);
          finally
            CloseKey;
          end;
        // Сохраняем файл настроек
        SaveToFile(ProfilePath + SettingsFileName);
      end;
  finally
    FreeAndNil(XmlFile);
  end;
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

// LOAD SETTINGS---------------------------------------------------------------

procedure TMraOptionsForm.LoadSettings;
var
  XmlFile: TrXML;
begin
  // Инициализируем XML
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            // Загружаем данные логина
            if OpenKey('settings\mra\account') then
              try
                MRAEmailEdit.Text := ReadString('login');
                if MRAEmailEdit.Text <> EmptyStr then
                  MRA_LoginUIN := MRAEmailEdit.Text;
                SavePassCheckBox.Checked := ReadBool('save-password');
                PassEdit.Text := ReadString('password');
                if PassEdit.Text <> EmptyStr then
                  begin
                    PassEdit.Hint := Base64Decode(PassEdit.Text);
                    MRA_LoginPassword := PassEdit.Hint;
                    PassEdit.Text := '----------------------';
                  end;
              finally
                CloseKey;
              end;
            // Загружаем данные сервера подключения
            if OpenKey('settings\mra\server') then
              try
                MraLoginServerComboBox.Text := ReadString('login-server');
                MraLoginServerPortEdit.Text := ReadString('login-port');
              finally
                CloseKey;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
end;

procedure TMraOptionsForm.TranslateForm;
begin
  // Переводим форму на другие языки

end;

procedure TMraOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TMraOptionsForm.FormCreate(Sender: TObject);
begin
  // Переводим форму на другие языки
  TranslateForm;
  // Загружаем настройки
  LoadSettings;
  // Деактивируем кнопку "применить"
  ApplyButton.Enabled := False;
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(66, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
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
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then
    ApplySettings;
  Close;
end;

procedure TMraOptionsForm.PassEditClick(Sender: TObject);
begin
  // Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = '----------------------' then
    PassEdit.Text := EmptyStr;
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
  // Отменяем событие изменения поля пароля
  PassEdit.OnChange := nil;
  // Показываем пароль в поле ввода пароля
  if ShowPassCheckBox.Checked then
    PassEdit.PasswordChar := #0
  else
    PassEdit.PasswordChar := '*';
  // Восстанавливаем событие изменения поля пароля
  PassEdit.OnChange := MRAEmailEditChange;
end;

end.
