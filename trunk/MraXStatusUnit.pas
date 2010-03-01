{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit MraXStatusUnit;

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
  VarsUnit;

type
  TMraXStatusForm = class(TForm)
    XButtonGroup: TButtonGroup;
    XTextMemo: TMemo;
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
    // Xindex: integer;
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  MraXStatusForm: TMraXStatusForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TMraXStatusForm.FormCreate(Sender: TObject);
begin
  // Перевод формы на языки
  TranslateForm;
  // Подсвечиваем текущий дополнительный статус и состояния контролов
  // XButtonGroup.ItemIndex := ICQ_X_CurrentStatus;
  // Xindex := ICQ_X_CurrentStatus;
  // XTextMemo.Text := ICQ_X_CurrentStatus_Text;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TMraXStatusForm.TranslateForm;
begin
  // Переводим интерфейс окна на другой язык

end;

{$ENDREGION}
{$REGION 'OKButtonClick'}

procedure TMraXStatusForm.OKButtonClick(Sender: TObject);
// var
// I: integer;
begin
  { ICQ_X_CurrentStatus := ButtonGroup1.ItemIndex;
    ICQ_X_CurrentStatus_Cap := ButtonGroup1.Items[ButtonGroup1.ItemIndex].Hint;
    ICQ_X_CurrentStatus_Code := ButtonGroup1.Items[ButtonGroup1.ItemIndex].Caption;
    ICQ_X_CurrentStatus_Text := Memo1.Text;
    //
    if ICQ_X_CurrentStatus = 0 then
    begin
    ICQ_X_CurrentStatus_Cap := EmptyStr;
    ICQ_X_CurrentStatus_Code := EmptyStr;
    ICQ_X_CurrentStatus_Text := EmptyStr;
    end;
    //
    for I := 0 to MainForm.ICQStatusPopupMenu.Items.Count - 1 do
    begin
    if MainForm.ICQStatusPopupMenu.Items[I].Tag = 17 then
    MainForm.ICQStatusPopupMenu.Items[I].ImageIndex := ButtonGroup1.Items[ButtonGroup1.ItemIndex].ImageIndex;
    end;
    //
    SendFLAP('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr, EmptyStr, EmptyStr));
    ICQ_SetInfoP;
    ICQ_SetStatusXText(ICQ_X_CurrentStatus_Text, ICQ_X_CurrentStatus_Code);
    if CheckBox1.Checked then ICQ_BirthDay_Enabled := true
    else ICQ_BirthDay_Enabled := false;
    SendFLAP('2', ICQ_CreateShortStatusPkt);
    //
    ButtonGroup1ButtonClicked(self, ICQ_X_CurrentStatus);
    //
    }
  // Закрываем окно
  Close;
end;

{$ENDREGION}
{$REGION 'XButtonGroupButtonClicked'}

procedure TMraXStatusForm.XButtonGroupButtonClicked(Sender: TObject; index: Integer);
begin
  { Xini := TIniFile.Create(MyPath + 'Users\' + 'IcqXstatuses.ini');
    //
    if Xindex > 0 then
    Xini.WriteString('XText', IntToStr(Xindex), Encrypt(Memo1.Text, 12345));
    Xindex := Index;
    Memo1.Clear;
    Memo1.Text := Decrypt(Xini.ReadString('XText', IntToStr(Index), EmptyStr), 12345);
    //
    Memo1.SelStart := Memo1.GetTextLen;
    if (Memo1.CanFocus) and (Assigned(MraXStatusForm)) then Memo1.SetFocus;
    //
    Xini.Free;

    if SaveXStatus then
    begin
    Sini := TIniFile.Create(Mypath + 'Config.ini');
    Sini.WriteInteger('ICQ', 'XStatusImg', ICQ_X_CurrentStatus);
    Sini.WriteString('ICQ', 'XStatusCap', ICQ_X_CurrentStatus_Cap);
    Sini.WriteString('ICQ', 'XStatusCode', ICQ_X_CurrentStatus_Code);
    Sini.WriteString('ICQ', 'XStatusText', Encrypt(ICQ_X_CurrentStatus_Text, 12345));
    Sini.WriteBool('ICQ', 'BirthDayBallon', CheckBox1.Checked);
    Sini.Free;
    end;

    }
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TMraXStatusForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TMraXStatusForm.FormDeactivate(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TMraXStatusForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем это окно
  Close;
end;

procedure TMraXStatusForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим главное окно на передний план
  SetForeGroundWindow(Application.MainForm.Handle);
  // Уничтожаем эту форму
  Action := CaFree;
  MraXStatusForm := nil;
end;

{$ENDREGION}

end.
