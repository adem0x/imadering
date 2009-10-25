unit GtransUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TGTransForm = class(TForm)
    CancelBitBtn: TBitBtn;
    OKBitBtn: TBitBtn;
    YourLangComboBox: TComboBox;
    YourLangLabel: TLabel;
    ToLangLabel: TLabel;
    ToLangComboBox: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GTransForm: TGTransForm;

implementation

{$R *.dfm}

end.
