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

  private
    { Private declarations }
  public
    { Public declarations }
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
  MraProtoUnit;

{$R *.dfm}

const
  UpWapRootURL = 'http://upwap.ru';

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
    1: begin
        // Запрашиваем страницу с кодом сессии
        SendProgressBar.Position := 0;
        SendFileHttpClient.Tag := 0;
        SendFileHttpClient.URL := 'http://upwap.ru/upload/';
        BottomInfoPanel.Caption := FileTransfer2L;
        SendFileHttpClient.GetASync;
      end;
  end;
end;

procedure TFileTransferForm.SendFileHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  SendFileHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TFileTransferForm.SendFileHttpClientDocEnd(Sender: TObject);
var
  List: TStringList;
  Doc, Skey, Buf, Boundry, OKURL: string;
  FileToSend: TMemoryStream;
  RosterItem: TListItem;
  SendYES: Boolean;
begin
  SendYES := False;
  // Читаем полученные http данные из блока памяти
  if SendFileHttpClient.RcvdStream <> nil then
    begin
      try
        // Увеличиваем статистику входящего трафика
        TrafRecev := TrafRecev + SendFileHttpClient.RcvdCount;
        AllTrafRecev := AllTrafRecev + SendFileHttpClient.RcvdCount;
        if Assigned(TrafficForm) then
          MainForm.OpenTrafficClick(nil);
        // Определяем выполнение задания для данных по флагу
        // Создаём временный лист
        List := TStringList.Create;
        try
          // Обнуляем позицию начала чтения в блоке памяти
          SendFileHttpClient.RcvdStream.Position := 0;
          // Читаем данные в лист
          List.LoadFromStream(SendFileHttpClient.RcvdStream);
          // Разбираем данные в листе
          if List.Text > EmptyStr then
            begin
              Doc := List.Text;
              case SendFileHttpClient.Tag of
                0: begin
                    // Узнаём ключ сессии
                    Skey := IsolateTextString(Doc, 'action="', '"');
                    // Создаём блок памяти для отправки файла методом POST
                    SendFileHttpClient.SendStream := TMemoryStream.Create;
                    // Формируем данные для отправки
                    with SendFileHttpClient do
                      begin
                        // Ссылка для приёма данных
                        URL := UpWapRootURL + Skey;
                        // Заполняем переменные для POST
                        Boundry := '----------sZLbqiVRVfOO8NjlMuYJE3';
                        { Specified in Multipart/form-data RFC }
                        ContentTypePost := UTF8Encode('multipart/form-data; boundary=' + Copy(Boundry, 3, Length(Boundry)));
                        Buf := UTF8Encode
                          (Boundry + RN + 'Content-Disposition: form-data; name="file"; filename="' + FileSizePanel.Hint + '"' + RN +
                            'Content-Type: image/jpeg' + RN + RN);
                        // Записываем переменные в память
                        SendStream.write(Buf[1], Length(Buf));
                        // Создаём блок памяти для файла
                        try
                          FileToSend := TMemoryStream.Create;
                          FileToSend.LoadFromFile(FileNamePanel.Hint);
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
                        OnSessionClosed := nil;
                        Abort;
                        OnSessionClosed := SendFileHttpClientSessionClosed;
                        SendFileHttpClient.Tag := 1;
                        PostAsync;
                      end;
                  end;
                1: begin
                    // Блокируем кнопку отмены операции
                    CancelBitBtnClick(nil);
                    // Ищем информацию об успешной закачке файла на сервер
                    if BMSearch(0, Doc, 'Файл размещен') > -1 then
                      begin
                        BottomInfoPanel.Caption := FileTransfer3L;
                        OKURL := UpWapRootURL + IsolateTextString(Doc, 'action="', '"');
                        // Формируем текст со ссылкой
                        case Tag of
                          1: OKURL := Format(FileTransfer5L, [FileSizePanel.Hint, OKURL, 'upwap.ru', 'http://upwap.ru']);
                        end;
                        // Ищем такой контакт в Ростере
                        RosterItem := RosterForm.ReqRosterItem(TopInfoPanel.Hint);
                        if RosterItem <> nil then
                          begin
                            // Отсылаем контакту ссылку и записываем это в историю сообщений
                            if RosterItem.SubItems[3] = 'Icq' then
                              begin
                                if ICQ_Work_Phaze then
                                  begin
                                    if (RosterItem.SubItems[6] <> '9') and (RosterItem.SubItems[33] = 'X') then
                                      ICQ_SendMessage_0406(RosterItem.Caption, OKURL, False)
                                    else
                                      ICQ_SendMessage_0406(RosterItem.Caption, OKURL, True);
                                    SendYES := True;
                                  end;
                              end
                            else if RosterItem.SubItems[3] = 'Jabber' then
                              begin

                              end
                            else if RosterItem.SubItems[3] = 'Mra' then
                              begin

                              end;
                            // Добавляем в историю
                            if SendYES then
                              begin
                                CheckMessage_BR(OKURL);
                                DecorateURL(OKURL);
                                RosterItem.SubItems[13] := RosterItem.SubItems[13] + '<span class=a>' + YouAt + ' [' + DateTimeChatMess +
                                  ']' + '</span><br><span class=c>' + OKURL + '</span><br><br>' + RN;
                              end;
                          end;
                      end;
                  end;
              end;
            end;
        finally
          List.Free;
        end;
      finally
        // Высвобождаем блок памяти
        SendFileHttpClient.RcvdStream.Free;
        SendFileHttpClient.RcvdStream := nil;
      end;
    end;
end;

procedure TFileTransferForm.SendFileHttpClientSendData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  // Если прерывание передачи, то останавливаем сокет
  if SendFileHttpClient.Tag = 2 then
    begin
      SendFileHttpClient.CloseAsync;
      SendFileHttpClient.Abort;
    end;
  // Отображаем процесс передачи файла
  SendProgressBar.Max := SendFileHttpClient.SendStream.Size;
  SendProgressBar.Position := SendFileHttpClient.SentCount;
  // Обновляем форму и контролы чтобы видеть изменения
  Update;
end;

procedure TFileTransferForm.SendFileHttpClientSendEnd(Sender: TObject);
begin
  // Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + SendFileHttpClient.SentCount;
  AllTrafSend := AllTrafSend + SendFileHttpClient.SentCount;
  if Assigned(TrafficForm) then
    MainForm.OpenTrafficClick(nil);
end;

procedure TFileTransferForm.SendFileHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (SendFileHttpClient.StatusCode = 0) or (SendFileHttpClient.StatusCode >= 400) then
    begin
      BottomInfoPanel.Caption := ErrorHttpClient(SendFileHttpClient.StatusCode);
    end;
end;

procedure TFileTransferForm.CancelBitBtnClick(Sender: TObject);
begin
  // Блокируем кнопку
  CancelBitBtn.Enabled := False;
  // Останавливаем передачу файла
  SendFileHttpClient.Tag := 2;
  SendFileHttpClient.Abort;
  // Разблокируем контролы Описания и Пароля
  DescEdit.Enabled := True;
  DescEdit.Color := ClWindow;
  PassEdit.Enabled := True;
  PassEdit.Color := ClWindow;
  if Sender <> nil then
    begin
      BottomInfoPanel.Caption := FileTransfer4L;
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
      // Высвобождаем память
      if SendFileHttpClient.SendStream <> nil then
        begin
          SendFileHttpClient.SendStream.Free;
          SendFileHttpClient.SendStream := nil;
        end;
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
end;

procedure TFileTransferForm.TranslateForm;
begin
  // Переводим окно на другие языки

end;

end.
