object IcqEditContactForm: TIcqEditContactForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 265
  ClientWidth = 245
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
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  PixelsPerInch = 96
  TextHeight = 13
  object NickLabel: TLabel
    Left = 9
    Top = 8
    Width = 3
    Height = 13
  end
  object PhoneLabel: TLabel
    Left = 9
    Top = 54
    Width = 3
    Height = 13
  end
  object EmailLabel: TLabel
    Left = 9
    Top = 100
    Width = 3
    Height = 13
  end
  object NoteLabel: TLabel
    Left = 9
    Top = 146
    Width = 3
    Height = 13
  end
  object NickEdit: TEdit
    Left = 8
    Top = 27
    Width = 229
    Height = 21
    MaxLength = 40
    TabOrder = 0
  end
  object PhoneEdit: TEdit
    Left = 8
    Top = 73
    Width = 229
    Height = 21
    MaxLength = 40
    NumbersOnly = True
    TabOrder = 1
  end
  object EmailEdit: TEdit
    Left = 8
    Top = 119
    Width = 229
    Height = 21
    MaxLength = 40
    TabOrder = 2
  end
  object NoteMemo: TMemo
    Left = 8
    Top = 165
    Width = 229
    Height = 57
    MaxLength = 40
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object OKButton: TButton
    Left = 132
    Top = 232
    Width = 105
    Height = 25
    Default = True
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 8
    Top = 232
    Width = 93
    Height = 25
    ModalResult = 2
    TabOrder = 5
  end
end
