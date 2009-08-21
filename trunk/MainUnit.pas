{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, CategoryButtons, ExtCtrls, Menus, ImgList,
  JvTimerList, OverbyteIcsWndControl, OverbyteIcsWSocket, OverbyteIcsHttpProt,
  rXML, JvHint, IdBaseComponent, IdThreadComponent, StrUtils, OverbyteIcsLogger,
  OverbyteIcsMimeUtils, StdCtrls;

type
  TMainForm = class(TForm)
    ContactList: TCategoryButtons;
    ToolBar2: TToolBar;
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
    JabberWSocket: TWSocket;
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
    AddNewGroupCL: TMenuItem;
    RenemeGroupCL: TMenuItem;
    DeleteGroupCL: TMenuItem;
    N20: TMenuItem;
    SearchInCL: TMenuItem;
    N18: TMenuItem;
    AddNewContactCL: TMenuItem;
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
    FrandAuthContact: TMenuItem;
    SendAddContact: TMenuItem;
    DelYourSelfContact: TMenuItem;
    SendInviteContact: TMenuItem;
    N24: TMenuItem;
    ZipHistoryThread: TIdThreadComponent;
    OpenHistory: TMenuItem;
    WIcsLogger: TIcsLogger;
    OpenTraffic: TMenuItem;
    OpenSocketLog: TMenuItem;
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
    procedure ICQTrayIconMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
    procedure MainToolButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ICQToolButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure MRAToolButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure JabberToolButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ContactListHotButton(Sender: TObject; const Button: TButtonItem);
    procedure ContactListContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ContactListButtonClicked(Sender: TObject;
      const Button: TButtonItem);
    procedure SendMessageForContactClick(Sender: TObject);
    procedure JvTimerListEvents1Timer(Sender: TObject);
    procedure CheckStatusContactClick(Sender: TObject);
    procedure AnketaContactClick(Sender: TObject);
    procedure HistoryContactClick(Sender: TObject);
    procedure CopyAccountContactClick(Sender: TObject);
    procedure OpenGroupsCLClick(Sender: TObject);
    procedure CloseGroupsCLClick(Sender: TObject);
    procedure AddNewGroupCLClick(Sender: TObject);
    procedure RenemeGroupCLClick(Sender: TObject);
    procedure DeleteGroupCLClick(Sender: TObject);
    procedure SearchInCLClick(Sender: TObject);
    procedure AddNewContactCLClick(Sender: TObject);
    procedure EditContactClick(Sender: TObject);
    procedure DeleteContactClick(Sender: TObject);
    procedure FrandAuthContactClick(Sender: TObject);
    procedure SendAddContactClick(Sender: TObject);
    procedure DelYourSelfContactClick(Sender: TObject);
    procedure SendInviteContactClick(Sender: TObject);
    procedure UnstableICQStatusClick(Sender: TObject);
    procedure ZipHistoryThreadRun(Sender: TIdThreadComponent);
    procedure OpenHistoryClick(Sender: TObject);
    procedure WIcsLoggerIcsLogEvent(Sender: TObject; LogOption: TLogOption;
      const Msg: string);
    procedure OpenSocketLogClick(Sender: TObject);
    procedure OpenTrafficClick(Sender: TObject);
    procedure UpdateHttpClientSendEnd(Sender: TObject);
    procedure MRAAvatarHttpClientSendEnd(Sender: TObject);
    procedure MRAAvatarHttpClientDocEnd(Sender: TObject);
    procedure ICQWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure UpdateHttpClientDocData(Sender: TObject; Buffer: Pointer;
      Len: Integer);
    procedure JabberWSocketSendData(Sender: TObject; BytesSent: Integer);
    procedure JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure JvTimerListEvents4Timer(Sender: TObject);
    procedure JvTimerListEvents3Timer(Sender: TObject);
    procedure JvTimerListEvents5Timer(Sender: TObject);
    procedure JvTimerListEvents6Timer(Sender: TObject);
    procedure JvTimerListEvents7Timer(Sender: TObject);
    procedure JvTimerListEvents8Timer(Sender: TObject);
    procedure JabberStatusOfflineClick(Sender: TObject);
    procedure JabberStatusOnlineClick(Sender: TObject);
    procedure ICQWSocketSocksError(Sender: TObject; Error: Integer;
      Msg: string);
    procedure JabberWSocketSocksError(Sender: TObject; Error: Integer;
      Msg: string);
    procedure UpdateHttpClientSocksError(Sender: TObject; Error: Integer;
      Msg: string);
    procedure UpdateHttpClientSessionClosed(Sender: TObject);
    procedure MRAAvatarHttpClientSessionClosed(Sender: TObject);
    procedure ICQWSocketError(Sender: TObject);
    procedure ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure UpdateHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure MRAAvatarHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure MRAAvatarHttpClientSocksError(Sender: TObject; Error: Integer;
      Msg: string);
    procedure JabberWSocketError(Sender: TObject);
    procedure JabberWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
    procedure JvTimerListEvents9Timer(Sender: TObject);
  private
    { Private declarations }
    ButtonInd: integer;
    lastClick: Tdatetime;
    procedure LoadImageList(ImgList: TImageList; FName: string);
    procedure LoadMainFormSettings;
    //procedure LoadProxySettings;
    //procedure SetProxySettings;
    procedure MainFormHideInTray;
    procedure AppActivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession); message WM_QueryEndSession;
  public
    { Public declarations }
    RoasterGroup: TButtonCategory;
    RoasterButton: TButtonItem;
    procedure SaveMainFormSettings;
    procedure ICQEnable(OnOff: boolean);
    procedure MRAEnable(OnOff: boolean);
    procedure JabberEnable(OnOff: boolean);
    procedure OpenFromTrayMessage(hUIN: string);
    procedure ZipHistory;
    procedure LoadContactList;
    procedure SaveContactList;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  VarsUnit, SettingsUnit, AboutUnit, UtilsUnit, IcqOptionsUnit, IcqXStatusUnit,
  MraXStatusUnit, FirstStartUnit, IcqProtoUnit, IcqContactInfoUnit,
  MraOptionsUnit, JabberOptionsUnit, ChatUnit, SmilesUnit, IcqReqAuthUnit,
  HistoryUnit, Code, CLSearchUnit, IcsLogUnit, TrafficUnit, UpdateUnit,
  JabberProtoUnit, MraProtoUnit;

procedure TMainForm.ZipHistory;
var
  i, ii: integer;
  ListF: TStringList;
begin
  //--В цикле проверяем у каких контактов добавилась история сообщений
  //и сжимаем её и сохраняем в файл
  //--Создаём необходимые папки
  ForceDirectories(MyPath + 'Profile\History\Unzip');
  //--Создаём временный лист для файла
  ListF := TStringList.Create;
  try
    try
      with ContactList do
      begin
        for i := 0 to Categories.Count - 1 do
        begin
          for ii := 0 to Categories[i].Items.Count - 1 do
          begin
            //--Если история этого контакта менялась и не пустая
            if (Categories[i].Items[ii].HistoryChange) and (Categories[i].Items[ii].History <> EmptyStr) then
            begin
              //--Записываем в лист историю этого контакта
              ListF.Text := Categories[i].Items[ii].History;
              //--Сохраняем файл во временный каталог
              ListF.SaveToFile(MyPath + 'Profile\History\Unzip\Icq_History.htm');
              //--Очишаем лист
              ListF.Clear;
              //--Добавляем в лист путь к файлу
              ListF.Add(MyPath + 'Profile\History\Unzip\Icq_History.htm');
              //--Сжимаем этот файл и ложим в эту же директорию
              Zip_File(ListF, MyPath + 'Profile\History\' + Categories[i].Items[ii].ContactType + '_' + Categories[i].Items[ii].UIN + '.z');
              //--Удаляем несжатый файл
              if FileExists(MyPath + 'Profile\History\Unzip\Icq_History.htm') then
                DeleteFile(MyPath + 'Profile\History\Unzip\Icq_History.htm');
              //--Снимаем у этого контакта флаг о изменившейся истории
              Categories[i].Items[ii].HistoryChange := false;
            end;
          end;
        end;
      end;
    except
    end;
  finally
    ListF.Free;
  end;
  //--Удаляем директорию хранения временных файлов истории
  if DirectoryExists(MyPath + 'Profile\History\Unzip') then RemoveDir(MyPath + 'Profile\History\Unzip');
  //--Останавливаем поток после сжатия всех необходимых файлов с историей
  ZipHistoryThread.Stop;
end;

procedure TMainForm.WIcsLoggerIcsLogEvent(Sender: TObject;
  LogOption: TLogOption; const Msg: string);
begin
  //--Заносим лог всех событий работые сокетов в окно просмотра логера
  //--Записываем в него только если окно лога открыто
  if Assigned(IcsLogForm) then
  begin
    if (IcsLogForm.SocketComboBox.ItemIndex > 0) and
      (IcsLogForm.LogEnableCheckBox.Enabled) then IcsLogForm.IcsLogMemo.Lines.Add(Msg);
  end;
  //SendMessage(IcsLogForm.IcsLogMemo.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TMainForm.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  //--Если виндовс выключается, то мы завершаем и программу
  ProgramCloseCommand := true;
  Msg.Result := 1;
end;

procedure TMainForm.ZipHistoryThreadRun(Sender: TIdThreadComponent);
begin
  //--Запускаем выполнение процедуры в потоке
  MainForm.ZipHistory;
end;

procedure TMainForm.ICQEnable(OnOff: boolean);
begin
  if OnOff then
  begin
    //--Инициализируем окно настроек протокола ICQ
    if not Assigned(IcqOptionsForm) then IcqOptionsForm := TIcqOptionsForm.Create(self);
    //--Ставим иконки в окне контактов и в трэе
    ICQTrayIcon.Visible := true;
    ICQToolButton.Visible := true;
  end
  else
  begin
    //--Прячем иконки в окне контактов и в трэе
    ICQTrayIcon.Visible := false;
    ICQToolButton.Visible := false;
    //--Высвобождаем окно настроек протокола ICQ
    if Assigned(IcqOptionsForm) then FreeAndNil(IcqOptionsForm);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientDocEnd(Sender: TObject);
begin
  //--Читаем полученные http данные из блока памяти
  if MRAAvatarHttpClient.RcvdStream <> nil then
  begin
    //--Увеличиваем статистику входящего трафика
    TrafRecev := TrafRecev + MRAAvatarHttpClient.RcvdCount;
    AllTrafRecev := AllTrafRecev + MRAAvatarHttpClient.RcvdCount;
    if Assigned(TrafficForm) then OpenTrafficClick(nil);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientSendEnd(Sender: TObject);
begin
  //--Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + MRAAvatarHttpClient.SentCount;
  AllTrafSend := AllTrafSend + MRAAvatarHttpClient.SentCount;
  if Assigned(TrafficForm) then OpenTrafficClick(nil);
end;

procedure TMainForm.MRAAvatarHttpClientSessionClosed(Sender: TObject);
begin
  //--Обрабатываем возможные ошибки в работе http сокета
  if (MRAAvatarHttpClient.StatusCode = 0) or (MRAAvatarHttpClient.StatusCode >= 400) then
  begin
    DAShow(ErrorHead, ErrorHttpClient(MRAAvatarHttpClient.StatusCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientSocksConnected(Sender: TObject;
  ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.MRAAvatarHttpClientSocksError(Sender: TObject;
  Error: Integer; Msg: string);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.MRAEnable(OnOff: boolean);
begin
  if OnOff then
  begin
    //--Инициализируем окно настроек протокола MRA
    if not Assigned(MraOptionsForm) then MraOptionsForm := TMraOptionsForm.Create(self);
    //--Ставим иконки в окне контактов и в трэе
    MRATrayIcon.Visible := true;
    MRAToolButton.Visible := true;
  end
  else
  begin
    //--Прячем иконки в окне контактов и в трэе
    MRATrayIcon.Visible := false;
    MRAToolButton.Visible := false;
    //--Высвобождаем окно настроек протокола MRA
    if Assigned(MraOptionsForm) then FreeAndNil(MraOptionsForm);
  end;
end;

procedure TMainForm.MRASettingsClick(Sender: TObject);
begin
  //--Открываем настройки сети MRA протокола
  if not Assigned(MraOptionsForm) then MraOptionsForm := TMraOptionsForm.Create(self);
  MraOptionsForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(MraOptionsForm.Handle);
end;

procedure TMainForm.JabberEnable(OnOff: boolean);
begin
  if OnOff then
  begin
    //--Инициализируем окно настроек протокола Jabber
    if not Assigned(JabberOptionsForm) then JabberOptionsForm := TJabberOptionsForm.Create(self);
    //--Ставим иконки в окне контактов и в трэе
    JabberTrayIcon.Visible := true;
    JabberToolButton.Visible := true;
  end
  else
  begin
    //--Прячем иконки в окне контактов и в трэе
    JabberTrayIcon.Visible := false;
    JabberToolButton.Visible := false;
    //--Высвобождаем окно настроек протокола Jabber
    if Assigned(JabberOptionsForm) then FreeAndNil(JabberOptionsForm);
  end;
end;

procedure TMainForm.JabberSettingsClick(Sender: TObject);
begin
  //--Открываем настройки сети Jabber протокола
  if not Assigned(JabberOptionsForm) then JabberOptionsForm := TJabberOptionsForm.Create(self);
  JabberOptionsForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(JabberOptionsForm.Handle);
end;

procedure TMainForm.JabberStatusOfflineClick(Sender: TObject);
begin
  //--Уводим ICQ протокол в оффлайн
  Jabber_GoOffline;
  Jabber_Reconnect := false;
end;

procedure TMainForm.JabberStatusOnlineClick(Sender: TObject);
begin
  //--Если логин Jabber или пароль пустые, то выводим окно настроек для их ввода
  if (Jabber_LoginUIN = EmptyStr) or (Jabber_LoginPassword = EmptyStr) then
  begin
    //--Показываем сообщение об этой ошибке
    DAShow(InformationHead, JabberAccountInfo_1, EmptyStr, 133, 3, 0);
    //--Открываем настройки ICQ
    JabberSettingsClick(self);
    //--Ставим фокусы в поле ввода логина или пароля
    with JabberOptionsForm do
    begin
      if (JabberJIDEdit.CanFocus) and (JabberJIDEdit.Text = EmptyStr) then JabberJIDEdit.SetFocus
      else if (PassEdit.CanFocus) and (PassEdit.Text = EmptyStr) then PassEdit.SetFocus;
    end;
    //--Выходим от сюда
    Exit;
  end;
  //--Делаем выбранный статус в меню выделенным
  TMenuItem(Sender).Default := true;
  //--Ставим статус для протокола
  Jabber_CurrentStatus := TMenuItem(Sender).ImageIndex;
  //--Ставим запасное значение статуса для протокола
  Jabber_CurrentStatus_bac := ICQ_CurrentStatus;
  //--Ставим иконки статуса в окне и в трэе
  JabberToolButton.ImageIndex := Jabber_CurrentStatus;
  JabberTrayIcon.IconIndex := Jabber_CurrentStatus;
  //--Подключаемся к Jabber серверу
  if Jabber_Offline_Phaze then
  begin
    try
      //--Блокируем контролы логина и пароля ICQ
      if Assigned(JabberOptionsForm) then
      begin
        with JabberOptionsForm do
        begin
          JabberJIDEdit.Enabled := false;
          JabberJIDEdit.Color := clBtnFace;
          PassEdit.Enabled := false;
          PassEdit.Color := clBtnFace;
        end;
      end;
      //--Активируем фазу коннекта к серверу Jabber
      Jabber_Connect_Phaze := true;
      Jabber_HTTP_Connect_Phaze := false;
      Jabber_Work_Phaze := false;
      Jabber_Offline_Phaze := false;
      //--Запускаем показ иконки коннекта Jabber
      JvTimerList.Events[3].Enabled := true;
      //--Устанавливаем параметры сокета
      JabberWSocket.Proto := 'tcp';
      //--Устанавливаем настройки прокси
      if HttpProxy_Enable then
      begin
        JabberWSocket.Addr := HttpProxy_Address;
        JabberWSocket.Port := HttpProxy_Port;
      end
      else
      begin
        JabberWSocket.Addr := Jabber_ServerAddr;
        JabberWSocket.Port := Jabber_ServerPort;
      end;
      //--Подключаем сокет
      JabberWSocket.Connect;
    except
      on E: Exception do
      begin
        //--Если при подключении произошла ошибка, то сообщаем об этом
        //E.Message;
        DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
        //--Активиуем режим оффлайн
        Jabber_GoOffline;
      end;
    end;
  end;
  //--Отсылаем пакет со статусом
  if (not Jabber_Connect_Phaze) and (not Jabber_Offline_Phaze) then
    JabberWSocket.SendStr(UTF8Encode(Jabber_SetStatus(Jabber_CurrentStatus)));
end;

procedure TMainForm.HintMaxTime(Sender: TObject);
begin
  Application.HintHidePause := MaxInt;
end;

procedure TMainForm.HistoryContactClick(Sender: TObject);
begin
  //--Открываем окно истории
  if not Assigned(HistoryForm) then HistoryForm := THistoryForm.Create(self);
  //--Загружаем файл истории для текущего чата
  HistoryForm.LoadHistoryFromFile(ContactList.SelectedItem.UIN);
  //--Отображаем окно на передний план
  if HistoryForm.Visible then ShowWindow(HistoryForm.Handle, SW_RESTORE);
  HistoryForm.Show;
  SetForeGroundWindow(HistoryForm.Handle);
end;

procedure TMainForm.UpdateHttpClientDocBegin(Sender: TObject);
begin
  //--Создаём блок памяти для приёма http данных
  UpdateHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TMainForm.UpdateHttpClientDocData(Sender: TObject; Buffer: Pointer;
  Len: Integer);
begin
  //--Если был активирован аборт сессии, то выходим и отключаем сокет
  if UpdateHttpClient.Tag = 2 then
  begin
    UpdateHttpClient.CloseAsync;
    UpdateHttpClient.Abort;
  end;
  //--Отображаем процесс получения данных
  if Assigned(UpdateForm) then
  begin
    with UpdateForm do
    begin
      if UpdateHttpClient.ContentLength > -1 then
      begin
        LoadSizeLabel.Caption := 'Скачано: ' + FloatToStrF(UpdateHttpClient.RcvdCount / 1000, ffFixed, 7, 1) + ' Кб';
        DownloadProgressBar.Max := UpdateHttpClient.ContentLength;
        DownloadProgressBar.Position := UpdateHttpClient.RcvdCount;
      end;
      //--Обновляем форму и контролы чтобы видеть изменения
      Update;
    end;
  end;
end;

procedure TMainForm.UpdateHttpClientDocEnd(Sender: TObject);
var
  list: TStringList;
  ver, bild, mess: string;

  procedure ShowUpdateNote;
  begin
    //--Если форма не существует, то создаём её
    if not Assigned(IcqReqAuthForm) then IcqReqAuthForm := TIcqReqAuthForm.Create(self);
    //--Делаем запрос в форме на обновление программы
    IcqReqAuthForm.UpDateVersion(mess);
    //--Отображаем окно
    IcqReqAuthForm.Show;
    //--Выводим окно на самый передний план, против глюков в вин и вайн
    SetForeGroundWindow(IcqReqAuthForm.Handle);
  end;

begin
  //--Читаем полученные http данные из блока памяти
  if UpdateHttpClient.RcvdStream <> nil then
  begin
    //--Увеличиваем статистику входящего трафика
    TrafRecev := TrafRecev + UpdateHttpClient.RcvdCount;
    AllTrafRecev := AllTrafRecev + UpdateHttpClient.RcvdCount;
    if Assigned(TrafficForm) then OpenTrafficClick(nil);
    //--Определяем выполнение задания для данных по флагу
    case UpdateHttpClient.Tag of
      0:
        begin
          //--Создаём временный лист
          list := TStringList.Create;
          try
            try
              //--Обнуляем позицию начала чтения в блоке памяти
              UpdateHttpClient.RcvdStream.Position := 0;
              //--Читаем данные в лист
              list.LoadFromStream(UpdateHttpClient.RcvdStream);
              //--Разбираем данные в листе
              if list.Text > EmptyStr then
              begin
                ver := IsolateTextString(list.Text, '<v>', '</v>');
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
                else if not UpdateAuto then DAShow(InformationHead, NewVersionIMaderingNO, EmptyStr, 133, 0, 100000000);
              end;
            except
            end;
          finally
            list.Free;
          end;
        end;
      1:
        begin
          if Assigned(UpdateForm) then
          begin
            with UpdateForm do
            begin
              //--Создаём блок в памяти для приёма файла обновления
              UpdateFile := TMemoryStream.Create;
              try
                try
                  //--Обнуляем позицию начала чтения в блоке памяти
                  UpdateHttpClient.RcvdStream.Position := 0;
                  //--Читаем данные в лист
                  UpdateFile.LoadFromStream(UpdateHttpClient.RcvdStream);
                  //--Информируем о успешной закачке файла обновления
                  InfoMemo.Lines.Add(UpDateLoadL);
                  InfoMemo.Lines.Add(UpDateUnL);
                  //--Переименовываем файл Imadering.exe
                  if FileExists(MyPath + 'Imadering.exe') then RenameFile(MyPath + 'Imadering.exe', MyPath + 'Imadering.old');
                  //--Запускаем установку обновления
                  UnZip_Stream(UpdateFile, MyPath);
                  //--Выводим информацию об окончании обновления
                  InfoMemo.Lines.Add(UpDateOKL);
                  AbortBitBtn.Enabled := false;
                except
                end;
              finally
                //--Уничтожаем блок памяти
                FreeAndNil(UpdateFile);
              end;
            end;
          end;
        end;
      2:
        begin
          //--Ничего не делаем с данными
        end;
    end;
    //--Высвобождаем блок памяти
    UpdateHttpClient.RcvdStream.Free;
    UpdateHttpClient.RcvdStream := nil;
  end;
end;

procedure TMainForm.ICQSettingsClick(Sender: TObject);
begin
  //--Открываем окно настроек ICQ протокола
  if not Assigned(IcqOptionsForm) then IcqOptionsForm := TIcqOptionsForm.Create(self);
  IcqOptionsForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(IcqOptionsForm.Handle);
end;

procedure TMainForm.ICQStatusOfflineClick(Sender: TObject);
begin
  //--Уводим ICQ протокол в оффлайн
  ICQ_GoOffline;
  ICQ_Reconnect := false;
end;

procedure TMainForm.ICQStatusOnlineClick(Sender: TObject);
begin
  //--Если логин ICQ или пароль пустые, то выводим окно настроек для их ввода
  if (ICQ_LoginUIN = EmptyStr) or (ICQ_LoginPassword = EmptyStr) then
  begin
    //--Показываем сообщение об этой ошибке
    DAShow(InformationHead, ICQAccountInfo_1, EmptyStr, 133, 3, 0);
    //--Открываем настройки ICQ
    ICQSettingsClick(self);
    //--Ставим фокусы в поле ввода логина или пароля
    with IcqOptionsForm do
    begin
      if (ICQUINEdit.CanFocus) and (ICQUINEdit.Text = EmptyStr) then ICQUINEdit.SetFocus
      else if (PassEdit.CanFocus) and (PassEdit.Text = EmptyStr) then PassEdit.SetFocus;
    end;
    //--Выходим от сюда
    Exit;
  end;
  //--Делаем выбранный статус в меню выделенным
  TMenuItem(Sender).Default := true;
  //--Ставим статус для протокола
  ICQ_CurrentStatus := TMenuItem(Sender).ImageIndex;
  //--Ставим запасное значение статуса для протокола
  ICQ_CurrentStatus_bac := ICQ_CurrentStatus;
  //--Ставим иконки статуса в окне и в трэе
  ICQToolButton.ImageIndex := ICQ_CurrentStatus;
  ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
  //--Отключаем статус Нестабильный если он включен
  if JvTimerList.Events[4].Enabled then
  begin
    JvTimerList.Events[4].Enabled := false;
    UnstableICQStatus.Checked := false;
  end;
  //--Подключаемся к ICQ серверу
  if ICQ_Offline_Phaze then
  begin
    try
      //--Блокируем контролы логина и пароля ICQ
      if Assigned(IcqOptionsForm) then
      begin
        with IcqOptionsForm do
        begin
          ICQUINEdit.Enabled := false;
          ICQUINEdit.Color := clBtnFace;
          PassEdit.Enabled := false;
          PassEdit.Color := clBtnFace;
        end;
      end;
      //--Активируем фазу коннекта к серверу ICQ
      ICQ_Connect_Phaze := true;
      ICQ_HTTP_Connect_Phaze := false;
      ICQ_BosConnect_Phaze := false;
      ICQ_Work_Phaze := false;
      ICQ_Offline_Phaze := false;
      //--Запускаем показ иконки коннекта ICQ
      JvTimerList.Events[3].Enabled := true;
      //--Устанавливаем параметры сокета
      ICQWSocket.Proto := 'tcp';
      //--Устанавливаем настройки прокси
      if HttpProxy_Enable then
      begin
        ICQWSocket.Addr := HttpProxy_Address;
        ICQWSocket.Port := HttpProxy_Port;
      end
      else
      begin
        ICQWSocket.Addr := ICQ_LoginServerAddr;
        ICQWSocket.Port := ICQ_LoginServerPort;
      end;
      //--Подключаем сокет
      ICQWSocket.Connect;
    except
    end;
  end;
  if (not ICQ_Connect_Phaze) and (not ICQ_BosConnect_Phaze) and (not ICQ_Offline_Phaze) then
    SendFLAP('2', ICQ_CreateShortStatusPkt);
end;

procedure TMainForm.ICQToolButtonClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup(ICQToolButton, ICQPopupMenu);
end;

procedure TMainForm.ICQToolButtonContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  //--Открываем меню над этим элементом
  Popup(ICQToolButton, RightICQPopupMenu);
end;

procedure TMainForm.MainFormHideInTray;
begin
  //--Показываем или сворачиваем главное окно
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

procedure TMainForm.OpenFromTrayMessage(hUIN: string);
label
  x;
var
  i, ii: integer;
  mUIN: string;
begin
  if hUIN > EmptyStr then
  begin
    mUIN := hUIN;
    goto x;
  end;
  //--Если список входящих сообщений пустой, то обнуляем флаг и выходим
  if InMessList.Count = 0 then
  begin
    ICQTrayIcon.Tag := 0;
    Exit;
  end;
  //-Получаем учётную запись отправителя сообщения с самого низа списка
  mUIN := InMessList.Strings[InMessList.Count - 1];
  //--Если она вдруг пустая, то выходим
  if mUIN = EmptyStr then Exit;
  x: ;
  //--Сканируем КЛ в поисках этого контакта
  with ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      for ii := 0 to Categories[i].Items.Count - 1 do
      begin
        if Categories[i].Items[ii].UIN = mUIN then
        begin
          //--Эмулируем двойной клик по кнопке контакта в КЛ
          ContactListButtonClicked(self, Categories[i].Items[ii]);
          ContactListButtonClicked(self, Categories[i].Items[ii]);
          //--Выходим
          Exit;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.ICQTrayIconClick(Sender: TObject);
begin
  //--Сворачиваем главное окно в трэй или разворачиваем если оно уже свёрнуто
  if ICQTrayIcon.Tag = 0 then MainFormHideInTray
  else OpenFromTrayMessage(EmptyStr);
end;

procedure TMainForm.ICQTrayIconMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  //--Определяем какой протокол вызвал меню в трэе
  if Button = mbRight then TrayProtoClickMenu := LowerCase((Sender as TTrayIcon).Name);
end;

procedure TMainForm.ICQWSocketDataAvailable(Sender: TObject; ErrCode: Word);
label
  x, z;
var
  Pkt, HexPkt, SubPkt: string;
  PktLen, Len, ProxyErr: integer;
begin
  //--Получаем пришедшие от сервера данные с сокета
  Pkt := ICQWSocket.ReceiveStr;
  //--Если при получении данных возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    ICQ_GoOffline;
  end;
  //--HTTP прокси коннект
  if (HttpProxy_Enable) and ((ICQ_Connect_Phaze) or (ICQ_BosConnect_Phaze)) and (not ICQ_HTTP_Connect_Phaze) then
  begin
    //--Заносим данные в специальный буфер
    ICQ_myBeautifulSocketBuffer := ICQ_myBeautifulSocketBuffer + Pkt;
    //--Если нет ответа нормального от прокси, то выходим
    if pos(#13#10 + #13#10, ICQ_myBeautifulSocketBuffer) = 0 then Exit;
    //--Забираем из ответа прокси нужную информацию от прокси
    Pkt := chop(#13#10 + #13#10, ICQ_myBeautifulSocketBuffer);
    //--Обнуляем ошибки прокси
    ProxyErr := 0;
    //--Если ответ положительный и прокси установил соединение,
    //то активируем фазу подключения через http прокси
    if AnsiStartsStr('HTTPS/1.0 200', pkt) or AnsiStartsStr('HTTPS/1.1 200', pkt)
      or AnsiStartsStr('HTTP/1.0 200', pkt) or AnsiStartsStr('HTTP/1.1 200', pkt) then
    begin
      ICQ_HTTP_Connect_Phaze := true;
    end
    else
      //--Сообщаем об ошибках прокси
      if AnsiStartsStr('HTTP/1.0 407', pkt) then
      begin
        ProxyErr := 1;
        DAShow(ErrorHead, ProxyConnectErrL1, EmptyStr, 134, 2, 0);
      end
      else
      begin
        ProxyErr := 2;
        DAShow(ErrorHead, ProxyConnectErrL2, EmptyStr, 134, 2, 0);
      end;
    //--Забираем из буфера пакет с данными ICQ
    Pkt := ICQ_myBeautifulSocketBuffer;
    //--Очищаем буфер
    ICQ_myBeautifulSocketBuffer := EmptyStr;
    //--Если в работе с прокси были ошибки, то уходим в оффлайн
    if ProxyErr <> 0 then
    begin
      ICQ_GoOffline;
      Exit;
    end;
  end;
  //--Если длинна этих данных равна нулю, выходим от сюда :)
  if Length(Pkt) = 0 then Exit;
  //--Увеличиваем статистику входящего трафика
  TrafRecev := TrafRecev + Length(Pkt);
  AllTrafRecev := AllTrafRecev + Length(Pkt);
  if Assigned(TrafficForm) then OpenTrafficClick(nil);
  //--Преобразуем данные из бинарного формата в HEX формат и прибавляем
  //их к специальному буферу накопления таких преобразованных данных
  ICQ_HexPkt := ICQ_HexPkt + Text2Hex(Pkt);
  //--Ищем ошибки в буфере пакетов
  if ((ICQ_HexPkt > EmptyStr) and (HexToInt(LeftStr(ICQ_HexPkt, 2)) <> $2A)) or
    ((Length(ICQ_HexPkt) > 2) and ((HexToInt(ICQ_HexPkt[3] + ICQ_HexPkt[4]) = $0)
    or (HexToInt(ICQ_HexPkt[3] + ICQ_HexPkt[4]) > $05))) then
  begin
    //--Если в пакете есть ошибки, то активируем оффлайн и выводим сообщение об ошибке
    DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
    ICQ_GoOffline;
    Exit;
  end;
  //--Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
  //для проверки этих данные на наличие слудующего целого пакета данных
  x: ;
  //--Проверяем если ли в буфере хоть один целый пакет
  if (Length(ICQ_HexPkt) >= ICQ_FLAP_HEAD_SIZE) and (Length(ICQ_HexPkt) >= ICQ_FLAP_HEAD_SIZE + ICQ_BodySize1) or
    ((HexToInt(ICQ_HexPkt[3] + ICQ_HexPkt[4]) = $04) and (ICQ_BodySize1 = 0)) then
  begin
    //--Забираем из буфера один целый пакет
    HexPkt := NextData(ICQ_HexPkt, ICQ_FLAP_HEAD_SIZE + ICQ_BodySize1);
    //--Разбираем пакет данных если его длинна больше нуля
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
                          //--Отсылаем серверу пакет с допустимыми для нас фэмили
                          if ICQ_BosConnect_Phaze then SendFLAP('2', ICQ_CliFamilyPkt);
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
                            //--Очищаем группы ICQ в списке контактов
                            ContactList.Categories.Clear;
                            //--Пока думаем, что у нас новый (обсолютно чистый) список контактов
                            NewKL := true;
                            ICQ_CL_Count := 0;
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
                    begin
                      //--Если при подключении произошла ошибка, то сообщаем об этом
                      //E.Message;
                      DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
                      //--Активиуем режим оффлайн
                      ICQ_GoOffline;
                    end;
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
    if Length(ICQ_HexPkt) > 0 then goto x;
  end;
end;

procedure TMainForm.ICQWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  //--Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + BytesSent;
  AllTrafSend := AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then OpenTrafficClick(nil);
end;

procedure TMainForm.ICQWSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  //--Если при отключении возникла ошибка, то сообщаем об этом
  if (not ICQ_Connect_Phaze) and (not ICQ_Offline_Phaze) then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    ICQ_GoOffline;
    //--Если нужно переподключаться, то активируем этот таймер
    ICQ_Reconnect := true;
  end;
end;

procedure TMainForm.ICQWSocketSessionConnected(Sender: TObject; ErrCode: Word);
var
  http_data, http_login: string;
begin
  //--Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    ICQ_GoOffline;
  end;
  //--HTTP прокси коннект
  if HttpProxy_Enable then
  begin
    //--Составляем адрес
    if ICQ_Connect_Phaze then http_data := ICQ_LoginServerAddr + ':' + ICQ_LoginServerPort
    else http_data := ICQ_Bos_IP + ':' + ICQ_Bos_Port;
    //--Если авторизация на прокси
    if HttpProxy_Auth then
    begin
      http_login := Base64Encode(HttpProxy_Login + ':' + HttpProxy_Password);
      http_login := 'Authorization: Basic ' + http_login + #13#10 +
        'Proxy-authorization: Basic ' + http_login + #13#10;
    end;
    //--Формируем основной запрос для http прокси
    http_data := 'CONNECT ' + http_data + ' HTTP/1.0' + #13#10 +
      'User-agent: Mozilla/4.08 [en] (WinNT; U)' + #13#10 +
      http_login + #13#10;
    //--Отсылаем запрос для прокси
    ICQWSocket.sendStr(http_data);
  end;
end;

procedure TMainForm.ICQWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQWSocketSocksError(Sender: TObject; Error: Integer;
  Msg: string);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    ICQ_GoOffline;
  end;
end;

procedure TMainForm.ICQXStatusClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  //--Открываем окно выбора дополнительного статуса
  if not Assigned(IcqXStatusForm) then IcqXStatusForm := TIcqXStatusForm.Create(self);
  //--Вычисляем позицию окна от позиции курсора
  GetCursorPos(FCursor);
  IcqXStatusForm.Top := FCursor.Y - (IcqXStatusForm.Height div 2);
  IcqXStatusForm.Left := FCursor.X - (IcqXStatusForm.Width div 2);
  //--Показываем окно доп. статуса
  IcqXStatusForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(IcqXStatusForm.Handle);
end;

procedure TMainForm.JabberToolButtonClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup(JabberToolButton, JabberPopupMenu);
end;

procedure TMainForm.JabberToolButtonContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  //--Отображаем правильное всплывающее меню
  JabberToolButtonClick(Sender);
end;

procedure TMainForm.JabberWSocketDataAvailable(Sender: TObject; ErrCode: Word);
var
  Pkt, challenge: string;
  ProxyErr: integer;
begin
  //--Получаем пришедшие от сервера данные с сокета
  Pkt := DecodeStr(JabberWSocket.ReceiveStr);
  //--Если при получении данных возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    Jabber_GoOffline;
  end;
  //--HTTP прокси коннект
  if (HttpProxy_Enable) and (Jabber_Connect_Phaze) and (not Jabber_HTTP_Connect_Phaze) then
  begin
    //--Заносим данные в специальный буфер
    Jabber_myBeautifulSocketBuffer := Jabber_myBeautifulSocketBuffer + Pkt;
    //--Если нет ответа нормального от прокси, то выходим
    if pos(#13#10 + #13#10, Jabber_myBeautifulSocketBuffer) = 0 then Exit;
    //--Забираем из ответа прокси нужную информацию от прокси
    Pkt := chop(#13#10 + #13#10, Jabber_myBeautifulSocketBuffer);
    //--Обнуляем ошибки прокси
    ProxyErr := 0;
    //--Если ответ положительный и прокси установил соединение,
    //то активируем фазу подключения через http прокси
    if AnsiStartsStr('HTTPS/1.0 200', pkt) or AnsiStartsStr('HTTPS/1.1 200', pkt)
      or AnsiStartsStr('HTTP/1.0 200', pkt) or AnsiStartsStr('HTTP/1.1 200', pkt) then
    begin
      Jabber_HTTP_Connect_Phaze := true;
    end
    else
      //--Сообщаем об ошибках прокси
      if AnsiStartsStr('HTTP/1.0 407', pkt) then
      begin
        ProxyErr := 1;
        DAShow(ErrorHead, ProxyConnectErrL1, EmptyStr, 134, 2, 0);
      end
      else
      begin
        ProxyErr := 2;
        DAShow(ErrorHead, ProxyConnectErrL2, EmptyStr, 134, 2, 0);
      end;
    //--Забираем из буфера пакет с данными Jabber
    Pkt := Jabber_myBeautifulSocketBuffer;
    //--Очищаем буфер
    Jabber_myBeautifulSocketBuffer := EmptyStr;
    //--Если в работе с прокси были ошибки, то уходим в оффлайн
    if ProxyErr <> 0 then
    begin
      Jabber_GoOffline;
      Exit;
    end;
  end;
  //--Если длинна этих данных равна нулю, выходим от сюда :)
  if Length(Pkt) = 0 then Exit;
  //--Увеличиваем статистику входящего трафика
  TrafRecev := TrafRecev + Length(Pkt);
  AllTrafRecev := AllTrafRecev + Length(Pkt);
  if Assigned(TrafficForm) then OpenTrafficClick(nil);
  //--Проверяем пакет окончания сессии
  if Pkt = ('</' + FRootTag + '>') then Jabber_GoOffline;
  //--Буферизируем данные пакетов из сокета и забираем цельные данные
  Jabber_BuffPkt := Jabber_BuffPkt + Pkt;
  repeat
    Pkt := GetFullTag(Jabber_BuffPkt);
    if Pkt <> EmptyStr then
    begin
      if (Pkt[2] <> '?') and (Pkt[2] <> '!') and (BMSearch(0, Pkt, FRootTag) = -1) then
      begin
        //--Если это стадия подключения к серверу жаббер
        if Jabber_Connect_Phaze then
        begin
          //--Ищем механизм авторизации DIGEST-MD5
          if BMSearch(0, Pkt, '>DIGEST-MD5<') > -1 then
            //--Отсылаем запрос challenge
            JabberWSocket.SendStr(UTF8Encode('<auth xmlns=''urn:ietf:params:xml:ns:xmpp-sasl'' mechanism=''DIGEST-MD5''/>'))
          //--Если получен пакет challenge, то расшифровываем его и отсылаем авторизацию
          else if BMSearch(0, Pkt, '</challenge>') > -1 then
          begin
            //--Получаем чистый challenge из пакета и расшифровываем
            challenge := Base64Decode(IsolateTextString(Pkt, '>', '</challenge>'));
            //--Забираем из challenge ключ nonce
            challenge := IsolateTextString(challenge, 'nonce="', '"');
            //--Если challenge пустой, то значит мы уже авторизовались
            if challenge = EmptyStr then JabberWSocket.SendStr(UTF8Encode('<response xmlns=''urn:ietf:params:xml:ns:xmpp-sasl''/>'))
            else
              //--Отсылаем пакет с авторизацией
              JabberWSocket.SendStr(JabberDIGESTMD5_Auth(Jabber_LoginUIN,
                Jabber_ServerAddr, Jabber_LoginPassword, challenge, GetRandomHexBytes(32)));
          end
          else if BMSearch(0, Pkt, '<not-authorized') > -1 then
          begin
            //--Отображаем сообщение, что авторизация не пройдена и закрываем сеанс
            DAShow(ErrorHead, JabberLoginErrorL, EmptyStr, 134, 2, 0);
            Jabber_GoOffline;
          end
          else if BMSearch(0, Pkt, '<success') > -1 then
          begin
            //--Закрепляем сессию с жаббер сервером
            JabberWSocket.SendStr(UTF8Encode(Format(StreamHead, [Jabber_ServerAddr])));
            //--Активируем режим онлайн для Jabber
            Jabber_Connect_Phaze := false;
            Jabber_HTTP_Connect_Phaze := false;
            Jabber_Work_Phaze := true;
            Jabber_Offline_Phaze := false;
            //--Отключаем метку пересоединения ведь мы уже и так онлайн!
            Jabber_Reconnect := false;
            //--Запускаем таймер отсылки пинг пакетов
            if Jabber_KeepAlive then JvTimerList.Events[9].Enabled := true;
            //--Выходим
            Exit;
          end;
        end;
        //--Разбираем пакеты рабочей фазы jabber
        if Jabber_Work_Phaze then
        begin
          //--Инициализируем XML
          with TrXML.Create() do
          try
            //--Загружаем пакет в объект xml
            Text := Pkt;
            //--Разделяем стадии
            if not Jabber_Session_OK then
            begin
              //--Разбираем пакеты
              if OpenKey('stream:features\bind') then
              try
                //--Устанавливаем bind
                JabberWSocket.SendStr(UTF8Encode(Jabber_SetBind));
              finally
                CloseKey();
              end;
              if OpenKey('stream:features\session') then
              try
                //--Устанавливаем session
                JabberWSocket.SendStr(UTF8Encode(Jabber_SetSession));
              finally
                CloseKey();
              end;
              if OpenKey('iq\session') then
              try
                Jabber_Session_OK := true;
                //--Запрашиваем список контактов
                JabberWSocket.SendStr(UTF8Encode(Jabber_GetRoster));
                //--Устанавливаем статус
                JabberWSocket.SendStr(UTF8Encode(Jabber_SetStatus(Jabber_CurrentStatus)));
              finally
                CloseKey();
              end;
            end;
            //--Парсим пакеты iq

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
  //--Отображаем ошибки сокета
  DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  //--Активируем режим оффлайн
  Jabber_GoOffline;
end;

procedure TMainForm.JabberWSocketSendData(Sender: TObject; BytesSent: Integer);
begin
  //--Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + BytesSent;
  AllTrafSend := AllTrafSend + BytesSent;
  if Assigned(TrafficForm) then OpenTrafficClick(nil);
end;

procedure TMainForm.JabberWSocketSessionAvailable(Sender: TObject;
  ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    Jabber_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSessionClosed(Sender: TObject; ErrCode: Word);
begin
  //--Если при отключении возникла ошибка, то сообщаем об этом
  if not Jabber_Offline_Phaze then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    Jabber_GoOffline;
    //--Если нужно переподключаться, то активируем этот таймер
    Jabber_Reconnect := true;
  end;
end;

procedure TMainForm.JabberWSocketSessionConnected(Sender: TObject;
  ErrCode: Word);
var
  http_data, http_login: string;
begin
  //--Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    Jabber_GoOffline;
  end;
  //--HTTP прокси коннект
  if HttpProxy_Enable then
  begin
    //--Составляем адрес
    if Jabber_Connect_Phaze then http_data := Jabber_ServerAddr + ':' + Jabber_ServerPort;
    //--Если авторизация на прокси
    if HttpProxy_Auth then
    begin
      http_login := Base64Encode(HttpProxy_Login + ':' + HttpProxy_Password);
      http_login := 'Authorization: Basic ' + http_login + #13#10 +
        'Proxy-authorization: Basic ' + http_login + #13#10;
    end;
    //--Формируем основной запрос для http прокси
    http_data := 'CONNECT ' + http_data + ' HTTP/1.0' + #13#10 +
      'User-agent: Mozilla/4.08 [en] (WinNT; U)' + #13#10 +
      http_login + #13#10;
    //--Отсылаем запрос для прокси
    JabberWSocket.sendStr(http_data);
  end;
  //--Отсылаем строку начала сессии с сервером
  JabberWSocket.SendStr(UTF8Encode(Format(StreamHead, [Jabber_ServerAddr])));
end;

procedure TMainForm.JabberWSocketSocksConnected(Sender: TObject; ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    Jabber_GoOffline;
  end;
end;

procedure TMainForm.JabberWSocketSocksError(Sender: TObject; Error: Integer;
  Msg: string);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
    //--Активируем режим оффлайн
    Jabber_GoOffline;
  end;
end;

procedure TMainForm.JvTimerListEvents0Timer(Sender: TObject);
begin
  //--Отображаем главное окно программы
  MainForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(Application.MainForm.Handle);
  //--Если это первый старт программы то запускаем окно первичной настройки протоколов
  if not FirstStart then
  begin
    FirstStartForm := TFirstStartForm.Create(self);
    //--Даём главному окну нормально прорисоваться
    Application.ProcessMessages;
    //--Затем показываем окно начальной настройки протоколов
    FirstStartForm.Show;
  end;
end;

procedure TMainForm.JvTimerListEvents1Timer(Sender: TObject);
var
  i, ii: integer;
  YesMsg, GroupRoasterMsg: boolean;
begin
  //--Смотрим по таймеру везде все флаги сообщений не прочитанных
  //и отображаем иконки мигающих сообщений
  //--Обнуляем местные метки
  YesMsg := false;
  GroupRoasterMsg := false;
  //--Сканируем и управляем иконками контактов с флагами сообщений
  with MainForm.ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      for ii := 0 to Categories[i].Items.Count - 1 do
      begin
        //--Если контакт печатает нам сообщение и время печати меньше отбоя печати
        if (Categories[i].Items[ii].Typing) and (Categories[i].Items[ii].TypingTime < 60) then
        begin
          Categories[i].Items[ii].ImageIndex := 161;
          Categories[i].Items[ii].TypingTime := Categories[i].Items[ii].TypingTime + 1;
        end
        else
        begin
          //--Если не печатает, то обнуляем флаги печати сообщения контактом
          Categories[i].Items[ii].TypingTime := 0;
          Categories[i].Items[ii].Typing := false;
          //--Если стоит флаг что есть непрочитанные сообщения от этого контакта
          if Categories[i].Items[ii].Msg then
          begin
            //--Если иконка сообщения уже отображается, то меняем её на статус,
            //если наоборот, то на иконку сообщения
            if Categories[i].Items[ii].ImageIndex = 165 then
              Categories[i].Items[ii].ImageIndex := Categories[i].Items[ii].Status
            else Categories[i].Items[ii].ImageIndex := 165;
            //--Ставим метку, что в этой группе были найдены контакты с сообщениями
            YesMsg := true;
            //--Если группа свёрнута, то мигаем ей один раз
            if (Categories[i].Collapsed) and (not GroupRoasterMsg) then
            begin
              if Categories[i].TextColor = clBlack then Categories[i].TextColor := clRed
              else Categories[i].TextColor := clBlack;
              GroupRoasterMsg := true;
            end;
            //--Если группа не свёрнута, то делаем её текст чёрным
            if not Categories[i].Collapsed then Categories[i].TextColor := clBlack;
          end
          else
          begin
            //--Если флага сообщения нету, то проверяем всё ли нормально
            //с иконкой статуса, если нет, то присваиваем её
            if Categories[i].Items[ii].ImageIndex <> Categories[i].Items[ii].Status then
              Categories[i].Items[ii].ImageIndex := Categories[i].Items[ii].Status;
            //--Если нет сообщений вообще, то делаем текст группы чёрным
            if (not YesMsg) and (not GroupRoasterMsg) then Categories[i].TextColor := clBlack;
          end;
        end;
        //--Не даём замерзать интерфейсу
        Application.ProcessMessages;
      end;
    end;
  end;
  //--Мигаем иконками сообщений во вкладках окна чата
  if Assigned(ChatForm) then
  begin
    with ChatForm.ChatPageControl do
    begin
      for i := 0 to PageCount - 1 do
      begin
        //--Если контакт печатает нам сообщение и время печати меньше отбоя печати
        if (Pages[i].Margins.Top = 1) and (Pages[i].Margins.Right < 60) then
        begin
          //--Если активная вкладка совпадает с UIN
          if Pages[i].HelpKeyword = ChatForm.InfoPanel2.Caption then
          begin
            //--Ставим сообщение о наборе текста
            ChatForm.NotifyPanel.Font.Color := clBlue;
            ChatForm.NotifyPanel.Caption := TypingTextL;
          end
          else Pages[i].ImageIndex := 161;
          Pages[i].Margins.Right := Pages[i].Margins.Right + 1;
        end
        else
        begin
          //--Если не печатает, то обнуляем флаги печати сообщения контактом
          Pages[i].Margins.Top := 0;
          Pages[i].Margins.Right := 0;
          //--Если активная вкладка совпадает с UIN
          if Pages[i].HelpKeyword = ChatForm.InfoPanel2.Caption then
          begin
            //--Сбрасываем сообщение о наборе текста
            ChatForm.NotifyPanel.Font.Color := clWindowText;
            ChatForm.NotifyPanel.Caption := '...';
          end;
          //--Если стоит флаг что есть непрочитанные сообщения от этого контакта
          if Pages[i].Margins.Left = 1 then
          begin
            //--Если иконка сообщения уже отображается, то меняем её на статус,
            //если наоборот, то на иконку сообщения
            if Pages[i].ImageIndex = 165 then Pages[i].ImageIndex := Pages[i].Tag
            else Pages[i].ImageIndex := 165;
            //--Зачемто засыпаем на 1 миллисекунду
            Sleep(1);
            //--Если окно чата не активно, то мигаем его кнопкой на панели задач
            if not ChatForm.Active then FormFlash(ChatForm.Handle);
          end
          //--Если флага сообщения нету, то проверяем всё ли нормально
          //с иконкой статуса, если нет, то присваиваем её
          else if Pages[i].ImageIndex <> Pages[i].Tag then Pages[i].ImageIndex := Pages[i].Tag;
        end;
        //--Не даём замерзать интерфейсу
        Application.ProcessMessages;
      end;
    end;
  end;
  //--Если не активен таймер иконки соединения, то можно мигать иконками сообщений
  if not JvTimerList.Events[3].Enabled then
  begin
    //--Если есть непрочитанные сообщения в КЛ и в списке очереди входящих сообщений
    if (YesMsg) and (InMessList.Count > 0) then
    begin
      //--Ставим флаг в трэе, что есть сообщения для открытия
      ICQTrayIcon.Tag := 1;
      //--Если иконка сообщения уже отображается, то меняем её на статус,
      //если наоборот, то на иконку сообщения
      if ICQTrayIcon.IconIndex = 165 then ICQTrayIcon.IconIndex := ICQ_CurrentStatus
      else ICQTrayIcon.IconIndex := 165;
    end
    else
    begin
      //--Сбрасываем отображение иконки сообщений в трэе
      ICQTrayIcon.Tag := 0;
      ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
    end;
  end;
end;


procedure TMainForm.JvTimerListEvents2Timer(Sender: TObject);
begin
  //--Ставим флаг - непоказывать всплывающее сообщение если новой версии нету
  if Sender = nil then UpdateAuto := false
  else UpdateAuto := true;
  //--Сбрасываем сокет если он занят чем то другим или висит
  UpdateHttpClient.Abort;
  //--Ставим флаг задания
  UpdateHttpClient.Tag := 0;
  //--Запускаем проверку обновлений программы на сайте
  try
    UpdateHttpClient.URL := 'http://imadering.com/version.txt';
    UpdateHttpClient.GetASync;
  except
  end;
end;

procedure TMainForm.JvTimerListEvents3Timer(Sender: TObject);
begin
  //--Отображаем мигающую иконку подключения к серверу
  if (ICQ_Connect_Phaze) or (ICQ_BosConnect_Phaze) then
  begin
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
    //--Останавливаем таймер
    JvTimerList.Events[3].Enabled := false;
    ICQToolButton.ImageIndex := ICQ_CurrentStatus;
    ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
  end;
end;

procedure TMainForm.JvTimerListEvents4Timer(Sender: TObject);
begin
  //--Если функция отключена, то выключаем таймер и выходим
  if not UnstableICQStatus.Checked then
  begin
    JvTimerList.Events[4].Enabled := false;
    //--Возвращаем прежнёё значение статуса
    ICQ_CurrentStatus := ICQ_CurrentStatus_bac;
    //--Отсылаем короткий пакет статуса
    SendFLAP('2', ICQ_CreateShortStatusPkt);
    Exit;
  end;
  //--Фак статус ICQ (переключаем режим видимости и невидимости через интервалы)
  if ICQ_Work_Phaze then
  begin
    if ICQ_CurrentStatus <> 11 then ICQ_CurrentStatus := 11
    else ICQ_CurrentStatus := ICQ_CurrentStatus_bac;
    //--Отсылаем короткий пакет статуса
    SendFLAP('2', ICQ_CreateShortStatusPkt);
  end;
end;

procedure TMainForm.JvTimerListEvents5Timer(Sender: TObject);
begin
  //--Если не подключена рабочая фаза ICQ, то выключаем таймер
  if not ICQ_Work_Phaze then
  begin
    JvTimerList.Events[5].Enabled := false;
    Exit;
  end;
  //--Отсылаем пакет с пингом равным 60 секундам
  SendFlap('5', '0000003C');
  //--Отсылаем пинг для сервера аватар ICQ
  if ICQ_Avatar_Work_Phaze then SendFLAP_Avatar('5', '0000003C');
end;

procedure TMainForm.JvTimerListEvents6Timer(Sender: TObject);
begin
  //--Скрываем окно списка контактов по события таймера автоскрытия
  Hide;
end;

procedure TMainForm.JvTimerListEvents7Timer(Sender: TObject);
begin
  //--Создаём форму со смайликами через секунду после создания окна чата
  if not Assigned(SmilesForm) then SmilesForm := TSmilesForm.Create(nil);
end;

procedure TMainForm.JvTimerListEvents8Timer(Sender: TObject);
begin
  //--Запускаем выполнение потока сжатия и сохранения истории
  //--Если поток остановлен и не работает, то запускаем его
  if ZipHistoryThread.Terminated then ZipHistoryThread.Start;
end;

procedure TMainForm.JvTimerListEvents9Timer(Sender: TObject);
begin
  //--Если не подключена рабочая фаза Jabber, то выключаем таймер
  if not Jabber_Work_Phaze then
  begin
    JvTimerList.Events[9].Enabled := false;
    Exit;
  end;
  //--Отсылаем пакет с пингом равным 60 секундам
  JabberWSocket.SendStr(Utf8Encode(' ' + #09 + ' '));
end;

procedure TMainForm.LoadImageList(ImgList: TImageList; FName: string);
var
  i, Count: integer;
  img1, img2: TBitmap;
begin
  //--Создаём компонент иконки
  img1 := TBitmap.Create;
  img2 := TBitmap.Create;
  img1.Height := 16;
  img1.Width := 16;
  img2.Height := 16;
  img2.Width := 16;
  try
    if FileExists(FName) then
    begin
      //--Если файл с иконками есть, то загружаем его
      img1.LoadFromFile(FName);
      //--Вычисляем количесво иконок в файле
      Count := img1.Width div 16;
      //--Загружаем по одной иконке в лист иконок с примерением прозрачности фона
      for i := 0 to Count do
      begin
        img2.Canvas.CopyRect(Rect(0, 0, 16, 16), Img1.Canvas,
          Bounds(i * 16, 0, 16, 16));
        ImgList.AddMasked(img2, clFuchsia);
        Application.ProcessMessages;
      end;
    end;
  finally
    img1.Free;
    img2.Free;
  end;
end;

procedure TMainForm.MainToolButtonClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup(MainToolButton, MainPopupMenu);
end;

procedure TMainForm.MainToolButtonContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  //--Отображаем правильное всплывающее меню
  MainToolButtonClick(Sender);
end;

procedure TMainForm.MRAToolButtonClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup(MRAToolButton, MRAPopupMenu);
end;

procedure TMainForm.MRAToolButtonContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  //--Отображаем правильное всплывающее меню
  MRAToolButtonClick(Sender);
end;

procedure TMainForm.MRAXStatusClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  //--Открываем окно выбора дополнительного статуса
  if not Assigned(MraXStatusForm) then MraXStatusForm := TMraXStatusForm.Create(self);
  //--Вычисляем позицию окна от позиции курсора
  GetCursorPos(FCursor);
  MraXStatusForm.Top := FCursor.Y - (MraXStatusForm.Height div 2);
  MraXStatusForm.Left := FCursor.X - (MraXStatusForm.Width div 2);
  //--Показываем окно доп. статуса
  MraXStatusForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(MraXStatusForm.Handle);
end;

procedure TMainForm.CheckStatusContactClick(Sender: TObject);
begin
  //--Проверяем статус контакта
  if ICQ_Work_Phaze then
    if ContactList.SelectedItem <> nil then ICQ_ReqStatus0215(ContactList.SelectedItem.UIN);
end;

procedure TMainForm.CheckUpdateClick(Sender: TObject);
begin
  //--Запускаем проверку обновлений программы на сайте
  JvTimerListEvents2Timer(nil);
end;

procedure TMainForm.OpenTrafficClick(Sender: TObject);
begin
  //--Отображаем окно трафика
  if not Assigned(TrafficForm) then TrafficForm := TTrafficForm.Create(self);
  //--Показываем сколько трафика передано за эту сессию
  TrafficForm.Edit1.Text := FloatToStrF(TrafRecev / 1000, ffFixed, 18, 3) + ' Кб | ' +
    FloatToStrF(TrafSend / 1000, ffFixed, 18, 3) + ' Кб | ' + DateTimeToStr(SesDataTraf);
  //--Показываем сколько трафика передано всего
  TrafficForm.Edit2.Text := FloatToStrF(AllTrafRecev / 1000000, ffFixed, 18, 3) + ' Мб | ' +
    FloatToStrF(AllTrafSend / 1000000, ffFixed, 18, 3) + ' Мб | ' + AllSesDataTraf;
  //--Отображаем окно модально
  if not TrafficForm.Visible then TrafficForm.Show;
end;

procedure TMainForm.OpenSocketLogClick(Sender: TObject);
begin
  //--Отображаем окно лога сокетов
  if not Assigned(IcsLogForm) then IcsLogForm := TIcsLogForm.Create(self);
  //--Отображаем окно на передний план
  if IcsLogForm.Visible then ShowWindow(IcsLogForm.Handle, SW_RESTORE);
  IcsLogForm.Show;
  SetForeGroundWindow(IcsLogForm.Handle);
end;

procedure TMainForm.OpenTestClick(Sender: TObject);
begin
  //--Место для запуска тестов

  {if not Assigned(IcqReqAuthForm) then IcqReqAuthForm := TIcqReqAuthForm.Create(self);
  IcqReqAuthForm.UpDateVersion('test');

  IcqReqAuthForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(IcqReqAuthForm.Handle);}

end;

procedure TMainForm.OnlyOnlineContactsToolButtonClick(Sender: TObject);
begin
  //--Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. оффлайн контактов
  if OnlyOnlineContactsToolButton.Down then
  begin
    OnlyOnlineContactsToolButton.ImageIndex := 137;
    OnlyOnlineContactsToolButton.Hint := OnlyOnlineOn;
  end
  else
  begin
    OnlyOnlineContactsToolButton.ImageIndex := 138;
    OnlyOnlineContactsToolButton.Hint := OnlyOnlineOff;
  end;
end;

procedure TMainForm.OpenSettingsClick(Sender: TObject);
begin
  //--Открываем окно с настройками программы
  if not Assigned(SettingsForm) then SettingsForm := TSettingsForm.Create(self);
  SettingsForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(SettingsForm.Handle);
end;

procedure TMainForm.RenemeGroupCLClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.AboutIMaderingClick(Sender: TObject);
begin
  //--Открываем окно о программе
  if not Assigned(AboutForm) then AboutForm := TAboutForm.Create(self);
  AboutForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(AboutForm.Handle);
end;

procedure TMainForm.CloseGroupsCLClick(Sender: TObject);
var
  i: integer;
begin
  //--Закрываем все группы в контакт листе
  for i := 0 to MainForm.ContactList.Categories.Count - 1 do
  begin
    MainForm.ContactList.Categories[i].Collapsed := true;
  end;
end;

procedure TMainForm.CloseProgramClick(Sender: TObject);
begin
  //--Закрываем программу
  ProgramCloseCommand := true;
  Close;
end;

procedure TMainForm.ContactListButtonClicked(Sender: TObject;
  const Button: TButtonItem);
var
  EnableTab: boolean;
  i, N: integer;
  diff: TdateTime;
  Sheet: TTabSheet;
begin
  //--Сбрасываем выделение заголовка группы при клике по любому контакту
  with ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      if Categories[i].GroupSelected = true then
      begin
        Categories[i].GroupSelected := false;
        //--Перерисовываем заголовок группы
        ShareUpdateCategory(ContactList.Categories[i]);
        //--Выходим из цикла
        Break;
      end;
    end;
  end;
  //--Вычитаем время плошлого клика
  diff := now - lastClick;
  //--Запоминаем время текущего клика
  lastClick := now;
  //--Если по времени произошёл двойной клик, то начинаем открывать окно чата с этим контактом
  if (diff < dblClickTime) and (ButtonInd = Button.Index) then
  begin
    //--Обнуляем флаг непрочитанных сообщений для этого контакта
    Button.Msg := false;
    //--Меняем иконку кнопки контакта на его статус
    Button.ImageIndex := Button.Status;
    //--Если окно чата не создано, то создаём его
    if not Assigned(ChatForm) then ChatForm := TChatForm.Create(self);
    //--Показываем компонент табов
    ChatForm.ChatPageControl.Visible := true;
    //--Ищем вкладку в табе
    EnableTab := false;
    with ChatForm.ChatPageControl do
    begin
      for i := 0 to PageCount - 1 do
      begin
        if Pages[i].HelpKeyword = Button.UIN then
        begin
          Pages[i].ImageIndex := Button.Status;
          Pages[i].Tag := Button.Status;
          Pages[i].Caption := Button.Caption;
          Pages[i].Hint := Button.Hint;
          ActivePageIndex := Pages[i].PageIndex;
          EnableTab := true;
          Break;
        end;
        Application.ProcessMessages;
      end;
    end;
    //--Если вкладку не нашли, то создаём её
    if not EnableTab then
    begin
      Sheet := TTabSheet.Create(self);
      Sheet.Caption := Button.Caption;
      Sheet.ImageIndex := Button.Status;
      Sheet.Tag := Button.Status;
      Sheet.HelpKeyword := Button.UIN;
      Sheet.Hint := Button.Hint;
      Sheet.ShowHint := true;
      Sheet.PageControl := ChatForm.ChatPageControl;
      ChatForm.ChatPageControl.ActivePageIndex := Sheet.PageIndex;
    end;
    //--Активируем чат и применяем параметры в окне чата
    ChatForm.ChatPageControlChange(self);
    //--Отображаем окно сообщений
    if ChatForm.Visible then ShowWindow(ChatForm.Handle, SW_RESTORE);
    ChatForm.Show;
    SetForegroundWindow(ChatForm.Handle);
    //--Ставим фокус в поле ввода текста
    if (ChatForm.InputMemo.CanFocus) and (ChatForm.Visible) then ChatForm.InputMemo.SetFocus;
    //--Запрашиваем анкету неопознанных контактов
    if (Button.Caption = Button.UIN) and ((Button.Category.GroupId = '0000') or (Button.Category.GroupId = 'NoCL')) then
    begin
      if ICQ_Work_Phaze then ICQ_ReqInfo_New_Pkt(Button.UIN);
    end;
    //--Удаляем отметку о сообщении из списка очереди входящих сообщений
    try
      N := InMessList.IndexOf(Button.UIN);
      if N > -1 then InMessList.Delete(N);
    except
    end;
  end;
  ButtonInd := Button.Index;
end;

procedure TMainForm.ContactListContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  FCursor: TPoint;
  i: integer;
begin
  //--Отключаем автоменю
  Handled := true;
  //--Вычисляем группу в которой происходит событие
  RoasterGroup := ContactList.GetCategoryAt(MousePos.X, MousePos.Y);
  //--Выделяем контакт на котором был правый клик мыши
  ContactList.FocusedItem := nil;
  ContactList.SelectedItem := RoasterButton;
  //--Получаем координаты курсора
  GetCursorPos(FCursor);
  //--Если кнопка КЛ, то выводим меню контакта
  if RoasterButton <> nil then
  begin
    //--Снимаем выделение с заголовка группы
    if RoasterGroup <> nil then
    begin
      RoasterGroup.GroupSelected := false;
      ContactList.ShareUpdateCategory(RoasterGroup);
    end;
    //--Активируем или деактивируем нужные для этого контакта пункты меню

    //--Отображаем меню
    ContactPopupMenu.Popup(FCursor.X, FCursor.Y);
  end
  else
  begin
    //--Если правый клик был по группе, то подсвечиваем её заголовок
    //и активируем или деактивируем нужные пункты меню контакт листа
    with ContactList do
    begin
      //--Если клик был по группе, то подсвечиваем её заголовок
      if RoasterGroup <> nil then
      begin
        //--Сбрасываем подсветку заголовка другой группы
        for i := 0 to Categories.Count - 1 do
        begin
          if Categories[i].GroupSelected = true then
          begin
            Categories[i].GroupSelected := false;
            //--Перерисовываем заголовок группы
            ShareUpdateCategory(ContactList.Categories[i]);
            //--Выходим из цикла
            Break;
          end;
        end;
        //--Подсвечиваем заголовок текущей группы
        RoasterGroup.GroupSelected := true;
        ShareUpdateCategory(RoasterGroup);
        //--Управляем пунктами меню для группы
        RenemeGroupCL.Visible := true;
        DeleteGroupCL.Visible := true;
      end
      else
      begin
        //--Если клик не по группе, то убираем подсветку со всех заголовков групп
        for i := 0 to Categories.Count - 1 do
        begin
          Categories[i].GroupSelected := false;
          ShareUpdateCategory(ContactList.Categories[i]);
        end;
        //--Управляем пунктами меню для группы
        RenemeGroupCL.Visible := false;
        DeleteGroupCL.Visible := false;
      end;
    end;
    //--Отображаем меню
    ContactListPopupMenu.Popup(FCursor.X, FCursor.Y);
  end;
end;

procedure TMainForm.ContactListHotButton(Sender: TObject;
  const Button: TButtonItem);
begin
  //--При перемещении по кнопкам КЛ запоминаем последнюю
  if Button <> nil then RoasterButton := Button
  else RoasterButton := nil;
end;

procedure TMainForm.CopyAccountContactClick(Sender: TObject);
begin
  //--Копируем имя учётной записи контакта в буфер обмена
  if ContactList.SelectedItem <> nil then SetClipboardText(Handle, ContactList.SelectedItem.UIN);
end;

procedure TMainForm.DeleteContactClick(Sender: TObject);
label
  x;
var
  i, ii, G, z, zz, cnt: integer;
begin
  //--Если ICQ не подключено к серверу, то выходим
  if not ICQ_Work_Phaze then Exit;
  //--Если ничего не активно для удаления, то выходим
  if ContactList.SelectedItem = nil then Exit;
  //--Удаляем контакт из списка контактов
  //--Блокируем всё окно со списком контактов
  MainForm.Enabled := false;
  try
    //--Выводим диалог подтверждения удаления контакта
    i := MessageBox(Handle, PChar(Format(DellContactL, [ContactList.SelectedItem.Caption])), PChar((Sender as TMenuItem).Hint),
      MB_TOPMOST or MB_YESNO or MB_ICONQUESTION);
    //--Если ответ на вопрос положительный, то начинаем удаление контакта
    if i = 6 then
    begin
      with ContactList do
      begin
        //--Сканируем группы и ищем этот контакт
        for z := 0 to Categories.Count - 1 do
        begin
          for zz := 0 to Categories[z].Items.Count - 1 do
          begin
            //--Если нашли контакт
            if Categories[z].Items[zz].UIN = ContactList.SelectedItem.UIN then
            begin
              //--Если это контакт из группы временных, то удаляем его как временный
              if Categories[z].Items[zz].GroupId = '0000' then
              begin
                //--Отправляем пакет для удаления контакта из списка на сервере
                ICQ_DeleteTempContact(Categories[z].Items[zz].UIN, Categories[z].Items[zz].Idd,
                  Categories[z].Items[zz].iType, Categories[z].Items[zz].TimeId);
                //--Запоминаем индекс группы
                G := Categories[z].Items[zz].Category.Index;
                //--Удаляем контакт локально из списка
                Categories[z].Items[zz].Destroy;
                //--Если в группе больше нет контактов, то удаляем её
                if Categories[G].Items.Count = 0 then Categories[G].Destroy;
              end
              //--Если контакт из группы "Не в списке"
              else if Categories[z].Items[zz].GroupId = 'NoCL' then
              begin
                //--Запоминаем индекс группы
                G := Categories[z].Items[zz].Category.Index;
                //--Удаляем контакт локально из списка
                Categories[z].Items[zz].Destroy;
                //--Если в группе больше нет контактов, то удаляем её
                if Categories[G].Items.Count = 0 then Categories[G].Destroy;
              end
              //--Иначе удаляем контакт как положено
              else
              begin
                //--Отправляем пакет для удаления контакта из списка на сервере
                ICQ_DeleteContact(Categories[z].Items[zz].UIN, Categories[z].Items[zz].GroupId,
                  Categories[z].Items[zz].Idd, Categories[z].Items[zz].Caption,
                  Categories[z].Items[zz].Mobile, Categories[z].Items[zz].Email,
                  Categories[z].Items[zz].Note);
                //--Удаляем контакт локально из списка
                Categories[z].Items[zz].Destroy;
              end;
              //--Выходим из циклов
              goto x;
            end;
          end;
        end;
        x: ;
        //--Вычисляем оставшееся количество контактов в группах
        with MainForm.ContactList do
        begin
          for i := 0 to Categories.Count - 1 do
          begin
            if (Categories[i].GroupId = '0000') or (Categories[i].GroupId = 'NoCL') or
              (Categories[i].Items.Count = 0) then Categories[i].Caption := Categories[i].GroupCaption + ' - ' +
              IntToStr(Categories[i].Items.Count)
            else
            begin
              cnt := Categories[i].Items.Count;
              for ii := 0 to Categories[i].Items.Count - 1 do
                case Categories[i].Items[ii].Status of
                  9, 80, 214: dec(cnt);
                end;
              Categories[i].Caption := Categories[i].GroupCaption + ' - ' + IntToStr(cnt) + GroupInv + IntToStr(Categories[i].Items.Count);
            end;
          end;
        end;
      end;
    end;
  finally
    //--В любом случае разблокировываем окно контактов
    MainForm.Enabled := true;
  end;
end;

procedure TMainForm.DeleteGroupCLClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.DelYourSelfContactClick(Sender: TObject);
var
  i: integer;
begin
  //--Если не подключены к серверу, то выходим
  if not ICQ_Work_Phaze then Exit;
  //--Если ничего не выбрано, то выходи
  if ContactList.SelectedItem = nil then Exit;
  //--Блокируем окно контактов
  MainForm.Enabled := false;
  try
    //--Выводим вопрос на подтверждение действия
    i := MessageBox(Handle, PChar(Format(DellYourSelfL,
      [ContactList.SelectedItem.Caption])), PChar((Sender as TMenuItem).Hint),
      MB_TOPMOST or MB_YESNO or MB_ICONQUESTION);
    //--Если ответ положительный, то удаляем себя из списка контакта
    if i = 6 then ICQ_DellMyFromCL(ContactList.SelectedItem.UIN);
  finally
    //--Разблокировываем окно контактов
    MainForm.Enabled := true;
  end;
end;

procedure TMainForm.EditContactClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  //--Выключаем прозрачность окна при активности
  if RoasterAlphaBlend then
    if AlphaBlendInactive then AlphaBlendValue := 255;
  //--Сбрасываем таймер автоскрытия окна при активности окна
  if JvTimerList.Events[6].Enabled then
  begin
    JvTimerList.Events[6].Enabled := false;
    JvTimerList.Events[6].Enabled := true;
  end;
  //--Убираем тут глюк в вайн с активацией окна чата (для сброса сообщения)
  if Assigned(ChatForm) then
  begin
    //--Отлично это сработало!
    if ChatForm.Active then ChatForm.FormActivate(self);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Сохраняем настройки окна
  SaveMainFormSettings;
  //--Указываем что окно уничтожается полностью при закрытии
  Action := caFree;
  MainForm := nil;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //--Делаем окно не закрывающим программу, а сворачиваем его в трэй
  if not ProgramCloseCommand then
  begin
    CanClose := false;
    MainFormHideInTray;
  end
  else
  begin
    //--Переводим все протоколы в оффлайн
    if not ICQ_Offline_Phaze then ICQ_GoOffline;
    if not Jabber_Offline_Phaze then Jabber_GoOffline;
    //--Скрываем окно чтобы небыло ощющения тормазов
    Hide;
    Application.ProcessMessages;
    //--Отключаем HTTP сокеты
    UpdateHttpClient.Abort;
    MRAAvatarHttpClient.Abort;
    //--Уничтожаем другие ресурсы
    if Assigned(AccountToNick) then FreeAndNil(AccountToNick);
    if Assigned(SmilesList) then FreeAndNil(SmilesList);
    if Assigned(InMessList) then FreeAndNil(InMessList);
    if Assigned(NoAvatar) then FreeAndNil(NoAvatar);
    if Assigned(OutMessage2) then FreeAndNil(OutMessage2);
    if Assigned(OutMessage3) then FreeAndNil(OutMessage3);
    if Assigned(SmilesForm) then FreeAndNil(SmilesForm);
    //--Останавливаем таймеры
    JvTimerList.Active := false;
    //--Если поток сжатия истории не остановился ещё, то ждём его остановки
    while not ZipHistoryThread.Terminated do
    begin
      Sleep(10);
      Application.ProcessMessages;
    end;
    //--Сохраняем историю сообщений, но уже не в потоке
    ZipHistory;
    //--Делаем текущую локальную копию списка контактов для отображения при запуске программы
    if ContactList.Categories.Count > 0 then SaveContactList;
  end;
end;

procedure TMainForm.AddNewContactCLClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.AddNewGroupCLClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.AnketaContactClick(Sender: TObject);
begin
  //--Отображаем информацию о контакте
  if ContactList.SelectedItem = nil then Exit;
  if not Assigned(IcqContactInfoForm) then IcqContactInfoForm := TIcqContactInfoForm.Create(self);
  //--Присваиваем UIN инфу которого хотим смотреть
  IcqContactInfoForm.ReqUIN := ContactList.SelectedItem.UIN;
  //--Загружаем информацию о нем
  IcqContactInfoForm.LoadUserUnfo;
  //--Отображаем окно на передний план
  if IcqContactInfoForm.Visible then ShowWindow(IcqContactInfoForm.Handle, SW_RESTORE);
  IcqContactInfoForm.Show;
  SetForeGroundWindow(IcqContactInfoForm.Handle);
end;

procedure TMainForm.AppActivate(Sender: TObject);
begin
  FormActivate(self);
end;

procedure TMainForm.AppDeactivate(Sender: TObject);
begin
  FormDeactivate(self);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  l: DWORD;
begin
  //--Включаем двойную буферезацию графики окна
  DoubleBuffered := true;
  //--Убираем кнопку "свернуть" в заголовке окна
  l := GetWindowLong(Self.Handle, GWL_STYLE);
  l := l and not (WS_MINIMIZEBOX);
  l := l and not (WS_MAXIMIZEBOX);
  SetWindowLong(Self.Handle, GWL_STYLE, l);
  //--Узнаём путь откуда запущена программа
  MyPath := ExtractFilePath(Application.ExeName);
  //--Временно создаём форму с настройками для применения настроек
  SettingsForm := TSettingsForm.Create(self);
  SettingsForm.ApplySettings;
  //--Загрузка иконок для программы
  LoadImageList(AllImageList, MyPath + 'Icons\' + CurrentIcons + '\icons.bmp');
  //--Устанавливаем иконку окна
  AllImageList.GetIcon(1, Icon);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //--Делаем всплывающие подсказки неисчезающими
  Application.HintHidePause := MaxInt;
  Application.OnHint := HintMaxTime;
  //--Заранее подгружаем иконки начальных статусов протоколов в трэй
  AllImageList.GetIcon(9, ICQTrayIcon.Icon);
  AllImageList.GetIcon(23, MRATrayIcon.Icon);
  AllImageList.GetIcon(30, JabberTrayIcon.Icon);
  //--Загружаем настройки окна
  LoadMainFormSettings;
  if AllSesDataTraf = EmptyStr then AllSesDataTraf := DateTimeToStr(now);
  //--Если это первый старт программы, то по умолчанию активруем ICQ протокол
  if not FirstStart then ICQEnable(true);
  //--Если автоматически проверять новые версии при старте
  if SettingsForm.AutoUpdateCheckBox.Checked then JvTimerList.Events[2].Enabled := true;
  //--Назначаем продвинутые функции активации и деактивации
  Application.OnActivate := AppActivate;
  Application.OnDeactivate := AppDeactivate;
  //--Делаем окно прилипающим к краям экрана
  ScreenSnap := true;
  //--Создаём необходимые листы
  AccountToNick := TStringList.Create;
  InMessList := TStringList.Create;
  SmilesList := TStringList.Create;
  if FileExists(MyPath + 'Profile\' + 'Nicks.txt') then AccountToNick.LoadFromFile(MyPath + 'Profile\' + 'Nicks.txt');
  if FileExists(MyPath + '\Smilies\' + CurrentSmiles + '\smilies.txt') then
    SmilesList.LoadFromFile(MyPath + '\Smilies\' + CurrentSmiles + '\smilies.txt');
  //--Проверяем если ли старый файл после обновления, если есть, то удаляем
  if FileExists(MyPath + 'Imadering.old') then DeleteFile(MyPath + 'Imadering.old');
  //--Если не активно запускаться свёрнутой в трэй то показываем клавное окно
  if not SettingsForm.HideInTrayProgramStartCheckBox.Checked then JvTimerList.Events[0].Enabled := true;
  //--В фоне создаём окно смайлов
  MainForm.JvTimerList.Events[7].Enabled := true;
  //--Загружаем копию локальную списка контактов
  LoadContactList;
  //--Назначаем путь для файла лога сокетов
  WIcsLogger.LogFileName := MyPath + 'Profile\IcsLog.txt';
  //--Инициализируем переменную времени начала статистики трафика сессии
  SesDataTraf := now;
end;

procedure TMainForm.FormDeactivate(Sender: TObject);
begin
  //--Включаем прозрачность окна при неактивности
  if RoasterAlphaBlend then
    if AlphaBlendInactive then AlphaBlendValue := RoasterAlphaValue;
  //--Окно смайлов убрать (глюк в вайн)
  if Assigned(SmilesForm) then
    if SmilesForm.Visible then SmilesForm.Close;
end;

procedure TMainForm.FrandAuthContactClick(Sender: TObject);
begin
  //--Позволяем добавить нас без повторения запроса на авторизацию нам
  if ICQ_Work_Phaze then
    if ContactList.SelectedItem <> nil then ICQ_SendGrandAuth(ContactList.SelectedItem.UIN);
end;

procedure TMainForm.LoadMainFormSettings;
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    //--Загружаем настройки
    if FileExists(MyPath + SettingsFileName) then
    begin
      LoadFromFile(MyPath + SettingsFileName);
      //--Загружаем позицию окна
      if OpenKey('settings\forms\mainform\position') then
      try
        Top := ReadInteger('top');
        Left := ReadInteger('left');
        Height := ReadInteger('height');
        Width := ReadInteger('width');
        //--Определяем не находится ли окно за пределами экрана
        while Top + Height > Screen.Height do Top := Top - 50;
        while Left + Width > Screen.Width do Left := Left - 50;
      finally
        CloseKey();
      end;
      //--Загружаем состояние кнопки звуков
      if OpenKey('settings\forms\mainform\sounds-on-off') then
      try
        if ReadBool('value') then
        begin
          SoundOnOffToolButton.ImageIndex := 136;
          SoundOnOffToolButton.Down := true;
          SoundOnOffToolButton.Hint := SoundOnHint;
        end;
      finally
        CloseKey();
      end;
      //--Загружаем состояние кнопки только онлайн
      if OpenKey('settings\forms\mainform\only-online-on-off') then
      try
        if ReadBool('value') then
        begin
          OnlyOnlineContactsToolButton.ImageIndex := 137;
          OnlyOnlineContactsToolButton.Down := true;
          OnlyOnlineContactsToolButton.Hint := OnlyOnlineOn;
        end;
      finally
        CloseKey();
      end;
      //--Загружаем был ли первый старт
      if OpenKey('settings\forms\mainform\first-start') then
      try
        FirstStart := ReadBool('value');
      finally
        CloseKey();
      end;
      //--Загружаем выбранные протоколы
      if OpenKey('settings\forms\mainform\proto-select') then
      try
        ICQEnable(ReadBool('icq'));
        MRAEnable(ReadBool('mra'));
        JabberEnable(ReadBool('jabber'));
      finally
        CloseKey;
      end;
      //--Загружаем данные трафика
      if OpenKey('settings\traffic') then
      try
        AllTrafSend := ReadFloat('send');
        AllTrafRecev := ReadFloat('recev');
        AllSesDataTraf := ReadString('start-date');
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

procedure TMainForm.SaveMainFormSettings;
begin
  //--Создаём необходимые папки
  ForceDirectories(MyPath + 'Profile');
  //--Сохраняем настройки положения главного окна в xml
  with TrXML.Create() do
  try
    if FileExists(MyPath + SettingsFileName) then LoadFromFile(MyPath + SettingsFileName);
    //--Сохраняем позицию окна
    if OpenKey('settings\forms\mainform\position', True) then
    try
      WriteInteger('top', Top);
      WriteInteger('left', Left);
      WriteInteger('height', Height);
      WriteInteger('width', Width);
    finally
      CloseKey();
    end;
    //--Сохраняем звук вкл. выкл.
    if OpenKey('settings\forms\mainform\sounds-on-off', True) then
    try
      WriteBool('value', SoundOnOffToolButton.Down);
    finally
      CloseKey();
    end;
    //--Сохраняем отображать только онлайн вкл. выкл.
    if OpenKey('settings\forms\mainform\only-online-on-off', True) then
    try
      WriteBool('value', OnlyOnlineContactsToolButton.Down);
    finally
      CloseKey();
    end;
    //--Записываем что первый запуск программы уже состоялся и показывать
    //окно настройки протоколов больше не будем при запуске
    if OpenKey('settings\forms\mainform\first-start', True) then
    try
      WriteBool('value', true);
    finally
      CloseKey();
    end;
    //--Сохраняем активные протоколы
    if OpenKey('settings\forms\mainform\proto-select', True) then
    try
      WriteBool('icq', ICQToolButton.Visible);
      WriteBool('mra', MRAToolButton.Visible);
      WriteBool('jabber', JabberToolButton.Visible);
    finally
      CloseKey();
    end;
    //--Сохраняем трафик
    if OpenKey('settings\traffic', True) then
    try
      WriteFloat('send', AllTrafSend);
      WriteFloat('recev', AllTrafRecev);
      WriteString('start-date', AllSesDataTraf);
    finally
      CloseKey();
    end;
    //--Записываем сам файл
    SaveToFile(MyPath + SettingsFileName);
  finally
    Free();
  end;
end;

procedure TMainForm.SearchInCLClick(Sender: TObject);
begin
  //--Открываем окно поиска контактов в контактном листе
  if not Assigned(CLSearchForm) then CLSearchForm := TCLSearchForm.Create(self);
  //--Отображаем окно
  if CLSearchForm.Visible then ShowWindow(CLSearchForm.Handle, SW_RESTORE);
  CLSearchForm.Show;
  SetForeGroundWindow(CLSearchForm.Handle);
end;

procedure TMainForm.SendAddContactClick(Sender: TObject);
begin
  //--Отправляем пакет "Вас добавили"
  if ICQ_Work_Phaze then
    if ContactList.SelectedItem <> nil then ICQ_SendYouAdded(ContactList.SelectedItem.UIN);
end;

procedure TMainForm.SendInviteContactClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TMainForm.SendMessageForContactClick(Sender: TObject);
begin
  //--Вызываем событие клика по кнопке КЛ
  if ContactList.SelectedItem = nil then Exit;
  //--Делаем двойной клик по контакту
  ContactListButtonClicked(self, ContactList.SelectedItem);
  ContactListButtonClicked(self, ContactList.SelectedItem);
end;

procedure TMainForm.SoundOnOffToolButtonClick(Sender: TObject);
begin
  //--Отображаем иконкой и подсказкой состояние кнопки вкл. выкл. звуков
  if SoundOnOffToolButton.Down then
  begin
    SoundOnOffToolButton.ImageIndex := 136;
    SoundOnOffToolButton.Hint := SoundOnHint;
  end
  else
  begin
    SoundOnOffToolButton.ImageIndex := 135;
    SoundOnOffToolButton.Hint := SoundOffHint;
  end;
end;

procedure TMainForm.TrayPopupMenuPopup(Sender: TObject);
var
  I: integer;
begin
  //--Определяем какой протокол в трэе вызвал это меню и назначаем
  //соответствующую иконку и таг для идентификации на пуект меню выбора статуса
  if TrayProtoClickMenu = 'icqtrayicon' then
  begin
    StatusTray.ImageIndex := ICQToolButton.ImageIndex;
    //--Очищаем пункты субменю
    StatusTray.Clear;
    //--Заполняем субменю пунктами из основного ICQ меню
    with StatusTray do
    begin
      for I := 0 to ICQPopupMenu.Items.Count - 1 do
      begin
        Add(NewItem(ICQPopupMenu.Items[I].Caption, 0, False, True, ICQPopupMenu.Items[I].OnClick, 0, 'MenuItem' + IntToStr(I)));
        //--Назначаем иконку для пункта меню
        Items[I].ImageIndex := ICQPopupMenu.Items[I].ImageIndex;
        //--Назначаем выделение для пункта меню
        Items[I].Default := ICQPopupMenu.Items[I].Default;
      end;
    end;
  end
  else if TrayProtoClickMenu = 'mratrayicon' then
  begin
    StatusTray.ImageIndex := MRAToolButton.ImageIndex;
    //--Очищаем пункты субменю
    StatusTray.Clear;
    //--Заполняем субменю пунктами из основного ICQ меню
    with StatusTray do
    begin
      for I := 0 to MRAPopupMenu.Items.Count - 1 do
      begin
        Add(NewItem(MRAPopupMenu.Items[I].Caption, 0, False, True, MRAPopupMenu.Items[I].OnClick, 0, 'MenuItem' + IntToStr(I)));
        //--Назначаем иконку для пункта меню
        Items[I].ImageIndex := MRAPopupMenu.Items[I].ImageIndex;
        //--Назначаем выделение для пункта меню
        Items[I].Default := MRAPopupMenu.Items[I].Default;
      end;
    end;
  end
  else if TrayProtoClickMenu = 'jabbertrayicon' then
  begin
    StatusTray.ImageIndex := JabberToolButton.ImageIndex;
    //--Очищаем пункты субменю
    StatusTray.Clear;
    //--Заполняем субменю пунктами из основного ICQ меню
    with StatusTray do
    begin
      for I := 0 to JabberPopupMenu.Items.Count - 1 do
      begin
        Add(NewItem(JabberPopupMenu.Items[I].Caption, 0, False, True, JabberPopupMenu.Items[I].OnClick, 0, 'MenuItem' + IntToStr(I)));
        //--Назначаем иконку для пункта меню
        Items[I].ImageIndex := JabberPopupMenu.Items[I].ImageIndex;
        //--Назначаем выделение для пункта меню
        Items[I].Default := JabberPopupMenu.Items[I].Default;
      end;
    end;
  end;
end;

procedure TMainForm.UnstableICQStatusClick(Sender: TObject);
begin
  //--Активируем или деактивируем таймер нестабильного статуса
  if not UnstableICQStatus.Checked then
  begin
    UnstableICQStatus.Checked := true;
    JvTimerList.Events[4].Enabled := true;
  end
  else UnstableICQStatus.Checked := false;
end;

procedure TMainForm.OpenGroupsCLClick(Sender: TObject);
var
  i: integer;
begin
  //--Открываем все группы в контакт листе
  for i := 0 to MainForm.ContactList.Categories.Count - 1 do
  begin
    MainForm.ContactList.Categories[i].Collapsed := false;
  end;
end;

procedure TMainForm.OpenHistoryClick(Sender: TObject);
begin
  //--Открываем пустое окно истории сообщений
  if not Assigned(HistoryForm) then HistoryForm := THistoryForm.Create(self);
  //--Отображаем окно на передний план
  if HistoryForm.Visible then ShowWindow(HistoryForm.Handle, SW_RESTORE);
  HistoryForm.Show;
  SetForeGroundWindow(HistoryForm.Handle);
end;

procedure TMainForm.LoadContactList;
var
  i, k: integer;
  cnt_group, cnt_contact: integer;
begin
  cnt_group := 0;
  cnt_contact := 0;
  //--Инициализируем XML
  with TrXML.Create() do
  try
    //--Загружаем файл контакт листа
    if FileExists(MyPath + 'Profile\ContactList.xml') then
    begin
      LoadFromFile(MyPath + 'Profile\ContactList.xml');
      //--Загружаем группы и контакты в них
      if OpenKey('settings') then
      try
        cnt_group := GetKeyCount('group');
      finally
        CloseKey();
      end;
      with ContactList do
        for i := 0 to cnt_group - 1 do
        begin
          if OpenKey('settings\group', false, i) then
          try
            Categories.Add.Caption := ReadString('caption');
            Categories[i].GroupId := ReadString('id');
            Categories[i].GroupCaption := ReadString('name');
            Categories[i].Collapsed := ReadBool('collapsed');
            cnt_contact := GetKeyCount('contact');
          finally
            CloseKey();
          end;
          for k := 0 to cnt_contact - 1 do
          begin
            if OpenKey('settings\group', false, i) then
            try
              OpenKey('contact', false, k);
              Categories[i].Items.Add.Caption := ReadString('nick');
              Categories[i].Items[k].UIN := ReadString('id');
              Categories[i].Items[k].ContactType := ReadString('type');
              Categories[i].Items[k].Msg := ReadBool('msg');
              if Categories[i].GroupId = 'NoCL' then
              begin
                Categories[i].Items[k].Status := 214;
                Categories[i].Items[k].ImageIndex := 214;
              end
              else
              begin
                Categories[i].Items[k].Status := 9;
                Categories[i].Items[k].ImageIndex := 9;
              end;
              Categories[i].Items[k].ImageIndex1 := -1;
              Categories[i].Items[k].ImageIndex2 := -1;
              //--Растормаживаем фэйс
              Application.ProcessMessages;
            finally
              CloseKey();
            end;
          end;
        end;
    end;
  finally
    Free();
  end;
end;

procedure TMainForm.SaveContactList;
var
  i, k: integer;
begin
  //--Создаём необходимые папки
  ForceDirectories(MyPath + 'Profile');
  //--Сохраняем настройки положения главного окна в xml
  with TrXML.Create() do
  try
    //--Сохраняем в цикле все группы и все контакты в них и флаги непрочитанных сообщений
    with ContactList do
    begin
      for i := 0 to Categories.Count - 1 do
      begin
        //--Записываем группу
        if OpenKey('settings\group', True, i) then
        try
          WriteString('id', Categories[i].GroupId);
          WriteString('caption', Categories[i].Caption);
          WriteString('name', Categories[i].GroupCaption);
          WriteBool('collapsed', Categories[i].Collapsed);
        finally
          CloseKey();
        end;
        for k := 0 to Categories[i].Items.Count - 1 do
        begin
          //--Записываем контакты в этой группе
          if OpenKey('settings\group', True, i) then
          try
            OpenKey('contact', True, k);
            WriteString('id', Categories[i].Items[k].UIN);
            WriteString('nick', Categories[i].Items[k].Caption);
            WriteString('type', Categories[i].Items[k].ContactType);
            WriteBool('msg', Categories[i].Items[k].Msg);
          finally
            CloseKey();
          end;
        end;
      end;
    end;
    //--Записываем сам файл
    SaveToFile(MyPath + 'Profile\ContactList.xml');
  finally
    Free();
  end;
end;

procedure TMainForm.UpdateHttpClientSendEnd(Sender: TObject);
begin
  //--Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + UpdateHttpClient.SentCount;
  AllTrafSend := AllTrafSend + UpdateHttpClient.SentCount;
  if Assigned(TrafficForm) then OpenTrafficClick(nil);
end;

procedure TMainForm.UpdateHttpClientSessionClosed(Sender: TObject);
begin
  //--Обрабатываем возможные ошибки в работе http сокета
  if (UpdateHttpClient.StatusCode = 0) or (UpdateHttpClient.StatusCode >= 400) then
  begin
    DAShow(ErrorHead, ErrorHttpClient(UpdateHttpClient.StatusCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.UpdateHttpClientSocksConnected(Sender: TObject;
  ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.UpdateHttpClientSocksError(Sender: TObject; Error: Integer;
  Msg: string);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
  end;
end;

procedure TMainForm.ICQWSocketError(Sender: TObject);
begin
  //--Отображаем ошибки сокета
  DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  //--Активируем режим оффлайн
  ICQ_GoOffline;
end;

initialization
  RegisterHtHints;

end.

