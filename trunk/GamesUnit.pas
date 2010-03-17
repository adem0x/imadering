{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit GamesUnit;

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
  ButtonGroup,
  ExtCtrls,
  ComCtrls,
  StdCtrls,
  Htmlview,
  Buttons,
  ShockwaveFlashObjects_TLB,
  OverbyteIcsWndControl,
  OverbyteIcsHttpProt,
  Zlib;

type
  TGamesForm = class(TForm)
    CatalogPanel: TPanel;
    CatalogButtonGroup: TButtonGroup;
    GamePanel: TPanel;
    CatalogSplitter: TSplitter;
    LoadPanel: TPanel;
    LoadAbortButton: TButton;
    FlashPanel: TPanel;
    LoadCatalogBitBtn: TBitBtn;
    ProgressPanel: TPanel;
    LoadGameProgressBar: TProgressBar;
    LoadLabel: TLabel;
    InfoLabel: TLabel;
    LoadGameBitBtn: TBitBtn;
    GameLoadHttpClient: THttpCli;
    LoadSizeLabel: TLabel;
    SettingsPanel: TPanel;
    InfoPanelSpeedButton: TSpeedButton;
    AllowNetworkingCheckBox: TCheckBox;
    SignatureLabel: TLabel;
    FlashInfoLabel: TLabel;
    PlayButton: TButton;
    ResetButton: TButton;
    VersionLabel: TLabel;
    FileLengthLabel: TLabel;
    HeightLabel: TLabel;
    WidthLabel: TLabel;
    FrameRateLabel: TLabel;
    FrameCountLabel: TLabel;
    FlashPlayerURLLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CatalogButtonGroupButtonClicked(Sender: TObject; index: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GameLoadHttpClientDocBegin(Sender: TObject);
    procedure GameLoadHttpClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure GameLoadHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
    procedure LoadGameBitBtnClick(Sender: TObject);
    procedure LoadCatalogBitBtnClick(Sender: TObject);
    procedure LoadAbortButtonClick(Sender: TObject);
    procedure GameLoadHttpClientSessionClosed(Sender: TObject);
    procedure GameLoadHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
    procedure GameLoadHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
    procedure InfoPanelSpeedButtonClick(Sender: TObject);
    procedure AllowNetworkingCheckBoxClick(Sender: TObject);
    procedure PlayButtonClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FlashPlayerURLLabelClick(Sender: TObject);
    procedure FlashPlayerURLLabelMouseEnter(Sender: TObject);
    procedure FlashPlayerURLLabelMouseLeave(Sender: TObject);

  private
    { Private declarations }
    Flash: TShockwaveFlash;
    GFileName: string;
    procedure CreateGamesList;

  public
    { Public declarations }
    procedure TranslateForm;
  end;

type
  TBitWidth = 1 .. 32;

  TSWFRect = packed record
    Xmin: Integer; // in twips
    Xmax: Integer; // in twips
    Ymin: Integer; // in twips
    Ymax: Integer; // in twips
  end;

  TSWFHeader = packed record
    Signature: array [0 .. 2] of AnsiChar;
    Version: Byte;
    FileLength: Cardinal;
    FrameSize: TSWFRect;
    FrameRate: Byte;
    FrameRateRemainder: Byte;
    FrameCount: Cardinal;
  end;

{$ENDREGION}

var
  GamesForm: TGamesForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  TrafficUnit,
  SettingsUnit;

{$ENDREGION}
{$REGION 'MyConsts'}

  const
    C_Signature = 'Signature: ';
    C_Version = 'Flash version: ';
    C_FileSize = 'File size: ';
    C_Height = 'Height: ';
    C_Width = 'Width: ';
    C_FrameRate = 'Framerate: ';
    C_FrameCount = 'Frame count: ';

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TGamesForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}
{$REGION 'FormClose'}

procedure TGamesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Высвобождаем флэш объект
  if Flash <> nil then
    FreeAndNil(Flash);
  // Уничтожаем окно после закрытия
  Action := CaFree;
  GamesForm := nil;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TGamesForm.FormCreate(Sender: TObject);
begin
  // Присваиваем иконку окну и кнопкам
  MainForm.AllImageList.GetIcon(286, Icon);
  MainForm.AllImageList.GetBitmap(6, LoadCatalogBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(225, LoadGameBitBtn.Glyph);
  // Переводим форму на другие языки
  TranslateForm;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Создаём список игр
  CreateGamesList;
  // Применяем настройки прокси
  SettingsForm.ApplyProxyHttpClient(GameLoadHttpClient);
end;

procedure TGamesForm.FormDblClick(Sender: TObject);
begin
  // Переводим форму на другие языки
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'ReadNBits'}

function ReadNBits(const Buffer; Position: Longint; Count: TBitWidth): Longint;
var
  I, B: Longint;
begin
  Result := 0;
  B := 1 shl (Count - 1);
  for I := Position to Position + Count - 1 do
    begin
      if (PByteArray(@Buffer)^[I div 8] and (128 shr (I mod 8))) <> 0 then
        Result := Result or B;
      B := B shr 1;
    end;
end;

{$ENDREGION}
{$REGION 'GetSwfFileHeader'}

function GetSwfFileHeader(const FileName: string; var Header: TSWFHeader): Boolean;
const
  BuffSize = 25;
var
  Buffer: PByteArray;
  NBitsField: Byte;
  Poz: Longword;
  FileStream: TFileStream;
  MemStream: TMemoryStream;
  ZStream: TDecompressionStream;
begin
  Result := FALSE;
  if not FileExists(FileName) then
    Exit;
  FileStream := TFileStream.Create(FileName, FmOpenRead);
  try
    FileStream.Position := 0;
    if FileStream.Size > 22 then
      begin
        GetMem(Buffer, BuffSize);
        try
          FileStream.read(Header, 8);
          if (Header.Signature = 'CWS') and (Header.Version >= 6) then
            begin
              Result := TRUE;
              MemStream := TMemoryStream.Create;
              try
                MemStream.CopyFrom(FileStream, FileStream.Size - 8);
                MemStream.Position := 0;
                ZStream := TDecompressionStream.Create(MemStream);
                try
                  ZStream.read(Buffer^, BuffSize);
                finally
                  ZStream.Free;
                end;
              finally
                MemStream.Free;
              end;
            end
          else
            begin
              FileStream.read(Buffer^, BuffSize);
              Result := Header.Signature = 'FWS';
            end;
          if Result then
            with Header do
              begin
                Poz := 0;
                NBitsField := TBitWidth(ReadNBits(Buffer^, Poz, 5));
                Inc(Poz, 5);
                FrameSize.Xmin := Integer(ReadNBits(Buffer^, Poz, NBitsField));
                Inc(Poz, NBitsField);
                FrameSize.Xmax := Integer(ReadNBits(Buffer^, Poz, NBitsField));
                Inc(Poz, NBitsField);
                FrameSize.Ymin := Integer(ReadNBits(Buffer^, Poz, NBitsField));
                Inc(Poz, NBitsField);
                FrameSize.Ymax := Integer(ReadNBits(Buffer^, Poz, NBitsField));
                Inc(Poz, NBitsField);
                NBitsField := Poz mod 8;
                Poz := Poz div 8;
                if (NBitsField > 0) then
                  Inc(Poz);
                FrameRateRemainder := Buffer^[Poz]; // 8.[8]
                FrameRate := Buffer^[Poz + 1];
                FrameCount := Buffer^[Poz + 2] or (Buffer^[Poz + 3] shl 8);
              end;
        finally
          FreeMem(Buffer);
        end;
      end;
  finally
    FileStream.Free;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TGamesForm.FlashPlayerURLLabelClick(Sender: TObject);
begin
  // Открываем сайт для скачки Flash Player
  OpenURL('http://get.adobe.com/flashplayer/otherversions/');
end;

procedure TGamesForm.FlashPlayerURLLabelMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := ClBlue;
end;

procedure TGamesForm.FlashPlayerURLLabelMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color := ClNavy;
end;

procedure TGamesForm.PlayButtonClick(Sender: TObject);
begin
  // Стартуем игру
  if Flash <> nil then
    Flash.Play;
end;

procedure TGamesForm.ResetButtonClick(Sender: TObject);
begin
  // Сброс игры
  if Flash <> nil then
    Flash.Rewind;
end;

procedure TGamesForm.GameLoadHttpClientDocBegin(Sender: TObject);
begin
  // Создаём блок памяти для приёма http данных
  GameLoadHttpClient.RcvdStream := TMemoryStream.Create;
end;

procedure TGamesForm.InfoPanelSpeedButtonClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  // Открываем информационную панель
  GetCursorPos(FCursor);
  if InfoPanelSpeedButton.NumGlyphs = 4 then
    begin
      SettingsPanel.Width := FlashPanel.Width div 2;
      InfoPanelSpeedButton.NumGlyphs := 1;
      SetCursorPos(FCursor.X - SettingsPanel.Width, FCursor.Y);
    end
  else
    begin
      SetCursorPos(FCursor.X + SettingsPanel.Width, FCursor.Y);
      InfoPanelSpeedButton.NumGlyphs := 4;
      SettingsPanel.Width := 0;
    end;
end;

{$ENDREGION}
{$REGION 'GameLoadHttpClientDocData'}

procedure TGamesForm.GameLoadHttpClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  // Отображаем процесс получения данных
  if GameLoadHttpClient.ContentLength > -1 then
    begin
      LoadSizeLabel.Caption := Format(S_DownCount, [FloatToStrF(GameLoadHttpClient.RcvdCount / 1000, FfFixed, 7, 1)]);
      LoadGameProgressBar.Max := GameLoadHttpClient.ContentLength;
      LoadGameProgressBar.Position := GameLoadHttpClient.RcvdCount;
    end;
  // Обновляем форму и контролы чтобы видеть изменения
  Update;
  // Если был активирован аборт сессии, то выходим и отключаем сокет
  if GameLoadHttpClient.Tag = 2 then
    begin
      GameLoadHttpClient.CloseAsync;
      GameLoadHttpClient.Abort;
    end;
end;

{$ENDREGION}
{$REGION 'GameLoadHttpClientRequestDone'}

procedure TGamesForm.GameLoadHttpClientRequestDone(Sender: TObject; RqType: THttpRequest; ErrCode: Word);
label
  X;
var
  List: TStringList;
  GFile: TMemoryStream;
begin
  try
    // Читаем полученные http данные из блока памяти
    if GameLoadHttpClient.RcvdStream <> nil then
      begin
        try
          // Увеличиваем статистику входящего трафика
          V_TrafRecev := V_TrafRecev + GameLoadHttpClient.RcvdCount;
          V_AllTrafRecev := V_AllTrafRecev + GameLoadHttpClient.RcvdCount;
          if Assigned(TrafficForm) then
            MainForm.OpenTrafficClick(nil);
          // Обнуляем позицию начала чтения в блоке памяти
          GameLoadHttpClient.RcvdStream.Position := 0;
          ForceDirectories(V_ProfilePath + C_GamesFolder);
          case GameLoadHttpClient.Tag of // Определяем выполнение задания для данных по флагу
            0: begin
                // Создаём временный лист
                List := TStringList.Create;
                try
                  // Читаем данные в лист
                  List.LoadFromStream(GameLoadHttpClient.RcvdStream);
                  // Разбираем данные в листе
                  if List.Text > EmptyStr then
                    begin
                      // Сохраняем каталог в файл
                      List.SaveToFile(V_ProfilePath + C_GamesFolder + C_GamesCatalogFileName);
                      // Обновляем список игр
                      CreateGamesList;
                      InfoLabel.Caption := '#Список игр успешно получен и обновлён!';
                    end;
                finally
                  List.Free;
                end;
              end;
            1: begin
                // Создаём блок в памяти для приёма файла игры
                GFile := TMemoryStream.Create;
                try
                  // Читаем данные в память
                  GFile.LoadFromStream(GameLoadHttpClient.RcvdStream);
                  // Сохраняем файл с игрой
                  GFile.SaveToFile(V_ProfilePath + C_GamesFolder + GFileName);
                  // Деактивируем кнопку Прервать
                  LoadAbortButton.Enabled := False;
                  // Прячем панель загрузки
                  LoadPanel.Visible := False;
                  // Запускаем игру
                  CatalogButtonGroupButtonClicked(CatalogButtonGroup, CatalogButtonGroup.ItemIndex);
                finally
                  // Уничтожаем блок памяти
                  FreeAndNil(GFile);
                end;
              end;
          end;
        X :;
        finally
          // Высвобождаем блок памяти
          GameLoadHttpClient.RcvdStream.Free;
          GameLoadHttpClient.RcvdStream := nil;
        end;
      end;
  except
    on E: Exception do
      MainForm.IMaderingEventsException(Self, E);
  end;
end;

{$ENDREGION}
{$REGION 'CatalogButtonGroupButtonClicked'}

procedure TGamesForm.CatalogButtonGroupButtonClicked(Sender: TObject; index: Integer);
var
  Gfile: string;
  FlashInfo: TSWFHeader;
begin
  // Стираем сообщения об ошибках
  FlashPanel.Caption := EmptyStr;
  FlashPlayerURLLabel.Visible := False;
  // Высвобождаем предыдущий флэш объект
  if Flash <> nil then
    FreeAndNil(Flash);
  // Если игра найдена, то запускаем игру
  Gfile := ExtractUrlFileName(CatalogButtonGroup.Items[index].Hint);
  if FileExists(V_ProfilePath + C_GamesFolder + Gfile) then
    begin
      // Прячем контролы
      InfoLabel.Visible := False;
      LoadGameBitBtn.Visible := False;
      InfoPanelSpeedButton.NumGlyphs := 4;
      SettingsPanel.Width := 0;
      WindowState := wsNormal;
      // Получаем информацию из флэш файла
      if GetSwfFileHeader(V_ProfilePath + C_GamesFolder + Gfile, FlashInfo) then
        begin
          SignatureLabel.Caption := C_Signature + FlashInfo.Signature;
          VersionLabel.Caption := C_Version + IntToStr(FlashInfo.Version);
          FileLengthLabel.Caption := C_FileSize + FloatToStrF(FlashInfo.FileLength / 1000000, FfFixed, 7, 1) + ' MB';
          HeightLabel.Caption := C_Height + IntToStr(FlashInfo.FrameSize.Ymax div 20);
          WidthLabel.Caption := C_Width + IntToStr(FlashInfo.FrameSize.Xmax div 20);
          FrameRateLabel.Caption := C_FrameRate + IntToStr(FlashInfo.FrameRate);
          FrameCountLabel.Caption := C_FrameCount + IntToStr(FlashInfo.FrameCount);
        end;
      // Загружаем новый флэш объект
      try
      Flash := TShockwaveFlash.Create(FlashPanel);
      // Подгоняем размеры окна к размерам игры
      Height := (FlashInfo.FrameSize.Ymax div 20) + 34;
      Width := FlashInfo.FrameSize.Xmax div 20 + CatalogButtonGroup.Width + 20;
      // Выставляем настройки
      Flash.Align := AlClient;
      Flash.Parent := FlashPanel;
      Flash.BackgroundColor := ClBlack;
      Flash.ScaleMode := 2; // 0 - ShowAll, 1 - NoBorder, 2 - ExtractFit, 3 - NoScale, 4- Low, 5 - AutoLow, 6 - AutoHight, 7 - Hight, 8 - Best, 9 - AutoMedium, 10 - Medium
      Flash.AllowFullScreen := 'false';
      Flash.Menu := false;
      Flash.Movie := V_ProfilePath + C_GamesFolder + Gfile;
      // Включаем или выключаем флэшке доступ к системе
      if AllowNetworkingCheckBox.Checked then
        Flash.AllowNetworking := 'all'
      else
        Flash.AllowNetworking := 'none';
      Flash.AllowScriptAccess := 'never';
      except
        if Flash <> nil then
          FreeAndNil(Flash);
        InfoLabel.Caption := '#Вероятно у вас не установлен компонент Flash Player!';
        InfoLabel.Visible := true;
        FlashPlayerURLLabel.Visible := true;
      end;
    end
  else
    begin
      // Отображаем сообщение и контролы для загрузки игры
      InfoLabel.Caption := '#Загрузите игру c сервера ...';
      InfoLabel.Visible := True;
      LoadGameBitBtn.Enabled := True;
      LoadGameBitBtn.Visible := True;
    end;
  // В заголовке отображаем название игры
  Caption := Format(S_Game, ['- ' + CatalogButtonGroup.Items.Items[index].Caption]);
end;

{$ENDREGION}
{$REGION 'CreateGamesList'}

procedure TGamesForm.CreateGamesList;
var
  List: TStringList;
  I: Integer;
begin
  // Строим список игр из файла каталога
  CatalogButtonGroup.Items.Clear;
  List := TStringList.Create;
  try
    if FileExists(V_ProfilePath + C_GamesFolder + C_GamesCatalogFileName) then
      List.LoadFromFile(V_ProfilePath + C_GamesFolder + C_GamesCatalogFileName);
    for I := 0 to List.Count - 1 do
      begin
        with CatalogButtonGroup.Items.Add do
          begin
            Caption := Parse(';', List.Strings[I], 1);
            Hint := Parse(';', List.Strings[I], 2);
            ImageIndex := 286;
          end;
      end;
  finally
    List.Free;
  end;
end;

{$ENDREGION}
{$REGION 'LoadCatalogBitBtnClick'}

procedure TGamesForm.LoadCatalogBitBtnClick(Sender: TObject);
begin
  // Сбрасываем сокет если он занят чем то другим или висит
  GameLoadHttpClient.Abort;
  // Ставим флаг задания
  GameLoadHttpClient.Tag := 0;
  // Стираем сообщения об ошибках
  FlashPanel.Caption := EmptyStr;
  // Отображаем сообщение и контролы о загрузке списка
  InfoLabel.Caption := '#Загрузка и обновление списка доступных игр ...';
  InfoLabel.Visible := True;
  LoadGameBitBtn.Visible := False;
  LoadPanel.Visible := False;
  // Высвобождаем предыдущий флэш объект
  if Flash <> nil then
    FreeAndNil(Flash);
  // Запускаем загрузку файла с каталогом игр
  GameLoadHttpClient.URL := C_GoogleCodeURL + C_GamesCatalogFileName;
  GameLoadHttpClient.GetASync;
end;

{$ENDREGION}
{$REGION 'LoadGameBitBtnClick'}

procedure TGamesForm.LoadGameBitBtnClick(Sender: TObject);
begin
  // Сбрасываем сокет если он занят чем то другим или висит
  GameLoadHttpClient.Abort;
  // Ставим флаг задания
  GameLoadHttpClient.Tag := 1;
  // Обнуляем прогресс бар и другие контролы
  LoadGameProgressBar.Position := 0;
  LoadAbortButton.Enabled := True;
  LoadPanel.Visible := True;
  InfoLabel.Caption := '#Загрузка игры с сервера ...';
  LoadGameBitBtn.Enabled := False;
  // Стираем сообщения об ошибках
  FlashPanel.Caption := EmptyStr;
  // Запускаем загрузку файла с игрой
  GameLoadHttpClient.URL := CatalogButtonGroup.Items[CatalogButtonGroup.ItemIndex].Hint;
  GFileName := ExtractUrlFileName(CatalogButtonGroup.Items[CatalogButtonGroup.ItemIndex].Hint);
  GameLoadHttpClient.GetASync;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TGamesForm.AllowNetworkingCheckBoxClick(Sender: TObject);
begin
  // Включаем или выключаем разрешение флэшке доступ к системе
  if AllowNetworkingCheckBox.Checked then
    Flash.AllowNetworking := 'all'
  else
    Flash.AllowNetworking := 'none';
end;

procedure TGamesForm.LoadAbortButtonClick(Sender: TObject);
begin
  // Деактивируем кнопку Прервать
  LoadAbortButton.Enabled := False;
  // Ставим флаг отбоя закачки
  GameLoadHttpClient.Tag := 2;
  GameLoadHttpClient.Abort;
  // Прячем панель загрузки
  LoadPanel.Visible := False;
  InfoLabel.Caption := '#Загрузите игру с сервера ...';
  LoadGameBitBtn.Enabled := True;
end;

procedure TGamesForm.GameLoadHttpClientSessionClosed(Sender: TObject);
begin
  // Обрабатываем возможные ошибки в работе http сокета
  with GameLoadHttpClient do
    begin
      if (StatusCode = 0) or (StatusCode >= 400) then
        begin
          FlashPanel.Caption := Format(ErrorHttpClient(StatusCode), [C_BN]);
        end;
    end;
end;

procedure TGamesForm.GameLoadHttpClientSocksConnected(Sender: TObject; ErrCode: Word);
begin
  // Если возникла ошибка, то сообщаем об этом
  if ErrCode <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, NotifyConnectError((Sender as THttpCli).name, ErrCode), EmptyStr, 134, 2, 0);
    end;
end;

procedure TGamesForm.GameLoadHttpClientSocksError(Sender: TObject; Error: Integer; Msg: string);
begin
  // Если возникла ошибка, то сообщаем об этом
  if Error <> 0 then
    begin
      DAShow(Lang_Vars[17].L_S, Lang_Vars[23].L_S + C_RN + Msg + C_RN + Format(HttpSocketErrCodeL, [Error]) + C_RN + '[ ' + SocketL + C_BN + (Sender as THttpCli).name + ' ]', EmptyStr, 134, 2, 0);
    end;
end;

{$ENDREGION}

end.
