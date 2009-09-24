{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit FileTransferUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, OverbyteIcsWndControl,
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
    SendStatusLabel: TLabel;
    SendFileHttpClient: THttpCli;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure SendFileHttpClientDocBegin(Sender: TObject);
    procedure SendFileHttpClientDocEnd(Sender: TObject);
    procedure SendFileHttpClientSendEnd(Sender: TObject);
    procedure SendFileHttpClientSessionClosed(Sender: TObject);
    procedure SendFileHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure SendFileHttpClientSocksError(Sender: TObject; Error: Integer;
      Msg: string);
  private
    { Private declarations }
  public
    { Public declarations }
    SendForUIN: string;
    procedure TranslateForm;
    procedure SendUpWap(xFile: string);
  end;

var
  FileTransferForm: TFileTransferForm;

implementation

uses MainUnit, SettingsUnit, UnitLogger, TrafficUnit, VarsUnit, UtilsUnit,
  IcqProtoUnit;

{$R *.dfm}

const
  UpWapRootURL = 'http://upwap.ru';

procedure TFileTransferForm.SendFileHttpClientDocBegin(Sender: TObject);
begin
  //--Создаём блок памяти для приёма http данных
  SendFileHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TFileTransferForm.SendFileHttpClientDocEnd(Sender: TObject);
var
  list: TStringList;
  Doc, skey: string;
begin
  //--Читаем полученные http данные из блока памяти
  if SendFileHttpClient.RcvdStream <> nil then
  begin
    try
      //--Увеличиваем статистику входящего трафика
      TrafRecev := TrafRecev + SendFileHttpClient.RcvdCount;
      AllTrafRecev := AllTrafRecev + SendFileHttpClient.RcvdCount;
      if Assigned(TrafficForm) then MainForm.OpenTrafficClick(nil);
      //--Определяем выполнение задания для данных по флагу
      //--Создаём временный лист
      list := TStringList.Create;
      try
        //--Обнуляем позицию начала чтения в блоке памяти
        SendFileHttpClient.RcvdStream.Position := 0;
        //--Читаем данные в лист
        list.LoadFromStream(SendFileHttpClient.RcvdStream);
        //--Разбираем данные в листе
        if list.Text > EmptyStr then
        begin
          Doc := DecodeStr(list.Text);
          case SendFileHttpClient.Tag of
            0:
              begin
                //--Узнаём ключ сессии
                skey := IsolateTextString(Doc, 'action="', '"');
                SendFileHttpClient.
              end;
            1:
              begin
                showmessage(Doc);
              end;
          end;
        end;
      finally
        list.Free;
      end;
    finally
      //--Высвобождаем блок памяти
      SendFileHttpClient.RcvdStream.Free;
      SendFileHttpClient.RcvdStream := nil;
    end;
  end;
end;

procedure TFileTransferForm.SendFileHttpClientSendEnd(Sender: TObject);
begin
  //--Увеличиваем статистику исходящего трафика
  TrafSend := TrafSend + SendFileHttpClient.SentCount;
  AllTrafSend := AllTrafSend + SendFileHttpClient.SentCount;
  if Assigned(TrafficForm) then MainForm.OpenTrafficClick(nil);
end;

procedure TFileTransferForm.SendFileHttpClientSessionClosed(Sender: TObject);
begin
  //--Обрабатываем возможные ошибки в работе http сокета
  if (SendFileHttpClient.StatusCode = 0) or (SendFileHttpClient.StatusCode >= 400) then
  begin
    DAShow(ErrorHead, ErrorHttpClient(SendFileHttpClient.StatusCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TFileTransferForm.SendFileHttpClientSocksConnected(Sender: TObject;
  ErrCode: Word);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TFileTransferForm.SendFileHttpClientSocksError(Sender: TObject;
  Error: Integer; Msg: string);
begin
  //--Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    DAShow(ErrorHead, Msg, EmptyStr, 134, 2, 0);
  end;
end;

procedure TFileTransferForm.SendUpWap(xFile: string);
begin
  //--Сбрасываем сокет
  SendFileHttpClient.Abort;
  //--Назначаем URL
  try
    SendFileHttpClient.URL := 'http://upwap.ru/upload/';
    SendFileHttpClient.GetASync;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(E);
  end;
end;

procedure TFileTransferForm.CancelBitBtnClick(Sender: TObject);
begin
  //--Блокируем кнопку
  CancelBitBtn.Enabled := false;
  //--Останавливаем передачу файла
  SendFileHttpClient.Tag := 2;
  SendFileHttpClient.Abort;
end;

procedure TFileTransferForm.CloseBitBtnClick(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TFileTransferForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //--Если передача закончена, то уничтожаем окно
  if not CancelBitBtn.Enabled then
  begin
    Action := caFree;
    FileTransferForm := nil;
  end;
end;

procedure TFileTransferForm.FormCreate(Sender: TObject);
begin
  //--Переводим окно на другие языки
  TranslateForm;
  //--Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(149, Icon);
  //--Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //--Применяем параметры прокси
  SendFileHttpClient.Abort;
  SettingsForm.ApplyProxyHttpClient(SendFileHttpClient);
end;

procedure TFileTransferForm.TranslateForm;
begin
  //--Переводим окно на другие языки

end;

end.

