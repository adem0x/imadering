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
    SendFileClient: THttpCli;
    DescEdit: TEdit;
    PassEdit: TEdit;
    DescLabel: TLabel;
    SendFileButton: TBitBtn;
    PassLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure SendFileClientDocBegin(Sender: TObject);
    procedure SendFileClientSendEnd(Sender: TObject);
    procedure SendFileClientSessionClosed(Sender: TObject);
    procedure SendFileButtonClick(Sender: TObject);
    procedure SendFileClientSendData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure SendFileClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure SendFileClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure SendFileClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure FormDblClick(Sender: TObject);
    procedure SendFileClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);

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
  JabberProtoUnit,
  MraProtoUnit,
  ChatUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_UpWap_RootURL = 'http://upwap.ru';
  C_UpWap_Name = 'UpWap.ru';
  C_UpWap_BadFileFormat = 'Запрещенный формат файла';
  C_UpWap_FileOK = 'Файл размещен';

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
  SendFileClient.Abort;
  SettingsForm.ApplyProxyHttpClient(SendFileClient);
  case Tag of
    1:
      begin // Передача через сервис UpWap.ru
        with SendFileClient do
        begin
          // Запрашиваем страницу с кодом сессии
          SendProgressBar.Position := 0;
          // Ставим флаг события для данных
          Tag := 0;
          // Формируем URL запроса
          URL := C_UpWap_RootURL + '/upload/';
          // Выводим информацию о начале процесса
          BottomInfoPanel.Caption := Lang_Vars[89].L_S;
          //Xlog(Name + ' ' + Log_Send, URL, C_HTTP, False);
          // Начинаем запрос данных
          GetASync;
        end;
      end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TFileTransferForm.SendFileClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
begin
  // Управляем кукие
  //XLog(SendFileClient.Name + ' ' + Log_Get + ' ' + C_Cookie, Data, C_HTTP);
end;

procedure TFileTransferForm.SendFileClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  SendFileClient.RcvdStream := TMemoryStream.Create;
end;

procedure TFileTransferForm.SendFileClientSendData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  // Отображаем процесс передачи файла
  SendProgressBar.Max := SendFileClient.SendStream.Size;
  SendProgressBar.Position := SendFileClient.SentCount;
  // Обновляем форму и контролы чтобы видеть изменения
  Update;
  // Если прерывание передачи, то останавливаем сокет
  if SendFileClient.Tag = 2 then
  begin
    SendFileClient.Close;
    SendFileClient.Abort;
  end;
end;

procedure TFileTransferForm.SendFileClientSendEnd(Sender: TObject);
begin
  // Увеличиваем статистику исходящего трафика
  V_TrafSend := V_TrafSend + SendFileClient.SentCount;
  V_AllTrafSend := V_AllTrafSend + SendFileClient.SentCount;
  if Assigned(TrafficForm) then
    MainForm.Traffic_MenuClick(nil);
end;

procedure TFileTransferForm.SendFileClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  with SendFileClient do
  begin
    if (StatusCode = 0) or (StatusCode >= 400) then
    begin
      if Tag = 1 then
        BottomInfoPanel.Caption := Format(ErrorHttpClient(StatusCode), [C_UpWap_Name])
      else
        BottomInfoPanel.Caption := Format(ErrorHttpClient(StatusCode), [SendFileClient.Name]);
    end;
  end;
end;

procedure TFileTransferForm.SendFileClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(Lang_Vars[17].L_S, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TFileTransferForm.SendFileClientSocksError(Sender: TObject; Error: Integer; Msg: string);
var
  S: string;
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    S := Format(Lang_Vars[23].L_S, [(Sender as THttpCli).name]) + ' ' + Msg + ' ' + '[' + Format(Lang_Vars[27].L_S, [Error]) + ']';
    DAShow(Lang_Vars[17].L_S, S, EmptyStr, 134, 2, 0);
  end;
end;

procedure TFileTransferForm.CancelBitBtnClick(Sender: TObject);
begin
  // Блокируем кнопку
  CancelBitBtn.Enabled := False;
  // Останавливаем передачу файла
  SendFileClient.Tag := 2;
  SendFileClient.Close;
  SendFileClient.Abort;
  // Разблокируем контролы Описания и Пароля
  DescEdit.Enabled := True;
  DescEdit.Color := ClWindow;
  PassEdit.Enabled := True;
  PassEdit.Color := ClWindow;
  if Sender <> nil then
  begin
    BottomInfoPanel.Caption := Lang_Vars[91].L_S;
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
  SettingsForm.ApplyProxyHttpClient(SendFileClient);
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

procedure TFileTransferForm.SendFileClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
label
  X;
var
  List: TStringList;
  Doc, Skey, OKURL, HistoryFile, MsgD: string;
  FileToSend: TMemoryStream;
  Buf, Boundry: Utf8String;
begin
  try
    // Высвобождаем память отправки данных
    if SendFileClient.SendStream <> nil then
    begin
      SendFileClient.SendStream.Free;
      SendFileClient.SendStream := nil;
    end;
    // Читаем полученные http данные из блока памяти
    if SendFileClient.RcvdStream <> nil then
    begin
      // Создаём временный лист
      List := TStringList.Create;
      try
        // Увеличиваем статистику входящего трафика
        V_TrafRecev := V_TrafRecev + SendFileClient.RcvdCount;
        V_AllTrafRecev := V_AllTrafRecev + SendFileClient.RcvdCount;
        if Assigned(TrafficForm) then
          MainForm.Traffic_MenuClick(nil);
        // Обнуляем позицию начала чтения в блоке памяти
        SendFileClient.RcvdStream.Position := 0;
        // Читаем данные в лист
        List.LoadFromStream(SendFileClient.RcvdStream);
        // Разбираем данные в листе
        if List.Text <> EmptyStr then
        begin
          Doc := UTF8ToString(List.Text);
          //Xlog(SendFileClient.Name + ' ' + Log_Get, Trim(Doc), C_HTTP);
          case SendFileClient.Tag of // Определяем выполнение задания для данных по флагу
            0:
              begin
                // Узнаём ключ сессии
                Skey := EmptyStr;
                Skey := IsolateTextString(Doc, 'action="', '"');
                //Xlog(SendFileClient.Name + ' ' + Log_Parsing, Skey, C_HTTP);
                // Формируем данные для отправки
                with SendFileClient do
                begin
                  // Создаём блок памяти для отправки файла методом POST
                  SendStream := TMemoryStream.Create;
                  // Ссылка для приёма данных
                  URL := C_UpWap_RootURL + Skey;
                  //Xlog(SendFileClient.Name + ' ' + Log_Parsing, URL, C_HTTP);
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
                  SendFileClient.Tag := 1;
                  PostAsync;
                end;
              end;
            1:
              begin
                // Ищем информацию об успешной закачке файла на сервер
                if Pos(C_UpWap_FileOK, Doc) > 0 then
                begin
                  BottomInfoPanel.Caption := Lang_Vars[90].L_S;
                  // Воспроизводим звук удачной пересылки файла
                  ImPlaySnd(6);
                  // Формируем текст со ссылкой
                  OKURL := C_UpWap_RootURL + IsolateTextString(Doc, 'action="', '"');
                  //Xlog(SendFileClient.Name + ' ' + Log_Parsing, OKURL, C_HTTP);
                  case Tag of
                    1: OKURL := Format(Lang_Vars[92].L_S, [T_FileName, OKURL, C_UpWap_Name, FileSizePanel.Caption]);
                  end;
                  // Отправляем сообщение с сылкой на файл
                  if T_UserType = C_Icq then
                  begin
                    // Если нет подключения к серверу ICQ, то выходим
                    if NotProtoOnline(C_Icq) then
                      goto X;
                    // Отправляем сообщение в юникод формате
                    ICQ_SendMessage_0406(T_UIN, OKURL, True);
                    // Формируем файл с историей
                    HistoryFile := V_ProfilePath + C_HistoryFolder + C_Icq + ' ' + ICQ_LoginUIN + ' ' + T_UIN + C_Htm_Ext;
                  end
                  else if T_UserType = C_Jabber then
                  begin
                    // Если нет подключения к серверу Jabber, то выходим
                    if NotProtoOnline(C_Jabber) then
                      goto X;
                    // Отправляем сообщение
                    Jab_SendMessage(J_ChatType, T_UIN, OKURL);
                    // Формируем файл с историей
                    HistoryFile := V_ProfilePath + C_HistoryFolder + C_Jabber + ' ' + Jabber_LoginUIN + ' ' + T_UIN + C_Htm_Ext;
                  end
                  else if T_UserType = C_Mra then
                  begin
                    // Если нет подключения к серверу MRA, то выходим
                    if NotProtoOnline(C_Mra) then
                      goto X;
                    // Отправляем сообщение
                    MRA_SendMessage(T_UIN, OKURL);
                    // Формируем файл с историей
                    HistoryFile := V_ProfilePath + C_HistoryFolder + C_Mra + ' ' + MRA_LoginUIN + ' ' + T_UIN + C_Htm_Ext;
                  end
                  else
                    goto X;
                  // Форматируем сообщение
                  MsgD := V_YouAt + ' ' + '[' + DateTimeChatMess + ']';
                  CheckMessage_BR(OKURL);
                  DecorateURL(OKURL);
                  // Записываем историю в файл этого контакта
                  SaveTextInHistory(Format(C_HistoryOut, [MsgD, OKURL]), HistoryFile);
                  // Если окно сообщений не было создано, то создаём его
                  if not Assigned(ChatForm) then
                    Application.CreateForm(TChatForm, ChatForm);
                  // Если вкладка чата совпадает с UIN получателя
                  with ChatForm do
                  begin
                    if UIN_Panel.Caption = T_UIN then
                    begin
                      // Оповещаем о удачной передаче файла
                      NotifyPanel.Caption := Lang_Vars[90].L_S;
                      // Увеличиваем счётчик исходящих сообщений
                      Inc(OutMessIndex);
                      // Добавляем в чат сообщение
                      AddChatText(MsgD, OKURL);
                      // Прокручиваем чат до конца
                      HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
                    end;
                  end;
                end
                else if Pos(C_UpWap_BadFileFormat, Doc) > 0 then
                begin
                  BottomInfoPanel.Caption := Lang_Vars[17].L_S + ':' + ' ' + C_UpWap_BadFileFormat;
                  DAShow(Lang_Vars[17].L_S + ' ' + SendFileClient.Name, C_UpWap_BadFileFormat, EmptyStr, 134, 2, 0);
                end;
                X: ;
                // Возвращаем пункты управления в исходное состояние
                CancelBitBtn.Enabled := False;
                if not FileTransferForm.Visible then
                  Close;
              end;
          end;
        end;
      finally
        // Высвобождаем блок памяти
        List.Free;
        SendFileClient.RcvdStream.Free;
        SendFileClient.RcvdStream := nil;
      end;
    end;
  except
    on E: Exception do
      MainForm.AppException(Self, E);
  end;
end;

{$ENDREGION}

end.

