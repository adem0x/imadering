{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqContactInfoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Htmlview, ShellApi, StrUtils, VarsUnit;

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
    procedure OKBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReqInfoBitBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure AddHTML(const ToWhere: THTMLViewer; Text: string;
      TextClass: string = 'cdef'; InsertBR: boolean = false;
      StupidInsert: boolean = false; ClearIt: boolean = false);
    procedure CreateSummery;
  public
    { Public declarations }
    ReqUIN: string;
    procedure TranslateForm;
    procedure LoadUserUnfo;
  end;

var
  IcqContactInfoForm: TIcqContactInfoForm;

const
  DetailsCSS: string = '<style type="text/css">' +
  'body, span { color: #000000; font: 12px tahoma, verdana; }' +
    'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' +
    '.cbold { font: bold 12px tahoma, verdana; }' +
    '.cdef { font: 12px tahoma, verdana; }' +
    '.cmargin { font: 11px tahoma, verdana; margin: 10px; }' +
    '</style>';

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UtilsUnit, SimpleXML, IcqOptionsUnit, Code;

procedure TIcqContactInfoForm.TranslateForm;
begin
  //--Переводим форму на другие языки

end;

procedure TIcqContactInfoForm.AddHTML(const ToWhere: THTMLViewer; Text: string;
  TextClass: string = 'cdef'; InsertBR: boolean = false;
  StupidInsert: boolean = false; ClearIt: boolean = false);
var
  Doc: string;
begin
  try
    Doc := ToWhere.DocumentSource;
    if StupidInsert then
    begin
      Doc := Doc + Text;
    end
    else
    begin
      Doc := Doc + '<span class="' + TextClass + '">' + Text + '</span>';
    end;
    if InsertBR then Doc := Doc + '<br>';
    if ClearIt then Doc := Text;
    ToWhere.LoadFromBuffer(PChar(Doc), Length(Doc), '');
  except
  end;
end;

procedure TIcqContactInfoForm.LoadUserUnfo;
var
  Doc: string;
begin
  //--Устанавливаем заголовок окна
  Caption := InfoCaptionL + ': ' + ReqUIN;
  //--Стираем отображение предыдущей инфы
  TopHTMLViewer.Clear;
  BottomHTMLViewer.Clear;
  Doc := '';
  TopHTMLViewer.LoadFromBuffer(PChar(Doc), Length(Doc), '');
  BottomHTMLViewer.LoadFromBuffer(PChar(Doc), Length(Doc), '');
  //--Ищем локально файл с информацией
  if FileExists(MyPath + 'Profile\Contacts\Icq_' + ReqUIN + '.z') then
  begin
    InfoLabel.Caption := InfoOKL;
    //--Распаковываем файл
    UnZip_File(MyPath + 'Profile\Contacts\Icq_' + ReqUIN + '.z', MyPath + 'Profile\Contacts\');
    //--Запускаем создание суммарного инфо из распакованного файла
    CreateSummery;
  end
  //--Если файл с инфой не нашли, то запрашиваем её и ожидаем получения
  else
  begin
    if ICQ_Work_Phaze then
    begin
      InfoLabel.Caption := InfoReqL;
      ICQ_ReqInfo_New_Pkt(ReqUIN);
    end;
    //--Добавляем стили
    AddHTML(TopHTMLViewer, '<html><head>' + DetailsCSS + '<title>Details</title></head><body>', '', false, false, true);
    //--Учётная запись контакта
    AddHTML(TopHTMLViewer, ICQAccountInfo + ' ' + ReqUIN, 'cbold');
    AddHTML(TopHTMLViewer, '<hr>', '', false, true);
    //--Очищаем картинку гороскопа
    HoroImage.Picture.Assign(nil);
    //--Загружаем аватар
    AvatarImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif');
  end;
end;

procedure TIcqContactInfoForm.CreateSummery;
var
  Xml: IXmlDocument;
  XmlElem: IXmlNode;
  Nick, First, Last, Age, iDay, iMonth, iYear: string;
  Email1, Email2, Email3, oCity, oState, Gender: string;
  Address, City, State, Zip, Country, oCountry: string;
  //WebAware, Auth: boolean;
  wCity, wState, wZip, wAddress, Company, Department, Position, wSite, wCountry, Occupation: string;
  Phone, Fax, Cellular, wPhone, wFax, HomePage, LastUpdateInfo: string;
  Int1, Int2, Int3, Int4, I1, I2, I3, I4, About: string;
  Lang1, Lang2, Lang3, Marital, Sexual, Height, Relig, Smok, Hair, Children: string;

  function StrArrayToStr(StrArr: array of string): string;
  var
    i: integer;
    s, ss: string;
  begin
    Result := '';
    for i := Low(StrArr) to High(StrArr) do
    begin
      s := StrArr[i];
      if (s > '') and (ss > '') then ss := ss + ', ' + s
      else if (s > '') and (ss = '') then ss := s;
    end;
    Result := ss;
  end;

  function CheckTextBR(msg: string): string;
  begin
    Result := AnsiReplaceText(msg, #13#10, '<BR>');
  end;

begin
  //--Добавляем стили
  AddHTML(TopHTMLViewer, '<html><head>' + DetailsCSS + '<title>Details</title></head><body>', '', false, false, true);
  AddHTML(BottomHTMLViewer, '<html><head>' + DetailsCSS + '<title>Details</title></head><body>', '', false, false, true);
  //--Учётная запись контакта
  AddHTML(TopHTMLViewer, ICQAccountInfo + ' ' + ReqUIN, 'cbold');
  AddHTML(TopHTMLViewer, '<hr>', '', false, true);
  //--Загружаем информацию из распакованного xml файла с инфой
  //--Инициализируем XML
  try
    Xml := CreateXmlDocument;
    //--Загружаем настройки
    if FileExists(MyPath + 'Profile\Contacts\Icq_Info.xml') then
    begin
      Xml.Load(MyPath + 'Profile\Contacts\Icq_Info.xml');
      //--Ник, Имя и фамилию
      XmlElem := Xml.DocumentElement.SelectSingleNode('name-info');
      if XmlElem <> nil then
      begin
        Nick := XmlElem.GetAttr('nick');
        if Nick <> '' then
        begin
          AddHTML(TopHTMLViewer, InfoNickL + ' ', 'cbold');
          AddHTML(TopHTMLViewer, Nick, 'cdef', true);
        end;
        First := XmlElem.GetAttr('first');
        Last := XmlElem.GetAttr('last');
        if IsNotNull([First, Last]) then
        begin
          AddHTML(TopHTMLViewer, InfoNameL + ' ', 'cbold');
          if Trim(First) <> '' then AddHTML(TopHTMLViewer, First + ' ');
          AddHTML(TopHTMLViewer, Last, 'cdef', true);
        end;
      end;
      //--Email адреса
      XmlElem := Xml.DocumentElement.SelectSingleNode('emails-info');
      if XmlElem <> nil then
      begin
        Email1 := XmlElem.GetAttr('email1');
        Email2 := XmlElem.GetAttr('email2');
        Email3 := XmlElem.GetAttr('email3');
        if IsNotNull([Email1, Email2, Email3]) then
        begin
          if Trim(Email1) <> '' then
          begin
            AddHTML(BottomHTMLViewer, EmailL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email1 + '">' + Email1 + '</a>', 'cmargin', true);
          end;
          if Trim(Email2) <> '' then
          begin
            AddHTML(BottomHTMLViewer, EmailL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email2 + '">' + Email2 + '</a>', 'cmargin', true);
          end;
          if Trim(Email3) <> '' then
          begin
            AddHTML(BottomHTMLViewer, EmailL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, '<a href="mailto:' + Email3 + '">' + Email3 + '</a>', 'cmargin', true);
          end;
          //--Вставляем разделитель
          AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
        end;
      end;
      //--Место жительства
      XmlElem := Xml.DocumentElement.SelectSingleNode('home-info');
      if XmlElem <> nil then
      begin
        Address := XmlElem.GetAttr('address');
        City := XmlElem.GetAttr('city');
        State := XmlElem.GetAttr('state');
        Zip := XmlElem.GetAttr('zip');
        Country := XmlElem.GetAttr('country');
        //--Получаем текст страны из кода
        if Assigned(IcqOptionsForm) then
          Country := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf(Country)];
        if IsNotNull([Country, City]) then
        begin
          AddHTML(BottomHTMLViewer, InfoHomeL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, StrArrayToStr([Country, City]), 'cdef', true);
        end;
        if IsNotNull([Address, State, Zip]) then
        begin
          if Trim(Address) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoAdressL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Address, 'cdef', true);
          end;
          if Trim(State) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoStateL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, State, 'cdef', true);
          end;
          if Trim(Zip) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoZipL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Zip, 'cdef', true);
          end;
        end;
        //--Вставляем разделитель
        if (IsNotNull([Country, City])) or (IsNotNull([Address, State, Zip])) then AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
      end;
      //--Пол, дата рождения и возраст
      XmlElem := Xml.DocumentElement.SelectSingleNode('personal-info');
      if XmlElem <> nil then
      begin
        //WebAware := XmlElem.GetBoolAttr('webaware');
        //Auth := XmlElem.GetBoolAttr('auth');
        HomePage := XmlElem.GetAttr('homepage');
        LastUpdateInfo := XmlElem.GetAttr('lastchange');
        Gender := XmlElem.GetAttr('gender');
        if Gender = '1' then
        begin
          AddHTML(BottomHTMLViewer, InfoGenderL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, InfoGender1L, 'cdef', true);
        end
        else if Gender = '2' then
        begin
          AddHTML(BottomHTMLViewer, InfoGenderL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, InfoGender2L, 'cdef', true);
        end;
      end;
      XmlElem := Xml.DocumentElement.SelectSingleNode('age-info');
      if XmlElem <> nil then
      begin
        Age := XmlElem.GetAttr('age');
        iDay := XmlElem.GetAttr('day');
        iMonth := XmlElem.GetAttr('mon');
        iYear := XmlElem.GetAttr('year');
        if Age <> '0' then
        begin
          AddHTML(BottomHTMLViewer, InfoAgeL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, Age, 'cdef', true);
        end;
        if (iDay <> '0') and (iMonth <> '0') and (iYear <> '0') then
        begin
          AddHTML(BottomHTMLViewer, InfoBirDate + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, iDay + '.' + iMonth + '.' + iYear, 'cdef', true);
        end;
        //--Вставляем разделитель
        if (Gender <> '0') or ((iDay <> '0') and (iMonth <> '0') and (iYear <> '0')) then AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
      end;
      //--Место рождения
      XmlElem := Xml.DocumentElement.SelectSingleNode('orig-home-info');
      if XmlElem <> nil then
      begin
        oCountry := XmlElem.GetAttr('country');
        //--Получаем текст страны из кода
        if Assigned(IcqOptionsForm) then
          oCountry := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf(oCountry)];
        oCity := XmlElem.GetAttr('city');
        oState := XmlElem.GetAttr('state');
        if IsNotNull([oCountry, oCity]) then
        begin
          AddHTML(BottomHTMLViewer, InfoOHomeL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, StrArrayToStr([oCountry, oCity]), 'cdef', true);
        end;
        if Trim(oState) <> '' then
        begin
          AddHTML(BottomHTMLViewer, InfoStateL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, oState, 'cdef', true);
        end;
        //--Вставляем разделитель
        if (IsNotNull([oCountry, oCity])) or (Trim(oState) <> '') then AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
      end;
      //--Работа
      XmlElem := Xml.DocumentElement.SelectSingleNode('work-info');
      if XmlElem <> nil then
      begin
        wCity := XmlElem.GetAttr('city');
        wState := XmlElem.GetAttr('state');
        wZip := XmlElem.GetAttr('zip');
        wAddress := XmlElem.GetAttr('address');
        Company := XmlElem.GetAttr('corp');
        Department := XmlElem.GetAttr('dep');
        Position := XmlElem.GetAttr('prof');
        wSite := XmlElem.GetAttr('site');
        wCountry := XmlElem.GetAttr('country');
        Occupation := XmlElem.GetAttr('occup');
        //--Получаем текст страны из кода
        if Assigned(IcqOptionsForm) then
          wCountry := IcqOptionsForm.CountryInfoComboBox.Items.Strings[IcqOptionsForm.CountryCodesComboBox.Items.IndexOf(wCountry)];
        //--Получаем текст занятия из кода
        if Assigned(IcqOptionsForm) then
          Occupation := IcqOptionsForm.CompanyProfInfoComboBox.Items.Strings[IcqOptionsForm.OccupationCodeComboBox.Items.IndexOf(Occupation)];
        if IsNotNull([wCountry, wCity]) then
        begin
          AddHTML(BottomHTMLViewer, InfoWorkL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, StrArrayToStr([wCountry, wCity]), 'cdef', true);
        end;
        if IsNotNull([wAddress, wState, wZip]) then
        begin
          if Trim(wAddress) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoAdressL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, wAddress, 'cdef', true);
          end;
          if Trim(wState) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoStateL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, wState, 'cdef', true);
          end;
          if Trim(wZip) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoZipL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, wZip, 'cdef', true);
          end;
        end;
        if IsNotNull([Company, Department, Position, Occupation, wSite]) then
        begin
          if Trim(Company) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoCompanyL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Company, 'cdef', true);
          end;
          if Trim(Department) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoDeportL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Department, 'cdef', true);
          end;
          if Trim(Position) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoPositionL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Position, 'cdef', true);
          end;
          if Trim(Occupation) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoOccupationL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Occupation, 'cdef', true);
          end;
          if Trim(wSite) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoWebSiteL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, wSite, 'cdef', true);
          end;
        end;
        //--Вставляем разделитель
        if (IsNotNull([wCountry, wCity])) or (IsNotNull([wAddress, wState, wZip])) or
          (IsNotNull([Company, Department, Position, Occupation, wSite])) then
          AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
      end;
      //--Телефоны
      XmlElem := Xml.DocumentElement.SelectSingleNode('phone-info');
      if XmlElem <> nil then
      begin
        Phone := XmlElem.GetAttr('phone1');
        Fax := XmlElem.GetAttr('phone2');
        Cellular := XmlElem.GetAttr('phone3');
        wPhone := XmlElem.GetAttr('phone4');
        wFax := XmlElem.GetAttr('phone5');
        if IsNotNull([Phone, Fax, Cellular, wPhone, wFax]) then
        begin
          if Trim(Phone) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoPhoneL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Phone, 'cdef', true);
          end;
          if Trim(Fax) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoFaxL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Fax, 'cdef', true);
          end;
          if Trim(Cellular) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoCellularL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Cellular, 'cdef', true);
          end;
          if Trim(wPhone) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfowPhoneL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, wPhone, 'cdef', true);
          end;
          if Trim(wFax) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfowFaxL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, wFax, 'cdef', true);
          end;
          //--Вставляем разделитель
          AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
        end;
      end;
      //--Интересы
      XmlElem := Xml.DocumentElement.SelectSingleNode('interests-info');
      if XmlElem <> nil then
      begin
        Int1 := XmlElem.GetAttr('int1');
        Int2 := XmlElem.GetAttr('int2');
        Int3 := XmlElem.GetAttr('int3');
        Int4 := XmlElem.GetAttr('int4');
      end;
      XmlElem := Xml.DocumentElement.SelectSingleNode('interests-id-info');
      if XmlElem <> nil then
      begin
        I1 := XmlElem.GetAttr('int_id1');
        I2 := XmlElem.GetAttr('int_id2');
        I3 := XmlElem.GetAttr('int_id3');
        I4 := XmlElem.GetAttr('int_id4');
        //--Получаем название интереса из кода интереса
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
        //--Формируем отображение интересов
        if IsNotNull([I1, I2, I3, I4, Int1, Int2, Int3, Int4]) then
        begin
          AddHTML(BottomHTMLViewer, InfoInterestsL + ' ', 'cbold', true);
          if (Trim(I1) <> '') or (Trim(Int1) <> '') then
          begin
            AddHTML(BottomHTMLViewer, I1 + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Int1, 'cdef', true);
          end;
          if (Trim(I2) <> '') or (Trim(Int2) <> '') then
          begin
            AddHTML(BottomHTMLViewer, I2 + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Int2, 'cdef', true);
          end;
          if (Trim(I3) <> '') or (Trim(Int3) <> '') then
          begin
            AddHTML(BottomHTMLViewer, I3 + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Int3, 'cdef', true);
          end;
          if (Trim(I4) <> '') or (Trim(Int4) <> '') then
          begin
            AddHTML(BottomHTMLViewer, I4 + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Int4, 'cdef', true);
          end;
          //--Вставляем разделитель
          AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
        end;
      end;
      //--Личное
      XmlElem := Xml.DocumentElement.SelectSingleNode('personal-x-info');
      if XmlElem <> nil then
      begin
        Marital := XmlElem.GetAttr('marital');
        Sexual := XmlElem.GetAttr('sexual');
        Height := XmlElem.GetAttr('height');
        Relig := XmlElem.GetAttr('relig');
        Smok := XmlElem.GetAttr('smok');
        Hair := XmlElem.GetAttr('hair');
        Children := XmlElem.GetAttr('children');
        //--Получаем название из кода
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
        //--Формируем отображение
        if IsNotNull([Marital, Sexual, Height, Relig, Smok, Hair, Children]) then
        begin
          if Trim(Marital) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoMaritalL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Marital, 'cdef', true);
          end;
          if Trim(Sexual) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoSexualL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Sexual, 'cdef', true);
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
            AddHTML(BottomHTMLViewer, InfoHeightL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Height, 'cdef', true);
          end;
          if Trim(Relig) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoReligL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Relig, 'cdef', true);
          end;
          if Trim(Smok) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoSmokL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Smok, 'cdef', true);
          end;
          if Trim(Hair) <> '' then
          begin
            AddHTML(BottomHTMLViewer, InfoHairL + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Hair, 'cdef', true);
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
            AddHTML(BottomHTMLViewer, InfoChildrenL1 + ' ', 'cbold');
            AddHTML(BottomHTMLViewer, Children, 'cdef', true);
          end;
          //--Вставляем разделитель
          if (IsNotNull([Marital, Sexual, Relig, Smok, Hair])) or (Height <> '0') or (Children <> '0') then
            AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
        end;
      end;
      //--Языки
      XmlElem := Xml.DocumentElement.SelectSingleNode('lang-info');
      if XmlElem <> nil then
      begin
        Lang1 := XmlElem.GetAttr('lang1');
        Lang2 := XmlElem.GetAttr('lang2');
        Lang3 := XmlElem.GetAttr('lang3');
        //--Получаем название языка из кода языка
        if Assigned(IcqOptionsForm) then
        begin
          with IcqOptionsForm do
          begin
            Lang1 := Lang1InfoComboBox.Items.Strings[LangsCodeComboBox.Items.IndexOf(Lang1)];
            Lang2 := Lang1InfoComboBox.Items.Strings[LangsCodeComboBox.Items.IndexOf(Lang2)];
            Lang3 := Lang1InfoComboBox.Items.Strings[LangsCodeComboBox.Items.IndexOf(Lang3)];
          end;
        end;
        //--Формируем отображение языков
        if IsNotNull([Lang1, Lang2, Lang3]) then
        begin
          AddHTML(BottomHTMLViewer, InfoLangL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, StrArrayToStr([Lang1, Lang2, Lang3]), 'cdef', true);
          //--Вставляем разделитель
          AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
        end;
      end;
      //--О себе
      XmlElem := Xml.DocumentElement.SelectSingleNode('about-info');
      if XmlElem <> nil then
      begin
        About := Decrypt(XmlElem.Text, 12345);
        if Trim(About) <> '' then
        begin
          AddHTML(BottomHTMLViewer, InfoAboutL + ' ', 'cbold');
          AddHTML(BottomHTMLViewer, About, 'cdef', true);
          //--Вставляем разделитель
          AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
        end;
      end;
      //--Домашняя страница
      if Trim(HomePage) <> '' then
      begin
        AddHTML(BottomHTMLViewer, InfoHomePageL + ' ', 'cbold');
        AddHTML(BottomHTMLViewer, HomePage, 'cdef', true);
        //--Вставляем разделитель
        AddHTML(BottomHTMLViewer, '<hr>', '', false, true);
      end;
      //--Дата последнего обновления, дополнительно
      if Trim(LastUpdateInfo) <> '' then
      begin
        AddHTML(BottomHTMLViewer, InfoLastUpDateL + ' ', 'cbold');
        AddHTML(BottomHTMLViewer, LastUpdateInfo, 'cdef', true);
      end;
    end;
  except
  end;
  //--Вычисляем знак гороскопа
  if (iDay <> '0') and (iMonth <> '0') then
  begin
    //--Загружаем картинку гороскопа
    HoroImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\horoscope.bmp');
    //--Прокручиваем на картинку этого знака
    HoroImage.Canvas.CopyRect(Rect(0, 0, 32, 32), HoroImage.Canvas, Bounds(Horospope(StrToInt(iDay), StrToInt(iMonth)), 0, 32, 32));
  end
  else HoroImage.Picture.Assign(nil);
  //--Загружаем аватар
  AvatarImage.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif');
  {if (Length(UserAvatarHash) = 32) and ((FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')) or
    (FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.gif')) or
    (FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.bmp'))) then
  begin
    if FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.jpg') then
      ContactImage.Picture.LoadFromFile(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')
    else if FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.gif') then
      ContactImage.Picture.LoadFromFile(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.gif')
    else if FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.bmp') then
      ContactImage.Picture.LoadFromFile(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.bmp');
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
  end;}
  //--Удаляем распакованный файл с информацией
  if FileExists(MyPath + 'Profile\Contacts\Icq_Info.xml') then DeleteFile(MyPath + 'Profile\Contacts\Icq_Info.xml');
end;

procedure TIcqContactInfoForm.ReqInfoBitBtnClick(Sender: TObject);
begin
  //--Запрашиваем информацию о контакте
  if (ReqUIN > '') and (ICQ_Work_Phaze) then
  begin
    InfoLabel.Caption := InfoReqL;
    ICQ_ReqInfo_New_Pkt(ReqUIN);
  end;
end;

procedure TIcqContactInfoForm.OKBitBtnClick(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TIcqContactInfoForm.FormCreate(Sender: TObject);
var
  Xml: IXmlDocument;
  XmlElem: IXmlNode;
begin
  //--Инициализируем XML
  try
    Xml := CreateXmlDocument;
    //--Загружаем настройки
    if FileExists(MyPath + 'Profile\ContactInfoForm.xml') then
    begin
      Xml.Load(MyPath + 'Profile\ContactInfoForm.xml');
      //--Загружаем позицию окна
      XmlElem := Xml.DocumentElement.SelectSingleNode('contactinfoform-position');
      if XmlElem <> nil then
      begin
        Top := XmlElem.GetIntAttr('top');
        Left := XmlElem.GetIntAttr('left');
      end;
    end;
  except
  end;
  //--Переводим форму на другие языки
  TranslateForm;
  //--Ставим иконки окна и кнопок
  MainForm.AllImageList.GetIcon(178, Icon);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ReqInfoBitBtn.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TIcqContactInfoForm.FormDestroy(Sender: TObject);
var
  Xml: IXmlDocument;
  XmlElem: IXmlNode;
begin
  //--Сохраняем настройки положения окна в xml
  try
    Xml := CreateXmlDocument('xml');
    //--Сохраняем позицию окна
    XmlElem := Xml.DocumentElement.AppendElement('contactinfoform-position');
    XmlElem.SetIntAttr('top', Top);
    XmlElem.SetIntAttr('left', Left);
    //--Записываем сам файл
    Xml.Save(MyPath + 'Profile\ContactInfoForm.xml');
  except
  end;
end;

end.

