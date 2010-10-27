{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit ShowCertUnit;

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
  ExtCtrls,
  OverbyteIcsWSocket,
  Buttons;

type
  // Визуализирует сертификат. Пользователь может его  принять или отвергнуть
  TShowCertForm = class(TForm)
    CertGroupBox: TGroupBox;
    LblIssuer: TLabel;
    LblSubject: TLabel;
    LblSerial: TLabel;
    LblValidAfter: TLabel;
    LblValidBefore: TLabel;
    LblShaHash: TLabel;
    LblCertExpired: TLabel;
    LblIssuerMemo: TMemo;
    AcceptCertButton: TBitBtn;
    RefuseCertButton: TBitBtn;
    procedure AcceptCertButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    AcceptedCertsList: TStringList;
    CertHash: string;
  public
    { Public declarations }
    CertAccepted: Boolean;
    procedure TranslateForm;
    function CheckAccepted(Hash: string): Boolean;
    procedure ShowCert(const Cert: TX509Base);
  end;

{$ENDREGION}

implementation

{$R *.dfm}

{$REGION 'MyUses'}
uses
  MainUnit,
  VarsUnit,
  UtilsUnit;
{$ENDREGION}

const
  AcceptedCertsFile = 'AcceptedCerts.txt';

{$REGION 'TranslateForm'}

procedure TShowCertForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}

{$REGION 'AcceptCertButtonClick'}

procedure TShowCertForm.AcceptCertButtonClick(Sender: TObject);
begin
  // Принимаем и сохраняем в файл сертификат
  // Добавляем в лист хэш сертификата
  AcceptedCertsList.Add(CertHash);
  // Сохраняем лист хешей сертификатов в файл
  if Assigned(AcceptedCertsList) then
  begin
    AcceptedCertsList.SaveToFile(V_ProfilePath + AcceptedCertsFile);
    // Уничтожаем лист хешей сертификатов
    FreeAndNil(AcceptedCertsList);
  end;
  CertAccepted := True;
  // Закрываем модальное окно
  ModalResult := MrOk;
end;
{$ENDREGION}
{$REGION 'CheckAccepted'}

function TShowCertForm.CheckAccepted(Hash: string): Boolean;
begin
  Result := False;
  if Assigned(AcceptedCertsList) then
  begin
    // Если нашли в листе сертификатов этот хэш, то ОК
    if AcceptedCertsList.IndexOf(Hash) > -1 then
      Result := True;
  end;
end;
{$ENDREGION}
{$REGION 'FormCreate'}

procedure TShowCertForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(173, Icon);
  MainForm.AllImageList.GetBitmap(139, RefuseCertButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, AcceptCertButton.Glyph);
  // Переводим окно на другие языки
  TranslateForm;
  // Создаём лист для загрузки хэшей сертификатов
  AcceptedCertsList := TStringList.Create;
  // Загружаем файл сертификатов
  if FileExists(V_ProfilePath + AcceptedCertsFile) then
    AcceptedCertsList.LoadFromFile(V_ProfilePath + AcceptedCertsFile);
  CertAccepted := False;
end;
{$ENDREGION}
{$REGION 'ShowCert'}

procedure TShowCertForm.ShowCert(const Cert: TX509Base);
begin
  // Заполняем поля формы
  with Cert do
  begin
    CertHash := Text2Hex(Sha1Hash);
    LblIssuerMemo.Text := IssuerOneLine;
    LblSubject.Caption := LblSubject.Caption + C_TN + C_BN + SubjectCName;
    LblSerial.Caption := LblSerial.Caption + C_TN + C_BN + IntToStr(SerialNum);
    LblValidAfter.Caption := LblValidAfter.Caption + C_TN + C_BN + DateToStr(ValidNotAfter);
    LblValidBefore.Caption := LblValidBefore.Caption + C_TN + C_BN + DateToStr(ValidNotBefore);
    LblShaHash.Caption := LblShaHash.Caption + C_TN + C_BN + CertHash;
    // Отображаем сообщение если сертификат просрочен
    LblCertExpired.Visible := HasExpired;
  end;
end;
{$ENDREGION}

end.

