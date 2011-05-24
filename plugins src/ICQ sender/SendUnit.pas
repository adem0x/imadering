unit SendUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TSendForm = class(TForm)
    UINEdit: TEdit;
    UINLabel: TLabel;
    MessLabel: TLabel;
    MessMemo: TMemo;
    StartButton: TButton;
    StopButton: TButton;
    TimeEdit: TEdit;
    TimeLabel: TLabel;
    SecondsLabel: TLabel;
    SendTimer: TTimer;
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure SendTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SendData: string;
  end;

var
  SendForm: TSendForm;

implementation

{$R *.dfm}

uses
  PlugInICQsender;

procedure TSendForm.SendTimerTimer(Sender: TObject);
begin
  if (UINEdit.Text <> EmptyStr) and (MessMemo.Text <> EmptyStr) then
  begin
    SendData := '2;' + UINEdit.Text + ':' + MessMemo.Text;
  end;
end;

procedure TSendForm.StartButtonClick(Sender: TObject);
begin
  if (UINEdit.Text = EmptyStr) or (MessMemo.Text = EmptyStr) then
  begin
    ShowMessage('Indicate ICQ user UIN and text message!');
    Exit;
  end;
  StartButton.Enabled := False;
  StopButton.Enabled := True;
  if (TimeEdit.Text <> EmptyStr) and (TimeEdit.Text <> '0') then
    SendTimer.Interval := StrToInt(TimeEdit.Text) * 1000;
  SendTimer.Enabled := True;
end;

procedure TSendForm.StopButtonClick(Sender: TObject);
begin
  StopButton.Enabled := False;
  StartButton.Enabled := True;
  SendTimer.Enabled := False;
end;

end.
