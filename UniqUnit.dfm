object UniqForm: TUniqForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 360
  ClientWidth = 442
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
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object SoundsGroupBox: TGroupBox
    Left = 8
    Top = 30
    Width = 426
    Height = 122
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object OnlineSoundPathSpeedButton: TSpeedButton
      Left = 367
      Top = 40
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object OnlineSoundPlaySpeedButton: TSpeedButton
      Left = 396
      Top = 40
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object MessSoundPathSpeedButton: TSpeedButton
      Left = 367
      Top = 90
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object MessSoundPlaySpeedButton: TSpeedButton
      Left = 396
      Top = 90
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
    end
    object OnlineSoundCheckBox: TCheckBox
      Left = 16
      Top = 18
      Width = 393
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object OnlineSoundPathEdit: TEdit
      Left = 16
      Top = 41
      Width = 345
      Height = 21
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object MessSoundCheckBox: TCheckBox
      Left = 16
      Top = 68
      Width = 393
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object MessSoundPathEdit: TEdit
      Left = 16
      Top = 91
      Width = 345
      Height = 21
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object CancelBitBtn: TBitBtn
    Left = 8
    Top = 327
    Width = 97
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = CancelBitBtnClick
  end
  object OKBitBtn: TBitBtn
    Left = 344
    Top = 327
    Width = 90
    Height = 25
    Caption = 'OK'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = OKBitBtnClick
  end
  object OptionGroupBox: TGroupBox
    Left = 8
    Top = 158
    Width = 426
    Height = 163
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object SaveHistoryCheckBox: TCheckBox
      Left = 16
      Top = 18
      Width = 393
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object SendTranslitCheckBox: TCheckBox
      Left = 16
      Top = 41
      Width = 393
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object AccountPanel: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 436
    Height = 21
    Align = alTop
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
end
