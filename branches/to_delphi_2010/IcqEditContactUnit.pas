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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CategoryButtons;

type
  TIcqEditContactForm = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IcqEditContactForm: TIcqEditContactForm;

implementation

{$R *.dfm}

uses
  IcqProtoUnit, VarsUnit;

procedure TIcqEditContactForm.Button1Click(Sender: TObject);
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
    (RoasterForm.Roaster_Sel_Button.GroupId = 'NoCL') then goto x;
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

procedure TIcqEditContactForm.Edit2KeyPress(Sender: TObject; var Key: Char);
const
  ValidAsciiChars = ['0' .. '9', '+'];
begin
  if (not(Key in ValidAsciiChars)) and (Key <> #8) then
    Key := #0;
end;

end.
