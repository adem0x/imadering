{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqXStatusUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ButtonGroup, StdCtrls, VarsUnit;

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
  private
    { Private declarations }
    Xindex: integer;
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  IcqXStatusForm: TIcqXStatusForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UnitCrypto, UtilsUnit;

procedure TIcqXStatusForm.FormCreate(Sender: TObject);
begin
  //--Перевод формы на языки
  TranslateForm;
  //--Подсвечиваем текущий дополнительный статус и состояния контролов
  XButtonGroup.ItemIndex := ICQ_X_CurrentStatus;
  Xindex := ICQ_X_CurrentStatus;
  XtextMemo.Text := ICQ_X_CurrentStatus_Text;
  BirthDayCheckBox.Checked := ICQ_BirthDay_Enabled;
end;

procedure TIcqXStatusForm.FormDeactivate(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TIcqXStatusForm.TranslateForm;
begin
  //--Переводим интерфейс окна на другой язык
  
end;

procedure TIcqXStatusForm.OKButtonClick(Sender: TObject);
begin
  //--Присваиваем переменным протокола выбранный статус
  ICQ_X_CurrentStatus := XButtonGroup.ItemIndex;
  ICQ_X_CurrentStatus_Cap := XButtonGroup.Items[XButtonGroup.ItemIndex].Hint;
  ICQ_X_CurrentStatus_Code := XButtonGroup.Items[XButtonGroup.ItemIndex].Caption;
  ICQ_X_CurrentStatus_Text := XTextMemo.Text;
  //--Ставим иконку доп. статуса в меню icq
  MainForm.ICQXStatus.ImageIndex := XButtonGroup.Items[XButtonGroup.ItemIndex].ImageIndex;
  //--Отправляем пакеты с инфой о новом статусе
  SendFLAP('2', ICQ_CliSetFirstOnlineInfoPkt('IMadering', EmptyStr, ICQ_X_CurrentStatus_Cap, EmptyStr, EmptyStr, EmptyStr));
  ICQ_SetInfoP;
  ICQ_SetStatusXText(ICQ_X_CurrentStatus_Text, ICQ_X_CurrentStatus_Code);
  //--Если шарик дня рождения то активируем этот режим
  if BirthDayCheckBox.Checked then ICQ_BirthDay_Enabled := true
  else ICQ_BirthDay_Enabled := false;
  SendFLAP('2', ICQ_CreateShortStatusPkt);
  //--Сохраняем настройки доп. статуса
  //
  //--Закрываем окно
  Close;
end;

procedure TIcqXStatusForm.CancelButtonClick(Sender: TObject);
begin
  //--Закрываем это окно
  Close;
end;

procedure TIcqXStatusForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Выводим главное окно на передний план
  SetForeGroundWindow(Application.MainForm.Handle);
  //--Уничтожаем эту форму
  Action := caFree;
  IcqXStatusForm := nil;
end;

end.
