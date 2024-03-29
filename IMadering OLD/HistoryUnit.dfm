object HistoryForm: THistoryForm
  Left = 0
  Top = 0
  ClientHeight = 500
  ClientWidth = 700
  Color = clBtnFace
  Constraints.MinHeight = 400
  DefaultMonitor = dmMainForm
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
  object PanelSplitter: TSplitter
    Left = 186
    Top = 0
    Height = 500
    AutoSnap = False
    MinSize = 130
    ExplicitLeft = 224
    ExplicitTop = 184
    ExplicitHeight = 100
  end
  object LeftPanel: TPanel
    Left = 0
    Top = 0
    Width = 186
    Height = 500
    Align = alLeft
    BevelEdges = [beRight]
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object HBevel: TBevel
      Left = 0
      Top = 99
      Width = 184
      Height = 1
      Align = alTop
      Shape = bsTopLine
    end
    object ContactSearchBitBtn: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 71
      Width = 178
      Height = 25
      Margins.Top = 0
      Align = alTop
      Caption = #1053#1072#1081#1090#1080' '#1082#1086#1085#1090#1072#1082#1090
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      TabStop = False
    end
    object HButtonGroup: TButtonGroup
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 178
      Height = 65
      Align = alTop
      BevelKind = bkTile
      BorderStyle = bsNone
      ButtonHeight = 20
      ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
      DoubleBuffered = True
      Images = MainForm.AllImageList
      Items = <
        item
          ImageIndex = 228
        end
        item
          ImageIndex = 245
        end
        item
          ImageIndex = 184
        end>
      ParentDoubleBuffered = False
      TabOrder = 1
      TabStop = False
      OnButtonClicked = HButtonGroupButtonClicked
    end
    object HCategoryPanelGroup: TCategoryPanelGroup
      Left = 0
      Top = 100
      Width = 184
      Height = 400
      HorzScrollBar.Visible = False
      VertScrollBar.Tracking = True
      VertScrollBar.Visible = False
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      Ctl3D = True
      GradientBaseColor = clWhite
      GradientColor = clActiveBorder
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Tahoma'
      HeaderFont.Style = []
      HeaderHeight = 20
      Images = MainForm.AllImageList
      ParentCtl3D = False
      TabOrder = 2
      OnCanResize = HCategoryPanelGroupCanResize
      object Bim_HCategoryPanel: TCategoryPanel
        Top = 270
        Height = 90
        Caption = 'Bimoid'
        Color = clWhite
        CollapsedHotImageIndex = 251
        CollapsedImageIndex = 251
        CollapsedPressedImageIndex = 251
        ExpandedHotImageIndex = 252
        ExpandedImageIndex = 252
        ExpandedPressedImageIndex = 252
        TabOrder = 0
        Visible = False
        object Bim_HCategoryButtons: TCategoryButtons
          Left = 0
          Top = 0
          Width = 180
          Height = 68
          Align = alClient
          BackgroundGradientColor = clWhite
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonFlow = cbfVertical
          ButtonHeight = 20
          ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder]
          Categories = <>
          DoubleBuffered = True
          GradientDirection = gdVertical
          Images = MainForm.AllImageList
          ParentDoubleBuffered = False
          RegularButtonColor = clWhite
          SelectedButtonColor = 15717318
          ShowHint = True
          TabOrder = 0
          TabStop = False
          OnButtonClicked = CategoryButtonsButtonClicked
        end
      end
      object MRA_HCategoryPanel: TCategoryPanel
        Top = 180
        Height = 90
        Caption = 'MRA'
        Color = clWhite
        CollapsedHotImageIndex = 251
        CollapsedImageIndex = 251
        CollapsedPressedImageIndex = 251
        ExpandedHotImageIndex = 252
        ExpandedImageIndex = 252
        ExpandedPressedImageIndex = 252
        TabOrder = 1
        Visible = False
        object MRA_HCategoryButtons: TCategoryButtons
          Left = 0
          Top = 0
          Width = 180
          Height = 68
          Align = alClient
          BackgroundGradientColor = clWhite
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonFlow = cbfVertical
          ButtonHeight = 20
          ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder]
          Categories = <>
          DoubleBuffered = True
          GradientDirection = gdVertical
          Images = MainForm.AllImageList
          ParentDoubleBuffered = False
          RegularButtonColor = clWhite
          SelectedButtonColor = 15717318
          ShowHint = True
          TabOrder = 0
          TabStop = False
          OnButtonClicked = CategoryButtonsButtonClicked
        end
      end
      object Jab_HCategoryPanel: TCategoryPanel
        Top = 90
        Height = 90
        Caption = 'Jabber'
        Color = clWhite
        CollapsedHotImageIndex = 251
        CollapsedImageIndex = 251
        CollapsedPressedImageIndex = 251
        ExpandedHotImageIndex = 252
        ExpandedImageIndex = 252
        ExpandedPressedImageIndex = 252
        TabOrder = 2
        Visible = False
        object Jab_HCategoryButtons: TCategoryButtons
          Left = 0
          Top = 0
          Width = 180
          Height = 68
          Align = alClient
          BackgroundGradientColor = clWhite
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonFlow = cbfVertical
          ButtonHeight = 20
          ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder]
          Categories = <>
          DoubleBuffered = True
          GradientDirection = gdVertical
          Images = MainForm.AllImageList
          ParentDoubleBuffered = False
          RegularButtonColor = clWhite
          SelectedButtonColor = 15717318
          ShowHint = True
          TabOrder = 0
          TabStop = False
          OnButtonClicked = CategoryButtonsButtonClicked
        end
      end
      object ICQ_HCategoryPanel: TCategoryPanel
        Top = 0
        Height = 90
        Caption = 'ICQ'
        Color = clWhite
        CollapsedHotImageIndex = 251
        CollapsedImageIndex = 251
        CollapsedPressedImageIndex = 251
        ExpandedHotImageIndex = 252
        ExpandedImageIndex = 252
        ExpandedPressedImageIndex = 252
        TabOrder = 3
        Visible = False
        object ICQ_HCategoryButtons: TCategoryButtons
          Left = 0
          Top = 0
          Width = 180
          Height = 68
          Align = alClient
          BackgroundGradientColor = clWhite
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonFlow = cbfVertical
          ButtonHeight = 20
          ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder]
          Categories = <>
          DoubleBuffered = True
          GradientDirection = gdVertical
          Images = MainForm.AllImageList
          ParentDoubleBuffered = False
          RegularButtonColor = clWhite
          SelectedButtonColor = 15717318
          ShowHint = True
          TabOrder = 0
          TabStop = False
          OnButtonClicked = CategoryButtonsButtonClicked
        end
      end
    end
  end
  object RightPanel: TPanel
    Left = 189
    Top = 0
    Width = 511
    Height = 500
    Align = alClient
    BevelEdges = [beLeft]
    BevelKind = bkTile
    BevelOuter = bvNone
    Constraints.MinWidth = 511
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    object BottomPanel: TPanel
      Left = 0
      Top = 465
      Width = 509
      Height = 35
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      object ReloadHistoryBitBtn: TBitBtn
        Left = 7
        Top = 4
        Width = 135
        Height = 25
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        TabStop = False
        OnClick = ReloadHistoryBitBtnClick
      end
      object SaveHistoryAsBitBtn: TBitBtn
        Left = 148
        Top = 4
        Width = 135
        Height = 25
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        TabStop = False
        OnClick = SaveHistoryAsBitBtnClick
      end
      object DeleteHistoryBitBtn: TBitBtn
        Left = 289
        Top = 4
        Width = 135
        Height = 25
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        TabStop = False
        OnClick = DeleteHistoryBitBtnClick
      end
      object MessCountPanel: TPanel
        AlignWithMargins = True
        Left = 434
        Top = 6
        Width = 65
        Height = 21
        Margins.Left = 0
        Margins.Top = 6
        Margins.Right = 10
        Margins.Bottom = 6
        Align = alRight
        BevelOuter = bvLowered
        Caption = '0'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
    object HTMLHistoryViewer: THTMLViewer
      Left = 0
      Top = 114
      Width = 509
      Height = 351
      Cursor = crDefault
      OnHotSpotClick = HTMLHistoryViewerHotSpotClick
      TabOrder = 1
      Align = alClient
      PopupMenu = HistoryPopupMenu
      DefBackground = clWhite
      BorderStyle = HtNone
      DefFontName = 'Times New Roman'
      DefPreFontName = 'Courier New'
      NoSelect = False
      ScrollBars = ssVertical
      CharSet = DEFAULT_CHARSET
      HtOptions = [HtPrintTableBackground, HtPrintMonochromeBlack, HtShowVScroll]
      OnMouseMove = HTMLHistoryViewerMouseMove
      OnKeyDown = HTMLHistoryViewerKeyDown
    end
    object TopPanel: TPanel
      Left = 0
      Top = 0
      Width = 509
      Height = 114
      Align = alTop
      BevelEdges = [beBottom]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 2
      object TextSearchGroupBox: TGroupBox
        Left = 4
        Top = 3
        Width = 500
        Height = 105
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object ArchivesLabel: TLabel
          Left = 224
          Top = 58
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object SBevel: TBevel
          Left = 215
          Top = 15
          Width = 2
          Height = 83
          Shape = bsLeftLine
        end
        object SearchTextLabel: TLabel
          Left = 224
          Top = 12
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ArchivesComboBox: TComboBox
          Left = 223
          Top = 77
          Width = 270
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
        end
        object SearchTextEdit: TEdit
          Left = 223
          Top = 31
          Width = 160
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object SearchTextBitBtn: TBitBtn
          Left = 389
          Top = 29
          Width = 104
          Height = 25
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 2
          TabStop = False
          OnClick = SearchTextBitBtnClick
        end
        object RegistrCheckBox: TCheckBox
          Left = 8
          Top = 24
          Width = 130
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
        object FullSearchTextCheckBox: TCheckBox
          Left = 8
          Top = 47
          Width = 130
          Height = 17
          TabStop = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object UpSearchCheckBox: TRadioButton
          Left = 144
          Top = 24
          Width = 65
          Height = 17
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          TabStop = True
        end
        object DownSearchCheckBox: TRadioButton
          Left = 144
          Top = 47
          Width = 65
          Height = 17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object SearchStatusPanel: TPanel
          Left = 8
          Top = 77
          Width = 201
          Height = 21
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
    end
  end
  object HistoryPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
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
