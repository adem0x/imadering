object ShowCertForm: TShowCertForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072#1084#1080' SSL'
  ClientHeight = 342
  ClientWidth = 486
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
    Top = 302
    Width = 486
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object AcceptCertButton: TBitBtn
      Left = 351
      Top = 6
      Width = 121
      Height = 25
      Caption = #1055#1088#1080#1085#1103#1090#1100
      Default = True
      TabOrder = 0
      TabStop = False
      OnClick = AcceptCertButtonClick
    end
    object RefuseCertButton: TBitBtn
      Left = 14
      Top = 6
      Width = 121
      Height = 25
      Caption = #1054#1090#1074#1077#1088#1075#1085#1091#1090#1100
      ModalResult = 2
      TabOrder = 1
      TabStop = False
    end
  end
  object CertGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 470
    Height = 291
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
      Left = 19
      Top = 19
      Width = 56
      Height = 13
      Caption = #1048#1079#1076#1072#1090#1077#1083#1100': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblSubject: TLabel
      Left = 19
      Top = 109
      Width = 51
      Height = 13
      Caption = #1057#1091#1073#1098#1077#1082#1090': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblSerial: TLabel
      Left = 19
      Top = 138
      Width = 91
      Height = 13
      Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblValidAfter: TLabel
      Left = 19
      Top = 168
      Width = 66
      Height = 13
      Caption = #1042#1072#1083#1080#1076#1077#1085' '#1076#1086': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblValidBefore: TLabel
      Left = 19
      Top = 199
      Width = 58
      Height = 13
      Caption = #1042#1072#1083#1080#1076#1077#1085' '#1089': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblShaHash: TLabel
      Left = 19
      Top = 230
      Width = 26
      Height = 13
      Caption = #1061#1101#1096': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblCertExpired: TLabel
      Left = 19
      Top = 256
      Width = 256
      Height = 16
      Caption = #1042#1085#1080#1084#1072#1085#1080#1077': '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090' '#1089#1077#1088#1074#1077#1088#1072' '#1080#1089#1090#1105#1082'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblIssuerMemo: TMemo
      Left = 18
      Top = 38
      Width = 434
      Height = 57
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
