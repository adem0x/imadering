unit ShowCertUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OverbyteIcsWSocket;

const
  AcceptedCertsFile = 'Profile\AcceptedCerts.txt';

type
  /// <summary>Визуализирует сертификат. Пользователь может его  принять или отвергнуть</summay>
  TShowCertForm = class(TForm)
    AcceptCertButton: TButton;
    RefuseCertButton: TButton;
    CertGroupBox: TGroupBox;
    BottomPanel: TPanel;
    LblIssuer: TLabel;
    LblSubject: TLabel;
    LblSerial: TLabel;
    lblValidAfter: TLabel;
    LblValidBefore: TLabel;
    LblShaHash: TLabel;
    LblCertExpired: TLabel;
    procedure AcceptCertButtonClick(Sender: TObject);
    procedure RefuseCertButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCertAccepted: Boolean;
    FAcceptedCertsList: TStringList;
    FCertHash: string;
    procedure SaveAcceptedCertsList;
  public
    ///  <summary>Принял ли пользователь сертификат</summary>
    property CertAccepted: boolean read FCertAccepted default false;
    ///  <summary>Проверить, вдруг этот сертификат уже принимали</summary>
    function CheckAccepted(Hash: string): boolean;

{$WARNINGS OFF}

    /// <param name="Cert">Сертификат, информацию о котором нужно отобразить</param>
    constructor Create(const Cert: TX509Base);
  end;

{$WARNINGS ON}

implementation

uses MainUnit, EncdDecd, UnitLogger, VarsUnit, UnitCrypto;

{$R *.dfm}

{ TShowCert }

procedure TShowCertForm.AcceptCertButtonClick(Sender: TObject);
begin
  FAcceptedCertsList.Add(FCertHash);
  SaveAcceptedCertsList;

  FCertAccepted := true;
  Close;
end;

procedure TShowCertForm.RefuseCertButtonClick(Sender: TObject);
begin
  Close;
end;

function TShowCertForm.CheckAccepted(Hash: string): boolean;
var
  EncryptedDataStream: TFileStream;
  DecryptedDataStream: TStream;
begin
  result := false;

  if FAcceptedCertsList <> nil then begin
    SaveAcceptedCertsList;
    FreeAndNil(FAcceptedCertsList);
  end;

  FAcceptedCertsList := TStringList.Create;

  if not FileExists(ProfilePath + AcceptedCertsFile) then
    exit;

  try
    EncryptedDataStream := TFileStream.Create(ProfilePath + AcceptedCertsFile, fmOpenRead);
    try
      DecryptedDataStream := DecryptStream(EncryptedDataStream, UnitCrypto.PasswordByMac);
      try
        FAcceptedCertsList.LoadFromStream(DecryptedDataStream);
        if FAcceptedCertsList.IndexOf(hash) >= 0 then begin
          result := true;
          FreeAndNil(FAcceptedCertsList);
        end;
      finally
        FreeAndNil(DecryptedDataStream);
      end;
    finally
      FreeAndNil(EncryptedDataStream);
    end;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;
end;

constructor TShowCertForm.Create(const Cert: TX509Base);
begin
  inherited Create(nil);

  FAcceptedCertsList := nil;

  //заполняем поля формы
  with Cert do
  begin
    FCertHash := EncodeString(Sha1Hash);
    LblIssuer.Caption := LblIssuer.Caption + IssuerOneLine;
    LblSubject.Caption := LblSubject.Caption + SubjectCName;
    LblSerial.Caption := LblSerial.Caption + IntToStr(SerialNum);
    lblValidAfter.Caption := lblValidAfter.Caption + DateToStr(ValidNotAfter);
    LblValidBefore.Caption := LblValidBefore.Caption + DateToStr(ValidNotBefore);
    LblShaHash.Caption := LblShaHash.Caption + FCerthash;
    LblCertExpired.Visible := HasExpired;
  end;
end;

procedure TShowCertForm.FormCreate(Sender: TObject);
begin
  //--Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(173, Icon);
  //MainForm.AllImageList.GetBitmap(6, RefuseCertButton.Glyph);
  //MainForm.AllImageList.GetBitmap(185, AcceptCertButton.Glyph);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TShowCertForm.SaveAcceptedCertsList;
var
  EncryptedFileStream: TFileStream;
  DecryptedDataStream: TMemoryStream;
  EncryptedDataStream: TStream;
begin
  try
    DecryptedDataStream := TMemoryStream.Create;
    try
      EncryptedDataStream := TMemoryStream.Create;
      try
        FAcceptedCertsList.SaveToStream(DecryptedDataStream);
        EncryptedDataStream := EncryptStream(DecryptedDataStream, UnitCrypto.PasswordByMac);

        if FileExists(ProfilePath + AcceptedCertsFile) then
          DeleteFile(ProfilePath + AcceptedCertsFile);

        if not DirectoryExists(ExtractFilePath(ProfilePath + AcceptedCertsFile)) then
          ForceDirectories(ProfilePath + AcceptedCertsFile);

        EncryptedFileStream := TFileStream.Create(ProfilePath + AcceptedCertsFile, fmCreate);
        try
          EncryptedFileStream.CopyFrom(EncryptedDataStream, EncryptedDataStream.Size);
        finally
          FreeAndNil(EncryptedFileStream);
          FreeAndNil(FAcceptedCertsList);
        end;
      finally
        FreeAndNil(EncryptedDataStream);
      end;
    finally
      FreeAndNil(DecryptedDataStream);
    end;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;
end;

end.

