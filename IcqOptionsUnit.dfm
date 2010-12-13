object IcqOptionsForm: TIcqOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 413
  ClientWidth = 597
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
  ScreenSnap = True
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ICQOptionButtonGroup: TButtonGroup
    Left = 8
    Top = 8
    Width = 137
    Height = 366
    BevelKind = bkTile
    BorderStyle = bsNone
    ButtonHeight = 25
    ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
    Images = MainForm.AllImageList
    Items = <
      item
        ImageIndex = 81
      end
      item
        ImageIndex = 162
      end
      item
        ImageIndex = 228
      end
      item
        ImageIndex = 172
      end
      item
        ImageIndex = 173
      end
      item
        ImageIndex = 174
      end
      item
        ImageIndex = 85
      end
      item
        ImageIndex = 175
      end
      item
        ImageIndex = 176
      end
      item
        ImageIndex = 177
      end
      item
        ImageIndex = 273
      end
      item
        ImageIndex = 180
      end
      item
        ImageIndex = 171
      end>
    ItemIndex = 0
    TabOrder = 0
    OnButtonClicked = ICQOptionButtonGroupButtonClicked
    OnKeyDown = ICQOptionButtonGroupKeyDown
  end
  object GeneralPanel: TPanel
    Left = 151
    Top = 8
    Width = 438
    Height = 366
    BevelKind = bkTile
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object OptionJvPageList: TJvPageList
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 428
      Height = 356
      ActivePage = ConsolePage
      PropagateEnable = False
      ShowDesignCaption = sdcNone
      Align = alClient
      object AccountPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'AccountPage'
        object AccountGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 232
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ReqPassLabel: TLabel
            Left = 80
            Top = 175
            Width = 3
            Height = 13
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = ReqPassLabelClick
            OnMouseEnter = ReqPassLabelMouseEnter
            OnMouseLeave = ReqPassLabelMouseLeave
          end
          object ICQUINLabel: TLabel
            Left = 80
            Top = 25
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PassLabel: TLabel
            Left = 80
            Top = 75
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object RegNewUINLabel: TLabel
            Left = 80
            Top = 202
            Width = 3
            Height = 13
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = RegNewUINLabelClick
            OnMouseEnter = ReqPassLabelMouseEnter
            OnMouseLeave = ReqPassLabelMouseLeave
          end
          object ICQUINEdit: TEdit
            Left = 78
            Top = 43
            Width = 273
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = ICQUINEditChange
          end
          object PassEdit: TEdit
            Left = 78
            Top = 93
            Width = 273
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 2
            OnChange = PassEditChange
            OnClick = PassEditClick
          end
          object ShowPassCheckBox: TCheckBox
            Left = 78
            Top = 123
            Width = 328
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ShowPassCheckBoxClick
          end
          object SavePassCheckBox: TCheckBox
            Left = 78
            Top = 146
            Width = 328
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = ICQUINEditChange
          end
        end
        object AccountGroupBox2: TGroupBox
          Left = 0
          Top = 238
          Width = 428
          Height = 118
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
      end
      object ConnectPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ConnectPage'
        object ConnectionGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 89
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Bevel2: TBevel
            Left = 10
            Top = 56
            Width = 408
            Height = 3
            Shape = bsBottomLine
          end
          object ServerLabel: TLabel
            Left = 62
            Top = 28
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PortLabel: TLabel
            Left = 341
            Top = 28
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object UseSSLCheckBox: TCheckBox
            Left = 13
            Top = 65
            Width = 402
            Height = 17
            TabStop = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object PortEdit: TEdit
            Left = 350
            Top = 25
            Width = 65
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            NumbersOnly = True
            ParentFont = False
            TabOrder = 1
            OnChange = ICQUINEditChange
          end
          object ServerComboBox: TComboBox
            Left = 71
            Top = 25
            Width = 211
            Height = 21
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
            Text = 'login.icq.com'
            OnChange = ICQUINEditChange
            Items.Strings = (
              'login.icq.com'
              'login.oscar.aol.com'
              'login.messaging.aol.com')
          end
        end
      end
      object PrivatPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'PrivatPage'
        object OtherOptionsGroupBox: TGroupBox
          Left = 0
          Top = 212
          Width = 428
          Height = 144
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ShowAwayTimeCheckBox: TCheckBox
            Left = 16
            Top = 22
            Width = 403
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ICQUINEditChange
          end
          object AutoReqAuthCheckBox: TCheckBox
            Left = 16
            Top = 45
            Width = 403
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
        end
        object AuthAndWebStatusGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 101
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object NoAutoAuthRadioButton: TRadioButton
            Left = 16
            Top = 23
            Width = 403
            Height = 17
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ICQUINEditChange
          end
          object YesAutoAuthRadioButton: TRadioButton
            Left = 16
            Top = 46
            Width = 403
            Height = 17
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ICQUINEditChange
          end
          object ShowWebAwareCheckBox: TCheckBox
            Left = 16
            Top = 72
            Width = 403
            Height = 17
            TabStop = False
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ICQUINEditChange
          end
        end
        object PrivatLevelGroupBox: TGroupBox
          Left = 0
          Top = 107
          Width = 428
          Height = 99
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
      end
      object IDClientPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'IDClientPage'
        object ClientIDGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ClientIDLabel: TLabel
            Left = 14
            Top = 116
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientProtoVerLabel: TLabel
            Left = 287
            Top = 171
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientCapsLabel: TLabel
            Left = 14
            Top = 238
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientVersionLabel: TLabel
            Left = 287
            Top = 116
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientLoginIDLabel: TLabel
            Left = 14
            Top = 171
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ClientIDComboBox: TComboBox
            Left = 13
            Top = 135
            Width = 250
            Height = 21
            AutoDropDown = True
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            TabStop = False
            Text = 'IMadering'
            Items.Strings = (
              'IMadering')
          end
          object ClientProtoVerEdit: TEdit
            Left = 286
            Top = 190
            Width = 130
            Height = 21
            TabStop = False
            Color = clBtnFace
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '9'
          end
          object ClientCaps1Edit: TEdit
            Left = 13
            Top = 256
            Width = 403
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object ClientCaps2Edit: TEdit
            Left = 13
            Top = 289
            Width = 403
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object ClientCaps3Edit: TEdit
            Left = 13
            Top = 322
            Width = 403
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object ClientVersionEdit: TEdit
            Left = 286
            Top = 135
            Width = 130
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object ClientIdInfoRichEdit: TRichEdit
            Left = 13
            Top = 20
            Width = 403
            Height = 77
            TabStop = False
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 6
          end
          object ClientLoginIdEdit: TEdit
            Left = 13
            Top = 190
            Width = 250
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnChange = ICQUINEditChange
          end
        end
      end
      object PassChangePage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'PassChangePage'
        object PassChangeGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object RetypeNewPassLabel: TLabel
            Left = 113
            Top = 241
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NewPassChangeLabel: TLabel
            Left = 113
            Top = 187
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ReqPassChangeLabel: TLabel
            Left = 113
            Top = 158
            Width = 3
            Height = 13
            Cursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = ReqPassLabelClick
            OnMouseEnter = ReqPassLabelMouseEnter
            OnMouseLeave = ReqPassLabelMouseLeave
          end
          object CurrentPassChangeLabel: TLabel
            Left = 113
            Top = 112
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ChangePassButton: TButton
            Left = 112
            Top = 317
            Width = 207
            Height = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
            OnClick = ChangePassButtonClick
          end
          object ShowPassChangeCheckBox: TCheckBox
            Left = 112
            Top = 287
            Width = 296
            Height = 17
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ShowPassChangeCheckBoxClick
          end
          object RetypeNewPassEdit: TEdit
            Left = 112
            Top = 260
            Width = 207
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 4
          end
          object NewPassChangeEdit: TEdit
            Left = 112
            Top = 206
            Width = 207
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 3
          end
          object CurrentPassChangeEdit: TEdit
            Left = 112
            Top = 131
            Width = 207
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 2
          end
          object PassChangeInfoRichEdit: TRichEdit
            Left = 13
            Top = 20
            Width = 403
            Height = 77
            TabStop = False
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 5
          end
        end
      end
      object AnketaPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'AnketaPage'
        object MyInfoNameGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 124
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object FamilyInfoLabel: TLabel
            Left = 223
            Top = 18
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NameInfoLabel: TLabel
            Left = 16
            Top = 69
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object NickInfoLabel: TLabel
            Left = 16
            Top = 18
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ConnectTimeInfoLabel: TLabel
            Left = 223
            Top = 69
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object FamilyInfoEdit: TEdit
            Left = 222
            Top = 37
            Width = 192
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 0
          end
          object NameInfoEdit: TEdit
            Left = 15
            Top = 88
            Width = 192
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 1
          end
          object NickInfoEdit: TEdit
            Left = 15
            Top = 37
            Width = 192
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            TabOrder = 2
          end
          object ConnectTimeInfoEdit: TEdit
            Left = 222
            Top = 88
            Width = 192
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
        end
        object EmailsInfoGroupBox: TGroupBox
          Left = 0
          Top = 130
          Width = 428
          Height = 226
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object EmailInfo1Label: TLabel
            Left = 16
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SpeedButton1: TSpeedButton
            Left = 370
            Top = 85
            Width = 23
            Height = 22
            Flat = True
          end
          object SpeedButton4: TSpeedButton
            Left = 370
            Top = 131
            Width = 23
            Height = 22
            Flat = True
          end
          object SpeedButton5: TSpeedButton
            Left = 370
            Top = 176
            Width = 23
            Height = 22
            Flat = True
          end
          object EmailInfo2Label: TLabel
            Left = 16
            Top = 70
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EmailInfo3Label: TLabel
            Left = 16
            Top = 121
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object RegDateInfoLabel: TLabel
            Left = 223
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SendMessInfoLabel: TLabel
            Left = 223
            Top = 70
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object InMessInfoLabel: TLabel
            Left = 223
            Top = 121
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ExternalIPInfoLabel: TLabel
            Left = 16
            Top = 171
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object LastTimeInfoLabel: TLabel
            Left = 223
            Top = 171
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object EmailInfo1Edit: TEdit
            Left = 15
            Top = 38
            Width = 192
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 0
          end
          object EmailInfo2Edit: TEdit
            Left = 15
            Top = 90
            Width = 192
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 1
          end
          object EmailInfo3Edit: TEdit
            Left = 15
            Top = 140
            Width = 192
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 2
          end
          object RegDateInfoEdit: TEdit
            Left = 222
            Top = 38
            Width = 192
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object SendMessInfoEdit: TEdit
            Left = 222
            Top = 89
            Width = 192
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object InMessInfoEdit: TEdit
            Left = 222
            Top = 140
            Width = 192
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object ExternalIPInfoEdit: TEdit
            Left = 15
            Top = 190
            Width = 192
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
          object LastTimeInfoEdit: TEdit
            Left = 222
            Top = 190
            Width = 192
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
          end
        end
      end
      object HomePage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'HomePage'
        object OriginalInfoGroupBox: TGroupBox
          Left = 0
          Top = 231
          Width = 428
          Height = 125
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object OCountryInfoLabel: TLabel
            Left = 15
            Top = 20
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OCityInfoLabel: TLabel
            Left = 15
            Top = 69
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OAreaInfoLabel: TLabel
            Left = 245
            Top = 20
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object OCountryInfoComboBox: TComboBox
            Left = 14
            Top = 39
            Width = 215
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
          end
          object OCityInfoEdit: TEdit
            Left = 14
            Top = 88
            Width = 215
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 1
          end
          object OAreaInfoEdit: TEdit
            Left = 244
            Top = 39
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
          end
        end
        object HomeInfoGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 225
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object CountryInfoLabel: TLabel
            Left = 15
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CityInfoLabel: TLabel
            Left = 15
            Top = 68
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object AreaInfoLabel: TLabel
            Left = 15
            Top = 118
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object ZipInfoLabel: TLabel
            Left = 144
            Top = 118
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object StreetInfoLabel: TLabel
            Left = 15
            Top = 169
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PhoneInfoLabel: TLabel
            Left = 245
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object FaxInfoLabel: TLabel
            Left = 245
            Top = 68
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CelularInfoLabel: TLabel
            Left = 245
            Top = 118
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CityInfoEdit: TEdit
            Left = 14
            Top = 87
            Width = 215
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 0
          end
          object AreaInfoEdit: TEdit
            Left = 14
            Top = 137
            Width = 113
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
          end
          object ZipInfoEdit: TEdit
            Left = 143
            Top = 137
            Width = 86
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 2
          end
          object StreetInfoEdit: TEdit
            Left = 14
            Top = 188
            Width = 401
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 3
          end
          object PhoneInfoEdit: TEdit
            Left = 244
            Top = 38
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 4
          end
          object FaxInfoEdit: TEdit
            Left = 244
            Top = 87
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 5
          end
          object CelularInfoEdit: TEdit
            Left = 244
            Top = 137
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 6
          end
          object CountryInfoComboBox: TComboBox
            Left = 14
            Top = 38
            Width = 215
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            TabStop = False
          end
        end
      end
      object WorkPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'WorkPage'
        object WorkInfoGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 174
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object WorkCountryInfoLabel: TLabel
            Left = 15
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkCityInfoLabel: TLabel
            Left = 15
            Top = 68
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkAreaInfoLabel: TLabel
            Left = 15
            Top = 118
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkZipInfoLabel: TLabel
            Left = 144
            Top = 118
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkPhoneInfoLabel: TLabel
            Left = 245
            Top = 19
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkFaxInfoLabel: TLabel
            Left = 245
            Top = 68
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkStreetInfoLabel: TLabel
            Left = 245
            Top = 118
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object WorkCityInfoEdit: TEdit
            Left = 14
            Top = 87
            Width = 215
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 0
          end
          object WorkAreaInfoEdit: TEdit
            Left = 14
            Top = 137
            Width = 113
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
          end
          object WorkZipInfoEdit: TEdit
            Left = 143
            Top = 137
            Width = 86
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 2
          end
          object WorkPhoneInfoEdit: TEdit
            Left = 244
            Top = 38
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 3
          end
          object WorkFaxInfoEdit: TEdit
            Left = 244
            Top = 87
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 4
          end
          object WorkStreetInfoEdit: TEdit
            Left = 244
            Top = 137
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 5
          end
          object WorkCountryInfoComboBox: TComboBox
            Left = 14
            Top = 38
            Width = 215
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            TabStop = False
          end
        end
        object CompanyInfoGroupBox: TGroupBox
          Left = 0
          Top = 180
          Width = 429
          Height = 176
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object CompanyNameInfoLabel: TLabel
            Left = 15
            Top = 20
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyCabInfoLabel: TLabel
            Left = 15
            Top = 69
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyProfInfoLabel: TLabel
            Left = 245
            Top = 20
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyMasteInfoLabel: TLabel
            Left = 245
            Top = 69
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanySiteInfoLabel: TLabel
            Left = 15
            Top = 119
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object CompanyNameInfoEdit: TEdit
            Left = 14
            Top = 39
            Width = 215
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 0
          end
          object CompanyCabInfoEdit: TEdit
            Left = 14
            Top = 88
            Width = 215
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 1
          end
          object CompanyProfInfoComboBox: TComboBox
            Left = 244
            Top = 39
            Width = 171
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
          end
          object CompanyMasteInfoEdit: TEdit
            Left = 244
            Top = 88
            Width = 171
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 3
          end
          object CompanySiteInfoEdit: TEdit
            Left = 14
            Top = 138
            Width = 401
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 80
            ParentFont = False
            TabOrder = 4
          end
        end
      end
      object PersonalPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'PersonalPage'
        object PersonalInfoGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object PersonalGenderInfoLabel: TLabel
            Left = 13
            Top = 20
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalMaritalInfoLabel: TLabel
            Left = 146
            Top = 20
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SpeedButton3: TSpeedButton
            Left = 368
            Top = 86
            Width = 23
            Height = 22
            Flat = True
          end
          object PersonalHomePageInfoLabel: TLabel
            Left = 146
            Top = 72
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object HoroImage: TImage
            Left = 380
            Top = 141
            Width = 32
            Height = 32
          end
          object PersonalAgeInfoLabel: TLabel
            Left = 13
            Top = 198
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalDayInfoLabel: TLabel
            Left = 64
            Top = 151
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalMonInfoLabel: TLabel
            Left = 190
            Top = 151
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalYearInfoLabel: TLabel
            Left = 307
            Top = 151
            Width = 3
            Height = 13
            Alignment = taRightJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalChildrenInfoLabel: TLabel
            Left = 13
            Top = 72
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalReligionInfoLabel: TLabel
            Left = 146
            Top = 198
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalHeightInfoLabel: TLabel
            Left = 13
            Top = 251
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalSmokInfoLabel: TLabel
            Left = 146
            Top = 251
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalSexInfoLabel: TLabel
            Left = 146
            Top = 305
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalHairColourInfoLabel: TLabel
            Left = 13
            Top = 305
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Bevel1: TBevel
            Left = 12
            Top = 179
            Width = 405
            Height = 8
            Shape = bsBottomLine
          end
          object PersonalBirthDayInfoLabel: TLabel
            Left = 12
            Top = 126
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object PersonalGenderInfoComboBox: TComboBox
            Left = 12
            Top = 39
            Width = 117
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
          end
          object PersonalMaritalInfoComboBox: TComboBox
            Left = 145
            Top = 39
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
          end
          object PersonalHomePageInfoEdit: TEdit
            Left = 145
            Top = 91
            Width = 272
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 2
          end
          object PersonalYearInfoEdit: TEdit
            Left = 316
            Top = 147
            Width = 49
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 3
          end
          object PersonalAgeInfoEdit: TEdit
            Left = 12
            Top = 217
            Width = 117
            Height = 21
            TabStop = False
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object PersonalChildrenInfoComboBox: TComboBox
            Left = 12
            Top = 91
            Width = 117
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            TabStop = False
          end
          object PersonalReligionInfoComboBox: TComboBox
            Left = 145
            Top = 217
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            TabStop = False
          end
          object PersonalDayInfoComboBox: TComboBox
            Left = 73
            Top = 147
            Width = 56
            Height = 21
            Style = csDropDownList
            DropDownCount = 18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            TabStop = False
            Items.Strings = (
              ''
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15'
              '16'
              '17'
              '18'
              '19'
              '20'
              '21'
              '22'
              '23'
              '24'
              '25'
              '26'
              '27'
              '28'
              '29'
              '30'
              '31')
          end
          object PersonalMonInfoComboBox: TComboBox
            Left = 199
            Top = 147
            Width = 56
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            TabStop = False
            Items.Strings = (
              ''
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12')
          end
          object PersonalHeightInfoComboBox: TComboBox
            Left = 12
            Top = 270
            Width = 117
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            TabStop = False
          end
          object PersonalSmokInfoComboBox: TComboBox
            Left = 145
            Top = 270
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
            TabStop = False
          end
          object PersonalSexInfoComboBox: TComboBox
            Left = 145
            Top = 324
            Width = 272
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            TabStop = False
          end
          object PersonalHairColourInfoComboBox: TComboBox
            Left = 12
            Top = 324
            Width = 117
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            TabStop = False
          end
        end
      end
      object InterestsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'InterestsPage'
        object LangsInfoGroupBox: TGroupBox
          Left = 0
          Top = 138
          Width = 428
          Height = 56
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Lang1InfoComboBox: TComboBox
            Left = 11
            Top = 24
            Width = 131
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
          end
          object Lang2InfoComboBox: TComboBox
            Left = 148
            Top = 24
            Width = 132
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
          end
          object Lang3InfoComboBox: TComboBox
            Left = 286
            Top = 24
            Width = 131
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
          end
        end
        object InterestInfoGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 133
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Interest1InfoComboBox: TComboBox
            Left = 11
            Top = 19
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = False
          end
          object Interest2InfoComboBox: TComboBox
            Left = 11
            Top = 46
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            TabStop = False
          end
          object Interest3InfoComboBox: TComboBox
            Left = 11
            Top = 73
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            TabStop = False
          end
          object Interest4InfoComboBox: TComboBox
            Left = 11
            Top = 100
            Width = 145
            Height = 21
            Style = csDropDownList
            DropDownCount = 15
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            TabStop = False
          end
          object Interest1InfoEdit: TEdit
            Left = 162
            Top = 19
            Width = 255
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 4
          end
          object Interest2InfoEdit: TEdit
            Left = 162
            Top = 46
            Width = 255
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 5
          end
          object Interest3InfoEdit: TEdit
            Left = 162
            Top = 73
            Width = 255
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 6
          end
          object Interest4InfoEdit: TEdit
            Left = 162
            Top = 100
            Width = 255
            Height = 21
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 60
            ParentFont = False
            TabOrder = 7
          end
        end
        object AboutInfoGroupBox: TGroupBox
          Left = 0
          Top = 200
          Width = 428
          Height = 156
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object AboutInfoRichEdit: TRichEdit
            Left = 11
            Top = 20
            Width = 406
            Height = 127
            TabStop = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HideScrollBars = False
            ParentFont = False
            PlainText = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object AvatarPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'AvatarPage'
        object AvatarInfoGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
      object ParamsPage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ParamsPage'
        object ParamInfoGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object ParamInfoRichEdit: TRichEdit
            Left = 13
            Top = 20
            Width = 403
            Height = 324
            TabStop = False
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object ConsolePage: TJvStandardPage
        Left = 0
        Top = 0
        Width = 428
        Height = 356
        Caption = 'ConsolePage'
        object CustomICQPacketGroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 428
          Height = 356
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 14
            Top = 89
            Width = 159
            Height = 13
            Caption = '#'#1055#1072#1082#1077#1090' '#1076#1072#1085#1085#1099#1093' '#1074' HEX '#1092#1086#1088#1084#1072#1090#1077
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SendCustomICQPacketRichEdit: TRichEdit
            Left = 13
            Top = 108
            Width = 403
            Height = 210
            TabStop = False
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object DumpInfoRichEdit: TRichEdit
            Left = 13
            Top = 20
            Width = 403
            Height = 61
            TabStop = False
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = clBtnFace
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            PlainText = True
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 1
          end
          object SendCustomICQPacketButton: TBitBtn
            Left = 318
            Top = 324
            Width = 98
            Height = 25
            DoubleBuffered = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentDoubleBuffered = False
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnClick = SendCustomICQPacketButtonClick
          end
        end
      end
    end
  end
  object ApplyButton: TBitBtn
    Left = 369
    Top = 380
    Width = 107
    Height = 25
    DoubleBuffered = True
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 2
    TabStop = False
    OnClick = ApplyButtonClick
  end
  object CancelButton: TBitBtn
    Left = 8
    Top = 380
    Width = 137
    Height = 25
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    TabStop = False
    OnClick = CancelButtonClick
  end
  object OKButton: TBitBtn
    Left = 482
    Top = 380
    Width = 107
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    TabStop = False
    OnClick = OKButtonClick
  end
end
