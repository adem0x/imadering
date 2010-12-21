object GamesForm: TGamesForm
  Left = 0
  Top = 0
  Caption = '#'#1048#1075#1088#1099
  ClientHeight = 396
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object CatalogSplitter: TSplitter
    Left = 140
    Top = 0
    Height = 396
    ExplicitLeft = 328
    ExplicitTop = 136
    ExplicitHeight = 100
  end
  object CatalogPanel: TPanel
    Left = 0
    Top = 0
    Width = 140
    Height = 396
    Align = alLeft
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object CatalogButtonGroup: TButtonGroup
      Left = 0
      Top = 0
      Width = 140
      Height = 365
      Align = alClient
      BevelKind = bkTile
      BorderStyle = bsNone
      ButtonHeight = 20
      ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
      DoubleBuffered = True
      Images = MainForm.AllImageList
      Items = <>
      ParentDoubleBuffered = False
      TabOrder = 0
      TabStop = False
      OnButtonClicked = CatalogButtonGroupButtonClicked
    end
    object LoadCatalogBitBtn: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 368
      Width = 134
      Height = 25
      Align = alBottom
      DoubleBuffered = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = LoadCatalogBitBtnClick
    end
  end
  object GamePanel: TPanel
    Left = 143
    Top = 0
    Width = 493
    Height = 396
    Align = alClient
    BevelEdges = [beLeft]
    BevelKind = bkTile
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object InfoPanelSpeedButton: TSpeedButton
      Left = 484
      Top = 0
      Width = 7
      Height = 344
      Align = alRight
      Flat = True
      Glyph.Data = {
        96030000424D9603000000000000360000002800000020000000090000000100
        1800000000006003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
        000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 4
      OnClick = InfoPanelSpeedButtonClick
      ExplicitLeft = 398
      ExplicitHeight = 340
    end
    object LoadPanel: TPanel
      Left = 0
      Top = 344
      Width = 491
      Height = 52
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      Visible = False
      object LoadAbortButton: TButton
        AlignWithMargins = True
        Left = 402
        Top = 15
        Width = 81
        Height = 27
        Margins.Top = 15
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alRight
        Enabled = False
        TabOrder = 0
        TabStop = False
        OnClick = LoadAbortButtonClick
      end
      object ProgressPanel: TPanel
        Left = 0
        Top = 0
        Width = 399
        Height = 50
        Align = alClient
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        DesignSize = (
          399
          50)
        object LoadLabel: TLabel
          Left = 8
          Top = 4
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LoadSizeLabel: TLabel
          Left = 388
          Top = 6
          Width = 3
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
        end
        object LoadGameProgressBar: TProgressBar
          AlignWithMargins = True
          Left = 8
          Top = 25
          Width = 386
          Height = 17
          Margins.Left = 8
          Margins.Right = 5
          Margins.Bottom = 8
          Align = alBottom
          Smooth = True
          TabOrder = 0
        end
      end
    end
    object FlashPanel: TPanel
      Left = 0
      Top = 0
      Width = 484
      Height = 344
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object InfoLabel: TLabel
        Left = 10
        Top = 15
        Width = 3
        Height = 13
      end
      object FlashPlayerURLLabel: TLabel
        Left = 10
        Top = 73
        Width = 383
        Height = 13
        Cursor = crHandPoint
        Caption = '#'#1057#1082#1072#1095#1072#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1074#1077#1088#1089#1080#1102' Flash Player '#1089' '#1086#1092#1080#1094#1080#1072#1083#1100#1085#1086#1075#1086' '#1089#1072#1081#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
        OnClick = FlashPlayerURLLabelClick
        OnMouseEnter = FlashPlayerURLLabelMouseEnter
        OnMouseLeave = FlashPlayerURLLabelMouseLeave
      end
      object LoadGameBitBtn: TBitBtn
        Left = 10
        Top = 42
        Width = 151
        Height = 25
        DoubleBuffered = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentDoubleBuffered = False
        ParentFont = False
        TabOrder = 0
        TabStop = False
        Visible = False
        OnClick = LoadGameBitBtnClick
      end
    end
    object SettingsPanel: TPanel
      Left = 484
      Top = 0
      Width = 0
      Height = 344
      Align = alRight
      BevelEdges = [beLeft]
      BevelKind = bkTile
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object SignatureLabel: TLabel
        Left = 10
        Top = 92
        Width = 3
        Height = 13
      end
      object FlashInfoLabel: TLabel
        Left = 10
        Top = 73
        Width = 3
        Height = 13
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object VersionLabel: TLabel
        Left = 10
        Top = 111
        Width = 3
        Height = 13
      end
      object FileLengthLabel: TLabel
        Left = 10
        Top = 130
        Width = 3
        Height = 13
      end
      object HeightLabel: TLabel
        Left = 10
        Top = 149
        Width = 3
        Height = 13
      end
      object WidthLabel: TLabel
        Left = 10
        Top = 168
        Width = 3
        Height = 13
      end
      object FrameRateLabel: TLabel
        Left = 10
        Top = 187
        Width = 3
        Height = 13
      end
      object FrameCountLabel: TLabel
        Left = 10
        Top = 206
        Width = 3
        Height = 13
      end
      object AllowNetworkingCheckBox: TCheckBox
        Left = 10
        Top = 9
        Width = 377
        Height = 17
        TabStop = False
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = AllowNetworkingCheckBoxClick
      end
      object PlayButton: TButton
        Left = 10
        Top = 34
        Width = 75
        Height = 25
        TabOrder = 1
        TabStop = False
        OnClick = PlayButtonClick
      end
      object ResetButton: TButton
        Left = 91
        Top = 34
        Width = 75
        Height = 25
        TabOrder = 2
        TabStop = False
        OnClick = ResetButtonClick
      end
    end
  end
  object GameLoadHttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.5.24 Version/10.54'
    Accept = 
      'text/html, application/xml;q=0.9, application/xhtml+xml, image/p' +
      'ng, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1'
    AcceptLanguage = 'ru-RU,ru;q=0.9,en;q=0.8'
    Connection = 'Keep-Alive'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthNone
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    OnSessionClosed = GameLoadHttpClientSessionClosed
    OnDocBegin = GameLoadHttpClientDocBegin
    OnDocData = GameLoadHttpClientDocData
    OnRequestDone = GameLoadHttpClientRequestDone
    OnCookie = GameLoadHttpClientCookie
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = GameLoadHttpClientSocksConnected
    OnSocksError = GameLoadHttpClientSocksError
    Left = 48
    Top = 32
  end
end
