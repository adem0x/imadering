{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit JabberOptionsUnit;

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
  ButtonGroup,
  ExtCtrls,
  ComCtrls,
  JvPageList,
  JvExControls,
  Mask,
  JvExMask,
  JvSpin,
  Menus,
  JvSimpleXml;

type
  TJabberOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    JabberOptionButtonGroup: TButtonGroup;
    OptionPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    RegNewAccountLabel: TLabel;
    ICQUINLabel: TLabel;
    PassLabel: TLabel;
    JabberJIDEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    DeleteAccountLabel: TLabel;
    JIDonserverLabel: TLabel;
    AccountOptionGroupBox: TGroupBox;
    ConnectPage: TJvStandardPage;
    OptionPage: TJvStandardPage;
    AnketaPage: TJvStandardPage;
    HomePage: TJvStandardPage;
    WorkPage: TJvStandardPage;
    PersonalPage: TJvStandardPage;
    ParamsPage: TJvStandardPage;
    CustomServerCheckBox: TCheckBox;
    ConnectionGroupBox: TGroupBox;
    Bevel1: TBevel;
    UseSSLCheckBox: TCheckBox;
    ResursLabel: TLabel;
    ResursComboBox: TComboBox;
    PrioritetJvSpinEdit: TJvSpinEdit;
    PrioritetLabel: TLabel;
    JServerPopupMenu: TPopupMenu;
    Set_JabberOrg: TMenuItem;
    Set_JabberRu: TMenuItem;
    Set_QIPru: TMenuItem;
    Set_GoogleTalk: TMenuItem;
    Set_LiveJournal: TMenuItem;
    ConsolePage: TJvStandardPage;
    CustomServerEdit: TEdit;
    CustomServerLabel: TLabel;
    CustomPortEdit: TEdit;
    CustomPortLabel: TLabel;
    ConsoleGroupBox: TGroupBox;
    DumpInfoRichEdit: TRichEdit;
    SendCustomXMLPacketRichEdit: TRichEdit;
    AvatarPage: TJvStandardPage;
    ProxyGroupBox: TGroupBox;
    CustomPktLabel: TLabel;
    ServersListLabel: TLabel;
    RegWebNewAccountLabel: TLabel;
    SendCustomXMLPacketButton: TBitBtn;
    ParamInfoGroupBox: TGroupBox;
    ParamInfoRichEdit: TRichEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JIDonserverLabelMouseEnter(Sender: TObject);
    procedure JIDonserverLabelMouseLeave(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure JabberOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure CustomServerCheckBoxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PassEditChange(Sender: TObject);
    procedure Set_JabberOrgClick(Sender: TObject);
    procedure JIDonserverLabelClick(Sender: TObject);
    procedure JabberOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure JabberJIDEditChange(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure ServersListLabelClick(Sender: TObject);
    procedure DeleteAccountLabelClick(Sender: TObject);
    procedure RegNewAccountLabelClick(Sender: TObject);
    procedure RegWebNewAccountLabelClick(Sender: TObject);
    procedure SendCustomXMLPacketButtonClick(Sender: TObject);

  private
    { Private declarations }
    procedure LoadSettings;

  public
    { Public declarations }
    procedure TranslateForm;
    procedure ApplySettings;
    procedure SaveSettings;
    procedure SetOnlineVars;
  end;

{$ENDREGION}

var
  JabberOptionsForm: TJabberOptionsForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  JabberProtoUnit,
  SettingsUnit,
  UtilsUnit,
  VarsUnit,
  OverbyteIcsMimeUtils,
  OverbyteIcsUrl,
  RosterUnit;

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TJabberOptionsForm.LoadSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
      begin
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Jabber];
          if XML_Node <> nil then
          begin
            // --------------------------------------------------------------------------
            // Загружаем данные логина
            JabberJIDEdit.Text := XML_Node.Properties.Value(C_Login);
            SavePassCheckBox.Checked := XML_Node.Properties.BoolValue(C_SavePass);
            // Загружаем пароль
            PassEdit.OnChange := nil;
            PassEdit.Text := XML_Node.Properties.Value(C_Pass);
            if PassEdit.Text <> EmptyStr then
            begin
              PassEdit.Hint := URLDecode(Base64Decode(PassEdit.Text));
              PassEdit.Text := C_MaskPass;
            end;
            PassEdit.OnChange := PassEditChange;
            // --------------------------------------------------------------------------
            // Загружаем настройки сервера
            Sub_Node := XML_Node.Items.ItemNamed[C_CustomServer];
            if Sub_Node <> nil then
            begin
              CustomServerCheckBox.Checked := Sub_Node.BoolValue;
              CustomServerEdit.Text := Sub_Node.Properties.Value(C_Host);
              CustomPortEdit.Text := Sub_Node.Properties.Value(C_Port);
              UseSSLCheckBox.Checked := Sub_Node.Properties.BoolValue('ssl');
            end;
            // --------------------------------------------------------------------------
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'ApplySettings'}

procedure TJabberOptionsForm.ApplySettings;
begin
  // Применяем настройки ICQ протокола
  // --------------------------------------------------------------------------
  // Нормализуем Jabber логин
  JabberJIDEdit.Text := Trim(JabberJIDEdit.Text);
  JabberJIDEdit.Text := NormalizeScreenName(JabberJIDEdit.Text);
  // Обновляем данные логина в протоколе
  if JabberJIDEdit.Enabled then
  begin
    if JabberJIDEdit.Text <> Jabber_JID then
    begin
      ClearContacts(C_Jabber); // Очищаем контакты предыдущего аккаунта
      Jabber_JID := JabberJIDEdit.Text;
    end;
    Jabber_LoginPassword := PassEdit.Hint;
    // Разбираем JID на логин и сервер
    Jabber_LoginUIN := Parse(C_EE, Jabber_JID, 1);
    Jabber_ServerAddr := Parse(C_EE, Jabber_JID, 2);
    // Делаем подсказку
    if Jabber_JID <> EmptyStr then
      MainForm.JabberToolButton.Hint := Format(C_AS, [C_Jabber]) + C_BN + C_NN + C_BN + C_QN + Jabber_JID + C_EN
    else
      MainForm.JabberToolButton.Hint := Format(C_AS, [C_Jabber]);
  end;
  // --------------------------------------------------------------------------
  // Применяем настройку порта сервера
  if CustomServerCheckBox.Checked then
    Jabber_ServerPort := CustomPortEdit.Text
  else
    Jabber_ServerPort := '5222';
  // Применяем настройку SSL
  Jabber_UseSSL := UseSSLCheckBox.Checked;
  // --------------------------------------------------------------------------
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TJabberOptionsForm.SaveSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Записываем настройки Jabber протокола в файл
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      if Root <> nil then
      begin
        // Очищаем раздел главной формы если он есть
        XML_Node := Root.Items.ItemNamed[C_Jabber];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(C_Jabber);
        // --------------------------------------------------------------------------
        // Записываем данные логина
        XML_Node.Properties.Add(C_Login, JabberJIDEdit.Text);
        XML_Node.Properties.Add(C_SavePass, SavePassCheckBox.Checked);
        if SavePassCheckBox.Checked then
          XML_Node.Properties.Add(C_Pass, Base64Encode(URLEncode(PassEdit.Hint)))
        else
        begin
          XML_Node.Properties.Add(C_Pass, EmptyStr);
          PassEdit.Text := EmptyStr;
        end;
        // Маскируем пароль
        if PassEdit.Text <> EmptyStr then
          PassEdit.Text := C_MaskPass;
        // --------------------------------------------------------------------------
        // Сохраняем настройки сервера
        Sub_Node := XML_Node.Items.Add(C_CustomServer);
        Sub_Node.Properties.Add(C_Host, CustomServerEdit.Text);
        Sub_Node.Properties.Add(C_Port, CustomPortEdit.Text);
        Sub_Node.Properties.Add('ssl', UseSSLCheckBox.Checked);
        Sub_Node.BoolValue := CustomServerCheckBox.Checked;
        // --------------------------------------------------------------------------
        // Сохраняем файл
        SaveToFile(V_ProfilePath + C_SettingsFileName);
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TJabberOptionsForm.TranslateForm;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      if FileExists(V_MyPath + Format(C_LangPath, [V_CurrentLang])) then
      begin
        // Загружаем файл языка
        LoadFromFile(V_MyPath + Format(C_LangPath, [V_CurrentLang]));
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Infos];
          if XML_Node <> nil then
          begin
            // Загружаем инфы
            Sub_Node := XML_Node.Items.ItemNamed[C_SendDump];
            if Sub_Node <> nil then
              DumpInfoRichEdit.Lines.Text := CheckText_RN(Sub_Node.Properties.Value(C_CS));
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Другое
  CancelButton.Caption := Lang_Vars[9].L_S;
  ApplyButton.Caption := Lang_Vars[10].L_S;
  SendCustomXMLPacketButton.Caption := Lang_Vars[165].L_S;
end;

{$ENDREGION}
{$REGION 'Set_JabberOrgClick'}

procedure TJabberOptionsForm.ServersListLabelClick(Sender: TObject);
begin
  // Открываем список жаббер серверов
  OpenURL('http://xmpp.org/services');
end;

procedure TJabberOptionsForm.Set_JabberOrgClick(Sender: TObject);
begin
  // Автоматом подстраиваем учётные записи под серверы
  if Pos('@', JabberJIDEdit.Text) > 0 then
    JabberJIDEdit.Text := Parse('@', JabberJIDEdit.Text, 1);
  JabberJIDEdit.Text := JabberJIDEdit.Text + (Sender as TMenuItem).Hint;
  // Правим параметры серверов
  case (Sender as TMenuItem).Tag of
    1, 2, 5:
      begin
        CustomServerCheckBox.Checked := False;
        CustomServerEdit.Text := '';
        CustomPortEdit.Text := '';
        UseSSLCheckBox.Checked := False;
      end;
    3:
      begin
        CustomServerCheckBox.Checked := True;
        CustomServerEdit.Text := 'webim.qip.ru';
        CustomPortEdit.Text := '5222';
        UseSSLCheckBox.Checked := False;
      end;
    4:
      begin
        CustomServerCheckBox.Checked := True;
        CustomServerEdit.Text := 'talk.google.com';
        CustomPortEdit.Text := '5223';
        UseSSLCheckBox.Checked := True;
      end;
  end;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TJabberOptionsForm.FormCreate(Sender: TObject);
begin
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(43, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(222, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, SendCustomXMLPacketButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем настройки
  LoadSettings;
  // Переводим форму на другие языки
  TranslateForm;
  // Применяем настройки
  ApplySettings;
  // Подгружаем произвольный пакет
  if FileExists(V_ProfilePath + C_Jabber + C_BN + C_PacketFileName) then
    SendCustomXMLPacketRichEdit.Lines.LoadFromFile(V_ProfilePath + C_Jabber + C_BN + C_PacketFileName);
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TJabberOptionsForm.FormShow(Sender: TObject);
begin
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  // Прокручиваем на первую вкладку
  OptionJvPageList.ActivePage := AccountPage;
  JabberOptionButtonGroup.ItemIndex := 0;
  // Прокручиваем рич в верх против глюка в вайн
  DumpInfoRichEdit.SelStart := 0;
  SendMessage(DumpInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
  // Загружаем онлайн параметры
  SetOnlineVars;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TJabberOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  // Применяем настройки
  ApplySettings;
  // Сохраняем настройки
  SaveSettings;
end;

procedure TJabberOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
begin
  // Отменяем событие изменения поля пароля
  PassEdit.OnChange := nil;
  // Показываем пароль в поле ввода пароля
  if ShowPassCheckBox.Checked then
    PassEdit.PasswordChar := #0
  else
    PassEdit.PasswordChar := '*';
  // Восстанавливаем событие изменения поля пароля
  PassEdit.OnChange := PassEditChange;
end;

procedure TJabberOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TJabberOptionsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TJabberOptionsForm.JabberJIDEditChange(Sender: TObject);
begin
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TJabberOptionsForm.JabberOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := index;
end;

procedure TJabberOptionsForm.JabberOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if JabberOptionButtonGroup.ItemIndex <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := JabberOptionButtonGroup.ItemIndex;
end;

procedure TJabberOptionsForm.CustomServerCheckBoxClick(Sender: TObject);
begin
  // Активируем настройку сервера
  if CustomServerCheckBox.Checked then
  begin
    CustomServerEdit.Enabled := True;
    CustomServerEdit.Color := ClWindow;
    CustomPortEdit.Enabled := True;
    CustomPortEdit.Color := ClWindow;
  end
  else
  begin
    CustomServerEdit.Enabled := False;
    CustomServerEdit.Color := ClBtnFace;
    CustomPortEdit.Enabled := False;
    CustomPortEdit.Color := ClBtnFace;
  end;
  JabberJIDEditChange(nil);
end;

procedure TJabberOptionsForm.DeleteAccountLabelClick(Sender: TObject);
begin
  // Проверяем что этот протокол в сети
  if NotProtoOnline(C_Jabber) then
    Exit;
  // Удаляем учётную запись
  Jab_Account_Delete;
end;

procedure TJabberOptionsForm.JIDonserverLabelClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  // Выводим меню настройки на серверы
  GetCursorPos(FCursor);
  JServerPopupMenu.Popup(FCursor.X, FCursor.Y);
end;

procedure TJabberOptionsForm.JIDonserverLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClBlue;
end;

procedure TJabberOptionsForm.JIDonserverLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClNavy;
end;

procedure TJabberOptionsForm.OKButtonClick(Sender: TObject);
begin
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then
    ApplyButtonClick(Self);
  // Закрываем окно
  Close;
end;

procedure TJabberOptionsForm.PassEditChange(Sender: TObject);
begin
  PassEdit.Hint := PassEdit.Text;
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TJabberOptionsForm.PassEditClick(Sender: TObject);
begin
  // Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = C_MaskPass then
    PassEdit.Text := EmptyStr;
end;

procedure TJabberOptionsForm.RegNewAccountLabelClick(Sender: TObject);
begin
  // Применяем параметры
  ApplySettings;
  // Ставим флаг регистрации нового аккаунта
  Jab_RegNewAccount := True;
  // Регистрируем новую учётную запись
  MainForm.JabberStatusOnlineClick(MainForm.JabberStatusOnline);
end;

procedure TJabberOptionsForm.RegWebNewAccountLabelClick(Sender: TObject);
var
  S: string;
begin
  // Открываем регистрацию нового аккаунта на сайте
  S := Parse(C_EE, JabberJIDEdit.Text, 2);
  if S <> EmptyStr then
    OpenURL(S);
end;

{$ENDREGION}
{$REGION 'SendCustomXMLPacketButtonClick'}

procedure TJabberOptionsForm.SendCustomXMLPacketButtonClick(Sender: TObject);
var
  Pkt: string;
begin
  // Сохраняем пакет локально для дальнейшего использования
  SendCustomXMLPacketRichEdit.Lines.SaveToFile(V_ProfilePath + C_Jabber + C_BN + C_PacketFileName);
  // Если пакет больше нуля и рабочая фаза icq подключения
  if NotProtoOnline(C_Jabber) then
    Exit;
  // Отправляем произвольный пакет данных
  Pkt := Trim(SendCustomXMLPacketRichEdit.Lines.Text);
  if Pkt <> EmptyStr then
    Jab_SendPkt(SendCustomXMLPacketRichEdit.Lines.Text);
end;
{$ENDREGION}
{$REGION 'SetOnlineVars'}

procedure TJabberOptionsForm.SetOnlineVars;
begin
  // Заполняем мемо дополнительной информацией о ICQ аккаунте
  ParamInfoRichEdit.Clear;
  // Начинаем заполнение строк
  ParamInfoRichEdit.Lines.BeginUpdate;
  // Добавляем информацию не вошедшую в другие разделы
  if Jab_Service_List <> EmptyStr then
    ParamInfoRichEdit.Lines.Add(Jab_Service_List);
  // Заканчиваем заполнение строк
  ParamInfoRichEdit.Lines.EndUpdate;
  // Прокручиваем
  ParamInfoRichEdit.SelStart := 0;
  SendMessage(ParamInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
end;

{$ENDREGION}

end.

