{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit SMSUnit;

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
  ComCtrls,
  Buttons,
  JvSimpleXml;

type
  TSMSForm = class(TForm)
    SMSInfoRichEdit: TRichEdit;
    PhoneEdit: TEdit;
    PhoneLabel: TLabel;
    SMSTextLabel: TLabel;
    SMSTextMemo: TMemo;
    CountLabel: TLabel;
    SendBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDblClick(Sender: TObject);
    procedure SMSTextMemoChange(Sender: TObject);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure SMSTextMemoKeyPress(Sender: TObject; var Key: Char);
    procedure SendBitBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  SMSForm: TSMSForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  MraProtoUnit,
  IcqProtoUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_SMSForm = 'sms_form';

{$ENDREGION}
{$REGION 'Other'}

procedure TSMSForm.CancelBitBtnClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TSMSForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Уничтожаем форму при закрытии
  Action := CaFree;
  SMSForm := nil;
end;

procedure TSMSForm.FormDblClick(Sender: TObject);
begin
  // Переводим окно на другие языки
  TranslateForm;
end;

procedure TSMSForm.SMSTextMemoKeyPress(Sender: TObject; var Key: Char);
begin
  // Ограничиваем количество вводимых символов до 41
  if (SMSTextMemo.GetTextLen >= 41) and (Key <> #8) then
    Key := #0;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TSMSForm.FormCreate(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        // Загружаем настройки
        if FileExists(V_ProfilePath + C_SettingsFileName) then
          begin
            LoadFromFile(V_ProfilePath + C_SettingsFileName);
            if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_SMSForm];
                if XML_Node <> nil then
                  begin
                    Top := XML_Node.Properties.IntValue('t');
                    Left := XML_Node.Properties.IntValue('l');
                    Height := XML_Node.Properties.IntValue('h');
                    Width := XML_Node.Properties.IntValue('w');
                    //PhoneEdit.Text := XML_Node.Properties.Value(C_Phone1);
                    // Определяем не находится ли окно за пределами экрана
                    FormSetInWorkArea(Self);
                  end;
              end;
          end;
      end;
  finally
    JvXML.Free;
  end;
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(276, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(277, SendBitBtn.Glyph);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Обновляем счётчик
  SMSTextMemoChange(nil);
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure TSMSForm.FormDestroy(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Сохраняем настройки положения окна в xml
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
      begin
        if FileExists(V_ProfilePath + C_SettingsFileName) then
          LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
          begin
            // Очищаем раздел формы если он есть
            XML_Node := Root.Items.ItemNamed[C_SMSForm];
            if XML_Node <> nil then
              XML_Node.Clear
            else
              XML_Node := Root.Items.Add(C_SMSForm);
            // Сохраняем позицию окна
            XML_Node.Properties.Add('t', Top);
            XML_Node.Properties.Add('l', Left);
            XML_Node.Properties.Add('h', Height);
            XML_Node.Properties.Add('w', Width);
            //XML_Node.Properties.Add(C_Phone1, PhoneEdit.Text);
          end;
        // Записываем сам файл
        SaveToFile(V_ProfilePath + C_SettingsFileName);
      end;
  finally
    JvXML.Free;
  end;
end;

{$ENDREGION}
{$REGION 'SendBitBtnClick'}

procedure TSMSForm.SendBitBtnClick(Sender: TObject);
begin
  // Отправляем SMS сообщение
  if not NotProtoOnline(C_Mra) then
    MRA_SendSMS('+' + PhoneEdit.Text, SMSTextMemo.Text);
end;

{$ENDREGION}
{$REGION 'SMSTextMemoChange'}

procedure TSMSForm.SMSTextMemoChange(Sender: TObject);
var
  S: string;
begin
  // Отображаем счётчик символов
  S := SMSTextMemo.Text;
  if SMSTextMemo.GetTextLen > 41 then
    begin
      SetLength(S, 41);
      SMSTextMemo.Text := S;
    end;
  CountLabel.Caption := Format(Lang_Vars[62].L_S, [SMSTextMemo.GetTextLen, 41]);
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TSMSForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelBitBtn.Caption := Lang_Vars[9].L_S;
end;

{$ENDREGION}

end.
