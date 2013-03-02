object BimoidOptionsForm: TBimoidOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 413
  ClientWidth = 597
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Position = poScreenCenter
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
  object BimOptionButtonGroup: TButtonGroup
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
        ImageIndex = 297
      end
      item
        ImageIndex = 162
      end
      item
        ImageIndex = 274
      end>
    ItemIndex = 0
    TabOrder = 0
    OnButtonClicked = BimOptionButtonGroupButtonClicked
    OnKeyDown = BimOptionButtonGroupKeyDown
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
        object AccountGroupBox: TGroupBox
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
          object ReqPassLabel: TLabel
            Left = 65
            Top = 179
            Width = 3
            Height = 13
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnMouseEnter = MRAonserverLabelMouseEnter
            OnMouseLeave = MRAonserverLabelMouseLeave
          end
          object BimoidLoginLabel: TLabel
            Left = 65
            Top = 26
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
            Left = 65
            Top = 79
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object BimoidLoginEdit: TEdit
            Left = 63
            Top = 45
            Width = 308
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = BimoidLoginEditChange
          end
          object PassEdit: TEdit
            Left = 63
            Top = 98
            Width = 308
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
            Left = 63
            Top = 128
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
            Left = 63
            Top = 151
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
            OnClick = BimoidLoginEditChange
          end
        end
      end
      object ConnectPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        object ServerGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 57
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object BimLoginServerLabel: TLabel
            Left = 58
            Top = 24
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object BimLoginServerPortLabel: TLabel
            Left = 334
            Top = 24
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object BimLoginServerComboBox: TComboBox
            Left = 67
            Top = 21
            Width = 205
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
            Text = 'bimoid.net'
            OnChange = BimoidLoginEditChange
            Items.Strings = (
              'bimoid.net')
          end
          object BimLoginServerPortEdit: TEdit
            Left = 343
            Top = 21
            Width = 62
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NumbersOnly = True
            ParentFont = False
            TabOrder = 1
            Text = '7023'
            OnChange = BimoidLoginEditChange
          end
        end
      end
      object OptionsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
      end
    end
  end
end
