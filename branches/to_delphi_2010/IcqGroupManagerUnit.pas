{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqGroupManagerUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VarsUnit, ComCtrls;

type
  TIcqGroupManagerForm = class(TForm)
    GNameLabel: TLabel;
    GNameEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Name_Group: string;
    GroupType: string;
    Create_Group: boolean;
    Id_Group: string;
    procedure TranslateForm;
  end;

var
  IcqGroupManagerForm: TIcqGroupManagerForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UtilsUnit, RosterUnit;

procedure TIcqGroupManagerForm.TranslateForm;
begin
  // Переводим форму на другие языки

end;

procedure TIcqGroupManagerForm.OKButtonClick(Sender: TObject);
label x, y;
var
  iClId: TStringList;
  i: integer;
  newId: string;
begin
  // Управляем группой по протоколу ICQ
  if GroupType = 'Icq' then
  begin
    // Если фаза работы с серверным КЛ ещё активна, то ждём её окончания
    if ICQ_SSI_Phaze then
    begin
      DAShow(WarningHead, AddContactErr2, EmptyStr, 134, 2, 0);
      Exit;
    end;
    // Если это добавление новой групы
    if Create_Group then
    begin
      // Если название группы пустое, то выходим
      if GNameEdit.Text = EmptyStr then
        goto y;
      // Ищем есть ли такая группа уже в Ростере
      with RosterForm.RosterJvListView do
      begin
        for i := 0 to Items.Count - 1 do
        begin
          if (Items[i].SubItems[3] = 'Icq') and
            (LowerCase(GNameEdit.Text, loUserLocale) = LowerCase
              (Items[i].SubItems[1], loUserLocale)) then
          begin
            DAShow(WarningHead, AddNewGroupErr1, EmptyStr, 133, 0, 0);
            Exit;
          end;
        end;
      end;
      // Генерируем идентификатор для этой группы
    x :;
      Randomize;
      newId := IntToHex(Random($7FFF), 4);
      // Ищем нет ли уже такого идентификатора в списке контактов
      with RosterForm.RosterJvListView do
      begin
        for i := 0 to Items.Count - 1 do
        begin
          if newId = Items[i].SubItems[4] then
            goto x;
        end;
      end;
      // Открываем сессию и добавляем группу
      ICQ_Add_Nick := GNameEdit.Text;
      ICQ_Add_GroupId := newId;
      ICQ_Add_Group_Phaze := true;
      ICQ_SSI_Phaze := true;
      ICQ_AddGroup(GNameEdit.Text, newId);
    end
    // Переименовывание группы
    else
    begin
      // Если это нередактируемые группы, то выходим
      if (GNameEdit.Text = EmptyStr) or (GNameEdit.Text = Name_Group) or
        (Id_Group = EmptyStr) or (Id_Group = 'NoCL') or (Id_Group = '0000') or
        (Id_Group = '0001') then
        goto y;
      // Запоминаем переменные для группы
      ICQ_Add_Nick := GNameEdit.Text;
      ICQ_Add_GroupId := Id_Group;
      // Создаём список для идентификаторов групп
      iClId := TStringList.Create;
      try
        // Заносим в список идентификаторы групп
        with RosterForm.RosterJvListView do
        begin
          for i := 0 to Items.Count - 1 do
          begin
            // Добавляем идентификаторы групп в список
            if (Items[i].Caption = 'NoCL') or (Items[i].Caption = '0000') then
              Continue;
            if (Items[i].SubItems[3] = 'Icq') and
              (Length(Items[i].Caption) = 4) then
              iClId.Add(Items[i].Caption);
          end;
        end;
        // Обновляем имя группы на сервере
        ICQ_UpdateGroup_AddContact(GNameEdit.Text, Id_Group, iClId);
        // Переименовываем группу в локальном КЛ
        with RosterForm.RosterJvListView do
        begin
          for i := 0 to Items.Count - 1 do
          begin
            // Ищем в Ростере эту группу
            if (Items[i].Caption = 'NoCL') or (Items[i].Caption = '0000') or
              (Items[i].Caption = '0001') then
              Continue;
            if (Items[i].SubItems[3] = 'Icq') and (Items[i].Caption = Id_Group)
              then
            begin
              Items[i].SubItems[1] := GNameEdit.Text;
              // Строим локальный КЛ
              RosterForm.UpdateFullCL;
              Break;
            end;
          end;
        end;
      finally
        iClId.Free;
      end;
    end;
  end
  // Управляем группой по протоколу Jabber
  else if GroupType = 'Jabber' then
  begin

  end
  // Управляем группой по протоколу MRA
  else if GroupType = 'Mra' then
  begin

  end;
  // Выходим и закрываем модальное окно
y :;
  ModalResult := mrOk;
end;

procedure TIcqGroupManagerForm.FormCreate(Sender: TObject);
begin
  // Переводим форму на другие языки
  TranslateForm;
end;

procedure TIcqGroupManagerForm.FormShow(Sender: TObject);
begin
  // Ставим фокус в поле имени группы
  if GNameEdit.CanFocus then
    GNameEdit.SetFocus;
end;

end.
