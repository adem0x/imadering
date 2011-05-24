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
  JvSimpleXml,
  StrUtils;

type
  TGTransForm = class(TForm)
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    YourLangComboBox: TComboBox;
    YourLangLabel: TLabel;
    ToLangLabel: TLabel;
    ToLangComboBox: TComboBox;
    GtransClient: THttpCli;
    GtransListView: TListView;
    GtansReset: TBitBtn;
    ClearMessPopupMenu: TPopupMenu;
    GTClearList: TMenuItem;
    TranslitCheckBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure GtransClientDocBegin(Sender: TObject);
    procedure GtransClientSessionClosed(Sender: TObject);
    procedure GtransClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure GtransClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure FormShow(Sender: TObject);
    procedure GtansResetClick(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure GTClearListClick(Sender: TObject);
    procedure GtransListViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GtransClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure FormDblClick(Sender: TObject);
    procedure GtransClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);

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
  C_GT = 'GTranslator | ';
  C_You_Lang = 'y';
  C_To_Lang = 't';

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TGTransForm.TranslateForm;
begin
  // Применяем язык
  SetLang(Self);
  // Заполняем списки
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
      if FileExists(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + ' ' + ChatForm.UIN_Panel.Caption + C_XML_Ext) then
      begin
        LoadFromFile(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + ' ' + ChatForm.UIN_Panel.Caption + C_XML_Ext);
        if Root <> nil then
        begin
          // Загружаем настройки перевода
          XML_Node := Root.Items.ItemNamed[C_Gtrans];
          if XML_Node <> nil then
          begin
            YourLangComboBox.ItemIndex := YourLangComboBox.Items.IndexOfName('[' + XML_Node.Properties.Value(C_You_Lang) + ']');
            ToLangComboBox.ItemIndex := ToLangComboBox.Items.IndexOfName('[' + XML_Node.Properties.Value(C_To_Lang) + ']');
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
  GtransClient.Close;
  GtransClient.Abort;
  // Получаем коды перевода из файла уникальных настроек для этого контакта
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_AnketaFolder + GUserType + ' ' + GUIN + C_XML_Ext) then
      begin
        LoadFromFile(V_ProfilePath + C_AnketaFolder + GUserType + ' ' + GUIN + C_XML_Ext);
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Gtrans];
          if XML_Node <> nil then
          begin
            // Изменяем направление перевода для исходящих и входящих сообщений
            if GtransListView.Items[0].ImageIndex = 166 then
            begin
              GtransYouLangCode := XML_Node.Properties.Value(C_You_Lang);
              GtransToLangCode := XML_Node.Properties.Value(C_To_Lang);
            end
            else
            begin
              GtransYouLangCode := XML_Node.Properties.Value(C_To_Lang);
              GtransToLangCode := XML_Node.Properties.Value(C_You_Lang);
            end;
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Формируем URL HTTP запроса
  // 1 Вариант с возвращаемыми значениями: http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=hello%20world&langpair=en%7Cit&callback=foo&context=bar
  // 2 Вариант с возвращаемыми значениями: http://www.google.com/translate_a/t?client=t&sl=en&tl=ru&ie=utf-8&oe=utf-8&q=hello%20world
  GtransClient.URL := Format(C_GoogleTrans, [GtransYouLangCode, GtransToLangCode, URLEncode(GText)]);
  //Xlog(GtransClient.Name + ' ' + Log_Send, GtransClient.URL, C_HTTP, False);
  GtransClient.GetASync;
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
      if FileExists(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + ' ' + ChatForm.UIN_Panel.Caption + C_XML_Ext) then
        LoadFromFile(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + ' ' + ChatForm.UIN_Panel.Caption + C_XML_Ext);
      if Root <> nil then
      begin
        XML_Node := Root.Items.ItemNamed[C_Gtrans];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_Gtrans);
        // Сохраняем настройки языков перевода
        XML_Node.Properties.Add(C_You_Lang, YouLangCode);
        XML_Node.Properties.Add(C_To_Lang, ToLangCode);
        XML_Node.BoolValue := True;
        // Записываем сам файл
        SaveToFile(V_ProfilePath + C_AnketaFolder + ChatForm.User_Proto + ' ' + ChatForm.UIN_Panel.Caption + C_XML_Ext);
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
  YourLangComboBox.Items.NameValueSeparator := ' ';
  ToLangComboBox.Items.NameValueSeparator := ' ';
  // Применяем настройки прокси
  SettingsForm.ApplyProxyHttpClient(GtransClient);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TGTransForm.GtransClientCookie(Sender: TObject; const Data: string; var Accept: Boolean);
begin
  // Управляем кукие
  //XLog(GtransClient.Name + ' ' + Log_Get + ' ' + C_Cookie, Data, C_HTTP);
end;

procedure TGTransForm.GtransClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  GtransClient.RcvdStream := TMemoryStream.Create;
end;

procedure TGTransForm.GtansResetClick(Sender: TObject);
begin
  // Перезапускаем перевод (возможно повисший)
  GtransClient.Close;
  GtransClient.Abort;
  GTranslation := False;
  ChatForm.NotifyPanel.Caption := '...';
end;

procedure TGTransForm.CancelBitBtnClick(Sender: TObject);
begin
  // Скрываем форму
  Hide;
end;

procedure TGTransForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TGTransForm.GtransClientSessionClosed(Sender: TObject);
var
  S: string;
begin
  // Обрабатываем возможные ошибки в работе http сокета
  if (GtransClient.StatusCode = 0) or (GtransClient.StatusCode >= 400) then
  begin
    GTranslation := False;
    if ChatForm.UIN_Panel.Caption = GUIN then
      ChatForm.NotifyPanel.Caption := Format(Lang_Vars[85].L_S, [IntToStr(GtransClient.StatusCode)]);
    S := Format(ErrorHttpClient(GtransClient.StatusCode), [GtransClient.Name]);
    DAShow(Lang_Vars[17].L_S, S, EmptyStr, 134, 2, 0);
  end;
end;

procedure TGTransForm.GtransClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
  begin
    GTranslation := False;
    DAShow(Lang_Vars[17].L_S, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
  end;
end;

procedure TGTransForm.GtransClientSocksError(Sender: TObject; Error: Integer; Msg: string);
var
  S: string;
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
  begin
    GTranslation := False;
    S := Format(Lang_Vars[23].L_S, [(Sender as THttpCli).name]) + ' ' + Msg + ' ' + '[' + Format(Lang_Vars[27].L_S, [Error]) + ']';
    DAShow(Lang_Vars[17].L_S, S, EmptyStr, 134, 2, 0);
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

procedure TGTransForm.GtransClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
label
  X;
const
  C_Sentences = 'sentences';
var
  List, TransList: TStringList;
  GMsg, MsgD, Msg, TMsg, HMsg, HistoryFile: string;
begin
  try
    // Читаем полученные http данные из блока памяти
    if GtransClient.RcvdStream <> nil then
    begin
      // Создаём временный лист
      List := TStringList.Create;
      try
        // Увеличиваем статистику входящего трафика
        V_TrafRecev := V_TrafRecev + GtransClient.RcvdCount;
        V_AllTrafRecev := V_AllTrafRecev + GtransClient.RcvdCount;
        if Assigned(TrafficForm) then
          MainForm.Traffic_MenuClick(nil);
        // Обнуляем позицию начала чтения в блоке памяти
        GtransClient.RcvdStream.Position := 0;
        // Читаем данные в лист
        List.LoadFromStream(GtransClient.RcvdStream);
        // Разбираем данные в листе
        if List.Text <> EmptyStr then
        begin
          GMsg := Utf8ToString(List.Text);
          //Xlog(GtransClient.Name + ' ' + Log_Get, GMsg, C_HTTP);
          if Pos(C_Sentences, GMsg) > 0 then
          begin
            // Парсим переведённое сообщение из ответа сервера
            TransList := TStringList.Create;
            try
              // Перевод
              IsoLateText(GMsg, '"trans":"', '","', TransList);
              Msg := Trim(ReplaceStr(TransList.Text, C_RN, ' '));
              //Xlog(GtransClient.Name + ' ' + Log_Parsing, Msg, C_HTTP);
              // Транслит
              if TranslitCheckBox.Checked then
              begin
                TransList.Clear;
                IsoLateText(GMsg, '"translit":"', '","', TransList);
                TMsg := Trim(ReplaceStr(TransList.Text, C_RN, ' '));
                {if TMsg <> EmptyStr then
                  Xlog(GtransClient.Name + ' ' + Log_Parsing, TMsg, C_HTTP);}
              end;
            finally
              TransList.Free;
            end;
            if TMsg <> EmptyStr then
              Msg := Msg + C_RN + C_MaskPass + C_RN + TMsg;
            // Правим коды спецсимволов в переводе
            CheckMessage_GAPI(Msg);
            //Xlog(GtransClient.Name + ' ' + Log_Parsing, Msg, C_HTTP);
            if Msg <> EmptyStr then
            begin
              with ChatForm do
              begin
                // Определяем входящее это сообщение или исходящее
                if GtransListView.Items[0].ImageIndex = 166 then
                begin
                  // Удаляем это сообщение из списка буфера
                  GtransListView.Items.Delete(0);
                  // Формируем сообщение
                  HMsg := Text2XML(GText + C_RN + C_MaskPass + C_RN + Msg);
                  // Добавляем сообщение в файл истории и в чат
                  MsgD := V_YouAt + ' ' + '[' + DateTimeChatMess + ']';
                  // Форматируем сообщение под html формат
                  CheckMessage_BR(HMsg);
                  CheckMessage_ClearTag(HMsg);
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
                    HistoryFile := V_ProfilePath + C_HistoryFolder + GUserType + ' ' + ICQ_LoginUIN + ' ' + GUIN + C_Htm_Ext;
                  end
                  else if User_Proto = C_Jabber then
                  begin
                    // Если нет подключения к серверу Jabber, то выходим
                    if NotProtoOnline(C_Jabber) then
                      goto X;
                    // Отправляем сообщение
                    Jab_SendMessage(J_ChatType, GUIN, Msg);
                    // Формируем файл с историей
                    HistoryFile := V_ProfilePath + C_HistoryFolder + GUserType + ' ' + Jabber_LoginUIN + ' ' + GUIN + C_Htm_Ext;
                  end
                  else if User_Proto = C_Mra then
                  begin
                    // Если нет подключения к серверу MRA, то выходим
                    if NotProtoOnline(C_Mra) then
                      goto X;
                    // Отправляем сообщение
                    MRA_SendMessage(GUIN, Msg);
                    // Формируем файл с историей
                    HistoryFile := V_ProfilePath + C_HistoryFolder + GUserType + ' ' + MRA_LoginUIN + ' ' + GUIN + C_Htm_Ext;
                  end
                  else
                    goto X;
                  // Записываем историю в файл этого контакта
                  HMsg := Text2XML(HMsg);
                  CheckMessage_BR(HMsg);
                  DecorateURL(HMsg);
                  SaveTextInHistory(Format(C_HistoryOut, [MsgD, HMsg]), HistoryFile);
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
                  end;
                end
                else
                begin
                  // Удаляем это сообщение из списка буфера
                  GtransListView.Items.Delete(0);
                  // Если сообщение входящее, то формируем его событие
                  HMsg := Text2XML(GText + C_RN + C_MaskPass + C_RN + Msg);
                  if GUserType = C_Icq then // ICQ
                    ICQ_ReqMsgNotify(GUIN, HMsg, '', '', '', '', '', '', '', '', True)
                  else if GUserType = C_Jabber then // Jabber
                    Jab_ParseMessage(nil, GUIN, HMsg)
                  else if GUserType = C_Mra then // MRA
                    MRA_MessageRecv(EmptyStr, GUIN, HMsg);
                end;
              end;
            end;
          end
          else
          begin
            // Удаляем это сообщение из списка буфера
            GtransListView.Items.Delete(0);
            // Формируем оповещение
            if ChatForm.UIN_Panel.Caption = GUIN then
              ChatForm.NotifyPanel.Caption := Lang_Vars[85].L_S;
            DAShow(Lang_Vars[17].L_S, Lang_Vars[85].L_S, EmptyStr, 134, 2, 0);
          end;
        end;
        X: ;
      finally
        // Высвобождаем блок памяти
        List.Free;
        GtransClient.RcvdStream.Free;
        GtransClient.RcvdStream := nil;
        GTranslation := False;
      end;
    end;
  except
    on E: Exception do
      MainForm.AppException(Self, E);
  end;
end;

{$ENDREGION}

end.

