object IcqAddContactForm: TIcqAddContactForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 129
  ClientWidth = 281
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AccountLabel: TLabel
    Left = 102
    Top = 11
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object NameLabel: TLabel
    Left = 102
    Top = 38
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object GroupLabel: TLabel
    Left = 102
    Top = 65
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object AccountEdit: TEdit
    Left = 111
    Top = 8
    Width = 162
    Height = 21
    TabStop = False
    MaxLength = 40
    TabOrder = 0
  end
  object NameEdit: TEdit
    Left = 111
    Top = 35
    Width = 162
    Height = 21
    TabStop = False
    MaxLength = 40
    TabOrder = 1
  end
  object GroupComboBox: TComboBox
    Left = 111
    Top = 62
    Width = 162
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    TabStop = False
  end
  object CancelButton: TButton
    Left = 8
    Top = 96
    Width = 89
    Height = 25
    ModalResult = 2
    TabOrder = 3
  end
  object AddContactButton: TButton
    Left = 176
    Top = 96
    Width = 97
    Height = 25
    Default = True
    TabOrder = 4
    OnClick = AddContactButtonClick
  end
end
