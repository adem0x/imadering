object RosterForm: TRosterForm
  Left = 0
  Top = 0
  ClientHeight = 409
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object RosterJvListView: TJvListView
    Left = 0
    Top = 0
    Width = 585
    Height = 373
    Align = alClient
    Columns = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end>
    ColumnClick = False
    GridLines = True
    Groups = <>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    PopupMenu = RosterPopupMenu
    SmallImages = MainForm.AllImageList
    TabOrder = 0
    ViewStyle = vsReport
    OnGetImageIndex = RosterJvListViewGetImageIndex
    AutoSelect = False
    ColumnsOrder = 
      '0=100,1=100,2=100,3=50,4=50,5=50,6=50,7=50,8=50,9=50,10=50,11=50' +
      ',12=50,13=50,14=50,15=50,16=50,17=50,18=50,19=50,20=50,21=50,22=' +
      '50,23=50,24=50,25=50,26=50,27=50,28=50,29=50,30=50,31=50,32=50,3' +
      '3=50,34=50,35=50,36=50,37=50'
    ExtendedColumns = <
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end>
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 373
    Width = 585
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object UINLabel: TLabel
      Left = 98
      Top = 11
      Width = 3
      Height = 13
      Alignment = taRightJustify
    end
    object UINEdit: TEdit
      Left = 107
      Top = 8
      Width = 241
      Height = 21
      TabOrder = 0
    end
    object SearchBitBtn: TBitBtn
      Left = 354
      Top = 6
      Width = 98
      Height = 25
      Default = True
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = SearchBitBtnClick
    end
  end
  object RosterPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    OnPopup = RosterPopupMenuPopup
    Left = 136
    Top = 128
    object RosterSendMessMenu: TMenuItem
      ImageIndex = 163
      OnClick = RosterSendMessMenuClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ClearNoCLContacts: TMenuItem
      ImageIndex = 139
      OnClick = ClearNoCLContactsClick
    end
    object ClearTempIcqContacts: TMenuItem
      ImageIndex = 139
      OnClick = ClearTempIcqContactsClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ClearICQ: TMenuItem
      ImageIndex = 139
      OnClick = ClearICQClick
    end
    object ClearJabber: TMenuItem
      ImageIndex = 139
      OnClick = ClearJabberClick
    end
    object ClearMRA: TMenuItem
      ImageIndex = 139
      OnClick = ClearMRAClick
    end
  end
end
