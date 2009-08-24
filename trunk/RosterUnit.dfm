object RosterForm: TRosterForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1086#1082' '#1082#1086#1085#1090#1072#1082#1090#1086#1074
  ClientHeight = 409
  ClientWidth = 585
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object JvListView1: TJvListView
    Left = 0
    Top = 0
    Width = 585
    Height = 409
    Align = alClient
    Columns = <
      item
        Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100
        Width = 100
      end
      item
        Caption = #1053#1080#1082
        Width = 100
      end
      item
        Caption = #1043#1088#1091#1087#1087#1072
        Width = 100
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    ColumnsOrder = '0=100,1=100,2=100'
    Groups = <>
    ExtendedColumns = <
      item
      end
      item
      end
      item
      end>
    ExplicitLeft = 208
    ExplicitTop = 144
    ExplicitWidth = 250
    ExplicitHeight = 150
  end
end
