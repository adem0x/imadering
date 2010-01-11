object LogForm: TLogForm
  Left = 0
  Top = 0
  ClientHeight = 397
  ClientWidth = 586
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
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
    Height = 371
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 371
    Width = 586
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      586
      26)
    object ClearLogSpeedButton: TSpeedButton
      Left = 557
      Top = 2
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = ClearLogSpeedButtonClick
    end
    object Bevel: TBevel
      Left = 549
      Top = 3
      Width = 2
      Height = 20
      Anchors = [akTop, akRight]
      Shape = bsRightLine
    end
    object ICQDumpSpeedButton: TSpeedButton
      Left = 5
      Top = 2
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object JabberDumpSpeedButton: TSpeedButton
      Left = 34
      Top = 2
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 2
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object MRADumpSpeedButton: TSpeedButton
      Left = 63
      Top = 2
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 3
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object WriteLogSpeedButton: TSpeedButton
      Left = 520
      Top = 2
      Width = 23
      Height = 22
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 4
      Down = True
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
  end
end
