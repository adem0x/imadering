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

  private
    { Private declarations }
    HTMLStyle: string;
    procedure AddHTML(const ToWhere: THTMLViewer; Text: string; TextClass: string = 'cdef'; InsertBR: Boolean = False; StupidInsert: Boolean = False; ClearIt: Boolean = False);
    procedure CreateSummery;

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
  OverbyteIcsUrl;

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
begin
  // Устанавливаем заголовок окна
  Caption := Lang_Vars[57].L_S + C_TN + ReqUIN;
  // Стираем отображение предыдущей инфы
  TopHTMLViewer.Clear;
  BottomHTMLViewer.Clear;
  // Ищем локально файл с информацией
  if FileExists(V_ProfilePath + C_AnketaFolder + ReqProto + C_BN + ReqUIN + C_XML_Ext) then
  begin
    InfoLabel.Caption := Lang_Vars[55].L_S;
    // Запускаем создание суммарного инфо из распакованного файла
    CreateSummery;
  end
  else // Если файл с инфой не нашли, то запрашиваем её и ожидаем получения
  begin
    InfoLabel.Caption := EmptyStr;
    if ICQ_Work_Phaze then
    begin
      InfoLabel.Caption := Lang_Vars[56].L_S;
      ICQ_ReqInfo_New_Pkt(ReqUIN);
    end;
    // Добавляем стили
    AddHTML(TopHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
    // Учётная запись контакта
    if ReqProto = C_Icq then
      AddHTML(TopHTMLViewer, Lang_Vars[20].L_S + C_BN + UpperCase(C_Icq) + C_TN + C_BN + ReqUIN, C_cbold)
    else if ReqProto = C_Jabber then
      AddHTML(TopHTMLViewer, Lang_Vars[20].L_S + C_BN + C_Jabber + C_TN + C_BN + ReqUIN, C_cbold)
    else if ReqProto = C_Mra then
      AddHTML(TopHTMLViewer, Lang_Vars[20].L_S + C_BN + C_Email + C_TN + C_BN + ReqUIN, C_cbold);
    AddHTML(TopHTMLViewer, C_BR, EmptyStr, False, True);
    // Очищаем картинку гороскопа
    HoroImage.Picture.Assign(nil);
    // Загружаем аватар
    AvatarFile := V_MyPath + C_IconsFolder + V_CurrentIcons + C_NoAvatarFileName;
    if FileExists(AvatarFile) then
      AvatarImage.Picture.LoadFromFile(AvatarFile);
  end;
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

procedure TIcqContactInfoForm.CreateSummery;
var
  Nick, First, Last, Age, IDay, IMonth, IYear: string;
  Email0, Email1, Email2, Email3, OCity, OState, Gender: string;
  Address, City, State, Zip, Country, OCountry: string;
  // WebAware, Auth: boolean;
  WCity, WState, WZip, WAddress, Company, Department, Position, WSite, WCountry, Occupation: string;
  Phone, Fax, Cellular, WPhone, WFax, HomePage, LastUpdateInfo: string;
  Int1, Int2, Int3, Int4, I1, I2, I3, I4, About: string;
  Lang1, Lang2, Lang3, Marital, Sexual, XHeight, Relig, Smok, Hair, Children: string;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Добавляем стили
  AddHTML(TopHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
  AddHTML(BottomHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
  // Учётная запись контакта
  AddHTML(TopHTMLViewer, Lang_Vars[20].L_S + C_BN + UpperCase(C_Icq) + C_TN + ReqUIN, C_cbold);
  AddHTML(TopHTMLViewer, C_HR, EmptyStr, False, True);
  // Загружаем информацию из распакованного xml файла с инфой
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      LoadFromFile(V_ProfilePath + C_AnketaFolder + ReqProto + C_BN + ReqUIN + C_XML_Ext);
      if Root <> nil then
      begin
        // Ник, Имя и фамилию
        XML_Node := Root.Items.ItemNamed[C_NameInfo];
        if XML_Node <> nil then
        begin
          Nick := URLDecode(XML_Node.Properties.Value(C_Nick));
          if Nick <> EmptyStr then
          begin
            AddHTML(TopHTMLViewer, InfoNickL + C_BN, 'cbold');
            AddHTML(TopHTMLViewer, Nick, 'cdef', True);
          end;
          First := URLDecode(XML_Node.Properties.Value(C_First));
          Last := URLDecode(XML_Node.Properties.Value(C_Last));
          if IsNotNull([First, Last]) then
          begin
            AddHTML(TopHTMLViewer, InfoNameL + C_BN, 'cbold');
            if Trim(First) <> EmptyStr then
              AddHTML(TopHTMLViewer, First + C_BN);
            AddHTML(TopHTMLViewer, Last, 'cdef', True);
          end;
        end;
        // Email адреса
        XML_Node := Root.Items.ItemNamed[C_EmailsInfo];
        if XML_Node <> nil then
        begin
          {Email0 := URLDecode(XML_Node.Properties.Value(C_Email0));
          Email1 := URLDecode(XML_Node.Properties.Value(C_Email1));
          Email2 := URLDecode(XML_Node.Properties.Value(C_Email2));
          Email3 := URLDecode(XML_Node.Properties.Value(C_Email3));}
          if IsNotNull([Email0, Email1, Email2, Email3]) then
          begin
            if Trim(Email0) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, C_Email + C_TN, 'cbold');
              AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email0 + '">' + Email1 + '</a>', 'cmargin', True);
            end;
            if Trim(Email1) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, C_Email + C_TN, 'cbold');
              AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email1 + '">' + Email1 + '</a>', 'cmargin', True);
            end;
            if Trim(Email2) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, C_Email + C_TN, 'cbold');
              AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email2 + '">' + Email2 + '</a>', 'cmargin', True);
            end;
            if Trim(Email3) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, C_Email + C_TN, 'cbold');
              AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email3 + '">' + Email3 + '</a>', 'cmargin', True);
            end;
            // Вставляем разделитель
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        end;
        // Место жительства
        XML_Node := Root.Items.ItemNamed[C_HomeInfo];
        if XML_Node <> nil then
        begin
          Address := URLDecode(XML_Node.Properties.Value(C_Address));
          City := URLDecode(XML_Node.Properties.Value(C_City));
          State := URLDecode(XML_Node.Properties.Value(C_State));
          Zip := URLDecode(XML_Node.Properties.Value(C_Zip));
          Country := XML_Node.Properties.Value(C_Country);
          // Получаем текст страны из кода
          if Assigned(IcqOptionsForm) then
            Country := IcqOptionsForm.CountryInfoComboBox.Items.Values['[' + Country + ']'];
          if IsNotNull([Country, City]) then
          begin
            AddHTML(BottomHTMLViewer, InfoHomeL + C_BN, 'cbold');
            if Country <> EmptyStr then
              AddHTML(BottomHTMLViewer, '<IMG NAME=i SRC="./Flags/' + GetFlagFile(V_MyPath + C_FlagsFolder, XML_Node.Properties.Value(C_Country), EmptyStr) + '" ALIGN=ABSMIDDLE BORDER=0> ' + StrArrayToStr([Country, City]), 'cdef',
                True)
            else
              AddHTML(BottomHTMLViewer, StrArrayToStr([Country, City]), 'cdef', True);
          end;
          if IsNotNull([Address, State, Zip]) then
          begin
            if Trim(Address) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoAdressL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Address, 'cdef', True);
            end;
            if Trim(State) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoStateL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, State, 'cdef', True);
            end;
            if Trim(Zip) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoZipL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Zip, 'cdef', True);
            end;
          end;
          // Вставляем разделитель
          if (IsNotNull([Country, City])) or (IsNotNull([Address, State, Zip])) then
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
        end;
        // Пол, последнее обновление, домашняя страничка, авторизация и вебаваре
        XML_Node := Root.Items.ItemNamed[C_PerInfo];
        if XML_Node <> nil then
        begin
          // WebAware := XML_Node.Properties.Value(C_WebAware);
          // Auth := XML_Node.Properties.Value(C_Auth);
          HomePage := URLDecode(XML_Node.Properties.Value(C_HomePage));
          LastUpdateInfo := XML_Node.Properties.Value(C_LastChange);
          Gender := XML_Node.Properties.Value(C_Gender);
          if Gender = '1' then
          begin
            AddHTML(BottomHTMLViewer, InfoGenderL + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, InfoGender1L + ' <IMG NAME=i SRC="./Icons/' + V_CurrentIcons + '/girl.gif" ALIGN=ABSMIDDLE BORDER=0>', 'cdef', True);
          end
          else if Gender = '2' then
          begin
            AddHTML(BottomHTMLViewer, InfoGenderL + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, InfoGender2L + ' <IMG NAME=i SRC="./Icons/' + V_CurrentIcons + '/boy.gif" ALIGN=ABSMIDDLE BORDER=0>', 'cdef', True);
          end;
        end;
        // Дата рождения
        XML_Node := Root.Items.ItemNamed[C_AgeInfo];
        if XML_Node <> nil then
        begin
          Age := XML_Node.Properties.Value(C_Age);
          IDay := XML_Node.Properties.Value(C_Day);
          IMonth := XML_Node.Properties.Value(C_Month);
          IYear := XML_Node.Properties.Value(C_Year);
          if Age <> '0' then
          begin
            AddHTML(BottomHTMLViewer, InfoAgeL + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, Age, 'cdef', True);
          end;
          if (IDay <> '0') and (IMonth <> '0') and (IYear <> '0') then
          begin
            AddHTML(BottomHTMLViewer, InfoBirDate + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, IDay + '.' + IMonth + '.' + IYear, 'cdef', True);
          end;
          // Вставляем разделитель
          if (Gender <> '0') or ((IDay <> '0') and (IMonth <> '0') and (IYear <> '0')) then
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
        end;
        // Место рождения
        XML_Node := Root.Items.ItemNamed[C_OHomeInfo];
        if XML_Node <> nil then
        begin
          OCountry := XML_Node.Properties.Value(C_Country);
          // Получаем текст страны из кода
          if Assigned(IcqOptionsForm) then
            OCountry := IcqOptionsForm.CountryInfoComboBox.Items.Values['[' + OCountry + ']'];
          OCity := URLDecode(XML_Node.Properties.Value(C_City));
          OState := URLDecode(XML_Node.Properties.Value(C_State));
          if IsNotNull([OCountry, OCity]) then
          begin
            AddHTML(BottomHTMLViewer, InfoOHomeL + C_BN, 'cbold');
            if OCountry <> EmptyStr then
              AddHTML(BottomHTMLViewer, '<IMG NAME=i SRC="./Flags/' + GetFlagFile(V_MyPath + C_FlagsFolder, XML_Node.Properties.Value(C_Country), EmptyStr) + '" ALIGN=ABSMIDDLE BORDER=0> ' + StrArrayToStr([OCountry, OCity]),
                'cdef', True)
            else
              AddHTML(BottomHTMLViewer, StrArrayToStr([OCountry, OCity]), 'cdef', True);
          end;
          if Trim(OState) <> EmptyStr then
          begin
            AddHTML(BottomHTMLViewer, InfoStateL + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, OState, 'cdef', True);
          end;
          // Вставляем разделитель
          if (IsNotNull([OCountry, OCity])) or (Trim(OState) <> EmptyStr) then
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
        end;
        // Работа
        XML_Node := Root.Items.ItemNamed[C_WorkInfo];
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
          if Assigned(IcqOptionsForm) then
            WCountry := IcqOptionsForm.CountryInfoComboBox.Items.Values['[' + WCountry + ']'];
          // Получаем текст занятия из кода
          if Assigned(IcqOptionsForm) then
            Occupation := IcqOptionsForm.CompanyProfInfoComboBox.Items.Values['[' + Occupation + ']'];
          if IsNotNull([WCountry, WCity]) then
          begin
            AddHTML(BottomHTMLViewer, InfoWorkL + C_BN, 'cbold');
            if WCountry <> EmptyStr then
              AddHTML(BottomHTMLViewer, '<IMG NAME=i SRC="./Flags/' + GetFlagFile(V_MyPath + C_FlagsFolder, XML_Node.Properties.Value(C_Country), EmptyStr) + '" ALIGN=ABSMIDDLE BORDER=0> ' + StrArrayToStr([WCountry, WCity]),
                'cdef', True)
            else
              AddHTML(BottomHTMLViewer, StrArrayToStr([WCountry, WCity]), 'cdef', True);
          end;
          if IsNotNull([WAddress, WState, WZip]) then
          begin
            if Trim(WAddress) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoAdressL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, WAddress, 'cdef', True);
            end;
            if Trim(WState) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoStateL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, WState, 'cdef', True);
            end;
            if Trim(WZip) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoZipL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, WZip, 'cdef', True);
            end;
          end;
          if IsNotNull([Company, Department, Position, Occupation, WSite]) then
          begin
            if Trim(Company) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoCompanyL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Company, 'cdef', True);
            end;
            if Trim(Department) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoDeportL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Department, 'cdef', True);
            end;
            if Trim(Position) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoPositionL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Position, 'cdef', True);
            end;
            if Trim(Occupation) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoOccupationL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Occupation, 'cdef', True);
            end;
            if Trim(WSite) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoWebSiteL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, WSite, 'cdef', True);
            end;
          end;
          // Вставляем разделитель
          if (IsNotNull([WCountry, WCity])) or (IsNotNull([WAddress, WState, WZip])) or (IsNotNull([Company, Department, Position, Occupation, WSite])) then
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
        end;
        // Телефоны
        XML_Node := Root.Items.ItemNamed[C_PhoneInfo];
        if XML_Node <> nil then
        begin
          {Phone := URLDecode(XML_Node.Properties.Value(C_Phone1));
          Fax := URLDecode(XML_Node.Properties.Value(C_Phone2));
          Cellular := URLDecode(XML_Node.Properties.Value(C_Phone3));
          WPhone := URLDecode(XML_Node.Properties.Value(C_Phone4));
          WFax := URLDecode(XML_Node.Properties.Value(C_Phone5));}
          if IsNotNull([Phone, Fax, Cellular, WPhone, WFax]) then
          begin
            if Trim(Phone) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoPhoneL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Phone, 'cdef', True);
            end;
            if Trim(Fax) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoFaxL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Fax, 'cdef', True);
            end;
            if Trim(Cellular) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoCellularL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Cellular, 'cdef', True);
            end;
            if Trim(WPhone) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfowPhoneL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, WPhone, 'cdef', True);
            end;
            if Trim(WFax) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfowFaxL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, WFax, 'cdef', True);
            end;
            // Вставляем разделитель
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        end;
        // Интересы
        XML_Node := Root.Items.ItemNamed[C_IntInfo];
        if XML_Node <> nil then
        begin
          {Int1 := URLDecode(XML_Node.Properties.Value(C_Int1));
          Int2 := URLDecode(XML_Node.Properties.Value(C_Int2));
          Int3 := URLDecode(XML_Node.Properties.Value(C_Int3));
          Int4 := URLDecode(XML_Node.Properties.Value(C_Int4));}
        end;
        XML_Node := Root.Items.ItemNamed[C_IntIdInfo];
        if XML_Node <> nil then
        begin
          {I1 := XML_Node.Properties.Value(C_IntId1);
          I2 := XML_Node.Properties.Value(C_IntId2);
          I3 := XML_Node.Properties.Value(C_IntId3);
          I4 := XML_Node.Properties.Value(C_IntId4);}
          // Получаем название интереса из кода интереса
          if Assigned(IcqOptionsForm) then
          begin
            with IcqOptionsForm do
            begin
              I1 := Interest1InfoComboBox.Items.Values['[' + I1 + ']'];
              I2 := Interest1InfoComboBox.Items.Values['[' + I2 + ']'];
              I3 := Interest1InfoComboBox.Items.Values['[' + I3 + ']'];
              I4 := Interest1InfoComboBox.Items.Values['[' + I4 + ']'];
            end;
          end;
          // Формируем отображение интересов
          if IsNotNull([I1, I2, I3, I4, Int1, Int2, Int3, Int4]) then
          begin
            AddHTML(BottomHTMLViewer, InfoInterestsL + C_BN, 'cbold', True);
            if (Trim(I1) <> EmptyStr) or (Trim(Int1) <> EmptyStr) then
            begin
              AddHTML(BottomHTMLViewer, I1 + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Int1, 'cdef', True);
            end;
            if (Trim(I2) <> EmptyStr) or (Trim(Int2) <> EmptyStr) then
            begin
              AddHTML(BottomHTMLViewer, I2 + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Int2, 'cdef', True);
            end;
            if (Trim(I3) <> EmptyStr) or (Trim(Int3) <> EmptyStr) then
            begin
              AddHTML(BottomHTMLViewer, I3 + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Int3, 'cdef', True);
            end;
            if (Trim(I4) <> EmptyStr) or (Trim(Int4) <> EmptyStr) then
            begin
              AddHTML(BottomHTMLViewer, I4 + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Int4, 'cdef', True);
            end;
            // Вставляем разделитель
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        end;
        // Личное
        XML_Node := Root.Items.ItemNamed[C_PersInfo];
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
              Marital := PersonalMaritalInfoComboBox.Items.Values['[' + Marital + ']'];
              Sexual := PersonalSexInfoComboBox.Items.Values['[' + Sexual + ']'];
              Relig := PersonalReligionInfoComboBox.Items.Values['[' + Relig + ']'];
              Smok := PersonalSmokInfoComboBox.Items.Values['[' + Smok + ']'];
              Hair := PersonalHairColourInfoComboBox.Items.Values['[' + Hair + ']'];
            end;
          end;
          // Формируем отображение
          if IsNotNull([Marital, Sexual, XHeight, Relig, Smok, Hair, Children]) then
          begin
            if Trim(Marital) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoMaritalL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Marital, 'cdef', True);
            end;
            if Trim(Sexual) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoSexualL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Sexual, 'cdef', True);
            end;
            if XHeight <> '0' then
            begin
              if Assigned(IcqOptionsForm) then
                with IcqOptionsForm do
                  XHeight := PersonalHeightInfoComboBox.Items.Values['[' + XHeight + ']'];
              AddHTML(BottomHTMLViewer, InfoHeightL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, XHeight, 'cdef', True);
            end;
            if Trim(Relig) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoReligL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Relig, 'cdef', True);
            end;
            if Trim(Smok) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoSmokL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Smok, 'cdef', True);
            end;
            if Trim(Hair) <> EmptyStr then
            begin
              AddHTML(BottomHTMLViewer, InfoHairL + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Hair, 'cdef', True);
            end;
            if Children <> '0' then
            begin
              if Assigned(IcqOptionsForm) then
                with IcqOptionsForm do
                  Children := PersonalChildrenInfoComboBox.Items.Values['[' + Children + ']'];
              AddHTML(BottomHTMLViewer, InfoChildrenL1 + C_BN, 'cbold');
              AddHTML(BottomHTMLViewer, Children, 'cdef', True);
            end;
            // Вставляем разделитель
            if (IsNotNull([Marital, Sexual, Relig, Smok, Hair])) or (XHeight <> '0') or (Children <> '0') then
              AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        end;
        // Языки
        XML_Node := Root.Items.ItemNamed[C_LangInfo];
        if XML_Node <> nil then
        begin
          {Lang1 := XML_Node.Properties.Value(C_Lang1);
          Lang2 := XML_Node.Properties.Value(C_Lang2);
          Lang3 := XML_Node.Properties.Value(C_Lang3);}
          // Получаем название языка из кода языка
          if Assigned(IcqOptionsForm) then
          begin
            with IcqOptionsForm do
            begin
              Lang1 := Lang1InfoComboBox.Items.Values['[' + Lang1 + ']'];
              Lang2 := Lang1InfoComboBox.Items.Values['[' + Lang2 + ']'];
              Lang3 := Lang1InfoComboBox.Items.Values['[' + Lang3 + ']'];
            end;
          end;
          // Формируем отображение языков
          if IsNotNull([Lang1, Lang2, Lang3]) then
          begin
            AddHTML(BottomHTMLViewer, InfoLangL + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, StrArrayToStr([Lang1, Lang2, Lang3]), 'cdef', True);
            // Вставляем разделитель
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        end;
        // О себе
        XML_Node := Root.Items.ItemNamed[C_AboutInfo];
        if XML_Node <> nil then
        begin
          About := URLDecode(XML_Node.Value);
          if Trim(About) <> EmptyStr then
          begin
            AddHTML(BottomHTMLViewer, InfoAboutL + C_BN, 'cbold');
            AddHTML(BottomHTMLViewer, About, 'cdef', True);
            // Вставляем разделитель
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        end;
        // Домашняя страница
        if Trim(HomePage) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoHomePageL + C_BN, 'cbold');
          AddHTML(BottomHTMLViewer, HomePage, 'cdef', True);
          // Вставляем разделитель
          AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
        end;
        // Дата последнего обновления, дополнительно
        if Trim(LastUpdateInfo) <> EmptyStr then
        begin
          AddHTML(BottomHTMLViewer, InfoLastUpDateL + C_BN, 'cbold');
          AddHTML(BottomHTMLViewer, LastUpdateInfo, 'cdef', True);
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Вычисляем знак гороскопа
  if (IDay <> '0') and (IMonth <> '0') then
  begin
    // Загружаем картинку гороскопа
    HoroImage.Picture.LoadFromFile(V_MyPath + C_IconsFolder + V_CurrentIcons + '\horoscope1.bmp');
    // Прокручиваем на картинку этого знака
    HoroImage.Canvas.CopyRect(Rect(0, 0, 32, 32), HoroImage.Canvas, Bounds(Horospope(StrToInt(IDay), StrToInt(IMonth)), 0, 32, 32));
  end
  else
    HoroImage.Picture.Assign(nil);
  // Загружаем аватар
  AvatarImage.Picture.LoadFromFile(V_MyPath + C_IconsFolder + V_CurrentIcons + C_NoAvatarFileName);
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
  if (ReqUIN > EmptyStr) and (ICQ_Work_Phaze) then
  begin
    InfoLabel.Caption := Lang_Vars[56].L_S;
    ICQ_ReqInfo_New_Pkt(ReqUIN);
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

