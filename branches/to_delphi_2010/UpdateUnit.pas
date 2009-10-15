{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit UpdateUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons;

type
  TUpdateForm = class(TForm)
    StartBitBtn: TBitBtn;
    AbortBitBtn: TBitBtn;
    CloseBitBtn: TBitBtn;
    DownloadProgressBar: TProgressBar;
    LoadSizeLabel: TLabel;
    InfoMemo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure AbortBitBtnClick(Sender: TObject);
    procedure StartBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdateForm: TUpdateForm;

implementation

{$R *.dfm}

uses
  MainUnit, UtilsUnit, VarsUnit, UnitLogger;

procedure TUpdateForm.AbortBitBtnClick(Sender: TObject);
begin
  // Активируем кнопку Возобновить закачку
  StartBitBtn.Enabled := true;
  // Деактивируем кнопку Прервать
  AbortBitBtn.Enabled := false;
  // Ставим флаг отбоя обработки закачки
  MainForm.UpdateHttpClient.Tag := 2;
  // Выводим информацию о прекрашении закачки обноления
  InfoMemo.Lines.Add(UpDateAbortL);
end;

procedure TUpdateForm.CloseBitBtnClick(Sender: TObject);
begin
  // Закрываем программу
  Close;
end;

procedure TUpdateForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Уничтожаем окно после закрытия
  Action := caFree;
  UpdateForm := nil;
end;

procedure TUpdateForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Отключаем закачку файла обновления
  AbortBitBtnClick(nil);
end;

procedure TUpdateForm.FormCreate(Sender: TObject);
begin
  // Включаем двойную буферезацию графики окна
  DoubleBuffered := true;
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(225, Icon);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(139, AbortBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, StartBitBtn.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE)
      or WS_EX_APPWINDOW);
end;

procedure TUpdateForm.StartBitBtnClick(Sender: TObject);
begin
  // Деактивируем кнопку Возобновить закачку
  StartBitBtn.Enabled := false;
  // Активируем кнопку Прервать
  AbortBitBtn.Enabled := true;
  // Ставим флаг обработки закачки файла обновления
  MainForm.UpdateHttpClient.Tag := 1;
  // Вставляем в мемо пробел
  if InfoMemo.Text <> EmptyStr then
    InfoMemo.Lines.Add('');
  // Обнуляем показатели прогресса
  LoadSizeLabel.Caption := 'Скачано: 0 Кб';
  DownloadProgressBar.Position := 0;
  // Выводим информацию о начале закачки обноления
  InfoMemo.Lines.Add(UpDateStartL + ' (' + UpdateVersionPath + ')');
  // Запускаем закачку файла обновления с сайта
  MainForm.UpdateHttpClient.Abort;
  try
    MainForm.UpdateHttpClient.URL :=
      'http://imadering.googlecode.com/files/' + UpdateVersionPath;
    MainForm.UpdateHttpClient.GetASync;
  except
    on E: Exception do
      // Если при подключении произошла ошибка, то сообщаем об этом
      InfoMemo.Lines.Add(E.Message);
  end;
end;

end.
