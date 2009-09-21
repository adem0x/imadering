object ShowCertForm: TShowCertForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072#1084#1080' SSL'
  ClientHeight = 340
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 300
    Width = 484
    Height = 40
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 274
    object AcceptCertButton: TButton
      Left = 352
      Top = 8
      Width = 121
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      TabOrder = 0
      OnClick = AcceptCertButtonClick
    end
    object RefuseCertButton: TButton
      Left = 10
      Top = 8
      Width = 121
      Height = 25
      Caption = #1054#1090#1074#1077#1088#1075#1085#1091#1090#1100
      TabOrder = 1
      OnClick = RefuseCertButtonClick
    end
  end
  object CertGroupBox: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 468
    Height = 289
    Margins.Bottom = 0
    Caption = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object LblIssuer: TLabel
      Left = 27
      Top = 32
      Width = 56
      Height = 13
      AutoSize = False
      Caption = #1048#1079#1076#1072#1090#1077#1083#1100': '
      WordWrap = True
    end
    object LblSubject: TLabel
      Left = 32
      Top = 72
      Width = 57
      Height = 13
      Caption = #1057#1091#1073#1098#1077#1082#1090': '
    end
    object LblSerial: TLabel
      Left = 32
      Top = 104
      Width = 101
      Height = 13
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088': '
    end
    object lblValidAfter: TLabel
      Left = 31
      Top = 136
      Width = 75
      Height = 13
      Caption = #1042#1072#1083#1080#1076#1077#1085' '#1076#1086': '
    end
    object LblValidBefore: TLabel
      Left = 32
      Top = 168
      Width = 65
      Height = 13
      Caption = #1042#1072#1083#1080#1076#1077#1085' '#1089': '
    end
    object LblShaHash: TLabel
      Left = 32
      Top = 200
      Width = 28
      Height = 13
      Caption = #1061#1101#1096': '
    end
    object LblCertExpired: TLabel
      Left = 32
      Top = 227
      Width = 256
      Height = 16
      Caption = #1042#1085#1080#1084#1072#1085#1080#1077': '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090' '#1089#1077#1088#1074#1077#1088#1072' '#1080#1089#1090#1077#1082'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
