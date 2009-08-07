unit UpdateUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, OverbyteIcsWndControl,
  OverbyteIcsHttpProt, SimpleXML, OverbyteIcsWSocket, JvTimerList, Code,
  JvZLibMultiple;

type
  TUpdateForm = class(TForm)
    StartBitBtn: TBitBtn;
    AbortBitBtn: TBitBtn;
    CloseBitBtn: TBitBtn;
    DownloadProgressBar: TProgressBar;
    SubHttpClient: THttpCli;
    DownloadHttpClient: THttpCli;
    UpJvTimerList: TJvTimerList;
    LoadSizeLabel: TLabel;
    InfoMemo: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure UpJvTimerListEvents0Timer(Sender: TObject);
    procedure SubHttpClientDocBegin(Sender: TObject);
    procedure SubHttpClientDocEnd(Sender: TObject);
    procedure UpJvTimerListEvents1Timer(Sender: TObject);
    procedure DownloadHttpClientDocBegin(Sender: TObject);
    procedure DownloadHttpClientDocEnd(Sender: TObject);
    procedure AbortBitBtnClick(Sender: TObject);
    procedure StartBitBtnClick(Sender: TObject);
    procedure DownloadHttpClientDocData(Sender: TObject; Buffer: Pointer;
      Len: Integer);
    procedure SubHttpClientDocData(Sender: TObject; Buffer: Pointer;
      Len: Integer);
    procedure SubHttpClientSessionClosed(Sender: TObject);
    procedure UpJvTimerListEvents2Timer(Sender: TObject);
    procedure DownloadHttpClientSessionClosed(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    GetM: boolean;
    UpdateFile: TMemoryStream;
    AbortUpdate: boolean;
    procedure UnZip(FileName: TStream; SDir: string);
  public
    { Public declarations }
  end;

var
  UpdateForm: TUpdateForm;

implementation

{$R *.dfm}

uses
  MainUnit, UtilsUnit, VarsUnit;

procedure TUpdateForm.AbortBitBtnClick(Sender: TObject);
begin
  //--Активируем режим не обработки данных с сокета
  AbortUpdate := true;
  //--Отключаем HTTP сокет
  if DownloadHttpClient.State <> httpNotConnected then DownloadHttpClient.Abort;
  //--Отключаем HTTP сокет
  if SubHttpClient.State <> httpNotConnected then SubHttpClient.Abort;
  //--Активируем кнопку Возобновить закачку
  StartBitBtn.Enabled := true;
  //--Деактивируем кнопку Прервать
  AbortBitBtn.Enabled := false;
end;

procedure TUpdateForm.CloseBitBtnClick(Sender: TObject);
begin
  //--Закрываем программу
  Close;
end;

procedure TUpdateForm.DownloadHttpClientDocBegin(Sender: TObject);
begin
  //--Создаём блок памяти для приёма http данных
  DownloadHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TUpdateForm.DownloadHttpClientDocData(Sender: TObject; Buffer: Pointer;
  Len: Integer);
begin
  //--Если был активирован аборт сессии, то выходим и отключаем сокет
  if AbortUpdate then if DownloadHttpClient.State <> httpNotConnected then DownloadHttpClient.Abort;
  //--Отображаем процесс получения данных
  if DownloadHttpClient.ContentLength > -1 then
  begin
    LoadSizeLabel.Caption := 'Скачано: ' + FloatToStrF(DownloadHttpClient.RcvdCount / 1000, ffFixed, 7, 1) + ' Кб';
    DownloadProgressBar.Max := DownloadHttpClient.ContentLength;
    DownloadProgressBar.Position := DownloadHttpClient.RcvdCount;
  end;
  //--Обновляем форму и контролы чтобы видеть изменения
  Update;
end;

procedure TUpdateForm.DownloadHttpClientDocEnd(Sender: TObject);
label
  x;
begin
  //--Читаем полученные http данные из блока памяти
  if DownloadHttpClient.RcvdStream <> nil then
  begin
    //--Если был активирован аборт сессии, то выходим и высвобождаем память
    if AbortUpdate then goto x;
    try
      //--Обнуляем позицию начала чтения в блоке памяти
      DownloadHttpClient.RcvdStream.Position := 0;
      //--Читаем данные в лист
      UpdateFile.LoadFromStream(DownloadHttpClient.RcvdStream);
      //--Информируем о успешной закачке файла обновления
      InfoMemo.Lines.Add('Файл обновления успешно получен.');
      InfoMemo.Lines.Add('Установка обновления...');
      //--Переименовываем файл Imadering.exe
      if FileExists(MyPath + 'Imadering.exe') then
        RenameFile(MyPath + 'Imadering.exe', MyPath + 'Imadering.old');
      //--Переименовываем файл Update.exe
      if FileExists(MyPath + 'Update.exe') then
        RenameFile(MyPath + 'Update.exe', MyPath + 'Update.old');
      //--Запускаем таймер распаковки архива с обновлением
      UpJvTimerList.Events[2].Enabled := true;
    except
    end;
    x: ;
    //--Высвобождаем блок памяти
    DownloadHttpClient.RcvdStream.Free;
    DownloadHttpClient.RcvdStream := nil;
  end;
end;

procedure TUpdateForm.DownloadHttpClientSessionClosed(Sender: TObject);
begin
  //--Сообщаем о завершении соедиенния
  //InfoMemo.Lines.Add('Подключение завершено.');
end;

procedure TUpdateForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Отключаем HTTP сокет
  if DownloadHttpClient.State <> httpNotConnected then DownloadHttpClient.Abort;
  //--Отключаем HTTP сокет
  if SubHttpClient.State <> httpNotConnected then SubHttpClient.Abort;
  //--Высвобождаем блок памяти
  FreeAndNil(UpdateFile);
end;

procedure TUpdateForm.FormCreate(Sender: TObject);
begin
  //--Включаем двойную буферезацию графики окна
  DoubleBuffered := true;
  //--Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(225, Icon);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(139, AbortBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, StartBitBtn.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TUpdateForm.StartBitBtnClick(Sender: TObject);
begin
  //--Запускаем таймер получения файла версии
  UpJvTimerList.Events[0].Enabled := true;
  //--Деактивируем кнопку Возобновить закачку
  StartBitBtn.Enabled := false;
  //--Активируем кнопку Прервать
  AbortBitBtn.Enabled := true;
  //--Дективируем режим не обработки данных с сокета
  AbortUpdate := false;
  //--Вставляем в мемо пробел
  InfoMemo.Lines.Add('');
end;

procedure TUpdateForm.SubHttpClientDocBegin(Sender: TObject);
begin
  //--Создаём блок памяти для приёма http данных
  SubHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TUpdateForm.SubHttpClientDocData(Sender: TObject; Buffer: Pointer;
  Len: Integer);
begin
  //--Отображаем процесс получения данных
  if SubHttpClient.ContentLength > -1 then
  begin
    LoadSizeLabel.Caption := 'Скачано: ' + FloatToStrF(SubHttpClient.RcvdCount / 1000, ffFixed, 7, 1) + ' Кб';
    DownloadProgressBar.Max := SubHttpClient.ContentLength;
    DownloadProgressBar.Position := SubHttpClient.RcvdCount;
  end;
  //--Обновляем форму и контролы чтобы видеть изменения
  Update;
end;

procedure TUpdateForm.SubHttpClientDocEnd(Sender: TObject);
label
  x;
var
  list: TStringList;
begin
  //--Читаем полученные http данные из блока памяти
  if SubHttpClient.RcvdStream <> nil then
  begin
    //--Если был активирован аборт сессии, то выходим и высвобождаем память
    if AbortUpdate then goto x;
    //--Если нужные нам действия первого уровня
    if not GetM then
    begin
      {//--Создаём временный лист
      list := TStringList.Create;
      try
        try
          //--Обнуляем позицию начала чтения в блоке памяти
          SubHttpClient.RcvdStream.Position := 0;
          //--Читаем данные в лист
          list.LoadFromStream(SubHttpClient.RcvdStream);
          //--Разбираем данные в листе
          if list.Text > '' then
          begin
            ver := IsolateTextString(list.Text, '<v>', '</v>');
            bild := IsolateTextString(list.Text, '<b>', '</b>');
            //--Проверяем есть доступно ли обновление
            if (ver = '') or (bild = '') then InfoMemo.Lines.Add('Ошибка: обновление не доступно.')
            else
            begin
              //--Выводим информацию о версии обновления
              InfoMemo.Lines.Add('Версия: ' + ver);
              InfoMemo.Lines.Add('Сборка: ' + bild);
              //--Запускаем закачку файла обновления
              UpJvTimerList.Events[1].Enabled := true;
            end;
          end;
        except
        end;
      finally
        list.Free;
      end;}
    end;
    x: ;
    //--Высвобождаем блок памяти
    SubHttpClient.RcvdStream.Free;
    SubHttpClient.RcvdStream := nil;
  end;
end;

procedure TUpdateForm.UpJvTimerListEvents0Timer(Sender: TObject);
begin
  //--Запускаем проверку обновлений программы на сайте
  try
    SubHttpClient.URL := 'http://imadering.com/version.txt';
    SubHttpClient.GetASync;
  except
    on E: Exception do
      //--Если при подключении произошла ошибка, то сообщаем об этом
      InfoMemo.Lines.Add(E.Message);
  end;
end;

procedure TUpdateForm.UpJvTimerListEvents1Timer(Sender: TObject);
begin
  //--Обнуляем показатели прогресса
  LoadSizeLabel.Caption := 'Скачано: 0 Кб';
  DownloadProgressBar.Position := 0;
  //--Выводим информацию о начале закачки обноления
  InfoMemo.Lines.Add('Загрузка обновления...');
  //--Запускаем закачку файла обновления с сайта
  try
    //DownloadHttpClient.URL := 'http://imadering.com/Update_' + ver + '_' + bild + '.z';
    //DownloadHttpClient.GetASync;
  except
    on E: Exception do
      //--Если при подключении произошла ошибка, то сообщаем об этом
      InfoMemo.Lines.Add(E.Message);
  end;
end;

procedure TUpdateForm.UnZip(FileName: TStream; SDir: string);
var
  z: TJvZlibMultiple;
begin
  //--Распаковываем файл в указанную директорию
  z := TJvZlibMultiple.Create(nil);
  try
    z.DecompressStream(FileName, SDir, true);
  finally
    z.Free;
    //--Сообщаем о завершении распаковки
    InfoMemo.Lines.Add('Установка обновления завершена.');
    InfoMemo.Lines.Add(' ');
    InfoMemo.Lines.Add('Для завершения обновления необходимо перезапустить программу IMadering!');
  end;
end;

procedure TUpdateForm.UpJvTimerListEvents2Timer(Sender: TObject);
begin
  //--Распаковываем файл с обновлением в папку Imadering (текущую)
  UnZip(UpdateFile, MyPath);
end;

procedure TUpdateForm.SubHttpClientSessionClosed(Sender: TObject);
begin
  //--Сообщаем о завершении соедиенния
  //InfoMemo.Lines.Add('Подключение завершено.');
end;

end.

