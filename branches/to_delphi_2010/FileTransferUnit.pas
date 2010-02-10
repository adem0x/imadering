{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit FileTransferUnit;

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
  ExtCtrls,
  ComCtrls,
  StdCtrls,
  Buttons,
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt;

type
  TFileTransferForm = class(TForm)
    TopInfoPanel: TPanel;
    FileNamePanel: TPanel;
    FileSizePanel: TPanel;
    FileNameLabel: TLabel;
    FileSizeLabel: TLabel;
    CancelBitBtn: TBitBtn;
    CloseBitBtn: TBitBtn;
    SendProgressBar: TProgressBar;
    BottomInfoPanel: TPanel;
    ProgressLabel: TLabel;
    SendFileHttpClient: THttpCli;
    DescEdit: TEdit;
    PassEdit: TEdit;
    DescLabel: TLabel;
    SendFileButton: TBitBtn;
    PassLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure SendFileHttpClientDocBegin(Sender: TObject);
    procedure SendFileHttpClientDocEnd(Sender: TObject);
    procedure SendFileHttpClientSendEnd(Sender: TObject);
    procedure SendFileHttpClientSessionClosed(Sender: TObject);
    procedure SendFileButtonClick(Sender: TObject);
    procedure SendFileHttpClientSendData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure SendFileHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure SendFileHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure SendFileHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    T_UIN: string;
    T_UserType: string;
    T_FilePath: string;
    T_FileName: string;
    procedure TranslateForm;
  end;

var
  FileTransferForm: TFileTransferForm;

implementation

uses
  MainUnit,
  SettingsUnit,
  TrafficUnit,
  VarsUnit,
  UtilsUnit,
  IcqProtoUnit,
  RosterUnit,
  JabberProtoUnit,
  MraProtoUnit,
  ChatUnit;

{$R *.dfm}

const
  UpWapRootURL = 'http://upwap.ru';

resourcestring
  RS_SF = 'SFClient | ';
  RS_DB = 'Doc_Begin; Rcvd_Stream Create';
  RS_SDA = 'Send_Data; Abort';
  RS_DE = 'Doc_End';
  RS_SE = 'Send_End';
  RS_SesClose = 'Session_Closed; Status_Code = ';
  RS_ReqD = 'Request_Done; Error = ';
  RS_RcvdSE = 'Rcvd_Stream; Enabled';
  RS_RcvdSF = 'Rcvd_Stream; Free';
  RS_SendSF = 'Send_Stream; Free';

procedure TFileTransferForm.SendFileButtonClick(Sender: TObject);
begin
  // Блокируем контролы Описания и Пароля
  CancelBitBtn.Enabled := True;
  DescEdit.Enabled := False;
  DescEdit.Color := ClBtnFace;
  PassEdit.Enabled := False;
  PassEdit.Color := ClBtnFace;
  SendFileButton.Enabled := False;
  // Применяем параметры прокси
  SendFileHttpClient.Abort;
  SettingsForm.ApplyProxyHttpClient(SendFileHttpClient);
  case Tag of
    1: begin // Передача через сервис UpWap.ru
        // Запрашиваем страницу с кодом сессии
        SendProgressBar.Position := 0;
        // Ставим флаг события для данных
        SendFileHttpClient.Tag := 0;
        // Формируем URL запроса
        SendFileHttpClient.URL := UpWapRootURL + '/upload/';
        // Выводим информацию о начале процесса
        BottomInfoPanel.Caption := S_FileTransfer2;
        Xlog(S_FileTransfer2 + BN + SendFileHttpClient.URL);
        // Начинаем запрос данных
        SendFileHttpClient.GetASync;
      end;
  end;
end;

procedure TFileTransferForm.SendFileHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  Xlog(RS_SF + RS_DB);
  SendFileHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TFileTransferForm.SendFileHttpClientDocEnd(Sender: TObject);
begin
  Xlog(RS_SF + RS_DE);
end;

procedure TFileTransferForm.SendFileHttpClientSendData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  // Отображаем процесс передачи файла
  SendProgressBar.Max := SendFileHttpClient.SendStream.Size;
  SendProgressBar.Position := SendFileHttpClient.SentCount;
  // Обновляем форму и контролы чтобы видеть изменения
  Update;
  // Если прерывание передачи, то останавливаем сокет
  if SendFileHttpClient.Tag = 2 then
    begin
      Xlog(RS_SF + RS_SDA);
      SendFileHttpClient.CloseAsync;
      SendFileHttpClient.Abort;
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSendEnd(Sender: TObject);
begin
  Xlog(RS_SF + RS_SE);
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + SendFileHttpClient.SentCount;
  AllTrafSend := AllTrafSend + SendFileHttpClient.SentCount;
  if Assigned(TrafficForm) then
    MainForm.OpenTrafficClick(nil);
end;

procedure TFileTransferForm.SendFileHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  with SendFileHttpClient do
    begin
      if (StatusCode = 0) or (StatusCode >= 400) then
        begin
          BottomInfoPanel.Caption := ErrorHttpClient(StatusCode);
          Xlog(RS_SF + RS_SesClose + IntToStr(StatusCode));
        end;
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(S_Errorhead, NotifyConnectError((Sender as THttpCli).Name, ErrCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(S_Errorhead, SocketConnErrorInfo_1 + RN + Msg + RN + Format(HttpSocketErrCodeL, [Error]) + RN + '[ ' + SocketL + BN + (Sender as THttpCli).Name + ' ]', EmptyStr, 134, 2, 0);
    end;
end;

procedure TFileTransferForm.CancelBitBtnClick(Sender: TObject);
begin
  // Блокируем кнопку
  CancelBitBtn.Enabled := False;
  // Останавливаем передачу файла
  SendFileHttpClient.Tag := 2;
  SendFileHttpClient.CloseAsync;
  SendFileHttpClient.Abort;
  // Разблокируем контролы Описания и Пароля
  DescEdit.Enabled := True;
  DescEdit.Color := ClWindow;
  PassEdit.Enabled := True;
  PassEdit.Color := ClWindow;
  if Sender <> nil then
    begin
      BottomInfoPanel.Caption := S_FileTransfer4;
      Xlog(RS_SF + S_FileTransfer4);
      SendFileButton.Enabled := True;
    end;
end;

procedure TFileTransferForm.CloseBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TFileTransferForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Если передача закончена, то уничтожаем окно
  if not CancelBitBtn.Enabled then
    begin
      // Уничтожаем форму
      Action := CaFree;
      FileTransferForm := nil;
    end;
end;

procedure TFileTransferForm.FormCreate(Sender: TObject);
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(149, Icon);
  MainForm.AllImageList.GetBitmap(139, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(166, SendFileButton.Glyph);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Применяем настройки прокси
  SettingsForm.ApplyProxyHttpClient(SendFileHttpClient);
end;

procedure TFileTransferForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TFileTransferForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelBitBtn.Caption := S_Cancel;
  CloseBitBtn.Caption := S_Close;
end;

procedure TFileTransferForm.SendFileHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
label
  X;
var
  List: TStringList;
  Doc, Skey, OKURL, HistoryFile, MsgD: string;
  FileToSend: TMemoryStream;
  Buf, Boundry: Utf8String;
begin
  try
    Xlog(RS_SF + RS_ReqD + IntToStr(ErrCode));
    // Высвобождаем память отправки данных
    if SendFileHttpClient.SendStream <> nil then
      begin
        SendFileHttpClient.SendStream.Free;
        SendFileHttpClient.SendStream := nil;
        Xlog(RS_SF + RS_SendSF);
      end;
    // Читаем полученные http данные из блока памяти
    if SendFileHttpClient.RcvdStream <> nil then
      begin
        Xlog(RS_SF + RS_RcvdSE);
        // Создаём временный лист
        List := TStringList.Create;
        try
          // Увеличиваем статистику входящего трафика
          TrafRecev := TrafRecev + SendFileHttpClient.RcvdCount;
          AllTrafRecev := AllTrafRecev + SendFileHttpClient.RcvdCount;
          if Assigned(TrafficForm) then
            MainForm.OpenTrafficClick(nil);
          // Обнуляем позицию начала чтения в блоке памяти
          SendFileHttpClient.RcvdStream.Position := 0;
          // Читаем данные в лист
          List.LoadFromStream(SendFileHttpClient.RcvdStream);
          // Разбираем данные в листе
          if List.Text > EmptyStr then
            begin
              Doc := UTF8ToString(List.Text);
              Xlog(RS_SF + RN + RN + Doc);
              case SendFileHttpClient.Tag of // Определяем выполнение задания для данных по флагу
                0: begin
                    // Узнаём ключ сессии
                    Skey := EmptyStr;
                    Skey := IsolateTextString(Doc, 'action="', '"');
                    // Формируем данные для отправки
                    with SendFileHttpClient do
                      begin
                        // Создаём блок памяти для отправки файла методом POST
                        SendStream := TMemoryStream.Create;
                        // Ссылка для приёма данных
                        URL := UpWapRootURL + Skey;
                        Xlog(RS_SF + URL);
                        // Заполняем переменные для POST
                        Boundry := '------------sZLbqiVRVfOO8NjlMuYJE3';
                        { Specified in Multipart/form-data RFC }
                        ContentTypePost := UTF8Encode('multipart/form-data; boundary=' + Copy(Boundry, 3, Length(Boundry)));
                        Buf := UTF8Encode(Boundry + RN + 'Content-Disposition: form-data; name="file"; filename="' + T_FileName + '"' +
                            RN + 'Content-Type: image/jpeg' + RN + RN);
                        // Записываем переменные в память
                        SendStream.write(Buf[1], Length(Buf));
                        // Создаём блок памяти для файла
                        FileToSend := TMemoryStream.Create;
                        try
                          FileToSend.LoadFromFile(T_FilePath);
                          FileToSend.SaveToStream(SendStream);
                        finally
                          FileToSend.Free;
                        end;
                        // Записываем переменную описания файла
                        Buf := UTF8Encode
                          (RN + Boundry + RN + 'Content-Disposition: form-data; name="desc"' + RN + RN + DescEdit.Text + RN + Boundry +
                            RN + 'Content-Disposition: form-data; name="password"' + RN + RN + PassEdit.Text + RN + Boundry + RN +
                            'Content-Disposition: form-data; name="send"' + RN + RN + 'Отправить!' + RN + Boundry + '--' + RN);
                        SendStream.write(Buf[1], Length(Buf));
                        SendStream.Seek(0, SoFromBeginning);
                        // Отправляем данные на сервер
                        SendFileHttpClient.Tag := 1;
                        PostAsync;
                      end;
                  end;
                1: begin
                    // Ищем информацию об успешной закачке файла на сервер
                    if Pos('Файл размещен', Doc) > 0 then
                      begin
                        BottomInfoPanel.Caption := S_FileTransfer3;
                        OKURL := UpWapRootURL + IsolateTextString(Doc, 'action="', '"');
                        // Формируем текст со ссылкой
                        case Tag of
                          1: OKURL := Format(S_FileTransfer5, [T_FileName, OKURL, 'upwap.ru', FileSizePanel.Caption]);
                        end;
                        Xlog(RS_SF + RN + OKURL);
                        MsgD := YouAt + ' [' + DateTimeChatMess + ']';
                        CheckMessage_BR(OKURL);
                        DecorateURL(OKURL);
                        // Отправляем сообщение с сылкой на файл
                        if T_UserType = S_Icq then
                          begin
                            // Если нет подключения к серверу ICQ, то выходим
                            if NotProtoOnline(S_Icq) then
                              goto X;
                            // Отправляем сообщение в юникод формате
                            ICQ_SendMessage_0406(T_UIN, OKURL, True);
                            // Формируем файл с историей
                            HistoryFile := ProfilePath + HistoryFileName + S_Icq + BN + ICQ_LoginUIN + BN + T_UIN + '.htm';
                          end
                        else if T_UserType = S_Jabber then
                          begin
                            // Если нет подключения к серверу Jabber, то выходим
                            if NotProtoOnline(S_Jabber) then
                              goto X;
                            // Отправляем сообщение
                            Jabber_SendMessage(T_UIN, OKURL);
                            // Формируем файл с историей
                            HistoryFile := ProfilePath + HistoryFileName + S_Jabber + BN + Jabber_LoginUIN + BN + T_UIN + '.htm';
                          end
                        else if T_UserType = S_Mra then
                          begin
                            // Если нет подключения к серверу MRA, то выходим
                            if NotProtoOnline(S_Mra) then
                              goto X;
                            // Формируем файл с историей
                            HistoryFile := ProfilePath + HistoryFileName + S_Mra + BN + MRA_LoginUIN + BN + T_UIN + '.htm';
                          end
                        else
                          goto X;
                        // Записываем историю в файл этого контакта
                        SaveTextInHistory('<span class=a>' + MsgD + '</span><br><span class=c>' + OKURL + '</span><br><br>', HistoryFile);
                        // Если окно сообщений не было создано, то создаём его
                        if not Assigned(ChatForm) then
                          ChatForm := TChatForm.Create(MainForm);
                        // Если вкладка чата совпадает с UIN получателя
                        with ChatForm do
                          begin
                            if InfoPanel2.Caption = T_UIN then
                              begin
                                // Оповещаем о удачной передаче файла
                                NotifyPanel.Caption := S_FileTransfer3;
                                // Увеличиваем счётчик исходящих сообщений
                                Inc(OutMessIndex);
                                // Добавляем в чат сообщение
                                AddChatText(MsgD, OKURL);
                                // Прокручиваем чат до конца
                                HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
                                // Очищаем поле ввода теста
                                InputRichEdit.Clear;
                                InputRichEditChange(Self);
                              end;
                          end;
                        // Возвращаем пункты управления в исходное состояние
                        CancelBitBtn.Enabled := False;
                        if not FileTransferForm.Visible then
                          Close;
                      end;
                  end;
              end;
            end;
        X :;
        finally
          Xlog(RS_SF + RS_RcvdSF);
          // Высвобождаем блок памяти
          List.Free;
          SendFileHttpClient.RcvdStream.Free;
          SendFileHttpClient.RcvdStream := nil;
        end;
      end;
  except
    on E: Exception do
      MainForm.IMaderingEventsException(Self, E);
  end;
end;

end.
