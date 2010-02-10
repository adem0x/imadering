object TwitterOptionsForm: TTwitterOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 413
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CancelButton: TBitBtn
    Left = 8
    Top = 380
    Width = 137
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    OnClick = CancelButtonClick
  end
  object ApplyButton: TBitBtn
    Left = 369
    Top = 380
    Width = 107
    Height = 25
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 2
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
    TabOrder = 3
    TabStop = False
    OnClick = OKButtonClick
  end
  object TwitterOptionButtonGroup: TButtonGroup
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
        ImageIndex = 268
      end
      item
        ImageIndex = 162
      end
      item
        ImageIndex = 171
      end>
    ItemIndex = 0
    TabOrder = 0
    OnButtonClicked = TwitterOptionButtonGroupButtonClicked
    OnKeyDown = TwitterOptionButtonGroupKeyDown
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
          Left = 0
          Top = 0
          Width = 428
          Height = 226
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ReqPassLabel: TLabel
            Left = 79
            Top = 173
            Width = 3
            Height = 13
            Cursor = crHandPoint
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
          object AccountLabel: TLabel
            Left = 79
            Top = 24
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PassLabel: TLabel
            Left = 79
            Top = 74
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RegNewTwitterLabel: TLabel
            Left = 79
            Top = 197
            Width = 3
            Height = 13
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = RegNewTwitterLabelClick
            OnMouseEnter = ReqPassLabelMouseEnter
            OnMouseLeave = ReqPassLabelMouseLeave
          end
          object AccountEdit: TEdit
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
            TabOrder = 1
            OnChange = AccountEditChange
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
            TabOrder = 2
            OnChange = PassEditChange
            OnClick = PassEditClick
          end
          object ShowPassCheckBox: TCheckBox
            Left = 78
            Top = 123
            Width = 336
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ShowPassCheckBoxClick
          end
          object SavePassCheckBox: TCheckBox
            Left = 78
            Top = 146
            Width = 336
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = AccountEditChange
          end
        end
        object OptionGroupBox: TGroupBox
          Left = 0
          Top = 232
          Width = 428
          Height = 124
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object InMessLabel: TLabel
            Left = 69
            Top = 26
            Width = 310
            Height = 13
            Caption = '#'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1079#1072#1075#1088#1091#1078#1072#1077#1084#1099#1093' '#1074#1093#1086#1076#1103#1097#1080#1093' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object MyMessLabel: TLabel
            Left = 69
            Top = 53
            Width = 282
            Height = 13
            Caption = '#'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1079#1072#1075#1088#1091#1078#1072#1077#1084#1099#1093' '#1084#1086#1080#1093' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object InMessJvSpinEdit: TJvSpinEdit
            Left = 14
            Top = 23
            Width = 49
            Height = 21
            TabStop = False
            Decimal = 1
            MaxValue = 60.000000000000000000
            MinValue = 1.000000000000000000
            Value = 5.000000000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = AccountEditChange
          end
          object MyMessJvSpinEdit: TJvSpinEdit
            Left = 14
            Top = 50
            Width = 49
            Height = 21
            TabStop = False
            Decimal = 1
            MaxValue = 60.000000000000000000
            MinValue = 1.000000000000000000
            Value = 5.000000000000000000
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = AccountEditChange
          end
        end
      end
      object ConnectPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ConnectPage'
      end
      object ConsolePage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ConsolePage'
        object ConsoleGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object CustomURLLabel: TLabel
            Left = 11
            Top = 86
            Width = 23
            Height = 13
            Caption = 'URL:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object DumpInfoRichEdit: TRichEdit
            Left = 10
            Top = 18
            Width = 408
            Height = 56
            TabStop = False
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object CustomURLEdit: TEdit
            Left = 10
            Top = 105
            Width = 408
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = 'http://'
          end
          object SendCustomURLButton: TButton
            Left = 322
            Top = 132
            Width = 96
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
          end
        end
      end
    end
  end
end
