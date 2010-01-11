{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqContactInfoUnit;

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
  StdCtrls,
  Buttons,
  ExtCtrls,
  Htmlview,
  ShellApi,
  StrUtils,
  VarsUnit,
  RXML,
  Menus;

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

  private
    { Private declarations }
    HTMLStyle: string;
    procedure AddHTML(const ToWhere: THTMLViewer; Text: string; TextClass: string = 'cdef'; InsertBR: Boolean = False;
      StupidInsert: Boolean = False; ClearIt: Boolean = False);
    procedure CreateSummery;

  public
    { Public declarations }
    ReqUIN: string;
    ReqProto: string;
    procedure TranslateForm;
    procedure LoadUserUnfo;
  end;

var
  IcqContactInfoForm: TIcqContactInfoForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  IcqOptionsUnit,
  OverbyteIcsUrl;

resourcestring
  DetailsCSS = '<style type="text/css">' + 'body, span { color: #000000; font: 12px tahoma, verdana; }' +
    'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' + '.cbold { font: bold 12px tahoma, verdana; }' +
    '.cdef { font: 12px tahoma, verdana; }' + '.cmargin { font: 11px tahoma, verdana; margin: 10px; }' + '</style>';
  RS_ContFormPos = 'settings\forms\contactinfoform\position';

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

procedure TIcqContactInfoForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

procedure TIcqContactInfoForm.AddHTML(const ToWhere: THTMLViewer; Text: string; TextClass: string = 'cdef'; InsertBR: Boolean = False;
  StupidInsert: Boolean = False; ClearIt: Boolean = False);
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
  ToWhere.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
end;

procedure TIcqContactInfoForm.LoadUserUnfo;
var
  AvatarFile: string;
begin
  // Устанавливаем заголовок окна
  Caption := InfoCaptionL + ': ' + ReqUIN;
  // Стираем отображение предыдущей инфы
  TopHTMLViewer.Clear;
  BottomHTMLViewer.Clear;
  // Ищем локально файл с информацией
  if FileExists(ProfilePath + AnketaFileName + ReqProto + BN + ReqUIN + '.xml') then
    begin
      InfoLabel.Caption := InfoOKL;
      // Запускаем создание суммарного инфо из распакованного файла
      CreateSummery;
    end
    // Если файл с инфой не нашли, то запрашиваем её и ожидаем получения
  else
    begin
      InfoLabel.Caption := EmptyStr;
      if ICQ_Work_Phaze then
        begin
          InfoLabel.Caption := InfoReqL;
          ICQ_ReqInfo_New_Pkt(ReqUIN);
        end;
      // Добавляем стили
      AddHTML(TopHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
      // Учётная запись контакта
      if ReqProto = S_Icq then
        AddHTML(TopHTMLViewer, ICQAccountInfo + BN + ReqUIN, 'cbold')
      else if ReqProto = S_Jabber then
        AddHTML(TopHTMLViewer, JabberAccountInfo + BN + ReqUIN, 'cbold');
      AddHTML(TopHTMLViewer, '<hr>', EmptyStr, False, True);
      // Очищаем картинку гороскопа
      HoroImage.Picture.Assign(nil);
      // Загружаем аватар
      AvatarFile := MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif';
      if FileExists(AvatarFile) then
        AvatarImage.Picture.LoadFromFile(AvatarFile);
    end;
end;

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

procedure TIcqContactInfoForm.CreateSummery;
var
  XmlFile: TrXML;
  Nick, First, Last, Age, IDay, IMonth, IYear: string;
  Email1, Email2, Email3, OCity, OState, Gender: string;
  Address, City, State, Zip, Country, OCountry: string;
  // WebAware, Auth: boolean;
  WCity, WState, WZip, WAddress, Company, Department, Position, WSite, WCountry, Occupation: string;
  Phone, Fax, Cellular, WPhone, WFax, HomePage, LastUpdateInfo: string;
  Int1, Int2, Int3, Int4, I1, I2, I3, I4, About: string;
  Lang1, Lang2, Lang3, Marital, Sexual, Height, Relig, Smok, Hair, Children: string;

function StrArrayToStr(StrArr: array of string): string;
var
  I: Integer;
  S, Ss: string;
begin
  Result := EmptyStr;
  for I := low(StrArr) to high(StrArr) do
    begin
      S := StrArr[I];
      if (S > EmptyStr) and (Ss > EmptyStr) then
        Ss := Ss + ', ' + S
      else if (S > EmptyStr) and (Ss = EmptyStr) then
        Ss := S;
    end;
  Result := Ss;
end;

begin
  // Добавляем стили
  AddHTML(TopHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
  AddHTML(BottomHTMLViewer, HTMLStyle, EmptyStr, False, False, True);
  // Учётная запись контакта
  AddHTML(TopHTMLViewer, ICQAccountInfo + BN + ReqUIN, 'cbold');
  AddHTML(TopHTMLViewer, '<hr>', EmptyStr, False, True);
  // Загружаем информацию из распакованного xml файла с инфой
  // Инициализируем XML
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        // Загружаем настройки
        LoadFromFile(ProfilePath + AnketaFileName + ReqProto + BN + ReqUIN + '.xml');
        // Ник, Имя и фамилию
        if OpenKey(RS_NameInfo) then
          try
            Nick := URLDecode(ReadString(RS_Nick));
            if Nick <> EmptyStr then
              begin
                AddHTML(TopHTMLViewer, InfoNickL + BN, 'cbold');
                AddHTML(TopHTMLViewer, Nick, 'cdef', True);
              end;
            First := URLDecode(ReadString(RS_First));
            Last := URLDecode(ReadString(RS_Last));
            if IsNotNull([First, Last]) then
              begin
                AddHTML(TopHTMLViewer, InfoNameL + BN, 'cbold');
                if Trim(First) <> EmptyStr then
                  AddHTML(TopHTMLViewer, First + BN);
                AddHTML(TopHTMLViewer, Last, 'cdef', True);
              end;
          finally
            CloseKey;
          end;
        // Email адреса
        if OpenKey(RS_EmailsInfo) then
          try
            Email1 := URLDecode(ReadString(RS_Email1));
            Email2 := URLDecode(ReadString(RS_Email2));
            Email3 := URLDecode(ReadString(RS_Email3));
            if IsNotNull([Email1, Email2, Email3]) then
              begin
                if Trim(Email1) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, EmailL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email1 + '">' + Email1 + '</a>', 'cmargin', True);
                  end;
                if Trim(Email2) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, EmailL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email2 + '">' + Email2 + '</a>', 'cmargin', True);
                  end;
                if Trim(Email3) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, EmailL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email3 + '">' + Email3 + '</a>', 'cmargin', True);
                  end;
                // Вставляем разделитель
                AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
              end;
          finally
            CloseKey;
          end;
        // Место жительства
        if OpenKey(RS_HomeInfo) then
          try
            Address := URLDecode(ReadString(RS_Address));
            City := URLDecode(ReadString(RS_City));
            State := URLDecode(ReadString(RS_State));
            Zip := URLDecode(ReadString(RS_Zip));
            Country := ReadString(RS_Country);
            // Получаем текст страны из кода
            if Assigned(IcqOptionsForm) then
              Country := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf(Country)];
            if IsNotNull([Country, City]) then
              begin
                AddHTML(BottomHTMLViewer, InfoHomeL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, StrArrayToStr([Country, City]), 'cdef', True);
              end;
            if IsNotNull([Address, State, Zip]) then
              begin
                if Trim(Address) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoAdressL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Address, 'cdef', True);
                  end;
                if Trim(State) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoStateL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, State, 'cdef', True);
                  end;
                if Trim(Zip) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoZipL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Zip, 'cdef', True);
                  end;
              end;
            // Вставляем разделитель
            if (IsNotNull([Country, City])) or (IsNotNull([Address, State, Zip])) then
              AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          finally
            CloseKey;
          end;
        // Пол, последнее обновление, домашняя страничка, авторизация и вебаваре
        if OpenKey(RS_PerInfo) then
          try
            // WebAware := XmlElem.GetBoolAttr(RS_WebAware);
            // Auth := XmlElem.GetBoolAttr(RS_Auth);
            HomePage := URLDecode(ReadString(RS_HomePage));
            LastUpdateInfo := ReadString(RS_LastChange);
            Gender := ReadString(RS_Gender);
            if Gender = '1' then
              begin
                AddHTML(BottomHTMLViewer, InfoGenderL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, InfoGender1L, 'cdef', True);
              end
            else if Gender = '2' then
              begin
                AddHTML(BottomHTMLViewer, InfoGenderL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, InfoGender2L, 'cdef', True);
              end;
          finally
            CloseKey;
          end;
        // Дата рождения
        if OpenKey(RS_AgeInfo) then
          try
            Age := ReadString(RS_Age);
            IDay := ReadString(RS_Day);
            IMonth := ReadString(RS_Month);
            IYear := ReadString(RS_Year);
            if Age <> '0' then
              begin
                AddHTML(BottomHTMLViewer, InfoAgeL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, Age, 'cdef', True);
              end;
            if (IDay <> '0') and (IMonth <> '0') and (IYear <> '0') then
              begin
                AddHTML(BottomHTMLViewer, InfoBirDate + BN, 'cbold');
                AddHTML(BottomHTMLViewer, IDay + '.' + IMonth + '.' + IYear, 'cdef', True);
              end;
            // Вставляем разделитель
            if (Gender <> '0') or ((IDay <> '0') and (IMonth <> '0') and (IYear <> '0')) then
              AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          finally
            CloseKey;
          end;
        // Место рождения
        if OpenKey(RS_OHomeInfo) then
          try
            OCountry := ReadString(RS_Country);
            // Получаем текст страны из кода
            if Assigned(IcqOptionsForm) then
              OCountry := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf(OCountry)];
            OCity := URLDecode(ReadString(RS_City));
            OState := URLDecode(ReadString(RS_State));
            if IsNotNull([OCountry, OCity]) then
              begin
                AddHTML(BottomHTMLViewer, InfoOHomeL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, StrArrayToStr([OCountry, OCity]), 'cdef', True);
              end;
            if Trim(OState) <> EmptyStr then
              begin
                AddHTML(BottomHTMLViewer, InfoStateL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, OState, 'cdef', True);
              end;
            // Вставляем разделитель
            if (IsNotNull([OCountry, OCity])) or (Trim(OState) <> EmptyStr) then
              AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          finally
            CloseKey;
          end;
        // Работа
        if OpenKey(RS_WorkInfo) then
          try
            WCity := URLDecode(ReadString(RS_City));
            WState := URLDecode(ReadString(RS_State));
            WZip := URLDecode(ReadString(RS_Zip));
            WAddress := URLDecode(ReadString(RS_Address));
            Company := URLDecode(ReadString(RS_Corp));
            Department := URLDecode(ReadString(RS_Dep));
            Position := URLDecode(ReadString(RS_Prof));
            WSite := URLDecode(ReadString(RS_Site));
            WCountry := ReadString(RS_Country);
            Occupation := ReadString(RS_Occup);
            // Получаем текст страны из кода
            if Assigned(IcqOptionsForm) then
              WCountry := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf(WCountry)];
            // Получаем текст занятия из кода
            if Assigned(IcqOptionsForm) then
              Occupation := IcqOptionsForm.CompanyProfInfoComboBox.Items.Strings[IcqOptionsForm.OccupationCodeComboBox.Items.IndexOf
                (Occupation)];
            if IsNotNull([WCountry, WCity]) then
              begin
                AddHTML(BottomHTMLViewer, InfoWorkL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, StrArrayToStr([WCountry, WCity]), 'cdef', True);
              end;
            if IsNotNull([WAddress, WState, WZip]) then
              begin
                if Trim(WAddress) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoAdressL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, WAddress, 'cdef', True);
                  end;
                if Trim(WState) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoStateL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, WState, 'cdef', True);
                  end;
                if Trim(WZip) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoZipL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, WZip, 'cdef', True);
                  end;
              end;
            if IsNotNull([Company, Department, Position, Occupation, WSite]) then
              begin
                if Trim(Company) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoCompanyL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Company, 'cdef', True);
                  end;
                if Trim(Department) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoDeportL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Department, 'cdef', True);
                  end;
                if Trim(Position) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoPositionL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Position, 'cdef', True);
                  end;
                if Trim(Occupation) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoOccupationL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Occupation, 'cdef', True);
                  end;
                if Trim(WSite) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoWebSiteL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, WSite, 'cdef', True);
                  end;
              end;
            // Вставляем разделитель
            if (IsNotNull([WCountry, WCity])) or (IsNotNull([WAddress, WState, WZip])) or
              (IsNotNull([Company, Department, Position, Occupation, WSite])) then
              AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          finally
            CloseKey;
          end;
        // Телефоны
        if OpenKey(RS_PhoneInfo) then
          try
            Phone := URLDecode(ReadString(RS_Phone1));
            Fax := URLDecode(ReadString(RS_Phone2));
            Cellular := URLDecode(ReadString(RS_Phone3));
            WPhone := URLDecode(ReadString(RS_Phone4));
            WFax := URLDecode(ReadString(RS_Phone5));
            if IsNotNull([Phone, Fax, Cellular, WPhone, WFax]) then
              begin
                if Trim(Phone) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoPhoneL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Phone, 'cdef', True);
                  end;
                if Trim(Fax) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoFaxL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Fax, 'cdef', True);
                  end;
                if Trim(Cellular) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoCellularL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Cellular, 'cdef', True);
                  end;
                if Trim(WPhone) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfowPhoneL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, WPhone, 'cdef', True);
                  end;
                if Trim(WFax) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfowFaxL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, WFax, 'cdef', True);
                  end;
                // Вставляем разделитель
                AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
              end;
          finally
            CloseKey;
          end;
        // Интересы
        if OpenKey(RS_IntInfo) then
          try
            Int1 := URLDecode(ReadString(RS_Int1));
            Int2 := URLDecode(ReadString(RS_Int2));
            Int3 := URLDecode(ReadString(RS_Int3));
            Int4 := URLDecode(ReadString(RS_Int4));
          finally
            CloseKey;
          end;
        if OpenKey(RS_IntIdInfo) then
          try
            I1 := ReadString(RS_IntId1);
            I2 := ReadString(RS_IntId2);
            I3 := ReadString(RS_IntId3);
            I4 := ReadString(RS_IntId4);
            // Получаем название интереса из кода интереса
            if Assigned(IcqOptionsForm) then
              begin
                with IcqOptionsForm do
                  begin
                    I1 := Interest1InfoComboBox.Items.Strings[InterestsCodesComboBox.Items.IndexOf(I1)];
                    I2 := Interest1InfoComboBox.Items.Strings[InterestsCodesComboBox.Items.IndexOf(I2)];
                    I3 := Interest1InfoComboBox.Items.Strings[InterestsCodesComboBox.Items.IndexOf(I3)];
                    I4 := Interest1InfoComboBox.Items.Strings[InterestsCodesComboBox.Items.IndexOf(I4)];
                  end;
              end;
            // Формируем отображение интересов
            if IsNotNull([I1, I2, I3, I4, Int1, Int2, Int3, Int4]) then
              begin
                AddHTML(BottomHTMLViewer, InfoInterestsL + BN, 'cbold', True);
                if (Trim(I1) <> EmptyStr) or (Trim(Int1) <> EmptyStr) then
                  begin
                    AddHTML(BottomHTMLViewer, I1 + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Int1, 'cdef', True);
                  end;
                if (Trim(I2) <> EmptyStr) or (Trim(Int2) <> EmptyStr) then
                  begin
                    AddHTML(BottomHTMLViewer, I2 + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Int2, 'cdef', True);
                  end;
                if (Trim(I3) <> EmptyStr) or (Trim(Int3) <> EmptyStr) then
                  begin
                    AddHTML(BottomHTMLViewer, I3 + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Int3, 'cdef', True);
                  end;
                if (Trim(I4) <> EmptyStr) or (Trim(Int4) <> EmptyStr) then
                  begin
                    AddHTML(BottomHTMLViewer, I4 + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Int4, 'cdef', True);
                  end;
                // Вставляем разделитель
                AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
              end;
          finally
            CloseKey;
          end;
        // Личное
        if OpenKey(RS_PersInfo) then
          try
            Marital := ReadString(RS_Marital);
            Sexual := ReadString(RS_Sexual);
            Height := ReadString(RS_Height);
            Relig := ReadString(RS_Relig);
            Smok := ReadString(RS_Smok);
            Hair := ReadString(RS_Hair);
            Children := ReadString(RS_Children);
            // Получаем название из кода
            if Assigned(IcqOptionsForm) then
              begin
                with IcqOptionsForm do
                  begin
                    Marital := PersonalMaritalInfoComboBox.Items.Strings[MaritalCodesComboBox.Items.IndexOf(Marital)];
                    Sexual := PersonalSexInfoComboBox.Items.Strings[SexCodesComboBox.Items.IndexOf(Sexual)];
                    Relig := PersonalReligionInfoComboBox.Items.Strings[ReligionCodesComboBox.Items.IndexOf(Relig)];
                    Smok := PersonalSmokInfoComboBox.Items.Strings[SmokCodesComboBox.Items.IndexOf(Smok)];
                    Hair := PersonalHairColourInfoComboBox.Items.Strings[HairColourCodesComboBox.Items.IndexOf(Hair)];
                  end;
              end;
            // Формируем отображение
            if IsNotNull([Marital, Sexual, Height, Relig, Smok, Hair, Children]) then
              begin
                if Trim(Marital) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoMaritalL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Marital, 'cdef', True);
                  end;
                if Trim(Sexual) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoSexualL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Sexual, 'cdef', True);
                  end;
                if Height <> '0' then
                  begin
                    case StrToInt(Height) of
                      140: Height := '140cm';
                      145: Height := '141-145cm';
                      150: Height := '146-150cm';
                      155: Height := '151-155cm';
                      160: Height := '156-160cm';
                      165: Height := '161-165cm';
                      170: Height := '166-170cm';
                      175: Height := '171-175cm';
                      180: Height := '176-180cm';
                      185: Height := '181-185cm';
                      190: Height := '186-190cm';
                      195: Height := '191-195cm';
                      200: Height := '196-200cm';
                      205: Height := '201-205cm';
                      210: Height := '206-210cm';
                      220: Height := '220cm';
                    end;
                    AddHTML(BottomHTMLViewer, InfoHeightL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Height, 'cdef', True);
                  end;
                if Trim(Relig) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoReligL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Relig, 'cdef', True);
                  end;
                if Trim(Smok) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoSmokL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Smok, 'cdef', True);
                  end;
                if Trim(Hair) <> EmptyStr then
                  begin
                    AddHTML(BottomHTMLViewer, InfoHairL + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Hair, 'cdef', True);
                  end;
                if Children <> '0' then
                  begin
                    case StrToInt(Children) of
                      1: Children := '1';
                      2: Children := '2';
                      3: Children := '3';
                      4: Children := '4';
                      5: Children := '5';
                      6: Children := '6';
                      7: Children := '7';
                      8: Children := '8';
                      9: Children := InfoChildrenL2;
                      255: Children := InfoChildrenL3;
                    end;
                    AddHTML(BottomHTMLViewer, InfoChildrenL1 + BN, 'cbold');
                    AddHTML(BottomHTMLViewer, Children, 'cdef', True);
                  end;
                // Вставляем разделитель
                if (IsNotNull([Marital, Sexual, Relig, Smok, Hair])) or (Height <> '0') or (Children <> '0') then
                  AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
              end;
          finally
            CloseKey;
          end;
        // Языки
        if OpenKey(RS_LangInfo) then
          try
            Lang1 := ReadString(RS_Lang1);
            Lang2 := ReadString(RS_Lang2);
            Lang3 := ReadString(RS_Lang3);
            // Получаем название языка из кода языка
            if Assigned(IcqOptionsForm) then
              begin
                with IcqOptionsForm do
                  begin
                    Lang1 := Lang1InfoComboBox.Items.Strings[LangsCodeComboBox.Items.IndexOf(Lang1)];
                    Lang2 := Lang1InfoComboBox.Items.Strings[LangsCodeComboBox.Items.IndexOf(Lang2)];
                    Lang3 := Lang1InfoComboBox.Items.Strings[LangsCodeComboBox.Items.IndexOf(Lang3)];
                  end;
              end;
            // Формируем отображение языков
            if IsNotNull([Lang1, Lang2, Lang3]) then
              begin
                AddHTML(BottomHTMLViewer, InfoLangL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, StrArrayToStr([Lang1, Lang2, Lang3]), 'cdef', True);
                // Вставляем разделитель
                AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
              end;
          finally
            CloseKey;
          end;
        // О себе
        if OpenKey(RS_AboutInfo) then
          try
            About := URLDecode(ReadString(RS_Info));
            if Trim(About) <> EmptyStr then
              begin
                AddHTML(BottomHTMLViewer, InfoAboutL + BN, 'cbold');
                AddHTML(BottomHTMLViewer, About, 'cdef', True);
                // Вставляем разделитель
                AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
              end;
          finally
            CloseKey;
          end;
        // Домашняя страница
        if Trim(HomePage) <> EmptyStr then
          begin
            AddHTML(BottomHTMLViewer, InfoHomePageL + BN, 'cbold');
            AddHTML(BottomHTMLViewer, HomePage, 'cdef', True);
            // Вставляем разделитель
            AddHTML(BottomHTMLViewer, '<hr>', EmptyStr, False, True);
          end;
        // Дата последнего обновления, дополнительно
        if Trim(LastUpdateInfo) <> EmptyStr then
          begin
            AddHTML(BottomHTMLViewer, InfoLastUpDateL + BN, 'cbold');
            AddHTML(BottomHTMLViewer, LastUpdateInfo, 'cdef', True);
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
  // Вычисляем знак гороскопа
  if (IDay <> '0') and (IMonth <> '0') then
    begin
      // Загружаем картинку гороскопа
      HoroImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\horoscope.bmp');
      // Прокручиваем на картинку этого знака
      HoroImage.Canvas.CopyRect(Rect(0, 0, 32, 32), HoroImage.Canvas, Bounds(Horospope(StrToInt(IDay), StrToInt(IMonth)), 0, 32, 32));
    end
  else
    HoroImage.Picture.Assign(nil);
  // Загружаем аватар
  AvatarImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif');
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

procedure TIcqContactInfoForm.ReqInfoBitBtnClick(Sender: TObject);
begin
  // Запрашиваем информацию о контакте
  if (ReqUIN > EmptyStr) and (ICQ_Work_Phaze) then
    begin
      InfoLabel.Caption := InfoReqL;
      ICQ_ReqInfo_New_Pkt(ReqUIN);
    end;
end;

procedure TIcqContactInfoForm.OKBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TIcqContactInfoForm.FormCreate(Sender: TObject);
var
  XmlFile: TrXML;
begin
  // Инициализируем XML
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        // Загружаем настройки
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            // Загружаем позицию окна
            if OpenKey(RS_ContFormPos) then
              try
                Top := ReadInteger('top');
                Left := ReadInteger('left');
              finally
                CloseKey;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
  // Переводим форму на другие языки
  TranslateForm;
  HTMLStyle := '<html><head>' + DetailsCSS + '<title>Details</title></head><body>';
  // Ставим иконки окна и кнопок
  MainForm.AllImageList.GetIcon(178, Icon);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ReqInfoBitBtn.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TIcqContactInfoForm.FormDestroy(Sender: TObject);
var
  XmlFile: TrXML;
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  // Сохраняем настройки положения окна в xml
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        if OpenKey(RS_ContFormPos, True) then
          try
            WriteInteger('top', Top);
            WriteInteger('left', Left);
          finally
            CloseKey;
          end;
        // Записываем сам файл
        SaveToFile(ProfilePath + SettingsFileName);
      end;
  finally
    FreeAndNil(XmlFile);
  end;
end;

end.
