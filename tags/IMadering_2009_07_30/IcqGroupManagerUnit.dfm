object IcqGroupManagerForm: TIcqGroupManagerForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'IcqGroupManagerForm'
  ClientHeight = 94
  ClientWidth = 211
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 195
    Height = 21
    MaxLength = 40
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 61
    Width = 97
    Height = 25
    Caption = 'Button1'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 61
    Width = 83
    Height = 25
    Caption = 'Button2'
    ModalResult = 2
    TabOrder = 2
  end
end
