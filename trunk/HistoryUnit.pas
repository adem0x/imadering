{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit HistoryUnit;

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
  Htmlview,
  ExtCtrls,
  Buttons,
  Menus,
  ExtDlgs,
  JvSimpleXml,
  CategoryButtons,
  ButtonGroup,
  IOUtils;

type
  THistoryForm = class(TForm)
    LeftPanel: TPanel;
    PanelSplitter: TSplitter;
    RightPanel: TPanel;
    BottomPanel: TPanel;
    ReloadHistoryBitBtn: TBitBtn;
    SaveHistoryAsBitBtn: TBitBtn;
    DeleteHistoryBitBtn: TBitBtn;
    MessCountPanel: TPanel;
    HistoryPopupMenu: TPopupMenu;
    CopyHistorySelText: TMenuItem;
    CopyAllHistoryText: TMenuItem;
    HTMLHistoryViewer: THTMLViewer;
    TopPanel: TPanel;
    ContactSearchBitBtn: TBitBtn;
    HButtonGroup: TButtonGroup;
    HCategoryPanelGroup: TCategoryPanelGroup;
    Bim_HCategoryPanel: TCategoryPanel;
    MRA_HCategoryPanel: TCategoryPanel;
    Jab_HCategoryPanel: TCategoryPanel;
    ICQ_HCategoryPanel: TCategoryPanel;
    ICQ_HCategoryButtons: TCategoryButtons;
    HBevel: TBevel;
    Jab_HCategoryButtons: TCategoryButtons;
    MRA_HCategoryButtons: TCategoryButtons;
    Bim_HCategoryButtons: TCategoryButtons;
    TextSearchGroupBox: TGroupBox;
    ArchivesLabel: TLabel;
    ArchivesComboBox: TComboBox;
    SBevel: TBevel;
    SearchTextEdit: TEdit;
    SearchTextBitBtn: TBitBtn;
    SearchTextLabel: TLabel;
    RegistrCheckBox: TCheckBox;
    FullSearchTextCheckBox: TCheckBox;
    UpSearchCheckBox: TRadioButton;
    DownSearchCheckBox: TRadioButton;
    SearchStatusPanel: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HistoryPopupMenuPopup(Sender: TObject);
    procedure HTMLHistoryViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchTextBitBtnClick(Sender: TObject);
    procedure ReloadHistoryBitBtnClick(Sender: TObject);
    procedure SaveHistoryAsBitBtnClick(Sender: TObject);
    procedure DeleteHistoryBitBtnClick(Sender: TObject);
    procedure ContactsComboBoxChange(Sender: TObject);
    procedure CopyHistorySelTextClick(Sender: TObject);
    procedure CopyAllHistoryTextClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure HTMLHistoryViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure HTMLHistoryViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
    procedure HCategoryPanelGroupCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure CategoryButtonsButtonClicked(Sender: TObject; const Button: TButtonItem);
    procedure HButtonGroupButtonClicked(Sender: TObject; Index: Integer);

  private
    { Private declarations }
    f_t, f_l, f_h, f_w: integer;
    HTMLStyle: string;
    MyHUIN: string;
    HistoryFile: string;
    procedure BuildHistoryCL;
  public
    { Public declarations }
    ReqHUIN: string;
    ReqCType: string;
    procedure TranslateForm;
    procedure LoadHistoryFromFile;
  end;

{$ENDREGION}

var
  HistoryForm: THistoryForm;

implementation

{$R *.dfm}

{$REGION 'MyUses'}

uses
  MainUnit,
  ChatUnit,
  UtilsUnit,
  VarsUnit,
  IcqProtoUnit,
  MraProtoUnit,
  JabberProtoUnit,
  OverbyteIcsUtils;

{$ENDREGION}
{$REGION 'LoadHistoryFromFile'}

procedure THistoryForm.LoadHistoryFromFile;
var
  Doc, H: string;
begin
  {ContactsComboBox.OnChange := nil;
  // Вычисляем нашу текущую учётную запись
  if ReqCType = C_Icq then
    MyHUIN := ICQ_LoginUIN
  else if ReqCType = C_Mra then
    MyHUIN := Mra_LoginUIN
  else if ReqCType = C_Jabber then
    MyHUIN := Jabber_LoginUIN;
  // --Очистили компонент истории и выводим надпись, что история загружается
  Doc := HTMLStyle;
  Doc := Doc + '<span class=b>' + Lang_Vars[116].L_S + '</span>';
  LoadHTMLStrings(HTMLHistoryViewer, Doc);
  HTMLHistoryViewer.Refresh;
  // Загружаем файл истории сообщений
  HistoryFile := V_ProfilePath + C_HistoryFolder + ReqCType + C_S9 + MyHUIN + C_S9 + ReqHUIN + C_Htm_Ext;
  if FileExists(HistoryFile) then
    begin
      // Находим этот контакт в списке файлов историй
      H := GetFileName(HistoryFile);
      H := Copy(H, 1, Length(H) - 4);
      ContactsComboBox.ItemIndex := ContactsComboBox.Items.IndexOf(H);
      // Ичищаем компонент просмотра истории
      HTMLHistoryViewer.Clear;
      // Добавляем стили
      Doc := HTMLStyle;
      // Загружаем весь текст истории
      Doc := Doc + ReadFromFile(HistoryFile, true);
      // Применяем смайлы
      if not V_TextSmilies then
        CheckMessage_Smilies(Doc);
      // Отображаем историю в компоненте
      SetLength(Doc, Length(Doc) - 6);
      LoadHTMLStrings(HTMLHistoryViewer, Doc);
      // Ставим каретку в самый низ текста
      HTMLHistoryViewer.VScrollBarPosition := HTMLHistoryViewer.VScrollBar.Max;
      HTMLHistoryViewer.CaretPos := Length(HTMLHistoryViewer.DocumentSource);
    end
  else
    begin
      ContactsComboBox.ItemIndex := -1;
      // Очистили компонент истории и выводим сообщение, что история не найдена
      HTMLHistoryViewer.Clear;
      Doc := HTMLStyle;
      Doc := Doc + '<span class=d>' + Lang_Vars[109].L_S + '</span>';
      LoadHTMLStrings(HTMLHistoryViewer, Doc);
    end;
  // Ищем архивы истории с этим контактом
  ArhiveComboBox.Clear;
  if ContactsComboBox.Text <> EmptyStr then
    ListFileInDir(V_ProfilePath + C_HistoryFolder + ContactsComboBox.Text + '*.7z', '.7z', ArhiveComboBox.Items);
  ContactsComboBox.OnChange := ContactsComboBoxChange;}
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure THistoryForm.TranslateForm;
begin
  // Применяем язык
  SetLang(Self);
  // Другое
  SearchStatusPanel.Caption := Parse(';', SearchStatusPanel.Hint, 1);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure THistoryForm.CopyHistorySelTextClick(Sender: TObject);
begin
  // Копируем выделенный текст в буфер обмена
  HTMLHistoryViewer.CopyToClipboard;
end;

procedure THistoryForm.CopyAllHistoryTextClick(Sender: TObject);
begin
  // Копируем весь текст в буфер обмена
  HTMLHistoryViewer.SelectAll;
  HTMLHistoryViewer.CopyToClipboard;
end;

procedure THistoryForm.HButtonGroupButtonClicked(Sender: TObject; Index: Integer);
begin
  // Сбрасываем выделение с истории контактов
  ICQ_HCategoryButtons.SelectedItem := nil;
  ICQ_HCategoryButtons.FocusedItem := nil;
  Jab_HCategoryButtons.SelectedItem := nil;
  Jab_HCategoryButtons.FocusedItem := nil;
  MRA_HCategoryButtons.SelectedItem := nil;
  MRA_HCategoryButtons.FocusedItem := nil;
  Bim_HCategoryButtons.SelectedItem := nil;
  Bim_HCategoryButtons.FocusedItem := nil;
  // Открываем историю выбранного пункта

end;

procedure THistoryForm.HCategoryPanelGroupCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  // Подгоняем размер открытой группы
  if Resize then
    HCategoryPanelGroup.SetOpenPanelHeight;
end;

procedure THistoryForm.HistoryPopupMenuPopup(Sender: TObject);
begin
  // Определяем есть ли выделенный текст
  if HTMLHistoryViewer.SelLength = 0 then
    CopyHistorySelText.Enabled := False
  else
    CopyHistorySelText.Enabled := True;
end;

procedure THistoryForm.SearchTextBitBtnClick(Sender: TObject);
begin
  // Снимаем предыдущее выделение текста
  HTMLHistoryViewer.SelLength := 0;
  // Делаем поиск текста в истории
  if not HTMLHistoryViewer.FindEx(SearchTextEdit.Text, RegistrCheckBox.Checked, UpSearchCheckBox.Checked) then
    MessageBox(Handle, PChar(Lang_Vars[26].L_S), PChar(Application.Title), MB_OK or MB_ICONINFORMATION);
end;

procedure THistoryForm.ReloadHistoryBitBtnClick(Sender: TObject);
begin
  // Если путь к файлу пустой, то выходим
  {if ContactsComboBox.Text = EmptyStr then
    Exit;
  // Перезагружаем файл истории
  ContactsComboBoxChange(nil); }
end;

{$ENDREGION}
{$REGION 'SaveHistoryAsBitBtnClick'}

procedure THistoryForm.SaveHistoryAsBitBtnClick(Sender: TObject);
var
  List: TStringList;
begin
  {// Если путь к файлу пустой, то выходим
  if ContactsComboBox.Text = EmptyStr then
    Exit;
  // Указываем начальное имя файла
  MainForm.SaveTextAsFileDialog.FileName := 'History ' + ContactsComboBox.Text;
  MainForm.SaveTextAsFileDialog.FilterIndex := 1;
  // Открываем диалог сохранения файла
  if MainForm.SaveTextAsFileDialog.Execute then
    begin
      // Создаём лист строк
      List := TStringList.Create;
      try
        // Выделяем весь текст в истории
        HTMLHistoryViewer.SelectAll;
        // Копируем выделенный текст в лист
        List.Text := HTMLHistoryViewer.SelText;
        // Сбрасываем выделение текста
        HTMLHistoryViewer.SelLength := 0;
        // Сохраняем текст из листа в файл из диалога
        List.SaveToFile(MainForm.SaveTextAsFileDialog.FileName, TEncoding.Unicode);
      finally
        List.Free;
      end;
    end;}
end;

{$ENDREGION}
{$REGION 'DeleteHistoryBitBtnClick'}

procedure THistoryForm.DeleteHistoryBitBtnClick(Sender: TObject);
var
  I: Integer;
begin
  {// Если путь к файлу пустой, то выходим
  if ContactsComboBox.Text = EmptyStr then
    Exit;
  // Выводим запрос на удаление файла истории
  I := MessageBox(Handle, PChar(Lang_Vars[44].L_S), PChar(Lang_Vars[19].L_S), MB_TOPMOST or MB_YESNO or MB_ICONQUESTION);
  // Если ответ положительный
  if I = IDYES then
    begin
      // Удаляем файл
      if FileExists(HistoryFile) then
        DeleteFile(HistoryFile);
      // Очищаем компонент истории
      HTMLHistoryViewer.Clear;
      // Удаляем эту запись из списка файлов истори
      ContactsComboBox.Items.Delete(ContactsComboBox.ItemIndex);
    end;}
end;

{$ENDREGION}
{$REGION 'ContactsComboBoxChange'}

procedure THistoryForm.ContactsComboBoxChange(Sender: TObject);
var
  Doc: string;
begin
  // Загружаем файл с историей выбранного контакта
  // --Очистили компонент истории и выводим надпись, что история загружается
  {Doc := HTMLStyle;
  Doc := Doc + '<span class=b>' + Lang_Vars[116].L_S + '</span>';
  LoadHTMLStrings(HTMLHistoryViewer, Doc);
  HTMLHistoryViewer.Refresh;
  // Загружаем файл истории сообщений
  HistoryFile := V_ProfilePath + C_HistoryFolder + ContactsComboBox.Text + '.htm';
  if FileExists(HistoryFile) then
    begin
      // Ичищаем компонент просмотра истории
      HTMLHistoryViewer.Clear;
      // Добавляем стили
      Doc := HTMLStyle;
      // Загружаем весь текст истории
      Doc := Doc + ReadFromFile(HistoryFile, true);
      // Применяем смайлы
      if not V_TextSmilies then
        CheckMessage_Smilies(Doc);
      // Отображаем историю в компоненте
      SetLength(Doc, Length(Doc) - 6);
      Doc := Doc + '<HR>';
      LoadHTMLStrings(HTMLHistoryViewer, Doc);
      // Ставим каретку в самый низ текста
      HTMLHistoryViewer.VScrollBarPosition := HTMLHistoryViewer.VScrollBar.Max;
      HTMLHistoryViewer.CaretPos := Length(Doc);
    end;
  // Ищем архивы истории с этим контактом
  ArhiveComboBox.Clear;
  ListFileInDir(V_ProfilePath + C_HistoryFolder + ContactsComboBox.Text + '*.7z', '.7z', ArhiveComboBox.Items);
  // Ставим фокус в поле поиска текста
  if SearchTextEdit.CanFocus then
    SearchTextEdit.SetFocus;}
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure THistoryForm.FormCreate(Sender: TObject);
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
        // Загружаем позицию окна
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[Self.Name];
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
  // Переводим окно на другие языки
  TranslateForm;
  // Формируем строку стиля
  HTMLHistoryViewer.DoubleBuffered := True;
  HTMLStyle := Format(C_HTML_head, [V_ChatCSS, C_IMadering]);
  // Назначаем иконки окну и кнопкам
  MainForm.AllImageList.GetIcon(147, Icon);
  MainForm.AllImageList.GetBitmap(221, SearchTextBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ReloadHistoryBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(225, SaveHistoryAsBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(148, DeleteHistoryBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(215, ContactSearchBitBtn.Glyph);
  ICQ_HCategoryPanel.xImageIndex := 81;
  Jab_HCategoryPanel.xImageIndex := 43;
  MRA_HCategoryPanel.xImageIndex := 66;
  Bim_HCategoryPanel.xImageIndex := 297;
  // Создаём список имеющихся файлов истории для выбора
  BuildHistoryCL;
  // Делаем окно независимым и ставим его кнопку в панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Назначаем событие выбора файла истории
  //ContactsComboBox.OnChange := ContactsComboBoxChange;
  // Исправляем глюк со скролом в Win 7
  HTMLHistoryViewer.VScrollBar.DoubleBuffered := False;
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure THistoryForm.FormDestroy(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Сохраняем настройки положения окна истории в xml
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      if Root <> nil then
      begin
        // Очищаем раздел формы истории если он есть
        XML_Node := Root.Items.ItemNamed[Self.Name];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(Self.Name);
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
      end;
      // Записываем сам файл
      SaveToFile(V_ProfilePath + C_SettingsFileName);
    end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure THistoryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Закрываем подсказки
  CloseSmiliesHint;
  // Указываем, что окно после закрытия уничтожится
  Action := CaFree;
  HistoryForm := nil;
end;

procedure THistoryForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure THistoryForm.HTMLHistoryViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
begin
  // Отключаем реакции
  Handled := True;
  // Открываем ссылку из чата во внешнем браузере
  OpenURL(SRC);
end;

procedure THistoryForm.HTMLHistoryViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При нажатии клавиш контрл + с копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
  begin
    HTMLHistoryViewer.CopyToClipboard;
  end;
end;

procedure THistoryForm.HTMLHistoryViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TitleStr: string;
begin
  // При движениях мыши определяем всплывание подсказок
  if (not MainForm.JvTimerList.Events[14].Enabled) and (Assigned(ActiveControl)) then
  begin
    if ActiveControl.Focused then
    begin
      // Запоминаем вызывающий компонент и атрибут
      SH_HTMLViewer := HTMLHistoryViewer;
      TitleStr := HTMLHistoryViewer.TitleAttr;
      // Проверяем содержимое атрибута
      if TitleStr = EmptyStr then
        SH_OldTitle := EmptyStr
      else if TitleStr <> SH_OldTitle then
      begin
        SH_TimerCount := 0;
        // Запускаем таймер показа подсказки с атрибутом
        MainForm.JvTimerList.Events[14].Enabled := True;
        SH_OldTitle := TitleStr;
      end;
    end;
  end;
end;

procedure THistoryForm.CategoryButtonsButtonClicked(Sender: TObject; const Button: TButtonItem);
var
  Proto, HistoryFile, Doc: string;
begin
  // Сбрасываем выделение системной истории
  HButtonGroup.ItemIndex := -1;
  // Сбрасываем выделение с других протоколов
  Proto := Button.Category.GroupType;
  if Proto = C_Icq then
  begin
    Jab_HCategoryButtons.SelectedItem := nil;
    Jab_HCategoryButtons.FocusedItem := nil;
    MRA_HCategoryButtons.SelectedItem := nil;
    MRA_HCategoryButtons.FocusedItem := nil;
    Bim_HCategoryButtons.SelectedItem := nil;
    Bim_HCategoryButtons.FocusedItem := nil;
  end
  else if Proto = C_Jabber then
  begin
    ICQ_HCategoryButtons.SelectedItem := nil;
    ICQ_HCategoryButtons.FocusedItem := nil;
    MRA_HCategoryButtons.SelectedItem := nil;
    MRA_HCategoryButtons.FocusedItem := nil;
    Bim_HCategoryButtons.SelectedItem := nil;
    Bim_HCategoryButtons.FocusedItem := nil;
  end
  else if Proto = C_Mra then
  begin
    ICQ_HCategoryButtons.SelectedItem := nil;
    ICQ_HCategoryButtons.FocusedItem := nil;
    Jab_HCategoryButtons.SelectedItem := nil;
    Jab_HCategoryButtons.FocusedItem := nil;
    Bim_HCategoryButtons.SelectedItem := nil;
    Bim_HCategoryButtons.FocusedItem := nil;
  end
  else if Proto = C_Bimoid then
  begin
    ICQ_HCategoryButtons.SelectedItem := nil;
    ICQ_HCategoryButtons.FocusedItem := nil;
    Jab_HCategoryButtons.SelectedItem := nil;
    Jab_HCategoryButtons.FocusedItem := nil;
    MRA_HCategoryButtons.SelectedItem := nil;
    MRA_HCategoryButtons.FocusedItem := nil;
  end;
  // Очистили компонент истории и выводим надпись, что история загружается
  HTMLHistoryViewer.Clear;
  Doc := HTMLStyle;
  Doc := Doc + Format(C_HistoryLoad, [Lang_Vars[116].L_S]);
  LoadHTMLStrings(HTMLHistoryViewer, Doc);
  HTMLHistoryViewer.Refresh;
  // Загружаем файл истории сообщений
  HistoryFile := Button.ContactType;
  if FileExists(HistoryFile) then
  begin
    // Ичищаем компонент просмотра истории
    HTMLHistoryViewer.Clear;
    // Добавляем стили
    Doc := HTMLStyle;
    // Загружаем весь текст истории
    Doc := Doc + ReadFromFile(HistoryFile, True);
    // Применяем смайлы
    if not V_TextSmilies then
      CheckMessage_Smilies(Doc);
    // Отображаем историю в компоненте
    SetLength(Doc, Length(Doc) - 6);
    LoadHTMLStrings(HTMLHistoryViewer, Doc);
    // Ставим каретку в самый низ текста
    HTMLHistoryViewer.VScrollBarPosition := HTMLHistoryViewer.VScrollBar.Max;
    HTMLHistoryViewer.CaretPos := Length(HTMLHistoryViewer.DocumentSource);
  end
  else
  begin
    // Очистили компонент истории и выводим сообщение, что история не найдена
    HTMLHistoryViewer.Clear;
    Doc := HTMLStyle;
    Doc := Doc + Format(C_HistoryInfo, [Lang_Vars[109].L_S]);
    LoadHTMLStrings(HTMLHistoryViewer, Doc);
  end;
end;

{$ENDREGION}
{$REGION 'BuildHistoryCL'}

procedure THistoryForm.BuildHistoryCL;
var
  I: Integer;
  Folder: string;
  CHF: TStringList;
begin
  // Строим КЛ истории
  CHF := TStringList.Create;
  try
    if DirectoryExists(V_ProfilePath + C_HistoryFolder + C_Icq) then
    begin
      // Делаем панель видимой
      ICQ_HCategoryPanel.Visible := True;
      // Создаем группы из папок учёток
      for Folder in TDirectory.GetDirectories(V_ProfilePath + C_HistoryFolder + C_Icq) do
      begin
        with ICQ_HCategoryButtons.Categories.Add do
        begin
          Caption := IcsExtractLastDir(Folder);
          GroupCaption := Caption;
          GroupType := C_Icq;
          GroupImage := -1;
          // Добавляем все файлы из этой директории
          CHF.Clear;
          ListFileInDir(V_ProfilePath + C_HistoryFolder + C_Icq + '\' + Caption + '\' + '*' + C_Htm_Ext, C_Htm_Ext, CHF);
          for I := 0 to CHF.Count - 1 do
          begin
            with Items.Add do
            begin
              UIN := CHF.Strings[I];
              Caption := UIN;
              ContactType := V_ProfilePath + C_HistoryFolder + C_Icq + '\' + Category.Caption + '\' + UIN + C_Htm_Ext;
              Hint := ContactType;
              ImageIndex := 81;
              XImageIndex := -1;
              CImageIndex := -1;
              PImageIndex := -1;
            end;
          end;
        end;
      end;
    end;
    if DirectoryExists(V_ProfilePath + C_HistoryFolder + C_Jabber) then
    begin
      // Делаем панель видимой
      Jab_HCategoryPanel.Visible := True;
      // Создаем группы из папок учёток
      for Folder in TDirectory.GetDirectories(V_ProfilePath + C_HistoryFolder + C_Jabber) do
      begin
        with Jab_HCategoryButtons.Categories.Add do
        begin
          Caption := IcsExtractLastDir(Folder);
          GroupCaption := Caption;
          GroupType := C_Jabber;
          GroupImage := -1;
          // Добавляем все файлы из этой директории
          CHF.Clear;
          ListFileInDir(V_ProfilePath + C_HistoryFolder + C_Jabber + '\' + Caption + '\' + '*' + C_Htm_Ext, C_Htm_Ext, CHF);
          for I := 0 to CHF.Count - 1 do
          begin
            with Items.Add do
            begin
              UIN := CHF.Strings[I];
              Caption := UIN;
              ContactType := V_ProfilePath + C_HistoryFolder + C_Jabber + '\' + Category.Caption + '\' + UIN + C_Htm_Ext;
              Hint := ContactType;
              ImageIndex := 43;
              XImageIndex := -1;
              CImageIndex := -1;
              PImageIndex := -1;
            end;
          end;
        end;
      end;
    end;
    if DirectoryExists(V_ProfilePath + C_HistoryFolder + C_Mra) then
    begin
      // Делаем панель видимой
      MRA_HCategoryPanel.Visible := True;
      // Создаем группы из папок учёток
      for Folder in TDirectory.GetDirectories(V_ProfilePath + C_HistoryFolder + C_Mra) do
      begin
        with MRA_HCategoryButtons.Categories.Add do
        begin
          Caption := IcsExtractLastDir(Folder);
          GroupCaption := Caption;
          GroupType := C_Mra;
          GroupImage := -1;
          // Добавляем все файлы из этой директории
          CHF.Clear;
          ListFileInDir(V_ProfilePath + C_HistoryFolder + C_Mra + '\' + Caption + '\' + '*' + C_Htm_Ext, C_Htm_Ext, CHF);
          for I := 0 to CHF.Count - 1 do
          begin
            with Items.Add do
            begin
              UIN := CHF.Strings[I];
              Caption := UIN;
              ContactType := V_ProfilePath + C_HistoryFolder + C_Mra + '\' + Category.Caption + '\' + UIN + C_Htm_Ext;
              Hint := ContactType;
              ImageIndex := 66;
              XImageIndex := -1;
              CImageIndex := -1;
              PImageIndex := -1;
            end;
          end;
        end;
      end;
    end;
    if DirectoryExists(V_ProfilePath + C_HistoryFolder + C_Bimoid) then
    begin
      // Делаем панель видимой
      Bim_HCategoryPanel.Visible := True;
      // Создаем группы из папок учёток
      for Folder in TDirectory.GetDirectories(V_ProfilePath + C_HistoryFolder + C_Bimoid) do
      begin
        with Bim_HCategoryButtons.Categories.Add do
        begin
          Caption := IcsExtractLastDir(Folder);
          GroupCaption := Caption;
          GroupType := C_Bimoid;
          GroupImage := -1;
          // Добавляем все файлы из этой директории
          CHF.Clear;
          ListFileInDir(V_ProfilePath + C_HistoryFolder + C_Bimoid + '\' + Caption + '\' + '*' + C_Htm_Ext, C_Htm_Ext, CHF);
          for I := 0 to CHF.Count - 1 do
          begin
            with Items.Add do
            begin
              UIN := CHF.Strings[I];
              Caption := UIN;
              ContactType := V_ProfilePath + C_HistoryFolder + C_Bimoid + '\' + Category.Caption + '\' + UIN + C_Htm_Ext;
              Hint := ContactType;
              ImageIndex := 297;
              XImageIndex := -1;
              CImageIndex := -1;
              PImageIndex := -1;
            end;
          end;
        end;
      end;
    end;
  finally
    CHF.Free;
  end;
end;
{$ENDREGION}

end.

