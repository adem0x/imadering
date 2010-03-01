{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit ProfileUnit;

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
  ExtCtrls,
  Pngimage,
  Menus,
  StdCtrls,
  JvSimpleXml,
  Buttons,
  ShellApi;

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
    OpenProfilesSpeedButton: TSpeedButton;
    procedure SiteLabelMouseEnter(Sender: TObject);
    procedure SiteLabelMouseLeave(Sender: TObject);
    procedure SiteLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LangComboBoxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LoginButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ProfileComboBoxChange(Sender: TObject);
    procedure OpenProfilesSpeedButtonClick(Sender: TObject);

  private
    { Private declarations }
    FClose: Boolean;
    procedure SaveSettings;
    procedure LoadSettings;

  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  ProfileForm: TProfileForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  SettingsUnit,
  RosterUnit,
  FirstStartUnit,
  LogUnit,
  ProfilesFolderUnit;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TProfileForm.SaveSettings;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  // Сохраняем настройки положения главного окна в xml
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        // Сохраняем язык по умолчанию
        Root.Items.Add(C_Lang, CurrentLang);
        // Сохраняем отображение окна профиля
        Root.Items.Add(C_Auto, AutoSignCheckBox.Checked);
        ProfileAuto := AutoSignCheckBox.Checked;
        // Сохраняем профиль по умолчанию
        XML_Node := Root.Items.Add(C_Profiles);
        XML_Node.Properties.Add(C_Cur, Profile);
        // Сохраняем список всех других профилей
        for I := 0 to ProfileComboBox.Items.Count - 1 do
          XML_Node.Items.Add('i' + IntToStr(I), ProfileComboBox.Items.Strings[I]);
        // Записываем сам файл
        SaveToFile(ProfilePath + ProfilesFileName);
      end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TProfileForm.LoadSettings;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        // Загружаем настройки
        if FileExists(ProfilePath + ProfilesFileName) then
          begin
            LoadFromFile(ProfilePath + ProfilesFileName);
            if Root <> nil then
              begin
                // Загружаем язык по умолчанию
                XML_Node := Root.Items.ItemNamed[C_Lang];
                if XML_Node <> nil then
                  CurrentLang := XML_Node.Value;
                // Загружаем отображение окна профиля
                XML_Node := Root.Items.ItemNamed[C_Auto];
                if XML_Node <> nil then
                  AutoSignCheckBox.Checked := XML_Node.BoolValue;
                ProfileAuto := AutoSignCheckBox.Checked;
                // Получаем имя последнего профиля
                XML_Node := Root.Items.ItemNamed[C_Profiles];
                if XML_Node <> nil then
                  begin
                    ProfileComboBox.Text := XML_Node.Properties.Value(C_Cur);
                    // Получаем список других профилей
                    for I := 0 to XML_Node.Items.Count - 1 do
                      ProfileComboBox.Items.Add(XML_Node.Items.Value('i' + IntToStr(I)));
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'LoginButtonClick'}

procedure TProfileForm.LoginButtonClick(Sender: TObject);
var
  PR: string;
begin
  // Запускаем выбранный профиль
  if ProfileComboBox.Text = EmptyStr then
    begin
      // Выводим сообщение о том, что нужно ввести или выбрать профиль
      DAShow(S_Errorhead, S_ProfileError, EmptyStr, 134, 2, 0);
      Exit;
    end;
  // Нормализуем имя профиля
  ProfileComboBox.Text := RafinePath(ProfileComboBox.Text);
  // Запоминаем имя профиля
  Profile := ProfileComboBox.Text;
  if ProfileComboBox.Items.IndexOf(Profile) = -1 then
    ProfileComboBox.Items.Add(Profile);
  // Сохраняем настройки
  SaveSettings;
  // Инициализируем папку с профилем
  PR := ProfilePath;
  ProfilePath := ProfilePath + Profile + '\';
  Profile := PR;
  XLog(LogProfile + ProfilePath, EmptyStr);
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
  MainForm.XTrayIcon.Visible := False;
  // Загружаем настройки главного окна
  MainForm.LoadMainFormSettings;
  if AllSesDataTraf = EmptyStr then
    AllSesDataTraf := DateTimeToStr(Now);
  // Создаём окно Ростера и загружаем контакты в него
  RosterForm := TRosterForm.Create(MainForm);
  // Если это первый старт программы, то по умолчанию активруем ICQ протокол
  if not FirstStart then
    MainForm.ICQ_Enable(True);
  // Если автоматически проверять новые версии при старте
  if SettingsForm.AutoUpdateCheckBox.Checked then
    MainForm.JvTimerList.Events[2].Enabled := True;
  // Создаём необходимые листы
  AccountToNick := TStringList.Create;
  InMessList := TStringList.Create;
  SmilesList := TStringList.Create;
  if FileExists(ProfilePath + Nick_BD_FileName) then
    AccountToNick.LoadFromFile(ProfilePath + Nick_BD_FileName, TEncoding.Unicode);
  XLog(LogNickCash + IntToStr(AccountToNick.Count), EmptyStr);
  if FileExists(MyPath + Format(SmiliesPath, [CurrentSmiles])) then
    SmilesList.LoadFromFile(MyPath + Format(SmiliesPath, [CurrentSmiles]), TEncoding.UTF8);
  XLog(LogSmiliesCount + IntToStr(SmilesList.Count - 1), EmptyStr);
  // Запускаем обработку Ростера
  RosterForm.UpdateFullCL;
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
  // Выключаем кнопку записи последующих событий в окно лога
  LogForm.WriteLogSpeedButton.Down := False;
  // Воспроизводим звук запуска программы
  ImPlaySnd(1);
  // Закрываем окно
  FClose := True;
  Close;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TProfileForm.OpenProfilesSpeedButtonClick(Sender: TObject);
begin
  // Открываем папку с профилями
  ShellExecute(0, 'open', PChar(ProfilePath), nil, nil, SW_SHOW);
end;

procedure TProfileForm.ProfileComboBoxChange(Sender: TObject);
begin
  // Пишем в всплывающей подсказке путь к профилю
  ProfileComboBox.Hint := ProfilePath + ProfileComboBox.Text;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TProfileForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Сведения о версии программы
  VersionLabel.Caption := Format(S_Version, [FullVersion]);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TProfileForm.DeleteButtonClick(Sender: TObject);
var
  N: Integer;
begin
  // Удаляем профиль из списка
  ProfileComboBox.Text := EmptyStr;
  ProfileComboBox.Hint := EmptyStr;
  N := ProfileComboBox.Items.IndexOf(ProfileComboBox.Text);
  if N > -1 then
    begin
      ProfileComboBox.Items.Delete(N);
      ProfileComboBox.Text := EmptyStr;
      SaveSettings;
    end;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TProfileForm.FormCreate(Sender: TObject);
label
  A;
var
  FrmFolder: TProfilesFolderForm;
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(253, Icon);
  MainForm.AllImageList.GetBitmap(227, OpenProfilesSpeedButton.Glyph);
  // Загружаем логотип программы
  if FileExists(MyPath + 'Icons\' + CurrentIcons + '\logo.png') then
    LogoImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\logo.png');
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем настройки
  LoadSettings;
  ProfileComboBox.Hint := ProfilePath + ProfileComboBox.Text;
  // Назначаем разделитель значений для списков
  LangComboBox.Items.NameValueSeparator := C_BN;
  // Устанавливаем язык
  LangComboBox.ItemIndex := LangComboBox.Items.IndexOfName('[' + CurrentLang + ']');
  // Переводим форму
  LangComboBox.OnChange := LangComboBoxChange;
  LangComboBoxChange(nil);
A :;
  // Проверяем если ли папки профилей и если нету, то спрашиваем где их хранить
  if not DirectoryExists(ProfilePath) then
    begin
      FrmFolder := TProfilesFolderForm.Create(MainForm);
      try
        FrmFolder.ShowModal;
        if FrmFolder.Folder1RadioButton.Checked then
          ProfilePath := FrmFolder.Folder1Edit.Text
        else
          ProfilePath := FrmFolder.Folder2Edit.Text;
      finally
        FreeAndNil(FrmFolder);
      end;
    end;
  // Создаём папку для профилей
  if not ForceDirectories(ProfilePath) then
    begin
      // Сообщаем, что прав на запись обновления у нас нет
      DAShow(S_Errorhead, S_UnPackErr, EmptyStr, 134, 2, 0);
      goto A;
    end;
end;

{$ENDREGION}
{$REGION 'LangComboBoxChange'}

procedure TProfileForm.LangComboBoxChange(Sender: TObject);
begin
  // Устанавливаем язык
  CurrentLang := IsolateTextString(LangComboBox.Items.Names[LangComboBox.ItemIndex], '[', ']');
  // Подгружаем переменные языка
  SetLangVars;
  // Переводим форму
  TranslateForm;
  // Применяем язык к форме лога
  LogForm.TranslateForm;
  // Применяем язык к главной форме
  MainForm.TranslateForm;
end;

{$ENDREGION}
{$REGION 'Other'}

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

procedure TProfileForm.SiteLabelClick(Sender: TObject);
begin
  // Открываем сайт в браузере по умолчанию
  OpenURL(C_SitePage);
end;

procedure TProfileForm.SiteLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TProfileForm.SiteLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

{$ENDREGION}

end.
