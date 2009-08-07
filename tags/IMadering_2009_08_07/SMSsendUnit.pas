{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit SMSsendUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TSMSsendForm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SMSsendForm: TSMSsendForm;

implementation

{$R *.dfm}

uses
  IcqProtoUnit, MainUnit, UtilsUnit;

procedure TSMSsendForm.Button1Click(Sender: TObject);
label
  x;
var
  SmsMsg, CellularNumber: string;
begin
  if not ICQ_Work_Phaze then goto x;
  if (Edit1.Text = EmptyStr) or (Memo1.Text = EmptyStr) then goto x;
  CellularNumber := NormalizeCellularNumber(Edit1.Text);
  if CellularNumber[1] <> '+' then CellularNumber := '+' + CellularNumber;
  SmsMsg := TranslitRus2Lat(Memo1.Text);
  if Length(SmsMsg) > Memo1.MaxLength then SetLength(SmsMsg, Memo1.MaxLength);
  ICQ_Send_SMS(CellularNumber, SmsMsg);
  //
  x: ;
  ModalResult := mrOk;
end;

procedure TSMSsendForm.Edit1KeyPress(Sender: TObject; var Key: Char);
const
  ValidAsciiChars = ['0'..'9', '+'];
begin
  if (not (Key in ValidAsciiChars)) and (Key <> #8) then Key := #0;
end;

procedure TSMSsendForm.Memo1Change(Sender: TObject);
begin
  ProgressBar1.Position := Memo1.GetTextLen;
  Label4.Caption := IntToStr(Memo1.GetTextLen) + '|147';
end;

end.
