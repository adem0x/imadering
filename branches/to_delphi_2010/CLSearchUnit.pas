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
  RXML,
  JvExComCtrls,
  JvListView,
  CategoryButtons,
  ComCtrls,
  ExtCtrls;

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
  MainUnit,
  UtilsUnit,
  RosterUnit;

resourcestring
  RS_CLSearchFormPos = 'settings\forms\clsearchform\position';

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
  if CLSearchEdit.Text <> '' then
    begin
      with RosterForm.RosterJvListView do
        begin
          for I := 0 to Items.Count - 1 do
            begin
              // Если это группы ICQ или NoCL, то пропускаем
              if ((Length(Items[I].Caption) = 4) and (Items[I].SubItems[3] = S_Icq)) or (Items[I].Caption = S_NoCL) then
                Continue;
              // Если нашли текст в учётной записи или нике
              if (Pos(UpperCase(CLSearchEdit.Text, LoUserLocale), UpperCase(Items[I].Caption, LoUserLocale)) > 0) or
                (Pos(UpperCase(CLSearchEdit.Text, LoUserLocale), UpperCase(Items[I].SubItems[0], LoUserLocale)) > 0) then
                begin
                  CLSearchJvListView.Items.Add.Caption := Items[I].Caption;
                  CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].SubItems.Append(Items[I].SubItems[0]);
                  CLSearchJvListView.Items[CLSearchJvListView.Items.Count - 1].ImageIndex := StrToInt(Items[I].SubItems[6]);
                end;
            end;
        end;
    end;
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
      RosterForm.OpenChatPage(nil, CLSearchJvListView.Selected.Caption);
    end;
end;

procedure TCLSearchForm.CLSearchJvListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
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
            CLItem.Category.Collapsed := False;
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
  Action := CaFree;
  CLSearchForm := nil;
end;

procedure TCLSearchForm.FormCreate(Sender: TObject);
var
  XmlFile: TrXML;
begin
  // Инициализируем XML
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        // Загружаем настройки
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            // Загружаем позицию окна
            if OpenKey(RS_CLSearchFormPos) then
              try
                Top := ReadInteger('top');
                Left := ReadInteger('left');
                Height := ReadInteger('height');
                Width := ReadInteger('width');
                // Определяем не находится ли окно за пределами экрана
                MainForm.FormSetInWorkArea(Self);
              finally
                CloseKey;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(215, Icon);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TCLSearchForm.FormDestroy(Sender: TObject);
var
  XmlFile: TrXML;
begin
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  // Сохраняем настройки положения окна в xml
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        // Сохраняем позицию окна
        if OpenKey(RS_CLSearchFormPos, True) then
          try
            WriteInteger('top', Top);
            WriteInteger('left', Left);
            WriteInteger('height', Height);
            WriteInteger('width', Width);
          finally
            CloseKey;
          end;
        // Записываем сам файл
        SaveToFile(ProfilePath + SettingsFileName);
      end;
  finally
    FreeAndNil(XmlFile);
  end;
end;

procedure TCLSearchForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  //CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

end.
