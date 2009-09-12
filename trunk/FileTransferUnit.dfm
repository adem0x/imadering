object FileTransferForm: TFileTransferForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1076#1072#1095#1072' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 161
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 30
    Width = 78
    Height = 13
    Caption = #1058#1077#1082#1091#1097#1080#1081' '#1092#1072#1081#1083':'
  end
  object Label2: TLabel
    Left = 240
    Top = 30
    Width = 74
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072':'
  end
  object Label3: TLabel
    Left = 9
    Top = 76
    Width = 75
    Height = 13
    Caption = #1061#1086#1076' '#1087#1077#1088#1077#1076#1072#1095#1080':'
  end
  object Label4: TLabel
    Left = 9
    Top = 118
    Width = 40
    Height = 13
    Caption = #1057#1090#1072#1090#1091#1089':'
  end
  object TopInfoPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 492
    Height = 21
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 8
    Top = 49
    Width = 225
    Height = 21
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 239
    Top = 49
    Width = 153
    Height = 21
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object CancelBitBtn: TBitBtn
    Left = 398
    Top = 31
    Width = 92
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    TabStop = False
    OnClick = CancelBitBtnClick
  end
  object CloseBitBtn: TBitBtn
    Left = 398
    Top = 62
    Width = 92
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    TabStop = False
    OnClick = CloseBitBtnClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 95
    Width = 482
    Height = 17
    TabOrder = 5
  end
  object BottomInfoPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 137
    Width = 492
    Height = 21
    Align = alBottom
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
end
