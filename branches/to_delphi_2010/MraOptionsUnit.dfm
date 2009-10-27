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
    DoubleBuffered = True
    ParentDoubleBuffered = False
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
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
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
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    TabStop = False
    OnClick = OKButtonClick
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
        ImageIndex = 66
      end
      item
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
        ImageIndex = 162
      end
      item
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        ImageIndex = 171
      end
      item
        Caption = 'ID '#1082#1083#1080#1077#1085#1090#1072
        ImageIndex = 172
      end>
    ItemIndex = 0
    TabOrder = 3
    OnButtonClicked = MRAOptionButtonGroupButtonClicked
    OnKeyDown = MRAOptionButtonGroupKeyDown
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
          Height = 230
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
          object RegNewEmailLabel: TLabel
            Left = 80
            Top = 199
            Width = 248
            Height = 13
            Cursor = crHandPoint
            Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = RegNewEmailLabelClick
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
            OnChange = MRAEmailEditChange
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
            OnChange = MRAEmailEditChange
            OnClick = PassEditClick
          end
          object ShowPassCheckBox: TCheckBox
            Left = 78
            Top = 123
            Width = 336
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
            OnClick = ShowPassCheckBoxClick
          end
          object SavePassCheckBox: TCheckBox
            Left = 78
            Top = 146
            Width = 336
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
        object OptionGroupBox: TGroupBox
          Left = 3
          Top = 239
          Width = 422
          Height = 114
          Caption = #1054#1087#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
      object ConnectPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ConnectPage'
        object GroupBox1: TGroupBox
          Left = 3
          Top = 3
          Width = 422
          Height = 86
          Caption = #1057#1077#1088#1074#1077#1088
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object MraLoginServerLabel: TLabel
            Left = 58
            Top = 24
            Width = 35
            Height = 13
            Alignment = taRightJustify
            Caption = #1040#1076#1088#1077#1089':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object MraLoginServerPortLabel: TLabel
            Left = 64
            Top = 51
            Width = 29
            Height = 13
            Alignment = taRightJustify
            Caption = #1055#1086#1088#1090':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object MraLoginServerComboBox: TComboBox
            Left = 99
            Top = 21
            Width = 278
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            TabStop = False
            Text = 'mrim.mail.ru'
            Items.Strings = (
              'mrim.mail.ru')
          end
          object MraLoginServerPortEdit: TEdit
            Left = 99
            Top = 48
            Width = 121
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '2042'
          end
        end
      end
      object OptionsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'OptionsPage'
      end
      object IDClientPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'IDClientPage'
      end
    end
  end
end
