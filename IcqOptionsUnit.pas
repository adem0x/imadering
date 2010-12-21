{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqOptionsUnit;

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
  ButtonGroup,
  JvPageList,
  JvExControls,
  ExtCtrls,
  StdCtrls,
  Buttons,
  ComCtrls,
  OverbyteIcsWSocket,
  VarsUnit,
  ShellApi,
  JvSimpleXml;

type
  TIcqOptionsForm = class(TForm)
    ICQOptionButtonGroup: TButtonGroup;
    GeneralPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    PrivatPage: TJvStandardPage;
    ConsolePage: TJvStandardPage;
    IDClientPage: TJvStandardPage;
    ApplyButton: TBitBtn;
    CancelButton: TBitBtn;
    OKButton: TBitBtn;
    Eye: TJvStandardPage;
    AnketaPage: TJvStandardPage;
    ClientIDGroupBox: TGroupBox;
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
    HomePage: TJvStandardPage;
    WorkPage: TJvStandardPage;
    PersonalPage: TJvStandardPage;
    InterestsPage: TJvStandardPage;
    AvatarPage: TJvStandardPage;
    AuthAndWebStatusGroupBox: TGroupBox;
    NoAutoAuthRadioButton: TRadioButton;
    YesAutoAuthRadioButton: TRadioButton;
    ShowWebAwareCheckBox: TCheckBox;
    PrivatLevelGroupBox: TGroupBox;
    AutoReqAuthCheckBox: TCheckBox;
    CustomICQPacketGroupBox: TGroupBox;
    ClientCaps3Edit: TEdit;
    ClientVersionEdit: TEdit;
    ClientVersionLabel: TLabel;
    EyeGroupBox: TGroupBox;
    ClearEyeButton: TButton;
    EyeDisableCheckBox: TCheckBox;
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
    ParamsPage: TJvStandardPage;
    PersonalInfoGroupBox: TGroupBox;
    PersonalGenderInfoLabel: TLabel;
    PersonalMaritalInfoLabel: TLabel;
    SpeedButton3: TSpeedButton;
    PersonalHomePageInfoLabel: TLabel;
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
    AvatarInfoGroupBox: TGroupBox;
    ParamInfoGroupBox: TGroupBox;
    SendCustomICQPacketRichEdit: TRichEdit;
    ParamInfoRichEdit: TRichEdit;
    RegNewUINLabel: TLabel;
    ConnectPage: TJvStandardPage;
    DumpInfoRichEdit: TRichEdit;
    AboutInfoGroupBox: TGroupBox;
    AboutInfoRichEdit: TRichEdit;
    Bevel1: TBevel;
    ClientIdInfoRichEdit: TRichEdit;
    EyeInfoRichEdit: TRichEdit;
    PersonalBirthDayInfoLabel: TLabel;
    CustomPktLabel: TLabel;
    ClientLoginIdEdit: TEdit;
    ClientLoginIDLabel: TLabel;
    ConnectionGroupBox: TGroupBox;
    Bevel2: TBevel;
    ServerLabel: TLabel;
    PortLabel: TLabel;
    UseSSLCheckBox: TCheckBox;
    PortEdit: TEdit;
    ServerComboBox: TComboBox;
    SendCustomICQPacketButton: TBitBtn;
    EyeListView: TListView;
    ChangePassLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ReqPassLabelMouseLeave(Sender: TObject);
    procedure ReqPassLabelMouseEnter(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ICQOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure ICQUINEditChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure ReqPassLabelClick(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure RegNewUINLabelClick(Sender: TObject);
    procedure ICQOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PassEditChange(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SendCustomICQPacketButtonClick(Sender: TObject);
    procedure ChangePassLabelClick(Sender: TObject);

  private
    { Private declarations }
    procedure LoadSettings;

  public
    { Public declarations }
    procedure TranslateForm;
    procedure ApplySettings;
    procedure SaveSettings;
    procedure SetOnlineVars;
  end;

{$ENDREGION}

var
  IcqOptionsForm: TIcqOptionsForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  SettingsUnit,
  UtilsUnit,
  OverbyteIcsMimeUtils,
  OverbyteIcsUrl,
  RosterUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_ClientId = 'ClientId';
  C_ClientLoginID = 'ClientLoginID';
  C_IcqCountries = 'icq_countries';
  C_IcqLangs = 'icq_languages';
  C_IcqInteres = 'icq_interests';
  C_IcqOccup = 'icq_occupation';
  C_IcqHair = 'icq_hair';
  C_IcqChild = 'icq_children';
  C_IcqHeight = 'icq_height';
  C_IcqSmok = 'icq_smoking';
  C_Relig = 'icq_religion';
  C_IcqSex = 'icq_sexual';
  C_IcqMarital = 'icq_marital';
  C_IcqGender = 'icq_gender';

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TIcqOptionsForm.LoadSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
      begin
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Icq];
          if XML_Node <> nil then
          begin
            // --------------------------------------------------------------------------
            // Загружаем данные логина
            ICQUINEdit.Text := XML_Node.Properties.Value(C_Login);
            SavePassCheckBox.Checked := XML_Node.Properties.BoolValue(C_SavePass);
            // Загружаем пароль
            PassEdit.OnChange := nil;
            PassEdit.Text := XML_Node.Properties.Value(C_Pass);
            if PassEdit.Text <> EmptyStr then
            begin
              PassEdit.Hint := URLDecode(Base64Decode(PassEdit.Text));
              PassEdit.Text := C_MaskPass;
            end;
            PassEdit.OnChange := PassEditChange;
            // --------------------------------------------------------------------------
            // Загружаем настройки идентификации
            Sub_Node := XML_Node.Items.ItemNamed[C_ClientLoginID];
            if Sub_Node <> nil then
            begin
              if Sub_Node.Value <> EmptyStr then
                ClientLoginIdEdit.Text := Sub_Node.Value;
            end;
            // --------------------------------------------------------------------------
            // Загружаем сервер подключения
            Sub_Node := XML_Node.Items.ItemNamed[C_CustomServer];
            if Sub_Node <> nil then
            begin
              if Sub_Node.Properties.Value(C_Host) <> EmptyStr then
                ServerComboBox.Text := Sub_Node.Properties.Value(C_Host);
              if Sub_Node.Properties.Value(C_Port) <> EmptyStr then
                PortEdit.Text := Sub_Node.Properties.Value(C_Port);
            end;
            // --------------------------------------------------------------------------
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'ApplySettings'}

procedure TIcqOptionsForm.ApplySettings;
begin
  // Применяем настройки ICQ протокола
  // --------------------------------------------------------------------------
  // Нормализуем ICQ логин
  ICQUINEdit.Text := Trim(ICQUINEdit.Text);
  ICQUINEdit.Text := NormalizeIcqNumber(ICQUINEdit.Text);
  ICQUINEdit.Text := NormalizeScreenName(ICQUINEdit.Text);
  // Обновляем данные логина в протоколе
  if ICQUINEdit.Enabled then
  begin
    if ICQUINEdit.Text <> ICQ_LoginUIN then
    begin
      ClearContacts(C_Icq); // Очищаем контакты предыдущего аккаунта
      ICQ_LoginUIN := ICQUINEdit.Text;
    end;
    ICQ_LoginPassword := PassEdit.Hint;
    // Делаем подсказку
    if ICQ_LoginUIN <> EmptyStr then
      MainForm.ICQToolButton.Hint := Format(C_AS, [C_Icq]) + C_BN + C_NN + C_BN + C_QN + ICQ_LoginUIN + C_EN
    else
      MainForm.ICQToolButton.Hint := Format(C_AS, [C_Icq]);
  end;
  // --------------------------------------------------------------------------
  // Настройки сервера подключения
  if (ServerComboBox.Text <> EmptyStr) and (PortEdit.Text <> EmptyStr) then
  begin
    ICQ_LoginServerAddr := ServerComboBox.Text;
    ICQ_LoginServerPort := PortEdit.Text;
  end;
  // --------------------------------------------------------------------------
  // Настройки идентификации клиента
  if ClientLoginIdEdit.Text <> EmptyStr then
    ICQ_ClientLoginID := ClientLoginIdEdit.Text;
  // --------------------------------------------------------------------------
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TIcqOptionsForm.SaveSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Записываем настройки ICQ протокола в файл
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      if Root <> nil then
      begin
        // Очищаем раздел главной формы если он есть
        XML_Node := Root.Items.ItemNamed[C_Icq];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_Icq);
        // --------------------------------------------------------------------------
        // Записываем данные логина
        XML_Node.Properties.Add(C_Login, ICQUINEdit.Text);
        XML_Node.Properties.Add(C_SavePass, SavePassCheckBox.Checked);
        if SavePassCheckBox.Checked then
          XML_Node.Properties.Add(C_Pass, Base64Encode(URLEncode(PassEdit.Hint)))
        else
        begin
          XML_Node.Properties.Add(C_Pass, EmptyStr);
          PassEdit.Text := EmptyStr;
        end;
        // Маскируем пароль
        if PassEdit.Text <> EmptyStr then
          PassEdit.Text := C_MaskPass;
        // --------------------------------------------------------------------------
        // Сохраняем сервер подключения
        Sub_Node := XML_Node.Items.Add(C_CustomServer);
        Sub_Node.Properties.Add(C_Host, ServerComboBox.Text);
        Sub_Node.Properties.Add(C_Port, PortEdit.Text);
        // --------------------------------------------------------------------------
        // Сохраняем настройки идентификации
        Sub_Node := XML_Node.Items.Add(C_ClientLoginID);
        Sub_Node.Value := ClientLoginIdEdit.Text;
        // --------------------------------------------------------------------------
        // Сохраняем файл
        SaveToFile(V_ProfilePath + C_SettingsFileName);
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TIcqOptionsForm.TranslateForm;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
      begin
        // Загружаем файл языка
        LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Infos];
          if XML_Node <> nil then
          begin
            // Загружаем инфы
            Sub_Node := XML_Node.Items.ItemNamed[C_ClientId];
            if Sub_Node <> nil then
              ClientIdInfoRichEdit.Lines.Text := CheckText_RN(Sub_Node.Properties.Value('c'));
            Sub_Node := XML_Node.Items.ItemNamed[EyeInfoRichEdit.Name];
            if Sub_Node <> nil then
              EyeInfoRichEdit.Lines.Text := CheckText_RN(Sub_Node.Properties.Value('c'));
            Sub_Node := XML_Node.Items.ItemNamed[DumpInfoRichEdit.Name];
            if Sub_Node <> nil then
              DumpInfoRichEdit.Lines.Text := CheckText_RN(Sub_Node.Properties.Value('c'));
          end;
          // Загружаем списки
          // Страны
          XML_Node := Root.Items.ItemNamed[C_IcqCountries];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                CountryInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Языки
          XML_Node := Root.Items.ItemNamed[C_IcqLangs];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                Lang1InfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Интересы
          XML_Node := Root.Items.ItemNamed[C_IcqInteres];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                Interest1InfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Профессия
          XML_Node := Root.Items.ItemNamed[C_IcqOccup];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                CompanyProfInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Цвет волос
          XML_Node := Root.Items.ItemNamed[C_IcqHair];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalHairColourInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Детей
          XML_Node := Root.Items.ItemNamed[C_IcqChild];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalChildrenInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Рост
          XML_Node := Root.Items.ItemNamed[C_IcqHeight];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalHeightInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Курение
          XML_Node := Root.Items.ItemNamed[C_IcqSmok];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalSmokInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Религия
          XML_Node := Root.Items.ItemNamed[C_Relig];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalReligionInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Секс
          XML_Node := Root.Items.ItemNamed[C_IcqSex];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalSexInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Соц. статус
          XML_Node := Root.Items.ItemNamed[C_IcqMarital];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalMaritalInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
          // Пол
          XML_Node := Root.Items.ItemNamed[C_IcqGender];
          if XML_Node <> nil then
          begin
            for I := 1 to XML_Node.Items.Count do
            begin
              Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
              if Sub_Node <> nil then
                PersonalGenderInfoComboBox.Items.Add(Sub_Node.Properties.Value('c'));
            end;
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Присваиваем список стран другим комбобоксам отображающим такой же список
  OCountryInfoComboBox.Items.Assign(CountryInfoComboBox.Items);
  WorkCountryInfoComboBox.Items.Assign(CountryInfoComboBox.Items);
  // Присваиваем список интересов другим комбобоксам отображающим такой же список
  Interest2InfoComboBox.Items.Assign(Interest1InfoComboBox.Items);
  Interest3InfoComboBox.Items.Assign(Interest1InfoComboBox.Items);
  Interest4InfoComboBox.Items.Assign(Interest1InfoComboBox.Items);
  // Присваиваем список языков другим комбобоксам отображающим такой же список
  Lang2InfoComboBox.Items.Assign(Lang1InfoComboBox.Items);
  Lang3InfoComboBox.Items.Assign(Lang1InfoComboBox.Items);
  // Другое
  ApplyButton.Caption := Lang_Vars[10].L_S;
  CancelButton.Caption := Lang_Vars[9].L_S;
  SendCustomICQPacketButton.Caption := Lang_Vars[165].L_S;
  OCountryInfoLabel.Caption := CountryInfoLabel.Caption;
  OAreaInfoLabel.Caption := AreaInfoLabel.Caption;
  OCityInfoLabel.Caption := CityInfoLabel.Caption;
  WorkCountryInfoLabel.Caption := CountryInfoLabel.Caption;
  WorkCityInfoLabel.Caption := CityInfoLabel.Caption;
  WorkAreaInfoLabel.Caption := AreaInfoLabel.Caption;
  WorkZipInfoLabel.Caption := ZipInfoLabel.Caption;
  WorkPhoneInfoLabel.Caption := PhoneInfoLabel.Caption;
  WorkFaxInfoLabel.Caption := FaxInfoLabel.Caption;
  WorkStreetInfoLabel.Caption := StreetInfoLabel.Caption;
  // Расширяем комбобоксы
  SetCustomWidthComboBox(CountryInfoComboBox);
  SetCustomWidthComboBox(OCountryInfoComboBox);
  SetCustomWidthComboBox(WorkCountryInfoComboBox);
  SetCustomWidthComboBox(Lang1InfoComboBox);
  SetCustomWidthComboBox(Lang2InfoComboBox);
  SetCustomWidthComboBox(Lang3InfoComboBox);
  SetCustomWidthComboBox(Interest1InfoComboBox);
  SetCustomWidthComboBox(Interest2InfoComboBox);
  SetCustomWidthComboBox(Interest3InfoComboBox);
  SetCustomWidthComboBox(Interest4InfoComboBox);
  SetCustomWidthComboBox(CompanyProfInfoComboBox);
  SetCustomWidthComboBox(PersonalHairColourInfoComboBox);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqOptionsForm.RegNewUINLabelClick(Sender: TObject);
begin
  // Открываем регистрацию на веб сайте ICQ
  OpenURL(C_IcqReg);
end;

procedure TIcqOptionsForm.ReqPassLabelClick(Sender: TObject);
begin
  // Открываем сайт ICQ для восстановления пароля
  OpenURL('http://www.icq.com/password');
end;

procedure TIcqOptionsForm.ReqPassLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClBlue;
end;

procedure TIcqOptionsForm.ReqPassLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClNavy;
end;

procedure TIcqOptionsForm.OKButtonClick(Sender: TObject);
begin
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then
    ApplyButtonClick(Self);
  // Закрываем окно
  Close;
end;

procedure TIcqOptionsForm.PassEditChange(Sender: TObject);
begin
  PassEdit.Hint := PassEdit.Text;
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TIcqOptionsForm.PassEditClick(Sender: TObject);
begin
  // Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = C_MaskPass then
    PassEdit.Text := EmptyStr;
end;

procedure TIcqOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TIcqOptionsForm.ChangePassLabelClick(Sender: TObject);
begin
  // Открываем страницу смены пароля
  OpenURL('http://www.icq.com/support/change_password/');
end;

procedure TIcqOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  // Применяем настройки
  ApplySettings;
  // Сохраняем настройки
  SaveSettings;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqOptionsForm.ICQOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := index;
end;

procedure TIcqOptionsForm.ICQOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if ICQOptionButtonGroup.ItemIndex <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := ICQOptionButtonGroup.ItemIndex;
end;

procedure TIcqOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
begin
  // Отменяем событие изменения поля пароля
  PassEdit.OnChange := nil;
  // Показываем пароль в поле ввода пароля
  if ShowPassCheckBox.Checked then
    PassEdit.PasswordChar := #0
  else
    PassEdit.PasswordChar := '*';
  // Восстанавливаем событие изменения поля пароля
  PassEdit.OnChange := PassEditChange;
end;

procedure TIcqOptionsForm.ICQUINEditChange(Sender: TObject);
begin
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TIcqOptionsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TIcqOptionsForm.FormCreate(Sender: TObject);
begin
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(81, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(222, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, SendCustomICQPacketButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Назначаем разделитель значений для списков
  CountryInfoComboBox.Items.NameValueSeparator := C_BN;
  OCountryInfoComboBox.Items.NameValueSeparator := C_BN;
  WorkCountryInfoComboBox.Items.NameValueSeparator := C_BN;
  Lang1InfoComboBox.Items.NameValueSeparator := C_BN;
  Lang2InfoComboBox.Items.NameValueSeparator := C_BN;
  Lang3InfoComboBox.Items.NameValueSeparator := C_BN;
  Interest1InfoComboBox.Items.NameValueSeparator := C_BN;
  Interest2InfoComboBox.Items.NameValueSeparator := C_BN;
  Interest3InfoComboBox.Items.NameValueSeparator := C_BN;
  Interest4InfoComboBox.Items.NameValueSeparator := C_BN;
  CompanyProfInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalHairColourInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalChildrenInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalHeightInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalSmokInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalReligionInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalSexInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalMaritalInfoComboBox.Items.NameValueSeparator := C_BN;
  PersonalGenderInfoComboBox.Items.NameValueSeparator := C_BN;
  // Логин ID
  ClientLoginIdEdit.Text := ICQ_ClientLoginID;
  // Сервер
  ServerComboBox.Text := ICQ_LoginServerAddr;
  PortEdit.Text := ICQ_LoginServerPort;
  // Загружаем настройки
  LoadSettings;
  // Переводим форму на другие языки
  TranslateForm;
  // Применяем настройки
  ApplySettings;
  // Подгружаем произвольный пакет
  if FileExists(V_ProfilePath + C_Icq + C_BN + C_PacketFileName) then
    SendCustomICQPacketRichEdit.Lines.LoadFromFile(V_ProfilePath + C_Icq + C_BN + C_PacketFileName);
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TIcqOptionsForm.FormShow(Sender: TObject);
begin
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  // Прокручиваем на первую вкладку
  OptionJvPageList.ActivePage := AccountPage;
  IcqOptionButtonGroup.ItemIndex := 0;
  // Прокручиваем рич в верх против глюка в вайн
  ClientIdInfoRichEdit.SelStart := 0;
  SendMessage(ClientIdInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
  EyeInfoRichEdit.SelStart := 0;
  SendMessage(EyeInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
  DumpInfoRichEdit.SelStart := 0;
  SendMessage(DumpInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
  // Загружаем онлайн параметры
  SetOnlineVars;
end;

{$ENDREGION}
{$REGION 'SetOnlineVars'}

procedure TIcqOptionsForm.SetOnlineVars;
begin
  // Загружаем онлайн переменные
  ConnectTimeInfoEdit.Text := MyConnTime;
  RegDateInfoEdit.Text := ICQ_MyUIN_RegTime;
  ExternalIPInfoEdit.Text := ICQ_Online_IP;
  SendMessInfoEdit.Text := ICQ_SendMess;
  InMessInfoEdit.Text := ICQ_RecMess;
  LastTimeInfoEdit.Text := ICQ_LastActive;
  // Заполняем мемо дополнительной информацией о ICQ аккаунте
  ParamInfoRichEdit.Clear;
  // Начинаем заполнение строк
  ParamInfoRichEdit.Lines.BeginUpdate;
  // Добавляем информацию не вошедшую в другие разделы
  if ICQ_CollSince <> EmptyStr then
    ParamInfoRichEdit.Lines.Add(Lang_Vars[48].L_S + C_TN + ICQ_CollSince);
  if ICQ_OnlineDays <> EmptyStr then
    ParamInfoRichEdit.Lines.Add(Lang_Vars[49].L_S + C_TN + ICQ_OnlineDays);
  if ICQ_AwayMess <> EmptyStr then
    ParamInfoRichEdit.Lines.Add(Lang_Vars[50].L_S + C_TN + ICQ_AwayMess);
  if ICQ_Bos_Addr <> EmptyStr then
    ParamInfoRichEdit.Lines.Add(Lang_Vars[51].L_S + C_TN + ICQ_Bos_Addr);
  if ICQ_MyIcon_Hash <> EmptyStr then
    ParamInfoRichEdit.Lines.Add(Lang_Vars[52].L_S + C_TN + ICQ_MyIcon_Hash);
  // Заканчиваем заполнение строк
  ParamInfoRichEdit.Lines.EndUpdate;
  // Прокручиваем
  ParamInfoRichEdit.SelStart := 0;
  SendMessage(ParamInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
end;

{$ENDREGION}
{$REGION 'SendCustomICQPacketButtonClick'}

procedure TIcqOptionsForm.SendCustomICQPacketButtonClick(Sender: TObject);
var
  Pkt: string;
begin
  // Сохраняем пакет локально для дальнейшего использования
  SendCustomICQPacketRichEdit.Lines.SaveToFile(V_ProfilePath + C_Icq + C_BN + C_PacketFileName);
  // Если пакет больше нуля и рабочая фаза icq подключения
  if NotProtoOnline(C_Icq) then
    Exit;
  // Копируем текст пакета из рича (используем ричедит против глюка с отрисовкой мемо в виндовс 7)
  Pkt := Trim(SendCustomICQPacketRichEdit.Lines.Text);
  if Pkt <> EmptyStr then
  begin
    // Удаляем все переносы строк из пакета
    Pkt := DeleteLineBreaks(Pkt);
    // Удаляем все пробелы из пакета
    Pkt := DeleteSpaces(Pkt);
    // Если пакет с заголовком, то удаляем из пакета заголовок
    if (Length(Pkt) > 2) and (UpperCase(Pkt[1] + Pkt[2]) = '2A') then
    begin
      NextData(Pkt, 12);
      // Отправляем пакет по второму каналу
      ICQ_SendPkt('2', Pkt);
    end
    else
      ICQ_SendPkt('2', Pkt);
  end;
end;
{$ENDREGION}

end.

