{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqXStatusUnit;

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
  ButtonGroup,
  StdCtrls,
  VarsUnit,
  JvSimpleXml;

type
  TIcqXStatusForm = class(TForm)
    XButtonGroup: TButtonGroup;
    XtextMemo: TMemo;
    BirthDayCheckBox: TCheckBox;
    OKButton: TButton;
    CancelButton: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure XButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
    Xindex: Integer;

  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  IcqXStatusForm: TIcqXStatusForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  OverbyteIcsUrl,
  StrUtils;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_IcqXStatus = 'icq_x_status_form';

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TIcqXStatusForm.FormCreate(Sender: TObject);
begin
  // Перевод формы на языки
  TranslateForm;
  // Подсвечиваем текущий дополнительный статус и состояния контролов
  XButtonGroup.ItemIndex := ICQ_X_CurrentStatus;
  Xindex := ICQ_X_CurrentStatus;
  BirthDayCheckBox.Checked := ICQ_BirthDay_Enabled;
  XButtonGroupButtonClicked(nil, ICQ_X_CurrentStatus);
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TIcqXStatusForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelButton.Caption := S_Cancel;
end;

{$ENDREGION}
{$REGION 'XButtonGroupButtonClicked'}

procedure TIcqXStatusForm.XButtonGroupButtonClicked(Sender: TObject; index: Integer);
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Подгружаем подписи к статусам
  XtextMemo.Lines.Clear;
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        // Загружаем настройки
        if FileExists(ProfilePath + SettingsFileName) then
          begin
            LoadFromFile(ProfilePath + SettingsFileName);
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_IcqXStatus];
                if XML_Node <> nil then
                  begin
                    Sub_Node := XML_Node.Items.ItemNamed['x' + IntToStr(index)];
                    if Sub_Node <> nil then
                      XtextMemo.Lines.Text := URLDecode(Sub_Node.Value);
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'OKButtonClick'}

procedure TIcqXStatusForm.OKButtonClick(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Присваиваем переменным протокола выбранный статус
  ICQ_X_CurrentStatus := XButtonGroup.ItemIndex;
  ICQ_X_CurrentStatus_Cap := XButtonGroup.Items[XButtonGroup.ItemIndex].Hint;
  ICQ_X_CurrentStatus_Code := XButtonGroup.Items[XButtonGroup.ItemIndex].Caption;
  ICQ_X_CurrentStatus_Text := ReplaceStr(XtextMemo.Text, #13#10, ' ');
  // Ставим иконку доп. статуса в меню icq
  MainForm.ICQXStatus.ImageIndex := XButtonGroup.Items[XButtonGroup.ItemIndex].ImageIndex;
  // Отправляем пакеты с инфой о новом статусе
  ICQ_SendPkt('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr, EmptyStr, EmptyStr));
  ICQ_SetInfoP;
  ICQ_SetStatusXText(ICQ_X_CurrentStatus_Text, ICQ_X_CurrentStatus_Code);
  // Если шарик дня рождения то активируем этот режим
  if BirthDayCheckBox.Checked then
    ICQ_BirthDay_Enabled := True
  else
    ICQ_BirthDay_Enabled := False;
  ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
  // Сохраняем настройки доп. статуса
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(ProfilePath + SettingsFileName) then
          LoadFromFile(ProfilePath + SettingsFileName);
        if Root <> nil then
          begin
            // Очищаем раздел формы если он есть
            XML_Node := Root.Items.ItemNamed[C_IcqXStatus];
            if XML_Node = nil then
              XML_Node := Root.Items.Add(C_IcqXStatus);
            Sub_Node := XML_Node.Items.ItemNamed['x' + IntToStr(XButtonGroup.ItemIndex)];
            if Sub_Node <> nil then
              Sub_Node.Clear
            else
              Sub_Node := XML_Node.Items.Add('x' + IntToStr(XButtonGroup.ItemIndex));
            // Сохраняем текст доп. статсов
            Sub_Node.Value := URLEncode(XtextMemo.Text);
          end;
        // Записываем сам файл
        SaveToFile(ProfilePath + SettingsFileName);
      end;
  finally
    JvXML.Free;
  end;
  // Закрываем окно
  Close;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TIcqXStatusForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TIcqXStatusForm.FormDeactivate(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TIcqXStatusForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем это окно
  Close;
end;

procedure TIcqXStatusForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим главное окно на передний план
  SetForeGroundWindow(Application.MainForm.Handle);
  // Уничтожаем эту форму
  Action := CaFree;
  IcqXStatusForm := nil;
end;

{$ENDREGION}

end.
