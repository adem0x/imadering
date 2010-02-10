object IcqGroupManagerForm: TIcqGroupManagerForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 101
  ClientWidth = 255
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
  object GNameLabel: TLabel
    Left = 9
    Top = 8
    Width = 3
    Height = 13
  end
  object GNameEdit: TEdit
    Left = 8
    Top = 27
    Width = 239
    Height = 21
    MaxLength = 40
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 160
    Top = 68
    Width = 87
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 8
    Top = 68
    Width = 89
    Height = 25
    ModalResult = 2
    TabOrder = 2
  end
end
