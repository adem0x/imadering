{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqGroupManagerUnit;

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
  VarsUnit,
  ComCtrls;

type
  TIcqGroupManagerForm = class(TForm)
    GNameLabel: TLabel;
    GNameEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Name_Group: string;
    GroupType: string;
    Create_Group: Boolean;
    Id_Group: string;
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  IcqGroupManagerForm: TIcqGroupManagerForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  RosterUnit;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TIcqGroupManagerForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := S_Cancel;
end;

{$ENDREGION}
{$REGION 'OKButtonClick'}

procedure TIcqGroupManagerForm.OKButtonClick(Sender: TObject);
label
  X,
  Y;
var
  IClId: TStringList;
  I: Integer;
  NewId: string;
begin
  // Управляем группой по протоколу ICQ
  if GroupType = C_Icq then
    begin
      // Если фаза работы с серверным КЛ ещё активна, то ждём её окончания
      if ICQ_SSI_Phaze then
        begin
          DAShow(S_WarningHead, AddContactErr2, EmptyStr, 134, 2, 0);
          Exit;
        end;
      // Если это добавление новой групы
      if Create_Group then
        begin
          // Если название группы пустое, то выходим
          if GNameEdit.Text = EmptyStr then
            goto Y;
          // Ищем есть ли такая группа уже в Ростере
          with RosterForm.RosterJvListView do
            begin
              for I := 0 to Items.Count - 1 do
                begin
                  if (Items[I].SubItems[3] = C_Icq) and (LowerCase(GNameEdit.Text, LoUserLocale) = LowerCase(Items[I].SubItems[1], LoUserLocale)) then
                    begin
                      DAShow(S_WarningHead, AddNewGroupErr1, EmptyStr, 133, 0, 0);
                      Exit;
                    end;
                end;
            end;
          // Генерируем идентификатор для этой группы
        X :;
          Randomize;
          NewId := IntToHex(Random($7FFF), 4);
          // Ищем нет ли уже такого идентификатора в списке контактов
          with RosterForm.RosterJvListView do
            begin
              for I := 0 to Items.Count - 1 do
                begin
                  if NewId = Items[I].SubItems[4] then
                    goto X;
                end;
            end;
          // Открываем сессию и добавляем группу
          ICQ_Add_Nick := GNameEdit.Text;
          ICQ_Add_GroupId := NewId;
          ICQ_Add_Group_Phaze := True;
          ICQ_SSI_Phaze := True;
          ICQ_AddGroup(GNameEdit.Text, NewId);
        end
        // Переименовывание группы
      else
        begin
          // Если это нередактируемые группы, то выходим
          if (GNameEdit.Text = EmptyStr) or (GNameEdit.Text = Name_Group) or (Id_Group = EmptyStr) or (Id_Group = C_NoCL) or (Id_Group = '0000') or (Id_Group = '0001') then
            goto Y;
          // Запоминаем переменные для группы
          ICQ_Add_Nick := GNameEdit.Text;
          ICQ_Add_GroupId := Id_Group;
          // Создаём список для идентификаторов групп
          IClId := TStringList.Create;
          try
            // Заносим в список идентификаторы групп
            with RosterForm.RosterJvListView do
              begin
                for I := 0 to Items.Count - 1 do
                  begin
                    // Добавляем идентификаторы групп в список
                    if (Items[I].Caption = C_NoCL) or (Items[I].Caption = '0000') then
                      Continue;
                    if (Items[I].SubItems[3] = C_Icq) and (Length(Items[I].Caption) = 4) then
                      IClId.Add(Items[I].Caption);
                  end;
              end;
            // Обновляем имя группы на сервере
            ICQ_UpdateGroup_AddContact(GNameEdit.Text, Id_Group, IClId);
            // Переименовываем группу в локальном КЛ
            with RosterForm.RosterJvListView do
              begin
                for I := 0 to Items.Count - 1 do
                  begin
                    // Ищем в Ростере эту группу
                    if (Items[I].Caption = C_NoCL) or (Items[I].Caption = '0000') or (Items[I].Caption = '0001') then
                      Continue;
                    if (Items[I].SubItems[3] = C_Icq) and (Items[I].Caption = Id_Group) then
                      begin
                        Items[I].SubItems[1] := GNameEdit.Text;
                        // Строим локальный КЛ
                        RosterForm.UpdateFullCL;
                        Break;
                      end;
                  end;
              end;
          finally
            IClId.Free;
          end;
        end;
    end
    // Управляем группой по протоколу Jabber
  else if GroupType = S_Jabber then
    begin

    end
    // Управляем группой по протоколу MRA
  else if GroupType = S_Mra then
    begin

    end;
  // Выходим и закрываем модальное окно
Y :;
  ModalResult := MrOk;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TIcqGroupManagerForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(153, Icon);
  // Переводим форму на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqGroupManagerForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TIcqGroupManagerForm.FormShow(Sender: TObject);
begin
  // Ставим фокус в поле имени группы
  if GNameEdit.CanFocus then
    GNameEdit.SetFocus;
end;

{$ENDREGION}

end.
