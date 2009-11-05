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
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Menus;

type
  TFloatingForm = class(TForm)
    StatusImage: TImage;
    XStatusImage: TImage;
    ClientImage: TImage;
    NickLabel: TLabel;
    FloatPopupMenu: TPopupMenu;
    FloatShape: TShape;
    CloseFloatMenu: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CloseFloatMenuClick(Sender: TObject);

  private
    { Private declarations }
    procedure WMNCHitTest(var Msg: TWMNCHitTest);
    message WM_NCHITTEST;
    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
  end;

var
  FloatingForm: TFloatingForm;

implementation

{$R *.dfm}
{$HINTS OFF}

procedure TFloatingForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_TOOLWINDOW;
  Params.WndParent := HWND_DESKTOP;
end;

procedure TFloatingForm.CloseFloatMenuClick(Sender: TObject);
begin
  // Закрываем плавающий контакт
  Close;
end;

procedure TFloatingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  Self := nil;
end;

{$HINTS ON}

procedure TFloatingForm.FormCreate(Sender: TObject);
begin
  FloatShape.Top := Top;
  FloatShape.Left := Left;
  FloatShape.Height := Height;
  FloatShape.Width := Width;
end;

procedure TFloatingForm.FormResize(Sender: TObject);
begin
  FloatShape.Top := Top;
  FloatShape.Left := Left;
  FloatShape.Height := Height;
  FloatShape.Width := Width;
end;

procedure TFloatingForm.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  if (ScreenToClient(Mouse.CursorPos).Y < FloatShape.Top + FloatShape.Height) and
    (ScreenToClient(Mouse.CursorPos).X < FloatShape.Left + FloatShape.Width) then
    Msg.Result := HTCAPTION;
end;

end.
