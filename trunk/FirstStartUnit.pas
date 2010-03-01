{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit FirstStartUnit;

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
  ExtCtrls,
  StdCtrls,
  JvPageList,
  JvExControls,
  Buttons,
  ShellApi;

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
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
    procedure CheckSelectProtocols;

  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  FirstStartForm: TFirstStartForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  IcqProtoUnit,
  IcqOptionsUnit,
  JabberOptionsUnit;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TFirstStartForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  NextButton.Caption := S_Next;
  CancelButton.Caption := S_Cancel;
  JabberGroupBox.Caption := ICQGroupBox.Caption;
  MRAGroupBox.Caption := ICQGroupBox.Caption;
  JabberPassLabel.Caption := ICQPassLabel.Caption;
  MRAPassLabel.Caption := ICQPassLabel.Caption;
  JabberShowPassCheckBox.Caption := ICQShowPassCheckBox.Caption;
  MRAShowPassCheckBox.Caption := ICQShowPassCheckBox.Caption;
  JabberSavePassCheckBox.Caption := ICQSavePassCheckBox.Caption;
  MRASavePassCheckBox.Caption := ICQSavePassCheckBox.Caption;
end;

{$ENDREGION}
{$REGION 'NextButtonClick'}

procedure TFirstStartForm.NextButtonClick(Sender: TObject);
begin
  // Переключаем страницы
  case ProtoJvPageList.ActivePageIndex of
    0: begin
        // Применяем и сохраняем логин и пароль ICQ
        if Assigned(IcqOptionsForm) then
          begin
            // Присваиваем логин
            IcqOptionsForm.ICQUINEdit.Text := ICQUINEdit.Text;
            IcqOptionsForm.PassEdit.Text := ICQPassEdit.Text;
            IcqOptionsForm.PassEdit.Hint := ICQPassEdit.Text;
            IcqOptionsForm.SavePassCheckBox.Checked := ICQSavePassCheckBox.Checked;
            // Применяем и сохраняем настройки логина ICQ
            IcqOptionsForm.ApplySettings;
            IcqOptionsForm.SaveSettings;
          end;
        // Переключаем на Jabber страницу
        ProtoJvPageList.ActivePageIndex := 1;
        // Активируем клавишу возврата
        PrevButton.Enabled := True;
      end;
    1: begin
        // Применяем и сохраняем логин и пароль Jabber
        if Assigned(JabberOptionsForm) then
          begin
            // Присваиваем логин
            JabberOptionsForm.JabberJIDEdit.Text := JabberIDEdit.Text;
            JabberOptionsForm.PassEdit.Text := JabberPassEdit.Text;
            JabberOptionsForm.SavePassCheckBox.Checked := JabberSavePassCheckBox.Checked;
            // Применяем и сохраняем настройки логина ICQ
            JabberOptionsForm.ApplySettings;
          end;
        // Переключаем на MRA страницу
        ProtoJvPageList.ActivePageIndex := 2;
        // Устанавливаем текст на кнопке управления
        NextButton.Caption := 'OK';
        // Активируем клавишу возврата
        PrevButton.Enabled := True;
      end;
    2: begin
        // Проверяем не все ли протоколы были отключены
        CheckSelectProtocols;
        // Сохраняем результаты начальной настройки протоколов
        MainForm.SaveMainFormSettings;
        // Закрываем окно
        Close;
      end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TFirstStartForm.CheckSelectProtocols;
begin
  // Проверяем выбран ли хоть один протокол
  if (not ICQEnableCheckBox.Checked) and (not MRAEnableCheckBox.Checked) and (not JabberEnableCheckBox.Checked) then
    begin
      DAShow(S_InfoHead, S_ProtoSelectAlert, EmptyStr, 133, 3, 0);
      ICQEnableCheckBox.Checked := True;
    end;
end;

procedure TFirstStartForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TFirstStartForm.PrevButtonClick(Sender: TObject);
begin
  // Возврат на предыдущую страницу
  with ProtoJvPageList do
    begin
      if ActivePageIndex = 0 then
        Exit
      else
        begin
          // Листаем страницу назад
          ActivePageIndex := ActivePageIndex - 1;
          // Деактивируем клавишу возврата если первая страница
          if ActivePageIndex = 0 then
            PrevButton.Enabled := False;
        end;
    end;
  // Устанавливаем текст на кнопке управления
  NextButton.Caption := S_Next;
end;

procedure TFirstStartForm.RegNewUINLabelClick(Sender: TObject);
begin
  // Открываем регистрацию на веб сайте ICQ
  OpenURL(C_ICQReg);
end;

{$ENDREGION}
{$REGION 'JabberEnableCheckBoxClick'}

procedure TFirstStartForm.JabberEnableCheckBoxClick(Sender: TObject);
begin
  // Управляем контролами для Jabber
  if JabberEnableCheckBox.Checked then
    begin
      JabberGroupBox.Enabled := True;
      JabberIDEdit.Color := ClWindow;
      JabberPassEdit.Color := ClWindow;
      JabberShowPassCheckBox.Enabled := True;
      JabberSavePassCheckBox.Enabled := True;
      RegNewJIDLabel.Enabled := True;
      // Включаем протокол жаббер
      MainForm.Jab_Enable(True);
    end
  else
    begin
      JabberGroupBox.Enabled := False;
      JabberIDEdit.Color := ClBtnFace;
      JabberPassEdit.Color := ClBtnFace;
      JabberShowPassCheckBox.Enabled := False;
      JabberSavePassCheckBox.Enabled := False;
      RegNewJIDLabel.Enabled := False;
      // Выключаем протокол жаббер
      MainForm.Jab_Enable(False);
    end;
end;

{$ENDREGION}
{$REGION 'ICQEnableCheckBoxClick'}

procedure TFirstStartForm.ICQEnableCheckBoxClick(Sender: TObject);
begin
  // Управляем контролами для ICQ
  if ICQEnableCheckBox.Checked then
    begin
      ICQGroupBox.Enabled := True;
      ICQUINEdit.Color := ClWindow;
      ICQPassEdit.Color := ClWindow;
      ICQShowPassCheckBox.Enabled := True;
      ICQSavePassCheckBox.Enabled := True;
      RegNewUINLabel.Enabled := True;
      // Включаем протокол ICQ
      MainForm.ICQ_Enable(True);
    end
  else
    begin
      ICQGroupBox.Enabled := False;
      ICQUINEdit.Color := ClBtnFace;
      ICQPassEdit.Color := ClBtnFace;
      ICQShowPassCheckBox.Enabled := False;
      ICQSavePassCheckBox.Enabled := False;
      RegNewUINLabel.Enabled := False;
      // Выключаем протокол ICQ
      MainForm.ICQ_Enable(False);
    end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TFirstStartForm.ICQShowPassCheckBoxClick(Sender: TObject);
begin
  if ICQShowPassCheckBox.Checked then
    ICQPassEdit.PasswordChar := #0
  else
    ICQPassEdit.PasswordChar := '*';
end;

procedure TFirstStartForm.MRARegNewEmailLabelClick(Sender: TObject);
begin
  // Открываем регистрацию на веб сайте mail.ru
  OpenURL(C_MraReg);
end;

procedure TFirstStartForm.MRARegNewEmailLabelMouseEnter(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClBlue;
end;

procedure TFirstStartForm.MRARegNewEmailLabelMouseLeave(Sender: TObject);
begin (Sender as TLabel)
  .Font.Color := ClNavy;
end;

procedure TFirstStartForm.MRAShowPassCheckBoxClick(Sender: TObject);
begin
  if MRAShowPassCheckBox.Checked then
    MRAPassEdit.PasswordChar := #0
  else
    MRAPassEdit.PasswordChar := '*';
end;

procedure TFirstStartForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Выводим главное окно на самый передний план
  SetForeGroundWindow(Application.MainForm.Handle);
  // Эту форму уничтожаем
  Action := CaFree;
  FirstStartForm := nil;
end;

procedure TFirstStartForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Проверяем не все ли протоколы были отключены
  CheckSelectProtocols;
end;

procedure TFirstStartForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'MRAEnableCheckBoxClick'}

procedure TFirstStartForm.MRAEnableCheckBoxClick(Sender: TObject);
begin
  // Управляем контролами для MRA
  if MRAEnableCheckBox.Checked then
    begin
      MRAGroupBox.Enabled := True;
      MRAEmailEdit.Color := ClWindow;
      MRAPassEdit.Color := ClWindow;
      MRAShowPassCheckBox.Enabled := True;
      MRASavePassCheckBox.Enabled := True;
      MRARegNewEmailLabel.Enabled := True;
      // Включаем протокол MRA
      MainForm.MRA_Enable(True);
    end
  else
    begin
      MRAGroupBox.Enabled := False;
      MRAEmailEdit.Color := ClBtnFace;
      MRAPassEdit.Color := ClBtnFace;
      MRAShowPassCheckBox.Enabled := False;
      MRASavePassCheckBox.Enabled := False;
      MRARegNewEmailLabel.Enabled := False;
      // Выключаем протокол MRA
      MainForm.MRA_Enable(False);
    end;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TFirstStartForm.FormCreate(Sender: TObject);
begin
  // Загружаем иконки окна
  MainForm.AllImageList.GetIcon(0, Icon);
  MainForm.AllImageList.GetIcon(81, ICQIconImage.Picture.Icon);
  MainForm.AllImageList.GetIcon(24, MRAIconImage.Picture.Icon);
  MainForm.AllImageList.GetIcon(28, JabberIconImage.Picture.Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(167, PrevButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, NextButton.Glyph);
  // Переводим форму на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // По умолчанию деактивируем контролы протоколов MRA и Jabber
  MRAEnableCheckBoxClick(Self);
  JabberEnableCheckBoxClick(Self);
end;

{$ENDREGION}

end.
