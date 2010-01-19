{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqEditContactUnit;

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
  CategoryButtons;

type
  TIcqEditContactForm = class(TForm)
    NickEdit: TEdit;
    PhoneEdit: TEdit;
    EmailEdit: TEdit;
    NoteMemo: TMemo;
    NickLabel: TLabel;
    PhoneLabel: TLabel;
    EmailLabel: TLabel;
    NoteLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure PhoneEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  IcqEditContactForm: TIcqEditContactForm;

implementation

{$R *.dfm}

uses
  IcqProtoUnit,
  VarsUnit,
  UtilsUnit,
  MainUnit;

procedure TIcqEditContactForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := S_Cancel;
end;

procedure TIcqEditContactForm.OKButtonClick(Sender: TObject);
{ label
  x;
  var
  i, ii: integer; }
begin
  { if not ICQ_Work_Phaze then goto x;
    if Edit1.Text = EmptyStr then goto x;
    if RoasterForm.Roaster_Sel_Button = nil then goto x;
    //
    if (RoasterForm.Roaster_Sel_Button.GroupId = '0000') or
    (RoasterForm.Roaster_Sel_Button.GroupId = S_NoCL) then goto x;
    ICQ_RenameAndEditContact(RoasterForm.Roaster_Sel_Button.UIN,
    RoasterForm.Roaster_Sel_Button.GroupId, RoasterForm.Roaster_Sel_Button.Idd,
    Edit1.Text, Edit2.Text, Edit3.Text, Memo1.Text);
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
    for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
    begin
    if RoasterForm.CategoryButtons1.Categories[i].Items[ii].UIN = RoasterForm.Roaster_Sel_Button.UIN then
    begin
    RoasterForm.CategoryButtons1.Categories[i].Items[ii].Caption := Edit1.Text;
    RoasterForm.CategoryButtons1.Categories[i].Items[ii].Mobile := Edit2.Text;
    RoasterForm.CategoryButtons1.Categories[i].Items[ii].Email := Edit3.Text;
    RoasterForm.CategoryButtons1.Categories[i].Items[ii].Note := Memo1.Text;
    RoasterForm.CategoryButtons1.Categories[i].Items[ii].Hint := ICQ_CreateHint(RoasterForm.CategoryButtons1.Categories[i].Items[ii]);
    //
    Break;
    end;
    end;
    end;
    //
    if (OnlyOnlineUsersCL) or (NoGroupModeCL) then
    begin
    OnlyOnlineUsersCL := not OnlyOnlineUsersCL;
    RoasterForm.ToolButton9Click(self);
    end;
    //
    x: ;
    ModalResult := mrOk; }
end;

procedure TIcqEditContactForm.PhoneEditKeyPress(Sender: TObject; var Key: Char);
const
  ValidChars = ['0' .. '9', '+'];
begin
  if (not CharInSet(Key, ValidChars)) and (Key <> #8) then
    Key := #0;
end;

procedure TIcqEditContactForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(141, Icon);
  // Переводим форму на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

end.
