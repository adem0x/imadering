{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit LogUnit;

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
  StdCtrls,
  ExtCtrls,
  Buttons;

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
    TwitDumpSpeedButton: TSpeedButton;
    SaveLogSpeedButton: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ClearLogSpeedButtonClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure SaveLogSpeedButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  LogForm: TLogForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  RosterUnit;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TLogForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TLogForm.FormCreate(Sender: TObject);
begin
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TLogForm.ClearLogSpeedButtonClick(Sender: TObject);
begin
  // Очищаем лог
  LogMemo.Clear;
end;

procedure TLogForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TLogForm.SaveLogSpeedButtonClick(Sender: TObject);
begin
  // Сохраняем данные лога в файл
  with MainForm do
    begin
      SaveTextAsFileDialog.FileName := 'IMadering Log';
      if SaveTextAsFileDialog.Execute then
        LogMemo.Lines.SaveToFile(SaveTextAsFileDialog.FileName, TEncoding.Unicode);
    end;
end;

{$ENDREGION}

end.
