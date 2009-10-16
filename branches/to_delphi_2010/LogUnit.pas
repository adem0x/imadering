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
  StdCtrls;

type
  TLogForm = class(TForm)
    LogMemo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure LogMemoDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
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

procedure TLogForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну
  MainForm.AllImageList.GetIcon(245, Icon);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Пишем в лог начальные события запуска программы
  XLog(LogMyPath + MyPath);
  XLog(LogProfile + ProfilePath);
  XLog(Format(LogIconCount, [AllIconCount]));
  XLog(LogNickCash + IntToStr(AccountToNick.Count));
  XLog(LogSmiliesCount + IntToStr(SmilesList.Count - 1));
  XLog(LogRosterCount + IntToStr(RosterForm.RosterJvListView.Items.Count));
end;

procedure TLogForm.LogMemoDblClick(Sender: TObject);
begin
  // Очищаем лог
  LogMemo.Clear;
end;

end.
