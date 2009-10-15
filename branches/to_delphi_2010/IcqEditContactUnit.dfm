object IcqEditContactForm: TIcqEditContactForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'IcqEditContactForm'
  ClientHeight = 265
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 9
    Top = 54
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 9
    Top = 100
    Width = 31
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 9
    Top = 146
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Edit1: TEdit
    Left = 8
    Top = 26
    Width = 229
    Height = 21
    MaxLength = 40
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 8
    Top = 72
    Width = 229
    Height = 21
    MaxLength = 40
    TabOrder = 1
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 8
    Top = 118
    Width = 229
    Height = 21
    MaxLength = 40
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 8
    Top = 164
    Width = 229
    Height = 57
    MaxLength = 40
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 232
    Width = 105
    Height = 25
    Caption = 'Button1'
    Default = True
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 144
    Top = 232
    Width = 93
    Height = 25
    Caption = 'Button2'
    ModalResult = 2
    TabOrder = 5
  end
end
