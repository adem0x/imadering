object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'IMadering'
  ClientHeight = 401
  ClientWidth = 283
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object ContactList: TCategoryButtons
    AlignWithMargins = True
    Left = 0
    Top = 26
    Width = 283
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
    GradientDirection = gdVertical
    Images = AllImageList
    PopupMenu = ContactListPopupMenu
    RegularButtonColor = clWhite
    SelectedButtonColor = 15717318
    ShowHint = True
    TabOrder = 1
    OnButtonClicked = ContactListButtonClicked
    OnCategoryCollapase = ContactListCategoryCollapase
    OnContextPopup = ContactListContextPopup
    OnHotButton = ContactListHotButton
    OnMouseDown = ContactListMouseDown
    OnSelectedItemChange = ContactListSelectedItemChange
  end
  object BottomToolBar: TToolBar
    Left = 0
    Top = 376
    Width = 283
    Height = 25
    Align = alBottom
    Color = clBtnFace
    EdgeBorders = [ebTop]
    Images = AllImageList
    ParentColor = False
    TabOrder = 0
    Transparent = False
    Wrapable = False
    OnMouseDown = BottomToolBarMouseDown
    object MainToolButton: TToolButton
      Tag = 1
      Left = 0
      Top = 0
      Hint = '<b>'#1043#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102'</b>'
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
    object OnlyOnlineContactsToolButton: TToolButton
      Left = 92
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
      Left = 115
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
    object PrivatToolButton: TToolButton
      Left = 161
      Top = 0
      Hint = '<b>'#1055#1088#1080#1074#1072#1090#1085#1099#1077' '#1089#1087#1080#1089#1082#1080'</b>'
      Caption = 'PrivatToolButton'
      ImageIndex = 236
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = PrivatListMenuClick
    end
    object HistoryToolButton: TToolButton
      Left = 184
      Top = 0
      Hint = '<b>'#1048#1089#1090#1086#1088#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081'</b>'
      ImageIndex = 147
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = OpenHistoryClick
    end
    object SettingsToolButton: TToolButton
      Left = 207
      Top = 0
      Hint = '<b>'#1053#1072#1089#1090#1088#1086#1081#1082#1080'</b>'
      Caption = 'SettingsToolButton'
      ImageIndex = 2
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = OpenSettingsClick
    end
    object TrafficToolButton: TToolButton
      Left = 230
      Top = 0
      Hint = '<b>'#1058#1088#1072#1092#1080#1082'</b>'
      ImageIndex = 226
      ParentShowHint = False
      PopupMenu = BottomPanelPopupMenu
      ShowHint = True
      Visible = False
      OnClick = OpenTrafficClick
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
  end
  object TopToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 283
    Height = 25
    Color = clBtnFace
    EdgeBorders = [ebBottom]
    Images = AllImageList
    ParentColor = False
    TabOrder = 2
    Transparent = False
    Wrapable = False
    OnMouseDown = TopToolBarMouseDown
    object MainToolTopButton: TToolButton
      Left = 0
      Top = 0
      Hint = '<b>'#1043#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102'</b>'
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
      Hint = '<b>'#1055#1088#1080#1074#1072#1090#1085#1099#1077' '#1089#1087#1080#1089#1082#1080'</b>'
      ImageIndex = 236
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = PrivatListMenuClick
    end
    object HistoryTopToolButton: TToolButton
      Left = 115
      Top = 0
      Hint = '<b>'#1048#1089#1090#1086#1088#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081'</b>'
      ImageIndex = 147
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = OpenHistoryClick
    end
    object SettingsTopToolButton: TToolButton
      Left = 138
      Top = 0
      Hint = '<b>'#1053#1072#1089#1090#1088#1086#1081#1082#1080'</b>'
      ImageIndex = 2
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = OpenSettingsClick
    end
    object TrafficTopToolButton: TToolButton
      Left = 161
      Top = 0
      Hint = '<b>'#1058#1088#1072#1092#1080#1082'</b>'
      ImageIndex = 226
      ParentShowHint = False
      PopupMenu = TopPanelPopupMenu
      ShowHint = True
      OnClick = OpenTrafficClick
    end
  end
  object ICQTrayIcon: TTrayIcon
    Hint = 'IMadering ICQ'
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = ICQTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 32
  end
  object TrayPopupMenu: TPopupMenu
    Images = AllImageList
    OnPopup = TrayPopupMenuPopup
    Left = 16
    Top = 128
    object HideInTrayTray: TMenuItem
      Caption = #1057#1082#1088#1099#1090#1100' IMadering'
      ImageIndex = 4
      OnClick = HideInTrayClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object StatusTray: TMenuItem
      Caption = #1057#1090#1072#1090#1091#1089
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object SettingsTray: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 2
      OnClick = OpenSettingsClick
    end
    object CheckUpdate: TMenuItem
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      ImageIndex = 6
      OnClick = CheckUpdateClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object CloseProgramTray: TMenuItem
      Caption = #1042#1099#1081#1090#1080' '#1080#1079' IMadering'
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
        Name = 'MainFormShowTimer'
        Cycled = False
        Enabled = False
        Interval = 1
        OnTimer = JvTimerListEvents0Timer
      end
      item
        Name = 'MessagesTimer'
        Interval = 700
        OnTimer = JvTimerListEvents1Timer
      end
      item
        Name = 'CheckUpdateTimer'
        Cycled = False
        Enabled = False
        Interval = 60000
        OnTimer = JvTimerListEvents2Timer
      end
      item
        Name = 'ConnectIconTimer'
        Enabled = False
        OnTimer = JvTimerListEvents3Timer
      end
      item
        Name = 'ICQFuckStatusTimer'
        Enabled = False
        Interval = 20000
        OnTimer = JvTimerListEvents4Timer
      end
      item
        Name = 'ICQAliveTimer'
        Enabled = False
        Interval = 60000
        OnTimer = JvTimerListEvents5Timer
      end
      item
        Name = 'AutoHideCLTimer'
        Enabled = False
        Interval = 10000
        OnTimer = JvTimerListEvents6Timer
      end
      item
        Name = 'CSFandBRTimer'
        Cycled = False
        Enabled = False
        OnTimer = JvTimerListEvents7Timer
      end
      item
        Name = '-'
        Cycled = False
        Enabled = False
      end
      item
        Name = 'JabberAliveTimer'
        Enabled = False
        Interval = 60000
        OnTimer = JvTimerListEvents9Timer
      end
      item
        Name = 'MRAAliveTimer'
        Enabled = False
        Interval = 60000
      end
      item
        Name = 'RosterTimer'
        Cycled = False
        Enabled = False
        Interval = 3000
        OnTimer = JvTimerListEvents11Timer
      end
      item
        Name = 'TrayIconsRefresh'
        Interval = 20000
        OnTimer = JvTimerListEvents12Timer
      end>
    Left = 16
    Top = 168
  end
  object MainPopupMenu: TPopupMenu
    AutoPopup = False
    Images = AllImageList
    Left = 16
    Top = 328
    object OpenTest: TMenuItem
      Caption = '_'#1058#1077#1089#1090'_'
      OnClick = OpenTestClick
    end
    object RosterMainMenu: TMenuItem
      Caption = #1057#1087#1080#1089#1086#1082' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
      ImageIndex = 1
      OnClick = RosterMainMenuClick
    end
    object PrivatListMenu: TMenuItem
      Caption = #1055#1088#1080#1074#1072#1090#1085#1099#1077' '#1089#1087#1080#1089#1082#1080
      ImageIndex = 236
      OnClick = PrivatListMenuClick
    end
    object SearchInCLMainMenu: TMenuItem
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1089#1087#1080#1089#1082#1091' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
      ImageIndex = 215
      OnClick = SearchInCLClick
    end
    object OpenTraffic: TMenuItem
      Caption = #1058#1088#1072#1092#1080#1082
      ImageIndex = 226
      OnClick = OpenTrafficClick
    end
    object OpenHistory: TMenuItem
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 147
      OnClick = OpenHistoryClick
    end
    object OpenSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 2
      OnClick = OpenSettingsClick
    end
    object LogFormMenu: TMenuItem
      Caption = #1051#1086#1075' '#1089#1086#1073#1099#1090#1080#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 245
      OnClick = LogFormMenuClick
    end
    object N29: TMenuItem
      Caption = '-'
    end
    object CheckUpdateMainMenu: TMenuItem
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      ImageIndex = 6
      OnClick = CheckUpdateClick
    end
    object AboutIMadering: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 0
      OnClick = AboutIMaderingClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object HideInTray: TMenuItem
      Caption = #1057#1082#1088#1099#1090#1100' IMadering'
      ImageIndex = 4
      OnClick = HideInTrayClick
    end
    object CloseProgram: TMenuItem
      Caption = #1042#1099#1081#1090#1080' '#1080#1079' IMadering'
      ImageIndex = 3
      OnClick = CloseProgramClick
    end
  end
  object MRATrayIcon: TTrayIcon
    Hint = 'IMadering MRA'
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = ICQTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 64
  end
  object JabberTrayIcon: TTrayIcon
    Hint = 'IMadering Jabber'
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
    OnDocEnd = UpdateHttpClientDocEnd
    OnSendEnd = UpdateHttpClientSendEnd
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = UpdateHttpClientSocksConnected
    OnSocksError = UpdateHttpClientSocksError
    Left = 48
    Top = 128
  end
  object ContactListPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = AllImageList
    OnPopup = ContactListPopupMenuPopup
    Left = 16
    Top = 232
    object OpenGroupsCL: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 151
      OnClick = OpenGroupsCLClick
    end
    object CloseGroupsCL: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 152
      OnClick = CloseGroupsCLClick
    end
    object HideEmptyGroups: TMenuItem
      Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1087#1091#1089#1090#1099#1077' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 230
      OnClick = HideEmptyGroupsClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object AddNewGroupICQ: TMenuItem
      Tag = 1
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091' ICQ'
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 153
      OnClick = AddNewGroupICQClick
    end
    object AddNewGroupJabber: TMenuItem
      Tag = 2
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091' Jabber'
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 153
      OnClick = AddNewGroupICQClick
    end
    object AddNewGroupMRA: TMenuItem
      Tag = 3
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091' MRA'
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 153
      OnClick = AddNewGroupICQClick
    end
    object RenemeGroupCL: TMenuItem
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 154
      OnClick = RenemeGroupCLClick
    end
    object DeleteGroupCL: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 155
      OnClick = DeleteGroupCLClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object SearchInCL: TMenuItem
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1089#1087#1080#1089#1082#1091' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
      ImageIndex = 215
      OnClick = SearchInCLClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object AddNewContactICQ: TMenuItem
      Tag = 1
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090' ICQ'
      ImageIndex = 143
      OnClick = AddNewContactICQClick
    end
    object AddNewContactJabber: TMenuItem
      Tag = 2
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090' Jabber'
      ImageIndex = 143
      OnClick = AddNewContactICQClick
    end
    object AddNewContactMRA: TMenuItem
      Tag = 3
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090' MRA'
      ImageIndex = 143
      OnClick = AddNewContactICQClick
    end
  end
  object ICQPopupMenu: TPopupMenu
    AutoPopup = False
    Images = AllImageList
    Left = 48
    Top = 328
    object ICQSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1077#1090#1080
      ImageIndex = 160
      OnClick = ICQSettingsClick
    end
    object ICQSearchNewContact: TMenuItem
      Caption = #1055#1086#1080#1089#1082' '#1085#1086#1074#1099#1093' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
      ImageIndex = 235
      OnClick = ICQSearchNewContactClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object ICQXStatus: TMenuItem
      Caption = #1044#1086#1087'. '#1089#1090#1072#1090#1091#1089
      ImageIndex = 44
      OnClick = ICQXStatusClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object ICQStatusFFC: TMenuItem
      Caption = #1043#1086#1090#1086#1074' '#1087#1086#1073#1086#1083#1090#1072#1090#1100
      ImageIndex = 16
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusEvil: TMenuItem
      Caption = #1047#1083#1086#1081
      ImageIndex = 18
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusDepres: TMenuItem
      Caption = #1044#1077#1087#1088#1077#1089#1089#1080#1103
      ImageIndex = 17
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusHome: TMenuItem
      Caption = #1044#1086#1084#1072
      ImageIndex = 19
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusWork: TMenuItem
      Caption = #1053#1072' '#1088#1072#1073#1086#1090#1077
      ImageIndex = 20
      OnClick = ICQStatusOnlineClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object ICQStatusLunch: TMenuItem
      Caption = #1050#1091#1096#1072#1102
      ImageIndex = 15
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusAway: TMenuItem
      Caption = #1054#1090#1086#1096#1105#1083
      ImageIndex = 8
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusNA: TMenuItem
      Caption = #1053#1077#1076#1086#1089#1090#1091#1087#1077#1085
      ImageIndex = 14
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusOccupied: TMenuItem
      Caption = #1047#1072#1085#1103#1090
      ImageIndex = 12
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusDND: TMenuItem
      Caption = #1053#1077' '#1073#1077#1089#1087#1086#1082#1086#1080#1090#1100
      ImageIndex = 13
      OnClick = ICQStatusOnlineClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object ICQStatusOnline: TMenuItem
      Caption = #1042' '#1089#1077#1090#1080
      ImageIndex = 7
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusInvisible: TMenuItem
      Caption = #1053#1077#1074#1080#1076#1080#1084#1099#1081
      ImageIndex = 10
      OnClick = ICQStatusOnlineClick
    end
    object ICQStatusInvisibleForAll: TMenuItem
      Caption = #1053#1077#1074#1080#1076#1080#1084#1099#1081' '#1076#1083#1103' '#1074#1089#1077#1093
      ImageIndex = 11
      OnClick = ICQStatusOnlineClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object ICQStatusOffline: TMenuItem
      Caption = #1053#1077' '#1074' '#1089#1077#1090#1080
      Default = True
      ImageIndex = 9
      OnClick = ICQStatusOfflineClick
    end
  end
  object MRAPopupMenu: TPopupMenu
    AutoPopup = False
    Images = AllImageList
    Left = 80
    Top = 328
    object MRASettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1077#1090#1080
      ImageIndex = 160
      OnClick = MRASettingsClick
    end
    object N16: TMenuItem
      Caption = '-'
    end
    object MRAXStatus: TMenuItem
      Caption = #1044#1086#1087'. '#1089#1090#1072#1090#1091#1089
      ImageIndex = 44
      OnClick = MRAXStatusClick
    end
    object N15: TMenuItem
      Caption = '-'
    end
    object MRAStatusFFC: TMenuItem
      Caption = #1043#1086#1090#1086#1074' '#1087#1086#1073#1086#1083#1090#1072#1090#1100
      ImageIndex = 26
      OnClick = MRAStatusOnlineClick
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object MRAStatusAway: TMenuItem
      Caption = #1054#1090#1086#1096#1105#1083
      ImageIndex = 22
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusDND: TMenuItem
      Caption = #1053#1077' '#1073#1077#1089#1087#1086#1082#1086#1080#1090#1100
      ImageIndex = 27
      OnClick = MRAStatusOnlineClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object MRAStatusOnline: TMenuItem
      Caption = #1042' '#1089#1077#1090#1080
      ImageIndex = 24
      OnClick = MRAStatusOnlineClick
    end
    object MRAStatusInvisible: TMenuItem
      Caption = #1053#1077#1074#1080#1076#1080#1084#1099#1081
      ImageIndex = 21
      OnClick = MRAStatusOnlineClick
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object MRAStatusOffline: TMenuItem
      Caption = #1053#1077' '#1074' '#1089#1077#1090#1080
      Default = True
      ImageIndex = 23
      OnClick = MRAStatusOfflineClick
    end
  end
  object JabberPopupMenu: TPopupMenu
    AutoPopup = False
    Images = AllImageList
    Left = 112
    Top = 328
    object JabberSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1077#1090#1080
      ImageIndex = 160
      OnClick = JabberSettingsClick
    end
    object JabberSearchNewContact: TMenuItem
      Caption = #1055#1086#1080#1089#1082' '#1085#1086#1074#1099#1093' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
      ImageIndex = 235
      OnClick = JabberSearchNewContactClick
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object JabberXStatus: TMenuItem
      Caption = #1044#1086#1087'. '#1057#1090#1072#1090#1091#1089
      ImageIndex = 44
      OnClick = JabberXStatusClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object JabberStatusFFC: TMenuItem
      Caption = #1043#1086#1090#1086#1074' '#1087#1086#1073#1086#1083#1090#1072#1090#1100
      ImageIndex = 36
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusEvil: TMenuItem
      Caption = #1047#1083#1086#1081
      ImageIndex = 38
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusDepression: TMenuItem
      Caption = #1044#1077#1087#1088#1077#1089#1089#1080#1103
      ImageIndex = 37
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusHome: TMenuItem
      Caption = #1044#1086#1084#1072
      ImageIndex = 39
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusWork: TMenuItem
      Caption = #1053#1072' '#1088#1072#1073#1086#1090#1077
      ImageIndex = 40
      OnClick = JabberStatusOnlineClick
    end
    object N26: TMenuItem
      Caption = '-'
    end
    object JabberStatusLunch: TMenuItem
      Caption = #1050#1091#1096#1072#1102
      ImageIndex = 35
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusAway: TMenuItem
      Caption = #1054#1090#1086#1096#1105#1083
      ImageIndex = 29
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusNA: TMenuItem
      Caption = #1053#1077#1076#1086#1089#1090#1091#1087#1077#1085
      ImageIndex = 34
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusOccupied: TMenuItem
      Caption = #1047#1072#1085#1103#1090
      ImageIndex = 32
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusDND: TMenuItem
      Caption = #1053#1077' '#1073#1077#1089#1087#1086#1082#1086#1080#1090#1100
      ImageIndex = 33
      OnClick = JabberStatusOnlineClick
    end
    object N17: TMenuItem
      Caption = '-'
    end
    object JabberStatusOnline: TMenuItem
      Caption = #1042' '#1089#1077#1090#1080
      ImageIndex = 28
      OnClick = JabberStatusOnlineClick
    end
    object JabberStatusInvisible: TMenuItem
      Caption = #1053#1077#1074#1080#1076#1080#1084#1099#1081
      ImageIndex = 31
      OnClick = JabberStatusOnlineClick
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object JabberStatusOffline: TMenuItem
      Caption = #1053#1077' '#1074' '#1089#1077#1090#1080
      Default = True
      ImageIndex = 30
      OnClick = JabberStatusOfflineClick
    end
  end
  object ContactPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = AllImageList
    Left = 48
    Top = 232
    object SendMessageForContact: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      ImageIndex = 163
      OnClick = SendMessageForContactClick
    end
    object SendFileMenu: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1092#1072#1081#1083
      ImageIndex = 149
      object SendFileUpWapru: TMenuItem
        Tag = 1
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1095#1077#1088#1077#1079' UpWap.ru'
        ImageIndex = 149
        OnClick = SendFileUpWapruClick
      end
    end
    object CheckStatusContact: TMenuItem
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1090#1072#1090#1091#1089#1072
      ImageIndex = 172
      OnClick = CheckStatusContactClick
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object AnketaContact: TMenuItem
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1086#1085#1090#1072#1082#1090#1077
      ImageIndex = 178
      OnClick = AnketaContactClick
    end
    object HistoryContact: TMenuItem
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 147
      OnClick = HistoryContactClick
    end
    object CopyAccountContact: TMenuItem
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1084#1103' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 144
      OnClick = CopyAccountContactClick
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object AddNewContact: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090' '#1074' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 143
      Visible = False
      OnClick = AddNewContactClick
    end
    object EditContact: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      ImageIndex = 141
      OnClick = EditContactClick
    end
    object DeleteContact: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      ImageIndex = 142
      OnClick = DeleteContactClick
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object NextContactMenu: TMenuItem
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ImageIndex = 222
      object GrandAuthContact: TMenuItem
        Caption = #1055#1086#1079#1074#1086#1083#1080#1090#1100' '#1076#1086#1073#1072#1074#1080#1090#1100' '#1074#1072#1089
        ImageIndex = 140
        OnClick = GrandAuthContactClick
      end
      object SendAddContact: TMenuItem
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' "'#1042#1072#1089' '#1076#1086#1073#1072#1074#1080#1083#1080'"'
        OnClick = SendAddContactClick
      end
      object DelYourSelfContact: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1077#1073#1103' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1077#1073#1103' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '#1082#1086#1085#1090#1072#1082#1090#1072
        ImageIndex = 139
        OnClick = DelYourSelfContactClick
      end
      object SendInviteContact: TMenuItem
        Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1088#1080#1075#1083#1072#1096#1077#1085#1080#1077
        OnClick = SendInviteContactClick
      end
    end
  end
  object RightICQPopupMenu: TPopupMenu
    AutoPopup = False
    Images = AllImageList
    OnPopup = RightICQPopupMenuPopup
    Left = 48
    Top = 296
    object UnstableICQStatus: TMenuItem
      Caption = #1053#1077#1089#1090#1072#1073#1080#1083#1100#1085#1099#1081' '#1089#1090#1072#1090#1091#1089
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
    OnSessionClosed = MRAAvatarHttpClientSessionClosed
    OnDocEnd = MRAAvatarHttpClientDocEnd
    OnSendEnd = MRAAvatarHttpClientSendEnd
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = MRAAvatarHttpClientSocksConnected
    OnSocksError = MRAAvatarHttpClientSocksError
    Left = 80
    Top = 64
  end
  object RightMRAPopupMenu: TPopupMenu
    Images = AllImageList
    Left = 80
    Top = 296
    object UnstableMRAStatus: TMenuItem
      Caption = #1053#1077#1089#1090#1072#1073#1080#1083#1100#1085#1099#1081' '#1089#1090#1072#1090#1091#1089
      ImageIndex = 230
    end
  end
  object RightJabberPopupMenu: TPopupMenu
    Images = AllImageList
    Left = 112
    Top = 296
    object UnstableJabberStatus: TMenuItem
      Caption = #1053#1077#1089#1090#1072#1073#1080#1083#1100#1085#1099#1081' '#1089#1090#1072#1090#1091#1089
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
    Images = AllImageList
    OnPopup = BottomPanelPopupMenuPopup
    Left = 160
    Top = 144
    object TopMainButtonONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1043#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102
      ImageIndex = 230
      OnClick = TopMainButtonONMenuClick
    end
    object TopOnlyOnlineONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1057#1082#1088#1099#1090#1100' '#1086#1092#1092#1083#1072#1081#1085' '#1082#1086#1085#1090#1072#1082#1090#1099
      Checked = True
      ImageIndex = 140
      OnClick = TopOnlyOnlineONMenuClick
    end
    object TopGroupONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1057#1082#1088#1099#1090#1100' '#1075#1088#1091#1087#1087#1099
      Checked = True
      ImageIndex = 140
      OnClick = TopGroupONMenuClick
    end
    object TopSoundsONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1047#1074#1091#1082#1080
      Checked = True
      ImageIndex = 140
      OnClick = TopSoundsONMenuClick
    end
    object TopPrivatONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1055#1088#1080#1074#1072#1090#1085#1099#1077' '#1089#1087#1080#1089#1082#1080
      Checked = True
      ImageIndex = 140
      OnClick = TopPrivatONMenuClick
    end
    object TopHistoryONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1048#1089#1090#1086#1088#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      Checked = True
      ImageIndex = 140
      OnClick = TopHistoryONMenuClick
    end
    object TopSettingsONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1053#1072#1089#1090#1088#1086#1081#1082#1080
      Checked = True
      ImageIndex = 140
      OnClick = TopSettingsONMenuClick
    end
    object TopTrafficONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1058#1088#1072#1092#1080#1082
      Checked = True
      ImageIndex = 140
      OnClick = TopTrafficONMenuClick
    end
  end
  object BottomPanelPopupMenu: TPopupMenu
    Images = AllImageList
    OnPopup = BottomPanelPopupMenuPopup
    Left = 160
    Top = 176
    object MainButtonONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1043#1083#1072#1074#1085#1086#1077' '#1084#1077#1085#1102
      Checked = True
      ImageIndex = 140
      OnClick = MainButtonONMenuClick
    end
    object OnlyOnlineONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1057#1082#1088#1099#1090#1100' '#1086#1092#1092#1083#1072#1081#1085' '#1082#1086#1085#1090#1072#1082#1090#1099
      ImageIndex = 230
      OnClick = OnlyOnlineONMenuClick
    end
    object GroupONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1057#1082#1088#1099#1090#1100' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 230
      OnClick = GroupONMenuClick
    end
    object SoundsONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1047#1074#1091#1082#1080
      ImageIndex = 230
      OnClick = SoundsONMenuClick
    end
    object PrivatONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1055#1088#1080#1074#1072#1090#1085#1099#1077' '#1089#1087#1080#1089#1082#1080
      ImageIndex = 230
      OnClick = PrivatONMenuClick
    end
    object HistoryONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1048#1089#1090#1086#1088#1080#1103' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 230
      OnClick = HistoryONMenuClick
    end
    object SettingsONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 230
      OnClick = SettingsONMenuClick
    end
    object TrafficONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1058#1088#1072#1092#1080#1082
      ImageIndex = 230
      OnClick = TrafficONMenuClick
    end
    object TopPanelONMenu: TMenuItem
      Caption = #1050#1085#1086#1087#1082#1072' - '#1042#1077#1088#1093#1085#1103#1103' '#1087#1072#1085#1077#1083#1100
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
end
