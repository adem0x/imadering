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
  JvSimpleXml;

type
  THistoryForm = class(TForm)
    TopPanel: TPanel;
    BottomPanel: TPanel;
    HTMLHistoryViewer: THTMLViewer;
    ContactsComboBox: TComboBox;
    ArhiveComboBox: TComboBox;
    Bevel1: TBevel;
    ContactsLabel: TLabel;
    ArhiveLabel: TLabel;
    SearchTextLabel: TLabel;
    SearchTextEdit: TEdit;
    SearchTextBitBtn: TBitBtn;
    RegistrCheckBox: TCheckBox;
    FullSearchTextCheckBox: TCheckBox;
    ReloadHistoryBitBtn: TBitBtn;
    SaveHistoryAsBitBtn: TBitBtn;
    DeleteHistoryBitBtn: TBitBtn;
    HistoryPopupMenu: TPopupMenu;
    CopyHistorySelText: TMenuItem;
    CopyAllHistoryText: TMenuItem;
    UpSearchCheckBox: TRadioButton;
    DownSearchCheckBox: TRadioButton;
    CloseBitBtn: TBitBtn;
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
    procedure CloseBitBtnClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure HTMLHistoryViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure HTMLHistoryViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);

  private
    { Private declarations }
    HTMLStyle: string;
    MyHUIN: string;
    HistoryFile: string;
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
  JabberProtoUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_HistoryForm = 'history_form';

{$ENDREGION}
{$REGION 'LoadHistoryFromFile'}

procedure THistoryForm.LoadHistoryFromFile;
var
  Doc, H: string;
begin
  ContactsComboBox.OnChange := nil;
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
  HistoryFile := V_ProfilePath + C_HistoryFolder + ReqCType + C_BN + MyHUIN + C_BN + ReqHUIN + '.htm';
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
      Doc := Doc + '<HR>';
      LoadHTMLStrings(HTMLHistoryViewer, Doc);
      // Ставим каретку в самый низ текста
      HTMLHistoryViewer.VScrollBarPosition := HTMLHistoryViewer.VScrollBar.Max;
      HTMLHistoryViewer.CaretPos := Length(Doc);
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
  ContactsComboBox.OnChange := ContactsComboBoxChange;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure THistoryForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CloseBitBtn.Caption := Lang_Vars[8].L_S;
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
    Showmessage(Lang_Vars[26].L_S);
end;

procedure THistoryForm.ReloadHistoryBitBtnClick(Sender: TObject);
begin
  // Если путь к файлу пустой, то выходим
  if ContactsComboBox.Text = EmptyStr then
    Exit;
  // Перезагружаем файл истории
  ContactsComboBoxChange(nil);
end;

{$ENDREGION}
{$REGION 'SaveHistoryAsBitBtnClick'}

procedure THistoryForm.SaveHistoryAsBitBtnClick(Sender: TObject);
var
  List: TStringList;
begin
  // Если путь к файлу пустой, то выходим
  if ContactsComboBox.Text = EmptyStr then
    Exit;
  // Указываем начальное имя файла
  MainForm.SaveTextAsFileDialog.FileName := 'History ' + ContactsComboBox.Text;
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
    end;
end;

{$ENDREGION}
{$REGION 'DeleteHistoryBitBtnClick'}

procedure THistoryForm.DeleteHistoryBitBtnClick(Sender: TObject);
var
  I: Integer;
begin
  // Если путь к файлу пустой, то выходим
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
    end;
end;

{$ENDREGION}
{$REGION 'ContactsComboBoxChange'}

procedure THistoryForm.ContactsComboBoxChange(Sender: TObject);
var
  Doc: string;
begin
  // Загружаем файл с историей выбранного контакта
  // --Очистили компонент истории и выводим надпись, что история загружается
  Doc := HTMLStyle;
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
    SearchTextEdit.SetFocus;
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
                XML_Node := Root.Items.ItemNamed[C_HistoryForm];
                if XML_Node <> nil then
                  begin
                    Top := XML_Node.Properties.IntValue('t');
                    Left := XML_Node.Properties.IntValue('l');
                    Height := XML_Node.Properties.IntValue('h');
                    Width := XML_Node.Properties.IntValue('w');
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
  HTMLStyle := '<html><head>' + V_ChatCSS + '<title>Chat</title></head><body>';
  // Назначаем иконки окну и кнопкам
  MainForm.AllImageList.GetIcon(147, Icon);
  MainForm.AllImageList.GetBitmap(221, SearchTextBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, ReloadHistoryBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(225, SaveHistoryAsBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(148, DeleteHistoryBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
  // Создаём список имеющихся файлов истории для выбора
  ListFileInDir(V_ProfilePath + C_HistoryFolder + '*.htm', '.htm', ContactsComboBox.Items);
  // Делаем окно независимым и ставим его кнопку в панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Назначаем событие выбора файла истории
  ContactsComboBox.OnChange := ContactsComboBoxChange;
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
            XML_Node := Root.Items.ItemNamed[C_HistoryForm];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(C_HistoryForm);
            // Сохраняем позицию окна
            XML_Node.Properties.Add('t', Top);
            XML_Node.Properties.Add('l', Left);
            XML_Node.Properties.Add('h', Height);
            XML_Node.Properties.Add('w', Width);
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

procedure THistoryForm.CloseBitBtnClick(Sender: TObject);
begin
  // Закрываем окно с историей
  Close;
end;

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

{$ENDREGION}

end.
