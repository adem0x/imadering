object ProfilesFolderForm: TProfilesFolderForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 175
  ClientWidth = 404
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
  object FolderSelectLabel: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Folder1RadioButton: TRadioButton
    Left = 8
    Top = 29
    Width = 388
    Height = 17
    Checked = True
    TabOrder = 0
  end
  object Folder1Edit: TEdit
    Left = 24
    Top = 52
    Width = 372
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object Folder2RadioButton: TRadioButton
    Left = 8
    Top = 88
    Width = 388
    Height = 17
    TabOrder = 2
  end
  object Folder2Edit: TEdit
    Left = 24
    Top = 111
    Width = 372
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
  end
  object OKButton: TButton
    Left = 312
    Top = 142
    Width = 84
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    TabStop = False
    OnClick = OKButtonClick
  end
end
