object SMSForm: TSMSForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 292
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PhoneLabel: TLabel
    Left = 9
    Top = 82
    Width = 3
    Height = 13
  end
  object SMSTextLabel: TLabel
    Left = 9
    Top = 138
    Width = 3
    Height = 13
  end
  object CountLabel: TLabel
    Left = 317
    Top = 138
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object SMSInfoRichEdit: TRichEdit
    Left = 8
    Top = 8
    Width = 313
    Height = 65
    TabStop = False
    BevelKind = bkFlat
    BorderStyle = bsNone
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PhoneEdit: TEdit
    Left = 8
    Top = 101
    Width = 313
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object SMSTextMemo: TMemo
    Left = 8
    Top = 157
    Width = 313
    Height = 92
    ScrollBars = ssVertical
    TabOrder = 2
    OnChange = SMSTextMemoChange
    OnKeyPress = SMSTextMemoKeyPress
  end
  object SendBitBtn: TBitBtn
    Left = 216
    Top = 259
    Width = 105
    Height = 25
    Default = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = SendBitBtnClick
  end
  object CancelBitBtn: TBitBtn
    Left = 8
    Top = 259
    Width = 105
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = CancelBitBtnClick
  end
end
