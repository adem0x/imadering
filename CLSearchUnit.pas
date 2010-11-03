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

  private
    { Private declarations }
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
  OverbyteIcsUrl;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_CLSearchForm = 'cl_search_form';

{$ENDREGION}
{$REGION 'CLSearchEditChange'}

procedure TCLSearchForm.CLSearchEditChange(Sender: TObject);
var
  I: Integer;
begin
  // Делаем поиск совпадений введенных символов в учётных записях и никах
  // контактов в списке
  // Очищаем список контактов от предыдущего поиска
  CLSearchJvListView.Clear;
  // Сбрасываем стрелочки сортировки в других столбцах
  for I := 0 to CLSearchJvListView.Columns.Count - 1 do
    CLSearchJvListView.Columns[I].ImageIndex := -1;
  // Делаем поиск текста
  if CLSearchEdit.Text <> EmptyStr then
  begin
    {with RosterForm.RosterJvListView do
    begin
      for I := 0 to Items.Count - 1 do
      begin
        // Если это группы ICQ или NoCL, то пропускаем
        if (Length(Items[I].Caption) <= 4) or (Items[I].Caption = C_NoCL) then
          Continue;
        // Если нашли текст в учётной записи или нике
        if (Pos(WideUpperCase(CLSearchEdit.Text), WideUpperCase(Items[I].Caption)) > 0) or (Pos(WideUpperCase(CLSearchEdit.Text),
          WideUpperCase(URLDecode(Items[I].SubItems[0]))) > 0) then
        begin
          CLSearchJvListView.Items.Add.Caption := Items[I].Caption;
          CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].SubItems.Append(URLDecode(Items[I].SubItems[0]));
          CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].ImageIndex := StrToInt(Items[I].SubItems[6]);
        end;
      end;
    end;}
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

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
    //RosterForm.OpenChatPage(nil, CLSearchJvListView.Selected.Caption);
  end;
end;

procedure TCLSearchForm.CLSearchJvListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
{var
  CLItem: TButtonItem;}
begin
  // Если выделили контакт, то выделяем его и в КЛ
  if Selected then
  begin
    {CLItem := RosterForm.ReqCLContact(Item.Caption);
    if CLItem <> nil then
    begin
      // Выделяем этот контакт в КЛ
      MainForm.ContactList.SelectedItem := CLItem;
      if CLItem.Category.Collapsed then
        CLItem.Category.Collapsed := False;
      MainForm.ContactList.ScrollIntoView(CLItem);
    end;}
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
          XML_Node := Root.Items.ItemNamed[C_CLSearchForm];
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
        XML_Node := Root.Items.ItemNamed[C_CLSearchForm];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_CLSearchForm);
        // Сохраняем позицию окна
        XML_Node.Properties.Add('t', Top);
        XML_Node.Properties.Add('l', Left);
        XML_Node.Properties.Add('h', Height);
        XML_Node.Properties.Add('w', Width);
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

