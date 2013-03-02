unit Test_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TTest_Form = class(TForm)
    Test1_Button: TButton;
    Test2_Button: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure WM_FORM_ACTIVATE(var message: TMessage); message WM_ACTIVATE;
  public
    { Public declarations }
    v_Active_Form: Boolean;
  end;

var
  Test_Form: TTest_Form;

implementation

{$R *.dfm}

uses
  PlugInPluginTest;

procedure TTest_Form.WM_FORM_ACTIVATE(var message: TMessage);
begin
  // Обновляем режим отображения окна
  v_Active_Form := not v_Active_Form;
  if v_Active_Form then
  begin
    if (Self.Visible) and (Self.CanFocus) then
      Activate;
  end
  else
    Self.FormStyle := FsNormal;
end;

procedure TTest_Form.FormCreate(Sender: TObject);
var
  Icon_Path: string;
begin
  v_Active_Form := False;
  // Подгружаем иконку окна
  Icon_Path := v_My_Path + 'Icons\28.ico';
  if FileExists(Icon_Path) then
    Icon.LoadFromFile(Icon_Path);
  // Помещаем иконку окна в ИмагеЛист для проброса в основную программу
  v_My_Plugin.Image_List.AddIcon(Icon);
end;

end.

