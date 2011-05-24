object ContactSearchForm: TContactSearchForm
  Left = 0
  Top = 0
  ClientHeight = 526
  ClientWidth = 593
  Color = clBtnFace
  Constraints.MinHeight = 510
  Constraints.MinWidth = 601
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
  object CenterPanel: TPanel
    Left = 0
    Top = 188
    Width = 593
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object NotPreviousClearCheckBox: TCheckBox
      Left = 12
      Top = 7
      Width = 231
      Height = 17
      TabStop = False
      TabOrder = 0
    end
    object OnlyOnlineCheckBox: TCheckBox
      Left = 249
      Top = 7
      Width = 113
      Height = 17
      TabStop = False
      TabOrder = 1
    end
    object SearchBitBtn: TBitBtn
      Left = 368
      Top = 3
      Width = 94
      Height = 25
      Default = True
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
      TabStop = False
      OnClick = SearchBitBtnClick
    end
    object SearchNextPageBitBtn: TBitBtn
      Left = 468
      Top = 3
      Width = 117
      Height = 25
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
      TabStop = False
      OnClick = SearchNextPageBitBtnClick
    end
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 494
    Width = 593
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object ResultClearSpeedButton: TSpeedButton
      Left = 246
      Top = 6
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = ResultClearSpeedButtonClick
    end
    object SendQMessageSpeedButton: TSpeedButton
      Left = 558
      Top = 6
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SendQMessageSpeedButtonClick
    end
    object StatusPanel: TPanel
      Left = 5
      Top = 6
      Width = 147
      Height = 22
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
    end
    object ResultPanel: TPanel
      Left = 158
      Top = 6
      Width = 82
      Height = 22
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = '0'
      TabOrder = 1
    end
    object QMessageEdit: TEdit
      Tag = 1
      Left = 284
      Top = 6
      Width = 268
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnEnter = QMessageEditEnter
      OnExit = QMessageEditExit
    end
  end
  object SearchResultJvListView: TJvListView
    Left = 0
    Top = 223
    Width = 593
    Height = 271
    Align = alClient
    Columns = <
      item
        Width = 22
      end
      item
        Width = 18
      end
      item
        Width = 115
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 18
      end
      item
        Width = 80
      end
      item
        Width = 80
      end
      item
        Width = 80
      end>
    DoubleBuffered = True
    Groups = <>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    PopupMenu = SearchResultPopupMenu
    SmallImages = MainForm.AllImageList
    TabOrder = 2
    TabStop = False
    ViewStyle = vsReport
    OnChanging = SearchResultJvListViewChanging
    OnColumnClick = SearchResultJvListViewColumnClick
    OnDblClick = SearchResultJvListViewDblClick
    OnGetImageIndex = SearchResultJvListViewGetImageIndex
    OnGetSubItemImage = SearchResultJvListViewGetSubItemImage
    OnMouseDown = SearchResultJvListViewMouseDown
    AutoSelect = False
    ColumnsOrder = '0=22,1=18,2=115,3=80,4=80,5=80,6=80,7=80,8=18,9=80,10=80,11=80'
    HeaderImagePosition = hipRight
    HeaderImages = MainForm.AllImageList
    ExtendedColumns = <
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end
      item
        HeaderImagePosition = hipRight
        UseParentHeaderImagePosition = False
      end>
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 188
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object GlobalSearchGroupBox: TGroupBox
      Left = 225
      Top = 5
      Width = 363
      Height = 179
      TabOrder = 0
      object NickLabel: TLabel
        Left = 55
        Top = 40
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object NameLabel: TLabel
        Left = 55
        Top = 66
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object FamilyLabel: TLabel
        Left = 55
        Top = 93
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object GenderLabel: TLabel
        Left = 55
        Top = 120
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object AgeLabel: TLabel
        Left = 55
        Top = 147
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object MaritalLabel: TLabel
        Left = 245
        Top = 120
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object CountryLabel: TLabel
        Left = 245
        Top = 39
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object CityLabel: TLabel
        Left = 245
        Top = 66
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object LangLabel: TLabel
        Left = 245
        Top = 93
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object KeyWordLabel: TLabel
        Left = 245
        Top = 147
        Width = 3
        Height = 13
        Alignment = taRightJustify
      end
      object Bevel3: TBevel
        Left = 169
        Top = 34
        Width = 3
        Height = 134
        Shape = bsLeftLine
      end
      object NickEdit: TEdit
        Left = 62
        Top = 36
        Width = 101
        Height = 21
        TabStop = False
        TabOrder = 1
        OnChange = NickEditChange
      end
      object NameEdit: TEdit
        Left = 62
        Top = 63
        Width = 101
        Height = 21
        TabStop = False
        TabOrder = 2
        OnChange = NickEditChange
      end
      object FamilyEdit: TEdit
        Left = 62
        Top = 90
        Width = 101
        Height = 21
        TabStop = False
        TabOrder = 3
        OnChange = NickEditChange
      end
      object GenderComboBox: TComboBox
        Left = 62
        Top = 117
        Width = 101
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        TabStop = False
        OnChange = NickEditChange
      end
      object AgeComboBox: TComboBox
        Left = 62
        Top = 144
        Width = 101
        Height = 21
        Style = csDropDownList
        TabOrder = 5
        TabStop = False
        OnChange = NickEditChange
        Items.Strings = (
          ''
          '13-18'
          '18-23'
          '23-30'
          '30-40'
          '40-50'
          '50-60'
          '60 ...')
      end
      object MaritalComboBox: TComboBox
        Left = 252
        Top = 117
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 6
        TabStop = False
        OnChange = NickEditChange
      end
      object CountryComboBox: TComboBox
        Left = 252
        Top = 36
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 7
        TabStop = False
        OnChange = NickEditChange
      end
      object CityEdit: TEdit
        Left = 252
        Top = 63
        Width = 101
        Height = 21
        TabStop = False
        TabOrder = 8
        OnChange = NickEditChange
      end
      object LangComboBox: TComboBox
        Left = 252
        Top = 90
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 9
        TabStop = False
        OnChange = NickEditChange
      end
      object KeyWordEdit: TEdit
        Left = 252
        Top = 144
        Width = 101
        Height = 21
        TabStop = False
        TabOrder = 0
        OnChange = NickEditChange
      end
      object GlobalSearchCheckBox: TCheckBox
        Left = 10
        Top = 8
        Width = 302
        Height = 17
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = GlobalSearchCheckBoxClick
      end
    end
    object UINSearchGroupBox: TGroupBox
      Left = 5
      Top = 5
      Width = 214
      Height = 55
      TabOrder = 1
      object UINSearchCheckBox: TCheckBox
        Left = 9
        Top = 8
        Width = 196
        Height = 17
        TabStop = False
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = UINSearchCheckBoxClick
      end
      object UINSearchEdit: TEdit
        Left = 9
        Top = 28
        Width = 196
        Height = 21
        TabStop = False
        TabOrder = 1
        OnChange = UINSearchEditChange
      end
    end
    object EmailSearchGroupBox: TGroupBox
      Left = 5
      Top = 66
      Width = 214
      Height = 56
      TabOrder = 2
      object EmailSearchCheckBox: TCheckBox
        Left = 9
        Top = 9
        Width = 196
        Height = 17
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = EmailSearchCheckBoxClick
      end
      object EmailSearchEdit: TEdit
        Left = 9
        Top = 29
        Width = 196
        Height = 21
        TabStop = False
        TabOrder = 1
        OnChange = EmailSearchEditChange
      end
    end
    object KeyWordSearchGroupBox: TGroupBox
      Left = 5
      Top = 128
      Width = 214
      Height = 56
      TabOrder = 3
      object KeyWordSearchCheckBox: TCheckBox
        Left = 9
        Top = 8
        Width = 196
        Height = 17
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = KeyWordSearchCheckBoxClick
      end
      object KeyWordSearchEdit: TEdit
        Left = 9
        Top = 28
        Width = 196
        Height = 21
        TabStop = False
        TabOrder = 1
        OnChange = KeyWordSearchEditChange
      end
    end
  end
  object SearchResultPopupMenu: TPopupMenu
    Alignment = paCenter
    AutoHotkeys = maManual
    Images = MainForm.AllImageList
    OnPopup = SearchResultPopupMenuPopup
    Left = 280
    Top = 312
    object ICQStatusCheckSM: TMenuItem
      Tag = 1
      ImageIndex = 172
      OnClick = ICQStatusCheckSMClick
    end
    object AccountNameCopySM: TMenuItem
      Tag = 2
      ImageIndex = 144
      OnClick = AccountNameCopySMClick
    end
    object SendMessageSM: TMenuItem
      Tag = 3
      ImageIndex = 163
      OnClick = SendMessageSMClick
    end
    object ContactInfoSM: TMenuItem
      Tag = 4
      ImageIndex = 178
      OnClick = ContactInfoSMClick
    end
    object AddContactInCLSM: TMenuItem
      Tag = 5
      ImageIndex = 143
      OnClick = AddContactInCLSMClick
    end
    object SaveSM: TMenuItem
      ImageIndex = 225
      OnClick = SaveSMClick
    end
    object LoadSM: TMenuItem
      ImageIndex = 227
      OnClick = LoadSMClick
    end
  end
  object LoadSearchResultFileDialog: TOpenTextFileDialog
    DefaultExt = '.txt'
    FileName = 'ICQ search result'
    Filter = 'Text Files (*.txt)|*.txt'
    Encodings.Strings = (
      'Unicode')
    Left = 312
    Top = 312
  end
end
