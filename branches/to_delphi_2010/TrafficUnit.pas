{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit TrafficUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TTrafficForm = class(TForm)
    TrafGroupBox: TGroupBox;
    ResetCurTrafButton: TButton;
    ResetAllTrafButton: TButton;
    CurTrafEdit: TEdit;
    AllTrafEdit: TEdit;
    CurTrafLabel: TLabel;
    AllTrafLabel: TLabel;
    CloseBitBtn: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResetCurTrafButtonClick(Sender: TObject);
    procedure ResetAllTrafButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TrafficForm: TTrafficForm;

implementation

{$R *.dfm}

uses
  MainUnit, VarsUnit;

procedure TTrafficForm.CloseBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TTrafficForm.ResetCurTrafButtonClick(Sender: TObject);
begin
  // Обнуляем текущий трафик
  TrafSend := 0;
  TrafRecev := 0;
  SesDataTraf := now;
  // Показываем сколько трафика передано за эту сессию
  CurTrafEdit.Text := FloatToStrF(TrafRecev / 1000, ffFixed, 18, 3)
    + ' KB | ' + FloatToStrF(TrafSend / 1000, ffFixed, 18, 3)
    + ' KB | ' + DateTimeToStr(SesDataTraf);
end;

procedure TTrafficForm.ResetAllTrafButtonClick(Sender: TObject);
begin
  // Обнуляем общий трафик
  AllTrafSend := 0;
  AllTrafRecev := 0;
  AllSesDataTraf := DateTimeToStr(now);
  // Показываем сколько трафика передано всего
  AllTrafEdit.Text := FloatToStrF(AllTrafRecev / 1000000, ffFixed, 18, 3)
    + ' MB | ' + FloatToStrF(AllTrafSend / 1000000, ffFixed, 18, 3)
    + ' MB | ' + AllSesDataTraf;
end;

procedure TTrafficForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Указываем что форма должна уничтожиться после закрытия
  Action := caFree;
  TrafficForm := nil;
end;

procedure TTrafficForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(226, Icon);
  MainForm.AllImageList.GetBitmap(3, CloseBitBtn.Glyph);
end;

end.
