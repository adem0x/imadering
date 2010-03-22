{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit UpdateUnit;

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
  ComCtrls,
  Buttons;

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
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
    procedure ArchiveProgress(Sender: TObject; const Value, MaxValue: Int64);
  end;

{$ENDREGION}

var
  UpdateForm: TUpdateForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TUpdateForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CloseBitBtn.Caption := Lang_Vars[8].L_S;
end;

{$ENDREGION}
{$REGION 'AbortBitBtnClick'}

procedure TUpdateForm.AbortBitBtnClick(Sender: TObject);
begin
  // Активируем кнопку Возобновить закачку
  StartBitBtn.Enabled := True;
  // Деактивируем кнопку Прервать
  AbortBitBtn.Enabled := False;
  // Ставим флаг отбоя обработки закачки
  MainForm.UpdateHttpClient.Tag := 2;
  MainForm.UpdateHttpClient.Abort;
  // Выводим информацию о прекрашении закачки обноления
  InfoMemo.Lines.Add(S_UpDateAbort);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TUpdateForm.CloseBitBtnClick(Sender: TObject);
begin
  // Закрываем программу
  Close;
end;

procedure TUpdateForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Уничтожаем окно после закрытия
  Action := CaFree;
  UpdateForm := nil;
end;

procedure TUpdateForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Отключаем закачку файла обновления
  AbortBitBtnClick(nil);
end;

procedure TUpdateForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TUpdateForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(225, Icon);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(139, AbortBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, StartBitBtn.Glyph);
  // Устанавливаем перевод
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'StartBitBtnClick'}

procedure TUpdateForm.StartBitBtnClick(Sender: TObject);
begin
  // Деактивируем кнопку Возобновить закачку
  StartBitBtn.Enabled := False;
  // Активируем кнопку Прервать
  AbortBitBtn.Enabled := True;
  // Ставим флаг обработки закачки файла обновления
  MainForm.UpdateHttpClient.Tag := 1;
  // Вставляем в мемо пробел
  if InfoMemo.Text <> EmptyStr then
    InfoMemo.Lines.Add(EmptyStr);
  // Обнуляем показатели прогресса
  LoadSizeLabel.Caption := Format(Lang_Vars[64].L_S, ['0']);
  DownloadProgressBar.Position := 0;
  // Выводим информацию о начале закачки обноления
  InfoMemo.Lines.Add(S_UpDateStart + ' (' + V_UpdateVersionPath + ')');
  // Запускаем закачку файла обновления с сайта
  MainForm.UpdateHttpClient.Abort;
  MainForm.UpdateHttpClient.URL := C_GoogleCodeURL + V_UpdateVersionPath;
  Xlog('URL: ' + MainForm.UpdateHttpClient.URL, EmptyStr);
  MainForm.UpdateHttpClient.GetASync;
end;

{$ENDREGION}
{$REGION 'ArchiveProgress'}

procedure TUpdateForm.ArchiveProgress(Sender: TObject; const Value, MaxValue: Int64);
var
  MyValue, MyMaxValue: Int64;
begin
  // Отображаем процесс распаковки архива
  MyValue := Value;
  MyMaxValue := MaxValue;
  while MyMaxValue > high(Word) do
    begin
      MyMaxValue := MyMaxValue shr 8;
      MyValue := MyValue shr 8;
    end;
  DownloadProgressBar.Max := MyMaxValue;
  DownloadProgressBar.Position := MyValue;
end;

{$ENDREGION}

end.
