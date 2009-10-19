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
  object RosterJvListView: TJvListView
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
      end
      item
        Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
      end
      item
        Caption = #1055#1088#1086#1090#1086#1082#1086#1083
      end
      item
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088
      end
      item
        Caption = #1058#1080#1087
      end
      item
        Caption = #1057#1090#1072#1090#1091#1089
      end
      item
        Caption = #1044#1086#1087'. '#1057#1090#1072#1090#1091#1089
      end
      item
        Caption = #1050#1083#1080#1077#1085#1090
      end
      item
        Caption = #1058#1077#1083#1077#1092#1086#1085
      end
      item
        Caption = #1047#1072#1084#1077#1090#1082#1072
      end
      item
        Caption = 'E-mail'
      end
      item
        Caption = 'TimeId'
      end
      item
        Caption = '-'
      end
      item
        Caption = #1048#1089#1093#1086#1076#1103#1097#1077#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      end
      item
        Caption = #1042#1093#1086#1076#1103#1097#1077#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      end
      item
        Caption = #1054#1092#1092#1083#1072#1081#1085' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      end
      item
        Caption = '-'
      end
      item
        Caption = #1057#1086#1073#1099#1090#1080#1077' '#1086#1085#1083#1072#1081#1085
      end
      item
        Caption = #1057#1086#1073#1099#1090#1080#1077' '#1086#1092#1092#1083#1072#1081#1085
      end
      item
        Caption = #1050#1083#1072#1089#1089' '#1082#1086#1085#1090#1072#1082#1090#1072
      end
      item
        Caption = 'IP '#1074#1085#1091#1090#1088#1077#1085#1085#1080#1081
      end
      item
        Caption = #1055#1086#1088#1090' '#1074#1085#1091#1090#1088#1077#1085#1085#1080#1081
      end
      item
        Caption = 'IP '#1074#1085#1077#1096#1085#1080#1081
      end
      item
        Caption = #1060#1083#1072#1075' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      end
      item
        Caption = #1042#1077#1088#1089#1080#1103' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      end
      item
        Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      end
      item
        Caption = 'CapsId'
      end
      item
        Caption = 'Caps'
      end
      item
        Caption = 'Hash '#1072#1074#1072#1090#1072#1088
      end
      item
        Caption = #1042#1088#1077#1084#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      end
      item
        Caption = #1058#1077#1082#1089#1090' '#1076#1086#1087'. '#1089#1090#1072#1090#1091#1089#1072
      end
      item
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1083#1080#1077#1085#1090#1072
      end
      item
        Caption = 'UTF8 '#1087#1086#1076#1076#1077#1088#1078#1082#1072
      end
      item
        Caption = #1055#1086#1076#1089#1082#1072#1079#1082#1072
      end
      item
        Caption = #1057#1095#1105#1090#1095#1080#1082' '#1085#1072#1073#1086#1088#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      end
      item
        Caption = #1053#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      end>
    ColumnClick = False
    GridLines = True
    Groups = <>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    PopupMenu = RosterPopupMenu
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
  object RosterPopupMenu: TPopupMenu
    Alignment = paCenter
    Left = 136
    Top = 128
    object ClearICQ: TMenuItem
      Caption = #1057#1090#1077#1088#1077#1090#1100' ICQ '#1082#1086#1085#1090#1072#1082#1090#1099
      OnClick = ClearICQClick
    end
    object ClearJabber: TMenuItem
      Caption = #1057#1090#1077#1088#1077#1090#1100' Jabber '#1082#1086#1085#1090#1072#1082#1090#1099
      OnClick = ClearJabberClick
    end
    object ClearMRA: TMenuItem
      Caption = #1057#1090#1077#1088#1077#1090#1100' MRA '#1082#1086#1085#1090#1072#1082#1090#1099
      Enabled = False
      OnClick = ClearMRAClick
    end
  end
end
