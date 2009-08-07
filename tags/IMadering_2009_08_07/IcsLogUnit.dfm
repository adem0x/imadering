object IcsLogForm: TIcsLogForm
  Left = 0
  Top = 0
  Caption = #1051#1086#1075' '#1089#1086#1082#1077#1090#1086#1074
  ClientHeight = 404
  ClientWidth = 527
  Color = clBtnFace
  Constraints.MinHeight = 404
  Constraints.MinWidth = 527
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
  object IcsLogMemo: TMemo
    Left = 0
    Top = 36
    Width = 527
    Height = 368
    Align = alClient
    HideSelection = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = IcsLogMemoDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object SocketLabel: TLabel
      Left = 18
      Top = 11
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = #1057#1086#1082#1077#1090':'
    end
    object SocketComboBox: TComboBox
      Left = 59
      Top = 8
      Width = 158
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = SocketComboBoxChange
      Items.Strings = (
        ''
        'ICQWSocket'
        'ICQAvatarWSocket'
        'MRAWSocket'
        'JabberWSocket'
        'HttpClient'
        'MRAAvatarHttpClient')
    end
    object LogEnableCheckBox: TCheckBox
      Left = 232
      Top = 10
      Width = 273
      Height = 17
      Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1083#1086#1075#1072' '#1088#1072#1073#1086#1090#1099' '#1089#1086#1082#1077#1090#1072
      TabOrder = 1
      OnClick = LogEnableCheckBoxClick
    end
  end
end
