object IcqContactInfoForm: TIcqContactInfoForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 418
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object InfoLabel: TLabel
    Left = 145
    Top = 390
    Width = 3
    Height = 13
  end
  object AvatarImage: TImage
    Left = 8
    Top = 8
    Width = 64
    Height = 64
    Center = True
    Proportional = True
    Transparent = True
  end
  object HoroImage: TImage
    Left = 521
    Top = 8
    Width = 32
    Height = 64
  end
  object Bevel1: TBevel
    Left = 8
    Top = 377
    Width = 545
    Height = 2
    Shape = bsBottomLine
  end
  object ReqInfoBitBtn: TBitBtn
    Left = 8
    Top = 385
    Width = 121
    Height = 25
    Caption = '#'#1047#1072#1087#1088#1086#1089#1080#1090#1100
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    TabStop = False
    OnClick = ReqInfoBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 447
    Top = 385
    Width = 106
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    OnClick = OKBitBtnClick
  end
  object BottomHTMLViewer: THTMLViewer
    Left = 8
    Top = 78
    Width = 545
    Height = 293
    Cursor = crDefault
    TabOrder = 2
    PopupMenu = BottomPopupMenu
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
    OnMouseDown = BottomHTMLViewerMouseDown
    OnKeyDown = BottomHTMLViewerKeyDown
  end
  object TopHTMLViewer: THTMLViewer
    Left = 78
    Top = 8
    Width = 437
    Height = 64
    Cursor = crDefault
    TabOrder = 3
    PopupMenu = TopPopupMenu
    BorderStyle = htNone
    HistoryMaxCount = 0
    DefFontName = 'Times New Roman'
    DefPreFontName = 'Courier New'
    NoSelect = False
    ScrollBars = ssNone
    CharSet = DEFAULT_CHARSET
    PrintMarginLeft = 2.000000000000000000
    PrintMarginRight = 2.000000000000000000
    PrintMarginTop = 2.000000000000000000
    PrintMarginBottom = 2.000000000000000000
    PrintScale = 1.000000000000000000
    OnMouseDown = TopHTMLViewerMouseDown
    OnKeyDown = TopHTMLViewerKeyDown
  end
  object TopPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = TopPopupMenuPopup
    Left = 240
    Top = 16
    object TopCopyHTML: TMenuItem
      Caption = '#'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 144
      OnClick = TopCopyHTMLClick
    end
    object TopAllCopyHTML: TMenuItem
      Caption = '#'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1105
      ImageIndex = 144
      OnClick = TopAllCopyHTMLClick
    end
  end
  object BottomPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = BottomPopupMenuPopup
    Left = 240
    Top = 168
    object BottomCopyHTML: TMenuItem
      Caption = '#'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 144
      OnClick = BottomCopyHTMLClick
    end
    object BottomAllCopyHTML: TMenuItem
      Caption = '#'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1105
      ImageIndex = 144
      OnClick = BottomAllCopyHTMLClick
    end
  end
end
