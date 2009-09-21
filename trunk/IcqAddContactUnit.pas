{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqAddContactUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VarsUnit, ComCtrls;

type
  TIcqAddContactForm = class(TForm)
    AccountEdit: TEdit;
    NameEdit: TEdit;
    GroupComboBox: TComboBox;
    CancelButton: TButton;
    AddContactButton: TButton;
    AccountLabel: TLabel;
    NameLabel: TLabel;
    GroupLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure AddContactButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ContactType: string;
    procedure TranslateForm;
    procedure BuildGroupList(gProto: string);
  end;

var
  IcqAddContactForm: TIcqAddContactForm;

implementation

uses MainUnit, IcqProtoUnit, UtilsUnit, RosterUnit;

{$R *.dfm}

procedure TIcqAddContactForm.BuildGroupList(gProto: string);
var
  i: integer;
begin
  //--Составляем список групп из Ростера
  with RosterForm.RosterJvListView do
  begin
    //--Список для ICQ
    if gProto = 'Icq' then
    begin
      for i := 0 to Items.Count - 1 do
      begin
        if (Items[i].SubItems[3] = 'Icq') and (Length(Items[i].Caption) = 4) then
        begin
          if Items[i].Caption = '0000' then Continue; //--Группа временных контактов
          if (Items[i].Caption = 'NoCL') or (Items[i].Caption = '0001') then Continue; //--Группа "Не в списке"
          GroupComboBox.Items.Add(Items[i].SubItems[1]);
        end;
      end;
    end
    //--Список для Jabber
    else if gProto = 'Jabber' then
    begin

    end
    //--Список для Mra
    else if gProto = 'Mra' then
    begin

    end;
  end;
  //--Выставляем по умолчанию первую группу в списке выбора групп
  if GroupComboBox.Items.Count > 0 then GroupComboBox.ItemIndex := 0;
end;

procedure TIcqAddContactForm.TranslateForm;
begin
  //--Переводим форму на другие языки

end;

procedure TIcqAddContactForm.AddContactButtonClick(Sender: TObject);
label
  x, y;
var
  RosterItem: TListItem;
  newId, iGpId: string;
  i: integer;
begin
  //--Добавляем контакты по протоколу ICQ
  if ContactType = 'Icq' then
  begin
    if ICQ_Work_Phaze then
    begin
      if (AccountEdit.Text <> EmptyStr) and (Length(AccountEdit.Text) > 4) then
      begin
        //--Нормализуем ICQ номер
        AccountEdit.Text := exNormalizeScreenName(AccountEdit.Text);
        AccountEdit.Text := exNormalizeIcqNumber(AccountEdit.Text);
        if Trim(NameEdit.Text) = EmptyStr then NameEdit.Text := AccountEdit.Text;
        //--Ищем такой контакт в Ростере
        RosterItem := RosterForm.ReqRosterItem(AccountEdit.Text);
        if RosterItem <> nil then //--Если такой контакт уже добавлен в список, то сообщаем об этом
        begin
          DAShow(WarningHead, AddContactErr1, EmptyStr, 133, 0, 0);
          Exit;
        end;
        //--Если фаза добавления контакта ещё активна, то ждём её окончания
        if ICQ_SSI_Phaze then
        begin
          DAShow(WarningHead, AddContactErr2, EmptyStr, 134, 2, 0);
          Exit;
        end;
        //--Если группа не выбрана
        if GroupComboBox.ItemIndex = -1 then
        begin
          DAShow(AlertHead, AddContactErr3, EmptyStr, 134, 2, 0);
          goto y;
        end;
        //--Генерируем идентификатор для этого контакта
        x: ;
        Randomize;
        newId := IntToHex(Random($7FFF), 4);
        //--Ищем нет ли уже такого идентификатора в списке контактов
        with RosterForm.RosterJvListView do
        begin
          for i := 0 to Items.Count - 1 do
          begin
            if newId = Items[i].SubItems[4] then goto x;
          end;
          //--Ищем идентификатор выбранной группы
          for i := 0 to Items.Count - 1 do
          begin
            if (Items[i].SubItems[1] = GroupComboBox.Text) and (Items[i].SubItems[3] = 'Icq') then
            begin
              iGpId := Items[i].SubItems[4];
              Break;
            end;
          end;
        end;
        //--Открываем сессию и добавляем контакт
        ICQ_Add_Contact_Phaze := true;
        ICQ_SSI_Phaze := true;
        ICQ_AddContact(AccountEdit.Text, iGpId, newId, NameEdit.Text, false);
      end;
    end;
  end
  //--Добавляем контакты по протоколу Jabber
  else if ContactType = 'Jabber' then
  begin

  end
  //--Добавляем контакты по протоколу Mra
  else if ContactType = 'Mra' then
  begin

  end;
  //--Выходим и закрываем модальное окно
  y: ;
  ModalResult := mrOk;
end;

procedure TIcqAddContactForm.FormCreate(Sender: TObject);
begin
  //--Переводим форму на другие языки
  TranslateForm;
  //--Присваиваем иконку окну
  MainForm.AllImageList.GetIcon(143, Icon);
end;

procedure TIcqAddContactForm.FormShow(Sender: TObject);
begin
  //--Ставим фокус в поле ввода учётной записи если она пустая
  if (AccountEdit.CanFocus) and (AccountEdit.Text = EmptyStr) then AccountEdit.SetFocus;
end;

end.

