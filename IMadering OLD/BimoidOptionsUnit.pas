{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit BimoidOptionsUnit;

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
  JvSimpleXml;

type
  TBimoidOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    BimOptionButtonGroup: TButtonGroup;
    OptionPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    ReqPassLabel: TLabel;
    BimoidLoginLabel: TLabel;
    PassLabel: TLabel;
    BimoidLoginEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    ConnectPage: TJvStandardPage;
    ServerGroupBox: TGroupBox;
    BimLoginServerLabel: TLabel;
    BimLoginServerComboBox: TComboBox;
    BimLoginServerPortLabel: TLabel;
    BimLoginServerPortEdit: TEdit;
    OptionsPage: TJvStandardPage;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure MRAonserverLabelMouseEnter(Sender: TObject);
    procedure MRAonserverLabelMouseLeave(Sender: TObject);
    procedure BimoidLoginEditChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure BimOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure BimOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure PassEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PassEditClick(Sender: TObject);

  private
    { Private declarations }
    procedure LoadSettings;

  public
    { Public declarations }
    procedure TranslateForm;
    procedure ApplySettings;
    procedure SaveSettings;
  end;

{$ENDREGION}

var
  BimoidOptionsForm: TBimoidOptionsForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  BimoidProtoUnit,
  OverbyteIcsMimeUtils,
  OverbyteIcsUrl,
  RosterUnit;

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TBimoidOptionsForm.LoadSettings;
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
          XML_Node := Root.Items.ItemNamed[Self.Name];
          if XML_Node <> nil then
          begin
            // --------------------------------------------------------------------------
            // Загружаем данные логина
            Sub_Node := XML_Node.Items.ItemNamed[AccountPage.Name];
            if Sub_Node <> nil then
            begin
              BimoidLoginEdit.Text := Sub_Node.Properties.Value(BimoidLoginEdit.Name);
              SavePassCheckBox.Checked := Sub_Node.Properties.BoolValue(SavePassCheckBox.Name);
              // Загружаем пароль
              PassEdit.OnChange := nil;
              PassEdit.Text := Sub_Node.Properties.Value(PassEdit.Name);
              if PassEdit.Text <> EmptyStr then
              begin
                PassEdit.HelpKeyword := URLDecode(Base64Decode(PassEdit.Text));
                PassEdit.Text := C_MaskPass;
              end;
              PassEdit.OnChange := PassEditChange;
            end;
            // --------------------------------------------------------------------------
            // Загружаем настройки сервера
            Sub_Node := XML_Node.Items.ItemNamed[ConnectPage.Name];
            if Sub_Node <> nil then
            begin
              BimLoginServerComboBox.Text := Sub_Node.Properties.Value(BimLoginServerComboBox.Name);
              BimLoginServerPortEdit.Text := Sub_Node.Properties.Value(BimLoginServerPortEdit.Name);
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

procedure TBimoidOptionsForm.ApplySettings;
begin
  // Применяем настройки Bimoid протокола
  // --------------------------------------------------------------------------
  // Обновляем данные логина в протоколе
  if BimoidLoginEdit.Enabled then
  begin
    if BimoidLoginEdit.Text <> Bim_LoginUIN then
    begin
      ClearContacts(C_Bimoid); // Очищаем контакты предыдущего аккаунта
      Bim_LoginUIN := BimoidLoginEdit.Text;
    end;
    Bim_LoginPassword := PassEdit.HelpKeyword;
    // Делаем подсказку
    if BimoidLoginEdit.Text <> EmptyStr then
      MainForm.BimoidToolButton.Hint := Format(C_AS, [C_Bimoid]) + ' ' + '-' + ' ' + '[' + Bim_LoginUIN + ']'
    else
      MainForm.BimoidToolButton.Hint := Format(C_AS, [C_Bimoid]);
  end;
  // --------------------------------------------------------------------------
  // Применяем настройки сервера
  if BimLoginServerComboBox.Text = EmptyStr then
    BimLoginServerComboBox.Text := BimLoginServerComboBox.Items[0];
  Bim_LoginServerAddr := BimLoginServerComboBox.Text;
  if BimLoginServerPortEdit.Text = EmptyStr then
    BimLoginServerPortEdit.Text := '7023';
  Bim_LoginServerPort := BimLoginServerPortEdit.Text;
  // --------------------------------------------------------------------------
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TBimoidOptionsForm.SaveSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Записываем настройки Bimoid протокола в файл
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      if Root <> nil then
      begin
        // Очищаем раздел Bimoid если он есть
        XML_Node := Root.Items.ItemNamed[Self.Name];
        if XML_Node <> nil then
          XML_Node.Clear
        else
          XML_Node := Root.Items.Add(Self.Name);
        // --------------------------------------------------------------------------
        // Записываем данные логина
        Sub_Node := XML_Node.Items.Add(AccountPage.Name);
        Sub_Node.Properties.Add(BimoidLoginEdit.Name, BimoidLoginEdit.Text);
        Sub_Node.Properties.Add(SavePassCheckBox.Name, SavePassCheckBox.Checked);
        if SavePassCheckBox.Checked then
          Sub_Node.Properties.Add(PassEdit.Name, Base64Encode(URLEncode(PassEdit.HelpKeyword)))
        else
        begin
          Sub_Node.Properties.Add(PassEdit.Name, EmptyStr);
          PassEdit.Text := EmptyStr;
        end;
        // Маскируем пароль
        if PassEdit.Text <> EmptyStr then
        begin
          PassEdit.OnChange := nil;
          PassEdit.Text := C_MaskPass;
          PassEdit.OnChange := PassEditChange;
        end;
        // --------------------------------------------------------------------------
        // Сохраняем настройки сервера
        Sub_Node := XML_Node.Items.Add(ConnectPage.Name);
        Sub_Node.Properties.Add(BimLoginServerComboBox.Name, BimLoginServerComboBox.Text);
        Sub_Node.Properties.Add(BimLoginServerPortEdit.Name, BimLoginServerPortEdit.Text);
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
  // Сообщаем плагинам, что настройки Bimoid обновлены
  MainForm.JvPluginManager.BroadcastMessage(15, EmptyStr);
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TBimoidOptionsForm.TranslateForm;
begin
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := Lang_Vars[9].L_S;
  ApplyButton.Caption := Lang_Vars[10].L_S;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TBimoidOptionsForm.FormCreate(Sender: TObject);
begin
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(297, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(222, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Переводим форму на другие языки
  TranslateForm;
  // Загружаем настройки
  LoadSettings;
  // Применяем настройки
  ApplySettings;
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TBimoidOptionsForm.FormShow(Sender: TObject);
begin
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  // Прокручиваем на первую вкладку
  OptionJvPageList.ActivePage := AccountPage;
  BimOptionButtonGroup.ItemIndex := 0;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TBimoidOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  // Применяем настройки
  ApplySettings;
  // Сохраняем настройки
  SaveSettings;
end;

procedure TBimoidOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TBimoidOptionsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TBimoidOptionsForm.BimoidLoginEditChange(Sender: TObject);
begin
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TBimoidOptionsForm.MRAonserverLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClBlue;
end;

procedure TBimoidOptionsForm.MRAonserverLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel)
    .Font.Color := ClNavy;
end;

procedure TBimoidOptionsForm.BimOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := index;
end;

procedure TBimoidOptionsForm.BimOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if BimOptionButtonGroup.ItemIndex <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := BimOptionButtonGroup.ItemIndex;
end;

procedure TBimoidOptionsForm.OKButtonClick(Sender: TObject);
begin
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then
    ApplyButtonClick(Self);
  // Закрываем окно
  Close;
end;

procedure TBimoidOptionsForm.PassEditChange(Sender: TObject);
begin
  PassEdit.HelpKeyword := PassEdit.Text;
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TBimoidOptionsForm.PassEditClick(Sender: TObject);
begin
  // Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = C_MaskPass then
    PassEdit.Text := EmptyStr;
end;

procedure TBimoidOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
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

{$ENDREGION}

end.

