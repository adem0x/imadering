{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit AddContactUnit;

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
  ComCtrls,
  JvSimpleXml;

type
  TAddContactForm = class(TForm)
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
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    ContactType: string;
    procedure TranslateForm;
    procedure BuildGroupList(GProto, xId: string);
  end;

{$ENDREGION}

var
  AddContactForm: TAddContactForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  RosterUnit,
  OverbyteIcsUrl;

{$ENDREGION}
{$REGION 'BuildGroupList'}

procedure TAddContactForm.BuildGroupList(GProto, xId: string);
var
  Z: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  GId: string;
begin
  // Составляем список групп из Ростера
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        XML_Node := Root.Items.ItemNamed[GProto];
        if XML_Node <> nil then
        begin
          // Открываем раздел групп
          Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
          if Sub_Node <> nil then
          begin
            if GProto = C_Icq then // Список для ICQ
            begin
              for Z := 0 to Sub_Node.Items.Count - 1 do
              begin
                Tri_Node := Sub_Node.Items.Item[Z];
                if Tri_Node <> nil then
                begin
                  GId := Tri_Node.Properties.Value(C_Id);
                  if (GId <> '0000') and (GId <> C_NoCL) and (GId <> C_IgCL) then
                    GroupComboBox.Items.Add(UrlDecode(Tri_Node.Properties.Value(C_Name)) + C_BN + C_QN + Tri_Node.Properties.Value(C_Id) + C_EN);
                end;
              end;
            end
            else if GProto = C_Jabber then // Список для Jabber
            begin

            end
            else if GProto = C_Mra then // Список для Mra
            begin

            end;
          end;
        end;
      end;
    end;
  end;
  // Выставляем по умолчанию первую группу в списке выбора групп
  if GroupComboBox.Items.Count > 0 then
  begin
    GroupComboBox.ItemIndex := 0;
    // Выставляем группу выбранную в КЛ
    if xId <> EmptyStr then
    begin
      for Z := 0 to GroupComboBox.Items.Count - 1 do
      begin
        if IsolateTextString(GroupComboBox.Items.Strings[Z], C_QN, C_EN) = xId then
          GroupComboBox.ItemIndex := Z;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TAddContactForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := Lang_Vars[9].L_S;
end;

{$ENDREGION}
{$REGION 'AddContactButtonClick'}

procedure TAddContactForm.AddContactButtonClick(Sender: TObject);
label
  X,
    Y;
var
  NewId, GId, Nick: string;
  Get_Node: TJvSimpleXmlElem;
begin
  // Добавляем контакты по протоколу ICQ
  if ContactType = C_Icq then
  begin
    // Проверяем в сети ли этот протокол
    if NotProtoOnline(C_Icq) then
      Exit;
    if AccountEdit.Text <> EmptyStr then
    begin
      // Нормализуем ICQ номер
      AccountEdit.Text := NormalizeScreenName(AccountEdit.Text);
      AccountEdit.Text := NormalizeIcqNumber(AccountEdit.Text);
      if Trim(NameEdit.Text) = EmptyStr then
        NameEdit.Text := AccountEdit.Text;
      // Ограничиваем длинну ника
      Nick := NameEdit.Text;
      if Length(Nick) > 20 then
        SetLength(Nick, 20);
      // Ищем такой контакт в Ростере
      Get_Node := RosterGetItem(C_Icq, C_Contact + C_SS, C_Login, AccountEdit.Text);
      if Get_Node <> nil then
      begin
        DAShow(Lang_Vars[19].L_S + C_BN + C_Icq, Lang_Vars[103].L_S, EmptyStr, 133, 0, 0);
        Exit;
      end
      else
      begin
        // Если фаза добавления контакта ещё активна, то ждём её окончания
        if ICQ_SSI_Phaze then
        begin
          DAShow(Lang_Vars[19].L_S + C_BN + C_Icq, Lang_Vars[104].L_S, EmptyStr, 134, 2, 0);
          Exit;
        end;
        // Если группа не выбрана
        if GroupComboBox.ItemIndex = -1 then
        begin
          DAShow(Lang_Vars[18].L_S, Lang_Vars[105].L_S, EmptyStr, 134, 2, 0);
          goto Y;
        end;
        // Генерируем идентификатор для этого контакта
        X: ;
        Randomize;
        NewId := IntToHex(Random($7FFF), 4);
        // Ищем нет ли уже такого идентификатора в списке контактов
        Get_Node := RosterGetItem(C_Icq, C_Contact + C_SS, C_Id, NewId);
        if Get_Node <> nil then
          goto X;
        // Получаем идентификатор выбранной группы
        GId := IsolateTextString(GroupComboBox.Text, C_QN, C_EN);
        // Открываем сессию и добавляем контакт
        if (NewId <> EmptyStr) and (GId <> EmptyStr) then
        begin
          ICQ_SSI_Phaze := True;
          ICQ_Add_Contact_Phaze := True;
          ICQ_Add_Group_Name := Trim(Parse(C_QN, GroupComboBox.Text, 1));
          ICQ_AddContact(AccountEdit.Text, GId, NewId, Nick, False);
        end;
      end;
    end;
  end
  else if ContactType = C_Jabber then // Добавляем контакты по протоколу Jabber
  begin

  end
  else if ContactType = C_Mra then // Добавляем контакты по протоколу Mra
  begin

  end;
  // Выходим и закрываем модальное окно}
  Y: ;
  ModalResult := MrOk;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TAddContactForm.FormCreate(Sender: TObject);
begin
  // Переводим форму на другие языки
  TranslateForm;
  // Присваиваем иконку окну
  MainForm.AllImageList.GetIcon(143, Icon);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TAddContactForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TAddContactForm.FormShow(Sender: TObject);
begin
  // Ставим фокус в поле ввода учётной записи если она пустая
  if (AccountEdit.CanFocus) and (AccountEdit.Text = EmptyStr) then
    AccountEdit.SetFocus;
  // Подставляем название протокола в заголовок
  Caption := Caption + C_BN + ContactType;
end;

{$ENDREGION}

end.

