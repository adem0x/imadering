{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit FloatingUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TFloatingForm = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    Shape1: TShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure WMNCHitTest(var Msg: TWMNCHitTest);
    message WM_NCHITTEST;
  public
    { Public declarations }
  end;

var
  FloatingForm: TFloatingForm;

implementation

{$R *.dfm}
{$HINTS OFF}

procedure TFloatingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  self := nil;
end;
{$HINTS ON}

procedure TFloatingForm.FormCreate(Sender: TObject);
begin
  Shape1.Top := Top;
  Shape1.Left := Left;
  Shape1.Height := Height;
  Shape1.Width := Width;
end;

procedure TFloatingForm.FormResize(Sender: TObject);
begin
  Shape1.Top := Top;
  Shape1.Left := Left;
  Shape1.Height := Height;
  Shape1.Width := Width;
end;

procedure TFloatingForm.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  if (ScreenToClient(Mouse.CursorPos).Y < Shape1.Top + Shape1.Height) and
    (ScreenToClient(Mouse.CursorPos).X < Shape1.Left + Shape1.Width) then
    Msg.Result := HTCAPTION;
end;

end.
