{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqOptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ButtonGroup, JvPageList, JvExControls, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, OverbyteIcsWSocket, VarsUnit, ShellApi, rXML;

type
  TIcqOptionsForm = class(TForm)
    ICQOptionButtonGroup: TButtonGroup;
    GeneralPanel: TPanel;
    ICQOptionsJvPageList: TJvPageList;
    JvStandardPage1: TJvStandardPage;
    JvStandardPage2: TJvStandardPage;
    JvStandardPage3: TJvStandardPage;
    JvStandardPage4: TJvStandardPage;
    ApplyButton: TBitBtn;
    CancelButton: TBitBtn;
    OKButton: TBitBtn;
    CheckBox5: TCheckBox;
    JvStandardPage5: TJvStandardPage;
    JvStandardPage6: TJvStandardPage;
    ClientIDGroupBox: TGroupBox;
    ClientIDInfoMemo: TMemo;
    ClientIDComboBox: TComboBox;
    ClientIDLabel: TLabel;
    ClientProtoVerEdit: TEdit;
    ClientProtoVerLabel: TLabel;
    ClientCaps1Edit: TEdit;
    ClientCaps2Edit: TEdit;
    ClientCapsLabel: TLabel;
    MyInfoNameGroupBox: TGroupBox;
    OtherOptionsGroupBox: TGroupBox;
    ShowAwayTimeCheckBox: TCheckBox;
    AccountGroupBox: TGroupBox;
    ReqPassLabel: TLabel;
    ICQUINLabel: TLabel;
    PassLabel: TLabel;
    ICQUINEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    JvStandardPage7: TJvStandardPage;
    JvStandardPage8: TJvStandardPage;
    JvStandardPage9: TJvStandardPage;
    JvStandardPage10: TJvStandardPage;
    JvStandardPage11: TJvStandardPage;
    JvStandardPage12: TJvStandardPage;
    AuthAndWebStatusGroupBox: TGroupBox;
    NoAutoAuthRadioButton: TRadioButton;
    YesAutoAuthRadioButton: TRadioButton;
    ShowWebAwareCheckBox: TCheckBox;
    WebAwareTestButton: TButton;
    RegNewICQUINButton: TButton;
    CheckAccountGroupBox: TGroupBox;
    CheckAccountLabel: TLabel;
    Edit5: TEdit;
    CheckAccountButton: TButton;
    PrivatLevelGroupBox: TGroupBox;
    PrivatLevelLabel: TLabel;
    PrivatLevelInfoLabel: TLabel;
    PrivatLevelTrackBar: TTrackBar;
    AutoReqAuthCheckBox: TCheckBox;
    CustomICQPacketGroupBox: TGroupBox;
    CustomICQPacketInfoMemo: TMemo;
    SendCustomICQPacketButton: TButton;
    ClientCaps3Edit: TEdit;
    ClientVersionEdit: TEdit;
    ClientVersionLabel: TLabel;
    PassChangeGroupBox: TGroupBox;
    ChangePassButton: TButton;
    ShowPassChangeCheckBox: TCheckBox;
    RetypeNewPassEdit: TEdit;
    RetypeNewPassLabel: TLabel;
    NewPassChangeEdit: TEdit;
    NewPassChangeLabel: TLabel;
    ReqPassChangeLabel: TLabel;
    CurrentPassChangeEdit: TEdit;
    CurrentPassChangeLabel: TLabel;
    PassChangeInfoMemo: TMemo;
    FamilyInfoEdit: TEdit;
    FamilyInfoLabel: TLabel;
    NameInfoEdit: TEdit;
    NameInfoLabel: TLabel;
    NickInfoEdit: TEdit;
    NickInfoLabel: TLabel;
    EmailsInfoGroupBox: TGroupBox;
    EmailInfo1Label: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    EmailInfo2Label: TLabel;
    EmailInfo3Label: TLabel;
    EmailInfo1Edit: TEdit;
    EmailInfo2Edit: TEdit;
    EmailInfo3Edit: TEdit;
    RegDateInfoEdit: TEdit;
    RegDateInfoLabel: TLabel;
    SendMessInfoLabel: TLabel;
    SendMessInfoEdit: TEdit;
    InMessInfoLabel: TLabel;
    InMessInfoEdit: TEdit;
    ExternalIPInfoLabel: TLabel;
    ExternalIPInfoEdit: TEdit;
    LastTimeInfoLabel: TLabel;
    LastTimeInfoEdit: TEdit;
    ConnectTimeInfoLabel: TLabel;
    ConnectTimeInfoEdit: TEdit;
    OriginalInfoGroupBox: TGroupBox;
    OCountryInfoLabel: TLabel;
    OCityInfoLabel: TLabel;
    OAreaInfoLabel: TLabel;
    OCountryInfoComboBox: TComboBox;
    OCityInfoEdit: TEdit;
    OAreaInfoEdit: TEdit;
    HomeInfoGroupBox: TGroupBox;
    CountryInfoLabel: TLabel;
    CityInfoLabel: TLabel;
    AreaInfoLabel: TLabel;
    ZipInfoLabel: TLabel;
    StreetInfoLabel: TLabel;
    PhoneInfoLabel: TLabel;
    FaxInfoLabel: TLabel;
    CelularInfoLabel: TLabel;
    CityInfoEdit: TEdit;
    AreaInfoEdit: TEdit;
    ZipInfoEdit: TEdit;
    StreetInfoEdit: TEdit;
    PhoneInfoEdit: TEdit;
    FaxInfoEdit: TEdit;
    CelularInfoEdit: TEdit;
    CountryInfoComboBox: TComboBox;
    WorkInfoGroupBox: TGroupBox;
    WorkCountryInfoLabel: TLabel;
    WorkCityInfoLabel: TLabel;
    WorkAreaInfoLabel: TLabel;
    WorkZipInfoLabel: TLabel;
    WorkPhoneInfoLabel: TLabel;
    WorkFaxInfoLabel: TLabel;
    WorkStreetInfoLabel: TLabel;
    WorkCityInfoEdit: TEdit;
    WorkAreaInfoEdit: TEdit;
    WorkZipInfoEdit: TEdit;
    WorkPhoneInfoEdit: TEdit;
    WorkFaxInfoEdit: TEdit;
    WorkStreetInfoEdit: TEdit;
    WorkCountryInfoComboBox: TComboBox;
    CompanyInfoGroupBox: TGroupBox;
    CompanyNameInfoLabel: TLabel;
    CompanyCabInfoLabel: TLabel;
    CompanyProfInfoLabel: TLabel;
    CompanyMasteInfoLabel: TLabel;
    CompanySiteInfoLabel: TLabel;
    CompanyNameInfoEdit: TEdit;
    CompanyCabInfoEdit: TEdit;
    CompanyProfInfoComboBox: TComboBox;
    CompanyMasteInfoEdit: TEdit;
    CompanySiteInfoEdit: TEdit;
    JvStandardPage13: TJvStandardPage;
    PersonalInfoGroupBox: TGroupBox;
    PersonalGenderInfoLabel: TLabel;
    PersonalMaritalInfoLabel: TLabel;
    SpeedButton3: TSpeedButton;
    PersonalHomePageInfoLabel: TLabel;
    PersonalBirthDayInfoLabel: TLabel;
    HoroImage: TImage;
    PersonalAgeInfoLabel: TLabel;
    PersonalDayInfoLabel: TLabel;
    PersonalMonInfoLabel: TLabel;
    PersonalYearInfoLabel: TLabel;
    PersonalChildrenInfoLabel: TLabel;
    PersonalReligionInfoLabel: TLabel;
    PersonalHeightInfoLabel: TLabel;
    PersonalSmokInfoLabel: TLabel;
    PersonalSexInfoLabel: TLabel;
    PersonalHairColourInfoLabel: TLabel;
    PersonalGenderInfoComboBox: TComboBox;
    PersonalMaritalInfoComboBox: TComboBox;
    PersonalHomePageInfoEdit: TEdit;
    PersonalYearInfoEdit: TEdit;
    PersonalAgeInfoEdit: TEdit;
    PersonalChildrenInfoComboBox: TComboBox;
    PersonalReligionInfoComboBox: TComboBox;
    PersonalDayInfoComboBox: TComboBox;
    PersonalMonInfoComboBox: TComboBox;
    PersonalHeightInfoComboBox: TComboBox;
    PersonalSmokInfoComboBox: TComboBox;
    PersonalSexInfoComboBox: TComboBox;
    PersonalHairColourInfoComboBox: TComboBox;
    LangsInfoGroupBox: TGroupBox;
    Lang1InfoComboBox: TComboBox;
    Lang2InfoComboBox: TComboBox;
    Lang3InfoComboBox: TComboBox;
    InterestInfoGroupBox: TGroupBox;
    Interest1InfoComboBox: TComboBox;
    Interest2InfoComboBox: TComboBox;
    Interest3InfoComboBox: TComboBox;
    Interest4InfoComboBox: TComboBox;
    Interest1InfoEdit: TEdit;
    Interest2InfoEdit: TEdit;
    Interest3InfoEdit: TEdit;
    Interest4InfoEdit: TEdit;
    AboutInfoGroupBox: TGroupBox;
    AvatarInfoGroupBox: TGroupBox;
    AvatarInfoPanel: TPanel;
    AvatarInfoImage: TImage;
    ParamInfoGroupBox: TGroupBox;
    SendCustomICQPacketRichEdit: TRichEdit;
    SendCustomICQPaketTimerCheckBox: TCheckBox;
    SendCustomICQPaketTimerEdit: TEdit;
    SendCustomICQPaketTimer: TTimer;
    AboutInfoRichEdit: TRichEdit;
    ParamInfoRichEdit: TRichEdit;
    CountryCodesComboBox: TComboBox;
    OccupationCodeComboBox: TComboBox;
    LangsCodeComboBox: TComboBox;
    InterestsCodesComboBox: TComboBox;
    MaritalCodesComboBox: TComboBox;
    HairColourCodesComboBox: TComboBox;
    ReligionCodesComboBox: TComboBox;
    SmokCodesComboBox: TComboBox;
    SexCodesComboBox: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ReqPassLabelMouseLeave(Sender: TObject);
    procedure ReqPassLabelMouseEnter(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ICQOptionButtonGroupButtonClicked(Sender: TObject; Index: Integer);
    procedure ICQUINEditChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure SavePassCheckBoxClick(Sender: TObject);
    procedure ReqPassLabelClick(Sender: TObject);
    procedure ShowPassChangeCheckBoxClick(Sender: TObject);
    procedure ChangePassButtonClick(Sender: TObject);
    procedure WebAwareTestButtonClick(Sender: TObject);
    procedure RegNewICQUINButtonClick(Sender: TObject);
    procedure ICQOptionButtonGroupKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PassEditClick(Sender: TObject);
    procedure ClientIDInfoMemoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SendCustomICQPaketTimerEditExit(Sender: TObject);
    procedure SendCustomICQPaketTimerEditKeyPress(Sender: TObject;
      var Key: Char);
    procedure SendCustomICQPacketButtonClick(Sender: TObject);
    procedure SendCustomICQPaketTimerTimer(Sender: TObject);
  private
    { Private declarations }
    procedure ApplySettings;
    procedure LoadSettings;
  public
    { Public declarations }
    procedure TranslateForm;
    procedure SetOnlineVars;
  end;

var
  IcqOptionsForm: TIcqOptionsForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, Code, SettingsUnit, UtilsUnit, IcqRegNewUINUnit;

//APPLY SETTINGS----------------------------------------------------------------

procedure TIcqOptionsForm.ApplySettings;
begin
  //--Применяем настройки ICQ протокола
  //--Нормализуем ICQ логин
  ICQUINEdit.Text := Trim(ICQUINEdit.Text);
  ICQUINEdit.Text := exNormalizeIcqNumber(ICQUINEdit.Text);
  ICQUINEdit.Text := exNormalizeScreenName(ICQUINEdit.Text);
  //--Обновляем данные логина в протоколе
  if ICQUINEdit.Enabled then
  begin
    ICQ_LoginUIN := ICQUINEdit.Text;
    PassEdit.Hint := PassEdit.Text;
    ICQ_LoginPassword := PassEdit.Hint;
  end;


  //----------------------------------------------------------------------------
  //--Записываем настройки ICQ протокола в файл
  With TrXML.Create() do try
    if FileExists(MyPath + SettingsFileName) then
      LoadFromFile(MyPath + SettingsFileName);
    If OpenKey('settings\icq\account', True) then try
      WriteString('login', ICQUINEdit.Text);
      WriteBool('save-password', SavePassCheckBox.Checked);
      if SavePassCheckBox.Checked then
        WriteString('password', Encrypt(PassEdit.Hint, PassKey))
      else
        WriteString('password', EmptyStr);
      //--Маскируем пароль
      if PassEdit.Text <> EmptyStr then
        PassEdit.Text := '----------------------';
    finally
      CloseKey();
    end;
    SaveToFile(MyPath + SettingsFileName);
  finally
    Free();
  end;

  //--Деактивируем кнопку применения настроек
  ApplyButton.Enabled := false;
end;

//LOAD SETTINGS-----------------------------------------------------------------

procedure TIcqOptionsForm.LoadSettings;
begin
  //--Инициализируем XML
  With TrXML.Create() do try
    if FileExists(MyPath + SettingsFileName) then begin
      LoadFromFile(MyPath + SettingsFileName);

      //--Загружаем позицию окна
      if OpenKey('settings\icq\account') then try
        ICQUINEdit.Text := ReadString('login');
        if ICQUINEdit.Text <> EmptyStr then
          ICQ_LoginUIN := ICQUINEdit.Text;
        SavePassCheckBox.Checked := ReadBool('save-password');
        PassEdit.Text := ReadString('password');
        if PassEdit.Text <> EmptyStr then begin
          PassEdit.Hint := Decrypt(PassEdit.Text, PassKey);
          ICQ_LoginPassword := PassEdit.Hint;
          PassEdit.Text := '----------------------';
        end;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
end;

procedure TIcqOptionsForm.RegNewICQUINButtonClick(Sender: TObject);
begin
  //--Открываем окно регистрации нового номера ICQ
  if not Assigned(IcqRegNewUINForm) then IcqRegNewUINForm := TIcqRegNewUINForm.Create(MainForm);
  IcqRegNewUINForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(IcqRegNewUINForm.Handle);
end;

procedure TIcqOptionsForm.ReqPassLabelClick(Sender: TObject);
begin
  //--Открываем сайт ICQ для восстановления пароля
  ShellExecute(Application.Handle, 'open', PChar('http://www.icq.com/password'), nil, nil, SW_SHOWNORMAL);
end;

procedure TIcqOptionsForm.ReqPassLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clBlue;
end;

procedure TIcqOptionsForm.ReqPassLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clNavy;
end;

procedure TIcqOptionsForm.TranslateForm;
begin
  //

  //--Присваиваем список стран другим комбобоксам отображающим такой же список
  OCountryInfoComboBox.Items.Assign(CountryInfoComboBox.Items);
  WorkCountryInfoComboBox.Items.Assign(CountryInfoComboBox.Items);
  //--Присваиваем список интересов другим комбобоксам отображающим такой же список
  Interest2InfoComboBox.Items.Assign(Interest1InfoComboBox.Items);
  Interest3InfoComboBox.Items.Assign(Interest1InfoComboBox.Items);
  Interest4InfoComboBox.Items.Assign(Interest1InfoComboBox.Items);
  //--Присваиваем список языков другим комбобоксам отображающим такой же список
  Lang2InfoComboBox.Items.Assign(Lang1InfoComboBox.Items);
  Lang3InfoComboBox.Items.Assign(Lang1InfoComboBox.Items);
end;

procedure TIcqOptionsForm.OKButtonClick(Sender: TObject);
begin
  //--Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then ApplySettings;
  Close;
end;

procedure TIcqOptionsForm.PassEditClick(Sender: TObject);
begin
  //--Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = '----------------------' then PassEdit.Text := EmptyStr;
end;

procedure TIcqOptionsForm.CancelButtonClick(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TIcqOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  //--Применяем настройки
  ApplySettings;
end;

procedure TIcqOptionsForm.ChangePassButtonClick(Sender: TObject);
begin
  if ICQ_Work_Phaze then
  begin
    if (CurrentPassChangeEdit.Text = EmptyStr) or (CurrentPassChangeEdit.Text <> ICQ_LoginPassword) then DAShow(AlertHead, PassChangeAlert_1, EmptyStr, 134, 2, 0)
    else if NewPassChangeEdit.Text = EmptyStr then DAShow(AlertHead, PassChangeAlert_1, EmptyStr, 134, 2, 0)
    else if Length(NewPassChangeEdit.Text) < 6 then DAShow(AlertHead, PassChangeAlert_1, EmptyStr, 134, 2, 0)
    else if (RetypeNewPassEdit.Text = EmptyStr) or (RetypeNewPassEdit.Text <> NewPassChangeEdit.Text) then DAShow(AlertHead, PassChangeAlert_1, EmptyStr, 134, 2, 0)
    else begin
      ICQ_PassChange(RetypeNewPassEdit.Text);
      ICQ_ChangePassword := RetypeNewPassEdit.Text;
    end;
  end
  else DAShow(AlertHead, OnlineAlert, EmptyStr, 134, 2, 0);
end;

procedure TIcqOptionsForm.ClientIDInfoMemoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  //ClientIDInfoMemo.
end;

procedure TIcqOptionsForm.SendCustomICQPacketButtonClick(Sender: TObject);
var
  Pkt: string;
begin
  //--Копируем текст пакета из рича (используем ричедит против глюка с отрисовкой мемо в виндовс 7)
  Pkt := Trim(SendCustomICQPacketRichEdit.Text);
  //--Если пакет больше нуля и рабочая фаза icq подключения
  if (Pkt > EmptyStr) and ICQ_Work_Phaze then
  begin
    //--Удаляем все переносы строк из пакета
    Pkt := DeleteLineBreaks(Pkt);
    //--Удаляем все пробелы из пакета
    Pkt := DeleteSpaces(Pkt);
    //--Если пакет с заголовком, то удаляем из пакета заголовок
    if (Length(Pkt) > 2) and (UpperCase(Pkt[1] + Pkt[2]) = '2A') then
    begin
      NextData(Pkt, 12);
      //--Отправляем пакет по второму каналу
      SendFLAP('2', Pkt);
    end
    else SendFLAP('2', Pkt);
    //--Запускаем таймер повтора отправки если установлено
    if SendCustomICQPaketTimerCheckBox.Checked then
    begin
      //--Применяем время таймера
      SendCustomICQPaketTimer.Interval := StrToInt(SendCustomICQPaketTimerEdit.Text) * 1000;
      //--Пересбрасываем и перезапускаем таймер
      SendCustomICQPaketTimer.Enabled := false;
      SendCustomICQPaketTimer.Enabled := true;
    end;
  end;
  //--Сохраняем пакет локально для дальнейшего использования
  SendCustomICQPacketRichEdit.Lines.SaveToFile(MyPath + 'Profile\IcqPacket.txt');
end;

procedure TIcqOptionsForm.SendCustomICQPaketTimerEditExit(Sender: TObject);
begin
  //--Если ввод пустой, то ставим по дефолту
  if SendCustomICQPaketTimerEdit.Text = EmptyStr then SendCustomICQPaketTimerEdit.Text := '10';
end;

procedure TIcqOptionsForm.SendCustomICQPaketTimerEditKeyPress(Sender: TObject;
  var Key: Char);
const
  ValidAsciiChars = ['0'..'9'];
begin
  //--Делаем так, что вводить можно только цифры
  if (not (Key in ValidAsciiChars)) and (Key <> #8) then Key := #0;
end;

procedure TIcqOptionsForm.SendCustomICQPaketTimerTimer(Sender: TObject);
begin
  //--Применяем время таймера
  SendCustomICQPaketTimer.Interval := StrToInt(SendCustomICQPaketTimerEdit.Text) * 1000;
  //--Нажимаем на кнопку отправки
  if SendCustomICQPaketTimerCheckBox.Checked then SendCustomICQPacketButtonClick(self)
  else SendCustomICQPaketTimer.Enabled := false;
end;

procedure TIcqOptionsForm.ICQOptionButtonGroupButtonClicked(Sender: TObject;
  Index: Integer);
begin
  //--Выбираем страницу настроек соответсвенно выбранной вкладке
  if Index <= ICQOptionsJvPageList.PageCount then ICQOptionsJvPageList.ActivePageIndex := Index;
end;

procedure TIcqOptionsForm.ICQOptionButtonGroupKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //--Выбираем страницу настроек соответсвенно выбранной вкладке
  if ICQOptionButtonGroup.ItemIndex <= ICQOptionsJvPageList.PageCount then ICQOptionsJvPageList.ActivePageIndex := ICQOptionButtonGroup.ItemIndex;
end;

procedure TIcqOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
begin
  //--Отменяем событие изменения поля пароля
  PassEdit.OnChange := nil;
  //--Показываем пароль в поле ввода пароля
  if ShowPassCheckBox.Checked then PassEdit.PasswordChar := #0
  else PassEdit.PasswordChar := '*';
  //--Восстанавливаем событие изменения поля пароля
  PassEdit.OnChange := ICQUINEditChange;
end;

procedure TIcqOptionsForm.SavePassCheckBoxClick(Sender: TObject);
begin
  //Edit1Change(self);
end;

procedure TIcqOptionsForm.ShowPassChangeCheckBoxClick(Sender: TObject);
begin
  if ShowPassChangeCheckBox.Checked then
  begin
    CurrentPassChangeEdit.PasswordChar := #0;
    NewPassChangeEdit.PasswordChar := #0;
    RetypeNewPassEdit.PasswordChar := #0;
  end
  else
  begin
    CurrentPassChangeEdit.PasswordChar := '*';
    NewPassChangeEdit.PasswordChar := '*';
    RetypeNewPassEdit.PasswordChar := '*';
  end;
end;

procedure TIcqOptionsForm.ICQUINEditChange(Sender: TObject);
begin
  //--Активируем кнопку применения настроек
  ApplyButton.Enabled := true;
end;

procedure TIcqOptionsForm.FormCreate(Sender: TObject);
begin
  //--Переводим форму на другие языки
  TranslateForm;
  //--Загружаем настройки
  LoadSettings;
  //--Применяем онлайн переменные
  SetOnlineVars;
  //--Деактивируем кнопку "применить"
  ApplyButton.Enabled := false;
  //--Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(81, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TIcqOptionsForm.WebAwareTestButtonClick(Sender: TObject);
begin
  //--Открываем браузер для проверки веб-статуса на сайте ICQ
  if ICQ_LoginUIN <> EmptyStr then
    ShellExecute(Application.Handle, 'open', PChar('http://status.icq.com/online.gif?icq=' + ICQ_LoginUIN + '&img=5'), nil, nil, SW_SHOWNORMAL);
end;

procedure TIcqOptionsForm.SetOnlineVars;
begin
  //--Загружаем онлайн переменные
  ConnectTimeInfoEdit.Text := MyConnTime;
  RegDateInfoEdit.Text := ICQ_MyUIN_RegTime;
  ExternalIPInfoEdit.Text := ICQ_Online_IP;
  SendMessInfoEdit.Text := ICQ_SendMess;
  InMessInfoEdit.Text := ICQ_RecMess;
  LastTimeInfoEdit.Text := ICQ_LastActive;
  //--Заполняем мемо дополнительной информацией о ICQ аккаунте
  ParamInfoRichEdit.Clear;
  //--Начинаем заполнение строк
  ParamInfoRichEdit.Lines.BeginUpdate;
  //--Добавляем информацию не вошедшую в другие разделы
  if ICQ_CollSince <> EmptyStr then ParamInfoRichEdit.Lines.Add(OnlineInfo1L + ': ' + ICQ_CollSince);
  if ICQ_OnlineTime <> EmptyStr then ParamInfoRichEdit.Lines.Add(OnlineInfo2L + ': ' + ICQ_OnlineTime);
  if ICQ_AwayMess <> EmptyStr then ParamInfoRichEdit.Lines.Add(OnlineInfo3L + ': ' + ICQ_AwayMess);
  if ICQ_Well_Known_URL <> EmptyStr then
  begin
    ParamInfoRichEdit.Lines.Add(OnlineInfo4L + ':' + #13#10 + ICQ_Well_Known_URL);
    ParamInfoRichEdit.Lines.Delete(ParamInfoRichEdit.Lines.Count - 1);
  end;
  if Bos_Addr <> EmptyStr then ParamInfoRichEdit.Lines.Add(OnlineInfo5L + ': ' + Bos_Addr);
  if ICQ_MyIcon_Hash <> EmptyStr then ParamInfoRichEdit.Lines.Add(OnlineInfo6L + ': ' + ICQ_MyIcon_Hash);
  if ICQ_CL_Count > 0 then ParamInfoRichEdit.Lines.Add(OnlineInfo7L + ': ' + IntToStr(ICQ_CL_Count));
  //--Заканчиваем заполнение строк
  ParamInfoRichEdit.Lines.EndUpdate;
end;

end.

