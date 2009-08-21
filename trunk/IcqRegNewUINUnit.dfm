object IcqRegNewUINForm: TIcqRegNewUINForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1085#1086#1074#1086#1075#1086' ICQ '#1085#1086#1084#1077#1088#1072
  ClientHeight = 333
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RegPassLabel: TLabel
    Left = 87
    Top = 42
    Width = 156
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100' '#1085#1086#1074#1086#1081' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ImageWordLabel: TLabel
    Left = 70
    Top = 241
    Width = 101
    Height = 13
    Alignment = taRightJustify
    Caption = #1057#1083#1086#1074#1086' '#1085#1072' '#1082#1072#1088#1090#1080#1085#1082#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object CopyUINSpeedButton: TSpeedButton
    Left = 326
    Top = 38
    Width = 23
    Height = 22
    Hint = '<b>'#1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1099#1081' ICQ# '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072'</b>'
    Flat = True
    ParentShowHint = False
    ShowHint = True
    Visible = False
    OnClick = CopyUINSpeedButtonClick
  end
  object Bevel1: TBevel
    Left = 8
    Top = 304
    Width = 341
    Height = 2
    Shape = bsBottomLine
  end
  object WebRegLabel: TLabel
    Left = 17
    Top = 312
    Width = 208
    Height = 13
    Cursor = crHandPoint
    Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1072' '#1074#1077#1073' '#1089#1072#1081#1090#1077' ICQ'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = WebRegLabelClick
    OnMouseEnter = WebRegLabelMouseEnter
    OnMouseLeave = WebRegLabelMouseLeave
  end
  object RegInfoPanel: TPanel
    Left = 8
    Top = 8
    Width = 341
    Height = 24
    BevelInner = bvLowered
    BevelOuter = bvNone
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object RegPassEdit: TEdit
    Left = 86
    Top = 61
    Width = 185
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 8
    ParentFont = False
    TabOrder = 1
  end
  object ReqSecretImageButton: TButton
    Left = 59
    Top = 93
    Width = 239
    Height = 25
    Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1082#1072#1088#1090#1080#1085#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ReqSecretImageButtonClick
  end
  object RegImagePanel: TPanel
    Left = 59
    Top = 127
    Width = 240
    Height = 100
    BevelInner = bvLowered
    BevelOuter = bvNone
    Caption = #1053#1077#1090' '#1082#1072#1088#1090#1080#1085#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    object RegImage: TImage
      Left = 1
      Top = 1
      Width = 238
      Height = 98
      Align = alClient
      Center = True
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 105
      ExplicitHeight = 81
    end
  end
  object SecretWordEdit: TEdit
    Left = 177
    Top = 238
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object NewUINRegButton: TButton
    Left = 43
    Top = 269
    Width = 271
    Height = 25
    Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = NewUINRegButtonClick
  end
  object ICQRegWSocket: TWSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    MultiThreaded = False
    MultiCast = False
    MultiCastIpTTL = 1
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    KeepAliveOnOff = wsKeepAliveOff
    KeepAliveTime = 0
    KeepAliveInterval = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    LastError = 0
    ReuseAddr = False
    ComponentOptions = []
    ListenBacklog = 5
    ReqVerLow = 1
    ReqVerHigh = 1
    OnDataAvailable = ICQRegWSocketDataAvailable
    OnSessionClosed = ICQRegWSocketSessionClosed
    OnSessionConnected = ICQRegWSocketSessionConnected
    OnSocksError = ICQRegWSocketSocksError
    Left = 24
    Top = 48
  end
end
