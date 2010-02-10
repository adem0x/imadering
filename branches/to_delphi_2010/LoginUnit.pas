unit LoginUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses
  UtilsUnit,
  VarsUnit,
  MainUnit;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TLoginForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := S_Cancel;
end;

end.
