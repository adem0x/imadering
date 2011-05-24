{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit LoginUnit;

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
  StdCtrls;

type
  TLoginForm = class(TForm)
    AccountEdit: TEdit;
    AccountLabel: TLabel;
    PasswordEdit: TEdit;
    PasswordLabel: TLabel;
    SavePassCheckBox: TCheckBox;
    OKButton: TButton;
    CancelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  UtilsUnit,
  VarsUnit,
  MainUnit;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TLoginForm.FormShow(Sender: TObject);
begin
  // Если логин указан, то переводим фокус на ввод пароля
  if AccountEdit.Text <> EmptyStr then
    if PasswordEdit.CanFocus then
      PasswordEdit.SetFocus;
end;

procedure TLoginForm.TranslateForm;
begin
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := Lang_Vars[9].L_S;
end;

{$ENDREGION}

end.
