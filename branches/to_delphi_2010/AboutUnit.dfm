object AboutForm: TAboutForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 286
  ClientWidth = 285
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object VersionLabel: TLabel
    Left = 64
    Top = 27
    Width = 6
    Height = 13
    Caption = 'V'
  end
  object URLLabel: TLabel
    Left = 139
    Top = 226
    Width = 114
    Height = 13
    Cursor = crHandPoint
    Caption = 'www.imadering.com'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = URLLabelClick
    OnMouseEnter = URLLabelMouseEnter
    OnMouseLeave = URLLabelMouseLeave
  end
  object SiteLabel: TLabel
    Left = 33
    Top = 226
    Width = 100
    Height = 13
    Caption = #1057#1072#1081#1090' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DataLabel: TLabel
    Left = 64
    Top = 46
    Width = 68
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1073#1086#1088#1082#1080':'
  end
  object HeadLabel: TLabel
    Left = 64
    Top = 8
    Width = 58
    Height = 13
    Caption = 'IMadering'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 245
    Width = 269
    Height = 2
    Shape = bsBottomLine
  end
  object LogoImage: TImage
    Left = 8
    Top = 8
    Width = 50
    Height = 50
    Center = True
    Transparent = True
  end
  object HeadJvBehaviorLabel: TJvBehaviorLabel
    Left = 8
    Top = 177
    Width = 269
    Height = 21
    Behavior = 'Typing'
    BehaviorOptions.MakeErrors = False
    BehaviorOptions.Interval = 45
    OnStart = HeadJvBehaviorLabelStart
    OnStop = HeadJvBehaviorLabelStop
    Alignment = taCenter
    AutoSize = False
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
  end
  object SubJvBehaviorLabel: TJvBehaviorLabel
    Left = 8
    Top = 195
    Width = 269
    Height = 25
    Behavior = 'Typing'
    BehaviorOptions.MakeErrors = False
    BehaviorOptions.Interval = 45
    OnStart = SubJvBehaviorLabelStart
    OnStop = SubJvBehaviorLabelStop
    Alignment = taCenter
    AutoSize = False
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 229
    Top = 8
    Width = 48
    Height = 13
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = #1048#1089#1090#1086#1088#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label1Click
    OnMouseEnter = URLLabelMouseEnter
    OnMouseLeave = URLLabelMouseLeave
  end
  object Label2: TLabel
    Left = 222
    Top = 27
    Width = 55
    Height = 13
    Cursor = crHandPoint
    Alignment = taRightJustify
    Caption = #1051#1080#1094#1077#1085#1079#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = Label2Click
    OnMouseEnter = URLLabelMouseEnter
    OnMouseLeave = URLLabelMouseLeave
  end
  object CheckUpdateBitBtn: TBitBtn
    Left = 8
    Top = 65
    Width = 269
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    TabStop = False
    OnClick = CheckUpdateBitBtnClick
  end
  object DonateBitBtn: TBitBtn
    Left = 8
    Top = 253
    Width = 161
    Height = 25
    Caption = #1055#1086#1076#1076#1077#1088#1078#1072#1090#1100' '#1087#1088#1086#1077#1082#1090
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    OnClick = DonateBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 192
    Top = 253
    Width = 85
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    TabStop = False
    OnClick = OKBitBtnClick
  end
  object AboutRichEdit: TRichEdit
    Left = 8
    Top = 96
    Width = 269
    Height = 75
    TabStop = False
    BevelKind = bkFlat
    BorderStyle = bsNone
    Color = clBtnFace
    Ctl3D = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object AboutListTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = AboutListTimerTimer
    Left = 184
    Top = 24
  end
end
