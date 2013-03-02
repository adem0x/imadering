object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  ClientHeight = 401
  ClientWidth = 305
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 100
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ContactList: TCategoryButtons
    Left = 0
    Top = 26
    Width = 305
    Height = 127
    Align = alTop
    BackgroundGradientColor = clWhite
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ButtonFlow = cbfVertical
    ButtonHeight = 20
    ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder]
    Categories = <>
    Color = clWhite
    DoubleBuffered = True
    GradientDirection = gdVertical
    Images = AllImageList
    ParentDoubleBuffered = False
    PopupMenu = ContactListPopupMenu
    RegularButtonColor = clWhite
    SelectedButtonColor = 15717318
    ShowHint = True
    TabOrder = 0
    TabStop = False
    OnButtonClicked = ContactListButtonClicked
    OnCategoryCollapase = ContactListCategoryCollapase
    OnContextPopup = ContactListContextPopup
    OnHotButton = ContactListHotButton
    OnMouseDown = ContactListMouseDown
  end
  object BottomToolBar: TToolBar
    Left = 0
    Top = 376
    Width = 305
    Height = 25
    Align = alBottom
    Color = clBtnFace
    DoubleBuffered = True
    EdgeBorders = [ebTop]
    Images = AllImageList
    List = True
    ParentColor = False
    ParentDoubleBuffered = False
    TabOrder = 1
    Transparent = False
    Wrapable = False
    OnMouseDown = BottomToolBarMouseDown
    object MainToolButton: TToolButton
      Left = 0
      Top = 0
      ImageIndex = 0
      ParentShowHint = False
      PopupMenu = MainPopupMenu
      ShowHint = True
      OnClick = MainToolButtonClick
      OnContextPopup = MainToolButtonContextPopup
    end
    object ICQToolButton: TToolButton
      Left = 23
      Top = 0
      ImageIndex = 9
      ParentShowHint = False
      PopupMenu = ICQPopupMenu
      ShowHint = True
      Visible = False
      OnClick = ICQToolButtonClick
      OnContextPopup = ICQToolButtonContextPopup
    end
    object JabberToolButton: TToolButton
      Left = 46
      Top = 0
      ImageIndex = 30
      ParentShowHint = False
      PopupMenu = JabberPopupMenu
      ShowHint = True
      Visible = False
      OnClick = JabberToolButtonClick
      OnContextPopup = JabberToolButtonContextPopup
    end
    object MRAToolButton: TToolButton
      Left = 69
      Top = 0
      ImageIndex = 23
      ParentShowHint = False
      PopupMenu = MRAPopupMenu
      ShowHint = True
      Visible = False
      OnClick = MRAToolButtonClick
      OnContextPopup = MRAToolButtonContextPopup
    end
    object BimoidToolButton: TToolButton
      Left = 92
      Top = 0
      ImageIndex = 298
      ParentShowHint = False
      PopupMenu = BimoidPopupMenu
      ShowHint = True
      Visible = False
      OnClick = BimoidToolButtonClick
      OnContextPopup = BimoidToolButtonContextPopup
    end
    object OnlyOnlineContactsToolButton: TToolButton
      Left = 115
      Top = 0
      ImageIndex = 138
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      Visible = False
      OnClick = OnlyOnlineContactsToolButtonClick
    end
    object SoundOnOffToolButton: TToolButton
      Left = 138
      Top = 0
      ImageIndex = 135
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      Visible = False
      OnClick = SoundOnOffToolButtonClick
    end
    object HistoryToolButton: TToolButton
      Left = 161
      Top = 0
      ImageIndex = 147
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = History_MenuClick
    end
    object SettingsToolButton: TToolButton
      Left = 184
      Top = 0
      ImageIndex = 2
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = Settings_MenuClick
    end
    object CLSearchToolButton: TToolButton
      Left = 207
      Top = 0
      ImageIndex = 215
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = SearchInCL_MenuClick
    end
    object TrafficToolButton: TToolButton
      Left = 230
      Top = 0
      ImageIndex = 226
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = Traffic_MenuClick
    end
    object TopPanelToolButton: TToolButton
      Left = 253
      Top = 0
      Down = True
      ImageIndex = 244
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = TopPanelToolButtonClick
    end
    object PluginsToolButton: TToolButton
      Left = 276
      Top = 0
      ImageIndex = 184
      ParentShowHint = False
      PopupMenu = PluginsPopupMenu
      ShowHint = True
      Visible = False
      OnClick = PluginsToolButtonClick
      OnContextPopup = PluginsToolButtonContextPopup
    end
  end
  object TopToolBar: TToolBar
    AlignWithMargins = True
    Left = 0
    Top = 1
    Width = 305
    Height = 25
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Color = clBtnFace
    DoubleBuffered = True
    EdgeBorders = [ebBottom]
    Images = AllImageList
    List = True
    ParentColor = False
    ParentDoubleBuffered = False
    TabOrder = 2
    Transparent = False
    Wrapable = False
    OnMouseDown = TopToolBarMouseDown
    object MainToolTopButton: TToolButton
      Left = 0
      Top = 0
      ImageIndex = 0
      ParentShowHint = False
      PopupMenu = MainPopupMenu
      ShowHint = True
      OnClick = MainToolTopButtonClick
      OnContextPopup = MainToolTopButtonContextPopup
    end
    object OnlyOnlineContactsTopButton: TToolButton
      Left = 23
      Top = 0
      ImageIndex = 138
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = OnlyOnlineContactsTopButtonClick
    end
    object SoundOnOffToolTopButton: TToolButton
      Left = 46
      Top = 0
      ImageIndex = 135
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = SoundOnOffToolTopButtonClick
    end
    object HistoryTopToolButton: TToolButton
      Left = 69
      Top = 0
      ImageIndex = 147
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = History_MenuClick
    end
    object SettingsTopToolButton: TToolButton
      Left = 92
      Top = 0
      ImageIndex = 2
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = Settings_MenuClick
    end
    object CLSearchTopToolButton: TToolButton
      Left = 115
      Top = 0
      ImageIndex = 215
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = SearchInCL_MenuClick
    end
    object TrafficTopToolButton: TToolButton
      Left = 138
      Top = 0
      ImageIndex = 226
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = Traffic_MenuClick
    end
    object TopModeToolButton: TToolButton
      Left = 161
      Top = 0
      ImageIndex = 288
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = TopModeToolButtonClick
    end
  end
  object NewMessPanel: TPanel
    Left = 0
    Top = 358
    Width = 305
    Height = 18
    Cursor = crHandPoint
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clInfoBk
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Visible = False
    OnClick = NewMessPanelClick
  end
  object HCategoryPanelGroup: TCategoryPanelGroup
    Left = 0
    Top = 153
    Width = 305
    Height = 205
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
    Images = AllImageList
    ParentCtl3D = False
    TabOrder = 4
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
        Width = 301
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
        Images = AllImageList
        ParentDoubleBuffered = False
        RegularButtonColor = clWhite
        SelectedButtonColor = 15717318
        ShowHint = True
        TabOrder = 0
        TabStop = False
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
        Width = 301
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
        Images = AllImageList
        ParentDoubleBuffered = False
        RegularButtonColor = clWhite
        SelectedButtonColor = 15717318
        ShowHint = True
        TabOrder = 0
        TabStop = False
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
        Width = 301
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
        Images = AllImageList
        ParentDoubleBuffered = False
        RegularButtonColor = clWhite
        SelectedButtonColor = 15717318
        ShowHint = True
        TabOrder = 0
        TabStop = False
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
        Width = 301
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
        Images = AllImageList
        ParentDoubleBuffered = False
        RegularButtonColor = clWhite
        SelectedButtonColor = 15717318
        ShowHint = True
        TabOrder = 0
        TabStop = False
      end
    end
  end
  object AllImageList: TImageList
    Left = 200
    Top = 48
  end
  object JvTimerList: TJvTimerList
    Events = <
      item
        Name = 'Profile Form Timer'
        Cycled = False
        Enabled = False
        Interval = 1
        OnTimer = JvTimerListEvents0Timer
      end
      item
        Name = 'Messages Icons Timer'
        Enabled = False
        OnTimer = JvTimerListEvents1Timer
      end
      item
        Name = 'Check Update Timer'
        Cycled = False
        Enabled = False
        Interval = 10000
        OnTimer = JvTimerListEvents2Timer
      end
      item
        Name = 'Sounds Queue'
        Cycled = False
        Enabled = False
      end
      item
        Name = 'ICQ FStatus Timer'
        Enabled = False
        Interval = 20000
        OnTimer = JvTimerListEvents4Timer
      end
      item
        Name = 'ICQ Alive Timer'
        Enabled = False
        Interval = 60000
        OnTimer = JvTimerListEvents5Timer
      end
      item
        Name = 'Auto Hide CL Timer'
        Enabled = False
        Interval = 10000
        OnTimer = JvTimerListEvents6Timer
      end
      item
        Name = 'Create Smilies Timer'
        Cycled = False
        Enabled = False
        Interval = 2000
        OnTimer = JvTimerListEvents7Timer
      end
      item
        Name = 'Gtranslation Timer'
        Enabled = False
        Interval = 3000
        OnTimer = JvTimerListEvents8Timer
      end
      item
        Name = 'Jabber Alive Timer'
        Enabled = False
        Interval = 60000
        OnTimer = JvTimerListEvents9Timer
      end
      item
        Name = 'MRA Alive Timer'
        Enabled = False
        Interval = 30000
        OnTimer = JvTimerListEvents10Timer
      end
      item
        Name = 'Roster Timer'
        Cycled = False
        Enabled = False
        Interval = 3000
        OnTimer = JvTimerListEvents11Timer
      end
      item
        Name = 'Tray Refresh Timer'
        Enabled = False
        Interval = 20000
        OnTimer = JvTimerListEvents12Timer
      end
      item
        Name = 'About Timer'
        Cycled = False
        Enabled = False
        Interval = 5000
        OnTimer = JvTimerListEvents13Timer
      end
      item
        Name = 'Smilies Hint Timer'
        Enabled = False
        Interval = 200
        OnTimer = JvTimerListEvents14Timer
      end
      item
        Name = 'Snap CL Timer'
        Cycled = False
        Enabled = False
        Interval = 100
        OnTimer = JvTimerListEvents15Timer
      end
      item
        Name = 'ICQBos Connect Timer'
        Cycled = False
        Enabled = False
        OnTimer = JvTimerListEvents16Timer
      end
      item
        Name = 'Plugins Data Timer'
        Enabled = False
        OnTimer = JvTimerListEvents17Timer
      end>
    Left = 168
    Top = 80
  end
  object MainPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 16
    Top = 288
    object OpenGame_Menu: TMenuItem
      ImageIndex = 60
      OnClick = OpenGame_MenuClick
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object SnapCL_Menu: TMenuItem
      ImageIndex = 278
      object SnapToRight: TMenuItem
        ImageIndex = 279
        OnClick = SnapToRightClick
      end
      object SnapToLeft: TMenuItem
        ImageIndex = 280
        OnClick = SnapToRightClick
      end
    end
    object N39: TMenuItem
      Caption = '-'
    end
    object PostInTwitter_Menu: TMenuItem
      ImageIndex = 268
      OnClick = PostInTwitter_MenuClick
    end
    object LinkCompress_Menu: TMenuItem
      ImageIndex = 193
      OnClick = LinkCompress_MenuClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object SearchInCL_Menu: TMenuItem
      ImageIndex = 215
      OnClick = SearchInCL_MenuClick
    end
    object Traffic_Menu: TMenuItem
      ImageIndex = 226
      OnClick = Traffic_MenuClick
    end
    object History_Menu: TMenuItem
      ImageIndex = 147
      OnClick = History_MenuClick
    end
    object Settings_Menu: TMenuItem
      ImageIndex = 2
      OnClick = Settings_MenuClick
    end
    object N29: TMenuItem
      Caption = '-'
    end
    object CheckUpdate_Menu: TMenuItem
      ImageIndex = 6
      OnClick = CheckUpdate_MenuClick
    end
    object AboutIMadering_Menu: TMenuItem
      ImageIndex = 0
      OnClick = AboutIMadering_MenuClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object SwitchProfile_Menu: TMenuItem
      ImageIndex = 253
      OnClick = SwitchProfile_MenuClick
    end
    object HideInTray_Menu: TMenuItem
      ImageIndex = 4
      OnClick = HideInTray_MenuClick
    end
    object CloseProgram_Menu: TMenuItem
      ImageIndex = 3
      OnClick = CloseProgram_MenuClick
    end
  end
  object ICQWSocket: TWSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    MultiThreaded = False
    MultiCast = False
    MultiCastIpTTL = 1
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    KeepAliveOnOff = wsKeepAliveOff
    KeepAliveTime = 0
    KeepAliveInterval = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    LastError = 0
    ReuseAddr = False
    ComponentOptions = []
    ListenBacklog = 5
    ReqVerLow = 1
    ReqVerHigh = 1
    OnDataAvailable = ICQWSocketDataAvailable
    OnSendData = ICQWSocketSendData
    OnSessionClosed = ICQWSocketSessionClosed
    OnSessionAvailable = ICQWSocketSessionAvailable
    OnSessionConnected = ICQWSocketSessionConnected
    OnSocksConnected = ICQWSocketSocksConnected
    OnError = ICQWSocketError
    OnBgException = SocketBgException
    OnSocksError = ICQWSocketSocksError
    Left = 16
    Top = 32
  end
  object MRAWSocket: TWSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    MultiThreaded = False
    MultiCast = False
    MultiCastIpTTL = 1
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    KeepAliveOnOff = wsKeepAliveOff
    KeepAliveTime = 0
    KeepAliveInterval = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    LastError = 0
    ReuseAddr = False
    ComponentOptions = []
    ListenBacklog = 5
    ReqVerLow = 1
    ReqVerHigh = 1
    OnDataAvailable = MRAWSocketDataAvailable
    OnSendData = MRAWSocketSendData
    OnSessionClosed = MRAWSocketSessionClosed
    OnSessionAvailable = MRAWSocketSessionAvailable
    OnSessionConnected = MRAWSocketSessionConnected
    OnSocksConnected = MRAWSocketSocksConnected
    OnError = MRAWSocketError
    OnBgException = SocketBgException
    OnSocksError = MRAWSocketSocksError
    Left = 16
    Top = 64
  end
  object JabberWSocket: TSslWSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    MultiThreaded = False
    MultiCast = False
    MultiCastIpTTL = 1
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    KeepAliveOnOff = wsKeepAliveOff
    KeepAliveTime = 0
    KeepAliveInterval = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    LastError = 0
    ReuseAddr = False
    ComponentOptions = []
    ListenBacklog = 5
    ReqVerLow = 1
    ReqVerHigh = 1
    OnDataAvailable = JabberWSocketDataAvailable
    OnSendData = JabberWSocketSendData
    OnSessionClosed = JabberWSocketSessionClosed
    OnSessionAvailable = JabberWSocketSessionAvailable
    OnSessionConnected = JabberWSocketSessionConnected
    OnSocksConnected = JabberWSocketSocksConnected
    OnError = JabberWSocketError
    OnBgException = SocketBgException
    OnSocksError = JabberWSocketSocksError
    SslContext = JabberSslContext
    SslEnable = False
    SslMode = sslModeClient
    OnSslVerifyPeer = JabberWSocketSslVerifyPeer
    Left = 16
    Top = 96
  end
  object ICQAvatarWSocket: TWSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Proto = 'tcp'
    LocalAddr = '0.0.0.0'
    LocalPort = '0'
    MultiThreaded = False
    MultiCast = False
    MultiCastIpTTL = 1
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    KeepAliveOnOff = wsKeepAliveOff
    KeepAliveTime = 0
    KeepAliveInterval = 0
    SocksLevel = '5'
    SocksAuthentication = socksNoAuthentication
    LastError = 0
    ReuseAddr = False
    ComponentOptions = []
    ListenBacklog = 5
    ReqVerLow = 1
    ReqVerHigh = 1
    OnError = ICQAvatarWSocketError
    OnBgException = SocketBgException
    Left = 48
    Top = 32
  end
  object HttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.5.24 Version/10.54'
    Accept = 
      'text/html, application/xml;q=0.9, application/xhtml+xml, image/p' +
      'ng, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1'
    AcceptLanguage = 'ru-RU,ru;q=0.9,en;q=0.8'
    Connection = 'Keep-Alive'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthNone
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    OnSessionClosed = HttpClientSessionClosed
    OnDocBegin = HttpClientDocBegin
    OnDocEnd = HttpClientDocEnd
    OnSendEnd = HttpClientSendEnd
    OnRequestDone = HttpClientRequestDone
    OnCookie = HttpClientCookie
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = HttpClientSocksConnected
    OnSocksError = HttpClientSocksError
    Left = 16
    Top = 128
  end
  object ContactListPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Images = AllImageList
    OnPopup = ContactListPopupMenuPopup
    Left = 16
    Top = 232
    object OpenGroupsCL: TMenuItem
      ImageIndex = 151
      OnClick = OpenGroupsCLClick
    end
    object CloseGroupsCL: TMenuItem
      ImageIndex = 152
      OnClick = CloseGroupsCLClick
    end
    object HideEmptyGroups: TMenuItem
      ImageIndex = 230
      OnClick = HideEmptyGroupsClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object AddGroupCL: TMenuItem
      Tag = 1
      ImageIndex = 153
      OnClick = AddGroupCLClick
    end
    object RenemeGroupCL: TMenuItem
      ImageIndex = 154
      OnClick = RenemeGroupCLClick
    end
    object DeleteGroupCL: TMenuItem
      ImageIndex = 155
      OnClick = DeleteGroupCLClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object SearchInCL: TMenuItem
      ImageIndex = 215
      OnClick = SearchInCL_MenuClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object AddContactCL: TMenuItem
      Tag = 1
      ImageIndex = 143
      OnClick = AddContactCLClick
    end
  end
  object ICQPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 48
    Top = 288
    object ICQSettings: TMenuItem
      ImageIndex = 160
      OnClick = ICQSettingsClick
    end
    object MyICQDetails_Menu: TMenuItem
      ImageIndex = 178
      object ShowMyICQDetails_Menu: TMenuItem
        ImageIndex = 178
        OnClick = ShowMyICQDetails_MenuClick
      end
      object ChangeMyICQDetails_Menu: TMenuItem
        ImageIndex = 178
        OnClick = ChangeMyICQDetails_MenuClick
      end
    end
    object ICQ_Addition: TMenuItem
      ImageIndex = 274
      object UnstableICQStatus: TMenuItem
        ImageIndex = 230
        OnClick = UnstableICQStatusClick
      end
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object ICQSearchNewContact: TMenuItem
      ImageIndex = 235
      OnClick = ICQSearchNewContactClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ICQAddGroup: TMenuItem
      ImageIndex = 153
      OnClick = ICQAddGroupClick
    end
    object ICQAddContact: TMenuItem
      ImageIndex = 143
      OnClick = ICQAddContactClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object ICQXStatus: TMenuItem
      ImageIndex = 44
      OnClick = ICQXStatusClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object ICQStatusFFC: TMenuItem
      ImageIndex = 16
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusEvil: TMenuItem
      ImageIndex = 18
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusDepres: TMenuItem
      ImageIndex = 17
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusHome: TMenuItem
      ImageIndex = 19
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusWork: TMenuItem
      ImageIndex = 20
      OnClick = ICQStatusOnlineClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object ICQStatusLunch: TMenuItem
      ImageIndex = 15
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusAway: TMenuItem
      ImageIndex = 8
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusNA: TMenuItem
      ImageIndex = 14
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusOccupied: TMenuItem
      ImageIndex = 12
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusDND: TMenuItem
      ImageIndex = 13
      OnClick = ICQStatusOnlineClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object ICQStatusOnline: TMenuItem
      ImageIndex = 7
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusInvisible: TMenuItem
      ImageIndex = 10
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusInvisibleForAll: TMenuItem
      ImageIndex = 11
      OnClick = ICQStatusOnlineClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object ICQStatusOffline: TMenuItem
      Default = True
      ImageIndex = 9
      OnClick = ICQStatusOfflineClick
    end
  end
  object MRAPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 112
    Top = 288
    object MRASettings: TMenuItem
      ImageIndex = 160
      OnClick = MRASettingsClick
    end
    object MyMRADetails_Menu: TMenuItem
      ImageIndex = 178
      object ShowMyMRADetails_Menu: TMenuItem
        ImageIndex = 178
        OnClick = ShowMyMRADetails_MenuClick
      end
      object ChangeMyMRADetails_Menu: TMenuItem
        ImageIndex = 178
      end
    end
    object MRA_Addition: TMenuItem
      ImageIndex = 274
      object TMenuItem
      end
    end
    object N33: TMenuItem
      Caption = '-'
    end
    object MRASearchNewContact: TMenuItem
      ImageIndex = 235
      OnClick = ICQSearchNewContactClick
    end
    object MraSMSSendMenu: TMenuItem
      ImageIndex = 276
      OnClick = MraSMSSendMenuClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object MRAAddGroup: TMenuItem
      ImageIndex = 153
      OnClick = MRAAddGroupClick
    end
    object MRAAddContact: TMenuItem
      ImageIndex = 143
      OnClick = MRAAddContactClick
    end
    object N34: TMenuItem
      Caption = '-'
    end
    object MRAXStatus: TMenuItem
      ImageIndex = 44
      OnClick = MRAXStatusClick
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object MRAStatusFFC: TMenuItem
      ImageIndex = 26
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusEvil: TMenuItem
      ImageIndex = 290
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusDepres: TMenuItem
      ImageIndex = 291
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusHome: TMenuItem
      ImageIndex = 292
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusWork: TMenuItem
      ImageIndex = 293
      OnClick = MRAStatusOnlineClick
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object MRAStatusLunch: TMenuItem
      ImageIndex = 294
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusAway: TMenuItem
      ImageIndex = 22
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusNA: TMenuItem
      ImageIndex = 295
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusOccupied: TMenuItem
      ImageIndex = 296
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusDND: TMenuItem
      ImageIndex = 27
      OnClick = MRAStatusOnlineClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object MRAStatusOnline: TMenuItem
      ImageIndex = 24
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusInvisible: TMenuItem
      ImageIndex = 21
      OnClick = MRAStatusOnlineClick
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object MRAStatusOffline: TMenuItem
      Default = True
      ImageIndex = 23
      OnClick = MRAStatusOfflineClick
    end
  end
  object JabberPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 80
    Top = 288
    object JabberSettings: TMenuItem
      ImageIndex = 160
      OnClick = JabberSettingsClick
    end
    object MyJabberDetails_Menu: TMenuItem
      ImageIndex = 178
      object ShowMyJabberDetails_Menu: TMenuItem
        ImageIndex = 178
        OnClick = ShowMyJabberDetails_MenuClick
      end
      object ChangeMyJabberDetails_Menu: TMenuItem
        ImageIndex = 178
        OnClick = ChangeMyJabberDetails_MenuClick
      end
    end
    object Jabber_Addition: TMenuItem
      ImageIndex = 274
      object JoinConf_Menu: TMenuItem
        ImageIndex = 236
        OnClick = JoinConf_MenuClick
      end
      object ConfList_Menu: TMenuItem
        ImageIndex = 250
        OnClick = ConfList_MenuClick
      end
    end
    object N36: TMenuItem
      Caption = '-'
    end
    object JabberSearchNewContact: TMenuItem
      ImageIndex = 235
      OnClick = ICQSearchNewContactClick
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object JabberAddGroup: TMenuItem
      ImageIndex = 153
      OnClick = JabberAddGroupClick
    end
    object JabberAddContact: TMenuItem
      ImageIndex = 143
      OnClick = JabberAddContactClick
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object JabberXStatus: TMenuItem
      ImageIndex = 44
      OnClick = JabberXStatusClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object JabberStatusFFC: TMenuItem
      ImageIndex = 36
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusEvil: TMenuItem
      ImageIndex = 38
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusDepression: TMenuItem
      ImageIndex = 37
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusHome: TMenuItem
      ImageIndex = 39
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusWork: TMenuItem
      ImageIndex = 40
      OnClick = JabberStatusOnlineClick
    end
    object N26: TMenuItem
      Caption = '-'
    end
    object JabberStatusLunch: TMenuItem
      ImageIndex = 35
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusAway: TMenuItem
      ImageIndex = 29
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusNA: TMenuItem
      ImageIndex = 34
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusOccupied: TMenuItem
      ImageIndex = 32
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusDND: TMenuItem
      ImageIndex = 33
      OnClick = JabberStatusOnlineClick
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object JabberStatusOnline: TMenuItem
      ImageIndex = 28
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusInvisible: TMenuItem
      ImageIndex = 31
      OnClick = JabberStatusOnlineClick
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object JabberStatusOffline: TMenuItem
      Default = True
      ImageIndex = 30
      OnClick = JabberStatusOfflineClick
    end
  end
  object ContactPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Images = AllImageList
    Left = 48
    Top = 232
    object SendMessageForContact: TMenuItem
      ImageIndex = 163
      OnClick = SendMessageForContactClick
    end
    object SendFileMenu: TMenuItem
      ImageIndex = 149
      object SendFileUpWapru: TMenuItem
        Tag = 1
        ImageIndex = 225
        OnClick = SendFileUpWapruClick
      end
    end
    object CheckStatusContact: TMenuItem
      ImageIndex = 172
      OnClick = CheckStatusContactClick
    end
    object ReqAuthContact: TMenuItem
      ImageIndex = 277
      OnClick = ReqAuthContactClick
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object AnketaContact: TMenuItem
      ImageIndex = 178
      OnClick = AnketaContactClick
    end
    object HistoryContact: TMenuItem
      ImageIndex = 147
      OnClick = HistoryContactClick
    end
    object CopyAccountContact: TMenuItem
      ImageIndex = 144
      OnClick = CopyAccountContactClick
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object AddNewContact: TMenuItem
      ImageIndex = 143
      Visible = False
      OnClick = AddNewContactClick
    end
    object EditContact: TMenuItem
      ImageIndex = 141
      OnClick = EditContactClick
    end
    object DeleteContact: TMenuItem
      ImageIndex = 142
      OnClick = DeleteContactClick
    end
    object N27: TMenuItem
      Caption = '-'
    end
    object NextContactMenu: TMenuItem
      ImageIndex = 223
      object GrandAuthContact: TMenuItem
        ImageIndex = 140
        OnClick = GrandAuthContactClick
      end
      object DelYourSelfContact: TMenuItem
        ImageIndex = 139
        OnClick = DelYourSelfContactClick
      end
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object FloatContactMenu: TMenuItem
      ImageIndex = 248
      OnClick = FloatContactMenuClick
    end
  end
  object MRA_PhotoClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.5.24 Version/10.54'
    Accept = 
      'text/html, application/xml;q=0.9, application/xhtml+xml, image/p' +
      'ng, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1'
    AcceptLanguage = 'ru-RU,ru;q=0.9,en;q=0.8'
    Connection = 'Keep-Alive'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthNone
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    OnDocBegin = HttpClientDocBegin
    OnSendEnd = HttpClientSendEnd
    OnCookie = MRA_PhotoClientCookie
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = HttpClientSocksConnected
    OnSocksError = HttpClientSocksError
    Left = 48
    Top = 64
  end
  object TopPanelPopupMenu: TPopupMenu
    Alignment = paRight
    AutoHotkeys = maManual
    Images = AllImageList
    OnPopup = BottomPanelPopupMenuPopup
    Left = 200
    Top = 144
    object TopMainButtonONMenu: TMenuItem
      ImageIndex = 230
      OnClick = TopMainButtonONMenuClick
    end
    object TopOnlyOnlineONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopOnlyOnlineONMenuClick
    end
    object TopSoundsONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopSoundsONMenuClick
    end
    object TopHistoryONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopHistoryONMenuClick
    end
    object TopSettingsONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopSettingsONMenuClick
    end
    object TopCLSearchONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopCLSearchONMenuClick
    end
    object TopTrafficONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopTrafficONMenuClick
    end
  end
  object BottomPanelPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Images = AllImageList
    OnPopup = BottomPanelPopupMenuPopup
    Left = 200
    Top = 176
    object MainButtonONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = MainButtonONMenuClick
    end
    object OnlyOnlineONMenu: TMenuItem
      ImageIndex = 230
      OnClick = OnlyOnlineONMenuClick
    end
    object SoundsONMenu: TMenuItem
      ImageIndex = 230
      OnClick = SoundsONMenuClick
    end
    object HistoryONMenu: TMenuItem
      ImageIndex = 230
      OnClick = HistoryONMenuClick
    end
    object SettingsONMenu: TMenuItem
      ImageIndex = 230
      OnClick = SettingsONMenuClick
    end
    object CLSearchONMenu: TMenuItem
      ImageIndex = 230
      OnClick = CLSearchONMenuClick
    end
    object TrafficONMenu: TMenuItem
      ImageIndex = 230
      OnClick = TrafficONMenuClick
    end
    object TopPanelONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopPanelONMenuClick
    end
  end
  object JabberSslContext: TSslContext
    SslVerifyPeer = True
    SslVerifyDepth = 9
    SslOptions = []
    SslVerifyPeerModes = [SslVerifyMode_PEER]
    SslSessionCacheModes = []
    SslCipherList = 'ALL:!ADH:RC4+RSA:+SSLv2:@STRENGTH'
    SslVersionMethod = sslV23
    SslSessionTimeout = 0
    SslSessionCacheSize = 20480
    Left = 48
    Top = 96
  end
  object SendFileOpenDialog: TOpenDialog
    Left = 136
    Top = 48
  end
  object TrayIcon: TTrayIcon
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = TrayIconClick
    OnDblClick = TrayIconDblClick
    Left = 136
    Top = 160
  end
  object TrayPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Images = AllImageList
    OnPopup = TrayPopupMenuPopup
    Left = 136
    Top = 192
    object HideInTray_MenuTray: TMenuItem
      ImageIndex = 4
      OnClick = HideInTray_MenuClick
    end
    object N30: TMenuItem
      Caption = '-'
    end
    object Status_MenuTray: TMenuItem
      ImageIndex = 256
      Visible = False
      object AllStatusFFC: TMenuItem
        ImageIndex = 262
        OnClick = AllStatusOfflineClick
      end
      object AllStatusEvil: TMenuItem
        ImageIndex = 264
        OnClick = AllStatusOfflineClick
      end
      object AllStatusDepres: TMenuItem
        ImageIndex = 263
        OnClick = AllStatusOfflineClick
      end
      object AllStatusHome: TMenuItem
        ImageIndex = 265
        OnClick = AllStatusOfflineClick
      end
      object AllStatusWork: TMenuItem
        ImageIndex = 266
        OnClick = AllStatusOfflineClick
      end
      object N41: TMenuItem
        Caption = '-'
      end
      object AllStatusLunch: TMenuItem
        ImageIndex = 261
        OnClick = AllStatusOfflineClick
      end
      object AllStatusAway: TMenuItem
        ImageIndex = 255
        OnClick = AllStatusOfflineClick
      end
      object AllStatusNA: TMenuItem
        ImageIndex = 260
        OnClick = AllStatusOfflineClick
      end
      object AllStatusOccupied: TMenuItem
        ImageIndex = 258
        OnClick = AllStatusOfflineClick
      end
      object AllStatusDND: TMenuItem
        ImageIndex = 259
        OnClick = AllStatusOfflineClick
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object AllStatusOnline: TMenuItem
        ImageIndex = 254
        OnClick = AllStatusOfflineClick
      end
      object AllStatusInvisible: TMenuItem
        ImageIndex = 257
        OnClick = AllStatusOfflineClick
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object AllStatusOffline: TMenuItem
        ImageIndex = 256
        OnClick = AllStatusOfflineClick
      end
    end
    object N28: TMenuItem
      Caption = '-'
    end
    object Settings_MenuTray: TMenuItem
      ImageIndex = 2
      Visible = False
      OnClick = Settings_MenuClick
    end
    object N24: TMenuItem
      Caption = '-'
    end
    object SwitchProfile_MenuTray: TMenuItem
      ImageIndex = 253
      Visible = False
      OnClick = SwitchProfile_MenuClick
    end
    object CloseProgram_MenuTray: TMenuItem
      ImageIndex = 3
      OnClick = CloseProgram_MenuClick
    end
  end
  object TwitterClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.80 (Windows NT 5.1; U; ru) Presto/2.5.24 Version/10.54'
    Accept = 
      'text/html, application/xml;q=0.9, application/xhtml+xml, image/p' +
      'ng, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1'
    AcceptLanguage = 'ru-RU,ru;q=0.9,en;q=0.8'
    Connection = 'Keep-Alive'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthNone
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    OnSessionClosed = TwitterClientSessionClosed
    OnDocBegin = HttpClientDocBegin
    OnSendEnd = HttpClientSendEnd
    OnRequestDone = TwitterClientRequestDone
    OnCookie = TwitterClientCookie
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = HttpClientSocksConnected
    OnSocksError = HttpClientSocksError
    Left = 48
    Top = 128
  end
  object SaveTextAsFileDialog: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'Text Files (*.txt)|*.txt|XML Files (*.xml)|*.xml'
    Encodings.Strings = (
      'Unicode')
    Left = 136
    Top = 80
  end
  object BimoidPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 144
    Top = 288
    object Bim_Settings: TMenuItem
      ImageIndex = 160
      OnClick = Bim_SettingsClick
    end
    object MyBimoidDetails_Menu: TMenuItem
      ImageIndex = 178
      object ShowMyBimoidDetails_Menu: TMenuItem
        ImageIndex = 178
        OnClick = ShowMyBimoidDetails_MenuClick
      end
      object ChangeMyBimoidDetails_Menu: TMenuItem
        ImageIndex = 178
      end
    end
    object Bim_Addition: TMenuItem
      ImageIndex = 274
      object TMenuItem
      end
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object Bim_SearchNewContact: TMenuItem
      ImageIndex = 235
    end
    object MenuItem5: TMenuItem
      Caption = '-'
    end
    object Bim_AddGroup: TMenuItem
      ImageIndex = 153
    end
    object Bim_AddContact: TMenuItem
      ImageIndex = 143
    end
    object MenuItem8: TMenuItem
      Caption = '-'
    end
    object Bim_XStatus: TMenuItem
      ImageIndex = 44
    end
    object MenuItem10: TMenuItem
      Caption = '-'
    end
    object Bim_StatusFFC: TMenuItem
      ImageIndex = 310
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusHome: TMenuItem
      ImageIndex = 308
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusWork: TMenuItem
      ImageIndex = 309
      OnClick = Bim_StatusOnlineClick
    end
    object MenuItem16: TMenuItem
      Caption = '-'
    end
    object Bim_StatusLunch: TMenuItem
      ImageIndex = 307
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusAway: TMenuItem
      ImageIndex = 303
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusNA: TMenuItem
      ImageIndex = 304
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusOccupied: TMenuItem
      ImageIndex = 305
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusDND: TMenuItem
      ImageIndex = 306
      OnClick = Bim_StatusOnlineClick
    end
    object MenuItem22: TMenuItem
      Caption = '-'
    end
    object Bim_StatusOnline: TMenuItem
      ImageIndex = 297
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusInvisible: TMenuItem
      ImageIndex = 301
      OnClick = Bim_StatusOnlineClick
    end
    object Bim_StatusInvisibleForAll: TMenuItem
      ImageIndex = 302
      OnClick = Bim_StatusOnlineClick
    end
    object MenuItem26: TMenuItem
      Caption = '-'
    end
    object Bim_StatusOffline: TMenuItem
      Default = True
      ImageIndex = 298
      OnClick = Bim_StatusOfflineClick
    end
  end
  object JvPluginManager: TJvPluginManager
    Extension = 'dll'
    PluginKind = plgDLL
    ShowLoadPluginErrors = True
    OnNewCommand = JvPluginManagerNewCommand
    OnPlugInError = JvPluginManagerPlugInError
    Left = 168
    Top = 48
  end
  object PluginsPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = PluginsImageList
    Left = 232
    Top = 288
  end
  object PluginsImageList: TImageList
    Left = 232
    Top = 256
  end
end
