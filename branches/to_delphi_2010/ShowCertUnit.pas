﻿{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit ShowCertUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OverbyteIcsWSocket, Buttons;

const
  AcceptedCertsFile = 'Profile\AcceptedCerts.txt';

type
  /// <summary>Визуализирует сертификат. Пользователь может его  принять или отвергнуть</summary>
  TShowCertForm = class(TForm)
    AcceptCertButton: TBitBtn;
    RefuseCertButton: TBitBtn;
    CertGroupBox: TGroupBox;
    BottomPanel: TPanel;
    LblIssuer: TLabel;
    LblSubject: TLabel;
    LblSerial: TLabel;
    lblValidAfter: TLabel;
    LblValidBefore: TLabel;
    LblShaHash: TLabel;
    LblCertExpired: TLabel;
    LblIssuerMemo: TMemo;
    procedure AcceptCertButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCertAccepted: Boolean;
    FAcceptedCertsList: TStringList;
    FCertHash: string;
    procedure SaveAcceptedCertsList;
    procedure LoadAcceptedCertsList;
  public
    /// <summary>Принял ли пользователь сертификат</summary>
    property CertAccepted: Boolean read FCertAccepted default false;
    /// <summary>Проверить, вдруг этот сертификат уже принимали</summary>
    function CheckAccepted(Hash: string): Boolean;
{$WARNINGS OFF}
    /// <param name="Cert">Сертификат, информацию о котором нужно отобразить</param>
    constructor Create(const Cert: TX509Base);
    destructor Destroy; override;
  end;
{$WARNINGS ON}

implementation

uses MainUnit, EncdDecd, UnitLogger, VarsUnit, UnitCrypto;
{$R *.dfm}

procedure TShowCertForm.AcceptCertButtonClick(Sender: TObject);
begin
  // Принимаем и сохраняем в файл сертификат
  try
    // Добавляем в лист хэш сертификата
    FAcceptedCertsList.Add(FCertHash);
    // Сохраняем лист сертификатов в файл
    SaveAcceptedCertsList;
    FCertAccepted := true;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(E);
  end;
  // Закрываем модальное окно
  ModalResult := mrOk;
end;

function TShowCertForm.CheckAccepted(Hash: string): Boolean;
begin
  Result := false;
  if FAcceptedCertsList <> nil then
  begin
    // Если нашли в листе сертификатов этот хэш, то ОК
    if FAcceptedCertsList.IndexOf(Hash) > -1 then
      Result := true;
  end;
end;

destructor TShowCertForm.Destroy;
begin
  if FAcceptedCertsList <> nil then
  begin
    // Сохраняем сертификаты
    SaveAcceptedCertsList;
    // Уничтожаем лист сертификатов
    FreeAndNil(FAcceptedCertsList);
  end;
  inherited Destroy;
end;

constructor TShowCertForm.Create(const Cert: TX509Base);
begin
  inherited Create(nil);
  // Создаём лист для загрузки хэшей сертификатов
  FAcceptedCertsList := TStringList.Create;
  // Загружаем файл сертификатов
  LoadAcceptedCertsList;
  // Заполняем поля формы
  with Cert do
  begin
    FCertHash := EncodeString(Sha1Hash);
    LblIssuerMemo.Text := IssuerOneLine;
    LblSubject.Caption := LblSubject.Caption + SubjectCName;
    LblSerial.Caption := LblSerial.Caption + IntToStr(SerialNum);
    lblValidAfter.Caption := lblValidAfter.Caption + DateToStr(ValidNotAfter);
    LblValidBefore.Caption := LblValidBefore.Caption + DateToStr
      (ValidNotBefore);
    LblShaHash.Caption := LblShaHash.Caption + FCertHash;
    // Отображаем сообщение если сертификат просрочен
    LblCertExpired.Visible := HasExpired;
  end;
end;

procedure TShowCertForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопке
  MainForm.AllImageList.GetIcon(173, Icon);
  MainForm.AllImageList.GetBitmap(139, RefuseCertButton.Glyph);
  MainForm.AllImageList.GetBitmap(140, AcceptCertButton.Glyph);
end;

procedure TShowCertForm.LoadAcceptedCertsList;
var
  EncryptedDataStream: TFileStream;
  DecryptedDataStream: TStream;
begin
  if not FileExists(ProfilePath + AcceptedCertsFile) then
    Exit;
  try
    EncryptedDataStream := TFileStream.Create(ProfilePath + AcceptedCertsFile,
      fmOpenRead);
    try
      // Расшифровываем
      DecryptedDataStream := DecryptStream(EncryptedDataStream,
        UnitCrypto.PasswordByMac);
      try
        FAcceptedCertsList.LoadFromStream(DecryptedDataStream);
      finally
        FreeAndNil(DecryptedDataStream);
      end;
    finally
      FreeAndNil(EncryptedDataStream);
    end;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(E);
  end;
end;

procedure TShowCertForm.SaveAcceptedCertsList;
var
  EncryptedFileStream: TFileStream;
  DecryptedDataStream: TMemoryStream;
  EncryptedDataStream: TStream;
begin
  // Сохраняем список принятых сертификатов в файл
  try
    DecryptedDataStream := TMemoryStream.Create;
    try
      EncryptedDataStream := TMemoryStream.Create;
      try
        FAcceptedCertsList.SaveToStream(DecryptedDataStream);
        // Шифруем
        EncryptedDataStream := EncryptStream
          (DecryptedDataStream, UnitCrypto.PasswordByMac);
        // Если уже есть какой-то файл списка, то удаляем его
        if FileExists(ProfilePath + AcceptedCertsFile) then
          DeleteFile(ProfilePath + AcceptedCertsFile);
        // Создаём папку профиля
        if not DirectoryExists(ExtractFilePath(ProfilePath + AcceptedCertsFile)
          ) then
          ForceDirectories(ProfilePath + AcceptedCertsFile);
        // Записываем в файл из памяти
        EncryptedFileStream := TFileStream.Create
          (ProfilePath + AcceptedCertsFile, fmCreate);
        try
          EncryptedFileStream.CopyFrom(EncryptedDataStream,
            EncryptedDataStream.Size);
        finally
          FreeAndNil(EncryptedFileStream);
        end;
      finally
        FreeAndNil(EncryptedDataStream);
      end;
    finally
      FreeAndNil(DecryptedDataStream);
    end;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(E);
  end;
end;

end.
