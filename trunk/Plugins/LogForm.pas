unit LogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TLogForm = class(TForm)
    LogListBox: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddMessage(text: string);
  end;

implementation

{$R *.dfm}

{ TForm1 }

procedure TLogForm.AddMessage(text: string);
begin
  LogListBox.Items.Insert(0, text);
end;

end.
