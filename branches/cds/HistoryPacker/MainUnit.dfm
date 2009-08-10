object MainForm: TMainForm
  Left = 306
  Top = 160
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1087#1072#1082#1086#1074#1097#1080#1082' '#1080#1089#1090#1086#1088#1080#1080
  ClientHeight = 228
  ClientWidth = 368
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001001800680300001600000028000000100000002000
    0000010018000000000000000000600000006000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000D98603D98603D98603D98603
    D98603D98603D98603D98603D98603D98603D98603D986030000000000000000
    00E8AB54FFF9D8FFF9D8FCEDC3FCEDC4FCEDC4FCEDC4FCEDC4FCEDC4FCEDC4FC
    EDC4FBEAB8FBEAB9D88503000000000000E8A953FFFFF1FFFFEEFFFFEEFFFFEE
    FFF9D6FFF8D7FEF8D7FEF8D7FEF8D7FBEDC3FBEDC3FAE9B8D885030000000000
    00E8A952FFFFF0FFFFEE004DE5004EE3004DE5FFFFEEFFFFF0FEF8D7FEF8D7FE
    F8D7FBEDC3FBEDC4D88503000000000000E8A952FFFFFFFFFFFFFFFFED0052E1
    FFFFEDFFFFEEFF8C48FF8C48FF8C48FF8C48FEF8D7FBEDC4D885030000000000
    00E8A952FFFFFFFFFFFFFFFFFF0052E3FFFFFFFFFFEEFFFFF0FFFFF1FFFFF1FE
    F8D7FEF8D7FBEDC4D88503000000000000E8A952FFFFFFFFFFFF005AE50055E5
    FFFFFFFFFFFFFF8C48FF8C48FF8C48FF8C48FEF8D7FBEDC4D885030000000000
    00E8A952FFFFFFFFFFFFFFFFFF005BE8FFFFFFFFFFFFFFFFFFFFFFFFFFFFEEFF
    FFEEFFFFF0FCEDC4D88503000000000000EBAC51FFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FDEBB6DA87030000000000
    00163DB8143BB51237B40E2DA71033B31033B30D31B30930B1052AAD0227AC00
    1EA20022AA001BA90013A80000000000001534BD1C62D61C61D61960D6185DD6
    155BD5165CD5175DD6175DD6105AD50A55D4034ED2034BD20001AB0000000000
    001736BD206CDE3778E61C32B82E74E30E5EDC1362DC1560DC1463DD2B71E407
    20B21C66E20048D70000A90000000000002945C15098F41D35B9FFFFFF162DB6
    3E8CF20B5DDC0A5DDC3B8AF30E27B5FFFFFF0016AC217CF20010AD0000000000
    00000000243FC01B36B9FFFFFF162DB71330B7102BB60B29B50828B60B25B5FF
    FFFF001AAD0019AE0000000000000000000000000000000000001731B8000000
    0000000000000000000000000000000924B5000000000000000000000000FFFF
    0000C00300008001000080010000800100008001000080010000800100008001
    00008001000080010000800100008001000080010000C0030000F7EF0000}
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnShow = FormShow
  DesignSize = (
    368
    228)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 163
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1089' '#1092#1072#1081#1083#1072#1084#1080' '#1076#1083#1103' '#1091#1087#1072#1082#1086#1074#1082#1080':'
  end
  object Label2: TLabel
    Left = 8
    Top = 109
    Width = 233
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1074' '#1082#1086#1090#1086#1088#1091#1102' '#1073#1091#1076#1091#1090' '#1088#1072#1089#1087#1072#1082#1086#1074#1072#1085#1099' '#1092#1072#1081#1083#1099':'
  end
  object Label3: TLabel
    Left = 8
    Top = 58
    Width = 114
    Height = 13
    Caption = #1060#1072#1081#1083' '#1076#1083#1103' '#1088#1072#1089#1087#1072#1082#1086#1074#1082#1080':'
  end
  object lblFilename: TLabel
    Left = 8
    Top = 190
    Width = 46
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1086#1075#1088#1077#1089#1089
  end
  object btnCompress: TButton
    Left = 8
    Top = 159
    Width = 129
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1059#1087#1072#1082#1086#1074#1072#1090#1100
    Enabled = False
    TabOrder = 6
    TabStop = False
    OnClick = btnCompressClick
  end
  object btnUnCompress: TButton
    Left = 231
    Top = 159
    Width = 129
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1056#1072#1089#1087#1072#1082#1086#1074#1072#1090#1100
    Enabled = False
    TabOrder = 7
    TabStop = False
    OnClick = btnUnCompressClick
  end
  object edSrcFolder: TEdit
    Left = 8
    Top = 27
    Width = 325
    Height = 21
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'C:\temp'
    OnChange = edSrcFolderChange
  end
  object edDestFolder: TEdit
    Left = 8
    Top = 128
    Width = 325
    Height = 21
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    Text = 'C:\temp\dc'
    OnChange = edDestFolderChange
  end
  object edFilename: TEdit
    Left = 8
    Top = 77
    Width = 325
    Height = 21
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'C:\temp\temp.z'
    OnChange = edSrcFolderChange
  end
  object pbProgress: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 209
    Width = 362
    Height = 16
    Align = alBottom
    TabOrder = 8
  end
  object btnSrc: TButton
    Left = 339
    Top = 27
    Width = 21
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 1
    TabStop = False
    OnClick = btnSrcClick
  end
  object btnDestFile: TButton
    Left = 339
    Top = 77
    Width = 21
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 3
    TabStop = False
    OnClick = btnDestFileClick
  end
  object btnDestFolder: TButton
    Left = 339
    Top = 128
    Width = 21
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 5
    TabStop = False
    OnClick = btnDestFolderClick
  end
end
