{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit FloatingUnit;

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
    OpenChatFloatMenu: TMenuItem;
    N2: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CloseFloatMenuClick(Sender: TObject);
    procedure OpenChatFloatMenuClick(Sender: TObject);

  private
    { Private declarations }
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;

    procedure WMNCRBUTTONDOWN(var Msg: TMessage); message WM_NCRBUTTONDOWN;

    procedure NCLBUTTONDBLCLK(var Msg: TMessage); message WM_NCLBUTTONDBLCLK;

  protected
    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
  end;

{$ENDREGION}

var
  FloatingForm: TFloatingForm;

implementation

{$R *.dfm}
{$HINTS OFF}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit;

{$ENDREGION}
{$REGION 'Other'}

procedure TFloatingForm.WMNCRBUTTONDOWN(var Msg: TMessage);
var
  FCursor: TPoint;
begin
  // Если по форме был клик правой кнопокой мыши, то отображаем меню
  if Msg.WParam = HTCAPTION then
    begin
      GetCursorPos(FCursor);
      FloatPopupMenu.Popup(FCursor.X, FCursor.Y);
    end;
  inherited;
end;

procedure TFloatingForm.NCLBUTTONDBLCLK(var Msg: TMessage);
begin
  // Открываем час с этим контактом если был двойной клик мышкой
  if Msg.WParam = HTCAPTION then
    OpenChatFloatMenuClick(nil);
  inherited;
end;

procedure TFloatingForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Переопределяем стиль создания формы
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
  // Уничтожаем форму после закрытия
  Action := CaFree;
  Self := nil;
end;

procedure TFloatingForm.OpenChatFloatMenuClick(Sender: TObject);
begin
  // Открываем чат с этим контактом
  //RosterForm.OpenChatPage(nil, NickLabel.Hint);
end;

procedure TFloatingForm.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  // Определяем события мыши как клик по заголовку окна
  if (ScreenToClient(Mouse.CursorPos).Y < FloatShape.Top + FloatShape.Height) and (ScreenToClient(Mouse.CursorPos).X < FloatShape.Left + FloatShape.Width) then
    Msg.Result := HTCAPTION;
end;

{$ENDREGION}
{$HINTS ON}
{$REGION 'FormCreate'}

procedure TFloatingForm.FormCreate(Sender: TObject);
begin
  // Формируем размеры плавающего окна
  FloatShape.Top := Top;
  FloatShape.Left := Left;
  FloatShape.Height := Height;
  FloatShape.Width := Width;
end;

{$ENDREGION}
{$REGION 'FormResize'}

procedure TFloatingForm.FormResize(Sender: TObject);
begin
  // Формируем размеры плавающего окна
  FloatShape.Top := Top;
  FloatShape.Left := Left;
  FloatShape.Height := Height;
  FloatShape.Width := Width;
end;

{$ENDREGION}

end.
