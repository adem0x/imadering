{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit UniqUnit;

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
  Buttons,
  ExtCtrls,
  MmSystem;

type
  TUniqForm = class(TForm)
    SoundsGroupBox: TGroupBox;
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    OptionGroupBox: TGroupBox;
    OnlineSoundCheckBox: TCheckBox;
    OnlineSoundPathEdit: TEdit;
    OnlineSoundPathSpeedButton: TSpeedButton;
    OnlineSoundPlaySpeedButton: TSpeedButton;
    MessSoundCheckBox: TCheckBox;
    MessSoundPathEdit: TEdit;
    MessSoundPathSpeedButton: TSpeedButton;
    MessSoundPlaySpeedButton: TSpeedButton;
    SaveHistoryCheckBox: TCheckBox;
    SendTranslitCheckBox: TCheckBox;
    AccountPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelBitBtnClick(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

{$ENDREGION}

var
  UniqForm: TUniqForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  JvBrowseFolder;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TUniqForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CancelBitBtn.Caption := S_Cancel;
  MessSoundPathSpeedButton.Hint := OnlineSoundPathSpeedButton.Hint;
  MessSoundPlaySpeedButton.Hint := OnlineSoundPlaySpeedButton.Hint;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TUniqForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(247, Icon);
  MainForm.AllImageList.GetBitmap(139, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(227, OnlineSoundPathSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(252, OnlineSoundPlaySpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(227, MessSoundPathSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(252, MessSoundPlaySpeedButton.Glyph);
  // Применяем строковые переменные
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TUniqForm.CancelBitBtnClick(Sender: TObject);
begin
  // Закрываем окно
  Close;
end;

procedure TUniqForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Уничтожаем форму после закрытия
  Action := CaFree;
  UniqForm := nil;
end;

procedure TUniqForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TUniqForm.OKBitBtnClick(Sender: TObject);
begin
  // Сохраняем настройки

  // Закрываем окно
  Close;
end;

{$ENDREGION}

end.
