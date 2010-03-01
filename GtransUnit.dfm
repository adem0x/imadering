object GTransForm: TGTransForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 319
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object YourLangLabel: TLabel
    Left = 9
    Top = 8
    Width = 3
    Height = 13
  end
  object ToLangLabel: TLabel
    Left = 225
    Top = 8
    Width = 3
    Height = 13
  end
  object CancelBitBtn: TBitBtn
    Left = 8
    Top = 54
    Width = 98
    Height = 25
    DoubleBuffered = True
    ModalResult = 2
    ParentDoubleBuffered = False
    TabOrder = 0
    TabStop = False
    OnClick = CancelBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 319
    Top = 54
    Width = 98
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    OnClick = OKBitBtnClick
  end
  object YourLangComboBox: TComboBox
    Left = 8
    Top = 27
    Width = 193
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    TabOrder = 2
    TabStop = False
  end
  object ToLangComboBox: TComboBox
    Left = 224
    Top = 27
    Width = 193
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    TabOrder = 3
    TabStop = False
  end
  object GtransListView: TListView
    Left = 0
    Top = 85
    Width = 425
    Height = 234
    Align = alBottom
    Columns = <
      item
        Width = 22
      end
      item
        Width = 110
      end
      item
        Width = 215
      end
      item
        Width = 70
      end>
    ColumnClick = False
    DoubleBuffered = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    SmallImages = MainForm.AllImageList
    TabOrder = 4
    TabStop = False
    ViewStyle = vsReport
    OnMouseDown = GtransListViewMouseDown
  end
  object GtansReset: TBitBtn
    Left = 136
    Top = 54
    Width = 153
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 5
    TabStop = False
    OnClick = GtansResetClick
  end
  object GtransHttpClient: THttpCli
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
    OnSessionClosed = GtransHttpClientSessionClosed
    OnDocBegin = GtransHttpClientDocBegin
    OnRequestDone = GtransHttpClientRequestDone
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = GtransHttpClientSocksConnected
    OnSocksError = GtransHttpClientSocksError
    Left = 160
    Top = 144
  end
  object ClearMessPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = ClearMessPopupMenuPopup
    Left = 192
    Top = 144
    object GTClearList: TMenuItem
      ImageIndex = 139
      OnClick = GTClearListClick
    end
  end
end
