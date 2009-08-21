object IcqOptionsForm: TIcqOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054#1087#1094#1080#1080': ICQ'
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
  ScreenSnap = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ICQOptionButtonGroup: TButtonGroup
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
        ImageIndex = 81
      end
      item
        Caption = #1055#1088#1080#1074#1072#1090#1085#1086#1089#1090#1100
        ImageIndex = 170
      end
      item
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        ImageIndex = 171
      end
      item
        Caption = 'ID '#1082#1083#1080#1077#1085#1090#1072
        ImageIndex = 172
      end
      item
        Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
        ImageIndex = 173
      end
      item
        Caption = #1052#1086#1103' '#1072#1085#1082#1077#1090#1072
        ImageIndex = 174
      end
      item
        Caption = #1044#1086#1084
        ImageIndex = 85
      end
      item
        Caption = #1056#1072#1073#1086#1090#1072
        ImageIndex = 175
      end
      item
        Caption = #1051#1080#1095#1085#1086#1077
        ImageIndex = 176
      end
      item
        Caption = #1048#1085#1090#1077#1088#1077#1089#1099
        ImageIndex = 179
      end
      item
        Caption = #1054' '#1089#1077#1073#1077
        ImageIndex = 177
      end
      item
        Caption = #1040#1074#1072#1090#1072#1088
        ImageIndex = 178
      end
      item
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        ImageIndex = 180
      end>
    ItemIndex = 0
    TabOrder = 0
    OnButtonClicked = ICQOptionButtonGroupButtonClicked
    OnKeyDown = ICQOptionButtonGroupKeyDown
  end
  object GeneralPanel: TPanel
    Left = 151
    Top = 8
    Width = 438
    Height = 366
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object ICQOptionsJvPageList: TJvPageList
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 428
      Height = 356
      ActivePage = JvStandardPage1
      PropagateEnable = False
      ShowDesignCaption = sdcNone
      Align = alClient
      object JvStandardPage1: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage1'
        object AccountGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 238
          Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ReqPassLabel: TLabel
            Left = 80
            Top = 173
            Width = 95
            Height = 13
            Cursor = crHandPoint
            Caption = #1047#1072#1073#1099#1083#1080' '#1087#1072#1088#1086#1083#1100'?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = ReqPassLabelClick
            OnMouseEnter = ReqPassLabelMouseEnter
            OnMouseLeave = ReqPassLabelMouseLeave
          end
          object ICQUINLabel: TLabel
            Left = 80
            Top = 25
            Width = 92
            Height = 13
            Caption = 'ICQ# '#1080#1083#1080' E-mail:'
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
          object ICQUINEdit: TEdit
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
            OnChange = ICQUINEditChange
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
            OnChange = ICQUINEditChange
            OnClick = PassEditClick
          end
          object ShowPassCheckBox: TCheckBox
            Left = 78
            Top = 123
            Width = 328
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
            Width = 323
            Height = 17
            Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object RegNewICQUINButton: TButton
            Left = 78
            Top = 200
            Width = 273
            Height = 25
            Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1099#1081' ICQ#'
            TabOrder = 4
            OnClick = RegNewICQUINButtonClick
          end
        end
        object GroupBox1: TGroupBox
          Left = 3
          Top = 247
          Width = 422
          Height = 106
          Caption = #1054#1087#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object ShowHideContactsCheckBox: TCheckBox
            Left = 14
            Top = 21
            Width = 392
            Height = 17
            Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1074#1088#1077#1084#1077#1085#1085#1099#1077' '#1082#1086#1085#1090#1072#1082#1090#1099' ('#1090#1088#1077#1073#1091#1077#1090#1089#1103' '#1087#1077#1088#1077#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077')'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ICQUINEditChange
          end
        end
      end
      object JvStandardPage2: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage2'
        object OtherOptionsGroupBox: TGroupBox
          Left = 3
          Top = 215
          Width = 422
          Height = 138
          Caption = #1054#1087#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ShowAwayTimeCheckBox: TCheckBox
            Left = 16
            Top = 22
            Width = 403
            Height = 17
            Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1082#1086#1085#1090#1072#1082#1090#1072#1084' '#1074#1088#1077#1084#1103' '#1087#1088#1086#1089#1090#1086#1103' '#1080#1083#1080' '#1084#1086#1077#1075#1086' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ICQUINEditChange
          end
          object AutoReqAuthCheckBox: TCheckBox
            Left = 16
            Top = 45
            Width = 403
            Height = 17
            Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1079#1072#1087#1088#1072#1096#1080#1074#1072#1090#1100' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1102' '#1087#1088#1080' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1080' '#1082#1086#1085#1090#1072#1082#1090#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object AuthAndWebStatusGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 101
          Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103' '#1080' Web-'#1089#1090#1072#1090#1091#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object NoAutoAuthRadioButton: TRadioButton
            Left = 16
            Top = 23
            Width = 403
            Height = 17
            Caption = #1047#1072#1087#1088#1072#1096#1080#1074#1072#1090#1100' '#1084#1086#1105' '#1088#1072#1079#1088#1077#1096#1077#1085#1080#1077' '#1085#1072' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ICQUINEditChange
          end
          object YesAutoAuthRadioButton: TRadioButton
            Left = 16
            Top = 46
            Width = 403
            Height = 17
            Caption = #1042#1089#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080' '#1084#1086#1075#1091#1090' '#1076#1086#1073#1072#1074#1083#1103#1090#1100' '#1084#1077#1085#1103' '#1073#1077#1079' '#1088#1072#1079#1088#1077#1096#1077#1085#1080#1103
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ICQUINEditChange
          end
          object ShowWebAwareCheckBox: TCheckBox
            Left = 16
            Top = 72
            Width = 308
            Height = 17
            Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1084#1086#1081' '#1086#1085#1083#1072#1081#1085'-'#1089#1090#1072#1090#1091#1089' '#1076#1083#1103' web '#1080' '#1087#1086#1080#1089#1082#1072
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ICQUINEditChange
          end
          object WebAwareTestButton: TButton
            Left = 330
            Top = 68
            Width = 85
            Height = 25
            Caption = 'Web '#1058#1077#1089#1090
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = WebAwareTestButtonClick
          end
        end
        object PrivatLevelGroupBox: TGroupBox
          Left = 3
          Top = 110
          Width = 422
          Height = 99
          Caption = #1059#1088#1086#1074#1077#1085#1100' '#1087#1088#1080#1074#1072#1090#1085#1086#1089#1090#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object PrivatLevelLabel: TLabel
            Left = 83
            Top = 24
            Width = 39
            Height = 13
            Caption = #1053#1080#1079#1082#1080#1081
          end
          object PrivatLevelInfoLabel: TLabel
            Left = 83
            Top = 45
            Width = 219
            Height = 13
            Caption = #1052#1086#1080' '#1076#1072#1085#1085#1099#1077' '#1073#1091#1076#1091#1090' '#1074#1080#1076#1085#1099' '#1074#1089#1077#1084' '#1082#1086#1085#1090#1072#1082#1090#1072#1084'.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PrivatLevelTrackBar: TTrackBar
            Left = 16
            Top = 17
            Width = 44
            Height = 76
            Enabled = False
            Max = 2
            Orientation = trVertical
            Position = 2
            ShowSelRange = False
            TabOrder = 0
            ThumbLength = 24
            TickMarks = tmBoth
          end
        end
      end
      object JvStandardPage3: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage3'
        object CheckBox5: TCheckBox
          Left = 16
          Top = 377
          Width = 425
          Height = 17
          Caption = 'CheckBox5'
          Enabled = False
          TabOrder = 0
        end
        object CheckAccountGroupBox: TGroupBox
          Left = 3
          Top = 278
          Width = 422
          Height = 75
          Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object CheckAccountLabel: TLabel
            Left = 15
            Top = 20
            Width = 173
            Height = 13
            Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100' ICQ# '#1080#1083#1080' AIM SN:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Edit5: TEdit
            Left = 14
            Top = 38
            Width = 292
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object CheckAccountButton: TButton
            Left = 312
            Top = 36
            Width = 99
            Height = 25
            Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object CustomICQPacketGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 269
          Caption = #1054#1090#1089#1099#1083#1082#1072' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1086#1075#1086' '#1087#1072#1082#1077#1090#1072' '#1076#1072#1085#1085#1099#1093
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object CustomICQPacketInfoMemo: TMemo
            Left = 13
            Top = 21
            Width = 396
            Height = 52
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Lines.Strings = (
              #1042#1085#1080#1084#1072#1085#1080#1077'! '#1069#1090#1072' '#1092#1091#1085#1082#1094#1080#1103' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085#1072' '#1076#1083#1103' '#1086#1095#1077#1085#1100' '#1086#1087#1099#1090#1085#1099#1093' '
              
                #1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'. '#1048#1089#1087#1086#1083#1100#1079#1091#1081#1090#1077' '#1077#1105' '#1090#1086#1083#1100#1082#1086' '#1077#1089#1083#1080' '#1074#1099' '#1090#1086#1095#1085#1086' '#1079#1085#1072#1077#1090#1077', '#1095#1090#1086' '#1074 +
                #1099' '
              #1076#1077#1083#1072#1077#1090#1077'. '#1055#1086#1089#1083#1077#1076#1089#1090#1074#1080#1103' '#1084#1086#1075#1091#1090' '#1073#1099#1090#1100' '#1085#1077#1087#1088#1077#1076#1089#1082#1072#1079#1091#1077#1084#1099#1077'.')
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object SendCustomICQPacketButton: TButton
            Left = 13
            Top = 236
            Width = 88
            Height = 25
            Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = SendCustomICQPacketButtonClick
          end
          object SendCustomICQPacketRichEdit: TRichEdit
            Left = 13
            Top = 79
            Width = 396
            Height = 151
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            HideScrollBars = False
            ParentFont = False
            PlainText = True
            ScrollBars = ssVertical
            TabOrder = 2
          end
          object SendCustomICQPaketTimerCheckBox: TCheckBox
            Left = 111
            Top = 240
            Width = 259
            Height = 17
            Caption = #1055#1086#1074#1090#1086#1088#1103#1090#1100' '#1086#1090#1087#1088#1072#1074#1082#1091' '#1074' '#1094#1080#1082#1083#1077' ('#1089#1077#1082#1091#1085#1076#1099'):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object SendCustomICQPaketTimerEdit: TEdit
            Left = 376
            Top = 238
            Width = 33
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 4
            Text = '10'
            OnExit = SendCustomICQPaketTimerEditExit
            OnKeyPress = SendCustomICQPaketTimerEditKeyPress
          end
        end
      end
      object JvStandardPage4: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage4'
        object ClientIDGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1103' '#1082#1083#1080#1077#1085#1090#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ClientIDLabel: TLabel
            Left = 15
            Top = 115
            Width = 153
            Height = 13
            Caption = #1044#1086#1089#1090#1091#1087#1085#1099#1077' '#1080#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088#1099':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientProtoVerLabel: TLabel
            Left = 15
            Top = 170
            Width = 94
            Height = 13
            Caption = 'ClientProtoVerLabel'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientCapsLabel: TLabel
            Left = 15
            Top = 233
            Width = 355
            Height = 13
            Caption = #1047#1076#1077#1089#1100' '#1084#1086#1078#1085#1086' '#1076#1086#1073#1072#1074#1080#1090#1100' '#1089#1074#1086#1080' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1082#1083#1080#1077#1085#1090#1072' ('#1076#1086' 16 '#1079#1085#1072#1082#1086#1074'):'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientVersionLabel: TLabel
            Left = 233
            Top = 115
            Width = 84
            Height = 13
            Caption = #1042#1077#1088#1089#1080#1103' '#1082#1083#1080#1077#1085#1090#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientIDInfoMemo: TMemo
            Left = 13
            Top = 21
            Width = 396
            Height = 76
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Lines.Strings = (
              #1042#1085#1080#1084#1072#1085#1080#1077'! '#1069#1090#1080' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085#1099' '#1076#1083#1103' '#1086#1087#1099#1090#1085#1099#1093' '
              #1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'. '#1045#1089#1083#1080' '#1074#1099' '#1085#1077' '#1079#1085#1072#1077#1090#1077', '#1095#1090#1086' '#1101#1090#1086' '#1090#1072#1082#1086#1077', '#1087#1086#1078#1072#1083#1091#1081#1089#1090#1072', '
              #1086#1089#1090#1072#1074#1100#1090#1077' '#1074#1089#1105' '#1082#1072#1082' '#1077#1089#1090#1100'. '#1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1080#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088#1072' '#1082#1083#1080#1077#1085#1090#1072' '#1084#1086#1078#1077#1090' '
              #1089#1076#1077#1083#1072#1090#1100' '#1085#1077#1076#1086#1089#1090#1091#1087#1085#1099#1084#1080' '#1085#1077#1082#1086#1090#1086#1088#1099#1077' '#1092#1091#1085#1082#1094#1080#1080', '#1074#1082#1083#1102#1095#1072#1103' '#1087#1077#1088#1077#1076#1072#1095#1091' '
              #1092#1072#1081#1083#1086#1074', '#1080#1083#1080' '#1089#1090#1072#1090#1100' '#1087#1088#1080#1095#1080#1085#1086#1081' '#1085#1077#1089#1090#1072#1073#1080#1083#1100#1085#1086#1081' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'.')
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            OnMouseMove = ClientIDInfoMemoMouseMove
          end
          object ClientIDComboBox: TComboBox
            Left = 13
            Top = 134
            Width = 204
            Height = 21
            AutoDropDown = True
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ItemIndex = 0
            ParentFont = False
            TabOrder = 1
            Text = 'IMadering'
            Items.Strings = (
              'IMadering')
          end
          object ClientProtoVerEdit: TEdit
            Left = 14
            Top = 189
            Width = 204
            Height = 21
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Text = '9'
          end
          object ClientCaps1Edit: TEdit
            Left = 13
            Top = 251
            Width = 396
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ClientCaps2Edit: TEdit
            Left = 13
            Top = 284
            Width = 396
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object ClientCaps3Edit: TEdit
            Left = 13
            Top = 317
            Width = 396
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object ClientVersionEdit: TEdit
            Left = 232
            Top = 134
            Width = 177
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
        end
      end
      object JvStandardPage5: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage5'
        object PassChangeGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object RetypeNewPassLabel: TLabel
            Left = 113
            Top = 233
            Width = 147
            Height = 13
            Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NewPassChangeLabel: TLabel
            Left = 113
            Top = 179
            Width = 76
            Height = 13
            Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ReqPassChangeLabel: TLabel
            Left = 113
            Top = 150
            Width = 95
            Height = 13
            Cursor = crHandPoint
            Caption = #1047#1072#1073#1099#1083#1080' '#1087#1072#1088#1086#1083#1100'?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = ReqPassLabelClick
            OnMouseEnter = ReqPassLabelMouseEnter
            OnMouseLeave = ReqPassLabelMouseLeave
          end
          object CurrentPassChangeLabel: TLabel
            Left = 113
            Top = 104
            Width = 88
            Height = 13
            Caption = #1058#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ChangePassButton: TButton
            Left = 112
            Top = 309
            Width = 207
            Height = 25
            Caption = #1057#1084#1077#1085#1080#1090#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ChangePassButtonClick
          end
          object ShowPassChangeCheckBox: TCheckBox
            Left = 112
            Top = 279
            Width = 296
            Height = 17
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ShowPassChangeCheckBoxClick
          end
          object RetypeNewPassEdit: TEdit
            Left = 112
            Top = 252
            Width = 207
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 2
          end
          object NewPassChangeEdit: TEdit
            Left = 112
            Top = 198
            Width = 207
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 3
          end
          object CurrentPassChangeEdit: TEdit
            Left = 112
            Top = 123
            Width = 207
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 4
          end
          object PassChangeInfoMemo: TMemo
            Left = 14
            Top = 21
            Width = 394
            Height = 68
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Lines.Strings = (
              #1044#1083#1103' '#1089#1084#1077#1085#1099' '#1087#1072#1088#1086#1083#1103', '#1074#1072#1084' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1074#1077#1089#1090#1080' '#1090#1077#1082#1091#1097#1080#1081' '#1087#1072#1088#1086#1083#1100' '#1080' '#1085#1086#1074#1099#1081' '
              #1087#1072#1088#1086#1083#1100' '#1076#1074#1072#1078#1076#1099'. '#1053#1072#1089#1090#1086#1103#1090#1077#1083#1100#1085#1086' '#1088#1077#1082#1086#1084#1077#1085#1076#1091#1077#1090#1089#1103' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1074' '#1085#1086#1074#1086#1084' '
              #1087#1072#1088#1086#1083#1077' '#1082#1086#1084#1073#1080#1085#1072#1094#1080#1102' '#1094#1080#1092#1088' '#1080' '#1073#1091#1082#1074' '#1083#1072#1090#1080#1085#1089#1082#1086#1075#1086' '#1072#1083#1092#1072#1074#1080#1090#1072'. '#1044#1083#1080#1085#1072' '#1087#1072#1088#1086#1083#1103' '
              #1076#1086#1083#1078#1085#1072' '#1073#1099#1090#1100' '#1074' '#1087#1088#1077#1076#1077#1083#1072#1093' '#1086#1090' 6 '#1076#1086' 8 '#1089#1080#1084#1074#1086#1083#1086#1074'.')
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
        end
      end
      object JvStandardPage6: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage6'
        object MyInfoNameGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 121
          Caption = #1048#1084#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object FamilyInfoLabel: TLabel
            Left = 220
            Top = 18
            Width = 48
            Height = 13
            Caption = #1060#1072#1084#1080#1083#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NameInfoLabel: TLabel
            Left = 16
            Top = 69
            Width = 23
            Height = 13
            Caption = #1048#1084#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NickInfoLabel: TLabel
            Left = 16
            Top = 18
            Width = 23
            Height = 13
            Caption = #1053#1080#1082':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ConnectTimeInfoLabel: TLabel
            Left = 220
            Top = 69
            Width = 107
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object FamilyInfoEdit: TEdit
            Left = 219
            Top = 37
            Width = 188
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 0
          end
          object NameInfoEdit: TEdit
            Left = 15
            Top = 88
            Width = 188
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 1
          end
          object NickInfoEdit: TEdit
            Left = 15
            Top = 37
            Width = 188
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 2
          end
          object ConnectTimeInfoEdit: TEdit
            Left = 219
            Top = 88
            Width = 188
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object EmailsInfoGroupBox: TGroupBox
          Left = 3
          Top = 130
          Width = 422
          Height = 223
          Caption = #1048#1085#1092#1086':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object EmailInfo1Label: TLabel
            Left = 16
            Top = 19
            Width = 41
            Height = 13
            Caption = 'E-mail 1:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SpeedButton1: TSpeedButton
            Left = 370
            Top = 85
            Width = 23
            Height = 22
            Flat = True
          end
          object SpeedButton4: TSpeedButton
            Left = 370
            Top = 131
            Width = 23
            Height = 22
            Flat = True
          end
          object SpeedButton5: TSpeedButton
            Left = 370
            Top = 176
            Width = 23
            Height = 22
            Flat = True
          end
          object EmailInfo2Label: TLabel
            Left = 16
            Top = 70
            Width = 41
            Height = 13
            Caption = 'E-mail 2:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EmailInfo3Label: TLabel
            Left = 16
            Top = 121
            Width = 41
            Height = 13
            Caption = 'E-mail 3:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object RegDateInfoLabel: TLabel
            Left = 220
            Top = 19
            Width = 97
            Height = 13
            Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SendMessInfoLabel: TLabel
            Left = 220
            Top = 70
            Width = 154
            Height = 13
            Caption = #1042#1089#1077#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1086':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object InMessInfoLabel: TLabel
            Left = 220
            Top = 121
            Width = 142
            Height = 13
            Caption = #1042#1089#1077#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '#1087#1086#1083#1091#1095#1077#1085#1086':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ExternalIPInfoLabel: TLabel
            Left = 16
            Top = 171
            Width = 94
            Height = 13
            Caption = #1042#1085#1077#1096#1085#1080#1081' IP '#1072#1076#1088#1077#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LastTimeInfoLabel: TLabel
            Left = 220
            Top = 171
            Width = 134
            Height = 13
            Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EmailInfo1Edit: TEdit
            Left = 15
            Top = 38
            Width = 188
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 0
          end
          object EmailInfo2Edit: TEdit
            Left = 15
            Top = 90
            Width = 188
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 1
          end
          object EmailInfo3Edit: TEdit
            Left = 15
            Top = 140
            Width = 188
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 2
          end
          object RegDateInfoEdit: TEdit
            Left = 219
            Top = 38
            Width = 188
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object SendMessInfoEdit: TEdit
            Left = 219
            Top = 89
            Width = 188
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object InMessInfoEdit: TEdit
            Left = 219
            Top = 140
            Width = 188
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object ExternalIPInfoEdit: TEdit
            Left = 15
            Top = 190
            Width = 188
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object LastTimeInfoEdit: TEdit
            Left = 219
            Top = 190
            Width = 188
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
        end
      end
      object JvStandardPage7: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage7'
        object OriginalInfoGroupBox: TGroupBox
          Left = 3
          Top = 233
          Width = 422
          Height = 120
          Caption = #1052#1077#1089#1090#1086' '#1088#1086#1078#1076#1077#1085#1080#1103':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object OCountryInfoLabel: TLabel
            Left = 16
            Top = 20
            Width = 41
            Height = 13
            Caption = #1057#1090#1088#1072#1085#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OCityInfoLabel: TLabel
            Left = 16
            Top = 69
            Width = 35
            Height = 13
            Caption = #1043#1086#1088#1086#1076':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OAreaInfoLabel: TLabel
            Left = 237
            Top = 20
            Width = 47
            Height = 13
            Caption = #1054#1073#1083#1072#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OCountryInfoComboBox: TComboBox
            Left = 15
            Top = 39
            Width = 204
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
          end
          object OCityInfoEdit: TEdit
            Left = 15
            Top = 88
            Width = 204
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 1
          end
          object OAreaInfoEdit: TEdit
            Left = 236
            Top = 39
            Width = 171
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
          end
        end
        object HomeInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 224
          Caption = #1044#1086#1084#1072#1096#1085#1080#1081' '#1072#1076#1088#1077#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object CountryInfoLabel: TLabel
            Left = 16
            Top = 20
            Width = 41
            Height = 13
            Caption = #1057#1090#1088#1072#1085#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CityInfoLabel: TLabel
            Left = 16
            Top = 70
            Width = 35
            Height = 13
            Caption = #1043#1086#1088#1086#1076':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object AreaInfoLabel: TLabel
            Left = 16
            Top = 121
            Width = 47
            Height = 13
            Caption = #1054#1073#1083#1072#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ZipInfoLabel: TLabel
            Left = 134
            Top = 121
            Width = 41
            Height = 13
            Caption = #1048#1085#1076#1077#1082#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object StreetInfoLabel: TLabel
            Left = 16
            Top = 172
            Width = 35
            Height = 13
            Caption = #1040#1076#1088#1077#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PhoneInfoLabel: TLabel
            Left = 237
            Top = 20
            Width = 48
            Height = 13
            Caption = #1058#1077#1083#1077#1092#1086#1085':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object FaxInfoLabel: TLabel
            Left = 237
            Top = 70
            Width = 29
            Height = 13
            Caption = #1060#1072#1082#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CelularInfoLabel: TLabel
            Left = 237
            Top = 121
            Width = 49
            Height = 13
            Caption = #1057#1086#1090#1086#1074#1099#1081':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CityInfoEdit: TEdit
            Left = 15
            Top = 89
            Width = 204
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 0
          end
          object AreaInfoEdit: TEdit
            Left = 15
            Top = 140
            Width = 95
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
          end
          object ZipInfoEdit: TEdit
            Left = 133
            Top = 140
            Width = 86
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 2
          end
          object StreetInfoEdit: TEdit
            Left = 15
            Top = 191
            Width = 392
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 3
          end
          object PhoneInfoEdit: TEdit
            Left = 236
            Top = 39
            Width = 171
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 4
          end
          object FaxInfoEdit: TEdit
            Left = 236
            Top = 89
            Width = 171
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 5
          end
          object CelularInfoEdit: TEdit
            Left = 236
            Top = 140
            Width = 171
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 6
          end
          object CountryInfoComboBox: TComboBox
            Left = 16
            Top = 39
            Width = 204
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 7
            Items.Strings = (
              ''
              #1040#1074#1089#1090#1088#1072#1083#1080#1103
              #1040#1074#1089#1090#1088#1080#1103
              #1040#1079#1077#1088#1073#1072#1081#1076#1078#1072#1085
              #1040#1083#1073#1072#1085#1080#1103
              #1040#1083#1078#1080#1088
              #1040#1085#1075#1080#1083#1072
              #1040#1085#1075#1086#1083#1072
              #1040#1085#1076#1086#1088#1088#1072
              #1040#1085#1090#1080#1075#1091#1072
              #1040#1085#1090#1080#1075#1091#1072' '#1080' '#1041#1072#1088#1073#1091#1076#1072
              #1040#1085#1090#1080#1083#1100#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1040#1085#1090#1080#1083#1100#1089#1082#1080#1077' '#1086'-'#1074#1072' ('#1053#1080#1076#1077#1088#1083#1072#1085#1076#1099')'
              #1040#1085#1090#1080#1083#1100#1089#1082#1080#1077' '#1086'-'#1074#1072' ('#1060#1088#1072#1085#1094#1080#1103')'
              #1040#1088#1075#1077#1085#1090#1080#1085#1072
              #1040#1088#1084#1077#1085#1080#1103
              #1040#1088#1091#1073#1072
              #1040#1092#1075#1072#1085#1080#1089#1090#1072#1085
              #1041#1072#1075#1072#1084#1099
              #1041#1072#1085#1075#1083#1072#1076#1077#1096
              #1041#1072#1088#1073#1072#1076#1086#1089
              #1041#1072#1088#1073#1091#1076#1072', '#1086'.'
              #1041#1072#1093#1088#1077#1081#1085
              #1041#1077#1083#1072#1088#1091#1089#1100
              #1041#1077#1083#1080#1079
              #1041#1077#1083#1100#1075#1080#1103
              #1041#1077#1085#1080#1085
              #1041#1077#1088#1084#1091#1076#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1041#1086#1083#1075#1072#1088#1080#1103
              #1041#1086#1083#1080#1074#1080#1103
              #1041#1086#1089#1085#1080#1103' '#1080' '#1043#1077#1088#1094#1077#1075#1086#1074#1080#1085#1072
              #1041#1086#1090#1089#1074#1072#1085#1072
              #1041#1088#1072#1079#1080#1083#1080#1103
              #1041#1088#1091#1085#1077#1081
              #1041#1091#1088#1082#1080#1085#1072' '#1060#1072#1089#1086
              #1041#1091#1088#1091#1085#1076#1080
              #1041#1091#1090#1072#1085
              #1042#1072#1085#1091#1072#1090#1091
              #1042#1072#1090#1080#1082#1072#1085
              #1042#1077#1083#1080#1082#1086#1073#1088#1080#1090#1072#1085#1080#1103
              #1042#1077#1085#1075#1088#1080#1103
              #1042#1077#1085#1077#1089#1091#1101#1083#1072
              #1042#1080#1088#1075#1080#1085#1089#1082#1080#1077' '#1086'-'#1074#1072' ('#1042#1077#1083#1080#1082#1086#1073#1088#1080#1090#1072#1085#1080#1103')'
              #1042#1080#1088#1075#1080#1085#1089#1082#1080#1077' '#1086'-'#1074#1072' ('#1057#1064#1040')'
              #1042#1086#1079#1085#1077#1089#1077#1085#1080#1103', '#1086'.'
              #1042#1086#1089#1090#1086#1095#1085#1086#1077' '#1057#1072#1084#1086#1072
              #1042#1100#1077#1090#1085#1072#1084
              #1043#1072#1073#1086#1085
              #1043#1072#1080#1090#1080
              #1043#1072#1084#1073#1080#1103
              #1043#1072#1085#1072
              #1043#1074#1072#1076#1077#1083#1091#1087#1072
              #1043#1074#1072#1090#1077#1084#1072#1083#1072
              #1043#1074#1080#1072#1085#1072
              #1043#1074#1080#1085#1077#1103
              #1043#1074#1080#1085#1077#1103'-'#1041#1080#1089#1089#1072#1091
              #1043#1077#1088#1084#1072#1085#1080#1103
              #1043#1080#1073#1088#1072#1083#1090#1072#1088
              #1043#1086#1085#1076#1091#1088#1072#1089
              #1043#1086#1085#1082#1086#1085#1075' ('#1057#1103#1085#1075#1072#1085')'
              #1043#1088#1077#1085#1072#1076#1072
              #1043#1088#1077#1085#1083#1072#1085#1076#1080#1103
              #1043#1088#1077#1094#1080#1103
              #1043#1088#1091#1079#1080#1103
              #1043#1091#1072#1084
              #1044#1072#1085#1080#1103
              #1044#1078#1080#1073#1091#1090#1080
              #1044#1080#1077#1075#1086' '#1043#1072#1088#1089#1080#1103
              #1044#1086#1084#1080#1085#1080#1082#1072
              #1044#1086#1084#1080#1085#1080#1082#1072#1085#1089#1082#1072#1103' '#1056#1077#1089#1087#1091#1073#1083#1080#1082#1072
              #1045#1075#1080#1087#1077#1090
              #1047#1072#1084#1073#1080#1103
              #1047#1072#1087#1072#1076#1085#1086#1077' '#1057#1072#1084#1086#1072
              #1047#1080#1084#1073#1072#1073#1074#1077
              #1048#1079#1088#1072#1080#1083#1100
              #1048#1085#1076#1080#1103
              #1048#1085#1076#1086#1085#1077#1079#1080#1103
              #1048#1086#1088#1076#1072#1085#1080#1103
              #1048#1088#1072#1082
              #1048#1088#1072#1085
              #1048#1088#1083#1072#1085#1076#1080#1103
              #1048#1089#1083#1072#1085#1076#1080#1103
              #1048#1089#1087#1072#1085#1080#1103
              #1048#1090#1072#1083#1080#1103
              #1049#1077#1084#1077#1085
              #1050#1072#1079#1072#1093#1089#1090#1072#1085
              #1050#1072#1081#1084#1072#1085#1086#1074#1099' '#1086'-'#1074#1072
              #1050#1072#1084#1073#1086#1076#1078#1072
              #1050#1072#1084#1077#1088#1091#1085
              #1050#1072#1085#1072#1076#1072
              #1050#1072#1085#1072#1088#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1050#1072#1087#1086'-'#1042#1077#1088#1076#1077
              #1050#1072#1090#1072#1088
              #1050#1077#1085#1080#1103
              #1050#1080#1083#1080#1085#1075', '#1086'-'#1074#1072
              #1050#1080#1087#1088
              #1050#1080#1088#1075#1080#1079#1080#1103
              #1050#1080#1088#1080#1073#1072#1090#1080
              #1050#1080#1090#1072#1081
              #1050#1086#1082#1086#1089#1086#1074#1099#1077'-'#1050#1080#1083#1080#1085#1075' '#1086'-'#1074#1072
              #1050#1086#1083#1091#1084#1073#1080#1103
              #1050#1086#1084#1086#1088#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1050#1086#1085#1075#1086
              #1050#1086#1085#1075#1086' ('#1047#1072#1080#1088')'
              #1050#1086#1089#1090#1072'-'#1056#1080#1082#1072
              #1050#1086#1090'-'#1076#39#1048#1074#1091#1072#1088
              #1050#1091#1073#1072
              #1050#1091#1074#1077#1081#1090
              #1050#1091#1082#1072', '#1086'-'#1074#1072
              #1051#1072#1086#1089
              #1051#1072#1090#1074#1080#1103
              #1051#1077#1089#1086#1090#1086
              #1051#1080#1073#1077#1088#1080#1103
              #1051#1080#1074#1072#1085
              #1051#1080#1074#1080#1103
              #1051#1080#1090#1074#1072
              #1051#1080#1093#1090#1077#1085#1096#1090#1077#1081#1085
              #1051#1102#1082#1089#1077#1084#1073#1091#1088#1075
              #1052#1072#1074#1088#1080#1082#1080#1081
              #1052#1072#1074#1088#1080#1090#1072#1085#1080#1103
              #1052#1072#1076#1072#1075#1072#1089#1082#1072#1088
              #1052#1072#1081#1086#1090#1090
              #1052#1072#1082#1072#1086
              #1052#1072#1082#1077#1076#1086#1085#1080#1103
              #1052#1072#1083#1072#1074#1080
              #1052#1072#1083#1072#1081#1079#1080#1103
              #1052#1072#1083#1080
              #1052#1072#1083#1100#1076#1080#1074#1089#1082#1072#1103' '#1056#1077#1089#1087#1091#1073#1083#1080#1082#1072
              #1052#1072#1083#1100#1090#1072
              #1052#1072#1088#1086#1082#1082#1086
              #1052#1072#1088#1090#1080#1085#1080#1082#1072
              #1052#1072#1088#1096#1072#1083#1083#1086#1074#1099' '#1086'-'#1074#1072
              #1052#1077#1082#1089#1080#1082#1072
              #1052#1080#1082#1088#1086#1085#1077#1079#1080#1103
              #1052#1086#1079#1072#1084#1073#1080#1082
              #1052#1086#1083#1076#1072#1074#1080#1103
              #1052#1086#1085#1072#1082#1086
              #1052#1086#1085#1075#1086#1083#1080#1103
              #1052#1086#1085#1090#1089#1077#1088#1088#1072#1090
              #1052#1100#1103#1085#1084#1072' ('#1041#1080#1088#1084#1072')'
              #1053#1072#1084#1080#1073#1080#1103
              #1053#1072#1091#1088#1091
              #1053#1077#1074#1080#1089
              #1053#1077#1080#1079#1074#1077#1089#1090#1085#1072#1103
              #1053#1077#1087#1072#1083
              #1053#1080#1075#1077#1088
              #1053#1080#1075#1077#1088#1080#1103
              #1053#1080#1076#1077#1088#1083#1072#1085#1076#1099
              #1053#1080#1082#1072#1088#1072#1075#1091#1072
              #1053#1080#1091#1101
              #1053#1086#1074#1072#1103' '#1047#1077#1083#1072#1085#1076#1080#1103
              #1053#1086#1074#1072#1103' '#1050#1072#1083#1077#1076#1086#1085#1080#1103
              #1053#1086#1088#1074#1077#1075#1080#1103
              #1053#1086#1088#1092#1086#1083#1082', '#1086'.'
              #1054#1073#1098#1077#1076#1080#1085#1077#1085#1085#1099#1077' '#1040#1088#1072#1073#1089#1082#1080#1077' '#1069#1084#1080#1088#1072#1090#1099
              #1054#1084#1072#1085
              #1055#1072#1082#1080#1089#1090#1072#1085
              #1055#1072#1083#1072#1091
              #1055#1072#1085#1072#1084#1072
              #1055#1072#1087#1091#1072' '#1053#1086#1074#1072#1103' '#1043#1074#1080#1085#1077#1103
              #1055#1072#1088#1072#1075#1074#1072#1081
              #1055#1077#1088#1091
              #1055#1086#1083#1100#1096#1072
              #1055#1086#1088#1090#1091#1075#1072#1083#1080#1103
              #1055#1091#1101#1088#1090#1086'-'#1056#1080#1082#1086
              #1056#1077#1102#1085#1100#1086#1085
              #1056#1086#1078#1076#1077#1089#1090#1074#1072', '#1086'.'
              #1056#1086#1089#1089#1080#1103
              #1056#1086#1090#1072', '#1086'.'
              #1056#1091#1072#1085#1076#1072
              #1056#1091#1084#1099#1085#1080#1103
              #1057#1072#1081#1087#1072#1085', '#1086'.'
              #1057#1072#1083#1100#1074#1072#1076#1086#1088
              #1057#1072#1085'-'#1052#1072#1088#1080#1085#1086
              #1057#1072#1085'-'#1058#1086#1084#1077' '#1080' '#1055#1088#1080#1085#1089#1080#1087#1080
              #1057#1072#1091#1076#1086#1074#1089#1082#1072#1103' '#1040#1088#1072#1074#1080#1103
              #1057#1074'. '#1045#1083#1077#1085#1099', '#1086'.'
              #1057#1074#1072#1079#1080#1083#1077#1085#1076
              #1057#1077#1074#1077#1088#1085#1072#1103' '#1050#1086#1088#1077#1103' ('#1050#1053#1044#1056')'
              #1057#1077#1081#1096#1077#1083#1100#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1057#1077#1085#1077#1075#1072#1083
              #1057#1077#1085'-'#1055#1100#1077#1088' '#1080' '#1052#1080#1082#1077#1083#1086#1085
              #1057#1077#1085#1090'-'#1042#1080#1085#1089#1077#1085#1090' '#1080' '#1043#1088#1077#1085#1072#1076#1080#1085#1099
              #1057#1077#1085#1090'-'#1050#1088#1080#1089#1090#1086#1092#1077#1088
              #1057#1077#1085#1090'-'#1050#1088#1080#1089#1090#1086#1092#1077#1088' '#1080' '#1053#1077#1074#1080#1089', '#1086'-'#1074#1072
              #1057#1077#1085#1090'-'#1051#1102#1089#1080#1103
              #1057#1077#1088#1073#1080#1103
              #1057#1080#1085#1075#1072#1087#1091#1088
              #1057#1080#1088#1080#1103
              #1057#1083#1086#1074#1072#1082#1080#1103
              #1057#1083#1086#1074#1077#1085#1080#1103
              #1057#1086#1083#1086#1084#1086#1085#1086#1074#1099' '#1086'-'#1074#1072
              #1057#1086#1084#1072#1083#1080
              #1057#1091#1076#1072#1085
              #1057#1091#1088#1080#1085#1072#1084
              #1057#1064#1040
              #1057#1100#1077#1088#1088#1072'-'#1051#1077#1086#1085#1077
              #1058#1072#1076#1078#1080#1082#1080#1089#1090#1072#1085
              #1058#1072#1080#1083#1072#1085#1076
              #1058#1072#1081#1074#1072#1085#1100
              #1058#1072#1085#1079#1072#1085#1080#1103
              #1058#1077#1088#1082#1089' '#1080' '#1050#1072#1081#1082#1086#1089', '#1086'-'#1074#1072
              #1058#1080#1085#1080#1072#1085', '#1086'.'
              #1058#1086#1075#1086
              #1058#1086#1082#1077#1083#1072#1091
              #1058#1086#1085#1075#1072
              #1058#1088#1080#1085#1080#1076#1072#1076' '#1080' '#1058#1086#1073#1072#1075#1086
              #1058#1091#1074#1072#1083#1091
              #1058#1091#1085#1080#1089
              #1058#1091#1088#1082#1084#1077#1085#1080#1089#1090#1072#1085
              #1058#1091#1088#1094#1080#1103
              #1059#1075#1072#1085#1076#1072
              #1059#1079#1073#1077#1082#1080#1089#1090#1072#1085
              #1059#1082#1088#1072#1080#1085#1072
              #1059#1086#1083#1083#1080#1089' '#1080' '#1060#1091#1090#1091#1085#1072', '#1086'-'#1074#1072
              #1059#1088#1091#1075#1074#1072#1081
              #1059#1101#1083#1100#1089
              #1060#1072#1088#1077#1088#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1060#1080#1076#1078#1080
              #1060#1080#1083#1080#1087#1087#1080#1085#1099
              #1060#1080#1085#1083#1103#1085#1076#1080#1103
              #1060#1086#1083#1082#1083#1077#1085#1076#1089#1082#1080#1077' '#1086'-'#1074#1072
              #1060#1088#1072#1085#1094#1080#1103
              #1060#1088#1072#1085#1094#1091#1079#1089#1082#1072#1103' '#1043#1074#1080#1072#1085#1072
              #1060#1088#1072#1085#1094#1091#1079#1089#1082#1072#1103' '#1055#1086#1083#1080#1085#1077#1079#1080#1103
              #1061#1086#1088#1074#1072#1090#1080#1103
              #1062#1077#1085#1090#1088#1072#1083#1100#1085#1086'-'#1040#1092#1088#1080#1082#1072#1085#1089#1082#1072#1103' '#1056#1077#1089#1087#1091#1073#1083#1080#1082#1072
              #1063#1072#1076
              #1063#1077#1088#1085#1086#1075#1086#1088#1080#1103
              #1063#1077#1093#1080#1103
              #1063#1080#1083#1080
              #1064#1074#1077#1081#1094#1072#1088#1080#1103
              #1064#1074#1077#1094#1080#1103
              #1064#1086#1090#1083#1072#1085#1076#1080#1103
              #1064#1088#1080'-'#1051#1072#1085#1082#1072
              #1069#1082#1074#1072#1076#1086#1088
              #1069#1082#1074#1072#1090#1086#1088#1080#1072#1083#1100#1085#1072#1103' '#1043#1074#1080#1085#1077#1103
              #1069#1088#1080#1090#1088#1077#1103
              #1069#1089#1090#1086#1085#1080#1103
              #1069#1092#1080#1086#1087#1080#1103
              #1070#1040#1056
              #1070#1075#1086#1089#1083#1072#1074#1080#1103
              #1070#1078#1085#1072#1103' '#1050#1086#1088#1077#1103
              #1071#1084#1072#1081#1082#1072
              #1071#1087#1086#1085#1080#1103)
          end
          object CountryCodesComboBox: TComboBox
            Left = 134
            Top = 12
            Width = 86
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 8
            Visible = False
            Items.Strings = (
              '0'
              '61'
              '43'
              '994'
              '355'
              '213'
              '101'
              '244'
              '376'
              '102'
              '1021'
              '5902'
              '599'
              '5901'
              '54'
              '374'
              '297'
              '93'
              '103'
              '880'
              '104'
              '120'
              '973'
              '375'
              '501'
              '32'
              '229'
              '105'
              '359'
              '591'
              '387'
              '267'
              '55'
              '673'
              '226'
              '257'
              '975'
              '678'
              '379'
              '44'
              '36'
              '58'
              '106'
              '123'
              '247'
              '684'
              '84'
              '241'
              '509'
              '220'
              '233'
              '590'
              '502'
              '592'
              '224'
              '245'
              '49'
              '350'
              '504'
              '852'
              '111'
              '299'
              '30'
              '995'
              '671'
              '45'
              '253'
              '246'
              '109'
              '110'
              '20'
              '260'
              '685'
              '263'
              '972'
              '91'
              '62'
              '962'
              '964'
              '98'
              '353'
              '354'
              '34'
              '39'
              '967'
              '705'
              '108'
              '855'
              '237'
              '107'
              '178'
              '238'
              '974'
              '254'
              '6102'
              '357'
              '706'
              '686'
              '86'
              '6101'
              '57'
              '2691'
              '242'
              '243'
              '506'
              '225'
              '53'
              '965'
              '682'
              '856'
              '371'
              '266'
              '231'
              '961'
              '218'
              '370'
              '4101'
              '352'
              '230'
              '222'
              '261'
              '269'
              '853'
              '389'
              '265'
              '60'
              '223'
              '960'
              '356'
              '212'
              '596'
              '692'
              '52'
              '691'
              '258'
              '373'
              '377'
              '976'
              '113'
              '95'
              '264'
              '674'
              '114'
              '9999'
              '977'
              '227'
              '234'
              '31'
              '505'
              '683'
              '64'
              '687'
              '47'
              '6722'
              '971'
              '968'
              '92'
              '680'
              '507'
              '675'
              '595'
              '51'
              '48'
              '351'
              '121'
              '262'
              '672'
              '7'
              '6701'
              '250'
              '40'
              '670'
              '503'
              '378'
              '239'
              '966'
              '290'
              '268'
              '850'
              '248'
              '221'
              '508'
              '116'
              '115'
              '1141'
              '122'
              '381'
              '65'
              '963'
              '4201'
              '386'
              '677'
              '252'
              '249'
              '597'
              '1'
              '232'
              '708'
              '66'
              '886'
              '255'
              '118'
              '6702'
              '228'
              '690'
              '676'
              '117'
              '688'
              '216'
              '709'
              '90'
              '256'
              '711'
              '380'
              '681'
              '598'
              '441'
              '298'
              '679'
              '63'
              '358'
              '500'
              '33'
              '594'
              '689'
              '385'
              '236'
              '235'
              '382'
              '42'
              '56'
              '41'
              '46'
              '442'
              '94'
              '593'
              '240'
              '291'
              '372'
              '251'
              '27'
              '3811'
              '82'
              '112'
              '81')
          end
        end
      end
      object JvStandardPage8: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage8'
        object WorkInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 174
          Caption = #1056#1072#1073#1086#1095#1080#1081' '#1072#1076#1088#1077#1089
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object WorkCountryInfoLabel: TLabel
            Left = 15
            Top = 19
            Width = 41
            Height = 13
            Caption = #1057#1090#1088#1072#1085#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkCityInfoLabel: TLabel
            Left = 15
            Top = 68
            Width = 35
            Height = 13
            Caption = #1043#1086#1088#1086#1076':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkAreaInfoLabel: TLabel
            Left = 15
            Top = 118
            Width = 47
            Height = 13
            Caption = #1054#1073#1083#1072#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkZipInfoLabel: TLabel
            Left = 135
            Top = 118
            Width = 41
            Height = 13
            Caption = #1048#1085#1076#1077#1082#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkPhoneInfoLabel: TLabel
            Left = 237
            Top = 19
            Width = 48
            Height = 13
            Caption = #1058#1077#1083#1077#1092#1086#1085':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkFaxInfoLabel: TLabel
            Left = 237
            Top = 68
            Width = 29
            Height = 13
            Caption = #1060#1072#1082#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkStreetInfoLabel: TLabel
            Left = 237
            Top = 118
            Width = 35
            Height = 13
            Caption = #1040#1076#1088#1077#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkCityInfoEdit: TEdit
            Left = 14
            Top = 87
            Width = 206
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 0
          end
          object WorkAreaInfoEdit: TEdit
            Left = 14
            Top = 137
            Width = 95
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
          end
          object WorkZipInfoEdit: TEdit
            Left = 134
            Top = 137
            Width = 86
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 2
          end
          object WorkPhoneInfoEdit: TEdit
            Left = 236
            Top = 38
            Width = 170
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 3
          end
          object WorkFaxInfoEdit: TEdit
            Left = 236
            Top = 87
            Width = 170
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 4
          end
          object WorkStreetInfoEdit: TEdit
            Left = 236
            Top = 137
            Width = 170
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 5
          end
          object WorkCountryInfoComboBox: TComboBox
            Left = 14
            Top = 38
            Width = 206
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 6
          end
        end
        object CompanyInfoGroupBox: TGroupBox
          Left = 3
          Top = 183
          Width = 422
          Height = 170
          Caption = #1050#1086#1084#1087#1072#1085#1080#1103
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object CompanyNameInfoLabel: TLabel
            Left = 15
            Top = 20
            Width = 52
            Height = 13
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyCabInfoLabel: TLabel
            Left = 15
            Top = 69
            Width = 37
            Height = 13
            Caption = #1054#1090#1076#1077#1083':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyProfInfoLabel: TLabel
            Left = 237
            Top = 20
            Width = 59
            Height = 13
            Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyMasteInfoLabel: TLabel
            Left = 237
            Top = 69
            Width = 61
            Height = 13
            Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanySiteInfoLabel: TLabel
            Left = 15
            Top = 119
            Width = 49
            Height = 13
            Caption = #1042#1077#1073'-'#1089#1072#1081#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyNameInfoEdit: TEdit
            Left = 14
            Top = 39
            Width = 206
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 0
          end
          object CompanyCabInfoEdit: TEdit
            Left = 14
            Top = 88
            Width = 206
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 1
          end
          object CompanyProfInfoComboBox: TComboBox
            Left = 236
            Top = 39
            Width = 170
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 2
            Items.Strings = (
              ''
              #1057#1077#1083#1100#1089#1082#1086#1077' '#1093#1086#1079#1103#1081#1089#1090#1074#1086
              #1048#1089#1082#1091#1089#1089#1090#1074#1086
              #1048#1085#1078#1077#1085#1077#1088#1085#1086'-'#1090#1077#1093#1085#1080#1095#1077#1089#1082#1080#1081' '#1087#1077#1088#1089#1086#1085#1072#1083
              #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083#1100#1089#1082#1080#1077' '#1058#1086#1074#1072#1088#1099
              #1050#1086#1088#1087#1086#1088#1072#1090#1080#1074#1085#1099#1077' '#1059#1089#1083#1091#1075#1080
              #1054#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
              #1060#1080#1085#1072#1085#1089#1099
              #1055#1088#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086
              #1050#1086#1084#1087#1100#1102#1090#1077#1088#1099
              #1070#1088#1080#1089#1087#1088#1091#1076#1077#1085#1094#1080#1103
              #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086
              #1056#1072#1079#1074#1083#1077#1095#1077#1085#1080#1103
              #1052#1077#1076#1080#1094#1080#1085#1072' '#1080' '#1079#1076#1088#1072#1074#1086#1086#1093#1088#1072#1085#1077#1085#1080#1077
              #1053#1077#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103
              #1055#1091#1090#1077#1096#1077#1089#1090#1074#1080#1103' & '#1056#1072#1079#1074#1083#1077#1095#1077#1085#1080#1103
              #1057#1092#1077#1088#1072' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103
              #1058#1088#1072#1085#1089#1087#1086#1088#1090#1080#1088#1086#1074#1082#1072
              #1055#1088#1086#1095#1080#1077' '#1091#1089#1083#1091#1075#1080)
          end
          object CompanyMasteInfoEdit: TEdit
            Left = 236
            Top = 88
            Width = 170
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 3
          end
          object CompanySiteInfoEdit: TEdit
            Left = 14
            Top = 138
            Width = 392
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 80
            ParentFont = False
            TabOrder = 4
          end
          object OccupationCodeComboBox: TComboBox
            Left = 351
            Top = 13
            Width = 55
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 5
            Visible = False
            Items.Strings = (
              '0'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19')
          end
        end
      end
      object JvStandardPage9: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage9'
        object PersonalInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1051#1080#1095#1085#1086#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object PersonalGenderInfoLabel: TLabel
            Left = 15
            Top = 20
            Width = 23
            Height = 13
            Caption = #1055#1086#1083':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalMaritalInfoLabel: TLabel
            Left = 137
            Top = 20
            Width = 28
            Height = 13
            Caption = #1041#1088#1072#1082':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SpeedButton3: TSpeedButton
            Left = 368
            Top = 86
            Width = 23
            Height = 22
            Flat = True
          end
          object PersonalHomePageInfoLabel: TLabel
            Left = 137
            Top = 72
            Width = 106
            Height = 13
            Caption = #1044#1086#1084#1072#1096#1085#1103#1103' '#1089#1090#1088#1072#1085#1080#1094#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalBirthDayInfoLabel: TLabel
            Left = 15
            Top = 127
            Width = 80
            Height = 13
            Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object HoroImage: TImage
            Left = 376
            Top = 141
            Width = 32
            Height = 32
          end
          object PersonalAgeInfoLabel: TLabel
            Left = 15
            Top = 181
            Width = 44
            Height = 13
            Caption = #1042#1086#1079#1088#1072#1089#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalDayInfoLabel: TLabel
            Left = 29
            Top = 151
            Width = 30
            Height = 13
            Alignment = taRightJustify
            Caption = #1044#1077#1085#1100':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalMonInfoLabel: TLabel
            Left = 150
            Top = 151
            Width = 35
            Height = 13
            Alignment = taRightJustify
            Caption = #1052#1077#1089#1103#1094':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalYearInfoLabel: TLabel
            Left = 281
            Top = 151
            Width = 23
            Height = 13
            Alignment = taRightJustify
            Caption = #1043#1086#1076':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalChildrenInfoLabel: TLabel
            Left = 15
            Top = 72
            Width = 30
            Height = 13
            Caption = #1044#1077#1090#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalReligionInfoLabel: TLabel
            Left = 137
            Top = 181
            Width = 45
            Height = 13
            Caption = #1056#1077#1083#1080#1075#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalHeightInfoLabel: TLabel
            Left = 15
            Top = 234
            Width = 27
            Height = 13
            Caption = #1056#1086#1089#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalSmokInfoLabel: TLabel
            Left = 137
            Top = 234
            Width = 47
            Height = 13
            Caption = #1050#1091#1088#1077#1085#1080#1077':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalSexInfoLabel: TLabel
            Left = 137
            Top = 288
            Width = 133
            Height = 13
            Caption = #1057#1077#1082#1089#1091#1072#1083#1100#1085#1072#1103' '#1086#1088#1080#1077#1085#1090#1072#1094#1080#1103':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalHairColourInfoLabel: TLabel
            Left = 15
            Top = 288
            Width = 62
            Height = 13
            Caption = #1062#1074#1077#1090' '#1074#1086#1083#1086#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalGenderInfoComboBox: TComboBox
            Left = 14
            Top = 39
            Width = 107
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            Items.Strings = (
              ''
              #1046#1077#1085#1089#1082#1080#1081
              #1052#1091#1078#1089#1082#1086#1081)
          end
          object PersonalMaritalInfoComboBox: TComboBox
            Left = 136
            Top = 39
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 1
            Items.Strings = (
              ''
              #1061#1086#1083#1086#1089#1090'/'#1085#1077' '#1079#1072#1084#1091#1078#1077#1084
              #1042' '#1089#1077#1088#1100#1105#1079#1085#1099#1093' '#1086#1090#1085#1086#1096#1077#1085#1080#1103#1093
              #1055#1086#1084#1086#1083#1074#1083#1077#1085'('#1072')/'#1086#1073#1088#1091#1095#1077#1085'('#1072')'
              #1046#1077#1085#1072#1090'/'#1079#1072#1084#1091#1078#1077#1084
              #1056#1072#1079#1074#1077#1076#1077#1085'('#1072')'
              #1056#1072#1079#1086#1096#1083#1080#1089#1100
              #1042#1076#1086#1074#1077#1094'/'#1074#1076#1086#1074#1072
              #1054#1090#1082#1088#1099#1090#1099#1081' '#1073#1088#1072#1082
              #1044#1088#1091#1075#1086#1077)
          end
          object PersonalHomePageInfoEdit: TEdit
            Left = 136
            Top = 91
            Width = 272
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 2
          end
          object PersonalYearInfoEdit: TEdit
            Left = 310
            Top = 147
            Width = 49
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 3
          end
          object PersonalAgeInfoEdit: TEdit
            Left = 14
            Top = 200
            Width = 107
            Height = 21
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object PersonalChildrenInfoComboBox: TComboBox
            Left = 14
            Top = 91
            Width = 107
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 5
            Items.Strings = (
              ''
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              #1041#1086#1083#1077#1077', '#1095#1077#1084' 8'
              #1053#1077#1090)
          end
          object PersonalReligionInfoComboBox: TComboBox
            Left = 136
            Top = 200
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 6
            Items.Strings = (
              ''
              #1040#1075#1085#1086#1089#1090#1080#1095#1077#1089#1082#1072#1103
              #1040#1090#1077#1080#1089#1090#1080#1095#1077#1089#1082#1072#1103
              #1041#1077#1093#1072#1080#1089#1090#1080#1095#1077#1089#1082#1072#1103
              #1041#1091#1076#1076#1080#1081#1089#1082#1072#1103
              #1044#1078#1072#1081#1085
              #1044#1088#1091#1075#1072#1103
              #1044#1091#1093#1086#1074#1085#1072#1103', '#1085#1086' '#1085#1077' '#1088#1077#1083#1080#1075#1080#1086#1079#1085#1072#1103
              #1045#1074#1088#1077#1081#1089#1082#1072#1103
              #1047#1086#1088#1086#1072#1089#1090#1088#1080#1081#1089#1082#1072#1103
              #1052#1086#1088#1084#1086#1085#1089#1082#1072#1103
              #1052#1091#1089#1091#1083#1100#1084#1072#1085#1089#1082#1072#1103
              #1053#1077#1086'-'#1087#1072#1075#1072#1085#1080#1089#1090#1089#1082#1072#1103
              #1056#1072#1089#1090#1072#1092#1072#1088#1080#1072#1085#1089#1090#1074#1086
              #1057#1080#1082#1093
              #1057#1080#1085#1090#1086
              #1059#1085#1080#1090#1072#1088#1080#1077#1074
              #1061#1080#1085#1076#1091
              #1061#1088#1080#1089#1090#1080#1072#1085#1089#1082#1072#1103)
          end
          object PersonalDayInfoComboBox: TComboBox
            Left = 65
            Top = 147
            Width = 56
            Height = 21
            Style = csDropDownList
            DropDownCount = 18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 7
            Items.Strings = (
              ''
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19'
              '20'
              '21'
              '22'
              '23'
              '24'
              '25'
              '26'
              '27'
              '28'
              '29'
              '30'
              '31')
          end
          object PersonalMonInfoComboBox: TComboBox
            Left = 191
            Top = 147
            Width = 56
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 8
            Items.Strings = (
              ''
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12')
          end
          object PersonalHeightInfoComboBox: TComboBox
            Left = 14
            Top = 253
            Width = 107
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 9
            Items.Strings = (
              ''
              '140cm'
              '141-145cm'
              '146-150cm'
              '151-155cm'
              '156-160cm'
              '161-165cm'
              '166-170cm'
              '171-175cm'
              '176-180cm'
              '181-185cm'
              '186-190cm'
              '191-195cm'
              '196-200cm'
              '201-205cm'
              '206-210cm'
              '220cm')
          end
          object PersonalSmokInfoComboBox: TComboBox
            Left = 136
            Top = 253
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 10
            Items.Strings = (
              ''
              #1053#1077#1090
              #1048#1085#1086#1075#1076#1072
              #1044#1072
              #1041#1088#1086#1089#1072#1102
              #1054#1073#1097#1077#1089#1090#1074#1077#1085#1085#1099#1081' '#1082#1091#1088#1080#1083#1100#1097#1080#1082
              #1044#1088#1091#1075#1086#1077)
          end
          object PersonalSexInfoComboBox: TComboBox
            Left = 136
            Top = 307
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 11
            Items.Strings = (
              ''
              #1053#1086#1088#1084#1072#1083#1100#1085#1072#1103
              #1043#1077#1081
              #1051#1077#1089#1073#1080#1103#1085#1082#1072
              #1041#1080'-'#1089#1077#1082#1089#1091#1072#1083#1100#1085#1072#1103
              #1044#1088#1091#1075#1072#1103)
          end
          object PersonalHairColourInfoComboBox: TComboBox
            Left = 14
            Top = 307
            Width = 107
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 12
            Items.Strings = (
              ''
              #1041#1077#1083#1099#1081
              #1041#1083#1086#1085#1076#1080#1085'/'#1041#1083#1086#1085#1076#1080#1085#1082#1072
              #1044#1088#1091#1075#1086#1081
              #1050#1072#1096#1090#1072#1085#1086#1074#1099#1081
              #1050#1088#1072#1089#1085#1099#1081
              #1051#1099#1089#1099#1081
              #1055#1077#1088#1077#1084#1077#1085#1085#1099#1081
              #1057#1074#1077#1090#1083#1086' '#1082#1086#1088#1080#1095#1085#1077#1074#1099#1081
              #1057#1077#1088#1099#1081
              #1058#1105#1084#1085#1086' '#1082#1086#1088#1080#1095#1085#1077#1074#1099#1081
              #1063#1077#1088#1085#1099#1081)
          end
          object MaritalCodesComboBox: TComboBox
            Left = 352
            Top = 12
            Width = 56
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 13
            Visible = False
            Items.Strings = (
              '0'
              '10'
              '11'
              '12'
              '20'
              '30'
              '31'
              '40'
              '50'
              '255')
          end
          object HairColourCodesComboBox: TComboBox
            Left = 65
            Top = 280
            Width = 56
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 14
            Visible = False
            Items.Strings = (
              '0'
              '9'
              '4'
              '12'
              '2'
              '7'
              '10'
              '11'
              '5'
              '8'
              '6'
              '3')
          end
          object ReligionCodesComboBox: TComboBox
            Left = 352
            Top = 173
            Width = 56
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 15
            Visible = False
            Items.Strings = (
              '0'
              '2'
              '3'
              '4'
              '5'
              '8'
              '19'
              '16'
              '9'
              '18'
              '11'
              '10'
              '12'
              '13'
              '15'
              '14'
              '17'
              '7'
              '6')
          end
          object SmokCodesComboBox: TComboBox
            Left = 352
            Top = 226
            Width = 56
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 16
            Visible = False
            Items.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5'
              '128')
          end
          object SexCodesComboBox: TComboBox
            Left = 352
            Top = 280
            Width = 56
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 17
            Visible = False
            Items.Strings = (
              '0'
              '2'
              '3'
              '5'
              '4'
              '10')
          end
        end
      end
      object JvStandardPage10: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage10'
        object LangsInfoGroupBox: TGroupBox
          Left = 3
          Top = 142
          Width = 422
          Height = 59
          Caption = #1042#1083#1072#1076#1077#1085#1080#1077' '#1103#1079#1099#1082#1072#1084#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Lang1InfoComboBox: TComboBox
            Left = 11
            Top = 24
            Width = 129
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            Items.Strings = (
              ''
              #1040#1079#1077#1088#1073#1072#1081#1076#1078#1072#1085#1089#1082#1080#1081
              #1040#1083#1073#1072#1085#1089#1082#1080#1081
              #1040#1085#1075#1083#1080#1081#1089#1082#1080#1081
              #1040#1088#1072#1073#1089#1082#1080#1081
              #1040#1088#1084#1103#1085#1089#1082#1080#1081
              #1040#1092#1088#1080#1082#1072#1072#1085#1089
              #1041#1077#1083#1086#1088#1091#1089#1089#1082#1080#1081
              #1041#1080#1088#1084#1072#1085#1089#1082#1080#1081
              #1041#1086#1083#1075#1072#1088#1089#1082#1080#1081
              #1041#1086#1089#1085#1080#1081#1089#1082#1080#1081
              #1041#1093#1086#1076#1078#1087#1091#1088#1080
              #1042#1072#1083#1083#1080#1081#1089#1082#1080#1081
              #1042#1077#1085#1075#1077#1088#1089#1082#1080#1081
              #1042#1100#1077#1090#1085#1072#1084#1089#1082#1080#1081
              #1043#1072#1101#1083#1100#1089#1082#1080#1081
              #1043#1086#1083#1083#1072#1085#1076#1089#1082#1080#1081
              #1043#1088#1077#1095#1077#1089#1082#1080#1081
              #1043#1091#1076#1078#1072#1088#1072#1090#1080
              #1044#1072#1090#1089#1082#1080#1081
              #1048#1074#1088#1080#1090
              #1048#1076#1080#1096
              #1048#1085#1076#1086#1085#1077#1079#1080#1081#1089#1082#1080#1081
              #1048#1089#1083#1072#1085#1076#1089#1082#1080#1081
              #1048#1089#1087#1072#1085#1089#1082#1080#1081
              #1048#1090#1072#1083#1100#1103#1085#1089#1082#1080#1081
              #1049#1086#1088#1091#1073#1072
              #1050#1072#1085#1090#1086#1085#1089#1082#1080#1081
              #1050#1072#1090#1072#1083#1072#1085#1089#1082#1080#1081
              #1050#1080#1090#1072#1081#1089#1082#1080#1081
              #1050#1086#1088#1077#1081#1089#1082#1080#1081
              #1050#1091#1088#1076#1089#1082#1080#1081
              #1050#1093#1084#1077#1088#1089#1082#1080#1081
              #1051#1072#1086#1089#1089#1082#1080#1081
              #1051#1072#1090#1099#1096#1089#1082#1080#1081
              #1051#1080#1090#1086#1074#1089#1082#1080#1081
              #1052#1072#1082#1077#1076#1086#1085#1089#1082#1080#1081
              #1052#1072#1083#1072#1081#1089#1082#1080#1081
              #1052#1072#1085#1076#1072#1088#1080#1085#1089#1082#1080#1081
              #1052#1086#1085#1075#1086#1083#1100#1089#1082#1080#1081
              #1053#1077#1080#1079#1074#1077#1089#1090#1085#1099#1081
              #1053#1077#1084#1077#1094#1082#1080#1081
              #1053#1086#1088#1074#1077#1078#1089#1082#1080#1081
              #1055#1072#1085#1076#1078#1072#1073#1080
              #1055#1077#1088#1089#1080#1076#1089#1082#1080#1081
              #1055#1086#1083#1100#1089#1082#1080#1081
              #1055#1086#1088#1090#1091#1075#1072#1083#1100#1089#1082#1080#1081
              #1056#1091#1084#1099#1085#1089#1082#1080#1081
              #1056#1091#1089#1089#1082#1080#1081
              #1057#1077#1088#1073#1089#1082#1080#1081
              #1057#1080#1085#1076#1093#1080
              #1057#1083#1086#1074#1072#1094#1082#1080#1081
              #1057#1083#1086#1074#1077#1085#1089#1082#1080#1081
              #1057#1086#1084#1072#1083#1080#1081#1089#1082#1080#1081
              #1057#1091#1072#1093#1080#1083#1080
              #1058#1072#1075#1072#1083#1086#1075
              #1058#1072#1081#1074#1072#1085#1100#1089#1082#1080#1081
              #1058#1072#1081#1089#1082#1080#1081
              #1058#1072#1084#1080#1083#1100#1089#1082#1080#1081
              #1058#1072#1090#1072#1088#1089#1082#1080#1081
              #1058#1091#1088#1077#1094#1082#1080#1081
              #1059#1082#1088#1072#1080#1085#1089#1082#1080#1081
              #1059#1088#1076#1091
              #1060#1072#1088#1089#1080
              #1060#1080#1085#1089#1082#1080#1081
              #1060#1088#1072#1085#1094#1091#1079#1089#1082#1080#1081
              #1061#1080#1085#1076#1080
              #1061#1086#1088#1074#1072#1090#1089#1082#1080#1081
              #1063#1072#1084#1086#1088#1088#1086
              #1063#1077#1096#1089#1082#1080#1081
              #1064#1074#1077#1076#1089#1082#1080#1081
              #1069#1089#1087#1077#1088#1072#1085#1090#1086
              #1069#1089#1090#1086#1085#1089#1082#1080#1081
              #1071#1087#1086#1085#1089#1082#1080#1081)
          end
          object Lang2InfoComboBox: TComboBox
            Left = 146
            Top = 24
            Width = 130
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 1
          end
          object Lang3InfoComboBox: TComboBox
            Left = 282
            Top = 24
            Width = 129
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 2
          end
          object LangsCodeComboBox: TComboBox
            Left = 162
            Top = 13
            Width = 87
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 3
            Visible = False
            Items.Strings = (
              '0'
              '68'
              '58'
              '12'
              '1'
              '59'
              '55'
              '72'
              '4'
              '3'
              '56'
              '2'
              '67'
              '23'
              '52'
              '18'
              '11'
              '20'
              '70'
              '10'
              '21'
              '53'
              '25'
              '24'
              '43'
              '26'
              '54'
              '5'
              '6'
              '7'
              '29'
              '69'
              '28'
              '30'
              '31'
              '32'
              '65'
              '33'
              '63'
              '62'
              '255'
              '19'
              '34'
              '60'
              '57'
              '35'
              '36'
              '37'
              '38'
              '39'
              '66'
              '40'
              '41'
              '42'
              '44'
              '46'
              '64'
              '48'
              '71'
              '47'
              '49'
              '50'
              '51'
              '15'
              '16'
              '17'
              '22'
              '8'
              '61'
              '9'
              '45'
              '13'
              '14'
              '27')
          end
        end
        object InterestInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 133
          Caption = #1048#1085#1090#1077#1088#1077#1089#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Interest1InfoComboBox: TComboBox
            Left = 11
            Top = 19
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 0
            Items.Strings = (
              ''
              '50-'#1077' '#1075#1086#1076#1099
              '60-'#1077' '#1075#1086#1076#1099
              '70-'#1077' '#1075#1086#1076#1099
              '80-'#1077' '#1075#1086#1076#1099
              'ICQ - '#1057#1087#1088#1072#1074#1082#1072
              #1040#1074#1090#1086#1084#1072#1090#1080#1079#1072#1094#1080#1103' '#1074' '#1073#1099#1090#1091
              #1040#1074#1090#1086#1084#1086#1073#1080#1083#1080' '
              #1040#1089#1090#1088#1086#1085#1086#1084#1080#1103
              #1040#1091#1076#1080#1086' '#1080' '#1074#1080#1076#1077#1086
              #1041#1080#1079#1085#1077#1089
              #1041#1080#1079#1085#1077#1089'-'#1091#1089#1083#1091#1075#1080
              #1042#1077#1073'-'#1076#1080#1079#1072#1081#1085
              #1042#1077#1095#1077#1088#1080#1085#1082#1080
              #1042#1080#1076#1099' '#1089#1087#1086#1088#1090#1072
              #1042#1086#1089#1087#1080#1090#1072#1085#1080#1077' '#1076#1077#1090#1077#1081
              #1043#1086#1089#1091#1076#1072#1088#1089#1090#1074#1086' '#1080' '#1074#1083#1072#1089#1090#1100
              #1044#1086#1084#1072#1096#1085#1080#1077' '#1078#1080#1074#1086#1090#1085#1099#1077' '
              #1046#1077#1085#1097#1080#1085#1099
              #1047#1072#1085#1103#1090#1080#1103' '#1085#1072' '#1089#1074#1077#1078#1077#1084' '#1074#1086#1079#1076#1091#1093#1077
              #1048#1075#1088#1099
              #1048#1079#1076#1072#1090#1077#1083#1100#1089#1082#1086#1077' '#1076#1077#1083#1086
              #1048#1085#1090#1077#1088#1085#1077#1090
              #1048#1089#1082#1091#1089#1089#1090#1074#1086
              #1050#1072#1090#1072#1083#1086#1075' '#1076#1083#1103' '#1079#1072#1082#1072#1079#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1087#1086' '#1087#1086#1095#1090#1077
              #1050#1080#1085#1086' '#1080' '#1090#1077#1083#1077#1074#1080#1076#1077#1085#1080#1077
              #1050#1086#1083#1083#1077#1082#1094#1080#1080
              #1050#1086#1084#1087#1100#1102#1090#1077#1088#1099
              #1050#1086#1089#1084#1086#1089
              #1050#1088#1072#1089#1086#1090#1072' '#1080' '#1079#1076#1086#1088#1086#1074#1100#1077
              #1050#1091#1083#1100#1090#1091#1088#1072
              #1051#1102#1073#1080#1084#1099#1077' '#1079#1072#1085#1103#1090#1080#1103
              #1052#1072#1075#1072#1079#1080#1085#1099
              #1052#1077#1076#1080#1072
              #1052#1080#1089#1090#1080#1094#1080#1079#1084
              #1052#1091#1079#1099#1082#1072
              #1053#1072#1091#1082#1072' '#1080' '#1090#1077#1093#1085#1080#1082#1072
              #1053#1086#1074#1086#1089#1090#1080' '#1080' '#1057#1052#1048
              #1054#1073#1097#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1085#1072#1091#1082#1080
              #1054#1076#1077#1078#1076#1072' '#1080' '#1084#1086#1076#1072
              #1055#1086#1090#1088#1077#1073#1080#1090#1077#1083#1100#1089#1082#1072#1103' '#1101#1083#1077#1082#1090#1088#1086#1085#1080#1082#1072
              #1055#1088#1086#1092#1077#1089#1089#1080#1080' '#1080' '#1088#1077#1084#1077#1089#1083#1072
              #1055#1091#1090#1077#1096#1077#1089#1090#1074#1080#1103
              #1056#1072#1079#1074#1083#1077#1095#1077#1085#1080#1103
              #1056#1077#1083#1080#1075#1080#1103
              #1057#1090#1080#1083#1100' '#1078#1080#1079#1085#1080
              #1058#1086#1074#1072#1088#1099' '#1076#1083#1103' '#1076#1086#1084#1072
              #1060#1072#1085#1072#1090#1099' '#1079#1085#1072#1084#1077#1085#1080#1090#1086#1089#1090#1077#1081
              #1060#1080#1079#1082#1091#1083#1100#1090#1091#1088#1072' '#1080' '#1089#1087#1086#1088#1090
              #1060#1080#1085#1072#1085#1089#1099' '#1080' '#1082#1086#1088#1087#1086#1088#1072#1094#1080#1080
              #1060#1080#1090#1085#1077#1089
              #1069#1082#1086#1083#1086#1075#1080#1103)
          end
          object Interest2InfoComboBox: TComboBox
            Left = 11
            Top = 46
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 1
          end
          object Interest3InfoComboBox: TComboBox
            Left = 11
            Top = 73
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 2
          end
          object Interest4InfoComboBox: TComboBox
            Left = 11
            Top = 100
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 0
            ParentFont = False
            TabOrder = 3
          end
          object Interest1InfoEdit: TEdit
            Left = 162
            Top = 19
            Width = 249
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 4
          end
          object Interest2InfoEdit: TEdit
            Left = 162
            Top = 46
            Width = 249
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 5
          end
          object Interest3InfoEdit: TEdit
            Left = 162
            Top = 73
            Width = 249
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 6
          end
          object Interest4InfoEdit: TEdit
            Left = 162
            Top = 100
            Width = 249
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 7
          end
          object InterestsCodesComboBox: TComboBox
            Left = 44
            Top = 59
            Width = 73
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
            Visible = False
            Items.Strings = (
              '0'
              '137'
              '134'
              '135'
              '136'
              '109'
              '150'
              '101'
              '128'
              '147'
              '125'
              '146'
              '121'
              '131'
              '120'
              '115'
              '124'
              '116'
              '132'
              '114'
              '107'
              '149'
              '110'
              '100'
              '145'
              '112'
              '103'
              '104'
              '129'
              '142'
              '105'
              '108'
              '141'
              '143'
              '126'
              '113'
              '118'
              '123'
              '133'
              '130'
              '140'
              '119'
              '127'
              '139'
              '117'
              '111'
              '144'
              '102'
              '148'
              '138'
              '106'
              '122')
          end
        end
      end
      object JvStandardPage11: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage11'
        object AboutInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1054' '#1089#1077#1073#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object AboutInfoRichEdit: TRichEdit
            Left = 14
            Top = 22
            Width = 393
            Height = 313
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            HideScrollBars = False
            ParentFont = False
            PlainText = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object JvStandardPage12: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage12'
        object AvatarInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1040#1074#1072#1090#1072#1088
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object AvatarInfoPanel: TPanel
            Left = 168
            Top = 120
            Width = 100
            Height = 100
            BevelKind = bkTile
            BevelOuter = bvNone
            TabOrder = 0
            object AvatarInfoImage: TImage
              Left = 0
              Top = 0
              Width = 96
              Height = 96
              Align = alClient
              Center = True
              Proportional = True
              ExplicitLeft = 8
              ExplicitWidth = 105
              ExplicitHeight = 81
            end
          end
        end
      end
      object JvStandardPage13: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'JvStandardPage13'
        object ParamInfoGroupBox: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 350
          Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1086#1085#1083#1072#1081#1085' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ParamInfoRichEdit: TRichEdit
            Left = 14
            Top = 22
            Width = 394
            Height = 313
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            HideScrollBars = False
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
    end
  end
  object ApplyButton: TBitBtn
    Left = 369
    Top = 380
    Width = 107
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 2
    TabStop = False
    OnClick = ApplyButtonClick
  end
  object CancelButton: TBitBtn
    Left = 8
    Top = 380
    Width = 137
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    TabStop = False
    OnClick = CancelButtonClick
  end
  object OKButton: TBitBtn
    Left = 482
    Top = 380
    Width = 107
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    TabStop = False
    OnClick = OKButtonClick
  end
  object SendCustomICQPaketTimer: TTimer
    Enabled = False
    OnTimer = SendCustomICQPaketTimerTimer
    Left = 184
    Top = 379
  end
end
