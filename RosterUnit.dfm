object RosterForm: TRosterForm
  Left = 0
  Top = 0
  ClientHeight = 409
  ClientWidth = 585
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
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
        Caption = 'Account'
        Width = 150
      end
      item
        Caption = 'Proto'
      end
      item
        Caption = 'Nick'
      end
      item
        Caption = 'Group'
      end
      item
        Caption = 'Id'
      end
      item
        Caption = 'Type'
      end
      item
        Caption = 'Auth'
      end
      item
        Caption = 'Status'
      end
      item
        Caption = 'XStatus'
      end
      item
        Caption = 'Client'
      end
      item
        Caption = 'Phone'
      end
      item
        Caption = 'Note'
      end
      item
        Caption = 'Email'
      end
      item
        Caption = 'Time Id'
      end
      item
        Caption = 'Out Mess'
      end
      item
        Caption = 'In Mess'
      end
      item
        Caption = 'Offline Mess'
      end
      item
        Caption = 'Float'
      end
      item
        Caption = 'Online Event'
      end
      item
        Caption = 'Offline Event'
      end
      item
        Caption = 'Proto Ver'
      end
      item
        Caption = 'Reg Date'
      end
      item
        Caption = 'Caps Short'
      end
      item
        Caption = 'Caps Full'
      end
      item
        Caption = 'Avatar Hash'
      end
      item
        Caption = 'Conn Time'
      end
      item
        Caption = 'Status Text'
      end
      item
        Caption = 'Client Name'
      end
      item
        Caption = 'Hint'
      end
      item
        Caption = 'Typing Event'
      end
      item
        Caption = 'Mess Event'
      end>
    ColumnClick = False
    DoubleBuffered = True
    GridLines = True
    Groups = <>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    PopupMenu = RosterPopupMenu
    SmallImages = MainForm.AllImageList
    TabOrder = 0
    ViewStyle = vsReport
    OnGetImageIndex = RosterJvListViewGetImageIndex
    AutoSelect = False
    ColumnsOrder = 
      '0=150,1=50,2=50,3=50,4=50,5=50,6=50,7=50,8=50,9=50,10=50,11=50,1' +
      '2=50,13=50,14=50,15=50,16=50,17=50,18=50,19=50,20=50,21=50,22=50' +
      ',23=50,24=50,25=50,26=50,27=50,28=50,29=50,30=50'
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
  end
end
