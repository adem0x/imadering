object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 416
  ClientWidth = 601
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
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
    DoubleBuffered = True
    Images = MainForm.AllImageList
    Items = <
      item
        ImageIndex = 0
      end
      item
        ImageIndex = 1
      end
      item
        ImageIndex = 112
      end
      item
        ImageIndex = 133
      end
      item
        ImageIndex = 147
      end
      item
        ImageIndex = 44
      end
      item
        ImageIndex = 228
      end
      item
        ImageIndex = 135
      end
      item
        ImageIndex = 182
      end
      item
        ImageIndex = 183
      end
      item
        ImageIndex = 184
      end
      item
        ImageIndex = 162
      end
      item
        ImageIndex = 160
      end>
    ItemIndex = 0
    ParentDoubleBuffered = False
    TabOrder = 0
    TabStop = False
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
    object SettingsJvPageList: TJvPageList
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 432
      Height = 359
      ActivePage = GeneralPage
      PropagateEnable = False
      ShowDesignCaption = sdcNone
      Align = alClient
      object GeneralPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'GeneralPage'
        object GeneralOptionGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 121
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
            OnClick = ProxyAddressEditChange
          end
          object AutoUpdateCheckBox: TCheckBox
            Left = 14
            Top = 45
            Width = 402
            Height = 17
            TabStop = False
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 1
            OnClick = ProxyAddressEditChange
          end
          object BestPrioritetCheckBox: TCheckBox
            Left = 14
            Top = 68
            Width = 402
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ProxyAddressEditChange
          end
        end
        object ProfileGroupBox: TGroupBox
          Left = 0
          Top = 127
          Width = 432
          Height = 106
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object ProfilePathLabel: TLabel
            Left = 15
            Top = 49
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OpenProfileSpeedButton: TSpeedButton
            Left = 399
            Top = 68
            Width = 23
            Height = 22
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = OpenProfileSpeedButtonClick
          end
          object NoShowProfileFormCheckBox: TCheckBox
            Left = 14
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
            OnClick = ProxyAddressEditChange
          end
          object ProfilePathEdit: TEdit
            Left = 14
            Top = 68
            Width = 379
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
        end
      end
      object CLPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'CLPage'
        object CLWindowGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 214
          Height = 149
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
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ProxyAddressEditChange
          end
          object AutoHideCLCheckBox: TCheckBox
            Left = 12
            Top = 42
            Width = 161
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ProxyAddressEditChange
          end
          object AutoHideClEdit: TEdit
            Left = 179
            Top = 40
            Width = 25
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            NumbersOnly = True
            ParentFont = False
            TabOrder = 2
            Text = '10'
            OnChange = ProxyAddressEditChange
          end
        end
        object TransparentGroupBox: TGroupBox
          Left = 220
          Top = 0
          Width = 212
          Height = 80
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
            TabStop = False
            TickStyle = tsNone
            OnChange = TransparentTrackBarChange
          end
          object TransparentNotActiveCheckBox: TCheckBox
            Left = 13
            Top = 52
            Width = 188
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ProxyAddressEditChange
          end
        end
        object HeadTextGroupBox: TGroupBox
          Left = 220
          Top = 86
          Width = 212
          Height = 63
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
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = ProxyAddressEditChange
          end
        end
        object CLOptionsGroupBox: TGroupBox
          Left = 0
          Top = 155
          Width = 432
          Height = 204
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object NoTaskBarMainButtonCheckBox: TCheckBox
            Left = 12
            Top = 19
            Width = 409
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ProxyAddressEditChange
          end
        end
      end
      object ChatPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'ChatPage'
        object ChatFormGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object KeyboardSoundsCheckBox: TCheckBox
            Left = 16
            Top = 24
            Width = 393
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ProxyAddressEditChange
          end
        end
      end
      object EventsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'EventsPage'
        object EventsGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object HistoryPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'HistoryPage'
        object HistoryGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object StatusesPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'StatusesPage'
        object StatusesGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object AntiSpamPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'AntiSpamPage'
        object AntiSpamGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object SoundsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'SoundsPage'
        object SoundsGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object SoundPlaySpeedButton: TSpeedButton
            Left = 385
            Top = 327
            Width = 34
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            OnClick = SoundPlaySpeedButtonClick
          end
          object SoundOnOffCheckBox: TCheckBox
            Left = 14
            Top = 17
            Width = 405
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = SoundOnOffCheckBoxClick
          end
          object SoundOffForStatusCheckBox: TCheckBox
            Left = 27
            Top = 40
            Width = 392
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object SoundAlwaysUniqCheckBox: TCheckBox
            Left = 27
            Top = 63
            Width = 392
            Height = 17
            TabStop = False
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 2
          end
          object SoundPackComboBox: TComboBox
            Left = 14
            Top = 88
            Width = 219
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            TabStop = False
            OnChange = SoundPackComboBoxChange
          end
          object DownSoundButton: TButton
            Left = 255
            Top = 86
            Width = 164
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            TabStop = False
          end
          object SoundPathListView: TListView
            Left = 14
            Top = 117
            Width = 405
            Height = 204
            Checkboxes = True
            Columns = <
              item
                Width = 170
              end
              item
                Width = 230
              end>
            ColumnClick = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HideSelection = False
            Items.ItemData = {
              03F80000000800000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
              000131000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF00000000013200
              0000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF0000000001330000000000
              00FFFFFFFFFFFFFFFF01000000FFFFFFFF000000000134000000000000FFFFFF
              FFFFFFFFFF01000000FFFFFFFF000000000135000000000000FFFFFFFFFFFFFF
              FF01000000FFFFFFFF000000000136000000000000FFFFFFFFFFFFFFFF010000
              00FFFFFFFF000000000137000000000000FFFFFFFFFFFFFFFF01000000FFFFFF
              FF0000000001380000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            ReadOnly = True
            RowSelect = True
            ParentFont = False
            TabOrder = 5
            TabStop = False
            ViewStyle = vsReport
            OnChange = SoundPathListViewChange
          end
          object SoundPathButton: TButton
            Left = 14
            Top = 327
            Width = 99
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            TabStop = False
          end
        end
      end
      object ThemesPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'ThemesPage'
        object LangGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 109
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object LangDownButton: TButton
            Left = 255
            Top = 16
            Width = 164
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
            OnClick = LangDownButtonClick
          end
          object LangComboBox: TComboBox
            Left = 13
            Top = 18
            Width = 220
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
            OnChange = LangComboBoxChange
            Items.Strings = (
              '[ru] '#1056#1091#1089#1089#1082#1080#1081
              '[en] English')
          end
          object LangInfoRichEdit: TRichEdit
            Left = 13
            Top = 47
            Width = 406
            Height = 56
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
            TabOrder = 2
          end
        end
        object SmiliesGroupBox: TGroupBox
          Left = 0
          Top = 115
          Width = 432
          Height = 129
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object SmiliesLabel: TLabel
            Left = 13
            Top = 80
            Width = 406
            Height = 32
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object SmiliesComboBox: TComboBox
            Left = 13
            Top = 18
            Width = 220
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
            OnChange = SmiliesComboBoxChange
          end
          object SmiliesDownButton: TButton
            Left = 255
            Top = 16
            Width = 164
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
            OnClick = LangDownButtonClick
          end
          object TextSmiliesCheckBox: TCheckBox
            Left = 13
            Top = 44
            Width = 406
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ProxyAddressEditChange
          end
          object SmiliesInfoRichEdit: TRichEdit
            Left = 13
            Top = 66
            Width = 406
            Height = 56
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
            TabOrder = 3
          end
        end
        object IconsGroupBox: TGroupBox
          Left = 0
          Top = 250
          Width = 432
          Height = 109
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object IconsComboBox: TComboBox
            Left = 13
            Top = 18
            Width = 220
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
            OnChange = IconsComboBoxChange
          end
          object IconsDownButton: TButton
            Left = 255
            Top = 16
            Width = 164
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
            OnClick = LangDownButtonClick
          end
          object IconsInfoRichEdit: TRichEdit
            Left = 13
            Top = 47
            Width = 406
            Height = 56
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
            TabOrder = 2
          end
        end
      end
      object HotKeysPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'HotKeysPage'
        object HotKeysGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object PluginsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'PluginsPage'
        object PluginsGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ShowPluginConfigButton: TButton
            Left = 10
            Top = 325
            Width = 412
            Height = 25
            TabOrder = 0
          end
          object PluginsListView: TListView
            Left = 10
            Top = 19
            Width = 412
            Height = 300
            Columns = <>
            TabOrder = 1
          end
        end
      end
      object GlobalProxyPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'GlobalProxyPage'
        object ProxyGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 247
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object HostLabel: TLabel
            Left = 82
            Top = 48
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
          object PortLabel: TLabel
            Left = 82
            Top = 75
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
          object TypeLabel: TLabel
            Left = 334
            Top = 48
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
          object ProxyVerLabel: TLabel
            Left = 334
            Top = 75
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
          object LoginLabel: TLabel
            Left = 82
            Top = 147
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
          object PassLabel: TLabel
            Left = 82
            Top = 174
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
          object Bevel1: TBevel
            Left = 12
            Top = 109
            Width = 406
            Height = 2
            Shape = bsBottomLine
          end
          object ProxyAddressEdit: TEdit
            Left = 91
            Top = 45
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
            OnChange = ProxyAddressEditChange
          end
          object ProxyPortEdit: TEdit
            Left = 91
            Top = 72
            Width = 187
            Height = 21
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NumbersOnly = True
            ParentFont = False
            TabOrder = 1
            OnChange = ProxyAddressEditChange
          end
          object ProxyTypeComboBox: TComboBox
            Left = 343
            Top = 45
            Width = 75
            Height = 21
            Style = csDropDownList
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 4
            TabStop = False
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
            Top = 72
            Width = 75
            Height = 21
            Style = csDropDownList
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 5
            TabStop = False
            Text = '1.0'
            OnChange = ProxyAddressEditChange
            Items.Strings = (
              '1.0'
              '1.1')
          end
          object ProxyAuthCheckBox: TCheckBox
            Left = 91
            Top = 121
            Width = 327
            Height = 17
            TabStop = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = ProxyAuthCheckBoxClick
          end
          object ProxyLoginEdit: TEdit
            Left = 91
            Top = 144
            Width = 327
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
            OnChange = ProxyAddressEditChange
          end
          object ProxyPasswordEdit: TEdit
            Left = 91
            Top = 171
            Width = 327
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
            TabOrder = 3
            OnChange = ProxyAddressEditChange
          end
          object ProxyShowPassCheckBox: TCheckBox
            Left = 91
            Top = 198
            Width = 327
            Height = 17
            TabStop = False
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
            Top = 22
            Width = 406
            Height = 17
            TabStop = False
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
            Top = 221
            Width = 327
            Height = 17
            TabStop = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            OnClick = ProxyAddressEditChange
          end
        end
        object ConnGroupBox: TGroupBox
          Left = 0
          Top = 247
          Width = 432
          Height = 112
          Align = alClient
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
            Width = 406
            Height = 17
            TabStop = False
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            State = cbChecked
            TabOrder = 0
            OnClick = ProxyAddressEditChange
          end
        end
      end
      object AccountsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        Caption = 'AccountsPage'
        object ProtocolsGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 359
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
                Width = 404
              end>
            ColumnClick = False
            Groups = <
              item
                Header = 'ICQ (OSCAR)'
                GroupID = 0
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                Header = 'Jabber (XMPP)'
                GroupID = 1
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                Header = 'Mail.ru agent (MRA)'
                GroupID = 2
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                Header = 'Twitter (www.twitter.com)'
                GroupID = 3
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end>
            HideSelection = False
            GroupView = True
            ReadOnly = True
            RowSelect = True
            ShowColumnHeaders = False
            SmallImages = MainForm.AllImageList
            TabOrder = 0
            TabStop = False
            ViewStyle = vsReport
            OnChange = ProtocolsListViewChange
            OnClick = ProtocolsListViewClick
            OnDblClick = ProtocolsListViewClick
            OnKeyUp = ProtocolsListViewKeyUp
          end
          object AddProtoBitBtn: TBitBtn
            Left = 12
            Top = 326
            Width = 132
            Height = 25
            DoubleBuffered = True
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentDoubleBuffered = False
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
            DoubleBuffered = True
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentDoubleBuffered = False
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
            DoubleBuffered = True
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentDoubleBuffered = False
            ParentFont = False
            TabOrder = 3
            TabStop = False
            OnClick = AddProtoBitBtnClick
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
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    TabStop = False
    OnClick = CancelBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 486
    Top = 383
    Width = 107
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    TabStop = False
    OnClick = OKBitBtnClick
  end
  object ApplyBitBtn: TBitBtn
    Left = 373
    Top = 383
    Width = 107
    Height = 25
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 4
    TabStop = False
    OnClick = ApplyBitBtnClick
  end
end
