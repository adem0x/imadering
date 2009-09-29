object ChatForm: TChatForm
  Left = 93
  Top = 94
  Caption = #1054#1082#1085#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
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
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
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
    Top = 70
    Width = 502
    Height = 177
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupSplitter: TSplitter
      Left = 356
      Top = 0
      Height = 177
      Align = alRight
      AutoSnap = False
      ExplicitLeft = 428
      ExplicitHeight = 357
    end
    object ChatCategoryButtons: TCategoryButtons
      Left = 359
      Top = 0
      Width = 143
      Height = 177
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alRight
      BevelKind = bkTile
      BorderStyle = bsNone
      ButtonFlow = cbfVertical
      ButtonHeight = 22
      ButtonOptions = [boAllowReorder, boFullSize, boGradientFill, boShowCaptions]
      Images = MainForm.AllImageList
      BackgroundGradientDirection = gdVertical
      Categories = <>
      Color = clWhite
      GradientDirection = gdVertical
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
      Height = 177
      Align = alClient
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      object HTMLChatViewer: THTMLViewer
        Left = 0
        Top = 0
        Width = 352
        Height = 173
        Cursor = crDefault
        OnHotSpotClick = HTMLChatViewerHotSpotClick
        TabOrder = 0
        Align = alClient
        PopupMenu = HtmlPopupMenu
        DefBackground = clWhite
        BorderStyle = htNone
        HistoryMaxCount = 0
        DefFontName = 'Times New Roman'
        DefPreFontName = 'Courier New'
        NoSelect = False
        ScrollBars = ssVertical
        CharSet = DEFAULT_CHARSET
        MarginHeight = 0
        MarginWidth = 5
        PrintMarginLeft = 2.000000000000000000
        PrintMarginRight = 2.000000000000000000
        PrintMarginTop = 2.000000000000000000
        PrintMarginBottom = 2.000000000000000000
        PrintScale = 1.000000000000000000
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
    TabOrder = 1
    object BottomToolsPanel: TPanel
      Left = 0
      Top = 129
      Width = 498
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        498
        31)
      object SendMessageSpeedButtonDrop: TSpeedButton
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
        OnClick = SendMessageSpeedButtonDropClick
      end
      object CloseTabSpeedButtonDrop: TSpeedButton
        Left = 392
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
        OnClick = CloseTabSpeedButtonDropClick
      end
      object ChatToolBar: TToolBar
        AlignWithMargins = True
        Left = 115
        Top = 4
        Width = 271
        Height = 25
        Margins.Top = 4
        Margins.Bottom = 0
        Align = alNone
        Anchors = [akLeft, akRight, akBottom]
        Images = MainForm.AllImageList
        TabOrder = 0
        Transparent = True
        Wrapable = False
        object ChatFontToolButton: TToolButton
          Left = 0
          Top = 0
          ImageIndex = 217
          ParentShowHint = False
          ShowHint = True
          OnClick = ChatFontToolButtonClick
        end
        object ContactMenuToolButton: TToolButton
          Left = 23
          Top = 0
          ImageIndex = 218
          OnClick = ContactMenuToolButtonClick
          OnContextPopup = ContactMenuToolButtonContextPopup
        end
        object ChatSettingsToolButton: TToolButton
          Left = 46
          Top = 0
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ChatSettingsToolButtonClick
        end
        object EnterKeyToolButton: TToolButton
          Left = 69
          Top = 0
          ImageIndex = 219
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
        end
        object TypingTextToolButton: TToolButton
          Left = 92
          Top = 0
          ImageIndex = 161
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
          OnClick = TypingTextToolButtonClick
        end
        object KeySoundToolButton: TToolButton
          Left = 115
          Top = 0
          Caption = 'KeySoundToolButton'
          ImageIndex = 183
          ParentShowHint = False
          ShowHint = True
          Style = tbsCheck
        end
      end
      object SendMessageBitBtn: TBitBtn
        Left = 18
        Top = 3
        Width = 91
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
        TabOrder = 1
        TabStop = False
        OnClick = SendMessageBitBtnClick
      end
      object CloseTabBitBtn: TBitBtn
        Left = 406
        Top = 3
        Width = 87
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #1047#1072#1082#1088#1099#1090#1100
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
      TabOrder = 1
      object MyAvatarPanelSpeedButton: TSpeedButton
        Left = 423
        Top = 0
        Width = 7
        Height = 103
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
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
        ShowHint = True
        Spacing = 0
        OnClick = MyAvatarPanelSpeedButtonClick
        ExplicitLeft = 412
        ExplicitTop = 22
        ExplicitHeight = 68
      end
      object InputMemo: TMemo
        Left = 0
        Top = 0
        Width = 423
        Height = 103
        Align = alClient
        BevelKind = bkTile
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        HideSelection = False
        ParentFont = False
        PopupMenu = MemoPopupMenu
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = InputMemoChange
        OnKeyDown = InputMemoKeyDown
        OnKeyPress = InputMemoKeyPress
      end
      object MyAvatarPanel: TPanel
        Left = 430
        Top = 0
        Width = 68
        Height = 103
        Align = alRight
        BevelKind = bkTile
        BevelOuter = bvNone
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
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
        end
      end
      object HTMLMsg: THTMLViewer
        Left = 183
        Top = 28
        Width = 205
        Height = 56
        Cursor = crDefault
        ViewImages = False
        TabOrder = 2
        DefBackground = clWhite
        BorderStyle = htNone
        Visible = False
        HistoryMaxCount = 0
        DefFontName = 'Tahoma'
        DefPreFontName = 'Courier New'
        NoSelect = False
        ScrollBars = ssVertical
        CharSet = DEFAULT_CHARSET
        PrintMarginLeft = 2.000000000000000000
        PrintMarginRight = 2.000000000000000000
        PrintMarginTop = 2.000000000000000000
        PrintMarginBottom = 2.000000000000000000
        PrintScale = 1.000000000000000000
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
        OnClick = QSpeedButtonClick
      end
      object QRepSpeedButton: TSpeedButton
        Left = 119
        Top = 2
        Width = 23
        Height = 22
        Flat = True
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
        PopupMenu = HistoryShowPopupMenu
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
        OnClick = ClearChatSpeedButtonClick
      end
      object SendFileSpeedButton: TSpeedButton
        Left = 182
        Top = 2
        Width = 23
        Height = 22
        Flat = True
        OnClick = SendFileSpeedButtonClick
        OnMouseDown = SendFileSpeedButtonMouseDown
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
        Left = 218
        Top = 3
        Width = 247
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
        TabOrder = 1
      end
    end
  end
  object TopChatFormPanel: TPanel
    Left = 0
    Top = 1
    Width = 502
    Height = 69
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      502
      69)
    object InfoContactSpeedButton: TSpeedButton
      AlignWithMargins = True
      Left = 474
      Top = 8
      Width = 23
      Height = 22
      Margins.Right = 0
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = InfoContactSpeedButtonClick
    end
    object EditContactSpeedButton: TSpeedButton
      AlignWithMargins = True
      Left = 474
      Top = 38
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = EditContactSpeedButtonClick
    end
    object ContactAvatarPanelSpeedButton: TSpeedButton
      Left = 69
      Top = 0
      Width = 7
      Height = 69
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
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
      ShowHint = True
      Spacing = 0
      OnClick = ContactAvatarPanelSpeedButtonClick
      ExplicitLeft = 412
      ExplicitTop = 22
      ExplicitHeight = 68
    end
    object InfoPanel1: TPanel
      AlignWithMargins = True
      Left = 77
      Top = 8
      Width = 204
      Height = 22
      Margins.Left = 5
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvLowered
      TabOrder = 0
    end
    object InfoPanel2: TPanel
      AlignWithMargins = True
      Left = 287
      Top = 8
      Width = 181
      Height = 22
      Anchors = [akTop, akRight]
      BevelOuter = bvLowered
      TabOrder = 1
    end
    object InfoPanel3: TPanel
      Left = 77
      Top = 38
      Width = 204
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvLowered
      TabOrder = 2
    end
    object InfoPanel4: TPanel
      Left = 287
      Top = 38
      Width = 181
      Height = 22
      Anchors = [akTop, akRight]
      BevelOuter = bvLowered
      TabOrder = 3
    end
    object ContactAvatarPanel: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 1
      Width = 68
      Height = 68
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 4
      object ContactAvatarImage: TImage
        Left = 0
        Top = 0
        Width = 64
        Height = 64
        Align = alClient
        Center = True
        Proportional = True
        ExplicitTop = 16
        ExplicitHeight = 52
      end
    end
  end
  object ChatPageControl: TPageControl
    Left = 0
    Top = 0
    Width = 502
    Height = 1
    Align = alTop
    Images = MainForm.AllImageList
    MultiLine = True
    ParentShowHint = False
    ShowHint = True
    TabHeight = 22
    TabOrder = 3
    Visible = False
    OnChange = ChatPageControlChange
    OnMouseDown = ChatPageControlMouseDown
    OnMouseMove = ChatPageControlMouseMove
  end
  object CloseTabPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 40
    Top = 80
    object CloseTabAllOffline: TMenuItem
      Tag = 1
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077', '#1082#1090#1086' '#1085#1077' '#1074' '#1089#1077#1090#1080
      ImageIndex = 158
      OnClick = CloseTabAllOfflineClick
    end
    object CloseTabAllNoCurrent: TMenuItem
      Tag = 2
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077', '#1082#1088#1086#1084#1077' '#1090#1077#1082#1091#1097#1077#1075#1086
      ImageIndex = 158
      OnClick = CloseTabAllNoCurrentClick
    end
    object CloseTabAll: TMenuItem
      Tag = 3
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
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
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1102' '#1080#1089#1090#1086#1088#1080#1102
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
    object Show100History: TMenuItem
      Tag = 2
      Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1077' 100 '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
    object Show50History: TMenuItem
      Tag = 3
      Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1077' 50 '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
    object Show20History: TMenuItem
      Tag = 4
      Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1077' 20 '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 147
      OnClick = ShowAllHistoryClick
    end
  end
  object MemoPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = MemoPopupMenuPopup
    Left = 64
    Top = 312
    object QRepMess: TMenuItem
      Tag = 1
      Caption = #1054#1090#1074#1077#1090
      ImageIndex = 157
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CutMemo: TMenuItem
      Tag = 2
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      ImageIndex = 145
      OnClick = CutMemoClick
    end
    object CopyMemo: TMenuItem
      Tag = 3
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 144
      OnClick = CopyMemoClick
    end
    object CopyAllMemo: TMenuItem
      Tag = 4
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1105
      ImageIndex = 144
      OnClick = CopyAllMemoClick
    end
    object PasteMemo: TMenuItem
      Tag = 5
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 146
      OnClick = PasteMemoClick
    end
  end
  object HtmlPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = HtmlPopupMenuPopup
    Left = 160
    Top = 112
    object ChatHTMLTextCopy: TMenuItem
      Tag = 1
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 144
      OnClick = ChatHTMLTextCopyClick
    end
    object ChatHTMLAllTextCopy: TMenuItem
      Tag = 2
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1105
      ImageIndex = 144
      OnClick = ChatHTMLAllTextCopyClick
    end
    object ChatHTMLQText: TMenuItem
      Tag = 3
      Caption = #1062#1080#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 216
      OnClick = ChatHTMLQTextClick
    end
  end
  object QmessPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 120
    Top = 192
  end
  object SendPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 8
    Top = 80
    object SendAllOnline: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1089#1077#1084', '#1082#1090#1086' '#1074' '#1089#1077#1090#1080
      ImageIndex = 166
      OnClick = SendAllOnlineClick
    end
    object SendAll: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1089#1077#1084
      ImageIndex = 166
      OnClick = SendAllClick
    end
  end
  object TabPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 232
    Top = 80
    object CloseChatTabMenu: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1074#1082#1083#1072#1076#1082#1091
      ImageIndex = 158
      OnClick = CloseChatTabMenuClick
    end
  end
  object ConfPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 416
    Top = 136
  end
  object ChatUserPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 136
    Top = 344
    object CloseLastChatMenu: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1101#1090#1086#1090' '#1095#1072#1090
      ImageIndex = 158
      OnClick = CloseTabBitBtnClick
    end
  end
  object FileTransferPopupMenu: TPopupMenu
    Images = MainForm.AllImageList
    Left = 200
    Top = 192
    object UpWapru1: TMenuItem
      Tag = 1
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1095#1077#1088#1077#1079' UpWap.ru'
      ImageIndex = 149
      OnClick = UpWapru1Click
    end
  end
end
