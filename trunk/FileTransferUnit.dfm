object FileTransferForm: TFileTransferForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 222
  ClientWidth = 498
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
  object FileNameLabel: TLabel
    Left = 9
    Top = 30
    Width = 3
    Height = 13
  end
  object FileSizeLabel: TLabel
    Left = 240
    Top = 30
    Width = 3
    Height = 13
  end
  object ProgressLabel: TLabel
    Left = 9
    Top = 76
    Width = 3
    Height = 13
  end
  object DescLabel: TLabel
    Left = 9
    Top = 121
    Width = 3
    Height = 13
  end
  object PassLabel: TLabel
    Left = 63
    Top = 172
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object TopInfoPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 492
    Height = 21
    Align = alTop
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object FileNamePanel: TPanel
    Left = 8
    Top = 49
    Width = 225
    Height = 21
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object FileSizePanel: TPanel
    Left = 239
    Top = 49
    Width = 153
    Height = 21
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object CancelBitBtn: TBitBtn
    Left = 398
    Top = 31
    Width = 92
    Height = 25
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 3
    TabStop = False
    OnClick = CancelBitBtnClick
  end
  object CloseBitBtn: TBitBtn
    Left = 398
    Top = 62
    Width = 92
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    TabStop = False
    OnClick = CloseBitBtnClick
  end
  object SendProgressBar: TProgressBar
    Left = 8
    Top = 95
    Width = 482
    Height = 17
    Smooth = True
    TabOrder = 5
  end
  object BottomInfoPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 198
    Width = 492
    Height = 21
    Align = alBottom
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object DescEdit: TEdit
    Left = 8
    Top = 140
    Width = 482
    Height = 21
    TabOrder = 7
  end
  object PassEdit: TEdit
    Left = 72
    Top = 169
    Width = 282
    Height = 21
    TabStop = False
    PasswordChar = '*'
    TabOrder = 8
  end
  object SendFileButton: TBitBtn
    Left = 360
    Top = 167
    Width = 130
    Height = 25
    Default = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 9
    TabStop = False
    OnClick = SendFileButtonClick
  end
  object SendFileHttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.64 (Windows NT 5.1; U; ru) Presto/2.1.1'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
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
    OnSessionClosed = SendFileHttpClientSessionClosed
    OnDocBegin = SendFileHttpClientDocBegin
    OnDocEnd = SendFileHttpClientDocEnd
    OnSendData = SendFileHttpClientSendData
    OnSendEnd = SendFileHttpClientSendEnd
    OnRequestDone = SendFileHttpClientRequestDone
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = SendFileHttpClientSocksConnected
    OnSocksError = SendFileHttpClientSocksError
    Left = 160
    Top = 8
  end
end
