{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit TwitterOptionsUnit;

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
  JvSimpleXml,
  Mask,
  JvExMask,
  JvSpin;

type
  TTwitterOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    TwitterOptionButtonGroup: TButtonGroup;
    OptionPanel: TPanel;
    OptionJvPageList: TJvPageList;
    AccountPage: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    ReqPassLabel: TLabel;
    AccountLabel: TLabel;
    PassLabel: TLabel;
    AccountEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    OptionGroupBox: TGroupBox;
    ConnectPage: TJvStandardPage;
    RegNewTwitterLabel: TLabel;
    InMessJvSpinEdit: TJvSpinEdit;
    MyMessJvSpinEdit: TJvSpinEdit;
    InMessLabel: TLabel;
    MyMessLabel: TLabel;
    ConsolePage: TJvStandardPage;
    ConsoleGroupBox: TGroupBox;
    DumpInfoRichEdit: TRichEdit;
    CustomURLEdit: TEdit;
    CustomURLLabel: TLabel;
    SendCustomURLButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ReqPassLabelClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure TwitterOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure TwitterOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure ReqPassLabelMouseEnter(Sender: TObject);
    procedure ReqPassLabelMouseLeave(Sender: TObject);
    procedure RegNewTwitterLabelClick(Sender: TObject);
    procedure PassEditChange(Sender: TObject);
    procedure PassEditClick(Sender: TObject);
    procedure AccountEditChange(Sender: TObject);
    procedure ShowPassCheckBoxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

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
  TwitterOptionsForm: TTwitterOptionsForm;

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
{$REGION 'MyConst'}

const
  C_InMessCount = 'InMessCount';
  C_MyMessCount = 'MyMessCount';

{$ENDREGION}
{$REGION 'LoadSettings'}

procedure TTwitterOptionsForm.LoadSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[S_Twitter];
                if XML_Node <> nil then
                  begin
                    // --------------------------------------------------------------------------
                    // Загружаем данные логина
                    AccountEdit.Text := XML_Node.Properties.Value(C_Login);
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
                    // Количесво загружаемых входящих сообщений
                    Sub_Node := XML_Node.Items.ItemNamed[C_InMessCount];
                    if Sub_Node <> nil then
                      InMessJvSpinEdit.Value := Sub_Node.IntValue;
                    // Количесво загружаемых моих сообщений
                    Sub_Node := XML_Node.Items.ItemNamed[C_MyMessCount];
                    if Sub_Node <> nil then
                      MyMessJvSpinEdit.Value := Sub_Node.IntValue;
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

procedure TTwitterOptionsForm.ApplySettings;
begin
  // Применяем настройки Twitter протокола
  // --------------------------------------------------------------------------
  // Нормализуем ICQ логин
  AccountEdit.Text := Trim(AccountEdit.Text);
  // Обновляем данные логина в протоколе
  if AccountEdit.Enabled then
    begin
      if AccountEdit.Text <> Twit_Login then
        begin
          { if Assigned(RosterForm) then
            RosterForm.ClearICQClick(Self); // Очищаем контакты предыдущего Twit }
          Twit_Login := AccountEdit.Text;
        end;
      Twit_Password := PassEdit.Hint;
    end;
  // --------------------------------------------------------------------------
  // Другие настройки
  // Количесво загружаемых входящих сообщений
  Twit_IncMess_Count := StrToInt(InMessJvSpinEdit.Text);
  // Количесво загружаемых моих сообщений
  Twit_MyMess_Count := StrToInt(MyMessJvSpinEdit.Text);
  // --------------------------------------------------------------------------
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'SaveSettings'}

procedure TTwitterOptionsForm.SaveSettings;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Записываем настройки ICQ протокола в файл
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        if Root <> nil then
          begin
            // Очищаем раздел главной формы если он есть
            XML_Node := Root.Items.ItemNamed[S_Twitter];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(S_Twitter);
            // --------------------------------------------------------------------------
            // Записываем данные логина
            XML_Node.Properties.Add(C_Login, AccountEdit.Text);
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
            // Количесво загружаемых входящих сообщений
            XML_Node.Items.Add(C_InMessCount, InMessJvSpinEdit.Text);
            // Количесво загружаемых моих сообщений
            XML_Node.Items.Add(C_MyMessCount, MyMessJvSpinEdit.Text);
            // --------------------------------------------------------------------------
            // Сохраняем файл
            SaveToFile(ProfilePath + SettingsFileName);
          end;
      end;
  finally
    JvXML.Free;
  end;
  // Деактивируем кнопку применения настроек
  ApplyButton.Enabled := False;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TTwitterOptionsForm.AccountEditChange(Sender: TObject);
begin
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TTwitterOptionsForm.ApplyButtonClick(Sender: TObject);
begin
  // Применяем настройки
  ApplySettings;
  // Сохраняем настройки
  SaveSettings;
end;

procedure TTwitterOptionsForm.ShowPassCheckBoxClick(Sender: TObject);
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

procedure TTwitterOptionsForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TTwitterOptionsForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TTwitterOptionsForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := S_Cancel;
  ApplyButton.Caption := S_Apply;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TTwitterOptionsForm.FormCreate(Sender: TObject);
begin
  // Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(268, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем настройки
  LoadSettings;
  // Переводим форму на другие языки
  TranslateForm;
  // Применяем настройки
  ApplySettings;
end;

{$ENDREGION}
{$REGION 'FormShow'}

procedure TTwitterOptionsForm.FormShow(Sender: TObject);
begin
  // Востанавливаем прежние сохранённые настройки
  LoadSettings;
  // Прокручиваем на первую вкладку
  OptionJvPageList.ActivePage := AccountPage;
  TwitterOptionButtonGroup.ItemIndex := 0;
  // Прокручиваем рич в верх против глюка в вайн
  SendMessage(DumpInfoRichEdit.Handle, EM_SCROLL, SB_TOP, 0);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TTwitterOptionsForm.TwitterOptionButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if index <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := index;
end;

procedure TTwitterOptionsForm.TwitterOptionButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Выбираем страницу настроек соответсвенно выбранной вкладке
  if TwitterOptionButtonGroup.ItemIndex <= OptionJvPageList.PageCount then
    OptionJvPageList.ActivePageIndex := TwitterOptionButtonGroup.ItemIndex;
end;

procedure TTwitterOptionsForm.OKButtonClick(Sender: TObject);
begin
  // Если были изменения, то применяем настройки и закрываем окно
  if ApplyButton.Enabled then
    ApplyButtonClick(Self);
  // Закрываем окно
  Close;
end;

procedure TTwitterOptionsForm.PassEditChange(Sender: TObject);
begin
  PassEdit.Hint := PassEdit.Text;
  // Активируем кнопку применения настроек
  ApplyButton.Enabled := True;
end;

procedure TTwitterOptionsForm.PassEditClick(Sender: TObject);
begin
  // Если уже заменитель пароля, то очищаем поле ввода пароля
  if PassEdit.Text = C_MaskPass then
    PassEdit.Text := EmptyStr;
end;

procedure TTwitterOptionsForm.RegNewTwitterLabelClick(Sender: TObject);
begin
  // Открываем ссылку регистрации
  OpenURL('https://twitter.com/signup');
end;

procedure TTwitterOptionsForm.ReqPassLabelClick(Sender: TObject);
begin
  // Открываем ссылку воостановления пароля
  OpenURL('http://twitter.com/account/resend_password');
end;

procedure TTwitterOptionsForm.ReqPassLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TTwitterOptionsForm.ReqPassLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

{$ENDREGION}

end.
