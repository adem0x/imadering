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
    UINSearchEdit: TEdit;
    EmailSearchCheckBox: TCheckBox;
    EmailSearchEdit: TEdit;
    KeyWordSearchCheckBox: TCheckBox;
    KeyWordSearchEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QMessageEditEnter(Sender: TObject);
    procedure QMessageEditExit(Sender: TObject);
    procedure SearchBitBtnClick(Sender: TObject);
    procedure ResultClearSpeedButtonClick(Sender: TObject);
    procedure SendQMessageSpeedButtonClick(Sender: TObject);
    procedure SearchNextPageBitBtnClick(Sender: TObject);
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
    procedure UINSearchEditChange(Sender: TObject);
    procedure EmailSearchEditChange(Sender: TObject);
    procedure KeyWordSearchEditChange(Sender: TObject);
    procedure NickEditChange(Sender: TObject);
    procedure UINSearchCheckBoxClick(Sender: TObject);
    procedure EmailSearchCheckBoxClick(Sender: TObject);
    procedure KeyWordSearchCheckBoxClick(Sender: TObject);
    procedure GlobalSearchCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    QmessT: string;
    //sPage: word;
    sPageInc: boolean;
    //autosendind: integer;
    function GetColimnAtX(X: integer): integer;
    procedure OpenAnketa;
    procedure OpenChatResult;
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  IcqSearchForm: TIcqSearchForm;

implementation

uses MainUnit, IcqProtoUnit, UtilsUnit, IcqAddContactUnit, IcqContactInfoUnit,
  IcqOptionsUnit, RosterUnit;

{$R *.dfm}

procedure TIcqSearchForm.OpenAnketa;
begin
  if not Assigned(IcqContactInfoForm) then IcqContactInfoForm := TIcqContactInfoForm.Create(self);
  //--Присваиваем UIN инфу которого хотим смотреть
  IcqContactInfoForm.ReqUIN := SearchResultJvListView.Selected.SubItems[1];
  //--Загружаем информацию о нем
  IcqContactInfoForm.LoadUserUnfo;
  //--Отображаем окно
  xShowForm(IcqContactInfoForm);
end;

procedure TIcqSearchForm.OpenChatResult;
var
  RosterItem: TListItem;
begin
  //--Ищем группу "Не в списке" в Ростере
  RosterItem := RosterForm.ReqRosterItem('NoCL');
  if RosterItem = nil then //--Если группу не нашли
  begin
    //--Добавляем такую группу в Ростер
    RosterItem := RosterForm.RosterJvListView.Items.Add;
    RosterItem.Caption := 'NoCL';
    //--Подготавиливаем все значения
    RosterForm.RosterItemSetFull(RosterItem);
    RosterItem.SubItems[1] := NoInListGroupCaption;
  end;
  //--Добавляем этот контакт в Ростер
  RosterItem := RosterForm.RosterJvListView.Items.Add;
  with RosterItem do
  begin
    Caption := SearchResultJvListView.Selected.SubItems[1];
    //--Подготавиливаем все значения
    RosterForm.RosterItemSetFull(RosterItem);
    //--Обновляем субстроки
    SubItems[0] := SearchResultJvListView.Selected.SubItems[2];
    SubItems[1] := 'NoCL';
    SubItems[2] := 'none';
    SubItems[3] := 'Icq';
    SubItems[6] := '214';
    SubItems[35] := '0';
  end;
  //--Открываем чат с этим контактом
  RosterForm.OpenChatPage(SearchResultJvListView.Selected.SubItems[1]);
end;

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

procedure TIcqSearchForm.UINSearchCheckBoxClick(Sender: TObject);
begin
  //--Активируем поиск по UIN
  if UINSearchCheckBox.Checked then
  begin
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.UINSearchEditChange(Sender: TObject);
begin
  //--Активируем поиск по UIN
  if not UINSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := true;
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.SearchBitBtnClick(Sender: TObject);
var
  i, CountryInd, LangInd, OccupInd, IntInd, MaritalInd: integer;
begin
  //--Сбрасываем стрелочки сортировки во всех столбцах
  for i := 0 to SearchResultJvListView.Columns.Count - 1 do
    SearchResultJvListView.Columns[i].ImageIndex := -1;
  //--Если не стоит галочка "Не очищать предыдущие резульаты", то стираем их
  if not NotPreviousClearCheckBox.Checked then
  begin
    SearchResultJvListView.Clear;
    ResultPanel.Caption := '0';
  end;
  //--Ищем по ICQ UIN
  if (UINSearchCheckBox.Checked) and (UINSearchEdit.Text <> EmptyStr) then
  begin
    //--Нормализуем UIN
    UINSearchEdit.Text := exNormalizeScreenName(UINSearchEdit.Text);
    UINSearchEdit.Text := exNormalizeIcqNumber(UINSearchEdit.Text);
    if not exIsValidCharactersDigit(UINSearchEdit.Text) then
    begin
      UINSearchEdit.Clear;
      Exit;
    end;
    if ICQ_Work_Phaze then
    begin
      StatusPanel.Caption := SearchInfoGoL;
      ICQ_SearchPoUIN_new(UINSearchEdit.Text);
    end;
  end
  //--Ищем по Email
  else if (EmailSearchCheckBox.Checked) and (EmailSearchEdit.Text <> EmptyStr) then
  begin
    if ICQ_Work_Phaze then
    begin
      StatusPanel.Caption := SearchInfoGoL;
      ICQ_SearchPoEmail_new(EmailSearchEdit.Text);
    end;
  end
  //--Ищем по ключевым словам
  else if (KeyWordSearchCheckBox.Checked) and (KeyWordSearchEdit.Text <> EmptyStr) then
  begin
    if ICQ_Work_Phaze then
    begin
      StatusPanel.Caption := SearchInfoGoL;
      ICQ_SearchPoText_new(KeyWordSearchEdit.Text, OnlyOnlineCheckBox.Checked);
    end;
  end
  //--Ищем по расширенным параметрам
  else if GlobalSearchCheckBox.Checked then
  begin
    if ICQ_Work_Phaze then
    begin
      //--Ищем старым способом если выбрана провессия или интересы
      if IsNotNull([ProfComboBox.Text, InterestComboBox.Text]) then
      begin

      end
      //--Ищем новым способом
      else if IsNotNull([NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text,
        KeyWordEdit.Text, GenderComboBox.Text, AgeComboBox.Text, MaritalComboBox.Text,
          CountryComboBox.Text, LangComboBox.Text]) then
      begin

      end;
    end;
  end;



{
    4:
      begin

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
  end;}
end;

procedure TIcqSearchForm.SearchNextPageBitBtnClick(Sender: TObject);
begin
  sPageInc := true;
  SearchBitBtnClick(self);
end;

procedure TIcqSearchForm.EmailSearchCheckBoxClick(Sender: TObject);
begin
  //--Активируем поиск по Email
  if EmailSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.EmailSearchEditChange(Sender: TObject);
begin
  //--Активируем поиск по Email
  if not EmailSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := true;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
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
  //--Уничтожаем окно
  SearchResultJvListView.HeaderImages := nil;
  Action := caFree;
  IcqSearchForm := nil;
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

procedure TIcqSearchForm.GlobalSearchCheckBoxClick(Sender: TObject);
begin
  //--Активируем глобальный поиск
  if GlobalSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.ICQStatusCheckSMClick(Sender: TObject);
begin
  //--Проверяем статус
  if SearchResultJvListView.Selected <> nil then
    ICQ_ReqStatus0215(SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TIcqSearchForm.KeyWordSearchCheckBoxClick(Sender: TObject);
begin
  //--Активируем поиск по ключ. словам
  if KeyWordSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.KeyWordSearchEditChange(Sender: TObject);
begin
  //--Активируем поиск по ключ. словам
  if not KeyWordSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := true;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.NickEditChange(Sender: TObject);
begin
  //--Активируем глобальный поиск
  if not GlobalSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := true;
  end;
end;

procedure TIcqSearchForm.AccountNameCopySMClick(Sender: TObject);
begin
  //--Копируем имя учётной записи в буфер обмена
  if SearchResultJvListView.Selected <> nil then
    SetClipboardText(Handle, SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TIcqSearchForm.SendMessageSMClick(Sender: TObject);
begin
  //--Открываем чат с выбранным контактом
  if SearchResultJvListView.Selected <> nil then OpenChatResult;
end;

procedure TIcqSearchForm.ContactInfoSMClick(Sender: TObject);
begin
  //--Открываем анкету
  if SearchResultJvListView.Selected <> nil then OpenAnketa;
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
  //--Заносим количество найденных в панель
  ResultPanel.Caption := IntToStr(SearchResultJvListView.Items.Count);
end;

procedure TIcqSearchForm.SearchResultJvListViewColumnClick(Sender: TObject;
  Column: TListColumn);
var
  i: integer;
begin
  if (Column.Index = 0) or (Column.Index = 1) or (Column.Index = 8) then
  begin
    //--Сбрасываем стрелочки сортировки во всех столбцах
    for i := 0 to SearchResultJvListView.Columns.Count - 1 do
      SearchResultJvListView.Columns[i].ImageIndex := -1;
    Exit;
  end;
  //--Выставляем стрелочку сортировки
  if Column.ImageIndex <> 234 then Column.ImageIndex := 234
  else Column.ImageIndex := 233;
  //--Сбрасываем стрелочки сортировки в других столбцах
  for i := 0 to SearchResultJvListView.Columns.Count - 1 do
    if SearchResultJvListView.Columns[i] <> Column then SearchResultJvListView.Columns[i].ImageIndex := -1;
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

function TIcqSearchForm.GetColimnAtX(X: integer): integer;
var
  i, RelativeX, ColStartX: Integer;
begin
  Result := 0;
  with SearchResultJvListView do
  begin
    //--Теперь попробуем найти колонку
    RelativeX := X - Selected.Position.X - BorderWidth;
    ColStartX := Columns[0].Width;
    for i := 1 to Columns.Count - 1 do
    begin
      if RelativeX < ColStartX then Break;
      if RelativeX <= ColStartX + Columns[i].Width then
      begin
        Result := i;
        Break;
      end;
      Inc(ColStartX, Columns[i].Width);
    end;
  end;
end;

procedure TIcqSearchForm.SearchResultJvListViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    with SearchResultJvListView do
    begin
      if Selected <> nil then
      begin
        case GetColimnAtX(X) of
          0: OpenAnketa; //--Открываем анкету этого контакта
          1: OpenChatResult; //--Открываем чат с этим контактом
          8: SendQMessageSpeedButtonClick(Self);
        end;
      end;
    end;
  end;
end;

procedure TIcqSearchForm.ResultClearSpeedButtonClick(Sender: TObject);
begin
  //--Очищаем список от результатов
  SearchResultJvListView.Clear;
  ResultPanel.Caption := '0';
end;

procedure TIcqSearchForm.SendQMessageSpeedButtonClick(Sender: TObject);
begin
  with SearchResultJvListView do
  begin
    if Selected <> nil then
    begin
    {if ListView1.Selected.Checked then Exit;
    if (Edit4.Tag = 1) or (Edit4.Text = EmptyStr) then Exit;
    if ICQ_Work_Phaze then
    begin
      ICQ_SendMessage_0406(ListView1.Selected.Caption, Edit4.Text, true);
      ListView1.Selected.Checked := true;
    end;}
    end;
  end;
end;

end.

