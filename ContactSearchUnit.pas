{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit ContactSearchUnit;

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
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  Buttons,
  Menus,
  VarsUnit,
  JvExComCtrls,
  JvListView,
  ExtDlgs,
  CategoryButtons;

type
  TContactSearchForm = class(TForm)
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
    EmailSearchGroupBox: TGroupBox;
    KeyWordSearchGroupBox: TGroupBox;
    UINSearchCheckBox: TCheckBox;
    UINSearchEdit: TEdit;
    EmailSearchCheckBox: TCheckBox;
    EmailSearchEdit: TEdit;
    KeyWordSearchCheckBox: TCheckBox;
    KeyWordSearchEdit: TEdit;
    SaveSM: TMenuItem;
    LoadSM: TMenuItem;
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
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
    f_t, f_l, f_h, f_w: integer;
    SPage: Word;
    SPageInc: Boolean;
    function GetColimnAtX(X: Integer): Integer;
    procedure OpenAnketa;
    procedure OpenChatResult;
    procedure ICQ_GlobalSearch;

  public
    { Public declarations }
    SearchProto: string;
    procedure TranslateForm;
    procedure SearchICQ;
    procedure SearchJabber;
    procedure SearchMRA;
  end;

{$ENDREGION}

var
  ContactSearchForm: TContactSearchForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  AddContactUnit,
  ContactInfoUnit,
  IcqOptionsUnit,
  JvSimpleXml,
  OverbyteIcsUrl,
  RosterUnit,
  JabberProtoUnit,
  MraProtoUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_IcqSearchF = 'icq_search_form';

{$ENDREGION}
{$REGION 'GlobalSearch'}

procedure TContactSearchForm.ICQ_GlobalSearch;
var
  CountryInd, LangInd, MaritalInd: Integer;
begin
  // Ищем новым способом
  if IsNotNull([NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text, KeyWordEdit.Text, GenderComboBox.Text, AgeComboBox.Text, MaritalComboBox.Text, CountryComboBox.Text, LangComboBox.Text]) then
  begin
    // Управляем счётчиком страниц
    if SPageInc then
    begin
      Inc(SPage);
      SearchNextPageBitBtn.Caption := Format(Lang_Vars[126].L_S, [SPage]);
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
        CountryInd := StrToInt(IsolateTextString(CountryComboBox.Text, C_QN, C_EN));
      // Язык
      if LangComboBox.ItemIndex > 0 then
        LangInd := StrToInt(IsolateTextString(LangComboBox.Text, C_QN, C_EN));
      // Брак
      if MaritalComboBox.ItemIndex > 0 then
        MaritalInd := StrToInt(IsolateTextString(MaritalComboBox.Text, C_QN, C_EN));
    end;
    // Начинаем поиск
    StatusPanel.Caption := Lang_Vars[121].L_S;
    ICQ_SearchNewBase(NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text, KeyWordEdit.Text, GenderComboBox.ItemIndex, AgeComboBox.ItemIndex, MaritalInd, CountryInd, LangInd, SPage,
      OnlyOnlineCheckBox.Checked);
  end;
end;

{$ENDREGION}
{$REGION 'OpenAnketa'}

procedure TContactSearchForm.OpenAnketa;
begin
  if not Assigned(ContactInfoForm) then
    Application.CreateForm(TContactInfoForm, ContactInfoForm);
  // Присваиваем UIN инфу которого хотим смотреть
  ContactInfoForm.ReqUIN := SearchResultJvListView.Selected.SubItems[1];
  ContactInfoForm.ReqProto := SearchProto;
  // Загружаем информацию о нем
  ContactInfoForm.LoadUserUnfo;
  // Отображаем окно
  XShowForm(ContactInfoForm);
end;

{$ENDREGION}
{$REGION 'OpenChatResult'}

procedure TContactSearchForm.OpenChatResult;
var
  I, Status: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Contact_Yes: Boolean;
  UIN, Nick: string;
  KL_Item: TButtonItem;
begin
  // Получаем логин и ник контакта
  UIN := SearchResultJvListView.Selected.SubItems[1];
  Nick := SearchResultJvListView.Selected.SubItems[2];
  if Nick = EmptyStr then
    Nick := UIN;
  // Определяем статус по протоколу
  Status := 286;
  if SearchProto = C_Icq then
    Status := 214
  else if SearchProto = C_Jabber then
    Status := 42
  else if SearchProto = C_Mra then
    Status := 312;
  // Ищем этот контакт в Ростере
  Contact_Yes := False;
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Ищем раздел протокола
        XML_Node := Root.Items.ItemNamed[SearchProto];
        if XML_Node <> nil then
        begin
          // Открываем раздел групп
          Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
          if Sub_Node = nil then
            Sub_Node := XML_Node.Items.Add(C_Group + C_SS);
          // Добавляем группу для контактов "не в списке"
          Tri_Node := Sub_Node.Items.ItemNamed[C_Group + C_DD + C_NoCL];
          if Tri_Node = nil then
          begin
            Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_NoCL);
            Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[33].L_S));
            Tri_Node.Properties.Add(C_Id, C_NoCL);
          end;
          // Ищем раздел контактов
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
          if Sub_Node <> nil then
          begin
            for I := 0 to Sub_Node.Items.Count - 1 do
            begin
              Tri_Node := Sub_Node.Items.Item[i];
              if Tri_Node <> nil then
              begin
                // Если нашли этот контакт
                if Tri_Node.Properties.Value(C_Login) = UrlEncode(UIN) then
                begin
                  Contact_Yes := True;
                  // Открываем чат с ним
                  KL_Item := TButtonItem.Create(nil);
                  try
                    KL_Item.UIN := UrlEncode(UIN);
                    KL_Item.ContactType := SearchProto;
                    KL_Item.Caption := Nick;
                    KL_Item.Status := Status;
                    OpenChatPage(KL_Item, SearchProto);
                  finally
                    FreeAndNil(KL_Item);
                  end;
                  // Прерываем цикл
                  Break;
                end;
              end;
            end;
            // Если контакт в Ростере не нашли
            if not Contact_Yes then
            begin
              // Добавляем этот контакт в эту группу
              Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
              Tri_Node.Properties.Add(C_Login, URLEncode(UIN));
              Tri_Node.Properties.Add(C_Group + C_Id, C_NoCL);
              Tri_Node.Properties.Add(C_Status, Status);
              Tri_Node.Properties.Add(C_Nick, URLEncode(Nick));
            end;
            // Обновляем КЛ
            UpdateFullCL;
            // Открываем чат с этим контактом
            KL_Item := ReqCLContact(SearchProto, UrlEncode(UIN));
            if KL_Item <> nil then
            begin
              MainForm.ContactListButtonClicked(Self, KL_Item);
              MainForm.ContactListButtonClicked(Self, KL_Item);
            end;
          end;
        end;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TContactSearchForm.TranslateForm;
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
  QMessageEdit.Text := Lang_Vars[102].L_S;
  HelpKeyword := Caption;
  UINSearchCheckBox.HelpKeyword := UINSearchCheckBox.Caption;
  SearchNextPageBitBtn.HelpKeyword := SearchNextPageBitBtn.Caption;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TContactSearchForm.UINSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по UIN
  if UINSearchCheckBox.Checked then
  begin
    EmailSearchCheckBox.Checked := False;
    KeyWordSearchCheckBox.Checked := False;
    GlobalSearchCheckBox.Checked := False;
  end;
end;

procedure TContactSearchForm.UINSearchEditChange(Sender: TObject);
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

procedure TContactSearchForm.SaveSMClick(Sender: TObject);
begin
  // Сохраняем результаты поиска в файл
  with MainForm do
  begin
    SaveTextAsFileDialog.FileName := SearchProto + C_BN + 'search result';
    if SaveTextAsFileDialog.Execute then
      SearchResultJvListView.SaveToCSV(SaveTextAsFileDialog.FileName);
  end;
end;

{$ENDREGION}
{$REGION 'SearchBitBtnClick'}

procedure TContactSearchForm.SearchBitBtnClick(Sender: TObject);
var
  I: Integer;
  ListItemD: TListItem;
begin
  // Проверяем что этот протокол в сети
  if NotProtoOnline(SearchProto) then
    Exit;
  // Сбрасываем стрелочки сортировки во всех столбцах
  for I := 0 to SearchResultJvListView.Columns.Count - 1 do
    SearchResultJvListView.Columns[I].ImageIndex := -1;
  // Если не стоит галочка "Не очищать предыдущие резульаты", то стираем их
  if not NotPreviousClearCheckBox.Checked then
  begin
    SearchResultJvListView.Clear;
    ResultPanel.Caption := '0';
  end;
  // Ищем
  if (UINSearchCheckBox.Checked) and (UINSearchEdit.Text <> EmptyStr) then
  begin
    // Ставим сообщение что идёт поиск
    StatusPanel.Caption := Lang_Vars[121].L_S;
    // Смотрим какой протокол
    if SearchProto = C_Icq then
    begin
      // Нормализуем UIN
      UINSearchEdit.Text := NormalizeScreenName(UINSearchEdit.Text);
      UINSearchEdit.Text := NormalizeIcqNumber(UINSearchEdit.Text);
      if not ExIsValidCharactersDigit(UINSearchEdit.Text) then
      begin
        UINSearchEdit.Clear;
        Exit;
      end;
      if ICQ_Work_Phaze then
        ICQ_SearchPoUIN_new(UINSearchEdit.Text);
    end
    else if SearchProto = C_Jabber then
    begin
        ListItemD := SearchResultJvListView.Items.Add;
        with ListItemD do
        begin
          Checked := False;
          Caption := EmptyStr; // Иконка анкеты
          SubItems.Add(EmptyStr); // Иконка чата
          if Pos(C_EE, UINSearchEdit.Text) = 0 then
            SubItems.Add(UINSearchEdit.Text + C_EE + Parse(C_EE, Jabber_JID, 2))
          else
            SubItems.Add(UINSearchEdit.Text);
          SubItems.Add(EmptyStr);
          SubItems.Add(EmptyStr);
          SubItems.Add(EmptyStr);
          SubItems.Add(EmptyStr);
          SubItems.Add(Lang_Vars[124].L_S);
          SubItems.Add(EmptyStr); // Иконка быстрых сообщений
          SubItems.Add(EmptyStr);
          SubItems.Add(EmptyStr);
          SubItems.Add(EmptyStr);
        end;
    end
    else if SearchProto = C_Mra then
    begin

    end;
  end
  else if (EmailSearchCheckBox.Checked) and (EmailSearchEdit.Text <> EmptyStr) then
  begin
    // Ставим сообщение что идёт поиск
    StatusPanel.Caption := Lang_Vars[121].L_S;
    // Смотрим какой протокол
    if SearchProto = C_Icq then
    begin
      if ICQ_Work_Phaze then
        ICQ_SearchPoEmail_new(EmailSearchEdit.Text);
    end
    else if SearchProto = C_Jabber then
    begin
      if Jabber_Work_Phaze then
        Jab_UserSearch(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmailSearchEdit.Text);
    end;
  end
  else if (KeyWordSearchCheckBox.Checked) and (KeyWordSearchEdit.Text <> EmptyStr) then
  begin
    // Ставим сообщение что идёт поиск
    StatusPanel.Caption := Lang_Vars[121].L_S;
    // Смотрим какой протокол
    if SearchProto = C_Icq then
    begin
      if ICQ_Work_Phaze then
        ICQ_SearchPoText_new(KeyWordSearchEdit.Text, OnlyOnlineCheckBox.Checked);
    end;
  end
  else if GlobalSearchCheckBox.Checked then
  begin
    // Смотрим какой протокол
    if SearchProto = C_Icq then
    begin
      if ICQ_Work_Phaze then
      begin
        // Сбрасываем кнопку листания страниц в результатов
        SPageInc := False;
        SearchNextPageBitBtn.Caption := SearchNextPageBitBtn.HelpKeyword;
        // Ищем
        ICQ_GlobalSearch;
      end;
    end
    else if SearchProto = C_Jabber then
    begin
      // Ставим сообщение что идёт поиск
      StatusPanel.Caption := Lang_Vars[121].L_S;
      // Ищем
      if IsNotNull([NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text, CountryComboBox.Text]) then
      begin
        if Jabber_Work_Phaze then
          Jab_UserSearch(NickEdit.Text, NameEdit.Text, FamilyEdit.Text, CityEdit.Text, Parse(C_BN, CountryComboBox.Text, 2), EmptyStr);
      end;
    end
    else if SearchProto = C_Mra then
    begin

    end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TContactSearchForm.SearchNextPageBitBtnClick(Sender: TObject);
begin
  // Начинаем листать страницы
  SPageInc := True;
  ICQ_GlobalSearch;
end;

procedure TContactSearchForm.EmailSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по Email
  if EmailSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := False;
    KeyWordSearchCheckBox.Checked := False;
    GlobalSearchCheckBox.Checked := False;
  end;
end;

procedure TContactSearchForm.EmailSearchEditChange(Sender: TObject);
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

procedure TContactSearchForm.QMessageEditEnter(Sender: TObject);
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

procedure TContactSearchForm.QMessageEditExit(Sender: TObject);
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
      Text := C_BN + Lang_Vars[102].L_S;
      Tag := 1;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'FormClose'}

procedure TContactSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим окно списка контактов на передний план
  BringWindowToTop(MainForm.Handle);
  // Уничтожаем окно
  SearchResultJvListView.HeaderImages := nil;
  Action := CaFree;
  ContactSearchForm := nil;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TContactSearchForm.FormCreate(Sender: TObject);
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
          XML_Node := Root.Items.ItemNamed[C_IcqSearchF];
          if XML_Node <> nil then
          begin
            // Загружаем позицию окна
            Top := XML_Node.Properties.IntValue(C_FT);
            Left := XML_Node.Properties.IntValue(C_FL);
            Height := XML_Node.Properties.IntValue(C_FH);
            Width := XML_Node.Properties.IntValue(C_FW);
            f_t := Top;
            f_l := Left;
            f_h := Height;
            f_w := Width;
            if XML_Node.Properties.BoolValue(C_FM, False) then
              WindowState := wsMaximized;
            // Определяем не находится ли окно за пределами экрана
            FormSetInWorkArea(Self);
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
  MainForm.AllImageList.GetBitmap(235, SearchBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(159, ResultClearSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(239, SendQMessageSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, SearchNextPageBitBtn.Glyph);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := True;
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure TContactSearchForm.FormDestroy(Sender: TObject);
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
        XML_Node := Root.Items.ItemNamed[C_IcqSearchF];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_IcqSearchF);
        // Сохраняем позицию окна
        if WindowState = wsMaximized then
        begin
          XML_Node.Properties.Add(C_FM, True);
          XML_Node.Properties.Add(C_FT, f_t);
          XML_Node.Properties.Add(C_FL, f_l);
          XML_Node.Properties.Add(C_FH, f_h);
          XML_Node.Properties.Add(C_FW, f_w);
        end
        else
        begin
          XML_Node.Properties.Add(C_FM, False);
          XML_Node.Properties.Add(C_FT, Top);
          XML_Node.Properties.Add(C_FL, Left);
          XML_Node.Properties.Add(C_FH, Height);
          XML_Node.Properties.Add(C_FW, Width);
        end;
        // Записываем сам файл
        SaveToFile(V_ProfilePath + C_SettingsFileName);
      end;
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TContactSearchForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TContactSearchForm.GlobalSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем глобальный поиск
  if GlobalSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := False;
    EmailSearchCheckBox.Checked := False;
    KeyWordSearchCheckBox.Checked := False;
  end;
end;

procedure TContactSearchForm.ICQStatusCheckSMClick(Sender: TObject);
begin
  // Проверяем статус
  if SearchResultJvListView.Selected <> nil then
    ICQ_ReqStatus0215(SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TContactSearchForm.KeyWordSearchCheckBoxClick(Sender: TObject);
begin
  // Активируем поиск по ключ. словам
  if KeyWordSearchCheckBox.Checked then
  begin
    UINSearchCheckBox.Checked := False;
    EmailSearchCheckBox.Checked := False;
    GlobalSearchCheckBox.Checked := False;
  end;
end;

procedure TContactSearchForm.KeyWordSearchEditChange(Sender: TObject);
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

procedure TContactSearchForm.LoadSMClick(Sender: TObject);
begin
  // Загружаем результаты поиска из файла
  SearchResultJvListView.Clear;
  if LoadSearchResultFileDialog.Execute then
    SearchResultJvListView.LoadFromCSV(LoadSearchResultFileDialog.FileName);
end;

procedure TContactSearchForm.NickEditChange(Sender: TObject);
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

procedure TContactSearchForm.AccountNameCopySMClick(Sender: TObject);
begin
  // Копируем имя учётной записи в буфер обмена
  if SearchResultJvListView.Selected <> nil then
    SetClipboardText(SearchResultJvListView.Selected.SubItems[1]);
end;

procedure TContactSearchForm.SendMessageSMClick(Sender: TObject);
begin
  // Открываем чат с выбранным контактом
  if SearchResultJvListView.Selected <> nil then
    OpenChatResult;
end;

procedure TContactSearchForm.ContactInfoSMClick(Sender: TObject);
begin
  // Открываем анкету
  if SearchResultJvListView.Selected <> nil then
    OpenAnketa;
end;

{$ENDREGION}
{$REGION 'AddContactInCLSMClick'}

procedure TContactSearchForm.AddContactInCLSMClick(Sender: TObject);
var
  FrmAddContact: TAddContactForm;
begin
  // Выводим форму добавления нового контакта
  FrmAddContact := TAddContactForm.Create(Self);
  try
    with FrmAddContact do
    begin
      // Ставим флаг какой протокол
      ContactType := SearchProto;
      // Строим список групп этого протокола
      BuildGroupList(ContactType, EmptyStr);
      // Добавляем параметры контакта
      AccountEdit.Text := SearchResultJvListView.Selected.SubItems[1];
      AccountEdit.ReadOnly := True;
      AccountEdit.Color := ClBtnFace;
      // Заносим имя учётной записи
      if SearchResultJvListView.Selected.SubItems[2] = EmptyStr then
        NameEdit.Text := SearchResultJvListView.Selected.SubItems[1]
      else
        NameEdit.Text := SearchResultJvListView.Selected.SubItems[2];
      // Отображаем окно модально
      ShowModal;
    end;
  finally
    FreeAndNil(FrmAddContact);
  end;
end;

{$ENDREGION}
{$REGION 'SearchResultJvListViewColumnClick'}

procedure TContactSearchForm.SearchResultJvListViewColumnClick(Sender: TObject; Column: TListColumn);
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

{$ENDREGION}
{$REGION 'Other'}

procedure TContactSearchForm.SearchResultJvListViewChanging(Sender: TObject; Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin
  // Заносим количество найденных в панель
  ResultPanel.Caption := IntToStr(SearchResultJvListView.Items.Count);
end;

procedure TContactSearchForm.SearchResultJvListViewDblClick(Sender: TObject);
begin
  // Выводим диалог добавления контакта в список контактов
  AddContactInCLSMClick(Self);
end;

procedure TContactSearchForm.SearchResultJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
begin
  // Ставим иконку просмотра анкеты о контакте
  Item.ImageIndex := 237;
end;

procedure TContactSearchForm.SearchResultJvListViewGetSubItemImage(Sender: TObject; Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
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

procedure TContactSearchForm.ResultClearSpeedButtonClick(Sender: TObject);
begin
  // Очищаем список от результатов
  SearchResultJvListView.Clear;
  ResultPanel.Caption := '0';
end;

{$ENDREGION}
{$REGION 'GetColimnAtX'}

function TContactSearchForm.GetColimnAtX(X: Integer): Integer;
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

{$ENDREGION}
{$REGION 'SearchResultJvListViewMouseDown'}

procedure TContactSearchForm.SearchResultJvListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

{$ENDREGION}
{$REGION 'SearchResultPopupMenuPopup'}

procedure TContactSearchForm.SearchResultPopupMenuPopup(Sender: TObject);
begin
  // Блокируем нужные пункты меню
  if SearchProto <> C_Icq then
    ICQStatusCheckSM.Visible := False
  else
    ICQStatusCheckSM.Visible := True;
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

{$ENDREGION}
{$REGION 'SendQMessageSpeedButtonClick'}

procedure TContactSearchForm.SendQMessageSpeedButtonClick(Sender: TObject);
begin
  // Проверяем что этот протокол в сети
  if NotProtoOnline(SearchProto) then
    Exit;
  // Отправляем сообщение
  with SearchResultJvListView do
  begin
    if Selected <> nil then
    begin
      // Если уже отправляли сообщение или оно пустое, то выходим
      if (Selected.Checked) or (QMessageEdit.Tag = 1) or (QMessageEdit.Text = EmptyStr) then
        Exit;
      // Смотрим какой протокол
      if SearchProto = C_Icq then
      begin
        if ICQ_Work_Phaze then
        begin
          ICQ_SendMessage_0406(Selected.SubItems[1], QMessageEdit.Text, True);
          Selected.Checked := True;
        end;
      end
      else if SearchProto = C_Jabber then
      begin
        if Jabber_Work_Phaze then
        begin
          Jab_SendMessage(Selected.SubItems[1], QMessageEdit.Text);
          Selected.Checked := True;
        end;
      end
      else if SearchProto = C_Mra then
      begin
        if MRA_Work_Phaze then
        begin
          MRA_SendMessage(Selected.SubItems[1], QMessageEdit.Text);
          Selected.Checked := True;
        end;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'SearchICQ'}

procedure TContactSearchForm.SearchICQ;
begin
  // Активируем контролы
  SearchProto := C_Icq;
  EmailSearchGroupBox.Visible := True;
  KeyWordSearchGroupBox.Visible := True;
  GlobalSearchGroupBox.Visible := True;
  TopPanel.Height := 188;
  SearchNextPageBitBtn.Enabled := True;
  UINSearchCheckBox.Caption := UINSearchCheckBox.HelpKeyword + C_BN + 'UIN';
  ResultClearSpeedButtonClick(nil);
  // Контролы глобального поиска
  GenderComboBox.Enabled := True;
  GenderComboBox.Color := clWindow;
  AgeComboBox.Enabled := True;
  AgeComboBox.Color := clWindow;
  CountryComboBox.Style := csDropDownList;
  SetCustomWidthComboBox(CountryComboBox);
  LangComboBox.Enabled := True;
  LangComboBox.Color := clWindow;
  MaritalComboBox.Enabled := True;
  MaritalComboBox.Color := clWindow;
  KeyWordEdit.Enabled := True;
  KeyWordEdit.Color := clWindow;
end;
{$ENDREGION}
{$REGION 'SearchJabber'}

procedure TContactSearchForm.SearchJabber;
begin
  // Активируем контролы
  SearchProto := C_Jabber;
  if Jab_VJID_Server <> EmptyStr then
  begin
    EmailSearchGroupBox.Visible := True;
    GlobalSearchGroupBox.Visible := True;
    TopPanel.Height := 188;
  end
  else
  begin
    EmailSearchGroupBox.Visible := False;
    GlobalSearchGroupBox.Visible := False;
    TopPanel.Height := 65;
  end;
  KeyWordSearchGroupBox.Visible := False;
  SearchNextPageBitBtn.Enabled := False;
  UINSearchCheckBox.Caption := UINSearchCheckBox.HelpKeyword + C_BN + 'JID';
  ResultClearSpeedButtonClick(nil);
  // Контролы глобального поиска
  GenderComboBox.Enabled := False;
  GenderComboBox.Color := clBtnFace;
  AgeComboBox.Enabled := False;
  AgeComboBox.Color := clBtnFace;
  CountryComboBox.Style := csDropDown;
  SetCustomWidthComboBox(CountryComboBox);
  LangComboBox.Enabled := False;
  LangComboBox.Color := clBtnFace;
  MaritalComboBox.Enabled := False;
  MaritalComboBox.Color := clBtnFace;
  KeyWordEdit.Enabled := False;
  KeyWordEdit.Color := clBtnFace;
end;
{$ENDREGION}
{$REGION 'SearchMRA'}

procedure TContactSearchForm.SearchMRA;
begin
  // Активируем контролы
  SearchProto := C_Mra;
  EmailSearchGroupBox.Visible := False;
  KeyWordSearchGroupBox.Visible := False;
  GlobalSearchGroupBox.Visible := False;
  TopPanel.Height := 65;
  SearchNextPageBitBtn.Enabled := False;
  UINSearchCheckBox.Caption := UINSearchCheckBox.HelpKeyword + C_BN + C_Email;
  ResultClearSpeedButtonClick(nil);
end;
{$ENDREGION}

end.

