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
  ShellApi,
  IOUtils,
  ImgList;

type
  TProfileForm = class(TForm)
    LogoImage: TImage;
    CenterPanel: TPanel;
    ProfileComboBox: TComboBox;
    ProfileLabel: TLabel;
    LoginButton: TBitBtn;
    SiteLabel: TLabel;
    NoShowProfileFormCheckBox: TCheckBox;
    OpenProfilesSpeedButton: TSpeedButton;
    LangsPopupMenu: TPopupMenu;
    LangsImageList: TImageList;
    LangsSpeedButton: TSpeedButton;
    DellProfileSpeedButton: TSpeedButton;
    FlagImage: TImage;
    VersionLabel: TLabel;
    AutoDellProfileCheckBox: TCheckBox;
    procedure SiteLabelMouseEnter(Sender: TObject);
    procedure SiteLabelMouseLeave(Sender: TObject);
    procedure SiteLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LoginButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ProfileComboBoxChange(Sender: TObject);
    procedure OpenProfilesSpeedButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DellProfileSpeedButtonClick(Sender: TObject);
    procedure LangsSpeedButtonClick(Sender: TObject);
    procedure LangsSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure AutoDellProfileCheckBoxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    FClose: Boolean;
    procedure SaveSettings;
    procedure LoadSettings;
    procedure LangMenuClick(Sender: TObject);

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
  ProfilesFolderUnit,
  OverbyteIcsUtils,
  RosterUnit;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TProfileForm.SaveSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Сохраняем настройки положения главного окна в xml
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Сохраняем язык по умолчанию
      Root.Items.Add(C_Lang, V_CurrentLang);
      // Сохраняем автовход в профиль
      Root.Items.Add(NoShowProfileFormCheckBox.Name, NoShowProfileFormCheckBox.Checked);
      V_ProfileAuto := NoShowProfileFormCheckBox.Checked;
      // Сохраняем автоудаление профиля
      Root.Items.Add(AutoDellProfileCheckBox.Name, AutoDellProfileCheckBox.Checked);
      // Сохраняем профиль по умолчанию
      XML_Node := Root.Items.Add(ProfileComboBox.Name);
      XML_Node.Value := V_Profile;
      // Записываем сам файл
      SaveToFile(V_ProfilePath + C_ProfilesFileName);
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TProfileForm.LoadSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      if FileExists(V_ProfilePath + C_ProfilesFileName) then
      begin
        LoadFromFile(V_ProfilePath + C_ProfilesFileName);
        if Root <> nil then
        begin
          // Загружаем язык по умолчанию
          XML_Node := Root.Items.ItemNamed[C_Lang];
          if XML_Node <> nil then
            V_CurrentLang := XML_Node.Value;
          // Загружаем автовход в профиль
          XML_Node := Root.Items.ItemNamed[NoShowProfileFormCheckBox.Name];
          if XML_Node <> nil then
            NoShowProfileFormCheckBox.Checked := XML_Node.BoolValue;
          V_ProfileAuto := NoShowProfileFormCheckBox.Checked;
          // Загружаем автоудаление профиля
          XML_Node := Root.Items.ItemNamed[AutoDellProfileCheckBox.Name];
          if XML_Node <> nil then
            AutoDellProfileCheckBox.Checked := XML_Node.BoolValue;
          V_AutoDellProfile := AutoDellProfileCheckBox.Checked;
          // Получаем имя последнего профиля
          XML_Node := Root.Items.ItemNamed[ProfileComboBox.Name];
          if XML_Node <> nil then
            ProfileComboBox.Text := XML_Node.Value;
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
  // Нормализуем имя профиля
  ProfileComboBox.Text := Trim(RafinePath(ProfileComboBox.Text));
  // Запускаем выбранный профиль
  if ProfileComboBox.Text = EmptyStr then
  begin
    // Выводим сообщение о том, что нужно ввести или выбрать профиль
    DAShow(Lang_Vars[17].L_S, Lang_Vars[5].L_S, EmptyStr, 134, 2, 0);
    Exit;
  end;
  // Скрываем окно профиля
  Hide;
  // Запоминаем имя профиля
  V_Profile := ProfileComboBox.Text;
  if ProfileComboBox.Items.IndexOf(V_Profile) = -1 then
    ProfileComboBox.Items.Add(V_Profile);
  // Сохраняем настройки профиля
  SaveSettings;
  // Делаем заголовок окна КЛ и иконки в трэе по имени профиля
  with MainForm do
  begin
    Caption := V_Profile;
    TrayIcon.Hint := V_Profile;
  end;
  V_YouAt := V_Profile;
  // Инициализируем папку с профилем
  PR := V_ProfilePath;
  V_ProfilePath := V_ProfilePath + V_Profile + '\';
  V_Profile := PR;
  // Вывод плагинам "Выбор профиля [путь к профилю]"
  MainForm.JvPluginManager.BroadcastMessage(2, V_ProfilePath);
  // Создаём форму с настройками для применения настроек
  Application.CreateForm(TSettingsForm, SettingsForm);
  SettingsForm.ApplySettings;
  // Модифицируем меню в трэе
  with MainForm do
  begin
    Status_MenuTray.Visible := True;
    Settings_MenuTray.Visible := True;
    SwitchProfile_MenuTray.Visible := True;
  end;
  // Загружаем настройки главного окна
  MainForm.LoadMainFormSettings;
  if V_AllSesDataTraf = EmptyStr then
    V_AllSesDataTraf := DateTimeToStr(Now);
  // Создаём Ростер и загружаем контакты в него
  JvXML_Create(V_Roster);
  if FileExists(V_ProfilePath + C_ContactListFileName) then
    V_Roster.LoadFromFile(V_ProfilePath + C_ContactListFileName);
  // Если автоматически проверять новые версии при старте
  if SettingsForm.AutoUpdateCheckBox.Checked then
    MainForm.JvTimerList.Events[2].Enabled := True;
  // Создаём необходимые листы
  V_AccountToNick := TStringList.Create;
  V_AccountToNick.NameValueSeparator := ';';
  V_InMessList := TStringList.Create;
  V_SmilesList := TStringList.Create;
  if FileExists(V_ProfilePath + C_Nick_BD_FileName) then
    V_AccountToNick.LoadFromFile(V_ProfilePath + C_Nick_BD_FileName, TEncoding.Unicode);
  if FileExists(V_MyPath + Format(C_SmiliesPath, [V_CurrentSmiles])) then
    V_SmilesList.LoadFromFile(V_MyPath + Format(C_SmiliesPath, [V_CurrentSmiles]), TEncoding.UTF8);
  // Запускаем обработку Ростера
  UpdateFullCL;
  // Если не активно запускаться свёрнутой в трэй то показываем клавное окно
  if not SettingsForm.HideInTrayProgramStartCheckBox.Checked then
  begin
    XShowForm(MainForm);
    // Выводим окно на самый передний план, против глюков в вин и вайн
    Application.BringToFront;
  end
  else
  begin
    MainForm.HideInTray_MenuTray.Caption := Lang_Vars[0].L_S;
    MainForm.HideInTray_MenuTray.ImageIndex := 5;
  end;
  // Инициализируем переменную времени начала статистики трафика сессии
  V_SesDataTraf := Now;
  with MainForm do
  begin
    // Если это первый старт программы то запускаем выбор протоколов
    if (not ICQToolButton.Visible) and (not JabberToolButton.Visible) //
      and (not MRAToolButton.Visible) and (not BimoidToolButton.Visible) then
    begin
      XShowForm(SettingsForm);
      SettingsForm.SettingsJvPageList.ActivePageIndex := 12;
      SettingsForm.SettingButtonGroup.ItemIndex := 12;
    end;
    // Запускаем таймер индикации событий в КЛ и чате
    JvTimerList.Events[1].Enabled := True;
    // Запускаем таймер перерисовки иконки в трэе
    JvTimerList.Events[12].Enabled := True;
    // В фоне создаём окно смайлов
    JvTimerList.Events[7].Enabled := True;
    // Запускаем таймер перевода
    JvTimerList.Events[8].Enabled := True;
  end;
  // Открываем новости IMadering
  if SettingsForm.AutoOpenSiteCheckBox.Checked then
    OpenURL(C_SitePage);
  // Закрываем окно
  FClose := True;
  Close;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TProfileForm.AutoDellProfileCheckBoxClick(Sender: TObject);
begin
  // Активируем удаление профиля при выходе
  V_AutoDellProfile := AutoDellProfileCheckBox.Checked;
end;

procedure TProfileForm.OpenProfilesSpeedButtonClick(Sender: TObject);
begin
  // Открываем папку с профилями
  ShellExecute(0, 'open', PChar(V_ProfilePath), nil, nil, SW_SHOW);
end;

procedure TProfileForm.ProfileComboBoxChange(Sender: TObject);
begin
  // Пишем в всплывающей подсказке путь к профилю
  ProfileComboBox.Hint := V_ProfilePath + ProfileComboBox.Text;
end;

procedure TProfileForm.LangsSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем меню над этим элементом
  if Button = MbRight then
    LangsSpeedButtonClick(Sender);
end;

{$ENDREGION}
{$REGION 'LangsSpeedButtonClick'}

procedure TProfileForm.LangsSpeedButtonClick(Sender: TObject);
var
  XPoint: TPoint;
begin
  // Открываем меню над этим элементом
  GetParentForm(TWinControl(LangsSpeedButton)).SendCancelMode(nil);
  LangsPopupMenu.PopUpComponent := TWinControl(LangsSpeedButton);
  XPoint := Point(TWinControl(LangsSpeedButton).Width, TWinControl(LangsSpeedButton).Top - (CenterPanel.Top + CenterPanel.Height));
  with TWinControl(LangsSpeedButton).ClientToScreen(XPoint) do
    LangsPopupMenu.PopUp(X, Y);
end;
{$ENDREGION}
{$REGION 'LangMenuClick'}

procedure TProfileForm.LangMenuClick(Sender: TObject);
begin
  // Применяем язык выбранный в меню
  TMenuItem(Sender).Default := true;
  V_CurrentLang := IsolateTextString(TMenuItem(Sender).Caption, '[', ']');
  // Подгружаем переменные языка
  SetLangVars;
  // Переводим форму
  TranslateForm;
  // Применяем язык к главной форме
  MainForm.TranslateForm;
  // Устанавливаем иконку флага страны на кнопку
  LangsSpeedButton.Glyph.Assign(nil);
  LangsImageList.GetBitmap(TMenuItem(Sender).ImageIndex, LangsSpeedButton.Glyph);
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
  VersionLabel.Caption := Format(Lang_Vars[4].L_S, [V_FullVersion]);
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TProfileForm.FormCreate(Sender: TObject);
label
  A;
var
  FrmFolder: TProfilesFolderForm;
  Folder, Langs, LangCode, FlagFile, Logo: string;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
  FlagImg: TBitmap;
  I: integer;
begin
  // Присваиваем иконку окну и кнопкам
  with MainForm.AllImageList do
  begin
    GetIcon(253, Icon);
    GetBitmap(227, OpenProfilesSpeedButton.Glyph);
    GetBitmap(140, LoginButton.Glyph);
    GetBitmap(139, DellProfileSpeedButton.Glyph);
  end;
  // Загружаем логотип программы
  Logo := V_MyPath + C_IconsFolder + V_CurrentIcons + '\' + 'logo' + C_PNG_Ext;
  if FileExists(Logo) then
    LogoImage.Picture.LoadFromFile(Logo);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем настройки
  LoadSettings;
  // Устанавливаем язык
  LangsSpeedButton.Glyph.TransparentColor := clNone;
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      for Langs in TDirectory.GetFiles(V_MyPath + C_LangsFolder, C_XML_Files) do
      begin
        LangCode := IcsExtractNameOnlyW(Langs);
        if FileExists(Langs) then
        begin
          // Загружаем файл языка
          LoadFromFile(Langs);
          if Root <> nil then
          begin
            // Получаем название языка
            XML_Node := Root.Items.ItemNamed[C_LangVars];
            if XML_Node <> nil then
            begin
              // Добавляем пункт этого языка в меню
              LangsPopupMenu.Items.Add(NewItem('[' + LangCode + ']' + ' ' + XML_Node.Properties.Value(C_Lang), 0, False, True, LangMenuClick, 0, LangCode));
              LangsPopupMenu.Items[LangsPopupMenu.Items.Count - 1].Hint := LangCode;
              // Получаем флаг страны этого языка
              FlagFile := V_MyPath + C_FlagsFolder + GetFlagFile(V_MyPath + C_FlagsFolder, EmptyStr, LangCode);
              if FileExists(FlagFile) then
              begin
                // Добавляем иконку флага ImageList
                FlagImg := TBitmap.Create;
                FlagImage.Picture.Assign(nil);
                FlagImage.Picture.LoadFromFile(FlagFile);
                try
                  FlagImg.Height := 11;
                  FlagImg.Width := 16;
                  FlagImg.Canvas.Draw(0, 0, FlagImage.Picture.Graphic);
                  LangsImageList.Add(FlagImg, nil);
                finally
                  FlagImg.Free;
                end;
                // Подставляем иконку флага страны этого языка в пункт меню
                LangsPopupMenu.Items[LangsPopupMenu.Items.Count - 1].ImageIndex := LangsImageList.Count - 1;
              end
              else
                LangsImageList.Add(nil, nil);
            end;
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Применяем текущий язык
  for I := 0 to LangsPopupMenu.Items.Count - 1 do
  begin
    if LangsPopupMenu.Items[I].Hint = V_CurrentLang then
      LangMenuClick(LangsPopupMenu.Items[I]);
  end;
  A: ;
  // Проверяем если ли папки профилей и если нету, то спрашиваем где их хранить
  if not DirectoryExists(V_ProfilePath) then
  begin
    FrmFolder := TProfilesFolderForm.Create(MainForm);
    try
      FrmFolder.ShowModal;
      if FrmFolder.Folder1RadioButton.Checked then
        V_ProfilePath := FrmFolder.Folder1Edit.Text
      else
        V_ProfilePath := FrmFolder.Folder2Edit.Text;
    finally
      FreeAndNil(FrmFolder);
    end;
  end;
  // Создаём папку для профилей
  if not ForceDirectories(V_ProfilePath) then
  begin
    // Сообщаем, что прав на запись обновления у нас нет
    DAShow(Lang_Vars[17].L_S, Lang_Vars[63].L_S, EmptyStr, 134, 2, 0);
    goto A;
  end;
  // Подгружаем список всех папок профилей
  for Folder in TDirectory.GetDirectories(V_ProfilePath) do
    ProfileComboBox.Items.Add(IcsExtractLastDir(Folder));
  ProfileComboBox.Hint := V_ProfilePath + ProfileComboBox.Text;
end;

{$ENDREGION}
{$REGION 'DellProfile'}

procedure TProfileForm.DellProfileSpeedButtonClick(Sender: TObject);
var
  N: Integer;
begin
  // Удаляем профиль из списка и с диска
  if ProfileComboBox.Text = EmptyStr then
    Exit;
  if MessageBox(Handle, PChar(Format(Lang_Vars[127].L_S, [ProfileComboBox.Text])), PChar(Lang_Vars[19].L_S), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
  begin
    if DirectoryExists(V_ProfilePath + ProfileComboBox.Text) then
      TDirectory.Delete(V_ProfilePath + ProfileComboBox.Text, True);
    N := ProfileComboBox.Items.IndexOf(ProfileComboBox.Text);
    if N > -1 then
      ProfileComboBox.Items.Delete(N);
    ProfileComboBox.Text := EmptyStr;
    ProfileComboBox.Hint := EmptyStr;
    SaveSettings;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TProfileForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  // Если нажата клавиша Esc, то закрываем окно
  if Key = #27 then
    Close;
end;

procedure TProfileForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FClose then
  begin
    // Уничтожаем форму при закрытии
    Action := caFree;
    ProfileForm := nil;
  end;
end;

procedure TProfileForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not FClose then
  begin
    // Спрашиваем выйти из программы или свернуть в трэй
    if MessageBox(Handle, PChar(Lang_Vars[2].L_S), PChar(Application.Title), MB_YESNO or MB_ICONQUESTION) = mrYes then
      MainForm.CloseProgram_MenuClick(nil)
    else
      MainForm.MainFormHideInTray;
  end;
end;

procedure TProfileForm.SiteLabelClick(Sender: TObject);
begin
  // Открываем сайт в браузере по умолчанию
  OpenURL(C_SitePage);
end;

procedure TProfileForm.SiteLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClBlue;
end;

procedure TProfileForm.SiteLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClNavy;
end;

procedure TProfileForm.FormShow(Sender: TObject);
begin
  // Скрываем кнопку приложения на панели задачь
  ShowWindow(Application.Handle, SW_HIDE);
end;

{$ENDREGION}

end.

