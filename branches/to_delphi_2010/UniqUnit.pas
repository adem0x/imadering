unit UniqUnit;

interface

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
  mmsystem;

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

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  UniqForm: TUniqForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  UtilsUnit,
  VarsUnit,
  JvBrowseFolder;

procedure TUniqForm.TranslateForm;
begin
  // Устанавливаем подсказки к кнопкам
  OnlineSoundPathSpeedButton.Hint := H_SelFolder_Button;
  OnlineSoundPlaySpeedButton.Hint := H_PlaySound_Button;
  MessSoundPathSpeedButton.Hint := H_SelFolder_Button;
  MessSoundPlaySpeedButton.Hint := H_PlaySound_Button;
end;

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
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Применяем строковые переменные
  TranslateForm;
end;

procedure TUniqForm.OKBitBtnClick(Sender: TObject);
begin
  // Сохраняем настройки

  // Закрываем окно
  Close;
end;

end.
