object Test_Form: TTest_Form
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Test'
  ClientHeight = 261
  ClientWidth = 398
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ScreenSnap = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Test1_Button: TButton
    Left = 80
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Test1'
    TabOrder = 0
  end
  object Test2_Button: TButton
    Left = 232
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Test2'
    TabOrder = 1
  end
end
