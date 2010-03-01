{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit SmilesUnit;

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
  Htmlview,
  ExtCtrls;

type
  TSmilesForm = class(TForm)
    BorderPanel: TPanel;
    SmiliesHTMLViewer: THTMLViewer;
    procedure SmiliesHTMLViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SmiliesHTMLViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

{$ENDREGION}

var
  SmilesForm: TSmilesForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  ChatUnit,
  UtilsUnit,
  VarsUnit;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TSmilesForm.FormCreate(Sender: TObject);
begin
  // Вычисляем размер окна смайлов
  if SmilesList.Count > 0 then
    begin
      Height := StrToInt(IsolateTextString(SmilesList.Strings[0], '<height>', '</height>'));
      Width := StrToInt(IsolateTextString(SmilesList.Strings[0], '<width>', '</width>'));
    end;
  // Загружаем смайлы из смайлпака
  if FileExists(MyPath + 'Smilies\' + CurrentSmiles + '\smilies.htm') then
    SmiliesHTMLViewer.LoadFromFile(MyPath + 'Smilies\' + CurrentSmiles + '\smilies.htm');
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TSmilesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Закрываем подсказки
  CloseSmiliesHint;
end;

procedure TSmilesForm.FormDeactivate(Sender: TObject);
begin
  // Закрываем окно
  Hide;
end;

procedure TSmilesForm.FormShow(Sender: TObject);
begin
  // Сбрасываем фокус со смайлов
  if SmiliesHTMLViewer.CanFocus then
    SmiliesHTMLViewer.SetFocus;
  // Показываем изображения смайликов
  SmiliesHTMLViewer.ViewImages := True;
end;

{$ENDREGION}
{$REGION 'SmiliesHTMLViewerHotSpotClick'}

procedure TSmilesForm.SmiliesHTMLViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
begin
  // Отключаем реакции
  Handled := True;
  // Выводим на передний план окно чата и ставим фокус в поле ввода
  SetForegroundWindow(ChatForm.Handle);
  if ChatForm.InputRichEdit.CanFocus then
    ChatForm.InputRichEdit.SetFocus;
  // Вставляем выбранный смайлик в поле ввода в окне чата
  with ChatForm.InputRichEdit do
    begin
      Text := Text + C_BN + SmiliesHTMLViewer.TitleAttr;
      SelStart := GetTextLen;
    end;
  // Закрываем подсказки
  CloseSmiliesHint;
  // Закрываем окно смайлов
  Hide;
  // Скрываем изображения смайликов
  SmiliesHTMLViewer.ViewImages := False;
end;

{$ENDREGION}
{$REGION 'SmiliesHTMLViewerMouseMove'}

procedure TSmilesForm.SmiliesHTMLViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TitleStr: string;
begin
  // При движениях мыши определяем всплывание подсказок
  if (not MainForm.JvTimerList.Events[14].Enabled) and (Assigned(ActiveControl)) then
    begin
      if ActiveControl.Focused then
        begin
          // Запоминаем вызывающий компонент и атрибут
          SH_HTMLViewer := SmiliesHTMLViewer;
          TitleStr := SmiliesHTMLViewer.TitleAttr;
          // Проверяем содержимое атрибута
          if TitleStr = EmptyStr then
            SH_OldTitle := EmptyStr
          else if TitleStr <> SH_OldTitle then
            begin
              SH_TimerCount := 0;
              // Запускаем таймер показа подсказки с атрибутом
              MainForm.JvTimerList.Events[14].Enabled := True;
              SH_OldTitle := TitleStr;
            end;
        end;
    end;
end;

{$ENDREGION}

end.
