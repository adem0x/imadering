object SmilesForm: TSmilesForm
  Left = 310
  Top = 144
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsNone
  ClientHeight = 222
  ClientWidth = 282
  Color = clWindow
  TransparentColorValue = clWhite
  Ctl3D = False
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
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
      ViewImages = False
      TabOrder = 0
      Align = alClient
      DefBackground = clWhite
      BorderStyle = HtNone
      DefFontName = 'Times New Roman'
      DefPreFontName = 'Courier New'
      NoSelect = True
      ScrollBars = ssNone
      CharSet = DEFAULT_CHARSET
      OnMouseMove = SmiliesHTMLViewerMouseMove
    end
  end
end
