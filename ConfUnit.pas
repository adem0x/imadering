unit ConfUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TConfForm = class(TForm)
    ConfGroupBox: TGroupBox;
    CancelButton: TBitBtn;
    JoinButton: TBitBtn;
    ConfServerEdit: TEdit;
    RoomEdit: TEdit;
    NickEdit: TEdit;
    PassEdit: TEdit;
    ConfServerLabel: TLabel;
    RoomLabel: TLabel;
    NickLabel: TLabel;
    PassLabel: TLabel;
    AddBookmarkCheckBox: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure JoinButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
  end;

var
  ConfForm: TConfForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  UtilsUnit,
  OverbyteIcsUrl,
  RosterUnit,
  VarsUnit;

{$ENDREGION}

{$REGION 'TranslateForm'}

procedure TConfForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Переводим другие контролы
  CancelButton.Caption := Lang_Vars[9].L_S;
end;

{$ENDREGION}

procedure TConfForm.CancelButtonClick(Sender: TObject);
begin
  // Закрываем форму
  Close;
end;

procedure TConfForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Уничтожаем форму
  Action := caFree;
  ConfForm := nil;
end;

procedure TConfForm.FormCreate(Sender: TObject);
begin
  // Переводим окно на другие языки
  TranslateForm;
  // Применяем иконки к окну и кнопкам
  MainForm.AllImageList.GetIcon(236, Icon);
  MainForm.AllImageList.GetBitmap(3, CancelButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, JoinButton.Glyph);
  // Делаем окно независимым и помещаем его кнопку на панель задач
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TConfForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TConfForm.JoinButtonClick(Sender: TObject);
begin
  // Входим в конференцию

  // Закрываем окно
  Close;
end;

end.
