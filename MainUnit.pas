﻿{ *******************************************************************************
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
  Registry,
  ActnList,
  GifImg,
  AppEvnts,
  JclDebug,
  JvSimpleXml,
  ExtDlgs;

type
  TMainForm = class(TForm)
    ContactList: TCategoryButtons;
    BottomToolBar: TToolBar;
    MainToolButton: TToolButton;
    ICQToolButton: TToolButton;
    ICQTrayIcon: TTrayIcon;
    TrayPopupMenu: TPopupMenu;
    AllImageList: TImageList;
    JvTimerList: TJvTimerList;
    MainPopupMenu: TPopupMenu;
    CloseProgram: TMenuItem;
    HideInTray: TMenuItem;
    N3: TMenuItem;
    CloseProgramTray1: TMenuItem;
    N1: TMenuItem;
    SettingsTray1: TMenuItem;
    N2: TMenuItem;
    MRATrayIcon: TTrayIcon;
    JabberTrayIcon: TTrayIcon;
    ICQWSocket: TWSocket;
    MRAWSocket: TWSocket;
    JabberWSocket: TSslWSocket;
    ICQAvatarWSocket: TWSocket;
    UpdateHttpClient: THttpCli;
    MRAToolButton: TToolButton;
    JabberToolButton: TToolButton;
    AboutIMadering: TMenuItem;
    OpenSettings: TMenuItem;
    HideMainInTray1: TMenuItem;
    OpenTest: TMenuItem;
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
    N16: TMenuItem;
    MRASettings: TMenuItem;
    N17: TMenuItem;
    JabberSettings: TMenuItem;
    SoundOnOffToolButton: TToolButton;
    OnlyOnlineContactsToolButton: TToolButton;
    N19: TMenuItem;
    StatusTray1: TMenuItem;
    ContactPopupMenu: TPopupMenu;
    CheckUpdateTray1: TMenuItem;
    RightICQPopupMenu: TPopupMenu;
    UnstableICQStatus: TMenuItem;
    OpenGroupsCL: TMenuItem;
    CloseGroupsCL: TMenuItem;
    N5: TMenuItem;
    AddNewGroupICQ: TMenuItem;
    RenemeGroupCL: TMenuItem;
    DeleteGroupCL: TMenuItem;
    N20: TMenuItem;
    SearchInCL: TMenuItem;
    N18: TMenuItem;
    AddNewContactICQ: TMenuItem;
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
    OpenHistory: TMenuItem;
    OpenTraffic: TMenuItem;
    MRAAvatarHttpClient: THttpCli;
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
    RosterMainMenu: TMenuItem;
    UnstableMRAStatus: TMenuItem;
    UnstableJabberStatus: TMenuItem;
    SearchInCLMainMenu: TMenuItem;
    HideEmptyGroups: TMenuItem;
    GroupOnOffToolButton: TToolButton;
    ICQSearchNewContact: TMenuItem;
    CheckUpdateMenu: TMenuItem;
    N29: TMenuItem;
    PrivatListMenu: TMenuItem;
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
    GroupONMenu: TMenuItem;
    TopPanelONMenu: TMenuItem;
    OnlyOnlineContactsTopButton: TToolButton;
    GroupOnOffToolTopButton: TToolButton;
    SoundOnOffToolTopButton: TToolButton;
    PrivatTopToolButton: TToolButton;
    HistoryTopToolButton: TToolButton;
    PrivatToolButton: TToolButton;
    HistoryToolButton: TToolButton;
    SettingsToolButton: TToolButton;
    PrivatONMenu: TMenuItem;
    HistoryONMenu: TMenuItem;
    SettingsONMenu: TMenuItem;
    MainToolTopButton: TToolButton;
    TrafficTopToolButton: TToolButton;
    TrafficToolButton: TToolButton;
    TrafficONMenu: TMenuItem;
    TopMainButtonONMenu: TMenuItem;
    TopOnlyOnlineONMenu: TMenuItem;
    TopGroupONMenu: TMenuItem;
    TopSoundsONMenu: TMenuItem;
    TopPrivatONMenu: TMenuItem;
    TopHistoryONMenu: TMenuItem;
    TopTrafficONMenu: TMenuItem;
    AddNewGroupJabber: TMenuItem;
    AddNewGroupMRA: TMenuItem;
    JabberSslContext: TSslContext;
    AddNewContactJabber: TMenuItem;
    AddNewContactMRA: TMenuItem;
    SendFileMenu: TMenuItem;
    SendFileUpWapru: TMenuItem;
    SendFileOpenDialog: TOpenDialog;
    LogFormMenu: TMenuItem;
    IMaderingEvents: TApplicationEvents;
    UniqContactSettingsMenu: TMenuItem;
    FloatContactMenu: TMenuItem;
    N27: TMenuItem;
    ProfileOpenMenu: TMenuItem;
    XTrayIcon: TTrayIcon;
    XTrayPopupMenu: TPopupMenu;
    HideProfileInTray: TMenuItem;
    CloseProgramTray2: TMenuItem;
    N24: TMenuItem;
    ShowLogTray: TMenuItem;
    N28: TMenuItem;
    HideMainInTray2: TMenuItem;
    StatusTray2: TMenuItem;
    N30: TMenuItem;
    SettingsTray2: TMenuItem;
    CheckUpdateTray2: TMenuItem;
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
    TwitterToolButton: TToolButton;
    TwitterPopupMenu: TPopupMenu;
    OpenSiteTwitterMinu: TMenuItem;
    OpenMyPageMenu: TMenuItem;
    TwitterSettingsMenu: TMenuItem;
    N33: TMenuItem;
    N31: TMenuItem;
    MyLentaTwitterMenu: TMenuItem;
    PostMessageTwitterMenu: TMenuItem;
    N36: TMenuItem;
    OnlineTwitterMenu: TMenuItem;
    OfflineTwitterMenu: TMenuItem;
    TwitterHttpClient: THttpCli;
    MyInfoTwitterMenu: TMenuItem;
    IncMessTwitterMenu: TMenuItem;
    SaveTextAsFileDialog: TSaveTextFileDialog;
    MraSMSSendMenu: TMenuItem;
    N34: TMenuItem;
    TwitterSearchMenu: TMenuItem;
    AllLentaTwitterMenu: TMenuItem;
    N37: TMenuItem;
    PostImageTwitterMenu: TMenuItem;
    MyPostsLentaTwitterMenu: TMenuItem;
    PostsMeLentaTwitterMenu: TMenuItem;
    FavoriteLentaTwitterMenu: TMenuItem;
    OutMessTwitterMenu: TMenuItem;
    SnapContactList: TMenuItem;
    SnapToRight: TMenuItem;
    SnapToLeft: TMenuItem;
    N39: TMenuItem;
    OpenGameMenu: TMenuItem;
    N38: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure JvTimerListEvents0Timer(Sender: TObject);
    procedure HintMaxTime(Sender: TObject);
    procedure MainToolButtonClick(Sender: TObject);
    procedure OpenSettingsClick(Sender: TObject);
    procedure ICQTrayIconClick(Sender: TObject);
    procedure OpenTestClick(Sender: TObject);
    procedure AboutIMaderingClick(Sender: TObject);
    procedure UpdateHttpClientDocBegin(Sender: TObject);
    procedure JvTimerListEvents2Timer(Sender: TObject);
    procedure ICQSettingsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ICQXStatusClick(Sender: TObject);
    procedure ICQToolButtonClick(Sender: TObject);
    procedure MRAToolButtonClick(Sender: TObject);
    procedure JabberToolButtonClick(Sender: TObject);
    procedure MRAXStatusClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SoundOnOffToolButtonClick(Sender: TObject);
    procedure OnlyOnlineContactsToolButtonClick(Sender: TObject);
    procedure TrayPopupMenuPopup(Sender: TObject);
    procedure ICQTrayIconMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ICQStatusOnlineClick(Sender: TObject);
    procedure ICQStatusOfflineClick(Sender: TObject);
    procedure ICQWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure MRASettingsClick(Sender: TObject);
    procedure JabberSettingsClick(Sender: TObject);
    procedure CheckUpdateTray1Click(Sender: TObject);
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
    procedure AddNewGroupICQClick(Sender: TObject);
    procedure RenemeGroupCLClick(Sender: TObject);
    procedure DeleteGroupCLClick(Sender: TObject);
    procedure SearchInCLClick(Sender: TObject);
    procedure AddNewContactICQClick(Sender: TObject);
    procedure EditContactClick(Sender: TObject);
    procedure DeleteContactClick(Sender: TObject);
    procedure GrandAuthContactClick(Sender: TObject);
    procedure SendAddContactClick(Sender: TObject);
    procedure DelYourSelfContactClick(Sender: TObject);
    procedure SendInviteContactClick(Sender: TObject);
    procedure UnstableICQStatusClick(Sender: TObject);
    procedure OpenHistoryClick(Sender: TObject);
    procedure OpenTrafficClick(Sender: TObject);
    procedure UpdateHttpClientSendEnd(Sender: TObject);
    procedure ICQWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure UpdateHttpClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure JabberWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure JvTimerListEvents4Timer(Sender: TObject);
    procedure JvTimerListEvents3Timer(Sender: TObject);
    procedure JvTimerListEvents5Timer(Sender: TObject);
    procedure JvTimerListEvents6Timer(Sender: TObject);
    procedure JvTimerListEvents7Timer(Sender: TObject);
    procedure JabberStatusOfflineClick(Sender: TObject);
    procedure JabberStatusOnlineClick(Sender: TObject);
    procedure ICQWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure JabberWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure UpdateHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure UpdateHttpClientSessionClosed(Sender: TObject);
    procedure ICQWSocketError(Sender: TObject);
    procedure ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure UpdateHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketError(Sender: TObject);
    procedure JabberWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure JvTimerListEvents9Timer(Sender: TObject);
    procedure RosterMainMenuClick(Sender: TObject);
    procedure JvTimerListEvents11Timer(Sender: TObject);
    procedure JvTimerListEvents12Timer(Sender: TObject);
    procedure JabberXStatusClick(Sender: TObject);
    procedure ContactListMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ContactListPopupMenuPopup(Sender: TObject);
    procedure HideEmptyGroupsClick(Sender: TObject);
    procedure RightICQPopupMenuPopup(Sender: TObject);
    procedure HideInTrayClick(Sender: TObject);
    procedure GroupOnOffToolButtonClick(Sender: TObject);
    procedure MainToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure PrivatListMenuClick(Sender: TObject);
    procedure JabberSearchNewContactClick(Sender: TObject);
    procedure ICQSearchNewContactClick(Sender: TObject);
    procedure CloseActiveFormActionExecute(Sender: TObject);
    procedure ChatTabCloseActionExecute(Sender: TObject);
    procedure BottomPanelPopupMenuPopup(Sender: TObject);
    procedure TopPanelToolButtonClick(Sender: TObject);
    procedure MRAStatusOnlineClick(Sender: TObject);
    procedure MainButtonONMenuClick(Sender: TObject);
    procedure SoundsONMenuClick(Sender: TObject);
    procedure OnlyOnlineONMenuClick(Sender: TObject);
    procedure GroupONMenuClick(Sender: TObject);
    procedure TopPanelONMenuClick(Sender: TObject);
    procedure MainToolTopButtonClick(Sender: TObject);
    procedure BottomToolBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TopToolBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MainToolTopButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure GroupOnOffToolTopButtonClick(Sender: TObject);
    procedure OnlyOnlineContactsTopButtonClick(Sender: TObject);
    procedure SoundOnOffToolTopButtonClick(Sender: TObject);
    procedure PrivatONMenuClick(Sender: TObject);
    procedure HistoryONMenuClick(Sender: TObject);
    procedure SettingsONMenuClick(Sender: TObject);
    procedure TrafficONMenuClick(Sender: TObject);
    procedure TopMainButtonONMenuClick(Sender: TObject);
    procedure TopOnlyOnlineONMenuClick(Sender: TObject);
    procedure TopGroupONMenuClick(Sender: TObject);
    procedure TopSoundsONMenuClick(Sender: TObject);
    procedure TopPrivatONMenuClick(Sender: TObject);
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
    procedure LogFormMenuClick(Sender: TObject);
    procedure IMaderingEventsException(Sender: TObject; E: Exception);
    procedure UniqContactSettingsMenuClick(Sender: TObject);
    procedure FloatContactMenuClick(Sender: TObject);
    procedure ProfileOpenMenuClick(Sender: TObject);
    procedure HideProfileInTrayClick(Sender: TObject);
    procedure XTrayIconClick(Sender: TObject);
    procedure CloseProgramClick(Sender: TObject);
    procedure PingICQServerClick(Sender: TObject);
    procedure JvTimerListEvents8Timer(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDblClick(Sender: TObject);
    procedure UpdateHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure TopCLSearchONMenuClick(Sender: TObject);
    procedure CLSearchONMenuClick(Sender: TObject);
    procedure TwitterHttpClientSessionClosed(Sender: TObject);
    procedure TwitterHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure TwitterToolButtonClick(Sender: TObject);
    procedure TwitterToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure PostMessageTwitterMenuClick(Sender: TObject);
    procedure TwitterSettingsMenuClick(Sender: TObject);
    procedure OpenSiteTwitterMinuClick(Sender: TObject);
    procedure OpenMyPageMenuClick(Sender: TObject);
    procedure MyLentaTwitterMenuClick(Sender: TObject);
    procedure IncMessTwitterMenuClick(Sender: TObject);
    procedure MyInfoTwitterMenuClick(Sender: TObject);
    procedure JvTimerListEvents10Timer(Sender: TObject);
    procedure MraSMSSendMenuClick(Sender: TObject);
    procedure JvTimerListEvents13Timer(Sender: TObject);
    procedure JvTimerListEvents14Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TwitterSearchMenuClick(Sender: TObject);
    procedure AllLentaTwitterMenuClick(Sender: TObject);
    procedure PostImageTwitterMenuClick(Sender: TObject);
    procedure SnapToRightClick(Sender: TObject);
    procedure JvTimerListEvents15Timer(Sender: TObject);
    procedure OpenGameMenuClick(Sender: TObject);

  private
    { Private declarations }
    ButtonInd: Integer;
    procedure LoadImageList(ImgList: TImageList; FName: string);
    procedure MainFormHideInTray;
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
    procedure Twit_Enable(OnOff: Boolean);
    procedure OpenFromTrayMessage(HUIN: string);
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
  IcqXStatusUnit,
  MraXStatusUnit,
  FirstStartUnit,
  IcqProtoUnit,
  IcqContactInfoUnit,
  MraOptionsUnit,
  JabberOptionsUnit,
  ChatUnit,
  SmilesUnit,
  IcqReqAuthUnit,
  HistoryUnit,
  CLSearchUnit,
  TrafficUnit,
  UpdateUnit,
  IcqAddContactUnit,
  JabberProtoUnit,
  MraProtoUnit,
  RosterUnit,
  IcqSearchUnit,
  IcqGroupManagerUnit,
  ShowCertUnit,
  FileTransferUnit,
  LogUnit,
  FloatingUnit,
  UniqUnit,
  ProfileUnit,
  GTransUnit,
  OverbyteIcsUrl,
  ShellApi,
  IcqEditContactUnit,
  TwitterOptionsUnit,
  SMSUnit,
  GamesUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_MainForm = 'main_form';
  C_MainFormSounds = 'sounds';
  C_MainFormOnlyOnline = 'only_online';
  C_MainFormGroups = 'groups';
  C_MainFormFirst = 'first_start';
  C_MainFormProto = 'protos';
  C_Traffic = 'traffic';
  C_MainFormHEG = 'empty_group';
  C_MainFormTP = 'top_panel';
  C_MainFormBP = 'bottom_panel';
  C_UpdateURL = 'http://imadering.googlecode.com/files/version.txt';

{$ENDREGION}
{$REGION 'WMEXITSIZEMOVE'}

procedure TMainForm.WMEXITSIZEMOVE(var message: TMessage);
begin
  if DockAppBar then
    begin
      DockAppBar := False;
      Height := NoDockHeigth;
      Width := NoDockWigth;
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
  GroupOnOffToolTopButton.Hint := GroupOnOffToolButton.Hint;
  SoundOnOffToolTopButton.Hint := SoundOnOffToolButton.Hint;
  PrivatTopToolButton.Hint := PrivatToolButton.Hint;
  HistoryTopToolButton.Hint := HistoryToolButton.Hint;
  SettingsTopToolButton.Hint := SettingsToolButton.Hint;
  TrafficTopToolButton.Hint := TrafficToolButton.Hint;
  CLSearchTopToolButton.Hint := CLSearchToolButton.Hint;
  // Применяем перевод меню
  HideProfileInTray.Caption := S_HideProfileInTray;
  HideInTray.Caption := S_HideInTray;
  HideMainInTray1.Caption := S_HideInTray;
  HideMainInTray2.Caption := S_HideInTray;
  SettingsTray1.Caption := OpenSettings.Caption;
  SettingsTray2.Caption := OpenSettings.Caption;
  CloseProgramTray1.Caption := CloseProgram.Caption;
  CloseProgramTray2.Caption := CloseProgram.Caption;
  CheckUpdateTray1.Caption := CheckUpdateMenu.Caption;
  CheckUpdateTray2.Caption := CheckUpdateMenu.Caption;
  StatusTray2.Caption := StatusTray1.Caption;
  LogFormMenu.Caption := ShowLogTray.Caption;
  TopMainButtonONMenu.Caption := MainButtonONMenu.Caption;
  TopOnlyOnlineONMenu.Caption := OnlyOnlineONMenu.Caption;
  TopGroupONMenu.Caption := GroupONMenu.Caption;
  TopSoundsONMenu.Caption := SoundsONMenu.Caption;
  TopPrivatONMenu.Caption := PrivatONMenu.Caption;
  TopHistoryONMenu.Caption := HistoryONMenu.Caption;
  TopSettingsONMenu.Caption := SettingsONMenu.Caption;
  TopTrafficONMenu.Caption := TrafficONMenu.Caption;
  SearchInCL.Caption := SearchInCLMainMenu.Caption;
  TopCLSearchONMenu.Caption := CLSearchONMenu.Caption;
  PostMessageTwitterMenu.Caption := S_PostInTwitter;
  // Применяем перевод статусов в меню
  ICQStatusFFC.Caption := S_Status1;
  ICQStatusEvil.Caption := S_Status2;
  ICQStatusDepres.Caption := S_Status3;
  ICQStatusHome.Caption := S_Status4;
  ICQStatusWork.Caption := S_Status5;
  ICQStatusLunch.Caption := S_Status6;
  ICQStatusAway.Caption := S_Status7;
  ICQStatusNA.Caption := S_Status8;
  ICQStatusOccupied.Caption := S_Status9;
  ICQStatusDND.Caption := S_Status10;
  ICQStatusOnline.Caption := S_Status11;
  ICQStatusInvisible.Caption := S_Status12;
  ICQStatusInvisibleForAll.Caption := S_Status13;
  ICQStatusOffline.Caption := S_Status14;
  //
  MRASettings.Caption := ICQSettings.Caption;
  MRAXStatus.Caption := ICQXStatus.Caption;
  MRAStatusFFC.Caption := S_Status1;
  MRAStatusAway.Caption := S_Status7;
  MRAStatusDND.Caption := S_Status10;
  MRAStatusOnline.Caption := S_Status11;
  MRAStatusInvisible.Caption := S_Status12;
  MRAStatusOffline.Caption := S_Status14;
  PingMRAServer.Caption := PingICQServer.Caption;
  UnstableMRAStatus.Caption := UnstableICQStatus.Caption;
  //
  JabberSettings.Caption := ICQSettings.Caption;
  JabberSearchNewContact.Caption := ICQSearchNewContact.Caption;
  JabberXStatus.Caption := ICQXStatus.Caption;
  JabberStatusFFC.Caption := S_Status1;
  JabberStatusEvil.Caption := S_Status2;
  JabberStatusDepression.Caption := S_Status3;
  JabberStatusHome.Caption := S_Status4;
  JabberStatusWork.Caption := S_Status5;
  JabberStatusLunch.Caption := S_Status6;
  JabberStatusAway.Caption := S_Status7;
  JabberStatusNA.Caption := S_Status8;
  JabberStatusOccupied.Caption := S_Status9;
  JabberStatusDND.Caption := S_Status10;
  JabberStatusOnline.Caption := S_Status11;
  JabberStatusInvisible.Caption := S_Status12;
  JabberStatusOffline.Caption := S_Status14;
  PingJabberServer.Caption := PingICQServer.Caption;
  UnstableJabberStatus.Caption := UnstableICQStatus.Caption;
  //
  AllStatusFFC.Caption := S_Status1;
  AllStatusEvil.Caption := S_Status2;
  AllStatusDepres.Caption := S_Status3;
  AllStatusHome.Caption := S_Status4;
  AllStatusWork.Caption := S_Status5;
  AllStatusLunch.Caption := S_Status6;
  AllStatusAway.Caption := S_Status7;
  AllStatusNA.Caption := S_Status8;
  AllStatusOccupied.Caption := S_Status9;
  AllStatusDND.Caption := S_Status10;
  AllStatusOnline.Caption := S_Status11;
  AllStatusInvisible.Caption := S_Status12;
  AllStatusOffline.Caption := S_Status14;
  //
  TwitterSettingsMenu.Caption := ICQSettings.Caption;
  OnlineTwitterMenu.Caption := S_Status11;
  OfflineTwitterMenu.Caption := S_Status14;
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
  ProgramCloseCommand := True;
  Msg.Result := 1;
end;

procedure TMainForm.XTrayIconClick(Sender: TObject);
begin
  // Сворачиваем главное окно в трэй или разворачиваем если оно уже свёрнуто
  if (Sender as TTrayIcon).Tag = 0 then
    begin
      if Assigned(ProfileForm) then
        HideProfileInTrayClick(nil);
    end;
end;

{$ENDREGION}
{$REGION 'ICQ_Enable'}

procedure TMainForm.ICQ_Enable(OnOff: Boolean);
begin
  if OnOff then
    begin
      // Инициализируем окно настроек протокола ICQ
      if not Assigned(IcqOptionsForm) then
        IcqOptionsForm := TIcqOptionsForm.Create(Self);
      // Ставим иконки в окне контактов и в трэе
      ICQTrayIcon.Visible := True;
      ICQToolButton.Visible := True;
    end
  else
    begin
      // Прячем иконки в окне контактов и в трэе
      ICQTrayIcon.Visible := False;
      ICQToolButton.Visible := False;
      // Высвобождаем окно настроек протокола ICQ
      if Assigned(IcqOptionsForm) then
        FreeAndNil(IcqOptionsForm);
      // Стираем из Ростера контакты ICQ
      if Assigned(RosterForm) then
        RosterForm.ClearICQClick(Self);
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
        MraOptionsForm := TMraOptionsForm.Create(Self);
      // Ставим иконки в окне контактов и в трэе
      MRATrayIcon.Visible := True;
      MRAToolButton.Visible := True;
    end
  else
    begin
      // Прячем иконки в окне контактов и в трэе
      MRATrayIcon.Visible := False;
      MRAToolButton.Visible := False;
      // Высвобождаем окно настроек протокола MRA
      if Assigned(MraOptionsForm) then
        FreeAndNil(MraOptionsForm);
      // Стираем из Ростера контакты MRA
      if Assigned(RosterForm) then
        RosterForm.ClearMRAClick(Self);
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

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
      DAShow(S_InfoHead, MRAAccountInfo_1, EmptyStr, 133, 3, 0);
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
  S_Log := S_Log + S_Mra + Log_Bevel + Log_Set_Status + TMenuItem(Sender).Caption + C_RN;
  // Ставим запасное значение статуса для протокола
  MRA_CurrentStatus_bac := MRA_CurrentStatus;
  // Ставим иконки статусов в окне и в трэе
  if not MRA_Offline_Phaze then
    begin
      MRATrayIcon.IconIndex := MRA_CurrentStatus;
      MRAToolButton.ImageIndex := MRA_CurrentStatus;
    end;
  // Подключаемся к MRA серверу
  if MRA_Offline_Phaze then
    begin
      S_Log := S_Log + S_Mra + Log_Bevel + Log_Login + MRA_LoginUIN + C_RN;
      // Ставим иконки подключения в окне и в трэе
      MRATrayIcon.IconIndex := 162;
      MRAToolButton.ImageIndex := 162;
      // Блокируем контролы логина и пароля ICQ
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
      // Активируем фазу коннекта к серверу ICQ
      MRA_Connect_Phaze := True;
      MRA_HTTP_Connect_Phaze := False;
      MRA_BosConnect_Phaze := False;
      MRA_Work_Phaze := False;
      MRA_Offline_Phaze := False;
      // Запускаем показ иконки коннекта MRA
      JvTimerList.Events[3].Enabled := True;
      // Устанавливаем параметры сокета
      MRAWSocket.Proto := 'tcp';
      // Устанавливаем настройки прокси
      if HttpProxy_Enable then
        begin
          MRAWSocket.Addr := HttpProxy_Address;
          MRAWSocket.Port := HttpProxy_Port;
          S_Log := S_Log + S_Mra + Log_Bevel + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port + C_RN;
        end
      else
        begin
          MRAWSocket.Addr := MRA_LoginServerAddr;
          MRAWSocket.Port := MRA_LoginServerPort;
          S_Log := S_Log + S_Mra + Log_Bevel + Log_Connect + MRA_LoginServerAddr + ':' + MRA_LoginServerPort + C_RN;
        end;
      // Прорисовываем интерфэйс
      Update;
      // Подключаем сокет
      MRAWSocket.Connect;
    end;
  // Отправляем статус
  // if MRA_Work_Phaze then ;
  // Пишем в лог
  XLog(Trim(S_Log), S_Mra);
end;

{$ENDREGION}
{$REGION 'Jab_Enable'}

procedure TMainForm.Jab_Enable(OnOff: Boolean);
begin
  if OnOff then
    begin
      // Инициализируем окно настроек протокола Jabber
      if not Assigned(JabberOptionsForm) then
        JabberOptionsForm := TJabberOptionsForm.Create(Self);
      // Ставим иконки в окне контактов и в трэе
      JabberTrayIcon.Visible := True;
      JabberToolButton.Visible := True;
    end
  else
    begin
      // Прячем иконки в окне контактов и в трэе
      JabberTrayIcon.Visible := False;
      JabberToolButton.Visible := False;
      // Высвобождаем окно настроек протокола Jabber
      if Assigned(JabberOptionsForm) then
        FreeAndNil(JabberOptionsForm);
      // Стираем из Ростера контакты Jabber
      if Assigned(RosterForm) then
        RosterForm.ClearJabberClick(Self);
    end;
end;

{$ENDREGION}
{$REGION 'Twit_Enable'}

procedure TMainForm.Twit_Enable(OnOff: Boolean);
begin
  if OnOff then
    begin
      // Инициализируем окно настроек протокола Twitter
      if not Assigned(TwitterOptionsForm) then
        TwitterOptionsForm := TTwitterOptionsForm.Create(Self);
      // Ставим иконку в окне контактов
      TwitterToolButton.Visible := True;
    end
  else
    begin
      // Прячем иконку в окне контактов
      TwitterToolButton.Visible := False;
      // Высвобождаем окно настроек протокола Twitter
      if Assigned(TwitterOptionsForm) then
        FreeAndNil(TwitterOptionsForm);
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JabberSearchNewContactClick(Sender: TObject);
begin
  ShowMessage(S_DevelMess);
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
      DAShow(S_InfoHead, JabberAccountInfo_1, EmptyStr, 133, 3, 0);
      // Открываем настройки ICQ
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
  S_Log := S_Log + S_Jabber + Log_Bevel + Log_Set_Status + TMenuItem(Sender).Caption + C_RN;
  // Ставим запасное значение статуса для протокола
  Jabber_CurrentStatus_bac := ICQ_CurrentStatus;
  // Ставим иконки статуса в окне и в трэе
  if not Jabber_Offline_Phaze then
    begin
      JabberToolButton.ImageIndex := Jabber_CurrentStatus;
      JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
    end;
  // Подключаемся к Jabber серверу
  if Jabber_Offline_Phaze then
    begin
      S_Log := S_Log + S_Jabber + Log_Bevel + Log_Login + Jabber_JID + C_RN;
      // Разбираем JID на логин и сервер
      Jabber_LoginUIN := Parse('@', Jabber_JID, 1);
      Jabber_ServerAddr := Parse('@', Jabber_JID, 2);
      // Если сервер и порт указаны вручную
      with JabberOptionsForm do
        if CustomServerCheckBox.Checked then
          begin
            Jabber_ServerAddr := CustomServerEdit.Text;
            Jabber_ServerPort := CustomPortEdit.Text;
          end;
      // Ставим иконки статуса в окне и в трэе
      JabberToolButton.ImageIndex := 162;
      JabberTrayIcon.IconIndex := 162;
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
              DeleteAccountLabel.Enabled := False;
            end;
        end;
      // Активируем фазу коннекта к серверу Jabber
      Jabber_Connect_Phaze := True;
      Jabber_HTTP_Connect_Phaze := False;
      Jabber_Work_Phaze := False;
      Jabber_Offline_Phaze := False;
      // Запускаем показ иконки коннекта Jabber
      JvTimerList.Events[3].Enabled := True;
      // Устанавливаем параметры сокета
      JabberWSocket.Proto := 'tcp';
      // Устанавливаем настройки прокси
      if HttpProxy_Enable then
        begin
          JabberWSocket.Addr := HttpProxy_Address;
          JabberWSocket.Port := HttpProxy_Port;
          S_Log := S_Log + S_Jabber + Log_Bevel + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port + C_RN;
        end
      else
        begin
          JabberWSocket.Addr := Jabber_ServerAddr;
          JabberWSocket.Port := Jabber_ServerPort;
          S_Log := S_Log + S_Jabber + Log_Bevel + Log_Connect + Jabber_ServerAddr + ':' + Jabber_ServerPort + C_RN;
        end;
      // Прорисовываем интерфэйс
      Update;
      JabberWSocket.SslEnable := False;
      // Подключаем сокет
      JabberWSocket.Connect;
    end;
  // Отсылаем пакет со статусом
  if Jabber_Work_Phaze then
    Jab_SendPkt(Jab_SetStatus(Jabber_CurrentStatus));
  // Пишем в лог
  XLog(Trim(S_Log), S_Jabber);
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
  if Assigned(RosterForm) then
    RosterForm.UpdateFullCL;
end;

procedure TMainForm.HideInTrayClick(Sender: TObject);
begin
  // Скрываем окно в трэй или наоборот
  MainFormHideInTray;
end;

procedure TMainForm.HideProfileInTrayClick(Sender: TObject);
begin
  // Показываем или сворачиваем окно профиля или главное окно
  if Assigned(ProfileForm) then
    begin
      if ProfileForm.Visible then
        begin
          ProfileForm.Hide;
          HideProfileInTray.Caption := S_RestoreProfileFromTray;
          HideProfileInTray.ImageIndex := 5;
        end
      else
        begin
          XShowForm(ProfileForm);
          HideProfileInTray.Caption := S_HideProfileInTray;
          HideProfileInTray.ImageIndex := 4;
        end;
    end;
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
{$REGION 'UpdateHttpClientDocData'}

procedure TMainForm.UpdateHttpClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  // Отображаем процесс получения данных
  if Assigned(UpdateForm) then
    begin
      with UpdateForm do
        begin
          if UpdateHttpClient.ContentLength > -1 then
            begin
              LoadSizeLabel.Caption := Format(S_DownCount, [FloatToStrF(UpdateHttpClient.RcvdCount / 1000, FfFixed, 7, 1)]);
              DownloadProgressBar.Max := UpdateHttpClient.ContentLength;
              DownloadProgressBar.Position := UpdateHttpClient.RcvdCount;
            end;
          // Обновляем форму и контролы чтобы видеть изменения
          Update;
        end;
    end;
  // Если был активирован аборт сессии, то выходим и отключаем сокет
  if UpdateHttpClient.Tag = 2 then
    begin
      UpdateHttpClient.CloseAsync;
      UpdateHttpClient.Abort;
    end;
end;

{$ENDREGION}
{$REGION 'UpdateHttpClientRequestDone'}

procedure TMainForm.UpdateHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
var
  List: TStringList;
  S, Ver, Bild, Mess: string;

procedure ShowUpdateNote;
begin
  // Если форма не существует, то создаём её
  if not Assigned(IcqReqAuthForm) then
    IcqReqAuthForm := TIcqReqAuthForm.Create(Self);
  // Делаем запрос в форме на обновление программы
  IcqReqAuthForm.UpDateVersion(Mess);
  // Отображаем окно
  XShowForm(IcqReqAuthForm);
end;

begin
  try
    // Высвобождаем память отправки данных
    if UpdateHttpClient.SendStream <> nil then
      begin
        UpdateHttpClient.SendStream.Free;
        UpdateHttpClient.SendStream := nil;
      end;
    // Читаем полученные http данные из блока памяти
    if UpdateHttpClient.RcvdStream <> nil then
      begin
        // Создаём временный лист
        List := TStringList.Create;
        try
          // Увеличиваем статистику входящего трафика
          TrafRecev := TrafRecev + UpdateHttpClient.RcvdCount;
          AllTrafRecev := AllTrafRecev + UpdateHttpClient.RcvdCount;
          if Assigned(TrafficForm) then
            OpenTrafficClick(nil);
          // Обнуляем позицию начала чтения в блоке памяти
          UpdateHttpClient.RcvdStream.Position := 0;
          // Определяем выполнение задания для данных по флагу
          case UpdateHttpClient.Tag of
            0: begin
                // Читаем данные в лист
                List.LoadFromStream(UpdateHttpClient.RcvdStream, TEncoding.UTF8);
                // Разбираем данные в листе
                if List.Text > EmptyStr then
                  begin
                    // Получаем версию и информацию сборки
                    S := IsolateTextString(List.Text, '<version>', '</version>');
                    Ver := LeftStr(S, 3);
                    Bild := RightStr(S, 3);
                    Mess := IsolateTextString(List.Text, '<info>', '</info>');
                    // Запоминаем переменную аддэйтпатч для автообновления
                    UpdateVersionPath := Format(UpdateVersionPath, [Ver, Bild]);
                    Xlog(C_RN + List.Text + C_RN + UpdateVersionPath, EmptyStr);
                    // Отображаем всплывающее окно с информацией о новой версии
                    if (Ver <> EmptyStr) and (Bild <> EmptyStr) then
                      begin
                        // Если версия на сайте выше текущей
                        if StrToInt(S) > StrToInt(ReplaceStr(FullVersion, '.', EmptyStr)) then
                          begin
                            DAShow(S_InfoHead, S_NewVerYES, EmptyStr, 133, 3, 100000000);
                            ShowUpdateNote;
                          end
                        else if not UpdateAuto then
                          DAShow(S_InfoHead, S_NewVerNO, EmptyStr, 133, 0, 0);
                      end
                    else if not UpdateAuto then
                      DAShow(S_InfoHead, S_NewVerErr, EmptyStr, 134, 2, 0);
                  end;
              end;
            1: begin
                if Assigned(UpdateForm) then
                  begin
                    with UpdateForm do
                      begin
                        // Создаём блок в памяти для приёма файла обновления
                        UpdateFile := TMemoryStream.Create;
                        try
                          // Читаем данные в память
                          UpdateFile.LoadFromStream(UpdateHttpClient.RcvdStream);
                          // Информируем о успешной закачке файла обновления
                          InfoMemo.Lines.Add(S_UpDateLoad);
                          // Сохраняем полученный файл
                          UpdateFile.SaveToFile(Profile + UpdateVersionPath);
                          // Проверяем есть ли у нас права на запись в папку с программой
                          if ForceDirectories(MyPath + C_Infos) then
                            begin
                              // Удаляем тестовую папку
                              if DirectoryExists(MyPath + C_Infos) then
                                RemoveDir(MyPath + C_Infos);
                              // Начинаем установку обновления
                              InfoMemo.Lines.Add(S_UpDateUn);
                              // Переименовываем файл Imadering.exe
                              if FileExists(MyPath + C_ExeName) then
                                RenameFile(MyPath + C_ExeName, MyPath + 'Imadering.old');
                              // Распаковываем архив
                              if UnpackArhive(Profile + UpdateVersionPath) then
                                begin
                                  InfoMemo.Lines.Add(S_UpDateOK);
                                  if FileExists(Profile + UpdateVersionPath) then
                                    DeleteFile(Profile + UpdateVersionPath);
                                end;
                            end
                          else
                            begin
                              // Сообщаем, что прав на запись обновления у нас нет
                              DAShow(S_Errorhead, S_UnPackErr, EmptyStr, 134, 2, 0);
                              // Открываем папку со скачанным архивом
                              ShellExecute(0, 'open', PChar(Profile), nil, PChar(Profile), SW_SHOW);
                            end;
                          AbortBitBtn.Enabled := False;
                        finally
                          // Уничтожаем блок памяти
                          FreeAndNil(UpdateFile);
                        end;
                      end;
                  end;
              end;
            2: begin
                // Ничего не делаем, потому что это остановка закачки обновления
              end;
            3: begin
                // Для тестов
              end;
          end;
        finally
          List.Free;
          // Высвобождаем блок памяти
          UpdateHttpClient.RcvdStream.Free;
          UpdateHttpClient.RcvdStream := nil;
        end;
      end;
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

procedure TMainForm.UpdateHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
(Sender as THttpCli)
  .RcvdStream := TMemoryStream.Create;
end;

procedure TMainForm.ICQSearchNewContactClick(Sender: TObject);
begin
  // Открываем окно поиска новых контактов
  if not Assigned(IcqSearchForm) then
    IcqSearchForm := TIcqSearchForm.Create(Self);
  // Открываем окно
  XShowForm(IcqSearchForm);
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
  XLog('ICQ | ' + Log_Set_Status + TMenuItem(Sender).Caption, C_Icq);
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
      DAShow(S_InfoHead, ICQAccountInfo_1, EmptyStr, 133, 3, 0);
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
  S_Log := S_Log + C_Icq + Log_Bevel + Log_Set_Status + TMenuItem(Sender).Caption + C_RN;
  // Ставим запасное значение статуса для протокола
  ICQ_CurrentStatus_bac := ICQ_CurrentStatus;
  // Ставим иконки статусов в окне и в трэе
  if not ICQ_Offline_Phaze then
    begin
      ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
      ICQToolButton.ImageIndex := ICQ_CurrentStatus;
    end;
  // Отключаем статус Нестабильный если он включен
  if JvTimerList.Events[4].Enabled then
    begin
      JvTimerList.Events[4].Enabled := False;
      UnstableICQStatus.Checked := False;
    end;
  // Подключаемся к ICQ серверу
  if ICQ_Offline_Phaze then
    begin
      S_Log := S_Log + C_Icq + Log_Bevel + Log_Login + ICQ_LoginUIN + C_RN;
      // Ставим иконки подключения в окне и в трэе
      ICQTrayIcon.IconIndex := 162;
      ICQToolButton.ImageIndex := 162;
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
      // Запускаем показ иконки коннекта ICQ
      JvTimerList.Events[3].Enabled := True;
      // Устанавливаем параметры сокета
      ICQWSocket.Proto := 'tcp';
      // Устанавливаем настройки прокси
      if HttpProxy_Enable then
        begin
          ICQWSocket.Addr := HttpProxy_Address;
          ICQWSocket.Port := HttpProxy_Port;
          S_Log := S_Log + C_Icq + Log_Bevel + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port + C_RN;
        end
      else
        begin
          ICQWSocket.Addr := ICQ_LoginServerAddr;
          ICQWSocket.Port := ICQ_LoginServerPort;
          S_Log := S_Log + C_Icq + Log_Bevel + Log_Connect + ICQ_LoginServerAddr + ':' + ICQ_LoginServerPort + C_RN;
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
  XLog(Trim(S_Log), C_Icq);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.ICQToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup(ICQToolButton, ICQPopupMenu);
end;

procedure TMainForm.ICQToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  Popup(ICQToolButton, RightICQPopupMenu);
end;

procedure TMainForm.MainButtonONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку главного меню на нижней панели
  MainButtonONMenu.Checked := not MainButtonONMenu.Checked;
  MainToolButton.Visible := not MainToolButton.Visible;
end;

procedure TMainForm.ICQTrayIconClick(Sender: TObject);
begin
  // Сворачиваем главное окно в трэй или разворачиваем если оно уже свёрнуто
  if (Sender as TTrayIcon).Tag = 0 then
    MainFormHideInTray
  else
    OpenFromTrayMessage(EmptyStr);
end;

procedure TMainForm.ICQTrayIconMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Определяем какой протокол вызвал меню в трэе
  if Button = MbRight then
    TrayProtoClickMenu := LowerCase((Sender as TTrayIcon).name)
    // Выводим список контактов на передний план если нажали средней клавишей мыши
  else if Button = MbMiddle then
    SetForeGroundWindow(Handle);
end;

{$ENDREGION}
{$REGION 'MainFormHideInTray'}

procedure TMainForm.MainFormHideInTray;
begin
  // Показываем или сворачиваем главное окно
  if Visible then
    begin
      Hide;
      HideMainInTray1.Caption := S_RestoreFromTray;
      HideMainInTray1.ImageIndex := 5;
      // Удаляем AppBar если он есть
      if DockAppBar then
        AppBarDestroy;
    end
  else
    begin
      // Если был режим AppBar, то восстанавливаем его
      if DockAppBar then
        begin
          if DockRigth then
            SnapToRightClick(SnapToRight)
          else
            SnapToRightClick(SnapToLeft);
        end;
      // Отображем окно контактов
      Show;
      SetForeGroundWindow(Application.MainForm.Handle);
      HideMainInTray1.Caption := S_HideInTray;
      HideMainInTray1.ImageIndex := 4;
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
  if InMessList.Count = 0 then
    begin
      ICQTrayIcon.Tag := 0;
      MRATrayIcon.Tag := 0;
      JabberTrayIcon.Tag := 0;
      Exit;
    end;
  // Получаем учётную запись отправителя сообщения с самого низа списка
  MUIN := InMessList.Strings[InMessList.Count - 1];
  // Если она вдруг пустая, то выходим
  if MUIN = EmptyStr then
    Exit;
X :;
  // Открываем чат с этим контактом
  RosterForm.OpenChatPage(nil, MUIN);
end;

{$ENDREGION}
{$REGION 'ICQWSocketDataAvailable'}

procedure TMainForm.ICQWSocketDataAvailable(Sender: TObject; ErrCode: Word);
label
  X,
  Z;
var
  Pkt, HexPkt, TLV: string;
  Len, ProxyErr, PktSize: Integer;
begin
  try
    // Получаем пришедшие от сервера данные с сокета
    Pkt := ICQWSocket.ReceiveStr;
    // Если при получении данных возникла ошибка, то сообщаем об этом
    if ErrCode <> 0 then
      begin
        DAShow(S_Errorhead, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
        // Активируем режим оффлайн
        ICQ_GoOffline;
        Exit;
      end;
    // HTTP прокси коннект
    if (HttpProxy_Enable) and ((ICQ_Connect_Phaze) or (ICQ_BosConnect_Phaze)) and (not ICQ_HTTP_Connect_Phaze) then
      begin
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
        if StartsStr('HTTPS/1.0 200', Pkt) or StartsStr('HTTPS/1.1 200', Pkt) or StartsStr('HTTP/1.0 200', Pkt) or StartsStr('HTTP/1.1 200', Pkt) then
          begin
            ICQ_HTTP_Connect_Phaze := True;
            XLog(C_Icq + Log_Get + Log_Proxy_OK, C_Icq);
          end
        else
        // Сообщаем об ошибках прокси
          if StartsStr('HTTP/1.0 407', Pkt) then
          begin
            ProxyErr := 1;
            DAShow(S_Errorhead, ProxyConnectErrL1 + C_RN + '[ ' + SocketL + C_BN + C_Icq + ' ]', EmptyStr, 134, 2, 0);
          end
        else
          begin
            ProxyErr := 2;
            DAShow(S_Errorhead, ProxyConnectErrL2 + C_RN + '[ ' + SocketL + C_BN + C_Icq + ' ]', EmptyStr, 134, 2, 0);
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
    TrafRecev := TrafRecev + Length(Pkt);
    AllTrafRecev := AllTrafRecev + Length(Pkt);
    if Assigned(TrafficForm) then
      OpenTrafficClick(nil);
    // Прибавляем данные к специальному буферу накопления таких преобразованных данных
    ICQ_BuffPkt := ICQ_BuffPkt + Pkt;
    // Ищем ошибки в буфере пакетов
    if ((ICQ_BuffPkt > EmptyStr) and (ICQ_BuffPkt[1] <> #$2A)) or ((Length(ICQ_BuffPkt) > 2) and ((ICQ_BuffPkt[2] = #$00) or (ICQ_BuffPkt[2] > #$05))) then
      begin
        // Если в пакете есть ошибки, то активируем оффлайн и выводим сообщение об ошибке
        DAShow(S_Errorhead, ParsingPktError + C_RN + '[ ' + SocketL + C_BN + C_Icq + ' ]', EmptyStr, 134, 2, 0);
        ICQ_GoOffline;
        Exit;
      end;
    // Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
    // для проверки этих данные на наличие слудующего целого пакета данных
  X :;
    PktSize := ICQ_BodySize(ICQ_BuffPkt);
    // Проверяем если ли в буфере хоть один целый пакет
    if (Length(ICQ_BuffPkt) >= ICQ_FLAP_HEAD_SIZE) and (Length(ICQ_BuffPkt) >= ICQ_FLAP_HEAD_SIZE + PktSize) or ((ICQ_BuffPkt[2] = #$04) and (PktSize = 0)) then
      begin
        // Забираем из буфера один целый пакет
        HexPkt := NextData(ICQ_BuffPkt, ICQ_FLAP_HEAD_SIZE + PktSize);
        // Пишем в лог данные пакета
        XLog(C_Icq + Log_Get + C_RN + Trim(Dump(HexPkt)), C_Icq);
        // Разбираем пакет данных если его длинна больше нуля
        if Length(HexPkt) > 0 then
          begin
            // Ещё раз делаем проверку на начало пакета ICQ протокола по метке $2A
            if NextData(HexPkt, 1) = #$2A then
              begin
                // Смотрим какой канал у пакета
                case HexToInt(Text2Hex(NextData(HexPkt, 1))) of
                  $01: begin
                      XLog(C_Icq + Log_Get + Log_Server_Hello, C_Icq);
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
                  $02: begin
                      // Пропускаем Seq (счётчик) и длинну пакета
                      NextData(HexPkt, 4);
                      // Смотрим какая фэмили у пакета
                      case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                        $0001: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $0003: begin
                                  if ICQ_BosConnect_Phaze then
                                    begin
                                      // Очищаем группы ICQ в Ростере
                                      RosterForm.ClearContacts(C_Icq);
                                      // Пока думаем, что у нас новый (обсолютно чистый) список контактов
                                      NewKL := True;
                                      ICQ_CL_Count := 0;
                                      // Отсылаем серверу пакет с допустимыми для нас фэмили
                                      ICQ_SendPkt('2', ICQ_CliFamilyPkt);
                                    end;
                                end;
                              $0005: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с адресом сервера icq аватар
                                  // ICQ_Parse_0105(HexPkt);
                                end;
                              $0013: begin
                                  // Если фаза подключения уже к основному серверу
                                  if ICQ_BosConnect_Phaze then
                                    begin
                                      // Отсылаем стандартные пакеты данных для окончательной авторизации
                                      ICQ_SendPkt('2', '00010008000000000008' + '00010002000300040005');
                                      ICQ_SendPkt('2', '0001000E00000000000E');
                                      ICQ_SendPkt('2', '00130002000000000002' + '000b0002000F');
                                      ICQ_SendPkt('2', '001300050000344A0005' + '4A32107F003D');
                                      ICQ_SendPkt('2', '00020002000000000002');
                                      ICQ_SendPkt('2', '00030002000000000002' + '000500020003');
                                      ICQ_SendPkt('2', '00040004000000000004');
                                      ICQ_SendPkt('2', '00090002000000000002');
                                    end;
                                end;
                              $0015: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с "добрыми" ссылками
                                  while Length(HexPkt) > 0 do
                                    begin
                                      TLV := Text2Hex(NextData(HexPkt, 2)); // Пропускаем TLV
                                      Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                      XLog(C_Icq + Log_Parsing + Log_Unk_Data + C_RN + 'TLV: ' + TLV + ' Value: ' + NextData(HexPkt, Len), C_Icq);
                                    end;
                                end;
                              $000F: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с онлайн инфой о нашем подключении и аккаунте
                                  ICQ_Parse_010F(HexPkt);
                                end;
                              $0021: begin
                                  // Пропускаем раздел флагов
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
                                      XLog(C_Icq + Log_Parsing + Log_Icon_Hash + C_RN + ICQ_MyIcon_Hash, C_Icq);
                                    end;
                                end;
                            end;
                          end;
                        $0002: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $0006: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с онлайн инфой о контакте
                                  ICQ_UserOnline_030B(HexPkt, True);
                                end;
                            end;
                          end;
                        $0004: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $0007: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с сообщением от контакта
                                  ICQ_ReqMessage_0407(HexPkt);
                                end;
                              $0014: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с нотификацией о наборе сообщения контактом
                                  ICQ_UserSentTyping_0414(HexPkt);
                                end;
                              $000C: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с сообщением о принятии нашего сообщения сервером
                                  ICQ_SRV_MSGACK_ADVANCED(HexPkt, False);
                                end;
                              $000B: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с сообщением о принятии нашего сообщения контактом
                                  ICQ_SRV_MSGACK_ADVANCED(HexPkt, True);
                                end;
                            end;
                          end;
                        $0003: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $000A: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с неизвестным статусом контакта
                                  ICQ_UserUnkStatus_030A(HexPkt);
                                end;
                              $000B: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с онлайн инфой о контакте
                                  ICQ_UserOnline_030B(HexPkt, False);
                                end;
                              $000C: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет с оффлайн инфой о контакте
                                  ICQ_UserOffline_030C(HexPkt);
                                end;
                            end;
                          end;
                        $0013: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $0001: begin
                                  // Если фаза добавления контакта
                                  if ICQ_Add_Contact_Phaze then
                                    begin
                                      // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                                      ICQ_AddEnd;
                                      ICQ_Add_Contact_Phaze := False;
                                      ICQ_SSI_Phaze := False;
                                      DAShow(S_Errorhead, AddContactError, EmptyStr, 134, 2, 0);
                                    end
                                  else
                                  // Если фаза добавления группы
                                    if ICQ_Add_Group_Phaze then
                                    begin
                                      // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                                      ICQ_AddEnd;
                                      ICQ_Add_Group_Phaze := False;
                                      ICQ_SSI_Phaze := False;
                                      DAShow(S_Errorhead, AddGroupError, EmptyStr, 134, 2, 0);
                                    end
                                  else
                                  // Если фаза удаления группы
                                    if ICQ_Group_Delete_Phaze then
                                    begin
                                      // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                                      ICQ_AddEnd;
                                      ICQ_Group_Delete_Phaze := False;
                                      ICQ_SSI_Phaze := False;
                                      DAShow(S_Errorhead, DelGroupError, EmptyStr, 134, 2, 0);
                                    end;
                                end;
                              $0006: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет со списком контактов
                                  XLog(C_Icq + Log_Get + Log_Get_CL, C_Icq);
                                  if ICQ_Parse_1306(HexPkt) then
                                    begin
                                      // Запрашиваем нашу инфу обязательно!
                                      ICQ_ReqInfo_New_Pkt(ICQ_LoginUIN);
                                      // Отсылаем подтверждение получения пакета с контактами
                                      ICQ_SendPkt('2', '00130007000000000007');
                                      // Отсылаем первоначальную онлайн инфу
                                      ICQ_SendPkt('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr));
                                      // Отсылаем параметры ограничений
                                      ICQ_SendPkt('2', ICQ_CliSetICBMparametersPkt);
                                      // Отсылаем первый пакет со статусом
                                      ICQ_SendPkt('2', ICQ_CliSetFirstStatusPkt);
                                      // Отсылаем стандартные параметры клиента
                                      ICQ_SendPkt('2', ICQ_CliClientReadyPkt);
                                      // Отсылаем возможность приёма сообщений от AIM
                                      ICQ_SendPkt('2', '00040010000000040010');
                                      // Отсылаем короткий статус
                                      ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
                                      // Если ещё есть доп. статус то отсылаем пакеты установки правильного доп. статуса как в ICQ 6
                                      if ICQ_X_CurrentStatus > 0 then
                                        begin
                                          ICQ_SendPkt('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr, EmptyStr, EmptyStr));
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
                                    end;
                                end;
                              $000E: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Разбираем пакет подтверждения операций со списком контактов
                                  // ICQ_Parse_130E_UpdateAck(HexPkt);
                                end;
                            end;
                          end;
                        $0015: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $0003: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Пропускаем данные о размере пакета и UIN получателя
                                  NextData(HexPkt, 10);
                                  case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                                    $DA07: begin
                                        // Пропускаем ещё данные о счётчике
                                        NextData(HexPkt, 2);
                                        // Разбираем пакет с инфой для данного UIN (и другие сервисные пакеты)
                                        ICQ_Parse_SNAC_1503(HexPkt);
                                      end;
                                  end;
                                end;
                            end;
                          end;
                        $0017: begin
                            // Смотрим какая субфэмили у пакета
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $0007: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Узнаём длинну пакета и увеличиваем её в двое для HEX формата
                                  Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                  // Отсылаем логин в формате MD5 шифрования
                                  ICQ_SendPkt('2', ICQ_MD5CliLoginPkt(ICQ_LoginPassword, NextData(HexPkt, Len)));
                                end;
                              $0003: begin
                                  // Пропускаем раздел флагов
                                  NextData(HexPkt, 6);
                                  // Сканируем пакет на наличие нужных нам TLV
                                  while Length(HexPkt) > 0 do
                                    begin
                                      TLV := Text2Hex(NextData(HexPkt, 2));
                                      case HexToInt(TLV) of
                                        $0008: begin // TLV с ошибкой авторизации
                                            Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                            DAShow(S_Errorhead, ICQ_NotifyAuthCookieError(Text2Hex(NextData(HexPkt, Len))), EmptyStr, 134, 2, 0);
                                            ICQ_GoOffline;
                                          end;
                                        $0005: begin // TLV с адресом для коннекта к основному серверу
                                            Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                            ICQ_Bos_Addr := NextData(HexPkt, Len);
                                            XLog(C_Icq + Log_Parsing + Log_Get_Server + ICQ_Bos_Addr, C_Icq);
                                            ICQ_Bos_IP := Parse(':', ICQ_Bos_Addr, 1);
                                            ICQ_Bos_Port := Parse(':', ICQ_Bos_Addr, 2);
                                          end;
                                        $0006: begin // TLV с куком для коннекта к основному серверу
                                            Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                            ICQ_Bos_Cookie := Text2Hex(NextData(HexPkt, Len));
                                            XLog(C_Icq + Log_Parsing + 'Cookie', C_Icq);
                                          end
                                        else // Если пакет содержит другие TLV, то пропускаем их
                                          begin
                                            Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                            XLog(C_Icq + Log_Parsing + Log_Unk_Data + C_RN + 'TLV: ' + TLV + ' Value: ' + Trim(Dump(NextData(HexPkt, Len))), C_Icq);
                                          end;
                                      end;
                                    end;
                                end;
                            end;
                          end;
                      end;
                    end;
                  $04: begin
                      // Если длинна пакета ноль, то завершаем связь с сервером
                      if PktSize = 0 then
                        begin
                          XLog(C_Icq + Log_Get + Log_Close_Server, C_Icq);
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
                              if HttpProxy_Enable then
                                begin
                                  ICQWSocket.Addr := HttpProxy_Address;
                                  ICQWSocket.Port := HttpProxy_Port;
                                  XLog('ICQ | ' + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port, C_Icq);
                                end
                              else
                                begin
                                  ICQWSocket.Addr := ICQ_Bos_IP;
                                  ICQWSocket.Port := ICQ_Bos_Port;
                                  XLog(C_Icq + Log_Bevel + Log_Connect + ICQ_Bos_IP + ':' + ICQ_Bos_Port, C_Icq);
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
                                DAShow(S_Errorhead, ICQxUIN, EmptyStr, 134, 2, 100000000);
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
                DAShow(S_Errorhead, ParsingPktError + C_RN + '[ ' + SocketL + C_BN + C_Icq + ' ]', EmptyStr, 134, 2, 0);
                ICQ_GoOffline;
                Exit;
              end;
          end;
        // Если в конце разбора пакета у нас ещё остались данные, то возвращаемся для проверки буфера
      Z :;
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
  TrafSend := TrafSend + BytesSent;
  AllTrafSend := AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then
    OpenTrafficClick(nil);
end;

procedure TMainForm.ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      ICQ_GoOffline;
    end;
end;

procedure TMainForm.ICQWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if (not ICQ_Connect_Phaze) and (not ICQ_Offline_Phaze) then
    begin
      DAShow(S_Errorhead, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
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
      DAShow(S_Errorhead, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      ICQ_GoOffline;
    end;
  // HTTP прокси коннект
  if HttpProxy_Enable then
    begin
      // Составляем адрес
      if ICQ_Connect_Phaze then
        Http_data := ICQ_LoginServerAddr + ':' + ICQ_LoginServerPort
      else
        Http_data := ICQ_Bos_IP + ':' + ICQ_Bos_Port;
      // Если авторизация на прокси
      if HttpProxy_Auth then
        begin
          Http_login := Base64Encode(HttpProxy_Login + ':' + HttpProxy_Password);
          Http_login := 'Authorization: Basic ' + Http_login + C_RN + 'Proxy-authorization: Basic ' + Http_login + C_RN;
        end;
      // Формируем основной запрос для http прокси
      Http_data := 'CONNECT ' + Http_data + ' HTTP/1.0' + C_RN + 'User-agent: Mozilla/4.08 [en] (WinNT; U)' + C_RN + Http_login + C_RN;
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
      DAShow(S_Errorhead, NotifyConnectError(C_Icq, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      ICQ_GoOffline;
    end;
end;

procedure TMainForm.ICQWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(S_Errorhead, SocketConnErrorInfo_1 + C_RN + Msg + C_RN + Format(HttpSocketErrCodeL, [Error]) + C_RN + '[ ' + SocketL + C_BN + C_Icq + ' ]', EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      ICQ_GoOffline;
    end;
end;

procedure TMainForm.ICQXStatusClick(Sender: TObject);
begin
  // Открываем окно выбора дополнительного статуса
  if not Assigned(IcqXStatusForm) then
    IcqXStatusForm := TIcqXStatusForm.Create(Self);
  // Отображаем окнов рабочей области
  FormShowInWorkArea(IcqXStatusForm);
end;

procedure TMainForm.IMaderingEventsException(Sender: TObject; E: Exception);
begin
  // Перехватываем глобально все ошибки в программе и выводим их в лог
  if Assigned(LogForm) then
    begin
      XShowForm(LogForm);
      LogForm.LogMemo.Lines.Add(DateTimeToStr(Now) + ': ' + Log_Exception1);
      JclLastExceptStackListToStrings(LogForm.LogMemo.Lines, False, False, False, False);
      LogForm.LogMemo.Lines.Add(Log_Exception2);
      LogForm.LogMemo.Lines.Add('-----------------------------------------------------------');
    end;
end;

procedure TMainForm.JabberToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup(JabberToolButton, JabberPopupMenu);
end;

procedure TMainForm.JabberToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  Popup(JabberToolButton, RightJabberPopupMenu);
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
  PktZ: RawByteString;
  Pkt, Challenge: string;
  ProxyErr, I, CntPkt: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  try
    // Получаем пришедшие от сервера данные с сокета
    PktZ := JabberWSocket.ReceiveStr;
    // Указываем кодовую страницу UTF-8 для полученных данных
    SetCodePage(PktZ, CP_UTF8, False);
    Pkt := PktZ;
    // Если при получении данных возникла ошибка, то сообщаем об этом
    if ErrCode <> 0 then
      begin
        DAShow(S_Errorhead, NotifyConnectError(S_Jabber, ErrCode), EmptyStr, 134, 2, 0);
        // Активируем режим оффлайн
        Jab_GoOffline;
        Exit;
      end;
    // HTTP прокси коннект
    if (HttpProxy_Enable) and (Jabber_Connect_Phaze) and (not Jabber_HTTP_Connect_Phaze) then
      begin
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
        if StartsStr('HTTPS/1.0 200', Pkt) or StartsStr('HTTPS/1.1 200', Pkt) or StartsStr('HTTP/1.0 200', Pkt) or StartsStr('HTTP/1.1 200', Pkt) then
          begin
            Jabber_HTTP_Connect_Phaze := True;
            XLog(S_Jabber + Log_Get + Log_Proxy_OK, S_Jabber);
          end
        else
        // Сообщаем об ошибках прокси
          if StartsStr('HTTP/1.0 407', Pkt) then
          begin
            ProxyErr := 1;
            DAShow(S_Errorhead, ProxyConnectErrL1 + C_RN + '[ ' + SocketL + C_BN + S_Jabber + ' ]', EmptyStr, 134, 2, 0);
          end
        else
          begin
            ProxyErr := 2;
            DAShow(S_Errorhead, ProxyConnectErrL2 + C_RN + '[ ' + SocketL + C_BN + S_Jabber + ' ]', EmptyStr, 134, 2, 0);
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
    TrafRecev := TrafRecev + Length(Pkt);
    AllTrafRecev := AllTrafRecev + Length(Pkt);
    if Assigned(TrafficForm) then
      OpenTrafficClick(nil);
    // Проверяем пакет окончания сессии
    if Pkt = ('</' + J_RootTag + '>') then
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
              Pkt := '<xml>' + Pkt + '</xml>';
              // Инициализируем XML
              JvXML_Create(JvXML);
              try
                with JvXML do
                  begin
                    // Загружаем пакет в объект xml
                    JvXML_LoadStr(JvXML, Pkt);
                    // Пишем в лог данные пакета
                    XLog(S_Jabber + Log_Get + C_RN + Trim(Copy(XMLData, 4, Length(XMLData))), S_Jabber);
                    // Если это стадия подключения к серверу жаббер
                    if Jabber_Connect_Phaze then
                      begin
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
                              Jab_SendPkt(Jab_DigestMD5_Auth(Jabber_LoginUIN, Jabber_ServerAddr, Jabber_LoginPassword, Challenge, GetRandomHexBytes(32)));
                          end
                        else if Pos('<not-authorized', Pkt) > 0 then
                          begin
                            // Отображаем сообщение, что авторизация не пройдена и закрываем сеанс
                            DAShow(S_Errorhead, JabberLoginErrorL, EmptyStr, 134, 2, 0);
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
                            RosterForm.ClearContacts(S_Jabber);
                            // Закрепляем сессию с жаббер сервером
                            // Если сервер и порт указаны вручную
                            if JabberOptionsForm.CustomServerCheckBox.Checked then
                              Jab_SendPkt(Format(J_StreamHead, [Parse('@', Jabber_JID, 2), CurrentLang]))
                            else
                              Jab_SendPkt(Format(J_StreamHead, [Jabber_ServerAddr, CurrentLang]));
                            // Выходим
                            Exit;
                          end;
                      end
                      // Разбираем пакеты рабочей фазы jabber
                    else if Jabber_Work_Phaze then
                      begin
                        // Начинаем разбор данных пакета
                        if Root <> nil then
                          begin
                            // Начинаем пробег по возможным склеенным пакетам
                            CntPkt := Root.Items.Count;
                            for I := 0 to CntPkt - 1 do
                              begin
                                XML_Node := Root.Items[I];
                                if XML_Node <> nil then
                                  begin
                                    if XML_Node.FullName = J_Features then
                                      Jab_ParseFeatures(XML_Node.SaveToString)
                                    else if XML_Node.FullName = J_Iq then
                                      Jab_ParseIQ(XML_Node.SaveToString)
                                    else if XML_Node.FullName = J_Presence then
                                      Jab_ParsePresence(XML_Node.SaveToString)
                                    else if XML_Node.FullName = J_Message then
                                      Jab_ParseMessage(XML_Node.SaveToString);
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
  DAShow(S_Errorhead, NotifyConnectError(S_Jabber, WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  Jab_GoOffline;
end;

procedure TMainForm.JabberWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + BytesSent;
  AllTrafSend := AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then
    OpenTrafficClick(nil);
end;

procedure TMainForm.JabberWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError(S_Jabber, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      Jab_GoOffline;
    end;
end;

procedure TMainForm.JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if not Jabber_Offline_Phaze then
    begin
      DAShow(S_Errorhead, NotifyConnectError(S_Jabber, ErrCode), EmptyStr, 134, 2, 0);
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
      DAShow(S_Errorhead, NotifyConnectError(S_Jabber, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      Jab_GoOffline;
    end;
  // HTTP прокси коннект
  if HttpProxy_Enable then
    begin
      // Составляем адрес
      if Jabber_Connect_Phaze then
        Http_data := Jabber_ServerAddr + ':' + Jabber_ServerPort;
      // Если авторизация на прокси
      if HttpProxy_Auth then
        begin
          Http_login := Base64Encode(HttpProxy_Login + ':' + HttpProxy_Password);
          Http_login := 'Authorization: Basic ' + Http_login + C_RN + 'Proxy-authorization: Basic ' + Http_login + C_RN;
        end;
      // Формируем основной запрос для http прокси
      Http_data := 'CONNECT ' + Http_data + ' HTTP/1.0' + C_RN + 'User-agent: Mozilla/4.08 [en] (WinNT; U)' + C_RN + Http_login + C_RN;
      // Отсылаем запрос для прокси
      JabberWSocket.SendStr(Http_data);
    end;
  // Если активно SSL
  JabberWSocket.SslEnable := Jabber_UseSSL;
  // Отсылаем строку начала сессии с сервером
  // Если сервер и порт указаны вручную
  if JabberOptionsForm.CustomServerCheckBox.Checked then
    Jab_SendPkt(Format(J_StreamHead, [Parse('@', Jabber_JID, 2), CurrentLang]))
  else
    Jab_SendPkt(Format(J_StreamHead, [Jabber_ServerAddr, CurrentLang]));
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError(S_Jabber, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      Jab_GoOffline;
    end;
end;

procedure TMainForm.JabberWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(S_Errorhead, SocketConnErrorInfo_1 + C_RN + Msg + C_RN + Format(HttpSocketErrCodeL, [Error]) + C_RN + '[ ' + SocketL + C_BN + S_Jabber + ' ]', EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      Jab_GoOffline;
    end;
end;

procedure TMainForm.JabberXStatusClick(Sender: TObject);
begin
  // Открываем окно выбора дополнительного статуса
  if not Assigned(IcqXStatusForm) then
    IcqXStatusForm := TIcqXStatusForm.Create(Self);
  // Отображаем окнов рабочей области
  FormShowInWorkArea(IcqXStatusForm);
end;

{$ENDREGION}
{$REGION 'JabberWSocketSslVerifyPeer'}

procedure TMainForm.JabberWSocketSslVerifyPeer(Sender: TObject; var Ok: Integer; Cert: TX509Base);
{ var
  FrmShowCert: TShowCertForm; }
begin
  { // Показываем форму принятия сертификата
    FrmShowCert := TShowCertForm.Create(Cert);
    try
    // Вдруг, уже принимали этот сертификат
    if not FrmShowCert.CheckAccepted(EncodeString(Cert.Sha1Hash)) then
    begin
    // Показываем диалог
    FrmShowCert.ShowModal;
    Ok := Integer(FrmShowCert.CertAccepted);
    end
    else
    Ok := Integer(True);
    finally
    FreeAndNil(FrmShowCert);
    end; }
end;

{$ENDREGION}
{$REGION 'Show Profile Form Timer'}
{$HINTS OFF}

procedure TMainForm.JvTimerListEvents0Timer(Sender: TObject);
var
  HMutex: THandle;

procedure ShowAllTrayIcon;
begin
  // Подгружаем иконку программы в трэй
  AllImageList.GetIcon(0, XTrayIcon.Icon);
  XTrayIcon.Visible := True;
end;

begin
  // Создаём и отображаем окно выбора профиля пользователя
  ProfileForm := TProfileForm.Create(Self);
  // Отображаем окно выбора профиля или входим в профиль автоматически
  // Проверяем не запущена ли уже программа
  HMutex := CreateMutex(nil, True, 'IMadering client');
  if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      ShowAllTrayIcon;
      XShowForm(ProfileForm);
    end
  else if ProfileForm.AutoSignCheckBox.Checked then
    ProfileForm.LoginButton.Click
  else
    begin
      ShowAllTrayIcon;
      XShowForm(ProfileForm);
    end;
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
  if Assigned(RosterForm) then
    RosterForm.UpdateFullCL;
end;

procedure TMainForm.JvTimerListEvents12Timer(Sender: TObject);
begin
  // Перерисовываем иконки в трэе против глюка в вайн в линукс
  if ICQTrayIcon.Visible then
    ICQTrayIcon.Refresh;
  //
  if MRATrayIcon.Visible then
    MRATrayIcon.Refresh;
  //
  if JabberTrayIcon.Visible then
    JabberTrayIcon.Refresh;
  //
  if XTrayIcon.Visible then
    XTrayIcon.Refresh;
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
  MoveWindow(AppBarDataCL.HWnd, AppBarDataCL.Rc.Left, AppBarDataCL.Rc.Top, AppBarDataCL.Rc.Right - AppBarDataCL.Rc.Left, AppBarDataCL.Rc.Bottom - AppBarDataCL.Rc.Top, TRUE);
  if not Visible then
    XShowForm(MainForm);
end;

{$ENDREGION}
{$REGION 'Message Icon Timer'}

procedure TMainForm.JvTimerListEvents1Timer(Sender: TObject);
var
  I, T: Integer;
  YesMsgICQ, YesMsgJabber, YesMsgMRA: Boolean;
  CLItem: TButtonItem;
  ChatItem: TToolButton;
begin
  // Отображаем иконки мигающих сообщений и события
  YesMsgICQ := False;
  YesMsgJabber := False;
  YesMsgMRA := False;
  // Сканируем и управляем иконками контактов с флагами сообщений в КЛ
  if Assigned(RosterForm) then
    begin
      with RosterForm.RosterJvListView do
        begin
          for I := 0 to Items.Count - 1 do
            begin
              // Ищем такую запись в КЛ
              CLItem := RosterForm.ReqCLContact(Items[I].Caption);
              // Ищем такую запись в чате
              ChatItem := RosterForm.ReqChatPage(Items[I].Caption);
              // Отображаем мигающие иконки сообщений
              if Items[I].SubItems[36] <> EmptyStr then
                begin
                  // Сбрасываем переменные событий
                  Items[I].SubItems[18] := '0';
                  Items[I].SubItems[19] := '0';
                  Items[I].SubItems[35] := '0';
                  // Отображаем иконку сообщения в КЛ
                  if CLItem <> nil then
                    begin
                      // Если иконка сообщения уже отображается, то меняем её на статус,
                      // если наоборот, то на иконку сообщения
                      if CLItem.ImageIndex = 165 then
                        CLItem.ImageIndex := CLItem.Status
                      else
                        CLItem.ImageIndex := 165;
                      // Если группа этого контакта свёрнута, то мигаем заголовком группы
                      if CLItem.Category.Collapsed then
                        begin
                          if CLItem.Category.TextColor = ClBlack then
                            CLItem.Category.TextColor := ClRed
                          else
                            CLItem.Category.TextColor := ClBlack;
                        end
                      else
                        CLItem.Category.TextColor := ClBlack;
                    end;
                  // Отображаем иконку сообщения в чате
                  if ChatItem <> nil then
                    begin
                      if ChatItem.ImageIndex = 165 then
                        ChatItem.ImageIndex := ChatItem.Tag
                      else
                        ChatItem.ImageIndex := 165;
                      // Если окно чата не активно, то мигаем его кнопкой на панели задач
                      if not ChatForm.Active then
                        FormFlash(ChatForm.Handle);
                    end;
                  // Ставим флажки непрочитанных сообщений по протоколам
                  if Items[I].SubItems[3] = C_Icq then
                    YesMsgICQ := True;
                  if Items[I].SubItems[3] = S_Jabber then
                    YesMsgJabber := True;
                  if Items[I].SubItems[3] = S_Mra then
                    YesMsgMRA := True;
                end
              else
              // Если таймер задержки Ростера активен, то игнорируем события статусов
                if not JvTimerList.Events[11].Enabled then
                begin
                  // Если контакт вышел в онлайн, то отображаем это иконкой двери
                  if Items[I].SubItems[18] <> '0' then
                    begin
                      T := StrToInt(Items[I].SubItems[18]);
                      Dec(T);
                      Items[I].SubItems[18] := IntToStr(T);
                      // Отображаем иконку двери в КЛ
                      if CLItem <> nil then
                        CLItem.ImageIndex := 228;
                      // Отображаем иконку двери в чате
                      if ChatItem <> nil then
                        ChatItem.ImageIndex := 228;
                    end
                    // Если контакт вышел в оффлайн, то отображаем это иконкой двери
                  else if Items[I].SubItems[19] <> '0' then
                    begin
                      T := StrToInt(Items[I].SubItems[19]);
                      Dec(T);
                      Items[I].SubItems[19] := IntToStr(T);
                      // Отображаем иконку двери в КЛ
                      if CLItem <> nil then
                        CLItem.ImageIndex := 229;
                      // Отображаем иконку двери в чате
                      if ChatItem <> nil then
                        ChatItem.ImageIndex := 229;
                    end
                    // Если контакт печатает нам сообщение и время печати меньше отбоя печати
                  else if Items[I].SubItems[35] <> '0' then
                    begin
                      // Уменьшаем значение индикации времени набора сообщения
                      T := StrToInt(Items[I].SubItems[35]);
                      Dec(T);
                      Items[I].SubItems[35] := IntToStr(T);
                      // Отображаем иконку печати сообщения в КЛ
                      if CLItem <> nil then
                        CLItem.ImageIndex := 161;
                      // Отображаем иконку печати сообщения в чате
                      if ChatItem <> nil then
                        begin
                          // Если активная вкладка совпадает с UIN
                          with ChatForm do
                            begin
                              if ChatItem.HelpKeyword = InfoPanel2.Caption then
                                begin
                                  ChatItem.ImageIndex := StrToInt(Items[I].SubItems[6]);
                                  // Ставим сообщение о наборе текста
                                  NotifyPanel.Font.Color := ClBlue;
                                  NotifyPanel.Caption := TypingTextL;
                                end
                              else
                                begin
                                  ChatItem.ImageIndex := 161;
                                  // Убираем сообщение о наборе текста
                                  NotifyPanel.Font.Color := ClWindowText;
                                  NotifyPanel.Caption := '...';
                                end;
                            end;
                        end;
                    end
                  else
                    begin
                      // Отображаем иконку статуса в КЛ
                      if CLItem <> nil then
                        begin
                          CLItem.Status := StrToInt(Items[I].SubItems[6]);
                          CLItem.ImageIndex := CLItem.Status;
                        end;
                      // Отображаем иконку статуса в чате
                      if ChatItem <> nil then
                        begin
                          ChatItem.Tag := StrToInt(Items[I].SubItems[6]);
                          ChatItem.ImageIndex := ChatItem.Tag;
                        end;
                    end;
                end;
            end;
        end;
    end;
  // Если не активен таймер иконки соединения, то можно мигать иконками сообщений
  if not JvTimerList.Events[3].Enabled then
    begin
      // Если есть непрочитанные сообщения в КЛ и в списке очереди входящих сообщений
      if (YesMsgICQ) and (InMessList.Count > 0) then
        begin
          // Ставим флаг в трэе, что есть сообщения для открытия
          ICQTrayIcon.Tag := 1;
          // Если иконка сообщения уже отображается, то меняем её на статус,
          // если наоборот, то на иконку сообщения
          if ICQTrayIcon.IconIndex = 165 then
            ICQTrayIcon.IconIndex := ICQ_CurrentStatus
          else
            ICQTrayIcon.IconIndex := 165;
        end
      else
        begin
          // Сбрасываем отображение иконки сообщений в трэе для ICQ
          ICQTrayIcon.Tag := 0;
          ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
        end;
      // Если есть непрочитанные сообщения в КЛ и в списке очереди входящих сообщений
      if (YesMsgJabber) and (InMessList.Count > 0) then
        begin
          // Ставим флаг в трэе, что есть сообщения для открытия
          JabberTrayIcon.Tag := 1;
          // Если иконка сообщения уже отображается, то меняем её на статус,
          // если наоборот, то на иконку сообщения
          if JabberTrayIcon.IconIndex = 165 then
            JabberTrayIcon.IconIndex := Jabber_CurrentStatus
          else
            JabberTrayIcon.IconIndex := 165;
        end
      else
        begin
          // Сбрасываем отображение иконки сообщений в трэе для ICQ
          JabberTrayIcon.Tag := 0;
          JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
        end;
      // Если есть непрочитанные сообщения в КЛ и в списке очереди входящих сообщений
      if (YesMsgMRA) and (InMessList.Count > 0) then
        begin
          // Ставим флаг в трэе, что есть сообщения для открытия
          MraTrayIcon.Tag := 1;
          // Если иконка сообщения уже отображается, то меняем её на статус,
          // если наоборот, то на иконку сообщения
          if MraTrayIcon.IconIndex = 165 then
            MraTrayIcon.IconIndex := Mra_CurrentStatus
          else
            MraTrayIcon.IconIndex := 165;
        end
      else
        begin
          // Сбрасываем отображение иконки сообщений в трэе для ICQ
          MraTrayIcon.Tag := 0;
          MraTrayIcon.IconIndex := Mra_CurrentStatus;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'Check Update Timer'}

procedure TMainForm.JvTimerListEvents2Timer(Sender: TObject);
begin
  // Ставим флаг - непоказывать всплывающее сообщение если новой версии нету
  if Sender = nil then
    UpdateAuto := False
  else
    UpdateAuto := True;
  // Сбрасываем сокет если он занят чем то другим или висит
  UpdateHttpClient.Abort;
  // Ставим флаг задания
  UpdateHttpClient.Tag := 0;
  // Запускаем проверку обновлений программы на сайте
  UpdateHttpClient.URL := C_UpdateURL;
  UpdateHttpClient.GetASync;
end;

{$ENDREGION}
{$REGION 'Connect Icon Timer'}

procedure TMainForm.JvTimerListEvents3Timer(Sender: TObject);
var
  NoStopTimer: Boolean;
begin
  NoStopTimer := False;
  // Отображаем мигающую иконку подключения к серверу ICQ
  if (ICQ_Connect_Phaze) or (ICQ_BosConnect_Phaze) then
    begin
      NoStopTimer := True;
      if ICQTrayIcon.IconIndex <> 168 then
        begin
          ICQTrayIcon.IconIndex := 168;
          ICQToolButton.ImageIndex := 168;
        end
      else
        begin
          ICQTrayIcon.IconIndex := 162;
          ICQToolButton.ImageIndex := 162;
        end;
    end
  else
    begin
      ICQToolButton.ImageIndex := ICQ_CurrentStatus;
      ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
    end;
  // Отображаем мигающую иконку подключения к серверу Jabber
  if Jabber_Connect_Phaze then
    begin
      NoStopTimer := True;
      if JabberTrayIcon.IconIndex <> 168 then
        begin
          JabberTrayIcon.IconIndex := 168;
          JabberToolButton.ImageIndex := 168;
        end
      else
        begin
          JabberTrayIcon.IconIndex := 162;
          JabberToolButton.ImageIndex := 162;
        end;
    end
  else
    begin
      JabberToolButton.ImageIndex := Jabber_CurrentStatus;
      JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
    end;
  // Отображаем мигающую иконку подключения к серверу MRA
  if (MRA_Connect_Phaze) or (MRA_BosConnect_Phaze) then
    begin
      NoStopTimer := True;
      if MRATrayIcon.IconIndex <> 168 then
        begin
          MRATrayIcon.IconIndex := 168;
          MRAToolButton.ImageIndex := 168;
        end
      else
        begin
          MRATrayIcon.IconIndex := 162;
          MRAToolButton.ImageIndex := 162;
        end;
    end
  else
    begin
      MRAToolButton.ImageIndex := MRA_CurrentStatus;
      MRATrayIcon.IconIndex := MRA_CurrentStatus;
    end;
  // Останавливаем таймер
  if not NoStopTimer then
    JvTimerList.Events[3].Enabled := False;
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
  // Создаём форму со смайликами через секунду после создания окна чата
  if not Assigned(SmilesForm) then
    SmilesForm := TSmilesForm.Create(nil);
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
  AllIconCount := 0;
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
        for I := 0 to AllIconCount do
          begin
            Img2.Canvas.CopyRect(Rect(0, 0, 16, 16), Img1.Canvas, Bounds(I * 16, 0, 16, 16));
            ImgList.AddMasked(Img2, ClFuchsia);
          end;
      end;
  finally
    Img1.Free;
    Img2.Free;
  end;
  XLog(Format(LogIconCount, [AllIconCount]), EmptyStr);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.MainToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaLeft;
  Popup(MainToolButton, MainPopupMenu);
end;

procedure TMainForm.MainToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaLeft;
  Popup(MainToolButton, MainPopupMenu);
end;

procedure TMainForm.MainToolTopButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaRight;
  Popup_down(MainToolTopButton, MainPopupMenu);
end;

procedure TMainForm.MainToolTopButtonContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaRight;
  Popup_down(MainToolTopButton, MainPopupMenu);
end;

procedure TMainForm.MRAToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup(MRAToolButton, MRAPopupMenu);
end;

procedure TMainForm.MRAToolButtonContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  Popup(MRAToolButton, RightMRAPopupMenu);
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
        DAShow(S_Errorhead, NotifyConnectError(S_Mra, ErrCode), EmptyStr, 134, 2, 0);
        // Активируем режим оффлайн
        MRA_GoOffline;
        Exit;
      end;
    // HTTP прокси коннект
    if (HttpProxy_Enable) and ((MRA_Connect_Phaze) or (MRA_BosConnect_Phaze)) and (not MRA_HTTP_Connect_Phaze) then
      begin
        // Заносим данные в специальный буфер
        MRA_myBeautifulSocketBuffer := MRA_myBeautifulSocketBuffer + Pkt;
        // Если нет ответа нормального от прокси, то выходим
        if Pos(C_RN + C_RN, MRA_myBeautifulSocketBuffer) = 0 then
          Exit;
        // Забираем из ответа прокси нужную информацию от прокси
        Pkt := Chop(C_RN + C_RN, MRA_myBeautifulSocketBuffer);
        // Обнуляем ошибки прокси
        ProxyErr := 0;
        // Если ответ положительный и прокси установил соединение,
        // то активируем фазу подключения через http прокси
        if StartsStr('HTTPS/1.0 200', Pkt) or StartsStr('HTTPS/1.1 200', Pkt) or StartsStr('HTTP/1.0 200', Pkt) or StartsStr('HTTP/1.1 200', Pkt) then
          begin
            MRA_HTTP_Connect_Phaze := True;
            XLog(S_Mra + Log_Get + Log_Proxy_OK, S_Mra);
            // Если уже подключились в Bos серверу
            if MRA_BosConnect_Phaze then
              begin
                // Отсылаем первый пакет логина
                MRA_Login_1;
                Exit;
              end;
          end
        else
        // Сообщаем об ошибках прокси
          if StartsStr('HTTP/1.0 407', Pkt) then
          begin
            ProxyErr := 1;
            DAShow(S_Errorhead, ProxyConnectErrL1 + C_RN + '[ ' + SocketL + C_BN + S_Mra + ' ]', EmptyStr, 134, 2, 0);
          end
        else
          begin
            ProxyErr := 2;
            DAShow(S_Errorhead, ProxyConnectErrL2 + C_RN + '[ ' + SocketL + C_BN + S_Mra + ' ]', EmptyStr, 134, 2, 0);
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
    TrafRecev := TrafRecev + Length(Pkt);
    AllTrafRecev := AllTrafRecev + Length(Pkt);
    if Assigned(TrafficForm) then
      OpenTrafficClick(nil);
    // Прибавляем данные к специальному буферу накопления таких преобразованных данных
    MRA_BuffPkt := MRA_BuffPkt + Pkt;
    // Если фаза первого подключания к серверу MRA
    if MRA_Connect_Phaze then
      begin
        MRA_Bos_Addr := MRA_BuffPkt;
        XLog(S_Mra + Log_Parsing + Log_Get_Server + MRA_Bos_Addr, S_Mra);
        // Получаем адрес Bos сервера для подключения
        MRA_Bos_IP := Parse(':', MRA_Bos_Addr, 1);
        MRA_Bos_Port := Parse(':', MRA_Bos_Addr, 2);
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
        MRAWSocket.Proto := 'tcp';
        if HttpProxy_Enable then
          begin
            MRAWSocket.Addr := HttpProxy_Address;
            MRAWSocket.Port := HttpProxy_Port;
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
        DAShow(S_Errorhead, ParsingPktError + C_RN + '[ ' + SocketL + C_BN + S_Mra + ' ]', EmptyStr, 134, 2, 0);
        MRA_GoOffline;
        Exit;
      end;
    // Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
    // для проверки этих данные на наличие слудующего целого пакета данных
  X :;
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
                XLog(S_Mra + Log_Get + S_Name + C_RN + Trim(Dump(HexPkt)), S_Mra);
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
                  $1002: begin
                      // Получаем интервал пакетов Ping
                      I := HexToInt(Text2Hex(NextData(HexPkt, Len)));
                      JvTimerList.Events[10].Interval := Swap32(I) * 1000;
                      Xlog(S_Mra + Log_Parsing + 'Ping interval: ' + IntToStr(JvTimerList.Events[10].Interval), S_Mra);
                      // Отправляем пакет авторизации на сервере
                      MRA_Login_2;
                      // Запускаем таймер MRA Alive
                      JvTimerList.Events[10].Enabled := True;
                    end;
                  $1004: begin
                      // Удачный логин и мы переходим в онлайн
                      MRA_Connect_Phaze := False;
                      MRA_BosConnect_Phaze := False;
                      MRA_HTTP_Connect_Phaze := False;
                      MRA_Work_Phaze := True;
                      MRA_Offline_Phaze := False;
                      // Отключаем метку пересоединения ведь мы уже и так онлайн!
                      MRA_Reconnect := False;
                      // Очищаем группы MRA в Ростере
                      RosterForm.ClearContacts(S_Mra);
                    end;
                  $1005: begin
                      if Pos('Invalid login', HexPkt) > 0 then
                        begin
                          // Отображаем сообщение, что авторизация не пройдена и закрываем сеанс
                          DAShow(S_Errorhead, MraLoginErrorL, EmptyStr, 134, 2, 0);
                          MRA_GoOffline;
                          Exit;
                        end;
                    end;
                  $1009: MRA_MessageRecv(NextData(HexPkt, Len));
                  $1015: MRA_ParseUserInfo(NextData(HexPkt, Len));
                  $1037: MRA_ParseCL(NextData(HexPkt, Len));
                  $100F: MRA_ParseStatus(NextData(HexPkt, Len));
                  $101D: MRA_ParseOfflineMess(NextData(HexPkt, Len));
                else
                  // Если канал пакета вообще другой, то проверяем в буфере другой пакет
                    goto Z;
                end;
              end
            else
              begin
                // --Если начальная метка пакета не правильная,
                // то выводим сообщение об ошибке разбора и выходим в оффлайн
                DAShow(S_Errorhead, ParsingPktError + C_RN + '[ ' + SocketL + C_BN + S_Mra + ' ]', EmptyStr, 134, 2, 0);
                MRA_GoOffline;
                Exit;
              end;
          end;
        // Если в конце разбора пакета у нас ещё остались данные, то возвращаемся для проверки буфера
      Z :;
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
  // Открываем окно выбора дополнительного статуса
  if not Assigned(MraXStatusForm) then
    MraXStatusForm := TMraXStatusForm.Create(Self);
  // Отображаем окнов рабочей области
  FormShowInWorkArea(MraXStatusForm);
end;

procedure TMainForm.MyInfoTwitterMenuClick(Sender: TObject);
begin
  // Загружаем информацию о пользователе
  if (Twit_Login <> EmptyStr) and (Twit_Password <> EmptyStr) then
    begin
      with TwitterHttpClient do
        begin
          Abort;
          Username := Twit_Login;
          Password := Twit_Password;
          URL := C_TwitUserInfo + Twit_Login;
          GetASync;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'AddNewContactClick'}

procedure TMainForm.AddNewContactClick(Sender: TObject);
var
  FrmAddCnt: TIcqAddContactForm;
begin
  // Создаём окно добавления контакта в КЛ
  FrmAddCnt := TIcqAddContactForm.Create(Self);
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
            ICQ_ReqStatus0215((ContactList.SelectedItem as TButtonItem).UIN)
          else
            DAShow(S_AlertHead, OnlineAlert, EmptyStr, 133, 3, 0);
        end;
    end;
end;

procedure TMainForm.CheckUpdateTray1Click(Sender: TObject);
begin
  // Запускаем проверку обновлений программы на сайте
  JvTimerListEvents2Timer(nil);
end;

{$ENDREGION}
{$REGION 'OpenTrafficClick'}

procedure TMainForm.OpenTrafficClick(Sender: TObject);
begin
  // Отображаем окно трафика
  if not Assigned(TrafficForm) then
    TrafficForm := TTrafficForm.Create(Self);
  // Показываем сколько трафика передано за эту сессию
  TrafficForm.CurTrafEdit.Text := FloatToStrF(TrafRecev / 1000, FfFixed, 18, 3) + ' KB | ' + FloatToStrF(TrafSend / 1000, FfFixed, 18, 3) + ' KB | ' + DateTimeToStr(SesDataTraf);
  // Показываем сколько трафика передано всего
  TrafficForm.AllTrafEdit.Text := FloatToStrF(AllTrafRecev / 1000000, FfFixed, 18, 3) + ' MB | ' + FloatToStrF(AllTrafSend / 1000000, FfFixed, 18, 3) + ' MB | ' + AllSesDataTraf;
  // Отображаем окно
  XShowForm(TrafficForm);
end;

{$ENDREGION}
{$REGION 'FloatContactMenuClick'}

procedure TMainForm.FloatContactMenuClick(Sender: TObject);
var
  I, FloatHandle: Integer;
  RosterItem: TListItem;
begin
  // Ищем этот контакт в Ростере
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
                          // (Screen.Forms[i] as FloatingForm)
                          Screen.Forms[I].Close;
                          SubItems[17] := EmptyStr;
                          Exit;
                        end;
                    end;
                end;
              FloatingFrm := TFloatingForm.Create(Self);
              SubItems[17] := IntToStr(FloatingFrm.Handle);
              FloatingFrm.NickLabel.Caption := SubItems[0];
              FloatingFrm.NickLabel.Hint := RosterItem.Caption;
              MainForm.AllImageList.GetBitmap(StrToInt(SubItems[6]), FloatingFrm.StatusImage.Picture.Bitmap);
              FloatingFrm.XStatusImage.Visible := False;
              FloatingFrm.ClientImage.Visible := False;
              FloatingFrm.Width := FloatingFrm.NickLabel.Width + 28;
              if FloatingFrm.XStatusImage.Visible then
                FloatingFrm.Width := FloatingFrm.Width + 18;
              if FloatingFrm.ClientImage.Visible then
                FloatingFrm.Width := FloatingFrm.Width + 20;
              FloatingFrm.Show;
            end;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.PingICQServerClick(Sender: TObject);
begin
  // Отправляем пакет для проверки связи с сервером ICQ
  // if not NotProtoOnline(S_Icq) then
end;

procedure TMainForm.PostImageTwitterMenuClick(Sender: TObject);
begin
  { TODO 2 : Сделать публикацию изображения в Twitter }
end;

procedure TMainForm.PostMessageTwitterMenuClick(Sender: TObject);
begin
  // Если форма не существует, то создаём её
  if not Assigned(IcqReqAuthForm) then
    IcqReqAuthForm := TIcqReqAuthForm.Create(Self);
  // Делаем запрос в форме на обновление программы
  IcqReqAuthForm.PostInTwitter(EmptyStr);
  // Отображаем окно
  XShowForm(IcqReqAuthForm);
end;

procedure TMainForm.PrivatListMenuClick(Sender: TObject);
begin
  ShowMessage(S_DevelMess);
end;

procedure TMainForm.PrivatONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку приватных списков на нижней панели
  PrivatONMenu.Checked := not PrivatONMenu.Checked;
  PrivatToolButton.Visible := not PrivatToolButton.Visible;
end;

{$ENDREGION}
{$REGION 'ProfileOpenMenuClick'}

procedure TMainForm.ProfileOpenMenuClick(Sender: TObject);
var
  Spath: string;
  R: Integer;
begin
  // Запускаем второй экземпляр программы для выбора другого профиля
  Spath := MyPath + C_ExeName;
  R := ShellExecute(0, 'open', 'Imadering.exe', nil, PChar(MyPath), SW_SHOW);
  XLog(Spath + C_BN + IntToStr(R), EmptyStr);
  if R < 32 then
    DAShow(S_Errorhead, NewProgErrL, EmptyStr, 134, 2, 0);
end;

{$ENDREGION}
{$REGION 'OpenTestClick'}

procedure TMainForm.OpenTestClick(Sender: TObject);
begin
  // Место для запуска тестов

end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.IncMessTwitterMenuClick(Sender: TObject);
begin
  { // Загружаем входящие сообщения
    if (Twit_Login <> EmptyStr) and (Twit_Password <> EmptyStr) then
    begin
    with TwitterHttpClient do
    begin
    Abort;
    Username := Twit_Login;
    Password := Twit_Password;
    URL := Format(C_TwitIncMess, [Twit_IncMess_Count]);
    GetASync;
    end;
    end; }
end;

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
  if Assigned(RosterForm) then
    RosterForm.UpdateFullCL;
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

procedure TMainForm.OpenSettingsClick(Sender: TObject);
begin
  // Открываем окно с настройками программы
  if not Assigned(SettingsForm) then
    SettingsForm := TSettingsForm.Create(Self);
  // Отображаем окно
  XShowForm(SettingsForm);
end;

procedure TMainForm.OpenSiteTwitterMinuClick(Sender: TObject);
begin
  // Открываем сайт Twitter
  OpenURL(C_TwitSite);
end;

{$ENDREGION}
{$REGION 'RenemeGroupCLClick'}

procedure TMainForm.RenemeGroupCLClick(Sender: TObject);
var
  FrmAddGroup: TIcqGroupManagerForm;
  I: Integer;
begin
  // Выводим форму добавления новой группы
  FrmAddGroup := TIcqGroupManagerForm.Create(Self);
  try
    with FrmAddGroup do
      begin
        Caption := (Sender as TMenuItem).Caption;
        // Ставим флаг, что это не добавление группы, а переименование
        Create_Group := False;
        // Вставляем название группы которую хотим переименовать
        for I := 0 to ContactList.Categories.Count - 1 do
          begin
            if ContactList.Categories[I].GroupSelected then
              begin
                GNameEdit.Text := ContactList.Categories[I].GroupCaption;
                Name_Group := ContactList.Categories[I].GroupCaption;
                // Флаги протокола
                GroupType := ContactList.Categories[I].GroupType;
                Id_Group := ContactList.Categories[I].GroupId;
                Break;
              end;
          end;
        // Отображаем окно модально
        ShowModal;
      end;
  finally
    FreeAndNil(FrmAddGroup);
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

procedure TMainForm.RosterMainMenuClick(Sender: TObject);
begin
  // Открываем окно списка контактов
  XShowForm(RosterForm);
end;

procedure TMainForm.AboutIMaderingClick(Sender: TObject);
begin
  // Открываем окно о программе
  if not Assigned(AboutForm) then
    AboutForm := TAboutForm.Create(Self);
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

procedure TMainForm.CloseProgramClick(Sender: TObject);
begin
  // Закрываем программу
  ProgramCloseCommand := True;
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
  Diff := Now - LastClick;
  // Запоминаем время текущего клика
  LastClick := Now;
  // Если по времени произошёл двойной клик, то начинаем открывать окно чата с этим контактом
  if (Diff < C_DblClickTime) and (ButtonInd = Button.index) then
    begin
      // Меняем иконку кнопки контакта на его статус
      Button.ImageIndex := Button.Status;
      // Открываем чат с этим контактом
      RosterForm.OpenChatPage(Button);
    end;
  // Запоминаем индекс кнопки
  ButtonInd := Button.index;
end;

{$ENDREGION}
{$REGION 'ContactListCategoryCollapase'}

procedure TMainForm.ContactListCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
var
  I: Integer;
  JvXML: TJvSimpleXml;
begin
  if not CollapseGroupsRestore then
    begin
      // Запоминаем свёрнутые группы
      // Инициализируем XML
      JvXML_Create(JvXML);
      try
        with JvXML do
          begin
            with ContactList do
              begin
                for I := 0 to Categories.Count - 1 do
                  Root.Items.Add(ChangeCP(URLEncode(Categories[I].GroupCaption + Categories[I].GroupType + Categories[I].GroupId))).Properties.Add('c', Categories[I].Collapsed);
              end;
            // Записываем файл
            SaveToFile(ProfilePath + GroupsFileName);
          end;
      finally
        JvXML.Free;
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
      // Для ICQ
      if RoasterButton.ContactType = C_Icq then
        begin
          DelYourSelfContact.Visible := True;
          CheckStatusContact.Visible := True;
          GrandAuthContact.Visible := True;
          SendAddContact.Visible := True;
        end
        // Для Jabber
      else if RoasterButton.ContactType = S_Jabber then
        begin
          DelYourSelfContact.Visible := False;
          CheckStatusContact.Visible := False;
          GrandAuthContact.Visible := False;
          SendAddContact.Visible := False;
        end
        // Для MRA
      else if RoasterButton.ContactType = S_Mra then
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
              RenemeGroupCL.Visible := True;
              DeleteGroupCL.Visible := True;
              // Управляем протоколами групп
              if RoasterGroup.GroupType = C_Icq then
                begin
                  AddNewGroupICQ.Visible := True;
                  AddNewGroupJabber.Visible := False;
                  AddNewGroupMRA.Visible := False;
                  //
                  AddNewContactICQ.Visible := True;
                  AddNewContactJabber.Visible := False;
                  AddNewContactMRA.Visible := False;
                end
              else if RoasterGroup.GroupType = S_Jabber then
                begin
                  AddNewGroupICQ.Visible := False;
                  AddNewGroupJabber.Visible := True;
                  AddNewGroupMRA.Visible := False;
                  //
                  AddNewContactICQ.Visible := False;
                  AddNewContactJabber.Visible := True;
                  AddNewContactMRA.Visible := False;
                end
              else if RoasterGroup.GroupType = S_Mra then
                begin
                  AddNewGroupICQ.Visible := False;
                  AddNewGroupJabber.Visible := False;
                  AddNewGroupMRA.Visible := True;
                  //
                  AddNewContactICQ.Visible := False;
                  AddNewContactJabber.Visible := False;
                  AddNewContactMRA.Visible := True;
                end;
            end
          else
            begin
              // Если клик не по группе, то убираем выделение отовсюду
              ContactList.SelectedItem := nil;
              // Управляем пунктами меню для группы
              RenemeGroupCL.Visible := False;
              DeleteGroupCL.Visible := False;
              // Управляем протоколами групп
              AddNewGroupICQ.Visible := True;
              AddNewGroupJabber.Visible := True;
              AddNewGroupMRA.Visible := True;
              // Добавление контактов в протоколы
              AddNewContactICQ.Visible := True;
              AddNewContactJabber.Visible := True;
              AddNewContactMRA.Visible := True;
            end;
        end;
      // Отображаем меню
      ContactListPopupMenu.Popup(FCursor.X, FCursor.Y);
    end;
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
    SetClipboardText((ContactList.SelectedItem as TButtonItem).UIN);
end;

{$ENDREGION}
{$REGION 'DeleteContactClick'}

procedure TMainForm.DeleteContactClick(Sender: TObject);
{ var
  RosterItem: TListItem; }
begin
  { //--Если ничего не активно для удаления, то выходим
    if ContactList.SelectedItem <> nil then
    begin
    //--Удаляем контакт из списка контактов
    //--Блокируем всё окно со списком контактов
    MainForm.Enabled := false;
    try
    //--Выводим диалог подтверждения удаления контакта
    if MessageBox(Handle, PChar(Format(DellContactL, [ContactList.SelectedItem.Caption])), PChar((Sender as TMenuItem).Hint),
    MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = mrYes then
    begin
    with ContactList do
    begin
    //--Сканируем Ростер и ищем этот контакт
    RosterItem := RosterForm.ReqRosterItem(SelectedItem.UIN);
    //--Удаляем эту кнопку с контактом из КЛ
    SelectedItem.Free;
    if RosterItem <> nil then
    begin
    //--Смотрим какой протокол у удаляемого контакта
    if RosterItem.SubItems[3] = C_Icq then
    begin
    //--Смотрим из какой группы этот контакт
    if RosterItem.SubItems[1] = '0000' then
    begin
    //--Если это контакт из группы временных, то удаляем его как временный
    //--Отправляем пакет для удаления контакта из списка на сервере
    ICQ_DeleteTempContact(RosterItem.Caption, RosterItem.SubItems[4],
    RosterItem.SubItems[5], RosterItem.SubItems[12]);
    RosterItem.Delete;
    end
    else if RosterItem.SubItems[1] = S_NoCL then
    begin
    //--Если контакт из группы "Не в списке"
    RosterItem.Delete;
    end
    else
    begin
    //--Иначе удаляем контакт как положено
    ICQ_DeleteContact(RosterItem.Caption, RosterItem.SubItems[1],
    RosterItem.SubItems[4], RosterItem.SubItems[0],
    RosterItem.SubItems[9], RosterItem.SubItems[11],
    RosterItem.SubItems[10]);
    RosterItem.Delete;
    end;
    end
    //--Удаляем по протоколу Jabber
    else if RosterItem.SubItems[3] = S_Jabber then
    begin

    end
    //--Удаляем по протоколу Mra
    else if RosterItem.SubItems[3] = S_Mra then
    begin

    end;
    //--Обновляем КЛ
    RosterForm.UpdateFullCL;
    end;
    end;
    end;
    finally
    //--В любом случае разблокировываем окно контактов
    MainForm.Enabled := true;
    end;
    end; }
end;

{$ENDREGION}
{$REGION 'DeleteGroupCLClick'}

procedure TMainForm.DeleteGroupCLClick(Sender: TObject);
label
  X;
var
  GroupProto, GroupId, GroupName: string;
  I: Integer;
  TCL: TStringList;
begin
  // Блокируем всё окно со списком контактов
  MainForm.Enabled := False;
  try
    // Смотрим какого это протокола группа
    for I := 0 to ContactList.Categories.Count - 1 do
      begin
        if ContactList.Categories[I].GroupSelected then
          begin
            GroupProto := ContactList.Categories[I].GroupType;
            GroupId := ContactList.Categories[I].GroupId;
            GroupName := ContactList.Categories[I].GroupCaption;
            Break;
          end;
      end;
    // Выводим диалог подтверждения удаления контакта
    if MessageBox(Handle, PChar(Format(DellGroupL, [GroupName])), PChar((Sender as TMenuItem).Hint), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
      begin
        // Удаляем группу вместе с контактами из локального КЛ
        for I := 0 to ContactList.Categories.Count - 1 do
          begin
            if ContactList.Categories[I].GroupSelected then
              begin
                ContactList.Categories[I].Free;
                Break;
              end;
          end;
        // Если это группа "Не в списке"
        if GroupId = C_NoCL then
          begin
            //
            Exit;
          end;
        // Удаляем выбранную группу ICQ
        if GroupProto = C_Icq then
          begin
            // Удаляем группу временных контактов
            if GroupId = '0000' then
              begin
                // Создаём список для идентификаторов временных контактов
                TCL := TStringList.Create;
                try
                  with RosterForm.RosterJvListView do
                    begin
                      for I := 0 to Items.Count - 1 do
                        begin
                          if (Items[I].SubItems[3] = C_Icq) and (Items[I].SubItems[1] = '0000') then
                            begin
                              TCL.Add(Items[I].Caption + ';' + Items[I].SubItems[4] + ';' + Items[I].SubItems[5] + ';' + Items[I].SubItems[12]);
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
                ICQ_DeleteGroup(GroupName, GroupId);
                ICQ_Group_Delete_Phaze := True;
                ICQ_SSI_Phaze := True;
              end;
            // Удаляем группу в локальном Ростере
            with RosterForm.RosterJvListView do
              begin
                for I := 0 to Items.Count - 1 do
                  begin
                    if (Items[I].SubItems[3] = C_Icq) and (Length(Items[I].Caption) = 4) and (Items[I].Caption = GroupId) then
                      begin
                        Items[I].Delete;
                        Break;
                      end;
                  end;
                // Удаляем все контакты из локального Ростера что были в этой группе
              X :;
                for I := 0 to Items.Count - 1 do
                  begin
                    if (Items[I].SubItems[3] = C_Icq) and (Items[I].SubItems[1] = GroupId) then
                      begin
                        Items[I].Delete;
                        goto X;
                      end;
                  end;
              end;
          end
          // Удаляем выбранную группу Jabber
        else if GroupProto = S_Jabber then
          begin

          end
          // Удаляем выбранную группу Mra
        else if GroupProto = S_Mra then
          begin

          end;
      end;
  finally
    // В любом случае разблокировываем окно контактов
    MainForm.Enabled := True;
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
        if MessageBox(Handle, PChar(Format(DellYourSelfL, [ContactList.SelectedItem.Caption])), PChar((Sender as TMenuItem).Hint), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
          if ICQ_Work_Phaze then
            ICQ_DellMyFromCL((ContactList.SelectedItem as TButtonItem).UIN)
          else
            DAShow(S_AlertHead, OnlineAlert, EmptyStr, 133, 3, 0);
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
  if RoasterAlphaBlend then
    if AlphaBlendInactive then
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
  if not ProgramCloseCommand then
    begin
      CanClose := False;
      MainFormHideInTray;
    end
  else
    begin
      // Останавливаем таймеры
      JvTimerList.Active := False;
      // Переводим все протоколы в оффлайн
      if not ICQ_Offline_Phaze then
        ICQ_GoOffline;
      if not Jabber_Offline_Phaze then
        Jab_GoOffline;
      if not MRA_Offline_Phaze then
        MRA_GoOffline;
      // Отключаем HTTP сокеты
      UpdateHttpClient.Abort;
      MRAAvatarHttpClient.Abort;
      TwitterHttpClient.Abort;
      if Assigned(FileTransferForm) then
        FileTransferForm.SendFileHttpClient.Abort;
      if Assigned(GTransForm) then
        GTransForm.GtransHttpClient.Abort;
      // Уничтожаем ресурсы списков
      if Assigned(InMessList) then
        FreeAndNil(InMessList);
      if Assigned(AccountToNick) then
        FreeAndNil(AccountToNick);
      if Assigned(SmilesList) then
        FreeAndNil(SmilesList);
      // Уничтожаем графические ресурсы
      if Assigned(NoAvatar) then
        FreeAndNil(NoAvatar);
      if Assigned(OutMessage2) then
        FreeAndNil(OutMessage2);
      if Assigned(OutMessage3) then
        FreeAndNil(OutMessage3);
      if Assigned(XStatusImg) then
        FreeAndNil(XStatusImg);
      if Assigned(XStatusMem) then
        FreeAndNil(XStatusMem);
      // Уничтожаем окно смайлов
      if Assigned(SmilesForm) then
        FreeAndNil(SmilesForm);
      // Уничтожаем окно чата
      if Assigned(ChatForm) then
        FreeAndNil(ChatForm);
      // Делаем текущую локальную копию списка контактов для отображения при запуске программы
      if Assigned(RosterForm) then
        begin
          RosterForm.RosterJvListView.SaveToCSV(ProfilePath + ContactListFileName);
          // Уничтожаем окно Ростера
          FreeAndNil(RosterForm);
        end;
      // Высвобождаем окно подсказок
      if Assigned(SH_HintWindow) then
        FreeAndNil(SH_HintWindow);
      // Если создан AppBar, то уничтожаем его
      if DockAppBar then
        AppBarDestroy;
    end;
end;

{$ENDREGION}
{$REGION 'AddNewContactICQClick'}

procedure TMainForm.AddNewContactICQClick(Sender: TObject);
var
  FrmAddContact: TIcqAddContactForm;
begin
  // Выводим форму добавления новой группы
  FrmAddContact := TIcqAddContactForm.Create(Self);
  try
    with FrmAddContact do
      begin
        // Ставим флаг какой протокол
        case (Sender as TMenuItem).Tag of
          1: ContactType := C_Icq;
          2: ContactType := S_Jabber;
          3: ContactType := S_Mra;
        end;
        // Строим список групп этого протокола
        BuildGroupList(ContactType);
        // Отображаем окно модально
        ShowModal;
      end;
  finally
    FreeAndNil(FrmAddContact);
  end;
end;

{$ENDREGION}
{$REGION 'AddNewGroupICQClick'}

procedure TMainForm.AddNewGroupICQClick(Sender: TObject);
var
  FrmAddGroup: TIcqGroupManagerForm;
begin
  // Выводим форму добавления новой группы
  FrmAddGroup := TIcqGroupManagerForm.Create(Self);
  try
    with FrmAddGroup do
      begin
        Caption := (Sender as TMenuItem).Caption;
        // Добавляем название группы по умолчанию
        GNameEdit.Text := AddNewGroupL;
        // Ставим флаг, что это добавление новой группы
        Create_Group := True;
        // Ставим флаг какой протокол
        case (Sender as TMenuItem).Tag of
          1: GroupType := C_Icq;
          2: GroupType := S_Jabber;
          3: GroupType := S_Mra;
        end;
        // Отображаем окно модально
        ShowModal;
      end;
  finally
    FreeAndNil(FrmAddGroup);
  end;
end;

procedure TMainForm.AllLentaTwitterMenuClick(Sender: TObject);
begin
  { TODO 2 : Сделать открытие общей ленты Twitter }
end;

{$ENDREGION}
{$REGION 'AnketaContactClick'}

procedure TMainForm.AnketaContactClick(Sender: TObject);
begin
  // Отображаем информацию о контакте
  if ContactList.SelectedItem <> nil then
    begin
      if not Assigned(IcqContactInfoForm) then
        IcqContactInfoForm := TIcqContactInfoForm.Create(Self);
      // Присваиваем UIN инфу которого хотим смотреть
      IcqContactInfoForm.ReqUIN := (ContactList.SelectedItem as TButtonItem).UIN;
      IcqContactInfoForm.ReqProto := (ContactList.SelectedItem as TButtonItem).ContactType;
      // Загружаем информацию о нем
      IcqContactInfoForm.LoadUserUnfo;
      // Отображаем окно
      XShowForm(IcqContactInfoForm);
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.EditContactClick(Sender: TObject);
begin
  ShowMessage(S_DevelMess);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Сохраняем настройки окна
  SaveMainFormSettings;
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

procedure TMainForm.FormCreate(Sender: TObject);
var
  S: string;
  Buf: array [0 .. $FF] of Char;
  Size: Integer;
  Lang: Word;
  VI: TOSVersionInfo;
begin
  // Устанавливаем начальное значение ширины окна КЛ
  Width := 199;
  // Узнаём путь откуда запущена программа
  MyPath := ExtractFilePath(Application.ExeName);
  // Смотрим язык системы
  Lang := GetSystemDefaultLangID;
  if Lang <> 1049 then
    CurrentLang := 'en';
  // Загружаем переменные языка
  SetLangVars;
  // Создаём окно лога
  LogForm := TLogForm.Create(Self);
  // Узнаём версию Windows
  VI.DwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VI);
  XLog(Format(Log_WinVer, [VI.DwMajorVersion, VI.DwMinorVersion, VI.DwBuildNumber, VI.SzCSDVersion]), EmptyStr);
  // Пишем в лог путь к программе
  XLog(LogMyPath + MyPath, EmptyStr);
  // Пишем в лог код локального языка системы
  XLog(Log_Lang_Code + IntToStr(Lang), EmptyStr);
  // Если профиль не найден, то создаём его в настройках юзера виндовс
  ProfilePath := MyPath + 'Profiles\';
  if not DirectoryExists(ProfilePath) then
    begin
      S := '%APPDATA%\IMadering\';
      Size := ExpandEnvironmentStrings(PChar(S), Buf, Sizeof(Buf));
      ProfilePath := Copy(Buf, 1, Size);
    end;
  XLog(LogProfile + ProfilePath, EmptyStr);
  // Загрузка иконок для программы
  LoadImageList(AllImageList, MyPath + 'Icons\' + CurrentIcons + '\icons.bmp');
  // Устанавливаем иконку окна
  AllImageList.GetIcon(1, Icon);
  // Устанавливаем иконки окна лога
  AllImageList.GetIcon(245, LogForm.Icon);
  AllImageList.GetBitmap(159, LogForm.ClearLogSpeedButton.Glyph);
  AllImageList.GetBitmap(81, LogForm.ICQDumpSpeedButton.Glyph);
  AllImageList.GetBitmap(43, LogForm.JabberDumpSpeedButton.Glyph);
  AllImageList.GetBitmap(66, LogForm.MRADumpSpeedButton.Glyph);
  AllImageList.GetBitmap(249, LogForm.WriteLogSpeedButton.Glyph);
  AllImageList.GetBitmap(268, LogForm.TwitDumpSpeedButton.Glyph);
  AllImageList.GetBitmap(225, LogForm.SaveLogSpeedButton.Glyph);
  // Делаем всплывающие подсказки неисчезающими
  Application.HintHidePause := MaxInt;
  Application.OnHint := HintMaxTime;
  // Скрываем кнопку главное меню в верхней панели
  MainToolTopButton.Visible := False;
  // Назначаем продвинутые функции активации и деактивации
  Application.OnActivate := AppActivate;
  Application.OnDeactivate := AppDeactivate;
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := True;
  // Проверяем если ли старый файл после обновления, если есть, то удаляем
  if FileExists(MyPath + 'Imadering.old') then
    DeleteFile(MyPath + 'Imadering.old');
  // Проверяем могут ли воспроизводится звуки на компьютере
  if InitMixer = 0 then
    SoundON := False;
  // Запоминаем текущую версию имадеринг
  FullVersion := InitBuildInfo;
  // Создаём окно подсказок
  SH_HintWindow := THintWindow.Create(Self);
  SH_HintWindow.Color := ClInfoBk;
  // Запускаем таймер отображения окна выбора профиля
  JvTimerList.Events[0].Enabled := True;
end;

{$ENDREGION}
{$REGION 'FormDeactivate'}

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  // Включаем прозрачность окна при неактивности
  if RoasterAlphaBlend then
    if AlphaBlendInactive then
      AlphaBlendValue := RoasterAlphaValue;
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
  if PKeySearch <> Key then
    begin
      CurGroup := 0;
      CurItem := 0;
    end;
  // Запоминаем клавишу
  PKeySearch := Key;
Z :;
  with ContactList do
    begin
      for I := CurGroup to Categories.Count - 1 do
        begin
          for Ii := CurItem to Categories[I].Items.Count - 1 do
            begin
              Capt := Categories[I].Items[Ii].Caption[1];
              if UpperCase(Capt, LoUserLocale) = UpperCase(Key, LoUserLocale) then
                begin
                  if Categories[I].Collapsed then
                    Categories[I].Collapsed := False;
                  Categories[I].Items.Items[Ii].ScrollIntoView;
                  SelectedItem := Categories.Items[I].Items.Items[Ii];
                  CurItem := Ii + 1;
                  goto X;
                end;
            end;
          CurItem := 0;
          goto Y;
        end;
      FocusedItem := nil;
      SelectedItem := nil;
      CurGroup := 0;
      CurItem := 0;
      Exit;
    X :;
      Exit;
    Y :;
      CurGroup := CurGroup + 1;
      if CurGroup > Categories.Count then
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
        ICQ_SendGrandAuth((ContactList.SelectedItem as TButtonItem).UIN)
      else
        DAShow(S_AlertHead, OnlineAlert, EmptyStr, 133, 3, 0);
    end;
end;

procedure TMainForm.GroupONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку скрыть группы на нижней панели
  GroupONMenu.Checked := not GroupONMenu.Checked;
  GroupOnOffToolButton.Visible := not GroupOnOffToolButton.Visible;
end;

procedure TMainForm.GroupOnOffToolButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. групп
  if GroupOnOffToolButton.Down then
    begin
      GroupOnOffToolTopButton.Down := True;
      GroupOnOffToolButton.ImageIndex := 231;
      GroupOnOffToolTopButton.ImageIndex := 231;
    end
  else
    begin
      GroupOnOffToolTopButton.Down := False;
      GroupOnOffToolButton.ImageIndex := 232;
      GroupOnOffToolTopButton.ImageIndex := 232;
    end;
  // Запускаем обработку Ростера
  if Assigned(RosterForm) then
    RosterForm.UpdateFullCL;
end;

procedure TMainForm.GroupOnOffToolTopButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. групп
  GroupOnOffToolButton.Down := not GroupOnOffToolButton.Down;
  GroupOnOffToolButtonClick(Self);
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
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            if Root <> nil then
              begin
                // Проверяем есть ли нода главной формы
                XML_Node := Root.Items.ItemNamed[C_MainForm];
                if XML_Node <> nil then
                  begin
                    // Загружаем позицию окна
                    Top := XML_Node.Properties.IntValue('t');
                    Left := XML_Node.Properties.IntValue('l');
                    Height := XML_Node.Properties.IntValue('h');
                    Width := XML_Node.Properties.IntValue('w');
                    // Определяем не находится ли окно за пределами экрана
                    FormSetInWorkArea(Self);
                    // Загружаем состояние кнопки звуков
                    Sub_Node := XML_Node.Items.ItemNamed[C_MainFormSounds];
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
                    // Загружаем состояние кнопки отображения групп
                    Sub_Node := XML_Node.Items.ItemNamed[C_MainFormGroups];
                    if Sub_Node <> nil then
                      if not Sub_Node.BoolValue then
                        begin
                          GroupOnOffToolButton.Down := False;
                          GroupOnOffToolButtonClick(Self);
                        end;
                    // Загружаем был ли первый старт
                    Sub_Node := XML_Node.Items.ItemNamed[C_MainFormFirst];
                    if Sub_Node <> nil then
                      FirstStart := Sub_Node.BoolValue;
                    // Загружаем выбранные протоколы
                    Sub_Node := XML_Node.Items.ItemNamed[C_MainFormProto];
                    if Sub_Node <> nil then
                      begin
                        ICQ_Enable(Sub_Node.Properties.BoolValue(C_Icq, False));
                        MRA_Enable(Sub_Node.Properties.BoolValue(S_Mra, False));
                        Jab_Enable(Sub_Node.Properties.BoolValue(S_Jabber, False));
                        Twit_Enable(Sub_Node.Properties.BoolValue(S_Twitter, False));
                      end;
                    // Загружаем данные трафика
                    Sub_Node := XML_Node.Items.ItemNamed[C_Traffic];
                    if Sub_Node <> nil then
                      begin
                        AllTrafSend := Sub_Node.Properties.IntValue('s', 0);
                        AllTrafRecev := Sub_Node.Properties.IntValue('r', 0);
                        AllSesDataTraf := Sub_Node.Properties.Value('d');
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
                        MainToolTopButton.Visible := Sub_Node.Properties.BoolValue('b0');
                        TopMainButtonONMenu.Checked := MainToolTopButton.Visible;
                        //
                        OnlyOnlineContactsTopButton.Visible := Sub_Node.Properties.BoolValue('b1');
                        TopOnlyOnlineONMenu.Checked := OnlyOnlineContactsTopButton.Visible;
                        //
                        GroupOnOffToolTopButton.Visible := Sub_Node.Properties.BoolValue('b2');
                        TopGroupONMenu.Checked := GroupOnOffToolTopButton.Visible;
                        //
                        SoundOnOffToolTopButton.Visible := Sub_Node.Properties.BoolValue('b3');
                        TopSoundsONMenu.Checked := SoundOnOffToolTopButton.Visible;
                        //
                        PrivatTopToolButton.Visible := Sub_Node.Properties.BoolValue('b4');
                        TopPrivatONMenu.Checked := PrivatTopToolButton.Visible;
                        //
                        HistoryTopToolButton.Visible := Sub_Node.Properties.BoolValue('b5');
                        TopHistoryONMenu.Checked := HistoryTopToolButton.Visible;
                        //
                        SettingsTopToolButton.Visible := Sub_Node.Properties.BoolValue('b6');
                        TopSettingsONMenu.Checked := SettingsTopToolButton.Visible;
                        //
                        CLSearchTopToolButton.Visible := Sub_Node.Properties.BoolValue('b7');
                        TopCLSearchONMenu.Checked := CLSearchTopToolButton.Visible;
                        //
                        TrafficTopToolButton.Visible := Sub_Node.Properties.BoolValue('b8');
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
                        MainToolButton.Visible := Sub_Node.Properties.BoolValue('b0');
                        MainButtonONMenu.Checked := MainToolButton.Visible;
                        //
                        OnlyOnlineContactsToolButton.Visible := Sub_Node.Properties.BoolValue('b1');
                        OnlyOnlineONMenu.Checked := OnlyOnlineContactsToolButton.Visible;
                        //
                        GroupOnOffToolButton.Visible := Sub_Node.Properties.BoolValue('b2');
                        GroupONMenu.Checked := GroupOnOffToolButton.Visible;
                        //
                        SoundOnOffToolButton.Visible := Sub_Node.Properties.BoolValue('b3');
                        SoundsONMenu.Checked := SoundOnOffToolButton.Visible;
                        //
                        PrivatToolButton.Visible := Sub_Node.Properties.BoolValue('b4');
                        PrivatONMenu.Checked := PrivatToolButton.Visible;
                        //
                        HistoryToolButton.Visible := Sub_Node.Properties.BoolValue('b5');
                        HistoryONMenu.Checked := HistoryToolButton.Visible;
                        //
                        SettingsToolButton.Visible := Sub_Node.Properties.BoolValue('b6');
                        SettingsONMenu.Checked := SettingsToolButton.Visible;
                        //
                        CLSearchToolButton.Visible := Sub_Node.Properties.BoolValue('b7');
                        CLSearchONMenu.Checked := CLSearchToolButton.Visible;
                        //
                        TrafficToolButton.Visible := Sub_Node.Properties.BoolValue('b8');
                        TrafficONMenu.Checked := TrafficToolButton.Visible;
                        //
                        TopPanelToolButton.Visible := Sub_Node.Properties.BoolValue('b9');
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
  if Profile = EmptyStr then
    Exit;
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  // Сохраняем настройки положения главного окна в xml
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        // Подгружаем файл с настройками если он есть
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        if Root <> nil then
          begin
            // Очищаем раздел главной формы если он есть
            XML_Node := Root.Items.ItemNamed[C_MainForm];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(C_MainForm);
            // Сохраняем позицию окна
            XML_Node.Properties.Add('t', Top);
            XML_Node.Properties.Add('l', Left);
            XML_Node.Properties.Add('h', Height);
            XML_Node.Properties.Add('w', Width);
            // Сохраняем звук вкл. выкл.
            XML_Node.Items.Add(C_MainFormSounds, SoundOnOffToolButton.Down);
            // Сохраняем отображать только онлайн вкл. выкл.
            XML_Node.Items.Add(C_MainFormOnlyOnline, OnlyOnlineContactsToolButton.Down);
            // Сохраняем отображать группы вкл. выкл.
            XML_Node.Items.Add(C_MainFormGroups, GroupOnOffToolButton.Down);
            // Записываем что первый запуск программы уже состоялся и показывать
            // окно настройки протоколов больше не будем при запуске
            XML_Node.Items.Add(C_MainFormFirst, True);
            // Сохраняем активные протоколы
            Sub_Node := XML_Node.Items.Add(C_MainFormProto);
            Sub_Node.Properties.Add(C_Icq, ICQToolButton.Visible);
            Sub_Node.Properties.Add(S_Mra, MRAToolButton.Visible);
            Sub_Node.Properties.Add(S_Jabber, JabberToolButton.Visible);
            Sub_Node.Properties.Add(S_Twitter, TwitterToolButton.Visible);
            // Сохраняем трафик
            Sub_Node := XML_Node.Items.Add(C_Traffic);
            Sub_Node.Properties.Add('s', AllTrafSend);
            Sub_Node.Properties.Add('r', AllTrafRecev);
            Sub_Node.Properties.Add('d', AllSesDataTraf);
            // Сохраняем пункты меню
            XML_Node.Items.Add(C_MainFormHEG, HideEmptyGroups.Checked);
            // Сохраняем состояние верхней панели
            Sub_Node := XML_Node.Items.Add(C_MainFormTP, TopPanelToolButton.Down);
            for I := 0 to TopPanelPopupMenu.Items.Count - 1 do
              Sub_Node.Properties.Add('b' + IntToStr(I), TopPanelPopupMenu.Items[I].Checked);
            // Сохраняем состояние нижней панели
            Sub_Node := XML_Node.Items.Add(C_MainFormBP);
            for I := 0 to BottomPanelPopupMenu.Items.Count - 1 do
              Sub_Node.Properties.Add('b' + IntToStr(I), BottomPanelPopupMenu.Items[I].Checked);
            // Записываем сам файл
            SaveToFile(ProfilePath + SettingsFileName);
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
  // --Открываем форму отправки файлов
  if not Assigned(FileTransferForm) then
    FileTransferForm := TFileTransferForm.Create(Self);
  // --Присваиваем переменную способа передачи
  with FileTransferForm do
    begin
      if CancelBitBtn.Enabled then
        begin
          XShowForm(FileTransferForm);
          DAShow(S_AlertHead, S_FileTransfer6, EmptyStr, 133, 3, 0);
          Exit;
        end;
      // Выбираем способ передачи файла
      Tag := (Sender as TMenuItem).Tag;
      TopInfoPanel.Caption := S_FileTransfer1 + (ContactList.SelectedItem as TButtonItem).Caption;
      T_UIN := (ContactList.SelectedItem as TButtonItem).UIN;
      T_UserType := (ContactList.SelectedItem as TButtonItem).ContactType;
      // --Открываем диалог выбора файла для передачи
      if SendFileOpenDialog.Execute then
        begin
          T_FilePath := SendFileOpenDialog.FileName;
          T_FileName := GetFileName(SendFileOpenDialog.FileName);
          FileNamePanel.Caption := C_BN + T_FileName;
          FileNamePanel.Hint := T_FileName;
          // --Вычисляем размер файла
          Fsize := GetFileSize(SendFileOpenDialog.FileName);
          if Fsize > 1000000 then
            FileSizePanel.Caption := FloatToStrF(Fsize / 1000000, FfFixed, 18, 3) + ' MB'
          else
            FileSizePanel.Caption := FloatToStrF(Fsize / 1000, FfFixed, 18, 3) + ' KB';
          // --Отображаем окно
          XShowForm(FileTransferForm);
        end;
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.SearchInCLClick(Sender: TObject);
begin
  // Открываем окно поиска контактов в контактном листе
  if not Assigned(CLSearchForm) then
    CLSearchForm := TCLSearchForm.Create(Self);
  // Отображаем окно
  XShowForm(CLSearchForm);
end;

procedure TMainForm.SendAddContactClick(Sender: TObject);
begin
  // Отправляем пакет "Вас добавили"
  if ContactList.SelectedItem <> nil then
    begin
      if ICQ_Work_Phaze then
        ICQ_SendYouAdded((ContactList.SelectedItem as TButtonItem).UIN)
      else
        DAShow(S_AlertHead, OnlineAlert, EmptyStr, 133, 3, 0);
    end;
end;

procedure TMainForm.SendInviteContactClick(Sender: TObject);
begin
  ShowMessage(S_DevelMess);
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
  if DockAppBar then
    AppBarDestroy;
  // Создаём новый AppBar
  AppBarCreate;
  if Sender = SnapToRight then
    AppBarSetPos(False)
  else
    AppBarSetPos(True);
  if not DockAppBar then
    begin
      DockAppBar := True;
      // Запоминаем предыдущие размеры окна
      NoDockHeigth := Height;
      NoDockWigth := Width;
    end;
  // Запоминаем сторону
  if Sender = SnapToRight then
    begin
      DockRigth := True;
      DockLeft := False;
    end
  else
    begin
      DockRigth := False;
      DockLeft := True;
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
      SoundON := False;
      if Assigned(SettingsForm) then
        SettingsForm.SoundOnOffCheckBox.Checked := True;
    end
  else
    begin
      SoundOnOffToolTopButton.Down := False;
      SoundOnOffToolButton.ImageIndex := 135;
      SoundOnOffToolTopButton.ImageIndex := 135;
      if InitMixer <> 0 then
        SoundON := True;
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

procedure TMainForm.TopGroupONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку отображать группы на верхней панели
  TopGroupONMenu.Checked := not TopGroupONMenu.Checked;
  GroupOnOffToolTopButton.Visible := not GroupOnOffToolTopButton.Visible;
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

procedure TMainForm.TopPrivatONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку приватные списки на верхней панели
  TopPrivatONMenu.Checked := not TopPrivatONMenu.Checked;
  PrivatTopToolButton.Visible := not PrivatTopToolButton.Visible;
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
{$REGION 'TrayPopupMenuPopup'}

procedure TMainForm.TrayPopupMenuPopup(Sender: TObject);
var
  I: Integer;
begin
  // Определяем какой протокол в трэе вызвал это меню и назначаем
  // соответствующую иконку и таг для идентификации на пуект меню выбора статуса
  if TrayProtoClickMenu = 'icqtrayicon' then
    begin
      StatusTray1.ImageIndex := ICQToolButton.ImageIndex;
      // Очищаем пункты субменю
      StatusTray1.Clear;
      // Заполняем субменю пунктами из основного ICQ меню
      with StatusTray1 do
        begin
          for I := 0 to ICQPopupMenu.Items.Count - 1 do
            begin
              Add(NewItem(ICQPopupMenu.Items[I].Caption, 0, False, True, ICQPopupMenu.Items[I].OnClick, 0, 'MenuItem' + IntToStr(I)));
              // Назначаем иконку для пункта меню
              Items[I].ImageIndex := ICQPopupMenu.Items[I].ImageIndex;
              // Назначаем выделение для пункта меню
              Items[I].default := ICQPopupMenu.Items[I].default;
            end;
        end;
    end
  else if TrayProtoClickMenu = 'mratrayicon' then
    begin
      StatusTray1.ImageIndex := MRAToolButton.ImageIndex;
      // Очищаем пункты субменю
      StatusTray1.Clear;
      // Заполняем субменю пунктами из основного ICQ меню
      with StatusTray1 do
        begin
          for I := 0 to MRAPopupMenu.Items.Count - 1 do
            begin
              Add(NewItem(MRAPopupMenu.Items[I].Caption, 0, False, True, MRAPopupMenu.Items[I].OnClick, 0, 'MenuItem' + IntToStr(I)));
              // Назначаем иконку для пункта меню
              Items[I].ImageIndex := MRAPopupMenu.Items[I].ImageIndex;
              // Назначаем выделение для пункта меню
              Items[I].default := MRAPopupMenu.Items[I].default;
            end;
        end;
    end
  else if TrayProtoClickMenu = 'jabbertrayicon' then
    begin
      StatusTray1.ImageIndex := JabberToolButton.ImageIndex;
      // Очищаем пункты субменю
      StatusTray1.Clear;
      // Заполняем субменю пунктами из основного ICQ меню
      with StatusTray1 do
        begin
          for I := 0 to JabberPopupMenu.Items.Count - 1 do
            begin
              Add(NewItem(JabberPopupMenu.Items[I].Caption, 0, False, True, JabberPopupMenu.Items[I].OnClick, 0, 'MenuItem' + IntToStr(I)));
              // Назначаем иконку для пункта меню
              Items[I].ImageIndex := JabberPopupMenu.Items[I].ImageIndex;
              // Назначаем выделение для пункта меню
              Items[I].default := JabberPopupMenu.Items[I].default;
            end;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'TwitterHttpClientRequestDone'}

procedure TMainForm.TwitterHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  I, Count: Integer;
  Msg, User_Name: string;
begin
  try
    // Высвобождаем память отправки данных
    if TwitterHttpClient.SendStream <> nil then
      begin
        TwitterHttpClient.SendStream.Free;
        TwitterHttpClient.SendStream := nil;
      end;
    // Читаем полученные http данные из блока памяти
    if TwitterHttpClient.RcvdStream <> nil then
      begin
        // Инициализируем XML
        JvXML_Create(JvXML);
        try
          // Увеличиваем статистику входящего трафика
          TrafRecev := TrafRecev + TwitterHttpClient.RcvdCount;
          AllTrafRecev := AllTrafRecev + TwitterHttpClient.RcvdCount;
          if Assigned(TrafficForm) then
            OpenTrafficClick(nil);
          // Обнуляем позицию начала чтения в блоке памяти
          TwitterHttpClient.RcvdStream.Position := 0;
          // Читаем данные в лист
          with JvXML do
            begin
              LoadFromStream(TwitterHttpClient.RcvdStream);
              // Разбираем данные XML
              Xlog(C_RN + XMLData, EmptyStr);
              // Проверяем на ошибки и отображаем если они есть
              if Root <> nil then
                begin
                  XML_Node := Root.Items.ItemNamed['error'];
                  if XML_Node <> nil then
                    DAShow(S_Errorhead, XML_Node.Value, EmptyStr, 134, 2, 0);
                  // Проверяем на успешную публикацию
                  XML_Node := Root.Items.ItemNamed['created_at'];
                  if XML_Node <> nil then
                    DAShow(S_InfoHead, S_TwitPostOK, EmptyStr, 133, 3, 0);
                  // Начинаем разбор списка
                  if Root.Properties.Value('type') = 'array' then
                    begin
                      Count := Root.Items.Count; // Получаем количество вложенных пакетов
                      for I := 0 to Count - 1 do
                        begin
                          XML_Node := Root.Items[I];
                          if XML_Node <> nil then
                            begin
                              Sub_Node := XML_Node.Items.ItemNamed['text'];
                              if Sub_Node <> nil then
                                begin
                                  Msg := EmptyStr;
                                  Msg := HtmlStrToString(Sub_Node.Value);
                                end;
                              Sub_Node := XML_Node.Items.ItemNamed['user'];
                              if Sub_Node <> nil then
                                begin
                                  Tri_Node := Sub_Node.Items.ItemNamed['name'];
                                  if Tri_Node <> nil then
                                    User_Name := Tri_Node.Value;
                                end;
                              DAShow(User_Name, Msg, EmptyStr, 165, 1, 0);
                            end;
                        end;
                    end;
                end;
            end;
        finally
          JvXML.Free;
          // Высвобождаем блок памяти
          TwitterHttpClient.RcvdStream.Free;
          TwitterHttpClient.RcvdStream := nil;
        end;
      end;
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.TwitterHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (TwitterHttpClient.StatusCode = 0) or (TwitterHttpClient.StatusCode >= 400) then
    begin
      DAShow(S_Errorhead, Format(ErrorHttpClient(TwitterHttpClient.StatusCode), [C_RN]), EmptyStr, 134, 2, 0);
    end;
end;

procedure TMainForm.TwitterSearchMenuClick(Sender: TObject);
begin
  { TODO 2 : Сделать поиск по Twitter }
end;

procedure TMainForm.TwitterSettingsMenuClick(Sender: TObject);
begin
  // Открываем окно настроек ICQ протокола
  if not Assigned(TwitterOptionsForm) then
    TwitterOptionsForm := TTwitterOptionsForm.Create(Self);
  // Отображаем окно
  XShowForm(TwitterOptionsForm);
end;

procedure TMainForm.TwitterToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup(TwitterToolButton, TwitterPopupMenu);
end;

procedure TMainForm.TwitterToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  Popup(TwitterToolButton, TwitterPopupMenu);
end;

{$ENDREGION}
{$REGION 'UniqContactSettingsMenuClick'}

procedure TMainForm.UniqContactSettingsMenuClick(Sender: TObject);
begin
  // Открываем окно уникальных настроек контакта
  if not Assigned(UniqForm) then
    UniqForm := TUniqForm.Create(Self);
  if (ContactList.SelectedItem as TButtonItem).ContactType = C_Icq then
    UniqForm.AccountPanel.Caption := ICQAccountInfo + C_BN + (ContactList.SelectedItem as TButtonItem).UIN
  else if (ContactList.SelectedItem as TButtonItem).ContactType = S_Jabber then
    UniqForm.AccountPanel.Caption := JabberAccountInfo + C_BN + (ContactList.SelectedItem as TButtonItem).UIN;
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

procedure TMainForm.OpenGameMenuClick(Sender: TObject);
begin
  // Открываем в окне чата закладку с играми
  if not Assigned(GamesForm) then
    GamesForm := TGamesForm.Create(self);
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

procedure TMainForm.OpenHistoryClick(Sender: TObject);
begin
  // Открываем пустое окно истории сообщений
  if not Assigned(HistoryForm) then
    HistoryForm := THistoryForm.Create(Self);
  // Отображаем окно
  XShowForm(HistoryForm);
end;

procedure TMainForm.MyLentaTwitterMenuClick(Sender: TObject);
begin
  { // Загружаем свои сообщения
    if (Twit_Login <> EmptyStr) and (Twit_Password <> EmptyStr) then
    begin
    with TwitterHttpClient do
    begin
    Abort;
    Username := Twit_Login;
    Password := Twit_Password;
    URL := Format(C_TwitOpenLenta, [Twit_Login, Twit_MyMess_Count]);
    GetASync;
    end;
    end; }
end;

procedure TMainForm.OpenMyPageMenuClick(Sender: TObject);
begin
  // Открываем страницу пользователя на Twitter
  OpenURL(C_TwitSite + Twit_Login);
end;

procedure TMainForm.UpdateHttpClientSendEnd(Sender: TObject);
begin
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + (Sender as THttpCli).SentCount;
  AllTrafSend := AllTrafSend + (Sender as THttpCli).SentCount;
  if Assigned(TrafficForm) then
    OpenTrafficClick(nil);
end;

{$ENDREGION}
{$REGION 'UpdateHttpClientSessionClosed'}

procedure TMainForm.UpdateHttpClientSessionClosed(Sender: TObject);
var
  S: string;
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (UpdateHttpClient.StatusCode = 0) or (UpdateHttpClient.StatusCode >= 400) then
    begin
      S := Format(ErrorHttpClient(UpdateHttpClient.StatusCode), [C_RN]);
      DAShow(S_Errorhead, S, EmptyStr, 134, 2, 0);
      if Assigned(UpdateForm) then
        UpdateForm.InfoMemo.Lines.Add(C_RN + S);
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.UpdateHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TMainForm.UpdateHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(S_Errorhead, SocketConnErrorInfo_1 + C_RN + Msg + C_RN + Format(HttpSocketErrCodeL, [Error]) + C_RN + '[ ' + SocketL + C_BN + (Sender as THttpCli).name + ' ]', EmptyStr, 134, 2, 0);
    end;
end;

procedure TMainForm.ICQWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(S_Errorhead, NotifyConnectError(C_Icq, WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  ICQ_GoOffline;
end;

procedure TMainForm.MRAWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(S_Errorhead, NotifyConnectError(S_Mra, WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  MRA_GoOffline;
end;

procedure TMainForm.MRAWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + BytesSent;
  AllTrafSend := AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then
    OpenTrafficClick(nil);
end;

procedure TMainForm.MRAWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError(S_Mra, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      MRA_GoOffline;
    end;
end;

procedure TMainForm.MRAWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if (not MRA_Connect_Phaze) and (not MRA_Offline_Phaze) then
    begin
      DAShow(S_Errorhead, NotifyConnectError(S_Mra, ErrCode), EmptyStr, 134, 2, 0);
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
      DAShow(S_Errorhead, NotifyConnectError(S_Mra, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      MRA_GoOffline;
    end;
  // HTTP прокси коннект
  if HttpProxy_Enable then
    begin
      // Составляем адрес
      if MRA_Connect_Phaze then
        Http_data := MRA_LoginServerAddr + ':' + MRA_LoginServerPort
      else
        Http_data := MRA_Bos_IP + ':' + MRA_Bos_Port;
      // Если авторизация на прокси
      if HttpProxy_Auth then
        begin
          Http_login := Base64Encode(HttpProxy_Login + ':' + HttpProxy_Password);
          Http_login := 'Authorization: Basic ' + Http_login + C_RN + 'Proxy-authorization: Basic ' + Http_login + C_RN;
        end;
      // Формируем основной запрос для http прокси
      Http_data := 'CONNECT ' + Http_data + ' HTTP/1.0' + C_RN + 'User-agent: Mozilla/4.08 [en] (WinNT; U)' + C_RN + Http_login + C_RN;
      // Отсылаем запрос для прокси
      MRAWSocket.SendStr(Http_data);
    end;
  // Если уже подключились в Bos серверу
  if MRA_BosConnect_Phaze then
    MRA_Login_1; // Отсылаем первый пакет логина
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMainForm.MRAWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError(S_Mra, ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      MRA_GoOffline;
    end;
end;

procedure TMainForm.MRAWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(S_Errorhead, SocketConnErrorInfo_1 + C_RN + Msg + C_RN + Format(HttpSocketErrCodeL, [Error]) + C_RN + '[ ' + SocketL + C_BN + S_Mra + ' ]', EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      MRA_GoOffline;
    end;
end;

procedure TMainForm.LogFormMenuClick(Sender: TObject);
begin
  // Отображаем окно
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