object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 416
  ClientWidth = 601
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
      ActivePage = HistoryPage
      PropagateEnable = False
      ShowDesignCaption = sdcNone
      Align = alClient
      object GeneralPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
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
          object AutoOpenSiteCheckBox: TCheckBox
            Left = 15
            Top = 91
            Width = 401
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
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
        object PopupGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 260
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object PopupPosLabel: TLabel
            Left = 14
            Top = 43
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PopupShowLabel: TLabel
            Left = 132
            Top = 92
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
          object SecondsLabel: TLabel
            Left = 177
            Top = 92
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PopupRowsLabel: TLabel
            Left = 132
            Top = 119
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
          object PopupEventsLabel: TLabel
            Left = 14
            Top = 166
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PopupPosComboBox: TComboBox
            Left = 13
            Top = 62
            Width = 249
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
            OnChange = ProxyAddressEditChange
          end
          object PopupShowEdit: TEdit
            Left = 141
            Top = 89
            Width = 30
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
            TabOrder = 1
            Text = '7'
            OnChange = ProxyAddressEditChange
          end
          object PopupRowsEdit: TEdit
            Left = 141
            Top = 116
            Width = 30
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 2
            NumbersOnly = True
            ParentFont = False
            TabOrder = 2
            Text = '4'
            OnChange = ProxyAddressEditChange
          end
          object PopupContactsCheckBox: TCheckBox
            Left = 13
            Top = 143
            Width = 404
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = ProxyAddressEditChange
          end
          object PopupSignOnCheckBox: TCheckBox
            Left = 23
            Top = 185
            Width = 394
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnClick = ProxyAddressEditChange
          end
          object PopupSignOffCheckBox: TCheckBox
            Left = 23
            Top = 208
            Width = 394
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = ProxyAddressEditChange
          end
          object PopupTypingCheckBox: TCheckBox
            Left = 23
            Top = 231
            Width = 394
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnClick = ProxyAddressEditChange
          end
          object PopupTestButton: TButton
            Left = 304
            Top = 60
            Width = 81
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            TabStop = False
            OnClick = PopupTestButtonClick
          end
          object PopupMessEnableCheckBox: TCheckBox
            Left = 13
            Top = 20
            Width = 404
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnClick = PopupMessEnableCheckBoxClick
          end
        end
      end
      object HistoryPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
        object HistoryGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 432
          Height = 135
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object SaveHistoryCheckBox: TCheckBox
            Left = 11
            Top = 19
            Width = 412
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object SaveNoCLHistoryCheckBox: TCheckBox
            Left = 11
            Top = 42
            Width = 412
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
          object SaveServiceHistoryCheckBox: TCheckBox
            Left = 11
            Top = 65
            Width = 412
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object SaveSpamHistoryCheckBox: TCheckBox
            Left = 11
            Top = 88
            Width = 412
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object SavePluginsHistoryCheckBox: TCheckBox
            Left = 11
            Top = 111
            Width = 412
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
        end
        object RecentGroupBox: TGroupBox
          Left = 0
          Top = 141
          Width = 432
          Height = 74
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object NumberRecentMessLabel: TLabel
            Left = 49
            Top = 47
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ShowRecentMessCheckBox: TCheckBox
            Left = 11
            Top = 21
            Width = 412
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object Edit1: TEdit
            Left = 11
            Top = 44
            Width = 32
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
            TabOrder = 1
            Text = '5'
          end
        end
        object HistoryPathGroupBox: TGroupBox
          Left = 0
          Top = 221
          Width = 432
          Height = 95
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object HistoryPathLabel: TLabel
            Left = 12
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object HistoryPathSpeedButton: TSpeedButton
            Left = 401
            Top = 38
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
          end
          object HistoryArchiveLabel: TLabel
            Left = 49
            Top = 68
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Edit2: TEdit
            Left = 11
            Top = 38
            Width = 384
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
            TabOrder = 0
          end
          object Edit3: TEdit
            Left = 11
            Top = 65
            Width = 32
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            NumbersOnly = True
            ParentFont = False
            TabOrder = 1
            Text = '1000'
          end
        end
      end
      object StatusesPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
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
            Top = 19
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
            OnClick = ProxyAddressEditChange
          end
          object SoundPackComboBox: TComboBox
            Left = 14
            Top = 44
            Width = 219
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
            OnChange = SoundPackComboBoxChange
          end
          object DownSoundButton: TButton
            Left = 255
            Top = 42
            Width = 164
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnClick = LangDownButtonClick
          end
          object SoundPathListView: TListView
            Left = 14
            Top = 127
            Width = 405
            Height = 194
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
            TabOrder = 3
            TabStop = False
            ViewStyle = vsReport
            OnItemChecked = SoundPathListViewItemChecked
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
            TabOrder = 4
            TabStop = False
          end
          object SoundsInfoRichEdit: TRichEdit
            Left = 14
            Top = 73
            Width = 405
            Height = 48
            TabStop = False
            BevelKind = bkTile
            BorderStyle = bsNone
            Color = clInfoBk
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 5
          end
        end
      end
      object ThemesPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
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
            Top = 18
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
            Top = 20
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
            Top = 49
            Width = 406
            Height = 48
            TabStop = False
            BevelKind = bkTile
            BorderStyle = bsNone
            Color = clInfoBk
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
            Top = 20
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
            Top = 18
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
            Top = 46
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
            Top = 68
            Width = 406
            Height = 48
            TabStop = False
            BevelKind = bkTile
            BorderStyle = bsNone
            Color = clInfoBk
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
            Top = 20
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
            Top = 18
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
            Top = 49
            Width = 406
            Height = 48
            TabStop = False
            BevelKind = bkTile
            BorderStyle = bsNone
            Color = clInfoBk
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
          object EnableHotKeysCheckBox: TCheckBox
            Left = 10
            Top = 19
            Width = 413
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
          object HotKeysListView: TListView
            Left = 10
            Top = 42
            Width = 413
            Height = 278
            Columns = <
              item
                Width = 300
              end
              item
                Width = 107
              end>
            ColumnClick = False
            DoubleBuffered = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Groups = <
              item
                GroupID = 0
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                GroupID = 1
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end>
            HideSelection = False
            Items.ItemData = {
              03530100000700000000000000FFFFFFFFFFFFFFFF0100000000000000000000
              000131000A4300740072006C002B0041006C0074002B00410000000000FFFFFF
              FFFFFFFFFF0100000000000000000000000132000A4300740072006C002B0041
              006C0074002B00490000000000FFFFFFFFFFFFFFFF0100000000000000000000
              000133000A4300740072006C002B0041006C0074002B004D0000000000FFFFFF
              FFFFFFFFFF0100000000000000000000000134000A4300740072006C002B0041
              006C0074002B004F0000000000FFFFFFFFFFFFFFFF0100000000000000000000
              000135000A4300740072006C002B0041006C0074002B00530000000000FFFFFF
              FFFFFFFFFF010000000000000000000000013600084300740072006C002B0046
              003100320000000000FFFFFFFFFFFFFFFF010000000100000000000000013700
              03450073006300FFFFFFFFFFFFFFFFFFFFFFFFFFFF}
            GroupView = True
            ReadOnly = True
            RowSelect = True
            ParentDoubleBuffered = False
            ParentFont = False
            TabOrder = 1
            TabStop = False
            ViewStyle = vsReport
            OnKeyDown = HotKeysListViewKeyDown
            OnSelectItem = HotKeysListViewSelectItem
          end
          object HotKeyEdit: THotKey
            Left = 10
            Top = 329
            Width = 175
            Height = 19
            DoubleBuffered = False
            HotKey = 49217
            InvalidKeys = [hcNone, hcShift, hcShiftCtrl]
            Modifiers = [hkCtrl, hkAlt]
            ParentDoubleBuffered = False
            TabOrder = 2
            TabStop = False
          end
          object HotKeySetButton: TButton
            Left = 203
            Top = 326
            Width = 103
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            TabStop = False
            OnClick = HotKeySetButtonClick
          end
          object HotKeyDellButton: TButton
            Left = 320
            Top = 326
            Width = 103
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            TabStop = False
            OnClick = HotKeyDellButtonClick
          end
        end
      end
      object PluginsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
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
            Top = 294
            Width = 200
            Height = 25
            TabOrder = 0
            TabStop = False
            OnClick = ShowPluginConfigButtonClick
          end
          object PluginsListView: TListView
            Left = 10
            Top = 87
            Width = 412
            Height = 201
            Columns = <
              item
                Width = 130
              end
              item
                Width = 130
              end
              item
                Width = 500
              end>
            ColumnClick = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            ParentFont = False
            TabOrder = 1
            TabStop = False
            ViewStyle = vsReport
          end
          object PluginsInfoRichEdit: TRichEdit
            Left = 10
            Top = 19
            Width = 412
            Height = 62
            TabStop = False
            BevelKind = bkTile
            BorderStyle = bsNone
            Color = clInfoBk
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
          object PluginsDownButton: TButton
            Left = 10
            Top = 325
            Width = 200
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            TabStop = False
            OnClick = LangDownButtonClick
          end
          object ReloadPluginsButton: TButton
            Left = 222
            Top = 325
            Width = 200
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            TabStop = False
            OnClick = ReloadPluginsButtonClick
          end
          object UnloadPluginButton: TButton
            Left = 222
            Top = 294
            Width = 200
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            TabStop = False
            OnClick = UnloadPluginButtonClick
          end
        end
      end
      object GlobalProxyPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 432
        Height = 359
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
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Groups = <
              item
                Header = 'ICQ - www.icq.com'
                GroupID = 0
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                Header = 'Jabber - www.xmpp.org'
                GroupID = 1
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                Header = 'MRA - www.mail.ru'
                GroupID = 2
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end
              item
                Header = 'Bimoid - www.bimoid.com'
                GroupID = 3
                State = [lgsNormal]
                HeaderAlign = taLeftJustify
                FooterAlign = taLeftJustify
                TitleImage = -1
                ExtendedImage = -1
              end>
            HideSelection = False
            Items.ItemData = {
              03700000000400000051000000FFFFFFFFFFFFFFFF0000000000000000000000
              000131002B000000FFFFFFFFFFFFFFFF00000000010000000000000001320042
              000000FFFFFFFFFFFFFFFF00000000020000000000000001330029010000FFFF
              FFFFFFFFFFFF000000000300000000000000013400}
            GroupView = True
            ReadOnly = True
            RowSelect = True
            ParentFont = False
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
            Enabled = False
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
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
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
    TabOrder = 3
    TabStop = False
    OnClick = OKBitBtnClick
  end
  object ApplyBitBtn: TBitBtn
    Left = 373
    Top = 383
    Width = 107
    Height = 25
    Enabled = False
    TabOrder = 4
    TabStop = False
    OnClick = ApplyBitBtnClick
  end
end
