{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MainUnit;

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
  ComCtrls,
  ToolWin,
  CategoryButtons,
  ExtCtrls,
  Menus,
  ImgList,
  JvTimerList,
  OverbyteIcsWndControl,
  OverbyteIcsWSocket,
  OverbyteIcsHttpProt,
  JvHint,
  StrUtils,
  OverbyteIcsMimeUtils,
  StdCtrls,
  ActnList,
  GifImg,
  AppEvnts,
  JclDebug,
  JvSimpleXml,
  ExtDlgs,
  IOUtils,
  OverbyteIcsUtils;

type
  TMainForm = class(TForm)
    ContactList: TCategoryButtons;
    BottomToolBar: TToolBar;
    MainToolButton: TToolButton;
    ICQToolButton: TToolButton;
    AllImageList: TImageList;
    JvTimerList: TJvTimerList;
    MainPopupMenu: TPopupMenu;
    CloseProgram_Menu: TMenuItem;
    HideInTray_Menu: TMenuItem;
    N3: TMenuItem;
    ICQWSocket: TWSocket;
    MRAWSocket: TWSocket;
    JabberWSocket: TSslWSocket;
    ICQAvatarWSocket: TWSocket;
    HttpClient: THttpCli;
    MRAToolButton: TToolButton;
    JabberToolButton: TToolButton;
    AboutIMadering_Menu: TMenuItem;
    Settings_Menu: TMenuItem;
    ContactListPopupMenu: TPopupMenu;
    ICQPopupMenu: TPopupMenu;
    MRAPopupMenu: TPopupMenu;
    JabberPopupMenu: TPopupMenu;
    ICQStatusOffline: TMenuItem;
    N6: TMenuItem;
    ICQStatusInvisibleForAll: TMenuItem;
    ICQStatusInvisible: TMenuItem;
    ICQStatusOnline: TMenuItem;
    N7: TMenuItem;
    ICQStatusDND: TMenuItem;
    ICQStatusOccupied: TMenuItem;
    ICQStatusNA: TMenuItem;
    ICQStatusAway: TMenuItem;
    ICQStatusLunch: TMenuItem;
    N8: TMenuItem;
    ICQStatusWork: TMenuItem;
    ICQStatusHome: TMenuItem;
    ICQStatusDepres: TMenuItem;
    ICQStatusEvil: TMenuItem;
    ICQStatusFFC: TMenuItem;
    ICQXStatus: TMenuItem;
    N11: TMenuItem;
    N9: TMenuItem;
    ICQSettings: TMenuItem;
    MRAStatusOffline: TMenuItem;
    N10: TMenuItem;
    JabberStatusOffline: TMenuItem;
    N12: TMenuItem;
    JabberStatusOnline: TMenuItem;
    MRAStatusInvisible: TMenuItem;
    MRAStatusOnline: TMenuItem;
    N13: TMenuItem;
    MRAStatusDND: TMenuItem;
    MRAStatusAway: TMenuItem;
    N14: TMenuItem;
    MRAStatusFFC: TMenuItem;
    N15: TMenuItem;
    MRAXStatus: TMenuItem;
    MRASettings: TMenuItem;
    N17: TMenuItem;
    JabberSettings: TMenuItem;
    SoundOnOffToolButton: TToolButton;
    OnlyOnlineContactsToolButton: TToolButton;
    ContactPopupMenu: TPopupMenu;
    RightICQPopupMenu: TPopupMenu;
    UnstableICQStatus: TMenuItem;
    OpenGroupsCL: TMenuItem;
    CloseGroupsCL: TMenuItem;
    N5: TMenuItem;
    AddGroupCL: TMenuItem;
    RenemeGroupCL: TMenuItem;
    DeleteGroupCL: TMenuItem;
    N20: TMenuItem;
    SearchInCL: TMenuItem;
    N18: TMenuItem;
    AddContactCL: TMenuItem;
    SendMessageForContact: TMenuItem;
    CheckStatusContact: TMenuItem;
    N21: TMenuItem;
    AnketaContact: TMenuItem;
    HistoryContact: TMenuItem;
    CopyAccountContact: TMenuItem;
    N22: TMenuItem;
    EditContact: TMenuItem;
    DeleteContact: TMenuItem;
    N23: TMenuItem;
    NextContactMenu: TMenuItem;
    GrandAuthContact: TMenuItem;
    SendAddContact: TMenuItem;
    DelYourSelfContact: TMenuItem;
    SendInviteContact: TMenuItem;
    AddNewContact: TMenuItem;
    History_Menu: TMenuItem;
    Traffic_Menu: TMenuItem;
    MRA_PhotoClient: THttpCli;
    RightMRAPopupMenu: TPopupMenu;
    RightJabberPopupMenu: TPopupMenu;
    JabberStatusInvisible: TMenuItem;
    JabberStatusDND: TMenuItem;
    N25: TMenuItem;
    JabberStatusOccupied: TMenuItem;
    JabberXStatus: TMenuItem;
    N4: TMenuItem;
    JabberStatusNA: TMenuItem;
    JabberStatusAway: TMenuItem;
    JabberStatusLunch: TMenuItem;
    JabberStatusWork: TMenuItem;
    N26: TMenuItem;
    JabberStatusHome: TMenuItem;
    JabberStatusDepression: TMenuItem;
    JabberStatusEvil: TMenuItem;
    JabberStatusFFC: TMenuItem;
    UnstableMRAStatus: TMenuItem;
    UnstableJabberStatus: TMenuItem;
    SearchInCL_Menu: TMenuItem;
    HideEmptyGroups: TMenuItem;
    ICQSearchNewContact: TMenuItem;
    CheckUpdate_Menu: TMenuItem;
    N29: TMenuItem;
    JabberSearchNewContact: TMenuItem;
    MainActionList: TActionList;
    CloseActiveFormAction: TAction;
    ChatTabCloseAction: TAction;
    TopPanelPopupMenu: TPopupMenu;
    BottomPanelPopupMenu: TPopupMenu;
    MainButtonONMenu: TMenuItem;
    TopSettingsONMenu: TMenuItem;
    TopToolBar: TToolBar;
    SettingsTopToolButton: TToolButton;
    TopPanelToolButton: TToolButton;
    SoundsONMenu: TMenuItem;
    OnlyOnlineONMenu: TMenuItem;
    TopPanelONMenu: TMenuItem;
    OnlyOnlineContactsTopButton: TToolButton;
    SoundOnOffToolTopButton: TToolButton;
    HistoryTopToolButton: TToolButton;
    HistoryToolButton: TToolButton;
    SettingsToolButton: TToolButton;
    HistoryONMenu: TMenuItem;
    SettingsONMenu: TMenuItem;
    MainToolTopButton: TToolButton;
    TrafficTopToolButton: TToolButton;
    TrafficToolButton: TToolButton;
    TrafficONMenu: TMenuItem;
    TopMainButtonONMenu: TMenuItem;
    TopOnlyOnlineONMenu: TMenuItem;
    TopSoundsONMenu: TMenuItem;
    TopHistoryONMenu: TMenuItem;
    TopTrafficONMenu: TMenuItem;
    JabberSslContext: TSslContext;
    SendFileMenu: TMenuItem;
    SendFileUpWapru: TMenuItem;
    SendFileOpenDialog: TOpenDialog;
    ShowLog_Menu: TMenuItem;
    IMaderingEvents: TApplicationEvents;
    UniqContactSettingsMenu: TMenuItem;
    FloatContactMenu: TMenuItem;
    N27: TMenuItem;
    SwitchProfile_Menu: TMenuItem;
    TrayIcon: TTrayIcon;
    TrayPopupMenu: TPopupMenu;
    CloseProgram_MenuTray: TMenuItem;
    N24: TMenuItem;
    ShowLog_MenuTray: TMenuItem;
    N28: TMenuItem;
    HideInTray_MenuTray: TMenuItem;
    Status_MenuTray: TMenuItem;
    N30: TMenuItem;
    Settings_MenuTray: TMenuItem;
    AllStatusOffline: TMenuItem;
    N32: TMenuItem;
    AllStatusInvisible: TMenuItem;
    AllStatusOnline: TMenuItem;
    N35: TMenuItem;
    AllStatusDND: TMenuItem;
    AllStatusOccupied: TMenuItem;
    AllStatusNA: TMenuItem;
    AllStatusAway: TMenuItem;
    AllStatusLunch: TMenuItem;
    N41: TMenuItem;
    AllStatusWork: TMenuItem;
    AllStatusHome: TMenuItem;
    AllStatusDepres: TMenuItem;
    AllStatusEvil: TMenuItem;
    AllStatusFFC: TMenuItem;
    PingICQServer: TMenuItem;
    PingMRAServer: TMenuItem;
    PingJabberServer: TMenuItem;
    CLSearchToolButton: TToolButton;
    CLSearchTopToolButton: TToolButton;
    CLSearchONMenu: TMenuItem;
    TopCLSearchONMenu: TMenuItem;
    TwitterClient: THttpCli;
    SaveTextAsFileDialog: TSaveTextFileDialog;
    MraSMSSendMenu: TMenuItem;
    N34: TMenuItem;
    SnapCL_Menu: TMenuItem;
    SnapToRight: TMenuItem;
    SnapToLeft: TMenuItem;
    N39: TMenuItem;
    OpenGame_Menu: TMenuItem;
    N38: TMenuItem;
    TopModeToolButton: TToolButton;
    SwitchProfile_MenuTray: TMenuItem;
    MRAStatusEvil: TMenuItem;
    MRAStatusDepres: TMenuItem;
    MRAStatusHome: TMenuItem;
    MRAStatusWork: TMenuItem;
    MRAStatusLunch: TMenuItem;
    MRAStatusNA: TMenuItem;
    MRAStatusOccupied: TMenuItem;
    PostInTwitter_Menu: TMenuItem;
    LinkCompress_Menu: TMenuItem;
    N1: TMenuItem;
    DumpMRA: TMenuItem;
    DumpICQ: TMenuItem;
    DumpJabber: TMenuItem;
    ICQAddGroup: TMenuItem;
    MRAAddGroup: TMenuItem;
    JabberAddGroup: TMenuItem;
    ICQAddContact: TMenuItem;
    N2: TMenuItem;
    MRAAddContact: TMenuItem;
    N19: TMenuItem;
    JabberAddContact: TMenuItem;
    N31: TMenuItem;
    MRASearchNewContact: TMenuItem;
    N16: TMenuItem;
    N33: TMenuItem;
    N36: TMenuItem;
    ICQ_Addition: TMenuItem;
    MRA_Addition: TMenuItem;
    Jabber_Addition: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure JvTimerListEvents0Timer(Sender: TObject);
    procedure HintMaxTime(Sender: TObject);
    procedure MainToolButtonClick(Sender: TObject);
    procedure Settings_MenuClick(Sender: TObject);
    procedure AboutIMadering_MenuClick(Sender: TObject);
    procedure HttpClientDocBegin(Sender: TObject);
    procedure JvTimerListEvents2Timer(Sender: TObject);
    procedure ICQSettingsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ICQXStatusClick(Sender: TObject);
    procedure ICQToolButtonClick(Sender: TObject);
    procedure MRAToolButtonClick(Sender: TObject);
    procedure JabberToolButtonClick(Sender: TObject);
    procedure MRAXStatusClick(Sender: TObject);
    procedure SoundOnOffToolButtonClick(Sender: TObject);
    procedure OnlyOnlineContactsToolButtonClick(Sender: TObject);
    procedure ICQStatusOnlineClick(Sender: TObject);
    procedure ICQStatusOfflineClick(Sender: TObject);
    procedure ICQWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure MRASettingsClick(Sender: TObject);
    procedure JabberSettingsClick(Sender: TObject);
    procedure ICQToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure MRAToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure JabberToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ContactListHotButton(Sender: TObject; const Button: TButtonItem);
    procedure ContactListContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ContactListButtonClicked(Sender: TObject; const Button: TButtonItem);
    procedure SendMessageForContactClick(Sender: TObject);
    procedure JvTimerListEvents1Timer(Sender: TObject);
    procedure CheckStatusContactClick(Sender: TObject);
    procedure AnketaContactClick(Sender: TObject);
    procedure HistoryContactClick(Sender: TObject);
    procedure CopyAccountContactClick(Sender: TObject);
    procedure OpenGroupsCLClick(Sender: TObject);
    procedure CloseGroupsCLClick(Sender: TObject);
    procedure AddGroupCLClick(Sender: TObject);
    procedure RenemeGroupCLClick(Sender: TObject);
    procedure DeleteGroupCLClick(Sender: TObject);
    procedure AddContactCLClick(Sender: TObject);
    procedure EditContactClick(Sender: TObject);
    procedure DeleteContactClick(Sender: TObject);
    procedure GrandAuthContactClick(Sender: TObject);
    procedure SendAddContactClick(Sender: TObject);
    procedure DelYourSelfContactClick(Sender: TObject);
    procedure SendInviteContactClick(Sender: TObject);
    procedure UnstableICQStatusClick(Sender: TObject);
    procedure History_MenuClick(Sender: TObject);
    procedure Traffic_MenuClick(Sender: TObject);
    procedure HttpClientSendEnd(Sender: TObject);
    procedure ICQWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure JabberWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure JvTimerListEvents4Timer(Sender: TObject);
    procedure JvTimerListEvents5Timer(Sender: TObject);
    procedure JvTimerListEvents6Timer(Sender: TObject);
    procedure JvTimerListEvents7Timer(Sender: TObject);
    procedure JabberStatusOfflineClick(Sender: TObject);
    procedure JabberStatusOnlineClick(Sender: TObject);
    procedure ICQWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure JabberWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure HttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure HttpClientSessionClosed(Sender: TObject);
    procedure ICQWSocketError(Sender: TObject);
    procedure ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure HttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketError(Sender: TObject);
    procedure JabberWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure JvTimerListEvents9Timer(Sender: TObject);
    procedure JvTimerListEvents11Timer(Sender: TObject);
    procedure JvTimerListEvents12Timer(Sender: TObject);
    procedure JabberXStatusClick(Sender: TObject);
    procedure ContactListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ContactListPopupMenuPopup(Sender: TObject);
    procedure HideEmptyGroupsClick(Sender: TObject);
    procedure RightICQPopupMenuPopup(Sender: TObject);
    procedure MainToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ICQSearchNewContactClick(Sender: TObject);
    procedure CloseActiveFormActionExecute(Sender: TObject);
    procedure ChatTabCloseActionExecute(Sender: TObject);
    procedure BottomPanelPopupMenuPopup(Sender: TObject);
    procedure TopPanelToolButtonClick(Sender: TObject);
    procedure MRAStatusOnlineClick(Sender: TObject);
    procedure MainButtonONMenuClick(Sender: TObject);
    procedure SoundsONMenuClick(Sender: TObject);
    procedure OnlyOnlineONMenuClick(Sender: TObject);
    procedure TopPanelONMenuClick(Sender: TObject);
    procedure MainToolTopButtonClick(Sender: TObject);
    procedure BottomToolBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TopToolBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MainToolTopButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure OnlyOnlineContactsTopButtonClick(Sender: TObject);
    procedure SoundOnOffToolTopButtonClick(Sender: TObject);
    procedure HistoryONMenuClick(Sender: TObject);
    procedure SettingsONMenuClick(Sender: TObject);
    procedure TrafficONMenuClick(Sender: TObject);
    procedure TopMainButtonONMenuClick(Sender: TObject);
    procedure TopOnlyOnlineONMenuClick(Sender: TObject);
    procedure TopSoundsONMenuClick(Sender: TObject);
    procedure TopHistoryONMenuClick(Sender: TObject);
    procedure TopSettingsONMenuClick(Sender: TObject);
    procedure TopTrafficONMenuClick(Sender: TObject);
    procedure MRAStatusOfflineClick(Sender: TObject);
    procedure MRAWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure MRAWSocketError(Sender: TObject);
    procedure MRAWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure MRAWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure MRAWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure MRAWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure MRAWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure MRAWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure AddNewContactClick(Sender: TObject);
    procedure JabberWSocketSslVerifyPeer(Sender: TObject; var Ok: Integer; Cert: TX509Base);
    procedure SocketBgException(Sender: TObject; E: Exception; var CanClose: Boolean);
    procedure SendFileUpWapruClick(Sender: TObject);
    procedure ContactListCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
    procedure ShowLog_MenuClick(Sender: TObject);
    procedure IMaderingEventsException(Sender: TObject; E: Exception);
    procedure UniqContactSettingsMenuClick(Sender: TObject);
    procedure FloatContactMenuClick(Sender: TObject);
    procedure SwitchProfile_MenuClick(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure CloseProgram_MenuClick(Sender: TObject);
    procedure PingICQServerClick(Sender: TObject);
    procedure JvTimerListEvents8Timer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDblClick(Sender: TObject);
    procedure HttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure TopCLSearchONMenuClick(Sender: TObject);
    procedure CLSearchONMenuClick(Sender: TObject);
    procedure TwitterClientSessionClosed(Sender: TObject);
    procedure TwitterClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure JvTimerListEvents10Timer(Sender: TObject);
    procedure MraSMSSendMenuClick(Sender: TObject);
    procedure JvTimerListEvents13Timer(Sender: TObject);
    procedure JvTimerListEvents14Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SnapToRightClick(Sender: TObject);
    procedure JvTimerListEvents15Timer(Sender: TObject);
    procedure OpenGame_MenuClick(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure TopModeToolButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SearchInCL_MenuClick(Sender: TObject);
    procedure HideInTray_MenuClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure CheckUpdate_MenuClick(Sender: TObject);
    procedure DumpMRAClick(Sender: TObject);
    procedure DumpICQClick(Sender: TObject);
    procedure DumpJabberClick(Sender: TObject);
    procedure LinkCompress_MenuClick(Sender: TObject);
    procedure HttpClientDocEnd(Sender: TObject);
    procedure PostInTwitter_MenuClick(Sender: TObject);
    procedure ICQAddContactClick(Sender: TObject);
    procedure MRAAddContactClick(Sender: TObject);
    procedure JabberAddContactClick(Sender: TObject);
    procedure ICQAddGroupClick(Sender: TObject);
    procedure JabberAddGroupClick(Sender: TObject);
    procedure MRAAddGroupClick(Sender: TObject);
    procedure HttpClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
    procedure TwitterClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
    procedure MRA_PhotoClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);

  private
    { Private declarations }
    ButtonInd: Integer;
    procedure LoadImageList(ImgList: TImageList; FName: string);
    procedure AppActivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QueryEndSession;
    procedure WMEXITSIZEMOVE(var message: TMessage); message WM_EXITSIZEMOVE;

  public
    { Public declarations }
    RoasterGroup: TButtonCategory;
    RoasterButton: TButtonItem;
    procedure TranslateForm;
    procedure LoadMainFormSettings;
    procedure SaveMainFormSettings;
    procedure ICQ_Enable(OnOff: Boolean);
    procedure MRA_Enable(OnOff: Boolean);
    procedure Jab_Enable(OnOff: Boolean);
    procedure OpenFromTrayMessage(HUIN: string);
    procedure MainFormHideInTray;
  end;

{$ENDREGION}

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  VarsUnit,
  SettingsUnit,
  AboutUnit,
  UtilsUnit,
  IcqOptionsUnit,
  XStatusUnit,
  IcqProtoUnit,
  ContactInfoUnit,
  MraOptionsUnit,
  JabberOptionsUnit,
  ChatUnit,
  SmilesUnit,
  MemoUnit,
  HistoryUnit,
  CLSearchUnit,
  TrafficUnit,
  AddContactUnit,
  JabberProtoUnit,
  MraProtoUnit,
  ContactSearchUnit,
  ShowCertUnit,
  FileTransferUnit,
  LogUnit,
  FloatingUnit,
  UniqUnit,
  ProfileUnit,
  GTransUnit,
  OverbyteIcsUrl,
  ShellApi,
  SMSUnit,
  GamesUnit,
  RosterUnit,
  HTTPUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_MainForm = 'Main_form';
  C_MainFormOnlyOnline = 'Only_online';
  C_MainFormFirst = 'First_start';
  C_MainFormProto = 'Protos';
  C_Traffic = 'Traffic';
  C_MainFormHEG = 'Empty_group';
  C_MainFormTP = 'Top_panel';
  C_MainFormBP = 'Bottom_panel';
  С_MainFormTop = 'Top_mode';

{$ENDREGION}
{$REGION 'WMEXITSIZEMOVE'}

procedure TMainForm.WMEXITSIZEMOVE(var message: TMessage);
begin
  if V_DockAppBar then
  begin
    V_DockAppBar := False;
    Height := V_NoDockHeigth;
    Width := V_NoDockWigth;
    // Уничтожаем АppBar
    AppBarDestroy;
  end;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TMainForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Выставляем подсказки к кнопкам
  MainToolTopButton.Hint := MainToolButton.Hint;
  OnlyOnlineContactsTopButton.Hint := OnlyOnlineContactsToolButton.Hint;
  SoundOnOffToolTopButton.Hint := SoundOnOffToolButton.Hint;
  HistoryTopToolButton.Hint := HistoryToolButton.Hint;
  SettingsTopToolButton.Hint := SettingsToolButton.Hint;
  TrafficTopToolButton.Hint := TrafficToolButton.Hint;
  CLSearchTopToolButton.Hint := CLSearchToolButton.Hint;
  // Применяем перевод меню
  HideInTray_Menu.Caption := Lang_Vars[1].L_S;
  HideInTray_MenuTray.Caption := Lang_Vars[1].L_S;
  Settings_MenuTray.Caption := Settings_Menu.Caption;
  CloseProgram_MenuTray.Caption := CloseProgram_Menu.Caption;
  SwitchProfile_MenuTray.Caption := SwitchProfile_Menu.Caption;
  ShowLog_Menu.Caption := ShowLog_MenuTray.Caption;
  TopMainButtonONMenu.Caption := MainButtonONMenu.Caption;
  TopOnlyOnlineONMenu.Caption := OnlyOnlineONMenu.Caption;
  TopSoundsONMenu.Caption := SoundsONMenu.Caption;
  TopHistoryONMenu.Caption := HistoryONMenu.Caption;
  TopSettingsONMenu.Caption := SettingsONMenu.Caption;
  TopTrafficONMenu.Caption := TrafficONMenu.Caption;
  SearchInCL.Caption := SearchInCL_Menu.Caption;
  TopCLSearchONMenu.Caption := CLSearchONMenu.Caption;
  PostInTwitter_Menu.Caption := Format(Lang_Vars[61].L_S, [C_Twitter]);
  LinkCompress_Menu.Caption := Lang_Vars[3].L_S;
  DumpMRA.Caption := Format(Lang_Vars[11].L_S, [C_MRA]);
  DumpICQ.Caption := Format(Lang_Vars[11].L_S, [C_ICQ]);
  DumpJabber.Caption := Format(Lang_Vars[11].L_S, [C_Jabber]);
  // Применяем перевод статусов в меню
  ICQSettings.Caption := Settings_Menu.Caption + C_BN + C_Icq;
  ICQ_Addition.Caption := NextContactMenu.Caption;
  ICQStatusFFC.Caption := Lang_Vars[67].L_S;
  ICQStatusEvil.Caption := Lang_Vars[68].L_S;
  ICQStatusDepres.Caption := Lang_Vars[69].L_S;
  ICQStatusHome.Caption := Lang_Vars[70].L_S;
  ICQStatusWork.Caption := Lang_Vars[71].L_S;
  ICQStatusLunch.Caption := Lang_Vars[72].L_S;
  ICQStatusAway.Caption := Lang_Vars[73].L_S;
  ICQStatusNA.Caption := Lang_Vars[74].L_S;
  ICQStatusOccupied.Caption := Lang_Vars[75].L_S;
  ICQStatusDND.Caption := Lang_Vars[76].L_S;
  ICQStatusOnline.Caption := Lang_Vars[77].L_S;
  ICQStatusInvisible.Caption := Lang_Vars[78].L_S;
  ICQStatusInvisibleForAll.Caption := Lang_Vars[79].L_S;
  ICQStatusOffline.Caption := Lang_Vars[80].L_S;
  ICQAddGroup.Caption := AddGroupCL.Caption;
  ICQAddContact.Caption := AddContactCL.Caption;
  // MRA
  MRASettings.Caption := Settings_Menu.Caption + C_BN + C_Mra;
  MRA_Addition.Caption := NextContactMenu.Caption;
  MRASearchNewContact.Caption := ICQSearchNewContact.Caption;
  MRAXStatus.Caption := ICQXStatus.Caption;
  MRAStatusFFC.Caption := Lang_Vars[67].L_S;
  MRAStatusEvil.Caption := Lang_Vars[68].L_S;
  MRAStatusDepres.Caption := Lang_Vars[69].L_S;
  MRAStatusHome.Caption := Lang_Vars[70].L_S;
  MRAStatusWork.Caption := Lang_Vars[71].L_S;
  MRAStatusLunch.Caption := Lang_Vars[72].L_S;
  MRAStatusAway.Caption := Lang_Vars[73].L_S;
  MRAStatusNA.Caption := Lang_Vars[74].L_S;
  MRAStatusOccupied.Caption := Lang_Vars[75].L_S;
  MRAStatusDND.Caption := Lang_Vars[76].L_S;
  MRAStatusOnline.Caption := Lang_Vars[77].L_S;
  MRAStatusInvisible.Caption := Lang_Vars[78].L_S;
  MRAStatusOffline.Caption := Lang_Vars[80].L_S;
  PingMRAServer.Caption := PingICQServer.Caption;
  UnstableMRAStatus.Caption := UnstableICQStatus.Caption;
  MRAAddGroup.Caption := AddGroupCL.Caption;
  MRAAddContact.Caption := AddContactCL.Caption;
  // Jabber
  JabberSettings.Caption := Settings_Menu.Caption + C_BN + C_Jabber;
  Jabber_Addition.Caption := NextContactMenu.Caption;
  JabberSearchNewContact.Caption := ICQSearchNewContact.Caption;
  JabberXStatus.Caption := ICQXStatus.Caption;
  JabberStatusFFC.Caption := Lang_Vars[67].L_S;
  JabberStatusEvil.Caption := Lang_Vars[68].L_S;
  JabberStatusDepression.Caption := Lang_Vars[69].L_S;
  JabberStatusHome.Caption := Lang_Vars[70].L_S;
  JabberStatusWork.Caption := Lang_Vars[71].L_S;
  JabberStatusLunch.Caption := Lang_Vars[72].L_S;
  JabberStatusAway.Caption := Lang_Vars[73].L_S;
  JabberStatusNA.Caption := Lang_Vars[74].L_S;
  JabberStatusOccupied.Caption := Lang_Vars[75].L_S;
  JabberStatusDND.Caption := Lang_Vars[76].L_S;
  JabberStatusOnline.Caption := Lang_Vars[77].L_S;
  JabberStatusInvisible.Caption := Lang_Vars[78].L_S;
  JabberStatusOffline.Caption := Lang_Vars[80].L_S;
  PingJabberServer.Caption := PingICQServer.Caption;
  UnstableJabberStatus.Caption := UnstableICQStatus.Caption;
  JabberAddGroup.Caption := AddGroupCL.Caption;
  JabberAddContact.Caption := AddContactCL.Caption;
  // All Statuses
  AllStatusFFC.Caption := Lang_Vars[67].L_S;
  AllStatusEvil.Caption := Lang_Vars[68].L_S;
  AllStatusDepres.Caption := Lang_Vars[69].L_S;
  AllStatusHome.Caption := Lang_Vars[70].L_S;
  AllStatusWork.Caption := Lang_Vars[71].L_S;
  AllStatusLunch.Caption := Lang_Vars[72].L_S;
  AllStatusAway.Caption := Lang_Vars[73].L_S;
  AllStatusNA.Caption := Lang_Vars[74].L_S;
  AllStatusOccupied.Caption := Lang_Vars[75].L_S;
  AllStatusDND.Caption := Lang_Vars[76].L_S;
  AllStatusOnline.Caption := Lang_Vars[77].L_S;
  AllStatusInvisible.Caption := Lang_Vars[78].L_S;
  AllStatusOffline.Caption := Lang_Vars[80].L_S;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.TrafficONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку трафик на нижней панели
  TrafficONMenu.Checked := not TrafficONMenu.Checked;
  TrafficToolButton.Visible := not TrafficToolButton.Visible;
end;

procedure TMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  // Если виндовс выключается, то мы завершаем и программу
  V_ProgramCloseCommand := True;
  Msg.Result := 1;
end;

procedure TMainForm.TrayIconClick(Sender: TObject);
var
  UIN: string;
  G, K: Integer;
begin
  // Выводим главное окно на первый план
  if Assigned(ProfileForm) then
  begin
    if ProfileForm.Visible then
      XShowForm(ProfileForm);
  end
  else
  begin
    if MainForm.Visible then
      XShowForm(MainForm);
  end;
  Application.BringToFront;
  // Если есть непрочитанные сообщения, то открываем их
  if TrayIcon.Tag = 1 then
  begin
    // Смотрим кто у нас первый в очереди на прочтение сообщения
    if V_InMessList <> nil then
      if V_InMessList.Count > 0 then
      begin
        UIN := V_InMessList.Strings[0];
        V_InMessList.Delete(0);
      end;
    // Если в очереди кто-то есть, то ищем его в КЛ
    with ContactList do
    begin
      for G := 0 to Categories.Count - 1 do
      begin
        for K := 0 to Categories[G].Items.Count - 1 do
        begin
          if UIN <> EmptyStr then
          begin
            // Если нашли нужный контакт
            if Categories[G].Items[K].UIN = UIN then
            begin
              // Меняем иконку кнопки контакта на его статус
              Categories[G].Items[K].ImageIndex := Categories[G].Items[K].Status;
              // Открываем чат с этим контактом
              OpenChatPage(Categories[G].Items[K], Categories[G].Items[K].ContactType);
              // Выходим из цикла
              Exit;
            end;
          end
          else
          begin
            // Если нашли нужный контакт
            if (Categories[G].Items[K].ImageIndex = 165) or (Categories[G].Items[K].ImageIndex = 150) then
            begin
              // Меняем иконку кнопки контакта на его статус
              Categories[G].Items[K].ImageIndex := Categories[G].Items[K].Status;
              // Открываем чат с этим контактом
              OpenChatPage(Categories[G].Items[K], Categories[G].Items[K].ContactType);
              // Выходим из циклов
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  // Скрываем или отображаем окно КЛ или профиля из трэя
  MainFormHideInTray;
end;

{$ENDREGION}
{$REGION 'ICQ_Enable'}

procedure TMainForm.ICQ_Enable(OnOff: Boolean);
begin
  if OnOff then
  begin
    // Инициализируем окно настроек протокола ICQ
    if not Assigned(IcqOptionsForm) then
      Application.CreateForm(TIcqOptionsForm, IcqOptionsForm);
    // Ставим иконку в окне контактов
    ICQToolButton.Visible := True;
  end
  else
  begin
    // Прячем иконку в окне контактов
    ICQToolButton.Visible := False;
    // Высвобождаем окно настроек протокола ICQ
    if Assigned(IcqOptionsForm) then
      FreeAndNil(IcqOptionsForm);
    // Стираем из Ростера контакты ICQ
    ClearContacts(C_Icq);
  end;
end;
{$ENDREGION}
{$REGION 'MRA_Enable'}

procedure TMainForm.MRA_Enable(OnOff: Boolean);
begin
  if OnOff then
  begin
    // Инициализируем окно настроек протокола MRA
    if not Assigned(MraOptionsForm) then
      Application.CreateForm(TMraOptionsForm, MraOptionsForm);
    // Ставим иконку в окне контактов
    MRAToolButton.Visible := True;
  end
  else
  begin
    // Прячем иконку в окне контактов
    MRAToolButton.Visible := False;
    // Высвобождаем окно настроек протокола MRA
    if Assigned(MraOptionsForm) then
      FreeAndNil(MraOptionsForm);
    // Стираем из Ростера контакты MRA
    ClearContacts(C_Mra);
  end;
end;
procedure TMainForm.MRA_PhotoClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
begin
  // Управляем кукие
  XLog(MRA_PhotoClient.Name + C_BN + Log_Get + C_BN + C_Cookie, Data, C_HTTP);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.MRAAddContactClick(Sender: TObject);
var
  FrmAddContact: TAddContactForm;
begin
  // Выводим форму добавления нового контакта
  FrmAddContact := TAddContactForm.Create(Self);
  try
    with FrmAddContact do
    begin
      // Ставим флаг какой протокол
      ContactType := C_Mra;
      // Строим список групп этого протокола
      BuildGroupList(ContactType, EmptyStr);
      // Отображаем окно модально
      ShowModal;
    end;
  finally
    FreeAndNil(FrmAddContact);
  end;
end;

procedure TMainForm.MRAAddGroupClick(Sender: TObject);
begin
  //

end;

procedure TMainForm.MRASettingsClick(Sender: TObject);
begin
  // Открываем настройки сети MRA протокола
  if not Assigned(MraOptionsForm) then
    MraOptionsForm := TMraOptionsForm.Create(Self);
  // Отображаем окно
  XShowForm(MraOptionsForm);
end;

procedure TMainForm.MraSMSSendMenuClick(Sender: TObject);
begin
  // Отправка SMS через MRA протокол
  if not Assigned(SMSForm) then
    SMSForm := TSMSForm.Create(Self);
  XShowForm(SMSForm);
end;

procedure TMainForm.MRAStatusOfflineClick(Sender: TObject);
begin
  // Уводим ICQ протокол в оффлайн
  MRA_GoOffline;
  MRA_Reconnect := False;
end;

{$ENDREGION}
{$REGION 'MRAStatusOnlineClick'}

procedure TMainForm.MRAStatusOnlineClick(Sender: TObject);
var
  S_Log: string;
begin
  // Если логин ICQ или пароль пустые, то выводим окно настроек для их ввода
  if (MRA_LoginUIN = EmptyStr) or (MRA_LoginPassword = EmptyStr) then
  begin
    // Показываем сообщение об этой ошибке
    DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[21].L_S, [C_Mra]), EmptyStr, 133, 3, 0);
    // Открываем настройки MRA
    MRASettingsClick(Self);
    // Ставим фокусы в поле ввода логина или пароля
    with MraOptionsForm do
    begin
      if (MRAEmailEdit.CanFocus) and (MRAEmailEdit.Text = EmptyStr) then
        MRAEmailEdit.SetFocus
      else if (PassEdit.CanFocus) and (PassEdit.Text = EmptyStr) then
        PassEdit.SetFocus;
    end;
    // Выходим от сюда
    Exit;
  end;
  // Делаем выбранный статус в меню выделенным
  TMenuItem(Sender).default := True;
  // Ставим статус для протокола
  MRA_CurrentStatus := TMenuItem(Sender).ImageIndex;
  S_Log := Log_Set_Status + C_TN + C_BN + TMenuItem(Sender).Caption + C_RN;
  // Ставим запасное значение статуса для протокола
  MRA_CurrentStatus_bac := MRA_CurrentStatus;
  // Ставим иконку статуса в окне КЛ
  if not MRA_Offline_Phaze then
    MRAToolButton.ImageIndex := MRA_CurrentStatus;
  // Подключаемся к MRA серверу
  if MRA_Offline_Phaze then
  begin
    S_Log := S_Log + C_Login + C_TN + C_BN + MRA_LoginUIN + C_RN;
    // Ставим иконку подключения
    MRAToolButton.ImageIndex := 25;
    // Блокируем контролы логина и пароля MRA
    if Assigned(MraOptionsForm) then
    begin
      with MraOptionsForm do
      begin
        MRAEmailEdit.Enabled := False;
        MRAEmailEdit.Color := ClBtnFace;
        PassEdit.Enabled := False;
        PassEdit.Color := ClBtnFace;
        MRAEmailComboBox.Enabled := False;
      end;
    end;
    // Активируем фазу коннекта к серверу MRA
    MRA_Connect_Phaze := True;
    MRA_HTTP_Connect_Phaze := False;
    MRA_BosConnect_Phaze := False;
    MRA_Work_Phaze := False;
    MRA_Offline_Phaze := False;
    // Устанавливаем параметры сокета
    MRAWSocket.Proto := C_SocketProto;
    // Устанавливаем настройки прокси
    if V_HttpProxy_Enable then
    begin
      MRAWSocket.Addr := V_HttpProxy_Address;
      MRAWSocket.Port := V_HttpProxy_Port;
      S_Log := S_Log + Log_HTTP_Proxy_Connect + C_TN + C_BN + V_HttpProxy_Address + C_TN + V_HttpProxy_Port;
    end
    else
    begin
      MRAWSocket.Addr := MRA_LoginServerAddr;
      MRAWSocket.Port := MRA_LoginServerPort;
      S_Log := S_Log + Log_Connect + C_TN + C_BN + MRA_LoginServerAddr + C_TN + MRA_LoginServerPort;
    end;
    // Прорисовываем интерфэйс
    Update;
    // Подключаем сокет
    MRAWSocket.Connect;
  end;
  // Отправляем статус
  // if MRA_Work_Phaze then ;
  // Пишем в лог
  XLog(C_Mra, S_Log, C_Mra);
end;

{$ENDREGION}
{$REGION 'Jab_Enable'}

procedure TMainForm.Jab_Enable(OnOff: Boolean);
begin
  if OnOff then
  begin
    // Инициализируем окно настроек протокола Jabber
    if not Assigned(JabberOptionsForm) then
      Application.CreateForm(TJabberOptionsForm, JabberOptionsForm);
    // Ставим иконку в окне контактов
    JabberToolButton.Visible := True;
  end
  else
  begin
    // Прячем иконку в окне контактов
    JabberToolButton.Visible := False;
    // Высвобождаем окно настроек протокола Jabber
    if Assigned(JabberOptionsForm) then
      FreeAndNil(JabberOptionsForm);
    // Стираем из Ростера контакты Jabber
    ClearContacts(C_Jabber);
  end;
end;
{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JabberAddContactClick(Sender: TObject);
var
  FrmAddContact: TAddContactForm;
begin
  // Выводим форму добавления нового контакта
  FrmAddContact := TAddContactForm.Create(Self);
  try
    with FrmAddContact do
    begin
      // Ставим флаг какой протокол
      ContactType := C_Jabber;
      // Строим список групп этого протокола
      BuildGroupList(ContactType, EmptyStr);
      // Отображаем окно модально
      ShowModal;
    end;
  finally
    FreeAndNil(FrmAddContact);
  end;
end;

procedure TMainForm.JabberAddGroupClick(Sender: TObject);
var
  GName, GProto: string;
  Get_Node: TJvSimpleXmlElem;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Начинаем добаление новой группы
  GProto := C_Jabber;
  if InputQuery(AddGroupCL.Caption + C_BN + GProto, AddGroupCL.Caption + C_TN, GName) then
  begin
    // Если имя группы пустое, то выходим
    if GName = EmptyStr then
      Exit;
    // Ищем есть ли такая группа уже в Ростере
    Get_Node := RosterGetItem(GProto, C_Group + C_SS, C_Name, UrlEncode(GName));
    if Get_Node <> nil then
    begin
      DAShow(Lang_Vars[19].L_S + C_BN + GProto, Lang_Vars[97].L_S, EmptyStr, 133, 0, 0);
      Exit;
    end;
    Get_Node := RosterGetItem(GProto, C_Contact + C_SS, C_Group + C_Id, UrlEncode(GName));
    if Get_Node <> nil then
    begin
      DAShow(Lang_Vars[19].L_S + C_BN + GProto, Lang_Vars[97].L_S, EmptyStr, 133, 0, 0);
      Exit;
    end;
    if Get_Node = nil then
    begin
      // Добавляем новую группу в локальный КЛ
      if V_Roster <> nil then
      begin
        with V_Roster do
        begin
          if Root <> nil then
          begin
            XML_Node := Root.Items.ItemNamed[GProto];
            if XML_Node <> nil then
            begin
              // Открываем раздел групп
              Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
              if Sub_Node <> nil then
              begin
                Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Name, URLEncode(GName));
                Tri_Node.Properties.Add(C_Id, URLEncode(GName));
              end;
            end;
          end;
        end;
      end;
      // Строим локальный КЛ
      UpdateFullCL;
      // Сообщаем об успешном добавлении группы
      DAShow(Lang_Vars[16].L_S + C_BN + GProto, Lang_Vars[101].L_S, EmptyStr, 133, 3, 0);
    end;
  end;
end;

procedure TMainForm.JabberSettingsClick(Sender: TObject);
begin
  // Открываем настройки сети Jabber протокола
  if not Assigned(JabberOptionsForm) then
    JabberOptionsForm := TJabberOptionsForm.Create(Self);
  // Отображаем окно
  XShowForm(JabberOptionsForm);
end;

procedure TMainForm.JabberStatusOfflineClick(Sender: TObject);
begin
  // Уводим ICQ протокол в оффлайн
  Jab_GoOffline;
  Jabber_Reconnect := False;
end;

{$ENDREGION}
{$REGION 'JabberStatusOnlineClick'}

procedure TMainForm.JabberStatusOnlineClick(Sender: TObject);
var
  S_Log: string;
begin
  // Если логин Jabber или пароль пустые, то выводим окно настроек для их ввода
  if (Jabber_JID = EmptyStr) or (Jabber_LoginPassword = EmptyStr) then
  begin
    // Показываем сообщение об этой ошибке
    DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[21].L_S, [C_Jabber]), EmptyStr, 133, 3, 0);
    // Открываем настройки Jabber
    JabberSettingsClick(Self);
    // Ставим фокусы в поле ввода логина или пароля
    with JabberOptionsForm do
    begin
      if (JabberJIDEdit.CanFocus) and (JabberJIDEdit.Text = EmptyStr) then
        JabberJIDEdit.SetFocus
      else if (PassEdit.CanFocus) and (PassEdit.Text = EmptyStr) then
        PassEdit.SetFocus;
    end;
    // Выходим от сюда
    Exit;
  end;
  // Делаем выбранный статус в меню выделенным
  TMenuItem(Sender).default := True;
  // Ставим статус для протокола
  Jabber_CurrentStatus := TMenuItem(Sender).ImageIndex;
  S_Log := Log_Set_Status + C_TN + C_BN + TMenuItem(Sender).Caption + C_RN;
  // Ставим запасное значение статуса для протокола
  Jabber_CurrentStatus_bac := Jabber_CurrentStatus;
  // Ставим иконки статуса в окне и в трэе
  if not Jabber_Offline_Phaze then
    JabberToolButton.ImageIndex := Jabber_CurrentStatus;
  // Подключаемся к Jabber серверу
  if Jabber_Offline_Phaze then
  begin
    S_Log := S_Log + C_Login + C_TN + C_BN + Jabber_JID + C_RN;
    // Если сервер и порт указаны вручную
    with JabberOptionsForm do
      if CustomServerCheckBox.Checked then
      begin
        Jabber_ServerAddr := CustomServerEdit.Text;
        Jabber_ServerPort := CustomPortEdit.Text;
      end;
    // Ставим иконку подключения
    JabberToolButton.ImageIndex := 41;
    // Блокируем контролы логина и пароля Jabber
    if Assigned(JabberOptionsForm) then
    begin
      with JabberOptionsForm do
      begin
        JabberJIDEdit.Enabled := False;
        JabberJIDEdit.Color := ClBtnFace;
        PassEdit.Enabled := False;
        PassEdit.Color := ClBtnFace;
        JIDonserverLabel.Enabled := False;
        RegNewAccountLabel.Enabled := False;
      end;
    end;
    // Активируем фазу коннекта к серверу Jabber
    Jabber_Connect_Phaze := True;
    Jabber_HTTP_Connect_Phaze := False;
    Jabber_Work_Phaze := False;
    Jabber_Offline_Phaze := False;
    // Устанавливаем параметры сокета
    JabberWSocket.Proto := C_SocketProto;
    // Устанавливаем настройки прокси
    if V_HttpProxy_Enable then
    begin
      JabberWSocket.Addr := V_HttpProxy_Address;
      JabberWSocket.Port := V_HttpProxy_Port;
      S_Log := S_Log + Log_HTTP_Proxy_Connect + C_TN + C_BN + V_HttpProxy_Address + C_TN + V_HttpProxy_Port;
    end
    else
    begin
      JabberWSocket.Addr := Jabber_ServerAddr;
      JabberWSocket.Port := Jabber_ServerPort;
      S_Log := S_Log + Log_Connect + C_TN + C_BN + Jabber_ServerAddr + C_TN + Jabber_ServerPort;
    end;
    // Прорисовываем интерфэйс
    Update;
    // Отключаем SSL
    JabberWSocket.SslEnable := False;
    // Подключаем сокет
    JabberWSocket.Connect;
  end;
  // Отсылаем пакет со статусом
  if Jabber_Work_Phaze then
    Jab_SendPkt(Jab_SetStatus(Jabber_CurrentStatus));
  // Пишем в лог
  XLog(C_Jabber, S_Log, C_Jabber);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.HideEmptyGroupsClick(Sender: TObject);
begin
  // Управляем режимом скрывать пустые группы
  with HideEmptyGroups do
  begin
    if Checked then
      Checked := False
    else
      Checked := True;
  end;
  // Запускаем обработку Ростера
  UpdateFullCL;
end;

procedure TMainForm.HideInTray_MenuClick(Sender: TObject);
begin
  // Скрываем окно КЛ или профиля в трэй
  MainFormHideInTray;
end;

procedure TMainForm.HintMaxTime(Sender: TObject);
begin
  // Делаем отображение подсказки бесконечным
  Application.HintHidePause := MaxInt;
end;

{$ENDREGION}
{$REGION 'HistoryContactClick'}

procedure TMainForm.HistoryContactClick(Sender: TObject);
begin
  // Открываем окно истории
  if not Assigned(HistoryForm) then
    HistoryForm := THistoryForm.Create(Self);
  // Загружаем файл истории этого контакта
  HistoryForm.ReqCType := (ContactList.SelectedItem as TButtonItem).ContactType;
  HistoryForm.ReqHUIN := (ContactList.SelectedItem as TButtonItem).UIN;
  // Отображаем окно
  XShowForm(HistoryForm);
  // Загружаем историю
  MainForm.Update;
  HistoryForm.Update;
  HistoryForm.LoadHistoryFromFile;
  // Ставим фокус в поле поиска текста
  if HistoryForm.SearchTextEdit.CanFocus then
    HistoryForm.SearchTextEdit.SetFocus;
end;

{$ENDREGION}
{$REGION 'HttpClientRequestDone'}

procedure TMainForm.HttpClientDocEnd(Sender: TObject);
begin
  // Получаем укороченную ссылку
  with HttpClient do
  begin
    if Tag = 4 then
    begin
      if Location <> EmptyStr then
      begin
        SetClipBoardText(Location);
        XLog(Name + C_BN + Log_Get, Location, C_HTTP);
        DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[161].L_S, [Location]), EmptyStr, 133, 3, 60000);
      end;
      // Высвобождаем память отправки данных
      if SendStream <> nil then
      begin
        SendStream.Free;
        SendStream := nil;
      end;
      // Читаем полученные http данные из блока памяти
      if RcvdStream <> nil then
      begin
        RcvdStream.Free;
        RcvdStream := nil;
      end;
      CloseAsync;
      Abort;
    end;
  end;
end;

procedure TMainForm.HttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
var
  {List: TStringList;
  Str: string;}
  Ver, FullVer, BuildDate, Mess: string;
  C_Flag1, C_Flag2: Boolean;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;

  procedure ShowUpdateNote;
  begin
    // Если форма не существует, то создаём её
    if not Assigned(MemoForm) then
      Application.CreateForm(TMemoForm, MemoForm);
    // Делаем запрос в форме на обновление программы
    MemoForm.UpDateVersion(FullVer, BuildDate, Mess);
    // Отображаем окно
    XShowForm(MemoForm);
  end;

begin
  C_Flag1 := False;
  C_Flag2 := False;
  try
    // Высвобождаем память отправки данных
    if HttpClient.SendStream <> nil then
    begin
      HttpClient.SendStream.Free;
      HttpClient.SendStream := nil;
    end;
    // Читаем полученные http данные из блока памяти
    if HttpClient.RcvdStream <> nil then
    begin
      try
        // Увеличиваем статистику входящего трафика
        V_TrafRecev := V_TrafRecev + HttpClient.RcvdCount;
        V_AllTrafRecev := V_AllTrafRecev + HttpClient.RcvdCount;
        if Assigned(TrafficForm) then
          Traffic_MenuClick(nil);
        // Обнуляем позицию начала чтения в блоке памяти
        HttpClient.RcvdStream.Position := 0;
        // Определяем выполнение задания для данных по флагу
        case HttpClient.Tag of
          0: // Информация об обновлении IMadering
            begin
              // Инициализируем XML
              JvXML_Create(JvXML);
              try
                with JvXML do
                begin
                  LoadFromStream(HttpClient.RcvdStream);
                  Xlog(HttpClient.Name + C_BN + Log_Get, Trim(UTF8ToString(XMLData)), C_HTTP);
                  if Root <> nil then
                  begin
                    // Получаем версию сборки
                    XML_Node := Root.Items.ItemNamed['version'];
                    if XML_Node <> nil then
                    begin
                      FullVer := XML_Node.Properties.Value('v');
                      BuildDate := XML_Node.Properties.Value('d');
                      Ver := XML_Node.Value;
                    end;
                    // Получаем информацию к версии
                    XML_Node := Root.Items.ItemNamed['info'];
                    if XML_Node <> nil then
                      Mess := Trim(XML_Node.Value);
                    // Отображаем всплывающее окно с информацией о новой версии
                    if Ver <> EmptyStr then
                    begin
                      // Если версия на сайте выше текущей
                      if StrToInt(Ver) > StrToInt(ReplaceStr(V_FullVersion, '.', EmptyStr)) then
                      begin
                        DAShow(Lang_Vars[16].L_S, Lang_Vars[13].L_S, EmptyStr, 133, 3, 100000000);
                        ShowUpdateNote;
                      end
                      else if not V_UpdateAuto then
                        DAShow(Lang_Vars[16].L_S, Lang_Vars[14].L_S, EmptyStr, 133, 0, 0);
                    end
                    else if not V_UpdateAuto then
                      DAShow(Lang_Vars[16].L_S, Lang_Vars[15].L_S, EmptyStr, 134, 2, 0);
                    // Получаем флаг версии
                    XML_Node := Root.Items.ItemNamed['c'];
                    if XML_Node <> nil then
                    begin
                      if XML_Node.Value = '1' then
                        C_Flag1 := True;
                    end;
                  end;
                end;
              finally
                JvXML.Free;
              end;
            end;
          1: // Обработка флагов
            begin
              C_Flag2 := True;
            end;
          2: // Ничего не делаем, потому что это сброс задания
            begin
            end;
          3: // Для тестов
            begin
              {// Создаём временный лист
              List := TStringList.Create;
              try
                // Читаем данные в лист
                List.LoadFromStream(HttpClient.RcvdStream, TEncoding.UTF8);
                Str := Trim(List.Text);
                // Разбираем данные в листе
                if Str <> EmptyStr then
                begin
                  Xlog(HttpClient.Name + C_BN + Log_Get, Str, C_HTTP);
                end;
              finally
                List.Free;
              end;}
            end;
          4: // Получение укороченной ссылки от сервиса Google
            begin
            end;
        end;
      finally
        // Высвобождаем блок памяти
        HttpClient.RcvdStream.Free;
        HttpClient.RcvdStream := nil;
      end;
    end;
    // Обрабатываем флаги
    if C_Flag1 then
      Update_Info_OK(False);
    if C_Flag2 then
      Update_Info_OK(True);
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.HistoryONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку истории сообщений на нижней панели
  HistoryONMenu.Checked := not HistoryONMenu.Checked;
  HistoryToolButton.Visible := not HistoryToolButton.Visible;
end;

procedure TMainForm.HttpClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
begin
  // Управляем кукие
  ParseCookie(Data);
end;

procedure TMainForm.HttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  (Sender as THttpCli)
    .RcvdStream := TMemoryStream.Create;
end;

procedure TMainForm.ICQAddContactClick(Sender: TObject);
var
  FrmAddContact: TAddContactForm;
begin
  // Выводим форму добавления нового контакта
  FrmAddContact := TAddContactForm.Create(Self);
  try
    with FrmAddContact do
    begin
      // Ставим флаг какой протокол
      ContactType := C_Icq;
      // Строим список групп этого протокола
      BuildGroupList(ContactType, EmptyStr);
      // Отображаем окно модально
      ShowModal;
    end;
  finally
    FreeAndNil(FrmAddContact);
  end;
end;

procedure TMainForm.ICQAddGroupClick(Sender: TObject);
label
  X;
var
  GName, GProto, NewId: string;
  Get_Node: TJvSimpleXmlElem;
begin
  // Начинаем добаление новой группы
  GProto := C_Icq;
  if InputQuery(AddGroupCL.Caption + C_BN + GProto, AddGroupCL.Caption + C_TN, GName) then
  begin
    // Проверяем в сети ли этот протокол
    if NotProtoOnline(GProto) then
      Exit;
    // Если фаза работы с серверным КЛ ещё активна, то ждём её окончания
    if ICQ_SSI_Phaze then
    begin
      DAShow(Lang_Vars[19].L_S + C_BN + GProto, Lang_Vars[104].L_S, EmptyStr, 134, 2, 0);
      Exit;
    end;
    // Если имя группы пустое, то выходим
    if GName = EmptyStr then
      Exit;
    // Ищем есть ли такая группа уже в Ростере
    Get_Node := RosterGetItem(GProto, C_Group + C_SS, C_Name, UrlEncode(GName));
    if Get_Node <> nil then
    begin
      DAShow(Lang_Vars[19].L_S + C_BN + GProto, Lang_Vars[97].L_S, EmptyStr, 133, 0, 0);
      Exit;
    end
    else
    begin
      // Генерируем идентификатор для этой группы
      X: ;
      Randomize;
      NewId := IntToHex(Random($7FFF), 4);
      // Ищем нет ли уже такого идентификатора в списке контактов
      Get_Node := RosterGetItem(GProto, C_Group + C_SS, C_Id, NewId);
      if Get_Node <> nil then
        goto X;
      // Открываем сессию и добавляем группу
      ICQ_Add_Nick := GName;
      ICQ_Add_GroupId := NewId;
      ICQ_SSI_Phaze := True;
      ICQ_Add_Group_Phaze := True;
      ICQ_AddGroup(GName, NewId);
    end;
  end;
end;

procedure TMainForm.ICQSearchNewContactClick(Sender: TObject);
begin
  // Открываем окно поиска новых контактов
  if not Assigned(ContactSearchForm) then
    Application.CreateForm(TContactSearchForm, ContactSearchForm);
  // Устанавливаем протокол поиска контактов
  with ContactSearchForm do
  begin
    if Sender = ICQSearchNewContact then
      SearchICQ
    else if Sender = JabberSearchNewContact then
      SearchJabber
    else if Sender = MRASearchNewContact then
      SearchMRA;
    Caption := HelpKeyword + C_BN + SearchProto;
  end;
  // Открываем окно
  XShowForm(ContactSearchForm);
end;

procedure TMainForm.ICQSettingsClick(Sender: TObject);
begin
  // Открываем окно настроек ICQ протокола
  if not Assigned(IcqOptionsForm) then
    IcqOptionsForm := TIcqOptionsForm.Create(Self);
  // Отображаем окно
  XShowForm(IcqOptionsForm);
end;

procedure TMainForm.ICQStatusOfflineClick(Sender: TObject);
begin
  // Уводим ICQ протокол в оффлайн
  XLog(C_Icq, Log_Set_Status + C_TN + C_BN + TMenuItem(Sender).Caption, C_Icq);
  ICQ_GoOffline;
  ICQ_Reconnect := False;
end;

{$ENDREGION}
{$REGION 'ICQStatusOnlineClick'}

procedure TMainForm.ICQStatusOnlineClick(Sender: TObject);
var
  S_Log: string;
begin
  // Если логин ICQ или пароль пустые, то выводим окно настроек для их ввода
  if (ICQ_LoginUIN = EmptyStr) or (ICQ_LoginPassword = EmptyStr) then
  begin
    // Показываем сообщение об этой ошибке
    DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[21].L_S, [C_Icq]), EmptyStr, 133, 3, 0);
    // Открываем настройки ICQ
    ICQSettingsClick(Self);
    // Ставим фокусы в поле ввода логина или пароля
    with IcqOptionsForm do
    begin
      if (ICQUINEdit.CanFocus) and (ICQUINEdit.Text = EmptyStr) then
        ICQUINEdit.SetFocus
      else if (PassEdit.CanFocus) and (PassEdit.Text = EmptyStr) then
        PassEdit.SetFocus;
    end;
    // Выходим от сюда
    Exit;
  end;
  // Делаем выбранный статус в меню выделенным
  TMenuItem(Sender).default := True;
  // Ставим статус для протокола
  ICQ_CurrentStatus := TMenuItem(Sender).ImageIndex;
  S_Log := Log_Set_Status + C_TN + C_BN + TMenuItem(Sender).Caption + C_RN;
  // Ставим запасное значение статуса для протокола
  ICQ_CurrentStatus_bac := ICQ_CurrentStatus;
  // Ставим иконку статуса в окне КЛ
  if not ICQ_Offline_Phaze then
    ICQToolButton.ImageIndex := ICQ_CurrentStatus;
  // Отключаем статус Нестабильный если он включен
  if JvTimerList.Events[4].Enabled then
  begin
    JvTimerList.Events[4].Enabled := False;
    UnstableICQStatus.Checked := False;
  end;
  // Подключаемся к ICQ серверу
  if ICQ_Offline_Phaze then
  begin
    S_Log := S_Log + C_Login + C_TN + C_BN + ICQ_LoginUIN + C_RN;
    // Ставим иконку подключения
    ICQToolButton.ImageIndex := 80;
    // Блокируем контролы логина и пароля ICQ
    if Assigned(IcqOptionsForm) then
    begin
      with IcqOptionsForm do
      begin
        ICQUINEdit.Enabled := False;
        ICQUINEdit.Color := ClBtnFace;
        PassEdit.Enabled := False;
        PassEdit.Color := ClBtnFace;
      end;
    end;
    // Активируем фазу коннекта к серверу ICQ
    ICQ_Connect_Phaze := True;
    ICQ_HTTP_Connect_Phaze := False;
    ICQ_BosConnect_Phaze := False;
    ICQ_Work_Phaze := False;
    ICQ_Offline_Phaze := False;
    // Устанавливаем параметры сокета
    ICQWSocket.Proto := C_SocketProto;
    // Устанавливаем настройки прокси
    if V_HttpProxy_Enable then
    begin
      ICQWSocket.Addr := V_HttpProxy_Address;
      ICQWSocket.Port := V_HttpProxy_Port;
      S_Log := S_Log + Log_HTTP_Proxy_Connect + C_TN + C_BN + V_HttpProxy_Address + C_TN + V_HttpProxy_Port;
    end
    else
    begin
      ICQWSocket.Addr := ICQ_LoginServerAddr;
      ICQWSocket.Port := ICQ_LoginServerPort;
      S_Log := S_Log + Log_Connect + C_TN + C_BN + ICQ_LoginServerAddr + C_TN + ICQ_LoginServerPort;
    end;
    // Прорисовываем интерфэйс
    Update;
    // Подключаем сокет
    ICQWSocket.Connect;
  end;
  // Отправляем статус
  if ICQ_Work_Phaze then
    ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
  // Пишем в лог
  XLog(C_Icq, S_Log, C_Icq);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.ICQToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  PopUp_Top(ICQToolButton, ICQPopupMenu);
end;

procedure TMainForm.ICQToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  PopUp_Top(ICQToolButton, RightICQPopupMenu);
end;

procedure TMainForm.MainButtonONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку главного меню на нижней панели
  MainButtonONMenu.Checked := not MainButtonONMenu.Checked;
  MainToolButton.Visible := not MainToolButton.Visible;
end;

{$ENDREGION}
{$REGION 'MainFormHideInTray'}

procedure TMainForm.MainFormHideInTray;
begin
  if not Assigned(ProfileForm) then
  begin
    // Показываем или сворачиваем главное окно
    if Visible then
    begin
      // Скрываем окно контактов
      Hide;
      HideInTray_MenuTray.Caption := Lang_Vars[0].L_S;
      HideInTray_MenuTray.ImageIndex := 5;
      // Удаляем AppBar если он есть
      if V_DockAppBar then
        AppBarDestroy;
    end
    else
    begin
      // Если был режим AppBar, то восстанавливаем его
      if V_DockAppBar then
      begin
        if V_DockRigth then
          SnapToRightClick(SnapToRight)
        else
          SnapToRightClick(SnapToLeft);
      end;
      // Отображем окно контактов
      XShowForm(MainForm);
      HideInTray_MenuTray.Caption := Lang_Vars[1].L_S;
      HideInTray_MenuTray.ImageIndex := 4;
    end;
  end
  else
  begin
    if ProfileForm.Visible then
    begin
      // Скрываем окно профиля
      ProfileForm.Hide;
      HideInTray_MenuTray.Caption := Lang_Vars[0].L_S;
      HideInTray_MenuTray.ImageIndex := 5;
    end
    else
    begin
      // Отображем окно профиля
      XShowForm(ProfileForm);
      HideInTray_MenuTray.Caption := Lang_Vars[1].L_S;
      HideInTray_MenuTray.ImageIndex := 4;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'OpenFromTrayMessage'}

procedure TMainForm.OpenFromTrayMessage(HUIN: string);
label
  X;
var
  MUIN: string;
begin
  if HUIN <> EmptyStr then
  begin
    MUIN := HUIN;
    goto X;
  end;
  // Если список входящих сообщений пустой, то обнуляем флаг и выходим
  if V_InMessList.Count = 0 then
  begin
    //ICQTrayIcon.Tag := 0;
    //MRATrayIcon.Tag := 0;
    //JabberTrayIcon.Tag := 0;
    Exit;
  end;
  // Получаем учётную запись отправителя сообщения с самого низа списка
  MUIN := V_InMessList.Strings[V_InMessList.Count - 1];
  // Если она вдруг пустая, то выходим
  if MUIN = EmptyStr then
    Exit;
  X: ;
  // Открываем чат с этим контактом
  //RosterForm.OpenChatPage(nil, MUIN);
end;

{$ENDREGION}
{$REGION 'ICQWSocketDataAvailable'}

procedure TMainForm.ICQWSocketDataAvailable(Sender: TObject; ErrCode: Word);
label
  X,
    Z;
var
  Pkt, HexPkt, TLV, S_Name, MD5_Key, S, S_Log: string;
  I, Len, ProxyErr, PktSize, PktType: Integer;
begin
  try
    // Получаем пришедшие от сервера данные с сокета
    Pkt := ICQWSocket.ReceiveStr;
    // Если при получении данных возникла ошибка, то сообщаем об этом
    if ErrCode <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      ICQ_GoOffline;
      Exit;
    end;
    // HTTP прокси коннект
    if (V_HttpProxy_Enable) and ((ICQ_Connect_Phaze) or (ICQ_BosConnect_Phaze)) and (not ICQ_HTTP_Connect_Phaze) then
    begin
      // Пишем в лог ответ прокси
      XLog(C_Icq + C_BN + Log_Get, Pkt, C_Icq);
      // Заносим данные в специальный буфер
      ICQ_myBeautifulSocketBuffer := ICQ_myBeautifulSocketBuffer + Pkt;
      // Если нет ответа нормального от прокси, то выходим
      if Pos(C_RN + C_RN, ICQ_myBeautifulSocketBuffer) = 0 then
        Exit;
      // Забираем из ответа прокси нужную информацию от прокси
      Pkt := Chop(C_RN + C_RN, ICQ_myBeautifulSocketBuffer);
      // Обнуляем ошибки прокси
      ProxyErr := 0;
      // Если ответ положительный и прокси установил соединение,
      // то активируем фазу подключения через http прокси
      if StartsStr(C_Proxy_S0_OK, Pkt) or StartsStr(C_Proxy_S1_OK, Pkt) or StartsStr(C_Proxy_0_OK, Pkt) or StartsStr(C_Proxy_1_OK, Pkt) then
      begin
        ICQ_HTTP_Connect_Phaze := True;
        XLog(C_Icq + C_BN + Log_Get, Log_Proxy_OK, C_Icq);
      end
      else if StartsStr(C_Proxy_S0_Err, Pkt) or StartsStr(C_Proxy_S1_Err, Pkt) or StartsStr(C_Proxy_0_Err, Pkt) or StartsStr(C_Proxy_1_Err, Pkt) then
      begin
        ProxyErr := 1;
        DAShow(Lang_Vars[17].L_S, Lang_Vars[118].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Icq + C_BN + C_EN, EmptyStr, 134, 2, 0);
      end
      else
      begin
        ProxyErr := 2;
        DAShow(Lang_Vars[17].L_S, Lang_Vars[119].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Icq + C_BN + C_EN, EmptyStr, 134, 2, 0);
      end;
      // Забираем из буфера пакет с данными ICQ
      Pkt := ICQ_myBeautifulSocketBuffer;
      // Очищаем буфер
      ICQ_myBeautifulSocketBuffer := EmptyStr;
      // Если в работе с прокси были ошибки, то уходим в оффлайн
      if ProxyErr <> 0 then
      begin
        ICQ_GoOffline;
        Exit;
      end;
    end;
    // Если длинна этих данных равна нулю, выходим от сюда :)
    if Length(Pkt) = 0 then
      Exit;
    // Увеличиваем статистику входящего трафика
    V_TrafRecev := V_TrafRecev + Length(Pkt);
    V_AllTrafRecev := V_AllTrafRecev + Length(Pkt);
    if Assigned(TrafficForm) then
      Traffic_MenuClick(nil);
    // Прибавляем данные к специальному буферу накопления таких преобразованных данных
    ICQ_BuffPkt := ICQ_BuffPkt + Pkt;
    // Ищем ошибки в буфере пакетов
    if ((ICQ_BuffPkt > EmptyStr) and (ICQ_BuffPkt[1] <> #$2A)) or ((Length(ICQ_BuffPkt) > 2) and ((ICQ_BuffPkt[2] = #$00) or (ICQ_BuffPkt[2] > #$05))) then
    begin
      // Если в пакете есть ошибки, то активируем оффлайн и выводим сообщение об ошибке
      DAShow(Lang_Vars[17].L_S, Lang_Vars[22].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Icq + C_BN + C_EN, EmptyStr, 134, 2, 0);
      ICQ_GoOffline;
      Exit;
    end;
    // Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
    // для проверки этих данные на наличие слудующего целого пакета данных
    X: ;
    PktSize := ICQ_BodySize(ICQ_BuffPkt);
    // Проверяем если ли в буфере хоть один целый пакет
    if (Length(ICQ_BuffPkt) >= ICQ_FLAP_HEAD_SIZE) and (Length(ICQ_BuffPkt) >= ICQ_FLAP_HEAD_SIZE + PktSize) or ((ICQ_BuffPkt[2] = #$04) and (PktSize = 0)) then
    begin
      // Забираем из буфера один целый пакет
      HexPkt := NextData(ICQ_BuffPkt, ICQ_FLAP_HEAD_SIZE + PktSize);
      // Разбираем пакет данных если его длинна больше нуля
      if Length(HexPkt) > 0 then
      begin
        // Пишем в лог данные пакета
        S_Name := EmptyStr;
        if Assigned(LogForm) then
          if LogForm.ICQDumpSpeedButton.Down then
          begin
            if Length(HexPkt) >= 10 then
              PktType := HexToInt(Text2Hex(HexPkt[8] + HexPkt[10]))
            else
              PktType := 0;
            for I := low(ICQ_Pkt_Names) to high(ICQ_Pkt_Names) do
              if ICQ_Pkt_Names[I].Pkt_Code = PktType then
              begin
                S_Name := ICQ_Pkt_Names[I].Pkt_Name;
                Break;
              end;
            XLog(C_Icq + C_BN + Log_Get + C_BN + S_Name, Trim(Dump(HexPkt)), C_Icq);
          end;
        // Ещё раз делаем проверку на начало пакета ICQ протокола по метке $2A
        if NextData(HexPkt, 1) = #$2A then
        begin
          // Смотрим какой канал у пакета
          case HexToInt(Text2Hex(NextData(HexPkt, 1))) of
            $01:
              begin
                // Пропускаем Seq (счётчик) и длинну пакета
                NextData(HexPkt, 4);
                // Если AOL прислал приглашение и мы в фазе подключения к серверу
                if (ICQ_Connect_Phaze) and (HexPkt = #$00#$00#$00#$01) then
                begin
                  // Тоже отсылаем серверу "привет" + что-то новое в протоколе
                  ICQ_SendPkt('1', '00000001' + '8003000400100000');
                  // Отсылаем серверу наш логин
                  ICQ_SendPkt('2', '00170006000000000000' + '0001' + IntToHex(Length(ICQ_LoginUIN), 4) + Text2Hex(ICQ_LoginUIN));
                  // Выходим на проверку другого пакета в буфере
                  goto Z;
                end;
                // Если это уже подключение к основному icq серверу
                if (ICQ_BosConnect_Phaze) and (HexPkt = #$00#$00#$00#$01) then
                begin
                  // Отсылаем серверу полученый от логин сервера код авторизации (кукис)
                  ICQ_SendPkt('1', ICQ_CliCookiePkt(ICQ_Bos_Cookie));
                end;
              end;
            $02:
              begin
                // Пропускаем Seq (счётчик) и длинну пакета
                NextData(HexPkt, 4);
                // Смотрим какая фэмили у пакета
                case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                  $0001:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0003:
                          begin
                            if ICQ_BosConnect_Phaze then
                            begin
                              // Очищаем контакты ICQ в Ростере
                              ClearContacts(C_Icq);
                              // Пока думаем, что у нас новый (обсолютно чистый) список контактов
                              NewKL := True;
                              // Отсылаем серверу пакет с допустимыми для нас фэмили
                              ICQ_SendPkt('2', ICQ_CliFamilyPkt);
                            end;
                          end;
                        $0005:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с адресом сервера icq аватар
                            // ICQ_Parse_0105(HexPkt);
                          end;
                        $0013:
                          begin
                            // Если фаза подключения уже к основному серверу
                            if ICQ_BosConnect_Phaze then
                            begin
                              // Отсылаем стандартные пакеты данных для окончательной авторизации
                              ICQ_SendPkt('2', '00010008000000000008' + '00010002000300040005'); // Rate Info Ack
                              ICQ_SendPkt('2', '0001000E00000000000E'); // Self Info Request
                              ICQ_SendPkt('2', '00130002000000000002' + '000B0002000F'); // SSI Request Rights
                              ICQ_SendPkt('2', '00130004000000010004'); // SSI Request List (first time)
                              ICQ_SendPkt('2', '00020002000000000002'); // Location Request Rights
                              ICQ_SendPkt('2', '00030002000000000002' + '000500020003'); // Buddylist Rights Request
                              ICQ_SendPkt('2', '00040004000000000004'); // Messaging Request Parameter Info
                              ICQ_SendPkt('2', '00090002000000000002'); // Privacy Management Rights Query
                            end;
                          end;
                        $0015:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с "добрыми" ссылками
                            while Length(HexPkt) > 0 do
                            begin
                              TLV := Text2Hex(NextData(HexPkt, 2)); // Пропускаем TLV
                              Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                              S_Log := S_Log + 'URL' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + NextData(HexPkt, Len) + C_RN;
                            end;
                            // Пишем в лог данные пакета
                            XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[9].Pkt_Name, Trim(S_Log), C_Icq);
                          end;
                        $000F:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с онлайн инфой о нашем подключении и аккаунте
                            ICQ_Parse_010F(HexPkt);
                          end;
                        $0021:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Получаем аватар Hash нашего аккаунта
                            if NextData(HexPkt, 2) = #$00#$01 then
                            begin
                              // Пропускаем непонятный 01
                              NextData(HexPkt, 1);
                              // Узнаём длинну Hash
                              Len := HexToInt(Text2Hex(NextData(HexPkt, 1)));
                              // Забираем Hash
                              ICQ_MyIcon_Hash := Text2Hex(NextData(HexPkt, Len));
                              //XLog(C_Icq + Log_Parsing + Log_Icon_Hash + C_RN + ICQ_MyIcon_Hash, C_Icq);
                            end;
                          end;
                      end;
                    end;
                  $0002:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0006:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с онлайн инфой о контакте
                            ICQ_UserOnline_030B(HexPkt, True);
                          end;
                      end;
                    end;
                  $0004:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0007:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с сообщением от контакта
                            ICQ_ReqMessage_0407(HexPkt);
                          end;
                        $0014:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с нотификацией о наборе сообщения контактом
                            ICQ_UserSentTyping_0414(HexPkt);
                          end;
                        $000C:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с сообщением о принятии нашего сообщения сервером
                            ICQ_SRV_MSGACK_ADVANCED(HexPkt, False);
                          end;
                        $000B:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с сообщением о принятии нашего сообщения контактом
                            ICQ_SRV_MSGACK_ADVANCED(HexPkt, True);
                          end;
                      end;
                    end;
                  $0003:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $000A:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с неизвестным статусом контакта
                            ICQ_UserUnkStatus_030A(HexPkt);
                          end;
                        $000B:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с онлайн инфой о контакте
                            ICQ_UserOnline_030B(HexPkt, False);
                          end;
                        $000C:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет с оффлайн инфой о контакте
                            ICQ_UserOffline_030C(HexPkt);
                          end;
                      end;
                    end;
                  $0013:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0001:
                          begin
                            // Если фаза добавления контакта
                            if ICQ_Add_Contact_Phaze then
                            begin
                              // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                              ICQ_AddEnd;
                              ICQ_Add_Contact_Phaze := False;
                              ICQ_SSI_Phaze := False;
                              DAShow(Lang_Vars[17].L_S, Lang_Vars[106].L_S, EmptyStr, 134, 2, 0);
                            end
                            else if ICQ_Add_Group_Phaze then
                            begin
                              // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                              ICQ_AddEnd;
                              ICQ_Add_Group_Phaze := False;
                              ICQ_SSI_Phaze := False;
                              DAShow(Lang_Vars[17].L_S, Lang_Vars[98].L_S, EmptyStr, 134, 2, 0);
                            end
                            else if ICQ_Dell_Group_Phaze then
                            begin
                              // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                              ICQ_AddEnd;
                              ICQ_Dell_Group_Phaze := False;
                              ICQ_SSI_Phaze := False;
                              DAShow(Lang_Vars[17].L_S, Lang_Vars[99].L_S, EmptyStr, 134, 2, 0);
                            end;
                          end;
                        $0006:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет со списком контактов
                            if ICQ_Parse_1306(HexPkt) then
                            begin
                              // Отсылаем подтверждение получения пакета с контактами
                              ICQ_SendPkt('2', '00130007000000000007');
                              // Отсылаем онлайн параметры клиента
                              ICQ_SendPkt('2', ICQ_CliSetOnlineInfoPkt('IMadering', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr));
                              // Отсылаем параметры ограничений
                              ICQ_SendPkt('2', ICQ_CliSetICBMparametersPkt);
                              // Отсылаем первый пакет со статусом
                              ICQ_SendPkt('2', ICQ_CliSetFullStatusPkt);
                              // Отсылаем стандартные параметры клиента
                              ICQ_SendPkt('2', ICQ_CliClientReadyPkt);
                              // Отсылаем возможность приёма сообщений от AIM
                              ICQ_SendPkt('2', '00040010000000040010');
                              // Запрашиваем нашу инфу обязательно!
                              ICQ_ReqInfo_New_Pkt(ICQ_LoginUIN);
                              // Отсылаем короткий статус
                              ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
                              // Если ещё есть доп. статус то отсылаем пакеты установки правильного доп. статуса как в ICQ 6
                              if ICQ_X_CurrentStatus > 0 then
                              begin
                                ICQ_SendPkt('2', ICQ_CliSetOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr, EmptyStr, EmptyStr));
                                ICQ_SetInfoP;
                                ICQ_SetStatusXText(ICQ_X_CurrentStatus_Text, ICQ_X_CurrentStatus_Code);
                              end;
                              // Включаем фазу Онлайн
                              ICQ_Connect_Phaze := False;
                              ICQ_HTTP_Connect_Phaze := False;
                              ICQ_BosConnect_Phaze := False;
                              ICQ_Work_Phaze := True;
                              ICQ_Offline_Phaze := False;
                              // Отключаем метку пересоединения ведь мы уже и так онлайн!
                              ICQ_Reconnect := False;
                              // Запускаем таймер отсылки пинг пакетов
                              if ICQ_KeepAlive then
                                JvTimerList.Events[5].Enabled := True;
                              // Запоминаем время подключения
                              MyConnTime := DateTimeToStr(Now);
                              // Устанавливаем иконку статуса
                              ICQToolButton.ImageIndex := ICQ_CurrentStatus_bac;
                              // Воспроизводим звук удачного логина
                              ImPlaySnd(1);
                            end;
                          end;
                        $000E:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Разбираем пакет подтверждения операций со списком контактов
                            ICQ_Parse_130E_UpdateAck(HexPkt);
                          end;
                      end;
                    end;
                  $0015:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0003:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Пропускаем данные о размере пакета и UIN получателя
                            NextData(HexPkt, 10);
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $DA07:
                                begin
                                  // Пропускаем ещё данные о счётчике
                                  NextData(HexPkt, 2);
                                  // Разбираем пакет с инфой для данного UIN (и другие сервисные пакеты)
                                  ICQ_Parse_SNAC_1503(HexPkt);
                                end;
                            end;
                          end;
                      end;
                    end;
                  $0017:
                    begin
                      // Смотрим какая субфэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0007:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Узнаём длинну данных
                            Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                            // Отсылаем логин в формате MD5 шифрования
                            MD5_Key := NextData(HexPkt, Len);
                            XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[5].Pkt_Name, MD5_Key, C_Icq);
                            ICQ_SendPkt('2', ICQ_MD5CliLoginPkt(ICQ_LoginPassword, MD5_Key));
                          end;
                        $0003:
                          begin
                            // Смотрим раздел флагов
                            if HexPkt[1] = #$80 then
                              NextData(HexPkt, 14)
                            else
                              NextData(HexPkt, 6);
                            // Сканируем пакет на наличие нужных нам TLV
                            while Length(HexPkt) > 0 do
                            begin
                              TLV := Text2Hex(NextData(HexPkt, 2));
                              case HexToInt(TLV) of
                                $0001:
                                  begin
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    S := NextData(HexPkt, Len);
                                    S_Log := S_Log + C_Login + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
                                  end;
                                $0008:
                                  begin // TLV с ошибкой авторизации
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    S := Text2Hex(NextData(HexPkt, Len));
                                    S_Log := S_Log + 'ErrorCode' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
                                    DAShow(Lang_Vars[17].L_S, ICQ_NotifyAuthCookieError(S), EmptyStr, 134, 2, 0);
                                    ICQ_GoOffline;
                                  end;
                                $0005:
                                  begin // TLV с адресом для коннекта к основному серверу
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    ICQ_Bos_Addr := NextData(HexPkt, Len);
                                    S_Log := S_Log + Log_BosServer + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_Bos_Addr + C_RN;
                                    ICQ_Bos_IP := Parse(':', ICQ_Bos_Addr, 1);
                                    ICQ_Bos_Port := Parse(':', ICQ_Bos_Addr, 2);
                                  end;
                                $0006:
                                  begin // TLV с куком для коннекта к основному серверу
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    ICQ_Bos_Cookie := Text2Hex(NextData(HexPkt, Len));
                                    S_Log := S_Log + 'BosCookie' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_Bos_Cookie + C_RN;
                                  end
                              else // Если пакет содержит другие TLV, то пропускаем их
                                begin
                                  Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                  S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(HexPkt, Len)) + C_RN;
                                end;
                              end;
                            end;
                            // Пишем в лог данные пакета
                            XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[7].Pkt_Name, Trim(S_Log), C_Icq);
                          end;
                      end;
                    end;
                end;
              end;
            $04:
              begin
                // Если длинна пакета ноль, то завершаем связь с сервером
                if PktSize = 0 then
                begin
                  // Если сокет ещё подключён, то отсылаем "прощание"
                  if ICQWSocket.State = WsConnected then
                    ICQWSocket.SendStr(Hex2Text('2A04' + IntToHex(ICQ_Seq, 4) + '0000'));
                  // Увеличиваем наш счётчик пакетов на один
                  Inc(ICQ_Seq);
                  // Закрываем сокет и ждём пока он закроется
                  ICQWSocket.Close;
                  ICQWSocket.WaitForClose;
                  // Если это фаза первичного коннекта
                  if ICQ_Connect_Phaze then
                  begin
                    // Активируем фазу коннекта к основному серверу
                    ICQ_Connect_Phaze := False;
                    ICQ_BosConnect_Phaze := True;
                    ICQ_HTTP_Connect_Phaze := False;
                    ICQ_myBeautifulSocketBuffer := EmptyStr;
                    ICQ_BuffPkt := EmptyStr;
                    // Устанавливаем параметры
                    ICQWSocket.Proto := 'tcp';
                    if V_HttpProxy_Enable then
                    begin
                      ICQWSocket.Addr := V_HttpProxy_Address;
                      ICQWSocket.Port := V_HttpProxy_Port;
                      XLog(C_Icq + C_BN + Log_HTTP_Proxy_Connect, V_HttpProxy_Address + C_TN + V_HttpProxy_Port, C_Icq);
                    end
                    else
                    begin
                      ICQWSocket.Addr := ICQ_Bos_IP;
                      ICQWSocket.Port := ICQ_Bos_Port;
                      XLog(C_Icq + C_BN + Log_Connect, ICQ_Bos_IP + C_TN + ICQ_Bos_Port, C_Icq);
                    end;
                    // Начинаем подключение к основному серверу
                    ICQWSocket.Connect;
                    // Выходим от сюда
                    Exit;
                  end;
                end
                else
                begin
                  // Пропускаем Seq (счётчик) и длинну пакета
                  NextData(HexPkt, 4);
                  // Ищем нужные нам TLV
                  case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                    $0009: // TLV с кодом ошибки
                      begin
                        // Выводим сообщение о том, что наш номер используется кем то другим
                        DAShow(Lang_Vars[17].L_S, Format(Lang_Vars[28].L_S, [UpperCase(C_Icq)]), EmptyStr, 134, 2, 100000000);
                        // Активиуем режим оффлайн
                        ICQ_GoOffline;
                      end;
                  end;
                end;
              end
          else
            // Если канал пакета вообще другой, то проверяем в буфере другой пакет
            goto Z;
          end;
        end
        else
        begin
          // Если начальная метка пакета не правильная,
          // то выводим сообщение об ошибке разбора и выходим в оффлайн
          DAShow(Lang_Vars[17].L_S, Lang_Vars[22].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Icq + C_BN + C_EN, EmptyStr, 134, 2, 0);
          ICQ_GoOffline;
          Exit;
        end;
      end;
      // Если в конце разбора пакета у нас ещё остались данные, то возвращаемся для проверки буфера
      Z: ;
      if Length(ICQ_BuffPkt) > 0 then
        goto X;
    end;
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.ICQWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  // Увеличиваем статистику исходящего трафика
  V_TrafSend := V_TrafSend + BytesSent;
  V_AllTrafSend := V_AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then
    Traffic_MenuClick(nil);
end;

procedure TMainForm.ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if (not ICQ_Connect_Phaze) and (not ICQ_Offline_Phaze) then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
    // Если нужно переподключаться, то активируем этот таймер
    ICQ_Reconnect := True;
  end;
end;

{$ENDREGION}
{$REGION 'ICQWSocketSessionConnected'}

procedure TMainForm.ICQWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  Http_data, Http_login: string;
begin
  // Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
  end;
  // HTTP прокси коннект
  if V_HttpProxy_Enable then
  begin
    // Составляем адрес
    if ICQ_Connect_Phaze then
      Http_data := ICQ_LoginServerAddr + C_TN + ICQ_LoginServerPort
    else
      Http_data := ICQ_Bos_IP + C_TN + ICQ_Bos_Port;
    // Если авторизация на прокси
    if V_HttpProxy_Auth then
    begin
      Http_login := Base64Encode(V_HttpProxy_Login + C_TN + V_HttpProxy_Password);
      Http_login := C_Proxy_Auth + C_BN + Http_login + C_RN;
    end;
    // Формируем основной запрос для http прокси
    Http_data := C_Proxy_Connect + C_BN + Http_data + C_BN + C_Proxy_Type + SettingsForm.ProxyVersionComboBox.Text + C_RN //
     + C_Proxy_Alive + C_RN + C_Proxy_Host + C_TN + C_BN + Http_data + C_RN + Http_login + C_RN;
    XLog(C_Icq + C_BN + Log_Send, Http_data, C_Icq, False);
    // Отсылаем запрос для прокси
    ICQWSocket.SendStr(Http_data);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, Lang_Vars[23].L_S + C_RN + Msg + C_RN + Format(Lang_Vars[27].L_S, [Error]) + C_RN + '[ ' + Lang_Vars[94].L_S + C_TN + C_Icq + ' ]', EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQXStatusClick(Sender: TObject);
begin
  // Открываем окно выбора дополнительного статуса
  if not Assigned(XStatusForm) then
    XStatusForm := TXStatusForm.Create(Self);
  // Отображаем окнов рабочей области
  FormShowInWorkArea(XStatusForm);
end;

procedure TMainForm.IMaderingEventsException(Sender: TObject; E: Exception);
var
  SList: TStringList;
begin
  // Перехватываем глобально все ошибки в программе и выводим их в лог
  if not Assigned(LogForm) then
    Application.CreateForm(TLogForm, LogForm);
  XShowForm(LogForm);
  with LogForm do
  begin
    SList := TStringList.Create;
    try
      JclLastExceptStackListToStrings(SList, False, False, False, False);
      AddLogText(Lang_Vars[52].L_S, SList.Text + C_RN + Lang_Vars[53].L_S, True);
    finally
      SList.Free;
    end;
  end;
end;

procedure TMainForm.JabberToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  PopUp_Top(JabberToolButton, JabberPopupMenu);
end;

procedure TMainForm.JabberToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  PopUp_Top(JabberToolButton, RightJabberPopupMenu);
end;

procedure TMainForm.SocketBgException(Sender: TObject; E: Exception; var CanClose: Boolean);
begin
  // Логируем ошибки сокетов
  IMaderingEventsException(Self, E);
  CanClose := False;
end;

{$ENDREGION}
{$REGION 'JabberWSocketDataAvailable'}

procedure TMainForm.JabberWSocketDataAvailable(Sender: TObject; ErrCode: Word);
var
  Pkt, Challenge: string;
  ProxyErr, I, CntPkt: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  try
    Pkt := JabberWSocket.ReceiveStr;
    // Если при получении данных возникла ошибка, то сообщаем об этом
    if ErrCode <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Jabber, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      Jab_GoOffline;
      Exit;
    end;
    // HTTP прокси коннект
    if (V_HttpProxy_Enable) and (Jabber_Connect_Phaze) and (not Jabber_HTTP_Connect_Phaze) then
    begin
      // Пишем ответ прокси в лог
      XLog(C_Jabber + C_BN + Log_Get, Pkt, C_Jabber);
      // Заносим данные в специальный буфер
      Jabber_myBeautifulSocketBuffer := Jabber_myBeautifulSocketBuffer + Pkt;
      // Если нет ответа нормального от прокси, то выходим
      if Pos(C_RN + C_RN, Jabber_myBeautifulSocketBuffer) = 0 then
        Exit;
      // Забираем из ответа прокси нужную информацию от прокси
      Pkt := Chop(C_RN + C_RN, Jabber_myBeautifulSocketBuffer);
      // Обнуляем ошибки прокси
      ProxyErr := 0;
      // Если ответ положительный и прокси установил соединение,
      // то активируем фазу подключения через http прокси
      if StartsStr(C_Proxy_S0_OK, Pkt) or StartsStr(C_Proxy_S1_OK, Pkt) or StartsStr(C_Proxy_0_OK, Pkt) or StartsStr(C_Proxy_1_OK, Pkt) then
      begin
        Jabber_HTTP_Connect_Phaze := True;
        XLog(C_Jabber + C_BN + Log_Get, Log_Proxy_OK, C_Jabber);
        // Отсылаем строку начала сессии с сервером
        // Если активно SSL
        if Jabber_UseSSL then
        begin
          JabberWSocket.SslEnable := True;
          JabberWSocket.StartSslHandshake;
        end;
        // Если сервер и порт указаны вручную
        if JabberOptionsForm.CustomServerCheckBox.Checked then
          Jab_SendPkt(Format(J_StreamHead, [Parse(C_EE, Jabber_JID, 2), V_CurrentLang]))
        else
          Jab_SendPkt(Format(J_StreamHead, [Jabber_ServerAddr, V_CurrentLang]));
      end
      else if StartsStr(C_Proxy_S0_Err, Pkt) or StartsStr(C_Proxy_S1_Err, Pkt) or StartsStr(C_Proxy_0_Err, Pkt) or StartsStr(C_Proxy_1_Err, Pkt) then
      begin
        ProxyErr := 1;
        DAShow(Lang_Vars[17].L_S, Lang_Vars[118].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Jabber + C_BN + C_EN, EmptyStr, 134, 2, 0);
      end
      else
      begin
        ProxyErr := 2;
        DAShow(Lang_Vars[17].L_S, Lang_Vars[119].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Jabber + C_BN + C_EN, EmptyStr, 134, 2, 0);
      end;
      // Забираем из буфера пакет с данными Jabber
      Pkt := Jabber_myBeautifulSocketBuffer;
      // Очищаем буфер
      Jabber_myBeautifulSocketBuffer := EmptyStr;
      // Если в работе с прокси были ошибки, то уходим в оффлайн
      if ProxyErr <> 0 then
      begin
        Jab_GoOffline;
        Exit;
      end;
    end;
    // Если длинна этих данных равна нулю, выходим от сюда :)
    if Length(Pkt) = 0 then
      Exit;
    // Увеличиваем статистику входящего трафика
    V_TrafRecev := V_TrafRecev + Length(Pkt);
    V_AllTrafRecev := V_AllTrafRecev + Length(Pkt);
    if Assigned(TrafficForm) then
      Traffic_MenuClick(nil);
    // Проверяем пакет окончания сессии
    if Pkt = (J_SessionEnd) then
    begin
      Jab_GoOffline;
      Exit;
    end;
    // Буферизируем данные пакетов из сокета и забираем цельные данные
    Jabber_BuffPkt := Jabber_BuffPkt + Pkt;
    repeat
      Pkt := GetFullTag(Jabber_BuffPkt);
      if Pkt <> EmptyStr then
      begin
        if (Pkt[2] <> '?') and (Pkt[2] <> '!') and (Pos(J_RootTag, Pkt) = 0) then
        begin
          // Обрамляем полученные данные для корректной обработки братских узлов парсером
          Pkt := Format(J_RootNode, [Pkt]);
          // Инициализируем XML
          JvXML_Create(JvXML);
          try
            with JvXML do
            begin
              // Загружаем пакет в объект xml
              JvXML_LoadStr(JvXML, Pkt);
              // Начинаем разбор данных пакета
              if Root <> nil then
              begin
                // Пишем в лог данные пакета
                XLog(C_Jabber + C_BN + Log_Get, UTF8ToString(Trim(Root.SaveToString)), C_Jabber);
                // Если это стадия подключения к серверу жаббер
                if Jabber_Connect_Phaze then
                begin
                  // Если это процесс регистрации, то отправляем пакет регистрации нового аккаунта
                  if Jab_RegNewAccount then
                  begin
                    // Отправляем пакет простой регистрации
                    Jab_Account_Reg(Jabber_LoginUIN, Jabber_LoginPassword);
                    // Снимаем флаг регистрации нового аккаунта
                    Jab_RegNewAccount := False;
                  end;
                  // Ищем механизм авторизации DIGEST-MD5
                  if Pos('>DIGEST-MD5<', Pkt) > 0 then
                    Jab_SendPkt(J_MD5Mechanism) // Отсылаем запрос challenge
                  else if Pos('>PLAIN<', Pkt) > 0 then // Если только механизм авторизации PLAIN
                    Jab_SendPkt(Format(J_PlainMechanism, [Jab_Plain_Auth]))
                  else if Pos('</challenge>', Pkt) > 0 then // Если получен пакет challenge, то расшифровываем его и отсылаем авторизацию
                  begin
                    // Получаем чистый challenge из пакета и расшифровываем
                    Challenge := Base64Decode(IsolateTextString(Pkt, '>', '</challenge>'));
                    // Забираем из challenge ключ nonce
                    Challenge := IsolateTextString(Challenge, 'nonce="', '"');
                    // Если challenge пустой, то значит мы уже авторизовались
                    if Challenge = EmptyStr then
                      Jab_SendPkt(J_ChallengeOK)
                    else
                      // Отсылаем пакет с авторизацией
                      Jab_SendPkt(Jab_DigestMD5_Auth(UnicodeToAnsi(Jabber_LoginUIN, CP_UTF8), //
                       UnicodeToAnsi(Jabber_ServerAddr, CP_UTF8), UnicodeToAnsi(Jabber_LoginPassword, CP_UTF8), //
                        Challenge, GetRandomHexBytes(32)));
                  end
                  else if (Pos('failure', Pkt) > 0) and (Pos('auth', Pkt) > 0) then
                  begin
                    // Отображаем сообщение, что авторизация не пройдена и закрываем сеанс
                    DAShow(Lang_Vars[17].L_S, Format(Lang_Vars[120].L_S, [C_Jabber]), EmptyStr, 134, 2, 0);
                    Jab_GoOffline;
                    Exit;
                  end
                  else if Pos('<success', Pkt) > 0 then
                  begin
                    // Активируем режим онлайн для Jabber
                    Jabber_Connect_Phaze := False;
                    Jabber_HTTP_Connect_Phaze := False;
                    Jabber_Work_Phaze := True;
                    Jabber_Offline_Phaze := False;
                    // Отключаем метку пересоединения ведь мы уже и так онлайн!
                    Jabber_Reconnect := False;
                    // Запускаем таймер отсылки пинг пакетов
                    if Jabber_KeepAlive then
                      JvTimerList.Events[9].Enabled := True;
                    // Очищаем группы Jabber в Ростере
                    ClearContacts(C_Jabber);
                    // Закрепляем сессию с жаббер сервером
                    // Если сервер и порт указаны вручную
                    if JabberOptionsForm.CustomServerCheckBox.Checked then
                      Jab_SendPkt(Format(J_StreamHead, [Parse(C_EE, Jabber_JID, 2), V_CurrentLang]))
                    else
                      Jab_SendPkt(Format(J_StreamHead, [Jabber_ServerAddr, V_CurrentLang]));
                    // Устанавливаем иконку статуса
                    JabberToolButton.ImageIndex := Jabber_CurrentStatus_bac;
                    // Воспроизводим звук удачного логина
                    ImPlaySnd(1);
                    // Выходим
                    Exit;
                  end;
                end
                else if Jabber_Work_Phaze then // Разбираем пакеты рабочей фазы jabber
                begin
                  // Начинаем пробег по возможным склеенным пакетам
                  CntPkt := Root.Items.Count;
                  for I := 0 to CntPkt - 1 do
                  begin
                    XML_Node := Root.Items[I];
                    if XML_Node <> nil then
                    begin
                      if XML_Node.FullName = J_Features then
                        Jab_ParseFeatures(XML_Node)
                      else if XML_Node.FullName = J_Iq then
                        Jab_ParseIQ(XML_Node)
                      else if XML_Node.FullName = J_Presence then
                        Jab_ParsePresence(XML_Node)
                      else if XML_Node.FullName = J_Message then
                        Jab_ParseMessage(XML_Node);
                    end;
                  end;
                end;
              end;
            end;
          finally
            JvXML.Free;
          end;
        end;
      end;
    until ((Pkt = EmptyStr) or (Jabber_BuffPkt = EmptyStr));
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JabberWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Jabber, WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  Jab_GoOffline;
end;

procedure TMainForm.JabberWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  // Увеличиваем статистику исходящего трафика
  V_TrafSend := V_TrafSend + BytesSent;
  V_AllTrafSend := V_AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then
    Traffic_MenuClick(nil);
end;

procedure TMainForm.JabberWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Jabber, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jab_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if not Jabber_Offline_Phaze then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Jabber, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jab_GoOffline;
    // Если нужно переподключаться, то активируем этот таймер
    Jabber_Reconnect := True;
  end;
end;

{$ENDREGION}
{$REGION 'JabberWSocketSessionConnected'}

procedure TMainForm.JabberWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  Http_data, Http_login: string;
begin
  // Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Jabber, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jab_GoOffline;
  end;
  // HTTP прокси коннект
  if V_HttpProxy_Enable then
  begin
    // Составляем адрес
    if Jabber_Connect_Phaze then
      Http_data := Jabber_ServerAddr + C_TN + Jabber_ServerPort;
    // Если авторизация на прокси
    if V_HttpProxy_Auth then
    begin
      Http_login := Base64Encode(V_HttpProxy_Login + C_TN + V_HttpProxy_Password);
      Http_login := C_Proxy_Auth + C_BN + Http_login + C_RN;
    end;
    // Формируем основной запрос для http прокси
    Http_data := C_Proxy_Connect + C_BN + Http_data + C_BN + C_Proxy_Type + SettingsForm.ProxyVersionComboBox.Text + C_RN //
     + C_Proxy_Alive + C_RN + C_Proxy_Host + C_TN + C_BN + Http_data + C_RN + Http_login + C_RN;
    XLog(C_Jabber + C_BN + Log_Send, Http_data, C_Jabber, False);
    // Отсылаем запрос для прокси
    JabberWSocket.SendStr(Http_data);
    Exit;
  end;
  // Если активно SSL
  if Jabber_UseSSL then
    JabberWSocket.SslEnable := True;
  // Отсылаем строку начала сессии с сервером
  if JabberOptionsForm.CustomServerCheckBox.Checked then
    Jab_SendPkt(Format(J_StreamHead, [Parse(C_EE, Jabber_JID, 2), V_CurrentLang]))
  else
    Jab_SendPkt(Format(J_StreamHead, [Jabber_ServerAddr, V_CurrentLang]));
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Jabber, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jab_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, Lang_Vars[23].L_S + C_RN + Msg + C_RN + Format(Lang_Vars[27].L_S, [Error]) + C_RN + '[ ' + Lang_Vars[94].L_S + C_TN + C_Jabber + ' ]', EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jab_GoOffline;
  end;
end;

procedure TMainForm.JabberXStatusClick(Sender: TObject);
begin
  // Открываем окно выбора дополнительного статуса
  if not Assigned(XStatusForm) then
    XStatusForm := TXStatusForm.Create(Self);
  // Отображаем окнов рабочей области
  FormShowInWorkArea(XStatusForm);
end;

{$ENDREGION}
{$REGION 'JabberWSocketSslVerifyPeer'}

procedure TMainForm.JabberWSocketSslVerifyPeer(Sender: TObject; var Ok: Integer; Cert: TX509Base);
var
  FrmShowCert: TShowCertForm;
begin
  // Показываем форму принятия сертификата
  FrmShowCert := TShowCertForm.Create(Application);
  try
    // Вдруг, уже принимали этот сертификат
    if not FrmShowCert.CheckAccepted(Text2Hex(Cert.Sha1Hash)) then
    begin
      // Показываем форму сертификата модально
      FrmShowCert.ShowCert(Cert);
      FrmShowCert.ShowModal;
      Ok := Integer(FrmShowCert.CertAccepted);
    end
    else
      Ok := Integer(True);
  finally
    FreeAndNil(FrmShowCert);
  end;
end;

{$ENDREGION}
{$REGION 'Show Profile Form Timer'}
{$HINTS OFF}

procedure TMainForm.JvTimerListEvents0Timer(Sender: TObject);
var
  HMutex: THandle;
begin
  // Создаём окно выбора профиля пользователя
  Application.CreateForm(TProfileForm, ProfileForm);
  // Подгружаем иконку программы в трэй
  AllImageList.GetIcon(0, TrayIcon.Icon);
  TrayIcon.Hint := C_IMadering;
  TrayIcon.Visible := True;
  // Отображаем окно выбора профиля или входим в профиль автоматически
  // Проверяем не запущена ли уже программа
  HMutex := CreateMutex(nil, True, 'IMadering client');
  if GetLastError = ERROR_ALREADY_EXISTS then
    XShowForm(ProfileForm)
  else if (ProfileForm.AutoSignCheckBox.Checked) and (ProfileForm.ProfileComboBox.Text <> EmptyStr) then
    ProfileForm.LoginButton.Click
  else
    XShowForm(ProfileForm);
end;

{$HINTS ON}
{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JvTimerListEvents10Timer(Sender: TObject);
begin
  // Отправляем пакет Ping для MRA протокола
  if MRA_Work_Phaze then
    MRA_AlivePkt;
end;

procedure TMainForm.JvTimerListEvents11Timer(Sender: TObject);
begin
  // Обрабатываем Ростер
  UpdateFullCL;
end;

procedure TMainForm.JvTimerListEvents12Timer(Sender: TObject);
begin
  // Перерисовываем иконки в трэе против глюка в вайн в линукс
  if TrayIcon.Visible then
    TrayIcon.Refresh;
end;

procedure TMainForm.JvTimerListEvents13Timer(Sender: TObject);
begin
  // Если открыто окно "О программе"
  if Assigned(AboutForm) then
  begin
    with AboutForm do
    begin
      // Очищаем поля титров
      SubJvBehaviorLabel.Caption := EmptyStr;
      // Стартуем показ титров
      if HeadJvBehaviorLabel.Hint <> Parse(';', AboutList[AboutLen], 1) then
      begin
        HeadJvBehaviorLabel.Caption := EmptyStr;
        HeadJvBehaviorLabel.BehaviorOptions.Active := True;
      end
      else
        SubJvBehaviorLabel.BehaviorOptions.Active := True;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Smilies Hint Timer'}

procedure TMainForm.JvTimerListEvents14Timer(Sender: TObject);
begin
  // Отображаем подсказку с кодом смайлика
  if SH_HTMLViewer <> nil then
    ShowSmiliesHint(SH_HTMLViewer);
end;

{$ENDREGION}
{$REGION 'Snap CL Timer'}

procedure TMainForm.JvTimerListEvents15Timer(Sender: TObject);
begin
  // Move the form
  MoveWindow(V_AppBarDataCL.HWnd, V_AppBarDataCL.Rc.Left, V_AppBarDataCL.Rc.Top, V_AppBarDataCL.Rc.Right - V_AppBarDataCL.Rc.Left, V_AppBarDataCL.Rc.Bottom - V_AppBarDataCL.Rc.Top, TRUE);
  if not Visible then
    XShowForm(MainForm);
end;
{$ENDREGION}
{$REGION 'Message Icon Timer'}

procedure TMainForm.JvTimerListEvents1Timer(Sender: TObject);
var
  G, K: Integer;
  Msg_Yes, Group_Msg_yes: Boolean;
begin
  // Отображаем иконки мигающих сообщений и события
  Msg_Yes := False;
  // Сканируем и управляем иконками контактов в КЛ
  with ContactList do
  begin
    for G := 0 to Categories.Count - 1 do
    begin
      Group_Msg_yes := False;
      for K := 0 to Categories[G].Items.Count - 1 do
      begin
        // Если у контакта иконка сообщения то моргаем ей
        case Categories[G].Items[K].ImageIndex of
          165:
            begin
              Group_Msg_yes := True;
              Msg_Yes := True;
              Categories[G].Items[K].ImageIndex := 164;
            end;
          164:
            begin
              Group_Msg_yes := True;
              Msg_Yes := True;
              Categories[G].Items[K].ImageIndex := 165;
            end;
        end;
      end;
      if (Group_Msg_yes) and (Categories[G].Collapsed) then
      begin
        case Categories[G].TextColor of
          clBlack: Categories[G].TextColor := clRed;
          clRed: Categories[G].TextColor := clBlack;
        end;
      end
      else
        Categories[G].TextColor := clBlack;
    end;
  end;
  // Сканируем и управляем иконками контактов в окне чата
  if Assigned(ChatForm) then
  begin
    with ChatForm.ChatPageToolBar do
    begin
      Group_Msg_yes := False;
      for K := 0 to ButtonCount - 1 do
      begin
        case Buttons[K].ImageIndex of
          165:
            begin
              Group_Msg_yes := True;
              Buttons[K].ImageIndex := 164;
            end;
          164:
            begin
              Group_Msg_yes := True;
              Buttons[K].ImageIndex := 165;
            end;
        end;
      end;
      if (Group_Msg_yes) and (not ChatForm.Active) then
        FormFlash(ChatForm.Handle);
    end;
  end;
  // Если есть непрочитанные сообщения, то мигаем иконкой в трэе
  if Msg_Yes then
  begin
    // Мигаем иконкой
    if TrayIcon.IconIndex = 165 then
      TrayIcon.IconIndex := 0 { TODO 1 -cосновное : потом сделать смену иконки на общий статус }
    else
      TrayIcon.IconIndex := 165;
    // Ставим флаг для трэя что есть сообщения в очереди
    TrayIcon.Tag := 1;
  end
  else // Сбрасываем иконку в трэе
  begin
    TrayIcon.IconIndex := 0; { TODO 1 -cосновное : потом сделать смену иконки на общий статус }
    TrayIcon.Tag := 0;
  end;
end;

{$ENDREGION}
{$REGION 'Check Update Timer'}

procedure TMainForm.JvTimerListEvents2Timer(Sender: TObject);
begin
  // Ставим флаг - непоказывать всплывающее сообщение если новой версии нету
  if Sender = nil then
    V_UpdateAuto := False
  else
    V_UpdateAuto := True;
  with HttpClient do
  begin
    // Сбрасываем сокет если он занят чем то другим или висит
    Close;
    Abort;
    // Ставим флаг задания
    Tag := 0;
    // Запускаем проверку обновлений программы на сайте
    LocationChangeMaxCount := 5;
    URL := C_UpdateURL;
    XLog(Name + C_BN + Log_Send, URL, C_HTTP, False);
    GetASync;
  end;
end;

{$ENDREGION}
{$REGION 'ICQ Fack Status'}

procedure TMainForm.JvTimerListEvents4Timer(Sender: TObject);
begin
  // Если функция отключена, то выключаем таймер и выходим
  if not UnstableICQStatus.Checked then
  begin
    JvTimerList.Events[4].Enabled := False;
    // Возвращаем прежнёё значение статуса
    ICQ_CurrentStatus := ICQ_CurrentStatus_bac;
    // Отсылаем короткий пакет статуса
    ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
    Exit;
  end;
  // Фак статус ICQ (переключаем режим видимости и невидимости через интервалы)
  if ICQ_Work_Phaze then
  begin
    if ICQ_CurrentStatus <> 11 then
      ICQ_CurrentStatus := 11
    else
      ICQ_CurrentStatus := ICQ_CurrentStatus_bac;
    // Отсылаем короткий пакет статуса
    ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
  end;
end;

{$ENDREGION}
{$REGION 'ICQ Ping Timer'}

procedure TMainForm.JvTimerListEvents5Timer(Sender: TObject);
begin
  // Отсылаем пакет с пингом ICQ равным 60 секундам
  if ICQ_Work_Phaze then
    ICQ_SendPkt('5', '0000003C');
  // Отсылаем пинг для ICQ сервера аватар равным 60 секундам
  if ICQ_Avatar_Work_Phaze then
    ICQA_SendPkt('5', '0000003C');
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JvTimerListEvents6Timer(Sender: TObject);
begin
  // Скрываем окно списка контактов по события таймера автоскрытия
  Hide;
end;

procedure TMainForm.JvTimerListEvents7Timer(Sender: TObject);
begin
  // Создаём форму со смайликами через 2 секунды после входа в профиль
  if not Assigned(SmilesForm) then
    Application.CreateForm(TSmilesForm, SmilesForm);
end;

procedure TMainForm.JvTimerListEvents9Timer(Sender: TObject);
begin
  // Отсылаем пакет с пингом Jabber равным 60 секундам
  if Jabber_Work_Phaze then
    Jab_SendPkt(C_BN + #09 + C_BN);
end;

{$ENDREGION}
{$REGION 'Gtrans Timer'}

procedure TMainForm.JvTimerListEvents8Timer(Sender: TObject);
begin
  // Автоматически сканируем список буфера сообщений для перевода
  if Assigned(GTransForm) then
  begin
    with GTransForm do
    begin
      if (GtransListView.Items.Count > 0) and (not GTranslation) then
      begin
        // Запускаем функцию перевода сообщения
        GUIN := GtransListView.Items[0].SubItems[0];
        GText := GtransListView.Items[0].SubItems[1];
        GUserType := GtransListView.Items[0].SubItems[2];
        GetTranslation;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'LoadImageList'}

procedure TMainForm.LoadImageList(ImgList: TImageList; FName: string);
var
  I, AllIconCount: Integer;
  Img1, Img2: TBitmap;
begin
  // Создаём компонент иконки
  Img1 := TBitmap.Create;
  Img2 := TBitmap.Create;
  Img1.Height := 16;
  Img1.Width := 16;
  Img2.Height := 16;
  Img2.Width := 16;
  try
    if FileExists(FName) then
    begin
      // Если файл с иконками есть, то загружаем его
      Img1.LoadFromFile(FName);
      // Вычисляем количесво иконок в файле
      AllIconCount := Img1.Width div 16;
      // Загружаем по одной иконке в лист иконок с примерением прозрачности фона
      for I := 0 to AllIconCount - 1 do
      begin
        Img2.Canvas.CopyRect(Rect(0, 0, 16, 16), Img1.Canvas, Bounds(I * 16, 0, 16, 16));
        ImgList.AddMasked(Img2, ClFuchsia);
      end;
    end;
  finally
    Img1.Free;
    Img2.Free;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.MainToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaLeft;
  PopUp_Top(MainToolButton, MainPopupMenu);
end;

procedure TMainForm.MainToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  MainToolButtonClick(MainToolButton);
end;

procedure TMainForm.MainToolTopButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaRight;
  Popup_down(MainToolTopButton, MainPopupMenu);
end;

procedure TMainForm.MainToolTopButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  MainToolTopButtonClick(MainToolTopButton);
end;

procedure TMainForm.MRAToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  PopUp_Top(MRAToolButton, MRAPopupMenu);
end;

procedure TMainForm.MRAToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  PopUp_Top(MRAToolButton, RightMRAPopupMenu);
end;

{$ENDREGION}
{$REGION 'MRAWSocketDataAvailable'}

procedure TMainForm.MRAWSocketDataAvailable(Sender: TObject; ErrCode: Word);
label
  X,
    Z;
var
  Pkt, HexPkt, S_Name, PktType: string;
  I, Len, ProxyErr, PktSize, C: Integer;
begin
  try
    // Получаем пришедшие от сервера данные с сокета
    Pkt := MRAWSocket.ReceiveStr;
    // Если при получении данных возникла ошибка, то сообщаем об этом
    if ErrCode <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Mra, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      MRA_GoOffline;
      Exit;
    end;
    // HTTP прокси коннект
    if (V_HttpProxy_Enable) and ((MRA_Connect_Phaze) or (MRA_BosConnect_Phaze)) and (not MRA_HTTP_Connect_Phaze) then
    begin
      // Пишем ответ прокси в лог
      XLog(C_Mra + C_BN + Log_Get, Pkt, C_Mra);
      // Заносим данные в специальный буфер
      MRA_myBeautifulSocketBuffer := MRA_myBeautifulSocketBuffer + Pkt;
      // Если нет ответа нормального от прокси, то выходим
      if Pos(C_RN + C_RN, MRA_myBeautifulSocketBuffer) = 0 then
        Exit;
      // Забираем из ответа прокси нужную информацию от прокси
      Pkt := Chop(C_RN + C_RN, MRA_myBeautifulSocketBuffer);
      // Обнуляем ошибки прокси
      ProxyErr := 0;
      // Если ответ положительный и прокси установил соединение, то активируем фазу подключения через http прокси
      if StartsStr(C_Proxy_S0_OK, Pkt) or StartsStr(C_Proxy_S1_OK, Pkt) or StartsStr(C_Proxy_0_OK, Pkt) or StartsStr(C_Proxy_1_OK, Pkt) then
      begin
        MRA_HTTP_Connect_Phaze := True;
        XLog(C_Mra + C_BN + Log_Get, Log_Proxy_OK, C_Mra);
        // Если уже подключились в Bos серверу
        if MRA_BosConnect_Phaze then
        begin
          // Отсылаем первый пакет логина
          MRA_Login_1;
          Exit;
        end;
      end
      else if StartsStr(C_Proxy_S0_Err, Pkt) or StartsStr(C_Proxy_S1_Err, Pkt) or StartsStr(C_Proxy_0_Err, Pkt) or StartsStr(C_Proxy_1_Err, Pkt) then
      begin
        ProxyErr := 1;
        DAShow(Lang_Vars[17].L_S, Lang_Vars[118].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Mra + C_BN + C_EN, EmptyStr, 134, 2, 0);
      end
      else
      begin
        ProxyErr := 2;
        DAShow(Lang_Vars[17].L_S, Lang_Vars[119].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Mra + C_BN + C_EN, EmptyStr, 134, 2, 0);
      end;
      // Забираем из буфера пакет с данными MRA
      Pkt := MRA_myBeautifulSocketBuffer;
      // Очищаем буфер
      MRA_myBeautifulSocketBuffer := EmptyStr;
      // Если в работе с прокси были ошибки, то уходим в оффлайн
      if ProxyErr <> 0 then
      begin
        MRA_GoOffline;
        Exit;
      end;
    end;
    // Если длинна этих данных равна нулю, выходим от сюда :)
    if Length(Pkt) = 0 then
      Exit;
    // Увеличиваем статистику входящего трафика
    V_TrafRecev := V_TrafRecev + Length(Pkt);
    V_AllTrafRecev := V_AllTrafRecev + Length(Pkt);
    if Assigned(TrafficForm) then
      Traffic_MenuClick(nil);
    // Прибавляем данные к специальному буферу накопления
    MRA_BuffPkt := MRA_BuffPkt + Pkt;
    // Если фаза первого подключания к серверу MRA
    if MRA_Connect_Phaze then
    begin
      MRA_Bos_Addr := Trim(MRA_BuffPkt);
      XLog(C_Mra + C_BN + Log_Parsing + C_BN + Log_BosServer, MRA_Bos_Addr, C_Mra);
      // Получаем адрес Bos сервера для подключения
      MRA_Bos_IP := Parse(C_TN, MRA_Bos_Addr, 1);
      MRA_Bos_Port := Parse(C_TN, MRA_Bos_Addr, 2);
      // Закрываем сокет и ждём пока он закроется
      MRAWSocket.Close;
      MRAWSocket.WaitForClose;
      // Подключаемся к Bos серверу
      // Активируем фазу коннекта к основному серверу
      MRA_Connect_Phaze := False;
      MRA_BosConnect_Phaze := True;
      MRA_HTTP_Connect_Phaze := False;
      MRA_myBeautifulSocketBuffer := EmptyStr;
      MRA_BuffPkt := EmptyStr;
      // Устанавливаем параметры
      MRAWSocket.Proto := C_SocketProto;
      if V_HttpProxy_Enable then
      begin
        MRAWSocket.Addr := V_HttpProxy_Address;
        MRAWSocket.Port := V_HttpProxy_Port;
      end
      else
      begin
        MRAWSocket.Addr := MRA_Bos_IP;
        MRAWSocket.Port := MRA_Bos_Port;
      end;
      // Начинаем подключение к основному серверу
      MRAWSocket.Connect;
      Exit;
    end;
    // Ищем ошибки в буфере пакетов
    if ((MRA_BuffPkt > EmptyStr) and (Text2Hex(LeftStr(MRA_BuffPkt, 4)) <> MRA_MagKey)) then
    begin
      // Если в пакете есть ошибки, то активируем оффлайн и выводим сообщение об ошибке
      DAShow(Lang_Vars[17].L_S, Lang_Vars[22].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Mra + C_BN + C_EN, EmptyStr, 134, 2, 0);
      MRA_GoOffline;
      Exit;
    end;
    // Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
    // для проверки этих данные на наличие слудующего целого пакета данных
    X: ;
    PktSize := MRA_BodySize(MRA_BuffPkt);
    // Проверяем если ли в буфере хоть один целый пакет
    if (Length(MRA_BuffPkt) >= MRA_FLAP_HEAD_SIZE) and (Length(MRA_BuffPkt) >= MRA_FLAP_HEAD_SIZE + PktSize) then
    begin
      // Забираем из буфера один целый пакет
      HexPkt := NextData(MRA_BuffPkt, MRA_FLAP_HEAD_SIZE + PktSize);
      // Разбираем пакет данных если его длинна больше нуля
      if Length(HexPkt) > 0 then
      begin
        // Пишем в лог данные пакета
        if Assigned(LogForm) then
          if LogForm.MRADumpSpeedButton.Down then
          begin
            PktType := HexPkt;
            NextData(PktType, 12);
            PktType := Text2Hex(NextData(PktType, 4));
            C := Swap32(HexToInt(PktType));
            for I := low(MRA_Pkt_Names) to high(MRA_Pkt_Names) do
              if MRA_Pkt_Names[I].Pkt_Code = C then
              begin
                S_Name := MRA_Pkt_Names[I].Pkt_Name;
                Break;
              end;
            XLog(C_Mra + C_BN + Log_Get + C_BN + S_Name, Trim(Dump(HexPkt)), C_Mra);
          end;
        // Ещё раз делаем проверку на начало пакета MRA протокола по магическому ключу
        if Text2Hex(NextData(HexPkt, 4)) = MRA_MagKey then
        begin
          // Забираем версию протокола сервера
          MRA_Server_Proto_Ver := Text2Hex(NextData(HexPkt, 1));
          NextData(HexPkt, 3);
          // Пропускаем Seq
          NextData(HexPkt, 4);
          // Смотрим какая команда у пакета
          C := HexToInt(Text2Hex(NextData(HexPkt, 4)));
          // Получаем длинну пакета
          Len := HexToInt(Text2Hex(NextData(HexPkt, 4)));
          Len := Swap32(Len);
          // Пропускаем from и fromport и 16 символов резерва в пакете
          NextData(HexPkt, 24);
          case Swap32(C) of
            $1002:
              begin
                // Получаем интервал пакетов Ping
                I := HexToInt(Text2Hex(NextData(HexPkt, Len)));
                JvTimerList.Events[10].Interval := Swap32(I) * 1000;
                Xlog(C_Mra + C_BN + Log_Parsing + C_BN + Log_PingInterval, IntToStr(JvTimerList.Events[10].Interval), C_Mra);
                // Отправляем пакет авторизации на сервере
                MRA_Login_2;
                // Запускаем таймер MRA Alive
                JvTimerList.Events[10].Enabled := True;
              end;
            $1004:
              begin
                // Удачный логин и мы переходим в онлайн
                MRA_Connect_Phaze := False;
                MRA_BosConnect_Phaze := False;
                MRA_HTTP_Connect_Phaze := False;
                MRA_Work_Phaze := True;
                MRA_Offline_Phaze := False;
                // Отключаем метку пересоединения ведь мы уже и так онлайн!
                MRA_Reconnect := False;
                // Очищаем группы MRA в Ростере
                ClearContacts(C_Mra);
                // Устанавливаем иконку статуса
                MRAToolButton.ImageIndex := MRA_CurrentStatus_bac;
                // Воспроизводим звук удачного логина
                ImPlaySnd(1);
              end;
            $1005:
              begin
                if Pos('Invalid login', HexPkt) > 0 then
                begin
                  // Отображаем сообщение, что авторизация не пройдена и закрываем сеанс
                  DAShow(Lang_Vars[17].L_S, Format(Lang_Vars[120].L_S, [C_Mra]), EmptyStr, 134, 2, 0);
                  MRA_GoOffline;
                  Exit;
                end;
              end;
            $1009: MRA_MessageRecv(NextData(HexPkt, Len));
            $1015: MRA_ParseUserInfo(NextData(HexPkt, Len));
            $1037: MRA_ParseCL(NextData(HexPkt, Len));
            $100F: MRA_ParseStatus(NextData(HexPkt, Len));
            $101D: MRA_ParseOfflineMess(NextData(HexPkt, Len));
            $1040: MRA_ParseSMS_ACK(NextData(HexPkt, Len));
          else
            // Если канал пакета вообще другой, то проверяем в буфере другой пакет
            goto Z;
          end;
        end
        else
        begin
          // Если начальная метка пакета не правильная, то выводим сообщение об ошибке разбора и выходим в оффлайн
          DAShow(Lang_Vars[17].L_S, Lang_Vars[22].L_S + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Mra + C_BN + C_EN, EmptyStr, 134, 2, 0);
          MRA_GoOffline;
          Exit;
        end;
      end;
      // Если в конце разбора пакета у нас ещё остались данные, то возвращаемся для проверки буфера
      Z: ;
      if Length(MRA_BuffPkt) > 0 then
        goto X;
    end;
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.MRAXStatusClick(Sender: TObject);
begin
  // Открываем окно выбора дополнительного статуса MRA

end;
{$ENDREGION}
{$REGION 'AddNewContactClick'}

procedure TMainForm.AddNewContactClick(Sender: TObject);
var
  FrmAddCnt: TAddContactForm;
begin
  // Создаём окно добавления контакта в КЛ
  FrmAddCnt := TAddContactForm.Create(Self);
  try
    { //--Составляем список групп из Ростера
      frmAddCnt.BuildGroupList(S_Icq);
      //--Заносим имя учётной записи
      frmAddCnt.AccountEdit.Text := SearchResultJvListView.Selected.SubItems[1];
      procedure TMainForm.N24Click(Sender: TObject);
      begin

      end;

      frmAddCnt.AccountEdit.ReadOnly := true;
      frmAddCnt.AccountEdit.Color := clBtnFace;
      //--Заносим имя учётной записи
      if SearchResultJvListView.Selected.SubItems[2] = EmptyStr then
      frmAddCnt.NameEdit.Text := SearchResultJvListView.Selected.SubItems[1]
      else frmAddCnt.NameEdit.Text := SearchResultJvListView.Selected.SubItems[2];
      //--Заполняем протокол контакта
      frmAddCnt.ContactType := C_Icq;
      //--Отображаем окно модально
      frmAddCnt.ShowModal; }
  finally
    FreeAndNil(FrmAddCnt);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.SoundsONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку звуков на нижней панели
  SoundsONMenu.Checked := not SoundsONMenu.Checked;
  SoundOnOffToolButton.Visible := not SoundOnOffToolButton.Visible;
end;

procedure TMainForm.ChatTabCloseActionExecute(Sender: TObject);
begin
  // Закрываем активную вкладку чата по нажатию Alt + F4
  if Application.ActiveFormHandle = ChatForm.Handle then
    ChatForm.CloseTabBitBtnClick(Self);
end;

procedure TMainForm.CheckStatusContactClick(Sender: TObject);
begin
  // Проверяем статус контакта
  if ContactList.SelectedItem <> nil then
  begin
    // Если контакт ICQ
    if (ContactList.SelectedItem as TButtonItem).ContactType = C_Icq then
    begin
      if ICQ_Work_Phaze then
        ICQ_ReqStatus0215((ContactList.SelectedItem as TButtonItem).UIN);
    end;
  end;
end;

procedure TMainForm.CheckUpdate_MenuClick(Sender: TObject);
begin
  // Запускаем проверку обновлений программы на сайте
  JvTimerListEvents2Timer(nil);
end;

{$ENDREGION}
{$REGION 'OpenTrafficClick'}

procedure TMainForm.Traffic_MenuClick(Sender: TObject);
begin
  // Отображаем окно трафика
  if not Assigned(TrafficForm) then
    Application.CreateForm(TTrafficForm, TrafficForm);
  // Показываем сколько трафика передано за эту сессию
  TrafficForm.CurTrafEdit.Text := FloatToStrF(V_TrafRecev / 1000, FfFixed, 18, 3) + C_BN + C_KB + C_BN + C_PN + C_BN + FloatToStrF(V_TrafSend / 1000, FfFixed, 18, 3) + C_BN + C_KB + C_BN + C_PN + C_BN + DateTimeToStr(V_SesDataTraf);
  // Показываем сколько трафика передано всего
  TrafficForm.AllTrafEdit.Text := FloatToStrF(V_AllTrafRecev / 1000000, FfFixed, 18, 3) + C_BN + C_MB + C_BN + C_PN + C_BN + FloatToStrF(V_AllTrafSend / 1000000, FfFixed, 18, 3) + C_BN + C_MB + C_BN + C_PN + C_BN + V_AllSesDataTraf;
  // Отображаем окно
  XShowForm(TrafficForm);
end;

{$ENDREGION}
{$REGION 'FloatContactMenuClick'}

procedure TMainForm.FloatContactMenuClick(Sender: TObject);
{var
  I, FloatHandle: Integer;
  RosterItem: TListItem;}
begin
  {// Ищем этот контакт в Ростере
  if ContactList.SelectedItem <> nil then
  begin
    RosterItem := RosterForm.ReqRosterItem((ContactList.SelectedItem as TButtonItem).UIN);
    if RosterItem <> nil then
    begin
      with RosterItem do
      begin
        // Ищем не создано ли уже это плавающее окно
        if (SubItems[17] <> EmptyStr) and (IsWindow(StrToInt(SubItems[17]))) then
        begin
          for I := 0 to Screen.FormCount - 1 do
          begin
            FloatHandle := Screen.Forms[I].Handle;
            if FloatHandle = StrToInt(SubItems[17]) then
            begin
              Screen.Forms[I].Close;
              SubItems[17] := EmptyStr;
              Exit;
            end;
          end;
        end;
        // Создаём плавающее окно с контактом
        V_FloatingFrm := TFloatingForm.Create(Self);
        // Записываем в Ростер хэндл плавающего окна
        SubItems[17] := IntToStr(V_FloatingFrm.Handle);
        // Отображаем ник контакта
        V_FloatingFrm.NickLabel.Caption := UrlDecode(SubItems[0]);
        // Запоминаем UIN этого контакта в плавающем окне
        V_FloatingFrm.NickLabel.Hint := RosterItem.Caption;
        // Устанавливаем статус картинки в плавающем окне
        MainForm.AllImageList.GetBitmap(StrToInt(SubItems[6]), V_FloatingFrm.StatusImage.Picture.Bitmap);
        V_FloatingFrm.XStatusImage.Visible := False;
        V_FloatingFrm.ClientImage.Visible := False;
        // Устанавливаем размер плавающего окна
        V_FloatingFrm.Width := V_FloatingFrm.NickLabel.Width + 28;
        if V_FloatingFrm.XStatusImage.Visible then
          V_FloatingFrm.Width := V_FloatingFrm.Width + 18;
        if V_FloatingFrm.ClientImage.Visible then
          V_FloatingFrm.Width := V_FloatingFrm.Width + 20;
        // Отображаем плавающее окно
        V_FloatingFrm.ScreenSnap := true;
        V_FloatingFrm.Show;
      end;
    end;
  end;}
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.PingICQServerClick(Sender: TObject);
begin
  // Отправляем пакет для проверки связи с сервером ICQ
  // if not NotProtoOnline(S_Icq) then
end;

procedure TMainForm.PostInTwitter_MenuClick(Sender: TObject);
begin
  // Открываем окно для ввода сообщения для Twitter
  if not Assigned(MemoForm) then
    Application.CreateForm(TMemoForm, MemoForm);
  // Делаем запрос в форме на обновление программы
  MemoForm.PostInTwitter(EmptyStr);
  // Отображаем окно
  XShowForm(MemoForm);
end;

{$ENDREGION}
{$REGION 'ProfileOpenMenuClick'}

procedure TMainForm.SwitchProfile_MenuClick(Sender: TObject);
var
  Spath: string;
  R: Integer;
begin
  // Запускаем второй экземпляр программы для выбора другого профиля
  Spath := V_MyPath + C_ExeName;
  R := ShellExecute(0, 'open', 'Imadering.exe', nil, PChar(V_MyPath), SW_SHOW);
  XLog(C_IMadering, Spath + C_BN + IntToStr(R), EmptyStr);
  if R < 32 then
    DAShow(Lang_Vars[17].L_S, Lang_Vars[65].L_S, EmptyStr, 134, 2, 0);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.OnlyOnlineContactsToolButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. оффлайн контактов
  if OnlyOnlineContactsToolButton.Down then
  begin
    OnlyOnlineContactsTopButton.Down := True;
    OnlyOnlineContactsToolButton.ImageIndex := 137;
    OnlyOnlineContactsTopButton.ImageIndex := 137;
  end
  else
  begin
    OnlyOnlineContactsTopButton.Down := False;
    OnlyOnlineContactsToolButton.ImageIndex := 138;
    OnlyOnlineContactsTopButton.ImageIndex := 138;
  end;
  // Запускаем обработку Ростера
  V_CollapseGroupsRestore := True;
  UpdateFullCL;
end;

procedure TMainForm.OnlyOnlineContactsTopButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. оффлайн контактов
  OnlyOnlineContactsToolButton.Down := not OnlyOnlineContactsToolButton.Down;
  OnlyOnlineContactsToolButtonClick(Self);
end;

procedure TMainForm.OnlyOnlineONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку скрыть оффлайн контакты на нижней панели
  OnlyOnlineONMenu.Checked := not OnlyOnlineONMenu.Checked;
  OnlyOnlineContactsToolButton.Visible := not OnlyOnlineContactsToolButton.Visible;
end;

procedure TMainForm.Settings_MenuClick(Sender: TObject);
begin
  // Открываем окно с настройками программы
  if not Assigned(SettingsForm) then
    Application.CreateForm(TSettingsForm, SettingsForm);
  // Отображаем окно
  XShowForm(SettingsForm);
end;
{$ENDREGION}
{$REGION 'RenemeGroupCLClick'}

procedure TMainForm.RenemeGroupCLClick(Sender: TObject);
var
  I: Integer;
  OldGName, GName, GProto, GId: string;
  GroupsIds: TStringList;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Get_Node: TJvSimpleXmlElem;
begin
  // Начинаем переименование группы
  if RoasterGroup <> nil then
  begin
    // Выводим диалог подтверждения удаления контакта
    GName := RoasterGroup.GroupCaption;
    OldGName := GName;
    GProto := RoasterGroup.GroupType;
    GId := RoasterGroup.GroupId;
    if InputQuery(RenemeGroupCL.Caption + C_BN + GProto, RenemeGroupCL.Caption + C_TN, GName) then
    begin
      // Проверяем в сети ли этот протокол
      if NotProtoOnline(GProto) then
        Exit;
      // Смотрим какой протокол у группы
      if GProto = C_Icq then
      begin
        // Если фаза работы с серверным КЛ ещё активна, то ждём её окончания
        if ICQ_SSI_Phaze then
        begin
          DAShow(Lang_Vars[19].L_S + C_BN + C_Icq, Lang_Vars[104].L_S, EmptyStr, 134, 2, 0);
          Exit;
        end;
        // Если это нередактируемые группы, то выходим
        if (GName = EmptyStr) or (GName = OldGName) or (GId = EmptyStr) or (GId = C_NoCL) or (GId = '0000') or (GId = '0001') then
          Exit;
        // Создаём список для идентификаторов групп
        GroupsIds := TStringList.Create;
        try
          // Заносим в список идентификаторы групп из Ростера
          if V_Roster <> nil then
          begin
            with V_Roster do
            begin
              if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_Icq];
                if XML_Node <> nil then
                begin
                  // Открываем раздел групп
                  Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
                  if Sub_Node <> nil then
                  begin
                    for I := 0 to Sub_Node.Items.Count - 1 do
                    begin
                      Tri_Node := Sub_Node.Items.Item[I];
                      if Tri_Node <> nil then
                      begin
                        if (Tri_Node.Properties.Value(C_Id) = C_NoCL) or (Tri_Node.Properties.Value(C_Id) = '0000') then
                          Continue;
                        GroupsIds.Add(Tri_Node.Properties.Value(C_Id));
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
          // Обновляем имя группы на сервере
          ICQ_SSI_Phaze := True;
          ICQ_Ren_Group_Phaze := True;
          ICQ_UpdateGroup_AddContact(GName, GId, GroupsIds);
        finally
          GroupsIds.Free;
        end;
        // Переименовываем группу в Ростере
        Get_Node := RosterGetItem(C_Icq, C_Group + C_SS, C_Id, GId);
        if Get_Node <> nil then
          RosterUpdateProp(Get_Node, C_Name, UrlEncode(GName));
      end
      else if GProto = C_Jabber then
      begin
        Exit;
      end
      else if GProto = C_Mra then
      begin
        Exit;
      end;
      // Обновляем КЛ
      UpdateFullCL;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.RightICQPopupMenuPopup(Sender: TObject);
begin
  // Управляем иконками доп. меню ICQ
  with UnstableICQStatus do
  begin
    if Checked then
      ImageIndex := 140
    else
      ImageIndex := 230;
  end;
end;

procedure TMainForm.AboutIMadering_MenuClick(Sender: TObject);
begin
  // Открываем окно о программе
  if not Assigned(AboutForm) then
    Application.CreateForm(TAboutForm, AboutForm);
  // Отображаем окно
  XShowForm(AboutForm);
end;

procedure TMainForm.CloseActiveFormActionExecute(Sender: TObject);
begin
  // Закрываем активное окно по нажатию на Esc
  if Application.ActiveFormHandle = Handle then
    MainFormHideInTray
  else
    ShowWindow(Application.ActiveFormHandle, SW_HIDE);
end;

procedure TMainForm.CloseGroupsCLClick(Sender: TObject);
var
  I: Integer;
begin
  // Закрываем все группы в контакт листе
  for I := 0 to MainForm.ContactList.Categories.Count - 1 do
    MainForm.ContactList.Categories[I].Collapsed := True;
end;

procedure TMainForm.CloseProgram_MenuClick(Sender: TObject);
begin
  // Закрываем программу
  V_ProgramCloseCommand := True;
  Close;
end;

procedure TMainForm.CLSearchONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку поиска на верхней панели
  CLSearchONMenu.Checked := not CLSearchONMenu.Checked;
  CLSearchToolButton.Visible := not CLSearchToolButton.Visible;
end;

{$ENDREGION}
{$REGION 'ContactListButtonClicked'}

procedure TMainForm.ContactListButtonClicked(Sender: TObject; const Button: TButtonItem);
var
  Diff: Tdatetime;
begin
  // Вычитаем время плошлого клика
  Diff := Now - V_LastClick;
  // Запоминаем время текущего клика
  V_LastClick := Now;
  // Если по времени произошёл двойной клик, то начинаем открывать окно чата с этим контактом
  if (Diff < C_DblClickTime) and (ButtonInd = Button.index) then
  begin
    // Меняем иконку кнопки контакта на его статус
    Button.ImageIndex := Button.Status;
    // Открываем чат с этим контактом
    OpenChatPage(Button, Button.ContactType);
  end;
  // Запоминаем индекс кнопки
  ButtonInd := Button.index;
  // Перерисовываем компонент
  ContactList.Update;
end;

{$ENDREGION}
{$REGION 'ContactListCategoryCollapase'}

procedure TMainForm.ContactListCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
var
  I: Integer;
  XML_Node: TJvSimpleXmlElem;
begin
  if not V_CollapseGroupsRestore then
  begin
    // Запоминаем свёрнутые группы
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          // Ищем раздел состояния групп
          XML_Node := Root.Items.ItemNamed[C_Group + C_SS];
          if XML_Node = nil then
            XML_Node := Root.Items.Add(C_Group + C_SS);
          // Очищаем раздел
          XML_Node.Clear;
          // Записываем в него состояние групп
          with ContactList do
          begin
            for I := 0 to Categories.Count - 1 do
              XML_Node.Items.Add(ChangeCP(URLEncode(Categories[I].GroupCaption + Categories[I].GroupType + Categories[I].GroupId))).Properties.Add(C_CS, Categories[I].Collapsed);
          end;
        end;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'ContactListContextPopup'}

procedure TMainForm.ContactListContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  FCursor: TPoint;
begin
  // Отключаем автоменю
  Handled := True;
  // Вычисляем группу в которой происходит событие
  RoasterGroup := ContactList.GetCategoryAt(MousePos.X, MousePos.Y);
  // Сбрасываем фокус
  ContactList.FocusedItem := nil;
  // Получаем координаты курсора
  GetCursorPos(FCursor);
  // Если кнопка КЛ, то выводим меню контакта
  if RoasterButton <> nil then
  begin
    // Выделяем контакт на котором был правый клик мыши
    ContactList.SelectedItem := RoasterButton;
    // Активируем или деактивируем нужные для этого контакта пункты меню
    if RoasterButton.ContactType = C_Icq then // Для ICQ
    begin
      DelYourSelfContact.Visible := True;
      CheckStatusContact.Visible := True;
      GrandAuthContact.Visible := True;
      SendAddContact.Visible := True;
    end
    else if RoasterButton.ContactType = C_Jabber then // Для Jabber
    begin
      DelYourSelfContact.Visible := False;
      CheckStatusContact.Visible := False;
      GrandAuthContact.Visible := False;
      SendAddContact.Visible := False;
    end
    else if RoasterButton.ContactType = C_Mra then // Для MRA
    begin
      DelYourSelfContact.Visible := False;
      CheckStatusContact.Visible := False;
      GrandAuthContact.Visible := False;
      SendAddContact.Visible := False;
    end;
    // Отображаем меню
    ContactPopupMenu.Popup(FCursor.X, FCursor.Y);
  end
  else
  begin
    with ContactList do
    begin
      // Если клик был по группе, то подсвечиваем её заголовок
      if RoasterGroup <> nil then
      begin
        SelectedItem := RoasterGroup;
        // Управляем пунктами меню для группы
        AddGroupCL.Visible := True;
        RenemeGroupCL.Visible := True;
        DeleteGroupCL.Visible := True;
        AddContactCL.Visible := True;
      end
      else
      begin
        // Если клик не по группе, то убираем выделение отовсюду
        ContactList.SelectedItem := nil;
        // Управляем пунктами меню для группы
        AddGroupCL.Visible := False;
        RenemeGroupCL.Visible := False;
        DeleteGroupCL.Visible := False;
        AddContactCL.Visible := False;
      end;
    end;
    // Отображаем меню
    ContactListPopupMenu.Popup(FCursor.X, FCursor.Y);
  end;
  // Перерисовываем компонент
  ContactList.Update;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.ContactListHotButton(Sender: TObject; const Button: TButtonItem);
begin
  // При перемещении по кнопкам КЛ запоминаем последнюю
  if Button <> nil then
    RoasterButton := Button
  else
    RoasterButton := nil;
end;

procedure TMainForm.ContactListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Добавляем событие для средней клавишы мыши
  if Button = MbMiddle then
  begin
    // Выделяем контакт на котором был правый клик мыши
    ContactList.FocusedItem := nil;
    ContactList.SelectedItem := RoasterButton;
    // Открываем информацию о контакте
    AnketaContactClick(Self);
  end;
end;

procedure TMainForm.ContactListPopupMenuPopup(Sender: TObject);
begin
  // Управляем иконками в пунктах меню
  with HideEmptyGroups do
  begin
    if Checked then
      ImageIndex := 140
    else
      ImageIndex := 230;
  end;
end;

procedure TMainForm.CopyAccountContactClick(Sender: TObject);
begin
  // Копируем имя учётной записи контакта в буфер обмена
  if ContactList.SelectedItem <> nil then
    SetClipboardText(UrlDecode((ContactList.SelectedItem as TButtonItem).UIN));
end;

{$ENDREGION}
{$REGION 'DeleteContactClick'}

procedure TMainForm.DeleteContactClick(Sender: TObject);
var
  UIN, Nick, Proto: string;
  Get_Node: TJvSimpleXmlElem;
  KL_Item: TButtonItem;
begin
  // Начинаем удаление контакта
  if ContactList.SelectedItem <> nil then
  begin
    // Выводим диалог подтверждения удаления контакта
    UIN := (ContactList.SelectedItem as TButtonItem).UIN;
    Nick := (ContactList.SelectedItem as TButtonItem).Caption;
    Proto := (ContactList.SelectedItem as TButtonItem).ContactType;
    if MessageBox(Handle, PChar(Format(Lang_Vars[83].L_S, [Nick])), PChar(DeleteContact.Caption + C_BN + Proto), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = mrYes then
    begin
      // Обновляем параметры этого контакта в Ростере
      Get_Node := RosterGetItem(Proto, C_Contact + C_SS, C_Login, UIN);
      if Get_Node <> nil then
      begin
        if Get_Node.Properties.Value(C_Group + C_Id) <> C_NoCL then
        begin
          // Проверяем в сети ли этот протокол
          if NotProtoOnline(Proto) then
            Exit;
          // Смотрим какой это протокол
          if Proto = C_Icq then
          begin
            // Если фаза работы с серверным КЛ ещё активна, то ждём её окончания
            if ICQ_SSI_Phaze then
            begin
              DAShow(Lang_Vars[19].L_S + C_BN + C_Icq, Lang_Vars[104].L_S, EmptyStr, 134, 2, 0);
              Exit;
            end;
            // Смотрим из какой группы этот контакт
            if Get_Node.Properties.Value(C_Group + C_Id) = '0000' then // Если это контакт из группы временных, то удаляем его как временный
            begin
              ICQ_SSI_Phaze := True;
              ICQ_Dell_Contact_Phaze := True;
              ICQ_DeleteTempContact(UrlDecode(UIN), Get_Node.Properties.Value(C_Id), Get_Node.Properties.Value(C_Type), Get_Node.Properties.Value(C_Time + C_Id));
            end
            else
            begin
              // Иначе удаляем контакт как положено
              ICQ_SSI_Phaze := True;
              ICQ_Dell_Contact_Phaze := True;
              ICQ_DeleteContact(UrlDecode(UIN), Get_Node.Properties.Value(C_Group + C_Id), Get_Node.Properties.Value(C_Id), Nick, //
                '', '', '');
            end;
          end
          else if Proto = C_Jabber then
          begin
            // Удаляем контакт из КЛ
            Jab_SSI_Phaze := True;
            Jab_Dell_Contact_Phaze := True;
            Jab_DellContact(UrlDecode(UIN));
          end
          else if Proto = C_Mra then
          begin
            Exit;
          end;
        end;
        // Удаляем этот контакт в Ростере
        Get_Node.Clear;
        // Удаляем этот контакт в КЛ
        KL_Item := ReqCLContact(Proto, UIN);
        if KL_Item <> nil then
          KL_Item.Free;
        // Обновляем КЛ
        UpdateFullCL;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'DeleteGroupCLClick'}

procedure TMainForm.DeleteGroupCLClick(Sender: TObject);
var
  GProto, GId, GName: string;
  I: Integer;
  TCL: TStringList;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Начинаем удаление группы
  if RoasterGroup <> nil then
  begin
    GName := RoasterGroup.GroupCaption;
    GProto := RoasterGroup.GroupType;
    GId := RoasterGroup.GroupId;
    if MessageBox(Handle, PChar(Format(Lang_Vars[117].L_S, [GName])), PChar(DeleteGroupCL.Caption + C_BN + GProto), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = mrYes then
    begin
      // Если это группа не "Не в списке"
      if GId <> C_NoCL then
      begin
        // Проверяем в сети ли этот протокол
        if NotProtoOnline(GProto) then
          Exit;
        // Смотрим какой протокол у группы
        if GProto = C_Icq then
        begin
          // Если фаза работы с серверным КЛ ещё активна, то ждём её окончания
          if ICQ_SSI_Phaze then
          begin
            DAShow(Lang_Vars[19].L_S + C_BN + C_Icq, Lang_Vars[104].L_S, EmptyStr, 134, 2, 0);
            Exit;
          end;
          // Удаляем группу временных контактов
          if GId = '0000' then
          begin
            // Открываем фазу удаления группы с сервера
            ICQ_SSI_Phaze := True;
            ICQ_Dell_Group_Phaze := True;
            // Создаём список для идентификаторов временных контактов
            TCL := TStringList.Create;
            try
              // Заносим в список идентификаторы групп из Ростера
              if V_Roster <> nil then
              begin
                with V_Roster do
                begin
                  if Root <> nil then
                  begin
                    XML_Node := Root.Items.ItemNamed[C_Icq];
                    if XML_Node <> nil then
                    begin
                      // Открываем раздел групп
                      Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                      if Sub_Node <> nil then
                      begin
                        for I := 0 to Sub_Node.Items.Count - 1 do
                        begin
                          Tri_Node := Sub_Node.Items.Item[I];
                          if Tri_Node <> nil then
                          begin
                            if Tri_Node.Properties.Value(C_Group + C_Id) = '0000' then
                              TCL.Add(UrlDecode(Tri_Node.Properties.Value(C_Login)) + C_LN + Tri_Node.Properties.Value(C_Id) //
                                + C_LN + Tri_Node.Properties.Value(C_Type) + C_LN + Tri_Node.Properties.Value(C_Time + C_Id));
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
              // Начинаем удаление временных контактов на сервере
              if TCL.Count > 0 then
                ICQ_DeleteTempContactMulti(TCL);
            finally
              TCL.Free;
            end;
          end
          else
          begin
            // Открываем фазу удаления группы с сервера
            ICQ_SSI_Phaze := True;
            ICQ_Dell_Group_Phaze := True;
            ICQ_DeleteGroup(GName, GId);
          end;
        end
        else if GProto = C_Jabber then
        begin
          // Удаляем все контакты в этой группе
          if V_Roster <> nil then
          begin
            with V_Roster do
            begin
              if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_Jabber];
                if XML_Node <> nil then
                begin
                  // Открываем раздел групп
                  Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                  if Sub_Node <> nil then
                  begin
                    for I := 0 to Sub_Node.Items.Count - 1 do
                    begin
                      Tri_Node := Sub_Node.Items.Item[I];
                      if Tri_Node <> nil then
                      begin
                        if Tri_Node.Properties.Value(C_Group + C_Id) = GId then
                        begin
                          Jab_SSI_Phaze := True;
                          Jab_Dell_Group_Phaze := True;
                          Jab_DellContact(UrlDecode(Tri_Node.Properties.Value(C_Login)));
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end
        else if GProto = C_Mra then
        begin
          Exit;
        end;
      end;
      // Удаляем группу и контакты этой группы из Ростера
      if V_Roster <> nil then
      begin
        with V_Roster do
        begin
          if Root <> nil then
          begin
            XML_Node := Root.Items.ItemNamed[GProto];
            if XML_Node <> nil then
            begin
              // Открываем раздел групп
              Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
              if Sub_Node <> nil then
              begin
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    if Tri_Node.Properties.Value(C_Id) = GId then
                    begin
                      Sub_Node.Items.Remove(Tri_Node);
                      Break;
                    end;
                  end;
                end;
              end;
              // Открываем раздел контактов
              Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
              if Sub_Node <> nil then
              begin
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    if Tri_Node.Properties.Value(C_Group + C_Id) = GId then
                      Tri_Node.Clear;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      // Удаляем группу вместе с контактами из КЛ
      for I := 0 to ContactList.Categories.Count - 1 do
      begin
        if (ContactList.Categories[I].GroupType = GProto) and (ContactList.Categories[I].GroupId = GId) then
        begin
          ContactList.Categories[I].Free;
          Break;
        end;
      end;
      // Обновляем КЛ
      UpdateFullCL;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'DelYourSelfContactClick'}

procedure TMainForm.DelYourSelfContactClick(Sender: TObject);
begin
  if ContactList.SelectedItem <> nil then
  begin
    // Блокируем окно контактов
    MainForm.Enabled := False;
    try
      // Выводим вопрос на подтверждение действия
      if MessageBox(Handle, PChar(Format(Lang_Vars[25].L_S, [ContactList.SelectedItem.Caption])), PChar((Sender as TMenuItem).Hint), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
        if ICQ_Work_Phaze then
          ICQ_DellMyFromCL((ContactList.SelectedItem as TButtonItem).UIN);
    finally
      // Разблокировываем окно контактов
      MainForm.Enabled := True;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'FormActivate'}

procedure TMainForm.FormActivate(Sender: TObject);
begin
  // Выключаем прозрачность окна при активности
  if V_RoasterAlphaBlend then
    if V_AlphaBlendInactive then
      AlphaBlendValue := 255;
  // Сбрасываем таймер автоскрытия окна при активности окна
  if JvTimerList.Events[6].Enabled then
  begin
    JvTimerList.Events[6].Enabled := False;
    JvTimerList.Events[6].Enabled := True;
  end;
  // Убираем тут глюк в вайн с активацией окна чата (для сброса сообщения)
  if Assigned(ChatForm) then
    if ChatForm.Active then
      ChatForm.FormActivate(Self);
end;

{$ENDREGION}
{$REGION 'FormCloseQuery'}

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Делаем окно не закрывающим программу, а сворачиваем его в трэй
  if not V_ProgramCloseCommand then
  begin
    CanClose := False;
    MainFormHideInTray;
  end
  else
  begin
    // Сохраняем настройки окна
    SaveMainFormSettings;
    // Останавливаем таймеры
    JvTimerList.Events.Deactivate;
    JvTimerList.Active := False;
    // Переводим все протоколы в оффлайн
    if not ICQ_Offline_Phaze then
      ICQ_GoOffline;
    if not Jabber_Offline_Phaze then
      Jab_GoOffline;
    if not MRA_Offline_Phaze then
      MRA_GoOffline;
    // Отключаем HTTP сокеты
    HttpClient.Abort;
    MRA_PhotoClient.Abort;
    TwitterClient.Abort;
    if Assigned(FileTransferForm) then
      FileTransferForm.SendFileClient.Abort;
    if Assigned(GTransForm) then
      GTransForm.GtransClient.Abort;
    // Уничтожаем ресурсы списков
    if Assigned(V_InMessList) then
      FreeAndNil(V_InMessList);
    if Assigned(V_AccountToNick) then
      FreeAndNil(V_AccountToNick);
    if Assigned(V_SmilesList) then
      FreeAndNil(V_SmilesList);
    // Уничтожаем графические ресурсы
    if Assigned(V_NoAvatar) then
      FreeAndNil(V_NoAvatar);
    if Assigned(V_OutMessage2) then
      FreeAndNil(V_OutMessage2);
    if Assigned(V_OutMessage3) then
      FreeAndNil(V_OutMessage3);
    if Assigned(V_XStatusImg) then
      FreeAndNil(V_XStatusImg);
    if Assigned(V_XStatusMem) then
      FreeAndNil(V_XStatusMem);
    // Делаем текущую локальную копию списка контактов для отображения при запуске программы
    if V_Roster <> nil then
    begin
      V_Roster.SaveToFile(V_ProfilePath + C_ContactListFileName);
      // Уничтожаем Ростер
      FreeAndNil(V_Roster);
    end;
    // Высвобождаем окно подсказок
    if Assigned(SH_HintWindow) then
      FreeAndNil(SH_HintWindow);
    // Если создан AppBar, то уничтожаем его
    if V_DockAppBar then
      AppBarDestroy;
  end;
end;

{$ENDREGION}
{$REGION 'AddNewContactICQClick'}

procedure TMainForm.AddContactCLClick(Sender: TObject);
var
  FrmAddContact: TAddContactForm;
begin
  if RoasterGroup <> nil then
  begin
    // Выводим форму добавления новой группы
    FrmAddContact := TAddContactForm.Create(Self);
    try
      with FrmAddContact do
      begin
        // Ставим флаг какой протокол
        ContactType := RoasterGroup.GroupType;
        // Строим список групп этого протокола
        BuildGroupList(ContactType, RoasterGroup.GroupId);
        // Отображаем окно модально
        ShowModal;
      end;
    finally
      FreeAndNil(FrmAddContact);
    end;
  end;
end;

{$ENDREGION}
{$REGION 'AddNewGroupICQClick'}

procedure TMainForm.AddGroupCLClick(Sender: TObject);
var
  GProto: string;
begin
  // Начинаем добаление новой группы
  if RoasterGroup <> nil then
  begin
    GProto := RoasterGroup.GroupType;
    // Смотрим какой протокол
    if GProto = C_Icq then
      ICQAddGroupClick(nil)
    else if GProto = C_Jabber then
      JabberAddGroupClick(nil)
    else if GProto = C_Mra then
      MRAAddGroupClick(nil);
  end;
end;
{$ENDREGION}
{$REGION 'AnketaContactClick'}

procedure TMainForm.AnketaContactClick(Sender: TObject);
begin
  // Отображаем информацию о контакте
  if ContactList.SelectedItem <> nil then
  begin
    if not Assigned(ContactInfoForm) then
      Application.CreateForm(TContactInfoForm, ContactInfoForm);
    // Присваиваем UIN инфу которого хотим смотреть
    ContactInfoForm.ReqUIN := UrlDecode((ContactList.SelectedItem as TButtonItem).UIN);
    ContactInfoForm.ReqProto := (ContactList.SelectedItem as TButtonItem).ContactType;
    // Загружаем информацию о нем
    ContactInfoForm.LoadUserUnfo;
    // Отображаем окно
    XShowForm(ContactInfoForm);
  end;
end;

{$ENDREGION}
{$REGION 'OpenDumpProtoLog'}

procedure TMainForm.DumpICQClick(Sender: TObject);
begin
  // Включаем лог отладки протокола ICQ
  if not Assigned(LogForm) then
    Application.CreateForm(TLogForm, LogForm);
  LogForm.ICQDumpSpeedButton.Down := True;
  XShowForm(LogForm);
end;

procedure TMainForm.DumpJabberClick(Sender: TObject);
begin
  // Включаем лог отладки протокола Jabber
  if not Assigned(LogForm) then
    Application.CreateForm(TLogForm, LogForm);
  LogForm.JabberDumpSpeedButton.Down := True;
  XShowForm(LogForm);
end;

procedure TMainForm.DumpMRAClick(Sender: TObject);
begin
  // Включаем лог отладки протокола MRA
  if not Assigned(LogForm) then
    Application.CreateForm(TLogForm, LogForm);
  LogForm.MRADumpSpeedButton.Down := True;
  XShowForm(LogForm);
end;
{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.EditContactClick(Sender: TObject);
begin
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TMainForm.AppActivate(Sender: TObject);
begin
  FormActivate(Self);
end;

procedure TMainForm.AppDeactivate(Sender: TObject);
begin
  FormDeactivate(Self);
end;

procedure TMainForm.BottomPanelPopupMenuPopup(Sender: TObject);
var
  I: Integer;
begin
  // Выстявляем иконки активности пунктов меню
  with (Sender as TPopupMenu) do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      if Items[I].Checked then
        Items[I].ImageIndex := 140
      else
        Items[I].ImageIndex := 230;
    end;
  end;
end;

procedure TMainForm.BottomToolBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FCursor: TPoint;
begin
  // Вызываем меню нижней панели в позиции курсора
  if Button = MbRight then
  begin
    GetCursorPos(FCursor);
    BottomPanelPopupMenu.Popup(FCursor.X, FCursor.Y);
  end;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TMainForm.AppMinimize(Sender: TObject);
begin
  // Скрываем кнопку программы в панели задач
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  S: string;
  Buf: array[0..$FF] of Char;
  Size: Integer;
  Lang: Word;
  VI: TOSVersionInfo;
  Language: array[0..100] of char;
begin
  // Управляем скрытием кнопки на панели задач
  with Application do
  begin
    ShowMainForm := False;
    OnMinimize := AppMinimize;
    OnRestore := AppMinimize;
    MainFormOnTaskbar := True;
    // Делаем всплывающие подсказки неисчезающими
    HintHidePause := MaxInt;
    OnHint := HintMaxTime;
    // Назначаем продвинутые функции активации и деактивации
    OnActivate := AppActivate;
    OnDeactivate := AppDeactivate;
  end;
  // Устанавливаем начальное значение ширины окна КЛ
  Width := 200;
  // Узнаём путь откуда запущена программа
  V_MyPath := ExtractFilePath(Application.ExeName);
  // Смотрим язык системы
  Lang := GetSystemDefaultLangID;
  if Lang = 1049 then
    V_CurrentLang := 'ru';
  // Узнаём версию Windows
  VI.DwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VI);
  V_StartLog := Format(Log_WinVer, [VI.DwMajorVersion, VI.DwMinorVersion, VI.DwBuildNumber, VI.SzCSDVersion]) + C_RN;
  // Пишем в лог код локального языка системы
  VerLanguageName(Lang, Language, 100);
  V_StartLog := V_StartLog + Log_Lang_Code + C_TN + C_BN + string(Language) + C_BN + C_QN + IntToStr(Lang) + C_EN + C_RN;
  // Пишем в лог путь к программе
  V_StartLog := V_StartLog + LogMyPath + C_TN + C_BN + V_MyPath;
  // Если профиль не найден, то создаём его в настройках юзера виндовс
  V_ProfilePath := V_MyPath + C_Profiles;
  if not DirectoryExists(V_ProfilePath) then
  begin
    S := '%APPDATA%' + C_SN + C_IMadering + C_SN;
    Size := ExpandEnvironmentStrings(PChar(S), Buf, Sizeof(Buf));
    V_ProfilePath := Copy(Buf, 1, Size);
  end;
  // Загрузка иконок для программы
  LoadImageList(AllImageList, V_MyPath + Format(C_IconsPath, [V_CurrentIcons]));
  // Устанавливаем иконку окна
  AllImageList.GetIcon(1, Icon);
  // Скрываем кнопку главное меню в верхней панели
  MainToolTopButton.Visible := False;
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := True;
  // Проверяем могут ли воспроизводится звуки на компьютере
  if InitMixer = 0 then
    V_SoundON := False;
  // Запоминаем текущую версию имадеринг
  V_FullVersion := InitBuildInfo;
  // Создаём окно подсказок
  SH_HintWindow := THintWindow.Create(Application);
  SH_HintWindow.Color := ClInfoBk;
  // Запускаем таймер отображения окна выбора профиля
  JvTimerList.Events[0].Enabled := True;
end;

{$ENDREGION}
{$REGION 'FormDeactivate'}

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  // Включаем прозрачность окна при неактивности
  if V_RoasterAlphaBlend then
    if V_AlphaBlendInactive then
      AlphaBlendValue := V_RoasterAlphaValue;
  // Окно смайлов убрать (глюк в вайн)
  if Assigned(SmilesForm) then
    if SmilesForm.Visible then
      SmilesForm.Hide;
  // Высвобождаем общую память приложения (вспоминая qip)
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
end;

{$ENDREGION}
{$REGION 'FormKeyPress'}

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
label
  X,
    Y,
    Z;
var
  I, Ii: Integer;
  Capt: string;
begin
  if Key = #13 then
    Exit;
  // Делаем поиск по списку контактов
  if V_PKeySearch <> Key then
  begin
    V_CurGroup := 0;
    V_CurItem := 0;
  end;
  // Запоминаем клавишу
  V_PKeySearch := Key;
  Z: ;
  with ContactList do
  begin
    for I := V_CurGroup to Categories.Count - 1 do
    begin
      for Ii := V_CurItem to Categories[I].Items.Count - 1 do
      begin
        Capt := Categories[I].Items[Ii].Caption[1];
        if UpperCase(Capt, LoUserLocale) = UpperCase(Key, LoUserLocale) then
        begin
          if Categories[I].Collapsed then
            Categories[I].Collapsed := False;
          Categories[I].Items.Items[Ii].ScrollIntoView;
          SelectedItem := Categories.Items[I].Items.Items[Ii];
          V_CurItem := Ii + 1;
          goto X;
        end;
      end;
      V_CurItem := 0;
      goto Y;
    end;
    FocusedItem := nil;
    SelectedItem := nil;
    V_CurGroup := 0;
    V_CurItem := 0;
    Exit;
    X: ;
    Exit;
    Y: ;
    V_CurGroup := V_CurGroup + 1;
    if V_CurGroup > Categories.Count then
      Exit
    else
      goto Z;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
  // Устанавливаем заголовок
  if Assigned(SettingsForm) then
    Caption := SettingsForm.HeaderTextEdit.Text;
end;

procedure TMainForm.GrandAuthContactClick(Sender: TObject);
begin
  // Позволяем добавить нас без повторения запроса на авторизацию нам
  if ContactList.SelectedItem <> nil then
  begin
    if ICQ_Work_Phaze then
      ICQ_SendGrandAuth((ContactList.SelectedItem as TButtonItem).UIN);
  end;
end;
{$ENDREGION}
{$REGION 'LoadMainFormSettings'}

procedure TMainForm.LoadMainFormSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      if FileExists(V_ProfilePath + C_SettingsFileName) then
      begin
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
        begin
          // Проверяем есть ли нода главной формы
          XML_Node := Root.Items.ItemNamed[C_MainForm];
          if XML_Node <> nil then
          begin
            // Загружаем позицию окна
            Top := XML_Node.Properties.IntValue(C_FT);
            Left := XML_Node.Properties.IntValue(C_FL);
            Height := XML_Node.Properties.IntValue(C_FH);
            Width := XML_Node.Properties.IntValue(C_FW);
            // Определяем не находится ли окно за пределами экрана
            FormSetInWorkArea(Self);
            // Загружаем состояние кнопки звуков
            Sub_Node := XML_Node.Items.ItemNamed[C_Sounds];
            if Sub_Node <> nil then
              if Sub_Node.BoolValue then
              begin
                SoundOnOffToolButton.Down := True;
                SoundOnOffToolButtonClick(Self);
              end;
            // Загружаем состояние кнопки только онлайн
            Sub_Node := XML_Node.Items.ItemNamed[C_MainFormOnlyOnline];
            if Sub_Node <> nil then
              if Sub_Node.BoolValue then
              begin
                OnlyOnlineContactsToolButton.Down := True;
                OnlyOnlineContactsToolButtonClick(Self);
              end;
            // Загружаем режим окна КЛ выше всех окон
            Sub_Node := XML_Node.Items.ItemNamed[С_MainFormTop];
            if Sub_Node <> nil then
              if Sub_Node.BoolValue then
              begin
                TopModeToolButton.Down := True;
                TopModeToolButtonClick(Self);
              end;
            // Загружаем был ли первый старт
            Sub_Node := XML_Node.Items.ItemNamed[C_MainFormFirst];
            if Sub_Node <> nil then
              V_FirstStart := Sub_Node.BoolValue;
            // Загружаем выбранные протоколы
            Sub_Node := XML_Node.Items.ItemNamed[C_MainFormProto];
            if Sub_Node <> nil then
            begin
              ICQ_Enable(Sub_Node.Properties.BoolValue(C_Icq, False));
              MRA_Enable(Sub_Node.Properties.BoolValue(C_Mra, False));
              Jab_Enable(Sub_Node.Properties.BoolValue(C_Jabber, False));
            end;
            // Загружаем данные трафика
            Sub_Node := XML_Node.Items.ItemNamed[C_Traffic];
            if Sub_Node <> nil then
            begin
              V_AllTrafSend := Sub_Node.Properties.IntValue(C_TS, 0);
              V_AllTrafRecev := Sub_Node.Properties.IntValue(C_TR, 0);
              V_AllSesDataTraf := Sub_Node.Properties.Value(C_TD);
            end;
            // Загружаем пункты меню
            Sub_Node := XML_Node.Items.ItemNamed[C_MainFormHEG];
            if Sub_Node <> nil then
              HideEmptyGroups.Checked := Sub_Node.BoolValue;
            // Загружаем состояние верхней панели
            Sub_Node := XML_Node.Items.ItemNamed[C_MainFormTP];
            if Sub_Node <> nil then
            begin
              // Загружаем состояние кнопок
              MainToolTopButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '0');
              TopMainButtonONMenu.Checked := MainToolTopButton.Visible;
              //
              OnlyOnlineContactsTopButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '1');
              TopOnlyOnlineONMenu.Checked := OnlyOnlineContactsTopButton.Visible;
              //
              SoundOnOffToolTopButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '2');
              TopSoundsONMenu.Checked := SoundOnOffToolTopButton.Visible;
              //
              HistoryTopToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '3');
              TopHistoryONMenu.Checked := HistoryTopToolButton.Visible;
              //
              SettingsTopToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '4');
              TopSettingsONMenu.Checked := SettingsTopToolButton.Visible;
              //
              CLSearchTopToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '5');
              TopCLSearchONMenu.Checked := CLSearchTopToolButton.Visible;
              //
              TrafficTopToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '6');
              TopTrafficONMenu.Checked := TrafficTopToolButton.Visible;
              //
              if not Sub_Node.BoolValue then
              begin
                TopPanelToolButton.Down := False;
                TopToolBar.Visible := False;
              end;
            end;
            // Загружаем состояние нижней панели
            Sub_Node := XML_Node.Items.ItemNamed[C_MainFormBP];
            if Sub_Node <> nil then
            begin
              // Загружаем состояние кнопок
              MainToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '0');
              MainButtonONMenu.Checked := MainToolButton.Visible;
              //
              OnlyOnlineContactsToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '1');
              OnlyOnlineONMenu.Checked := OnlyOnlineContactsToolButton.Visible;
              //
              SoundOnOffToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '2');
              SoundsONMenu.Checked := SoundOnOffToolButton.Visible;
              //
              HistoryToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '3');
              HistoryONMenu.Checked := HistoryToolButton.Visible;
              //
              SettingsToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '4');
              SettingsONMenu.Checked := SettingsToolButton.Visible;
              //
              CLSearchToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '5');
              CLSearchONMenu.Checked := CLSearchToolButton.Visible;
              //
              TrafficToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '6');
              TrafficONMenu.Checked := TrafficToolButton.Visible;
              //
              TopPanelToolButton.Visible := Sub_Node.Properties.BoolValue(C_PB + '7');
              TopPanelONMenu.Checked := TopPanelToolButton.Visible;
            end;
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'SaveMainFormSettings'}

procedure TMainForm.SaveMainFormSettings;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  if V_Profile = EmptyStr then
    Exit;
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Сохраняем настройки положения главного окна в xml
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Подгружаем файл с настройками если он есть
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      if Root <> nil then
      begin
        // Очищаем раздел главной формы если он есть
        XML_Node := Root.Items.ItemNamed[C_MainForm];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_MainForm);
        // Сохраняем позицию окна
        XML_Node.Properties.Add(C_FT, Top);
        XML_Node.Properties.Add(C_FL, Left);
        XML_Node.Properties.Add(C_FH, Height);
        XML_Node.Properties.Add(C_FW, Width);
        // Сохраняем звук вкл. выкл.
        XML_Node.Items.Add(C_Sounds, SoundOnOffToolButton.Down);
        // Сохраняем отображать только онлайн вкл. выкл.
        XML_Node.Items.Add(C_MainFormOnlyOnline, OnlyOnlineContactsToolButton.Down);
        // Сохраняем режим окна КЛ выше всех окон
        XML_Node.Items.Add(С_MainFormTop, TopModeToolButton.Down);
        // Записываем что первый запуск программы уже состоялся и показывать окно настройки протоколов больше не будем при запуске
        XML_Node.Items.Add(C_MainFormFirst, True);
        // Сохраняем активные протоколы
        Sub_Node := XML_Node.Items.Add(C_MainFormProto);
        Sub_Node.Properties.Add(C_Icq, ICQToolButton.Visible);
        Sub_Node.Properties.Add(C_Mra, MRAToolButton.Visible);
        Sub_Node.Properties.Add(C_Jabber, JabberToolButton.Visible);
        // Сохраняем трафик
        Sub_Node := XML_Node.Items.Add(C_Traffic);
        Sub_Node.Properties.Add(C_TS, V_AllTrafSend);
        Sub_Node.Properties.Add(C_TR, V_AllTrafRecev);
        Sub_Node.Properties.Add(C_TD, V_AllSesDataTraf);
        // Сохраняем пункты меню
        XML_Node.Items.Add(C_MainFormHEG, HideEmptyGroups.Checked);
        // Сохраняем состояние верхней панели
        Sub_Node := XML_Node.Items.Add(C_MainFormTP, TopPanelToolButton.Down);
        for I := 0 to TopPanelPopupMenu.Items.Count - 1 do
          Sub_Node.Properties.Add(C_PB + IntToStr(I), TopPanelPopupMenu.Items[I].Checked);
        // Сохраняем состояние нижней панели
        Sub_Node := XML_Node.Items.Add(C_MainFormBP);
        for I := 0 to BottomPanelPopupMenu.Items.Count - 1 do
          Sub_Node.Properties.Add(C_PB + IntToStr(I), BottomPanelPopupMenu.Items[I].Checked);
        // Записываем сам файл
        SaveToFile(V_ProfilePath + C_SettingsFileName);
      end;
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'SendFileUpWapruClick'}

procedure TMainForm.SendFileUpWapruClick(Sender: TObject);
var
  Fsize: Longint;
begin
  if NotProtoOnline((ContactList.SelectedItem as TButtonItem).ContactType) then
    Exit;
  // Открываем форму отправки файлов
  if not Assigned(FileTransferForm) then
    Application.CreateForm(TFileTransferForm, FileTransferForm);
  // Присваиваем переменную способа передачи
  with FileTransferForm do
  begin
    if CancelBitBtn.Enabled then
    begin
      XShowForm(FileTransferForm);
      DAShow(Lang_Vars[18].L_S, Lang_Vars[93].L_S, EmptyStr, 133, 3, 0);
      Exit;
    end;
    // Активируем кнопки
    DescEdit.Enabled := True;
    DescEdit.Color := ClWindow;
    PassEdit.Enabled := True;
    PassEdit.Color := ClWindow;
    SendFileButton.Enabled := True;
    BottomInfoPanel.Caption := EmptyStr;
    SendProgressBar.Position := 0;
    // Выбираем способ передачи файла
    // 1 - UpWap.ru
    Tag := (Sender as TMenuItem).Tag;
    TopInfoPanel.Caption := Lang_Vars[88].L_S + (ContactList.SelectedItem as TButtonItem).Caption;
    T_UIN := UrlDecode((ContactList.SelectedItem as TButtonItem).UIN);
    T_UserType := (ContactList.SelectedItem as TButtonItem).ContactType;
    // Открываем диалог выбора файла для передачи
    if SendFileOpenDialog.Execute then
    begin
      T_FilePath := SendFileOpenDialog.FileName;
      T_FileName := GetFileName(SendFileOpenDialog.FileName);
      FileNamePanel.Caption := C_BN + T_FileName;
      FileNamePanel.Hint := T_FileName;
      // Вычисляем размер файла
      Fsize := GetFileSize(SendFileOpenDialog.FileName);
      if Fsize > 1000000 then
        FileSizePanel.Caption := FloatToStrF(Fsize / 1000000, FfFixed, 18, 3) + ' MB'
      else
        FileSizePanel.Caption := FloatToStrF(Fsize / 1000, FfFixed, 18, 3) + ' KB';
      // Отображаем окно
      XShowForm(FileTransferForm);
    end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.SearchInCL_MenuClick(Sender: TObject);
begin
  // Открываем окно поиска контактов в контактном листе
  if not Assigned(CLSearchForm) then
    Application.CreateForm(TCLSearchForm, CLSearchForm);
  // Отображаем окно
  XShowForm(CLSearchForm);
end;

procedure TMainForm.SendAddContactClick(Sender: TObject);
begin
  // Отправляем пакет "Вас добавили"
  if ContactList.SelectedItem <> nil then
  begin
    if ICQ_Work_Phaze then
      ICQ_SendYouAdded((ContactList.SelectedItem as TButtonItem).UIN);
  end;
end;

procedure TMainForm.SendInviteContactClick(Sender: TObject);
begin
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TMainForm.SendMessageForContactClick(Sender: TObject);
begin
  // Вызываем событие клика по кнопке КЛ
  if ContactList.SelectedItem <> nil then
  begin
    // Делаем двойной клик по контакту
    ContactListButtonClicked(Self, (ContactList.SelectedItem as TButtonItem));
    ContactListButtonClicked(Self, (ContactList.SelectedItem as TButtonItem));
  end;
end;

procedure TMainForm.SettingsONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку настройки на нижней панели
  SettingsONMenu.Checked := not SettingsONMenu.Checked;
  SettingsToolButton.Visible := not SettingsToolButton.Visible;
end;

{$ENDREGION}
{$REGION 'SnapToRightClick'}

procedure TMainForm.SnapToRightClick(Sender: TObject);
begin
  // Уничтожаем старый AppBar
  if V_DockAppBar then
    AppBarDestroy;
  // Создаём новый AppBar
  AppBarCreate;
  if Sender = SnapToRight then
    AppBarSetPos(False)
  else
    AppBarSetPos(True);
  if not V_DockAppBar then
  begin
    V_DockAppBar := True;
    // Запоминаем предыдущие размеры окна
    V_NoDockHeigth := Height;
    V_NoDockWigth := Width;
  end;
  // Запоминаем сторону
  if Sender = SnapToRight then
  begin
    V_DockRigth := True;
    V_DockLeft := False;
  end
  else
  begin
    V_DockRigth := False;
    V_DockLeft := True;
  end;
  // Запускаем таймер перемещения формы в AppBar
  JvTimerList.Events[15].Enabled := True;
end;

{$ENDREGION}
{$REGION 'SoundOnOffToolButtonClick'}

procedure TMainForm.SoundOnOffToolButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. звуков
  if SoundOnOffToolButton.Down then
  begin
    SoundOnOffToolTopButton.Down := True;
    SoundOnOffToolButton.ImageIndex := 136;
    SoundOnOffToolTopButton.ImageIndex := 136;
    V_SoundON := False;
    if Assigned(SettingsForm) then
      SettingsForm.SoundOnOffCheckBox.Checked := True;
  end
  else
  begin
    SoundOnOffToolTopButton.Down := False;
    SoundOnOffToolButton.ImageIndex := 135;
    SoundOnOffToolTopButton.ImageIndex := 135;
    if InitMixer <> 0 then
      V_SoundON := True;
    if Assigned(SettingsForm) then
      SettingsForm.SoundOnOffCheckBox.Checked := False;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.SoundOnOffToolTopButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. звуков
  SoundOnOffToolButton.Down := not SoundOnOffToolButton.Down;
  SoundOnOffToolButtonClick(Self);
end;

procedure TMainForm.TopCLSearchONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку поиска на верхней панели
  TopCLSearchONMenu.Checked := not TopCLSearchONMenu.Checked;
  CLSearchTopToolButton.Visible := not CLSearchTopToolButton.Visible;
end;

procedure TMainForm.TopHistoryONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку история сообщений на верхней панели
  TopHistoryONMenu.Checked := not TopHistoryONMenu.Checked;
  HistoryTopToolButton.Visible := not HistoryTopToolButton.Visible;
end;

procedure TMainForm.TopMainButtonONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку главного меню на верхней панели
  TopMainButtonONMenu.Checked := not TopMainButtonONMenu.Checked;
  MainToolTopButton.Visible := not MainToolTopButton.Visible;
end;

procedure TMainForm.TopModeToolButtonClick(Sender: TObject);
begin
  // Управляем режимом "поверх всех окон" из окна КЛ
  if TopModeToolButton.Down then
  begin
    FormStyle := FsStayOnTop;
    TopModeToolButton.ImageIndex := 287;
  end
  else
  begin
    FormStyle := FsNormal;
    TopModeToolButton.ImageIndex := 288;
  end;
end;

procedure TMainForm.TopOnlyOnlineONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку только онлайн на верхней панели
  TopOnlyOnlineONMenu.Checked := not TopOnlyOnlineONMenu.Checked;
  OnlyOnlineContactsTopButton.Visible := not OnlyOnlineContactsTopButton.Visible;
end;

procedure TMainForm.TopPanelONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку скрыть группы на нижней панели
  TopPanelONMenu.Checked := not TopPanelONMenu.Checked;
  TopPanelToolButton.Visible := not TopPanelToolButton.Visible;
end;

procedure TMainForm.TopPanelToolButtonClick(Sender: TObject);
begin
  // Включаем или отключаем отображение верхней панели
  if TopPanelToolButton.Down then
    TopToolBar.Visible := True
  else
    TopToolBar.Visible := False;
end;

procedure TMainForm.TopSettingsONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку настройки на верхней панели
  TopSettingsONMenu.Checked := not TopSettingsONMenu.Checked;
  SettingsTopToolButton.Visible := not SettingsTopToolButton.Visible;
end;

procedure TMainForm.TopSoundsONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку звуки на верхней панели
  TopSoundsONMenu.Checked := not TopSoundsONMenu.Checked;
  SoundOnOffToolTopButton.Visible := not SoundOnOffToolTopButton.Visible;
end;

procedure TMainForm.TopToolBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FCursor: TPoint;
begin
  // Вызываем меню верхней панели в позиции курсора
  if Button = MbRight then
  begin
    GetCursorPos(FCursor);
    TopPanelPopupMenu.Popup(FCursor.X, FCursor.Y);
  end;
end;

procedure TMainForm.TopTrafficONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку трафик на верхней панели
  TopTrafficONMenu.Checked := not TopTrafficONMenu.Checked;
  TrafficTopToolButton.Visible := not TrafficTopToolButton.Visible;
end;

{$ENDREGION}
{$REGION 'TwitterHttpClientRequestDone'}

procedure TMainForm.TwitterClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
begin
  // Управляем кукие
  XLog(TwitterClient.Name + C_BN + Log_Get + C_BN + C_Cookie, Data, C_HTTP);
end;

procedure TMainForm.TwitterClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
  List: TStringList;
  Form_Flag, PIN_Flag, Login_Flag, PostMsg_Flag: Boolean;
  PostData: AnsiString;
  S: string;
begin
  Form_Flag := False;
  PIN_Flag := False;
  Login_Flag := False;
  PostMsg_Flag := False;
  try
    // Высвобождаем память отправки данных
    if TwitterClient.SendStream <> nil then
    begin
      TwitterClient.SendStream.Free;
      TwitterClient.SendStream := nil;
    end;
    // Читаем полученные http данные из блока памяти
    if TwitterClient.RcvdStream <> nil then
    begin
      // Создаём временный лист
      List := TStringList.Create;
      try
        // Увеличиваем статистику входящего трафика
        V_TrafRecev := V_TrafRecev + TwitterClient.RcvdCount;
        V_AllTrafRecev := V_AllTrafRecev + TwitterClient.RcvdCount;
        if Assigned(TrafficForm) then
          Traffic_MenuClick(nil);
        // Обнуляем позицию начала чтения в блоке памяти
        TwitterClient.RcvdStream.Position := 0;
        // Определяем выполнение задания для данных по флагу
        case TwitterClient.Tag of
          0: // Запрос ключей OAuth
            begin
              // Читаем данные в лист
              List.LoadFromStream(TwitterClient.RcvdStream, TEncoding.UTF8);
              S := Trim(List.Text);
              // Разбираем данные в листе
              if S <> EmptyStr then
              begin
                XLog(C_Twitter + C_BN + Log_Get, S, C_Twitter);
                // Парсим ключи
                V_Twitter_OAuth_Token := IsolateTextString(S, C_Twitter_OAuth_Token, C_AN);
                V_Twitter_OAuth_Token_Secret := IsolateTextString(S, C_Twitter_OAuth_Token_Secret, C_AN);
                if (V_Twitter_OAuth_Token <> EmptyStr) and (V_Twitter_OAuth_Token_Secret <> EmptyStr) then
                begin
                  XLog(C_Twitter + C_BN + Log_Parsing, C_Twitter_OAuth_Token + V_Twitter_OAuth_Token + C_RN //
                    + C_Twitter_OAuth_Token_Secret + V_Twitter_OAuth_Token_Secret, C_Twitter);
                  // Ставим флаг для получения формы логина
                  Form_Flag := True;
                  //OpenURL(C_Twitter_Host + C_Twitter_Authorize + C_GT + C_Twitter_OAuth_Token + V_Twitter_OAuth_Token);
                end;
              end;
            end;
          1:
            begin
              // Читаем данные в лист
              List.LoadFromStream(TwitterClient.RcvdStream, TEncoding.UTF8);
              S := Trim(List.Text);
              // Разбираем данные в листе
              if S <> EmptyStr then
              begin
                XLog(C_Twitter + C_BN + Log_Get, S, C_Twitter);
                V_Twitter_Authenticity_Token := IsolateTextString(S, 'name="authenticity_token"', '>');
                V_Twitter_Authenticity_Token := EncodeRFC3986(IsolateTextString(V_Twitter_Authenticity_Token, 'value="', '"'));
                // Ставим флаг для получения ПИН кода
                if V_Twitter_Authenticity_Token <> EmptyStr then
                begin
                  XLog(C_Twitter + C_BN + Log_Parsing, C_Twitter_Authenticity_Token + V_Twitter_Authenticity_Token, C_Twitter);
                  PIN_Flag := True;
                end;
              end;
            end;
          2:
            begin
              // Читаем данные в лист
              List.LoadFromStream(TwitterClient.RcvdStream, TEncoding.UTF8);
              S := Trim(List.Text);
              // Разбираем данные в листе
              if S <> EmptyStr then
              begin
                XLog(C_Twitter + C_BN + Log_Get, S, C_Twitter);
                V_Twitter_OAuth_PIN := IsolateTextString(S, 'id="oauth_pin"', '/');
                V_Twitter_OAuth_PIN := Trim(IsolateTextString(V_Twitter_OAuth_PIN, '>', '<'));
                // Ставим флаг для логина с полученным ПИН кодом
                if V_Twitter_OAuth_PIN <> EmptyStr then
                begin
                  XLog(C_Twitter + C_BN + Log_Parsing, 'PIN' + C_TN + C_BN + C_QN + V_Twitter_OAuth_PIN + C_EN, C_Twitter);
                  Login_Flag := True;
                end
                else // Сообщаем, что были введены не верные логин или пароль
                begin
                  V_Twitter_Username := EmptyStr;
                  V_Twitter_Password := EmptyStr;
                  DAShow(Lang_Vars[17].L_S, Format(Lang_Vars[120].L_S, [C_Twitter]), EmptyStr, 134, 2, 0);
                end;
              end;
            end;
          3:
            begin
              // Читаем данные в лист
              List.LoadFromStream(TwitterClient.RcvdStream, TEncoding.UTF8);
              S := Trim(List.Text);
              // Разбираем данные в листе
              if S <> EmptyStr then
              begin
                XLog(C_Twitter + C_BN + Log_Get, S, C_Twitter);
                V_Twitter_OAuth_Token := EmptyStr;
                V_Twitter_OAuth_Token_Secret := EmptyStr;
                V_Twitter_OAuth_Token := IsolateTextString(S, C_Twitter_OAuth_Token, C_AN);
                V_Twitter_OAuth_Token_Secret := IsolateTextString(S, C_Twitter_OAuth_Token_Secret, C_AN);
                // Ставим флаг для постинга сообщения
                if (V_Twitter_OAuth_Token <> EmptyStr) and (V_Twitter_OAuth_Token_Secret <> EmptyStr) then
                begin
                  XLog(C_Twitter + C_BN + Log_Parsing, C_Twitter_OAuth_Token + V_Twitter_OAuth_Token + C_RN //
                    + C_Twitter_OAuth_Token_Secret + V_Twitter_OAuth_Token_Secret, C_Twitter);
                  PostMsg_Flag := True;
                end;
              end;
            end;
          4:
            begin
              // Инициализируем XML
              JvXML_Create(JvXML);
              try
                with JvXML do
                begin
                  LoadFromStream(TwitterClient.RcvdStream);
                  XLog(C_Twitter + C_BN + Log_Get, Trim(XMLData), C_Twitter);
                  if Root <> nil then
                  begin
                    // Проверяем на ошибки и отображаем если они есть
                    XML_Node := Root.Items.ItemNamed['error'];
                    if XML_Node <> nil then
                      DAShow(Lang_Vars[17].L_S + C_BN + C_Twitter, XML_Node.Value, EmptyStr, 134, 2, 0);
                    // Проверяем на успешную публикацию
                    XML_Node := Root.Items.ItemNamed['created_at'];
                    if XML_Node <> nil then
                      DAShow(Lang_Vars[16].L_S, Format(Lang_Vars[60].L_S, [C_Twitter]), EmptyStr, 133, 3, 0);
                  end;
                end;
              finally
                JvXML.Free;
              end;
            end;
        end;
      finally
        List.Free;
        // Высвобождаем блок памяти
        TwitterClient.RcvdStream.Free;
        TwitterClient.RcvdStream := nil;
      end;
    end;
    // Запускаем получение формы логина
    if Form_Flag then
    begin
      with TwitterClient do
      begin
        // Сбрасываем сокет если он занят чем то другим или висит
        Close;
        Abort;
        // Ставим флаг задания
        Tag := 1;
        // Запускаем получение формы логина
        URL := C_Twitter_Host + C_Twitter_Authorize + C_GT + C_Twitter_OAuth_Token + V_Twitter_OAuth_Token;
        XLog(C_Twitter + C_BN + Log_Send, URL, C_Twitter, False);
        GetASync;
      end;
      Exit;
    end;
    // Запускаем получение ПИН кода
    if PIN_Flag then
    begin
      PostData := EmptyStr;
      with TwitterClient do
      begin
        // Сбрасываем сокет если он занят чем то другим или висит
        Close;
        Abort;
        // Ставим флаг задания
        Tag := 2;
        // Запускаем получение ПИН кода
        URL := C_Twitter_Host + C_Twitter_Authorize + C_GT //
        + C_Twitter_Authenticity_Token + V_Twitter_Authenticity_Token + C_AN //
        + C_Twitter_OAuth_Token + V_Twitter_OAuth_Token + C_AN //
        + C_Twitter_Username + EncodeRFC3986(V_Twitter_Username) + C_AN //
        + C_Twitter_Password + EncodeRFC3986(V_Twitter_Password);
        XLog(C_Twitter + C_BN + Log_Send, URL, C_Twitter, False);
        SendStream := TMemoryStream.Create;
        SendStream.Write(PostData[1], Length(PostData));
        SendStream.Seek(0, 0);
        PostASync;
      end;
      Exit;
    end;
    // Запускаем логин с полученным ПИН кодом
    if Login_Flag then
    begin
      // Начинаем заполнение параметров
      V_Twitter_Params := TStringList.Create;
      try
        V_Twitter_OAuth_Consumer_Key := C_Twitter_OAuth_Consumer_Key + X_Twitter_OAuth_Consumer_Key;
        V_Twitter_OAuth_Nonce := C_Twitter_OAuth_Nonce + Twitter_Generate_Nonce;
        V_Twitter_OAuth_Timestamp := C_Twitter_OAuth_Timestamp + IntToStr(DateTimeToUnix(Now));
        with V_Twitter_Params do
        begin
          Add(V_Twitter_OAuth_Consumer_Key);
          Add(V_Twitter_OAuth_Nonce);
          Add(C_Twitter_OAuth_Signature_Method);
          Add(V_Twitter_OAuth_Timestamp);
          Add(C_Twitter_OAuth_Token + V_Twitter_OAuth_Token);
          Add(C_Twitter_OAuth_Verifier + V_Twitter_OAuth_PIN);
          Add(C_Twitter_OAuth_Version);
        end;
        V_Twitter_OAuth_Signature := Twitter_HMAC_SHA1_Signature(C_Twitter_Host + C_Twitter_Access_Token, C_POST, V_Twitter_OAuth_Token_Secret, V_Twitter_Params);
      finally
        V_Twitter_Params.Free;
      end;
      PostData := EmptyStr;
      with TwitterClient do
      begin
        // Сбрасываем сокет если он занят чем то другим или висит
        Close;
        Abort;
        // Ставим флаг задания
        Tag := 3;
        // Запускаем логин с полученным ПИН кодом
        URL := V_Twitter_OAuth_Signature;
        XLog(C_Twitter + C_BN + Log_Send, URL, C_Twitter, False);
        SendStream := TMemoryStream.Create;
        SendStream.Write(PostData[1], Length(PostData));
        SendStream.Seek(0, 0);
        PostASync;
      end;
      Exit;
    end;
    // Запускаем постинг сообщения
    if PostMsg_Flag then
    begin
      // Начинаем заполнение параметров
      V_Twitter_Params := TStringList.Create;
      try
        V_Twitter_OAuth_Consumer_Key := C_Twitter_OAuth_Consumer_Key + X_Twitter_OAuth_Consumer_Key;
        V_Twitter_OAuth_Nonce := C_Twitter_OAuth_Nonce + Twitter_Generate_Nonce;
        V_Twitter_OAuth_Timestamp := C_Twitter_OAuth_Timestamp + IntToStr(DateTimeToUnix(Now));
        with V_Twitter_Params do
        begin
          Add(V_Twitter_OAuth_Consumer_Key);
          Add(V_Twitter_OAuth_Nonce);
          Add(C_Twitter_OAuth_Signature_Method);
          Add(V_Twitter_OAuth_Timestamp);
          Add(C_Twitter_OAuth_Token + V_Twitter_OAuth_Token);
          Add(C_Twitter_OAuth_Version);
          Add('status=' + EncodeRFC3986(V_Twitter_PostMsg));
        end;
        V_Twitter_OAuth_Signature := Twitter_HMAC_SHA1_Signature(C_Twitter_Host + C_Twitter_PostMsg, C_POST, V_Twitter_OAuth_Token_Secret, V_Twitter_Params);
      finally
        V_Twitter_Params.Free;
      end;
      PostData := EmptyStr;
      with TwitterClient do
      begin
        // Сбрасываем сокет если он занят чем то другим или висит
        Close;
        Abort;
        // Ставим флаг задания
        Tag := 4;
        // Запускаем логин с полученным ПИН кодом
        URL := V_Twitter_OAuth_Signature;
        XLog(C_Twitter + C_BN + Log_Send, URL, C_Twitter, False);
        SendStream := TMemoryStream.Create;
        SendStream.Write(PostData[1], Length(PostData));
        SendStream.Seek(0, 0);
        PostASync;
      end;
    end;
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.TwitterClientSessionClosed(Sender: TObject);
var
  S: string;
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (TwitterClient.StatusCode = 0) or (TwitterClient.StatusCode >= 400) then
  begin
    S := Format(ErrorHttpClient(TwitterClient.StatusCode), [(Sender as THttpCli).Name]);
    DAShow(Lang_Vars[17].L_S, S, EmptyStr, 134, 2, 0);
  end;
end;
{$ENDREGION}
{$REGION 'UniqContactSettingsMenuClick'}

procedure TMainForm.UniqContactSettingsMenuClick(Sender: TObject);
begin
  // Открываем окно уникальных настроек контакта
  if not Assigned(UniqForm) then
    UniqForm := TUniqForm.Create(Self);
  if (ContactList.SelectedItem as TButtonItem).ContactType = C_Icq then
    UniqForm.AccountPanel.Caption := Lang_Vars[20].L_S + C_BN + UpperCase(C_Icq) + C_TN + (ContactList.SelectedItem as TButtonItem).UIN
  else if (ContactList.SelectedItem as TButtonItem).ContactType = C_Jabber then
    UniqForm.AccountPanel.Caption := Lang_Vars[20].L_S + C_BN + C_Jabber + C_TN + (ContactList.SelectedItem as TButtonItem).UIN;
  // Отображаем окно
  XShowForm(UniqForm);
end;
{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.UnstableICQStatusClick(Sender: TObject);
begin
  // Активируем или деактивируем таймер нестабильного статуса
  if not UnstableICQStatus.Checked then
  begin
    UnstableICQStatus.Checked := True;
    JvTimerList.Events[4].Enabled := True;
  end
  else
    UnstableICQStatus.Checked := False;
end;

procedure TMainForm.OpenGame_MenuClick(Sender: TObject);
begin
  // Открываем в окне чата закладку с играми
  if not Assigned(GamesForm) then
    Application.CreateForm(TGamesForm, GamesForm);
  XShowForm(GamesForm);
end;

procedure TMainForm.OpenGroupsCLClick(Sender: TObject);
var
  I: Integer;
begin
  // Открываем все группы в контакт листе
  for I := 0 to MainForm.ContactList.Categories.Count - 1 do
    MainForm.ContactList.Categories[I].Collapsed := False;
end;

procedure TMainForm.History_MenuClick(Sender: TObject);
begin
  // Открываем пустое окно истории сообщений
  if not Assigned(HistoryForm) then
    Application.CreateForm(THistoryForm, HistoryForm);
  // Отображаем окно
  XShowForm(HistoryForm);
end;

procedure TMainForm.HttpClientSendEnd(Sender: TObject);
begin
  // Увеличиваем статистику исходящего трафика
  V_TrafSend := V_TrafSend + (Sender as THttpCli).SentCount;
  V_AllTrafSend := V_AllTrafSend + (Sender as THttpCli).SentCount;
  if Assigned(TrafficForm) then
    Traffic_MenuClick(nil);
end;

{$ENDREGION}
{$REGION 'UpdateHttpClientSessionClosed'}

procedure TMainForm.HttpClientSessionClosed(Sender: TObject);
var
  S: string;
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (HttpClient.StatusCode = 0) or (HttpClient.StatusCode >= 400) then
  begin
    S := Format(ErrorHttpClient(HttpClient.StatusCode), [(Sender as THttpCli).Name]);
    DAShow(Lang_Vars[17].L_S, S, EmptyStr, 134, 2, 0);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.HttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.HttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
var
  S: string;
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    S := Format(Lang_Vars[23].L_S, [(Sender as THttpCli).name]) + C_BN + Msg + C_BN + C_QN + Format(Lang_Vars[27].L_S, [Error]) + C_EN;
    DAShow(Lang_Vars[17].L_S, S, EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.ICQWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Icq, WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  ICQ_GoOffline;
end;

procedure TMainForm.MRAWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Mra, WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  MRA_GoOffline;
end;

procedure TMainForm.MRAWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  // Увеличиваем статистику исходящего трафика
  V_TrafSend := V_TrafSend + BytesSent;
  V_AllTrafSend := V_AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then
    Traffic_MenuClick(nil);
end;

procedure TMainForm.MRAWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Mra, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
end;

procedure TMainForm.MRAWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if (not MRA_Connect_Phaze) and (not MRA_Offline_Phaze) then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Mra, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
    // Если нужно переподключаться, то активируем этот таймер
    MRA_Reconnect := True;
  end;
end;

{$ENDREGION}
{$REGION 'MRAWSocketSessionConnected'}

procedure TMainForm.MRAWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  Http_data, Http_login: string;
begin
  // Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Mra, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
  // HTTP прокси коннект
  if V_HttpProxy_Enable then
  begin
    // Составляем адрес
    if MRA_Connect_Phaze then
      Http_data := MRA_LoginServerAddr + C_TN + MRA_LoginServerPort
    else
      Http_data := MRA_Bos_IP + C_TN + MRA_Bos_Port;
    // Если авторизация на прокси
    if V_HttpProxy_Auth then
    begin
      Http_login := Base64Encode(V_HttpProxy_Login + C_TN + V_HttpProxy_Password);
      Http_login := C_Proxy_Auth + C_BN + Http_login + C_RN;
    end;
    // Формируем основной запрос для http прокси
    Http_data := C_Proxy_Connect + C_BN + Http_data + C_BN + C_Proxy_Type + SettingsForm.ProxyVersionComboBox.Text + C_RN //
     + C_Proxy_Alive + C_RN + C_Proxy_Host + C_TN + C_BN + Http_data + C_RN + Http_login + C_RN;
    XLog(C_Mra + C_BN + Log_Send, Http_data, C_Mra, False);
    // Отсылаем запрос для прокси
    MRAWSocket.SendStr(Http_data);
    Exit;
  end;
  // Если уже подключились в Bos серверу
  if MRA_BosConnect_Phaze then
    MRA_Login_1; // Отсылаем первый пакет логина
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.LinkCompress_MenuClick(Sender: TObject);
const
  P = 'url=%s&security_token=null';
var
  L: string;
  S: AnsiString;
begin
  // Делаем запрос для укорочения ссылки
  if InputQuery(LinkCompress_Menu.Caption, 'URL' + C_TN, L) then
  begin
    if L <> EmptyStr then
    begin
      L := UrlEncode(L);
      L := Format(P, [L]);
      S := EmptyStr;
      with HttpClient do
      begin
        // Сбрасываем сокет если он занят чем то другим или висит
        Close;
        Abort;
        // Ставим флаг задания
        Location := EmptyStr;
        Tag := 4;
        // Запускаем получение укороченной ссылки
        LocationChangeMaxCount := 0;
        URL := 'http://goo.gl/api/shorten' + C_GT + L;
        XLog(Name + C_BN + Log_Send, URL, C_HTTP, False);
        SendStream := TMemoryStream.Create;
        SendStream.Write(S[1], Length(S));
        SendStream.Seek(0, 0);
        PostASync;
      end;
    end;
  end;
end;

procedure TMainForm.MRAWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError(C_Mra, ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
end;

procedure TMainForm.MRAWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, Lang_Vars[23].L_S + C_RN + Msg + C_RN + Format(Lang_Vars[27].L_S, [Error]) + C_RN + C_QN + C_BN + Log_Socket + C_TN + C_BN + C_Mra + C_BN + C_EN, EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
end;

procedure TMainForm.ShowLog_MenuClick(Sender: TObject);
begin
  // Отображаем окно
  if not Assigned(LogForm) then
    Application.CreateForm(TLogForm, LogForm);
  XShowForm(LogForm);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  // Помещаем кнопку формы в таскбар и делаем независимой
  if Assigned(SettingsForm) then
    if not SettingsForm.NoTaskBarMainButtonCheckBox.Checked then
    begin
      SetWindowLong(Handle, GWL_HWNDPARENT, 0);
      SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
    end;
  // Скрываем кнопку программы на панели задач
  ShowWindow(Application.Handle, SW_HIDE);
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // Удаляем профиль автоматически если указано
  if V_AutoDellProfile then
  begin
    if DirectoryExists(V_ProfilePath) then
      TDirectory.Delete(V_ProfilePath, True);
  end;
end;
{$ENDREGION}
{$REGION 'Init and Final'}

initialization

  // Стартуем встроенный в программу отладчик
  Include(JclStackTrackingOptions, StRawMode);
  Include(JclStackTrackingOptions, StStaticModuleList);
  JclStartExceptionTracking;
  // Активируем хинты с поддержкой HTML
  RegisterHtHints;

finalization

  // Деактивируем встроенный отладчик
  JclStopExceptionTracking;

{$ENDREGION}

end.

