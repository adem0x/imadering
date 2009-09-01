{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit CLSearchUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, VarsUnit, rXML;

type
  TCLSearchForm = class(TForm)
    CLSearchListView: TListView;
    Panel1: TPanel;
    Label1: TLabel;
    CLSearchEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLSearchEditChange(Sender: TObject);
    procedure CLSearchListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CLSearchListViewDblClick(Sender: TObject);
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
  MainUnit, UtilsUnit;

procedure TCLSearchForm.CLSearchEditChange(Sender: TObject);
var
  i, ii: integer;
begin
  //--Делаем поиск совпадений введенных символов в учётных записях и никах
  //контактов в списке
  //--Очищаем список контактов от предыдущего поиска
  CLSearchListView.Clear;
  if CLSearchEdit.Text <> '' then
  begin
    with MainForm.ContactList do
    begin
      for i := 0 to Categories.Count - 1 do
      begin
        for ii := 0 to Categories[i].Items.Count - 1 do
        begin
          //--Если нашли текст в учётной записи или нике
          if (BMSearch(0, UpperCase(Categories[i].Items[ii].UIN, loUserLocale), UpperCase(CLSearchEdit.Text, loUserLocale)) > -1) or
            (BMSearch(0, UpperCase(Categories[i].Items[ii].Caption, loUserLocale), UpperCase(CLSearchEdit.Text, loUserLocale)) > -1) then
          begin
            CLSearchListView.Items.Add.Caption := Categories[i].Items[ii].UIN;
            CLSearchListView.Items[CLSearchListView.Items.Count - 1].SubItems.Append(Categories[i].Items[ii].Caption);
            CLSearchListView.Items[CLSearchListView.Items.Count - 1].ImageIndex := Categories[i].Items[ii].ImageIndex;
          end;
        end;
      end;
    end;
  end;
end;

procedure TCLSearchForm.CLSearchListViewDblClick(Sender: TObject);
label
  x;
var
  i, ii: integer;
begin
  //--Если выделили контакт, то выделяем его и в КЛ
  if CLSearchListView.Selected <> nil then
  begin
    with MainForm.ContactList do
    begin
      for i := 0 to Categories.Count - 1 do
      begin
        for ii := 0 to Categories[i].Items.Count - 1 do
        begin
          if CLSearchListView.Selected.Caption = Categories[i].Items[ii].UIN then
          begin
            //--Делаем синхронный двойной клик на этом контакте в КЛ
            MainForm.ContactListButtonClicked(self, Categories[i].Items[ii]);
            MainForm.ContactListButtonClicked(self, Categories[i].Items[ii]);
            //--Выходим из цыклов
            goto x;
          end;
        end;
      end;
    end;
  end;
  x: ;
end;

procedure TCLSearchForm.CLSearchListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
label
  x;
var
  i, ii: integer;
begin
  //--Если выделили контакт, то выделяем его и в КЛ
  if Selected then
  begin
    with MainForm.ContactList do
    begin
      for i := 0 to Categories.Count - 1 do
      begin
        for ii := 0 to Categories[i].Items.Count - 1 do
        begin
          if Item.Caption = Categories[i].Items[ii].UIN then
          begin
            //--Выделяем этот контакт в КЛ
            MainForm.ContactList.SelectedItem := Categories[i].Items[ii];
            if Categories[i].Items[ii].Category.Collapsed then Categories[i].Items[ii].Category.Collapsed := false;
            MainForm.ContactList.ScrollIntoView(Categories[i].Items[ii]);
            //--Выходим из цыклов
            goto x;
          end;
        end;
      end;
    end;
  end;
  x: ;
end;

procedure TCLSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Выводим окно списка контактов на передний план
  BringWindowToTop(MainForm.Handle);
  //--Указываем текущему окну уничтожиться после закрытия
  Action := caFree;
  CLSearchForm := nil;
end;

procedure TCLSearchForm.FormCreate(Sender: TObject);
begin
  //--Инициализируем XML
  With TrXML.Create() do try
    //--Загружаем настройки
    if FileExists(ProfilePath + SettingsFileName) then begin
      LoadFromFile(ProfilePath + SettingsFileName);
      //--Загружаем позицию окна
      if OpenKey('settings\forms\clsearchform\position') then try
        Top := ReadInteger('top');
        Left := ReadInteger('left');
        Height := ReadInteger('height');
        Width := ReadInteger('width');
        //--Определяем не находится ли окно за пределами экрана
        while Top + Height > Screen.Height do
          Top := Top - 50;
        while Left + Width > Screen.Width do
          Left := Left - 50;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
  //--Переводим окно на другие языки
  TranslateForm;
  //--Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(215, Icon);
  //--Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TCLSearchForm.FormDestroy(Sender: TObject);
begin
  //--Создаём необходимые папки
  ForceDirectories(ProfilePath + 'Profile');
  //--Сохраняем настройки положения окна в xml
  With TrXML.Create() do try
    if FileExists(ProfilePath + SettingsFileName) then
      LoadFromFile(ProfilePath + SettingsFileName);
    //--Сохраняем позицию окна
    if OpenKey('settings\forms\clsearchform\position', True) then try
      WriteInteger('top', Top);
      WriteInteger('left', Left);
      WriteInteger('height', Height);
      WriteInteger('width', Width);
    finally
      CloseKey();
    end;
    //--Записываем сам файл
    SaveToFile(ProfilePath + SettingsFileName);
  finally
    Free();
  end;
end;

procedure TCLSearchForm.TranslateForm;
begin
  //--Переводим окно на другие языки

end;

end.

