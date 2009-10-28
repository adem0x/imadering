{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit CLSearchUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, VarsUnit, rXML, JvExComCtrls, JvListView,
  CategoryButtons, ComCtrls, ExtCtrls;

type
  TCLSearchForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    CLSearchEdit: TEdit;
    CLSearchJvListView: TJvListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLSearchEditChange(Sender: TObject);
    procedure CLSearchJvListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CLSearchJvListViewDblClick(Sender: TObject);
    procedure CLSearchJvListViewColumnClick
      (Sender: TObject; Column: TListColumn);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  CLSearchForm: TCLSearchForm;

implementation

{$R *.dfm}

uses
  MainUnit, UtilsUnit, RosterUnit;

procedure TCLSearchForm.CLSearchEditChange(Sender: TObject);
var
  i: integer;
begin
  // Делаем поиск совпадений введенных символов в учётных записях и никах
  // контактов в списке
  // Очищаем список контактов от предыдущего поиска
  CLSearchJvListView.Clear;
  // Сбрасываем стрелочки сортировки в других столбцах
  for i := 0 to CLSearchJvListView.Columns.Count - 1 do
    CLSearchJvListView.Columns[i].ImageIndex := -1;
  // Делаем поиск текста
  if CLSearchEdit.Text <> '' then
  begin
    with RosterForm.RosterJvListView do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        // Если это группы ICQ или NoCL, то пропускаем
        if ((Length(Items[i].Caption) = 4) and (Items[i].SubItems[3] = 'Icq'))
          or (Items[i].Caption = 'NoCL') then
          Continue;
        // Если нашли текст в учётной записи или нике
        if (BMSearch(0, UpperCase(Items[i].Caption, loUserLocale), UpperCase
              (CLSearchEdit.Text, loUserLocale)) > -1) or
          (BMSearch(0, UpperCase(Items[i].SubItems[0], loUserLocale), UpperCase
              (CLSearchEdit.Text, loUserLocale)) > -1) then
        begin
          CLSearchJvListView.Items.Add.Caption := Items[i].Caption;
          CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1]
            .SubItems.Append(Items[i].SubItems[0]);
          CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1]
            .ImageIndex := StrToInt(Items[i].SubItems[6]);
        end;
      end;
    end;
  end;
end;

procedure TCLSearchForm.CLSearchJvListViewColumnClick
  (Sender: TObject; Column: TListColumn);
var
  i: integer;
begin
  // Выставляем стрелочку сортировки
  if Column.ImageIndex <> 234 then
    Column.ImageIndex := 234
  else
    Column.ImageIndex := 233;
  // Сбрасываем стрелочки сортировки в других столбцах
  for i := 0 to CLSearchJvListView.Columns.Count - 1 do
    if CLSearchJvListView.Columns[i] <> Column then
      CLSearchJvListView.Columns[i].ImageIndex := -1;
end;

procedure TCLSearchForm.CLSearchJvListViewDblClick(Sender: TObject);
begin
  // Если выделили контакт, то выделяем его и в КЛ
  if CLSearchJvListView.Selected <> nil then
  begin
    // Открываем чат с этим контактом
    //RosterForm.OpenChatPage(CLSearchJvListView.Selected.Caption);
  end;
end;

procedure TCLSearchForm.CLSearchJvListViewSelectItem
  (Sender: TObject; Item: TListItem; Selected: Boolean);
var
  CLItem: TButtonItem;
begin
  // Если выделили контакт, то выделяем его и в КЛ
  if Selected then
  begin
    CLItem := RosterForm.ReqCLContact(Item.Caption);
    if CLItem <> nil then
    begin
      // Выделяем этот контакт в КЛ
      MainForm.ContactList.SelectedItem := CLItem;
      if CLItem.Category.Collapsed then
        CLItem.Category.Collapsed := false;
      MainForm.ContactList.ScrollIntoView(CLItem);
    end;
  end;
end;

procedure TCLSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим окно списка контактов на передний план
  BringWindowToTop(MainForm.Handle);
  // Уничтожаем окно
  CLSearchJvListView.HeaderImages := nil;
  Action := caFree;
  CLSearchForm := nil;
end;

procedure TCLSearchForm.FormCreate(Sender: TObject);
begin
  // Инициализируем XML
  with TrXML.Create() do
    try
      // Загружаем настройки
      if FileExists(ProfilePath + SettingsFileName) then
      begin
        LoadFromFile(ProfilePath + SettingsFileName);
        // Загружаем позицию окна
        if OpenKey('settings\forms\clsearchform\position') then
          try
            Top := ReadInteger('top');
            Left := ReadInteger('left');
            Height := ReadInteger('height');
            Width := ReadInteger('width');
            // Определяем не находится ли окно за пределами экрана
            MainForm.FormSetInWorkArea(self);
          finally
            CloseKey();
          end;
      end;
    finally
      Free();
    end;
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(215, Icon);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE)
      or WS_EX_APPWINDOW);
end;

procedure TCLSearchForm.FormDestroy(Sender: TObject);
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile');
  // Сохраняем настройки положения окна в xml
  with TrXML.Create() do
    try
      if FileExists(ProfilePath + SettingsFileName) then
        LoadFromFile(ProfilePath + SettingsFileName);
      // Сохраняем позицию окна
      if OpenKey('settings\forms\clsearchform\position', True) then
        try
          WriteInteger('top', Top);
          WriteInteger('left', Left);
          WriteInteger('height', Height);
          WriteInteger('width', Width);
        finally
          CloseKey();
        end;
      // Записываем сам файл
      SaveToFile(ProfilePath + SettingsFileName);
    finally
      Free();
    end;
end;

procedure TCLSearchForm.TranslateForm;
begin
  // Переводим окно на другие языки

end;

end.
