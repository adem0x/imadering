object UpdateForm: TUpdateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1074#1077#1088#1089#1080#1080' IMadering'
  ClientHeight = 266
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LoadSizeLabel: TLabel
    Left = 9
    Top = 191
    Width = 72
    Height = 13
    Caption = #1057#1082#1072#1095#1072#1085#1086': 0 '#1050#1073
  end
  object StartBitBtn: TBitBtn
    Left = 240
    Top = 233
    Width = 110
    Height = 25
    Caption = #1042#1086#1079#1086#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 0
    TabStop = False
    OnClick = StartBitBtnClick
  end
  object AbortBitBtn: TBitBtn
    Left = 124
    Top = 233
    Width = 110
    Height = 25
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    TabOrder = 1
    TabStop = False
    OnClick = AbortBitBtnClick
  end
  object CloseBitBtn: TBitBtn
    Left = 8
    Top = 233
    Width = 110
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    TabStop = False
    OnClick = CloseBitBtnClick
  end
  object DownloadProgressBar: TProgressBar
    Left = 8
    Top = 210
    Width = 342
    Height = 17
    Smooth = True
    TabOrder = 3
  end
  object InfoMemo: TMemo
    Left = 8
    Top = 8
    Width = 342
    Height = 177
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
end
