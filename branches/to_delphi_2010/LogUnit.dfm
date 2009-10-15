object LogForm: TLogForm
  Left = 0
  Top = 0
  Caption = #1051#1086#1075' '#1089#1086#1073#1099#1090#1080#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 397
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  ScreenSnap = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LogMemo: TMemo
    Left = 0
    Top = 0
    Width = 586
    Height = 397
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = LogMemoChange
    OnDblClick = LogMemoDblClick
  end
end
