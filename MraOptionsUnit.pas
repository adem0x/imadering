{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MraOptionsUnit;

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
  TMraOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    MRAOptionButtonGroup: TButtonGroup;
    OptionPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    ReqPassLabel: TLabel;
    MRAEmailLabel: TLabel;
    PassLabel: TLabel;
    MRAEmailEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    RegNewEmailLabel: TLabel;
    OptionGroupBox: TGroupBox;
    ConnectPage: TJvStandardPage;
    GroupBox1: TGroupBox;
    MraLoginServerLabel: TLabel;
    MraLoginServerComboBox: TComboBox;
    MraLoginServerPortLabel: TLabel;
    MraLoginServerPortEdit: TEdit;
    OptionsPage: TJvStandardPage;
    IDClientPage: TJvStandardPage;
    ConsolePage: TJvStandardPage;
    MRAEmailComboBox: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure MRAonserverLabelMouseEnter(Sender: TObject);
    procedure MRAonserverLabelMouseLeave(Sender: TObject);
    procedure RegNewEmailLabelClick(Sender: TObject);
    procedure ReqPassLabelClick(Sender: TObject);
    procedure MRAEmailEditChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure MRAOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure MRAOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  MraOptionsForm: TMraOptionsForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  MraProtoUnit,
  RosterUnit,
  OverbyteIcsMimeUtils,
  OverbyteIcsUrl;

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TMraOptionsForm.LoadSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
  S_email: string;
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
                XML_Node := Root.Items.ItemNamed[C_Mra];
                if XML_Node <> nil then
                  begin
                    // --------------------------------------------------------------------------
                    // Загружаем данные логина
                    S_email := XML_Node.Properties.Value(C_Login);
                    MraEmailEdit.Text := Parse('@', S_email, 1);
                    MRAEmailComboBox.ItemIndex := MRAEmailComboBox.Items.IndexOf('@' + Parse('@', S_email, 2));
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
                    // Загружаем остальные настройки

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

procedure TMraOptionsForm.ApplySettings;
begin
  // Применяем настройки MRA протокола
  // --------------------------------------------------------------------------
  // Нормализуем MRA логин
  MraEmailEdit.Text := Trim(MraEmailEdit.Text);
  MraEmailEdit.Text := NormalizeScreenName(MraEmailEdit.Text);
  // Обновляем данные логина в протоколе
  if MraEmailEdit.Enabled then
    begin
      if (MraEmailEdit.Text + MRAEmailComboBox.Text) <> MRA_LoginUIN then
        begin
          if Assigned(RosterForm) then
            RosterForm.ClearContacts(C_Mra); // Очищаем контакты предыдущего аккаунта
          MRA_LoginUIN := MraEmailEdit.Text + MRAEmailComboBox.Text;
        end;
      MRA_LoginPassword := PassEdit.Hint;
    end;
  // --------------------------------------------------------------------------

  // --------------------------------------------------------------------------
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TMraOptionsForm.SaveSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Записываем настройки MRA протокола в файл
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
            XML_Node := Root.Items.ItemNamed[C_Mra];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(C_Mra);
            // --------------------------------------------------------------------------
            // Записываем данные логина
            XML_Node.Properties.Add(C_Login, MraEmailEdit.Text + MRAEmailComboBox.Text);
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
            // Сохраняем другие настройки

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

procedure TMraOptionsForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := Lang_Vars[9].L_S;
  ApplyButton.Caption := Lang_Vars[10].L_S;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TMraOptionsForm.FormCreate(Sender: TObject);
begin
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(66, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
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
{$REGION 'Other'}

procedure TMraOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  // Применяем настройки
  ApplySettings;
  // Сохраняем настройки
  SaveSettings;
end;

procedure TMraOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TMraOptionsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TMraOptionsForm.FormShow(Sender: TObject);
begin
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  // Прокручиваем на первую вкладку
  OptionJvPageList.ActivePage := AccountPage;
  MraOptionButtonGroup.ItemIndex := 0;
  // Прокручиваем рич в верх против глюка в вайн
  // SendMessage(DumpInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMraOptionsForm.MRAEmailEditChange(Sender: TObject);
begin
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TMraOptionsForm.MRAonserverLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TMraOptionsForm.MRAonserverLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

procedure TMraOptionsForm.MRAOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := index;
end;

procedure TMraOptionsForm.MRAOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if MRAOptionButtonGroup.ItemIndex <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := MRAOptionButtonGroup.ItemIndex;
end;

procedure TMraOptionsForm.OKButtonClick(Sender: TObject);
begin
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then
    ApplyButtonClick(Self);
  // Закрываем окно
  Close;
end;

procedure TMraOptionsForm.PassEditChange(Sender: TObject);
begin
  PassEdit.Hint := PassEdit.Text;
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TMraOptionsForm.PassEditClick(Sender: TObject);
begin
  // Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = C_MaskPass then
    PassEdit.Text := EmptyStr;
end;

procedure TMraOptionsForm.RegNewEmailLabelClick(Sender: TObject);
begin
  // Открываем регистрацию на веб сайте mail.ru
  OpenURL('http://win.mail.ru/cgi-bin/signup');
end;

procedure TMraOptionsForm.ReqPassLabelClick(Sender: TObject);
begin
  // Открываем ссылку воостановления пароля
  OpenURL('http://win.mail.ru/cgi-bin/passremind');
end;

procedure TMraOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
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
