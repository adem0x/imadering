object UpdateForm: TUpdateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 266
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object LoadSizeLabel: TLabel
    Left = 9
    Top = 191
    Width = 3
    Height = 13
  end
  object StartBitBtn: TBitBtn
    Left = 240
    Top = 233
    Width = 110
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    TabStop = False
    OnClick = StartBitBtnClick
  end
  object AbortBitBtn: TBitBtn
    Left = 124
    Top = 233
    Width = 110
    Height = 25
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    OnClick = AbortBitBtnClick
  end
  object CloseBitBtn: TBitBtn
    Left = 8
    Top = 233
    Width = 110
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
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
