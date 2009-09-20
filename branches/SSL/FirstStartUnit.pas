{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit FirstStartUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvPageList, JvExControls, Buttons, ShellApi;

type
  TFirstStartForm = class(TForm)
    BottomPanel: TPanel;
    CancelButton: TBitBtn;
    ProtoJvPageList: TJvPageList;
    Jabber_Page: TJvStandardPage;
    MRA_Page: TJvStandardPage;
    ICQ_Page: TJvStandardPage;
    JabberEnableCheckBox: TCheckBox;
    JabberGroupBox: TGroupBox;
    JabberIconImage: TImage;
    JabberIDLabel: TLabel;
    JabberIDEdit: TEdit;
    JabberPassEdit: TEdit;
    JabberPassLabel: TLabel;
    JabberShowPassCheckBox: TCheckBox;
    JabberSavePassCheckBox: TCheckBox;
    NextButton: TBitBtn;
    ICQIconImage: TImage;
    ICQEnableCheckBox: TCheckBox;
    ICQGroupBox: TGroupBox;
    ICQUINLabel: TLabel;
    ICQPassLabel: TLabel;
    ICQUINEdit: TEdit;
    ICQPassEdit: TEdit;
    ICQShowPassCheckBox: TCheckBox;
    ICQSavePassCheckBox: TCheckBox;
    MRAIconImage: TImage;
    MRAEnableCheckBox: TCheckBox;
    MRAGroupBox: TGroupBox;
    MRAEmailLabel: TLabel;
    MRAPassLabel: TLabel;
    MRARegNewEmailLabel: TLabel;
    MRAEmailEdit: TEdit;
    MRAPassEdit: TEdit;
    MRAShowPassCheckBox: TCheckBox;
    MRASavePassCheckBox: TCheckBox;
    PrevButton: TBitBtn;
    RegNewJIDLabel: TLabel;
    RegNewUINLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure JabberEnableCheckBoxClick(Sender: TObject);
    procedure ICQEnableCheckBoxClick(Sender: TObject);
    procedure MRAEnableCheckBoxClick(Sender: TObject);
    procedure PrevButtonClick(Sender: TObject);
    procedure MRARegNewEmailLabelMouseEnter(Sender: TObject);
    procedure MRARegNewEmailLabelMouseLeave(Sender: TObject);
    procedure ICQShowPassCheckBoxClick(Sender: TObject);
    procedure MRAShowPassCheckBoxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RegNewUINLabelClick(Sender: TObject);
    procedure MRARegNewEmailLabelClick(Sender: TObject);
  private
    { Private declarations }
    procedure CheckSelectProtocols;
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  FirstStartForm: TFirstStartForm;

implementation

{$R *.dfm}

uses
  MainUnit, VarsUnit, UtilsUnit, IcqProtoUnit, Code, IcqOptionsUnit,
  JabberOptionsUnit;

procedure TFirstStartForm.CheckSelectProtocols;
begin
  //--Проверяем выбран ли хоть один протокол
  if (not ICQEnableCheckBox.Checked) and (not MRAEnableCheckBox.Checked) and
    (not JabberEnableCheckBox.Checked) then
  begin
    ShowMessage(FirstStartProtoSelectAlert);
    ICQEnableCheckBox.Checked := true;
  end;
end;

procedure TFirstStartForm.TranslateForm;
begin
  //--Перевод интерфейса окна на другой язык

end;

procedure TFirstStartForm.CancelButtonClick(Sender: TObject);
begin
  //--Закрываем окно
  Close;
end;

procedure TFirstStartForm.NextButtonClick(Sender: TObject);
begin
  //--Переключаем страницы
  case ProtoJvPageList.ActivePageIndex of
    0:
      begin
        //--Применяем и сохраняем логин и пароль ICQ
        if Assigned(IcqOptionsForm) then
        begin
          //--Присваиваем логин
          IcqOptionsForm.ICQUINEdit.Text := ICQUINEdit.Text;
          IcqOptionsForm.PassEdit.Text := ICQPassEdit.Text;
          IcqOptionsForm.SavePassCheckBox.Checked := ICQSavePassCheckBox.Checked;
          //--Применяем и сохраняем настройки логина ICQ
          IcqOptionsForm.ApplySettings;
        end;
        //--Переключаем на Jabber страницу
        ProtoJvPageList.ActivePageIndex := 1;
        //--Активируем клавишу возврата
        PrevButton.Enabled := true;
      end;
    1:
      begin
        //--Применяем и сохраняем логин и пароль Jabber
        if Assigned(JabberOptionsForm) then
        begin
          //--Присваиваем логин
          JabberOptionsForm.JabberJIDEdit.Text := JabberIDEdit.Text;
          JabberOptionsForm.PassEdit.Text := JabberPassEdit.Text;
          JabberOptionsForm.SavePassCheckBox.Checked := JabberSavePassCheckBox.Checked;
          //--Применяем и сохраняем настройки логина ICQ
          JabberOptionsForm.ApplySettings;
        end;
        //--Переключаем на MRA страницу
        ProtoJvPageList.ActivePageIndex := 2;
        //--Устанавливаем текст на кнопке управления
        NextButton.Caption := 'OK';
        //--Активируем клавишу возврата
        PrevButton.Enabled := true;
      end;
    2:
      begin
        //--Проверяем не все ли протоколы были отключены
        CheckSelectProtocols;
        //--Сохраняем результаты начальной настройки протоколов
        MainForm.SaveMainFormSettings;
        //--Закрываем окно
        Close;
      end;
  end;
end;

procedure TFirstStartForm.PrevButtonClick(Sender: TObject);
begin
  //--Возврат на предыдущую страницу
  with ProtoJvPageList do
  begin
    if ActivePageIndex = 0 then Exit
    else
    begin
      //--Листаем страницу назад
      ActivePageIndex := ActivePageIndex - 1;
      //--Деактивируем клавишу возврата если первая страница
      if ActivePageIndex = 0 then PrevButton.Enabled := false;
    end;
  end;
  //--Устанавливаем текст на кнопке управления
  NextButton.Caption := FirstStartNextButton;
end;

procedure TFirstStartForm.JabberEnableCheckBoxClick(Sender: TObject);
begin
  //--Управляем контролами для Jabber
  if JabberEnableCheckBox.Checked then
  begin
    JabberGroupBox.Enabled := true;
    JabberIDEdit.Color := clWindow;
    JabberPassEdit.Color := clWindow;
    JabberShowPassCheckBox.Enabled := true;
    JabberSavePassCheckBox.Enabled := true;
    RegNewJIDLabel.Enabled := true;
    //--Включаем протокол жаббер
    MainForm.JabberEnable(true);
  end
  else
  begin
    JabberGroupBox.Enabled := false;
    JabberIDEdit.Color := clBtnFace;
    JabberPassEdit.Color := clBtnFace;
    JabberShowPassCheckBox.Enabled := false;
    JabberSavePassCheckBox.Enabled := false;
    RegNewJIDLabel.Enabled := false;
    //--Выключаем протокол жаббер
    MainForm.JabberEnable(false);
  end;
end;

procedure TFirstStartForm.RegNewUINLabelClick(Sender: TObject);
begin
  //--Открываем регистрацию на веб сайте ICQ
  OpenURL('http://www.icq.com/register');
end;

procedure TFirstStartForm.ICQEnableCheckBoxClick(Sender: TObject);
begin
  //--Управляем контролами для ICQ
  if ICQEnableCheckBox.Checked then
  begin
    ICQGroupBox.Enabled := true;
    ICQUINEdit.Color := clWindow;
    ICQPassEdit.Color := clWindow;
    ICQShowPassCheckBox.Enabled := true;
    ICQSavePassCheckBox.Enabled := true;
    RegNewUINLabel.Enabled := true;
    //--Включаем протокол ICQ
    MainForm.ICQEnable(true);
  end
  else
  begin
    ICQGroupBox.Enabled := false;
    ICQUINEdit.Color := clBtnFace;
    ICQPassEdit.Color := clBtnFace;
    ICQShowPassCheckBox.Enabled := false;
    ICQSavePassCheckBox.Enabled := false;
    RegNewUINLabel.Enabled := false;
    //--Выключаем протокол ICQ
    MainForm.ICQEnable(false);
  end;
end;

procedure TFirstStartForm.ICQShowPassCheckBoxClick(Sender: TObject);
begin
  if ICQShowPassCheckBox.Checked then ICQPassEdit.PasswordChar := #0
  else ICQPassEdit.PasswordChar := '*';
end;

procedure TFirstStartForm.MRARegNewEmailLabelClick(Sender: TObject);
begin
  //--Открываем регистрацию на веб сайте mail.ru
  OpenURL('http://win.mail.ru/cgi-bin/signup');
end;

procedure TFirstStartForm.MRARegNewEmailLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clBlue;
end;

procedure TFirstStartForm.MRARegNewEmailLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := clNavy;
end;

procedure TFirstStartForm.MRAShowPassCheckBoxClick(Sender: TObject);
begin
  if MRAShowPassCheckBox.Checked then MRAPassEdit.PasswordChar := #0
  else MRAPassEdit.PasswordChar := '*';
end;

procedure TFirstStartForm.MRAEnableCheckBoxClick(Sender: TObject);
begin
  //--Управляем контролами для MRA
  if MRAEnableCheckBox.Checked then
  begin
    MRAGroupBox.Enabled := true;
    MRAEmailEdit.Color := clWindow;
    MRAPassEdit.Color := clWindow;
    MRAShowPassCheckBox.Enabled := true;
    MRASavePassCheckBox.Enabled := true;
    MRARegNewEmailLabel.Enabled := true;
    //--Включаем протокол MRA
    MainForm.MRAEnable(true);
  end
  else
  begin
    MRAGroupBox.Enabled := false;
    MRAEmailEdit.Color := clBtnFace;
    MRAPassEdit.Color := clBtnFace;
    MRAShowPassCheckBox.Enabled := false;
    MRASavePassCheckBox.Enabled := false;
    MRARegNewEmailLabel.Enabled := false;
    //--Выключаем протокол MRA
    MainForm.MRAEnable(false);
  end;
end;

procedure TFirstStartForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Выводим главное окно на самый передний план
  SetForeGroundWindow(Application.MainForm.Handle);
  //--Эту форму уничтожаем
  Action := caFree;
  FirstStartForm := nil;
end;

procedure TFirstStartForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  //--Проверяем не все ли протоколы были отключены
  CheckSelectProtocols;
end;

procedure TFirstStartForm.FormCreate(Sender: TObject);
begin
  //--Загружаем иконки окна
  MainForm.AllImageList.GetIcon(0, Icon);
  MainForm.AllImageList.GetIcon(81, ICQIconImage.Picture.Icon);
  MainForm.AllImageList.GetIcon(24, MRAIconImage.Picture.Icon);
  MainForm.AllImageList.GetIcon(28, JabberIconImage.Picture.Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(167, PrevButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, NextButton.Glyph);
  //--Переводим форму на другие языки
  TranslateForm;
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //--По умолчанию деактивируем контролы протоколов MRA и Jabber
  MRAEnableCheckBoxClick(self);
  JabberEnableCheckBoxClick(self);
end;

end.

