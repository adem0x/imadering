object FloatingForm: TFloatingForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'FloatingForm'
  ClientHeight = 20
  ClientWidth = 162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = FloatPopupMenu
  Scaled = False
  ScreenSnap = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object FloatShape: TShape
    Left = 27
    Top = 1
    Width = 65
    Height = 17
    ParentShowHint = False
    Pen.Color = clActiveCaption
    ShowHint = False
  end
  object StatusImage: TImage
    AlignWithMargins = True
    Left = 3
    Top = 2
    Width = 16
    Height = 16
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    Center = True
    PopupMenu = FloatPopupMenu
    Transparent = True
    ExplicitLeft = 2
  end
  object XStatusImage: TImage
    AlignWithMargins = True
    Left = 23
    Top = 2
    Width = 16
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    Center = True
    PopupMenu = FloatPopupMenu
    Transparent = True
    ExplicitLeft = 22
    ExplicitHeight = 17
  end
  object ClientImage: TImage
    AlignWithMargins = True
    Left = 143
    Top = 2
    Width = 16
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Bottom = 2
    Align = alRight
    Center = True
    PopupMenu = FloatPopupMenu
    Transparent = True
    ExplicitLeft = 142
    ExplicitTop = 3
    ExplicitHeight = 15
  end
  object NickLabel: TLabel
    AlignWithMargins = True
    Left = 43
    Top = 2
    Width = 44
    Height = 16
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    Caption = 'NickLabel'
    Color = clWhite
    ParentColor = False
    ParentShowHint = False
    PopupMenu = FloatPopupMenu
    ShowHint = False
    Layout = tlCenter
    ExplicitHeight = 13
  end
  object FloatPopupMenu: TPopupMenu
    Alignment = paCenter
    Images = MainForm.AllImageList
    Left = 104
    object OpenChatFloatMenu: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      ImageIndex = 163
      OnClick = OpenChatFloatMenuClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object CloseFloatMenu: TMenuItem
      Caption = #1042#1099#1082#1083'. '#1087#1083#1072#1074#1072#1102#1097#1080#1081' '#1082#1086#1085#1090#1072#1082#1090
      ImageIndex = 248
      OnClick = CloseFloatMenuClick
    end
  end
end
