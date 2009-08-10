object MraOptionsForm: TMraOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054#1087#1094#1080#1080': Mail.ru Agent'
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
  end
  object MRAOptionButtonGroup: TButtonGroup
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
      end>
    ItemIndex = 0
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 151
    Top = 8
    Width = 438
    Height = 366
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 4
    object JvPageList1: TJvPageList
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
          Height = 350
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
            OnMouseEnter = MRAonserverLabelMouseEnter
            OnMouseLeave = MRAonserverLabelMouseLeave
          end
          object ICQUINLabel: TLabel
            Left = 80
            Top = 25
            Width = 38
            Height = 13
            Caption = 'E-mail:'
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
          object MRAonserverLabel: TLabel
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
            OnMouseEnter = MRAonserverLabelMouseEnter
            OnMouseLeave = MRAonserverLabelMouseLeave
          end
          object RegNewEmailLabel: TLabel
            Left = 48
            Top = 229
            Width = 327
            Height = 13
            Cursor = crHandPoint
            Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100' '#1085#1072' '#1074#1077#1073'-'#1089#1072#1081#1090#1077
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnMouseEnter = MRAonserverLabelMouseEnter
            OnMouseLeave = MRAonserverLabelMouseLeave
          end
          object MRAEmailEdit: TEdit
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
          end
          object ShowPassCheckBox: TCheckBox
            Left = 78
            Top = 123
            Width = 341
            Height = 17
            Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object SavePassCheckBox: TCheckBox
            Left = 78
            Top = 146
            Width = 341
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
        end
      end
    end
  end
end
