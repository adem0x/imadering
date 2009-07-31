{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit MraOptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ButtonGroup, ExtCtrls, ComCtrls, JvPageList,
  JvExControls;

type
  TMraOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    MRAOptionButtonGroup: TButtonGroup;
    Panel1: TPanel;
    JvPageList1: TJvPageList;
    JvStandardPage1: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    ReqPassLabel: TLabel;
    ICQUINLabel: TLabel;
    PassLabel: TLabel;
    MRAEmailEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    MRAonserverLabel: TLabel;
    RegNewEmailLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure MRAonserverLabelMouseEnter(Sender: TObject);
    procedure MRAonserverLabelMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MraOptionsForm: TMraOptionsForm;

implementation

{$R *.dfm}

uses
  MainUnit;

procedure TMraOptionsForm.CancelButtonClick(Sender: TObject);
begin
  //--Закрываем форму
  Close;
end;

procedure TMraOptionsForm.FormCreate(Sender: TObject);
begin
  //--Переводим форму на другие языки
  //TranslateForm;
  //--Загружаем настройки
  //LoadSettings;
  //--Деактивируем кнопку "применить"
  ApplyButton.Enabled := false;
  //--Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(66, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TMraOptionsForm.MRAonserverLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clBlue;
end;

procedure TMraOptionsForm.MRAonserverLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clNavy;
end;

end.
