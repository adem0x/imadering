object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 416
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SettingButtonGroup: TButtonGroup
    Left = 8
    Top = 8
    Width = 137
    Height = 369
    BevelKind = bkTile
    BorderStyle = bsNone
    ButtonHeight = 28
    ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
    Images = MainForm.AllImageList
    Items = <
      item
        Caption = #1054#1073#1097#1080#1077
        ImageIndex = 0
      end
      item
        Caption = #1057#1087#1080#1089#1086#1082' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
        ImageIndex = 1
      end
      item
        Caption = #1054#1082#1085#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
        ImageIndex = 165
      end
      item
        Caption = #1057#1086#1073#1099#1090#1080#1103
        ImageIndex = 133
      end
      item
        Caption = #1048#1089#1090#1086#1088#1080#1103
        ImageIndex = 147
      end
      item
        Caption = #1057#1090#1072#1090#1091#1089#1099
        ImageIndex = 181
      end
      item
        Caption = #1040#1085#1090#1080'-'#1089#1087#1072#1084
        ImageIndex = 170
      end
      item
        Caption = #1047#1074#1091#1082#1080
        ImageIndex = 135
      end
      item
        Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089
        ImageIndex = 182
      end
      item
        Caption = #1043#1086#1088#1103#1095#1080#1077' '#1082#1083#1072#1074#1080#1096#1080
        ImageIndex = 183
      end
      item
        Caption = #1052#1086#1076#1091#1083#1080
        ImageIndex = 184
      end
      item
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
        ImageIndex = 162
      end
      item
        Caption = #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
        ImageIndex = 160
      end>
    ItemIndex = 0
    TabOrder = 0
    OnButtonClicked = SettingButtonGroupButtonClicked
    OnKeyDown = SettingButtonGroupKeyDown
  end
  object PagesPanel: TPanel
    Left = 151
    Top = 8
    Width = 442
    Height = 369
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object JvPageList1: TJvPageList
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 432
      Height = 359
      ActivePage = JvStandardPage1
      PropagateEnable = False
      ShowDesignCaption = sdcNone
      Align = alClient
      object JvStandardPage1: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage1'
        object GeneralOptionGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1054#1073#1097#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object HideInTrayProgramStartCheckBox: TCheckBox
            Left = 14
            Top = 22
            Width = 395
            Height = 17
            Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' '#1089#1074#1077#1088#1085#1091#1090#1086#1081' '#1074' '#1090#1088#1101#1081
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ProxyAddresEditChange
          end
          object StartOnWinStartCheckBox: TCheckBox
            Left = 14
            Top = 45
            Width = 395
            Height = 17
            Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' IMadering '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1089#1080#1089#1090#1077#1084#1099' ('#1090#1086#1083#1100#1082#1086' '#1076#1083#1103' Windows)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ProxyAddresEditChange
          end
          object AutoUpdateCheckBox: TCheckBox
            Left = 14
            Top = 68
            Width = 395
            Height = 17
            Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1085#1086#1074#1086#1081' '#1074#1077#1088#1089#1080#1080' '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ProxyAddresEditChange
          end
        end
      end
      object JvStandardPage2: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage2'
        object CLWindowGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 214
          Height = 149
          Caption = #1054#1082#1085#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object AlwaylTopCheckBox: TCheckBox
            Left = 12
            Top = 19
            Width = 192
            Height = 17
            Caption = #1055#1086#1074#1077#1088#1093' '#1074#1089#1077#1093' '#1086#1082#1086#1085
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ProxyAddresEditChange
          end
          object AutoHideCLCheckBox: TCheckBox
            Left = 12
            Top = 42
            Width = 161
            Height = 17
            Caption = #1040#1074#1090#1086'-'#1089#1082#1088#1099#1090#1080#1077' ('#1089#1077#1082#1091#1085#1076#1099'):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ProxyAddresEditChange
          end
          object AutoHideClEdit: TEdit
            Left = 179
            Top = 40
            Width = 25
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
            Text = '10'
            OnChange = ProxyAddresEditChange
            OnExit = AutoHideClEditExit
            OnKeyPress = AutoHideClEditKeyPress
          end
        end
        object TransparentGroupBox: TGroupBox
          Left = 220
          Top = 0
          Width = 212
          Height = 80
          Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object TransparentTrackBar: TTrackBar
            Left = 3
            Top = 19
            Width = 206
            Height = 26
            Max = 240
            PositionToolTip = ptTop
            ShowSelRange = False
            TabOrder = 0
            TickStyle = tsNone
            OnChange = TransparentTrackBarChange
          end
          object TransparentNotActiveCheckBox: TCheckBox
            Left = 13
            Top = 52
            Width = 188
            Height = 17
            Caption = #1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1085#1077#1072#1082#1090#1080#1074#1085#1086#1075#1086
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ProxyAddresEditChange
          end
        end
        object HeadTextGroupBox: TGroupBox
          Left = 220
          Top = 86
          Width = 212
          Height = 63
          Caption = #1058#1077#1082#1089#1090' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' '#1086#1082#1085#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object HeaderTextEdit: TEdit
            Left = 13
            Top = 25
            Width = 187
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'IMadering'
            OnChange = ProxyAddresEditChange
          end
        end
        object CLOptionsGroupBox: TGroupBox
          Left = 0
          Top = 155
          Width = 432
          Height = 204
          Caption = #1054#1087#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
      end
      object JvStandardPage3: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage3'
        object ChatFormGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1086#1082#1085#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage4: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage4'
        object EventsGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1081' '#1086' '#1089#1086#1073#1099#1090#1080#1103#1093' '#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage6: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage6'
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1048#1089#1090#1086#1088#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage7: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage7'
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1057#1090#1072#1090#1091#1089#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage8: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage8'
        object GroupBox3: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1040#1085#1090#1080'-'#1089#1087#1072#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage9: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage9'
        object GroupBox4: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1047#1074#1091#1082#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage10: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage10'
        object GroupBox7: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage11: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage11'
        object GroupBox8: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1043#1086#1088#1103#1095#1080#1077' '#1082#1083#1072#1074#1080#1096#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage12: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage12'
        object GroupBox9: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1052#1086#1076#1091#1083#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object JvStandardPage5: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage5'
        object GroupBox5: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 247
          Align = alTop
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1095#1077#1088#1077#1079' '#1087#1088#1086#1082#1089#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 12
            Top = 54
            Width = 73
            Height = 13
            Alignment = taRightJustify
            Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1082#1089#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 18
            Top = 81
            Width = 67
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1086#1088#1090' '#1087#1088#1086#1082#1089#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 315
            Top = 54
            Width = 22
            Height = 13
            Alignment = taRightJustify
            Caption = #1058#1080#1087':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 298
            Top = 81
            Width = 39
            Height = 13
            Alignment = taRightJustify
            Caption = #1042#1077#1088#1089#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 51
            Top = 145
            Width = 34
            Height = 13
            Alignment = taRightJustify
            Caption = #1051#1086#1075#1080#1085':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 44
            Top = 172
            Width = 41
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ProxyAddresEdit: TEdit
            Left = 91
            Top = 51
            Width = 207
            Height = 21
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = ProxyAddresEditChange
          end
          object ProxyPortEdit: TEdit
            Left = 91
            Top = 78
            Width = 187
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
            OnChange = ProxyAddresEditChange
          end
          object ProxyTypeComboBox: TComboBox
            Left = 343
            Top = 51
            Width = 73
            Height = 21
            Style = csDropDownList
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ItemIndex = 0
            ParentFont = False
            TabOrder = 2
            Text = 'HTTP'
            Items.Strings = (
              'HTTP'
              'HTTPS'
              'SOCKS 4'
              'SOCKS 4A'
              'SOCKS 5')
          end
          object ProxyVersionComboBox: TComboBox
            Left = 343
            Top = 78
            Width = 73
            Height = 21
            Style = csDropDownList
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ItemIndex = 0
            ParentFont = False
            TabOrder = 3
            Text = '1.0'
            OnChange = ProxyAddresEditChange
            Items.Strings = (
              '1.0'
              '1.1')
          end
          object ProxyAuthCheckBox: TCheckBox
            Left = 91
            Top = 113
            Width = 231
            Height = 17
            Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1085#1072' '#1087#1088#1086#1082#1089#1080
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = ProxyAuthCheckBoxClick
          end
          object ProxyLoginEdit: TEdit
            Left = 91
            Top = 142
            Width = 325
            Height = 21
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = ProxyAddresEditChange
          end
          object ProxyPasswordEdit: TEdit
            Left = 91
            Top = 169
            Width = 325
            Height = 21
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 6
            OnChange = ProxyAddresEditChange
          end
          object ProxyShowPassCheckBox: TCheckBox
            Left = 91
            Top = 196
            Width = 302
            Height = 17
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnClick = ProxyShowPassCheckBoxClick
          end
          object ProxyEnableCheckBox: TCheckBox
            Left = 12
            Top = 23
            Width = 318
            Height = 17
            Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1087#1088#1086#1082#1089#1080' '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = ProxyEnableCheckBoxClick
          end
          object NTLMCheckBox: TCheckBox
            Left = 91
            Top = 219
            Width = 318
            Height = 17
            Caption = 'NTLM '#1072#1091#1090#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1103
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnClick = ProxyAddresEditChange
          end
        end
        object GroupBox6: TGroupBox
          Left = 0
          Top = 247
          Width = 432
          Height = 112
          Align = alClient
          Caption = #1054#1087#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object ReconnectCheckBox: TCheckBox
            Left = 12
            Top = 21
            Width = 389
            Height = 17
            Caption = #1055#1077#1088#1077#1087#1086#1076#1082#1083#1102#1095#1072#1090#1100#1089#1103' '#1087#1088#1080' '#1086#1073#1088#1099#1074#1077' '#1089#1074#1103#1079#1080
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
            OnClick = ProxyAddresEditChange
          end
        end
      end
      object JvStandardPage13: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'JvStandardPage13'
        object ProtocolsGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Caption = #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' ('#1091#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1088#1086#1090#1086#1082#1086#1083#1072#1084#1080')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ProtocolsListView: TListView
            Left = 12
            Top = 20
            Width = 408
            Height = 300
            Checkboxes = True
            Columns = <
              item
                Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
                Width = 404
              end>
            ColumnClick = False
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            SmallImages = MainForm.AllImageList
            TabOrder = 0
            TabStop = False
            ViewStyle = vsReport
            OnClick = ProtocolsListViewClick
            OnDblClick = ProtocolsListViewDblClick
            OnKeyUp = ProtocolsListViewKeyUp
            OnSelectItem = ProtocolsListViewSelectItem
          end
          object AddProtoBitBtn: TBitBtn
            Left = 12
            Top = 326
            Width = 132
            Height = 25
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
            OnClick = AddProtoBitBtnClick
          end
          object SettingsProtoBitBtn: TBitBtn
            Left = 150
            Top = 326
            Width = 132
            Height = 25
            Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnClick = SettingsProtoBitBtnClick
          end
          object DeleteProtoBitBtn: TBitBtn
            Left = 288
            Top = 326
            Width = 132
            Height = 25
            Caption = #1059#1076#1072#1083#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            TabStop = False
            OnClick = DeleteProtoBitBtnClick
          end
        end
      end
    end
  end
  object CancelBitBtn: TBitBtn
    Left = 8
    Top = 383
    Width = 137
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    TabStop = False
    OnClick = CancelBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 472
    Top = 383
    Width = 121
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    TabStop = False
    OnClick = OKBitBtnClick
  end
  object ApplyBitBtn: TBitBtn
    Left = 336
    Top = 383
    Width = 121
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 4
    TabStop = False
    OnClick = ApplyBitBtnClick
  end
end
