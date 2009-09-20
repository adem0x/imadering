object IcqAddContactForm: TIcqAddContactForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1085#1090#1072#1082#1090
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
  object AccountLabel: TLabel
    Left = 21
    Top = 11
    Width = 84
    Height = 13
    Alignment = taRightJustify
    Caption = #1059#1095#1105#1090#1085#1072#1103' '#1079#1072#1087#1080#1089#1100':'
  end
  object NameLabel: TLabel
    Left = 31
    Top = 38
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Caption = #1048#1084#1103' '#1082#1086#1085#1090#1072#1082#1090#1072':'
  end
  object GroupLabel: TLabel
    Left = 65
    Top = 65
    Width = 40
    Height = 13
    Alignment = taRightJustify
    Caption = #1043#1088#1091#1087#1087#1072':'
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
    ItemHeight = 13
    TabOrder = 2
    TabStop = False
  end
  object CancelButton: TButton
    Left = 8
    Top = 96
    Width = 89
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object AddContactButton: TButton
    Left = 176
    Top = 96
    Width = 97
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Default = True
    TabOrder = 4
    OnClick = AddContactButtonClick
  end
end
