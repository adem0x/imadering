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
  IOUtils,
  Menus,
  JvAppHotKey;

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
    PopupGroupBox: TGroupBox;
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
    PopupPosLabel: TLabel;
    PopupPosComboBox: TComboBox;
    PopupShowLabel: TLabel;
    PopupShowEdit: TEdit;
    SecondsLabel: TLabel;
    PopupRowsEdit: TEdit;
    PopupRowsLabel: TLabel;
    PopupContactsCheckBox: TCheckBox;
    PopupEventsLabel: TLabel;
    PopupSignOnCheckBox: TCheckBox;
    PopupSignOffCheckBox: TCheckBox;
    PopupTypingCheckBox: TCheckBox;
    PopupTestButton: TButton;
    SoundsInfoRichEdit: TRichEdit;
    PluginsInfoRichEdit: TRichEdit;
    PluginsDownButton: TButton;
    ReloadPluginsButton: TButton;
    UnloadPluginButton: TButton;
    EnableHotKeysCheckBox: TCheckBox;
    HotKeysListView: TListView;
    HotKeyEdit: THotKey;
    HotKeySetButton: TButton;
    HotKeyDellButton: TButton;
    PopupMessEnableCheckBox: TCheckBox;
    AutoOpenSiteCheckBox: TCheckBox;
    RecentGroupBox: TGroupBox;
    HistoryPathGroupBox: TGroupBox;
    SaveHistoryCheckBox: TCheckBox;
    SaveNoCLHistoryCheckBox: TCheckBox;
    SaveServiceHistoryCheckBox: TCheckBox;
    SaveSpamHistoryCheckBox: TCheckBox;
    SavePluginsHistoryCheckBox: TCheckBox;
    ShowRecentMessCheckBox: TCheckBox;
    Edit1: TEdit;
    NumberRecentMessLabel: TLabel;
    Edit2: TEdit;
    HistoryPathLabel: TLabel;
    HistoryPathSpeedButton: TSpeedButton;
    Edit3: TEdit;
    HistoryArchiveLabel: TLabel;
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
    procedure SoundPlaySpeedButtonClick(Sender: TObject);
    procedure SoundPackComboBoxChange(Sender: TObject);
    procedure OpenProfileSpeedButtonClick(Sender: TObject);
    procedure PopupTestButtonClick(Sender: TObject);
    procedure ReloadPluginsButtonClick(Sender: TObject);
    procedure ShowPluginConfigButtonClick(Sender: TObject);
    procedure UnloadPluginButtonClick(Sender: TObject);
    procedure HotKeySetButtonClick(Sender: TObject);
    procedure SoundPathListViewItemChecked(Sender: TObject; Item: TListItem);
    procedure HotKeysListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure HotKeyDellButtonClick(Sender: TObject);
    procedure HotKeysListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PopupMessEnableCheckBoxClick(Sender: TObject);

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
    procedure GetLoadedPluginsList;
    procedure HotKeysUpdate;
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
  SmilesUnit,
  OverbyteIcsUtils,
  OverbyteIcsUrl,
  ChatUnit,
  BimoidProtoUnit;

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
  LangFile := V_MyPath + C_LangsFolder + S + C_XML_Ext;
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
                LangInfoRichEdit.Lines.Text := EmptyStr;
                LangInfoRichEdit.Lines.Strings[0] := CheckText_RN(XML_Node.Properties.Value('c'));
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
  with ProtocolsListView do
  begin
    // Начинаем обновление списка
    Items.BeginUpdate;
    // ICQ протокол
    Items[0].Caption := ' ' + C_Icq + ':' + ' ' + Lang_Vars[12].L_S;
    Items[0].Checked := MainForm.ICQToolButton.Visible;
    // Jabber протокол
    Items[1].Caption := ' ' + C_Jabber + ':' + ' ' + Lang_Vars[12].L_S;
    Items[1].Checked := MainForm.JabberToolButton.Visible;
    // MRA протокол
    Items[2].Caption := ' ' + C_Mra + ':' + ' ' + Lang_Vars[12].L_S;
    Items[2].Checked := MainForm.MRAToolButton.Visible;
    // Bimoid протокол
    Items[3].Caption := ' ' + C_Bimoid + ':' + ' ' + Lang_Vars[12].L_S;
    Items[3].Checked := MainForm.BimoidToolButton.Visible;
    // Заканчиваем обновление списка
    Items.EndUpdate;
  end;
  // Подгружаем названия звуков и их дефолтные значения
  with SoundPathListView do
  begin
    Items.BeginUpdate;
    //
    Items[0].Checked := True;
    V_SoundConnect_Path := Format(V_MyPath + V_SoundConnect_Mask, [V_CurrentSounds]);
    Items[0].SubItems[0] := V_SoundConnect_Path;
    //
    Items[1].Checked := True;
    V_SoundIncMsg_Path := Format(V_MyPath + V_SoundIncMsg_Mask, [V_CurrentSounds]);
    Items[1].SubItems[0] := V_SoundIncMsg_Path;
    //
    Items[2].Checked := True;
    V_SoundMsgSend_Path := Format(V_MyPath + V_SoundMsgSend_Mask, [V_CurrentSounds]);
    Items[2].SubItems[0] := V_SoundMsgSend_Path;
    //
    Items[3].Checked := True;
    V_SoungUserOnline_Path := Format(V_MyPath + V_SoungUserOnline_Mask, [V_CurrentSounds]);
    Items[3].SubItems[0] := V_SoungUserOnline_Path;
    //
    Items[4].Checked := True;
    V_SoundEvent_Path := Format(V_MyPath + V_SoundEvent_Mask, [V_CurrentSounds]);
    Items[4].SubItems[0] := V_SoundEvent_Path;
    //
    Items[5].Checked := True;
    V_SoundFileSend_Path := Format(V_MyPath + V_SoundFileSend_Mask, [V_CurrentSounds]);
    Items[5].SubItems[0] := V_SoundFileSend_Path;
    //
    Items[6].Checked := True;
    V_SoundError_Path := Format(V_MyPath + V_SoundError_Mask, [V_CurrentSounds]);
    Items[6].SubItems[0] := V_SoundError_Path;
    //
    Items[7].Checked := True;
    V_SoundUserOffline_Path := Format(V_MyPath + V_SoundUserOffline_Mask, [V_CurrentSounds]);
    Items[7].SubItems[0] := V_SoundUserOffline_Path;
    //
    Items.EndUpdate;
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
          XML_Node := Root.Items.ItemNamed[Self.Name];
          if XML_Node <> nil then
          begin
            // ----------------------------------------------------------------------
            // Загружаем и отображаем настройки Прокси
            Sub_Node := XML_Node.Items.ItemNamed[ProxyAddressEdit.Name];
            if Sub_Node <> nil then
              ProxyAddressEdit.Text := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyPortEdit.Name];
            if Sub_Node <> nil then
              ProxyPortEdit.Text := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyTypeComboBox.Name];
            if Sub_Node <> nil then
              ProxyTypeComboBox.ItemIndex := Sub_Node.IntValue;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyVersionComboBox.Name];
            if Sub_Node <> nil then
              ProxyVersionComboBox.ItemIndex := Sub_Node.IntValue;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyAuthCheckBox.Name];
            if Sub_Node <> nil then
              ProxyAuthCheckBox.Checked := Sub_Node.BoolValue;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyLoginEdit.Name];
            if Sub_Node <> nil then
              ProxyLoginEdit.Text := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyPasswordEdit.Name];
            if Sub_Node <> nil then
              ProxyPasswordEdit.Text := UrlDecode(Base64Decode(Sub_Node.Value));
            Sub_Node := XML_Node.Items.ItemNamed[NTLMCheckBox.Name];
            if Sub_Node <> nil then
              NTLMCheckBox.Checked := Sub_Node.BoolValue;
            Sub_Node := XML_Node.Items.ItemNamed[ProxyEnableCheckBox.Name];
            if Sub_Node <> nil then
              ProxyEnableCheckBox.Checked := Sub_Node.BoolValue;
            ProxyEnableCheckBoxClick(nil);
            // ----------------------------------------------------------------------
            // Загружаем и отображаем Общие настройки
            // Загружаем запуск свёрнутой в трэй
            Sub_Node := XML_Node.Items.ItemNamed[HideInTrayProgramStartCheckBox.Name];
            if Sub_Node <> nil then
              HideInTrayProgramStartCheckBox.Checked := Sub_Node.BoolValue;
            // Загружаем проверять наличие новой версии при запуске
            Sub_Node := XML_Node.Items.ItemNamed[AutoUpdateCheckBox.Name];
            if Sub_Node <> nil then
              AutoUpdateCheckBox.Checked := Sub_Node.BoolValue;
            // Загружаем приоритет программы
            Sub_Node := XML_Node.Items.ItemNamed[BestPrioritetCheckBox.Name];
            if Sub_Node <> nil then
              BestPrioritetCheckBox.Checked := Sub_Node.BoolValue;
            // Загружаем открытие новостей IMadering
            Sub_Node := XML_Node.Items.ItemNamed[AutoOpenSiteCheckBox.Name];
            if Sub_Node <> nil then
              AutoOpenSiteCheckBox.Checked := Sub_Node.BoolValue;
            // ----------------------------------------------------------------------
            // Загружаем и отображаем настройки КЛ
            // Загружаем поверх всех окон
            Sub_Node := XML_Node.Items.ItemNamed[AlwaylTopCheckBox.Name];
            if Sub_Node <> nil then
              AlwaylTopCheckBox.Checked := Sub_Node.BoolValue;
            // Загружаем настройки прозрачности списка контактов
            Sub_Node := XML_Node.Items.ItemNamed[TransparentTrackBar.Name];
            if Sub_Node <> nil then
              TransparentTrackBar.Position := Sub_Node.IntValue;
            // Загружаем прозрачность неактивноно окна списка контактов
            Sub_Node := XML_Node.Items.ItemNamed[TransparentNotActiveCheckBox.Name];
            if Sub_Node <> nil then
              TransparentNotActiveCheckBox.Checked := Sub_Node.BoolValue;
            // Загружаем автоскрытие списка контактов
            Sub_Node := XML_Node.Items.ItemNamed[AutoHideCLCheckBox.Name];
            if Sub_Node <> nil then
              AutoHideCLCheckBox.Checked := Sub_Node.BoolValue;
            // Загружаем время автоскрытия списка контактов
            Sub_Node := XML_Node.Items.ItemNamed[AutoHideClEdit.Name];
            if Sub_Node <> nil then
              AutoHideClEdit.Text := Sub_Node.Value;
            // Загружаем заголовок окна списка контактов
            Sub_Node := XML_Node.Items.ItemNamed[HeaderTextEdit.Name];
            if Sub_Node <> nil then
              HeaderTextEdit.Text := Sub_Node.Value;
            // Загружаем показ кнопки на панели задач
            Sub_Node := XML_Node.Items.ItemNamed[NoTaskBarMainButtonCheckBox.Name];
            if Sub_Node <> nil then
              NoTaskBarMainButtonCheckBox.Checked := Sub_Node.BoolValue;
            // ----------------------------------------------------------------------
            // Загружаем настройки окна чата
            // Загружаем звуки нажатия клавиш
            Sub_Node := XML_Node.Items.ItemNamed[KeyboardSoundsCheckBox.Name];
            if Sub_Node <> nil then
              KeyboardSoundsCheckBox.Checked := Sub_Node.BoolValue;
            // ----------------------------------------------------------------------
            // Загружаем и отображаем настройки Подключения
            // Загружаем пересоединение при разрыве соединения
            Sub_Node := XML_Node.Items.ItemNamed[ReconnectCheckBox.Name];
            if Sub_Node <> nil then
              ReconnectCheckBox.Checked := Sub_Node.BoolValue;
            // ----------------------------------------------------------------------
            // Загружаем настройки Смайликов
            Sub_Node := XML_Node.Items.ItemNamed[SmiliesComboBox.Name];
            if Sub_Node <> nil then
              V_CurrentSmiles := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[TextSmiliesCheckBox.Name];
            if Sub_Node <> nil then
              TextSmiliesCheckBox.Checked := Sub_Node.BoolValue;
            // ----------------------------------------------------------------------
            // Загружаем и отображаем настройки Звука
            SoundOnOffCheckBox.Checked := MainForm.SoundOnOffToolButton.Down;
            // Заполняем список звуков
            Sub_Node := XML_Node.Items.ItemNamed[SoundPackComboBox.Name];
            if Sub_Node <> nil then
              V_CurrentSounds := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[SoundPathListView.Name];
            if Sub_Node <> nil then
            begin
              with SoundPathListView do
              begin
                Items.BeginUpdate;
                for I := 0 to Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.ItemNamed['c' + IntToStr(I)];
                  if Tri_Node <> nil then
                  begin
                    Items[I].SubItems[0] := XML2Text(Tri_Node.Properties.Value('c'));
                    Items[I].Checked := Tri_Node.BoolValue;
                  end;
                end;
                Items.EndUpdate;
              end;
            end;
            // --------------------------------------------------------------------
            // Загружаем настройки Всплывающих окон
            Sub_Node := XML_Node.Items.ItemNamed[PopupPosComboBox.Name];
            if Sub_Node <> nil then
              PopupPosComboBox.ItemIndex := Sub_Node.IntValue
            else
              PopupPosComboBox.ItemIndex := 3;
            Sub_Node := XML_Node.Items.ItemNamed[PopupShowEdit.Name];
            if Sub_Node <> nil then
              PopupShowEdit.Text := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[PopupRowsEdit.Name];
            if Sub_Node <> nil then
              PopupRowsEdit.Text := Sub_Node.Value;
            Sub_Node := XML_Node.Items.ItemNamed[PopupMessEnableCheckBox.Name];
            if Sub_Node <> nil then
              PopupMessEnableCheckBox.Checked := Sub_Node.BoolValue;
            PopupMessEnableCheckBoxClick(nil);
            // --------------------------------------------------------------------
            // Загружаем настройки Горячих клавиш
            Sub_Node := XML_Node.Items.ItemNamed[EnableHotKeysCheckBox.Name];
            if Sub_Node <> nil then
              EnableHotKeysCheckBox.Checked := Sub_Node.BoolValue;
            Sub_Node := XML_Node.Items.ItemNamed[HotKeysListView.Name];
            if Sub_Node <> nil then
            begin
              with HotKeysListView do
              begin
                Items.BeginUpdate;
                for I := 0 to Items.Count - 2 do
                begin
                  Tri_Node := Sub_Node.Items.ItemNamed['c' + IntToStr(I)];
                  if Tri_Node <> nil then
                    Items[I].SubItems[0] := Tri_Node.Value;
                end;
                Items.EndUpdate;
              end;
            end;
            // --------------------------------------------------------------------
          end;
          // Назначаем учётные записи протоколов
          with ProtocolsListView do
          begin
            // Начинаем обновление списка
            Items.BeginUpdate;
            // ICQ
            XML_Node := Root.Items.ItemNamed[C_Icq];
            if XML_Node <> nil then
            begin
              if XML_Node.Properties.Value(C_Login) <> EmptyStr then
                Items[0].Caption := ' ' + C_Icq + ':' + ' ' + XML_Node.Properties.Value(C_Login);
            end;
            // Jabber
            XML_Node := Root.Items.ItemNamed[C_Jabber];
            if XML_Node <> nil then
            begin
              if XML_Node.Properties.Value(C_Login) <> EmptyStr then
                Items[1].Caption := ' ' + C_Jabber + ':' + ' ' + XML_Node.Properties.Value(C_Login);
            end;
            // MRA
            XML_Node := Root.Items.ItemNamed[C_Mra];
            if XML_Node <> nil then
            begin
              if XML_Node.Properties.Value(C_Login) <> EmptyStr then
                Items[2].Caption := ' ' + C_Mra + ':' + ' ' + XML_Node.Properties.Value(C_Login);
            end;
            // Bimoid
            XML_Node := Root.Items.ItemNamed[C_Bimoid];
            if XML_Node <> nil then
            begin
              if XML_Node.Properties.Value(C_Login) <> EmptyStr then
                Items[2].Caption := ' ' + C_Bimoid + ':' + ' ' + XML_Node.Properties.Value(C_Login);
            end;
            // Заканчиваем обновление списка
            Items.EndUpdate;
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
  SoundPackComboBoxChange(nil);
  // Ставим дефолтное значение позиции всплывающих окон
  if PopupPosComboBox.ItemIndex = -1 then
    PopupPosComboBox.ItemIndex := V_DAPos;
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
    if HttpClient.State <> HttpConnected then
    begin
      HttpClient.Abort;
      ApplyProxyHttpClient(HttpClient);
    end;
    // HTTP сокет для Twitter протокола
    if TwitterClient.State <> HttpConnected then
    begin
      TwitterClient.Abort;
      ApplyProxyHttpClient(TwitterClient);
    end;
    // HTTP сокет для аватар MRA протокола
    if MRA_PhotoClient.State <> HttpConnected then
    begin
      MRA_PhotoClient.Abort;
      ApplyProxyHttpClient(MRA_PhotoClient);
    end;
    // HTTP сокет для передачи файлов
    {if (Assigned(FileTransferForm)) and (FileTransferForm.SendFileClient.State <> HttpConnected) then
    begin
      FileTransferForm.SendFileClient.Abort;
      ApplyProxyHttpClient(FileTransferForm.SendFileClient);
    end;
    // HTTP сокет для переводчика
    if (Assigned(GtransForm)) and (GtransForm.GtransClient.State <> HttpConnected) then
    begin
      GtransForm.GtransClient.Abort;
      ApplyProxyHttpClient(GtransForm.GtransClient);
    end;
    // HTTP сокет для игр
    if (Assigned(GamesForm)) and (GamesForm.GamesClient.State <> HttpConnected) then
    begin
      GamesForm.GamesClient.Abort;
      ApplyProxyHttpClient(GamesForm.GamesClient);
    end;}
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
  // Сокет для протокола Bimoid
  if Assigned(BimoidWSocket) then
  begin
    if BimoidWSocket.State <> WsConnected then
    begin
      BimoidWSocket.Abort;
      ApplyProxySocketClient(BimoidWSocket);
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
  // Применяем "Поверх всех окон"
  if AlwaylTopCheckBox.Checked then
    MainForm.TopModeToolButton.Down := True
  else
    MainForm.TopModeToolButton.Down := False;
  MainForm.TopModeToolButtonClick(nil);
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
  // Включаем или выключаем звуки
  if SoundOnOffCheckBox.Checked then
    MainForm.SoundOnOffToolButton.Down := True
  else
    MainForm.SoundOnOffToolButton.Down := False;
  MainForm.SoundOnOffToolButtonClick(nil);
  // Соунд пак
  if SoundPackComboBox.Text <> V_CurrentSounds then
    V_CurrentSounds := SoundPackComboBox.Text;
  with SoundPathListView do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      case I of
        0:
          begin
            V_SoundConnect := Items[I].Checked;
            V_SoundConnect_Path := Items[I].SubItems[0];
          end;
        1:
          begin
            V_SoundIncMsg := Items[I].Checked;
            V_SoundIncMsg_Path := Items[I].SubItems[0];
          end;
        2:
          begin
            V_SoundMsgSend := Items[I].Checked;
            V_SoundMsgSend_Path := Items[I].SubItems[0];
          end;
        3:
          begin
            V_SoungUserOnline := Items[I].Checked;
            V_SoungUserOnline_Path := Items[I].SubItems[0];
          end;
        4:
          begin
            V_SoundEvent := Items[I].Checked;
            V_SoundEvent_Path := Items[I].SubItems[0];
          end;
        5:
          begin
            V_SoundFileSend := Items[I].Checked;
            V_SoundFileSend_Path := Items[I].SubItems[0];
          end;
        6:
          begin
            V_SoundError := Items[I].Checked;
            V_SoundError_Path := Items[I].SubItems[0];
          end;
        7:
          begin
            V_SoundUserOffline := Items[I].Checked;
            V_SoundUserOffline_Path := Items[I].SubItems[0];
          end;
      end;
    end;
  end;
  // --------------------------------------------------------------------------
  // Применяем настройки Всплывающих окон
  if PopupPosComboBox.ItemIndex > -1 then
    V_DAPos := PopupPosComboBox.ItemIndex;
  V_DATimeShow := StrToInt(PopupShowEdit.Text);
  V_DARows := StrToInt(PopupRowsEdit.Text);
  // --------------------------------------------------------------------------
  // Применяем горячие клавиши
  HotKeysUpdate;
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
  // Вывод для плагинов "Настройки изменены []"
  MainForm.JvPluginManager.BroadcastMessage(3, EmptyStr);
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
        XML_Node := Root.Items.ItemNamed[Self.Name];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(Self.Name);
        // --------------------------------------------------------------------
        // Записываем настройки прокси
        XML_Node.Items.Add(ProxyAddressEdit.Name, ProxyAddressEdit.Text);
        XML_Node.Items.Add(ProxyPortEdit.Name, ProxyPortEdit.Text);
        XML_Node.Items.Add(ProxyTypeComboBox.Name, ProxyTypeComboBox.ItemIndex);
        XML_Node.Items.Add(ProxyVersionComboBox.Name, ProxyVersionComboBox.ItemIndex);
        XML_Node.Items.Add(ProxyAuthCheckBox.Name, ProxyAuthCheckBox.Checked);
        XML_Node.Items.Add(ProxyLoginEdit.Name, ProxyLoginEdit.Text);
        XML_Node.Items.Add(ProxyPasswordEdit.Name, Base64Encode(UrlEncode(ProxyPasswordEdit.Text)));
        XML_Node.Items.Add(NTLMCheckBox.Name, NTLMCheckBox.Checked);
        XML_Node.Items.Add(ProxyEnableCheckBox.Name, ProxyEnableCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем Общие настройки
        // Сохраняем запуск свёрнутой в трэй
        XML_Node.Items.Add(HideInTrayProgramStartCheckBox.Name, HideInTrayProgramStartCheckBox.Checked);
        // Сохраняем проверять наличие новой версии при запуске
        XML_Node.Items.Add(AutoUpdateCheckBox.Name, AutoUpdateCheckBox.Checked);
        // Сохраняем приоритет программы
        XML_Node.Items.Add(BestPrioritetCheckBox.Name, BestPrioritetCheckBox.Checked);
        // Сохраняем открытие новостей IMadering
        XML_Node.Items.Add(AutoOpenSiteCheckBox.Name, AutoOpenSiteCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем настройки КЛ
        // Сохраняем поверх всех окон
        XML_Node.Items.Add(AlwaylTopCheckBox.Name, AlwaylTopCheckBox.Checked);
        // Сохраняем настройки прозрачности списка контактов
        XML_Node.Items.Add(TransparentTrackBar.Name, TransparentTrackBar.Position);
        // Сохраняем прозрачность неактивноно окна списка контактов
        XML_Node.Items.Add(TransparentNotActiveCheckBox.Name, TransparentNotActiveCheckBox.Checked);
        // Сохраняем автоскрытие списка контактов
        XML_Node.Items.Add(AutoHideCLCheckBox.Name, AutoHideCLCheckBox.Checked);
        XML_Node.Items.Add(AutoHideClEdit.Name, AutoHideClEdit.Text);
        // Сохраняем заголовок окна списка контактов
        XML_Node.Items.Add(HeaderTextEdit.Name, HeaderTextEdit.Text);
        // Сохраняем показ кнопки на панели задач
        XML_Node.Items.Add(NoTaskBarMainButtonCheckBox.Name, NoTaskBarMainButtonCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем настройки Подключения
        // Сохраняем пересоединяться при разрыве соединения
        XML_Node.Items.Add(ReconnectCheckBox.Name, ReconnectCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем настройки Смайликов
        XML_Node.Items.Add(SmiliesComboBox.Name, V_CurrentSmiles);
        XML_Node.Items.Add(TextSmiliesCheckBox.Name, TextSmiliesCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем настройки Звуков
        XML_Node.Items.Add(SoundPackComboBox.Name, V_CurrentSounds);
        Sub_Node := XML_Node.Items.Add(SoundPathListView.Name);
        with SoundPathListView do
          for I := 0 to Items.Count - 1 do
            Sub_Node.Items.Add('c' + IntToStr(I), Items[I].Checked).Properties.Add('c', Text2XML(Items[I].SubItems[0]));
        // --------------------------------------------------------------------
        // Сохраняем настройки окна чата
        XML_Node.Items.Add(KeyboardSoundsCheckBox.Name, KeyboardSoundsCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем настройки Всплывающих окон
        XML_Node.Items.Add(PopupPosComboBox.Name, PopupPosComboBox.ItemIndex);
        XML_Node.Items.Add(PopupShowEdit.Name, PopupShowEdit.Text);
        XML_Node.Items.Add(PopupRowsEdit.Name, PopupRowsEdit.Text);
        XML_Node.Items.Add(PopupMessEnableCheckBox.Name, PopupMessEnableCheckBox.Checked);
        // --------------------------------------------------------------------
        // Сохраняем настройки Горячих клавиш
        XML_Node.Items.Add(EnableHotKeysCheckBox.Name, EnableHotKeysCheckBox.Checked);
        Sub_Node := XML_Node.Items.Add(HotKeysListView.Name);
        with HotKeysListView do
          for I := 0 to Items.Count - 2 do
            Sub_Node.Items.Add('c' + IntToStr(I), Items[I].SubItems[0]);
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
        XML_Node := Root.Items.ItemNamed[NoShowProfileFormCheckBox.Name];
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
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TSettingsForm.LangDownButtonClick(Sender: TObject);
begin
  // Открываем страничку загрузки
  OpenURL(C_SitePage);
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
    MainForm.MRASettingsClick(Self)
  else if ProtocolsListView.Selected.index = 3 then
    MainForm.Bim_SettingsClick(Self);
end;

procedure TSettingsForm.ShowPluginConfigButtonClick(Sender: TObject);
begin
  // Открываем настройки выбранного плагина
  if PluginsListView.Selected <> nil then
  begin
    MainForm.JvPluginManager.Plugins[PluginsListView.Selected.Index].Configure;
  end;
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
      SmiliesInfoRichEdit.Lines.Text := EmptyStr;
      SmiliesInfoRichEdit.Lines.Strings[0] := CheckText_RN(IsoLateTextString(List.Strings[0], '<info>', '</info>'));
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
{$REGION 'SoundPackComboBoxChange'}

procedure TSettingsForm.SoundPackComboBoxChange(Sender: TObject);
var
  FilePath: string;
begin
  // Переписываем список на новый путь к звукам
  with SoundPathListView do
  begin
    Items.BeginUpdate;
    //
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
    //
    Items.EndUpdate;
  end;
  // Подгружаем информацию о соундпаке
  FilePath := V_MyPath + C_SoundsFolder + IconsComboBox.Text + '\' + C_InfoFileName;
  if FileExists(FilePath) then
  begin
    SoundsInfoRichEdit.Lines.Text := EmptyStr;
    SoundsInfoRichEdit.Lines.Strings[0] := Trim(ReadFromFile(FilePath, False));
    // Прокручиваем рич в верх против глюка в вайн
    SendMessage(SoundsInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
  end
  else
    SoundsInfoRichEdit.Lines.Text := EmptyStr;
  // Активируем кнопку Применить
  ApplyBitBtn.Enabled := True;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TSettingsForm.SoundPathListViewItemChecked(Sender: TObject; Item: TListItem);
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

procedure TSettingsForm.PopupMessEnableCheckBoxClick(Sender: TObject);
begin
  // Активируем или деактивируем контролы всплывающих окон
  if PopupMessEnableCheckBox.Checked then
  begin
    PopupPosComboBox.Enabled := False;
    PopupPosComboBox.Color := ClBtnFace;
    PopupTestButton.Enabled := False;
    PopupShowEdit.Enabled := False;
    PopupShowEdit.Color := ClBtnFace;
    PopupRowsEdit.Enabled := False;
    PopupRowsEdit.Color := ClBtnFace;
    PopupContactsCheckBox.Enabled := False;
    PopupSignOnCheckBox.Enabled := False;
    PopupSignOffCheckBox.Enabled := False;
    PopupTypingCheckBox.Enabled := False;
  end
  else
  begin
    PopupPosComboBox.Enabled := True;
    PopupPosComboBox.Color := ClWindow;
    PopupTestButton.Enabled := True;
    PopupShowEdit.Enabled := True;
    PopupShowEdit.Color := ClWindow;
    PopupRowsEdit.Enabled := True;
    PopupRowsEdit.Color := ClWindow;
    PopupContactsCheckBox.Enabled := True;
    PopupSignOnCheckBox.Enabled := True;
    PopupSignOffCheckBox.Enabled := True;
    PopupTypingCheckBox.Enabled := True;
  end;
  // Исправляем глюк с прорисовкой TEdit
  PopupShowEdit.SendToBack;
  PopupShowEdit.BringToFront;
  PopupRowsEdit.SendToBack;
  PopupRowsEdit.BringToFront;
  // Активируем кнопку применения настроек
  ApplyBitBtn.Enabled := True;
end;

procedure TSettingsForm.PopupTestButtonClick(Sender: TObject);
var
  P, R: Integer;
begin
  // Тестируем всплывающие сообщения
  P := V_DAPos;
  R := V_DARows;
  V_DAPos := PopupPosComboBox.ItemIndex;
  V_DARows := StrToInt(PopupRowsEdit.Text);
  DAShow(Lang_Vars[16].L_S, PopupTestButton.Caption, EmptyStr, 133, 1, StrToInt(PopupShowEdit.Text));
  V_DAPos := P;
  V_DARows := R;
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
  with MainForm do
  begin
    // ICQ
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
    // Bimoid
    if (not ProtocolsListView.Items[3].Checked) and (BimoidToolButton.Visible) then
      Bim_Enable(False)
    else if (ProtocolsListView.Items[3].Checked) and (not BimoidToolButton.Visible) then
      Bim_Enable(True);
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
  // Исправляем глюк с прорисовкой TEdit
  ProxyLoginEdit.SendToBack;
  ProxyLoginEdit.BringToFront;
  ProxyPasswordEdit.SendToBack;
  ProxyPasswordEdit.BringToFront;
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
  // Исправляем глюк с прорисовкой TEdit
  ProxyAddressEdit.SendToBack;
  ProxyAddressEdit.BringToFront;
  ProxyPortEdit.SendToBack;
  ProxyPortEdit.BringToFront;
  ProxyLoginEdit.SendToBack;
  ProxyLoginEdit.BringToFront;
  ProxyPasswordEdit.SendToBack;
  ProxyPasswordEdit.BringToFront;
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
  else
    ProxyPortEdit.Text := EmptyStr;
  end;
end;

procedure TSettingsForm.ReloadPluginsButtonClick(Sender: TObject);
var
  I: Integer;
begin
  // Перезагружаем плагины
  with MainForm do
  begin
    // Выгружаем плагины
    for I := 0 to JvPluginManager.PluginCount - 1 do
      JvPluginManager.UnloadPlugin(0);
    // Очищаем меню команд плагинов
    MainForm.PluginsPopupMenu.Items.Clear;
    // Загружаем плагины
    JvPluginManager.LoadPlugins;
    // Загружаем список плагинов
    GetLoadedPluginsList;
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

procedure TSettingsForm.UnloadPluginButtonClick(Sender: TObject);
var
  PlgFileName: string;
begin
  // Выгружаем выбранный плагин
  if PluginsListView.Selected <> nil then
  begin
    // Запоминаем путь к файлу этого плагина
    PlgFileName := MainForm.JvPluginManager.Plugins[PluginsListView.Selected.Index].FileName;
    // Отключаем выбранный плагин
    MainForm.JvPluginManager.UnloadPlugin(PluginsListView.Selected.Index);
    // Удаляем файл с плагином
    if FileExists(PlgFileName) then
      DeleteFile(PlgFileName);
    // Переподключаем плагины
    ReloadPluginsButtonClick(nil);
  end;
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
  MainForm.AllImageList.GetBitmap(135, SoundPlaySpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(227, OpenProfileSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(227, HistoryPathSpeedButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Назначаем разделитель значений для списков
  LangComboBox.Items.NameValueSeparator := ' ';
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
  // Загружаем список загруженных плагинов
  GetLoadedPluginsList;
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
  // Прокручиваем рич в верх против глюка в вайн
  PluginsInfoRichEdit.SelStart := 0;
  SendMessage(PluginsInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
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
  FilePath := V_MyPath + C_IconsFolder + IconsComboBox.Text + '\' + C_InfoFileName;
  if FileExists(FilePath) then
  begin
    IconsInfoRichEdit.Lines.Text := EmptyStr;
    IconsInfoRichEdit.Lines.Strings[0] := Trim(ReadFromFile(FilePath, False));
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
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
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
  PluginsDownButton.Caption := LangDownButton.Caption;
  PluginsInfoRichEdit.Lines.Text := EmptyStr;
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем текущий файл языка
      if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
      begin
        // Загружаем файл языка
        LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
        if Root <> nil then
        begin
          // Переводим названия звуков
          XML_Node := Root.Items.ItemNamed[SoundPathListView.Name];
          if XML_Node <> nil then
          begin
            with SoundPathListView do
            begin
              // Начинаем обновление списка
              Items.BeginUpdate;
              // Заполняем названия звуков
              for I := 0 to Items.Count - 1 do
              begin
                Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
                if Sub_Node <> nil then
                  Items[I].Caption := Sub_Node.Properties.Value('c');
              end;
              // Заканчиваем обновление списка
              Items.EndUpdate;
            end;
          end;
          // Подгружаем инфы
          XML_Node := Root.Items.ItemNamed[C_Infos];
          if XML_Node <> nil then
          begin
            Sub_Node := XML_Node.Items.ItemNamed[PluginsInfoRichEdit.Name];
            if Sub_Node <> nil then
              PluginsInfoRichEdit.Lines.Strings[0] := Sub_Node.Properties.Value('c');
          end;
          // Подгружаем названия горячих клавиш
          XML_Node := Root.Items.ItemNamed['H' + 'o' + 't' + 'K' + 'e' + 'y' + 's'];
          if XML_Node <> nil then
          begin
            with HotKeysListView do
            begin
              // Начинаем обновление списка
              Items.BeginUpdate;
              // Группа изменяемых клавиш
              Sub_Node := XML_Node.Items.ItemNamed['g' + '0'];
              if Sub_Node <> nil then
                Groups.Items[0].Header := Sub_Node.Properties.Value('c');
              // Группа неизменяемых клавиш
              Sub_Node := XML_Node.Items.ItemNamed['g' + '1'];
              if Sub_Node <> nil then
                Groups.Items[1].Header := Sub_Node.Properties.Value('c');
              // Названия горячих комбинаций клавиш
              for I := 0 to Items.Count - 1 do
              begin
                Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
                if Sub_Node <> nil then
                  Items[I].Caption := XML2Text(Sub_Node.Properties.Value('c'));
              end;
              // Заканчиваем обновление списка
              Items.EndUpdate;
            end;
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Ставим дефолтное значение позиции всплывающих окон
  if PopupPosComboBox.ItemIndex = -1 then
    PopupPosComboBox.ItemIndex := V_DAPos;
  // Деактивируем кнопку применения настроек
  ApplyBitBtn.Enabled := False;
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
{$REGION 'GetLoadedPluginsList'}

procedure TSettingsForm.GetLoadedPluginsList;
var
  I: Integer;
begin
  PluginsListView.Clear;
  // Составляем список плагинов
  with MainForm do
  begin
    for I := 0 to JvPluginManager.PluginCount - 1 do
    begin
      with PluginsListView.Items.Add do
      begin
        Caption := JvPluginManager.Plugins[I].Name + ' ' + JvPluginManager.Plugins[I].PluginVersion;
        SubItems.Add(JvPluginManager.Plugins[I].Author);
        SubItems.Add(JvPluginManager.Plugins[I].Description);
      end;
    end;
    if JvPluginManager.PluginCount = 0 then
    begin
      PluginsToolButton.Visible := False;
      if Assigned(ChatForm) then
        ChatForm.PluginsToolButton.Visible := False;
    end
    else
    begin
      PluginsToolButton.Visible := True;
      if Assigned(ChatForm) then
        ChatForm.PluginsToolButton.Visible := True;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'HotKeys'}

procedure TSettingsForm.HotKeysUpdate;
var
  E: Boolean;
begin
  // Обновляем состояние горячих клавиш
  E := EnableHotKeysCheckBox.Checked;
  if E then
  begin
    with HotKeysListView do
    begin
      // HotKey 1
      if HotKey1 = nil then
        HotKey1 := TJvApplicationHotKey.Create(MainForm);
      HotKey1.Tag := 1;
      HotKey1.Active := False;
      HotKey1.HotKey := TextToShortCut(Items[0].SubItems.Strings[0]);
      HotKey1.OnHotKey := MainForm.DoHotKey;
      HotKey1.OnHotKeyRegisterFailed := MainForm.DoHotKeyRegisterFailed;
      if HotKey1.HotKey <> 0 then
        HotKey1.Active := True;
      // HotKey 2
      if HotKey2 = nil then
        HotKey2 := TJvApplicationHotKey.Create(MainForm);
      HotKey2.Tag := 2;
      HotKey2.Active := False;
      HotKey2.HotKey := TextToShortCut(Items[1].SubItems.Strings[0]);
      HotKey2.OnHotKey := MainForm.DoHotKey;
      HotKey2.OnHotKeyRegisterFailed := MainForm.DoHotKeyRegisterFailed;
      if HotKey2.HotKey <> 0 then
        HotKey2.Active := True;
      // HotKey 3
      if HotKey3 = nil then
        HotKey3 := TJvApplicationHotKey.Create(MainForm);
      HotKey3.Tag := 3;
      HotKey3.Active := False;
      HotKey3.HotKey := TextToShortCut(Items[2].SubItems.Strings[0]);
      HotKey3.OnHotKey := MainForm.DoHotKey;
      HotKey3.OnHotKeyRegisterFailed := MainForm.DoHotKeyRegisterFailed;
      if HotKey3.HotKey <> 0 then
        HotKey3.Active := True;
      // HotKey 4
      if HotKey4 = nil then
        HotKey4 := TJvApplicationHotKey.Create(MainForm);
      HotKey4.Tag := 4;
      HotKey4.Active := False;
      HotKey4.HotKey := TextToShortCut(Items[3].SubItems.Strings[0]);
      HotKey4.OnHotKey := MainForm.DoHotKey;
      HotKey4.OnHotKeyRegisterFailed := MainForm.DoHotKeyRegisterFailed;
      if HotKey4.HotKey <> 0 then
        HotKey4.Active := True;
      // HotKey 5
      if HotKey5 = nil then
        HotKey5 := TJvApplicationHotKey.Create(MainForm);
      HotKey5.Tag := 5;
      HotKey5.Active := False;
      HotKey5.HotKey := TextToShortCut(Items[4].SubItems.Strings[0]);
      HotKey5.OnHotKey := MainForm.DoHotKey;
      HotKey5.OnHotKeyRegisterFailed := MainForm.DoHotKeyRegisterFailed;
      if HotKey5.HotKey <> 0 then
        HotKey5.Active := True;
      // HotKey 6
      if HotKey6 = nil then
        HotKey6 := TJvApplicationHotKey.Create(MainForm);
      HotKey6.Tag := 6;
      HotKey6.Active := False;
      HotKey6.HotKey := TextToShortCut(Items[5].SubItems.Strings[0]);
      HotKey6.OnHotKey := MainForm.DoHotKey;
      HotKey6.OnHotKeyRegisterFailed := MainForm.DoHotKeyRegisterFailed;
      if HotKey6.HotKey <> 0 then
        HotKey6.Active := True;
    end;
  end
  else
  begin
    if HotKey1 <> nil then
    begin
      HotKey1.Active := False;
      FreeAndNil(HotKey1);
    end;
    if HotKey2 <> nil then
    begin
      HotKey2.Active := False;
      FreeAndNil(HotKey2);
    end;
    if HotKey3 <> nil then
    begin
      HotKey3.Active := False;
      FreeAndNil(HotKey3);
    end;
    if HotKey4 <> nil then
    begin
      HotKey4.Active := False;
      FreeAndNil(HotKey4);
    end;
    if HotKey5 <> nil then
    begin
      HotKey5.Active := False;
      FreeAndNil(HotKey5);
    end;
    if HotKey6 <> nil then
    begin
      HotKey6.Active := False;
      FreeAndNil(HotKey6);
    end;
  end;
end;

procedure TSettingsForm.HotKeyDellButtonClick(Sender: TObject);
begin
  // Удаляем комбинацию горячих клавиш
  with HotKeysListView do
  begin
    if Selected <> nil then
    begin
      if Selected.Index <> 6 then
      begin
        Selected.SubItems.Strings[0] := ShortCutToText(0);
        ApplyBitBtn.Enabled := True;
      end;
    end;
  end;
end;

procedure TSettingsForm.HotKeySetButtonClick(Sender: TObject);
begin
  // Назначаем комбинацию горячих клавиш
  with HotKeysListView do
  begin
    if Selected <> nil then
    begin
      if Selected.Index <> 6 then
      begin
        Selected.SubItems.Strings[0] := ShortCutToText(HotKeyEdit.HotKey);
        ApplyBitBtn.Enabled := True;
      end;
    end;
  end;

end;

procedure TSettingsForm.HotKeysListViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Переводим фокус на HotKeyEdit
  if HotKeyEdit.CanFocus then
    HotKeyEdit.SetFocus;
end;

procedure TSettingsForm.HotKeysListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  // Получаем выбранный хоткей
  if Selected then
    HotKeyEdit.HotKey := TextToShortCut(Item.SubItems.Strings[0])
  else
    HotKeyEdit.HotKey := 0;
end;
{$ENDREGION}

end.

