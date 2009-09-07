{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqSearchUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Menus, VarsUnit, JvExComCtrls,
  JvListView, rXML;

type
  TIcqSearchForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    NotPreviousClearCheckBox: TCheckBox;
    OnlyOnlineCheckBox: TCheckBox;
    SearchBitBtn: TBitBtn;
    StatusPanel: TPanel;
    ResultPanel: TPanel;
    ResultClearSpeedButton: TSpeedButton;
    QMessageEdit: TEdit;
    SendQMessageSpeedButton: TSpeedButton;
    SearchResultPopupMenu: TPopupMenu;
    ICQStatusCheckSM: TMenuItem;
    AccountNameCopySM: TMenuItem;
    SendMessageSM: TMenuItem;
    SearchNextPageBitBtn: TBitBtn;
    ContactInfoSM: TMenuItem;
    AddContactInCLSM: TMenuItem;
    SearchResultJvListView: TJvListView;
    Panel12: TPanel;
    GlobalSearchGroupBox: TGroupBox;
    NickLabel: TLabel;
    NickEdit: TEdit;
    NameLabel: TLabel;
    NameEdit: TEdit;
    FamilyLabel: TLabel;
    FamilyEdit: TEdit;
    GenderLabel: TLabel;
    GenderComboBox: TComboBox;
    AgeLabel: TLabel;
    AgeComboBox: TComboBox;
    MaritalLabel: TLabel;
    MaritalComboBox: TComboBox;
    Label25: TLabel;
    CountryComboBox: TComboBox;
    CityLabel: TLabel;
    CityEdit: TEdit;
    LangLabel: TLabel;
    LangComboBox: TComboBox;
    ProfLabel: TLabel;
    ProfComboBox: TComboBox;
    InterestLabel: TLabel;
    InterestComboBox: TComboBox;
    KeyWordLabel: TLabel;
    KeyWordEdit: TEdit;
    Bevel3: TBevel;
    GlobalSearchCheckBox: TCheckBox;
    UINSearchGroupBox: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    UINSearchCheckBox: TCheckBox;
    Edit1: TEdit;
    EmailSearchCheckBox: TCheckBox;
    Edit2: TEdit;
    KeyWordSearchCheckBox: TCheckBox;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QMessageEditEnter(Sender: TObject);
    procedure QMessageEditExit(Sender: TObject);
    procedure SearchBitBtnClick(Sender: TObject);
    procedure ResultClearSpeedButtonClick(Sender: TObject);
    procedure SendQMessageSpeedButtonClick(Sender: TObject);
    procedure SearchNextPageBitBtnClick(Sender: TObject);
    procedure Edit23KeyPress(Sender: TObject; var Key: Char);
    procedure AutoSendTimerTimer(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ICQStatusCheckSMClick(Sender: TObject);
    procedure AccountNameCopySMClick(Sender: TObject);
    procedure SendMessageSMClick(Sender: TObject);
    procedure AddContactInCLSMClick(Sender: TObject);
    procedure ContactInfoSMClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchResultJvListViewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SearchResultJvListViewChanging(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
    procedure SearchResultJvListViewContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure SearchResultJvListViewGetSubItemImage(Sender: TObject;
      Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
    procedure SearchResultJvListViewColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure SearchResultJvListViewGetImageIndex(Sender: TObject;
      Item: TListItem);
  private
    { Private declarations }
    QmessT: string;
    //sPage: word;
    sPageInc: boolean;
    //autosendind: integer;
  public
    { Public declarations }
    SP1, SP2, SP3, SP4: string;
    G1, G2: string;
    A1, A2: string;
    procedure TranslateForm;
  end;

var
  IcqSearchForm: TIcqSearchForm;

implementation

uses MainUnit, IcqProtoUnit, UtilsUnit, IcqAddContactUnit, IcqContactInfoUnit,
  IcqOptionsUnit;

{$R *.dfm}

procedure TIcqSearchForm.TranslateForm;
begin
  //--Присваиваем списки комбобоксам
  if Assigned(IcqOptionsForm) then
  begin
    with IcqOptionsForm do
    begin
      //--Присваиваем Брак
      MaritalComboBox.Items.Assign(PersonalMaritalInfoComboBox.Items);
      SetCustomWidthComboBox(MaritalComboBox);
      //--Присваиваем Страну
      CountryComboBox.Items.Assign(CountryInfoComboBox.Items);
      SetCustomWidthComboBox(CountryComboBox);
      //--Присваиваем Язык
      LangComboBox.Items.Assign(Lang1InfoComboBox.Items);
      SetCustomWidthComboBox(LangComboBox);
      //--Присваиваем Профессию
      ProfComboBox.Items.Assign(CompanyProfInfoComboBox.Items);
      SetCustomWidthComboBox(ProfComboBox);
      //--Присваиваем Интересы
      InterestComboBox.Items.Assign(Interest1InfoComboBox.Items);
      SetCustomWidthComboBox(InterestComboBox);
    end;
  end;
  //--Переводим форму на другие языки
  
end;

procedure TIcqSearchForm.AutoSendTimerTimer(Sender: TObject);
//label
  //x, y;
begin
  {if ListView1.Items.Count > 0 then
  begin
    x: ;
    ListView1.ItemIndex := autosendind;
    if ListView1.Selected <> nil then
    begin
      if ListView1.Selected.Checked then
      begin
        if autosendind = ListView1.Items.Count - 1 then goto y;
        Inc(autosendind);
        goto x;
      end;
      SpeedButton2Click(self);
      if autosendind = ListView1.Items.Count - 1 then goto y;
      Inc(autosendind);
    end;
  end
  else
  begin
    y: ;
    AutoSendTimer.Enabled := false;
    //
    BitBtn2.Enabled := true;
    BitBtn3.Enabled := false;
    //DAShow(false, '4', '34', EmptyStr, 157, 3, 10000);
  end;}
end;

procedure TIcqSearchForm.SearchBitBtnClick(Sender: TObject);
//var
  //CodeList: TStringList;
  //CountryInd, LangInd, OccupInd, IntInd, PastInd, MaritalInd, OrganInd: integer;
begin
  {if not CheckBox4.Checked then
  begin
    ListView1.Clear;
    Panel7.Caption := '0';
  end;
  //
  case PageControl1.ActivePageIndex of
    0:
      begin
        if (Edit1.Text > EmptyStr) and (CheckBox1.Checked) then
        begin
          Edit1.Text := exNormalizeScreenName(Edit1.Text);
          Edit1.Text := exNormalizeIcqNumber(Edit1.Text);
          if not exIsValidCharactersDigit(Edit1.Text) then
          begin
            Edit1.Clear;
            Exit;
          end;
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoUIN_old_1(Edit1.Text);
          end;
        end;
        //
        if (Edit2.Text > EmptyStr) and (CheckBox2.Checked) then
        begin
          Edit2.Text := exNormalizeScreenName(Edit2.Text);
          Edit2.Text := exNormalizeIcqNumber(Edit2.Text);
          if not exIsValidCharactersDigit(Edit2.Text) then
          begin
            Edit2.Clear;
            Exit;
          end;
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoUIN_old_2(Edit2.Text);
          end;
        end;
        //
        if (Edit3.Text > EmptyStr) and (CheckBox3.Checked) then
        begin
          Edit3.Text := exNormalizeScreenName(Edit3.Text);
          Edit3.Text := exNormalizeIcqNumber(Edit3.Text);
          if not exIsValidCharactersDigit(Edit3.Text) then
          begin
            Edit3.Clear;
            Exit;
          end;
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoUIN_new(Edit3.Text);
          end;
        end;
      end;
    1:
      begin
        if (Edit5.Text > EmptyStr) and (CheckBox6.Checked) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoEmail_old(Edit5.Text, CheckBox5.Checked);
          end;
        end;
        //
        if (Edit6.Text > EmptyStr) and (CheckBox7.Checked) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoEmail_new(Edit6.Text);
          end;
        end;
      end;
    2:
      begin
        if (Edit7.Text > EmptyStr) or (Edit8.Text > EmptyStr) or (Edit9.Text > EmptyStr) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoNick_First_Last(Edit7.Text, Edit8.Text, Edit9.Text, CheckBox5.Checked);
          end;
        end;
      end;
    3:
      begin
        if not ICQ_Work_Phaze then Exit;
        if IsNotNull([Edit12.Text, Edit13.Text, Edit14.Text, Edit10.Text, Edit11.Text,
          ComboBox1.Text, ComboBox2.Text, ComboBox4.Text, ComboBox3.Text,
            ComboBox9.Text, ComboBox5.Text, ComboBox8.Text, Edit15.Text,
            ComboBox6.Text, ComboBox7.Text]) then
        begin
          CodeList := TStringList.Create;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt');
          try
            CountryInd := StrToInt(CodeList.Strings[ComboBox3.ItemIndex]);
          except
            CountryInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt');
          try
            LangInd := StrToInt(CodeList.Strings[ComboBox9.ItemIndex]);
          except
            LangInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt');
          try
            IntInd := StrToInt(CodeList.Strings[ComboBox8.ItemIndex]);
          except
            IntInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt');
          try
            MaritalInd := StrToInt(CodeList.Strings[ComboBox4.ItemIndex]);
          except
            MaritalInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Occupation_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Occupation_codes.txt');
          try
            OccupInd := StrToInt(CodeList.Strings[ComboBox5.ItemIndex]);
          except
            OccupInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Organization_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Organization_codes.txt');
          try
            OrganInd := StrToInt(CodeList.Strings[ComboBox6.ItemIndex]);
          except
            OrganInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Past_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Past_codes.txt');
          try
            PastInd := StrToInt(CodeList.Strings[ComboBox7.ItemIndex]);
          except
            PastInd := 0;
          end;
          CodeList.Free;
          //
          Panel6.Caption := SP2;
          ICQ_SearchByPersonalInfo(Edit12.Text, Edit13.Text, Edit14.Text, Edit10.Text, Edit11.Text,
            ComboBox1.ItemIndex, ComboBox2.ItemIndex, MaritalInd, CountryInd,
            LangInd, OccupInd, IntInd, CheckBox5.Checked,
            Edit15.Text, OrganInd, PastInd);
        end;
      end;
    4:
      begin
        if not ICQ_Work_Phaze then Exit;
        if IsNotNull([ComboBox15.Text, ComboBox16.Text]) then
        begin
          // interest or work
          CodeList := TStringList.Create;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt');
          try
            CountryInd := StrToInt(CodeList.Strings[ComboBox13.ItemIndex]);
          except
            CountryInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt');
          try
            LangInd := StrToInt(CodeList.Strings[ComboBox14.ItemIndex]);
          except
            LangInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt');
          try
            IntInd := StrToInt(CodeList.Strings[ComboBox16.ItemIndex]);
          except
            IntInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt');
          try
            MaritalInd := StrToInt(CodeList.Strings[ComboBox12.ItemIndex]);
          except
            MaritalInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Industry_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Industry_codes.txt');
          try
            OccupInd := StrToInt(CodeList.Strings[ComboBox15.ItemIndex]);
          except
            OccupInd := 0;
          end;
          CodeList.Free;
          //
          Panel6.Caption := SP2;
          ICQ_SearchByPersonalInfo(Edit16.Text, Edit17.Text, Edit18.Text, Edit19.Text, Edit20.Text, ComboBox10.ItemIndex,
            ComboBox11.ItemIndex, MaritalInd, CountryInd, LangInd,
            OccupInd, IntInd, CheckBox5.Checked);
        end
        else
        begin
          if IsNotNull([Edit16.Text, Edit17.Text, Edit18.Text, Edit19.Text,
            Edit20.Text, ComboBox10.Text, ComboBox11.Text, ComboBox12.Text,
              ComboBox13.Text, ComboBox14.Text]) then
          begin
            if sPageInc then Inc(sPage)
            else sPage := 0;
            //
            CodeList := TStringList.Create;
            //
            if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt') then
              CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt');
            try
              CountryInd := StrToInt(CodeList.Strings[ComboBox13.ItemIndex]);
            except
              CountryInd := 0;
            end;
            CodeList.Clear;
            //
            if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt') then
              CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt');
            try
              LangInd := StrToInt(CodeList.Strings[ComboBox14.ItemIndex]);
            except
              LangInd := 0;
            end;
            CodeList.Clear;
            //
            if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt') then
              CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt');
            try
              MaritalInd := StrToInt(CodeList.Strings[ComboBox12.ItemIndex]);
            except
              MaritalInd := 0;
            end;
            CodeList.Clear;
            //
            Panel6.Caption := SP2;
            ICQ_SearchNewBase(Edit16.Text, Edit17.Text, Edit18.Text, Edit19.Text, Edit20.Text, ComboBox10.ItemIndex,
              ComboBox11.ItemIndex, MaritalInd, CountryInd, LangInd, sPage,
              CheckBox5.Checked);
            sPageInc := false;
          end;
        end;
      end;
    5:
      begin
        if (Edit21.Text > EmptyStr) and (CheckBox8.Checked) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoText(Edit21.Text, CheckBox5.Checked);
          end;
        end;
        //
        if CheckBox9.Checked then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoChatGroup(ComboBox17.ItemIndex + 1);
          end;
        end;
      end;
  end;}
end;

procedure TIcqSearchForm.BitBtn2Click(Sender: TObject);
begin
  {if ListView1.Items.Count > 0 then
  begin
    autosendind := 0;
    if (Edit23.Text = EmptyStr) or (Edit23.Text = '0') then Edit23.Text := '60';
    AutoSendTimer.Interval := StrToInt(Edit23.Text) * 1000;
    AutoSendTimer.Enabled := true;
    //
    BitBtn2.Enabled := false;
    BitBtn3.Enabled := true;
  end
  else
  begin
    AutoSendTimer.Enabled := false;
  end;}
end;

procedure TIcqSearchForm.SearchNextPageBitBtnClick(Sender: TObject);
begin
  sPageInc := true;
  SearchBitBtnClick(self);
end;

procedure TIcqSearchForm.Edit23KeyPress(Sender: TObject; var Key: Char);
const
  ValidAsciiChars = ['0'..'9'];
begin
  if (not (Key in ValidAsciiChars)) and (Key <> #8) then Key := #0;
end;

procedure TIcqSearchForm.QMessageEditEnter(Sender: TObject);
var
  FOptions: TFontStyles;
begin
  //--Сбрасываем текст в поле быстрых сообщений
  with QMessageEdit do
  begin
    if Tag = 1 then
    begin
      Clear;
      FOptions := [];
      Font.Style := FOptions;
      Tag := 0;
    end;
  end;
end;

procedure TIcqSearchForm.QMessageEditExit(Sender: TObject);
var
  FOptions: TFontStyles;
begin
  //--
  with QMessageEdit do
  begin
    if Text = EmptyStr then
    begin
      FOptions := [];
      Include(FOptions, fsBold);
      Font.Style := FOptions;
      Text := ' ' + QmessT;
      Tag := 1;
    end;
  end;
end;

procedure TIcqSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Выводим окно списка контактов на передний план
  BringWindowToTop(MainForm.Handle);
end;

procedure TIcqSearchForm.FormCreate(Sender: TObject);
begin
  //--Инициализируем XML
  with TrXML.Create() do
  try
    //--Загружаем настройки
    if FileExists(ProfilePath + SettingsFileName) then
    begin
      LoadFromFile(ProfilePath + SettingsFileName);
      //--Загружаем позицию окна
      if OpenKey('settings\forms\icqsearchform\position') then
      try
        Top := ReadInteger('top');
        Left := ReadInteger('left');
        //--Определяем не находится ли окно за пределами экрана
        MainForm.FormSetInWorkArea(self);
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
  //--Переводим форму на другие языки
  TranslateForm;
  //--Устанавливаем иконки на форму и кнопки
  MainForm.AllImageList.GetIcon(235, Icon);
  MainForm.AllImageList.GetBitmap(221, SearchBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(159, ResultClearSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(239, SendQMessageSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, SearchNextPageBitBtn.Glyph);
  //--Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //--Делаем окно прилипающим к краям экрана
  ScreenSnap := true;
end;

procedure TIcqSearchForm.FormDestroy(Sender: TObject);
begin
  //--Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile');
  //--Сохраняем настройки положения окна в xml
  with TrXML.Create() do
  try
    if FileExists(ProfilePath + SettingsFileName) then LoadFromFile(ProfilePath + SettingsFileName);
    //--Сохраняем позицию окна
    if OpenKey('settings\forms\icqsearchform\position', True) then
    try
      WriteInteger('top', Top);
      WriteInteger('left', Left);
    finally
      CloseKey();
    end;
    //--Записываем сам файл
    SaveToFile(ProfilePath + SettingsFileName);
  finally
    Free();
  end;
end;

procedure TIcqSearchForm.ICQStatusCheckSMClick(Sender: TObject);
begin
  //if ListView1.Selected <> nil then
  //  ICQ_ReqStatus0215(ListView1.Selected.Caption);
end;

procedure TIcqSearchForm.AccountNameCopySMClick(Sender: TObject);
begin
  //if ListView1.Selected <> nil then
  //  SetClipboardText(Handle, ListView1.Selected.Caption);
end;

procedure TIcqSearchForm.SendMessageSMClick(Sender: TObject);
{var
  i, ii, G, T: integer;
  NoCLG: boolean;
  Nick: string;}
begin
  {if ListView1.Selected <> nil then
  begin
    NoCLG := false;
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
      begin
        if RoasterForm.CategoryButtons1.Categories[i].Items[ii].UIN = ListView1.Selected.Caption then
        begin
          RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[ii]);
          RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[ii]);
          Exit;
        end;
      end;
    end;
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].GroupId = 'NoCL' then NoCLG := true;
    end;
    if not NoCLG then
    begin
      RoasterForm.CategoryButtons1.Categories.Add.Caption := RoasterForm.NoInListGroupCaption;
      G := RoasterForm.CategoryButtons1.Categories.Count - 1;
      RoasterForm.CategoryButtons1.Categories.Items[G].GroupId := 'NoCL';
      RoasterForm.CategoryButtons1.Categories.Items[G].GroupCaption := RoasterForm.NoInListGroupCaption;
    end;
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].GroupId = 'NoCL' then
      begin
        Nick := ListView1.Selected.SubItems.Strings[0];
        if Nick = EmptyStr then Nick := ListView1.Selected.Caption;
        RoasterForm.CategoryButtons1.Categories[i].Items.Add.Caption := Nick;
        T := RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].UIN := ListView1.Selected.Caption;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].GroupId := 'NoCL';
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Hint := '<b>' + ListView1.Selected.Caption + '</b>';
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Status := 34;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].ImageIndex := 34;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].ImageIndex1 := -1;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].ImageIndex2 := -1;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Msg := false;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Auth := true;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].QuoteMsg := EmptyStr;
        //RoasterForm.CategoryButtons1.Categories[i].Items[T].Index := 0;
        //
        RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[T]);
        RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[T]);
      end;
    end;
  end;}
end;

procedure TIcqSearchForm.ContactInfoSMClick(Sender: TObject);
begin
  {if ListView1.Selected <> nil then
  begin
    if Assigned(IcqContactInfoForm) then
    begin
      if IcqContactInfoForm.ReqUIN <> ListView1.Selected.Caption then
      begin
        IcqContactInfoForm.ReqUIN := ListView1.Selected.Caption;
        IcqContactInfoForm.LoadUserUnfo();
      end;
      ShowWindow(IcqContactInfoForm.Handle, SW_RESTORE);
      IcqContactInfoForm.Show;
      IcqContactInfoForm.ButtonGroup1.ItemIndex := 0;
      IcqContactInfoForm.JvPageList1.ActivePageIndex := 0;
    end
    else
    begin
      IcqContactInfoForm := TIcqContactInfoForm.Create(self);
      IcqContactInfoForm.ReqUIN := ListView1.Selected.Caption;
      IcqContactInfoForm.LoadUserUnfo();
      IcqContactInfoForm.Show;
    end;
  end;}
end;

procedure TIcqSearchForm.AddContactInCLSMClick(Sender: TObject);
//var
  //i: integer;
  //frmAddCnt: TIcqAddContactForm;
begin
  {frmAddCnt := TIcqAddContactForm.Create(nil);
  try
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories.Items[i].GroupId = '0000' then Continue;
      if RoasterForm.CategoryButtons1.Categories.Items[i].GroupId = 'NoCL' then Continue;
      frmAddCnt.ComboBox1.Items.Add(RoasterForm.CategoryButtons1.Categories.Items[i].GroupCaption);
    end;
    if frmAddCnt.ComboBox1.Items.Count > 0 then frmAddCnt.ComboBox1.ItemIndex := 0;
    frmAddCnt.Edit1.Text := ListView1.Selected.Caption;
    frmAddCnt.Edit2.Text := ListView1.Selected.SubItems.Strings[0];
    frmAddCnt.ShowModal;
  finally
    FreeAndNil(frmAddCnt);
  end;}
end;

procedure TIcqSearchForm.SearchResultJvListViewChanging(Sender: TObject;
  Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin
  //Panel7.Caption := IntToStr(ListView1.Items.Count);
end;

procedure TIcqSearchForm.SearchResultJvListViewColumnClick(Sender: TObject;
  Column: TListColumn);
var
  i: integer;
begin
  //--Сбрасываем стрелочки сортировки в других столбцах
  for i := 0 to SearchResultJvListView.Columns.Count - 1 do
    SearchResultJvListView.Columns[i].ImageIndex := -1;
  if (Column.Index = 0) or (Column.Index = 1) or (Column.Index = 8) then Exit;
  //--Выставляем стрелочку сортировки
  if Column.ImageIndex <> 234 then Column.ImageIndex := 234
  else Column.ImageIndex := 233;
end;

procedure TIcqSearchForm.SearchResultJvListViewContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if SearchResultJvListView.Selected <> nil then Handled := false
  else Handled := true;
end;

procedure TIcqSearchForm.SearchResultJvListViewGetImageIndex(Sender: TObject;
  Item: TListItem);
begin
  Item.ImageIndex := 237;
end;

procedure TIcqSearchForm.SearchResultJvListViewGetSubItemImage(Sender: TObject;
  Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
begin
  if SubItem = 0 then ImageIndex := 238;
  if Item.Checked then
  begin
    if SubItem = 7 then ImageIndex := 240;
  end
  else
  begin
    if SubItem = 7 then ImageIndex := 239;
  end;
end;

procedure TIcqSearchForm.SearchResultJvListViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//var
//  ocw, fcw: integer;
begin
  {if Button = mbLeft then
  begin
    if ListView1.Selected <> nil then
    begin
      ocw := ListView1.Column[0].Width + ListView1.Column[1].Width + ListView1.Column[2].Width +
        ListView1.Column[3].Width + ListView1.Column[4].Width + ListView1.Column[5].Width;
      fcw := ocw + ListView1.Column[6].Width;
      if (X > ocw) and (X < fcw) then SpeedButton2Click(Self);
    end;
  end;    }
end;

procedure TIcqSearchForm.ResultClearSpeedButtonClick(Sender: TObject);
begin
  //ListView1.Clear;
  //Panel7.Caption := '0';
end;

procedure TIcqSearchForm.SendQMessageSpeedButtonClick(Sender: TObject);
begin
  {if ListView1.Selected <> nil then
  begin
    if ListView1.Selected.Checked then Exit;
    if (Edit4.Tag = 1) or (Edit4.Text = EmptyStr) then Exit;
    if ICQ_Work_Phaze then
    begin
      ICQ_SendMessage_0406(ListView1.Selected.Caption, Edit4.Text, true);
      ListView1.Selected.Checked := true;
    end;
  end;}
end;

end.

