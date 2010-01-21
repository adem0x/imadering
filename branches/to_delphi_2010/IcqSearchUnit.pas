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
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  Buttons,
  Menus,
  VarsUnit,
  JvExComCtrls,
  JvListView,
  ExtDlgs;

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
    CountryLabel: TLabel;
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
    SaveSM: TMenuItem;
    LoadSM: TMenuItem;
    SearchResultSaveDialog: TSaveTextFileDialog;
    LoadSearchResultFileDialog: TOpenTextFileDialog;
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
    procedure SearchResultJvListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SearchResultJvListViewChanging(Sender: TObject; Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
    procedure SearchResultJvListViewGetSubItemImage(Sender: TObject; Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
    procedure SearchResultJvListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure SearchResultJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
    procedure UINSearchEditChange(Sender: TObject);
    procedure EmailSearchEditChange(Sender: TObject);
    procedure KeyWordSearchEditChange(Sender: TObject);
    procedure NickEditChange(Sender: TObject);
    procedure UINSearchCheckBoxClick(Sender: TObject);
    procedure EmailSearchCheckBoxClick(Sender: TObject);
    procedure KeyWordSearchCheckBoxClick(Sender: TObject);
    procedure GlobalSearchCheckBoxClick(Sender: TObject);
    procedure SearchResultJvListViewDblClick(Sender: TObject);
    procedure SearchResultPopupMenuPopup(Sender: TObject);
    procedure LoadSMClick(Sender: TObject);
    procedure SaveSMClick(Sender: TObject);

  private
    { Private declarations }
    SPage: Word;
    SPageInc: Boolean;
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

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  IcqAddContactUnit,
  IcqContactInfoUnit,
  IcqOptionsUnit,
  RosterUnit,
  JvSimpleXml;

{$R *.dfm}

resourcestring
  RS_IcqSearchF = 'icq_search_form';

procedure TIcqSearchForm.GlobalSearch;
var
  CountryInd, LangInd, MaritalInd: Integer;
begin
  // Ищем новым способом
  if IsNotNull([NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text, KeyWordEdit.Text, GenderComboBox.Text, AgeComboBox.Text, MaritalComboBox.Text, CountryComboBox.Text, LangComboBox.Text])
    then
    begin
      // Управляем счётчиком страниц
      if SPageInc then
        begin
          Inc(SPage);
          SearchNextPageBitBtn.Caption := Format(SearchNextPage2, [SPage]);
        end
      else
        SPage := 0;
      // Получаем коды из текста
      CountryInd := -1;
      LangInd := -1;
      MaritalInd := -1;
      with IcqOptionsForm do
        begin
          // Страна
          if CountryComboBox.ItemIndex > 0 then
            CountryInd := StrToInt(IsolateTextString(CountryComboBox.Text, '[', ']'));
          // Язык
          if LangComboBox.ItemIndex > 0 then
            LangInd := StrToInt(IsolateTextString(LangComboBox.Text, '[', ']'));
          // Брак
          if MaritalComboBox.ItemIndex > 0 then
            MaritalInd := StrToInt(IsolateTextString(MaritalComboBox.Text, '[', ']'));
        end;
      // Начинаем поиск
      StatusPanel.Caption := SearchInfoGoL;
      ICQ_SearchNewBase(NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text, KeyWordEdit.Text, GenderComboBox.ItemIndex, AgeComboBox.ItemIndex, MaritalInd, CountryInd, LangInd, SPage,
        OnlyOnlineCheckBox.Checked);
    end;
end;

procedure TIcqSearchForm.OpenAnketa;
begin
  if not Assigned(IcqContactInfoForm) then
    IcqContactInfoForm := TIcqContactInfoForm.Create(Self);
  // Присваиваем UIN инфу которого хотим смотреть
  IcqContactInfoForm.ReqUIN := SearchResultJvListView.Selected.SubItems[1];
  IcqContactInfoForm.ReqProto := S_Icq;
  // Загружаем информацию о нем
  IcqContactInfoForm.LoadUserUnfo;
  // Отображаем окно
  XShowForm(IcqContactInfoForm);
end;

procedure TIcqSearchForm.OpenChatResult;
var
  RosterItem: TListItem;
begin
  // Ищем эту запись в Ростере
  RosterItem := RosterForm.ReqRosterItem(SearchResultJvListView.Selected.SubItems[1]);
  if RosterItem = nil then
    begin
      // Ищем группу "Не в списке" в Ростере
      RosterItem := RosterForm.ReqRosterItem(S_NoCL);
      if RosterItem = nil then // Если группу не нашли
        begin
          // Добавляем такую группу в Ростер
          RosterItem := RosterForm.RosterJvListView.Items.Add;
          RosterItem.Caption := S_NoCL;
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
          if SearchResultJvListView.Selected.SubItems[2] = EmptyStr then
            SubItems[0] := SearchResultJvListView.Selected.SubItems[1]
          else
            SubItems[0] := SearchResultJvListView.Selected.SubItems[2];
          SubItems[1] := S_NoCL;
          SubItems[2] := 'none';
          SubItems[3] := S_Icq;
          SubItems[6] := '214';
          SubItems[35] := '0';
        end;
      // Обновляем КЛ
      RosterForm.UpdateFullCL;
    end;
  // Открываем чат с этим контактом
  RosterForm.OpenChatPage(nil, SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TIcqSearchForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
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
          // Присваиваем Пол
          GenderComboBox.Items.Assign(PersonalGenderInfoComboBox.Items);
          SetCustomWidthComboBox(GenderComboBox);
        end;
    end;
  // Другое
  QMessageEdit.Text := S_SearchQMess;
end;

procedure TIcqSearchForm.UINSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по UIN
  if UINSearchCheckBox.Checked then
    begin
      EmailSearchCheckBox.Checked := False;
      KeyWordSearchCheckBox.Checked := False;
      GlobalSearchCheckBox.Checked := False;
    end;
end;

procedure TIcqSearchForm.UINSearchEditChange(Sender: TObject);
begin
  // Активируем поиск по UIN
  if not UINSearchCheckBox.Checked then
    begin
      UINSearchCheckBox.Checked := True;
      EmailSearchCheckBox.Checked := False;
      KeyWordSearchCheckBox.Checked := False;
      GlobalSearchCheckBox.Checked := False;
    end;
end;

procedure TIcqSearchForm.SaveSMClick(Sender: TObject);
begin
  // Сохраняем результаты поиска в файл
  if SearchResultSaveDialog.Execute then
    SearchResultJvListView.SaveToCSV(SearchResultSaveDialog.FileName);
end;

procedure TIcqSearchForm.SearchBitBtnClick(Sender: TObject);
var
  I: Integer;
begin
  // Сбрасываем стрелочки сортировки во всех столбцах
  for I := 0 to SearchResultJvListView.Columns.Count - 1 do
    SearchResultJvListView.Columns[I].ImageIndex := -1;
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
      UINSearchEdit.Text := ExNormalizeScreenName(UINSearchEdit.Text);
      UINSearchEdit.Text := ExNormalizeIcqNumber(UINSearchEdit.Text);
      if not ExIsValidCharactersDigit(UINSearchEdit.Text) then
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
  else if (EmailSearchCheckBox.Checked) and (EmailSearchEdit.Text <> EmptyStr) then
    begin
      if ICQ_Work_Phaze then
        begin
          StatusPanel.Caption := SearchInfoGoL;
          ICQ_SearchPoEmail_new(EmailSearchEdit.Text);
        end;
    end
    // Ищем по ключевым словам
  else if (KeyWordSearchCheckBox.Checked) and (KeyWordSearchEdit.Text <> EmptyStr) then
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
          SPageInc := False;
          SearchNextPageBitBtn.Caption := SearchNextPage1;
          // Ищем
          GlobalSearch;
        end;
    end;
end;

procedure TIcqSearchForm.SearchNextPageBitBtnClick(Sender: TObject);
begin
  // Начинаем листать страницы
  SPageInc := True;
  GlobalSearch;
end;

procedure TIcqSearchForm.EmailSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по Email
  if EmailSearchCheckBox.Checked then
    begin
      UINSearchCheckBox.Checked := False;
      KeyWordSearchCheckBox.Checked := False;
      GlobalSearchCheckBox.Checked := False;
    end;
end;

procedure TIcqSearchForm.EmailSearchEditChange(Sender: TObject);
begin
  // Активируем поиск по Email
  if not EmailSearchCheckBox.Checked then
    begin
      UINSearchCheckBox.Checked := False;
      EmailSearchCheckBox.Checked := True;
      KeyWordSearchCheckBox.Checked := False;
      GlobalSearchCheckBox.Checked := False;
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
          Include(FOptions, FsBold);
          Font.Style := FOptions;
          Text := BN + S_SearchQMess;
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
  Action := CaFree;
  IcqSearchForm := nil;
end;

procedure TIcqSearchForm.FormCreate(Sender: TObject);
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
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[RS_IcqSearchF];
                if XML_Node <> nil then
                  begin
                    // Загружаем позицию окна
                    Top := XML_Node.Properties.IntValue('t');
                    Left := XML_Node.Properties.IntValue('l');
                    Height := XML_Node.Properties.IntValue('h');
                    Width := XML_Node.Properties.IntValue('w');
                    // Определяем не находится ли окно за пределами экрана
                    MainForm.FormSetInWorkArea(Self);
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
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
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := True;
end;

procedure TIcqSearchForm.FormDestroy(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  // Сохраняем настройки положения окна в xml
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        if Root <> nil then
          begin
            // Очищаем раздел формы если он есть
            XML_Node := Root.Items.ItemNamed[RS_IcqSearchF];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(RS_IcqSearchF);
            // Сохраняем позицию окна
            XML_Node.Properties.Add('t', Top);
            XML_Node.Properties.Add('l', Left);
            XML_Node.Properties.Add('h', Height);
            XML_Node.Properties.Add('w', Width);
            // Записываем сам файл
            SaveToFile(ProfilePath + SettingsFileName);
          end;
      end;
  finally
    JvXML.Free;
  end;
end;

procedure TIcqSearchForm.GlobalSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем глобальный поиск
  if GlobalSearchCheckBox.Checked then
    begin
      UINSearchCheckBox.Checked := False;
      EmailSearchCheckBox.Checked := False;
      KeyWordSearchCheckBox.Checked := False;
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
      UINSearchCheckBox.Checked := False;
      EmailSearchCheckBox.Checked := False;
      GlobalSearchCheckBox.Checked := False;
    end;
end;

procedure TIcqSearchForm.KeyWordSearchEditChange(Sender: TObject);
begin
  // Активируем поиск по ключ. словам
  if not KeyWordSearchCheckBox.Checked then
    begin
      UINSearchCheckBox.Checked := False;
      EmailSearchCheckBox.Checked := False;
      KeyWordSearchCheckBox.Checked := True;
      GlobalSearchCheckBox.Checked := False;
    end;
end;

procedure TIcqSearchForm.LoadSMClick(Sender: TObject);
begin
  // Загружаем результаты поиска из файла
  SearchResultJvListView.Clear;
  if LoadSearchResultFileDialog.Execute then
    SearchResultJvListView.LoadFromCSV(LoadSearchResultFileDialog.FileName);
end;

procedure TIcqSearchForm.NickEditChange(Sender: TObject);
begin
  // Активируем глобальный поиск
  if not GlobalSearchCheckBox.Checked then
    begin
      UINSearchCheckBox.Checked := False;
      EmailSearchCheckBox.Checked := False;
      KeyWordSearchCheckBox.Checked := False;
      GlobalSearchCheckBox.Checked := True;
    end;
end;

procedure TIcqSearchForm.AccountNameCopySMClick(Sender: TObject);
begin
  // Копируем имя учётной записи в буфер обмена
  if SearchResultJvListView.Selected <> nil then
    SetClipboardText(SearchResultJvListView.Selected.SubItems[1]);
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
{ var
  FrmAddCnt: TIcqAddContactForm; }
begin
  // Создаём окно добавления контакта в КЛ
  { FrmAddCnt := TIcqAddContactForm.Create(Self);
    try
    with FrmAddCnt do
    begin
    // Составляем список групп из Ростера
    BuildGroupList(S_Icq);
    // Заносим имя учётной записи
    AccountEdit.Text := SearchResultJvListView.Selected.SubItems[1];
    AccountEdit.readonly := True;
    AccountEdit.Color := ClBtnFace;
    // Заносим имя учётной записи
    if SearchResultJvListView.Selected.SubItems[2] = EmptyStr then
    NameEdit.Text := SearchResultJvListView.Selected.SubItems[1]
    else
    NameEdit.Text := SearchResultJvListView.Selected.SubItems[2];
    // Заполняем протокол контакта
    ContactType := S_Icq;
    // Отображаем окно модально
    ShowModal;
    end;
    finally
    FreeAndNil(FrmAddCnt);
    end; }
end;

procedure TIcqSearchForm.SearchResultJvListViewChanging(Sender: TObject; Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin
  // Заносим количество найденных в панель
  ResultPanel.Caption := IntToStr(SearchResultJvListView.Items.Count);
end;

procedure TIcqSearchForm.SearchResultJvListViewColumnClick(Sender: TObject; Column: TListColumn);
var
  I: Integer;
begin
  if (Column.index = 0) or (Column.index = 1) or (Column.index = 8) then
    begin
      // Сбрасываем стрелочки сортировки во всех столбцах
      for I := 0 to SearchResultJvListView.Columns.Count - 1 do
        SearchResultJvListView.Columns[I].ImageIndex := -1;
      Exit;
    end;
  // Выставляем стрелочку сортировки
  if Column.ImageIndex <> 234 then
    Column.ImageIndex := 234
  else
    Column.ImageIndex := 233;
  // Сбрасываем стрелочки сортировки в других столбцах
  for I := 0 to SearchResultJvListView.Columns.Count - 1 do
    if SearchResultJvListView.Columns[I] <> Column then
      SearchResultJvListView.Columns[I].ImageIndex := -1;
end;

procedure TIcqSearchForm.SearchResultJvListViewDblClick(Sender: TObject);
begin
  // Выводим диалог добавления контакта в список контактов
  AddContactInCLSMClick(Self);
end;

procedure TIcqSearchForm.SearchResultJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
begin
  // Ставим иконку просмотра анкеты о контакте
  Item.ImageIndex := 237;
end;

procedure TIcqSearchForm.SearchResultJvListViewGetSubItemImage(Sender: TObject; Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
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
  I, RelativeX, ColStartX: Integer;
begin
  Result := 0;
  with SearchResultJvListView do
    begin
      // Теперь попробуем найти колонку
      RelativeX := X - Selected.Position.X - BorderWidth;
      ColStartX := Columns[0].Width;
      for I := 1 to Columns.Count - 1 do
        begin
          if RelativeX < ColStartX then
            Break;
          if RelativeX <= ColStartX + Columns[I].Width then
            begin
              Result := I;
              Break;
            end;
          Inc(ColStartX, Columns[I].Width);
        end;
    end;
end;

procedure TIcqSearchForm.SearchResultJvListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = MbLeft then
    begin
      with SearchResultJvListView do
        begin
          if Selected <> nil then
            begin
              case GetColimnAtX(X) of
                0: OpenAnketa; // Открываем анкету этого контакта
                1: OpenChatResult; // Открываем чат с этим контактом
                8: SendQMessageSpeedButtonClick(Self);
              end;
            end;
        end;
    end;
end;

procedure TIcqSearchForm.SearchResultPopupMenuPopup(Sender: TObject);
begin
  // Блокируем нужные пункты меню
  if SearchResultJvListView.Selected <> nil then
    begin
      ICQStatusCheckSM.Enabled := True;
      AccountNameCopySM.Enabled := True;
      SendMessageSM.Enabled := True;
      ContactInfoSM.Enabled := True;
      AddContactInCLSM.Enabled := True;
    end
  else
    begin
      ICQStatusCheckSM.Enabled := False;
      AccountNameCopySM.Enabled := False;
      SendMessageSM.Enabled := False;
      ContactInfoSM.Enabled := False;
      AddContactInCLSM.Enabled := False;
    end;
  if SearchResultJvListView.Items.Count > 0 then
    SaveSM.Enabled := True
  else
    SaveSM.Enabled := False;
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
          if (Selected.Checked) or (QMessageEdit.Tag = 1) or (QMessageEdit.Text = EmptyStr) then
            Exit;
          // Отправляем быстрое сообщение этому контакту
          if ICQ_Work_Phaze then
            begin
              ICQ_SendMessage_0406(Selected.SubItems[1], QMessageEdit.Text, True);
              Selected.Checked := True;
            end;
        end;
    end;
end;

end.
