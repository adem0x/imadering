object IcqSearchForm: TIcqSearchForm
  Left = 0
  Top = 0
  Caption = 'IcqSearchForm'
  ClientHeight = 455
  ClientWidth = 588
  Color = clBtnFace
  Constraints.MinHeight = 482
  Constraints.MinWidth = 596
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 588
    Height = 182
    ActivePage = TabSheet5
    Align = alTop
    Images = MainForm.AllImageList
    MultiLine = True
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      ImageIndex = 136
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 3
        Top = 3
        Width = 189
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object Edit1: TEdit
          Left = 7
          Top = 27
          Width = 170
          Height = 21
          TabOrder = 0
          OnKeyPress = Edit1KeyPress
        end
        object CheckBox1: TCheckBox
          Left = 7
          Top = 5
          Width = 170
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 1
          OnClick = CheckBox1Click
        end
      end
      object Panel4: TPanel
        Left = 198
        Top = 3
        Width = 190
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
        object Edit2: TEdit
          Left = 7
          Top = 27
          Width = 171
          Height = 21
          TabOrder = 0
          OnKeyPress = Edit2KeyPress
        end
        object CheckBox2: TCheckBox
          Left = 7
          Top = 5
          Width = 171
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 1
          OnClick = CheckBox2Click
        end
      end
      object Panel5: TPanel
        Left = 394
        Top = 3
        Width = 183
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 2
        object Edit3: TEdit
          Left = 7
          Top = 27
          Width = 164
          Height = 21
          TabOrder = 0
          OnKeyPress = Edit3KeyPress
        end
        object CheckBox3: TCheckBox
          Left = 7
          Top = 5
          Width = 164
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 1
          OnClick = CheckBox3Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 135
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel8: TPanel
        Left = 3
        Top = 3
        Width = 291
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object Edit5: TEdit
          Left = 7
          Top = 27
          Width = 273
          Height = 21
          TabOrder = 0
          OnKeyPress = Edit5KeyPress
        end
        object CheckBox6: TCheckBox
          Left = 7
          Top = 5
          Width = 273
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 1
          OnClick = CheckBox6Click
        end
      end
      object Panel9: TPanel
        Left = 300
        Top = 3
        Width = 277
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
        object Edit6: TEdit
          Left = 7
          Top = 27
          Width = 259
          Height = 21
          TabOrder = 0
          OnKeyPress = Edit6KeyPress
        end
        object CheckBox7: TCheckBox
          Left = 7
          Top = 5
          Width = 259
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 1
          OnClick = CheckBox7Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 137
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel10: TPanel
        Left = 3
        Top = 3
        Width = 574
        Height = 56
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 6
          Width = 31
          Height = 13
          Caption = 'Label1'
        end
        object Label2: TLabel
          Left = 199
          Top = 6
          Width = 31
          Height = 13
          Caption = 'Label2'
        end
        object Label3: TLabel
          Left = 388
          Top = 6
          Width = 31
          Height = 13
          Caption = 'Label3'
        end
        object Edit7: TEdit
          Left = 7
          Top = 24
          Width = 185
          Height = 21
          TabOrder = 0
        end
        object Edit8: TEdit
          Left = 198
          Top = 24
          Width = 183
          Height = 21
          TabOrder = 1
        end
        object Edit9: TEdit
          Left = 387
          Top = 24
          Width = 176
          Height = 21
          TabOrder = 2
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      ImageIndex = 138
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel11: TPanel
        Left = 3
        Top = 3
        Width = 574
        Height = 144
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object Bevel1: TBevel
          Left = 180
          Top = 3
          Width = 3
          Height = 133
          Shape = bsLeftLine
        end
        object Bevel2: TBevel
          Left = 382
          Top = 3
          Width = 3
          Height = 133
          Shape = bsLeftLine
        end
        object Label4: TLabel
          Left = 36
          Top = 9
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label5: TLabel
          Left = 36
          Top = 36
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label6: TLabel
          Left = 36
          Top = 62
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label7: TLabel
          Left = 36
          Top = 89
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label8: TLabel
          Left = 36
          Top = 116
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label9: TLabel
          Left = 238
          Top = 9
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label10: TLabel
          Left = 238
          Top = 36
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label11: TLabel
          Left = 238
          Top = 63
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label12: TLabel
          Left = 238
          Top = 90
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label13: TLabel
          Left = 238
          Top = 116
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label14: TLabel
          Left = 426
          Top = 9
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label15: TLabel
          Left = 426
          Top = 36
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label16: TLabel
          Left = 426
          Top = 63
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label17: TLabel
          Left = 426
          Top = 89
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label18: TLabel
          Left = 426
          Top = 116
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object ComboBox1: TComboBox
          Left = 73
          Top = 5
          Width = 101
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 0
        end
        object Edit10: TEdit
          Left = 73
          Top = 86
          Width = 101
          Height = 21
          TabOrder = 1
        end
        object ComboBox2: TComboBox
          Left = 73
          Top = 32
          Width = 101
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 2
          Items.Strings = (
            ''
            '13-17'
            '18-22'
            '23-29'
            '30-39'
            '40-49'
            '50-59'
            '60 ...')
        end
        object ComboBox3: TComboBox
          Left = 73
          Top = 59
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 0
          TabOrder = 3
        end
        object ComboBox4: TComboBox
          Left = 73
          Top = 113
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 15
          ItemHeight = 0
          TabOrder = 4
        end
        object ComboBox5: TComboBox
          Left = 275
          Top = 5
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 0
          TabOrder = 5
        end
        object ComboBox6: TComboBox
          Left = 275
          Top = 32
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 0
          TabOrder = 6
        end
        object ComboBox7: TComboBox
          Left = 275
          Top = 59
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 15
          ItemHeight = 0
          TabOrder = 7
        end
        object ComboBox8: TComboBox
          Left = 275
          Top = 86
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 0
          TabOrder = 8
        end
        object Edit11: TEdit
          Left = 275
          Top = 113
          Width = 101
          Height = 21
          TabOrder = 9
        end
        object Edit12: TEdit
          Left = 463
          Top = 5
          Width = 101
          Height = 21
          TabOrder = 10
        end
        object Edit13: TEdit
          Left = 463
          Top = 32
          Width = 101
          Height = 21
          TabOrder = 11
        end
        object Edit14: TEdit
          Left = 463
          Top = 59
          Width = 101
          Height = 21
          TabOrder = 12
        end
        object Edit15: TEdit
          Left = 463
          Top = 86
          Width = 101
          Height = 21
          TabOrder = 13
        end
        object ComboBox9: TComboBox
          Left = 463
          Top = 113
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 0
          TabOrder = 14
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'TabSheet5'
      ImageIndex = 139
      object Panel12: TPanel
        Left = 3
        Top = 3
        Width = 574
        Height = 117
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object Bevel3: TBevel
          Left = 188
          Top = 3
          Width = 3
          Height = 106
          Shape = bsLeftLine
        end
        object Bevel4: TBevel
          Left = 371
          Top = 3
          Width = 3
          Height = 106
          Shape = bsLeftLine
        end
        object Label19: TLabel
          Left = 44
          Top = 9
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label20: TLabel
          Left = 44
          Top = 35
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label21: TLabel
          Left = 44
          Top = 62
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label22: TLabel
          Left = 44
          Top = 89
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label23: TLabel
          Left = 227
          Top = 9
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label24: TLabel
          Left = 227
          Top = 35
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label25: TLabel
          Left = 227
          Top = 62
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label26: TLabel
          Left = 227
          Top = 89
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label27: TLabel
          Left = 426
          Top = 9
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label28: TLabel
          Left = 426
          Top = 35
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label29: TLabel
          Left = 426
          Top = 62
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Label30: TLabel
          Left = 426
          Top = 89
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label4'
        end
        object Edit16: TEdit
          Left = 81
          Top = 5
          Width = 101
          Height = 21
          TabOrder = 0
        end
        object Edit17: TEdit
          Left = 81
          Top = 32
          Width = 101
          Height = 21
          TabOrder = 1
        end
        object Edit18: TEdit
          Left = 81
          Top = 59
          Width = 101
          Height = 21
          TabOrder = 2
        end
        object ComboBox10: TComboBox
          Left = 81
          Top = 86
          Width = 101
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
        end
        object ComboBox11: TComboBox
          Left = 264
          Top = 5
          Width = 101
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          Items.Strings = (
            ''
            '13-17'
            '18-22'
            '23-29'
            '30-39'
            '40-49'
            '50-59'
            '60 ...')
        end
        object ComboBox12: TComboBox
          Left = 264
          Top = 32
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 15
          ItemHeight = 13
          TabOrder = 5
        end
        object ComboBox13: TComboBox
          Left = 264
          Top = 59
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 6
        end
        object Edit19: TEdit
          Left = 264
          Top = 86
          Width = 101
          Height = 21
          TabOrder = 7
        end
        object ComboBox14: TComboBox
          Left = 463
          Top = 5
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 8
        end
        object ComboBox15: TComboBox
          Left = 463
          Top = 32
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 9
        end
        object ComboBox16: TComboBox
          Left = 463
          Top = 59
          Width = 101
          Height = 21
          Style = csDropDownList
          DropDownCount = 20
          ItemHeight = 13
          TabOrder = 10
        end
        object Edit20: TEdit
          Left = 463
          Top = 86
          Width = 101
          Height = 21
          TabOrder = 11
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'TabSheet6'
      ImageIndex = 140
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel13: TPanel
        Left = 3
        Top = 3
        Width = 284
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object Edit21: TEdit
          Left = 7
          Top = 27
          Width = 266
          Height = 21
          TabOrder = 0
          OnKeyPress = Edit21KeyPress
        end
        object CheckBox8: TCheckBox
          Left = 7
          Top = 5
          Width = 266
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 1
          OnClick = CheckBox8Click
        end
      end
      object Panel14: TPanel
        Left = 293
        Top = 3
        Width = 284
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
        object CheckBox9: TCheckBox
          Left = 7
          Top = 5
          Width = 266
          Height = 17
          Caption = 'CheckBox1'
          TabOrder = 0
          OnClick = CheckBox9Click
        end
        object ComboBox17: TComboBox
          Left = 7
          Top = 27
          Width = 266
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 1
          OnChange = ComboBox17Change
        end
      end
      object Panel15: TPanel
        Left = 3
        Top = 68
        Width = 284
        Height = 59
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 2
        object Label31: TLabel
          Left = 7
          Top = 4
          Width = 37
          Height = 13
          Caption = 'Label31'
        end
        object Label32: TLabel
          Left = 31
          Top = 29
          Width = 37
          Height = 13
          Alignment = taRightJustify
          Caption = 'Label32'
        end
        object Edit23: TEdit
          Left = 74
          Top = 25
          Width = 29
          Height = 21
          MaxLength = 3
          TabOrder = 0
          Text = '60'
          OnChange = Edit23Change
          OnKeyPress = Edit23KeyPress
        end
        object BitBtn2: TBitBtn
          Left = 109
          Top = 23
          Width = 80
          Height = 25
          Caption = 'BitBtn2'
          TabOrder = 1
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 195
          Top = 23
          Width = 78
          Height = 25
          Caption = 'BitBtn2'
          TabOrder = 2
          OnClick = BitBtn3Click
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 182
    Width = 588
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object CheckBox4: TCheckBox
      Left = 14
      Top = 10
      Width = 206
      Height = 17
      Caption = 'CheckBox4'
      TabOrder = 0
    end
    object CheckBox5: TCheckBox
      Left = 226
      Top = 10
      Width = 135
      Height = 17
      Caption = 'CheckBox5'
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 388
      Top = 6
      Width = 94
      Height = 25
      Caption = 'BitBtn1'
      Default = True
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn4: TBitBtn
      Left = 488
      Top = 6
      Width = 93
      Height = 25
      Caption = 'BitBtn4'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 423
    Width = 588
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 246
      Top = 6
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 558
      Top = 6
      Width = 23
      Height = 22
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton2Click
    end
    object Panel6: TPanel
      Left = 5
      Top = 6
      Width = 147
      Height = 22
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
    end
    object Panel7: TPanel
      Left = 158
      Top = 6
      Width = 82
      Height = 22
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = '0'
      TabOrder = 1
    end
    object Edit4: TEdit
      Tag = 1
      Left = 284
      Top = 6
      Width = 268
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnEnter = Edit4Enter
      OnExit = Edit4Exit
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 219
    Width = 588
    Height = 204
    Align = alClient
    Columns = <
      item
        Caption = '1'
        Width = 90
      end
      item
        Caption = '2'
        Width = 100
      end
      item
        Caption = '3'
        Width = 90
      end
      item
        Caption = '4'
        Width = 90
      end
      item
        Caption = '5'
        Width = 80
      end
      item
        Caption = '6'
        Width = 70
      end
      item
        Width = 18
      end
      item
        Caption = '8'
        Width = 100
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    SmallImages = MainForm.AllImageList
    TabOrder = 3
    ViewStyle = vsReport
    OnChanging = ListView1Changing
    OnColumnClick = ListView1ColumnClick
    OnContextPopup = ListView1ContextPopup
    OnDblClick = ListView1DblClick
    OnGetSubItemImage = ListView1GetSubItemImage
    OnMouseDown = ListView1MouseDown
  end
  object PopupMenu1: TPopupMenu
    Images = MainForm.AllImageList
    Left = 224
    Top = 288
    object N11: TMenuItem
      Tag = 1
      Caption = '1'
      ImageIndex = 150
      OnClick = N11Click
    end
    object N21: TMenuItem
      Tag = 2
      Caption = '2'
      ImageIndex = 148
      OnClick = N21Click
    end
    object N31: TMenuItem
      Tag = 3
      Caption = '3'
      ImageIndex = 149
      OnClick = N31Click
    end
    object N41: TMenuItem
      Tag = 4
      Caption = '4'
      ImageIndex = 127
      OnClick = N41Click
    end
    object N51: TMenuItem
      Tag = 5
      Caption = '5'
      ImageIndex = 160
      OnClick = N51Click
    end
  end
  object AutoSendTimer: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = AutoSendTimerTimer
    Left = 192
    Top = 288
  end
end
