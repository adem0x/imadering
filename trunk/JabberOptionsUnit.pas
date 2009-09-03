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
  JvExControls, rXML;

type
  TJabberOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    JabberOptionButtonGroup: TButtonGroup;
    Panel1: TPanel;
    JvPageList1: TJvPageList;
    JvStandardPage1: TJvStandardPage;
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
    GroupBox1: TGroupBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JIDonserverLabelMouseEnter(Sender: TObject);
    procedure JIDonserverLabelMouseLeave(Sender: TObject);
    procedure JabberJIDEditChange(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadSettings;
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
  MainUnit, JabberProtoUnit, Code, SettingsUnit, UtilsUnit, VarsUnit;

procedure TJabberOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  //--Применяем настройки
  ApplySettings;
end;

//--APPLY SETTINGS--------------------------------------------------------------

procedure TJabberOptionsForm.ApplySettings;
begin
  //--Применяем настройки Jabber протокола
  //--Нормализуем Jabber логин
  JabberJIDEdit.Text := Trim(JabberJIDEdit.Text);
  JabberJIDEdit.Text := exNormalizeScreenName(JabberJIDEdit.Text);
  //--Обновляем данные логина в протоколе
  if JabberJIDEdit.Enabled then
  begin
    Jabber_JID := JabberJIDEdit.Text;
    if PassEdit.Text <> '----------------------' then
    begin
      PassEdit.Hint := PassEdit.Text;
      Jabber_LoginPassword := PassEdit.Hint;
    end;
  end;
  //----------------------------------------------------------------------------
  //--Записываем настройки Jabber протокола в файл
  with TrXML.Create() do
  try
    if FileExists(ProfilePath + SettingsFileName) then LoadFromFile(ProfilePath + SettingsFileName);
    if OpenKey('settings\jabber\account', True) then
    try
      WriteString('login', JabberJIDEdit.Text);
      WriteBool('save-password', SavePassCheckBox.Checked);
      if SavePassCheckBox.Checked then
        WriteString('password', Encrypt(PassEdit.Hint, PassKey))
      else WriteString('password', EmptyStr);
      //--Маскируем пароль
      if PassEdit.Text <> EmptyStr then PassEdit.Text := '----------------------';
    finally
      CloseKey();
    end;
    SaveToFile(ProfilePath + SettingsFileName);
  finally
    Free();
  end;
  //--Деактивируем кнопку применения настроек
  ApplyButton.Enabled := false;
end;

//--LOAD SETTINGS---------------------------------------------------------------

procedure TJabberOptionsForm.LoadSettings;
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    if FileExists(ProfilePath + SettingsFileName) then
    begin
      LoadFromFile(ProfilePath + SettingsFileName);
      //--Загружаем данные логина
      if OpenKey('settings\jabber\account') then
      try
        JabberJIDEdit.Text := ReadString('login');
        if JabberJIDEdit.Text <> EmptyStr then Jabber_JID := JabberJIDEdit.Text;
        SavePassCheckBox.Checked := ReadBool('save-password');
        PassEdit.Text := ReadString('password');
        if PassEdit.Text <> EmptyStr then
        begin
          PassEdit.Hint := Decrypt(PassEdit.Text, PassKey);
          Jabber_LoginPassword := PassEdit.Hint;
          PassEdit.Text := '----------------------';
        end;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

procedure TJabberOptionsForm.TranslateForm;
begin
  //--Переводим форму на другие языки

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

procedure TJabberOptionsForm.JabberJIDEditChange(Sender: TObject);
begin
  //--Активируем кнопку применения настроек
  ApplyButton.Enabled := true;
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

procedure TJabberOptionsForm.PassEditClick(Sender: TObject);
begin
  //--Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = '----------------------' then PassEdit.Text := EmptyStr;
end;

procedure TJabberOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
begin
  //--Отменяем событие изменения поля пароля
  PassEdit.OnChange := nil;
  //--Показываем пароль в поле ввода пароля
  if ShowPassCheckBox.Checked then PassEdit.PasswordChar := #0
  else PassEdit.PasswordChar := '*';
  //--Восстанавливаем событие изменения поля пароля
  PassEdit.OnChange := JabberJIDEditChange;
end;

end.
