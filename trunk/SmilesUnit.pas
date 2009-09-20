{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit SmilesUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Htmlview, ExtCtrls, VarsUnit;

type
  TSmilesForm = class(TForm)
    HintTimer: TTimer;
    BorderPanel: TPanel;
    SmiliesHTMLViewer: THTMLViewer;
    procedure HintTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SmiliesHTMLViewerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SmiliesHTMLViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    TimerCount: integer;
    OldTitle: string;
    HintWindow: THintWindow;
    HintVisible: boolean;
    procedure CloseAll;
  public
    //
  end;

var
  SmilesForm: TSmilesForm;

implementation

uses
  MainUnit, ChatUnit, UtilsUnit, UnitLogger;

{$R *.dfm}

procedure TSmilesForm.CloseAll;
begin
  //--Убираем подсказки
  HintTimer.Enabled := False;
  HintWindow.ReleaseHandle;
  HintVisible := False;
end;

procedure TSmilesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Закрываем подсказки
  CloseAll;
end;

procedure TSmilesForm.FormCreate(Sender: TObject);
begin
  try
    //--Создаём окно подсказок
    HintWindow := THintWindow.Create(Self);
    HintWindow.Color := clInfoBk;
    //--Вычисляем размер окна смайлов
    if SmilesList.Count > 0 then
    begin
      Height := StrToInt(IsolateTextString(SmilesList.Strings[0], '<height>', '</height>'));
      Width := StrToInt(IsolateTextString(SmilesList.Strings[0], '<width>', '</width>'));
    end;
    //--Загружаем смайлы из смайлпака
    if FileExists(MyPath + 'Smilies\' + CurrentSmiles + '\smilies.htm') then
      SmiliesHTMLViewer.LoadFromFile(MyPath + 'Smilies\' + CurrentSmiles + '\smilies.htm');
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(E);
  end;
end;

procedure TSmilesForm.FormDeactivate(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TSmilesForm.FormDestroy(Sender: TObject);
begin
  //--Высвобождаем окно подсказок
  HintWindow.Free;
end;

procedure TSmilesForm.HintTimerTimer(Sender: TObject);
const
  StartCount = 2;
  EndCount = 20;
var
  Pt, Pt1: TPoint;
  ARect: TRect;
  TitleStr: string;
begin
  //--Определяем показывать ли всплывающие подсказки
  Inc(TimerCount);
  GetCursorPos(Pt);
  Pt1 := SmiliesHTMLViewer.ScreenToClient(Pt);
  TitleStr := SmiliesHTMLViewer.TitleAttr;
  if (TitleStr = EmptyStr) or not PtInRect(SmiliesHTMLViewer.ClientRect, Pt1) then
  begin
    OldTitle := EmptyStr;
    CloseAll;
    Exit;
  end;
  if TitleStr <> OldTitle then
  begin
    TimerCount := 0;
    OldTitle := TitleStr;
    HintWindow.ReleaseHandle;
    HintVisible := False;
    Exit;
  end;
  if TimerCount > EndCount then
    CloseAll
  else if (TimerCount >= StartCount) and not HintVisible then
  begin
    ARect := HintWindow.CalcHintRect(300, TitleStr, nil);
    with ARect do
      HintWindow.ActivateHint(Rect(Pt.X, Pt.Y + 18, Pt.X + Right, Pt.Y + 18 + Bottom), TitleStr);
    HintVisible := True;
  end;
end;

procedure TSmilesForm.SmiliesHTMLViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  //--Отключаем реакции
  Handled := true;
  //--Вставляем выбранный смайлик в поле ввода в окне чата
  ChatForm.InputMemo.Text := ChatForm.InputMemo.Text + ' ' + SmiliesHTMLViewer.TitleAttr;
  ChatForm.InputMemo.SelStart := ChatForm.InputMemo.GetTextLen;
  if SmiliesHTMLViewer.CanFocus then SmiliesHTMLViewer.SetFocus;
  //--Закрываем окно смайлов
  Close;
  //--Выводим на передний план окно чата и ставим фокус в поле ввода
  SetForegroundWindow(ChatForm.Handle);
  if ChatForm.InputMemo.CanFocus then ChatForm.InputMemo.SetFocus;
end;

procedure TSmilesForm.SmiliesHTMLViewerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  TitleStr: string;
begin
  //--При движениях мыши определяем всплывание подсказок
  if not HintTimer.Enabled and Assigned(ActiveControl) and ActiveControl.Focused then
  begin
    TitleStr := SmiliesHTMLViewer.TitleAttr;
    if TitleStr = EmptyStr then
      OldTitle := EmptyStr
    else if TitleStr <> OldTitle then
    begin
      TimerCount := 0;
      HintTimer.Enabled := True;
      OldTitle := TitleStr;
    end;
  end;
end;

end.

