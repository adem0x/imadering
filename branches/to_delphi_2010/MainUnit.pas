{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MainUnit;

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
  RXML,
  JvHint,
  StrUtils,
  OverbyteIcsMimeUtils,
  StdCtrls,
  Registry,
  ActnList,
  GifImg,
  AppEvnts,
  JclDebug;

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
    CloseProgramTray: TMenuItem;
    N1: TMenuItem;
    SettingsTray: TMenuItem;
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
    HideInTrayTray: TMenuItem;
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
    StatusTray: TMenuItem;
    ContactPopupMenu: TPopupMenu;
    CheckUpdate: TMenuItem;
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
    CheckUpdateMainMenu: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure JvTimerListEvents0Timer(Sender: TObject);
    procedure CloseProgramClick(Sender: TObject);
    procedure HintMaxTime(Sender: TObject);
    procedure MainToolButtonClick(Sender: TObject);
    procedure OpenSettingsClick(Sender: TObject);
    procedure ICQTrayIconClick(Sender: TObject);
    procedure OpenTestClick(Sender: TObject);
    procedure AboutIMaderingClick(Sender: TObject);
    procedure UpdateHttpClientDocBegin(Sender: TObject);
    procedure UpdateHttpClientDocEnd(Sender: TObject);
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
    procedure CheckUpdateClick(Sender: TObject);
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
    procedure MRAAvatarHttpClientSendEnd(Sender: TObject);
    procedure MRAAvatarHttpClientDocEnd(Sender: TObject);
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
    procedure MRAAvatarHttpClientSessionClosed(Sender: TObject);
    procedure ICQWSocketError(Sender: TObject);
    procedure ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure UpdateHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure MRAAvatarHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure MRAAvatarHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
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

  private
    { Private declarations }
    ButtonInd: Integer;
    LastClick: Tdatetime;
    procedure LoadImageList(ImgList: TImageList; FName: string);
    procedure LoadMainFormSettings;
    procedure MainFormHideInTray;
    procedure AppActivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession);
    message WM_QueryEndSession;

  public
    { Public declarations }
    RoasterGroup: TButtonCategory;
    RoasterButton: TButtonItem;
    procedure TranslateForm;
    procedure SaveMainFormSettings;
    procedure ICQEnable(OnOff: Boolean);
    procedure MRAEnable(OnOff: Boolean);
    procedure JabberEnable(OnOff: Boolean);
    procedure OpenFromTrayMessage(HUIN: string);
    procedure FormShowInWorkArea(XForm: TForm);
    procedure FormSetInWorkArea(XForm: TForm);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

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
  EncdDecd,
  ShowCertUnit,
  FileTransferUnit,
  LogUnit;

resourcestring
  StrPluginsFolder = 'Profile\Plugins\';

procedure TMainForm.TrafficONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку трафик на нижней панели
  TrafficONMenu.Checked := not TrafficONMenu.Checked;
  TrafficToolButton.Visible := not TrafficToolButton.Visible;
end;

procedure TMainForm.TranslateForm;
begin
  // Выставляем подсказки к кнопкам
  OnlyOnlineContactsTopButton.Hint := H_OnlyOnline;
  OnlyOnlineContactsToolButton.Hint := H_OnlyOnline;
  GroupOnOffToolTopButton.Hint := H_GroupCL;
  GroupOnOffToolButton.Hint := H_GroupCL;
  SoundOnOffToolTopButton.Hint := H_Sound;
  SoundOnOffToolButton.Hint := H_Sound;
  TopPanelToolButton.Hint := H_TopPanel;
  MainToolButton.Hint := H_Main_Button;
  MainToolTopButton.Hint := H_Main_Button;
  PrivatTopToolButton.Hint := H_Privat_Button;
  PrivatToolButton.Hint := H_Privat_Button;
  HistoryTopToolButton.Hint := H_History_Button;
  HistoryToolButton.Hint := H_History_Button;
  SettingsTopToolButton.Hint := H_Setting_Button;
  SettingsToolButton.Hint := H_Setting_Button;
  TrafficTopToolButton.Hint := H_Traf_Button;
  TrafficToolButton.Hint := H_Traf_Button;
end;

procedure TMainForm.FormShowInWorkArea(XForm: TForm);
var
  FCursor: TPoint;
begin
  // Вычисляем позицию окна от позиции курсора
  GetCursorPos(FCursor);
  with XForm do
  begin
    Top := FCursor.Y - (Height div 2);
    Left := FCursor.X - (Width div 2);
    // Определяем не находится ли окно за пределами экрана
    if Top < Screen.WorkAreaTop then
      Top := Screen.WorkAreaTop;
    if Left + Width > (Screen.WorkAreaLeft + Screen.WorkAreaWidth) then
      Left := (Screen.WorkAreaLeft + Screen.WorkAreaWidth) - Width;
    if Left < Screen.WorkAreaLeft then
      Left := Screen.WorkAreaLeft;
    // Показываем окно доп. статуса
    XShowForm(XForm);
  end;
end;

procedure TMainForm.FormSetInWorkArea(XForm: TForm);
begin
  with XForm do
  begin
    // Определяем не находится ли окно за пределами экрана
    if Top < Screen.WorkAreaTop then
      Top := Screen.WorkAreaTop;
    if Top + Height > (Screen.WorkAreaTop + Screen.WorkAreaHeight) then
      Top := (Screen.WorkAreaTop + Screen.WorkAreaHeight) - Height;
    if Left + Width > (Screen.WorkAreaLeft + Screen.WorkAreaWidth) then
      Left := (Screen.WorkAreaLeft + Screen.WorkAreaWidth) - Width;
    if Left < Screen.WorkAreaLeft then
      Left := Screen.WorkAreaLeft;
  end;
end;

procedure TMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  // Если виндовс выключается, то мы завершаем и программу
  ProgramCloseCommand := True;
  Msg.Result := 1;
end;

procedure TMainForm.ICQEnable(OnOff: Boolean);
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
    RosterForm.ClearICQClick(Self);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientDocEnd(Sender: TObject);
begin
  // Читаем полученные http данные из блока памяти
  if MRAAvatarHttpClient.RcvdStream <> nil then
  begin
    // Увеличиваем статистику входящего трафика
    TrafRecev := TrafRecev + MRAAvatarHttpClient.RcvdCount;
    AllTrafRecev := AllTrafRecev + MRAAvatarHttpClient.RcvdCount;
    if Assigned(TrafficForm) then
      OpenTrafficClick(nil);
    // Обрабатываем полученую MRA аватару

    // Высвобождаем блок памяти
    MRAAvatarHttpClient.RcvdStream.Free;
    MRAAvatarHttpClient.RcvdStream := nil;
  end;
end;

procedure TMainForm.MRAAvatarHttpClientSendEnd(Sender: TObject);
begin
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + MRAAvatarHttpClient.SentCount;
  AllTrafSend := AllTrafSend + MRAAvatarHttpClient.SentCount;
  if Assigned(TrafficForm) then
    OpenTrafficClick(nil);
end;

procedure TMainForm.MRAAvatarHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (MRAAvatarHttpClient.StatusCode = 0) or (MRAAvatarHttpClient.StatusCode >= 400) then
  begin
    DAShow(ErrorHead, ErrorHttpClient(MRAAvatarHttpClient.StatusCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('MRA', ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.MRAEnable(OnOff: Boolean);
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
    // RosterForm.ClearMRAClick(self);
  end;
end;

procedure TMainForm.MRASettingsClick(Sender: TObject);
begin
  // Открываем настройки сети MRA протокола
  if not Assigned(MraOptionsForm) then
    MraOptionsForm := TMraOptionsForm.Create(Self);
  // Отображаем окно
  XShowForm(MraOptionsForm);
end;

procedure TMainForm.MRAStatusOfflineClick(Sender: TObject);
begin
  // Уводим ICQ протокол в оффлайн
  MRA_GoOffline;
  MRA_Reconnect := False;
end;

procedure TMainForm.MRAStatusOnlineClick(Sender: TObject);
begin
  // Если логин ICQ или пароль пустые, то выводим окно настроек для их ввода
  if (MRA_LoginUIN = EmptyStr) or (MRA_LoginPassword = EmptyStr) then
  begin
    // Показываем сообщение об этой ошибке
    DAShow(InformationHead, ICQAccountInfo_1, EmptyStr, 133, 3, 0);
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
  XLog('MRA | ' + Log_Set_Status + TMenuItem(Sender).Caption);
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
    XLog('MRA | ' + Log_Login + ICQ_LoginUIN);
    // Ставим иконки подключения в окне и в трэе
    MRATrayIcon.IconIndex := 168;
    MRAToolButton.ImageIndex := 168;
    // Блокируем контролы логина и пароля ICQ
    if Assigned(MraOptionsForm) then
    begin
      with MraOptionsForm do
      begin
        MRAEmailEdit.Enabled := False;
        MRAEmailEdit.Color := ClBtnFace;
        PassEdit.Enabled := False;
        PassEdit.Color := ClBtnFace;
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
      XLog('MRA | ' + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port);
    end
    else
    begin
      MRAWSocket.Addr := MRA_LoginServerAddr;
      MRAWSocket.Port := MRA_LoginServerPort;
      XLog(Log_MRA_Connect + MRA_LoginServerAddr + ':' + MRA_LoginServerPort);
    end;
    // Прорисовываем интерфэйс
    Update;
    // Подключаем сокет
    MRAWSocket.Connect;
  end;
  // Отправляем статус
  // if MRA_Work_Phaze then ;
end;

procedure TMainForm.JabberEnable(OnOff: Boolean);
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
    RosterForm.ClearJabberClick(Self);
  end;
end;

procedure TMainForm.JabberSearchNewContactClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
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
  Jabber_GoOffline;
  Jabber_Reconnect := False;
end;

procedure TMainForm.JabberStatusOnlineClick(Sender: TObject);
begin
  // Если логин Jabber или пароль пустые, то выводим окно настроек для их ввода
  if (Jabber_JID = EmptyStr) or (Jabber_LoginPassword = EmptyStr) then
  begin
    // Показываем сообщение об этой ошибке
    DAShow(InformationHead, JabberAccountInfo_1, EmptyStr, 133, 3, 0);
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
  XLog('Jabber | ' + Log_Set_Status + TMenuItem(Sender).Caption);
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
    XLog('Jabber | ' + Log_Login + Jabber_JID);
    // Разбираем JID на логин и сервер
    Jabber_LoginUIN := Parse('@', Jabber_JID, 1);
    Jabber_ServerAddr := Parse('@', Jabber_JID, 2);
    // Если сервер и порт указаны вручную
    with JabberOptionsForm do
      if JUseCustomServerSettingsCheckBox.Checked then
      begin
        // Jabber_LoginUIN := Jabber_JID;
        Jabber_ServerAddr := JCustomServerHostEdit.Text;
        Jabber_ServerPort := JCustomServerPortEdit.Text;
      end;
    // Ставим иконки статуса в окне и в трэе
    JabberToolButton.ImageIndex := 168;
    JabberTrayIcon.IconIndex := 168;
    // Блокируем контролы логина и пароля ICQ
    if Assigned(JabberOptionsForm) then
    begin
      with JabberOptionsForm do
      begin
        JabberJIDEdit.Enabled := False;
        JabberJIDEdit.Color := ClBtnFace;
        PassEdit.Enabled := False;
        PassEdit.Color := ClBtnFace;
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
      XLog('Jabber | ' + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port);
    end
    else
    begin
      JabberWSocket.Addr := Jabber_ServerAddr;
      JabberWSocket.Port := Jabber_ServerPort;
      XLog(Log_Jabber_Connect + Jabber_ServerAddr + ':' + Jabber_ServerPort);
    end;
    // Прорисовываем интерфэйс
    Update;
    JabberWSocket.SslEnable := False;
    // Подключаем сокет
    JabberWSocket.Connect;
  end;
  // Отсылаем пакет со статусом
  if Jabber_Work_Phaze then
    Sendflap_jabber(Jabber_SetStatus(Jabber_CurrentStatus));
end;

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
  if RoasterReady then
    RosterForm.UpdateFullCL;
end;

procedure TMainForm.HideInTrayClick(Sender: TObject);
begin
  // Скрываем окно в трэй или наоборот
  MainFormHideInTray;
end;

procedure TMainForm.HintMaxTime(Sender: TObject);
begin
  // Делаем отображение подсказки бесконечным
  Application.HintHidePause := MaxInt;
end;

procedure TMainForm.HistoryContactClick(Sender: TObject);
begin
  // Открываем окно истории
  if not Assigned(HistoryForm) then
    HistoryForm := THistoryForm.Create(Self);
  // Загружаем файл истории для текущего чата
  // HistoryForm.LoadHistoryFromFile(ContactList.SelectedItem.UIN);
  // Отображаем окно
  XShowForm(HistoryForm);
end;

procedure TMainForm.HistoryONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку истории сообщений на нижней панели
  HistoryONMenu.Checked := not HistoryONMenu.Checked;
  HistoryToolButton.Visible := not HistoryToolButton.Visible;
end;

procedure TMainForm.UpdateHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  UpdateHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TMainForm.UpdateHttpClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  // Если был активирован аборт сессии, то выходим и отключаем сокет
  if UpdateHttpClient.Tag = 2 then
  begin
    UpdateHttpClient.CloseAsync;
    UpdateHttpClient.Abort;
  end;
  // Отображаем процесс получения данных
  if Assigned(UpdateForm) then
  begin
    with UpdateForm do
    begin
      if UpdateHttpClient.ContentLength > -1 then
      begin
        LoadSizeLabel.Caption := 'Скачано: ' + FloatToStrF(UpdateHttpClient.RcvdCount / 1000, FfFixed, 7, 1) + ' KB';
        DownloadProgressBar.Max := UpdateHttpClient.ContentLength;
        DownloadProgressBar.Position := UpdateHttpClient.RcvdCount;
      end;
      // Обновляем форму и контролы чтобы видеть изменения
      Update;
    end;
  end;
end;

procedure TMainForm.UpdateHttpClientDocEnd(Sender: TObject);
var
  List: TStringList;
  Ver, Bild, Mess: string;

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
  // Читаем полученные http данные из блока памяти
  if UpdateHttpClient.RcvdStream <> nil then
  begin
    try
      // Увеличиваем статистику входящего трафика
      TrafRecev := TrafRecev + UpdateHttpClient.RcvdCount;
      AllTrafRecev := AllTrafRecev + UpdateHttpClient.RcvdCount;
      if Assigned(TrafficForm) then
        OpenTrafficClick(nil);
      // Определяем выполнение задания для данных по флагу
      case UpdateHttpClient.Tag of
        0:
          begin
            // Создаём временный лист
            List := TStringList.Create;
            try
              // Обнуляем позицию начала чтения в блоке памяти
              UpdateHttpClient.RcvdStream.Position := 0;
              // Читаем данные в лист
              List.LoadFromStream(UpdateHttpClient.RcvdStream);
              // Разбираем данные в листе
              if List.Text > EmptyStr then
              begin
                { ver := IsolateTextString(list.Text, '<v>', '</v>');
                  bild := IsolateTextString(list.Text, '<b>', '</b>');
                  mess := IsolateTextString(list.Text, '<m>', '</m>');
                  //--Запоминаем переменную аддэйтпатч для автообновления
                  UpdateVersionPath := Format(UpdateVersionPath, [ver, bild]);
                  //--Отображаем всплывающее окно с информацией о новой версии
                  if (ver <> EmptyStr) and (bild <> EmptyStr) then
                  begin
                  //--Если версия на сайте выше текущей
                  if StrToInt(ver) > Update_Version then
                  begin
                  DAShow(InformationHead, NewVersionIMaderingYES1, EmptyStr, 133, 3, 100000000);
                  ShowUpdateNote;
                  end
                  //--Если версия таже, но сборка выше текущей
                  else if StrToInt(bild) > StrToInt(Parse('.', InitBuildInfo, 4)) then
                  begin
                  DAShow(InformationHead, NewVersionIMaderingYES2, EmptyStr, 133, 3, 100000000);
                  ShowUpdateNote;
                  end
                  else if not UpdateAuto then DAShow(InformationHead, NewVersionIMaderingNO, EmptyStr, 133, 0, 100000000);
                  end
                  else if not UpdateAuto then DAShow(InformationHead, NewVersionIMaderingErr, EmptyStr, 134, 2, 0); }
              end;
            finally
              List.Free;
            end;
          end;
        1:
          begin
            if Assigned(UpdateForm) then
            begin
              with UpdateForm do
              begin
                // Создаём блок в памяти для приёма файла обновления
                UpdateFile := TMemoryStream.Create;
                try
                  try
                    { // Обнуляем позицию начала чтения в блоке памяти
                      UpdateHttpClient.RcvdStream.Position := 0;
                      // Читаем данные в лист
                      UpdateFile.LoadFromStream(UpdateHttpClient.RcvdStream);
                      // Информируем о успешной закачке файла обновления
                      InfoMemo.Lines.Add(UpDateLoadL);
                      InfoMemo.Lines.Add(UpDateUnL);
                      // Переименовываем файл Imadering.exe
                      if FileExists(MyPath + 'Imadering.exe') then
                      RenameFile(MyPath + 'Imadering.exe', MyPath + 'Imadering.old');
                      // Запускаем установку обновления
                      UnZip_Stream(UpdateFile, MyPath);
                      // Выводим информацию об окончании обновления
                      InfoMemo.Lines.Add(UpDateOKL);
                      AbortBitBtn.Enabled := False; }
                  except
                  end;
                finally
                  // Уничтожаем блок памяти
                  FreeAndNil(UpdateFile);
                end;
              end;
            end;
          end;
        2:
          begin
            // Ничего не делаем с данными
          end;
      end;
    finally
      // Высвобождаем блок памяти
      UpdateHttpClient.RcvdStream.Free;
      UpdateHttpClient.RcvdStream := nil;
    end;
  end;
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
  XLog('ICQ | ' + Log_Set_Status + TMenuItem(Sender).Caption);
  ICQ_GoOffline;
  ICQ_Reconnect := False;
end;

procedure TMainForm.ICQStatusOnlineClick(Sender: TObject);
begin
  try
    // Если логин ICQ или пароль пустые, то выводим окно настроек для их ввода
    if (ICQ_LoginUIN = EmptyStr) or (ICQ_LoginPassword = EmptyStr) then
    begin
      // Показываем сообщение об этой ошибке
      DAShow(InformationHead, ICQAccountInfo_1, EmptyStr, 133, 3, 0);
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
    XLog('ICQ | ' + Log_Set_Status + TMenuItem(Sender).Caption);
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
      XLog('ICQ | ' + Log_Login + ICQ_LoginUIN);
      // Ставим иконки подключения в окне и в трэе
      ICQTrayIcon.IconIndex := 168;
      ICQToolButton.ImageIndex := 168;
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
        XLog('ICQ | ' + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port);
      end
      else
      begin
        ICQWSocket.Addr := ICQ_LoginServerAddr;
        ICQWSocket.Port := ICQ_LoginServerPort;
        XLog(Log_ICQ_Connect + ICQ_LoginServerAddr + ':' + ICQ_LoginServerPort);
      end;
      // Прорисовываем интерфэйс
      Update;
      // Подключаем сокет
      ICQWSocket.Connect;
    end;
    // Отправляем статус
    if ICQ_Work_Phaze then
      SendFLAP('2', ICQ_CreateShortStatusPkt);
  except
    on E: Exception do
      IMaderingEventsException(Self, E);
  end;
end;

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

procedure TMainForm.MainFormHideInTray;
begin
  // Показываем или сворачиваем главное окно
  if Visible then
  begin
    Hide;
    HideInTrayTray.Caption := RestoreFromTrayStr;
    HideInTrayTray.ImageIndex := 5;
  end
  else
  begin
    Show;
    SetForeGroundWindow(Application.MainForm.Handle);
    HideInTrayTray.Caption := HideInTrayStr;
    HideInTrayTray.ImageIndex := 4;
  end;
end;

procedure TMainForm.OpenFromTrayMessage(HUIN: string);
label X;
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
  // -Получаем учётную запись отправителя сообщения с самого низа списка
  MUIN := InMessList.Strings[InMessList.Count - 1];
  // Если она вдруг пустая, то выходим
  if MUIN = EmptyStr then
    Exit;
X :;
  // Открываем чат с этим контактом
  RosterForm.OpenChatPage(MUIN);
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

procedure TMainForm.ICQWSocketDataAvailable(Sender: TObject; ErrCode: Word);
label X, Z;
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
      DAShow(ErrorHead, NotifyConnectError('ICQ', ErrCode), EmptyStr, 134, 2, 0);
      // Активируем режим оффлайн
      ICQ_GoOffline;
    end;
    // HTTP прокси коннект
    if (HttpProxy_Enable) and ((ICQ_Connect_Phaze) or (ICQ_BosConnect_Phaze)) and (not ICQ_HTTP_Connect_Phaze) then
    begin
      // Заносим данные в специальный буфер
      ICQ_myBeautifulSocketBuffer := ICQ_myBeautifulSocketBuffer + Pkt;
      // Если нет ответа нормального от прокси, то выходим
      if Pos(#13#10 + #13#10, ICQ_myBeautifulSocketBuffer) = 0 then
        Exit;
      // Забираем из ответа прокси нужную информацию от прокси
      Pkt := Chop(#13#10 + #13#10, ICQ_myBeautifulSocketBuffer);
      // Обнуляем ошибки прокси
      ProxyErr := 0;
      // Если ответ положительный и прокси установил соединение,
      // то активируем фазу подключения через http прокси
      if AnsiStartsStr('HTTPS/1.0 200', Pkt) or AnsiStartsStr('HTTPS/1.1 200', Pkt) or AnsiStartsStr('HTTP/1.0 200', Pkt) or AnsiStartsStr
        ('HTTP/1.1 200', Pkt) then
      begin
        ICQ_HTTP_Connect_Phaze := True;
        XLog('ICQ get | ' + Log_Proxy_OK);
      end
      else
      // Сообщаем об ошибках прокси
        if AnsiStartsStr('HTTP/1.0 407', Pkt) then
      begin
        ProxyErr := 1;
        DAShow(ErrorHead, ProxyConnectErrL1, EmptyStr, 134, 2, 0);
        XLog('ICQ get | ' + ProxyConnectErrL1);
      end
      else
      begin
        ProxyErr := 2;
        DAShow(ErrorHead, ProxyConnectErrL2, EmptyStr, 134, 2, 0);
        XLog('ICQ get | ' + ProxyConnectErrL2);
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
    // Преобразуем данные из бинарного формата в HEX формат и прибавляем
    // их к специальному буферу накопления таких преобразованных данных
    ICQ_BuffPkt := ICQ_BuffPkt + Pkt;
    // Ищем ошибки в буфере пакетов
    if ((ICQ_BuffPkt > EmptyStr) and (ICQ_BuffPkt[1] <> #$2A)) or
      ((Length(ICQ_BuffPkt) > 2) and ((ICQ_BuffPkt[2] = #$00) or (ICQ_BuffPkt[2] > #$05))) then
    begin
      // Если в пакете есть ошибки, то активируем оффлайн и выводим сообщение об ошибке
      DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
      XLog('ICQ get | ' + ParsingPktError);
      ICQ_GoOffline;
      Exit;
    end;
    // Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
    // для проверки этих данные на наличие слудующего целого пакета данных
  X :;
    PktSize := ICQ_BodySize;
    // Проверяем если ли в буфере хоть один целый пакет
    if (Length(ICQ_BuffPkt) >= ICQ_FLAP_HEAD_SIZE) and (Length(ICQ_BuffPkt) >= ICQ_FLAP_HEAD_SIZE + PktSize) or
      ((ICQ_BuffPkt[2] = #$04) and (PktSize = 0)) then
    begin
      // Забираем из буфера один целый пакет
      HexPkt := NextData(ICQ_BuffPkt, ICQ_FLAP_HEAD_SIZE + PktSize);
      // Пишем в лог данные пакета
      if LogForm.ICQDumpSpeedButton.Down then
        XLog('ICQ get | ' + RN + Trim(Dump(HexPkt)));
      // Разбираем пакет данных если его длинна больше нуля
      if Length(HexPkt) > 0 then
      begin
        // Ещё раз делаем проверку на начало пакета ICQ протокола по метке $2A
        if NextData(HexPkt, 1) = #$2A then
        begin
          // Смотрим какой канал у пакета
          case Ord(HexPkt[1]) of
            $01:
              begin
                XLog('ICQ get | ' + Log_Server_Hello);
                // Пропускаем канал, Seq (счётчик) и длинну пакета
                NextData(HexPkt, 5);
                // Если AOL прислал приглашение и мы в фазе подключения к серверу
                if (ICQ_Connect_Phaze) and (HexPkt = #$00#$00#$00#$01) then
                begin
                  // Тоже отсылаем серверу "привет" + что-то новое в протоколе
                  SendFLAP('1', '00000001' + '8003000400100000');
                  // Отсылаем серверу наш логин
                  SendFLAP('2', '00170006000000000000' + '0001' + IntToHex(Length(ICQ_LoginUIN), 4) + Text2Hex(ICQ_LoginUIN));
                  // Выходим на проверку другого пакета в буфере
                  goto Z;
                end;
                // Если это уже подключение к основному icq серверу
                if (ICQ_BosConnect_Phaze) and (HexPkt = #$00#$00#$00#$01) then
                begin
                  // Отсылаем серверу полученый от логин сервера код авторизации (кукис)
                  SendFLAP('1', ICQ_CliCookiePkt(ICQ_Bos_Cookie));
                end;
              end;
            $02:
              begin
                // Пропускаем канал, Seq (счётчик), длинну пакета и первый символ фэмили
                NextData(HexPkt, 6);
                // Смотрим какая фэмили у пакета
                case Ord(HexPkt[1]) of
                  $01:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $03:
                          begin
                            if ICQ_BosConnect_Phaze then
                            begin
                              // Очищаем группы ICQ в Ростере
                              RosterForm.ClearContacts('Icq');
                              // Пока думаем, что у нас новый (обсолютно чистый) список контактов
                              NewKL := True;
                              ICQ_CL_Count := 0;
                              // Отсылаем серверу пакет с допустимыми для нас фэмили
                              SendFLAP('2', ICQ_CliFamilyPkt);
                            end;
                          end;
                        $05:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с адресом сервера icq аватар
                            // ICQ_Parse_0105(HexPkt);
                          end;
                        $13:
                          begin
                            // Если фаза подключения уже к основному серверу
                            if ICQ_BosConnect_Phaze then
                            begin
                              // Отсылаем стандартные пакеты данных для окончательной авторизации
                              SendFLAP('2', '00010008000000000008' + '00010002000300040005');
                              SendFLAP('2', '0001000E00000000000E');
                              SendFLAP('2', '00130002000000000002' + '000b0002000F');
                              SendFLAP('2', '001300050000344A0005' + '4A32107F003D');
                              SendFLAP('2', '00020002000000000002');
                              SendFLAP('2', '00030002000000000002' + '000500020003');
                              SendFLAP('2', '00040004000000000004');
                              SendFLAP('2', '00090002000000000002');
                            end;
                          end;
                        $15:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с "добрыми" ссылками
                            while Length(HexPkt) > 0 do
                            begin
                              TLV := Text2Hex(NextData(HexPkt, 2)); // Пропускаем TLV
                              Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                              XLog('ICQ parsing | ' + Log_Unk_Data + RN + 'TLV: ' + TLV + ' Value: ' + NextData(HexPkt, Len));
                            end;
                          end;
                        $0F:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с онлайн инфой о нашем подключении и аккаунте
                            ICQ_Parse_010F(HexPkt);
                          end;
                        $21:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Получаем аватар Hash нашего аккаунта
                            if NextData(HexPkt, 2) = #$00#$01 then
                            begin
                              // Пропускаем непонятный 01
                              NextData(HexPkt, 1);
                              // Узнаём длинну Hash
                              { Len := HexToInt(NextData(HexPkt, 2));
                                // Забираем Hash
                                ICQ_MyIcon_Hash := NextData(HexPkt, Len); }
                            end;
                          end;
                      end;
                    end;
                  $02:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $06:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с онлайн инфой о контакте
                            // ICQ_UserOnline_030B(HexPkt, True);
                          end;
                      end;
                    end;
                  $04:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $07:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с сообщением от контакта
                            // ICQ_ReqMessage_0407(HexPkt);
                          end;
                        $14:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с нотификацией о наборе сообщения контактом
                            // ICQ_UserSentTyping_0414(HexPkt);
                          end;
                        $0C:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с сообщением о принятии нашего сообщения сервером
                            // ICQ_SRV_MSGACK_ADVANCED(HexPkt, False);
                          end;
                        $0B:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с сообщением о принятии нашего сообщения контактом
                            // ICQ_SRV_MSGACK_ADVANCED(HexPkt, True);
                          end;
                      end;
                    end;
                  $03:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $0A:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с неизвестным статусом контакта
                            // ICQ_UserUnkStatus_030A(HexPkt);
                          end;
                        $0B:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с онлайн инфой о контакте
                            // ICQ_UserOnline_030B(HexPkt, False);
                          end;
                        $0C:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет с оффлайн инфой о контакте
                            // ICQ_UserOffline_030C(HexPkt);
                          end;
                      end;
                    end;
                  $13:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $01:
                          begin
                            // Если фаза добавления контакта
                            if ICQ_Add_Contact_Phaze then
                            begin
                              // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                              ICQ_AddEnd;
                              ICQ_Add_Contact_Phaze := False;
                              ICQ_SSI_Phaze := False;
                              DAShow(ErrorHead, AddContactError, EmptyStr, 134, 2, 0);
                            end
                            else
                            // Если фаза добавления группы
                              if ICQ_Add_Group_Phaze then
                            begin
                              // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                              ICQ_AddEnd;
                              ICQ_Add_Group_Phaze := False;
                              ICQ_SSI_Phaze := False;
                              DAShow(ErrorHead, AddGroupError, EmptyStr, 134, 2, 0);
                            end
                            else
                            // Если фаза удаления группы
                              if ICQ_Group_Delete_Phaze then
                            begin
                              // Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
                              ICQ_AddEnd;
                              ICQ_Group_Delete_Phaze := False;
                              ICQ_SSI_Phaze := False;
                              DAShow(ErrorHead, DelGroupError, EmptyStr, 134, 2, 0);
                            end;
                          end;
                        $06:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет со списком контактов
                            XLog('ICQ get | ' + Log_Get_CL);
                            if ICQ_Parse_1306(HexPkt) then
                            begin
                              // Запрашиваем нашу инфу обязательно!
                              ICQ_ReqInfo_New_Pkt(ICQ_LoginUIN);
                              // Отсылаем подтверждение получения пакета с контактами
                              SendFLAP('2', '00130007000000000007');
                              // Отсылаем первоначальную онлайн инфу
                              SendFLAP('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr));
                              // Отсылаем параметры ограничений
                              SendFLAP('2', ICQ_CliSetICBMparametersPkt);
                              // Отсылаем первый пакет со статусом
                              SendFLAP('2', ICQ_CliSetFirstStatusPkt);
                              // Отсылаем стандартные параметры клиента
                              SendFLAP('2', ICQ_CliClientReadyPkt);
                              // Отсылаем возможность приёма сообщений от AIM
                              SendFLAP('2', '00040010000000040010');
                              // Отсылаем короткий статус
                              SendFLAP('2', ICQ_CreateShortStatusPkt);
                              // Если ещё есть доп. статус то отсылаем пакеты установки правильного доп. статуса как в ICQ 6
                              if ICQ_X_CurrentStatus > 0 then
                              begin
                                SendFLAP('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr,
                                    EmptyStr, EmptyStr));
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
                        $0E:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Разбираем пакет подтверждения операций со списком контактов
                            // ICQ_Parse_130E_UpdateAck(HexPkt);
                          end;
                      end;
                    end;
                  $15:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $03:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Пропускаем данные о размере пакета и UIN получателя
                            NextData(HexPkt, 10);
                            case HexToInt(Text2Hex(NextData(HexPkt, 2))) of
                              $DA07:
                                begin
                                  // Пропускаем ещё данные о счётчике
                                  NextData(HexPkt, 2);
                                  // Разбираем пакет с инфой для данного UIN
                                  // ICQ_Parse_SNAC_1503(HexPkt);
                                end;
                            end;
                          end;
                      end;
                    end;
                  $17:
                    begin
                      // Пропускаем первый символ субфэмили
                      NextData(HexPkt, 2);
                      // Смотрим какая субфэмили у пакета
                      case Ord(HexPkt[1]) of
                        $07:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Узнаём длинну пакета и увеличиваем её в двое для HEX формата
                            Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                            // Отсылаем логин в формате MD5 шифрования
                            SendFLAP('2', ICQ_MD5CliLoginPkt(ICQ_LoginPassword, NextData(HexPkt, Len)));
                          end;
                        $03:
                          begin
                            // Пропускаем раздел флагов
                            NextData(HexPkt, 7);
                            // Сканируем пакет на наличие нужных нам TLV
                            while Length(HexPkt) > 0 do
                            begin
                              NextData(HexPkt, 1); // Пропускаем первый символ
                              case Ord(HexPkt[1]) of
                                $08:
                                  begin // TLV с ошибкой авторизации
                                    NextData(HexPkt, 1);
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    DAShow(ErrorHead, ICQ_NotifyAuthCookieError(Text2Hex(NextData(HexPkt, Len))), EmptyStr, 134, 2, 0);
                                    ICQ_GoOffline;
                                  end;
                                $05:
                                  begin // TLV с адресом для коннекта к основному серверу
                                    NextData(HexPkt, 1);
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    ICQ_Bos_Addr := NextData(HexPkt, Len);
                                    XLog('ICQ parsing | ' + Log_Get_Server + ICQ_Bos_Addr);
                                    ICQ_Bos_IP := Parse(':', ICQ_Bos_Addr, 1);
                                    ICQ_Bos_Port := Parse(':', ICQ_Bos_Addr, 2);
                                  end;
                                $06:
                                  begin // TLV с куком для коннекта к основному серверу
                                    NextData(HexPkt, 1);
                                    Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                    ICQ_Bos_Cookie := Text2Hex(NextData(HexPkt, Len));
                                    XLog('ICQ parsing | Cookie');
                                  end
                                else // Если пакет содержит другие TLV, то пропускаем их
                                begin
                                  TLV := '00' + Text2Hex(NextData(HexPkt, 1));
                                  Len := HexToInt(Text2Hex(NextData(HexPkt, 2)));
                                  XLog('ICQ parsing | ' + Log_Unk_Data + RN + 'TLV: ' + TLV + ' Value: ' + Trim(Dump(NextData(HexPkt, Len))));
                                end;
                              end;
                            end;
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
                  XLog('ICQ get | ' + Log_Close_Server);
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
                      XLog('ICQ | ' + Log_HTTP_Proxy_Connect + HttpProxy_Address + ':' + HttpProxy_Port);
                    end
                    else
                    begin
                      ICQWSocket.Addr := ICQ_Bos_IP;
                      ICQWSocket.Port := ICQ_Bos_Port;
                      XLog(Log_ICQ_Connect + ICQ_Bos_IP + ':' + ICQ_Bos_Port);
                    end;
                    // Начинаем подключение к основному серверу
                    ICQWSocket.Connect;
                    // Выходим от сюда
                    Exit;
                  end;
                end
                else
                begin
                  // Пропускаем канал, Seq (счётчик), длинну пакета и первый символ фэмили
                  NextData(HexPkt, 6);
                  // Ищем нужные нам TLV
                  case Ord(HexPkt[1]) of
                    $09: // TLV с кодом ошибки
                      begin
                        // Выводим сообщение о том, что наш номер используется кем то другим
                        DAShow(ErrorHead, ICQxUIN, EmptyStr, 134, 2, 100000000);
                        XLog('ICQ get | ' + ICQxUIN);
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
          DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
          XLog('ICQ get | ' + ParsingPktError);
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
    DAShow(ErrorHead, NotifyConnectError('ICQ', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if (not ICQ_Connect_Phaze) and (not ICQ_Offline_Phaze) then
  begin
    DAShow(ErrorHead, NotifyConnectError('ICQ', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
    // Если нужно переподключаться, то активируем этот таймер
    ICQ_Reconnect := True;
  end;
end;

procedure TMainForm.ICQWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  Http_data, Http_login: string;
begin
  // Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('ICQ', ErrCode), EmptyStr, 134, 2, 0);
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
      Http_login := 'Authorization: Basic ' + Http_login + #13#10 + 'Proxy-authorization: Basic ' + Http_login + #13#10;
    end;
    // Формируем основной запрос для http прокси
    Http_data := 'CONNECT ' + Http_data + ' HTTP/1.0' + #13#10 + 'User-agent: Mozilla/4.08 [en] (WinNT; U)' + #13#10 + Http_login + #13#10;
    // Отсылаем запрос для прокси
    ICQWSocket.SendStr(Http_data);
  end;
end;

procedure TMainForm.ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('ICQ', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
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

procedure TMainForm.JabberWSocketDataAvailable(Sender: TObject; ErrCode: Word);
var
  PktZ: RawByteString;
  Pkt, Challenge: string;
  ProxyErr, CntPkt, I: Integer;
begin
  CntPkt := 0;
  // Получаем пришедшие от сервера данные с сокета
  PktZ := JabberWSocket.ReceiveStr;
  // Указываем кодовую страницу UTF-8 для полученных данных
  SetCodePage(PktZ, 65001, False);
  Pkt := PktZ;
  // Пишем в лог данные пакета
  if LogForm.JabberDumpSpeedButton.Down then
    XLog('Jabber get | ' + RN + Trim(Dump(Pkt)));
  // Если при получении данных возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('Jabber', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jabber_GoOffline;
    Exit;
  end;
  // HTTP прокси коннект
  if (HttpProxy_Enable) and (Jabber_Connect_Phaze) and (not Jabber_HTTP_Connect_Phaze) then
  begin
    // Заносим данные в специальный буфер
    Jabber_myBeautifulSocketBuffer := Jabber_myBeautifulSocketBuffer + Pkt;
    // Если нет ответа нормального от прокси, то выходим
    if Pos(#13#10 + #13#10, Jabber_myBeautifulSocketBuffer) = 0 then
      Exit;
    // Забираем из ответа прокси нужную информацию от прокси
    Pkt := Chop(#13#10 + #13#10, Jabber_myBeautifulSocketBuffer);
    // Обнуляем ошибки прокси
    ProxyErr := 0;
    // Если ответ положительный и прокси установил соединение,
    // то активируем фазу подключения через http прокси
    if AnsiStartsStr('HTTPS/1.0 200', Pkt) or AnsiStartsStr('HTTPS/1.1 200', Pkt) or AnsiStartsStr('HTTP/1.0 200', Pkt) or AnsiStartsStr
      ('HTTP/1.1 200', Pkt) then
    begin
      Jabber_HTTP_Connect_Phaze := True;
      XLog('Jabber | ' + Log_Proxy_OK);
    end
    else
    // Сообщаем об ошибках прокси
      if AnsiStartsStr('HTTP/1.0 407', Pkt) then
    begin
      ProxyErr := 1;
      DAShow(ErrorHead, ProxyConnectErrL1, EmptyStr, 134, 2, 0);
      XLog('Jabber | ' + ProxyConnectErrL1);
    end
    else
    begin
      ProxyErr := 2;
      DAShow(ErrorHead, ProxyConnectErrL2, EmptyStr, 134, 2, 0);
      XLog('Jabber | ' + ProxyConnectErrL2);
    end;
    // Забираем из буфера пакет с данными Jabber
    Pkt := Jabber_myBeautifulSocketBuffer;
    // Очищаем буфер
    Jabber_myBeautifulSocketBuffer := EmptyStr;
    // Если в работе с прокси были ошибки, то уходим в оффлайн
    if ProxyErr <> 0 then
    begin
      Jabber_GoOffline;
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
  if Pkt = ('</' + FRootTag + '>') then
  begin
    Jabber_GoOffline;
    Exit;
  end;
  // Буферизируем данные пакетов из сокета и забираем цельные данные
  Jabber_BuffPkt := Jabber_BuffPkt + Pkt;
  repeat
    Pkt := GetFullTag(Jabber_BuffPkt);
    if Pkt <> EmptyStr then
    begin
      if (Pkt[2] <> '?') and (Pkt[2] <> '!') and (BMSearch(0, Pkt, FRootTag) = -1) then
      begin
        // Если это стадия подключения к серверу жаббер
        if Jabber_Connect_Phaze then
        begin
          // Ищем механизм авторизации DIGEST-MD5
          if BMSearch(0, Pkt, '>DIGEST-MD5<') > -1 then
            // Отсылаем запрос challenge
            Sendflap_jabber('<auth xmlns=''urn:ietf:params:xml:ns:xmpp-sasl'' mechanism=''DIGEST-MD5''/>')
            // Если только механизм авторизации PLAIN
          else if BMSearch(0, Pkt, '>PLAIN<') > -1 then
            Sendflap_jabber(Format(JPlainMechanism, [JabberPlain_Auth]))
            // Если получен пакет challenge, то расшифровываем его и отсылаем авторизацию
          else if BMSearch(0, Pkt, '</challenge>') > -1 then
          begin
            // Получаем чистый challenge из пакета и расшифровываем
            Challenge := Base64Decode(IsolateTextString(Pkt, '>', '</challenge>'));
            // Забираем из challenge ключ nonce
            Challenge := IsolateTextString(Challenge, 'nonce="', '"');
            // Если challenge пустой, то значит мы уже авторизовались
            if Challenge = EmptyStr then
              Sendflap_jabber('<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''/>')
            else
              // Отсылаем пакет с авторизацией
              Sendflap_jabber(JabberDIGESTMD5_Auth(Jabber_LoginUIN, Jabber_ServerAddr, Jabber_LoginPassword, Challenge, GetRandomHexBytes
                    (32)));
          end
          else if BMSearch(0, Pkt, '<not-authorized') > -1 then
          begin
            // Отображаем сообщение, что авторизация не пройдена и закрываем сеанс
            DAShow(ErrorHead, JabberLoginErrorL, EmptyStr, 134, 2, 0);
            Jabber_GoOffline;
            Exit;
          end
          else if BMSearch(0, Pkt, '<success') > -1 then
          begin
            // Закрепляем сессию с жаббер сервером
            // Если сервер и порт указаны вручную
            if JabberOptionsForm.JUseCustomServerSettingsCheckBox.Checked then
              Sendflap_jabber(Format(StreamHead, [Parse('@', Jabber_JID, 2)]))
            else
              Sendflap_jabber(Format(StreamHead, [Jabber_ServerAddr]));
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
            // Выходим
            // Очищаем группы Jabber в Ростере
            RosterForm.ClearContacts('Jabber');
            Exit;
          end;
        end;
        // Разбираем пакеты рабочей фазы jabber
        if Jabber_Work_Phaze then
        begin
          // Обрамляем в STREAM для корректной обработки братских узлов парсером
          Pkt := '<istream>' + Pkt + '</istream>';
          // Инициализируем XML
          with TrXML.Create() do
            try
              begin
                // Загружаем пакет в объект xml
                Text := Pkt;
                // Начинаем пробег по возможным склеенным пакетам
                if OpenKey('istream') then
                  try
                    CntPkt := GetKeyCount();
                  finally
                    CloseKey();
                  end;
                for I := 0 to CntPkt - 1 do
                begin
                  if OpenKey('istream\stream:features', False, I) then
                    try
                      Jabber_ParseFeatures(GetKeyXML);
                    finally
                      CloseKey();
                    end
                    // Парсим пакеты iq
                  else if OpenKey('istream\iq', False, I) then
                    try
                      Jabber_ParseIQ(GetKeyXML);
                    finally
                      CloseKey();
                    end
                    // Парсим пакеты presence
                  else if OpenKey('istream\presence', False, I) then
                    try
                      Jabber_ParsePresence(GetKeyXML);
                    finally
                      CloseKey();
                    end
                  else if OpenKey('istream\message', False, I) then
                    try
                      Jabber_ParseMessage(GetKeyXML);
                    finally
                      CloseKey();
                    end;
                end;
              end;
            finally
              Free();
            end;
        end;
      end;
    end;
  until ((Pkt = '') or (Jabber_BuffPkt = ''));
end;

procedure TMainForm.JabberWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(ErrorHead, NotifyConnectError('Jabber', WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  Jabber_GoOffline;
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
    DAShow(ErrorHead, NotifyConnectError('Jabber', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jabber_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if not Jabber_Offline_Phaze then
  begin
    DAShow(ErrorHead, NotifyConnectError('Jabber', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jabber_GoOffline;
    // Если нужно переподключаться, то активируем этот таймер
    Jabber_Reconnect := True;
  end;
end;

procedure TMainForm.JabberWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  Http_data, Http_login: string;
begin
  // Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('Jabber', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jabber_GoOffline;
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
      Http_login := 'Authorization: Basic ' + Http_login + #13#10 + 'Proxy-authorization: Basic ' + Http_login + #13#10;
    end;
    // Формируем основной запрос для http прокси
    Http_data := 'CONNECT ' + Http_data + ' HTTP/1.0' + #13#10 + 'User-agent: Mozilla/4.08 [en] (WinNT; U)' + #13#10 + Http_login + #13#10;
    // Отсылаем запрос для прокси
    JabberWSocket.SendStr(Http_data);
  end;
  // Если активно SSL
  JabberWSocket.SslEnable := Jabber_UseSSL;
  // Отсылаем строку начала сессии с сервером
  // Если сервер и порт указаны вручную
  if JabberOptionsForm.JUseCustomServerSettingsCheckBox.Checked then
    Sendflap_jabber(Format(StreamHead, [Parse('@', Jabber_JID, 2)]))
  else
    Sendflap_jabber(Format(StreamHead, [Jabber_ServerAddr]));
end;

procedure TMainForm.JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('Jabber', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jabber_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    Jabber_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSslVerifyPeer(Sender: TObject;

  var Ok: Integer; Cert: TX509Base);
var
  FrmShowCert: TShowCertForm;
begin
  // Показываем форму принятия сертификата
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

procedure TMainForm.JvTimerListEvents0Timer(Sender: TObject);
begin
  // Отображаем главное окно программы
  Show;
  // Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(Application.MainForm.Handle);
  // Если это первый старт программы то запускаем окно первичной настройки протоколов
  if not FirstStart then
  begin
    // Даём главному окну нормально прорисоваться
    Update;
    // Затем показываем окно начальной настройки протоколов
    FirstStartForm := TFirstStartForm.Create(Self);
    FirstStartForm.Show;
  end;
end;

procedure TMainForm.JvTimerListEvents11Timer(Sender: TObject);
begin
  // Обрабатываем Ростер
  if RoasterReady then
    RosterForm.UpdateFullCL;
end;

procedure TMainForm.JvTimerListEvents12Timer(Sender: TObject);
begin
  // Перерисовываем иконки в трэе против глюка в вайн в линукс
  ICQTrayIcon.Refresh;
  MRATrayIcon.Refresh;
  JabberTrayIcon.Refresh;
end;

procedure TMainForm.JvTimerListEvents1Timer(Sender: TObject);
var
  I, T: Integer;
  YesMsgICQ, YesMsgJabber
  { , YesMsgMRA } : Boolean;
  CLItem: TButtonItem;
  ChatItem: TTabSheet;
begin
  // Отображаем иконки мигающих сообщений и события
  YesMsgICQ := False;
  YesMsgJabber := False;
  // YesMsgMRA := false;
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
          if Items[I].SubItems[3] = 'Icq' then
            YesMsgICQ := True;
          if Items[I].SubItems[3] = 'Jabber' then
            YesMsgJabber := True;
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
  end;
end;

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
  UpdateHttpClient.URL := 'http://imadering.googlecode.com/files/version.txt';
  UpdateHttpClient.GetASync;
end;

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
      ICQTrayIcon.IconIndex := 169;
      ICQToolButton.ImageIndex := 169;
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
      JabberTrayIcon.IconIndex := 169;
      JabberToolButton.ImageIndex := 169;
    end;
  end
  else
  begin
    JabberToolButton.ImageIndex := Jabber_CurrentStatus;
    JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
  end;
  // Останавливаем таймер
  if not NoStopTimer then
    JvTimerList.Events[3].Enabled := False;
end;

procedure TMainForm.JvTimerListEvents4Timer(Sender: TObject);
begin
  // Если функция отключена, то выключаем таймер и выходим
  if not UnstableICQStatus.Checked then
  begin
    JvTimerList.Events[4].Enabled := False;
    // Возвращаем прежнёё значение статуса
    ICQ_CurrentStatus := ICQ_CurrentStatus_bac;
    // Отсылаем короткий пакет статуса
    SendFLAP('2', ICQ_CreateShortStatusPkt);
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
    SendFLAP('2', ICQ_CreateShortStatusPkt);
  end;
end;

procedure TMainForm.JvTimerListEvents5Timer(Sender: TObject);
begin
  // Если не подключена рабочая фаза ICQ, то выключаем таймер
  if not ICQ_Work_Phaze then
  begin
    JvTimerList.Events[5].Enabled := False;
    Exit;
  end;
  // Отсылаем пакет с пингом равным 60 секундам
  SendFLAP('5', '0000003C');
  // Отсылаем пинг для сервера аватар ICQ
  if ICQ_Avatar_Work_Phaze then
    SendFLAP_Avatar('5', '0000003C');
end;

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
  // Запускаем обработку Ростера
  RoasterReady := True;
  RosterForm.UpdateFullCL;
end;

procedure TMainForm.JvTimerListEvents9Timer(Sender: TObject);
begin
  // Если не подключена рабочая фаза Jabber, то выключаем таймер
  if not Jabber_Work_Phaze then
  begin
    JvTimerList.Events[9].Enabled := False;
    Exit;
  end;
  // Отсылаем пакет с пингом равным 60 секундам
  Sendflap_jabber(' ' + #09 + ' ');
end;

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
  XLog(Format(LogIconCount, [AllIconCount]));
end;

procedure TMainForm.MainToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  MainPopupMenu.Alignment := PaLeft;
  Popup(MainToolButton, MainPopupMenu);
end;

procedure TMainForm.MainToolButtonContextPopup(Sender: TObject; MousePos: TPoint;

  var Handled: Boolean);
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

procedure TMainForm.MRAWSocketDataAvailable(Sender: TObject; ErrCode: Word);
label X, Z;
var
  Pkt, HexPkt
  { , SubPkt } : string;
  { PktLen, Len, } ProxyErr, PktSize: Integer;
begin
  // Получаем пришедшие от сервера данные с сокета
  Pkt := MRAWSocket.ReceiveStr;
  // Пишем в лог данные пакета
  if LogForm.MRADumpSpeedButton.Down then
    XLog('MRA get | ' + RN + Trim(Dump(Pkt)));
  // Если при получении данных возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('MRA', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
  // HTTP прокси коннект
  if (HttpProxy_Enable) and ((MRA_Connect_Phaze) or (MRA_BosConnect_Phaze)) and (not MRA_HTTP_Connect_Phaze) then
  begin
    // Заносим данные в специальный буфер
    MRA_myBeautifulSocketBuffer := MRA_myBeautifulSocketBuffer + Pkt;
    // Если нет ответа нормального от прокси, то выходим
    if Pos(#13#10 + #13#10, MRA_myBeautifulSocketBuffer) = 0 then
      Exit;
    // Забираем из ответа прокси нужную информацию от прокси
    Pkt := Chop(#13#10 + #13#10, MRA_myBeautifulSocketBuffer);
    // Обнуляем ошибки прокси
    ProxyErr := 0;
    // Если ответ положительный и прокси установил соединение,
    // то активируем фазу подключения через http прокси
    if AnsiStartsStr('HTTPS/1.0 200', Pkt) or AnsiStartsStr('HTTPS/1.1 200', Pkt) or AnsiStartsStr('HTTP/1.0 200', Pkt) or AnsiStartsStr
      ('HTTP/1.1 200', Pkt) then
    begin
      MRA_HTTP_Connect_Phaze := True;
      XLog('MRA | ' + Log_Proxy_OK);
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
      if AnsiStartsStr('HTTP/1.0 407', Pkt) then
    begin
      ProxyErr := 1;
      DAShow(ErrorHead, ProxyConnectErrL1, EmptyStr, 134, 2, 0);
      XLog('MRA | ' + ProxyConnectErrL1);
    end
    else
    begin
      ProxyErr := 2;
      DAShow(ErrorHead, ProxyConnectErrL2, EmptyStr, 134, 2, 0);
      XLog('MRA | ' + ProxyConnectErrL2);
    end;
    // Забираем из буфера пакет с данными ICQ
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
  // Преобразуем данные из бинарного формата в HEX формат и прибавляем
  // их к специальному буферу накопления таких преобразованных данных
  MRA_HexPkt := MRA_HexPkt + Text2Hex(Pkt);
  // Если фаза первого подключания к серверу MRA
  if MRA_Connect_Phaze then
  begin
    MRA_Bos_Addr := Hex2Text(MRA_HexPkt);
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
    MRA_HexPkt := EmptyStr;
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
  if ((MRA_HexPkt > EmptyStr) and ((LeftStr(MRA_HexPkt, 8)) <> MRA_MagKey)) or
    ((Length(MRA_HexPkt) > 2) and ((HexToInt(MRA_HexPkt[3] + MRA_HexPkt[4]) = $0))) then
  begin
    // Если в пакете есть ошибки, то активируем оффлайн и выводим сообщение об ошибке
    DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
    MRA_GoOffline;
    Exit;
  end;

  // Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
  // для проверки этих данные на наличие слудующего целого пакета данных
X :;
  PktSize := MRA_BodySize;
  // Проверяем если ли в буфере хоть один целый пакет
  if (Length(MRA_HexPkt) >= MRA_FLAP_HEAD_SIZE) and (Length(MRA_HexPkt) >= MRA_FLAP_HEAD_SIZE + PktSize) then
  begin
    // Забираем из буфера один целый пакет
    HexPkt := NextData(MRA_HexPkt, MRA_FLAP_HEAD_SIZE + PktSize);

    { //--Разбираем пакет данных если его длинна больше нуля
      if Length(HexPkt) > 0 then
      begin
      //--Ещё раз делаем проверку на начало пакета ICQ протокола по метке $2A
      if HexToInt(NextData(HexPkt, 2)) = $2A then
      begin
      //--Смотрим какой канал у пакета
      case HexToInt(NextData(HexPkt, 2)) of
      $01:
      begin
      //--Пропускаем Seq (счётчик)
      NextData(HexPkt, 4);
      //--Узнаём длинну пакета и увеличиваем её в двое для HEX формата
      PktLen := HexToInt(NextData(HexPkt, 4));
      PktLen := PktLen * 2;
      //--Получаем тело пакета
      SubPkt := NextData(HexPkt, PktLen);
      //--Если AOL прислал приглашение и мы в фазе подключения к серверу
      if (ICQ_Connect_Phaze) and (SubPkt = '00000001') then
      begin
      //--Тоже отсылаем серверу "привет" + что-то новое в протоколе
      SendFLAP('1', '00000001' + '8003000400100000');
      //--Отсылаем серверу наш логин
      SendFLAP('2', '00170006000000000000' + '0001' +
      IntToHex(Length(ICQ_LoginUIN), 4) + Text2Hex(ICQ_LoginUIN));
      //--Выходим на проверку другого пакета в буфере
      goto z;
      end;
      //--Если это уже подключение к основному icq серверу
      if (ICQ_BosConnect_Phaze) and (SubPkt = '00000001') then
      begin
      //--Отсылаем серверу полученый от логин сервера код авторизации (кукис)
      SendFLAP('1', ICQ_CliCookiePkt(ICQ_Bos_Cookie));
      end;
      end;
      $02:
      begin
      //--Пропускаем Seq (счётчик)
      NextData(HexPkt, 4);
      //--Узнаём длинну пакета и увеличиваем её в двое для HEX формата
      PktLen := HexToInt(NextData(HexPkt, 4));
      PktLen := PktLen * 2;
      //--Получаем тело пакета
      SubPkt := NextData(HexPkt, PktLen);
      //--Смотрим какая фэмили у пакета
      case HexToInt(NextData(SubPkt, 4)) of
      $0001:
      begin
      //--Смотрим какая субфэмили у пакета
      case HexToInt(NextData(SubPkt, 4)) of
      $0003:
      begin
      if ICQ_BosConnect_Phaze then
      begin
      //--Очищаем группы ICQ в Ростере
      RosterForm.ClearContacts('Icq');
      //--Пока думаем, что у нас новый (обсолютно чистый) список контактов
      NewKL := true;
      ICQ_CL_Count := 0;
      //--Отсылаем серверу пакет с допустимыми для нас фэмили
      SendFLAP('2', ICQ_CliFamilyPkt);
      end;
      end;
      $0005:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с адресом сервера icq аватар
      ICQ_Parse_0105(SubPkt);
      end;
      $0013:
      begin
      //--Если фаза подключения уже к основному серверу
      if ICQ_BosConnect_Phaze then
      begin
      //--Отсылаем стандартные пакеты данных для окончательной авторизации
      SendFLAP('2', '00010008000000000008' + '00010002000300040005');
      SendFLAP('2', '0001000E00000000000E');
      SendFLAP('2', '00130002000000000002' + '000b0002000F');
      SendFLAP('2', '001300050000344A0005' + '4A32107F003D');
      SendFLAP('2', '00020002000000000002');
      SendFLAP('2', '00030002000000000002' + '000500020003');
      SendFLAP('2', '00040004000000000004');
      SendFLAP('2', '00090002000000000002');
      end;
      end;
      $000F:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с онлайн инфой о нашем подключении и аккаунте
      ICQ_Parse_010F(SubPkt);
      end;
      $0021:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Получаем аватар Hash нашего аккаунта
      if NextData(SubPkt, 4) = '0001' then
      begin
      //--Пропускаем непонятный 01
      NextData(SubPkt, 2);
      //--Узнаём длинну Hash
      Len := HexToInt(NextData(SubPkt, 2));
      Len := Len * 2;
      //--Забираем Hash
      ICQ_MyIcon_Hash := NextData(SubPkt, Len);
      end;
      end;
      end;
      end;
      $0002:
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $0006:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с онлайн инфой о контакте
      ICQ_UserOnline_030B(SubPkt, true);
      end;
      end;
      end;
      $0004:
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $0007:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с сообщением от контакта
      ICQ_ReqMessage_0407(SubPkt);
      end;
      $0014:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с нотификацией о наборе сообщения контактом
      ICQ_UserSentTyping_0414(SubPkt);
      end;
      $000C:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с сообщением о принятии нашего сообщения сервером
      ICQ_SRV_MSGACK_ADVANCED(SubPkt, false);
      end;
      $000B:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с сообщением о принятии нашего сообщения контактом
      ICQ_SRV_MSGACK_ADVANCED(SubPkt, true);
      end;
      end;
      end;
      $0003:
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $000A:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с неизвестным статусом контакта
      ICQ_UserUnkStatus_030A(SubPkt);
      end;
      $000B:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с онлайн инфой о контакте
      ICQ_UserOnline_030B(SubPkt, false);
      end;
      $000C:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет с оффлайн инфой о контакте
      ICQ_UserOffline_030C(SubPkt);
      end;
      end;
      end;
      $0013:
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $0001:
      begin
      //--Если фаза добавления контакта
      if ICQ_Add_Contact_Phaze then
      begin
      //--Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
      ICQ_AddEnd;
      ICQ_Add_Contact_Phaze := false;
      ICQ_SSI_Phaze := false;
      DAShow(ErrorHead, AddContactError, EmptyStr, 134, 2, 0);
      end else
      //--Если фаза добавления группы
      if ICQ_Add_Group_Phaze then
      begin
      //--Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
      ICQ_AddEnd;
      ICQ_Add_Group_Phaze := false;
      ICQ_SSI_Phaze := false;
      DAShow(ErrorHead, AddGroupError, EmptyStr, 134, 2, 0);
      end else
      //--Если фаза удаления группы
      if ICQ_Group_Delete_Phaze then
      begin
      //--Деактивируем фазу и выводим сообщение об ошибке и разбираем следующий пакет
      ICQ_AddEnd;
      ICQ_Group_Delete_Phaze := false;
      ICQ_SSI_Phaze := false;
      DAShow(ErrorHead, DelGroupError, EmptyStr, 134, 2, 0);
      end;
      end;
      $0006:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет со списком контактов
      if ICQ_Parse_1306(SubPkt) then
      begin
      //--Запрашиваем нашу инфу обязательно!
      ICQ_ReqInfo_New_Pkt(ICQ_LoginUIN);
      //--Отсылаем подтверждение получения пакета с контактами
      SendFLAP('2', '00130007000000000007');
      //--Отсылаем первоначальную онлайн инфу
      SendFLAP('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr));
      //--Отсылаем параметры ограничений
      SendFLAP('2', ICQ_CliSetICBMparametersPkt);
      //--Отсылаем первый пакет со статусом
      SendFLAP('2', ICQ_CliSetFirstStatusPkt);
      //--Отсылаем стандартные параметры клиента
      SendFLAP('2', ICQ_CliClientReadyPkt);
      //--Отсылаем возможность приёма сообщений от AIM
      SendFLAP('2', '00040010000000040010');
      //--Отсылаем короткий статус
      SendFLAP('2', ICQ_CreateShortStatusPkt);
      //--Если ещё есть доп. статус то отсылаем пакеты установки правильного доп. статуса как в ICQ 6
      if ICQ_X_CurrentStatus > 0 then
      begin
      SendFLAP('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr, EmptyStr, EmptyStr));
      ICQ_SetInfoP;
      ICQ_SetStatusXText(ICQ_X_CurrentStatus_Text, ICQ_X_CurrentStatus_Code);
      end;
      //--Включаем фазу Онлайн
      ICQ_Connect_Phaze := false;
      ICQ_HTTP_Connect_Phaze := false;
      ICQ_BosConnect_Phaze := false;
      ICQ_Work_Phaze := true;
      ICQ_Offline_Phaze := false;
      //--Отключаем метку пересоединения ведь мы уже и так онлайн!
      ICQ_Reconnect := false;
      //--Запускаем таймер отсылки пинг пакетов
      if ICQ_KeepAlive then JvTimerList.Events[5].Enabled := true;
      end;
      end;
      $000E:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Разбираем пакет подтверждения операций со списком контактов
      ICQ_Parse_130E_UpdateAck(SubPkt);
      end;
      end;
      end;
      $0015:
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $0003:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Пропускаем данные о размере пакета и UIN получателя
      NextData(SubPkt, 20);
      case HexToInt(NextData(SubPkt, 4)) of
      $DA07:
      begin
      //--Пропускаем ещё данные о счётчике
      NextData(SubPkt, 4);
      //--Разбираем пакет с инфой для данного UIN
      ICQ_Parse_SNAC_1503(SubPkt);
      end;
      end;
      end;
      end;
      end;
      $0017:
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $0007:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Узнаём длинну пакета и увеличиваем её в двое для HEX формата
      Len := HexToInt(NextData(SubPkt, 4));
      Len := Len * 2;
      //--Отсылаем логин в формате MD5 шифрования
      SendFLAP('2', ICQ_MD5CliLoginPkt(Hex2Text(NextData(SubPkt, Len))));
      end;
      $0003:
      begin
      //--Пропускаем раздел флагов
      NextData(SubPkt, 12);
      //--Сканируем пакет на наличие нужных нам TLV
      while Length(SubPkt) > 0 do
      begin
      case HexToInt(NextData(SubPkt, 4)) of
      $0008: //--TLV с ошибкой авторизации
      begin
      Len := HexToInt(NextData(SubPkt, 4));
      Len := Len * 2;
      DAShow(ErrorHead, ICQ_NotifyAuthCookieError(NextData(SubPkt, Len)), EmptyStr, 134, 2, 0);
      ICQ_GoOffline;
      end;
      $0005: //--TLV с адресом для коннекта к основному серверу
      begin
      Len := HexToInt(NextData(SubPkt, 4));
      Len := Len * 2;
      Bos_Addr := Hex2Text(NextData(SubPkt, Len));
      ICQ_Bos_IP := Parse(':', Bos_Addr, 1);
      ICQ_Bos_Port := Parse(':', Bos_Addr, 2);
      end;
      $0006: //--TLV с куком для коннекта к основному серверу
      begin
      Len := HexToInt(NextData(SubPkt, 4));
      Len := Len * 2;
      ICQ_Bos_Cookie := NextData(SubPkt, Len);
      end
      else
      begin
      //--Если пакет содержит другие TLV, то пропускаем их
      Len := HexToInt(NextData(SubPkt, 4));
      Len := Len * 2;
      NextData(SubPkt, Len);
      end;
      end;
      end;
      end;
      end;
      end;
      end;
      end;
      $04:
      begin
      //--Пропускаем Seq (счётчик)
      NextData(HexPkt, 4);
      //--Узнаём длинну пакета
      PktLen := HexToInt(NextData(HexPkt, 4));
      //--Если длинна пакета ноль, то завершаем связь с сервером
      if PktLen = 0 then
      begin
      //--Если сокет ещё подключён, то отсылаем "прощание"
      if ICQWSocket.State = wsConnected then ICQWSocket.SendStr(Hex2Text('2A04' + IntToHex(ICQ_Seq1, 4) + '0000'));
      //--Увеличиваем наш счётчик пакетов на один
      Inc(ICQ_Seq1);
      //--Закрываем сокет и ждём пока он закроется
      ICQWSocket.Close;
      ICQWSocket.WaitForClose;
      //--Если это фаза первичного коннекта
      if ICQ_Connect_Phaze then
      begin
      try
      //--Активируем фазу коннекта к основному серверу
      ICQ_Connect_Phaze := false;
      ICQ_BosConnect_Phaze := true;
      ICQ_HTTP_Connect_Phaze := false;
      //--Устанавливаем параметры
      ICQWSocket.Proto := 'tcp';
      if HttpProxy_Enable then
      begin
      ICQWSocket.Addr := HttpProxy_Address;
      ICQWSocket.Port := HttpProxy_Port;
      end
      else
      begin
      ICQWSocket.Addr := ICQ_Bos_IP;
      ICQWSocket.Port := ICQ_Bos_Port;
      end;
      //--Начинаем подключение к основному серверу
      ICQWSocket.Connect;
      except
      on E: Exception do
      TLogger.Instance.WriteMessage(E);
      end;
      end;
      end
      else
      begin
      //--Если длинна пакета больше нуля, то увеличиваем её вдвое
      PktLen := PktLen * 2;
      //--Получаем тело пакета
      SubPkt := NextData(HexPkt, PktLen);
      //--Ищем нужные нам TLV
      case HexToInt(NextData(SubPkt, 4)) of
      $0009: //--TLV с кодом ошибки
      begin
      //--Выводим сообщение о том, что наш номер используется кем то другим
      DAShow(ErrorHead, ICQxUIN, EmptyStr, 134, 2, 100000000);
      //--Активиуем режим оффлайн
      ICQ_GoOffline;
      end;
      end;
      end;
      end
      else
      //--Если канал пакета вообще другой, то проверяем в буфере другой пакет
      goto z;
      end;
      end
      else
      begin
      //--Если начальная метка пакета не правильная,
      //то выводим сообщение об ошибке разбора и выходим в оффлайн
      DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
      ICQ_GoOffline;
      Exit;
      end;
      end;
      //--Если в конце разбора пакета у нас ещё остались данные, то возвращаемся для проверки буфера
      z: ;
      if Length(ICQ_HexPkt) > 0 then goto x; }
  end;
end;

procedure TMainForm.MRAXStatusClick(Sender: TObject);
begin
  // Открываем окно выбора дополнительного статуса
  if not Assigned(MraXStatusForm) then
    MraXStatusForm := TMraXStatusForm.Create(Self);
  // Отображаем окнов рабочей области
  FormShowInWorkArea(MraXStatusForm);
end;

procedure TMainForm.AddNewContactClick(Sender: TObject);
var
  FrmAddCnt: TIcqAddContactForm;
begin
  // Создаём окно добавления контакта в КЛ
  FrmAddCnt := TIcqAddContactForm.Create(Self);
  try
    { //--Составляем список групп из Ростера
      frmAddCnt.BuildGroupList('Icq');
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
      frmAddCnt.ContactType := 'Icq';
      //--Отображаем окно модально
      frmAddCnt.ShowModal; }
  finally
    FreeAndNil(FrmAddCnt);
  end;
end;

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
    { if ContactList.SelectedItem.ContactType = 'Icq' then
      begin
      if ICQ_Work_Phaze then ICQ_ReqStatus0215(ContactList.SelectedItem.UIN)
      else DAShow(AlertHead, OnlineAlert, EmptyStr, 133, 3, 0);
      end; }
  end;
end;

procedure TMainForm.CheckUpdateClick(Sender: TObject);
begin
  // Запускаем проверку обновлений программы на сайте
  JvTimerListEvents2Timer(nil);
end;

procedure TMainForm.OpenTrafficClick(Sender: TObject);
begin
  // Отображаем окно трафика
  if not Assigned(TrafficForm) then
    TrafficForm := TTrafficForm.Create(Self);
  // Показываем сколько трафика передано за эту сессию
  TrafficForm.CurTrafEdit.Text := FloatToStrF(TrafRecev / 1000, FfFixed, 18, 3) + ' KB | ' + FloatToStrF(TrafSend / 1000, FfFixed, 18, 3)
    + ' KB | ' + DateTimeToStr(SesDataTraf);
  // Показываем сколько трафика передано всего
  TrafficForm.AllTrafEdit.Text := FloatToStrF(AllTrafRecev / 1000000, FfFixed, 18, 3) + ' MB | ' + FloatToStrF
    (AllTrafSend / 1000000, FfFixed, 18, 3) + ' MB | ' + AllSesDataTraf;
  // Отображаем окно
  XShowForm(TrafficForm);
end;

procedure TMainForm.PrivatListMenuClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.PrivatONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку приватных списков на нижней панели
  PrivatONMenu.Checked := not PrivatONMenu.Checked;
  PrivatToolButton.Visible := not PrivatToolButton.Visible;
end;

procedure TMainForm.OpenTestClick(Sender: TObject);
begin
  // Место для запуска тестов
  if not Assigned(ChatForm) then
    ChatForm := TChatForm.Create(Self);
  XShowForm(ChatForm);
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
  if RoasterReady then
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
      // Присваиваем иконку окну
      AllImageList.GetIcon((Sender as TMenuItem).ImageIndex, Icon);
      Caption := (Sender as TMenuItem).Hint;
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

procedure TMainForm.ContactListButtonClicked(Sender: TObject; const Button: TButtonItem);
var
  Diff: Tdatetime;
begin
  // Вычитаем время плошлого клика
  Diff := Now - LastClick;
  // Запоминаем время текущего клика
  LastClick := Now;
  // Если по времени произошёл двойной клик, то начинаем открывать окно чата с этим контактом
  if (Diff < DblClickTime) and (ButtonInd = Button.index) then
  begin
    // Меняем иконку кнопки контакта на его статус
    Button.ImageIndex := Button.Status;
    // Открываем чат с этим контактом
    RosterForm.OpenChatPage(Button.UIN);
  end;
  // Запоминаем индекс кнопки
  ButtonInd := Button.index;
end;

procedure TMainForm.ContactListCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
var
  GroupXml: TrXML;
  Skey: string;
  I: Integer;
begin
  // Запоминаем свёрнутые группы
  GroupXml := TrXML.Create;
  try
    with GroupXml do
    begin
      with ContactList do
      begin
        for I := 0 to Categories.Count - 1 do
        begin
          Skey := 'groups\' + Categories[I].GroupCaption + '-' + Categories[I].GroupType + '-' + Categories[I].GroupId;
          // Запоминаем состояние группы
          if OpenKey(Skey, True) then
            try
              WriteBool('collapsed', Category.Collapsed);
            finally
              CloseKey;
            end;
        end;
      end;
      // Записываем файл
      SaveToFile(ProfilePath + GroupsFileName);
    end;
  finally
    FreeAndNil(GroupXml);
  end;
end;

procedure TMainForm.ContactListContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
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
    if RoasterButton.ContactType = 'Icq' then
    begin
      DelYourSelfContact.Visible := True;
      CheckStatusContact.Visible := True;
      GrandAuthContact.Visible := True;
      SendAddContact.Visible := True;
    end
    // Для Jabber
    else if RoasterButton.ContactType = 'Jabber' then
    begin
      DelYourSelfContact.Visible := False;
      CheckStatusContact.Visible := False;
      GrandAuthContact.Visible := False;
      SendAddContact.Visible := False;
    end
    // Для MRA
    else if RoasterButton.ContactType = 'Mra' then
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
        if RoasterGroup.GroupType = 'Icq' then
        begin
          AddNewGroupICQ.Visible := True;
          AddNewGroupJabber.Visible := False;
          AddNewGroupMRA.Visible := False;
          //
          AddNewContactICQ.Visible := True;
          AddNewContactJabber.Visible := False;
          AddNewContactMRA.Visible := False;
        end
        else if RoasterGroup.GroupType = 'Jabber' then
        begin
          AddNewGroupICQ.Visible := False;
          AddNewGroupJabber.Visible := True;
          AddNewGroupMRA.Visible := False;
          //
          AddNewContactICQ.Visible := False;
          AddNewContactJabber.Visible := True;
          AddNewContactMRA.Visible := False;
        end
        else if RoasterGroup.GroupType = 'Mra' then
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
  // if ContactList.SelectedItem <> nil then SetClipboardText(Handle, ContactList.SelectedItem.UIN);
end;

procedure TMainForm.DeleteContactClick(Sender: TObject);
var
  RosterItem: TListItem;
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
    if RosterItem.SubItems[3] = 'Icq' then
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
    else if RosterItem.SubItems[1] = 'NoCL' then
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
    else if RosterItem.SubItems[3] = 'Jabber' then
    begin

    end
    //--Удаляем по протоколу Mra
    else if RosterItem.SubItems[3] = 'Mra' then
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

procedure TMainForm.DeleteGroupCLClick(Sender: TObject);
label X;
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
    if MessageBox(Handle, PChar(Format(DellGroupL, [GroupName])), PChar((Sender as TMenuItem).Hint),
      MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
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
      if GroupId = 'NoCL' then
      begin
        //
        Exit;
      end;
      // Удаляем выбранную группу ICQ
      if GroupProto = 'Icq' then
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
                if (Items[I].SubItems[3] = 'Icq') and (Items[I].SubItems[1] = '0000') then
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
            if (Items[I].SubItems[3] = 'Icq') and (Length(Items[I].Caption) = 4) and (Items[I].Caption = GroupId) then
            begin
              Items[I].Delete;
              Break;
            end;
          end;
          // Удаляем все контакты из локального Ростера что были в этой группе
        X :;
          for I := 0 to Items.Count - 1 do
          begin
            if (Items[I].SubItems[3] = 'Icq') and (Items[I].SubItems[1] = GroupId) then
            begin
              Items[I].Delete;
              goto X;
            end;
          end;
        end;
      end
      // Удаляем выбранную группу Jabber
      else if GroupProto = 'Jabber' then
      begin

      end
      // Удаляем выбранную группу Mra
      else if GroupProto = 'Mra' then
      begin

      end;
    end;
  finally
    // В любом случае разблокировываем окно контактов
    MainForm.Enabled := True;
  end;
end;

procedure TMainForm.DelYourSelfContactClick(Sender: TObject);
begin
  if ContactList.SelectedItem <> nil then
  begin
    // Блокируем окно контактов
    MainForm.Enabled := False;
    try
      // Выводим вопрос на подтверждение действия
      if MessageBox(Handle, PChar(Format(DellYourSelfL, [ContactList.SelectedItem.Caption])), PChar((Sender as TMenuItem).Hint),
        MB_TOPMOST or MB_YESNO or MB_ICONQUESTION) = MrYes then
        if ICQ_Work_Phaze then
          ICQ_DellMyFromCL((ContactList.SelectedItem as TButtonItem).UIN)
        else
          DAShow(AlertHead, OnlineAlert, EmptyStr, 133, 3, 0);
    finally
      // Разблокировываем окно контактов
      MainForm.Enabled := True;
    end;
  end;
end;

procedure TMainForm.EditContactClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

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

procedure TMainForm.FormClose(Sender: TObject;

  var Action: TCloseAction);
begin
  // Сохраняем настройки окна
  SaveMainFormSettings;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject;

  var CanClose: Boolean);
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
    ICQ_GoOffline;
    Jabber_GoOffline;
    // MRA_GoOffline;
    // Отключаем HTTP сокеты
    UpdateHttpClient.Abort;
    MRAAvatarHttpClient.Abort;
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
    if Assigned(XStatusGif) then
      FreeAndNil(XStatusGif);
    if Assigned(XStatusMem) then
      FreeAndNil(XStatusMem);
    // Уничтожаем окно смайлов
    if Assigned(SmilesForm) then
      FreeAndNil(SmilesForm);
    // Уничтожаем окно чата
    if Assigned(ChatForm) then
      FreeAndNil(ChatForm);
    // Делаем текущую локальную копию списка контактов для отображения при запуске программы
    RosterForm.RosterJvListView.SaveToCSV(ProfilePath + 'Profile\ContactList.txt');
    // Уничтожаем окно Ростера
    if Assigned(RosterForm) then
      FreeAndNil(RosterForm);
  end;
end;

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
        1:
          ContactType := 'Icq';
        2:
          ContactType := 'Jabber';
        3:
          ContactType := 'Mra';
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

procedure TMainForm.AddNewGroupICQClick(Sender: TObject);
var
  FrmAddGroup: TIcqGroupManagerForm;
begin
  // Выводим форму добавления новой группы
  FrmAddGroup := TIcqGroupManagerForm.Create(Self);
  try
    with FrmAddGroup do
    begin
      // Присваиваем иконку окну
      AllImageList.GetIcon((Sender as TMenuItem).ImageIndex, Icon);
      Caption := (Sender as TMenuItem).Hint;
      // Добавляем название группы по умолчанию
      GNameEdit.Text := AddNewGroupL;
      // Ставим флаг, что это добавление новой группы
      Create_Group := True;
      // Ставим флаг какой протокол
      case (Sender as TMenuItem).Tag of
        1:
          GroupType := 'Icq';
        2:
          GroupType := 'Jabber';
        3:
          GroupType := 'Mra';
      end;
      // Отображаем окно модально
      ShowModal;
    end;
  finally
    FreeAndNil(FrmAddGroup);
  end;
end;

procedure TMainForm.AnketaContactClick(Sender: TObject);
begin
  // Отображаем информацию о контакте
  if ContactList.SelectedItem <> nil then
  begin
    if not Assigned(IcqContactInfoForm) then
      IcqContactInfoForm := TIcqContactInfoForm.Create(Self);
    // Присваиваем UIN инфу которого хотим смотреть
    { IcqContactInfoForm.ReqUIN := ContactList.SelectedItem.UIN;
      IcqContactInfoForm.ReqProto := ContactList.SelectedItem.ContactType; }
    // Загружаем информацию о нем
    IcqContactInfoForm.LoadUserUnfo;
    // Отображаем окно
    XShowForm(IcqContactInfoForm);
  end;
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

procedure TMainForm.FormCreate(Sender: TObject);
var
  S: string;
  Buf: array [0 .. $FF] of Char;
  Size: Integer;
begin
  // Самым первым создаём окно лога
  LogForm := TLogForm.Create(Self);
  // Устанавливаем начальное значение ширины окна КЛ
  Width := 199;
  // Узнаём путь откуда запущена программа
  MyPath := ExtractFilePath(Application.ExeName);
  XLog(LogMyPath + MyPath);
  // Смотрим в реестре путь к профилю
  with TRegistry.Create do
    try
      if not OpenKey(ProgramKey, False) then
        ProfilePath := MyPath
      else
        ProfilePath := ReadString(CProfile);
    finally
      Free;
    end;
  if ProfilePath = EmptyStr then
    ProfilePath := MyPath;
  // Если профиль не найден, то создаём его в настройках юзера виндовс
  if not DirectoryExists(ProfilePath + 'Profile') then
  begin
    S := '%APPDATA%\IMadering\';
    Size := ExpandEnvironmentStrings(PChar(S), Buf, Sizeof(Buf));
    ProfilePath := Copy(Buf, 1, Size);
  end;
  XLog(LogProfile + ProfilePath);
  // Временно создаём форму с настройками для применения настроек
  SettingsForm := TSettingsForm.Create(Self);
  SettingsForm.ApplySettings;
  // Устанавливаем языковые подписи
  TranslateForm;
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
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Делаем всплывающие подсказки неисчезающими
  Application.HintHidePause := MaxInt;
  Application.OnHint := HintMaxTime;
  // Заранее подгружаем иконки начальных статусов протоколов в трэй
  AllImageList.GetIcon(9, ICQTrayIcon.Icon);
  AllImageList.GetIcon(23, MRATrayIcon.Icon);
  AllImageList.GetIcon(30, JabberTrayIcon.Icon);
  // Создаём окно Ростера
  RosterForm := TRosterForm.Create(Self);
  // Скрываем кнопку главное меню в верхней панели
  MainToolTopButton.Visible := False;
  // Загружаем настройки окна
  LoadMainFormSettings;
  if AllSesDataTraf = EmptyStr then
    AllSesDataTraf := DateTimeToStr(Now);
  // Если это первый старт программы, то по умолчанию активруем ICQ протокол
  if not FirstStart then
    ICQEnable(True);
  // Если автоматически проверять новые версии при старте
  if SettingsForm.AutoUpdateCheckBox.Checked then
    JvTimerList.Events[2].Enabled := True;
  // Назначаем продвинутые функции активации и деактивации
  Application.OnActivate := AppActivate;
  Application.OnDeactivate := AppDeactivate;
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := True;
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
  // Проверяем если ли старый файл после обновления, если есть, то удаляем
  if FileExists(MyPath + 'Imadering.old') then
    DeleteFile(MyPath + 'Imadering.old');
  // Если не активно запускаться свёрнутой в трэй то показываем клавное окно
  if not SettingsForm.HideInTrayProgramStartCheckBox.Checked then
    JvTimerList.Events[0].Enabled := True;
  // В фоне создаём окно смайлов
  JvTimerList.Events[7].Enabled := True;
  // Инициализируем переменную времени начала статистики трафика сессии
  SesDataTraf := Now;
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  // Включаем прозрачность окна при неактивности
  if RoasterAlphaBlend then
    if AlphaBlendInactive then
      AlphaBlendValue := RoasterAlphaValue;
  // Окно смайлов убрать (глюк в вайн)
  if Assigned(SmilesForm) then
    if SmilesForm.Visible then
      SmilesForm.Close;
end;

procedure TMainForm.GrandAuthContactClick(Sender: TObject);
begin
  // Позволяем добавить нас без повторения запроса на авторизацию нам
  if ContactList.SelectedItem <> nil then
  begin
    { if ICQ_Work_Phaze then ICQ_SendGrandAuth(ContactList.SelectedItem.UIN)
      else DAShow(AlertHead, OnlineAlert, EmptyStr, 133, 3, 0); }
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
  if RoasterReady then
    RosterForm.UpdateFullCL;
end;

procedure TMainForm.GroupOnOffToolTopButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. групп
  GroupOnOffToolButton.Down := not GroupOnOffToolButton.Down;
  GroupOnOffToolButtonClick(Self);
end;

procedure TMainForm.LoadMainFormSettings;
begin
  // Инициализируем XML
  with TrXML.Create() do
    try
      // Загружаем настройки
      if FileExists(ProfilePath + SettingsFileName) then
      begin
        LoadFromFile(ProfilePath + SettingsFileName);
        // Загружаем позицию окна
        if OpenKey('settings\forms\mainform\position') then
          try
            Top := ReadInteger('top');
            Left := ReadInteger('left');
            Height := ReadInteger('height');
            Width := ReadInteger('width');
            // Определяем не находится ли окно за пределами экрана
            FormSetInWorkArea(Self);
          finally
            CloseKey();
          end;
        // Загружаем состояние кнопки звуков
        if OpenKey('settings\forms\mainform\sounds-on-off') then
          try
            if ReadBool('value') then
            begin
              SoundOnOffToolButton.Down := True;
              SoundOnOffToolButtonClick(Self);
            end;
          finally
            CloseKey();
          end;
        // Загружаем состояние кнопки только онлайн
        if OpenKey('settings\forms\mainform\only-online-on-off') then
          try
            if ReadBool('value') then
            begin
              OnlyOnlineContactsToolButton.Down := True;
              OnlyOnlineContactsToolButtonClick(Self);
            end;
          finally
            CloseKey();
          end;
        // Загружаем состояние кнопки отображения групп
        if OpenKey('settings\forms\mainform\group-on-off') then
          try
            if not ReadBool('value') then
            begin
              GroupOnOffToolButton.Down := False;
              GroupOnOffToolButtonClick(Self);
            end;
          finally
            CloseKey();
          end;
        // Загружаем был ли первый старт
        if OpenKey('settings\forms\mainform\first-start') then
          try
            FirstStart := ReadBool('value');
          finally
            CloseKey();
          end;
        // Загружаем выбранные протоколы
        if OpenKey('settings\forms\mainform\proto-select') then
          try
            ICQEnable(ReadBool('icq'));
            MRAEnable(ReadBool('mra'));
            JabberEnable(ReadBool('jabber'));
          finally
            CloseKey;
          end;
        // Загружаем данные трафика
        if OpenKey('settings\traffic') then
          try
            AllTrafSend := ReadFloat('send');
            AllTrafRecev := ReadFloat('recev');
            AllSesDataTraf := ReadString('start-date');
          finally
            CloseKey();
          end;
        // Загружаем пункты меню
        if OpenKey('settings\forms\mainform\hide-empty-group') then
          try
            HideEmptyGroups.Checked := ReadBool('value');
          finally
            CloseKey();
          end;
        // Загружаем состояние верхней панели
        if OpenKey('settings\forms\mainform\top-panel') then
          try
            if not ReadBool('value') then
            begin
              TopPanelToolButton.Down := False;
              TopToolBar.Visible := False;
            end;
            // Загружаем состояние кнопок
            MainToolTopButton.Visible := ReadBool('b0');
            TopMainButtonONMenu.Checked := MainToolTopButton.Visible;
            //
            OnlyOnlineContactsTopButton.Visible := ReadBool('b1');
            TopOnlyOnlineONMenu.Checked := OnlyOnlineContactsTopButton.Visible;
            //
            GroupOnOffToolTopButton.Visible := ReadBool('b2');
            TopGroupONMenu.Checked := GroupOnOffToolTopButton.Visible;
            //
            SoundOnOffToolTopButton.Visible := ReadBool('b3');
            TopSoundsONMenu.Checked := SoundOnOffToolTopButton.Visible;
            //
            PrivatTopToolButton.Visible := ReadBool('b4');
            TopPrivatONMenu.Checked := PrivatTopToolButton.Visible;
            //
            HistoryTopToolButton.Visible := ReadBool('b5');
            TopHistoryONMenu.Checked := HistoryTopToolButton.Visible;
            //
            SettingsTopToolButton.Visible := ReadBool('b6');
            TopSettingsONMenu.Checked := SettingsTopToolButton.Visible;
            //
            TrafficTopToolButton.Visible := ReadBool('b7');
            TopTrafficONMenu.Checked := TrafficTopToolButton.Visible;
          finally
            CloseKey();
          end;
        // Загружаем состояние верхней панели
        if OpenKey('settings\forms\mainform\bottom-panel') then
          try
            // Загружаем состояние кнопок
            MainToolButton.Visible := ReadBool('b0');
            MainButtonONMenu.Checked := MainToolButton.Visible;
            //
            OnlyOnlineContactsToolButton.Visible := ReadBool('b1');
            OnlyOnlineONMenu.Checked := OnlyOnlineContactsToolButton.Visible;
            //
            GroupOnOffToolButton.Visible := ReadBool('b2');
            GroupONMenu.Checked := GroupOnOffToolButton.Visible;
            //
            SoundOnOffToolButton.Visible := ReadBool('b3');
            SoundsONMenu.Checked := SoundOnOffToolButton.Visible;
            //
            PrivatToolButton.Visible := ReadBool('b4');
            PrivatONMenu.Checked := PrivatToolButton.Visible;
            //
            HistoryToolButton.Visible := ReadBool('b5');
            HistoryONMenu.Checked := HistoryToolButton.Visible;
            //
            SettingsToolButton.Visible := ReadBool('b6');
            SettingsONMenu.Checked := SettingsToolButton.Visible;
            //
            TrafficToolButton.Visible := ReadBool('b7');
            TrafficONMenu.Checked := TrafficToolButton.Visible;
            //
            TopPanelToolButton.Visible := ReadBool('b8');
            TopPanelONMenu.Checked := TopPanelToolButton.Visible;
          finally
            CloseKey();
          end;
      end;
    finally
      Free();
    end;
end;

procedure TMainForm.SaveMainFormSettings;
var
  I: Integer;
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile\');
  // Сохраняем настройки положения главного окна в xml
  with TrXML.Create() do
    try
      if FileExists(ProfilePath + SettingsFileName) then
        LoadFromFile(ProfilePath + SettingsFileName);
      // Сохраняем позицию окна
      if OpenKey('settings\forms\mainform\position', True) then
        try
          WriteInteger('top', Top);
          WriteInteger('left', Left);
          WriteInteger('height', Height);
          WriteInteger('width', Width);
        finally
          CloseKey();
        end;
      // Сохраняем звук вкл. выкл.
      if OpenKey('settings\forms\mainform\sounds-on-off', True) then
        try
          WriteBool('value', SoundOnOffToolButton.Down);
        finally
          CloseKey();
        end;
      // Сохраняем отображать только онлайн вкл. выкл.
      if OpenKey('settings\forms\mainform\only-online-on-off', True) then
        try
          WriteBool('value', OnlyOnlineContactsToolButton.Down);
        finally
          CloseKey();
        end;
      // Сохраняем отображать группы вкл. выкл.
      if OpenKey('settings\forms\mainform\group-on-off', True) then
        try
          WriteBool('value', GroupOnOffToolButton.Down);
        finally
          CloseKey();
        end;
      // Записываем что первый запуск программы уже состоялся и показывать
      // окно настройки протоколов больше не будем при запуске
      if OpenKey('settings\forms\mainform\first-start', True) then
        try
          WriteBool('value', True);
        finally
          CloseKey();
        end;
      // Сохраняем активные протоколы
      if OpenKey('settings\forms\mainform\proto-select', True) then
        try
          WriteBool('icq', ICQToolButton.Visible);
          WriteBool('mra', MRAToolButton.Visible);
          WriteBool('jabber', JabberToolButton.Visible);
        finally
          CloseKey();
        end;
      // Сохраняем трафик
      if OpenKey('settings\traffic', True) then
        try
          WriteFloat('send', AllTrafSend);
          WriteFloat('recev', AllTrafRecev);
          WriteString('start-date', AllSesDataTraf);
        finally
          CloseKey();
        end;
      // Сохраняем пункты меню
      if OpenKey('settings\forms\mainform\hide-empty-group', True) then
        try
          WriteBool('value', HideEmptyGroups.Checked);
        finally
          CloseKey();
        end;
      // Сохраняем состояние верхней панели
      if OpenKey('settings\forms\mainform\top-panel', True) then
        try
          WriteBool('value', TopPanelToolButton.Down);
          for I := 0 to TopPanelPopupMenu.Items.Count - 1 do
            WriteBool('b' + IntToStr(I), TopPanelPopupMenu.Items[I].Checked);
        finally
          CloseKey();
        end;
      // Сохраняем состояние нижней панели
      if OpenKey('settings\forms\mainform\bottom-panel', True) then
        try
          for I := 0 to BottomPanelPopupMenu.Items.Count - 1 do
            WriteBool('b' + IntToStr(I), BottomPanelPopupMenu.Items[I].Checked);
        finally
          CloseKey();
        end;
      // Записываем сам файл
      SaveToFile(ProfilePath + SettingsFileName);
    finally
      Free();
    end;
end;

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
    { if ICQ_Work_Phaze then ICQ_SendYouAdded(ContactList.SelectedItem.UIN)
      else DAShow(AlertHead, OnlineAlert, EmptyStr, 133, 3, 0); }
  end;
end;

procedure TMainForm.SendFileUpWapruClick(Sender: TObject);
var
  Fsize: Longint;
begin
  { if NotProtoOnline(ContactList.SelectedItem.ContactType) then Exit;
    //--Открываем форму отправки файлов
    if not Assigned(FileTransferForm) then FileTransferForm := TFileTransferForm.Create(self);
    //--Присваиваем переменную способа передачи
    with FileTransferForm do
    begin
    Tag := (Sender as TMenuItem).Tag;
    TopInfoPanel.Caption := FileTransfer1L + ' ' + ContactList.SelectedItem.Caption;
    TopInfoPanel.Hint := ContactList.SelectedItem.UIN;
    BottomInfoPanel.Hint := ContactList.SelectedItem.ContactType;
    //--Открываем диалог выбора файла для передачи
    if SendFileOpenDialog.Execute then
    begin
    FileNamePanel.Hint := SendFileOpenDialog.FileName;
    FileSizePanel.Hint := GetFileFName(SendFileOpenDialog.FileName);
    FileNamePanel.Caption := ' ' + FileSizePanel.Hint;
    //--Вычисляем размер файла
    fsize := GetFileSize(SendFileOpenDialog.FileName);
    if fsize > 1000000 then
    FileSizePanel.Caption := FloatToStrF(fsize / 1000000, ffFixed, 18, 3) + ' MB'
    else FileSizePanel.Caption := FloatToStrF(fsize / 1000, ffFixed, 18, 3) + ' KB';
    //--Отображаем окно
    xShowForm(FileTransferForm);
    end;
    end; }
end;

procedure TMainForm.SendInviteContactClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.SendMessageForContactClick(Sender: TObject);
begin
  // Вызываем событие клика по кнопке КЛ
  if ContactList.SelectedItem <> nil then
  begin
    // Делаем двойной клик по контакту
    // ContactListButtonClicked(self, ContactList.SelectedItem);
    // ContactListButtonClicked(self, ContactList.SelectedItem);
  end;
end;

procedure TMainForm.SettingsONMenuClick(Sender: TObject);
begin
  // Скрываем кнопку настройки на нижней панели
  SettingsONMenu.Checked := not SettingsONMenu.Checked;
  SettingsToolButton.Visible := not SettingsToolButton.Visible;
end;

procedure TMainForm.SoundOnOffToolButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. звуков
  if SoundOnOffToolButton.Down then
  begin
    SoundOnOffToolTopButton.Down := True;
    SoundOnOffToolButton.ImageIndex := 136;
    SoundOnOffToolTopButton.ImageIndex := 136;
  end
  else
  begin
    SoundOnOffToolTopButton.Down := False;
    SoundOnOffToolButton.ImageIndex := 135;
    SoundOnOffToolTopButton.ImageIndex := 135;
  end;
end;

procedure TMainForm.SoundOnOffToolTopButtonClick(Sender: TObject);
begin
  // Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. звуков
  SoundOnOffToolButton.Down := not SoundOnOffToolButton.Down;
  SoundOnOffToolButtonClick(Self);
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

procedure TMainForm.TrayPopupMenuPopup(Sender: TObject);
var
  I: Integer;
begin
  // Определяем какой протокол в трэе вызвал это меню и назначаем
  // соответствующую иконку и таг для идентификации на пуект меню выбора статуса
  if TrayProtoClickMenu = 'icqtrayicon' then
  begin
    StatusTray.ImageIndex := ICQToolButton.ImageIndex;
    // Очищаем пункты субменю
    StatusTray.Clear;
    // Заполняем субменю пунктами из основного ICQ меню
    with StatusTray do
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
    StatusTray.ImageIndex := MRAToolButton.ImageIndex;
    // Очищаем пункты субменю
    StatusTray.Clear;
    // Заполняем субменю пунктами из основного ICQ меню
    with StatusTray do
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
    StatusTray.ImageIndex := JabberToolButton.ImageIndex;
    // Очищаем пункты субменю
    StatusTray.Clear;
    // Заполняем субменю пунктами из основного ICQ меню
    with StatusTray do
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

procedure TMainForm.UpdateHttpClientSendEnd(Sender: TObject);
begin
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + UpdateHttpClient.SentCount;
  AllTrafSend := AllTrafSend + UpdateHttpClient.SentCount;
  if Assigned(TrafficForm) then
    OpenTrafficClick(nil);
end;

procedure TMainForm.UpdateHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (UpdateHttpClient.StatusCode = 0) or (UpdateHttpClient.StatusCode >= 400) then
  begin
    DAShow(ErrorHead, ErrorHttpClient(UpdateHttpClient.StatusCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.UpdateHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('Update', ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.UpdateHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.ICQWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(ErrorHead, NotifyConnectError('ICQ', WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  // Активируем режим оффлайн
  ICQ_GoOffline;
end;

procedure TMainForm.MRAWSocketError(Sender: TObject);
begin
  // Отображаем ошибки сокета
  DAShow(ErrorHead, NotifyConnectError('MRA', WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
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
    DAShow(ErrorHead, NotifyConnectError('MRA', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
end;

procedure TMainForm.MRAWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  // Если при отключении возникла ошибка, то сообщаем об этом
  if (not MRA_Connect_Phaze) and (not MRA_Offline_Phaze) then
  begin
    DAShow(ErrorHead, NotifyConnectError('MRA', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
    // Если нужно переподключаться, то активируем этот таймер
    MRA_Reconnect := True;
  end;
end;

procedure TMainForm.MRAWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  Http_data, Http_login: string;
begin
  // Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('MRA', ErrCode), EmptyStr, 134, 2, 0);
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
      Http_login := 'Authorization: Basic ' + Http_login + #13#10 + 'Proxy-authorization: Basic ' + Http_login + #13#10;
    end;
    // Формируем основной запрос для http прокси
    Http_data := 'CONNECT ' + Http_data + ' HTTP/1.0' + #13#10 + 'User-agent: Mozilla/4.08 [en] (WinNT; U)' + #13#10 + Http_login + #13#10;
    // Отсылаем запрос для прокси
    MRAWSocket.SendStr(Http_data);
  end;
end;

procedure TMainForm.MRAWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, NotifyConnectError('MRA', ErrCode), EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
end;

procedure TMainForm.MRAWSocketSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
    // Активируем режим оффлайн
    MRA_GoOffline;
  end;
end;

procedure TMainForm.LogFormMenuClick(Sender: TObject);
begin
  // Отображаем окно
  XShowForm(LogForm);
end;

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

end.
