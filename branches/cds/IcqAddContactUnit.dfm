object IcqAddContactForm: TIcqAddContactForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'IcqAddContactForm'
  ClientHeight = 129
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 74
    Top = 11
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 74
    Top = 38
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 74
    Top = 65
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Label1'
  end
  object Edit1: TEdit
    Left = 111
    Top = 8
    Width = 162
    Height = 21
    MaxLength = 40
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 111
    Top = 35
    Width = 162
    Height = 21
    MaxLength = 40
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 111
    Top = 62
    Width = 162
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 2
  end
  object Button1: TButton
    Left = 184
    Top = 96
    Width = 89
    Height = 25
    Caption = 'Button1'
    ModalResult = 2
    TabOrder = 3
  end
  object Button2: TButton
    Left = 8
    Top = 96
    Width = 97
    Height = 25
    Caption = 'Button2'
    Default = True
    TabOrder = 4
    OnClick = Button2Click
  end
end
