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

procedure TGTransForm.GetTranslation(GText: string);
begin
  //
end;

procedure TGTransForm.FormCreate(Sender: TObject);
begin
  //
end;

end.
