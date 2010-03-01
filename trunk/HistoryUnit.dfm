object HistoryForm: THistoryForm
  Left = 0
  Top = 0
  ClientHeight = 427
  ClientWidth = 521
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 529
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 521
    Height = 103
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel1: TBevel
      Left = 215
      Top = 4
      Width = 2
      Height = 93
      Shape = bsLeftLine
    end
    object ContactsLabel: TLabel
      Left = 7
      Top = 6
      Width = 3
      Height = 13
    end
    object ArhiveLabel: TLabel
      Left = 7
      Top = 52
      Width = 3
      Height = 13
    end
    object SearchTextLabel: TLabel
      Left = 225
      Top = 6
      Width = 3
      Height = 13
    end
    object ContactsComboBox: TComboBox
      Left = 6
      Top = 25
      Width = 200
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      TabOrder = 0
      TabStop = False
    end
    object ArhiveComboBox: TComboBox
      Left = 6
      Top = 71
      Width = 200
      Height = 21
      Style = csDropDownList
      DropDownCount = 15
      TabOrder = 1
      TabStop = False
    end
    object SearchTextEdit: TEdit
      Left = 224
      Top = 25
      Width = 172
      Height = 21
      TabOrder = 2
    end
    object SearchTextBitBtn: TBitBtn
      Left = 402
      Top = 23
      Width = 109
      Height = 25
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      TabStop = False
      OnClick = SearchTextBitBtnClick
    end
    object RegistrCheckBox: TCheckBox
      Left = 225
      Top = 54
      Width = 164
      Height = 17
      TabOrder = 4
    end
    object FullSearchTextCheckBox: TCheckBox
      Left = 225
      Top = 77
      Width = 164
      Height = 17
      TabOrder = 5
    end
    object UpSearchCheckBox: TRadioButton
      Left = 395
      Top = 54
      Width = 116
      Height = 17
      Checked = True
      TabOrder = 6
      TabStop = True
    end
    object DownSearchCheckBox: TRadioButton
      Left = 395
      Top = 77
      Width = 116
      Height = 17
      TabOrder = 7
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 392
    Width = 521
    Height = 35
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object ReloadHistoryBitBtn: TBitBtn
      Left = 7
      Top = 4
      Width = 109
      Height = 25
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      TabStop = False
      OnClick = ReloadHistoryBitBtnClick
    end
    object SaveHistoryAsBitBtn: TBitBtn
      Left = 122
      Top = 4
      Width = 139
      Height = 25
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      TabStop = False
      OnClick = SaveHistoryAsBitBtnClick
    end
    object DeleteHistoryBitBtn: TBitBtn
      Left = 287
      Top = 4
      Width = 102
      Height = 25
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      TabStop = False
      OnClick = DeleteHistoryBitBtnClick
    end
    object CloseBitBtn: TBitBtn
      AlignWithMargins = True
      Left = 413
      Top = 4
      Width = 101
      Height = 25
      Margins.Top = 4
      Margins.Right = 7
      Margins.Bottom = 4
      Align = alRight
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      OnClick = CloseBitBtnClick
    end
  end
  object HTMLHistoryViewer: THTMLViewer
    Left = 0
    Top = 103
    Width = 521
    Height = 289
    Cursor = crDefault
    OnHotSpotClick = HTMLHistoryViewerHotSpotClick
    TabOrder = 2
    Align = alClient
    PopupMenu = HistoryPopupMenu
    DefBackground = clWhite
    BorderStyle = HtNone
    DefFontName = 'Times New Roman'
    DefPreFontName = 'Courier New'
    NoSelect = False
    ScrollBars = ssVertical
    CharSet = DEFAULT_CHARSET
    OnMouseMove = HTMLHistoryViewerMouseMove
    OnKeyDown = HTMLHistoryViewerKeyDown
  end
  object HistoryPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = HistoryPopupMenuPopup
    Left = 240
    Top = 216
    object CopyHistorySelText: TMenuItem
      Tag = 1
      Enabled = False
      ImageIndex = 144
      OnClick = CopyHistorySelTextClick
    end
    object CopyAllHistoryText: TMenuItem
      Tag = 2
      ImageIndex = 144
      OnClick = CopyAllHistoryTextClick
    end
  end
end
