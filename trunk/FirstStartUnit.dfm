object FirstStartForm: TFirstStartForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1085#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 246
  ClientWidth = 329
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 207
    Width = 329
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      329
      39)
    object CancelButton: TBitBtn
      Left = 9
      Top = 6
      Width = 88
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 0
      TabStop = False
      OnClick = CancelButtonClick
    end
    object NextButton: TBitBtn
      Left = 232
      Top = 6
      Width = 88
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1044#1072#1083#1077#1077
      Default = True
      TabOrder = 1
      TabStop = False
      OnClick = NextButtonClick
      Layout = blGlyphRight
    end
    object PrevButton: TBitBtn
      Left = 138
      Top = 6
      Width = 88
      Height = 25
      Caption = #1053#1072#1079#1072#1076
      Enabled = False
      TabOrder = 2
      TabStop = False
      OnClick = PrevButtonClick
    end
  end
  object JvPageList1: TJvPageList
    Left = 0
    Top = 0
    Width = 329
    Height = 207
    ActivePage = ICQ_Page
    PropagateEnable = False
    ShowDesignCaption = sdcNone
    Align = alClient
    object ICQ_Page: TJvStandardPage
      Left = 0
      Top = 0
      Width = 329
      Height = 207
      Caption = 'ICQ_Page'
      object ICQIconImage: TImage
        Left = 12
        Top = 9
        Width = 18
        Height = 18
        Center = True
        Transparent = True
      end
      object ICQEnableCheckBox: TCheckBox
        Left = 36
        Top = 9
        Width = 284
        Height = 17
        TabStop = False
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1076#1076#1077#1088#1078#1082#1091' ICQ '#1087#1088#1086#1090#1086#1082#1086#1083#1072
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = ICQEnableCheckBoxClick
      end
      object ICQGroupBox: TGroupBox
        Left = 9
        Top = 32
        Width = 311
        Height = 169
        Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object ICQUINLabel: TLabel
          Left = 11
          Top = 26
          Width = 92
          Height = 13
          Alignment = taRightJustify
          Caption = 'ICQ# '#1080#1083#1080' E-mail:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ICQPassLabel: TLabel
          Left = 57
          Top = 53
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1072#1088#1086#1083#1100':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ICQUINEdit: TEdit
          Left = 109
          Top = 23
          Width = 188
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ICQPassEdit: TEdit
          Left = 109
          Top = 50
          Width = 188
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 1
        end
        object ICQShowPassCheckBox: TCheckBox
          Left = 14
          Top = 82
          Width = 283
          Height = 17
          TabStop = False
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = ICQShowPassCheckBoxClick
        end
        object ICQSavePassCheckBox: TCheckBox
          Left = 14
          Top = 105
          Width = 283
          Height = 17
          TabStop = False
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ICQRegNewUINButton: TButton
          Left = 14
          Top = 133
          Width = 283
          Height = 25
          Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1099#1081' ICQ#'
          TabOrder = 4
          TabStop = False
          OnClick = ICQRegNewUINButtonClick
        end
      end
    end
    object MRA_Page: TJvStandardPage
      Left = 0
      Top = 0
      Width = 329
      Height = 207
      Caption = 'MRA_Page'
      object MRAIconImage: TImage
        Left = 12
        Top = 9
        Width = 18
        Height = 18
        Center = True
        Transparent = True
      end
      object MRAEnableCheckBox: TCheckBox
        Left = 36
        Top = 9
        Width = 284
        Height = 17
        TabStop = False
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1076#1076#1077#1088#1078#1082#1091' MRA '#1087#1088#1086#1090#1086#1082#1086#1083#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = MRAEnableCheckBoxClick
      end
      object MRAGroupBox: TGroupBox
        Left = 9
        Top = 32
        Width = 311
        Height = 169
        Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object MRAEmailLabel: TLabel
          Left = 65
          Top = 26
          Width = 38
          Height = 13
          Alignment = taRightJustify
          Caption = 'E-mail:'
        end
        object MRAPassLabel: TLabel
          Left = 57
          Top = 53
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1072#1088#1086#1083#1100':'
        end
        object MRARegNewEmailLabel: TLabel
          Left = 18
          Top = 136
          Width = 275
          Height = 13
          Cursor = crHandPoint
          Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1099#1081' E-mail '#1085#1072' www.mail.ru'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnMouseEnter = MRARegNewEmailLabelMouseEnter
          OnMouseLeave = MRARegNewEmailLabelMouseLeave
        end
        object MRAEmailEdit: TEdit
          Left = 109
          Top = 23
          Width = 188
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object MRAPassEdit: TEdit
          Left = 109
          Top = 50
          Width = 188
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 1
        end
        object MRAShowPassCheckBox: TCheckBox
          Left = 14
          Top = 82
          Width = 283
          Height = 17
          TabStop = False
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = MRAShowPassCheckBoxClick
        end
        object MRASavePassCheckBox: TCheckBox
          Left = 14
          Top = 105
          Width = 283
          Height = 17
          TabStop = False
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
    end
    object Jabber_Page: TJvStandardPage
      Left = 0
      Top = 0
      Width = 329
      Height = 207
      Caption = 'Jabber_Page'
      object JabberIconImage: TImage
        Left = 12
        Top = 9
        Width = 18
        Height = 18
        Center = True
        Transparent = True
      end
      object JabberEnableCheckBox: TCheckBox
        Left = 36
        Top = 9
        Width = 284
        Height = 17
        TabStop = False
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1076#1076#1077#1088#1078#1082#1091' Jabber '#1087#1088#1086#1090#1086#1082#1086#1083#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = JabberEnableCheckBoxClick
      end
      object JabberGroupBox: TGroupBox
        Left = 9
        Top = 32
        Width = 311
        Height = 169
        Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object JabberIDLabel: TLabel
          Left = 45
          Top = 26
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Jabber ID:'
        end
        object JabberPassLabel: TLabel
          Left = 57
          Top = 53
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1072#1088#1086#1083#1100':'
        end
        object JabberIDEdit: TEdit
          Left = 109
          Top = 23
          Width = 188
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object JabberPassEdit: TEdit
          Left = 109
          Top = 50
          Width = 188
          Height = 21
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          PasswordChar = '*'
          TabOrder = 1
        end
        object JabberShowPassCheckBox: TCheckBox
          Left = 14
          Top = 82
          Width = 283
          Height = 17
          TabStop = False
          Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object JabberSavePassCheckBox: TCheckBox
          Left = 14
          Top = 105
          Width = 283
          Height = 17
          TabStop = False
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object JabberRegNewJIDButton: TButton
          Left = 14
          Top = 133
          Width = 283
          Height = 25
          Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1099#1081' Jabber ID'
          TabOrder = 4
          TabStop = False
        end
      end
    end
  end
end
