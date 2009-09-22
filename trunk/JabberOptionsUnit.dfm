object JabberOptionsForm: TJabberOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054#1087#1094#1080#1080': Jabber'
  ClientHeight = 413
  ClientWidth = 597
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CancelButton: TBitBtn
    Left = 8
    Top = 380
    Width = 137
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 0
    TabStop = False
    OnClick = CancelButtonClick
  end
  object ApplyButton: TBitBtn
    Left = 369
    Top = 380
    Width = 107
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 1
    TabStop = False
    OnClick = ApplyButtonClick
  end
  object OKButton: TBitBtn
    Left = 482
    Top = 380
    Width = 107
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    TabStop = False
    OnClick = OKButtonClick
  end
  object JabberOptionButtonGroup: TButtonGroup
    Left = 8
    Top = 8
    Width = 137
    Height = 366
    BevelKind = bkTile
    BorderStyle = bsNone
    ButtonHeight = 27
    ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
    Images = MainForm.AllImageList
    Items = <
      item
        Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
        ImageIndex = 41
      end
      item
        Caption = #1057#1077#1088#1074#1077#1088
      end
      item
        Caption = #1055#1088#1086#1082#1089#1080
        ImageIndex = 162
      end
      item
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      end
      item
        Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1088#1086#1089#1090#1077#1088#1086#1084
      end
      item
        Caption = #1052#1086#1103' '#1072#1085#1082#1077#1090#1072
      end
      item
        Caption = #1044#1086#1084
      end
      item
        Caption = #1056#1072#1073#1086#1090#1072
      end
      item
        Caption = #1051#1080#1095#1085#1086#1077
      end
      item
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      end>
    ItemIndex = 0
    TabOrder = 3
    OnButtonClicked = JabberOptionButtonGroupButtonClicked
    OnKeyDown = JabberOptionButtonGroupKeyDown
  end
  object OptionPanel: TPanel
    Left = 151
    Top = 8
    Width = 438
    Height = 366
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 4
    object OptionJvPageList: TJvPageList
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 428
      Height = 356
      ActivePage = AccountPage
      PropagateEnable = False
      ShowDesignCaption = sdcNone
      Align = alClient
      object AccountPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'AccountPage'
        object AccountGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 232
          Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object RegNewAccountLabel: TLabel
            Left = 80
            Top = 176
            Width = 229
            Height = 13
            Cursor = crHandPoint
            Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1101#1090#1091' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnMouseEnter = JIDonserverLabelMouseEnter
            OnMouseLeave = JIDonserverLabelMouseLeave
          end
          object ICQUINLabel: TLabel
            Left = 80
            Top = 25
            Width = 174
            Height = 13
            Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100' (JID@server):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PassLabel: TLabel
            Left = 80
            Top = 75
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
          object DeleteAccountLabel: TLabel
            Left = 80
            Top = 205
            Width = 103
            Height = 13
            Cursor = crHandPoint
            Caption = #1059#1076#1072#1083#1080#1090#1100' '#1072#1082#1082#1072#1091#1085#1090
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnMouseEnter = JIDonserverLabelMouseEnter
            OnMouseLeave = JIDonserverLabelMouseLeave
          end
          object JIDonserverLabel: TLabel
            Left = 263
            Top = 70
            Width = 88
            Height = 13
            Cursor = crHandPoint
            Alignment = taRightJustify
            Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1085#1072'...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnMouseEnter = JIDonserverLabelMouseEnter
            OnMouseLeave = JIDonserverLabelMouseLeave
          end
          object JabberJIDEdit: TEdit
            Left = 78
            Top = 43
            Width = 273
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = JabberSomeEditChange
          end
          object PassEdit: TEdit
            Left = 78
            Top = 93
            Width = 273
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 1
            OnChange = PassEditChange
            OnClick = PassEditClick
          end
          object ShowPassCheckBox: TCheckBox
            Left = 78
            Top = 123
            Width = 331
            Height = 17
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ShowPassCheckBoxClick
          end
          object SavePassCheckBox: TCheckBox
            Left = 78
            Top = 146
            Width = 331
            Height = 17
            Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = JabberSomeEditChange
          end
        end
        object AccountOptionGroupBox: TGroupBox
          Left = 3
          Top = 241
          Width = 422
          Height = 112
          Caption = #1054#1087#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object ResursLabel: TLabel
            Left = 23
            Top = 24
            Width = 38
            Height = 13
            Alignment = taRightJustify
            Caption = #1056#1077#1089#1091#1088#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PrioritetLabel: TLabel
            Left = 263
            Top = 24
            Width = 59
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ResursComboBox: TComboBox
            Left = 67
            Top = 21
            Width = 165
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 13
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = 'IMadering'
            Items.Strings = (
              'IMadering'
              'Home'
              'Work')
          end
          object PrioritetJvSpinEdit: TJvSpinEdit
            Left = 328
            Top = 21
            Width = 62
            Height = 21
            Decimal = 1
            MaxValue = 9999.000000000000000000
            Value = 30.000000000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object ServerPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ServerPage'
        object ConnectionGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Bevel1: TBevel
            Left = 10
            Top = 76
            Width = 403
            Height = 3
            Shape = bsBottomLine
          end
          object JCustomServerHostEdit: TLabeledEdit
            Left = 56
            Top = 45
            Width = 217
            Height = 21
            EditLabel.Width = 27
            EditLabel.Height = 13
            EditLabel.Caption = #1061#1086#1089#1090':'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LabelPosition = lpLeft
            ParentFont = False
            TabOrder = 0
            OnChange = JabberSomeEditChange
          end
          object JCustomServerPortEdit: TLabeledEdit
            Left = 329
            Top = 45
            Width = 65
            Height = 21
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = #1055#1086#1088#1090':'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -11
            EditLabel.Font.Name = 'Tahoma'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LabelPosition = lpLeft
            ParentFont = False
            TabOrder = 1
            OnChange = JabberSomeEditChange
          end
          object JUseCustomServerSettingsCheckBox: TCheckBox
            Left = 16
            Top = 20
            Width = 393
            Height = 17
            Caption = #1042#1088#1091#1095#1085#1091#1102' '#1079#1072#1076#1072#1090#1100' '#1072#1076#1088#1077#1089' '#1080' '#1087#1086#1088#1090' '#1089#1077#1088#1074#1077#1088#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = JUseCustomServerSettingsCheckBoxClick
          end
          object JUseSSLCheckBox: TCheckBox
            Left = 16
            Top = 85
            Width = 393
            Height = 17
            Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' SSL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = JabberSomeEditChange
          end
          object CheckBox1: TCheckBox
            Left = 16
            Top = 108
            Width = 393
            Height = 17
            Caption = #1055#1086#1076#1076#1077#1088#1078#1080#1074#1072#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 4
            OnClick = JabberSomeEditChange
          end
        end
      end
      object ProxyPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ProxyPage'
      end
      object OptionPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'OptionPage'
      end
      object RosterPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'RosterPage'
      end
      object AnketaPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'AnketaPage'
      end
      object HomePage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'HomePage'
      end
      object WorkPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'WorkPage'
      end
      object PersonalPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'PersonalPage'
      end
      object ParamsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ParamsPage'
      end
    end
  end
end
