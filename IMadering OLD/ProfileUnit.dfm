object ProfileForm: TProfileForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 256
  ClientWidth = 259
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
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
  object LangsSpeedButton: TSpeedButton
    Left = 227
    Top = 230
    Width = 24
    Height = 23
    Flat = True
    ParentShowHint = False
    ShowHint = True
    Spacing = 0
    Transparent = False
    OnClick = LangsSpeedButtonClick
    OnMouseDown = LangsSpeedButtonMouseDown
  end
  object FlagImage: TImage
    Left = 198
    Top = 234
    Width = 16
    Height = 11
    Visible = False
  end
  object VersionLabel: TLabel
    Left = 9
    Top = 235
    Width = 3
    Height = 13
  end
  object CenterPanel: TPanel
    Left = 8
    Top = 73
    Width = 243
    Height = 155
    BevelKind = bkTile
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object ProfileLabel: TLabel
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
    object SiteLabel: TLabel
      Left = 62
      Top = 132
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
    object OpenProfilesSpeedButton: TSpeedButton
      Left = 180
      Top = 24
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = OpenProfilesSpeedButtonClick
    end
    object DellProfileSpeedButton: TSpeedButton
      Left = 205
      Top = 24
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = DellProfileSpeedButtonClick
    end
    object ProfileComboBox: TComboBox
      Left = 10
      Top = 24
      Width = 164
      Height = 21
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      Text = 'Profile1'
      OnChange = ProfileComboBoxChange
    end
    object LoginButton: TBitBtn
      Left = 10
      Top = 101
      Width = 218
      Height = 25
      Default = True
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      TabStop = False
      OnClick = LoginButtonClick
    end
    object NoShowProfileFormCheckBox: TCheckBox
      Left = 10
      Top = 51
      Width = 218
      Height = 17
      TabStop = False
      TabOrder = 2
    end
    object AutoDellProfileCheckBox: TCheckBox
      Left = 10
      Top = 74
      Width = 218
      Height = 17
      TabStop = False
      TabOrder = 3
      OnClick = AutoDellProfileCheckBoxClick
    end
  end
  object LangsPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = LangsImageList
    Left = 96
    Top = 24
  end
  object LangsImageList: TImageList
    Height = 11
    Masked = False
    Left = 136
    Top = 24
  end
end
