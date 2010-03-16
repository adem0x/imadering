{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit ProfilesFolderUnit;

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
  TProfilesFolderForm = class(TForm)
    FolderSelectLabel: TLabel;
    Folder1RadioButton: TRadioButton;
    Folder1Edit: TEdit;
    Folder2RadioButton: TRadioButton;
    Folder2Edit: TEdit;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  ProfilesFolderForm: TProfilesFolderForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit;

{$ENDREGION}
{$REGION 'Other'}

procedure TProfilesFolderForm.OKButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TProfilesFolderForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TProfilesFolderForm.FormCreate(Sender: TObject);
var
  S: string;
  Buf: array [0 .. $FF] of Char;
  Size: Integer;
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(227, Icon);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Заполняем пути
  S := '%APPDATA%\IMadering\';
  Size := ExpandEnvironmentStrings(PChar(S), Buf, Sizeof(Buf));
  Folder1Edit.Text := Copy(Buf, 1, Size);
  Folder2Edit.Text := V_MyPath + 'Profiles\';
end;

{$ENDREGION}

end.
