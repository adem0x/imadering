unit ChannelDataUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TChannelDataForm = class(TForm)
    ChannelDataMemo: TMemo;
    TopPanel: TPanel;
    ChanelEdit: TEdit;
    FilterEnable: TCheckBox;
    TestOutData: TButton;
    ClearButton: TButton;
    procedure TestOutDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    xOutData: string;
  end;

var
  ChannelDataForm: TChannelDataForm;

implementation

{$R *.dfm}

uses
  PlugInDemo;

procedure TChannelDataForm.ClearButtonClick(Sender: TObject);
begin
  // Clear channel log
  ChannelDataMemo.Clear;
end;

procedure TChannelDataForm.FormCreate(Sender: TObject);
begin
  // Initialize vars
  xOutData := EmptyStr;
end;

procedure TChannelDataForm.TestOutDataClick(Sender: TObject);
var
  S: string;
begin
  // Send test popup message in imadering
  S := '1;Demo plugin:Test popup message';
  if InputQuery('Send data', 'Data:', S) then
  begin
    xOutData := S;
  end;
end;

end.
