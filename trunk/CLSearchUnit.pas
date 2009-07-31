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
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, VarsUnit;

type
  TCLSearchForm = class(TForm)
    ListView1: TListView;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  MainUnit;

procedure TCLSearchForm.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TCLSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  BringWindowToTop(RoasterForm.Handle);
  //
  Action := caFree;
  CLSearchForm := nil;
end;

procedure TCLSearchForm.FormCreate(Sender: TObject);
begin
  {Sini := TIniFile.Create(Mypath + 'Config.ini');
  //
  Left := Sini.ReadInteger('General', 'CLSearchLeft', 30);
  Top := Sini.ReadInteger('General', 'CLSearchTop', 30);
  Height := Sini.ReadInteger('General', 'CLSearchHeight', 252);
  Width := Sini.ReadInteger('General', 'CLSearchWidth', 421);
  //
  Sini.Free;}
  //
  TranslateForm;
  //
  MainForm.AllImageList.GetIcon(49, Icon);
  MainForm.AllImageList.GetBitmap(50, BitBtn1.Glyph);
  //
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TCLSearchForm.FormDestroy(Sender: TObject);
begin
  {//--Sohranyaem razmery
  Sini := TIniFile.Create(Mypath + 'Config.ini');
  //
  Sini.WriteInteger('General', 'CLSearchLeft', Left);
  Sini.WriteInteger('General', 'CLSearchTop', Top);
  Sini.WriteInteger('General', 'CLSearchHeight', Height);
  Sini.WriteInteger('General', 'CLSearchWidth', Width);
  //
  Sini.Free;}
end;

procedure TCLSearchForm.TranslateForm;
begin
  {Lini := TIniFile.Create(MyPath + 'Langs\' + CurrentLang + '\General.txt');
  //
  Caption := Lini.ReadString('CLSearch', '1', '');
  Label1.Caption := Lini.ReadString('CLSearch', '2', '');
  ListView1.Columns.Items[0].Caption := Lini.ReadString('CLSearch', '3', '');
  ListView1.Columns.Items[1].Caption := Lini.ReadString('CLSearch', '4', '');
  BitBtn1.Caption := Lini.ReadString('CLSearch', '5', '');
  //
  Lini.Free;}
end;

end.
