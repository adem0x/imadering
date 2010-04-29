object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  ClientHeight = 401
  ClientWidth = 329
  Color = clWhite
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
  OnDeactivate = FormDeactivate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ContactList: TCategoryButtons
    AlignWithMargins = True
    Left = 0
    Top = 26
    Width = 329
    Height = 350
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BackgroundGradientDirection = gdVertical
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
    Width = 329
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
      Tag = 1
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
      Tag = 2
      Left = 23
      Top = 0
      Hint = '<b>ICQ</b>'
      ImageIndex = 9
      ParentShowHint = False
      PopupMenu = ICQPopupMenu
      ShowHint = True
      Visible = False
      OnClick = ICQToolButtonClick
      OnContextPopup = ICQToolButtonContextPopup
    end
    object MRAToolButton: TToolButton
      Tag = 3
      Left = 46
      Top = 0
      Hint = '<b>MRA</b>'
      ImageIndex = 23
      ParentShowHint = False
      PopupMenu = MRAPopupMenu
      ShowHint = True
      Visible = False
      OnClick = MRAToolButtonClick
      OnContextPopup = MRAToolButtonContextPopup
    end
    object JabberToolButton: TToolButton
      Tag = 4
      Left = 69
      Top = 0
      Hint = '<b>Jabber</b>'
      ImageIndex = 30
      ParentShowHint = False
      PopupMenu = JabberPopupMenu
      ShowHint = True
      Visible = False
      OnClick = JabberToolButtonClick
      OnContextPopup = JabberToolButtonContextPopup
    end
    object TwitterToolButton: TToolButton
      Left = 92
      Top = 0
      Hint = '<b>Twitter</b>'
      ImageIndex = 269
      ParentShowHint = False
      PopupMenu = TwitterPopupMenu
      ShowHint = True
      Visible = False
      OnClick = TwitterToolButtonClick
      OnContextPopup = TwitterToolButtonContextPopup
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
    object GroupOnOffToolButton: TToolButton
      Left = 138
      Top = 0
      Down = True
      ImageIndex = 231
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      Visible = False
      OnClick = GroupOnOffToolButtonClick
    end
    object SoundOnOffToolButton: TToolButton
      Left = 161
      Top = 0
      ImageIndex = 135
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      Visible = False
      OnClick = SoundOnOffToolButtonClick
    end
    object PrivatToolButton: TToolButton
      Left = 184
      Top = 0
      ImageIndex = 236
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = PrivatListMenuClick
    end
    object HistoryToolButton: TToolButton
      Left = 207
      Top = 0
      ImageIndex = 147
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = OpenHistoryClick
    end
    object SettingsToolButton: TToolButton
      Left = 230
      Top = 0
      ImageIndex = 2
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = OpenSettingsClick
    end
    object CLSearchToolButton: TToolButton
      Left = 253
      Top = 0
      ImageIndex = 215
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = SearchInCLClick
    end
    object TrafficToolButton: TToolButton
      Left = 276
      Top = 0
      ImageIndex = 226
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = OpenTrafficClick
    end
    object TopPanelToolButton: TToolButton
      Left = 299
      Top = 0
      Down = True
      ImageIndex = 244
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = TopPanelToolButtonClick
    end
  end
  object TopToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 329
    Height = 25
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
    object GroupOnOffToolTopButton: TToolButton
      Left = 46
      Top = 0
      Down = True
      ImageIndex = 231
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = GroupOnOffToolTopButtonClick
    end
    object SoundOnOffToolTopButton: TToolButton
      Left = 69
      Top = 0
      ImageIndex = 135
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = SoundOnOffToolTopButtonClick
    end
    object PrivatTopToolButton: TToolButton
      Left = 92
      Top = 0
      ImageIndex = 236
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = PrivatListMenuClick
    end
    object HistoryTopToolButton: TToolButton
      Left = 115
      Top = 0
      ImageIndex = 147
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = OpenHistoryClick
    end
    object SettingsTopToolButton: TToolButton
      Left = 138
      Top = 0
      ImageIndex = 2
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = OpenSettingsClick
    end
    object CLSearchTopToolButton: TToolButton
      Left = 161
      Top = 0
      ImageIndex = 215
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = SearchInCLClick
    end
    object TrafficTopToolButton: TToolButton
      Left = 184
      Top = 0
      ImageIndex = 226
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = OpenTrafficClick
    end
    object TopModeToolButton: TToolButton
      Left = 207
      Top = 0
      ImageIndex = 288
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      Style = tbsCheck
      OnClick = TopModeToolButtonClick
    end
  end
  object ICQTrayIcon: TTrayIcon
    Hint = 'ICQ'
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = ICQTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 32
  end
  object TrayPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Images = AllImageList
    OnPopup = TrayPopupMenuPopup
    Left = 16
    Top = 128
    object HideMainInTray1: TMenuItem
      ImageIndex = 4
      OnClick = HideInTrayClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object StatusTray1: TMenuItem
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object SettingsTray1: TMenuItem
      ImageIndex = 2
      OnClick = OpenSettingsClick
    end
    object CheckUpdateTray1: TMenuItem
      ImageIndex = 6
      OnClick = CheckUpdateTray1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object CloseProgramTray1: TMenuItem
      ImageIndex = 3
      OnClick = CloseProgramClick
    end
  end
  object AllImageList: TImageList
    Left = 16
    Top = 296
  end
  object JvTimerList: TJvTimerList
    Active = True
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
        Interval = 60000
        OnTimer = JvTimerListEvents2Timer
      end
      item
        Name = 'Connect Icon Timer'
        Enabled = False
        OnTimer = JvTimerListEvents3Timer
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
        OnTimer = JvTimerListEvents7Timer
      end
      item
        Name = 'Gtranslation Timer'
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
      end>
    Left = 16
    Top = 168
  end
  object MainPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 16
    Top = 328
    object OpenTest: TMenuItem
      Caption = 'Test'
      Visible = False
      OnClick = OpenTestClick
    end
    object OpenGameMenu: TMenuItem
      ImageIndex = 286
      OnClick = OpenGameMenuClick
    end
    object N38: TMenuItem
      Caption = '-'
    end
    object SnapContactList: TMenuItem
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
    object RosterMainMenu: TMenuItem
      ImageIndex = 1
      OnClick = RosterMainMenuClick
    end
    object PrivatListMenu: TMenuItem
      ImageIndex = 236
      OnClick = PrivatListMenuClick
    end
    object SearchInCLMainMenu: TMenuItem
      ImageIndex = 215
      OnClick = SearchInCLClick
    end
    object OpenTraffic: TMenuItem
      ImageIndex = 226
      OnClick = OpenTrafficClick
    end
    object OpenHistory: TMenuItem
      ImageIndex = 147
      OnClick = OpenHistoryClick
    end
    object OpenSettings: TMenuItem
      ImageIndex = 2
      OnClick = OpenSettingsClick
    end
    object LogFormMenu: TMenuItem
      ImageIndex = 245
      OnClick = LogFormMenuClick
    end
    object N29: TMenuItem
      Caption = '-'
    end
    object CheckUpdateMenu: TMenuItem
      ImageIndex = 6
      OnClick = CheckUpdateTray1Click
    end
    object AboutIMadering: TMenuItem
      ImageIndex = 0
      OnClick = AboutIMaderingClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ProfileOpenMenu: TMenuItem
      ImageIndex = 253
      OnClick = ProfileOpenMenuClick
    end
    object HideInTray: TMenuItem
      ImageIndex = 4
      OnClick = HideInTrayClick
    end
    object CloseProgram: TMenuItem
      ImageIndex = 3
      OnClick = CloseProgramClick
    end
  end
  object MRATrayIcon: TTrayIcon
    Hint = 'MRA'
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = ICQTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 64
  end
  object JabberTrayIcon: TTrayIcon
    Hint = 'Jabber'
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = ICQTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 96
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
    Left = 48
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
    Left = 48
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
    Left = 48
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
    OnBgException = SocketBgException
    Left = 80
    Top = 32
  end
  object UpdateHttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.64 (Windows NT 5.1; U; ru) Presto/2.1.1'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
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
    OnSessionClosed = UpdateHttpClientSessionClosed
    OnDocBegin = UpdateHttpClientDocBegin
    OnDocData = UpdateHttpClientDocData
    OnSendEnd = UpdateHttpClientSendEnd
    OnRequestDone = UpdateHttpClientRequestDone
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = UpdateHttpClientSocksConnected
    OnSocksError = UpdateHttpClientSocksError
    Left = 48
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
    object AddNewGroupICQ: TMenuItem
      Tag = 1
      ImageIndex = 153
      OnClick = AddNewGroupICQClick
    end
    object AddNewGroupJabber: TMenuItem
      Tag = 2
      ImageIndex = 153
      OnClick = AddNewGroupICQClick
    end
    object AddNewGroupMRA: TMenuItem
      Tag = 3
      ImageIndex = 153
      OnClick = AddNewGroupICQClick
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
      OnClick = SearchInCLClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object AddNewContactICQ: TMenuItem
      Tag = 1
      ImageIndex = 143
      OnClick = AddNewContactICQClick
    end
    object AddNewContactJabber: TMenuItem
      Tag = 2
      ImageIndex = 143
      OnClick = AddNewContactICQClick
    end
    object AddNewContactMRA: TMenuItem
      Tag = 3
      ImageIndex = 143
      OnClick = AddNewContactICQClick
    end
  end
  object ICQPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 48
    Top = 328
    object ICQSettings: TMenuItem
      ImageIndex = 160
      OnClick = ICQSettingsClick
    end
    object ICQSearchNewContact: TMenuItem
      ImageIndex = 235
      OnClick = ICQSearchNewContactClick
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
    Left = 80
    Top = 328
    object MRASettings: TMenuItem
      ImageIndex = 160
      OnClick = MRASettingsClick
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object MraSMSSendMenu: TMenuItem
      Caption = '#'#1054#1090#1087#1088#1072#1074#1080#1090#1100' SMS'
      ImageIndex = 276
      OnClick = MraSMSSendMenuClick
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
    object N14: TMenuItem
      Caption = '-'
    end
    object MRAStatusAway: TMenuItem
      ImageIndex = 22
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
    Left = 112
    Top = 328
    object JabberSettings: TMenuItem
      ImageIndex = 160
      OnClick = JabberSettingsClick
    end
    object JabberSearchNewContact: TMenuItem
      ImageIndex = 235
      OnClick = JabberSearchNewContactClick
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
    object N21: TMenuItem
      Caption = '-'
    end
    object AnketaContact: TMenuItem
      ImageIndex = 178
      OnClick = AnketaContactClick
    end
    object UniqContactSettingsMenu: TMenuItem
      ImageIndex = 247
      OnClick = UniqContactSettingsMenuClick
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
    object FloatContactMenu: TMenuItem
      ImageIndex = 248
      OnClick = FloatContactMenuClick
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object NextContactMenu: TMenuItem
      ImageIndex = 222
      object GrandAuthContact: TMenuItem
        ImageIndex = 140
        OnClick = GrandAuthContactClick
      end
      object SendAddContact: TMenuItem
        OnClick = SendAddContactClick
      end
      object DelYourSelfContact: TMenuItem
        ImageIndex = 139
        OnClick = DelYourSelfContactClick
      end
      object SendInviteContact: TMenuItem
        OnClick = SendInviteContactClick
      end
    end
  end
  object RightICQPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    OnPopup = RightICQPopupMenuPopup
    Left = 48
    Top = 296
    object PingICQServer: TMenuItem
      ImageIndex = 162
      OnClick = PingICQServerClick
    end
    object UnstableICQStatus: TMenuItem
      ImageIndex = 230
      OnClick = UnstableICQStatusClick
    end
  end
  object MRAAvatarHttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.64 (Windows NT 5.1; U; ru) Presto/2.1.1'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
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
    SocksAuthentication = socksNoAuthentication
    Left = 80
    Top = 64
  end
  object RightMRAPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 80
    Top = 296
    object PingMRAServer: TMenuItem
      ImageIndex = 162
    end
    object UnstableMRAStatus: TMenuItem
      ImageIndex = 230
    end
  end
  object RightJabberPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 112
    Top = 296
    object PingJabberServer: TMenuItem
      ImageIndex = 162
    end
    object UnstableJabberStatus: TMenuItem
      ImageIndex = 230
    end
  end
  object MainActionList: TActionList
    Left = 16
    Top = 200
    object CloseActiveFormAction: TAction
      Caption = 'CloseActiveFormAction'
      ShortCut = 27
      OnExecute = CloseActiveFormActionExecute
    end
    object ChatTabCloseAction: TAction
      Caption = 'ChatTabCloseAction'
      ShortCut = 32883
      OnExecute = ChatTabCloseActionExecute
    end
  end
  object TopPanelPopupMenu: TPopupMenu
    Alignment = paRight
    AutoHotkeys = maManual
    Images = AllImageList
    OnPopup = BottomPanelPopupMenuPopup
    Left = 160
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
    object TopGroupONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopGroupONMenuClick
    end
    object TopSoundsONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopSoundsONMenuClick
    end
    object TopPrivatONMenu: TMenuItem
      Checked = True
      ImageIndex = 140
      OnClick = TopPrivatONMenuClick
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
    Left = 160
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
    object GroupONMenu: TMenuItem
      ImageIndex = 230
      OnClick = GroupONMenuClick
    end
    object SoundsONMenu: TMenuItem
      ImageIndex = 230
      OnClick = SoundsONMenuClick
    end
    object PrivatONMenu: TMenuItem
      ImageIndex = 230
      OnClick = PrivatONMenuClick
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
    Left = 80
    Top = 96
  end
  object SendFileOpenDialog: TOpenDialog
    Left = 48
    Top = 200
  end
  object IMaderingEvents: TApplicationEvents
    OnException = IMaderingEventsException
    Left = 48
    Top = 168
  end
  object xTrayIcon: TTrayIcon
    Hint = 'IMadering'
    Icons = AllImageList
    PopupMenu = xTrayPopupMenu
    OnClick = xTrayIconClick
    Left = 80
    Top = 168
  end
  object xTrayPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    Images = AllImageList
    Left = 80
    Top = 200
    object HideProfileInTray: TMenuItem
      ImageIndex = 4
      OnClick = HideProfileInTrayClick
    end
    object HideMainInTray2: TMenuItem
      ImageIndex = 4
      Visible = False
      OnClick = HideInTrayClick
    end
    object N30: TMenuItem
      Caption = '-'
    end
    object StatusTray2: TMenuItem
      ImageIndex = 256
      Visible = False
      object AllStatusFFC: TMenuItem
        ImageIndex = 262
      end
      object AllStatusEvil: TMenuItem
        ImageIndex = 264
      end
      object AllStatusDepres: TMenuItem
        ImageIndex = 263
      end
      object AllStatusHome: TMenuItem
        ImageIndex = 265
      end
      object AllStatusWork: TMenuItem
        ImageIndex = 266
      end
      object N41: TMenuItem
        Caption = '-'
      end
      object AllStatusLunch: TMenuItem
        ImageIndex = 261
      end
      object AllStatusAway: TMenuItem
        ImageIndex = 255
      end
      object AllStatusNA: TMenuItem
        ImageIndex = 260
      end
      object AllStatusOccupied: TMenuItem
        ImageIndex = 258
      end
      object AllStatusDND: TMenuItem
        ImageIndex = 259
      end
      object N35: TMenuItem
        Caption = '-'
      end
      object AllStatusOnline: TMenuItem
        ImageIndex = 254
      end
      object AllStatusInvisible: TMenuItem
        ImageIndex = 257
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object AllStatusOffline: TMenuItem
        Default = True
        ImageIndex = 256
      end
    end
    object N28: TMenuItem
      Caption = '-'
    end
    object ShowLogTray: TMenuItem
      ImageIndex = 245
      OnClick = LogFormMenuClick
    end
    object SettingsTray2: TMenuItem
      ImageIndex = 2
      Visible = False
      OnClick = OpenSettingsClick
    end
    object CheckUpdateTray2: TMenuItem
      ImageIndex = 6
      Visible = False
      OnClick = CheckUpdateTray1Click
    end
    object N24: TMenuItem
      Caption = '-'
    end
    object CloseProgramTray2: TMenuItem
      ImageIndex = 3
      OnClick = CloseProgramClick
    end
  end
  object TwitterPopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoPopup = False
    Images = AllImageList
    Left = 144
    Top = 328
    object TwitterSettingsMenu: TMenuItem
      ImageIndex = 160
      OnClick = TwitterSettingsMenuClick
    end
    object MyInfoTwitterMenu: TMenuItem
      Caption = '#'#1055#1086#1082#1072#1079#1072#1090#1100' '#1084#1086#1080' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 178
      OnClick = MyInfoTwitterMenuClick
    end
    object TwitterSearchMenu: TMenuItem
      Caption = '#'#1055#1086#1080#1089#1082' '#1087#1086' Twitter'
      ImageIndex = 235
      OnClick = TwitterSearchMenuClick
    end
    object N33: TMenuItem
      Caption = '-'
    end
    object OpenSiteTwitterMinu: TMenuItem
      ImageIndex = 267
      OnClick = OpenSiteTwitterMinuClick
    end
    object OpenMyPageMenu: TMenuItem
      ImageIndex = 270
      OnClick = OpenMyPageMenuClick
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object AllLentaTwitterMenu: TMenuItem
      Caption = '#'#1054#1073#1097#1072#1103' '#1083#1077#1085#1090#1072
      ImageIndex = 271
      OnClick = AllLentaTwitterMenuClick
    end
    object MyLentaTwitterMenu: TMenuItem
      ImageIndex = 271
      OnClick = MyLentaTwitterMenuClick
    end
    object MyPostsLentaTwitterMenu: TMenuItem
      Caption = '#'#1052#1086#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
    end
    object PostsMeLentaTwitterMenu: TMenuItem
      Caption = '#'#1054#1090#1074#1077#1090#1099' '#1084#1085#1077
    end
    object FavoriteLentaTwitterMenu: TMenuItem
      Caption = '#'#1048#1079#1073#1088#1072#1085#1085#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
    end
    object IncMessTwitterMenu: TMenuItem
      Caption = '#'#1042#1093#1086#1076#1103#1097#1080#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      OnClick = IncMessTwitterMenuClick
    end
    object OutMessTwitterMenu: TMenuItem
      Caption = '#'#1048#1089#1093#1086#1076#1103#1097#1080#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
    end
    object N37: TMenuItem
      Caption = '-'
    end
    object PostMessageTwitterMenu: TMenuItem
      ImageIndex = 272
      OnClick = PostMessageTwitterMenuClick
    end
    object PostImageTwitterMenu: TMenuItem
      Caption = '#'#1054#1087#1091#1073#1083#1080#1082#1086#1074#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
      OnClick = PostImageTwitterMenuClick
    end
    object N36: TMenuItem
      Caption = '-'
    end
    object OnlineTwitterMenu: TMenuItem
      ImageIndex = 268
    end
    object OfflineTwitterMenu: TMenuItem
      ImageIndex = 269
    end
  end
  object TwitterHttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Opera/9.64 (Windows NT 5.1; U; ru) Presto/2.1.1'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthBasic
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    OnSessionClosed = TwitterHttpClientSessionClosed
    OnDocBegin = UpdateHttpClientDocBegin
    OnSendEnd = UpdateHttpClientSendEnd
    OnRequestDone = TwitterHttpClientRequestDone
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = UpdateHttpClientSocksConnected
    OnSocksError = UpdateHttpClientSocksError
    Left = 80
    Top = 128
  end
  object SaveTextAsFileDialog: TSaveTextFileDialog
    DefaultExt = '.txt'
    Filter = 'Text Files (*.txt)|*.txt'
    Encodings.Strings = (
      'Unicode')
    Left = 80
    Top = 232
  end
end
