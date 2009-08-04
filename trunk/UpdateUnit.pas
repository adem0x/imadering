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
    procedure FormCreate(Sender: TObject);
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
  private
    { Private declarations }
    ver: string;
    bild: string;
    MyPath: string;
    ProxyAddresEdit: string;
    ProxyPortEdit: string;
    ProxyTypeComboBox: integer;
    ProxyVersionComboBox: integer;
    ProxyAuthCheckBox: boolean;
    ProxyLoginEdit: string;
    ProxyPasswordEdit: string;
    NTLMCheckBox: boolean;
    ProxyEnableCheckBox: boolean;
    GetM: boolean;
    UpdateFile: TMemoryStream;
    AbortUpdate: boolean;
    procedure ProxyEnableCheckBoxClick(HttpClient: THttpCli);
    procedure UnZip(FileName: TStream; SDir: string);
  public
    { Public declarations }
  end;

var
  UpdateForm: TUpdateForm;

implementation

{$R *.dfm}

function IsolateTextString(const S: string; Tag1, Tag2: string): string;
var
  pScan, pEnd, pTag1, pTag2: PChar;
  foundText: string;
  searchtext: string;
begin
  Result := '';
  searchtext := Uppercase(S);
  Tag1 := Uppercase(Tag1);
  Tag2 := Uppercase(Tag2);
  pTag1 := PChar(Tag1);
  pTag2 := PChar(Tag2);
  pScan := PChar(searchtext);
  repeat
    pScan := StrPos(pScan, pTag1);
    if pScan <> nil then
    begin
      Inc(pScan, Length(Tag1));
      pEnd := StrPos(pScan, pTag2);
      if pEnd <> nil then
      begin
        SetString(foundText,
          Pchar(S) + (pScan - PChar(searchtext)),
          pEnd - pScan);
        Result := foundText;
        pScan := pEnd + Length(tag2);
      end
      else
        pScan := nil;
    end;
  until pScan = nil;
end;

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
var
  Xml: IXmlDocument;
  XmlElem: IXmlNode;
begin
  //--Узнаём путь откуда запущена программа
  MyPath := ExtractFilePath(Application.ExeName);
  //--Ищем настройки прокси в имадеринге чтобы применить их
  if FileExists(MyPath + 'Profile\Proxy.xml') then
  begin
    try
      Xml := CreateXmlDocument;
      Xml.Load(MyPath + 'Profile\Proxy.xml');
      //--Загружаем адрес прокси
      XmlElem := Xml.DocumentElement.SelectSingleNode('proxy');
      if XmlElem <> nil then
      begin
        //--Считываем параметры прокси
        if XmlElem.ChildNodes.Count > 0 then
        begin
          ProxyAddresEdit := XmlElem.ChildNodes.Item[0].GetAttr('name');
          ProxyPortEdit := XmlElem.ChildNodes.Item[0].GetAttr('port');
          ProxyTypeComboBox := XmlElem.ChildNodes.Item[1].GetIntAttr('type-index');
          ProxyVersionComboBox := XmlElem.ChildNodes.Item[1].GetIntAttr('version-index');
          ProxyAuthCheckBox := XmlElem.ChildNodes.Item[2].GetBoolAttr('proxy-auth-enable');
          ProxyLoginEdit := XmlElem.ChildNodes.Item[2].GetAttr('proxy-login');
          ProxyPasswordEdit := XmlElem.ChildNodes.Item[2].GetAttr('proxy-password');
          NTLMCheckBox := XmlElem.ChildNodes.Item[2].GetBoolAttr('proxy-ntlm-auth');
        end;
        ProxyEnableCheckBox := XmlElem.GetBoolAttr('proxy-enable');
        //--Применяем параметры прокси для обоих http сокетов
        ProxyEnableCheckBoxClick(DownloadHttpClient);
        ProxyEnableCheckBoxClick(SubHttpClient);
      end;
    except
    end;
  end;
  //--Сообщаем о начале обновления
  InfoMemo.Lines.Add('Запрос информации для обновления...');
  //--Создаём блок в памяти для приёма файла обновления
  UpdateFile := TMemoryStream.Create;
  //--Удаляем старый файл Update.exe
  if FileExists(MyPath + 'Update.old') then DeleteFile(MyPath + 'Update.old');
  //--Запускаем таймер получения файла версии
  UpJvTimerList.Events[0].Enabled := true;
end;

procedure TUpdateForm.ProxyEnableCheckBoxClick(HttpClient: THttpCli);
var
  RequestVerProxy: string;
begin
  with HttpClient do
  begin
    //--Применяем настройки прокси
    if ProxyEnableCheckBox then
    begin
      //--Версия запроов
      case ProxyVersionComboBox of
        0: RequestVerProxy := '1.0';
        1: RequestVerProxy := '1.1';
      end;
      RequestVer := RequestVerProxy;
      //--HTTP и HTTPS тип прокси
      if (ProxyTypeComboBox = 0) or (ProxyTypeComboBox = 1) then
      begin
        //--Сбрасываем тип SOCKS прокси
        SocksLevel := '';
        //--Сбрасываем адрес SOCKS прокси и порт
        SocksServer := '';
        SocksPort := '';
        //--Сбрасываем авторизацию SOCKS прокси
        SocksAuthentication := socksNoAuthentication;
        SocksUsercode := '';
        SocksPassword := '';
        //--Назначаем адрес HTTP прокси и порт
        Proxy := ProxyAddresEdit;
        ProxyPort := ProxyPortEdit;
        //--Назначаем авторизацию на HTTP прокси
        if ProxyAuthCheckBox then
        begin
          ProxyAuth := httpAuthBasic;
          if NTLMCheckBox then ProxyAuth := httpAuthNtlm;
          ProxyUsername := ProxyLoginEdit;
          ProxyPassword := ProxyPasswordEdit;
        end
        else
        begin
          //--Сбрасываем авторизацию HTTP прокси
          ProxyAuth := httpAuthNone;
          ProxyUsername := '';
          ProxyPassword := '';
        end;
      end
      else
      begin
        //--Сбрасываем адрес HTTP прокси и порт
        Proxy := '';
        ProxyPort := '80';
        //--Сбрасываем авторизацию HTTP прокси
        ProxyAuth := httpAuthNone;
        ProxyUsername := '';
        ProxyPassword := '';
        //--SOCKS4, SOCKS4A и SOCKS5 тип прокси
        case ProxyTypeComboBox of
          2: SocksLevel := '4';
          3: SocksLevel := '4A';
          4: SocksLevel := '5';
        end;
        //--Назначаем адрес SOCKS прокси и порт
        SocksServer := ProxyAddresEdit;
        SocksPort := ProxyPortEdit;
        //--Назначаем авторизацию на SOCKS прокси
        if ProxyAuthCheckBox then
        begin
          SocksAuthentication := socksAuthenticateUsercode;
          SocksUsercode := ProxyLoginEdit;
          SocksPassword := ProxyPasswordEdit;
        end
        else
        begin
          //--Сбрасываем авторизацию SOCKS прокси
          SocksAuthentication := socksNoAuthentication;
          SocksUsercode := '';
          SocksPassword := '';
        end;
      end;
    end
    else
    begin
      //--Сбрасываем версию запросов
      RequestVer := '1.0';
      //--Сбрасываем адрес HTTP прокси и порт
      Proxy := '';
      ProxyPort := '80';
      //--Сбрасываем авторизацию HTTP прокси
      ProxyAuth := httpAuthNone;
      ProxyUsername := '';
      ProxyPassword := '';
      //--Сбрасываем тип SOCKS прокси
      SocksLevel := '';
      //--Сбрасываем адрес SOCKS прокси и порт
      SocksServer := '';
      SocksPort := '';
      //--Сбрасываем авторизацию SOCKS прокси
      SocksAuthentication := socksNoAuthentication;
      SocksUsercode := '';
      SocksPassword := '';
    end;
  end;
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
      //--Создаём временный лист
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
      end;
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
    DownloadHttpClient.URL := 'http://imadering.com/Update_' + ver + '_' + bild + '.z';
    DownloadHttpClient.GetASync;
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

