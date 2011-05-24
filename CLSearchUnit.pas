{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit CLSearchUnit;

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
  VarsUnit,
  JvExComCtrls,
  JvListView,
  CategoryButtons,
  ComCtrls,
  ExtCtrls,
  JvSimpleXml;

type
  TCLSearchForm = class(TForm)
    TopPanel: TPanel;
    CLSearchLabel: TLabel;
    CLSearchEdit: TEdit;
    CLSearchJvListView: TJvListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLSearchEditChange(Sender: TObject);
    procedure CLSearchJvListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure CLSearchJvListViewDblClick(Sender: TObject);
    procedure CLSearchJvListViewColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormDblClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);

  private
    { Private declarations }
    f_t, f_l, f_h, f_w: integer;
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  CLSearchForm: TCLSearchForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  OverbyteIcsUrl,
  RosterUnit;

{$ENDREGION}
{$REGION 'CLSearchEditChange'}

procedure TCLSearchForm.CLSearchEditChange(Sender: TObject);
var
  I: Integer;
  SearchText: string;

  procedure FindInRoster(Proto: string);
  var
    Z: Integer;
    XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
    UIN, Nick: string;
  begin
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[Proto];
          if XML_Node <> nil then
          begin
            // Открываем раздел контактов
            Sub_Node := XML_Node.Items.ItemNamed[C_Contact + 's'];
            if Sub_Node <> nil then
            begin
              // Ищем параметр этого контакта
              for Z := 0 to Sub_Node.Items.Count - 1 do
              begin
                Tri_Node := Sub_Node.Items.Item[Z];
                if Tri_Node <> nil then
                begin
                  UIN := WideUpperCase(UrlDecode(Tri_Node.Properties.Value(C_Login)));
                  Nick := WideUpperCase(UrlDecode(Tri_Node.Properties.Value(C_Nick)));
                  // Если нашли текст в учётной записи или нике
                  if (Pos(SearchText, UIN) > 0) or (Pos(SearchText, Nick) > 0) then
                  begin
                    CLSearchJvListView.Items.BeginUpdate;
                    CLSearchJvListView.Items.Add.Caption := URLDecode(Tri_Node.Properties.Value(C_Login));
                    CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].SubItems.Append(URLDecode(Tri_Node.Properties.Value(C_Nick)));
                    CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].SubItems.Append(Proto);
                    CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].ImageIndex := StrToInt(Tri_Node.Properties.Value(C_Status));
                    CLSearchJvListView.Items.EndUpdate;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

begin
  // Делаем поиск совпадений введенных символов в учётных записях и никах контактов в списке
  // Очищаем список контактов от предыдущего поиска
  CLSearchJvListView.Clear;
  // Сбрасываем стрелочки сортировки в других столбцах
  for I := 0 to CLSearchJvListView.Columns.Count - 1 do
    CLSearchJvListView.Columns[I].ImageIndex := -1;
  // Делаем поиск текста
  if CLSearchEdit.Text <> EmptyStr then
  begin
    SearchText := WideUpperCase(CLSearchEdit.Text);
    // Ищем раздел нужного нам протокола
    if MainForm.ICQToolButton.Visible then
      FindInRoster(C_Icq);
    if MainForm.JabberToolButton.Visible then
      FindInRoster(C_Jabber);
    if MainForm.MRAToolButton.Visible then
      FindInRoster(C_Mra);
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TCLSearchForm.FormDeactivate(Sender: TObject);
begin
  // Сбрасываем выделенние
  CLSearchJvListView.Selected := nil;
end;

procedure TCLSearchForm.CLSearchJvListViewColumnClick(Sender: TObject; Column: TListColumn);
var
  I: Integer;
begin
  // Выставляем стрелочку сортировки
  if Column.ImageIndex <> 234 then
    Column.ImageIndex := 234
  else
    Column.ImageIndex := 233;
  // Сбрасываем стрелочки сортировки в других столбцах
  for I := 0 to CLSearchJvListView.Columns.Count - 1 do
    if CLSearchJvListView.Columns[I] <> Column then
      CLSearchJvListView.Columns[I].ImageIndex := -1;
end;

procedure TCLSearchForm.CLSearchJvListViewDblClick(Sender: TObject);
begin
  // Если выделили контакт, то выделяем его и в КЛ
  if CLSearchJvListView.Selected <> nil then
  begin
    // Открываем чат с этим контактом
    MainForm.SendMessageForContactClick(nil);
  end;
end;

procedure TCLSearchForm.CLSearchJvListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  KL_Item: TButtonItem;
begin
  // Если выделили контакт, то выделяем его и в КЛ
  if Selected then
  begin
    // Отключаем режим КЛ только онлайн контакты
    if MainForm.OnlyOnlineContactsToolButton.Down then
    begin
      MainForm.OnlyOnlineContactsToolButton.Down := false;
      MainForm.OnlyOnlineContactsToolButtonClick(nil);
    end;
    // Получаем этот контакт в КЛ
    KL_Item := ReqCLContact(Item.SubItems[1], UrlEncode(Item.Caption));
    if KL_Item <> nil then
    begin
      // Выделяем этот контакт в КЛ
      MainForm.ContactList.SelectedItem := KL_Item;
      if KL_Item.Category.Collapsed then
        KL_Item.Category.Collapsed := False;
      MainForm.ContactList.ScrollIntoView(KL_Item);
    end
    else
      MainForm.ContactList.SelectedItem := nil;
  end;
end;

procedure TCLSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим окно списка контактов на передний план
  BringWindowToTop(MainForm.Handle);
  // Уничтожаем окно
  CLSearchJvListView.HeaderImages := nil;
  Action := CaFree;
  CLSearchForm := nil;
end;

procedure TCLSearchForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TCLSearchForm.FormCreate(Sender: TObject);
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
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(215, Icon);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure TCLSearchForm.FormDestroy(Sender: TObject);
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
{$REGION 'TranslateForm'}

procedure TCLSearchForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}

end.

