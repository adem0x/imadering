object ShowCert: TShowCert
  Left = 0
  Top = 0
  Caption = 'ShowCert'
  ClientHeight = 314
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 273
    Width = 484
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 394
    ExplicitWidth = 480
    object AcceptCertButton: TButton
      Left = 16
      Top = 6
      Width = 153
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090
      TabOrder = 0
      OnClick = AcceptCertButtonClick
    end
    object RefuseCertButton: TButton
      Left = 175
      Top = 6
      Width = 153
      Height = 25
      Caption = #1054#1090#1074#1077#1088#1075#1085#1091#1090#1100' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090
      TabOrder = 1
      OnClick = RefuseCertButtonClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 484
    Height = 273
    Align = alClient
    Caption = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 561
    ExplicitHeight = 265
    object LblIssuer: TLabel
      Left = 32
      Top = 40
      Width = 56
      Height = 13
      Caption = #1048#1079#1076#1072#1090#1077#1083#1100': '
    end
    object LblSubject: TLabel
      Left = 32
      Top = 72
      Width = 51
      Height = 13
      Caption = #1057#1091#1073#1098#1077#1082#1090': '
    end
    object LblSerial: TLabel
      Left = 32
      Top = 104
      Width = 91
      Height = 13
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088': '
    end
    object lblValidAfter: TLabel
      Left = 31
      Top = 136
      Width = 66
      Height = 13
      Caption = #1042#1072#1083#1080#1076#1077#1085' '#1076#1086': '
    end
    object LblValidBefore: TLabel
      Left = 32
      Top = 168
      Width = 58
      Height = 13
      Caption = #1042#1072#1083#1080#1076#1077#1085' '#1089': '
    end
    object LblShaHash: TLabel
      Left = 32
      Top = 200
      Width = 26
      Height = 13
      Caption = #1061#1101#1096': '
    end
    object LblCertExpired: TLabel
      Left = 31
      Top = 219
      Width = 340
      Height = 23
      Caption = #1042#1085#1080#1084#1072#1085#1080#1077': '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090' '#1089#1077#1088#1074#1077#1088#1072' '#1080#1089#1090#1077#1082'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
