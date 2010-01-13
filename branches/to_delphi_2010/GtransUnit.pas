{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit GtransUnit;

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
  StdCtrls,
  Buttons,
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt,
  ExtCtrls,
  ComCtrls,
  Menus;

type
  TGTransForm = class(TForm)
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    YourLangComboBox: TComboBox;
    YourLangLabel: TLabel;
    ToLangLabel: TLabel;
    ToLangComboBox: TComboBox;
    GtransHttpClient: THttpCli;
    GtransListView: TListView;
    GtansReset: TBitBtn;
    ClearMessPopupMenu: TPopupMenu;
    GTClearList: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure GtransHttpClientDocBegin(Sender: TObject);
    procedure GtransHttpClientDocEnd(Sender: TObject);
    procedure GtransHttpClientSessionClosed(Sender: TObject);
    procedure GtransHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure GtransHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure FormShow(Sender: TObject);
    procedure GtansResetClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure GTClearListClick(Sender: TObject);
    procedure ClearMessPopupMenuPopup(Sender: TObject);
    procedure GtransListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
    GtransYouLangCode: string;
    GtransToLangCode: string;

  public
    { Public declarations }
    GUIN: string;
    GUserType: string;
    GText: string;
    GTranslation: Boolean;
    procedure TranslateForm;
    procedure GetTranslation;
  end;

var
  GTransForm: TGTransForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  SettingsUnit,
  OverbyteIcsUrl,
  TrafficUnit,
  VarsUnit,
  UtilsUnit,
  RXML,
  ChatUnit,
  IcqProtoUnit,
  MraProtoUnit,
  JabberProtoUnit;

resourcestring
  RS_GTFormCode = 'language\GTranslateCode';
  RS_GTLog = 'GTranslator | ';

procedure TGTransForm.TranslateForm;
var
  I, Count: Integer;
  XmlFile: TrXML;
begin
  // Создаём шаблон для перевода
  //CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Заполняем списки
  Count := 0;
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(MyPath + Format(LangPath, [CurrentLang])) then
          begin
            // Загружаем файл языка
            LoadFromFile(MyPath + Format(LangPath, [CurrentLang]));
            // Переводим заголовок формы и получаем все остальные пункты
            if OpenKey(RS_GTFormCode) then
              try
                Count := GetKeyCount;
              finally
                CloseKey;
              end;
            for I := 1 to Count do
              begin
                if OpenKey(RS_GTFormCode + '\c' + IntToStr(I)) then
                  try
                    YourLangComboBox.Items.Add(ReadString('c'));
                  finally
                    CloseKey;
                  end;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
  ToLangComboBox.Items.Assign(YourLangComboBox.Items);
  SetCustomWidthComboBox(YourLangComboBox);
  SetCustomWidthComboBox(ToLangComboBox);
  // Другое
  CancelBitBtn.Caption := S_Cancel;
end;

procedure TGTransForm.FormShow(Sender: TObject);
var
  XmlFile: TrXML;
begin
  YourLangComboBox.ItemIndex := -1;
  ToLangComboBox.ItemIndex := -1;
  // Получаем коды перевода из файла уникальных настроек для этого контакта
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + AnketaFileName + ChatForm.UserType + BN + ChatForm.InfoPanel2.Caption + '.usr') then
          begin
            LoadFromFile(ProfilePath + AnketaFileName + ChatForm.UserType + BN + ChatForm.InfoPanel2.Caption + '.usr');
            // Сохраняем позицию окна
            if OpenKey(S_UniqGT) then
              try
                // Изменяем направление перевода для исходящих и входящих сообщений
                YourLangComboBox.ItemIndex := YourLangComboBox.Items.IndexOfName('[' + ReadString('youlang') + ']');
                ToLangComboBox.ItemIndex := ToLangComboBox.Items.IndexOfName('[' + ReadString('tolang') + ']');
              finally
                CloseKey;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
end;

procedure TGTransForm.GetTranslation;
var
  XmlFile: TrXML;
begin
  // Запускаем перевод текста через "google api translator"
  GTranslation := True;
  // Сбрасываем сокет если он занят чем то другим или висит
  GtransHttpClient.Abort;
  // Получаем коды перевода из файла уникальных настроек для этого контакта
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + AnketaFileName + GUserType + BN + GUIN + '.usr') then
          begin
            LoadFromFile(ProfilePath + AnketaFileName + GUserType + BN + GUIN + '.usr');
            // Сохраняем позицию окна
            if OpenKey(S_UniqGT) then
              try
                // Изменяем направление перевода для исходящих и входящих сообщений
                if GtransListView.Items[0].ImageIndex = 166 then
                  begin
                    GtransYouLangCode := ReadString('youlang');
                    GtransToLangCode := ReadString('tolang');
                  end
                else
                  begin
                    GtransYouLangCode := ReadString('tolang');
                    GtransToLangCode := ReadString('youlang');
                  end;
              finally
                CloseKey;
              end;
          end;
      end;
  finally
    FreeAndNil(XmlFile);
  end;
  // Формируем URL HTTP запроса
  // Вариант с возвращаемыми значениями (http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=hello%20world&langpair=en%7Cit&callback=foo&context=bar)
  GtransHttpClient.URL := Format('http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%s&langpair=%s|%s',
    [URLEncode(GText), GtransYouLangCode, GtransToLangCode]);
  Xlog(RS_GTLog + Format(Log_Gtrans_URL, [GtransYouLangCode, GtransToLangCode]) + RN + GtransHttpClient.URL);
  GtransHttpClient.GetASync;
end;

procedure TGTransForm.GtransHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  GtransHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TGTransForm.GtransHttpClientDocEnd(Sender: TObject);
label
  X;
var
  List: TStringList;
  GMsg, GStatus, MsgD, Msg, HMsg, HistoryFile: string;
begin
  // Читаем полученные http данные из блока памяти
  if GtransHttpClient.RcvdStream <> nil then
    begin
      try
        // Увеличиваем статистику входящего трафика
        TrafRecev := TrafRecev + GtransHttpClient.RcvdCount;
        AllTrafRecev := AllTrafRecev + GtransHttpClient.RcvdCount;
        if Assigned(TrafficForm) then
          MainForm.OpenTrafficClick(nil);
        // Создаём временный лист
        List := TStringList.Create;
        try
          // Обнуляем позицию начала чтения в блоке памяти
          GtransHttpClient.RcvdStream.Position := 0;
          // Читаем данные в лист
          List.LoadFromStream(GtransHttpClient.RcvdStream);
          // Разбираем данные в листе
          if List.Text > EmptyStr then
            begin
              GMsg := Utf8ToString(List.Text);
              Xlog(RS_GTLog + Format(Log_Gtrans_Req, [GtransYouLangCode, GtransToLangCode]) + RN + GMsg);
              // Проверяем статус перевода (200 означает успешный перевод)
              GStatus := IsoLateTextString(GMsg, '"responseStatus": ', '}');
              if GStatus = '200' then
                begin
                  // Парсим переведённое сообщение из ответа сервера
                  Msg := IsoLateTextString(GMsg, '"translatedText":"', '"},');
                  // Правим коды спецсимволов в переводе
                  CheckMessage_GAPI(Msg);
                  with ChatForm do
                    begin
                      // Определяем входящее это сообщение или исходящее
                      if GtransListView.Items[0].ImageIndex = 166 then
                        begin
                          // Удаляем это сообщение из списка буфера
                          GtransListView.Items.Delete(0);
                          // Формируем сообщение
                          HMsg := GText + RN + '(' + Msg + ')';
                          // Добавляем сообщение в файл истории и в чат
                          MsgD := YouAt + ' [' + DateTimeChatMess + ']';
                          // Форматируем сообщение под html формат
                          CheckMessage_BR(HMsg);
                          CheckMessage_ClearTag(HMsg);
                          CheckMessage_BR(HMsg);
                          DecorateURL(HMsg);
                          // Если тип контакта ICQ, то отправляем сообщение по ICQ протоколу
                          if GUserType = S_Icq then
                            begin
                              // Если нет подключения к серверу ICQ, то выходим
                              if NotProtoOnline(S_Icq) then
                                goto X;
                              // Заканчиваем оповещение о наборе текста
                              // if MainForm.ICQTypeTextTimer.Enabled then MainForm.ICQTypeTextTimerTimer(self);
                              // Отправляем сообщение в юникод формате
                              ICQ_SendMessage_0406(GUIN, Msg, True);
                              // Формируем файл с историей
                              HistoryFile := ProfilePath + HistoryFileName + GUserType + BN + ICQ_LoginUIN + BN + GUIN + '.htm';
                            end
                          else if UserType = S_Jabber then
                            begin
                              // Если нет подключения к серверу Jabber, то выходим
                              if NotProtoOnline(S_Jabber) then
                                goto X;
                              // Отправляем сообщение
                              Jabber_SendMessage(GUIN, Msg);
                              // Формируем файл с историей
                              HistoryFile := ProfilePath + HistoryFileName + GUserType + BN + Jabber_LoginUIN + BN + GUIN + '.htm';
                            end
                          else if UserType = S_Mra then
                            begin
                              // Если нет подключения к серверу MRA, то выходим
                              if NotProtoOnline(S_Mra) then
                                goto X;
                              // Формируем файл с историей
                              HistoryFile := ProfilePath + HistoryFileName + GUserType + BN + MRA_LoginUIN + BN + GUIN + '.htm';
                            end
                          else
                            goto X;
                          // Записываем историю в файл этого контакта
                          SaveTextInHistory('<span class=a>' + MsgD + '</span><br><span class=c>' + HMsg + '</span><br><br>', HistoryFile);
                          // Если вкладка чата совпадает с UIN получателя
                          if InfoPanel2.Caption = GUIN then
                            begin
                              // Оповещаем о удачном переводе
                              NotifyPanel.Caption := GtransOKL;
                              // Если включены графические смайлики, то форматируем сообщение под смайлы
                              if not TextSmilies then
                                CheckMessage_Smilies(HMsg);
                              // Увеличиваем счётчик исходящих сообщений
                              Inc(OutMessIndex);
                              // Добавляем в чат сообщение
                              AddChatText(MsgD, HMsg);
                              // Прокручиваем чат до конца
                              HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
                              // Очищаем поле ввода теста
                              InputRichEdit.Clear;
                              InputRichEditChange(Self);
                            end;
                        end
                      else // Если сообщение входящее, то формируем его событие
                        begin
                          HMsg := GText + RN + '(' + Msg + ')';
                          if GUserType = S_Icq then
                            ICQ_ReqMsgNotify(GUIN, HMsg, '', '', '', '', '', '', '', '', True);
                          // else if UserType = S_Jabber then
                          // else if UserType = S_Mra then
                          // Удаляем это сообщение из списка буфера
                          GtransListView.Items.Delete(0);
                        end;
                    end;
                end
              else
                begin
                  if ChatForm.InfoPanel2.Caption = GUIN then
                    ChatForm.NotifyPanel.Caption := Format(GtransErrL, [GStatus]);
                  DAShow(S_Errorhead, Format(GtransErrL, [GStatus]), EmptyStr, 134, 2, 0);
                  // Удаляем это сообщение из списка буфера
                  GtransListView.Items.Delete(0);
                end;
            end;
        X :;
        finally
          List.Free;
        end;
      finally
        // Высвобождаем блок памяти
        GtransHttpClient.RcvdStream.Free;
        GtransHttpClient.RcvdStream := nil;
        GTranslation := False;
      end;
    end;
end;

procedure TGTransForm.OKBitBtnClick(Sender: TObject);
var
  YouLangCode, ToLangCode: string;
  XmlFile: TrXML;
begin
  // Активируем режим перевода для этого контакта
  YouLangCode := IsolateTextString(YourLangComboBox.Items.Names[YourLangComboBox.ItemIndex], '[', ']');
  ToLangCode := IsolateTextString(ToLangComboBox.Items.Names[ToLangComboBox.ItemIndex], '[', ']');
  // Запоминаем параметры перевода для этого контакта
  // Создаём необходимые папки
  ForceDirectories(ProfilePath);
  XmlFile := TrXML.Create;
  try
    with XmlFile do
      begin
        if FileExists(ProfilePath + AnketaFileName + ChatForm.UserType + BN + ChatForm.InfoPanel2.Caption + '.usr') then
          LoadFromFile(ProfilePath + AnketaFileName + ChatForm.UserType + BN + ChatForm.InfoPanel2.Caption + '.usr');
        // Сохраняем позицию окна
        if OpenKey(S_UniqGT, True) then
          try
            WriteBool('enable', True);
            WriteString('youlang', YouLangCode);
            WriteString('tolang', ToLangCode);
          finally
            CloseKey;
          end;
        // Записываем сам файл
        SaveToFile(ProfilePath + AnketaFileName + ChatForm.UserType + BN + ChatForm.InfoPanel2.Caption + '.usr');
      end;
  finally
    FreeAndNil(XmlFile);
  end;
end;

procedure TGTransForm.GtansResetClick(Sender: TObject);
begin
  // Перезапускаем перевод (возможно повисший)
  GTransForm.GtransHttpClient.Abort;
  GTransForm.GTranslation := False;
  ChatForm.NotifyPanel.Caption := '...';
end;

procedure TGTransForm.CancelBitBtnClick(Sender: TObject);
begin
  // Скрываем форму
  Hide;
end;

procedure TGTransForm.ClearMessPopupMenuPopup(Sender: TObject);
begin
  // Если сообщений нету, то блокируем пункт меню
  if GtransListView.Selected <> nil then
    GTClearList.Enabled := true
  else
    GTClearList.Enabled := false;
end;

procedure TGTransForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем иконки
  MainForm.AllImageList.GetIcon(246, Icon);
  MainForm.AllImageList.GetBitmap(139, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(6, GtansReset.Glyph);
  // Применяем язык
  TranslateForm;
  // Назначаем разделитель значений для списков
  YourLangComboBox.Items.NameValueSeparator := BN;
  ToLangComboBox.Items.NameValueSeparator := BN;
  // Применяем настройки прокси
  SettingsForm.ApplyProxyHttpClient(GtransHttpClient);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TGTransForm.GtransHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (GtransHttpClient.StatusCode = 0) or (GtransHttpClient.StatusCode >= 400) then
    begin
      GTranslation := False;
      if ChatForm.InfoPanel2.Caption = GUIN then
        ChatForm.NotifyPanel.Caption := Format(GtransErrL, [IntToStr(GtransHttpClient.StatusCode)]);
      DAShow(S_Errorhead, ErrorHttpClient(GtransHttpClient.StatusCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TGTransForm.GtransHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      GTranslation := False;
      DAShow(S_Errorhead, NotifyConnectError('GTrans', ErrCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TGTransForm.GtransHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      GTranslation := False;
      DAShow(S_Errorhead, Msg, EmptyStr, 134, 2, 0);
    end;
end;

procedure TGTransForm.GtransListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FCursor: TPoint;
begin
  // Выводим всплывающее меню
  if Button = mbRight then
  begin
    GetCursorPos(FCursor);
    ClearMessPopupMenu.Popup(FCursor.X, FCursor.Y);
  end;
end;

procedure TGTransForm.GTClearListClick(Sender: TObject);
begin
  // Очищаем список от сообщений
  GtransListView.Clear;
end;

end.
