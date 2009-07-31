object CLSearchForm: TCLSearchForm
  Left = 0
  Top = 0
  Caption = 'CLSearchForm'
  ClientHeight = 218
  ClientWidth = 413
  Color = clBtnFace
  Constraints.MinHeight = 230
  Constraints.MinWidth = 421
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
  object ListView1: TListView
    Left = 0
    Top = 57
    Width = 413
    Height = 161
    Align = alClient
    Columns = <
      item
        Width = 180
      end
      item
        Width = 220
      end>
    ColumnClick = False
    GridLines = True
    HideSelection = False
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 413
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 10
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Edit1: TEdit
      Left = 8
      Top = 28
      Width = 281
      Height = 21
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 295
      Top = 26
      Width = 112
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
end
