object FileTransferForm: TFileTransferForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1076#1072#1095#1072' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 222
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object FileNameLabel: TLabel
    Left = 9
    Top = 30
    Width = 78
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1080#1081' '#1092#1072#1081#1083':'
  end
  object FileSizeLabel: TLabel
    Left = 240
    Top = 30
    Width = 74
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072':'
  end
  object ProgressLabel: TLabel
    Left = 9
    Top = 76
    Width = 75
    Height = 13
    Caption = #1061#1086#1076' '#1087#1077#1088#1077#1076#1072#1095#1080':'
  end
  object DescLabel: TLabel
    Left = 9
    Top = 121
    Width = 97
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1082' '#1092#1072#1081#1083#1091':'
  end
  object PassLabel: TLabel
    Left = 25
    Top = 172
    Width = 41
    Height = 13
    Alignment = taRightJustify
    Caption = #1055#1072#1088#1086#1083#1100':'
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
    Caption = #1054#1090#1084#1077#1085#1072
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
    Caption = #1047#1072#1082#1088#1099#1090#1100
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
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
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
    SocksAuthentication = socksNoAuthentication
    Left = 160
    Top = 8
  end
end
