{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit JabberOptionsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ButtonGroup, ExtCtrls, ComCtrls, JvPageList,
  JvExControls;

type
  TJabberOptionsForm = class(TForm)
    CancelButton: TBitBtn;
    ApplyButton: TBitBtn;
    OKButton: TBitBtn;
    JabberOptionButtonGroup: TButtonGroup;
    Panel1: TPanel;
    JvPageList1: TJvPageList;
    JvStandardPage1: TJvStandardPage;
    AccountGroupBox: TGroupBox;
    RegNewAccountLabel: TLabel;
    ICQUINLabel: TLabel;
    PassLabel: TLabel;
    JabberJIDEdit: TEdit;
    PassEdit: TEdit;
    ShowPassCheckBox: TCheckBox;
    SavePassCheckBox: TCheckBox;
    DeleteAccountLabel: TLabel;
    JIDonserverLabel: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JIDonserverLabelMouseEnter(Sender: TObject);
    procedure JIDonserverLabelMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  JabberOptionsForm: TJabberOptionsForm;

implementation

{$R *.dfm}

uses
  MainUnit;

procedure TJabberOptionsForm.CancelButtonClick(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TJabberOptionsForm.FormCreate(Sender: TObject);
begin
  //--Переводим форму на другие языки
  //TranslateForm;
  //--Загружаем настройки
  //LoadSettings;
  //--Деактивируем кнопку "применить"
  ApplyButton.Enabled := false;
  //--Выставляем иконки формы и кнопок
  MainForm.AllImageList.GetIcon(43, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(6, ApplyButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKButton.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TJabberOptionsForm.JIDonserverLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clBlue;
end;

procedure TJabberOptionsForm.JIDonserverLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clNavy;
end;

end.
