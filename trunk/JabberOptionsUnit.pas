{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit JabberOptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ButtonGroup, ExtCtrls, ComCtrls, JvPageList,
  JvExControls, rXML, Mask, JvExMask, JvSpin, Menus;

type
  TJabberOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    JabberOptionButtonGroup: TButtonGroup;
    OptionPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    RegNewAccountLabel: TLabel;
    ICQUINLabel: TLabel;
    PassLabel: TLabel;
    JabberJIDEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    DeleteAccountLabel: TLabel;
    JIDonserverLabel: TLabel;
    AccountOptionGroupBox: TGroupBox;
    ServerPage: TJvStandardPage;
    ProxyPage: TJvStandardPage;
    OptionPage: TJvStandardPage;
    RosterPage: TJvStandardPage;
    AnketaPage: TJvStandardPage;
    HomePage: TJvStandardPage;
    WorkPage: TJvStandardPage;
    PersonalPage: TJvStandardPage;
    ParamsPage: TJvStandardPage;
    JCustomServerHostEdit: TLabeledEdit;
    JCustomServerPortEdit: TLabeledEdit;
    JUseCustomServerSettingsCheckBox: TCheckBox;
    ConnectionGroupBox: TGroupBox;
    Bevel1: TBevel;
    JUseSSLCheckBox: TCheckBox;
    CheckBox1: TCheckBox;
    ResursLabel: TLabel;
    ResursComboBox: TComboBox;
    PrioritetJvSpinEdit: TJvSpinEdit;
    PrioritetLabel: TLabel;
    JServerPopupMenu: TPopupMenu;
    Set_JabberOrg: TMenuItem;
    Set_JabberRu: TMenuItem;
    Set_QIPru: TMenuItem;
    Set_GoogleTalk: TMenuItem;
    Set_LiveJournal: TMenuItem;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JIDonserverLabelMouseEnter(Sender: TObject);
    procedure JIDonserverLabelMouseLeave(Sender: TObject);
    procedure JabberSomeEditChange(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure JabberOptionButtonGroupButtonClicked(Sender: TObject;
      Index: Integer);
    procedure JUseCustomServerSettingsCheckBoxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PassEditChange(Sender: TObject);
    procedure Set_JabberOrgClick(Sender: TObject);
    procedure JIDonserverLabelClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadSettings;
    procedure LoadAccountSettings(SettingsXml: TrXML);
    procedure LoadConnectionSettings(SettingsXml: TrXML);
    procedure UpdateJabberSettings;
    procedure SaveSettingsJabberAccount(SettingsXml: TrXML);
    procedure SaveSettingsJabberConnection(SettingsXml: TrXML);
  public
    { Public declarations }
    procedure ApplySettings;
    procedure TranslateForm;
  end;

var
  JabberOptionsForm: TJabberOptionsForm;

implementation

{$R *.dfm}

uses
  MainUnit, JabberProtoUnit, UnitCrypto, SettingsUnit, UtilsUnit, VarsUnit,
  RosterUnit;

resourcestring
  StrSettingsJabberConnection = 'settings\jabber\connection';
  StrSettingsJabberAccount = 'settings\jabber\account';
  StrKeyUseCustomServerSettings = 'use_custom_server';
  StrKeyUseSSL = 'UseSSL';
  StrKeyServerHost = 'server_host';
  StrKeyServerPort = 'server_port';
  StrKeyLogin = 'login';
  StrKeySavePassword = 'save-password';
  StrKeyPassword = 'password';
  StrPassMask = '----------------------';

procedure TJabberOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  //--Применяем настройки
  ApplySettings;
end;

//--APPLY SETTINGS--------------------------------------------------------------

procedure TJabberOptionsForm.ApplySettings;
var
  SettingsXml: TrXML;
begin
  //--Применяем настройки Jabber протокола
  UpdateJabberSettings;
  //----------------------------------------------------------------------------
  SettingsXml := TrXML.Create;
  //--Записываем настройки Jabber протокола в файл
  try
    if FileExists(ProfilePath + SettingsFileName) then
      SettingsXml.LoadFromFile(ProfilePath + SettingsFileName);
    //--Сохраняем настройки
    SaveSettingsJabberAccount(SettingsXml);
    SaveSettingsJabberConnection(SettingsXml);
    //--Записываем файл
    SettingsXml.SaveToFile(ProfilePath + SettingsFileName);
  finally
    FreeAndNil(SettingsXml);
  end;
  //--Деактивируем кнопку применения настроек
  ApplyButton.Enabled := false;
end;

//--LOAD SETTINGS---------------------------------------------------------------

procedure TJabberOptionsForm.LoadSettings;
var
  SettingsXml: TrXML;
begin
  //--Инициализируем XML
  SettingsXml := TrXML.Create;
  try
    if FileExists(ProfilePath + SettingsFileName) then
    begin
      SettingsXml.LoadFromFile(ProfilePath + SettingsFileName);
      //--Загружаем данные логина
      LoadAccountSettings(SettingsXml);
      //--Загружаем настройки подключения
      LoadConnectionSettings(SettingsXml);
    end;
  finally
    FreeAndNil(SettingsXml);
  end;
end;

procedure TJabberOptionsForm.TranslateForm;
begin
  //--Переводим форму на другие языки

end;

procedure TJabberOptionsForm.SaveSettingsJabberConnection(SettingsXml: TrXML);
begin
  with SettingsXml do
    if OpenKey(StrSettingsJabberConnection, true) then
    try
      WriteBool(StrKeyUseCustomServerSettings, JUseCustomServerSettingsCheckBox.Checked);
      WriteBool(StrKeyUseSSL, JUseSSLCheckBox.Checked);
      WriteString(StrKeyServerHost, JCustomServerHostEdit.Text);
      WriteString(StrKeyServerPort, JCustomServerPortEdit.Text);
    finally
      CloseKey;
    end;
end;

procedure TJabberOptionsForm.Set_JabberOrgClick(Sender: TObject);
begin
  //--Автоматом подстраиваем учётные записи под серверы
  if BMSearch(0, JabberJIDEdit.Text, '@') > -1 then
    JabberJIDEdit.Text := Parse('@', JabberJIDEdit.Text, 1);
  JabberJIDEdit.Text := JabberJIDEdit.Text + (Sender as TMenuItem).Hint;
  //--Правим параметры серверов
  case (Sender as TMenuItem).Tag of
    1, 2, 5:
      begin
        JUseCustomServerSettingsCheckBox.Checked := false;
        JCustomServerHostEdit.Text := '';
        JCustomServerPortEdit.Text := '';
        JUseSSLCheckBox.Checked := false;
      end;
    3:
      begin
        JUseCustomServerSettingsCheckBox.Checked := true;
        JCustomServerHostEdit.Text := 'webim.qip.ru';
        JCustomServerPortEdit.Text := '5222';
        JUseSSLCheckBox.Checked := false;
      end;
    4:
      begin
        JUseCustomServerSettingsCheckBox.Checked := true;
        JCustomServerHostEdit.Text := 'talk.google.com';
        JCustomServerPortEdit.Text := '5223';
        JUseSSLCheckBox.Checked := true;
      end;
  end;
end;

procedure TJabberOptionsForm.SaveSettingsJabberAccount(SettingsXml: TrXML);
begin
  with SettingsXml do
    if OpenKey(StrSettingsJabberAccount, True) then
    try
      WriteString(StrKeyLogin, JabberJIDEdit.Text);
      WriteBool(StrKeySavePassword, SavePassCheckBox.Checked);
      if SavePassCheckBox.Checked then
        WriteString(StrKeyPassword, EncryptString(PassEdit.Hint, PasswordByMac))
      else WriteString(StrKeyPassword, EmptyStr);
      //--Маскируем пароль
      PassEdit.OnChange := nil;
      if PassEdit.Text <> EmptyStr then PassEdit.Text := StrPassMask;
      PassEdit.OnChange := PassEditChange;
    finally
      CloseKey;
    end;
end;

procedure TJabberOptionsForm.UpdateJabberSettings;
begin
  //--Нормализуем вводимые поля
  //Jabber логин
  JabberJIDEdit.Text := Trim(JabberJIDEdit.Text);
  JabberJIDEdit.Text := exNormalizeScreenName(JabberJIDEdit.Text);
  //Server Host
  JCustomServerHostEdit.Text := Trim(JCustomServerHostEdit.Text);
  JCustomServerHostEdit.Text := exNormalizeScreenName(JCustomServerHostEdit.Text);
  //Server Port
  JCustomServerPortEdit.Text := Trim(JCustomServerPortEdit.Text);
  JCustomServerPortEdit.Text := exNormalizeScreenName(JCustomServerPortEdit.Text);
  //--Обновляем данные логина в протоколе
  if JabberJIDEdit.Enabled then
  begin
    //--Если логин поменялся, то стираем контакты предыдущего логина.
    if JabberJIDEdit.Text <> Jabber_JID then RosterForm.ClearJabberClick(self);
    //--Логин и пароль обновляем
    Jabber_JID := JabberJIDEdit.Text;
    Jabber_LoginPassword := PassEdit.Hint;
  end;
  //--Обновляем настройки соединения
  Jabber_UseSSL := JUseSSLCheckBox.Checked;
  if JUseSSLCheckBox.Checked then
  begin
    Jabber_ServerPort := CONST_Jabber_DefaultServerSSLPort;
  end else begin
    Jabber_ServerPort := CONST_Jabber_DefaultServerNoSecurePort;
  end;
end;

procedure TJabberOptionsForm.LoadConnectionSettings(SettingsXml: TrXML);
begin
  with SettingsXml do
    if OpenKey(StrSettingsJabberConnection) then
    try
      JUseCustomServerSettingsCheckBox.Checked := ReadBool(StrKeyUseCustomServerSettings);
      JUseSSLCheckBox.Checked := ReadBool(StrKeyUseSSL);
      JCustomServerHostEdit.Text := ReadString(StrKeyServerHost);
      JCustomServerPortEdit.Text := ReadString(StrKeyServerPort);
    finally
      CloseKey;
    end;
end;

procedure TJabberOptionsForm.LoadAccountSettings(SettingsXml: TrXML);
begin
  with SettingsXml do
    if OpenKey(StrSettingsJabberAccount) then
    try
      JabberJIDEdit.Text := ReadString(StrKeyLogin);
      if JabberJIDEdit.Text <> EmptyStr then Jabber_JID := JabberJIDEdit.Text;
      SavePassCheckBox.Checked := ReadBool(StrKeySavePassword);
      //--Загружаем пароль
      PassEdit.OnChange := nil;
      PassEdit.Text := ReadString(StrKeyPassword);
      if PassEdit.Text <> EmptyStr then
      begin
        PassEdit.Hint := DecryptString(PassEdit.Text, PasswordByMac);
        Jabber_LoginPassword := PassEdit.Hint;
        PassEdit.Text := StrPassMask;
      end;
      PassEdit.OnChange := PassEditChange;
    finally
      CloseKey;
    end;
end;

procedure TJabberOptionsForm.CancelButtonClick(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TJabberOptionsForm.FormCreate(Sender: TObject);
begin
  //--Переводим форму на другие языки
  TranslateForm;
  //--Загружаем настройки
  LoadSettings;
  //активизируем их
  UpdateJabberSettings;
  //--Деактивируем кнопку "применить"
  ApplyButton.Enabled := false;
  //--Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(43, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TJabberOptionsForm.FormShow(Sender: TObject);
begin
  OptionJvPageList.ActivePage := AccountPage;
  JabberOptionButtonGroup.ItemIndex := 0;
end;

procedure TJabberOptionsForm.JabberSomeEditChange(Sender: TObject);
begin
  //--Активируем кнопку применения настроек
  ApplyButton.Enabled := true;
end;

procedure TJabberOptionsForm.JabberOptionButtonGroupButtonClicked(
  Sender: TObject; Index: Integer);
begin
  //--Выбираем страницу настроек соответсвенно выбранной вкладке
  if Index <= OptionJvPageList.PageCount then OptionJvPageList.ActivePageIndex := Index;
end;

procedure TJabberOptionsForm.JUseCustomServerSettingsCheckBoxClick(Sender: TObject);
begin
  JCustomServerHostEdit.Enabled := JUseCustomServerSettingsCheckBox.Checked;
  JCustomServerPortEdit.Enabled := JUseCustomServerSettingsCheckBox.Checked;
  JabberSomeEditChange(nil);
end;

procedure TJabberOptionsForm.JIDonserverLabelClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  //--Выводим меню настройки на серверы
  GetCursorPos(FCursor);
  JServerPopupMenu.Popup(FCursor.X, FCursor.Y);
end;

procedure TJabberOptionsForm.JIDonserverLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clBlue;
end;

procedure TJabberOptionsForm.JIDonserverLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clNavy;
end;

procedure TJabberOptionsForm.OKButtonClick(Sender: TObject);
begin
  //--Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then ApplySettings;
  Close;
end;

procedure TJabberOptionsForm.PassEditChange(Sender: TObject);
begin
  PassEdit.Hint := PassEdit.Text;
  //--Активируем кнопку применения настроек
  ApplyButton.Enabled := true;
end;

procedure TJabberOptionsForm.PassEditClick(Sender: TObject);
begin
  //--Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = StrPassMask then PassEdit.Text := EmptyStr;
end;

procedure TJabberOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
begin
  //--Отменяем событие изменения поля пароля
  PassEdit.OnChange := nil;
  //--Показываем пароль в поле ввода пароля
  if ShowPassCheckBox.Checked then PassEdit.PasswordChar := #0
  else PassEdit.PasswordChar := '*';
  //--Восстанавливаем событие изменения поля пароля
  PassEdit.OnChange := PassEditChange;
end;

end.

