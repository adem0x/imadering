{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit SettingsUnit;

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
  JvPageList,
  JvExControls,
  ExtCtrls,
  ButtonGroup,
  StdCtrls,
  Buttons,
  OverbyteIcsWndControl,
  OverbyteIcsWSocket,
  OverbyteIcsHttpProt,
  ComCtrls,
  JvSimpleXml,
  Mmsystem,
  ShellApi,
  IOUtils;

type
  TSettingsForm = class(TForm)
    SettingButtonGroup: TButtonGroup;
    PagesPanel: TPanel;
    SettingsJvPageList: TJvPageList;
    GeneralPage: TJvStandardPage;
    CLPage: TJvStandardPage;
    ChatPage: TJvStandardPage;
    EventsPage: TJvStandardPage;
    GlobalProxyPage: TJvStandardPage;
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    ApplyBitBtn: TBitBtn;
    GeneralOptionGroupBox: TGroupBox;
    CLWindowGroupBox: TGroupBox;
    ChatFormGroupBox: TGroupBox;
    EventsGroupBox: TGroupBox;
    ProxyGroupBox: TGroupBox;
    ProxyAddressEdit: TEdit;
    HostLabel: TLabel;
    PortLabel: TLabel;
    ProxyPortEdit: TEdit;
    ProxyTypeComboBox: TComboBox;
    TypeLabel: TLabel;
    ProxyVersionComboBox: TComboBox;
    ProxyVerLabel: TLabel;
    ProxyAuthCheckBox: TCheckBox;
    ProxyLoginEdit: TEdit;
    ProxyPasswordEdit: TEdit;
    LoginLabel: TLabel;
    PassLabel: TLabel;
    ProxyShowPassCheckBox: TCheckBox;
    ProxyEnableCheckBox: TCheckBox;
    NTLMCheckBox: TCheckBox;
    ConnGroupBox: TGroupBox;
    ReconnectCheckBox: TCheckBox;
    HideInTrayProgramStartCheckBox: TCheckBox;
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
    HistoryPage: TJvStandardPage;
    StatusesPage: TJvStandardPage;
    AntiSpamPage: TJvStandardPage;
    SoundsPage: TJvStandardPage;
    ThemesPage: TJvStandardPage;
    HotKeysPage: TJvStandardPage;
    PluginsPage: TJvStandardPage;
    AccountsPage: TJvStandardPage;
    HistoryGroupBox: TGroupBox;
    StatusesGroupBox: TGroupBox;
    AntiSpamGroupBox: TGroupBox;
    SoundsGroupBox: TGroupBox;
    LangGroupBox: TGroupBox;
    HotKeysGroupBox: TGroupBox;
    PluginsGroupBox: TGroupBox;
    ProtocolsGroupBox: TGroupBox;
    ProtocolsListView: TListView;
    AddProtoBitBtn: TBitBtn;
    SettingsProtoBitBtn: TBitBtn;
    DeleteProtoBitBtn: TBitBtn;
    ShowPluginConfigButton: TButton;
    PluginsListView: TListView;
    BestPrioritetCheckBox: TCheckBox;
    SmiliesGroupBox: TGroupBox;
    IconsGroupBox: TGroupBox;
    Bevel1: TBevel;
    LangDownButton: TButton;
    LangComboBox: TComboBox;
    LangInfoRichEdit: TRichEdit;
    SmiliesComboBox: TComboBox;
    SmiliesDownButton: TButton;
    TextSmiliesCheckBox: TCheckBox;
    IconsComboBox: TComboBox;
    IconsDownButton: TButton;
    IconsInfoRichEdit: TRichEdit;
    SmiliesLabel: TLabel;
    SmiliesInfoRichEdit: TRichEdit;
    SoundOnOffCheckBox: TCheckBox;
    SoundOffForStatusCheckBox: TCheckBox;
    SoundAlwaysUniqCheckBox: TCheckBox;
    SoundPackComboBox: TComboBox;
    DownSoundButton: TButton;
    SoundPathListView: TListView;
    SoundPlaySpeedButton: TSpeedButton;
    SoundPathButton: TButton;
    ProfileGroupBox: TGroupBox;
    NoShowProfileFormCheckBox: TCheckBox;
    ProfilePathEdit: TEdit;
    ProfilePathLabel: TLabel;
    OpenProfileSpeedButton: TSpeedButton;
    NoTaskBarMainButtonCheckBox: TCheckBox;
    KeyboardSoundsCheckBox: TCheckBox;
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
    procedure SettingButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ProtocolsListViewClick(Sender: TObject);
    procedure ProtocolsListViewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SettingsProtoBitBtnClick(Sender: TObject);
    procedure AddProtoBitBtnClick(Sender: TObject);
    procedure ProtocolsListViewChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure LangComboBoxChange(Sender: TObject);
    procedure LangDownButtonClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SmiliesComboBoxChange(Sender: TObject);
    procedure IconsComboBoxChange(Sender: TObject);
    procedure SoundOnOffCheckBoxClick(Sender: TObject);
    procedure SoundPlaySpeedButtonClick(Sender: TObject);
    procedure SoundPathListViewChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure SoundPackComboBoxChange(Sender: TObject);
    procedure OpenProfileSpeedButtonClick(Sender: TObject);

  private
    { Private declarations }
    ChangeProtoItem: TListItem;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure TranslateForm;

  public
    { Public declarations }
    procedure ApplySettings;
    procedure ApplyProxyHttpClient(HttpClient: THttpCli);
    procedure ApplyProxySocketClient(SocketClient: TWSocket);
  end;

{$ENDREGION}

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  VarsUnit,
  IcqOptionsUnit,
  JvBrowseFolder,
  UtilsUnit,
  OverbyteIcsMimeUtils,
  FileTransferUnit,
  GTransUnit,
  SmilesUnit,
  GamesUnit,
  OverbyteIcsUtils;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_Settings = 'Settings';
  C_Proxy = 'Proxy';
  C_ProxyType = 'Type';
  C_ProxyVersion = 'Version';
  C_ProxyNTLM = 'NTLM';
  C_StartInTray = 'Start_in_tray';
  C_UpdateCheck = 'Update_check';
  C_HPriority = 'High_priority';
  C_CLForm = 'CL_form';
  C_AlwaysTop = 'Always_top';
  C_TrValue = 'Tr_value';
  C_TrActive = 'Tr_active';
  C_AutoHide = 'Auto_hide';
  C_AutoHideS = 'Auto_hide_s';
  C_CLHeader = 'Header';
  C_Recon = 'Reconnect';
  C_Smile = 'Smiles';
  C_TextSmile = 'Text_smilies';
  C_NoTask = 'No_task';
  C_Chat = 'Chat';
  C_KeySounds = 'Key_Sounds';

{$ENDREGION}
{$REGION 'LangComboBoxChange'}

procedure TSettingsForm.LangComboBoxChange(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
  S, LangFile: string;
begin
  // Отображаем данные о выбранном языке
  S := IsolateTextString(LangComboBox.Items.Names[LangComboBox.ItemIndex], '[', ']');
  LangFile := V_MyPath + 'Langs\' + S + '.xml';
  if FileExists(LangFile) then
    begin
      // Инициализируем XML
      JvXML_Create(JvXML);
      try
        with JvXML do
          begin
            // Загружаем настройки
            if FileExists(V_MyPath + Format(C_LangPath, [S])) then
              begin
                // Загружаем файл языка
                LoadFromFile(V_MyPath + Format(C_LangPath, [S]));
                if Root <> nil then
                  begin
                    //
                    XML_Node := Root.Items.ItemNamed[C_Infos];
                    if XML_Node <> nil then
                      begin
                        XML_Node := Root.Items.ItemNamed[C_Infos].Items.ItemNamed[C_Lang];
                        if XML_Node <> nil then
                          begin
                            LangInfoRichEdit.Lines.Text := CheckText_RN(XML_Node.Properties.Value('c'));
                            // Прокручиваем рич в верх против глюка в вайн
                            SendMessage(LangInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
                            // Активируем кнопку Применить
                            ApplyBitBtn.Enabled := True;
                          end;
                      end;
                  end;
              end;
          end;
      finally
        JvXML.Free;
      end;
    end
  else
    LangInfoRichEdit.Lines.Text := EmptyStr;
end;

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TSettingsForm.LoadSettings;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Folder: string;
begin
  // Устанавливаем галочки включенных протоколов
  ProtocolsListView.Clear;
  ProtocolsListView.Items.BeginUpdate;
  // Добавляем ICQ протокол
  with ProtocolsListView.Items.Add do
    begin
      Caption := C_BN + Lang_Vars[12].L_S;
      GroupID := 0;
      ImageIndex := 81;
      Checked := MainForm.ICQToolButton.Visible;
    end;
  // Добавляем Jabber протокол
  with ProtocolsListView.Items.Add do
    begin
      Caption := C_BN + Lang_Vars[12].L_S;
      GroupID := 1;
      ImageIndex := 43;
      Checked := MainForm.JabberToolButton.Visible;
    end;
  // Добавляем MRA протокол
  with ProtocolsListView.Items.Add do
    begin
      Caption := C_BN + Lang_Vars[12].L_S;
      GroupID := 2;
      ImageIndex := 66;
      Checked := MainForm.MRAToolButton.Visible;
    end;
  ProtocolsListView.Items.EndUpdate;
  // Подгружаем названия звуков и их дефолтные значения
  with SoundPathListView do
    begin
      Items[0].Caption := V_SoundConnect_Name;
      Items[0].Checked := True;
      V_SoundConnect_Path := Format(V_MyPath + V_SoundConnect_Mask, [V_CurrentSounds]);
      Items[0].SubItems[0] := V_SoundConnect_Path;
      //
      Items[1].Caption := V_SoundIncMsg_Name;
      Items[1].Checked := True;
      V_SoundIncMsg_Path := Format(V_MyPath + V_SoundIncMsg_Mask, [V_CurrentSounds]);
      Items[1].SubItems[0] := V_SoundIncMsg_Path;
      //
      Items[2].Caption := V_SoundMsgSend_Name;
      Items[2].Checked := True;
      V_SoundMsgSend_Path := Format(V_MyPath + V_SoundMsgSend_Mask, [V_CurrentSounds]);
      Items[2].SubItems[0] := V_SoundMsgSend_Path;
      //
      Items[3].Caption := V_SoungUserOnline_Name;
      Items[3].Checked := True;
      V_SoungUserOnline_Path := Format(V_MyPath + V_SoungUserOnline_Mask, [V_CurrentSounds]);
      Items[3].SubItems[0] := V_SoungUserOnline_Path;
      //
      Items[4].Caption := V_SoundEvent_Name;
      Items[4].Checked := True;
      V_SoundEvent_Path := Format(V_MyPath + V_SoundEvent_Mask, [V_CurrentSounds]);
      Items[4].SubItems[0] := V_SoundEvent_Path;
      //
      Items[5].Caption := V_SoundFileSend_Name;
      Items[5].Checked := True;
      V_SoundFileSend_Path := Format(V_MyPath + V_SoundFileSend_Mask, [V_CurrentSounds]);
      Items[5].SubItems[0] := V_SoundFileSend_Path;
      //
      Items[6].Caption := V_SoundError_Name;
      Items[6].Checked := True;
      V_SoundError_Path := Format(V_MyPath + V_SoundError_Mask, [V_CurrentSounds]);
      Items[6].SubItems[0] := V_SoundError_Path;
      //
      Items[7].Caption := V_SoundUserOffline_Name;
      Items[7].Checked := True;
      V_SoundUserOffline_Path := Format(V_MyPath + V_SoundUserOffline_Mask, [V_CurrentSounds]);
      Items[7].SubItems[0] := V_SoundUserOffline_Path;
    end;
  // Считываем настройки из xml файла
  if FileExists(V_ProfilePath + C_SettingsFileName) then
    begin
      // Инициализируем XML
      JvXML_Create(JvXML);
      try
        with JvXML do
          begin
            LoadFromFile(V_ProfilePath + C_SettingsFileName);
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_Settings];
                if XML_Node <> nil then
                  begin
                    // ----------------------------------------------------------------------
                    // Загружаем и отображаем настройки Прокси
                    Sub_Node := XML_Node.Items.ItemNamed[C_Proxy];
                    if Sub_Node <> nil then
                      begin
                        ProxyAddressEdit.Text := Sub_Node.Properties.Value(C_Host);
                        ProxyPortEdit.Text := Sub_Node.Properties.Value(C_Port);
                        ProxyTypeComboBox.ItemIndex := Sub_Node.Properties.IntValue(C_ProxyType);
                        ProxyVersionComboBox.ItemIndex := Sub_Node.Properties.IntValue(C_ProxyVersion);
                        ProxyAuthCheckBox.Checked := Sub_Node.Properties.BoolValue(C_Auth);
                        ProxyLoginEdit.Text := Sub_Node.Properties.Value(C_Login);
                        ProxyPasswordEdit.Text := Base64Decode(Sub_Node.Properties.Value(C_Pass));
                        NTLMCheckBox.Checked := Sub_Node.Properties.BoolValue(C_ProxyNTLM);
                        ProxyEnableCheckBox.Checked := Sub_Node.BoolValue;
                        ProxyEnableCheckBoxClick(nil);
                      end;
                    // ----------------------------------------------------------------------
                    // Загружаем и отображаем Общие настройки
                    // Загружаем запуск свёрнутой в трэй
                    Sub_Node := XML_Node.Items.ItemNamed[C_StartInTray];
                    if Sub_Node <> nil then
                      HideInTrayProgramStartCheckBox.Checked := Sub_Node.BoolValue;
                    // Загружаем проверять наличие новой версии при запуске
                    Sub_Node := XML_Node.Items.ItemNamed[C_UpdateCheck];
                    if Sub_Node <> nil then
                      AutoUpdateCheckBox.Checked := Sub_Node.BoolValue;
                    // Загружаем приоритет программы
                    Sub_Node := XML_Node.Items.ItemNamed[C_HPriority];
                    if Sub_Node <> nil then
                      BestPrioritetCheckBox.Checked := Sub_Node.BoolValue;
                    // ----------------------------------------------------------------------
                    // Загружаем и отображаем настройки КЛ
                    Sub_Node := XML_Node.Items.ItemNamed[C_CLForm];
                    if Sub_Node <> nil then
                      begin
                        // Загружаем поверх всех окон
                        AlwaylTopCheckBox.Checked := Sub_Node.Properties.BoolValue(C_AlwaysTop);
                        // Загружаем настройки прозрачности списка контактов
                        TransparentTrackBar.Position := Sub_Node.Properties.IntValue(C_TrValue);
                        // Загружаем прозрачность неактивноно окна списка контактов
                        TransparentNotActiveCheckBox.Checked := Sub_Node.Properties.BoolValue(C_TrActive);
                        // Загружаем автоскрытие списка контактов
                        AutoHideCLCheckBox.Checked := Sub_Node.Properties.BoolValue(C_AutoHide);
                        // Загружаем время автоскрытия списка контактов
                        AutoHideClEdit.Text := Sub_Node.Properties.Value(C_AutoHideS);
                        // Загружаем заголовок окна списка контактов
                        HeaderTextEdit.Text := Sub_Node.Properties.Value(C_CLHeader);
                        // Загружаем показ кнопки на панели задач
                        NoTaskBarMainButtonCheckBox.Checked := Sub_Node.Properties.BoolValue(C_NoTask);
                      end;
                    // ----------------------------------------------------------------------
                    // Загружаем настройки окна чата
                    Sub_Node := XML_Node.Items.ItemNamed[C_Chat];
                    if Sub_Node <> nil then
                    begin
                      // Загружаем звуки нажатия клавиш
                      KeyboardSoundsCheckBox.Checked := Sub_Node.Properties.BoolValue(C_KeySounds);
                    end;
                    // ----------------------------------------------------------------------
                    // Загружаем и отображаем настройки Подключения
                    // Загружаем пересоединение при разрыве соединения
                    Sub_Node := XML_Node.Items.ItemNamed[C_Recon];
                    if Sub_Node <> nil then
                      ReconnectCheckBox.Checked := Sub_Node.BoolValue;
                    // ----------------------------------------------------------------------
                    // Загружаем настройки Смайликов
                    Sub_Node := XML_Node.Items.ItemNamed[C_Smile];
                    if Sub_Node <> nil then
                      begin
                        TextSmiliesCheckBox.Checked := Sub_Node.Properties.BoolValue(C_TextSmile);
                        V_CurrentSmiles := Sub_Node.Value;
                      end;
                    // ----------------------------------------------------------------------
                    // Загружаем и отображаем настройки Звука
                    SoundOnOffCheckBox.OnClick := nil;
                    SoundOnOffCheckBox.Checked := MainForm.SoundOnOffToolButton.Down;
                    SoundOnOffCheckBox.OnClick := SoundOnOffCheckBoxClick;
                    // Заполняем список звуков
                    Sub_Node := XML_Node.Items.ItemNamed[C_Sounds];
                    if Sub_Node <> nil then
                      begin
                        V_CurrentSounds := Sub_Node.Properties.Value('p');
                        with SoundPathListView do
                          begin
                            OnChange := nil;
                            for I := 0 to Items.Count - 1 do
                              begin
                                Tri_Node := Sub_Node.Items.ItemNamed['s' + IntToStr(I)];
                                if Tri_Node <> nil then
                                  begin
                                    Items[I].SubItems[0] := Tri_Node.Properties.Value('p');
                                    Items[I].Checked := Tri_Node.BoolValue;
                                  end;
                              end;
                            OnChange := SoundPathListViewChange;
                          end;
                      end;
                  end;
                // Назначаем учётные записи протоколов
                with ProtocolsListView do
                  begin
                    // ICQ
                    XML_Node := Root.Items.ItemNamed[C_Icq];
                    if XML_Node <> nil then
                      Items[0].Caption := C_BN + XML_Node.Properties.Value(C_Login);
                    if Items[0].Caption = C_BN then
                      Items[0].Caption := C_BN + Lang_Vars[12].L_S;
                    // Jabber
                    XML_Node := Root.Items.ItemNamed[C_Jabber];
                    if XML_Node <> nil then
                      Items[1].Caption := C_BN + XML_Node.Properties.Value(C_Login);
                    if Items[1].Caption = C_BN then
                      Items[1].Caption := C_BN + Lang_Vars[12].L_S;
                    // MRA
                    XML_Node := Root.Items.ItemNamed[C_Mra];
                    if XML_Node <> nil then
                      Items[2].Caption := C_BN + XML_Node.Properties.Value(C_Login);
                    if Items[2].Caption = C_BN then
                      Items[2].Caption := C_BN + Lang_Vars[12].L_S;
                  end;
              end;
          end;
      finally
        JvXML.Free;
      end;
    end;
  // Заголовок по умолчанию
  if HeaderTextEdit.Text = EmptyStr then
    HeaderTextEdit.Text := MainForm.Caption;
  // Устанавливаем список папок со Смайлпаками
  SmiliesComboBox.Clear;
  for Folder in TDirectory.GetDirectories(V_MyPath + C_SmiliesFolder) do
    SmiliesComboBox.Items.Add(IcsExtractLastDir(Folder));
  SmiliesComboBox.ItemIndex := SmiliesComboBox.Items.IndexOf(V_CurrentSmiles);
  SmiliesComboBoxChange(nil);
  // Устанавливаем список папок с Иконпаками
  IconsComboBox.Clear;
  for Folder in TDirectory.GetDirectories(V_MyPath + C_IconsFolder) do
    IconsComboBox.Items.Add(IcsExtractLastDir(Folder));
  IconsComboBox.ItemIndex := IconsComboBox.Items.IndexOf(V_CurrentIcons);
  IconsComboBoxChange(nil);
  // Устанавливаем список папок со Звуками
  SoundPackComboBox.Clear;
  for Folder in TDirectory.GetDirectories(V_MyPath + C_SoundsFolder) do
    SoundPackComboBox.Items.Add(IcsExtractLastDir(Folder));
  SoundPackComboBox.ItemIndex := SoundPackComboBox.Items.IndexOf(V_CurrentSounds);
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
end;

{$ENDREGION}
{$REGION 'ApplySettings'}

procedure TSettingsForm.ApplySettings;
var
  I: Integer;
  FOptions: TBorderIcons;
begin
  // Применяем настройки прокси
  with MainForm do
    begin
      // HTTP сокет для обновлений программы
      if UpdateHttpClient.State <> HttpConnected then
        begin
          UpdateHttpClient.Abort;
          ApplyProxyHttpClient(UpdateHttpClient);
        end;
      // HTTP сокет для Twitter протокола
      if TwitterHttpClient.State <> HttpConnected then
        begin
          TwitterHttpClient.Abort;
          ApplyProxyHttpClient(TwitterHttpClient);
        end;
      // HTTP сокет для аватар MRA протокола
      if MRAAvatarHttpClient.State <> HttpConnected then
        begin
          MRAAvatarHttpClient.Abort;
          ApplyProxyHttpClient(MRAAvatarHttpClient);
        end;
      // HTTP сокет для передачи файлов
      if (Assigned(FileTransferForm)) and (FileTransferForm.SendFileHttpClient.State <> HttpConnected) then
        begin
          FileTransferForm.SendFileHttpClient.Abort;
          ApplyProxyHttpClient(FileTransferForm.SendFileHttpClient);
        end;
      // HTTP сокет для переводчика
      if (Assigned(GtransForm)) and (GtransForm.GtransHttpClient.State <> HttpConnected) then
        begin
          GtransForm.GtransHttpClient.Abort;
          ApplyProxyHttpClient(GtransForm.GtransHttpClient);
        end;
      // HTTP сокет для игр
      if (Assigned(GamesForm)) and (GamesForm.GameLoadHttpClient.State <> HttpConnected) then
        begin
          GamesForm.GameLoadHttpClient.Abort;
          ApplyProxyHttpClient(GamesForm.GameLoadHttpClient);
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
  // Если запускать программу с высоким приоритетом
  if BestPrioritetCheckBox.Checked then
    begin
      // Устанавливаем высокий приоритет приложению
      SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
      SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST);
    end;
  // --------------------------------------------------------------------------
  // Применяем настройки для списка контактов
  if AlwaylTopCheckBox.Checked then // Применяем "Поверх всех окон"
    MainForm.FormStyle := FsStayOnTop
  else
    MainForm.FormStyle := FsNormal;
  // Применяем настройки прозрачности
  if TransparentTrackBar.Position > 0 then
    begin
      V_RoasterAlphaBlend := True;
      MainForm.AlphaBlend := True;
      V_RoasterAlphaValue := 255 - TransparentTrackBar.Position;
    end
  else
    begin
      V_RoasterAlphaBlend := False;
      MainForm.AlphaBlend := False;
      MainForm.AlphaBlendValue := 255;
      V_RoasterAlphaValue := 255;
    end;
  V_AlphaBlendInactive := TransparentNotActiveCheckBox.Checked;
  // Применяем настройки автоскрытия списка контактов
  if AutoHideClEdit.Text = EmptyStr then
    AutoHideClEdit.Text := '10';
  MainForm.JvTimerList.Events[6].Interval := (StrToInt(AutoHideClEdit.Text) * 1000);
  MainForm.JvTimerList.Events[6].Enabled := AutoHideCLCheckBox.Checked;
  // Применяем настройку залоговка окна списка контактов
  MainForm.Caption := HeaderTextEdit.Text;
  // Применяем настройки показа кнопки окна КЛ на панели задач
  FOptions := [];
  if NoTaskBarMainButtonCheckBox.Checked then
    Include(FOptions, biSystemMenu)
  else
    begin
      Include(FOptions, biSystemMenu);
      Include(FOptions, biMinimize);
    end;
  MainForm.BorderIcons := FOptions;
  MainForm.OnShow(nil);
  // --------------------------------------------------------------------------
  // Применяем настройки смайликов
  if SmiliesComboBox.Text <> V_CurrentSmiles then
    begin
      V_CurrentSmiles := SmiliesComboBox.Text;
      if Assigned(SmilesForm) then
        begin
          // Подгружаем обозначения смайлов
          if FileExists(V_MyPath + Format(C_SmiliesPath, [V_CurrentSmiles])) then
            V_SmilesList.LoadFromFile(V_MyPath + Format(C_SmiliesPath, [V_CurrentSmiles]), TEncoding.UTF8);
          // Пересоздаём окно смайлов
          FreeAndNil(SmilesForm);
          SmilesForm := TSmilesForm.Create(nil);
        end;
    end;
  // Применяем текстовые смайлы
  V_TextSmilies := TextSmiliesCheckBox.Checked;
  // --------------------------------------------------------------------------
  // Применяем настройки Звуков
  if SoundPackComboBox.Text <> V_CurrentSounds then
    V_CurrentSounds := SoundPackComboBox.Text;
  with SoundPathListView do
    begin
      for I := 0 to Items.Count - 1 do
        begin
          case I of
            0: begin
                V_SoundConnect := Items[I].Checked;
                V_SoundConnect_Path := Items[I].SubItems[0];
              end;
            1: begin
                V_SoundIncMsg := Items[I].Checked;
                V_SoundIncMsg_Path := Items[I].SubItems[0];
              end;
            2: begin
                V_SoundMsgSend := Items[I].Checked;
                V_SoundMsgSend_Path := Items[I].SubItems[0];
              end;
            3: begin
                V_SoungUserOnline := Items[I].Checked;
                V_SoungUserOnline_Path := Items[I].SubItems[0];
              end;
            4: begin
                V_SoundEvent := Items[I].Checked;
                V_SoundEvent_Path := Items[I].SubItems[0];
              end;
            5: begin
                V_SoundFileSend := Items[I].Checked;
                V_SoundFileSend_Path := Items[I].SubItems[0];
              end;
            6: begin
                V_SoundError := Items[I].Checked;
                V_SoundError_Path := Items[I].SubItems[0];
              end;
            7: begin
                V_SoundUserOffline := Items[I].Checked;
                V_SoundUserOffline_Path := Items[I].SubItems[0];
              end;
          end;
        end;
    end;
  // --------------------------------------------------------------------------
  // Если файл с настройками не создан, то сохраняем его
  if not FileExists(V_ProfilePath + C_SettingsFileName) then
    SaveSettings;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
end;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TSettingsForm.SaveSettings;
var
  Lang: string;
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  ForceDirectories(V_ProfilePath + C_HistoryFolder);
  ForceDirectories(V_ProfilePath + C_AvatarFolder);
  ForceDirectories(V_ProfilePath + C_AnketaFolder);
  ForceDirectories(V_ProfilePath + C_GamesFolder);
  // Записываем настройки программы в файл
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_ProfilePath + C_SettingsFileName) then
          LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
          begin
            // Очищаем раздел настроек если он есть
            XML_Node := Root.Items.ItemNamed[C_Settings];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(C_Settings);
            // --------------------------------------------------------------------
            // Записываем настройки прокси
            Sub_Node := XML_Node.Items.Add(C_Proxy);
            Sub_Node.Properties.Add(C_Host, ProxyAddressEdit.Text);
            Sub_Node.Properties.Add(C_Port, ProxyPortEdit.Text);
            Sub_Node.Properties.Add(C_ProxyType, ProxyTypeComboBox.ItemIndex);
            Sub_Node.Properties.Add(C_ProxyVersion, ProxyVersionComboBox.ItemIndex);
            Sub_Node.Properties.Add(C_Auth, ProxyAuthCheckBox.Checked);
            Sub_Node.Properties.Add(C_Login, ProxyLoginEdit.Text);
            Sub_Node.Properties.Add(C_Pass, Base64Encode(ProxyPasswordEdit.Text));
            Sub_Node.Properties.Add(C_ProxyNTLM, NTLMCheckBox.Checked);
            Sub_Node.BoolValue := ProxyEnableCheckBox.Checked;
            // --------------------------------------------------------------------
            // Сохраняем Общие настройки
            // Сохраняем запуск свёрнутой в трэй
            XML_Node.Items.Add(C_StartInTray, HideInTrayProgramStartCheckBox.Checked);
            // Сохраняем проверять наличие новой версии при запуске
            XML_Node.Items.Add(C_UpdateCheck, AutoUpdateCheckBox.Checked);
            // Сохраняем приоритет программы
            XML_Node.Items.Add(C_HPriority, BestPrioritetCheckBox.Checked);
            // --------------------------------------------------------------------
            // Сохраняем настройки КЛ
            Sub_Node := XML_Node.Items.Add(C_CLForm);
            // Сохраняем поверх всех окон
            Sub_Node.Properties.Add(C_AlwaysTop, AlwaylTopCheckBox.Checked);
            // Сохраняем настройки прозрачности списка контактов
            Sub_Node.Properties.Add(C_TrValue, TransparentTrackBar.Position);
            // Сохраняем прозрачность неактивноно окна списка контактов
            Sub_Node.Properties.Add(C_TrActive, TransparentNotActiveCheckBox.Checked);
            // Сохраняем автоскрытие списка контактов
            Sub_Node.Properties.Add(C_AutoHide, AutoHideCLCheckBox.Checked);
            Sub_Node.Properties.Add(C_AutoHideS, AutoHideClEdit.Text);
            // Сохраняем заголовок окна списка контактов
            Sub_Node.Properties.Add(C_CLHeader, HeaderTextEdit.Text);
            // Сохраняем показ кнопки на панели задач
            Sub_Node.Properties.Add(C_NoTask, NoTaskBarMainButtonCheckBox.Checked);
            // --------------------------------------------------------------------
            // Сохраняем настройки Подключения
            // Сохраняем пересоединяться при разрыве соединения
            XML_Node.Items.Add(C_Recon, ReconnectCheckBox.Checked);
            // --------------------------------------------------------------------
            // Сохраняем настройки Смайликов
            XML_Node.Items.Add(C_Smile, V_CurrentSmiles).Properties.Add(C_TextSmile, TextSmiliesCheckBox.Checked);
            // --------------------------------------------------------------------
            // Сохраняем настройки Звуков
            Sub_Node := XML_Node.Items.Add(C_Sounds);
            Sub_Node.Properties.Add('p', V_CurrentSounds);
            with SoundPathListView do
              for I := 0 to Items.Count - 1 do
                Sub_Node.Items.Add('s' + IntToStr(I), Items[I].Checked).Properties.Add('p', Items[I].SubItems[0]);
            // --------------------------------------------------------------------
            // Сохраняем настройки окна чата
            Sub_Node := XML_Node.Items.Add(C_Chat);
            Sub_Node.Properties.Add(C_KeySounds, KeyboardSoundsCheckBox.Checked);
            // --------------------------------------------------------------------
            // Записываем сам файл
            SaveToFile(V_ProfilePath + C_SettingsFileName);
          end;
      end;
  finally
    JvXML.Free;
  end;
  // --------------------------------------------------------------------------
  // Сохраняем настройки для окна выбора профиля
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        LoadFromFile(V_Profile + C_ProfilesFileName);
        if Root <> nil then
          begin
            // Применяем показ окна выбора профиля
            XML_Node := Root.Items.ItemNamed[C_Auto];
            if XML_Node <> nil then
              XML_Node.BoolValue := NoShowProfileFormCheckBox.Checked;
            // Применяем настройки языка
            Lang := IsolateTextString(LangComboBox.Items.Names[LangComboBox.ItemIndex], '[', ']');
            if Lang <> V_CurrentLang then
              begin
                V_CurrentLang := Lang;
                // Записываем настройку языка
                XML_Node := Root.Items.ItemNamed[C_Lang];
                if XML_Node <> nil then
                  XML_Node.Value := V_CurrentLang;
                // Подгружаем переменные языка
                SetLangVars;
                // Переводим все открытые формы
                for I := 0 to Screen.FormCount - 1 do
                  begin
                    if Screen.Forms[I].HelpFile = 'T' then
                      Screen.Forms[I].OnDblClick(nil);
                  end;
              end;
            // Записываем сам файл
            SaveToFile(V_Profile + C_ProfilesFileName);
          end;
      end;
  finally
    JvXML.Free;
  end;
  // --------------------------------------------------------------------------
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TSettingsForm.LangDownButtonClick(Sender: TObject);
begin
  // Открываем страничку загрузки
  OpenURL(C_DownPage);
end;

procedure TSettingsForm.CancelBitBtnClick(Sender: TObject);
begin
  // Закрываем окно настроек
  Close;
end;

procedure TSettingsForm.OKBitBtnClick(Sender: TObject);
begin
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyBitBtn.Enabled then
    ApplyBitBtnClick(Self);
  // Закрываем окно
  Close;
end;

procedure TSettingsForm.OpenProfileSpeedButtonClick(Sender: TObject);
begin
  // Открываем папку с профилями
  ShellExecute(0, 'open', PChar(V_ProfilePath), nil, nil, SW_SHOW);
end;

procedure TSettingsForm.AddProtoBitBtnClick(Sender: TObject);
begin
  // Включаем или Отключаем выбранный протокол
  if ProtocolsListView.Selected <> nil then
    begin
      ProtocolsListView.Selected.Checked := not ProtocolsListView.Selected.Checked;
      ProtocolsListViewClick(nil);
    end;
end;

procedure TSettingsForm.ApplyBitBtnClick(Sender: TObject);
begin
  // Применяем настройки
  ApplySettings;
  // Сохраняем настройки
  SaveSettings;
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

{$ENDREGION}
{$REGION 'SettingsProtoBitBtnClick'}

procedure TSettingsForm.SettingsProtoBitBtnClick(Sender: TObject);
begin
  // Открываем окно настройки выбранного протокола
  if ProtocolsListView.Selected.index = 0 then
    MainForm.ICQSettingsClick(Self)
  else if ProtocolsListView.Selected.index = 1 then
    MainForm.JabberSettingsClick(Self)
  else if ProtocolsListView.Selected.index = 2 then
    MainForm.MRASettingsClick(Self);
end;

{$ENDREGION}
{$REGION 'SmiliesComboBoxChange'}

procedure TSettingsForm.SmiliesComboBoxChange(Sender: TObject);
var
  FilePath: string;
  List: TStringList;
begin
  // Подгружаем информацию о смайлпаке
  FilePath := V_MyPath + Format(C_SmiliesPath, [SmiliesComboBox.Text]);
  if FileExists(FilePath) then
    begin
      List := TStringList.Create;
      try
        List.LoadFromFile(FilePath);
        SmiliesInfoRichEdit.Lines.Text := CheckText_RN(IsoLateTextString(List.Strings[0], '<info>', '</info>'));
        // Прокручиваем рич в верх против глюка в вайн
        SendMessage(SmiliesInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
        // Активируем кнопку Применить
        ApplyBitBtn.Enabled := True;
      finally
        List.Free;
      end;
    end
  else
    SmiliesInfoRichEdit.Lines.Text := EmptyStr;
end;

{$ENDREGION}
{$REGION 'SoundOnOffCheckBoxClick'}

procedure TSettingsForm.SoundOnOffCheckBoxClick(Sender: TObject);
begin
  // Включаем или выключаем звуки
  if SoundOnOffCheckBox.Checked then
    begin
      MainForm.SoundOnOffToolButton.Down := True;
      MainForm.SoundOnOffToolButtonClick(nil);
      SoundOffForStatusCheckBox.Enabled := False;
      SoundAlwaysUniqCheckBox.Enabled := False;
    end
  else
    begin
      MainForm.SoundOnOffToolButton.Down := False;
      MainForm.SoundOnOffToolButtonClick(nil);
      SoundOffForStatusCheckBox.Enabled := True;
      SoundAlwaysUniqCheckBox.Enabled := True;
    end;
end;

{$ENDREGION}
{$REGION 'SoundPackComboBoxChange'}

procedure TSettingsForm.SoundPackComboBoxChange(Sender: TObject);
begin
  // Переписываем список на новый путь к звукам
  with SoundPathListView do
    begin
      Items[0].SubItems[0] := Format(V_MyPath + V_SoundConnect_Mask, [SoundPackComboBox.Text]);
      //
      Items[1].SubItems[0] := Format(V_MyPath + V_SoundIncMsg_Mask, [SoundPackComboBox.Text]);
      //
      Items[2].SubItems[0] := Format(V_MyPath + V_SoundMsgSend_Mask, [SoundPackComboBox.Text]);
      //
      Items[3].SubItems[0] := Format(V_MyPath + V_SoungUserOnline_Mask, [SoundPackComboBox.Text]);
      //
      Items[4].SubItems[0] := Format(V_MyPath + V_SoundEvent_Mask, [SoundPackComboBox.Text]);
      //
      Items[5].SubItems[0] := Format(V_MyPath + V_SoundFileSend_Mask, [SoundPackComboBox.Text]);
      //
      Items[6].SubItems[0] := Format(V_MyPath + V_SoundError_Mask, [SoundPackComboBox.Text]);
      //
      Items[7].SubItems[0] := Format(V_MyPath + V_SoundUserOffline_Mask, [SoundPackComboBox.Text]);
    end;
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TSettingsForm.SoundPathListViewChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
end;

procedure TSettingsForm.SoundPlaySpeedButtonClick(Sender: TObject);
begin
  // Проигрываем выбранный звук
  with SoundPathListView do
    if Selected <> nil then
      if FileExists(Selected.SubItems[0]) then
        Sndplaysound(PChar(Selected.SubItems[0]), Snd_async);
end;

procedure TSettingsForm.ProtocolsListViewChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  // Подсвечиваем выбранный пункт
  ChangeProtoItem := Item;
end;

{$ENDREGION}
{$REGION 'ProtocolsListViewClick'}

procedure TSettingsForm.ProtocolsListViewClick(Sender: TObject);
begin
  if ChangeProtoItem <> nil then
    ProtocolsListView.Selected := ChangeProtoItem;
  // Управляем включением и отключением протоколов
  // ICQ
  with MainForm do
    begin
      if (not ProtocolsListView.Items[0].Checked) and (ICQToolButton.Visible) then
        ICQ_Enable(False)
      else if (ProtocolsListView.Items[0].Checked) and (not ICQToolButton.Visible) then
        ICQ_Enable(True);
      // Jabber
      if (not ProtocolsListView.Items[1].Checked) and (JabberToolButton.Visible) then
        Jab_Enable(False)
      else if (ProtocolsListView.Items[1].Checked) and (not JabberToolButton.Visible) then
        Jab_Enable(True);
      // MRA
      if (not ProtocolsListView.Items[2].Checked) and (MRAToolButton.Visible) then
        MRA_Enable(False)
      else if (ProtocolsListView.Items[2].Checked) and (not MRAToolButton.Visible) then
        MRA_Enable(True);
    end;
  // Активируем или деактивируем кнопку настроек протокола
  if ProtocolsListView.Selected <> nil then
    begin
      if ProtocolsListView.Selected.Checked then
        begin
          AddProtoBitBtn.Enabled := False;
          DeleteProtoBitBtn.Enabled := True;
        end
      else
        begin
          AddProtoBitBtn.Enabled := True;
          DeleteProtoBitBtn.Enabled := False;
        end;
      SettingsProtoBitBtn.Enabled := True;
    end
  else
    begin
      AddProtoBitBtn.Enabled := False;
      SettingsProtoBitBtn.Enabled := False;
      DeleteProtoBitBtn.Enabled := False;
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TSettingsForm.ProtocolsListViewKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Запускаем событие по клику на галочку
  ProtocolsListViewClick(Self);
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

{$ENDREGION}
{$REGION 'ProxyEnableCheckBoxClick'}

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

{$ENDREGION}
{$REGION 'Other'}

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
  MainForm.AlphaBlendValue := V_RoasterAlphaValue;
  MainForm.AlphaBlend := V_RoasterAlphaBlend;
end;

procedure TSettingsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TSettingsForm.TransparentTrackBarChange(Sender: TObject);
begin
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
  // Активируем режим прозрачности у списка контактов
  MainForm.AlphaBlend := True;
  MainForm.AlphaBlendValue := 255 - TransparentTrackBar.Position;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем иконку окна
  MainForm.AllImageList.GetIcon(2, Icon);
  // Устанавливаем иконки на кнопки
  MainForm.AllImageList.GetBitmap(3, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(222, ApplyBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(186, AddProtoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(2, SettingsProtoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(139, DeleteProtoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(252, SoundPlaySpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(227, OpenProfileSpeedButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Назначаем разделитель значений для списков
  LangComboBox.Items.NameValueSeparator := C_BN;
  // Загружаем настройки
  LoadSettings;
  ProxyTypeComboBox.OnSelect := ProxyTypeComboBoxSelect;
  // Устанавливаем язык
  LangComboBox.ItemIndex := LangComboBox.Items.IndexOfName('[' + V_CurrentLang + ']');
  LangComboBoxChange(nil);
  // Устанавливаем перевод
  TranslateForm;
  // Заполняем путь к профилю
  ProfilePathEdit.Text := V_ProfilePath;
  NoShowProfileFormCheckBox.Checked := V_ProfileAuto;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  ProxyTypeComboBox.OnSelect := ProxyTypeComboBoxSelect;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
  // Становимся на первую вкладку
  SettingsJvPageList.ActivePageIndex := 0;
  SettingButtonGroup.ItemIndex := 0;
end;

{$ENDREGION}
{$REGION 'IconsComboBoxChange'}

procedure TSettingsForm.IconsComboBoxChange(Sender: TObject);
var
  FilePath: string;
begin
  // Подгружаем информацию о смайлпаке
  FilePath := V_MyPath + 'Icons\' + IconsComboBox.Text + '\info.txt';
  if FileExists(FilePath) then
    begin
      IconsInfoRichEdit.Lines.LoadFromFile(FilePath, TEncoding.UTF8);
      // Прокручиваем рич в верх против глюка в вайн
      SendMessage(SmiliesInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
    end
  else
    IconsInfoRichEdit.Lines.Text := EmptyStr;
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TSettingsForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelBitBtn.Caption := Lang_Vars[9].L_S;
  ApplyBitBtn.Caption := Lang_Vars[10].L_S;
  SmiliesDownButton.Caption := LangDownButton.Caption;
  IconsDownButton.Caption := LangDownButton.Caption;
  DownSoundButton.Caption := LangDownButton.Caption;
end;

{$ENDREGION}
{$REGION 'ApplyProxyHttpClient'}

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

{$ENDREGION}
{$REGION 'ApplyProxySocketClient'}

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
              V_HttpProxy_Enable := True;
              // Назначаем адрес HTTP прокси и порт
              V_HttpProxy_Address := ProxyAddressEdit.Text;
              V_HttpProxy_Port := ProxyPortEdit.Text;
              // Назначаем авторизацию на HTTP прокси
              if ProxyAuthCheckBox.Checked then
                begin
                  V_HttpProxy_Auth := True;
                  V_HttpProxy_Login := ProxyLoginEdit.Text;
                  V_HttpProxy_Password := ProxyPasswordEdit.Text;
                end
              else
                begin
                  // Сбрасываем авторизацию HTTP прокси
                  V_HttpProxy_Auth := False;
                  V_HttpProxy_Login := EmptyStr;
                  V_HttpProxy_Password := EmptyStr;
                end;
            end
          else
            begin
              // Убираем флаг, что для сокета активен режим через HTTP прокси
              V_HttpProxy_Enable := False;
              // Сбрасываем адрес HTTP прокси и порт
              V_HttpProxy_Address := EmptyStr;
              V_HttpProxy_Port := EmptyStr;
              // Сбрасываем авторизацию HTTP прокси
              V_HttpProxy_Auth := False;
              V_HttpProxy_Login := EmptyStr;
              V_HttpProxy_Password := EmptyStr;
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
          V_HttpProxy_Enable := False;
          // Сбрасываем адрес HTTP прокси и порт
          V_HttpProxy_Address := EmptyStr;
          V_HttpProxy_Port := EmptyStr;
          // Сбрасываем авторизацию HTTP прокси
          V_HttpProxy_Auth := False;
          V_HttpProxy_Login := EmptyStr;
          V_HttpProxy_Password := EmptyStr;
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

{$ENDREGION}

end.
