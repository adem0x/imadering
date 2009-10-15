{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqReqAuthUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CategoryButtons, Buttons;

type
  TIcqReqAuthForm = class(TForm)
    InfoMemo: TMemo;
    HeadLabel: TLabel;
    YesBitBtn: TBitBtn;
    NoBitBtn: TBitBtn;
    procedure YesBitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure NoBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Invite: boolean;
    UpDate: boolean;
    procedure UpDateVersion(m: string);
  end;

var
  IcqReqAuthForm: TIcqReqAuthForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UnitCrypto, VarsUnit, UtilsUnit, UpdateUnit;

procedure TIcqReqAuthForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Автоматически уничтожаем форму при закрытии
  if UpDate then
  begin
    Action := caFree;
    IcqReqAuthForm := nil;
  end;
end;

procedure TIcqReqAuthForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetBitmap(139, NoBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, YesBitBtn.Glyph);
end;

procedure TIcqReqAuthForm.NoBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  if UpDate then
    Close;
end;

procedure TIcqReqAuthForm.UpDateVersion(m: string);
begin
  // Ставим иконку окну
  MainForm.AllImageList.GetIcon(6, Icon);
  // Отображаем информацию и запрос на закачку новой версии
  Caption := UpDate3L;
  HeadLabel.Caption := UpDate1L;
  InfoMemo.Text := UpDate2L + #13#10 + #13#10 + m;
  // Ставим флаги функции окна
  UpDate := true;
  Invite := false;
  // Блокируем мемо
  InfoMemo.ReadOnly := true;
  InfoMemo.Color := clBtnFace;
end;

procedure TIcqReqAuthForm.YesBitBtnClick(Sender: TObject);
// label
// x;
begin
  if UpDate then
  begin
    // Открываем окно автообновления
    if not Assigned(UpdateForm) then
      UpdateForm := TUpdateForm.Create(MainForm);
    // Отображаем окно на передний план
    xShowForm(UpdateForm);
    // Запускаем процесс получения информации для обновления
    UpdateForm.StartBitBtnClick(nil);
    // Закрываем это окно
    Close;
  end;

  { if RoasterForm.Roaster_Sel_Button = nil then goto x;
    //
    if Invite then
    begin
    Sini := TIniFile.Create(Mypath + 'Config.ini');
    Sini.WriteString('ICQ', 'Invite', Encrypt(Memo1.Text, 12345));
    Sini.Free;
    //
    if (RoasterForm.Roaster_Sel_Button.Status <> 20) and (RoasterForm.Roaster_Sel_Button.Utf8Supported) then
    ICQ_SendMessage_0406(RoasterForm.Roaster_Sel_Button.UIN, Memo1.Text, false)
    else ICQ_SendMessage_0406(RoasterForm.Roaster_Sel_Button.UIN, Memo1.Text, true);
    end
    else
    begin
    ICQ_SendGrandAuth(RoasterForm.Roaster_Sel_Button.UIN);
    ICQ_ReqAuthSend(RoasterForm.Roaster_Sel_Button.UIN, Memo1.Text);
    end;
    //
    x: ;
    ModalResult := mrOk; }
end;

end.
