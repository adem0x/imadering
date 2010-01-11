object IcqGroupManagerForm: TIcqGroupManagerForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '#'#1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1075#1088#1091#1087#1087#1072#1084#1080
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GNameLabel: TLabel
    Left = 9
    Top = 8
    Width = 100
    Height = 13
    Caption = '#'#1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099':'
  end
  object GNameEdit: TEdit
    Left = 8
    Top = 27
    Width = 195
    Height = 21
    MaxLength = 40
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 122
    Top = 61
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 8
    Top = 61
    Width = 83
    Height = 25
    Caption = '#'#1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
