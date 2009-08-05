unit IcsLogUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TIcsLogForm = class(TForm)
    IcsLogMemo: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IcsLogForm: TIcsLogForm;

implementation

uses MainUnit;

{$R *.dfm}

procedure TIcsLogForm.FormCreate(Sender: TObject);
begin
  //--Ставим иконку окна
  MainForm.AllImageList.GetIcon(227, Icon);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

end.
