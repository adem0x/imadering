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
  Dialogs, StdCtrls, VarsUnit;

type
  TIcqAddContactForm = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  IcqAddContactForm: TIcqAddContactForm;

implementation

uses MainUnit, IcqProtoUnit, UtilsUnit;

{$R *.dfm}

procedure TIcqAddContactForm.TranslateForm;
begin
  //--
  
end;

procedure TIcqAddContactForm.Button2Click(Sender: TObject);
{label
  x, y;
var
  i, ii: integer;
  newId, iGpId, iNick: string;}
begin
  {if (Edit1.Text = EmptyStr) or (Length(Edit1.Text) < 5) or (not ICQ_Work_Phaze) then goto y;
  //
  if ComboBox1.ItemIndex = -1 then
  begin
    DAShow(false, '3', '31', EmptyStr, 157, 2, DATimeShow);
    goto y;
  end;
  //
  Edit1.Text := exNormalizeScreenName(Edit1.Text);
  Edit1.Text := exNormalizeIcqNumber(Edit1.Text);
  if Trim(Edit2.Text) = EmptyStr then iNick := Edit1.Text
  else iNick := Edit2.Text;
  //
  for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
  begin
    if RoasterForm.CategoryButtons1.Categories.Items[i].GroupId = '0000' then Continue;
    if RoasterForm.CategoryButtons1.Categories.Items[i].GroupId = 'NoCL' then Continue;
    for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].Items[ii].UIN = Edit1.Text then
      begin
        DAShow(false, '2', '24', EmptyStr, 157, 0, DATimeShow);
        Exit;
      end;
    end;
  end;
  //
  if ICQ_SSI_Phaze then
  begin
    DAShow(false, '2', '25', EmptyStr, 157, 3, DATimeShow);
    Exit;
  end;
  //
  x: ;
  Randomize;
  newId := IntToHex(Random($7FFF), 4);
  //
  for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
  begin
    for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
    begin
      if newId = RoasterForm.CategoryButtons1.Categories[i].Items[ii].Idd then goto x;
    end;
  end;
  for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
  begin
    if RoasterForm.CategoryButtons1.Categories[i].GroupCaption = ComboBox1.Text then
    begin
      iGpId := RoasterForm.CategoryButtons1.Categories[i].GroupId;
      Break;
    end;
  end;
  //
  ICQ_Add_Contact_Phaze := true;
  ICQ_SSI_Phaze := true;
  ICQ_AddContact(Edit1.Text, iGpId, newId, iNick, false);
  //
  y: ;
  ModalResult := mrOk;}
end;

procedure TIcqAddContactForm.FormCreate(Sender: TObject);
begin
  TranslateForm;
  //
  MainForm.AllImageList.GetIcon(160, Icon);
end;

end.
