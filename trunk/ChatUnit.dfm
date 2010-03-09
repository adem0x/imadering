object ChatForm: TChatForm
  Left = 93
  Top = 94
  ClientHeight = 414
  ClientWidth = 502
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ChatSplitter: TSplitter
    Left = 0
    Top = 247
    Width = 502
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    MinSize = 80
    OnMoved = ChatSplitterMoved
    ExplicitTop = 241
  end
  object CenterChatFormPanel: TPanel
    Left = 0
    Top = 94
    Width = 502
    Height = 153
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object GroupSplitter: TSplitter
      Left = 356
      Top = 0
      Height = 153
      Align = alRight
      AutoSnap = False
      ExplicitLeft = 428
      ExplicitHeight = 357
    end
    object ChatCategoryButtons: TCategoryButtons
      Left = 359
      Top = 0
      Width = 143
      Height = 153
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      BackgroundGradientDirection = gdVertical
      BevelKind = bkTile
      BorderStyle = bsNone
      ButtonFlow = cbfVertical
      ButtonHeight = 22
      ButtonOptions = [boAllowReorder, boFullSize, boGradientFill, boShowCaptions]
      Categories = <>
      Color = clWhite
      GradientDirection = gdVertical
      Images = MainForm.AllImageList
      RegularButtonColor = clWhite
      SelectedButtonColor = 15717318
      ShowHint = True
      TabOrder = 0
      OnButtonClicked = ChatCategoryButtonsButtonClicked
      OnContextPopup = ChatCategoryButtonsContextPopup
      OnHotButton = ChatCategoryButtonsHotButton
    end
    object HtmlPanel: TPanel
      Left = 0
      Top = 0
      Width = 356
      Height = 153
      Align = alClient
      BevelKind = bkTile
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object HTMLChatViewer: THTMLViewer
        Left = 0
        Top = 0
        Width = 352
        Height = 149
        Cursor = crDefault
        OnHotSpotClick = HTMLChatViewerHotSpotClick
        TabOrder = 0
        Align = alClient
        PopupMenu = HtmlPopupMenu
        DefBackground = clWhite
        BorderStyle = HtNone
        DefFontName = 'Times New Roman'
        DefPreFontName = 'Courier New'
        NoSelect = False
        ScrollBars = ssVertical
        CharSet = DEFAULT_CHARSET
        MarginHeight = 0
        MarginWidth = 5
        OnMouseMove = HTMLChatViewerMouseMove
        OnMouseDown = HTMLChatViewerMouseDown
        OnKeyDown = HTMLChatViewerKeyDown
        OnParseEnd = HTMLChatViewerParseEnd
      end
    end
  end
  object BottomChatFormPanel: TPanel
    Left = 0
    Top = 250
    Width = 502
    Height = 164
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object BottomToolsPanel: TPanel
      Left = 0
      Top = 129
      Width = 498
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        498
        31)
      object SendMessageSpeedButtonDrop: TSpeedButton
        Left = 388
        Top = 3
        Width = 15
        Height = 25
        Anchors = [akRight, akBottom]
        Glyph.Data = {
          96030000424D9603000000000000360000002800000020000000090000000100
          1800000000006003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000000000000000000000000000FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
          000000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000000000000000000000000000000000FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 3
        OnClick = SendMessageSpeedButtonDropClick
      end
      object CloseTabSpeedButtonDrop: TSpeedButton
        Left = 4
        Top = 3
        Width = 15
        Height = 25
        Anchors = [akLeft, akBottom]
        Glyph.Data = {
          96030000424D9603000000000000360000002800000020000000090000000100
          1800000000006003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000000000000000000000000000FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
          000000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000000000000000000000000000000000FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        NumGlyphs = 3
        OnClick = CloseTabSpeedButtonDropClick
      end
      object ChatToolBar: TToolBar
        AlignWithMargins = True
        Left = 111
        Top = 4
        Width = 271
        Height = 25
        Margins.Top = 4
        Margins.Bottom = 0
        Align = alNone
        Anchors = [akLeft, akRight, akBottom]
        DoubleBuffered = True
        Images = MainForm.AllImageList
        List = True
        ParentDoubleBuffered = False
        TabOrder = 0
        Transparent = False
        Wrapable = False
        object ChatFontToolButton: TToolButton
          Left = 0
          Top = 0
          ImageIndex = 217
          ParentShowHint = False
          ShowHint = True
          OnClick = ChatFontToolButtonClick
        end
        object UniqToolButton: TToolButton
          Left = 23
          Top = 0
          ImageIndex = 247
          ParentShowHint = False
          ShowHint = True
          OnClick = UniqToolButtonClick
        end
        object ContactMenuToolButton: TToolButton
          Left = 46
          Top = 0
          ImageIndex = 218
          ParentShowHint = False
          ShowHint = True
          OnClick = ContactMenuToolButtonClick
          OnContextPopup = ContactMenuToolButtonContextPopup
        end
        object ChatSettingsToolButton: TToolButton
          Left = 69
          Top = 0
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ChatSettingsToolButtonClick
        end
        object EnterKeyToolButton: TToolButton
          Left = 92
          Top = 0
          Down = True
          ImageIndex = 219
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
        end
        object TypingTextToolButton: TToolButton
          Left = 115
          Top = 0
          ImageIndex = 161
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
          OnClick = TypingTextToolButtonClick
        end
        object KeySoundToolButton: TToolButton
          Left = 138
          Top = 0
          ImageIndex = 183
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
        end
      end
      object SendMessageBitBtn: TBitBtn
        Left = 402
        Top = 3
        Width = 91
        Height = 25
        Anchors = [akRight, akBottom]
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        TabStop = False
        OnClick = SendMessageBitBtnClick
      end
      object CloseTabBitBtn: TBitBtn
        Left = 18
        Top = 3
        Width = 87
        Height = 25
        Anchors = [akLeft, akBottom]
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 2
        TabStop = False
        OnClick = CloseTabBitBtnClick
      end
    end
    object MemoPanel: TPanel
      Left = 0
      Top = 26
      Width = 498
      Height = 103
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object MyAvatarPanelSpeedButton: TSpeedButton
        Left = 425
        Top = 0
        Width = 7
        Height = 103
        Align = alRight
        Flat = True
        Glyph.Data = {
          96030000424D9603000000000000360000002800000020000000090000000100
          1800000000006003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
          000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = False
        Spacing = 0
        OnClick = MyAvatarPanelSpeedButtonClick
        ExplicitLeft = 412
        ExplicitTop = 22
        ExplicitHeight = 68
      end
      object MyAvatarPanel: TPanel
        Left = 432
        Top = 0
        Width = 66
        Height = 103
        Align = alRight
        BevelEdges = [beLeft, beTop, beBottom]
        BevelKind = bkTile
        BevelOuter = bvNone
        ParentShowHint = False
        ShowCaption = False
        ShowHint = True
        TabOrder = 0
        object MyAvatarImage: TImage
          Left = 0
          Top = 0
          Width = 64
          Height = 64
          Align = alTop
          Center = True
          ParentShowHint = False
          Proportional = True
          ShowHint = True
          Transparent = True
        end
      end
      object InputRichEdit: TRichEdit
        AlignWithMargins = True
        Left = 4
        Top = 0
        Width = 421
        Height = 103
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelKind = bkTile
        BorderStyle = bsNone
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PlainText = True
        PopupMenu = MemoPopupMenu
        ScrollBars = ssVertical
        TabOrder = 2
        OnChange = InputRichEditChange
        OnKeyDown = InputRichEditKeyDown
        OnKeyPress = InputRichEditKeyPress
      end
      object HTMLMsg: THTMLViewer
        Left = 183
        Top = 28
        Width = 205
        Height = 56
        Cursor = crDefault
        ViewImages = False
        TabOrder = 1
        DefBackground = clWhite
        BorderStyle = HtNone
        Visible = False
        DefFontName = 'Tahoma'
        DefPreFontName = 'Courier New'
        NoSelect = False
        ScrollBars = ssVertical
        CharSet = DEFAULT_CHARSET
      end
    end
    object TopToolsPanel: TPanel
      Left = 0
      Top = 0
      Width = 498
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        498
        26)
      object SmiliesSpeedButton: TSpeedButton
        Left = 56
        Top = 2
        Width = 23
        Height = 22
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = SmiliesSpeedButtonClick
      end
      object Bevel1: TBevel
        Left = 84
        Top = 3
        Width = 2
        Height = 19
        Shape = bsLeftLine
      end
      object QSpeedButton: TSpeedButton
        Left = 91
        Top = 2
        Width = 23
        Height = 22
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = QSpeedButtonClick
      end
      object QRepSpeedButton: TSpeedButton
        Left = 119
        Top = 2
        Width = 23
        Height = 22
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = QRepSpeedButtonClick
        OnMouseDown = QRepSpeedButtonMouseDown
      end
      object Bevel2: TBevel
        Left = 147
        Top = 3
        Width = 2
        Height = 19
        Shape = bsLeftLine
      end
      object HistorySpeedButton: TSpeedButton
        Left = 154
        Top = 2
        Width = 23
        Height = 22
        Flat = True
        ParentShowHint = False
        PopupMenu = HistoryShowPopupMenu
        ShowHint = True
        OnClick = HistorySpeedButtonClick
        OnMouseDown = HistorySpeedButtonMouseDown
      end
      object Bevel3: TBevel
        Left = 210
        Top = 3
        Width = 2
        Height = 19
        Shape = bsLeftLine
      end
      object ClearChatSpeedButton: TSpeedButton
        Left = 470
        Top = 2
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = ClearChatSpeedButtonClick
      end
      object SendFileSpeedButton: TSpeedButton
        Left = 182
        Top = 2
        Width = 23
        Height = 22
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = SendFileSpeedButtonClick
        OnMouseDown = SendFileSpeedButtonMouseDown
      end
      object GtransSpeedButton: TSpeedButton
        Left = 216
        Top = 2
        Width = 23
        Height = 22
        AllowAllUp = True
        GroupIndex = 1
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = GtransSpeedButtonClick
        OnMouseDown = GtransSpeedButtonMouseDown
      end
      object TextLenPanel: TPanel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 40
        Height = 18
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alLeft
        BevelOuter = bvLowered
        Caption = '0'
        TabOrder = 0
      end
      object NotifyPanel: TPanel
        Left = 244
        Top = 3
        Width = 221
        Height = 19
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvLowered
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
  end
  object TopChatFormPanel: TPanel
    Left = 0
    Top = 28
    Width = 502
    Height = 66
    Align = alTop
    BevelEdges = [beLeft, beTop, beRight]
    BevelKind = bkTile
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object ContactAvatarPanelSpeedButton: TSpeedButton
      Left = 66
      Top = 0
      Width = 7
      Height = 64
      Align = alLeft
      Flat = True
      Glyph.Data = {
        96030000424D9603000000000000360000002800000020000000090000000100
        1800000000006003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000
        000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 4
      ParentShowHint = False
      ShowHint = False
      Spacing = 0
      OnClick = ContactAvatarPanelSpeedButtonClick
      ExplicitLeft = 412
      ExplicitTop = 22
      ExplicitHeight = 68
    end
    object ContactAvatarPanel: TPanel
      Left = 0
      Top = 0
      Width = 66
      Height = 64
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelEdges = [beRight]
      BevelKind = bkTile
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object ContactAvatarImage: TImage
        Left = 0
        Top = 0
        Width = 64
        Height = 64
        Align = alClient
        Center = True
        Proportional = True
        Transparent = True
        ExplicitTop = 16
        ExplicitHeight = 52
      end
    end
    object TopInfoButtonPanel: TPanel
      Left = 468
      Top = 0
      Width = 30
      Height = 64
      Align = alRight
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object InfoContactSpeedButton: TSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 6
        Width = 23
        Height = 22
        Margins.Left = 2
        Margins.Top = 6
        Margins.Right = 5
        Align = alTop
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = InfoContactSpeedButtonClick
        ExplicitLeft = 10
      end
      object EditContactSpeedButton: TSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 36
        Width = 23
        Height = 22
        Margins.Left = 2
        Margins.Right = 5
        Margins.Bottom = 6
        Align = alBottom
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = EditContactSpeedButtonClick
        ExplicitLeft = 12
        ExplicitTop = 34
      end
    end
    object TopInfoPanelR: TPanel
      Left = 295
      Top = 0
      Width = 173
      Height = 64
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object InfoPanel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 6
        Width = 167
        Height = 22
        Cursor = crHandPoint
        Margins.Top = 6
        Align = alTop
        BevelOuter = bvLowered
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = InfoPanel2Click
      end
      object InfoPanel4: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 36
        Width = 167
        Height = 22
        Margins.Bottom = 6
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        object GenderImage: TImage
          AlignWithMargins = True
          Left = 4
          Top = 1
          Width = 20
          Height = 20
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Center = True
          Transparent = True
        end
      end
    end
    object TopInfoPanelL: TPanel
      Left = 73
      Top = 0
      Width = 222
      Height = 64
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object InfoPanel1: TPanel
        AlignWithMargins = True
        Left = 1
        Top = 6
        Width = 218
        Height = 22
        Cursor = crHandPoint
        Margins.Left = 1
        Margins.Top = 6
        Align = alTop
        BevelOuter = bvLowered
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = InfoPanel1Click
      end
      object InfoPanel3: TPanel
        AlignWithMargins = True
        Left = 1
        Top = 36
        Width = 218
        Height = 22
        Margins.Left = 1
        Margins.Bottom = 6
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
        object FlagImage: TImage
          AlignWithMargins = True
          Left = 4
          Top = 1
          Width = 20
          Height = 20
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Center = True
          ExplicitLeft = 1
        end
      end
    end
  end
  object ChatPageToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 502
    Height = 28
    AutoSize = True
    BorderWidth = 1
    DoubleBuffered = True
    EdgeBorders = [ebLeft, ebTop, ebRight]
    Images = MainForm.AllImageList
    List = True
    ParentDoubleBuffered = False
    ShowCaptions = True
    TabOrder = 3
  end
  object CloseTabPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 40
    Top = 104
    object CloseTabAllOffline: TMenuItem
      Tag = 1
      ImageIndex = 158
      OnClick = CloseTabAllOfflineClick
    end
    object CloseTabAllNoCurrent: TMenuItem
      Tag = 2
      ImageIndex = 158
      OnClick = CloseTabAllNoCurrentClick
    end
    object CloseTabAll: TMenuItem
      Tag = 3
      ImageIndex = 158
      OnClick = CloseTabAllClick
    end
  end
  object HistoryShowPopupMenu: TPopupMenu
    AutoPopup = False
    Images = MainForm.AllImageList
    Left = 160
    Top = 192
    object ShowAllHistory: TMenuItem
      Tag = 1
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
    object Show100History: TMenuItem
      Tag = 2
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
    object Show50History: TMenuItem
      Tag = 3
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
    object Show20History: TMenuItem
      Tag = 4
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
  end
  object MemoPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Images = MainForm.AllImageList
    OnPopup = MemoPopupMenuPopup
    Left = 16
    Top = 288
    object QRepMess: TMenuItem
      Tag = 1
      ImageIndex = 157
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CutMemo: TMenuItem
      Tag = 2
      ImageIndex = 145
      OnClick = CutMemoClick
    end
    object CopyMemo: TMenuItem
      Tag = 3
      ImageIndex = 144
      OnClick = CopyMemoClick
    end
    object CopyAllMemo: TMenuItem
      Tag = 4
      ImageIndex = 144
      OnClick = CopyAllMemoClick
    end
    object PasteMemo: TMenuItem
      Tag = 5
      ImageIndex = 146
      OnClick = PasteMemoClick
    end
  end
  object HtmlPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = HtmlPopupMenuPopup
    Left = 160
    Top = 152
    object ChatHTMLTextCopy: TMenuItem
      Tag = 1
      ImageIndex = 144
      OnClick = ChatHTMLTextCopyClick
    end
    object ChatHTMLAllTextCopy: TMenuItem
      Tag = 2
      ImageIndex = 144
      OnClick = ChatHTMLAllTextCopyClick
    end
    object ChatHTMLQText: TMenuItem
      Tag = 3
      ImageIndex = 216
      OnClick = ChatHTMLQTextClick
    end
    object ChatHTMLQTextTwitter: TMenuItem
      ImageIndex = 268
      OnClick = ChatHTMLQTextTwitterClick
    end
  end
  object QmessPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Images = MainForm.AllImageList
    Left = 120
    Top = 192
  end
  object SendPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 8
    Top = 104
    object SendAllOnline: TMenuItem
      ImageIndex = 166
      OnClick = SendAllOnlineClick
    end
    object SendAll: TMenuItem
      ImageIndex = 166
      OnClick = SendAllClick
    end
  end
  object TabPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 160
    Top = 112
    object CloseChatTabMenu: TMenuItem
      ImageIndex = 158
      OnClick = CloseChatTabMenuClick
    end
  end
  object ConfPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 416
    Top = 152
  end
  object ChatUserPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 48
    Top = 288
    object CloseLastChatMenu: TMenuItem
      ImageIndex = 158
      OnClick = CloseTabBitBtnClick
    end
  end
  object FileTransferPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 200
    Top = 192
    object SendUpWapRu: TMenuItem
      Tag = 1
      ImageIndex = 225
      OnClick = SendUpWapRuClick
    end
  end
end
