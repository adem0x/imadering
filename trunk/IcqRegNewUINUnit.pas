{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqRegNewUINUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, OverbyteIcsWndControl, OverbyteIcsWSocket,
  Buttons, ShellApi;

type
  TIcqRegNewUINForm = class(TForm)
    RegInfoPanel: TPanel;
    RegPassLabel: TLabel;
    RegPassEdit: TEdit;
    ReqSecretImageButton: TButton;
    RegImagePanel: TPanel;
    RegImage: TImage;
    ImageWordLabel: TLabel;
    SecretWordEdit: TEdit;
    NewUINRegButton: TButton;
    ICQRegWSocket: TWSocket;
    CopyUINSpeedButton: TSpeedButton;
    Bevel1: TBevel;
    WebRegLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReqSecretImageButtonClick(Sender: TObject);
    procedure ICQRegWSocketDataAvailable(Sender: TObject; ErrCode: Word);
    procedure NewUINRegButtonClick(Sender: TObject);
    procedure CopyUINSpeedButtonClick(Sender: TObject);
    procedure WebRegLabelMouseEnter(Sender: TObject);
    procedure WebRegLabelMouseLeave(Sender: TObject);
    procedure WebRegLabelClick(Sender: TObject);
    procedure ICQRegWSocketSessionConnected(Sender: TObject; ErrCode: Word);
    procedure ICQRegWSocketSessionClosed(Sender: TObject; ErrCode: Word);
    procedure ICQRegWSocketSocksError(Sender: TObject; Error: Integer;
      Msg: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IcqRegNewUINForm: TIcqRegNewUINForm;

implementation

uses UtilsUnit, VarsUnit, MainUnit, IcqProtoUnit;

{$R *.dfm}

procedure TIcqRegNewUINForm.CopyUINSpeedButtonClick(Sender: TObject);
var
  ed: TEdit;
begin
  //--Это ламерский код но против глюков в других методах
  //я применил этот для копирования в буфер обмена
  ed := TEdit.Create(nil);
  ed.Visible := false;
  ed.Parent := IcqRegNewUINForm;
  ed.Text := RegInfoPanel.Caption;
  ed.SelectAll;
  ed.CopyToClipboard;
  FreeAndNil(ed);
end;

procedure TIcqRegNewUINForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //--Если сокет уже подключён, то закрываем его и ждем когда он закроется
  ICQRegWSocket.Close;
  ICQRegWSocket.WaitForClose;
  //--Указываем уничтожаться окну при закрытии
  Action := caFree;
  IcqRegNewUINForm := nil;
end;

procedure TIcqRegNewUINForm.FormCreate(Sender: TObject);
begin
  //--Присваиваем иконки окну и кнопкам
  MainForm.AllImageList.GetIcon(81, Icon);
  MainForm.AllImageList.GetBitmap(144, CopyUINSpeedButton.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TIcqRegNewUINForm.ICQRegWSocketDataAvailable(Sender: TObject;
  ErrCode: Word);
label
  x, z;
var
  Pkt, HexPkt, SubPkt, ImageData, NewUin: string;
  PktLen, Len: integer;
  StreamImg: TMemoryStream;
begin
  //--Получаем пришедшие от сервера данные с сокета
  Pkt := ICQRegWSocket.ReceiveStr;
  //--Если длинна этих данных равна нулю, выходим от сюда :)
  if Length(Pkt) = 0 then Exit;
  //--Преобразуем данные из бинарного формата в HEX формат и прибавляем
  //их к специальному буферу накопления таких преобразованных данных
  ICQ_RegUIN_HexPkt := ICQ_RegUIN_HexPkt + Text2Hex(Pkt);
  //--Ищем ошибки в буфере пакетов
  if ((ICQ_RegUIN_HexPkt > EmptyStr) and (HexToInt(LeftStr(ICQ_RegUIN_HexPkt, 2)) <> $2A)) or
    ((Length(ICQ_RegUIN_HexPkt) > 2) and ((HexToInt(ICQ_RegUIN_HexPkt[3] + ICQ_RegUIN_HexPkt[4]) = $0)
    or (HexToInt(ICQ_RegUIN_HexPkt[3] + ICQ_RegUIN_HexPkt[4]) > $05))) then
  begin
    //--Если в пакете есть ошибки, то закрываем сокет и выводим сообщение об ошибке
    DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
    ICQRegWSocket.Close;
    Exit;
  end;
  //--Если пакет был разобран, но в буфере есть ещё данные, то возвращаемся сюда
  //для проверки этих данные на наличие слудующего целого пакета данных
  x: ;
  //--Проверяем если ли в буфере хоть один целый пакет
  if (Length(ICQ_RegUIN_HexPkt) >= ICQ_FLAP_HEAD_SIZE) and (Length(ICQ_RegUIN_HexPkt) >= ICQ_FLAP_HEAD_SIZE + ICQ_BodySize2) or
    ((HexToInt(ICQ_RegUIN_HexPkt[3] + ICQ_RegUIN_HexPkt[4]) = $04) and (ICQ_BodySize2 = 0)) then
  begin
    //--Забираем из буфера один целый пакет
    HexPkt := NextData(ICQ_RegUIN_HexPkt, ICQ_FLAP_HEAD_SIZE + ICQ_BodySize2);
    //--Разбираем пакет данных если его длинна больше нуля
    if Length(HexPkt) > 0 then
    begin
      //--Ещё раз делаем проверку на начало пакета ICQ протокола по метке $2A
      if HexToInt(NextData(HexPkt, 2)) = $2A then
      begin
        //--Смотрим какой канал у пакета
        case HexToInt(NextData(HexPkt, 2)) of
          $01:
            begin
              //--Пропускаем Seq (счётчик)
              NextData(HexPkt, 4);
              //--Узнаём длинну пакета и увеличиваем её в двое для HEX формата
              PktLen := HexToInt(NextData(HexPkt, 4));
              PktLen := PktLen * 2;
              //--Получаем тело пакета
              SubPkt := NextData(HexPkt, PktLen);
              //--Если AOL прислал приглашение
              if SubPkt = '00000001' then
              begin
                //--Отсылаем ему тоже "привет" + что-то новое в протоколе
                SendFLAP_Reg('1', '00000001' + '8003000400100000');
                //--Затем отсылаем запрос на картинку
                SendFLAP_Reg('2', '0017000C0000000000000000');
              end;
            end;
          $02:
            begin
              //--Пропускаем Seq (счётчик)
              NextData(HexPkt, 4);
              //--Узнаём длинну пакета и увеличиваем её в двое для HEX формата
              PktLen := HexToInt(NextData(HexPkt, 4));
              PktLen := PktLen * 2;
              //--Получаем тело пакета
              SubPkt := NextData(HexPkt, PktLen);
              //--Смотрим какая фэмили у пакета
              case HexToInt(NextData(SubPkt, 4)) of
                $0017:
                  begin
                    //--Смотрим какая субфэмили у пакета
                    case HexToInt(NextData(SubPkt, 4)) of
                      $0001: //--Означает что сервер отказал в регистрации
                        begin
                          //--Отображаем, на панели, что в регистрации было отказано
                          if Assigned(IcqRegNewUINForm) then RegInfoPanel.Caption := ICQRegNewInfo_1;
                        end;
                      $0005: //--Пакет содержит новый зареганый UIN
                        begin
                          //--Пропускаем раздел флагов
                          NextData(SubPkt, 12);
                          //--Пропускаем другие непонятные данные в пакете
                          NextData(SubPkt, 92);
                          //--Расшифровываем новый UIN
                          NewUin := FloatToStr(Swap32(HexToInt(NextData(SubPkt, 8))));
                          //--Если новый номер действительно есть, то отображаем его на панели
                          if NewUin > EmptyStr then
                          begin
                            //--Проверяем на всякий случай не была ли форма закрыта
                            if Assigned(IcqRegNewUINForm) then
                            begin
                              //--Отображаем UIN и пароль на панели
                              RegInfoPanel.Caption := 'ICQ#: ' + NewUin + '  ' + PassLabelInfo + ' ' + RegPassEdit.Text;
                              //--Делаем кнопку копирования нового UIN и пароля активной
                              CopyUINSpeedButton.Visible := true;
                              //--На всякий случай пишем в файл лог регистраций номеров ICQ
                              AppendOrWriteTextToFile(MyPath + 'Profile\Icq Registered Accounts.txt', NewUin + ';' + RegPassEdit.Text);
                            end;
                          end;
                        end;
                      $000D: //--Содержит картинку с секретным кодом
                        begin
                          //--Пропускаем раздел флагов
                          NextData(SubPkt, 12);
                          //--Пропускаем другие непонятные данные в пакете
                          NextData(SubPkt, 32);
                          //--Узнаём длинну данных с картинкой и увеличиваем её в двое для HEX формата
                          Len := HexToInt(NextData(SubPkt, 4));
                          Len := Len * 2;
                          //--Получаем данные картинки найденной длинны
                          ImageData := Hex2Text(NextData(SubPkt, Len));
                          //--Если эти данные реально есть, то пишем их в память
                          if ImageData > EmptyStr then
                          begin
                            //--Создали блок памяти
                            StreamImg := TMemoryStream.Create;
                            try
                              //--Заполняем память
                              StreamImg.Write(ImageData[1], Length(ImageData));
                              //--Сохраняем из памяти картинку на жёсткий диск
                              StreamImg.SaveToFile(Mypath + 'Profile\RegImage.jpg');
                              //--Если окно существует ещё то отображаем картинку на форме
                              if Assigned(IcqRegNewUINForm) then
                              begin
                                //--Загружаем картинку из сохранённого файла
                                RegImage.Picture.LoadFromFile(Mypath + 'Profile\RegImage.jpg');
                                //--Если поле ввода секретного слова доступно для фокуса то тавим курсор в него
                                if SecretWordEdit.CanFocus then SecretWordEdit.SetFocus;
                              end;
                            finally
                              //--Высвобождаем блок памяти
                              StreamImg.Free;
                            end;
                            //--Активируем кнопку регистации нового номера icq
                            NewUINRegButton.Enabled := true;
                          end;
                        end;
                    end;
                  end;
              end;
            end;
          $04: //--Сервер прощается с нами и говорит "до свидания"
            begin
              //--Пропускаем Seq (счётчик)
              NextData(HexPkt, 4);
              //--Смотрим длинну пакета
              PktLen := HexToInt(NextData(HexPkt, 4));
              //--Если длинна равно ноль, то точно прощается :)
              if PktLen = 0 then
              begin
                //--Если сокет ещё подключен, то тоже отправляем прощание
                if ICQRegWSocket.State = wsConnected then ICQRegWSocket.SendStr(Hex2Text('2A04' + IntToHex(ICQ_Seq2, 4) + '0000'));
                //--Закрываем сокет и ждем пока закроется
                ICQRegWSocket.Close;
                ICQRegWSocket.WaitForClose;
              end
              else
              begin
                //--Увеличиваем длинну пакета в двое для HEX формата
                PktLen := PktLen * 2;
                //--Получаем тело пакета
                SubPkt := NextData(HexPkt, PktLen);
                //--Идём по пакету пока не найдем нужный TLV
                while Length(SubPkt) > 0 do
                begin
                  case HexToInt(NextData(SubPkt, 4)) of
                    $0008: //--TLV с кодом ошибки
                      begin
                        //--Получаем длинну TLV и увеличиваем её в двое
                        Len := HexToInt(NextData(SubPkt, 4));
                        Len := Len * 2;
                        //--Показываем сообщение об этой ошибке
                        RegInfoPanel.Caption := ICQ_NotifyAuthCookieError(NextData(SubPkt, Len));
                        DAShow(ErrorHead, RegInfoPanel.Caption, EmptyStr, 134, 2, 0);
                        //--Закрываем сокет и ждем пока закроется
                        ICQRegWSocket.Close;
                        ICQRegWSocket.WaitForClose;
                      end
                  else
                    begin
                      //--Если попадаются другие TLV, то пропускаем их
                      Len := HexToInt(NextData(SubPkt, 4));
                      Len := Len * 2;
                      NextData(SubPkt, Len);
                    end;
                  end;
                end;
              end;
            end
        else
          //--Если канал пакета вообще другой, то проверяем в буфере другой пакет
          goto z;
        end;
      end
      else
      begin
        //--Если начальная метка пакета не правильная,
        //то выводим сообщение об ошибке разбора и выходим
        DAShow(ErrorHead, ParsingPktError, EmptyStr, 134, 2, 0);
        //--Закрываем сокет и ждем пока закроется
        ICQRegWSocket.Close;
        ICQRegWSocket.WaitForClose;
        Exit;
      end;
    end;
    //--Если в конце разбора пакета у нас ещё остались данные, то возвращаемся для проверки буфера
    z: ;
    if Length(ICQ_RegUIN_HexPkt) > 0 then goto x;
  end;
end;

procedure TIcqRegNewUINForm.ReqSecretImageButtonClick(Sender: TObject);
begin
  //--Обнуляем контролы
  CopyUINSpeedButton.Visible := false;
  RegImage.Picture.Assign(nil);
  SecretWordEdit.Clear;
  //--Проверяем указан ли пароль для нового ICQ#
  if RegPassEdit.Text = EmptyStr then
  begin
    //--Сообщаем о том что нужно ввести пароль
    DAShow(AlertHead, RegNewAlert_1, EmptyStr, 134, 2, 0);
    //--Ставим фокус в поле ввода
    if RegPassEdit.CanFocus then RegPassEdit.SetFocus;
    //--Выходим
    Exit;
  end;
  //--Запускаем процесс получения картинки с кодом
  RegInfoPanel.Caption := RegPanelInfo_1;
  if ICQRegWSocket.State = wsConnected then
  begin
    //--Если сокет уже подключён, то закрываем его и ждем когда он закроется
    ICQRegWSocket.Close;
    ICQRegWSocket.WaitForClose;
  end;
  try
    //--Назначаем параметры сокета
    ICQRegWSocket.Addr := 'login.icq.com';
    ICQRegWSocket.Port := '5190';
    //--Подключаем сокет
    ICQRegWSocket.Connect;
  except
    on E: Exception do
    begin
      //--Если при подключении произошла ошибка, то сообщаем об этом и закрываем сокет
      //E.Message;
      DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
      ICQRegWSocket.Close;
    end;
  end;
end;

procedure TIcqRegNewUINForm.NewUINRegButtonClick(Sender: TObject);
begin
  //--Проверяем введено ли слово с картинки
  if SecretWordEdit.Text = EmptyStr then
  begin
    //--Сообщаем об этой ошибке
    DAShow(AlertHead, RegNewAlert_2, EmptyStr, 134, 2, 0);
    //--Ставим фокус в поле ввода
    if SecretWordEdit.CanFocus then SecretWordEdit.SetFocus;
    //--Выходим
    Exit;
  end;
  //--Сбрасываем контролы
  NewUINRegButton.Enabled := false;
  RegImage.Picture.Assign(nil);
  //--Если сокет ещё подключен, то отправляем регистрационные данные и ждём нового UIN :)
  if ICQRegWSocket.State = wsConnected then ICQ_SendRegNewUIN(RegPassEdit.Text, SecretWordEdit.Text)
  else
  begin
    //--Если сокет уже отвалился, то сообщаем об этом
    DAShow(AlertHead, SocketConnErrorInfo_1, EmptyStr, 134, 2, 0);
    //--Запрашиваем новую картинку
    ReqSecretImageButton.Click;
  end;
end;

procedure TIcqRegNewUINForm.WebRegLabelClick(Sender: TObject);
begin
  //--Открываем регистрацию на веб сайте ICQ
  ShellExecute(Application.Handle, 'open', PChar('http://www.icq.com/register'), nil, nil, SW_SHOWNORMAL);
end;

procedure TIcqRegNewUINForm.WebRegLabelMouseEnter(Sender: TObject);
begin
  WebRegLabel.Font.Color := clBlue;
end;

procedure TIcqRegNewUINForm.WebRegLabelMouseLeave(Sender: TObject);
begin
  WebRegLabel.Font.Color := clNavy;
end;

procedure TIcqRegNewUINForm.ICQRegWSocketSessionClosed(Sender: TObject;
  ErrCode: Word);
begin
  //--Если при отключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  end;
end;

procedure TIcqRegNewUINForm.ICQRegWSocketSessionConnected(Sender: TObject;
  ErrCode: Word);
begin
  //--Если при подключении возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    DAShow(ErrorHead, ICQ_NotifyConnectError(WSocket_WSAGetLastError), EmptyStr, 134, 2, 0);
  end;
end;

procedure TIcqRegNewUINForm.ICQRegWSocketSocksError(Sender: TObject;
  Error: Integer; Msg: string);
begin
  //--Отображаем ошибки подключения через Socks прокси
  
end;

end.

