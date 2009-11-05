unit GtransUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, OverbyteIcsWndControl, OverbyteIcsHttpProt;

type
  TGTransForm = class(TForm)
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    YourLangComboBox: TComboBox;
    YourLangLabel: TLabel;
    ToLangLabel: TLabel;
    ToLangComboBox: TComboBox;
    GtransHttpClient: THttpCli;
    procedure FormCreate(Sender: TObject);
    procedure OKBitBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetTranslation(GText: string);
  end;

var
  GTransForm: TGTransForm;

implementation

{$R *.dfm}

uses
  MainUnit;

procedure TGTransForm.GetTranslation(GText: string);
begin
  //
end;

procedure TGTransForm.OKBitBtnClick(Sender: TObject);
begin
  // Активируем режим перевода для этого контакта

end;

procedure TGTransForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем иконки
  MainForm.AllImageList.GetIcon(246, Icon);
  MainForm.AllImageList.GetBitmap(139, CancelBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(140, OKBitBtn.Glyph);
end;

end.
