object UniqForm: TUniqForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1059#1085#1080#1082#1072#1083#1100#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1082#1086#1085#1090#1072#1082#1090#1072
  ClientHeight = 360
  ClientWidth = 442
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
  object SoundsGroupBox: TGroupBox
    Left = 8
    Top = 30
    Width = 426
    Height = 132
    Caption = #1047#1074#1091#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object OnlineSoundPathSpeedButton: TSpeedButton
      Left = 367
      Top = 43
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object OnlineSoundPlaySpeedButton: TSpeedButton
      Left = 396
      Top = 43
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object MessSoundPathSpeedButton: TSpeedButton
      Left = 367
      Top = 98
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object MessSoundPlaySpeedButton: TSpeedButton
      Left = 396
      Top = 98
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object OnlineSoundCheckBox: TCheckBox
      Left = 16
      Top = 20
      Width = 393
      Height = 17
      Caption = #1042#1086#1089#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1100' '#1101#1090#1086#1090' '#1079#1074#1091#1082' '#1087#1088#1080' '#1074#1093#1086#1076#1077' '#1082#1086#1085#1090#1072#1082#1090#1072' '#1074' '#1089#1077#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object OnlineSoundPathEdit: TEdit
      Left = 16
      Top = 43
      Width = 345
      Height = 21
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object MessSoundCheckBox: TCheckBox
      Left = 16
      Top = 75
      Width = 393
      Height = 17
      Caption = #1042#1086#1089#1087#1088#1086#1080#1079#1074#1086#1076#1080#1090#1100' '#1101#1090#1086#1090' '#1079#1074#1091#1082' '#1076#1083#1103' '#1074#1093#1086#1076#1103#1097#1080#1093' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1086#1090' '#1082#1086#1085#1090#1072#1082#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object MessSoundPathEdit: TEdit
      Left = 16
      Top = 98
      Width = 345
      Height = 21
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object CancelBitBtn: TBitBtn
    Left = 8
    Top = 327
    Width = 97
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = CancelBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 344
    Top = 327
    Width = 90
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = OKBitBtnClick
  end
  object OptionGroupBox: TGroupBox
    Left = 8
    Top = 168
    Width = 426
    Height = 153
    Caption = #1054#1087#1094#1080#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object SaveHistoryCheckBox: TCheckBox
      Left = 16
      Top = 22
      Width = 393
      Height = 17
      Caption = #1042#1089#1077#1075#1076#1072' '#1089#1086#1093#1088#1072#1085#1103#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1076#1083#1103' '#1101#1090#1086#1075#1086' '#1082#1086#1085#1090#1072#1082#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object SendTranslitCheckBox: TCheckBox
      Left = 16
      Top = 45
      Width = 393
      Height = 17
      Caption = #1042#1089#1077#1075#1076#1072' '#1086#1090#1087#1088#1072#1074#1083#1103#1090#1100' '#1101#1090#1086#1084#1091' '#1082#1086#1085#1090#1072#1082#1090#1091' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1074' '#1090#1088#1072#1085#1089#1083#1080#1090#1077#1088#1072#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object AccountPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 436
    Height = 21
    Align = alTop
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
end
