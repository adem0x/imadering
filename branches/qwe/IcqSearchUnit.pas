{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit IcqSearchUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Menus, VarsUnit;

type
  TIcqSearchForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    ListView1: TListView;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Panel3: TPanel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Panel4: TPanel;
    Edit2: TEdit;
    CheckBox2: TCheckBox;
    Panel5: TPanel;
    Edit3: TEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    BitBtn1: TBitBtn;
    Panel6: TPanel;
    Panel7: TPanel;
    SpeedButton1: TSpeedButton;
    Edit4: TEdit;
    SpeedButton2: TSpeedButton;
    Panel8: TPanel;
    Edit5: TEdit;
    CheckBox6: TCheckBox;
    Panel9: TPanel;
    Edit6: TEdit;
    CheckBox7: TCheckBox;
    Panel10: TPanel;
    Edit7: TEdit;
    Label1: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    ComboBox1: TComboBox;
    Edit10: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    ComboBox9: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    ComboBox10: TComboBox;
    Bevel3: TBevel;
    Bevel4: TBevel;
    ComboBox11: TComboBox;
    ComboBox12: TComboBox;
    ComboBox13: TComboBox;
    Edit19: TEdit;
    ComboBox14: TComboBox;
    ComboBox15: TComboBox;
    ComboBox16: TComboBox;
    Edit20: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Panel13: TPanel;
    Edit21: TEdit;
    CheckBox8: TCheckBox;
    Panel14: TPanel;
    CheckBox9: TCheckBox;
    Panel15: TPanel;
    Edit23: TEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label31: TLabel;
    Label32: TLabel;
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    ComboBox17: TComboBox;
    BitBtn4: TBitBtn;
    AutoSendTimer: TTimer;
    N41: TMenuItem;
    N51: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Edit4Enter(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ListView1Changing(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
    procedure ListView1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ListView1GetSubItemImage(Sender: TObject; Item: TListItem;
      SubItem: Integer; var ImageIndex: Integer);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox17Change(Sender: TObject);
    procedure Edit21KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit23KeyPress(Sender: TObject; var Key: Char);
    procedure AutoSendTimerTimer(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit23Change(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1DblClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    QmessT: string;
    sPage: word;
    sPageInc: boolean;
    autosendind: integer;
  public
    { Public declarations }
    SP1, SP2, SP3, SP4: string;
    G1, G2: string;
    A1, A2: string;
    procedure TranslateForm;
  end;

var
  IcqSearchForm: TIcqSearchForm;

implementation

uses MainUnit, IcqProtoUnit, UtilsUnit, IcqAddContactUnit, IcqContactInfoUnit;

{$R *.dfm}

procedure TIcqSearchForm.TranslateForm;
//var
//  i, ItemWidth, CWidth: integer;
begin
  {Lini := TIniFile.Create(MyPath + 'Langs\' + CurrentLang + '\General.txt');
  //
  Caption := Lini.ReadString('IcqSearch', '1', EmptyStr);
  PageControl1.Pages[0].Caption := Lini.ReadString('IcqSearch', '2', EmptyStr);
  PageControl1.Pages[1].Caption := Lini.ReadString('IcqSearch', '3', EmptyStr);
  PageControl1.Pages[2].Caption := Lini.ReadString('IcqSearch', '4', EmptyStr);
  PageControl1.Pages[3].Caption := Lini.ReadString('IcqSearch', '5', EmptyStr);
  PageControl1.Pages[4].Caption := Lini.ReadString('IcqSearch', '6', EmptyStr);
  PageControl1.Pages[5].Caption := Lini.ReadString('IcqSearch', '7', EmptyStr);
  CheckBox1.Caption := Lini.ReadString('IcqSearch', '8', EmptyStr);
  CheckBox2.Caption := Lini.ReadString('IcqSearch', '9', EmptyStr);
  CheckBox3.Caption := Lini.ReadString('IcqSearch', '10', EmptyStr);
  CheckBox4.Caption := Lini.ReadString('IcqSearch', '14', EmptyStr);
  CheckBox5.Caption := Lini.ReadString('IcqSearch', '15', EmptyStr);
  BitBtn1.Caption := Lini.ReadString('IcqSearch', '16', EmptyStr);
  ListView1.Column[0].Caption := Lini.ReadString('IcqSearch', '17', EmptyStr);
  ListView1.Column[1].Caption := Lini.ReadString('IcqSearch', '11', EmptyStr);
  ListView1.Column[2].Caption := Lini.ReadString('IcqSearch', '12', EmptyStr);
  ListView1.Column[3].Caption := Lini.ReadString('IcqSearch', '13', EmptyStr);
  ListView1.Column[4].Caption := Lini.ReadString('IcqSearch', '18', EmptyStr);
  ListView1.Column[5].Caption := Lini.ReadString('IcqSearch', '19', EmptyStr);
  ListView1.Column[7].Caption := Lini.ReadString('IcqSearch', '20', EmptyStr);
  CheckBox6.Caption := Lini.ReadString('IcqSearch', '8', EmptyStr);
  CheckBox7.Caption := Lini.ReadString('IcqSearch', '9', EmptyStr);
  Label1.Caption := Lini.ReadString('IcqSearch', '11', EmptyStr) + ':';
  Label2.Caption := Lini.ReadString('IcqSearch', '12', EmptyStr) + ':';
  Label3.Caption := Lini.ReadString('IcqSearch', '13', EmptyStr) + ':';
  Panel6.Caption := Lini.ReadString('IcqSearch', '21', EmptyStr);
  SP1 := Panel6.Caption;
  SP2 := Lini.ReadString('IcqSearch', '22', EmptyStr);
  SP3 := Lini.ReadString('IcqSearch', '23', EmptyStr);
  SP4 := Lini.ReadString('IcqSearch', '24', EmptyStr);
  SpeedButton1.Hint := Lini.ReadString('IcqSearch', '25', EmptyStr);
  SpeedButton2.Hint := Lini.ReadString('IcqSearch', '26', EmptyStr);
  Edit4.Text := ' ' + Lini.ReadString('IcqSearch', '27', EmptyStr);
  QmessT := Edit4.Text;
  //
  Label4.Caption := Lini.ReadString('IcqSearch', '28', EmptyStr);
  Label5.Caption := Lini.ReadString('IcqSearch', '29', EmptyStr);
  Label6.Caption := Lini.ReadString('IcqSearch', '30', EmptyStr);
  Label7.Caption := Lini.ReadString('IcqSearch', '31', EmptyStr);
  Label8.Caption := Lini.ReadString('IcqSearch', '32', EmptyStr);
  Label9.Caption := Lini.ReadString('IcqSearch', '33', EmptyStr);
  Label10.Caption := Lini.ReadString('IcqSearch', '34', EmptyStr);
  Label11.Caption := Lini.ReadString('IcqSearch', '35', EmptyStr);
  Label12.Caption := Lini.ReadString('IcqSearch', '36', EmptyStr);
  Label13.Caption := Lini.ReadString('IcqSearch', '37', EmptyStr);
  Label14.Caption := Lini.ReadString('IcqSearch', '11', EmptyStr) + ':';
  Label15.Caption := Lini.ReadString('IcqSearch', '12', EmptyStr) + ':';
  Label16.Caption := Lini.ReadString('IcqSearch', '13', EmptyStr) + ':';
  Label17.Caption := Lini.ReadString('IcqSearch', '20', EmptyStr) + ':';
  Label18.Caption := Lini.ReadString('IcqSearch', '38', EmptyStr);
  //
  Label19.Caption := Lini.ReadString('IcqSearch', '11', EmptyStr) + ':';
  Label20.Caption := Lini.ReadString('IcqSearch', '12', EmptyStr) + ':';
  Label21.Caption := Lini.ReadString('IcqSearch', '13', EmptyStr) + ':';
  Label22.Caption := Lini.ReadString('IcqSearch', '28', EmptyStr);
  Label23.Caption := Lini.ReadString('IcqSearch', '29', EmptyStr);
  Label24.Caption := Lini.ReadString('IcqSearch', '32', EmptyStr);
  Label25.Caption := Lini.ReadString('IcqSearch', '30', EmptyStr);
  Label26.Caption := Lini.ReadString('IcqSearch', '31', EmptyStr);
  Label27.Caption := Lini.ReadString('IcqSearch', '38', EmptyStr);
  Label28.Caption := Lini.ReadString('IcqSearch', '33', EmptyStr);
  Label29.Caption := Lini.ReadString('IcqSearch', '36', EmptyStr);
  Label30.Caption := Lini.ReadString('IcqSearch', '37', EmptyStr);
  //
  CheckBox8.Caption := Lini.ReadString('IcqSearch', '39', EmptyStr);
  CheckBox9.Caption := Lini.ReadString('IcqSearch', '40', EmptyStr);
  Label31.Caption := Lini.ReadString('IcqSearch', '41', EmptyStr);
  Label32.Caption := Lini.ReadString('IcqSearch', '42', EmptyStr);
  BitBtn2.Caption := Lini.ReadString('IcqSearch', '43', EmptyStr);
  BitBtn3.Caption := Lini.ReadString('IcqSearch', '44', EmptyStr);
  BitBtn4.Caption := Lini.ReadString('IcqSearch', '49', EmptyStr);
  //
  G1 := Lini.ReadString('IcqSearch', '45', EmptyStr);
  G2 := Lini.ReadString('IcqSearch', '46', EmptyStr);
  A1 := Lini.ReadString('IcqSearch', '47', EmptyStr);
  A2 := Lini.ReadString('IcqSearch', '48', EmptyStr);
  //
  ComboBox1.Clear;
  ComboBox1.Items.Add(EmptyStr);
  ComboBox1.Items.Add(Lini.ReadString('Gender', '1', EmptyStr));
  ComboBox1.Items.Add(Lini.ReadString('Gender', '2', EmptyStr));
  ComboBox1.ItemIndex := 0;
  ComboBox10.Items.Assign(ComboBox1.Items);
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries.txt') then
  begin
    ComboBox3.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries.txt');
    ComboBox13.Items.Assign(ComboBox3.Items);
    ComboBox3.ItemIndex := 0;
    ComboBox13.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox3 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
    Combobox13.Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus.txt') then
  begin
    ComboBox4.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus.txt');
    ComboBox12.Items.Assign(ComboBox4.Items);
    ComboBox4.ItemIndex := 0;
    ComboBox12.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox4 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
    Combobox12.Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Occupation.txt') then
  begin
    ComboBox5.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Occupation.txt');
    ComboBox5.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox5 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Industry.txt') then
  begin
    ComboBox15.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Industry.txt');
    ComboBox15.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox15 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Organization.txt') then
  begin
    ComboBox6.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Organization.txt');
    ComboBox6.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox6 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Past.txt') then
  begin
    ComboBox7.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Past.txt');
    ComboBox7.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox7 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests.txt') then
  begin
    ComboBox8.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests.txt');
    ComboBox16.Items.Assign(ComboBox8.Items);
    ComboBox8.ItemIndex := 0;
    ComboBox16.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox8 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
    Combobox16.Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages.txt') then
  begin
    ComboBox9.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages.txt');
    ComboBox14.Items.Assign(ComboBox9.Items);
    ComboBox9.ItemIndex := 0;
    ComboBox14.ItemIndex := 0;
    ItemWidth := 0;
    with Combobox9 do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        CWidth := Application.MainForm.Canvas.TextWidth(Items.Strings[i]);
        if CWidth > ItemWidth then ItemWidth := CWidth;
      end;
      Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
    end;
    Combobox14.Perform(CB_SETDROPPEDWIDTH, ItemWidth + 25, 0);
  end;
  //
  if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_RandGroups.txt') then
  begin
    ComboBox17.Items.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_RandGroups.txt');
    ComboBox17.ItemIndex := 0;
  end;
  //
  for i := 0 to PopupMenu1.Items.Count - 1 do
  begin
    if PopupMenu1.Items[i].Tag = 1 then
      PopupMenu1.Items[i].Caption := Lini.ReadString('Menus', '15', EmptyStr)
    else if PopupMenu1.Items[i].Tag = 2 then
      PopupMenu1.Items[i].Caption := Lini.ReadString('Menus', '18', EmptyStr)
    else if PopupMenu1.Items[i].Tag = 3 then
      PopupMenu1.Items[i].Caption := Lini.ReadString('Menus', '14', EmptyStr)
    else if PopupMenu1.Items[i].Tag = 4 then
      PopupMenu1.Items[i].Caption := Lini.ReadString('Menus', '16', EmptyStr)
    else if PopupMenu1.Items[i].Tag = 5 then
      PopupMenu1.Items[i].Caption := Lini.ReadString('Menus', '43', EmptyStr);
  end;
  //
  Lini.Free;}
end;

procedure TIcqSearchForm.AutoSendTimerTimer(Sender: TObject);
label
  x, y;
begin
  if ListView1.Items.Count > 0 then
  begin
    x: ;
    ListView1.ItemIndex := autosendind;
    if ListView1.Selected <> nil then
    begin
      if ListView1.Selected.Checked then
      begin
        if autosendind = ListView1.Items.Count - 1 then goto y;
        Inc(autosendind);
        goto x;
      end;
      SpeedButton2Click(self);
      if autosendind = ListView1.Items.Count - 1 then goto y;
      Inc(autosendind);
    end;
  end
  else
  begin
    y: ;
    AutoSendTimer.Enabled := false;
    //
    BitBtn2.Enabled := true;
    BitBtn3.Enabled := false;
    //DAShow(false, '4', '34', EmptyStr, 157, 3, 10000);
  end;
end;

procedure TIcqSearchForm.BitBtn1Click(Sender: TObject);
var
  CodeList: TStringList;
  CountryInd, LangInd, OccupInd, IntInd, PastInd, MaritalInd, OrganInd: integer;
begin
  if not CheckBox4.Checked then
  begin
    ListView1.Clear;
    Panel7.Caption := '0';
  end;
  //
  case PageControl1.ActivePageIndex of
    0:
      begin
        if (Edit1.Text > EmptyStr) and (CheckBox1.Checked) then
        begin
          Edit1.Text := exNormalizeScreenName(Edit1.Text);
          Edit1.Text := exNormalizeIcqNumber(Edit1.Text);
          if not exIsValidCharactersDigit(Edit1.Text) then
          begin
            Edit1.Clear;
            Exit;
          end;
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoUIN_old_1(Edit1.Text);
          end;
        end;
        //
        if (Edit2.Text > EmptyStr) and (CheckBox2.Checked) then
        begin
          Edit2.Text := exNormalizeScreenName(Edit2.Text);
          Edit2.Text := exNormalizeIcqNumber(Edit2.Text);
          if not exIsValidCharactersDigit(Edit2.Text) then
          begin
            Edit2.Clear;
            Exit;
          end;
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoUIN_old_2(Edit2.Text);
          end;
        end;
        //
        if (Edit3.Text > EmptyStr) and (CheckBox3.Checked) then
        begin
          Edit3.Text := exNormalizeScreenName(Edit3.Text);
          Edit3.Text := exNormalizeIcqNumber(Edit3.Text);
          if not exIsValidCharactersDigit(Edit3.Text) then
          begin
            Edit3.Clear;
            Exit;
          end;
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoUIN_new(Edit3.Text);
          end;
        end;
      end;
    1:
      begin
        if (Edit5.Text > EmptyStr) and (CheckBox6.Checked) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoEmail_old(Edit5.Text, CheckBox5.Checked);
          end;
        end;
        //
        if (Edit6.Text > EmptyStr) and (CheckBox7.Checked) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoEmail_new(Edit6.Text);
          end;
        end;
      end;
    2:
      begin
        if (Edit7.Text > EmptyStr) or (Edit8.Text > EmptyStr) or (Edit9.Text > EmptyStr) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoNick_First_Last(Edit7.Text, Edit8.Text, Edit9.Text, CheckBox5.Checked);
          end;
        end;
      end;
    3:
      begin
        if not ICQ_Work_Phaze then Exit;
        if IsNotNull([Edit12.Text, Edit13.Text, Edit14.Text, Edit10.Text, Edit11.Text,
          ComboBox1.Text, ComboBox2.Text, ComboBox4.Text, ComboBox3.Text,
            ComboBox9.Text, ComboBox5.Text, ComboBox8.Text, Edit15.Text,
            ComboBox6.Text, ComboBox7.Text]) then
        begin
          CodeList := TStringList.Create;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt');
          try
            CountryInd := StrToInt(CodeList.Strings[ComboBox3.ItemIndex]);
          except
            CountryInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt');
          try
            LangInd := StrToInt(CodeList.Strings[ComboBox9.ItemIndex]);
          except
            LangInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt');
          try
            IntInd := StrToInt(CodeList.Strings[ComboBox8.ItemIndex]);
          except
            IntInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt');
          try
            MaritalInd := StrToInt(CodeList.Strings[ComboBox4.ItemIndex]);
          except
            MaritalInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Occupation_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Occupation_codes.txt');
          try
            OccupInd := StrToInt(CodeList.Strings[ComboBox5.ItemIndex]);
          except
            OccupInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Organization_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Organization_codes.txt');
          try
            OrganInd := StrToInt(CodeList.Strings[ComboBox6.ItemIndex]);
          except
            OrganInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Past_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Past_codes.txt');
          try
            PastInd := StrToInt(CodeList.Strings[ComboBox7.ItemIndex]);
          except
            PastInd := 0;
          end;
          CodeList.Free;
          //
          Panel6.Caption := SP2;
          ICQ_SearchByPersonalInfo(Edit12.Text, Edit13.Text, Edit14.Text, Edit10.Text, Edit11.Text,
            ComboBox1.ItemIndex, ComboBox2.ItemIndex, MaritalInd, CountryInd,
            LangInd, OccupInd, IntInd, CheckBox5.Checked,
            Edit15.Text, OrganInd, PastInd);
        end;
      end;
    4:
      begin
        if not ICQ_Work_Phaze then Exit;
        if IsNotNull([ComboBox15.Text, ComboBox16.Text]) then
        begin
          // interest or work
          CodeList := TStringList.Create;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt');
          try
            CountryInd := StrToInt(CodeList.Strings[ComboBox13.ItemIndex]);
          except
            CountryInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt');
          try
            LangInd := StrToInt(CodeList.Strings[ComboBox14.ItemIndex]);
          except
            LangInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Interests_codes.txt');
          try
            IntInd := StrToInt(CodeList.Strings[ComboBox16.ItemIndex]);
          except
            IntInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt');
          try
            MaritalInd := StrToInt(CodeList.Strings[ComboBox12.ItemIndex]);
          except
            MaritalInd := 0;
          end;
          CodeList.Clear;
          //
          if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Industry_codes.txt') then
            CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Industry_codes.txt');
          try
            OccupInd := StrToInt(CodeList.Strings[ComboBox15.ItemIndex]);
          except
            OccupInd := 0;
          end;
          CodeList.Free;
          //
          Panel6.Caption := SP2;
          ICQ_SearchByPersonalInfo(Edit16.Text, Edit17.Text, Edit18.Text, Edit19.Text, Edit20.Text, ComboBox10.ItemIndex,
            ComboBox11.ItemIndex, MaritalInd, CountryInd, LangInd,
            OccupInd, IntInd, CheckBox5.Checked);
        end
        else
        begin
          if IsNotNull([Edit16.Text, Edit17.Text, Edit18.Text, Edit19.Text,
            Edit20.Text, ComboBox10.Text, ComboBox11.Text, ComboBox12.Text,
              ComboBox13.Text, ComboBox14.Text]) then
          begin
            if sPageInc then Inc(sPage)
            else sPage := 0;
            //
            CodeList := TStringList.Create;
            //
            if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt') then
              CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Countries_codes.txt');
            try
              CountryInd := StrToInt(CodeList.Strings[ComboBox13.ItemIndex]);
            except
              CountryInd := 0;
            end;
            CodeList.Clear;
            //
            if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt') then
              CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_Languages_codes.txt');
            try
              LangInd := StrToInt(CodeList.Strings[ComboBox14.ItemIndex]);
            except
              LangInd := 0;
            end;
            CodeList.Clear;
            //
            if FileExists(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt') then
              CodeList.LoadFromFile(MyPath + 'Langs\' + CurrentLang + '\Icq_MaritalStatus_codes.txt');
            try
              MaritalInd := StrToInt(CodeList.Strings[ComboBox12.ItemIndex]);
            except
              MaritalInd := 0;
            end;
            CodeList.Clear;
            //
            Panel6.Caption := SP2;
            ICQ_SearchNewBase(Edit16.Text, Edit17.Text, Edit18.Text, Edit19.Text, Edit20.Text, ComboBox10.ItemIndex,
              ComboBox11.ItemIndex, MaritalInd, CountryInd, LangInd, sPage,
              CheckBox5.Checked);
            sPageInc := false;
          end;
        end;
      end;
    5:
      begin
        if (Edit21.Text > EmptyStr) and (CheckBox8.Checked) then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoText(Edit21.Text, CheckBox5.Checked);
          end;
        end;
        //
        if CheckBox9.Checked then
        begin
          if ICQ_Work_Phaze then
          begin
            Panel6.Caption := SP2;
            ICQ_SearchPoChatGroup(ComboBox17.ItemIndex + 1);
          end;
        end;
      end;
  end;
end;

procedure TIcqSearchForm.BitBtn2Click(Sender: TObject);
begin
  if ListView1.Items.Count > 0 then
  begin
    autosendind := 0;
    if (Edit23.Text = EmptyStr) or (Edit23.Text = '0') then Edit23.Text := '60';
    AutoSendTimer.Interval := StrToInt(Edit23.Text) * 1000;
    AutoSendTimer.Enabled := true;
    //
    BitBtn2.Enabled := false;
    BitBtn3.Enabled := true;
  end
  else
  begin
    AutoSendTimer.Enabled := false;
  end;
end;

procedure TIcqSearchForm.BitBtn3Click(Sender: TObject);
begin
  AutoSendTimer.Enabled := false;
  //
  BitBtn2.Enabled := true;
  BitBtn3.Enabled := false;
end;

procedure TIcqSearchForm.BitBtn4Click(Sender: TObject);
begin
  sPageInc := true;
  BitBtn1Click(self);
end;

procedure TIcqSearchForm.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    CheckBox2.Checked := false;
    CheckBox3.Checked := false;
  end;
end;

procedure TIcqSearchForm.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then
  begin
    CheckBox1.Checked := false;
    CheckBox3.Checked := false;
  end;
end;

procedure TIcqSearchForm.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked then
  begin
    CheckBox1.Checked := false;
    CheckBox2.Checked := false;
  end;
end;

procedure TIcqSearchForm.CheckBox6Click(Sender: TObject);
begin
  if CheckBox6.Checked then CheckBox7.Checked := false;
end;

procedure TIcqSearchForm.CheckBox7Click(Sender: TObject);
begin
  if CheckBox7.Checked then CheckBox6.Checked := false;
end;

procedure TIcqSearchForm.CheckBox8Click(Sender: TObject);
begin
  if CheckBox8.Checked then CheckBox9.Checked := false;
end;

procedure TIcqSearchForm.CheckBox9Click(Sender: TObject);
begin
  if CheckBox9.Checked then CheckBox8.Checked := false;
end;

procedure TIcqSearchForm.ComboBox17Change(Sender: TObject);
begin
  CheckBox8.Checked := false;
  CheckBox9.Checked := true;
end;

procedure TIcqSearchForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  CheckBox1.Checked := true;
  CheckBox2.Checked := false;
  CheckBox3.Checked := false;
end;

procedure TIcqSearchForm.Edit21KeyPress(Sender: TObject; var Key: Char);
begin
  CheckBox8.Checked := true;
  CheckBox9.Checked := false;
end;

procedure TIcqSearchForm.Edit23Change(Sender: TObject);
begin
  if (Edit23.Text = EmptyStr) or (Edit23.Text = '0') then Edit23.Text := '60';
  AutoSendTimer.Interval := StrToInt(Edit23.Text) * 1000;
end;

procedure TIcqSearchForm.Edit23KeyPress(Sender: TObject; var Key: Char);
const
  ValidAsciiChars = ['0'..'9'];
begin
  if (not (Key in ValidAsciiChars)) and (Key <> #8) then Key := #0;
end;

procedure TIcqSearchForm.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  CheckBox1.Checked := false;
  CheckBox2.Checked := true;
  CheckBox3.Checked := false;
end;

procedure TIcqSearchForm.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  CheckBox1.Checked := false;
  CheckBox2.Checked := false;
  CheckBox3.Checked := true;
end;

procedure TIcqSearchForm.Edit4Enter(Sender: TObject);
var
  FOptions: TFontStyles;
begin
  if Edit4.Tag = 1 then
  begin
    Edit4.Clear;
    FOptions := [];
    Edit4.Font.Style := FOptions;
    Edit4.Tag := 0;
  end;
end;

procedure TIcqSearchForm.Edit4Exit(Sender: TObject);
var
  FOptions: TFontStyles;
begin
  if Edit4.Text = EmptyStr then
  begin
    FOptions := [];
    Include(FOptions, fsBold);
    Edit4.Font.Style := FOptions;
    Edit4.Text := ' ' + QmessT;
    Edit4.Tag := 1;
  end;
end;

procedure TIcqSearchForm.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
  CheckBox6.Checked := true;
  CheckBox7.Checked := false;
end;

procedure TIcqSearchForm.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  CheckBox6.Checked := false;
  CheckBox7.Checked := true;
end;

procedure TIcqSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //BringWindowToTop(RoasterForm.Handle);
end;

procedure TIcqSearchForm.FormCreate(Sender: TObject);
begin
  {Sini := TIniFile.Create(Mypath + 'Config.ini');
  //
  Left := Sini.ReadInteger('General', 'IcqSearchLeft', 30);
  Top := Sini.ReadInteger('General', 'IcqSearchTop', 30);
  Height := Sini.ReadInteger('General', 'IcqSearchHeight', 482);
  Width := Sini.ReadInteger('General', 'IcqSearchWidth', 542);
  //
  Sini.Free;}
  //
  TranslateForm;
  //
  MainForm.AllImageList.GetIcon(46, Icon);
  MainForm.AllImageList.GetBitmap(49, BitBtn1.Glyph);
  MainForm.AllImageList.GetBitmap(45, BitBtn2.Glyph);
  MainForm.AllImageList.GetBitmap(33, BitBtn3.Glyph);
  MainForm.AllImageList.GetBitmap(128, SpeedButton1.Glyph);
  MainForm.AllImageList.GetBitmap(133, SpeedButton2.Glyph);
  MainForm.AllImageList.GetBitmap(183, BitBtn4.Glyph);
  //
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TIcqSearchForm.FormDestroy(Sender: TObject);
begin
  //--Sohranyaem razmery
  {Sini := TIniFile.Create(Mypath + 'Config.ini');
  //
  Sini.WriteInteger('General', 'IcqSearchLeft', Left);
  Sini.WriteInteger('General', 'IcqSearchTop', Top);
  Sini.WriteInteger('General', 'IcqSearchHeight', Height);
  Sini.WriteInteger('General', 'IcqSearchWidth', Width);
  //
  Sini.Free;}
end;

procedure TIcqSearchForm.FormResize(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0: PageControl1.Height := PageControl1.ActivePage.Top + Panel3.Height + 10;
    1: PageControl1.Height := PageControl1.ActivePage.Top + Panel8.Height + 10;
    2: PageControl1.Height := PageControl1.ActivePage.Top + Panel10.Height + 10;
    3: PageControl1.Height := PageControl1.ActivePage.Top + Panel11.Height + 10;
    4: PageControl1.Height := PageControl1.ActivePage.Top + Panel12.Height + 10;
    5: PageControl1.Height := PageControl1.ActivePage.Top + Panel15.Top + Panel15.Height + 7;
  end;
end;

procedure TIcqSearchForm.ListView1Changing(Sender: TObject; Item: TListItem;
  Change: TItemChange; var AllowChange: Boolean);
begin
  Panel7.Caption := IntToStr(ListView1.Items.Count);
end;

procedure TIcqSearchForm.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if ListView1.SortType = stNone then ListView1.SortType := stText
  else ListView1.SortType := stNone;
end;

procedure TIcqSearchForm.ListView1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  if ListView1.Selected <> nil then
  begin
    Handled := false;
  end
  else
  begin
    Handled := true;
  end;
end;

procedure TIcqSearchForm.ListView1DblClick(Sender: TObject);
begin
  N51Click(self);
end;

procedure TIcqSearchForm.ListView1GetSubItemImage(Sender: TObject;
  Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
begin
  if Item.Checked then
  begin
    if SubItem = 5 then ImageIndex := 134;
  end
  else
  begin
    if SubItem = 5 then ImageIndex := 133;
  end;
end;

procedure TIcqSearchForm.ListView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ocw, fcw: integer;
begin
  if Button = mbLeft then
  begin
    if ListView1.Selected <> nil then
    begin
      ocw := ListView1.Column[0].Width + ListView1.Column[1].Width + ListView1.Column[2].Width +
        ListView1.Column[3].Width + ListView1.Column[4].Width + ListView1.Column[5].Width;
      fcw := ocw + ListView1.Column[6].Width;
      if (X > ocw) and (X < fcw) then SpeedButton2Click(Self);
    end;
  end;
end;

procedure TIcqSearchForm.N11Click(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    ICQ_ReqStatus0215(ListView1.Selected.Caption);
end;

procedure TIcqSearchForm.N21Click(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    SetClipboardText(Handle, ListView1.Selected.Caption);
end;

procedure TIcqSearchForm.N31Click(Sender: TObject);
{var
  i, ii, G, T: integer;
  NoCLG: boolean;
  Nick: string;}
begin
  {if ListView1.Selected <> nil then
  begin
    NoCLG := false;
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      for ii := 0 to RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1 do
      begin
        if RoasterForm.CategoryButtons1.Categories[i].Items[ii].UIN = ListView1.Selected.Caption then
        begin
          RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[ii]);
          RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[ii]);
          Exit;
        end;
      end;
    end;
    //
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].GroupId = 'NoCL' then NoCLG := true;
    end;
    if not NoCLG then
    begin
      RoasterForm.CategoryButtons1.Categories.Add.Caption := RoasterForm.NoInListGroupCaption;
      G := RoasterForm.CategoryButtons1.Categories.Count - 1;
      RoasterForm.CategoryButtons1.Categories.Items[G].GroupId := 'NoCL';
      RoasterForm.CategoryButtons1.Categories.Items[G].GroupCaption := RoasterForm.NoInListGroupCaption;
    end;
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories[i].GroupId = 'NoCL' then
      begin
        Nick := ListView1.Selected.SubItems.Strings[0];
        if Nick = EmptyStr then Nick := ListView1.Selected.Caption;
        RoasterForm.CategoryButtons1.Categories[i].Items.Add.Caption := Nick;
        T := RoasterForm.CategoryButtons1.Categories[i].Items.Count - 1;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].UIN := ListView1.Selected.Caption;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].GroupId := 'NoCL';
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Hint := '<b>' + ListView1.Selected.Caption + '</b>';
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Status := 34;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].ImageIndex := 34;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].ImageIndex1 := -1;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].ImageIndex2 := -1;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Msg := false;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].Auth := true;
        RoasterForm.CategoryButtons1.Categories[i].Items[T].QuoteMsg := EmptyStr;
        //RoasterForm.CategoryButtons1.Categories[i].Items[T].Index := 0;
        //
        RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[T]);
        RoasterForm.CategoryButtons1ButtonClicked(self, RoasterForm.CategoryButtons1.Categories[i].Items[T]);
      end;
    end;
  end;}
end;

procedure TIcqSearchForm.N41Click(Sender: TObject);
begin
  {if ListView1.Selected <> nil then
  begin
    if Assigned(IcqContactInfoForm) then
    begin
      if IcqContactInfoForm.ReqUIN <> ListView1.Selected.Caption then
      begin
        IcqContactInfoForm.ReqUIN := ListView1.Selected.Caption;
        IcqContactInfoForm.LoadUserUnfo();
      end;
      ShowWindow(IcqContactInfoForm.Handle, SW_RESTORE);
      IcqContactInfoForm.Show;
      IcqContactInfoForm.ButtonGroup1.ItemIndex := 0;
      IcqContactInfoForm.JvPageList1.ActivePageIndex := 0;
    end
    else
    begin
      IcqContactInfoForm := TIcqContactInfoForm.Create(self);
      IcqContactInfoForm.ReqUIN := ListView1.Selected.Caption;
      IcqContactInfoForm.LoadUserUnfo();
      IcqContactInfoForm.Show;
    end;
  end;}
end;

procedure TIcqSearchForm.N51Click(Sender: TObject);
//var
  //i: integer;
  //frmAddCnt: TIcqAddContactForm;
begin
  {frmAddCnt := TIcqAddContactForm.Create(nil);
  try
    for i := 0 to RoasterForm.CategoryButtons1.Categories.Count - 1 do
    begin
      if RoasterForm.CategoryButtons1.Categories.Items[i].GroupId = '0000' then Continue;
      if RoasterForm.CategoryButtons1.Categories.Items[i].GroupId = 'NoCL' then Continue;
      frmAddCnt.ComboBox1.Items.Add(RoasterForm.CategoryButtons1.Categories.Items[i].GroupCaption);
    end;
    if frmAddCnt.ComboBox1.Items.Count > 0 then frmAddCnt.ComboBox1.ItemIndex := 0;
    frmAddCnt.Edit1.Text := ListView1.Selected.Caption;
    frmAddCnt.Edit2.Text := ListView1.Selected.SubItems.Strings[0];
    frmAddCnt.ShowModal;
  finally
    FreeAndNil(frmAddCnt);
  end;}
end;

procedure TIcqSearchForm.PageControl1Change(Sender: TObject);
begin
  BitBtn4.Enabled := false;
  case PageControl1.ActivePageIndex of
    0: PageControl1.Height := PageControl1.ActivePage.Top + Panel3.Height + 10;
    1: PageControl1.Height := PageControl1.ActivePage.Top + Panel8.Height + 10;
    2: PageControl1.Height := PageControl1.ActivePage.Top + Panel10.Height + 10;
    3: PageControl1.Height := PageControl1.ActivePage.Top + Panel11.Height + 10;
    4:
      begin
        PageControl1.Height := PageControl1.ActivePage.Top + Panel12.Height + 10;
        BitBtn4.Enabled := true;
      end;
    5: PageControl1.Height := PageControl1.ActivePage.Top + Panel15.Top + Panel15.Height + 7;
  end;
end;

procedure TIcqSearchForm.SpeedButton1Click(Sender: TObject);
begin
  ListView1.Clear;
  Panel7.Caption := '0';
end;

procedure TIcqSearchForm.SpeedButton2Click(Sender: TObject);
begin
  if ListView1.Selected <> nil then
  begin
    if ListView1.Selected.Checked then Exit;
    if (Edit4.Tag = 1) or (Edit4.Text = EmptyStr) then Exit;
    if ICQ_Work_Phaze then
    begin
      ICQ_SendMessage_0406(ListView1.Selected.Caption, Edit4.Text, true);
      ListView1.Selected.Checked := true;
    end;
  end;
end;

end.

