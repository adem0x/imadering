object ProfileForm: TProfileForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IMadering'
  ClientHeight = 310
  ClientWidth = 259
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LogoImage: TImage
    Left = 0
    Top = 0
    Width = 259
    Height = 73
    Align = alTop
    Center = True
    Transparent = True
    ExplicitWidth = 257
  end
  object VersionLabel: TLabel
    Left = 9
    Top = 287
    Width = 35
    Height = 13
    Caption = 'Version'
  end
  object CenterPanel: TPanel
    Left = 8
    Top = 79
    Width = 243
    Height = 202
    BevelKind = bkTile
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object ProfileLabel: TLabel
      Left = 11
      Top = 7
      Width = 122
      Height = 13
      Caption = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1087#1088#1086#1092#1080#1083#1100':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProfilePassLabel: TLabel
      Left = 11
      Top = 61
      Width = 46
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SiteLabel: TLabel
      Left = 62
      Top = 174
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
      OnClick = SiteLabelClick
      OnMouseEnter = SiteLabelMouseEnter
      OnMouseLeave = SiteLabelMouseLeave
    end
    object ProfileComboBox: TComboBox
      Left = 10
      Top = 26
      Width = 218
      Height = 21
      TabOrder = 0
    end
    object ProfilePassEdit: TEdit
      Left = 10
      Top = 80
      Width = 218
      Height = 21
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 11
      Top = 107
      Width = 215
      Height = 17
      Caption = #1053#1077' '#1089#1087#1088#1072#1096#1080#1074#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
      TabOrder = 2
    end
    object LoginButton: TButton
      Left = 10
      Top = 138
      Width = 102
      Height = 25
      Caption = #1042#1086#1081#1090#1080
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object DeleteButton: TButton
      Left = 126
      Top = 138
      Width = 102
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 4
    end
  end
end
