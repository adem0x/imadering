unit ProfileUnit;

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
  ExtCtrls,
  Pngimage,
  Menus,
  StdCtrls;

type
  TProfileForm = class(TForm)
    LogoImage: TImage;
    CenterPanel: TPanel;
    ProfileComboBox: TComboBox;
    ProfileLabel: TLabel;
    LoginButton: TButton;
    DeleteButton: TButton;
    VersionLabel: TLabel;
    SiteLabel: TLabel;
    LangLabel: TLabel;
    LangComboBox: TComboBox;
    AutoSignCheckBox: TCheckBox;
    procedure SiteLabelMouseEnter(Sender: TObject);
    procedure SiteLabelMouseLeave(Sender: TObject);
    procedure SiteLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LangComboBoxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LoginButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DeleteButtonClick(Sender: TObject);

  private
    { Private declarations }
    FClose: Boolean;
    procedure SaveSettings;
    procedure LoadSettings;

  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  ProfileForm: TProfileForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  RXML,
  SettingsUnit,
  RosterUnit,
  FirstStartUnit;

procedure TProfileForm.SaveSettings;
var
  I: Integer;
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  // Сохраняем настройки положения главного окна в xml
  with TrXML.Create() do
    try
      // Сохраняем язык по умолчанию
      if OpenKey('defaults\language', True) then
        try
          WriteString('locale', CurrentLang);
        finally
          CloseKey();
        end;
      // Сохраняем профиль по умолчанию
      if OpenKey('defaults\profile', True) then
        try
          WriteString('name', Profile);
          WriteBool('auto', AutoSignCheckBox.Checked);
        finally
          CloseKey();
        end;
      // Сохраняем список всех других профилей
      for I := 0 to ProfileComboBox.Items.Count - 1 do
        begin
          if OpenKey('defaults\profile\items' + IntToStr(I), True) then
            try
              WriteString('name', ProfileComboBox.Items.Strings[I]);
            finally
              CloseKey();
            end;
        end;
      // Записываем сам файл
      SaveToFile(ProfilePath + ProfilesFileName);
    finally
      Free();
    end;
end;

procedure TProfileForm.LoadSettings;
var
  I, Cnt: Integer;
begin
  // Инициализируем XML
  with TrXML.Create() do
    try
      // Загружаем настройки
      if FileExists(ProfilePath + ProfilesFileName) then
        begin
          LoadFromFile(ProfilePath + ProfilesFileName);
          // Загружаем язык по умолчанию
          if OpenKey('defaults\language') then
            try
              CurrentLang := ReadString('locale');
            finally
              CloseKey();
            end;
          // Получаем имя последнего профиля
          if OpenKey('defaults\profile') then
            try
              ProfileComboBox.Text := ReadString('name');
              AutoSignCheckBox.Checked := ReadBool('auto');
            finally
              CloseKey();
            end;
          // Получаем список других профилей
          if OpenKey('defaults\profile') then
            try
              Cnt := GetKeyCount();
            finally
              CloseKey();
            end;
          for I := 0 to Cnt - 1 do
            begin
              if OpenKey('defaults\profile\items' + IntToStr(I)) then
                try
                  ProfileComboBox.Items.Add(ReadString('name'));
                finally
                  CloseKey();
                end;
            end;
        end;
    finally
      Free();
    end;
end;

procedure TProfileForm.LoginButtonClick(Sender: TObject);
begin
  // Запускаем выбранный профиль
  if ProfileComboBox.Text = EmptyStr then
    begin
      // Выводим сообщение о том, что нужно ввести или выбрать профиль
      DAShow(ErrorHead, ProfileErrorL, EmptyStr, 134, 2, 0);
      Exit;
    end;
  Profile := ProfileComboBox.Text;
  if ProfileComboBox.Items.IndexOf(Profile) = -1 then
    ProfileComboBox.Items.Add(Profile);
  // Сохраняем настройки
  SaveSettings;
  // Инициализируем папку с профилем
  ProfilePath := ProfilePath + Profile + '\';
  XLog(LogProfile + ProfilePath);
  // Создаём форму с настройками для применения настроек
  SettingsForm := TSettingsForm.Create(MainForm);
  SettingsForm.ApplySettings;
  // Модифицируем меню в трэе
  with MainForm do
    begin
      HideProfileInTray.Visible := False;
      HideMainInTray2.Visible := True;
      StatusTray2.Visible := True;
      SettingsTray2.Visible := True;
      CheckUpdateTray2.Visible := True;
      // Заранее подгружаем иконки начальных статусов протоколов в трэй
      AllImageList.GetIcon(9, ICQTrayIcon.Icon);
      AllImageList.GetIcon(23, MRATrayIcon.Icon);
      AllImageList.GetIcon(30, JabberTrayIcon.Icon);
    end;
  // Пока просто скрываем общую иконку в трэе (потом сделать отображение по настройке)
  MainForm.XTrayIcon.Visible := false;
  // Создаём окно Ростера
  RosterForm := TRosterForm.Create(MainForm);
  // Загружаем настройки окна
  MainForm.LoadMainFormSettings;
  if AllSesDataTraf = EmptyStr then
    AllSesDataTraf := DateTimeToStr(Now);
  // Если это первый старт программы, то по умолчанию активруем ICQ протокол
  if not FirstStart then
    MainForm.ICQEnable(True);
  // Если автоматически проверять новые версии при старте
  if SettingsForm.AutoUpdateCheckBox.Checked then
    MainForm.JvTimerList.Events[2].Enabled := True;
  // Создаём необходимые листы
  AccountToNick := TStringList.Create;
  InMessList := TStringList.Create;
  SmilesList := TStringList.Create;
  if FileExists(ProfilePath + 'Profile\' + 'Nicks.txt') then
    AccountToNick.LoadFromFile(ProfilePath + 'Profile\' + 'Nicks.txt');
  XLog(LogNickCash + IntToStr(AccountToNick.Count));
  if FileExists(MyPath + 'Smilies\' + CurrentSmiles + '\smilies.txt') then
    SmilesList.LoadFromFile(MyPath + 'Smilies\' + CurrentSmiles + '\smilies.txt');
  XLog(LogSmiliesCount + IntToStr(SmilesList.Count - 1));
  // Если не активно запускаться свёрнутой в трэй то показываем клавное окно
  if not SettingsForm.HideInTrayProgramStartCheckBox.Checked then
    begin
      XShowForm(MainForm);
      // Выводим окно на самый передний план, против глюков в вин и вайн
      SetForeGroundWindow(Application.MainForm.Handle);
    end;
  // В фоне создаём окно смайлов
  MainForm.JvTimerList.Events[7].Enabled := True;
  // Инициализируем переменную времени начала статистики трафика сессии
  SesDataTraf := Now;
  // Если это первый старт программы то запускаем окно первичной настройки протоколов
  if not FirstStart then
    begin
      // Затем показываем окно начальной настройки протоколов
      FirstStartForm := TFirstStartForm.Create(MainForm);
      XShowForm(FirstStartForm);
    end;
  // Запускаем таймер индикации событий
  MainForm.JvTimerList.Events[1].Enabled := True;
  // Высвобождаем общую память приложения (вспоминая qip)
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
  // Закрываем окно
  FClose := True;
  Close;
end;

procedure TProfileForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Сведения о версии программы
  VersionLabel.Caption := Format(VersionL, [InitBuildInfo]);
end;

procedure TProfileForm.DeleteButtonClick(Sender: TObject);
var
  N: Integer;
begin
  // Удаляем профиль из списка
  ProfileComboBox.Text := EmptyStr;
  N := ProfileComboBox.Items.IndexOf(ProfileComboBox.Text);
  if N > -1 then
    begin
      ProfileComboBox.Items.Delete(N);
      ProfileComboBox.Text := EmptyStr;
      SaveSettings;
    end;
end;

procedure TProfileForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Уничтожаем форму
  Action := CaFree;
  ProfileForm := nil;
end;

procedure TProfileForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Закрываем программу
  if not FClose then
    MainForm.CloseProgramClick(nil);
end;

procedure TProfileForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(253, Icon);
  // Загружаем логотип программы
  if FileExists(MyPath + 'Icons\' + CurrentIcons + '\logo.png') then
    LogoImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\logo.png');
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем настройки
  LoadSettings;
  // Устанавливаем язык
  if CurrentLang = 'ru' then
    LangComboBox.ItemIndex := 0
  else
    LangComboBox.ItemIndex := 1;
  // Переводим форму
  LangComboBox.OnChange := LangComboBoxChange;
  LangComboBoxChange(nil);
  // Высвобождаем общую память приложения (вспоминая qip)
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
end;

procedure TProfileForm.LangComboBoxChange(Sender: TObject);
begin
  // Устанавливаем язык
  case LangComboBox.ItemIndex of
    0: CurrentLang := 'ru';
    1: CurrentLang := 'en';
  end;
  // Переводим форму
  SetLangVars;
  TranslateForm;
  MainForm.TranslateForm;
end;

procedure TProfileForm.SiteLabelClick(Sender: TObject);
begin
  // Открываем сайт в браузере по умолчанию
  OpenURL('http://imadering.com');
end;

procedure TProfileForm.SiteLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TProfileForm.SiteLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

end.
