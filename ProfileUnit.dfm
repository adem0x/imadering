object ProfileForm: TProfileForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 281
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
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
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
    Top = 260
    Width = 3
    Height = 13
  end
  object CenterPanel: TPanel
    Left = 8
    Top = 79
    Width = 243
    Height = 175
    BevelKind = bkTile
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object ProfileLabel: TLabel
      Left = 11
      Top = 51
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SiteLabel: TLabel
      Left = 62
      Top = 151
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
    object LangLabel: TLabel
      Left = 11
      Top = 5
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object OpenProfilesSpeedButton: TSpeedButton
      Left = 205
      Top = 70
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = OpenProfilesSpeedButtonClick
    end
    object ProfileComboBox: TComboBox
      Left = 10
      Top = 70
      Width = 189
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      Text = 'Profile1'
      OnChange = ProfileComboBoxChange
    end
    object LoginButton: TButton
      Left = 10
      Top = 120
      Width = 102
      Height = 25
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = LoginButtonClick
    end
    object DeleteButton: TButton
      Left = 126
      Top = 120
      Width = 102
      Height = 25
      TabOrder = 2
      OnClick = DeleteButtonClick
    end
    object LangComboBox: TComboBox
      Left = 10
      Top = 24
      Width = 218
      Height = 21
      Style = csDropDownList
      DropDownCount = 15
      TabOrder = 3
      TabStop = False
      Items.Strings = (
        '[ru] '#1056#1091#1089#1089#1082#1080#1081
        '[en] English')
    end
    object AutoSignCheckBox: TCheckBox
      Left = 10
      Top = 97
      Width = 218
      Height = 17
      TabOrder = 4
    end
  end
end
