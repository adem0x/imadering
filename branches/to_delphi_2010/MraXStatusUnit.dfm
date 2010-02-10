object MraXStatusForm: TMraXStatusForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = ' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1089#1090#1072#1090#1091#1089
  ClientHeight = 302
  ClientWidth = 223
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  HelpFile = 'T'
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object XButtonGroup: TButtonGroup
    Left = 8
    Top = 8
    Width = 207
    Height = 187
    BevelKind = bkFlat
    BorderStyle = bsNone
    ButtonHeight = 26
    ButtonWidth = 29
    ButtonOptions = [gboGroupStyle]
    Images = MainForm.AllImageList
    Items = <
      item
        ImageIndex = 44
      end
      item
        ImageIndex = 85
      end
      item
        ImageIndex = 86
      end
      item
        ImageIndex = 87
      end
      item
        ImageIndex = 88
      end
      item
        ImageIndex = 89
      end
      item
        ImageIndex = 90
      end
      item
        ImageIndex = 91
      end
      item
        ImageIndex = 92
      end
      item
        ImageIndex = 93
      end
      item
        ImageIndex = 94
      end
      item
        ImageIndex = 95
      end
      item
        ImageIndex = 96
      end
      item
        ImageIndex = 97
      end
      item
        ImageIndex = 98
      end
      item
        ImageIndex = 99
      end
      item
        ImageIndex = 100
      end
      item
        ImageIndex = 101
      end
      item
        ImageIndex = 102
      end
      item
        ImageIndex = 103
      end
      item
        ImageIndex = 104
      end
      item
        ImageIndex = 105
      end
      item
        ImageIndex = 106
      end
      item
        ImageIndex = 107
      end
      item
        ImageIndex = 108
      end
      item
        ImageIndex = 109
      end
      item
        ImageIndex = 110
      end
      item
        ImageIndex = 111
      end
      item
        ImageIndex = 112
      end
      item
        ImageIndex = 113
      end
      item
        ImageIndex = 114
      end
      item
        ImageIndex = 115
      end
      item
        ImageIndex = 116
      end
      item
        ImageIndex = 117
      end
      item
        ImageIndex = 118
      end
      item
        ImageIndex = 119
      end
      item
        ImageIndex = 120
      end
      item
        ImageIndex = 121
      end
      item
        ImageIndex = 122
      end
      item
        ImageIndex = 123
      end
      item
        ImageIndex = 124
      end
      item
        ImageIndex = 125
      end
      item
        ImageIndex = 126
      end
      item
        ImageIndex = 127
      end
      item
        ImageIndex = 128
      end
      item
        ImageIndex = 129
      end
      item
        ImageIndex = 130
      end
      item
        ImageIndex = 131
      end
      item
        ImageIndex = 132
      end>
    ItemIndex = 0
    TabOrder = 0
    OnButtonClicked = XButtonGroupButtonClicked
  end
  object XTextMemo: TMemo
    Left = 8
    Top = 201
    Width = 207
    Height = 62
    MaxLength = 160
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 8
    Top = 269
    Width = 97
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 111
    Top = 269
    Width = 104
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = CancelButtonClick
  end
end
