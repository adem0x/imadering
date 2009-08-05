object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'IMadering'
  ClientHeight = 401
  ClientWidth = 197
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
    Top = 1
    Width = 197
    Height = 375
    Margins.Left = 0
    Margins.Top = 1
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ButtonFlow = cbfVertical
    ButtonHeight = 20
    ButtonOptions = [boFullSize, boGradientFill, boShowCaptions, boBoldCaptions, boUsePlusMinus, boCaptionOnlyBorder]
    Images = AllImageList
    BackgroundGradientDirection = gdVertical
    Categories = <>
    GradientDirection = gdVertical
    PopupMenu = ContactListPopupMenu
    RegularButtonColor = clWhite
    SelectedButtonColor = 15717318
    ShowHint = True
    TabOrder = 0
    OnButtonClicked = ContactListButtonClicked
    OnContextPopup = ContactListContextPopup
    OnHotButton = ContactListHotButton
  end
  object ToolBar2: TToolBar
    Left = 0
    Top = 376
    Width = 197
    Height = 25
    Margins.Left = 1
    Margins.Top = 0
    Margins.Right = 1
    Margins.Bottom = 0
    Align = alBottom
    Color = clBtnFace
    EdgeBorders = [ebTop]
    Images = AllImageList
    ParentColor = False
    TabOrder = 1
    Transparent = False
    Wrapable = False
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
    object SoundOnOffToolButton: TToolButton
      Left = 92
      Top = 0
      Hint = '<b>'#1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1079#1074#1091#1082#1080'</b>'
      ImageIndex = 135
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = SoundOnOffToolButtonClick
    end
    object OnlyOnlineContactsToolButton: TToolButton
      Left = 115
      Top = 0
      Hint = '<b>'#1057#1082#1088#1099#1090#1100' '#1086#1092#1092#1083#1072#1081#1085' '#1082#1086#1085#1090#1072#1082#1090#1099'</b>'
      ImageIndex = 138
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = OnlyOnlineContactsToolButtonClick
    end
  end
  object ICQTrayIcon: TTrayIcon
    Hint = 'IMadering ICQ'
    Icon.Data = {
      0000010001001010000001001800680300001600000028000000100000002000
      0000010018000000000000000000480000004800000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313AB40E18AA
      030DA1000000313AB40E18AA030DA10000000000000000000000000000000000
      000000000000005D64C98485F5676BF44E59F3030EA24E59F34E59F34E59F303
      0EA20000000000000000000000000000000000000000007279D5AAADF6999CF6
      8485F51D27AE8485F5676BF44E59F31D27AE0000000000000000000000000000
      005F66CB4951BE2E37B2787ECBBDC0F7AAADF63E46B9AAADF6999CF68485F53E
      46B9030EA6030D9D000000000000888EE3999CF68485F5676BF4353DB58186CB
      D2D4F7575EC6D2D4F7BDC0F7686FD05C61D94E59F34E59F3030D9F000000989E
      EDBDC0F7AAADF6999CF68485F5353DB59095E6575EC6BDC0F75C61D99095E699
      9CF68485F5676BF41A24AD000000A3A8F5E2E3F7D2D4F7BDC0F7AAADF6AAADF6
      5C61D92AF0EE5C61D9D2D4F7D2D4F7BDC0F7AAADF6999CF6424ABB0000000000
      005F66CB4951BE2E37B2030EA6030EA647EEDE36EFDF3AEFED4951BE4951BE2E
      37B2030EA6030D9D000000000000888EE3999CF68485F5676BF44E59F34E59F3
      353EB636EFDF353EB69095E6AAADF6999CF68485F5676BF4030D9F000000989E
      EDBDC0F7AAADF6999CF6656BD6353EB64E59F3353EB6676BF4353DB57C81CDBD
      C0F7AAADF6999CF61A24AD000000A3A8F5E2E3F7D2D4F79398E46269CC676BF4
      4E59F31D27AE676BF44E59F33A42B78489CED2D4F7BDC0F7424ABB0000000000
      00A5AAF69EA3F08389E0AAADF6999CF68485F53E46B9999CF68485F5676BF43E
      46B98389E17279D60000000000000000000000000000009399E9D2D4F7BDC0F7
      AAADF6575EC6BDC0F7AAADF6999CF6575EC60000000000000000000000000000
      000000000000009EA3F0E9EAF7E2E3F7D2D4F76C73D2E2E3F7D2D4F7BDC0F76C
      73D2000000000000000000000000000000000000000000000000A0A5F1969CEB
      8C92E4000000A0A5F1969CEB8C92E4000000000000000000000000000000FFFF
      0000F11F0000E00F0000E00F0000800300000001000000010000000100008003
      000000010000000100000001000080030000E00F0000E00F0000F11F0000}
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = ICQTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 16
  end
  object TrayPopupMenu: TPopupMenu
    Images = AllImageList
    OnPopup = TrayPopupMenuPopup
    Left = 16
    Top = 112
    object HideInTrayTray: TMenuItem
      Caption = #1057#1082#1088#1099#1090#1100' IMadering'
      ImageIndex = 4
      OnClick = ICQTrayIconClick
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
        Name = 'ICQMessagesTimer'
        Interval = 500
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
        Name = 'MRAMessagesTimer'
        Enabled = False
      end
      item
        Name = 'JabberMessagesTimer'
        Enabled = False
      end
      item
        Name = 'ConnectIconTimer'
        Enabled = False
        OnTimer = JvTimerListEvents5Timer
      end
      item
        Name = 'ICQFuckStatusTimer'
        Enabled = False
        Interval = 20000
        OnTimer = JvTimerListEvents6Timer
      end
      item
        Name = 'ICQAliveTimer'
        Enabled = False
        Interval = 60000
        OnTimer = JvTimerListEvents7Timer
      end
      item
        Name = 'AutoHideCLTimer'
        Enabled = False
        Interval = 10000
        OnTimer = JvTimerListEvents8Timer
      end
      item
        Name = 'CreateSmiliesFormTimer'
        Cycled = False
        Enabled = False
        OnTimer = JvTimerListEvents9Timer
      end
      item
        Name = 'ZipHistoryTimer'
        Interval = 60000
        OnTimer = JvTimerListEvents10Timer
      end>
    Left = 16
    Top = 264
  end
  object MainPopupMenu: TPopupMenu
    AutoPopup = False
    Images = AllImageList
    Left = 16
    Top = 328
    object N4: TMenuItem
      Caption = #1058#1077#1089#1090'!'
      Visible = False
      OnClick = N4Click
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
      OnClick = ICQTrayIconClick
    end
    object CloseProgram: TMenuItem
      Caption = #1042#1099#1081#1090#1080' '#1080#1079' IMadering'
      ImageIndex = 3
      OnClick = CloseProgramClick
    end
  end
  object MRATrayIcon: TTrayIcon
    Hint = 'IMadering MRA'
    Icon.Data = {
      0000010001001010000001001800680300001600000028000000100000002000
      0000010018000000000000000000600000006000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004E4EFF4E4EFF4E4EFF4E4EFF4E4EFF4E4EFF4E4EFF00
      00000000000000000000000000000000000000000000006B6BFA3434D75858E0
      8989EAAFAFF19494EB5050DC2B2BD16B6BFA0000000000000000000000000000
      000000006B6BFA3B3BDCBBBBF4FDFDFFFDFDFFFDFDFFFDFDFFFDFDFFFDFDFFFD
      FDFF0000000000000000000000000000004E4EFF3737E0B8B8F4FDFDFFB8B8F4
      5858E43333DD4747E0B7B7F2CCCCF57E7EE36B6BFA0000000000000000000000
      004E4EFF5B5BE9FDFDFFC0C0F73A3AE66969EC9D9DF46F6FEF4646E73C3CE134
      34DB2727D54E4EFF0000000000000000004E4EFF9393F3FDFDFF6868EF6969F0
      FFFFFFFDFDFFFDFDFF7373F34242EDFDFDFF9393F24E4EFF0000000000000000
      004E4EFFACACF8FDFDFF4C4CF29E9EF4FDFDFFFDFDFFFDFDFFA2A2F84A4AF2FD
      FDFFA5A5F84E4EFF0000000000000000004E4EFF9C9CF9FDFDFF6363F76B6BF0
      FDFDFFFDFDFFFDFDFF6868F64747F2FDFDFF8B8BF64E4EFF0000000000000000
      004E4EFF6B6BFAFDFDFFBBBBFD3F3FF86868F1A5A5F66B6BF75454F9B7B7FEFD
      FDFF4848F44E4EFF0000000000000000004E4EFF4949FCCBCBFEFDFDFFB7B7FE
      6161FC4343FC6A6AFDD3D3FEFDFDFF8B8BFD3C3CF94E4EFF0000000000000000
      000000006B6BFA5252FECBCBFEFDFDFFFDFDFFFDFDFFFDFDFFFDFDFF9999FE44
      44FE6B6BFA0000000000000000000000000000000000006B6BFA4B4BFF6A6AFF
      9090FEB1B1FDA1A1FE5D5DFF4949FF6B6BFA0000000000000000000000000000
      000000000000000000004E4EFF4E4EFF4E4EFF4E4EFF5454FF4E4EFF4E4EFF00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000F01F0000E00F0000C00F00008007000080030000800300008003
      0000800300008003000080030000C0070000E00F0000F01F0000FFFF0000}
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = MRATrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 48
  end
  object JabberTrayIcon: TTrayIcon
    Hint = 'IMadering Jabber'
    Icon.Data = {
      0000010001001010000001001800680300001600000028000000100000002000
      0000010018000000000000000000000000000000000000000000000000000000
      0044424232303032303000000000000000000000000000000000000000000000
      00000000000000000000000000006E6D6D9E9D9D4D4B4BB1A875343232000000
      000000000000000000000000000000000000000000000000000000000000BBBB
      BB747373CEC8A84D4B4BB4AB7A37353400000000000000000000000000000000
      0000000000000000000000000000929191FFFFFF747373D1CCAE4F4E4DB7AF80
      39373742405909005001014A09005032006D5A5ADE0000000000000000000000
      00929191FFFFFF777575D4CFB4514F4F4240594A4AD55656ED5959F35656ED48
      48D2262690262690000000000000000000000000949393FFFFFF7978785C5B95
      2C2D765F5FF66060F65F5FF65D5DF55B5BF45757EF3535AE2626900000000000
      000000000000009695956969853E3FA06666F93031786B6AFB6969FA6666F961
      61F75D5DF55757EF2626905A5ADE0000000000000000005927C25959EA6B6AFB
      4748A47A79FE5051BD4E4FBD7373FD6B6AFB6363F85D5DF54848D232006D0000
      000000000000003931BA6968F97777FE8888FF8384DBB0B0FFA4A4FF5758BE77
      77FE6B6AFB6161F75858EE0900500000000000000000003535BE7373FD8888FF
      BDBDFFA7A8DBD7D8FFD1D1FFBDBDFF8888FF7373FD6666F95D5DF501014A0000
      000000000000003D34C27877FCA4A4FFD1D1FFE5E6FFBFC0DBE5E6FFD1D1FFA4
      A4FF7A79FE6969FA5C5CF10F065D0000000000000000005E2CCF6E6EF2B0B0FF
      D7D8FFEEEFFFFEFFFFEEEFFFD7D8FFB0B0FF7C7CFE6B6AFB5454E34412930000
      000000000000005A5ADE5353DDA1A1FED1D1FFE5E6FFEEEFFFE5E6FFD1D1FFA4
      A4FF7A79FE6868F84040C65A5ADE0000000000000000000000005E2CCF6868E8
      BABAFED1D1FFD7D8FFD1D1FFBDBDFF8888FF7171FB4F4FDA5E2CCF0000000000
      000000000000000000000000005E2CCF5A5ADE8F8FF3ACACFDA4A4FF8585FD6A
      6AF04A49D25E2CCF000000000000000000000000000000000000000000000000
      5A5ADE5F2DD13E35C63737C33C33C15C2AC95A5ADE0000000000000000008FFF
      000007FF000003FF00000007000080030000C0010000E0000000E0000000E000
      0000E0000000E0000000E0000000E0000000F0010000F8030000FC070000}
    Icons = AllImageList
    PopupMenu = TrayPopupMenu
    OnClick = JabberTrayIconClick
    OnMouseDown = ICQTrayIconMouseDown
    Left = 16
    Top = 80
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
    OnSessionClosed = ICQWSocketSessionClosed
    OnSessionConnected = ICQWSocketSessionConnected
    Left = 48
    Top = 16
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
    Left = 48
    Top = 48
  end
  object JabberWSocket: TWSocket
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
    Left = 48
    Top = 80
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
    Left = 80
    Top = 16
  end
  object HttpClient: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Mozilla/4.0 (compatible; ICS)'
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
    OnDocBegin = HttpClientDocBegin
    OnDocEnd = HttpClientDocEnd
    SocksAuthentication = socksNoAuthentication
    Left = 152
    Top = 328
  end
  object ContactListPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = AllImageList
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
    object N5: TMenuItem
      Caption = '-'
    end
    object AddNewGroupCL: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 153
      OnClick = AddNewGroupCLClick
    end
    object RenemeGroupCL: TMenuItem
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 154
      OnClick = RenemeGroupCLClick
    end
    object DeleteGroupCL: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
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
    object AddNewContactCL: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
      ImageIndex = 143
      OnClick = AddNewContactCLClick
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
      Tag = 999
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
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object MRAStatusAway: TMenuItem
      Caption = #1054#1090#1086#1096#1105#1083
      ImageIndex = 22
    end
    object MRAStatusDND: TMenuItem
      Caption = #1053#1077' '#1073#1077#1089#1087#1086#1082#1086#1080#1090#1100
      ImageIndex = 27
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object MRAStatusOnline: TMenuItem
      Caption = #1042' '#1089#1077#1090#1080
      ImageIndex = 24
    end
    object MRAStatusInvisible: TMenuItem
      Caption = #1053#1077#1074#1080#1076#1080#1084#1099#1081
      ImageIndex = 21
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object MRAStatusOffline: TMenuItem
      Caption = #1053#1077' '#1074' '#1089#1077#1090#1080
      Default = True
      ImageIndex = 23
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
    object N17: TMenuItem
      Caption = '-'
    end
    object JabberStatusOnline: TMenuItem
      Caption = #1042' '#1089#1077#1090#1080
      ImageIndex = 28
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object JabberStatusOffline: TMenuItem
      Caption = #1053#1077' '#1074' '#1089#1077#1090#1080
      Default = True
      ImageIndex = 30
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
    object N24: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090' '#1074' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 143
      Visible = False
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
      object FrandAuthContact: TMenuItem
        Caption = #1055#1086#1079#1074#1086#1083#1080#1090#1100' '#1076#1086#1073#1072#1074#1080#1090#1100' '#1074#1072#1089
        ImageIndex = 140
        OnClick = FrandAuthContactClick
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
    Left = 48
    Top = 296
    object UnstableICQStatus: TMenuItem
      Caption = #1053#1077#1089#1090#1072#1073#1080#1083#1100#1085#1099#1081' '#1089#1090#1072#1090#1091#1089
      OnClick = UnstableICQStatusClick
    end
  end
  object ZipHistoryThread: TIdThreadComponent
    Active = False
    Loop = False
    Priority = tpNormal
    StopMode = smTerminate
    OnRun = ZipHistoryThreadRun
    Left = 16
    Top = 144
  end
end
