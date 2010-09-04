{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit GtransUnit;

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
  Buttons,
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt,
  ExtCtrls,
  ComCtrls,
  Menus,
  JvSimpleXml;

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
    procedure GtransHttpClientSessionClosed(Sender: TObject);
    procedure GtransHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure GtransHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure FormShow(Sender: TObject);
    procedure GtansResetClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure GTClearListClick(Sender: TObject);
    procedure ClearMessPopupMenuPopup(Sender: TObject);
    procedure GtransListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GtransHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure FormDblClick(Sender: TObject);

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

{$ENDREGION}

var
  GTransForm: TGTransForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  SettingsUnit,
  OverbyteIcsUrl,
  TrafficUnit,
  VarsUnit,
  UtilsUnit,
  ChatUnit,
  IcqProtoUnit,
  MraProtoUnit,
  JabberProtoUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_GTFormCode = 'GTranslateCode';
  C_GT = 'GTranslator | ';

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TGTransForm.TranslateForm;
var
  I: Integer;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Заполняем списки
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
          begin
            // Загружаем файл языка
            LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_GTFormCode];
                if XML_Node <> nil then
                  begin
                    // Загружаем коды языков
                    for I := 1 to XML_Node.Items.Count do
                      begin
                        Sub_Node := XML_Node.Items.ItemNamed['c' + IntToStr(I)];
                        if Sub_Node <> nil then
                          YourLangComboBox.Items.Add(Sub_Node.Properties.Value('c'));
                      end;
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
  ToLangComboBox.Items.Assign(YourLangComboBox.Items);
  SetCustomWidthComboBox(YourLangComboBox);
  SetCustomWidthComboBox(ToLangComboBox);
  // Другое
  CancelBitBtn.Caption := Lang_Vars[9].L_S;
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TGTransForm.FormShow(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  YourLangComboBox.ItemIndex := -1;
  ToLangComboBox.ItemIndex := -1;
  // Получаем коды перевода из файла уникальных настроек для этого контакта
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + C_BN + ChatForm.UIN_Panel.Caption + '.usr') then
          begin
            LoadFromFile(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + C_BN + ChatForm.UIN_Panel.Caption + '.usr');
            if Root <> nil then
              begin
                // Загружаем настройки перевода
                XML_Node := Root.Items.ItemNamed[C_Gtrans];
                if XML_Node <> nil then
                  begin
                    YourLangComboBox.ItemIndex := YourLangComboBox.Items.IndexOfName('[' + XML_Node.Properties.Value('y') + ']');
                    ToLangComboBox.ItemIndex := ToLangComboBox.Items.IndexOfName('[' + XML_Node.Properties.Value('t') + ']');
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
  // По умолчанию выставляем язык локализации
  if YourLangComboBox.ItemIndex = -1 then
    YourLangComboBox.ItemIndex := YourLangComboBox.Items.IndexOfName('[' + V_CurrentLang + ']');
end;

{$ENDREGION}
{$REGION 'GetTranslation'}

procedure TGTransForm.GetTranslation;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Запускаем перевод текста через "google api translator"
  GTranslation := True;
  // Сбрасываем сокет если он занят чем то другим или висит
  GtransHttpClient.Abort;
  // Получаем коды перевода из файла уникальных настроек для этого контакта
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + GUserType + C_BN + GUIN + '.usr') then
          begin
            LoadFromFile(V_ProfilePath + C_AnketaFolder + GUserType + C_BN + GUIN + '.usr');
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_Gtrans];
                if XML_Node <> nil then
                  begin
                    // Изменяем направление перевода для исходящих и входящих сообщений
                    if GtransListView.Items[0].ImageIndex = 166 then
                      begin
                        GtransYouLangCode := XML_Node.Properties.Value('y');
                        GtransToLangCode := XML_Node.Properties.Value('t');
                      end
                    else
                      begin
                        GtransYouLangCode := XML_Node.Properties.Value('t');
                        GtransToLangCode := XML_Node.Properties.Value('y');
                      end;
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
  // Формируем URL HTTP запроса
  // Вариант с возвращаемыми значениями (http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=hello%20world&langpair=en%7Cit&callback=foo&context=bar)
  GtransHttpClient.URL := Format('http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%s&langpair=%s|%s', [URLEncode(GText), GtransYouLangCode, GtransToLangCode]);
  Xlog(C_GT + Format(Log_Gtrans_URL, [GtransYouLangCode, GtransToLangCode]) + C_RN + GtransHttpClient.URL, EmptyStr);
  GtransHttpClient.GetASync;
end;

{$ENDREGION}
{$REGION 'OKBitBtnClick'}

procedure TGTransForm.OKBitBtnClick(Sender: TObject);
var
  YouLangCode, ToLangCode: string;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Если языки не выбраны
  if (YourLangComboBox.ItemIndex = -1) or (ToLangComboBox.ItemIndex = -1) then
    begin
      // Показываем сообщение об этой ошибке
      DAShow(Lang_Vars[16].L_S, Lang_Vars[84].L_S, EmptyStr, 133, 3, 0);
      Exit;
    end;
  // Активируем режим перевода для этого контакта
  YouLangCode := IsolateTextString(YourLangComboBox.Text, '[', ']');
  ToLangCode := IsolateTextString(ToLangComboBox.Text, '[', ']');
  // Запоминаем параметры перевода для этого контакта
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + C_BN + ChatForm.UIN_Panel.Caption + '.usr') then
          LoadFromFile(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + C_BN + ChatForm.UIN_Panel.Caption + '.usr');
        if Root <> nil then
          begin
            XML_Node := Root.Items.ItemNamed[C_Gtrans];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(C_Gtrans);
            // Сохраняем настройки языков перевода
            XML_Node.Properties.Add('y', YouLangCode);
            XML_Node.Properties.Add('t', ToLangCode);
            XML_Node.BoolValue := True;
            // Записываем сам файл
            SaveToFile(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + C_BN + ChatForm.UIN_Panel.Caption + '.usr');
          end;
      end;
  finally
    JvXML.Free;
  end;
  // Закрываем форму
  ModalResult := MrOK;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

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
  YourLangComboBox.Items.NameValueSeparator := C_BN;
  ToLangComboBox.Items.NameValueSeparator := C_BN;
  // Применяем настройки прокси
  SettingsForm.ApplyProxyHttpClient(GtransHttpClient);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TGTransForm.GtransHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  GtransHttpClient.RcvdStream := TMemoryStream.Create;
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
    GTClearList.Enabled := True
  else
    GTClearList.Enabled := False;
end;

procedure TGTransForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TGTransForm.GtransHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (GtransHttpClient.StatusCode = 0) or (GtransHttpClient.StatusCode >= 400) then
    begin
      GTranslation := False;
      if ChatForm.UIN_Panel.Caption = GUIN then
        ChatForm.NotifyPanel.Caption := Format(Lang_Vars[85].L_S, [IntToStr(GtransHttpClient.StatusCode)]);
      DAShow(Lang_Vars[17].L_S, Format(ErrorHttpClient(GtransHttpClient.StatusCode), [C_RN]), EmptyStr, 134, 2, 0);
    end;
end;

procedure TGTransForm.GtransHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      GTranslation := False;
      DAShow(Lang_Vars[17].L_S, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TGTransForm.GtransHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      GTranslation := False;
      DAShow(Lang_Vars[17].L_S, Lang_Vars[23].L_S + C_RN + Msg + C_RN + Format(Lang_Vars[27].L_S, [Error]) + C_RN + '[ ' + Lang_Vars[94].L_S + C_TN + (Sender as THttpCli).name + ' ]', EmptyStr, 134, 2, 0);
    end;
end;

procedure TGTransForm.GtransListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FCursor: TPoint;
begin
  // Выводим всплывающее меню
  if Button = MbRight then
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

{$ENDREGION}
{$REGION 'GtransHttpClientRequestDone'}

procedure TGTransForm.GtransHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
label
  X;
var
  List: TStringList;
  GMsg, GStatus, MsgD, Msg, HMsg, HistoryFile: string;
begin
  try
    // Читаем полученные http данные из блока памяти
    if GtransHttpClient.RcvdStream <> nil then
      begin
        // Создаём временный лист
        List := TStringList.Create;
        try
          // Увеличиваем статистику входящего трафика
          V_TrafRecev := V_TrafRecev + GtransHttpClient.RcvdCount;
          V_AllTrafRecev := V_AllTrafRecev + GtransHttpClient.RcvdCount;
          if Assigned(TrafficForm) then
            MainForm.Traffic_MenuClick(nil);
          // Обнуляем позицию начала чтения в блоке памяти
          GtransHttpClient.RcvdStream.Position := 0;
          // Читаем данные в лист
          List.LoadFromStream(GtransHttpClient.RcvdStream);
          // Разбираем данные в листе
          if List.Text > EmptyStr then
            begin
              GMsg := Utf8ToString(List.Text);
              Xlog(C_GT + Format(Log_Gtrans_Req, [GtransYouLangCode, GtransToLangCode]) + C_RN + GMsg, EmptyStr);
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
                          HMsg := GText + C_RN + '(' + Msg + ')';
                          // Добавляем сообщение в файл истории и в чат
                          MsgD := V_YouAt + ' [' + DateTimeChatMess + ']';
                          // Форматируем сообщение под html формат
                          CheckMessage_BR(HMsg);
                          CheckMessage_ClearTag(HMsg);
                          CheckMessage_BR(HMsg);
                          DecorateURL(HMsg);
                          // Если тип контакта ICQ, то отправляем сообщение по ICQ протоколу
                          if GUserType = C_Icq then
                            begin
                              // Если нет подключения к серверу ICQ, то выходим
                              if NotProtoOnline(C_Icq) then
                                goto X;
                              // Заканчиваем оповещение о наборе текста
                              // if MainForm.ICQTypeTextTimer.Enabled then MainForm.ICQTypeTextTimerTimer(self);
                              // Отправляем сообщение в юникод формате
                              ICQ_SendMessage_0406(GUIN, Msg, True);
                              // Формируем файл с историей
                              HistoryFile := V_ProfilePath + C_HistoryFolder + GUserType + C_BN + ICQ_LoginUIN + C_BN + GUIN + '.htm';
                            end
                          else if User_Proto = C_Jabber then
                            begin
                              // Если нет подключения к серверу Jabber, то выходим
                              if NotProtoOnline(C_Jabber) then
                                goto X;
                              // Отправляем сообщение
                              Jab_SendMessage(GUIN, Msg);
                              // Формируем файл с историей
                              HistoryFile := V_ProfilePath + C_HistoryFolder + GUserType + C_BN + Jabber_LoginUIN + C_BN + GUIN + '.htm';
                            end
                          else if User_Proto = C_Mra then
                            begin
                              // Если нет подключения к серверу MRA, то выходим
                              if NotProtoOnline(C_Mra) then
                                goto X;
                              // Формируем файл с историей
                              HistoryFile := V_ProfilePath + C_HistoryFolder + GUserType + C_BN + MRA_LoginUIN + C_BN + GUIN + '.htm';
                            end
                          else
                            goto X;
                          // Записываем историю в файл этого контакта
                          SaveTextInHistory('<span class=a>' + MsgD + '</span><br><span class=c>' + HMsg + '</span><br><br>', HistoryFile);
                          // Если вкладка чата совпадает с UIN получателя
                          if UIN_Panel.Caption = GUIN then
                            begin
                              // Оповещаем о удачном переводе
                              NotifyPanel.Caption := Lang_Vars[86].L_S;
                              // Если включены графические смайлики, то форматируем сообщение под смайлы
                              if not V_TextSmilies then
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
                          HMsg := GText + C_RN + '(' + Msg + ')';
                          if GUserType = C_Icq then
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
                  if ChatForm.UIN_Panel.Caption = GUIN then
                    ChatForm.NotifyPanel.Caption := Format(Lang_Vars[85].L_S, [GStatus]);
                  DAShow(Lang_Vars[17].L_S, Format(Lang_Vars[85].L_S, [GStatus]), EmptyStr, 134, 2, 0);
                  // Удаляем это сообщение из списка буфера
                  GtransListView.Items.Delete(0);
                end;
            end;
        X :;
        finally
          // Высвобождаем блок памяти
          List.Free;
          GtransHttpClient.RcvdStream.Free;
          GtransHttpClient.RcvdStream := nil;
          GTranslation := False;
        end;
      end;
  except
    on E: Exception do
      MainForm.IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}

end.
