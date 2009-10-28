{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqSearchUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Menus, VarsUnit, JvExComCtrls,
  JvListView, rXML;

type
  TIcqSearchForm = class(TForm)
    CenterPanel: TPanel;
    BottomPanel: TPanel;
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
    TopPanel: TPanel;
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
    procedure SearchResultJvListViewContextPopup
      (Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure SearchResultJvListViewGetSubItemImage
      (Sender: TObject; Item: TListItem; SubItem: Integer;
      var ImageIndex: Integer);
    procedure SearchResultJvListViewColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure SearchResultJvListViewGetImageIndex
      (Sender: TObject; Item: TListItem);
    procedure UINSearchEditChange(Sender: TObject);
    procedure EmailSearchEditChange(Sender: TObject);
    procedure KeyWordSearchEditChange(Sender: TObject);
    procedure NickEditChange(Sender: TObject);
    procedure UINSearchCheckBoxClick(Sender: TObject);
    procedure EmailSearchCheckBoxClick(Sender: TObject);
    procedure KeyWordSearchCheckBoxClick(Sender: TObject);
    procedure GlobalSearchCheckBoxClick(Sender: TObject);
    procedure SearchResultJvListViewDblClick(Sender: TObject);
  private
    { Private declarations }
    sPage: word;
    sPageInc: Boolean;
    function GetColimnAtX(X: Integer): Integer;
    procedure OpenAnketa;
    procedure OpenChatResult;
    procedure GlobalSearch;
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

procedure TIcqSearchForm.GlobalSearch;
var
  CountryInd, LangInd, MaritalInd: Integer;
begin
  // Ищем новым способом
  if IsNotNull([NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text,
    KeyWordEdit.Text, GenderComboBox.Text, AgeComboBox.Text,
    MaritalComboBox.Text, CountryComboBox.Text, LangComboBox.Text]) then
  begin
    // Управляем счётчиком страниц
    if sPageInc then
    begin
      Inc(sPage);
      SearchNextPageBitBtn.Caption := Format(SearchNextPage2, [sPage]);
    end
    else
      sPage := 0;
    // Получаем коды из текста
    CountryInd := -1;
    LangInd := -1;
    MaritalInd := -1;
    if Assigned(IcqOptionsForm) then
    begin
      with IcqOptionsForm do
      begin
        // Страна
        if CountryComboBox.ItemIndex > 0 then
          CountryInd := StrToInt(CountryCodesComboBox.Items.Strings
              [CountryInfoComboBox.Items.IndexOf(CountryComboBox.Text)]);
        // Язык
        if LangComboBox.ItemIndex > 0 then
          LangInd := StrToInt
            (LangsCodeComboBox.Items.Strings[Lang1InfoComboBox.Items.IndexOf
              (LangComboBox.Text)]);
        // Брак
        if MaritalComboBox.ItemIndex > 0 then
          MaritalInd := StrToInt(MaritalCodesComboBox.Items.Strings
              [PersonalMaritalInfoComboBox.Items.IndexOf(MaritalComboBox.Text)]
            );
      end;
    end;
    // Начинаем поиск
    StatusPanel.Caption := SearchInfoGoL;
    ICQ_SearchNewBase(NickEdit.Text, NameEdit.Text, FamilyEdit.Text,
      CityEdit.Text, KeyWordEdit.Text, GenderComboBox.ItemIndex,
      AgeComboBox.ItemIndex, MaritalInd, CountryInd, LangInd, sPage,
      OnlyOnlineCheckBox.Checked);
  end;
end;

procedure TIcqSearchForm.OpenAnketa;
begin
  if not Assigned(IcqContactInfoForm) then
    IcqContactInfoForm := TIcqContactInfoForm.Create(self);
  // Присваиваем UIN инфу которого хотим смотреть
  IcqContactInfoForm.ReqUIN := SearchResultJvListView.Selected.SubItems[1];
  IcqContactInfoForm.ReqProto := 'Icq';
  // Загружаем информацию о нем
  IcqContactInfoForm.LoadUserUnfo;
  // Отображаем окно
  xShowForm(IcqContactInfoForm);
end;

procedure TIcqSearchForm.OpenChatResult;
var
  RosterItem: TListItem;
begin
  // Ищем группу "Не в списке" в Ростере
  RosterItem := RosterForm.ReqRosterItem('NoCL');
  if RosterItem = nil then // Если группу не нашли
  begin
    // Добавляем такую группу в Ростер
    RosterItem := RosterForm.RosterJvListView.Items.Add;
    RosterItem.Caption := 'NoCL';
    // Подготавиливаем все значения
    RosterForm.RosterItemSetFull(RosterItem);
    RosterItem.SubItems[1] := NoInListGroupCaption;
  end;
  // Добавляем этот контакт в Ростер
  RosterItem := RosterForm.RosterJvListView.Items.Add;
  with RosterItem do
  begin
    Caption := SearchResultJvListView.Selected.SubItems[1];
    // Подготавиливаем все значения
    RosterForm.RosterItemSetFull(RosterItem);
    // Обновляем субстроки
    SubItems[0] := SearchResultJvListView.Selected.SubItems[2];
    SubItems[1] := 'NoCL';
    SubItems[2] := 'none';
    SubItems[3] := 'Icq';
    SubItems[6] := '214';
    SubItems[35] := '0';
  end;
  // Открываем чат с этим контактом
  //RosterForm.OpenChatPage(SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TIcqSearchForm.TranslateForm;
begin
  // Присваиваем списки комбобоксам
  if Assigned(IcqOptionsForm) then
  begin
    with IcqOptionsForm do
    begin
      // Присваиваем Брак
      MaritalComboBox.Items.Assign(PersonalMaritalInfoComboBox.Items);
      SetCustomWidthComboBox(MaritalComboBox);
      // Присваиваем Страну
      CountryComboBox.Items.Assign(CountryInfoComboBox.Items);
      SetCustomWidthComboBox(CountryComboBox);
      // Присваиваем Язык
      LangComboBox.Items.Assign(Lang1InfoComboBox.Items);
      SetCustomWidthComboBox(LangComboBox);
    end;
  end;
  // Переводим форму на другие языки

end;

procedure TIcqSearchForm.UINSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по UIN
  if UINSearchCheckBox.Checked then
  begin
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.UINSearchEditChange(Sender: TObject);
begin
  // Активируем поиск по UIN
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
  i: Integer;
begin
  // Сбрасываем стрелочки сортировки во всех столбцах
  for i := 0 to SearchResultJvListView.Columns.Count - 1 do
    SearchResultJvListView.Columns[i].ImageIndex := -1;
  // Если не стоит галочка "Не очищать предыдущие резульаты", то стираем их
  if not NotPreviousClearCheckBox.Checked then
  begin
    SearchResultJvListView.Clear;
    ResultPanel.Caption := '0';
  end;
  // Ищем по ICQ UIN
  if (UINSearchCheckBox.Checked) and (UINSearchEdit.Text <> EmptyStr) then
  begin
    // Нормализуем UIN
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
  // Ищем по Email
  else if (EmailSearchCheckBox.Checked) and (EmailSearchEdit.Text <> EmptyStr)
    then
  begin
    if ICQ_Work_Phaze then
    begin
      StatusPanel.Caption := SearchInfoGoL;
      ICQ_SearchPoEmail_new(EmailSearchEdit.Text);
    end;
  end
  // Ищем по ключевым словам
  else if (KeyWordSearchCheckBox.Checked) and
    (KeyWordSearchEdit.Text <> EmptyStr) then
  begin
    if ICQ_Work_Phaze then
    begin
      StatusPanel.Caption := SearchInfoGoL;
      ICQ_SearchPoText_new(KeyWordSearchEdit.Text, OnlyOnlineCheckBox.Checked);
    end;
  end
  // Ищем по расширенным параметрам
  else if GlobalSearchCheckBox.Checked then
  begin
    if ICQ_Work_Phaze then
    begin
      // Сбрасываем кнопку листания страниц в результатов
      sPageInc := false;
      SearchNextPageBitBtn.Caption := SearchNextPage1;
      // Ищем
      GlobalSearch;
    end;
  end;
end;

procedure TIcqSearchForm.SearchNextPageBitBtnClick(Sender: TObject);
begin
  // Начинаем листать страницы
  sPageInc := true;
  GlobalSearch;
end;

procedure TIcqSearchForm.EmailSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по Email
  if EmailSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.EmailSearchEditChange(Sender: TObject);
begin
  // Активируем поиск по Email
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
  // Сбрасываем текст в поле быстрых сообщений
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
  // Восстанавливаем
  with QMessageEdit do
  begin
    if Text = EmptyStr then
    begin
      FOptions := [];
      Include(FOptions, fsBold);
      Font.Style := FOptions;
      Text := ' ' + SearchQMessL;
      Tag := 1;
    end;
  end;
end;

procedure TIcqSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим окно списка контактов на передний план
  BringWindowToTop(MainForm.Handle);
  // Уничтожаем окно
  SearchResultJvListView.HeaderImages := nil;
  Action := caFree;
  IcqSearchForm := nil;
end;

procedure TIcqSearchForm.FormCreate(Sender: TObject);
begin
  // Инициализируем XML
  with TrXML.Create() do
    try
      // Загружаем настройки
      if FileExists(ProfilePath + SettingsFileName) then
      begin
        LoadFromFile(ProfilePath + SettingsFileName);
        // Загружаем позицию окна
        if OpenKey('settings\forms\icqsearchform\position') then
          try
            Top := ReadInteger('top');
            Left := ReadInteger('left');
            // Определяем не находится ли окно за пределами экрана
            MainForm.FormSetInWorkArea(self);
          finally
            CloseKey();
          end;
      end;
    finally
      Free();
    end;
  // Переводим форму на другие языки
  TranslateForm;
  // Устанавливаем иконки на форму и кнопки
  MainForm.AllImageList.GetIcon(235, Icon);
  MainForm.AllImageList.GetBitmap(221, SearchBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(159, ResultClearSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(239, SendQMessageSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, SearchNextPageBitBtn.Glyph);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE)
      or WS_EX_APPWINDOW);
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := true;
end;

procedure TIcqSearchForm.FormDestroy(Sender: TObject);
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile');
  // Сохраняем настройки положения окна в xml
  with TrXML.Create() do
    try
      if FileExists(ProfilePath + SettingsFileName) then
        LoadFromFile(ProfilePath + SettingsFileName);
      // Сохраняем позицию окна
      if OpenKey('settings\forms\icqsearchform\position', true) then
        try
          WriteInteger('top', Top);
          WriteInteger('left', Left);
        finally
          CloseKey();
        end;
      // Записываем сам файл
      SaveToFile(ProfilePath + SettingsFileName);
    finally
      Free();
    end;
end;

procedure TIcqSearchForm.GlobalSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем глобальный поиск
  if GlobalSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := false;
    KeyWordSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.ICQStatusCheckSMClick(Sender: TObject);
begin
  // Проверяем статус
  if SearchResultJvListView.Selected <> nil then
    ICQ_ReqStatus0215(SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TIcqSearchForm.KeyWordSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по ключ. словам
  if KeyWordSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := false;
    EmailSearchCheckBox.Checked := false;
    GlobalSearchCheckBox.Checked := false;
  end;
end;

procedure TIcqSearchForm.KeyWordSearchEditChange(Sender: TObject);
begin
  // Активируем поиск по ключ. словам
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
  // Активируем глобальный поиск
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
  // Копируем имя учётной записи в буфер обмена
  if SearchResultJvListView.Selected <> nil then
    SetClipboardText(Handle, SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TIcqSearchForm.SendMessageSMClick(Sender: TObject);
begin
  // Открываем чат с выбранным контактом
  if SearchResultJvListView.Selected <> nil then
    OpenChatResult;
end;

procedure TIcqSearchForm.ContactInfoSMClick(Sender: TObject);
begin
  // Открываем анкету
  if SearchResultJvListView.Selected <> nil then
    OpenAnketa;
end;

procedure TIcqSearchForm.AddContactInCLSMClick(Sender: TObject);
var
  frmAddCnt: TIcqAddContactForm;
begin
  // Создаём окно добавления контакта в КЛ
  frmAddCnt := TIcqAddContactForm.Create(self);
  try
    with frmAddCnt do
    begin
      // Составляем список групп из Ростера
      BuildGroupList('Icq');
      // Заносим имя учётной записи
      AccountEdit.Text := SearchResultJvListView.Selected.SubItems[1];
      AccountEdit.ReadOnly := true;
      AccountEdit.Color := clBtnFace;
      // Заносим имя учётной записи
      if SearchResultJvListView.Selected.SubItems[2] = EmptyStr then
        NameEdit.Text := SearchResultJvListView.Selected.SubItems[1]
      else
        NameEdit.Text := SearchResultJvListView.Selected.SubItems[2];
      // Заполняем протокол контакта
      ContactType := 'Icq';
      // Отображаем окно модально
      ShowModal;
    end;
  finally
    FreeAndNil(frmAddCnt);
  end;
end;

procedure TIcqSearchForm.SearchResultJvListViewChanging
  (Sender: TObject; Item: TListItem; Change: TItemChange;
  var AllowChange: Boolean);
begin
  // Заносим количество найденных в панель
  ResultPanel.Caption := IntToStr(SearchResultJvListView.Items.Count);
end;

procedure TIcqSearchForm.SearchResultJvListViewColumnClick
  (Sender: TObject; Column: TListColumn);
var
  i: Integer;
begin
  if (Column.Index = 0) or (Column.Index = 1) or (Column.Index = 8) then
  begin
    // Сбрасываем стрелочки сортировки во всех столбцах
    for i := 0 to SearchResultJvListView.Columns.Count - 1 do
      SearchResultJvListView.Columns[i].ImageIndex := -1;
    Exit;
  end;
  // Выставляем стрелочку сортировки
  if Column.ImageIndex <> 234 then
    Column.ImageIndex := 234
  else
    Column.ImageIndex := 233;
  // Сбрасываем стрелочки сортировки в других столбцах
  for i := 0 to SearchResultJvListView.Columns.Count - 1 do
    if SearchResultJvListView.Columns[i] <> Column then
      SearchResultJvListView.Columns[i].ImageIndex := -1;
end;

procedure TIcqSearchForm.SearchResultJvListViewContextPopup
  (Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  if SearchResultJvListView.Selected <> nil then
    Handled := false
  else
    Handled := true;
end;

procedure TIcqSearchForm.SearchResultJvListViewDblClick(Sender: TObject);
begin
  // Выводим диалог добавления контакта в список контактов
  AddContactInCLSMClick(self);
end;

procedure TIcqSearchForm.SearchResultJvListViewGetImageIndex
  (Sender: TObject; Item: TListItem);
begin
  // Ставим иконку просмотра анкеты о контакте
  Item.ImageIndex := 237;
end;

procedure TIcqSearchForm.SearchResultJvListViewGetSubItemImage
  (Sender: TObject; Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
begin
  // Ставим иконку открытия чата с этим контактом
  if SubItem = 0 then
    ImageIndex := 238;
  // Ставим иконки отправки быстрых сообщений
  if Item.Checked then
  begin
    if SubItem = 7 then
      ImageIndex := 240;
  end
  else
  begin
    if SubItem = 7 then
      ImageIndex := 239;
  end;
end;

function TIcqSearchForm.GetColimnAtX(X: Integer): Integer;
var
  i, RelativeX, ColStartX: Integer;
begin
  Result := 0;
  with SearchResultJvListView do
  begin
    // Теперь попробуем найти колонку
    RelativeX := X - Selected.Position.X - BorderWidth;
    ColStartX := Columns[0].Width;
    for i := 1 to Columns.Count - 1 do
    begin
      if RelativeX < ColStartX then
        Break;
      if RelativeX <= ColStartX + Columns[i].Width then
      begin
        Result := i;
        Break;
      end;
      Inc(ColStartX, Columns[i].Width);
    end;
  end;
end;

procedure TIcqSearchForm.SearchResultJvListViewMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    with SearchResultJvListView do
    begin
      if Selected <> nil then
      begin
        case GetColimnAtX(X) of
          0:
            OpenAnketa; // Открываем анкету этого контакта
          1:
            OpenChatResult; // Открываем чат с этим контактом
          8:
            SendQMessageSpeedButtonClick(self);
        end;
      end;
    end;
  end;
end;

procedure TIcqSearchForm.ResultClearSpeedButtonClick(Sender: TObject);
begin
  // Очищаем список от результатов
  SearchResultJvListView.Clear;
  ResultPanel.Caption := '0';
end;

procedure TIcqSearchForm.SendQMessageSpeedButtonClick(Sender: TObject);
begin
  with SearchResultJvListView do
  begin
    if Selected <> nil then
    begin
      // Если уже отправляли сообщение или оно пустое, то выходим
      if (Selected.Checked) or (QMessageEdit.Tag = 1) or
        (QMessageEdit.Text = EmptyStr) then
        Exit;
      // Отправляем быстрое сообщение этому контакту
      if ICQ_Work_Phaze then
      begin
        ICQ_SendMessage_0406(Selected.SubItems[1], QMessageEdit.Text, true);
        Selected.Checked := true;
      end;
    end;
  end;
end;

end.
