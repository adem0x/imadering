object SmilesForm: TSmilesForm
  Left = 310
  Top = 144
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  Caption = 'Smilies'
  ClientHeight = 222
  ClientWidth = 282
  Color = clWindow
  TransparentColorValue = clWhite
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmAuto
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object BorderPanel: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 222
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object SmiliesHTMLViewer: THTMLViewer
      Left = 0
      Top = 0
      Width = 278
      Height = 218
      Cursor = crDefault
      OnHotSpotClick = SmiliesHTMLViewerHotSpotClick
      TabStop = True
      TabOrder = 0
      Align = alClient
      DefBackground = clWhite
      BorderStyle = htNone
      HistoryMaxCount = 0
      DefFontName = 'Times New Roman'
      DefPreFontName = 'Courier New'
      NoSelect = True
      ScrollBars = ssNone
      CharSet = DEFAULT_CHARSET
      PrintMarginLeft = 2.000000000000000000
      PrintMarginRight = 2.000000000000000000
      PrintMarginTop = 2.000000000000000000
      PrintMarginBottom = 2.000000000000000000
      PrintScale = 1.000000000000000000
      OnMouseMove = SmiliesHTMLViewerMouseMove
    end
  end
  object HintTimer: TTimer
    Interval = 200
    OnTimer = HintTimerTimer
    Left = 120
    Top = 72
  end
end
