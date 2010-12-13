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
    Top = 108
    Width = 425
    Height = 211
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
  object TranslitCheckBox: TCheckBox
    Left = 8
    Top = 85
    Width = 409
    Height = 17
    TabStop = False
    Caption = '#Enable translit'
    TabOrder = 6
  end
  object GtransClient: THttpCli
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
    OnSessionClosed = GtransClientSessionClosed
    OnDocBegin = GtransClientDocBegin
    OnRequestDone = GtransClientRequestDone
    SocksAuthentication = socksNoAuthentication
    OnSocksConnected = GtransClientSocksConnected
    OnSocksError = GtransClientSocksError
    Left = 160
    Top = 144
  end
  object ClearMessPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Images = MainForm.AllImageList
    Left = 192
    Top = 144
    object GTClearList: TMenuItem
      ImageIndex = 139
      OnClick = GTClearListClick
    end
  end
end
