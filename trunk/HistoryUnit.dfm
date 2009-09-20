object HistoryForm: THistoryForm
  Left = 0
  Top = 0
  Caption = #1048#1089#1090#1086#1088#1080#1103
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
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
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
      Left = 214
      Top = 3
      Width = 3
      Height = 93
      Shape = bsLeftLine
    end
    object ContactsLabel: TLabel
      Left = 7
      Top = 6
      Width = 55
      Height = 13
      Caption = #1050#1086#1085#1090#1072#1082#1090#1099':'
    end
    object ArhiveLabel: TLabel
      Left = 7
      Top = 52
      Width = 35
      Height = 13
      Caption = #1040#1088#1093#1080#1074':'
    end
    object SearchTextLabel: TLabel
      Left = 225
      Top = 6
      Width = 72
      Height = 13
      Caption = #1055#1086#1080#1089#1082' '#1090#1077#1082#1089#1090#1072':'
    end
    object ContactsComboBox: TComboBox
      Left = 6
      Top = 25
      Width = 200
      Height = 21
      Style = csDropDownList
      DropDownCount = 20
      ItemHeight = 0
      TabOrder = 0
      TabStop = False
      OnChange = ContactsComboBoxChange
    end
    object ArhiveComboBox: TComboBox
      Left = 6
      Top = 71
      Width = 200
      Height = 21
      Style = csDropDownList
      DropDownCount = 15
      ItemHeight = 0
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
      Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
      TabOrder = 3
      TabStop = False
      OnClick = SearchTextBitBtnClick
    end
    object RegistrCheckBox: TCheckBox
      Left = 225
      Top = 54
      Width = 164
      Height = 17
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
      TabOrder = 4
    end
    object FullSearchTextCheckBox: TCheckBox
      Left = 225
      Top = 77
      Width = 164
      Height = 17
      Caption = #1048#1089#1082#1072#1090#1100' '#1074#1077#1079#1076#1077
      TabOrder = 5
    end
    object UpSearchCheckBox: TRadioButton
      Left = 395
      Top = 54
      Width = 116
      Height = 17
      Caption = #1042#1074#1077#1088#1093
      Checked = True
      TabOrder = 6
      TabStop = True
    end
    object DownSearchCheckBox: TRadioButton
      Left = 395
      Top = 77
      Width = 116
      Height = 17
      Caption = #1042#1085#1080#1079
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
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 0
      TabStop = False
      OnClick = ReloadHistoryBitBtnClick
    end
    object SaveHistoryAsBitBtn: TBitBtn
      Left = 122
      Top = 4
      Width = 139
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082' ...'
      TabOrder = 1
      TabStop = False
      OnClick = SaveHistoryAsBitBtnClick
    end
    object DeleteHistoryBitBtn: TBitBtn
      Left = 287
      Top = 4
      Width = 102
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
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
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 3
      OnClick = CloseBitBtnClick
      ExplicitLeft = 414
    end
  end
  object HTMLHistoryViewer: THTMLViewer
    Left = 0
    Top = 103
    Width = 521
    Height = 289
    Cursor = crDefault
    TabOrder = 2
    Align = alClient
    PopupMenu = HistoryPopupMenu
    DefBackground = clWhite
    BorderStyle = htNone
    HistoryMaxCount = 0
    DefFontName = 'Times New Roman'
    DefPreFontName = 'Courier New'
    NoSelect = False
    ScrollBars = ssVertical
    CharSet = DEFAULT_CHARSET
    PrintMarginLeft = 2.000000000000000000
    PrintMarginRight = 2.000000000000000000
    PrintMarginTop = 2.000000000000000000
    PrintMarginBottom = 2.000000000000000000
    PrintScale = 1.000000000000000000
    OnKeyDown = HTMLHistoryViewerKeyDown
    ExplicitHeight = 283
  end
  object HistoryPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    OnPopup = HistoryPopupMenuPopup
    Left = 264
    Top = 216
    object CopyHistorySelText: TMenuItem
      Tag = 1
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Enabled = False
      ImageIndex = 148
      OnClick = CopyHistorySelTextClick
    end
    object CopyAllHistoryText: TMenuItem
      Tag = 2
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1105
      ImageIndex = 148
      OnClick = CopyAllHistoryTextClick
    end
  end
  object SaveTextAsFileDialog: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'Text Files (*.txt)|*.txt'
    Left = 232
    Top = 216
  end
end
