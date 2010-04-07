object JabberOptionsForm: TJabberOptionsForm
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
        ImageIndex = 41
      end
      item
        ImageIndex = 162
      end
      item
        ImageIndex = 274
      end
      item
        ImageIndex = 174
      end
      item
        ImageIndex = 85
      end
      item
        ImageIndex = 175
      end
      item
        ImageIndex = 176
      end
      item
        ImageIndex = 273
      end
      item
        ImageIndex = 180
      end
      item
        ImageIndex = 171
      end>
    ItemIndex = 0
    TabOrder = 0
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
          Left = 0
          Top = 0
          Width = 428
          Height = 232
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object RegNewAccountLabel: TLabel
            Left = 80
            Top = 177
            Width = 3
            Height = 13
            Cursor = crHandPoint
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
            Left = 80
            Top = 75
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object DeleteAccountLabel: TLabel
            Left = 80
            Top = 204
            Width = 3
            Height = 13
            Cursor = crHandPoint
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
            Left = 348
            Top = 70
            Width = 3
            Height = 13
            Cursor = crHandPoint
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = JIDonserverLabelClick
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
            OnChange = JabberJIDEditChange
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
            Width = 331
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ShowPassCheckBoxClick
          end
          object SavePassCheckBox: TCheckBox
            Left = 78
            Top = 146
            Width = 331
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = JabberJIDEditChange
          end
        end
        object AccountOptionGroupBox: TGroupBox
          Left = 0
          Top = 238
          Width = 428
          Height = 118
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object ResursLabel: TLabel
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
          object PrioritetLabel: TLabel
            Left = 319
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
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            TabStop = False
            Text = 'IMadering'
            OnChange = JabberJIDEditChange
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
            TabStop = False
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
            OnChange = JabberJIDEditChange
          end
        end
      end
      object ConnectPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ConnectPage'
        object ConnectionGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 113
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Bevel1: TBevel
            Left = 10
            Top = 78
            Width = 408
            Height = 3
            Shape = bsBottomLine
          end
          object CustomServerLabel: TLabel
            Left = 62
            Top = 50
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
          object CustomPortLabel: TLabel
            Left = 341
            Top = 50
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
          object CustomServerCheckBox: TCheckBox
            Left = 13
            Top = 22
            Width = 402
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = CustomServerCheckBoxClick
          end
          object UseSSLCheckBox: TCheckBox
            Left = 13
            Top = 87
            Width = 402
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = JabberJIDEditChange
          end
          object CustomServerEdit: TEdit
            Left = 71
            Top = 47
            Width = 211
            Height = 21
            TabStop = False
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = JabberJIDEditChange
          end
          object CustomPortEdit: TEdit
            Left = 350
            Top = 47
            Width = 65
            Height = 21
            TabStop = False
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NumbersOnly = True
            ParentFont = False
            TabOrder = 3
            OnChange = JabberJIDEditChange
          end
        end
        object ProxyGroupBox: TGroupBox
          Left = 0
          Top = 119
          Width = 428
          Height = 237
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
      object OptionPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'OptionPage'
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
      object AvatarPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'AvatarPage'
      end
      object ParamsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ParamsPage'
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
          object Label1: TLabel
            Left = 14
            Top = 88
            Width = 159
            Height = 13
            Caption = '#'#1055#1072#1082#1077#1090' '#1076#1072#1085#1085#1099#1093' '#1074' XML '#1092#1086#1088#1084#1072#1090#1077
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object DumpInfoRichEdit: TRichEdit
            Left = 13
            Top = 20
            Width = 403
            Height = 61
            TabStop = False
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object SendCustomXMLPacketRichEdit: TRichEdit
            Left = 13
            Top = 107
            Width = 403
            Height = 211
            TabStop = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ScrollBars = ssVertical
            TabOrder = 1
          end
          object SendCustomXMLPacketButton: TButton
            Left = 322
            Top = 324
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
  object JServerPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Left = 240
    Top = 379
    object Set_JabberOrg: TMenuItem
      Tag = 1
      Caption = 'Jabber.org'
      Hint = '@jabber.org'
      OnClick = Set_JabberOrgClick
    end
    object Set_JabberRu: TMenuItem
      Tag = 2
      Caption = 'Jabber.ru'
      Hint = '@jabber.ru'
      OnClick = Set_JabberOrgClick
    end
    object Set_QIPru: TMenuItem
      Tag = 3
      Caption = 'QIP.ru'
      Hint = '@qip.ru'
      OnClick = Set_JabberOrgClick
    end
    object Set_GoogleTalk: TMenuItem
      Tag = 4
      Caption = 'Google talk'
      Hint = '@gmail.com'
      OnClick = Set_JabberOrgClick
    end
    object Set_LiveJournal: TMenuItem
      Tag = 5
      Caption = 'LiveJournal'
      Hint = '@livejournal.com'
      OnClick = Set_JabberOrgClick
    end
  end
end
