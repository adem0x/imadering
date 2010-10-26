{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqContactInfoUnit;

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
  StdCtrls,
  Buttons,
  ExtCtrls,
  Htmlview,
  ShellApi,
  StrUtils,
  VarsUnit,
  Menus,
  JvSimpleXml;

type
  TIcqContactInfoForm = class(TForm)
    ReqInfoBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    BottomHTMLViewer: THTMLViewer;
    InfoLabel: TLabel;
    AvatarImage: TImage;
    TopHTMLViewer: THTMLViewer;
    HoroImage: TImage;
    Bevel1: TBevel;
    TopPopupMenu: TPopupMenu;
    BottomPopupMenu: TPopupMenu;
    TopCopyHTML: TMenuItem;
    BottomCopyHTML: TMenuItem;
    TopAllCopyHTML: TMenuItem;
    BottomAllCopyHTML: TMenuItem;
    Bevel2: TBevel;
    procedure OKBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReqInfoBitBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TopHTMLViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BottomHTMLViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BottomHTMLViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TopHTMLViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TopCopyHTMLClick(Sender: TObject);
    procedure BottomCopyHTMLClick(Sender: TObject);
    procedure TopPopupMenuPopup(Sender: TObject);
    procedure BottomPopupMenuPopup(Sender: TObject);
    procedure TopAllCopyHTMLClick(Sender: TObject);
    procedure BottomAllCopyHTMLClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure BottomHTMLViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);

  private
    { Private declarations }
    HTMLStyle: string;
    procedure AddHTML(const ToWhere: THTMLViewer; Text: string; TextClass: string = 'cdef'; InsertBR: Boolean = False; StupidInsert: Boolean = False; ClearIt: Boolean = False);
    procedure CreateSummery(Info_Node: TJvSimpleXmlElem);

  public
    { Public declarations }
    ReqUIN: string;
    ReqProto: string;
    procedure TranslateForm;
    procedure LoadUserUnfo;
  end;

{$ENDREGION}

var
  IcqContactInfoForm: TIcqContactInfoForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  IcqOptionsUnit,
  OverbyteIcsUrl,
  JabberProtoUnit,
  MraProtoUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_ContForm = 'contact_info_form';

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqContactInfoForm.TopAllCopyHTMLClick(Sender: TObject);
begin
  // Выделяем всё и копируем в буфер обмена
  TopHTMLViewer.SelectAll;
  TopHTMLViewer.CopyToClipboard;
end;

procedure TIcqContactInfoForm.TopCopyHTMLClick(Sender: TObject);
begin
  // Копируем выделенный текст в буфер обмена
  TopHTMLViewer.CopyToClipboard;
end;

procedure TIcqContactInfoForm.TopHTMLViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При нажатии комбинации клавиш Ctrl + C в истории чата
  // копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
    TopHTMLViewer.CopyToClipboard;
end;

procedure TIcqContactInfoForm.TopHTMLViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Сбрасываем выделение текста в чате по клику левой клавишей мыши
  if Button = MbLeft then
    TopHTMLViewer.SelLength := 0;
end;

procedure TIcqContactInfoForm.TopPopupMenuPopup(Sender: TObject);
begin
  // Проверяем есть ли выделенный текст в истории чата
  if TopHTMLViewer.SelLength = 0 then
    TopCopyHTML.Enabled := False
  else
    TopCopyHTML.Enabled := True;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TIcqContactInfoForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  BottomCopyHTML.Caption := TopCopyHTML.Caption;
  BottomAllCopyHTML.Caption := TopAllCopyHTML.Caption;
end;

{$ENDREGION}
{$REGION 'AddHTML'}

procedure TIcqContactInfoForm.AddHTML(const ToWhere: THTMLViewer; Text: string; TextClass: string = 'cdef'; InsertBR: Boolean = False; StupidInsert: Boolean = False; ClearIt: Boolean = False);
var
  Doc: string;
begin
  Doc := UTF8ToString(ToWhere.DocumentSource);
  if StupidInsert then
    Doc := Doc + Text
  else
    Doc := Doc + '<span class="' + TextClass + '">' + Text + '</span>';
  if InsertBR then
    Doc := Doc + '<br>';
  if ClearIt then
    Doc := Text;
  LoadHTMLStrings(ToWhere, Doc);
end;

{$ENDREGION}
{$REGION 'LoadUserUnfo'}

procedure TIcqContactInfoForm.LoadUserUnfo;
var
  AvatarFile: string;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;

  procedure GetInfo;
  begin
    InfoLabel.Caption := EmptyStr;
    if ReqProto = C_Icq then
    begin
      if ICQ_Work_Phaze then
      begin
        InfoLabel.Caption := Lang_Vars[56].L_S;
        ICQ_ReqInfo_New_Pkt(ReqUIN);
      end;
    end
    else if ReqProto = C_Jabber then
    begin
      if Jabber_Work_Phaze then
      begin
        InfoLabel.Caption := Lang_Vars[56].L_S;

      end;
    end
    else if ReqProto = C_Mra then
    begin
      if MRA_Work_Phaze then
      begin
        InfoLabel.Caption := Lang_Vars[56].L_S;

      end;
    end;
  end;

begin
  // Устанавливаем заголовок окна
  Caption := Lang_Vars[57].L_S;
  // Стираем отображение предыдущей инфы
  TopHTMLViewer.Clear;
  BottomHTMLViewer.Clear;
  // Добавляем стили для верхнего уровня
  AddHTML(TopHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
  // Отображаем учётную запись контакта
  AddHTML(TopHTMLViewer, Lang_Vars[20].L_S + C_BN + ReqProto + C_TN + C_BN, C_cbold);
  AddHTML(TopHTMLViewer, ReqUIN, C_cdef, True);
  // Очищаем картинку гороскопа
  HoroImage.Picture.Assign(nil);
  // Загружаем аватар
  AvatarFile := V_MyPath + C_IconsFolder + V_CurrentIcons + C_NoAvatarFileName;
  if FileExists(AvatarFile) then
    AvatarImage.Picture.LoadFromFile(AvatarFile);
  // Ищем локально файл с информацией
  if FileExists(V_ProfilePath + C_AnketaFolder + ReqProto + C_BN + ReqUIN + C_XML_Ext) then
  begin
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        // Загружаем настройки
        LoadFromFile(V_ProfilePath + C_AnketaFolder + ReqProto + C_BN + ReqUIN + C_XML_Ext);
        if Root <> nil then
        begin
          // Открываем раздел с информацией
          XML_Node := Root.Items.ItemNamed[C_Infos];
          if XML_Node <> nil then
          begin
            // Отображаем, что информация найдена
            InfoLabel.Caption := Lang_Vars[55].L_S;
            // Запускаем создание суммарного инфо из распакованного файла
            CreateSummery(XML_Node);
          end
          else
            GetInfo;
        end;
      end;
    finally
      JvXML.Free;
    end;
  end
  else // Если файл с инфой не нашли, то запрашиваем её и ожидаем получения
    GetInfo;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqContactInfoForm.BottomAllCopyHTMLClick(Sender: TObject);
begin
  // Выделяем всё и копируем в буфер обмена
  BottomHTMLViewer.SelectAll;
  BottomHTMLViewer.CopyToClipboard;
end;

procedure TIcqContactInfoForm.BottomCopyHTMLClick(Sender: TObject);
begin
  // Копируем выделенный текст в буфер обмена
  BottomHTMLViewer.CopyToClipboard;
end;

procedure TIcqContactInfoForm.BottomHTMLViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
begin
  // Отключаем реакции
  Handled := True;
  // Открываем ссылку из чата во внешнем браузере
  OpenURL(SRC);
end;

procedure TIcqContactInfoForm.BottomHTMLViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При нажатии комбинации клавиш Ctrl + C в истории чата
  // копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
    BottomHTMLViewer.CopyToClipboard;
end;

procedure TIcqContactInfoForm.BottomHTMLViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Сбрасываем выделение текста в чате по клику левой клавишей мыши
  if Button = MbLeft then
    BottomHTMLViewer.SelLength := 0;
end;

procedure TIcqContactInfoForm.BottomPopupMenuPopup(Sender: TObject);
begin
  // Проверяем есть ли выделенный текст в истории чата
  if BottomHTMLViewer.SelLength = 0 then
    BottomCopyHTML.Enabled := False
  else
    BottomCopyHTML.Enabled := True;
end;

{$ENDREGION}
{$REGION 'CreateSummery'}

procedure TIcqContactInfoForm.CreateSummery(Info_Node: TJvSimpleXmlElem);
const
  C_cmargin = 'cmargin';
var
  Nick, First, Last, Age, IDay, IMonth, IYear: string;
  Email0, Email1, Email2, Email3, OCity, OState, Gender: string;
  Address, City, State, Zip, Country, OCountry: string;
  // WebAware, Auth: boolean;
  WCity, WState, WZip, WAddress, Company, Department, Position, WSite, WCountry, Occupation: string;
  Phone, Fax, Cellular, WPhone, WFax, HomePage, LastUpdateInfo: string;
  Int1, Int2, Int3, Int4, I1, I2, I3, I4, About: string;
  Lang1, Lang2, Lang3, Marital, Sexual, XHeight, Relig, Smok, Hair, Children: string;
  XML_Node: TJvSimpleXmlElem;
begin
  // Добавляем стили для нижнего уровня
  AddHTML(BottomHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
  // Загружаем информацию из распакованного xml файла с инфой
  if Info_Node <> nil then
  begin
    // Ник, Имя и фамилию
    XML_Node := Info_Node.Items.ItemNamed[C_NameInfo];
    if XML_Node <> nil then
    begin
      Nick := URLDecode(XML_Node.Properties.Value(C_Nick));
      First := URLDecode(XML_Node.Properties.Value(C_First));
      Last := URLDecode(XML_Node.Properties.Value(C_Last));
      if IsNotNull([Nick, First, Last]) then
      begin
        // Вставляем разделитель
        AddHTML(TopHTMLViewer, C_HR, EmptyStr, False, True);
        // Вставляем ник и имена
        if Nick <> EmptyStr then
        begin
          AddHTML(TopHTMLViewer, Lang_Vars[128].L_S + C_TN + C_BN, C_cbold);
          AddHTML(TopHTMLViewer, Nick, C_cdef, True);
        end;
        AddHTML(TopHTMLViewer, Lang_Vars[129].L_S + C_TN + C_BN, C_cbold);
        if Trim(First) <> EmptyStr then
          AddHTML(TopHTMLViewer, First + C_BN);
        AddHTML(TopHTMLViewer, Last, C_cdef, True);
      end;
    end;
    // Email адреса
    XML_Node := Info_Node.Items.ItemNamed[C_EmailsInfo];
    if XML_Node <> nil then
    begin
      Email0 := URLDecode(XML_Node.Properties.Value(C_Email + '0'));
      Email1 := URLDecode(XML_Node.Properties.Value(C_Email + '1'));
      Email2 := URLDecode(XML_Node.Properties.Value(C_Email + '2'));
      Email3 := URLDecode(XML_Node.Properties.Value(C_Email + '3'));
      if IsNotNull([Email0, Email1, Email2, Email3]) then
      begin
        if Trim(Email0) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, C_Email + C_TN + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Format(C_HTML_Email, [Email0, Email0]), C_cmargin, True);
        end;
        if Trim(Email1) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, C_Email + C_TN + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Format(C_HTML_Email, [Email1, Email1]), C_cmargin, True);
        end;
        if Trim(Email2) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, C_Email + C_TN + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Format(C_HTML_Email, [Email2, Email2]), C_cmargin, True);
        end;
        if Trim(Email3) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, C_Email + C_TN + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Format(C_HTML_Email, [Email3, Email3]), C_cmargin, True);
        end;
        // Вставляем разделитель
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
      end;
    end;
    // Место жительства
    XML_Node := Info_Node.Items.ItemNamed[C_HomeInfo];
    if XML_Node <> nil then
    begin
      Address := URLDecode(XML_Node.Properties.Value(C_Address));
      City := URLDecode(XML_Node.Properties.Value(C_City));
      State := URLDecode(XML_Node.Properties.Value(C_State));
      Zip := URLDecode(XML_Node.Properties.Value(C_Zip));
      Country := XML_Node.Properties.Value(C_Country);
      // Получаем текст страны из кода
      if ReqProto = C_Icq then
      begin
        if Assigned(IcqOptionsForm) then
          Country := IcqOptionsForm.CountryInfoComboBox.Items.Values[C_QN + Country + C_EN];
      end
      else if ReqProto = C_Jabber then
      begin

      end
      else if ReqProto = C_Mra then
      begin

      end;
      if IsNotNull([Country, City]) then
      begin
        AddHTML(BottomHTMLViewer, Lang_Vars[132].L_S + C_TN + C_BN, C_cbold);
        if Country <> EmptyStr then
          AddHTML(BottomHTMLViewer, Format(C_HTML_Flags + C_BN, [GetFlagFile(V_MyPath + C_FlagsFolder, XML_Node.Properties.Value(C_Country), EmptyStr)]) + StrArrayToStr([Country, City]), C_cdef, True)
        else
          AddHTML(BottomHTMLViewer, StrArrayToStr([Country, City]), C_cdef, True);
      end;
      if IsNotNull([Address, State, Zip]) then
      begin
        if Trim(Address) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoAdressL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Address, C_cdef, True);
        end;
        if Trim(State) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoStateL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, State, C_cdef, True);
        end;
        if Trim(Zip) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoZipL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Zip, C_cdef, True);
        end;
      end;
      // Вставляем разделитель
      if (IsNotNull([Country, City])) or (IsNotNull([Address, State, Zip])) then
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
    end;
    // Пол, последнее обновление, домашняя страничка, авторизация и вебаваре
    XML_Node := Info_Node.Items.ItemNamed[C_PerInfo];
    if XML_Node <> nil then
    begin
      // WebAware := XML_Node.Properties.Value(C_WebAware);
      // Auth := XML_Node.Properties.Value(C_Auth);
      HomePage := URLDecode(XML_Node.Properties.Value(C_HomePage));
      LastUpdateInfo := XML_Node.Properties.Value(C_LastChange);
      Gender := XML_Node.Properties.Value(C_Gender);
      if Gender = '1' then
      begin
        AddHTML(BottomHTMLViewer, Lang_Vars[130].L_S + C_TN + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, Lang_Vars[51].L_S + C_BN + Format(C_HTML_Female, [V_CurrentIcons]), C_cdef, True);
      end
      else if Gender = '2' then
      begin
        AddHTML(BottomHTMLViewer, Lang_Vars[130].L_S + C_TN + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, Lang_Vars[50].L_S + C_BN + Format(C_HTML_Male, [V_CurrentIcons]), C_cdef, True);
      end;
    end;
    // Дата рождения
    XML_Node := Info_Node.Items.ItemNamed[C_AgeInfo];
    if XML_Node <> nil then
    begin
      Age := XML_Node.Properties.Value(C_Age);
      IDay := XML_Node.Properties.Value(C_Day);
      if Length(IDay) = 1 then
        IDay := '0' + IDay;
      IMonth := XML_Node.Properties.Value(C_Month);
      if Length(IMonth) = 1 then
        IMonth := '0' + IMonth;
      IYear := XML_Node.Properties.Value(C_Year);
      if Age <> '0' then
      begin
        AddHTML(BottomHTMLViewer, Lang_Vars[131].L_S + C_TN + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, Age, C_cdef, True);
      end;
      if (IDay <> '0') and (IMonth <> '0') and (IYear <> '0') then
      begin
        AddHTML(BottomHTMLViewer, Lang_Vars[133].L_S + C_TN + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, IDay + '.' + IMonth + '.' + IYear, C_cdef, True);
      end;
      // Вставляем разделитель
      if (Gender <> '0') or ((IDay <> '0') and (IMonth <> '0') and (IYear <> '0')) then
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
    end;
    // Место рождения
    XML_Node := Info_Node.Items.ItemNamed[C_OHomeInfo];
    if XML_Node <> nil then
    begin
      OCountry := XML_Node.Properties.Value(C_Country);
      // Получаем текст страны из кода
      if ReqProto = C_Icq then
      begin
        if Assigned(IcqOptionsForm) then
          OCountry := IcqOptionsForm.CountryInfoComboBox.Items.Values[C_QN + OCountry + C_EN];
      end
      else if ReqProto = C_Jabber then
      begin

      end
      else if ReqProto = C_Mra then
      begin

      end;
      OCity := URLDecode(XML_Node.Properties.Value(C_City));
      OState := URLDecode(XML_Node.Properties.Value(C_State));
      if IsNotNull([OCountry, OCity]) then
      begin
        AddHTML(BottomHTMLViewer, InfoOHomeL + C_BN, C_cbold);
        if OCountry <> EmptyStr then
          AddHTML(BottomHTMLViewer, Format(C_HTML_Flags + C_BN, [GetFlagFile(V_MyPath + C_FlagsFolder, XML_Node.Properties.Value(C_Country), EmptyStr)]) + StrArrayToStr([OCountry, OCity]),
            C_cdef, True)
        else
          AddHTML(BottomHTMLViewer, StrArrayToStr([OCountry, OCity]), C_cdef, True);
      end;
      if Trim(OState) <> EmptyStr then
      begin
        AddHTML(BottomHTMLViewer, InfoStateL + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, OState, C_cdef, True);
      end;
      // Вставляем разделитель
      if (IsNotNull([OCountry, OCity])) or (Trim(OState) <> EmptyStr) then
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
    end;
    // Работа
    XML_Node := Info_Node.Items.ItemNamed[C_WorkInfo];
    if XML_Node <> nil then
    begin
      WCity := URLDecode(XML_Node.Properties.Value(C_City));
      WState := URLDecode(XML_Node.Properties.Value(C_State));
      WZip := URLDecode(XML_Node.Properties.Value(C_Zip));
      WAddress := URLDecode(XML_Node.Properties.Value(C_Address));
      Company := URLDecode(XML_Node.Properties.Value(C_Corp));
      Department := URLDecode(XML_Node.Properties.Value(C_Dep));
      Position := URLDecode(XML_Node.Properties.Value(C_Prof));
      WSite := URLDecode(XML_Node.Properties.Value(C_Site));
      WCountry := XML_Node.Properties.Value(C_Country);
      Occupation := XML_Node.Properties.Value(C_Occup);
      // Получаем текст страны из кода
      if ReqProto = C_Icq then
      begin
        if Assigned(IcqOptionsForm) then
          WCountry := IcqOptionsForm.CountryInfoComboBox.Items.Values[C_QN + WCountry + C_EN];
      end
      else if ReqProto = C_Jabber then
      begin

      end
      else if ReqProto = C_Mra then
      begin

      end;
      // Получаем текст занятия из кода
      if Assigned(IcqOptionsForm) then
        Occupation := IcqOptionsForm.CompanyProfInfoComboBox.Items.Values[C_QN + Occupation + C_EN];
      if IsNotNull([WCountry, WCity]) then
      begin
        AddHTML(BottomHTMLViewer, InfoWorkL + C_BN, C_cbold);
        if WCountry <> EmptyStr then
          AddHTML(BottomHTMLViewer, Format(C_HTML_Flags + C_BN, [GetFlagFile(V_MyPath + C_FlagsFolder, XML_Node.Properties.Value(C_Country), EmptyStr)]) + StrArrayToStr([WCountry, WCity]),
            C_cdef, True)
        else
          AddHTML(BottomHTMLViewer, StrArrayToStr([WCountry, WCity]), C_cdef, True);
      end;
      if IsNotNull([WAddress, WState, WZip]) then
      begin
        if Trim(WAddress) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoAdressL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, WAddress, C_cdef, True);
        end;
        if Trim(WState) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoStateL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, WState, C_cdef, True);
        end;
        if Trim(WZip) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoZipL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, WZip, C_cdef, True);
        end;
      end;
      if IsNotNull([Company, Department, Position, Occupation, WSite]) then
      begin
        if Trim(Company) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoCompanyL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Company, C_cdef, True);
        end;
        if Trim(Department) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoDeportL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Department, C_cdef, True);
        end;
        if Trim(Position) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoPositionL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Position, C_cdef, True);
        end;
        if Trim(Occupation) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoOccupationL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Occupation, C_cdef, True);
        end;
        if Trim(WSite) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoWebSiteL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, WSite, C_cdef, True);
        end;
      end;
      // Вставляем разделитель
      if (IsNotNull([WCountry, WCity])) or (IsNotNull([WAddress, WState, WZip])) or (IsNotNull([Company, Department, Position, Occupation, WSite])) then
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
    end;
    // Телефоны
    XML_Node := Info_Node.Items.ItemNamed[C_PhoneInfo];
    if XML_Node <> nil then
    begin
      Phone := URLDecode(XML_Node.Properties.Value(C_Phone + '1'));
      Fax := URLDecode(XML_Node.Properties.Value(C_Phone + '2'));
      Cellular := URLDecode(XML_Node.Properties.Value(C_Phone + '3'));
      WPhone := URLDecode(XML_Node.Properties.Value(C_Phone + '4'));
      WFax := URLDecode(XML_Node.Properties.Value(C_Phone + '5'));
      if IsNotNull([Phone, Fax, Cellular, WPhone, WFax]) then
      begin
        if Trim(Phone) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoPhoneL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Phone, C_cdef, True);
        end;
        if Trim(Fax) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoFaxL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Fax, C_cdef, True);
        end;
        if Trim(Cellular) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoCellularL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Cellular, C_cdef, True);
        end;
        if Trim(WPhone) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfowPhoneL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, WPhone, C_cdef, True);
        end;
        if Trim(WFax) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfowFaxL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, WFax, C_cdef, True);
        end;
        // Вставляем разделитель
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
      end;
    end;
    // Интересы
    XML_Node := Info_Node.Items.ItemNamed[C_IntInfo];
    if XML_Node <> nil then
    begin
      Int1 := URLDecode(XML_Node.Properties.Value(C_CS + '1'));
      Int2 := URLDecode(XML_Node.Properties.Value(C_CS + '2'));
      Int3 := URLDecode(XML_Node.Properties.Value(C_CS + '3'));
      Int4 := URLDecode(XML_Node.Properties.Value(C_CS + '4'));
    end;
    XML_Node := Info_Node.Items.ItemNamed[C_IntIdInfo];
    if XML_Node <> nil then
    begin
      I1 := XML_Node.Properties.Value(C_Id + '1');
      I2 := XML_Node.Properties.Value(C_Id + '2');
      I3 := XML_Node.Properties.Value(C_Id + '3');
      I4 := XML_Node.Properties.Value(C_Id + '4');
      // Получаем название интереса из кода интереса
      if Assigned(IcqOptionsForm) then
      begin
        with IcqOptionsForm do
        begin
          I1 := Interest1InfoComboBox.Items.Values[C_QN + I1 + C_EN];
          I2 := Interest1InfoComboBox.Items.Values[C_QN + I2 + C_EN];
          I3 := Interest1InfoComboBox.Items.Values[C_QN + I3 + C_EN];
          I4 := Interest1InfoComboBox.Items.Values[C_QN + I4 + C_EN];
        end;
      end;
      // Формируем отображение интересов
      if IsNotNull([I1, I2, I3, I4, Int1, Int2, Int3, Int4]) then
      begin
        AddHTML(BottomHTMLViewer, InfoInterestsL + C_BN, C_cbold, True);
        if (Trim(I1) <> EmptyStr) or (Trim(Int1) <> EmptyStr) then
        begin
          AddHTML(BottomHTMLViewer, C_nbsp + C_nbsp);
          AddHTML(BottomHTMLViewer, I1 + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Int1, C_cdef, True);
        end;
        if (Trim(I2) <> EmptyStr) or (Trim(Int2) <> EmptyStr) then
        begin
          AddHTML(BottomHTMLViewer, C_nbsp + C_nbsp);
          AddHTML(BottomHTMLViewer, I2 + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Int2, C_cdef, True);
        end;
        if (Trim(I3) <> EmptyStr) or (Trim(Int3) <> EmptyStr) then
        begin
          AddHTML(BottomHTMLViewer, C_nbsp + C_nbsp);
          AddHTML(BottomHTMLViewer, I3 + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Int3, C_cdef, True);
        end;
        if (Trim(I4) <> EmptyStr) or (Trim(Int4) <> EmptyStr) then
        begin
          AddHTML(BottomHTMLViewer, C_nbsp + C_nbsp);
          AddHTML(BottomHTMLViewer, I4 + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Int4, C_cdef, True);
        end;
        // Вставляем разделитель
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
      end;
    end;
    // Личное
    XML_Node := Info_Node.Items.ItemNamed[C_PersInfo];
    if XML_Node <> nil then
    begin
      Marital := XML_Node.Properties.Value(C_Marital);
      Sexual := XML_Node.Properties.Value(C_Sexual);
      XHeight := XML_Node.Properties.Value(C_Height);
      Relig := XML_Node.Properties.Value(C_Relig);
      Smok := XML_Node.Properties.Value(C_Smok);
      Hair := XML_Node.Properties.Value(C_Hair);
      Children := XML_Node.Properties.Value(C_Children);
      // Получаем название из кода
      if Assigned(IcqOptionsForm) then
      begin
        with IcqOptionsForm do
        begin
          Marital := PersonalMaritalInfoComboBox.Items.Values[C_QN + Marital + C_EN];
          Sexual := PersonalSexInfoComboBox.Items.Values[C_QN + Sexual + C_EN];
          Relig := PersonalReligionInfoComboBox.Items.Values[C_QN + Relig + C_EN];
          Smok := PersonalSmokInfoComboBox.Items.Values[C_QN + Smok + C_EN];
          Hair := PersonalHairColourInfoComboBox.Items.Values[C_QN + Hair + C_EN];
          XHeight := PersonalHeightInfoComboBox.Items.Values[C_QN + XHeight + C_EN];
          Children := PersonalChildrenInfoComboBox.Items.Values[C_QN + Children + C_EN];
        end;
      end;
      // Формируем отображение
      if IsNotNull([Marital, Sexual, XHeight, Relig, Smok, Hair, Children]) then
      begin
        if Trim(Marital) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoMaritalL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Marital, C_cdef, True);
        end;
        if Trim(Sexual) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoSexualL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Sexual, C_cdef, True);
        end;
        if Trim(XHeight) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoHeightL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, XHeight, C_cdef, True);
        end;
        if Trim(Relig) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoReligL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Relig, C_cdef, True);
        end;
        if Trim(Smok) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoSmokL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Smok, C_cdef, True);
        end;
        if Trim(Hair) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoHairL + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Hair, C_cdef, True);
        end;
        if Trim(Children) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoChildrenL1 + C_BN, C_cbold);
          AddHTML(BottomHTMLViewer, Children, C_cdef, True);
        end;
        // Вставляем разделитель
        if IsNotNull([Marital, Sexual, Relig, Smok, Hair, XHeight, Children]) then
          AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
      end;
    end;
    // Языки
    XML_Node := Info_Node.Items.ItemNamed[C_LangInfo];
    if XML_Node <> nil then
    begin
      Lang1 := XML_Node.Properties.Value(C_Lang + '1');
      Lang2 := XML_Node.Properties.Value(C_Lang + '2');
      Lang3 := XML_Node.Properties.Value(C_Lang + '3');
      // Получаем название языка из кода языка
      if Assigned(IcqOptionsForm) then
      begin
        with IcqOptionsForm do
        begin
          Lang1 := Lang1InfoComboBox.Items.Values[C_QN + Lang1 + C_EN];
          Lang2 := Lang1InfoComboBox.Items.Values[C_QN + Lang2 + C_EN];
          Lang3 := Lang1InfoComboBox.Items.Values[C_QN + Lang3 + C_EN];
        end;
      end;
      // Формируем отображение языков
      if IsNotNull([Lang1, Lang2, Lang3]) then
      begin
        AddHTML(BottomHTMLViewer, InfoLangL + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, StrArrayToStr([Lang1, Lang2, Lang3]), C_cdef, True);
        // Вставляем разделитель
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
      end;
    end;
    // О себе
    XML_Node := Info_Node.Items.ItemNamed[C_AboutInfo];
    if XML_Node <> nil then
    begin
      About := URLDecode(XML_Node.Value);
      if Trim(About) <> EmptyStr then
      begin
        AddHTML(BottomHTMLViewer, InfoAboutL + C_BN, C_cbold);
        AddHTML(BottomHTMLViewer, About, C_cdef, True);
        // Вставляем разделитель
        AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
      end;
    end;
    // Домашняя страница
    if Trim(HomePage) <> EmptyStr then
    begin
      AddHTML(BottomHTMLViewer, InfoHomePageL + C_BN, C_cbold);
      AddHTML(BottomHTMLViewer, HomePage, C_cdef, True);
      // Вставляем разделитель
      AddHTML(BottomHTMLViewer, C_HR, EmptyStr, False, True);
    end;
    // Дата последнего обновления, дополнительно
    if Trim(LastUpdateInfo) <> EmptyStr then
    begin
      AddHTML(BottomHTMLViewer, InfoLastUpDateL + C_BN, C_cbold);
      AddHTML(BottomHTMLViewer, LastUpdateInfo, C_cdef, True);
    end;
    // Вычисляем знак гороскопа
    if (IDay <> '00') and (IMonth <> '00') then
    begin
      // Загружаем картинку гороскопа
      HoroImage.Picture.LoadFromFile(V_MyPath + C_IconsFolder + V_CurrentIcons + C_SN + 'horoscope1' + C_BMP_Ext);
      // Прокручиваем на картинку этого знака
      HoroImage.Canvas.CopyRect(Rect(0, 0, 32, 32), HoroImage.Canvas, Bounds(Horospope(StrToInt(IDay), StrToInt(IMonth)), 0, 32, 32));
    end
    else
      HoroImage.Picture.Assign(nil);
  end;
  // Загружаем аватар
  { if (Length(UserAvatarHash) = 32) and ((FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')) or
    (FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.gif')) or
    (FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.bmp'))) then
    begin
    if FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.jpg') then
    ContactImage.Picture.LoadFromFile(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')
    else if FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.gif') then
    ContactImage.Picture.LoadFromFile(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.gif')
    else if FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.bmp') then
    ContactImage.Picture.LoadFromFile(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.bmp');
    end
    else
    begin
    if (Length(UserAvatarHash) = 32) and (ICQ_Avatar_Work_Phaze) then
    begin
    ICQ_GetAvatarImage(UIN, UserAvatarHash);
    end;
    if (Length(UserAvatarHash) = 32) and (not AvatarServiceDisable) and (not ICQ_Avatar_Connect_Phaze) and
    (not ICQ_Avatar_Work_Phaze) and (ICQ_Work_Phaze) then
    begin
    ICQ_Avatar_Connect_Phaze := true;
    ICQ_Avatar_Work_Phaze := false;
    ICQ_GetAvatar_UIN := UIN;
    ICQ_GetAvatar_Hash := UserAvatarHash;
    ICQ_GetAvatarBosServer;
    end;
    //SearchAvatarTimer.Enabled := true;
    ContactImage.Picture.Assign(nil);
    ContactImage.Picture.Assign(NoAvatar.Picture);
    end; }
  // Удаляем распакованный файл с информацией
  // if FileExists(ProfilePath + 'Profile\Contacts\Icq_Info.xml') then DeleteFile(ProfilePath + 'Profile\Contacts\Icq_Info.xml');
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqContactInfoForm.ReqInfoBitBtnClick(Sender: TObject);
begin
  // Запрашиваем информацию о контакте
  if ReqProto = C_Icq then
  begin
    if (ReqUIN > EmptyStr) and (ICQ_Work_Phaze) then
    begin
      InfoLabel.Caption := Lang_Vars[56].L_S;
      ICQ_ReqInfo_New_Pkt(ReqUIN);
    end;
  end
  else if ReqProto = C_Jabber then
  begin

  end
  else if ReqProto = C_Mra then
  begin

  end;
end;

procedure TIcqContactInfoForm.OKBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TIcqContactInfoForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TIcqContactInfoForm.FormCreate(Sender: TObject);
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
      if FileExists(V_ProfilePath + C_SettingsFileName) then
      begin
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
        begin
          // Загружаем позицию окна
          XML_Node := Root.Items.ItemNamed[C_ContForm];
          if XML_Node <> nil then
          begin
            Top := XML_Node.Properties.IntValue('t');
            Left := XML_Node.Properties.IntValue('l');
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Переводим форму на другие языки
  TranslateForm;
  HTMLStyle := '<html><head>' + V_DetailsCSS + '<title>Details</title></head><body>';
  // Ставим иконки окна и кнопок
  MainForm.AllImageList.GetIcon(178, Icon);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ReqInfoBitBtn.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure TIcqContactInfoForm.FormDestroy(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Сохраняем настройки положения окна в xml
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      if Root <> nil then
      begin
        // Очищаем раздел формы если он есть
        XML_Node := Root.Items.ItemNamed[C_ContForm];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_ContForm);
        XML_Node.Properties.Add('t', Top);
        XML_Node.Properties.Add('l', Left);
        // Записываем сам файл
        SaveToFile(V_ProfilePath + C_SettingsFileName);
      end;
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}

end.

