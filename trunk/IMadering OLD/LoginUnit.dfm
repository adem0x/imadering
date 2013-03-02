object LoginForm: TLoginForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 126
  ClientWidth = 286
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AccountLabel: TLabel
    Left = 68
    Top = 11
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object PasswordLabel: TLabel
    Left = 68
    Top = 38
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object AccountEdit: TEdit
    Left = 77
    Top = 8
    Width = 201
    Height = 21
    TabOrder = 0
  end
  object PasswordEdit: TEdit
    Left = 77
    Top = 35
    Width = 201
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object SavePassCheckBox: TCheckBox
    Left = 77
    Top = 62
    Width = 201
    Height = 17
    TabOrder = 2
  end
  object OKButton: TButton
    Left = 184
    Top = 93
    Width = 94
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object CancelButton: TButton
    Left = 8
    Top = 93
    Width = 94
    Height = 25
    ModalResult = 2
    TabOrder = 4
  end
end
