{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit FileTransferUnit;

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

{$ENDREGION}

var
  FileTransferForm: TFileTransferForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

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

{$ENDREGION}
{$REGION 'MyConst'}

const
  UpWapRootURL = 'http://upwap.ru';
  C_SF = 'SFClient | ';
  C_DB = 'Doc_Begin; Rcvd_Stream Create';
  C_SDA = 'Send_Data; Abort';
  C_DE = 'Doc_End';
  C_SE = 'Send_End';
  C_SesClose = 'Session_Closed; Status_Code = ';
  C_ReqD = 'Request_Done; Error = ';
  C_RcvdSE = 'Rcvd_Stream; Enabled';
  C_RcvdSF = 'Rcvd_Stream; Free';
  C_SendSF = 'Send_Stream; Free';

{$ENDREGION}
{$REGION 'SendFileButtonClick'}

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
        BottomInfoPanel.Caption := Lang_Vars[89].L_S;
        Xlog(Lang_Vars[89].L_S + C_BN + SendFileHttpClient.URL, EmptyStr);
        // Начинаем запрос данных
        SendFileHttpClient.GetASync;
      end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TFileTransferForm.SendFileHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  Xlog(C_SF + C_DB, EmptyStr);
  SendFileHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TFileTransferForm.SendFileHttpClientDocEnd(Sender: TObject);
begin
  Xlog(C_SF + C_DE, EmptyStr);
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
      Xlog(C_SF + C_SDA, EmptyStr);
      SendFileHttpClient.CloseAsync;
      SendFileHttpClient.Abort;
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSendEnd(Sender: TObject);
begin
  Xlog(C_SF + C_SE, EmptyStr);
  // Увеличиваем статистику исходящего трафика
  V_TrafSend := V_TrafSend + SendFileHttpClient.SentCount;
  V_AllTrafSend := V_AllTrafSend + SendFileHttpClient.SentCount;
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
          BottomInfoPanel.Caption := Format(ErrorHttpClient(StatusCode), [C_BN]);
          Xlog(C_SF + C_SesClose + IntToStr(StatusCode), EmptyStr);
        end;
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, Lang_Vars[23].L_S + C_RN + Msg + C_RN + Format(Lang_Vars[27].L_S, [Error]) + C_RN + '[ ' + Lang_Vars[94].L_S + C_TN + (Sender as THttpCli).name + ' ]', EmptyStr, 134, 2, 0);
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
      BottomInfoPanel.Caption := Lang_Vars[91].L_S;
      Xlog(C_SF + Lang_Vars[91].L_S, EmptyStr);
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

procedure TFileTransferForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

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

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TFileTransferForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelBitBtn.Caption := Lang_Vars[9].L_S;
  CloseBitBtn.Caption := Lang_Vars[8].L_S;
end;

{$ENDREGION}
{$REGION 'SendFileHttpClientRequestDone'}

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
    Xlog(C_SF + C_ReqD + IntToStr(ErrCode), EmptyStr);
    // Высвобождаем память отправки данных
    if SendFileHttpClient.SendStream <> nil then
      begin
        SendFileHttpClient.SendStream.Free;
        SendFileHttpClient.SendStream := nil;
        Xlog(C_SF + C_SendSF, EmptyStr);
      end;
    // Читаем полученные http данные из блока памяти
    if SendFileHttpClient.RcvdStream <> nil then
      begin
        Xlog(C_SF + C_RcvdSE, EmptyStr);
        // Создаём временный лист
        List := TStringList.Create;
        try
          // Увеличиваем статистику входящего трафика
          V_TrafRecev := V_TrafRecev + SendFileHttpClient.RcvdCount;
          V_AllTrafRecev := V_AllTrafRecev + SendFileHttpClient.RcvdCount;
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
              Xlog(C_SF + C_RN + C_RN + Doc, EmptyStr);
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
                        Xlog(C_SF + URL, EmptyStr);
                        // Заполняем переменные для POST
                        Boundry := '------------sZLbqiVRVfOO8NjlMuYJE3';
                        { Specified in Multipart/form-data RFC }
                        ContentTypePost := UTF8Encode('multipart/form-data; boundary=' + Copy(Boundry, 3, Length(Boundry)));
                        Buf := UTF8Encode(Boundry + C_RN + 'Content-Disposition: form-data; name="file"; filename="' + T_FileName + '"' + C_RN + 'Content-Type: image/jpeg' + C_RN + C_RN);
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
                        Buf := UTF8Encode(C_RN + Boundry + C_RN + 'Content-Disposition: form-data; name="desc"' + C_RN + C_RN + DescEdit.Text + C_RN + Boundry + C_RN +
                            'Content-Disposition: form-data; name="password"' + C_RN + C_RN + PassEdit.Text + C_RN + Boundry + C_RN + 'Content-Disposition: form-data; name="send"' + C_RN + C_RN +
                            'Отправить!' + C_RN + Boundry + '--' + C_RN);
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
                        BottomInfoPanel.Caption := Lang_Vars[90].L_S;
                        // Воспроизводим звук удачной пересылки файла
                        ImPlaySnd(6);
                        // Формируем текст со ссылкой
                        OKURL := UpWapRootURL + IsolateTextString(Doc, 'action="', '"');
                        case Tag of
                          1: OKURL := Format(Lang_Vars[92].L_S, [T_FileName, OKURL, 'upwap.ru', FileSizePanel.Caption]);
                        end;
                        Xlog(C_SF + C_RN + OKURL, EmptyStr);
                        MsgD := V_YouAt + ' [' + DateTimeChatMess + ']';
                        CheckMessage_BR(OKURL);
                        DecorateURL(OKURL);
                        // Отправляем сообщение с сылкой на файл
                        if T_UserType = C_Icq then
                          begin
                            // Если нет подключения к серверу ICQ, то выходим
                            if NotProtoOnline(C_Icq) then
                              goto X;
                            // Отправляем сообщение в юникод формате
                            ICQ_SendMessage_0406(T_UIN, OKURL, True);
                            // Формируем файл с историей
                            HistoryFile := V_ProfilePath + C_HistoryFolder + C_Icq + C_BN + ICQ_LoginUIN + C_BN + T_UIN + '.htm';
                          end
                        else if T_UserType = C_Jabber then
                          begin
                            // Если нет подключения к серверу Jabber, то выходим
                            if NotProtoOnline(C_Jabber) then
                              goto X;
                            // Отправляем сообщение
                            Jab_SendMessage(T_UIN, OKURL);
                            // Формируем файл с историей
                            HistoryFile := V_ProfilePath + C_HistoryFolder + C_Jabber + C_BN + Jabber_LoginUIN + C_BN + T_UIN + '.htm';
                          end
                        else if T_UserType = C_Mra then
                          begin
                            // Если нет подключения к серверу MRA, то выходим
                            if NotProtoOnline(C_Mra) then
                              goto X;
                            // Формируем файл с историей
                            HistoryFile := V_ProfilePath + C_HistoryFolder + C_Mra + C_BN + MRA_LoginUIN + C_BN + T_UIN + '.htm';
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
                                NotifyPanel.Caption := Lang_Vars[90].L_S;
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
          Xlog(C_SF + C_RcvdSF, EmptyStr);
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

{$ENDREGION}

end.
