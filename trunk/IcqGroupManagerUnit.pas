{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqGroupManagerUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VarsUnit;

type
  TIcqGroupManagerForm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Create_Group: boolean;
    Name_Group: string;
    Id_Group: string;
  end;

var
  IcqGroupManagerForm: TIcqGroupManagerForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UtilsUnit;

procedure TIcqGroupManagerForm.Button1Click(Sender: TObject);
{label
  x, y;
var
  iClId: TStringList;
  i, ii: integer;
  newId: string;}
begin
  {//
  if ICQ_SSI_Phaze then
  begin
    DAShow(false, '2', '25', EmptyStr, 157, 3, DATimeShow);
    Exit;
  end;
  //
  if Create_Group then
  begin
    if Edit1.Text = EmptyStr then goto x;
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].GroupCaption = Edit1.Text then
      begin
        DAShow(false, '2', '29', EmptyStr, 157, 0, DATimeShow);
        goto x;
      end;
    end;
    //
    y: ;
    Randomize;
    newId := IntToHex(Random($7FFF), 4);
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
      begin
        if newId = RoasterForm.CategoryButtons1.Categories[i].Items[ii].Idd then goto y;
      end;
    end;
    //
    ICQ_Add_Nick := Edit1.Text;
    ICQ_Add_GroupId := newId;
    ICQ_Add_Group_Phaze := true;
    ICQ_SSI_Phaze := true;
    ICQ_AddGroup(Edit1.Text, newId);
  end
  else
  begin
    if Edit1.Text = EmptyStr then goto x;
    if Edit1.Text = Name_Group then goto x;
    if (Id_Group = EmptyStr) or (Id_Group = 'NoCL') then goto x;
    //
    ICQ_Add_Nick := Edit1.Text;
    ICQ_Add_GroupId := Id_Group;
    //
    iClId := TStringList.Create;
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].GroupId = ICQ_Add_GroupId then
      begin
        RoasterForm.CategoryButtons1.Categories[i].GroupCaption := Edit1.Text;
        for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
        begin
          iClId.Add(RoasterForm.CategoryButtons1.Categories[i].Items[ii].Idd);
        end;
        Break;
      end;
    end;
    //
    ICQ_UpdateGroup_AddContact(Edit1.Text, Id_Group, iClId);
    iClId.Free;
    //--Calculate contacts count in group
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      RoasterForm.CategoryButtons1.Categories[i].Caption := RoasterForm.CategoryButtons1.Categories[i].GroupCaption +
        ' - ' + IntToStr(RoasterForm.CategoryButtons1.Categories[i].Items.Count);
    end;
    //
    if (OnlyOnlineUsersCL) or (NoGroupModeCL) then
    begin
      OnlyOnlineUsersCL := not OnlyOnlineUsersCL;
      RoasterForm.ToolButton9Click(self);
    end;
  end;
  //
  x: ;
  ModalResult := mrOk;}
end;

procedure TIcqGroupManagerForm.FormShow(Sender: TObject);
begin
  if Edit1.CanFocus then Edit1.SetFocus;
end;

end.

