object LogForm: TLogForm
  Left = 0
  Top = 0
  ClientHeight = 397
  ClientWidth = 586
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 371
    Width = 586
    Height = 26
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      586
      24)
    object ClearLogSpeedButton: TSpeedButton
      Left = 557
      Top = 1
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = ClearLogSpeedButtonClick
    end
    object Bevel: TBevel
      Left = 549
      Top = 2
      Width = 2
      Height = 20
      Anchors = [akTop, akRight]
      Shape = bsRightLine
    end
    object ICQDumpSpeedButton: TSpeedButton
      Left = 5
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object JabberDumpSpeedButton: TSpeedButton
      Left = 34
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 2
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object MRADumpSpeedButton: TSpeedButton
      Left = 63
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 3
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object WriteLogSpeedButton: TSpeedButton
      Left = 433
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 5
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = WriteLogSpeedButtonClick
    end
    object TwitDumpSpeedButton: TSpeedButton
      Left = 92
      Top = 1
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 4
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object SaveLogSpeedButton: TSpeedButton
      Left = 491
      Top = 1
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SaveLogSpeedButtonClick
    end
    object SearchSpeedButton: TSpeedButton
      Left = 462
      Top = 1
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SearchSpeedButtonClick
    end
    object SendEmailSpeedButton: TSpeedButton
      Left = 520
      Top = 1
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SendEmailSpeedButtonClick
    end
    object RosterSpeedButton: TSpeedButton
      Left = 121
      Top = 1
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = RosterSpeedButtonClick
    end
  end
  object HTMLLogViewer: THTMLViewer
    Left = 0
    Top = 0
    Width = 586
    Height = 371
    Cursor = crDefault
    TabOrder = 1
    Align = alClient
    PopupMenu = LogPopupMenu
    DefBackground = clWhite
    BorderStyle = HtNone
    DefFontName = 'Times New Roman'
    DefPreFontName = 'Courier New'
    NoSelect = False
    CharSet = DEFAULT_CHARSET
    HtOptions = [HtPrintTableBackground, HtPrintMonochromeBlack, HtShowDummyCaret, HtShowVScroll]
    OnKeyDown = HTMLLogViewerKeyDown
  end
  object LogFindDialog: TFindDialog
    OnFind = LogFindDialogFind
    Left = 272
    Top = 160
  end
  object LogPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Images = MainForm.AllImageList
    OnPopup = LogPopupMenuPopup
    Left = 240
    Top = 160
    object CopySelText_Menu: TMenuItem
      ImageIndex = 144
      OnClick = CopySelText_MenuClick
    end
    object CopyAllText_Menu: TMenuItem
      ImageIndex = 144
      OnClick = CopyAllText_MenuClick
    end
    object HexToText_Menu: TMenuItem
      ImageIndex = 289
      OnClick = HexToText_MenuClick
    end
    object ToUtf8Text_Menu: TMenuItem
      ImageIndex = 289
      OnClick = ToUtf8Text_MenuClick
    end
    object HexToUtf8Text_Menu: TMenuItem
      ImageIndex = 289
      OnClick = HexToUtf8Text_MenuClick
    end
    object HexToLEText_Menu: TMenuItem
      ImageIndex = 289
      OnClick = HexToLEText_MenuClick
    end
    object HexToBEText_Menu: TMenuItem
      ImageIndex = 289
      OnClick = HexToBEText_MenuClick
    end
  end
end
