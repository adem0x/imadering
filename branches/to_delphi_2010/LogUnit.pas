unit LogUnit;

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
  StdCtrls, ExtCtrls, Buttons;

type
  TLogForm = class(TForm)
    LogMemo: TMemo;
    BottomPanel: TPanel;
    ClearLogSpeedButton: TSpeedButton;
    Bevel: TBevel;
    ICQDumpSpeedButton: TSpeedButton;
    JabberDumpSpeedButton: TSpeedButton;
    MRADumpSpeedButton: TSpeedButton;
    WriteLogSpeedButton: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ClearLogSpeedButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  LogForm: TLogForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  RosterUnit;

procedure TLogForm.TranslateForm;
begin
  // Устанавливаем хинты
  ClearLogSpeedButton.Hint := H_Log_Clear;
  ICQDumpSpeedButton.Hint := H_Log_ICQ;
  JabberDumpSpeedButton.Hint := H_Log_Jabber;
  MRADumpSpeedButton.Hint := H_Log_MRA;
  WriteLogSpeedButton.Hint := H_Log_Write;
end;

procedure TLogForm.ClearLogSpeedButtonClick(Sender: TObject);
begin
  // Очищаем лог
  LogMemo.Clear;
end;

procedure TLogForm.FormCreate(Sender: TObject);
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

end.
