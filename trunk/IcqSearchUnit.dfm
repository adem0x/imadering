object IcqSearchForm: TIcqSearchForm
  Left = 0
  Top = 0
  Caption = #1055#1086#1080#1089#1082' '#1085#1086#1074#1099#1093' '#1082#1086#1085#1090#1072#1082#1090#1086#1074' ICQ'
  ClientHeight = 526
  ClientWidth = 593
  Color = clBtnFace
  Constraints.MinHeight = 510
  Constraints.MinWidth = 601
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 214
    Width = 593
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object NotPreviousClearCheckBox: TCheckBox
      Left = 12
      Top = 7
      Width = 216
      Height = 17
      Caption = #1053#1077' '#1086#1095#1080#1097#1072#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
      TabOrder = 0
    end
    object OnlyOnlineCheckBox: TCheckBox
      Left = 250
      Top = 7
      Width = 123
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' "'#1042' '#1089#1077#1090#1080'"'
      TabOrder = 1
    end
    object SearchBitBtn: TBitBtn
      Left = 388
      Top = 3
      Width = 94
      Height = 25
      Caption = #1048#1089#1082#1072#1090#1100
      Default = True
      TabOrder = 2
      OnClick = SearchBitBtnClick
    end
    object SearchNextPageBitBtn: TBitBtn
      Left = 488
      Top = 3
      Width = 93
      Height = 25
      Caption = #1044#1072#1083#1077#1077
      Enabled = False
      TabOrder = 3
      OnClick = SearchNextPageBitBtnClick
    end
  end
  object Panel2: TPanel
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
      Caption = #1057#1090#1072#1090#1091#1089' '#1087#1086#1080#1089#1082#1072
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
    Top = 249
    Width = 593
    Height = 245
    Align = alClient
    Columns = <
      item
        Width = 22
      end
      item
        Width = 18
      end
      item
        Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
        Width = 115
      end
      item
        Caption = #1053#1080#1082
        Width = 80
      end
      item
        Caption = #1048#1084#1103
        Width = 80
      end
      item
        Caption = #1060#1072#1084#1080#1083#1080#1103
        Width = 80
      end
      item
        Caption = #1055#1086#1083' - '#1042#1086#1079#1088#1072#1089#1090
        Width = 80
      end
      item
        Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
        Width = 80
      end
      item
        Width = 18
      end
      item
        Caption = #1057#1090#1088#1072#1085#1072
        Width = 80
      end
      item
        Caption = #1043#1086#1088#1086#1076
        Width = 80
      end
      item
        Caption = 'E-mail'
        Width = 80
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    PopupMenu = SearchResultPopupMenu
    SmallImages = MainForm.AllImageList
    TabOrder = 2
    ViewStyle = vsReport
    OnChanging = SearchResultJvListViewChanging
    OnColumnClick = SearchResultJvListViewColumnClick
    OnContextPopup = SearchResultJvListViewContextPopup
    OnGetImageIndex = SearchResultJvListViewGetImageIndex
    OnGetSubItemImage = SearchResultJvListViewGetSubItemImage
    OnMouseDown = SearchResultJvListViewMouseDown
    AutoSelect = False
    ColumnsOrder = '0=22,1=18,2=115,3=80,4=80,5=80,6=80,7=80,8=18,9=80,10=80,11=80'
    HeaderImagePosition = hipRight
    HeaderImages = MainForm.AllImageList
    Groups = <>
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
  object Panel12: TPanel
    Left = 0
    Top = 0
    Width = 593
    Height = 214
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object GlobalSearchGroupBox: TGroupBox
      Left = 225
      Top = 5
      Width = 363
      Height = 205
      TabOrder = 0
      object NickLabel: TLabel
        Left = 33
        Top = 40
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = #1053#1080#1082':'
      end
      object NameLabel: TLabel
        Left = 33
        Top = 66
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = #1048#1084#1103':'
      end
      object FamilyLabel: TLabel
        Left = 8
        Top = 93
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = #1060#1072#1084#1080#1083#1080#1103':'
      end
      object GenderLabel: TLabel
        Left = 33
        Top = 120
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = #1055#1086#1083':'
      end
      object AgeLabel: TLabel
        Left = 12
        Top = 147
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = #1042#1086#1079#1088#1072#1089#1090':'
      end
      object MaritalLabel: TLabel
        Left = 28
        Top = 174
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = #1041#1088#1072#1082':'
      end
      object Label25: TLabel
        Left = 205
        Top = 39
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = #1057#1090#1088#1072#1085#1072':'
      end
      object CityLabel: TLabel
        Left = 211
        Top = 66
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = #1043#1086#1088#1086#1076':'
      end
      object LangLabel: TLabel
        Left = 216
        Top = 93
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = #1071#1079#1099#1082':'
      end
      object ProfLabel: TLabel
        Left = 187
        Top = 120
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103':'
      end
      object InterestLabel: TLabel
        Left = 192
        Top = 147
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = #1048#1085#1090#1077#1088#1077#1089#1099':'
      end
      object KeyWordLabel: TLabel
        Left = 178
        Top = 175
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = #1050#1083#1102#1095'. '#1089#1083#1086#1074#1072':'
      end
      object Bevel3: TBevel
        Left = 169
        Top = 34
        Width = 3
        Height = 162
        Shape = bsLeftLine
      end
      object NickEdit: TEdit
        Left = 62
        Top = 36
        Width = 101
        Height = 21
        TabOrder = 0
        OnChange = NickEditChange
      end
      object NameEdit: TEdit
        Left = 62
        Top = 63
        Width = 101
        Height = 21
        TabOrder = 1
        OnChange = NickEditChange
      end
      object FamilyEdit: TEdit
        Left = 62
        Top = 90
        Width = 101
        Height = 21
        TabOrder = 2
        OnChange = NickEditChange
      end
      object GenderComboBox: TComboBox
        Left = 62
        Top = 117
        Width = 101
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = NickEditChange
        Items.Strings = (
          ''
          #1046#1077#1085#1089#1082#1080#1081
          #1052#1091#1078#1089#1082#1086#1081)
      end
      object AgeComboBox: TComboBox
        Left = 62
        Top = 144
        Width = 101
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = NickEditChange
        Items.Strings = (
          ''
          '13-17'
          '18-22'
          '23-29'
          '30-39'
          '40-49'
          '50-59'
          '60 ...')
      end
      object MaritalComboBox: TComboBox
        Left = 62
        Top = 171
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 5
        OnChange = NickEditChange
      end
      object CountryComboBox: TComboBox
        Left = 252
        Top = 36
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 6
        OnChange = NickEditChange
      end
      object CityEdit: TEdit
        Left = 252
        Top = 63
        Width = 101
        Height = 21
        TabOrder = 7
        OnChange = NickEditChange
      end
      object LangComboBox: TComboBox
        Left = 252
        Top = 90
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 8
        OnChange = NickEditChange
      end
      object ProfComboBox: TComboBox
        Left = 252
        Top = 117
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 9
        OnChange = NickEditChange
      end
      object InterestComboBox: TComboBox
        Left = 252
        Top = 144
        Width = 101
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        ItemHeight = 13
        TabOrder = 10
        OnChange = NickEditChange
      end
      object KeyWordEdit: TEdit
        Left = 252
        Top = 172
        Width = 101
        Height = 21
        TabOrder = 11
        OnChange = NickEditChange
      end
      object GlobalSearchCheckBox: TCheckBox
        Left = 11
        Top = 9
        Width = 302
        Height = 17
        Caption = #1043#1083#1086#1073#1072#1083#1100#1085#1099#1081' '#1087#1086#1080#1089#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = GlobalSearchCheckBoxClick
      end
    end
    object UINSearchGroupBox: TGroupBox
      Left = 5
      Top = 5
      Width = 214
      Height = 64
      TabOrder = 1
      object UINSearchCheckBox: TCheckBox
        Left = 9
        Top = 7
        Width = 196
        Height = 17
        Caption = #1048#1089#1082#1072#1090#1100' '#1087#1086' ICQ#'
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
        Top = 30
        Width = 196
        Height = 21
        TabOrder = 1
        OnChange = UINSearchEditChange
      end
    end
    object GroupBox1: TGroupBox
      Left = 5
      Top = 75
      Width = 214
      Height = 64
      TabOrder = 2
      object EmailSearchCheckBox: TCheckBox
        Left = 9
        Top = 8
        Width = 196
        Height = 17
        Caption = #1048#1089#1082#1072#1090#1100' '#1087#1086' E-mail'
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
        Top = 31
        Width = 196
        Height = 21
        TabOrder = 1
        OnChange = EmailSearchEditChange
      end
    end
    object GroupBox2: TGroupBox
      Left = 5
      Top = 145
      Width = 214
      Height = 65
      TabOrder = 3
      object KeyWordSearchCheckBox: TCheckBox
        Left = 9
        Top = 9
        Width = 196
        Height = 17
        Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1083#1102#1095'. '#1089#1083#1086#1074#1091
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
        Top = 32
        Width = 196
        Height = 21
        TabOrder = 1
        OnChange = KeyWordSearchEditChange
      end
    end
  end
  object SearchResultPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 216
    Top = 344
    object ICQStatusCheckSM: TMenuItem
      Tag = 1
      Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1090#1072#1090#1091#1089#1072
      ImageIndex = 172
      OnClick = ICQStatusCheckSMClick
    end
    object AccountNameCopySM: TMenuItem
      Tag = 2
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1084#1103' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
      ImageIndex = 144
      OnClick = AccountNameCopySMClick
    end
    object SendMessageSM: TMenuItem
      Tag = 3
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      ImageIndex = 163
      OnClick = SendMessageSMClick
    end
    object ContactInfoSM: TMenuItem
      Tag = 4
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1086#1085#1090#1072#1082#1090#1077
      ImageIndex = 178
      OnClick = ContactInfoSMClick
    end
    object AddContactInCLSM: TMenuItem
      Tag = 5
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090' '#1074' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 143
      OnClick = AddContactInCLSMClick
    end
  end
end
