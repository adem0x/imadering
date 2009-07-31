object SMSsendForm: TSMSsendForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SMSsendForm'
  ClientHeight = 248
  ClientWidth = 274
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
    Top = 57
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 35
    Top = 194
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 238
    Top = 57
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = '0|147'
  end
  object Edit1: TEdit
    Left = 8
    Top = 26
    Width = 258
    Height = 21
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Memo1: TMemo
    Left = 8
    Top = 75
    Width = 258
    Height = 111
    MaxLength = 147
    ScrollBars = ssVertical
    TabOrder = 1
    OnChange = Memo1Change
  end
  object Button1: TButton
    Left = 8
    Top = 215
    Width = 121
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 168
    Top = 215
    Width = 98
    Height = 25
    Caption = 'Button2'
    ModalResult = 2
    TabOrder = 3
  end
  object ProgressBar1: TProgressBar
    Left = 72
    Top = 192
    Width = 194
    Height = 17
    Max = 147
    Smooth = True
    TabOrder = 4
  end
end
