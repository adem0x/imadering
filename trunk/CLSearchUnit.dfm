object CLSearchForm: TCLSearchForm
  Left = 0
  Top = 0
  ClientHeight = 258
  ClientWidth = 413
  Color = clBtnFace
  Constraints.MinHeight = 230
  Constraints.MinWidth = 420
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
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 413
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object CLSearchLabel: TLabel
      Left = 11
      Top = 9
      Width = 3
      Height = 13
    end
    object CLSearchEdit: TEdit
      Left = 10
      Top = 28
      Width = 392
      Height = 21
      TabOrder = 0
      OnChange = CLSearchEditChange
    end
  end
  object CLSearchJvListView: TJvListView
    Left = 0
    Top = 57
    Width = 413
    Height = 201
    Align = alClient
    Columns = <
      item
        Width = 180
      end
      item
        Width = 225
      end>
    Groups = <>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SmallImages = MainForm.AllImageList
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = CLSearchJvListViewColumnClick
    OnDblClick = CLSearchJvListViewDblClick
    OnSelectItem = CLSearchJvListViewSelectItem
    AutoSelect = False
    ColumnsOrder = '0=180,1=225'
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
      end>
    ExplicitLeft = 8
    ExplicitTop = 63
    ExplicitWidth = 397
    ExplicitHeight = 107
  end
end
