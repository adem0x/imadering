unit GtransUnit;

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
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt;

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
    procedure GtransHttpClientDocBegin(Sender: TObject);
    procedure GtransHttpClientDocEnd(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetTranslation(GText, SLang, DLang: string);
  end;

var
  GTransForm: TGTransForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  SettingsUnit,
  OverbyteIcsUrl,
  TrafficUnit,
  VarsUnit,
  UtilsUnit;

procedure TGTransForm.GetTranslation(GText, SLang, DLang: string);
begin
  // Сбрасываем сокет если он занят чем то другим или висит
  GtransHttpClient.Abort;
  // Запускаем проверку обновлений программы на сайте
  GtransHttpClient.URL := Format('http://ajax.googleapis.com/ajax/services/language/translate?q=%s&langpair=%s|%s&v=1.0',
      [URLEncode(GText), SLang, DLang]);
  GtransHttpClient.GetASync;
end;

procedure TGTransForm.GtransHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  GtransHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TGTransForm.GtransHttpClientDocEnd(Sender: TObject);
var
  List: TStringList;
begin
  // Читаем полученные http данные из блока памяти
  if GtransHttpClient.RcvdStream <> nil then
  begin
    try
      // Увеличиваем статистику входящего трафика
      TrafRecev := TrafRecev + GtransHttpClient.RcvdCount;
      AllTrafRecev := AllTrafRecev + GtransHttpClient.RcvdCount;
      if Assigned(TrafficForm) then
        MainForm.OpenTrafficClick(nil);
      // Создаём временный лист
      List := TStringList.Create;
      try
        // Обнуляем позицию начала чтения в блоке памяти
        GtransHttpClient.RcvdStream.Position := 0;
        // Читаем данные в лист
        List.LoadFromStream(GtransHttpClient.RcvdStream);
        // Разбираем данные в листе
        if List.Text > EmptyStr then
        begin
          xlog(List.Text);
        end;
      finally
        List.Free;
      end;
    finally
      // Высвобождаем блок памяти
      GtransHttpClient.RcvdStream.Free;
      GtransHttpClient.RcvdStream := nil;
    end;
  end;
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
  // Применяем настройки прокси
  SettingsForm.ApplyProxyHttpClient(GtransHttpClient);
end;

end.
