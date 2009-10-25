{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit SettingsUnit;

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
  JvPageList,
  JvExControls,
  ExtCtrls,
  ButtonGroup,
  StdCtrls,
  Buttons,
  RXml,
  OverbyteIcsWndControl,
  OverbyteIcsWSocket,
  OverbyteIcsHttpProt,
  Registry,
  ComCtrls,
  ImgList,
  JvExForms,
  JvCustomItemViewer,
  JvImageListViewer;

type
  TSettingsForm = class(TForm)
    SettingButtonGroup: TButtonGroup;
    PagesPanel: TPanel;
    SettingsJvPageList: TJvPageList;
    General: TJvStandardPage;
    CL: TJvStandardPage;
    Chat: TJvStandardPage;
    Events: TJvStandardPage;
    GlobalProxy: TJvStandardPage;
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    ApplyBitBtn: TBitBtn;
    GeneralOptionGroupBox: TGroupBox;
    CLWindowGroupBox: TGroupBox;
    ChatFormGroupBox: TGroupBox;
    EventsGroupBox: TGroupBox;
    GroupBox5: TGroupBox;
    ProxyAddressEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ProxyPortEdit: TEdit;
    ProxyTypeComboBox: TComboBox;
    Label3: TLabel;
    ProxyVersionComboBox: TComboBox;
    Label4: TLabel;
    ProxyAuthCheckBox: TCheckBox;
    ProxyLoginEdit: TEdit;
    ProxyPasswordEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    ProxyShowPassCheckBox: TCheckBox;
    ProxyEnableCheckBox: TCheckBox;
    NTLMCheckBox: TCheckBox;
    GroupBox6: TGroupBox;
    ReconnectCheckBox: TCheckBox;
    HideInTrayProgramStartCheckBox: TCheckBox;
    StartOnWinStartCheckBox: TCheckBox;
    AutoUpdateCheckBox: TCheckBox;
    TransparentGroupBox: TGroupBox;
    HeadTextGroupBox: TGroupBox;
    CLOptionsGroupBox: TGroupBox;
    AlwaylTopCheckBox: TCheckBox;
    TransparentTrackBar: TTrackBar;
    TransparentNotActiveCheckBox: TCheckBox;
    AutoHideCLCheckBox: TCheckBox;
    AutoHideClEdit: TEdit;
    HeaderTextEdit: TEdit;
    History: TJvStandardPage;
    Statuses: TJvStandardPage;
    AntiSpam: TJvStandardPage;
    Sounds: TJvStandardPage;
    Themes: TJvStandardPage;
    HotKeys: TJvStandardPage;
    Plugins: TJvStandardPage;
    Accounts: TJvStandardPage;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    ProtocolsGroupBox: TGroupBox;
    ProtocolsListView: TListView;
    AddProtoBitBtn: TBitBtn;
    SettingsProtoBitBtn: TBitBtn;
    DeleteProtoBitBtn: TBitBtn;
    GroupBox10: TGroupBox;
    ProfilePathEdit: TEdit;
    ProfilePathLabel: TLabel;
    ProfilePathSpeedButton: TSpeedButton;
    PluginsJvImageList: TJvImageListViewer;
    ShowPluginConfigButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SettingButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure ApplyBitBtnClick(Sender: TObject);
    procedure ProxyAuthCheckBoxClick(Sender: TObject);
    procedure ProxyShowPassCheckBoxClick(Sender: TObject);
    procedure ProxyEnableCheckBoxClick(Sender: TObject);
    procedure ProxyAddressEditChange(Sender: TObject);
    procedure ProxyTypeComboBoxSelect(Sender: TObject);
    procedure TransparentTrackBarChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure AutoHideClEditKeyPress(Sender: TObject; var Key: Char);
    procedure AutoHideClEditExit(Sender: TObject);
    procedure AddProtoBitBtnClick(Sender: TObject);
    procedure DeleteProtoBitBtnClick(Sender: TObject);
    procedure ProtocolsListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure SettingButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ProtocolsListViewClick(Sender: TObject);
    procedure ProtocolsListViewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SettingsProtoBitBtnClick(Sender: TObject);
    procedure ProtocolsListViewDblClick(Sender: TObject);
    procedure ProfilePathSpeedButtonClick(Sender: TObject);

  private
    { Private declarations }
    procedure LoadSettings;
    procedure TranslateForm;

  public
    { Public declarations }
    procedure ApplySettings;
    procedure ApplyProxyHttpClient(HttpClient: THttpCli);
    procedure ApplyProxySocketClient(SocketClient: TWSocket);
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  VarsUnit,
  IcqOptionsUnit,
  JvBrowseFolder,
  UtilsUnit,
  OverbyteIcsMimeUtils;

procedure DoAppToRun(RunName, AppName: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      WriteString(RunName, AppName);
      CloseKey;
      Free;
    end;
end;

function IsAppInRun(RunName: string): Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
      Result := ValueExists(RunName);
      CloseKey;
      Free;
    end;
end;

procedure DelAppFromRun(RunName: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
    begin
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      if ValueExists(RunName) then
        DeleteValue(RunName);
      CloseKey;
      Free;
    end;
end;

procedure TSettingsForm.LoadSettings;
var
  ListItemD: TListItem;
begin
  // Считываем настройки из xml файла
  if FileExists(ProfilePath + SettingsFileName) then
    begin
      with TrXML.Create() do
        try
          LoadFromFile(ProfilePath + SettingsFileName);
          // Загружаем и отображаем настройки прокси
          if OpenKey('settings\proxy\address') then
            try
              ProxyAddressEdit.Text := ReadString('host');
              ProxyPortEdit.Text := ReadString('port');
            finally
              CloseKey();
            end;
          if OpenKey('settings\proxy\type') then
            try
              ProxyTypeComboBox.ItemIndex := ReadInteger('type-index');
              ProxyVersionComboBox.ItemIndex := ReadInteger('version-index');
            finally
              CloseKey();
            end;
          if OpenKey('settings\proxy\auth') then
            try
              ProxyAuthCheckBox.Checked := ReadBool('auth-enable');
              ProxyLoginEdit.Text := ReadString('login');
              ProxyPasswordEdit.Text := Base64Decode(ReadString('password'));
              NTLMCheckBox.Checked := ReadBool('ntlm-auth');
            finally
              CloseKey();
            end;
          if OpenKey('settings\proxy\main') then
            try
              ProxyEnableCheckBox.Checked := ReadBool('enable');
              ProxyEnableCheckBoxClick(nil);
            finally
              CloseKey();
            end;
          // ----------------------------------------------------------------------
          // Загружаем и отображаем другие настройки
          if OpenKey('settings\main\hide-in-tray-program-start') then
            try
              // Загружаем запуск свёрнутой в трэй
              HideInTrayProgramStartCheckBox.Checked := ReadBool('value');
              // Загружаем автозапуск при старте Windows
              StartOnWinStartCheckBox.Checked := IsAppInRun('IMadering');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\auto-update-check') then
            try
              // Загружаем проверять наличие новой версии при запуске
              AutoUpdateCheckBox.Checked := ReadBool('value');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\always-top') then
            try
              // Загружаем поверх всех окон
              AlwaylTopCheckBox.Checked := ReadBool('value');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\transparent-value') then
            try
              // Загружаем настройки прозрачности списка контактов
              TransparentTrackBar.Position := ReadInteger('value');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\transparent-active') then
            try
              // Загружаем прозрачность неактивноно окна списка контактов
              TransparentNotActiveCheckBox.Checked := ReadBool('value');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\auto-hide-cl') then
            try
              // Загружаем автоскрытие списка контактов
              AutoHideCLCheckBox.Checked := ReadBool('value');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\auto-hide-cl-value') then
            try
              // Загружаем автоскрытие списка контактов
              AutoHideClEdit.Text := ReadString('value');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\header-cl-form') then
            try
              // Загружаем заголовок окна списка контактов
              HeaderTextEdit.Text := ReadString('text');
            finally
              CloseKey();
            end;
          if OpenKey('settings\main\reconnect') then
            try
              // Загружаем пересоединение при разрыве соединения
              ReconnectCheckBox.Checked := ReadBool('value');
            finally
              CloseKey();
            end;
        finally
          Free();
        end;
    end;
  // Устанавливаем галочки включенных протоколов
  ProtocolsListView.Clear;
  ProtocolsListView.Items.BeginUpdate;
  // Добавляем ICQ протокол
  ListItemD := ProtocolsListView.Items.Add;
  ListItemD.Checked := MainForm.ICQToolButton.Visible;
  if Assigned(IcqOptionsForm) then
    ListItemD.Caption := 'ICQ: ' + IcqOptionsForm.ICQUINEdit.Text
  else
    ListItemD.Caption := 'ICQ:';
  ListItemD.ImageIndex := 81;
  // Добавляем MRA протокол
  ListItemD := ProtocolsListView.Items.Add;
  ListItemD.Checked := MainForm.MRAToolButton.Visible;
  ListItemD.Caption := 'MRA:';
  ListItemD.ImageIndex := 66;
  // Добавляем Jabber протокол
  ListItemD := ProtocolsListView.Items.Add;
  ListItemD.Checked := MainForm.JabberToolButton.Visible;
  ListItemD.Caption := 'Jabber:';
  ListItemD.ImageIndex := 43;
  ProtocolsListView.Items.EndUpdate;
end;

// Apply Settings--------------------------------------------------------------

procedure TSettingsForm.ApplySettings;
begin
  // Применяем настройки профиля
  if AnsiCompareText(ProfilePath, ProfilePathEdit.Text) <> 0 then
    begin
      // Попробуем скопировать
      if CopyDir(ProfilePath + 'Profile', ProfilePathEdit.Text + 'Profile') then
        begin
          // Спрашиваем удалять профиль или нет
          if MessageBox(Handle, PChar(DelProfile), PChar('IMadering'), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
            ClearDir(ProfilePath + 'Profile', True);
          // Изменяем путь
          ProfilePath := ProfilePathEdit.Text;
          // Сохраняем путь к профилю
          with TRegistry.Create do
            try
              if OpenKey(ProgramKey, True) then
                WriteString(CProfile, ProfilePath);
            finally
              Free;
            end;
        end;
    end;
  // Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile\');
  ForceDirectories(ProfilePath + HistoryFileName);
  ForceDirectories(ProfilePath + AvatarFileName);
  ForceDirectories(ProfilePath + AnketaFileName);
  // Применяем настройки прокси
  with MainForm do
    begin
      // HTTP сокет для обновлений программы
      if UpdateHttpClient.State <> HttpConnected then
        begin
          UpdateHttpClient.Abort;
          ApplyProxyHttpClient(UpdateHttpClient);
        end;
      // HTTP сокет для аватар MRA протокола
      if MRAAvatarHttpClient.State <> HttpConnected then
        begin
          MRAAvatarHttpClient.Abort;
          ApplyProxyHttpClient(MRAAvatarHttpClient);
        end;
      // Сокет для протокола ICQ
      if ICQWSocket.State <> WsConnected then
        begin
          ICQWSocket.Abort;
          ApplyProxySocketClient(ICQWSocket);
        end;
      // Сокет для аватар ICQ
      if ICQAvatarWSocket.State <> WsConnected then
        begin
          ICQAvatarWSocket.Abort;
          ApplyProxySocketClient(ICQAvatarWSocket);
        end;
      // Сокет для протокола MRA
      if MRAWSocket.State <> WsConnected then
        begin
          MRAWSocket.Abort;
          ApplyProxySocketClient(MRAWSocket);
        end;
      // Сокет для протокла Jabber
      if JabberWSocket.State <> WsConnected then
        begin
          JabberWSocket.Abort;
          ApplyProxySocketClient(JabberWSocket);
        end;
    end;
  // --------------------------------------------------------------------------
  // Применяем общие настройки
  // Если "Запускать при старте системы", то ставим это в реестре
  if StartOnWinStartCheckBox.Checked then
    DoAppToRun('IMadering', MyPath + 'Imadering.exe')
  else
    DelAppFromRun('IMadering');
  // Применяем настройки для списка контактов
  if AlwaylTopCheckBox.Checked then
    MainForm.FormStyle := FsStayOnTop
  else
    MainForm.FormStyle := FsNormal;
  // Применяем настройки прозрачности
  if TransparentTrackBar.Position > 0 then
    begin
      RoasterAlphaBlend := True;
      MainForm.AlphaBlend := True;
      RoasterAlphaValue := 255 - TransparentTrackBar.Position;
    end
  else
    begin
      RoasterAlphaBlend := False;
      MainForm.AlphaBlend := False;
      MainForm.AlphaBlendValue := 255;
      RoasterAlphaValue := 255;
    end;
  AlphaBlendInactive := TransparentNotActiveCheckBox.Checked;
  // Применяем настройки автоскрытия списка контактов
  MainForm.JvTimerList.Events[6].Enabled := AutoHideCLCheckBox.Checked;
  MainForm.JvTimerList.Events[6].Interval := (StrToInt(AutoHideClEdit.Text) * 1000);
  // Применяем настройку залоговка окна списка контактов
  MainForm.Caption := HeaderTextEdit.Text;
  // --------------------------------------------------------------------------
  // Записываем настройки
  if ApplyBitBtn.Enabled then
    begin
      if not NoReSave then // Если разрешена перезапись настроек
        begin
          with TrXML.Create() do
            try
              if FileExists(ProfilePath + SettingsFileName) then
                LoadFromFile(ProfilePath + SettingsFileName);
              // Записываем настройки прокси
              if OpenKey('settings\proxy\main', True) then
                try
                  WriteBool('enable', ProxyEnableCheckBox.Checked);
                finally
                  CloseKey();
                end;
              if OpenKey('settings\proxy\address', True) then
                try
                  WriteString('host', ProxyAddressEdit.Text);
                  WriteString('port', ProxyPortEdit.Text);
                finally
                  CloseKey();
                end;
              if OpenKey('settings\proxy\type', True) then
                try
                  WriteString('type', ProxyTypeComboBox.Text);
                  WriteInteger('type-index', ProxyTypeComboBox.ItemIndex);
                  WriteString('version', ProxyVersionComboBox.Text);
                  WriteInteger('version-index', ProxyVersionComboBox.ItemIndex);
                finally
                  CloseKey();
                end;
              if OpenKey('settings\proxy\auth', True) then
                try
                  WriteBool('auth-enable', ProxyAuthCheckBox.Checked);
                  WriteString('login', ProxyLoginEdit.Text);
                  WriteString('password', Base64Encode(ProxyPasswordEdit.Text));
                  WriteBool('ntlm-auth', NTLMCheckBox.Checked);
                finally
                  CloseKey();
                end;
              // --------------------------------------------------------------------
              // Сохраняем запуск свёрнутой в трэй
              if OpenKey('settings\main\hide-in-tray-program-start', True) then
                try
                  WriteBool('value', HideInTrayProgramStartCheckBox.Checked);
                finally
                  CloseKey();
                end;
              // Сохраняем пересоединяться при разрыве соединения
              if OpenKey('settings\main\reconnect', True) then
                try
                  WriteBool('value', ReconnectCheckBox.Checked);
                finally
                  CloseKey();
                end;
              // Сохраняем проверять наличие новой версии при запуске
              if OpenKey('settings\main\auto-update-check', True) then
                try
                  WriteBool('value', AutoUpdateCheckBox.Checked);
                finally
                  CloseKey();
                end;
              // Сохраняем поверх всех окон
              if OpenKey('settings\main\always-top', True) then
                try
                  WriteBool('value', AlwaylTopCheckBox.Checked);
                finally
                  CloseKey();
                end;
              // Сохраняем настройки прозрачности списка контактов
              if OpenKey('settings\main\transparent-value', True) then
                try
                  WriteInteger('value', TransparentTrackBar.Position);
                finally
                  CloseKey();
                end;
              // Сохраняем прозрачность неактивноно окна списка контактов
              if OpenKey('settings\main\transparent-active', True) then
                try
                  WriteBool('value', TransparentNotActiveCheckBox.Checked);
                finally
                  CloseKey();
                end;
              // Сохраняем автоскрытие списка контактов
              if OpenKey('settings\main\auto-hide-cl', True) then
                try
                  WriteBool('value', AutoHideCLCheckBox.Checked);
                finally
                  CloseKey();
                end;
              if OpenKey('settings\main\auto-hide-cl-value', True) then
                try
                  WriteString('value', AutoHideClEdit.Text);
                finally
                  CloseKey();
                end;
              // Сохраняем заголовок окна списка контактов
              if OpenKey('settings\main\header-cl-form', True) then
                try
                  WriteString('text', HeaderTextEdit.Text);
                finally
                  CloseKey();
                end;
              SaveToFile(ProfilePath + SettingsFileName);
            finally
              Free();
            end;
        end;
    end;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
end;

procedure TSettingsForm.AutoHideClEditExit(Sender: TObject);
begin
  // Если ввод пустой, то ставим по дефолту
  if AutoHideClEdit.Text = EmptyStr then
    AutoHideClEdit.Text := '10';
end;

procedure TSettingsForm.AutoHideClEditKeyPress(Sender: TObject; var Key: Char);
const
  ValidAsciiChars = ['0' .. '9'];
begin
  // Делаем так, что вводить можно только цифры
  if (not(Key in ValidAsciiChars)) and (Key <> #8) then
    Key := #0;
end;

procedure TSettingsForm.CancelBitBtnClick(Sender: TObject);
begin
  // Закрываем окно настроек
  Close;
end;

procedure TSettingsForm.DeleteProtoBitBtnClick(Sender: TObject);
begin
  // В будущем удаляем протоколы в активный список
  ShowMessage(DevelMess);
end;

procedure TSettingsForm.OKBitBtnClick(Sender: TObject);
begin
  // Применяем настройки
  NoReSave := False;
  ApplySettings;
  // Закрываем окно настроек
  Close;
end;

procedure TSettingsForm.AddProtoBitBtnClick(Sender: TObject);
begin
  // В будущем добавляем протоколы в активный список
  ShowMessage(DevelMess);
end;

procedure TSettingsForm.ApplyBitBtnClick(Sender: TObject);
begin
  // Применяем настройки
  NoReSave := False;
  ApplySettings;
end;

procedure TSettingsForm.SettingButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= SettingsJvPageList.PageCount then
    SettingsJvPageList.ActivePageIndex := index;
end;

procedure TSettingsForm.SettingButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if SettingButtonGroup.ItemIndex <= SettingsJvPageList.PageCount then
    SettingsJvPageList.ActivePageIndex := SettingButtonGroup.ItemIndex;
end;

procedure TSettingsForm.SettingsProtoBitBtnClick(Sender: TObject);
begin
  // Открываем окно настройки выбранного протокола
  if ProtocolsListView.Selected.index = 0 then
    MainForm.ICQSettingsClick(Self)
  else if ProtocolsListView.Selected.index = 1 then
    MainForm.MRASettingsClick(Self)
  else if ProtocolsListView.Selected.index = 2 then
    MainForm.JabberSettingsClick(Self);
end;

procedure TSettingsForm.ProfilePathSpeedButtonClick(Sender: TObject);
var
  DDir: string;
begin
  DDir := ProfilePathEdit.Text;
  // Открываем диалог выбора папки
  if BrowseForFolder(SelectDirL, True, DDir) then
    begin
      // Если выбрана не папка, то выходим
      if BMSearch(0, DDir, ':\') = -1 then
        Exit;
      // Правим слэш для выбранной папки
      if Length(DDir) > 3 then
        ProfilePathEdit.Text := DDir + '\'
      else
        ProfilePathEdit.Text := DDir;
      ProxyAddressEditChange(Self);
    end;
end;

procedure TSettingsForm.ProtocolsListViewClick(Sender: TObject);
begin
  // Управляем включением и отключением протоколов
  // ICQ
  if (not ProtocolsListView.Items[0].Checked) and (MainForm.ICQToolButton.Visible) then
    MainForm.ICQEnable(False)
  else if (ProtocolsListView.Items[0].Checked) and (not MainForm.ICQToolButton.Visible) then
    MainForm.ICQEnable(True);
  // MRA
  if (not ProtocolsListView.Items[1].Checked) and (MainForm.MRAToolButton.Visible) then
    MainForm.MRAEnable(False)
  else if (ProtocolsListView.Items[1].Checked) and (not MainForm.MRAToolButton.Visible) then
    MainForm.MRAEnable(True);
  // Jabber
  if (not ProtocolsListView.Items[2].Checked) and (MainForm.JabberToolButton.Visible) then
    MainForm.JabberEnable(False)
  else if (ProtocolsListView.Items[2].Checked) and (not MainForm.JabberToolButton.Visible) then
    MainForm.JabberEnable(True);
end;

procedure TSettingsForm.ProtocolsListViewDblClick(Sender: TObject);
begin
  // Если двойной клик то выполняем тоже самое что и при динарном
  ProtocolsListViewClick(Self);
end;

procedure TSettingsForm.ProtocolsListViewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Если клавишей пробел мы включаем и отключаем протоколы, то запускаем событие по клику на галочку
  if Key = 32 then
    ProtocolsListViewClick(Self);
end;

procedure TSettingsForm.ProtocolsListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  // Активируем или деактивируем кнопку настроек протокола
  if Selected then
    SettingsProtoBitBtn.Enabled := True
  else
    SettingsProtoBitBtn.Enabled := False;
end;

procedure TSettingsForm.ProxyAddressEditChange(Sender: TObject);
begin
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
end;

procedure TSettingsForm.ProxyAuthCheckBoxClick(Sender: TObject);
begin
  // Управляем контролами авторизации на прокси
  if ProxyAuthCheckBox.Checked then
    begin
      ProxyLoginEdit.Enabled := True;
      ProxyLoginEdit.Color := ClWindow;
      ProxyPasswordEdit.Enabled := True;
      ProxyPasswordEdit.Color := ClWindow;
      NTLMCheckBox.Enabled := True;
    end
  else
    begin
      ProxyLoginEdit.Enabled := False;
      ProxyLoginEdit.Color := ClBtnFace;
      ProxyPasswordEdit.Enabled := False;
      ProxyPasswordEdit.Color := ClBtnFace;
      NTLMCheckBox.Enabled := False;
    end;
  // Активируем кнопку применения настроек
  ApplyBitBtn.Enabled := True;
end;

procedure TSettingsForm.ProxyEnableCheckBoxClick(Sender: TObject);
begin
  // Разрешаем использование прокси
  if ProxyEnableCheckBox.Checked then
    begin
      ProxyAddressEdit.Enabled := True;
      ProxyAddressEdit.Color := ClWindow;
      ProxyPortEdit.Enabled := True;
      ProxyPortEdit.Color := ClWindow;
      ProxyTypeComboBox.Enabled := True;
      ProxyTypeComboBox.Color := ClWindow;
      ProxyVersionComboBox.Enabled := True;
      ProxyVersionComboBox.Color := ClWindow;
      ProxyAuthCheckBox.Enabled := True;
      if ProxyAuthCheckBox.Checked then
        begin
          ProxyLoginEdit.Enabled := True;
          ProxyLoginEdit.Color := ClWindow;
          ProxyPasswordEdit.Enabled := True;
          ProxyPasswordEdit.Color := ClWindow;
          NTLMCheckBox.Enabled := True;
        end;
      ProxyShowPassCheckBox.Enabled := True;
    end
  else
    begin
      ProxyAddressEdit.Enabled := False;
      ProxyAddressEdit.Color := ClBtnFace;
      ProxyPortEdit.Enabled := False;
      ProxyPortEdit.Color := ClBtnFace;
      ProxyTypeComboBox.Enabled := False;
      ProxyTypeComboBox.Color := ClBtnFace;
      ProxyVersionComboBox.Enabled := False;
      ProxyVersionComboBox.Color := ClBtnFace;
      ProxyAuthCheckBox.Enabled := False;
      if ProxyAuthCheckBox.Checked then
        begin
          ProxyLoginEdit.Enabled := False;
          ProxyLoginEdit.Color := ClBtnFace;
          ProxyPasswordEdit.Enabled := False;
          ProxyPasswordEdit.Color := ClBtnFace;
          NTLMCheckBox.Enabled := False;
        end;
      ProxyShowPassCheckBox.Enabled := False;
    end;
  // Активируем кнопку применения настроек
  ApplyBitBtn.Enabled := True;
end;

procedure TSettingsForm.ProxyShowPassCheckBoxClick(Sender: TObject);
begin
  // Показываем пароль логина к прокси
  if ProxyShowPassCheckBox.Checked then
    ProxyPasswordEdit.PasswordChar := #0
  else
    ProxyPasswordEdit.PasswordChar := '*';
end;

procedure TSettingsForm.ProxyTypeComboBoxSelect(Sender: TObject);
begin
  // Автоматически заполняем порт прокси
  case ProxyTypeComboBox.ItemIndex of
    0: ProxyPortEdit.Text := '80';
    1: ProxyPortEdit.Text := '443';
  else ProxyPortEdit.Text := EmptyStr;
  end;
end;

procedure TSettingsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Возвращаем действующее значение прозрачности списку контактов
  MainForm.AlphaBlendValue := RoasterAlphaValue;
  MainForm.AlphaBlend := RoasterAlphaBlend;
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем настройки
  LoadSettings;
  ProxyTypeComboBox.OnSelect := ProxyTypeComboBoxSelect;
  // Устанавливаем перевод
  TranslateForm;
  // Путь к профилю
  ProfilePathEdit.Text := ProfilePath;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;

  // Видимо  баг в JVCL. Приходится указывать в коде еще раз...
  PluginsJvImageList.Options.ShowCaptions := True;
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  // Устанавливаем иконку окна
  MainForm.AllImageList.GetIcon(2, Icon);
  // Устанавливаем иконки на кнопки
  MainForm.AllImageList.GetBitmap(3, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(186, AddProtoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(2, SettingsProtoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(139, DeleteProtoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(227, ProfilePathSpeedButton.Glyph);
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  ProxyTypeComboBox.OnSelect := ProxyTypeComboBoxSelect;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
  // Становимся на первую вкладку
  SettingsJvPageList.ActivePageIndex := 0;
  SettingButtonGroup.ItemIndex := 0;
end;

procedure TSettingsForm.TransparentTrackBarChange(Sender: TObject);
begin
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
  // Активируем режим прозрачности у списка контактов
  MainForm.AlphaBlend := True;
  MainForm.AlphaBlendValue := 255 - TransparentTrackBar.Position;
end;

procedure TSettingsForm.TranslateForm;
begin
  // Переводим форму на другие языки

end;

procedure TSettingsForm.ApplyProxyHttpClient(HttpClient: THttpCli);
begin
  with HttpClient do
    begin
      // Применяем настройки прокси
      if ProxyEnableCheckBox.Checked then
        begin
          // Версия запроов
          RequestVer := ProxyVersionComboBox.Text;
          // HTTP и HTTPS тип прокси
          if (ProxyTypeComboBox.ItemIndex = 0) or (ProxyTypeComboBox.ItemIndex = 1) then
            begin
              // Сбрасываем тип SOCKS прокси
              SocksLevel := EmptyStr;
              // Сбрасываем адрес SOCKS прокси и порт
              SocksServer := EmptyStr;
              SocksPort := EmptyStr;
              // Сбрасываем авторизацию SOCKS прокси
              SocksAuthentication := SocksNoAuthentication;
              SocksUsercode := EmptyStr;
              SocksPassword := EmptyStr;
              // Назначаем адрес HTTP прокси и порт
              Proxy := ProxyAddressEdit.Text;
              ProxyPort := ProxyPortEdit.Text;
              // Назначаем авторизацию на HTTP прокси
              if ProxyAuthCheckBox.Checked then
                begin
                  ProxyAuth := HttpAuthBasic;
                  if NTLMCheckBox.Checked then
                    ProxyAuth := HttpAuthNtlm;
                  ProxyUsername := ProxyLoginEdit.Text;
                  ProxyPassword := ProxyPasswordEdit.Text;
                end
              else
                begin
                  // Сбрасываем авторизацию HTTP прокси
                  ProxyAuth := HttpAuthNone;
                  ProxyUsername := EmptyStr;
                  ProxyPassword := EmptyStr;
                end;
            end
          else
            begin
              // Сбрасываем адрес HTTP прокси и порт
              Proxy := EmptyStr;
              ProxyPort := '80';
              // Сбрасываем авторизацию HTTP прокси
              ProxyAuth := HttpAuthNone;
              ProxyUsername := EmptyStr;
              ProxyPassword := EmptyStr;
              // SOCKS4, SOCKS4A и SOCKS5 тип прокси
              case ProxyTypeComboBox.ItemIndex of
                2: SocksLevel := '4';
                3: SocksLevel := '4A';
                4: SocksLevel := '5';
              end;
              // Назначаем адрес SOCKS прокси и порт
              SocksServer := ProxyAddressEdit.Text;
              SocksPort := ProxyPortEdit.Text;
              // Назначаем авторизацию на SOCKS прокси
              if ProxyAuthCheckBox.Checked then
                begin
                  SocksAuthentication := SocksAuthenticateUsercode;
                  SocksUsercode := ProxyLoginEdit.Text;
                  SocksPassword := ProxyPasswordEdit.Text;
                end
              else
                begin
                  // Сбрасываем авторизацию SOCKS прокси
                  SocksAuthentication := SocksNoAuthentication;
                  SocksUsercode := EmptyStr;
                  SocksPassword := EmptyStr;
                end;
            end;
        end
      else
        begin
          // Сбрасываем версию запросов
          RequestVer := '1.0';
          // Сбрасываем адрес HTTP прокси и порт
          Proxy := EmptyStr;
          ProxyPort := '80';
          // Сбрасываем авторизацию HTTP прокси
          ProxyAuth := HttpAuthNone;
          ProxyUsername := EmptyStr;
          ProxyPassword := EmptyStr;
          // Сбрасываем тип SOCKS прокси
          SocksLevel := EmptyStr;
          // Сбрасываем адрес SOCKS прокси и порт
          SocksServer := EmptyStr;
          SocksPort := EmptyStr;
          // Сбрасываем авторизацию SOCKS прокси
          SocksAuthentication := SocksNoAuthentication;
          SocksUsercode := EmptyStr;
          SocksPassword := EmptyStr;
        end;
    end;
end;

procedure TSettingsForm.ApplyProxySocketClient(SocketClient: TWSocket);
begin
  with SocketClient do
    begin
      // Применяем настройки прокси
      if ProxyEnableCheckBox.Checked then
        begin
          // HTTP и HTTPS тип прокси
          if (ProxyTypeComboBox.ItemIndex = 0) or (ProxyTypeComboBox.ItemIndex = 1) then
            begin
              // Сбрасываем тип SOCKS прокси
              SocksLevel := '5';
              // Сбрасываем адрес SOCKS прокси и порт
              SocksServer := EmptyStr;
              SocksPort := EmptyStr;
              // Сбрасываем авторизацию SOCKS прокси
              SocksAuthentication := SocksNoAuthentication;
              SocksUsercode := EmptyStr;
              SocksPassword := EmptyStr;
              // Ставим флаг, что для сокета активен режим через HTTP прокси
              HttpProxy_Enable := True;
              // Назначаем адрес HTTP прокси и порт
              HttpProxy_Address := ProxyAddressEdit.Text;
              HttpProxy_Port := ProxyPortEdit.Text;
              // Назначаем авторизацию на HTTP прокси
              if ProxyAuthCheckBox.Checked then
                begin
                  HttpProxy_Auth := True;
                  HttpProxy_Login := ProxyLoginEdit.Text;
                  HttpProxy_Password := ProxyPasswordEdit.Text;
                end
              else
                begin
                  // Сбрасываем авторизацию HTTP прокси
                  HttpProxy_Auth := False;
                  HttpProxy_Login := EmptyStr;
                  HttpProxy_Password := EmptyStr;
                end;
            end
          else
            begin
              // Убираем флаг, что для сокета активен режим через HTTP прокси
              HttpProxy_Enable := False;
              // Сбрасываем адрес HTTP прокси и порт
              HttpProxy_Address := EmptyStr;
              HttpProxy_Port := EmptyStr;
              // Сбрасываем авторизацию HTTP прокси
              HttpProxy_Auth := False;
              HttpProxy_Login := EmptyStr;
              HttpProxy_Password := EmptyStr;
              // SOCKS4, SOCKS4A и SOCKS5 тип прокси
              case ProxyTypeComboBox.ItemIndex of
                2: SocksLevel := '4';
                3: SocksLevel := '4A';
                4: SocksLevel := '5';
              end;
              // Назначаем адрес SOCKS прокси и порт
              SocksServer := ProxyAddressEdit.Text;
              SocksPort := ProxyPortEdit.Text;
              // Назначаем авторизацию на SOCKS прокси
              if ProxyAuthCheckBox.Checked then
                begin
                  SocksAuthentication := SocksAuthenticateUsercode;
                  SocksUsercode := ProxyLoginEdit.Text;
                  SocksPassword := ProxyPasswordEdit.Text;
                end
              else
                begin
                  // Сбрасываем авторизацию SOCKS прокси
                  SocksAuthentication := SocksNoAuthentication;
                  SocksUsercode := EmptyStr;
                  SocksPassword := EmptyStr;
                end;
            end;
        end
      else
        begin
          // Убираем флаг, что для сокета активен режим через HTTP прокси
          HttpProxy_Enable := False;
          // Сбрасываем адрес HTTP прокси и порт
          HttpProxy_Address := EmptyStr;
          HttpProxy_Port := EmptyStr;
          // Сбрасываем авторизацию HTTP прокси
          HttpProxy_Auth := False;
          HttpProxy_Login := EmptyStr;
          HttpProxy_Password := EmptyStr;
          // Сбрасываем тип SOCKS прокси
          SocksLevel := '5';
          // Сбрасываем адрес SOCKS прокси и порт
          SocksServer := EmptyStr;
          SocksPort := EmptyStr;
          // Сбрасываем авторизацию SOCKS прокси
          SocksAuthentication := SocksNoAuthentication;
          SocksUsercode := EmptyStr;
          SocksPassword := EmptyStr;
        end;
    end;
end;

end.
