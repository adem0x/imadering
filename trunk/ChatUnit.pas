{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit ChatUnit;

interface

{$REGION 'Uses'}

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Htmlview,
  StrUtils,
  Menus,
  ExtCtrls,
  StdCtrls,
  Buttons,
  CategoryButtons,
  VarsUnit,
  ShellApi,
  MMsystem,
  GIFImg,
  ComCtrls,
  ToolWin,
  JvSimpleXml;

type
  TChatForm = class(TForm)
    CloseTabPopupMenu: TPopupMenu;
    CloseTabAllOffline: TMenuItem;
    CloseTabAllNoCurrent: TMenuItem;
    CloseTabAll: TMenuItem;
    CenterChatFormPanel: TPanel;
    ChatCategoryButtons: TCategoryButtons;
    GroupSplitter: TSplitter;
    BottomChatFormPanel: TPanel;
    BottomToolsPanel: TPanel;
    MemoPanel: TPanel;
    MyAvatarPanelSpeedButton: TSpeedButton;
    MyAvatarPanel: TPanel;
    MyAvatarImage: TImage;
    HTMLMsg: THTMLViewer;
    ChatSplitter: TSplitter;
    HtmlPanel: TPanel;
    HTMLChatViewer: THTMLViewer;
    TopChatFormPanel: TPanel;
    HistoryShowPopupMenu: TPopupMenu;
    ShowAllHistory: TMenuItem;
    Show100History: TMenuItem;
    Show50History: TMenuItem;
    Show20History: TMenuItem;
    MemoPopupMenu: TPopupMenu;
    QRepMess: TMenuItem;
    CutMemo: TMenuItem;
    N1: TMenuItem;
    CopyMemo: TMenuItem;
    CopyAllMemo: TMenuItem;
    PasteMemo: TMenuItem;
    HtmlPopupMenu: TPopupMenu;
    ChatHTMLTextCopy: TMenuItem;
    ChatHTMLAllTextCopy: TMenuItem;
    ChatHTMLQText: TMenuItem;
    QmessPopupMenu: TPopupMenu;
    ContactAvatarPanel: TPanel;
    ContactAvatarImage: TImage;
    ChatToolBar: TToolBar;
    EnterKeyToolButton: TToolButton;
    ChatSettingsToolButton: TToolButton;
    TypingTextToolButton: TToolButton;
    ChatFontToolButton: TToolButton;
    TopToolsPanel: TPanel;
    TextLenPanel: TPanel;
    SmiliesSpeedButton: TSpeedButton;
    Bevel1: TBevel;
    QSpeedButton: TSpeedButton;
    QRepSpeedButton: TSpeedButton;
    Bevel2: TBevel;
    HistorySpeedButton: TSpeedButton;
    Bevel3: TBevel;
    NotifyPanel: TPanel;
    ClearChatSpeedButton: TSpeedButton;
    ContactMenuToolButton: TToolButton;
    ContactAvatarPanelSpeedButton: TSpeedButton;
    SendFileSpeedButton: TSpeedButton;
    SendMessageSpeedButtonDrop: TSpeedButton;
    SendMessageBitBtn: TBitBtn;
    CloseTabBitBtn: TBitBtn;
    CloseTabSpeedButtonDrop: TSpeedButton;
    SendPopupMenu: TPopupMenu;
    SendAllOnline: TMenuItem;
    SendAll: TMenuItem;
    TabPopupMenu: TPopupMenu;
    CloseChatTabMenu: TMenuItem;
    ConfPopupMenu: TPopupMenu;
    ChatUserPopupMenu: TPopupMenu;
    CloseLastChatMenu: TMenuItem;
    FileTransferPopupMenu: TPopupMenu;
    SendUpWapRu: TMenuItem;
    GtransSpeedButton: TSpeedButton;
    InputRichEdit: TRichEdit;
    ChatPageToolBar: TToolBar;
    TopInfoButtonPanel: TPanel;
    InfoContactSpeedButton: TSpeedButton;
    EditContactSpeedButton: TSpeedButton;
    TopInfoPanelR: TPanel;
    UIN_Panel: TPanel;
    Age_Panel: TPanel;
    TopInfoPanelL: TPanel;
    Name_Panel: TPanel;
    City_Panel: TPanel;
    UniqToolButton: TToolButton;
    FlagImage: TImage;
    ChatHTMLQTextTwitter: TMenuItem;
    GenderImage: TImage;
    SearchInGoogle: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MyAvatarPanelSpeedButtonClick(Sender: TObject);
    procedure ChatSplitterMoved(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChatCategoryButtonsContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure ChatCategoryButtonsHotButton(Sender: TObject; const Button: TButtonItem);
    procedure ChatCategoryButtonsButtonClicked(Sender: TObject; const Button: TButtonItem);
    procedure CloseTabAllClick(Sender: TObject);
    procedure CloseTabAllNoCurrentClick(Sender: TObject);
    procedure CloseTabAllOfflineClick(Sender: TObject);
    procedure ChatSettingsToolButtonClick(Sender: TObject);
    procedure EditContactSpeedButtonClick(Sender: TObject);
    procedure ShowAllHistoryClick(Sender: TObject);
    procedure InfoContactSpeedButtonClick(Sender: TObject);
    procedure ChatHTMLTextCopyClick(Sender: TObject);
    procedure HTMLChatViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MemoPopupMenuPopup(Sender: TObject);
    procedure PasteMemoClick(Sender: TObject);
    procedure ChatHTMLQTextClick(Sender: TObject);
    procedure CutMemoClick(Sender: TObject);
    procedure CopyMemoClick(Sender: TObject);
    procedure CopyAllMemoClick(Sender: TObject);
    procedure ChatHTMLAllTextCopyClick(Sender: TObject);
    procedure HtmlPopupMenuPopup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ChatFontToolButtonClick(Sender: TObject);
    procedure HTMLChatViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
    procedure SmiliesSpeedButtonClick(Sender: TObject);
    procedure QSpeedButtonClick(Sender: TObject);
    procedure HistorySpeedButtonClick(Sender: TObject);
    procedure HistorySpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ClearChatSpeedButtonClick(Sender: TObject);
    procedure ContactAvatarPanelSpeedButtonClick(Sender: TObject);
    procedure SendMessageBitBtnClick(Sender: TObject);
    procedure SendMessageSpeedButtonDropClick(Sender: TObject);
    procedure CloseTabBitBtnClick(Sender: TObject);
    procedure CloseTabSpeedButtonDropClick(Sender: TObject);
    procedure SendAllOnlineClick(Sender: TObject);
    procedure SendAllClick(Sender: TObject);
    procedure SendFileSpeedButtonClick(Sender: TObject);
    procedure TypingTextToolButtonClick(Sender: TObject);
    procedure CloseChatTabMenuClick(Sender: TObject);
    procedure ContactMenuToolButtonClick(Sender: TObject);
    procedure ContactMenuToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure HTMLChatViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SendFileSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure QRepSpeedButtonClick(Sender: TObject);
    procedure QRepSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SendUpWapRuClick(Sender: TObject);
    procedure HTMLChatViewerParseEnd(Sender: TObject);
    procedure GtransSpeedButtonClick(Sender: TObject);
    procedure InputRichEditChange(Sender: TObject);
    procedure InputRichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InputRichEditKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure UniqToolButtonClick(Sender: TObject);
    procedure Name_PanelClick(Sender: TObject);
    procedure UIN_PanelClick(Sender: TObject);
    procedure GtransSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ChatHTMLQTextTwitterClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure HTMLChatViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SearchInGoogleClick(Sender: TObject);

  private
    { Private declarations }
    f_t, f_l, f_h, f_w: integer;
    HTMLStyle: string;
    LastClick: Tdatetime;
    ButtonInd: Integer;
    TabMenuToolButton: TToolButton;
    procedure QuickMessClick(Sender: TObject);

  public
    { Public declarations }
    OutMessIndex: LongInt;
    ChatButton: TButtonItem;
    User_Proto: string;
    User_Avatar_Hash: string;
    procedure TranslateForm;
    procedure CheckMessage_ClearTag(var Msg: string);
    procedure AddChatText(Nick_Time, Mess_Text: string; MessIn: Boolean = False);
    procedure CreateFastReplyMenu;
    function AddMessInActiveChat(CNick, CPopMsg, CId, CMsgD, CMess: string): Boolean;
    procedure CreateNewChat(CButton: TToolButton);
    procedure RemoveChatPageButton(ChatButton: TToolButton);
    procedure Save_Input_Text;
  end;

{$ENDREGION}

var
  ChatForm: TChatForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  SmilesUnit,
  SettingsUnit,
  IcqProtoUnit,
  HistoryUnit,
  ContactInfoUnit,
  UtilsUnit,
  JabberProtoUnit,
  FileTransferUnit,
  GtransUnit,
  MraProtoUnit,
  UniqUnit,
  OverbyteIcsUrl,
  MemoUnit,
  RosterUnit;

{$ENDREGION}
{$REGION 'MyConst'}

const
  C_ChatForm = 'chat_form';
  C_ChatFormSP = 'splits';
  C_ChatFormSE = 'send_enter';
  C_ChatFormST = 'typing_notify';
  C_ChatFormKS = 'key_sound';
  C_ChatFormAP = 'avatar_panels';

{$ENDREGION}
{$REGION 'CreateNewChat'}

procedure TChatForm.CreateNewChat(CButton: TToolButton);
var
  UIN, HistoryFile, Doc, HistoryText, ImageFile, MyAvatarUIN: string;
  JvXML: TJvSimpleXml;
  Get_Node, XML_Node: TJvSimpleXmlElem;
begin
  // Применяем параметры нового чата
  UIN := CButton.HelpKeyword;
  if CButton.Margins.Left = 1 then
    User_Proto := C_Icq
  else if CButton.Margins.Left = 2 then
    User_Proto := C_Jabber
  else if CButton.Margins.Left = 3 then
    User_Proto := C_Mra;
  // Ставим учётную запись контакта в информационное поле
  UIN_Panel.Caption := UrlDecode(UIN);
  // Очищаем поле ввода
  InputRichEdit.Clear;
  // Ищем эту запись в Ростере и помечаем что сообщения прочитаны и получаем параметры
  Get_Node := RosterGetItem(User_Proto, C_Contact + C_SS, C_Login, UIN);
  if Get_Node <> nil then
  begin
    // Снимаем метку о непрочитанном сообщении
    RosterUpdateProp(Get_Node, C_Mess, EmptyStr);
    CButton.Tag := Get_Node.Properties.IntValue(C_Status);
    CButton.Hint := URLDecode('');
    User_Avatar_Hash := Hex2Text('');
    // Загружаем файл истории сообщений
    if User_Proto = C_Icq then
      HistoryFile := V_ProfilePath + C_HistoryFolder + User_Proto + C_BN + ICQ_LoginUIN + C_BN + UrlDecode(UIN) + C_Htm_Ext
    else if User_Proto = C_Jabber then
      HistoryFile := V_ProfilePath + C_HistoryFolder + User_Proto + C_BN + Jabber_LoginUIN + C_BN + UrlDecode(UIN) + C_Htm_Ext
    else if User_Proto = C_Mra then
      HistoryFile := V_ProfilePath + C_HistoryFolder + User_Proto + C_BN + MRA_LoginUIN + C_BN + UrlDecode(UIN) + C_Htm_Ext;
    if FileExists(HistoryFile) then
    begin
      // Проверяем создавать или нет архив истории
      if CreateHistoryArhive(HistoryFile) then
      begin
        // Если сжатие истории закончено успешно, то удаляем файл истории
        DeleteFile(HistoryFile);
        // Сообщаем о создании архива и записываем это в новый файл для памятки
        HistoryText := Format(C_HistoryInfo, [Lang_Vars[66].L_S]);
        SaveTextInHistory(HistoryText, HistoryFile);
      end
      else
        HistoryText := ReadFromFile(HistoryFile, true);
    end;
    // Отображаем историю в чате
    if HistoryText <> EmptyStr then
    begin
      // Очищаем чат от другой истории
      HTMLChatViewer.Clear;
      // Добавляем стили
      Doc := HTMLStyle;
      // Загружаем из файла истории указанное количесво сообщений
      Doc := Doc + TailLineTail(HistoryText, 5);
      if not V_TextSmilies then
        CheckMessage_Smilies(Doc);
      SetLength(Doc, Length(Doc) - 6);
      Doc := Doc + C_HR;
      LoadHTMLStrings(HTMLChatViewer, Doc);
    end
    else
    begin
      // Очищаем чат от другой истории
      HTMLChatViewer.Clear;
      // Добавляем стили
      Doc := HTMLStyle;
      LoadHTMLStrings(HTMLChatViewer, Doc);
    end;
    // Ставим имя и фамилию в информационное поле
    Name_Panel.Caption := '';
    // Ставим город и возраст в информационное поле
    City_Panel.Caption := '';
    Age_Panel.Caption := '';
    // Ставим флаг страны
    ImageFile := V_MyPath + C_FlagsFolder + GetFlagFile(V_MyPath + C_FlagsFolder, '', EmptyStr);
    if FileExists(ImageFile) then
      FlagImage.Picture.LoadFromFile(ImageFile)
    else
      FlagImage.Picture.Assign(nil);
    // Ставим иконку пола
    ImageFile := V_MyPath + C_IconsFolder + V_CurrentIcons + C_SN + '' + C_GIF_Ext;
    if FileExists(ImageFile) then
      GenderImage.Picture.LoadFromFile(ImageFile)
    else
      GenderImage.Picture.Assign(nil);
    // Ставим клиент в информационное поле
    if '' <> EmptyStr then
    begin
      NotifyPanel.Caption := '';
      NotifyPanel.Font.Color := ClWindowText;
      NotifyPanel.Hint := '';
    end
    else
    begin
      NotifyPanel.Caption := '...';
      NotifyPanel.Font.Color := ClWindowText;
    end;
    // Выводим текст доп. статуса и иконку доп статуса
    if '' <> EmptyStr then
    begin
      Doc := UTF8ToString(HTMLChatViewer.DocumentSource);
      // Если есть и иконка доп. статуса
      if '' <> '-1' then
        Doc := Doc + C_HistoryX;
      Doc := Doc + Format(C_HistoryInfo, [URLDecode('')]);
      LoadHTMLStrings(HTMLChatViewer, Doc);
      // Преобразуем и подгружаем иконку доп. статуса
      if '' > '-1' then
      begin
        V_XStatusImg.Assign(nil);
        MainForm.AllImageList.GetBitmap(StrToInt('0'), V_XStatusImg);
        V_XStatusMem.Clear;
        V_XStatusImg.SaveToStream(V_XStatusMem);
        HTMLChatViewer.ReplaceImage(C_XX, V_XStatusMem);
      end;
    end;
    // Ставим каретку в самый низ текста
    HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
    HTMLChatViewer.CaretPos := Length(Doc);
    // Выставляем уникальные параметры для этого контакта
    GtransSpeedButton.Down := False;
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + C_XML_Ext) then
        begin
          LoadFromFile(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + C_XML_Ext);
          if Root <> nil then
          begin
            // Подгружаем параметры перевода для этого контакта
            {XML_Node := Root.Items.ItemNamed[C_Gtrans];
            if XML_Node <> nil then
            begin
              GtransSpeedButton.Down := XML_Node.BoolValue;
            end;}

            // Подгружаем свою аватарку если установлена

            // Вставляем ранее набранный текст в поле набора
            XML_Node := Root.Items.ItemNamed[C_OutMess];
            if XML_Node <> nil then
              InputRichEdit.Text := UrlDecode(XML_Node.Value);
          end;
        end;
      end;
    finally
      JvXML.Free;
    end;
  end;
  if Name_Panel.Caption = EmptyStr then
    Name_Panel.Caption := CButton.Caption;
  // Ставим курсор в поле ввода после последнего символа
  InputRichEdit.SelStart := InputRichEdit.GetTextLen;
  // Ставим фокус в поле ввода текста
  if (InputRichEdit.CanFocus) and (ChatForm.Visible) then
    InputRichEdit.SetFocus;
  // Сбрасываем флаг модификации поля ввода
  InputRichEdit.Modified := False;
  // Удаляем отметку о сообщении из списка очереди входящих сообщений
  DellcIdInMessList(UIN);
  // Сбрасываем иконку сообщения в этой закладке
  CButton.ImageIndex := CButton.Tag;
  // Обновляем КЛ
  UpdateFullCL;
  // Загружаем аватар собеседника
  try
    // JPG
    if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_JPG_Ext) then
      ContactAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_JPG_Ext)
        // GIF
    else if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_GIF_Ext) then
      ContactAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_GIF_Ext)
        // BMP
    else if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_BMP_Ext) then
      ContactAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_BMP_Ext)
        // PNG
    else if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_PNG_Ext) then
      ContactAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + UIN_Panel.Caption + C_PNG_Ext)
    else
    begin
      ContactAvatarImage.Picture.Assign(nil);
      ContactAvatarImage.Picture.Assign(V_NoAvatar.Picture);
    end;
  except
    ContactAvatarImage.Picture.Assign(nil);
    ContactAvatarImage.Picture.Assign(V_NoAvatar.Picture);
  end;
  try
    // Подгружаем мои аватар
    if User_Proto = C_Icq then
      MyAvatarUIN := ICQ_LoginUIN
    else if User_Proto = C_Jabber then
      MyAvatarUIN := Jabber_JID
    else if User_Proto = C_Mra then
      MyAvatarUIN := MRA_LoginUIN;
    // JPG
    if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_JPG_Ext) then
      MyAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_JPG_Ext)
        // GIF
    else if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_GIF_Ext) then
      MyAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_GIF_Ext)
        // BMP
    else if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_BMP_Ext) then
      MyAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_BMP_Ext)
        // PNG
    else if FileExists(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_PNG_Ext) then
      MyAvatarImage.Picture.LoadFromFile(V_ProfilePath + C_AvatarFolder + User_Proto + C_BN + MyAvatarUIN + C_PNG_Ext)
    else
    begin
      MyAvatarImage.Picture.Assign(nil);
      MyAvatarImage.Picture.Assign(V_NoAvatar.Picture);
    end;
  except
    ContactAvatarImage.Picture.Assign(nil);
    ContactAvatarImage.Picture.Assign(V_NoAvatar.Picture);
  end;
  {else
    begin
    if (Length(UserAvatarHash) = 32) and (ICQ_Avatar_Work_Phaze) then
    begin
    ICQ_GetAvatarImage(UIN, UserAvatarHash);
    end;
    if (Length(UserAvatarHash) = 32) and (not AvatarServiceDisable) and (not ICQ_Avatar_Connect_Phaze) and
    (not ICQ_Avatar_Work_Phaze) and (ICQ_Work_Phaze) then
    begin
    ICQ_Avatar_Connect_Phaze := true;
    ICQ_Avatar_Work_Phaze := false;
    ICQ_GetAvatar_UIN := UIN;
    ICQ_GetAvatar_Hash := UserAvatarHash;
    ICQ_GetAvatarBosServer;
    end;
    //SearchAvatarTimer.Enabled := true;
    ContactImage.Picture.Assign(nil);
    ContactImage.Picture.Assign(NoAvatar.Picture);
    end;}

end;

{$ENDREGION}
{$REGION 'AddMessInActiveChat'}

function TChatForm.AddMessInActiveChat(CNick, CPopMsg, CId, CMsgD, CMess: string): Boolean;
var
  ChatTab: TToolButton;
begin
  Result := False;
  if Visible then
  begin
    // Если открыт текущий чат с этим контактом
    if UIN_Panel.Caption = UrlDecode(CId) then
    begin
      // Если не включены текстовые смайлы, то форматируем сообщение под смайлы
      if not V_TextSmilies then
        CheckMessage_Smilies(CMess);
      // Добавляем сообщение в текущий чат
      AddChatText(CMsgD, CMess, True);
      // Прокручиваем чат в самый конец
      HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
      // Если окно сообщений активно, то выходим
      if ChatForm.Active then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
  // Если в списке очереди входящих сообщений нет этого контакта, то добавляем его туда
  if V_InMessList.IndexOf(CId) = -1 then
    V_InMessList.Add(CId);
  // Играем звук входящего сообщения
  ImPlaySnd(2);
  // Показываем всплывашку с сообщением
  DAShow(CNick, CPopMsg, CId, 165, 1, 0);
  // Ставим иконку с сообщением на закладке в чате
  ChatTab := ReqChatPage(CId);
  if ChatTab <> nil then
    ChatTab.ImageIndex := 165;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.QRepSpeedButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  PopUp_Top(QRepSpeedButton, QmessPopupMenu);
end;

procedure TChatForm.QRepSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем меню над этим элементом
  if Button = MbRight then
    PopUp_Top(QRepSpeedButton, QmessPopupMenu);
end;

procedure TChatForm.QSpeedButtonClick(Sender: TObject);
begin
  {// Достаём из Ростера последнее сообщение от этого контакта
  RosterItem := RosterForm.ReqRosterItem(InfoPanel2.Caption);
  if RosterItem <> nil then
    begin
      if RosterItem.SubItems[15] <> EmptyStr then
        InputRichEdit.Lines.Add('> ' + URLDecode(RosterItem.SubItems[15]));
    end;}
end;

procedure TChatForm.QuickMessClick(Sender: TObject);
begin
  // Вставляем в поле ввода текст из меню быстрых ответов
  if InputRichEdit.SelText <> EmptyStr then
    InputRichEdit.SelText := TMenuItem(Sender).Caption
  else if InputRichEdit.Text <> EmptyStr then
    InputRichEdit.SelText := ' ' + TMenuItem(Sender).Caption
  else
    InputRichEdit.SelText := TMenuItem(Sender).Caption;
end;

{$ENDREGION}
{$REGION 'CreateFastReplyMenu'}

procedure TChatForm.CreateFastReplyMenu;
var
  I: Integer;
  List: TStringList;
begin
  // Создаём временный лист строк
  List := TStringList.Create;
  // Если файл с быстрыми ответами найден, то загружаем его
  if FileExists(V_ProfilePath + C_ReplyFileName) then
    List.LoadFromFile(V_ProfilePath + C_ReplyFileName)
  else
  begin
    // Иначе добавляем быстрые ответы по умолчанию
    List.Add(Parse(';', Lang_Vars[43].L_S, 1));
    List.Add(Parse(';', Lang_Vars[43].L_S, 2));
    List.Add(Parse(';', Lang_Vars[43].L_S, 3));
  end;
  try
    // Добаляем быстрые ответы в раздел меню поля ввода текста
    with MemoPopupMenu.Items.Items[0] do
    begin
      for I := 0 to List.Count - 1 do
      begin
        if List.Strings[I] <> EmptyStr then
        begin
          Add(NewItem(List.Strings[I], 0, False, True, QuickMessClick, 0, 'MenuItem' + IntToStr(I)));
          // Назначаем иконку для пункта меню
          Items[I].ImageIndex := 157;
        end;
      end;
    end;
    // Добавляем быстрые ответы в меню быстрых ответов
    with QmessPopupMenu.Items do
    begin
      for I := 0 to List.Count - 1 do
      begin
        if List.Strings[I] <> EmptyStr then
        begin
          Add(NewItem(List.Strings[I], 0, False, True, QuickMessClick, 0, 'MenuItem' + IntToStr(I)));
          // Назначаем иконку для пункта меню
          Items[I].ImageIndex := 157;
        end;
      end;
    end;
  finally
    List.Free;
  end;
end;

{$ENDREGION}
{$REGION 'ChatCategoryButtonsButton'}

procedure TChatForm.ChatCategoryButtonsButtonClicked(Sender: TObject; const Button: TButtonItem);
var
  Diff: Tdatetime;
begin
  // Проверяем двойной клик
  Diff := Now - LastClick;
  LastClick := Now;
  if (Diff < C_DblClickTime) and (ButtonInd = Button.index) then
  begin
    // В будущем вставка ника в поле ввода для jabber конференций

    Exit;
  end;
  ButtonInd := Button.index;
end;

procedure TChatForm.ChatCategoryButtonsContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := True;
  // Выделяем выбранный контакт
  ChatCategoryButtons.FocusedItem := nil;
  ChatCategoryButtons.SelectedItem := ChatButton;
  if ChatButton <> nil then
  begin
    // Параметры меню контактов в конференции

  end;
end;

procedure TChatForm.ChatCategoryButtonsHotButton(Sender: TObject; const Button: TButtonItem);
begin
  // Запоминаем над какой кнопкой происходит действие
  if Button <> nil then
    ChatButton := Button
  else
    ChatButton := nil;
end;

{$ENDREGION}
{$REGION 'CheckMessage_ClearTag'}

procedure TChatForm.CheckMessage_ClearTag(var Msg: string);
var
  Doc: string;
begin
  // Вырезаем таким образом все левые тэги из сообщения оставляя чистый текст
  HTMLMsg.Clear;
  Doc := Msg;
  LoadHTMLStrings(HTMLMsg, Doc);
  HTMLMsg.SelectAll;
  Msg := HTMLMsg.SelText;
  Msg := ReplaceStr(Msg, #$A0, C_BN);
end;

{$ENDREGION}
{$REGION 'AddChatText'}

procedure TChatForm.AddChatText(Nick_Time, Mess_Text: string; MessIn: Boolean = False);
var
  Doc: string;
begin
  Doc := UTF8ToString(HTMLChatViewer.DocumentSource);
  if MessIn then
    Doc := Doc + '<IMG NAME="i" SRC="./Icons/' + V_CurrentIcons + '/inmess.gif" ALIGN="ABSMIDDLE" BORDER="0"><span class=b> ' + Nick_Time + '</span><br>'
  else
    Doc := Doc + '<IMG NAME="o' + IntToStr(OutMessIndex) + '" SRC="./Icons/' + V_CurrentIcons + '/outmess1.gif" ALIGN="ABSMIDDLE" BORDER="0"><span class=a> ' + Nick_Time + '</span><br>';
  Doc := Doc + '<span class=c>' + Mess_Text + '</span><br><br>';
  LoadHTMLStrings(HTMLChatViewer, Doc);
end;

{$ENDREGION}
{$REGION 'CloseTab'}

procedure TChatForm.CloseTabAllOfflineClick(Sender: TObject);
var
  I, T: Integer;
begin
  // Если вкладки есть, то закрываем те что со статусом оффлайн
  with ChatPageToolBar do
  begin
    // Сканируем вкладки
    T := 0;
    for I := 0 to ButtonCount - 1 do
    begin
      case Buttons[T].Tag of
        9, 23, 25, 30, 41, 42, 80, 214:
          begin
            RemoveChatPageButton(Buttons[T]);
            Dec(T);
            // Прорисовываем интерфейс
            Update;
          end;
      end;
      Inc(T);
    end;
    // Испраляем глюк тулбара закладок чата (те кто писал ComCtrls.pas - пиздюки)
    Realign;
    // Если вкладки все закрыты, то закрываем окно чата
    if ButtonCount = 0 then
      ChatForm.Hide
    else
    begin
      Buttons[0].Down := True;
      CreateNewChat(Buttons[0]);
    end;
  end;
end;

procedure TChatForm.CloseTabAllNoCurrentClick(Sender: TObject);
var
  I, T: Integer;
begin
  // Если вкладки присутствуют, то закрываем все кроме текущей
  with ChatPageToolBar do
  begin
    if ButtonCount > 1 then
    begin
      T := 0;
      for I := 0 to ButtonCount - 1 do
      begin
        if not Buttons[T].Down then
        begin
          RemoveChatPageButton(Buttons[T]);
          Dec(T);
          // Прорисовываем интерфейс
          Update;
        end;
        Inc(T);
      end;
    end;
    // Испраляем глюк тулбара закладок чата (те кто писал ComCtrls.pas - пиздюки)
    Realign;
  end;
end;

procedure TChatForm.CloseChatTabMenuClick(Sender: TObject);
begin
  // Закрываем вкладку над которой было вызвано меню
  if (TabMenuToolButton <> nil) and (TabMenuToolButton is TToolButton) then
  begin
    if TabMenuToolButton.Down then
      CloseTabBitBtnClick(nil)
    else
      RemoveChatPageButton(TabMenuToolButton);
  end;
end;

procedure TChatForm.CloseTabAllClick(Sender: TObject);
begin
  // Закрываем окно чата
  Hide;
  // Закрываем все вкладки чата
  while ChatPageToolBar.ButtonCount > 0 do
    RemoveChatPageButton(ChatPageToolBar.Buttons[0]);
end;

{$ENDREGION}
{$REGION 'QText'}

procedure TChatForm.ChatHTMLQTextClick(Sender: TObject);
var
  I: Integer;
begin
  // Цитируем выделенный текст в поле ввода и подставляем в начало каждой строки символ >
  with TStringList.Create do
  begin
    try
      Text := HTMLChatViewer.SelText;
      if (Count > 0) then
      begin
        for I := 0 to Count - 1 do
          Strings[I] := '> ' + Strings[I];
        InputRichEdit.Lines.Add(Text);
      end;
    finally
      Free;
    end;
  end;
  if InputRichEdit.CanFocus then
    InputRichEdit.SetFocus;
end;

{$ENDREGION}
{$REGION 'QTextTwitter'}

procedure TChatForm.ChatHTMLQTextTwitterClick(Sender: TObject);
var
  S: string;
begin
  // Цетируем выделенный текст в twitter
  S := HTMLChatViewer.SelText;
  // Ограничиваем длинну текста до 140 символов
  SetLength(S, 140);
  // Если форма не существует, то создаём её
  if not Assigned(MemoForm) then
    Application.CreateForm(TMemoForm, MemoForm);
  // Делаем запрос в форме на обновление программы
  MemoForm.PostInTwitter(Trim(S));
  // Отображаем окно
  XShowForm(MemoForm);
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.CopyMemoClick(Sender: TObject);
begin
  // Копируем выделенный текст из поля ввода в буфер обмена
  InputRichEdit.CopyToClipboard;
end;

procedure TChatForm.CopyAllMemoClick(Sender: TObject);
begin
  // Копируем весь текст из поля ввода в буфер обмена
  InputRichEdit.SelectAll;
  InputRichEdit.CopyToClipboard;
end;

procedure TChatForm.PasteMemoClick(Sender: TObject);
begin
  // Вставляем в поле ввода текст из буфера обмена
  InputRichEdit.PasteFromClipboard;
end;

procedure TChatForm.SearchInGoogleClick(Sender: TObject);
var
  S: string;
begin
  // Делаем поиск выделенного текста в Google
  S := UrlEncode(Trim(HTMLChatViewer.SelText));
  OpenURL(Format(C_GoogleSearch, [S]));
end;

procedure TChatForm.SendAllClick(Sender: TObject);
begin
  //
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TChatForm.SendAllOnlineClick(Sender: TObject);
begin
  //
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TChatForm.SendFileSpeedButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  PopUp_Top(SendFileSpeedButton, FileTransferPopupMenu);
end;

procedure TChatForm.SendFileSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем меню над этим элементом
  if Button = MbRight then
    PopUp_Top(SendFileSpeedButton, FileTransferPopupMenu);
end;

procedure TChatForm.SendMessageBitBtnClick(Sender: TObject);
var
  K: Char;
begin
  // Вызываем событие нажатия клавиши интер для поля ввода текста
  K := #13;
  InputRichEditKeyPress(Sender, K);
  // Ставим фокус курсора в поле ввода
  if (InputRichEdit.CanFocus) and (ChatForm.Visible) then
    InputRichEdit.SetFocus;
end;

procedure TChatForm.MyAvatarPanelSpeedButtonClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  // Прячем панель с аватаркой
  GetCursorPos(FCursor);
  if MyAvatarPanelSpeedButton.NumGlyphs = 1 then
  begin
    MyAvatarPanel.Width := 0;
    MyAvatarPanelSpeedButton.NumGlyphs := 4;
    SetCursorPos(FCursor.X + 68, FCursor.Y);
  end
  else
  begin
    MyAvatarPanel.Width := 68;
    MyAvatarPanelSpeedButton.NumGlyphs := 1;
    SetCursorPos(FCursor.X - 68, FCursor.Y);
  end;
  // Играем звук открытия окна
  ImPlaySnd(8);
end;

procedure TChatForm.InfoContactSpeedButtonClick(Sender: TObject);
begin
  // Открываем окно информации о контакте
  if not Assigned(ContactInfoForm) then
    Application.CreateForm(TContactInfoForm, ContactInfoForm);
  // Присваиваем UIN инфу которого хотим смотреть
  ContactInfoForm.ReqUIN := UIN_Panel.Caption;
  ContactInfoForm.ReqProto := User_Proto;
  // Загружаем информацию о нем
  ContactInfoForm.LoadUserUnfo;
  // Отображаем окно на передний план
  XShowForm(ContactInfoForm);
end;

procedure TChatForm.Name_PanelClick(Sender: TObject);
begin
  // Копируем в буфер обмена ник или имя и отчество контакта
  SetClipboardText(Name_Panel.Caption);
end;

procedure TChatForm.UIN_PanelClick(Sender: TObject);
begin
  // Копируем в буфер обмена ник или имя и отчество контакта
  SetClipboardText(UIN_Panel.Caption);
end;

procedure TChatForm.EditContactSpeedButtonClick(Sender: TObject);
begin
  //
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TChatForm.ChatSplitterMoved(Sender: TObject);
begin
  // Перерисовываем компоненты аватара
  MyAvatarPanelSpeedButton.Refresh;
  MyAvatarPanel.Refresh;
end;

procedure TChatForm.ChatFontToolButtonClick(Sender: TObject);
begin
  //
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TChatForm.ChatSettingsToolButtonClick(Sender: TObject);
begin
  // Отображаем окно настроек в разделе окно сообщений
  if Assigned(SettingsForm) then
  begin
    with SettingsForm do
    begin
      // Отображаем окно
      if Visible then
        ShowWindow(Handle, SW_RESTORE);
      Show;
      // Активируем раздел
      SettingsJvPageList.ActivePageIndex := 2;
      SettingButtonGroup.ItemIndex := 2;
    end;
  end;
end;

procedure TChatForm.ToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Запоминаем таб кнопку над которой вызвано меню
  if (Sender is TToolButton) then
    TabMenuToolButton := (Sender as TToolButton);
end;
{$ENDREGION}
{$REGION 'Save_Input_Text'}

procedure TChatForm.Save_Input_Text;
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Сохраняем набранный текст для этой вкладки
  if (UIN_Panel.Caption <> EmptyStr) and (InputRichEdit.Modified) then
  begin
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + C_XML_Ext) then
          LoadFromFile(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + C_XML_Ext);
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_OutMess];
          if XML_Node = nil then
            XML_Node := Root.Items.Add(C_OutMess);
          XML_Node.Value := URLEncode(InputRichEdit.Text);
        end;
        // Записываем файл
        SaveToFile(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + C_XML_Ext);
      end;
    finally
      JvXML.Free;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'ToolButtonMouse Events'}

procedure TChatForm.ToolButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Определяем какой клавишей был выполнен клик по закладке
  if (Sender is TToolButton) then
  begin
    case Button of
      MbLeft: // Применяем параметры чата с этим контактом
        begin
          // Запоминаем кнопку на которой было нажатие
          TabMenuToolButton := (Sender as TToolButton);
          // Сохраняем набранный текст для этой вкладки
          Save_Input_Text;
        end;
      MbMiddle: // Закрываем эту закладку
        if (Sender as TToolButton).Down then
          CloseTabBitBtnClick(nil)
        else
          RemoveChatPageButton((Sender as TToolButton));
    end;
  end;
end;

procedure TChatForm.ToolButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Определяем какой клавишей был выполнен клик по закладке
  if (Sender is TToolButton) then
  begin
    case Button of
      MbLeft: // Применяем параметры чата с этим контактом
        begin
          // Открываем новый чат
          if TabMenuToolButton = (Sender as TToolButton) then
            CreateNewChat((Sender as TToolButton));
        end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TChatForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
  // Другое
  CloseTabBitBtn.Caption := Lang_Vars[8].L_S;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.TypingTextToolButtonClick(Sender: TObject);
begin
  ShowMessage(Lang_Vars[6].L_S);
end;

procedure TChatForm.UniqToolButtonClick(Sender: TObject);
begin
  // Открываем окно уникальных настроек контакта
  if not Assigned(UniqForm) then
    UniqForm := TUniqForm.Create(Self);
  if User_Proto = C_Icq then
    UniqForm.AccountPanel.Caption := Lang_Vars[20].L_S + C_BN + UpperCase(C_Icq) + C_TN + UIN_Panel.Caption
  else if User_Proto = C_Jabber then
    UniqForm.AccountPanel.Caption := Lang_Vars[20].L_S + C_BN + C_Jabber + C_TN + UIN_Panel.Caption;
  // Отображаем окно
  XShowForm(UniqForm);
end;

{$ENDREGION}
{$REGION 'SendUpWapRu'}

procedure TChatForm.SendUpWapRuClick(Sender: TObject);
var
  Fsize: LongInt;
begin
  if NotProtoOnline(User_Proto) then
    Exit;
  // Открываем форму отправки файлов
  if not Assigned(FileTransferForm) then
    FileTransferForm := TFileTransferForm.Create(Self);
  // Присваиваем переменную способа передачи
  with FileTransferForm do
  begin
    // Проверяем закончена ли предыдушая сессия передачи файла
    if CancelBitBtn.Enabled then
    begin
      XShowForm(FileTransferForm);
      DAShow(Lang_Vars[18].L_S, Lang_Vars[93].L_S, EmptyStr, 133, 3, 0);
      Exit;
    end;
    // Выбираем способ передачи файла
    Tag := (Sender as TMenuItem).Tag; // 1 - UpWap.ru
    TopInfoPanel.Caption := Lang_Vars[88].L_S + Name_Panel.Caption;
    T_UIN := UIN_Panel.Caption;
    T_UserType := User_Proto;
    // Открываем диалог выбора файла для передачи
    if MainForm.SendFileOpenDialog.Execute then
    begin
      T_FilePath := MainForm.SendFileOpenDialog.FileName;
      T_FileName := GetFileName(MainForm.SendFileOpenDialog.FileName);
      FileNamePanel.Caption := C_BN + T_FileName;
      FileNamePanel.Hint := T_FileName;
      // Вычисляем размер файла
      Fsize := GetFileSize(MainForm.SendFileOpenDialog.FileName);
      if Fsize > 1000000 then
        FileSizePanel.Caption := FloatToStrF(Fsize / 1000000, FfFixed, 18, 3) + ' MB'
      else
        FileSizePanel.Caption := FloatToStrF(Fsize / 1000, FfFixed, 18, 3) + ' KB';
      // Отображаем окно
      XShowForm(FileTransferForm);
    end;
  end;
end;

{$ENDREGION}
{$REGION 'FormActivate'}

procedure TChatForm.FormActivate(Sender: TObject);
var
  I: Integer;
begin
  // Активируем чат с активной закладкой в чате
  with ChatPageToolBar do
  begin
    for I := 0 to ButtonCount - 1 do
    begin
      if Buttons[I].Down then
      begin
        CreateNewChat(Buttons[I]);
        Break;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TChatForm.FormCreate(Sender: TObject);
var
  AvatarFile, OutMessage2File, OutMessage3File: string;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      // Загружаем настройки
      if FileExists(V_ProfilePath + C_SettingsFileName) then
      begin
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_ChatForm];
          if XML_Node <> nil then
          begin
            // Загружаем позицию окна
            Top := XML_Node.Properties.IntValue(C_FT);
            Left := XML_Node.Properties.IntValue(C_FL);
            Height := XML_Node.Properties.IntValue(C_FH);
            Width := XML_Node.Properties.IntValue(C_FW);
            f_t := Top;
            f_l := Left;
            f_h := Height;
            f_w := Width;
            if XML_Node.Properties.BoolValue(C_FM, False) then
              WindowState := wsMaximized;
            // Определяем не находится ли окно за пределами экрана
            FormSetInWorkArea(Self);
            // Загружаем позицию сплитеров
            Sub_Node := XML_Node.Items.ItemNamed[C_ChatFormSP];
            if Sub_Node <> nil then
            begin
              BottomChatFormPanel.Height := Sub_Node.Properties.IntValue('s1', 130);
              ChatCategoryButtons.Width := Sub_Node.Properties.IntValue('s2', 130);
            end;
            // Загружаем "отправлять по интер"
            Sub_Node := XML_Node.Items.ItemNamed[C_ChatFormSE];
            if Sub_Node <> nil then
              EnterKeyToolButton.Down := Sub_Node.BoolValue;
            // Загружаем отправлять отчёт о печати текста
            Sub_Node := XML_Node.Items.ItemNamed[C_ChatFormST];
            if Sub_Node <> nil then
              TypingTextToolButton.Down := Sub_Node.BoolValue;
            // Загружаем состояние панелей аватар
            Sub_Node := XML_Node.Items.ItemNamed[C_ChatFormAP];
            if Sub_Node <> nil then
            begin
              ContactAvatarPanel.Width := Sub_Node.Properties.IntValue('a1', 68);
              if ContactAvatarPanel.Width = 0 then
              begin
                ContactAvatarPanelSpeedButton.Left := 0;
                ContactAvatarPanelSpeedButton.NumGlyphs := 1;
              end;
              MyAvatarPanel.Width := Sub_Node.Properties.IntValue('a2', 68);
              if MyAvatarPanel.Width = 0 then
                MyAvatarPanelSpeedButton.NumGlyphs := 4;
            end;
          end;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  // Присваиваем окну и кнопкам иконки
  MainForm.AllImageList.GetIcon(163, Icon);
  MainForm.AllImageList.GetBitmap(156, SmiliesSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(216, QSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(157, QRepSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(147, HistorySpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(149, SendFileSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(159, ClearChatSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(178, InfoContactSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(141, EditContactSpeedButton.Glyph);
  MainForm.AllImageList.GetBitmap(166, SendMessageBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(158, CloseTabBitBtn.Glyph);
  MainForm.AllImageList.GetBitmap(246, GtransSpeedButton.Glyph);
  // Создаём хранитель картинки пустой аватары для быстрого её отображения
  V_NoAvatar := TImage.Create(MainForm);
  AvatarFile := V_MyPath + C_IconsFolder + V_CurrentIcons + C_NoAvatarFileName;
  if FileExists(AvatarFile) then
    V_NoAvatar.Picture.LoadFromFile(AvatarFile);
  // Создаём иконки подтвержения сообщений
  V_OutMessage2 := TMemoryStream.Create;
  OutMessage2File := V_MyPath + C_IconsFolder + V_CurrentIcons + C_SN + 'outmess2' + C_GIF_Ext;
  if FileExists(OutMessage2File) then
    V_OutMessage2.LoadFromFile(OutMessage2File);
  V_OutMessage3 := TMemoryStream.Create;
  OutMessage3File := V_MyPath + C_IconsFolder + V_CurrentIcons + C_SN + 'outmess3' + C_GIF_Ext;
  if FileExists(OutMessage3File) then
    V_OutMessage3.LoadFromFile(OutMessage3File);
  // Присваиваем картинку пустой аватары в места для аватар
  ContactAvatarImage.Picture.Assign(V_NoAvatar.Picture);
  MyAvatarImage.Picture.Assign(V_NoAvatar.Picture);
  V_XStatusImg := TBitmap.Create;
  V_XStatusMem := TMemoryStream.Create;
  // Переводим форму на другие языки
  TranslateForm;
  // Создаём меню быстрых ответов
  CreateFastReplyMenu;
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Делаем окно прилипающим к краям экрана
  ScreenSnap := True;
  // Формируем строку html стиля
  HTMLChatViewer.DoubleBuffered := True;
  HTMLStyle := Format(C_HTML_head, [V_ChatCSS, C_IMadering]);
  // Пока скрываем всегда отображение участников конференции
  ChatCategoryButtons.Visible := False;
  GroupSplitter.Visible := False;
end;

{$ENDREGION}
{$REGION 'FormDestroy'}

procedure TChatForm.FormDestroy(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
begin
  // Создаём необходимые папки
  ForceDirectories(V_ProfilePath);
  // Сохраняем настройки положения окна чата в xml
  // Инициализируем XML
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_SettingsFileName) then
        LoadFromFile(V_ProfilePath + C_SettingsFileName);
      // Очищаем раздел чат формы если он есть
      XML_Node := Root.Items.ItemNamed[C_ChatForm];
      if XML_Node <> nil then
        XML_Node.Clear
      else
        XML_Node := Root.Items.Add(C_ChatForm);
      // Сохраняем позицию окна
      if WindowState = wsMaximized then
      begin
        XML_Node.Properties.Add(C_FM, True);
        XML_Node.Properties.Add(C_FT, f_t);
        XML_Node.Properties.Add(C_FL, f_l);
        XML_Node.Properties.Add(C_FH, f_h);
        XML_Node.Properties.Add(C_FW, f_w);
      end
      else
      begin
        XML_Node.Properties.Add(C_FM, False);
        XML_Node.Properties.Add(C_FT, Top);
        XML_Node.Properties.Add(C_FL, Left);
        XML_Node.Properties.Add(C_FH, Height);
        XML_Node.Properties.Add(C_FW, Width);
      end;
      // Сохраняем позицию сплитеров
      Sub_Node := XML_Node.Items.Add(C_ChatFormSP);
      Sub_Node.Properties.Add('s1', BottomChatFormPanel.Height);
      Sub_Node.Properties.Add('s2', ChatCategoryButtons.Width);
      // Сохраняем "отправлять по интер"
      XML_Node.Items.Add(C_ChatFormSE, EnterKeyToolButton.Down);
      // Сохраняем отправлять отчёт о печати текста
      XML_Node.Items.Add(C_ChatFormST, TypingTextToolButton.Down);
      // Сохраняем "звук нажатия клавиш"
      //XML_Node.Items.Add(C_ChatFormKS, KeySoundToolButton.Down);
      // Сохраняем состояние панелей аватар
      Sub_Node := XML_Node.Items.Add(C_ChatFormAP);
      Sub_Node.Properties.Add('a1', ContactAvatarPanel.Width);
      Sub_Node.Properties.Add('a2', MyAvatarPanel.Width);
      // Записываем сам файл
      SaveToFile(V_ProfilePath + C_SettingsFileName);
    end;
  finally
    JvXML.Free;
  end;
  // Сохраняем набранный текст для открытой вкладки в чате
  Save_Input_Text;
end;

{$ENDREGION}
{$REGION 'GtransSpeedButtonClick'}

procedure TChatForm.GtransSpeedButtonClick(Sender: TObject);
var
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Включаем или отключаем автоматический перевод сообщений
  if GtransSpeedButton.Down then
  begin
    // Отображаем модально окно переводчика
    if not Assigned(GTransForm) then
      GTransForm := TGTransForm.Create(MainForm);
    GTransForm.Hide;
    GTransForm.YourLangComboBox.Enabled := True;
    GTransForm.ToLangComboBox.Enabled := True;
    GTransForm.OKBitBtn.Enabled := True;
    // Если перевод выключен, то деактивируем кнопку перевода
    if GTransForm.ShowModal <> 1 then
      GtransSpeedButton.Down := False;
  end
  else // Деактивируем функцию перевода в файле уникальных настроек этого контакта
  begin
    // Создаём необходимые папки
    ForceDirectories(V_ProfilePath);
    // Инициализируем XML
    JvXML_Create(JvXML);
    try
      with JvXML do
      begin
        if FileExists(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + '.usr') then
          LoadFromFile(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + '.usr');
        if Root <> nil then
        begin
          // Находим раздел gtrans если он есть
          XML_Node := Root.Items.ItemNamed[C_Gtrans];
          if XML_Node <> nil then
            XML_Node.Clear
          else
            XML_Node := Root.Items.Add(C_Gtrans);
          // Сохраняем состояние GTrans
          XML_Node.BoolValue := False;
          // Записываем сам файл
          SaveToFile(V_ProfilePath + C_AnketaFolder + User_Proto + C_BN + UIN_Panel.Caption + '.usr');
        end;
      end;
    finally
      JvXML.Free;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Закрываем подсказки
  CloseSmiliesHint;
  // Выводим на передний план окно со списком контактов
  BringWindowToTop(MainForm.Handle);
end;

procedure TChatForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

procedure TChatForm.GtransSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Перезапускаем перевод (возможно повисший)
  if Button = MbRight then
  begin
    if not Assigned(GTransForm) then
      GTransForm := TGTransForm.Create(MainForm);
    GTransForm.YourLangComboBox.Enabled := False;
    GTransForm.ToLangComboBox.Enabled := False;
    GTransForm.OKBitBtn.Enabled := False;
    XShowForm(GTransForm);
  end;
end;

procedure TChatForm.HtmlPopupMenuPopup(Sender: TObject);
begin
  // Проверяем есть ли выделенный текст в истории чата
  if HTMLChatViewer.SelLength = 0 then
  begin
    ChatHTMLTextCopy.Enabled := False;
    ChatHTMLQText.Enabled := False;
    ChatHTMLQTextTwitter.Enabled := False;
    SearchInGoogle.Enabled := False;
  end
  else
  begin
    ChatHTMLTextCopy.Enabled := True;
    ChatHTMLQText.Enabled := True;
    ChatHTMLQTextTwitter.Enabled := True;
    SearchInGoogle.Enabled := True;
  end;
end;

procedure TChatForm.HistorySpeedButtonClick(Sender: TObject);
begin
  // Открываем окно истории
  if not Assigned(HistoryForm) then
    HistoryForm := THistoryForm.Create(Self);
  // Загружаем файл истории для текущего чата
  HistoryForm.ReqCType := User_Proto;
  HistoryForm.ReqHUIN := UIN_Panel.Caption;
  // Отображаем окно
  XShowForm(HistoryForm);
  // Загружаем историю
  ChatForm.Update;
  HistoryForm.Update;
  HistoryForm.LoadHistoryFromFile;
  // Ставим фокус в поле поиска текста
  if HistoryForm.SearchTextEdit.CanFocus then
    HistoryForm.SearchTextEdit.SetFocus;
end;

procedure TChatForm.HistorySpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем меню над этим элементом
  if Button = MbRight then
    PopUp_Top(HistorySpeedButton, HistoryShowPopupMenu);
end;

procedure TChatForm.HTMLChatViewerHotSpotClick(Sender: TObject; const SRC: string; var Handled: Boolean);
begin
  // Отключаем реакции
  Handled := True;
  // Открываем ссылку из чата во внешнем браузере
  OpenURL(SRC);
end;

procedure TChatForm.HTMLChatViewerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // При нажатии комбинации клавиш Ctrl + C в истории чата копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
    HTMLChatViewer.CopyToClipboard;
end;

procedure TChatForm.HTMLChatViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Сбрасываем выделение текста в чате по клику левой клавишей мыши
  if Button = MbLeft then
    HTMLChatViewer.SelLength := 0;
end;

procedure TChatForm.HTMLChatViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  TitleStr: string;
begin
  // При движениях мыши определяем всплывание подсказок
  if (not MainForm.JvTimerList.Events[14].Enabled) and (Assigned(ActiveControl)) then
  begin
    if ActiveControl.Focused then
    begin
      // Запоминаем вызывающий компонент и атрибут
      SH_HTMLViewer := HTMLChatViewer;
      TitleStr := HTMLChatViewer.TitleAttr;
      // Проверяем содержимое атрибута
      if TitleStr = EmptyStr then
        SH_OldTitle := EmptyStr
      else if TitleStr <> SH_OldTitle then
      begin
        SH_TimerCount := 0;
        // Запускаем таймер показа подсказки с атрибутом
        MainForm.JvTimerList.Events[14].Enabled := True;
        SH_OldTitle := TitleStr;
      end;
    end;
  end;
end;

procedure TChatForm.HTMLChatViewerParseEnd(Sender: TObject);
begin
  // Заменяем всегда картинку доп. статуса при изменениях текста чата
  HTMLChatViewer.ReplaceImage('x', V_XStatusMem);
  // Заменяем картинки исходящих сообщений

  // Заменяем картинки входящих сообщений

  // Заменяем картинки sms сообщений

end;

{$ENDREGION}
{$REGION 'SmiliesSpeedButtonClick'}

procedure TChatForm.SmiliesSpeedButtonClick(Sender: TObject);
var
  XPoint: TPoint;
begin
  // Если окно не создано ещё, то создаём его
  if not Assigned(SmilesForm) then
    SmilesForm := TSmilesForm.Create(nil);
  // Присваиваем окну чата
  SmilesForm.PopupParent := ChatForm;
  // Вычисляем позицию над вызывающим контролом
  XPoint := Point(SmiliesSpeedButton.Width, SmiliesSpeedButton.Top);
  with SmiliesSpeedButton.ClientToScreen(XPoint) do
  begin
    SmilesForm.Left := X - SmiliesSpeedButton.Width;
    SmilesForm.Top := (Y - SmilesForm.Height) - 2;
  end;
  // Отображаем окно смайлов
  SmilesForm.Show;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.SendMessageSpeedButtonDropClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup_down(SendMessageSpeedButtonDrop, SendPopupMenu);
end;

procedure TChatForm.ContactAvatarPanelSpeedButtonClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  // Прячем панель с аватаркой
  GetCursorPos(FCursor);
  if ContactAvatarPanelSpeedButton.NumGlyphs = 4 then
  begin
    ContactAvatarPanel.Width := 0;
    ContactAvatarPanelSpeedButton.Left := 0;
    ContactAvatarPanelSpeedButton.NumGlyphs := 1;
    SetCursorPos(FCursor.X - 68, FCursor.Y);
  end
  else
  begin
    ContactAvatarPanelSpeedButton.Left := 68;
    ContactAvatarPanel.Width := 68;
    ContactAvatarPanelSpeedButton.NumGlyphs := 4;
    SetCursorPos(FCursor.X + 68, FCursor.Y);
  end;
  // Играем звук открытия окна
  ImPlaySnd(8);
end;

procedure TChatForm.ContactMenuToolButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  PopUp_Top(ContactMenuToolButton, ChatUserPopupMenu);
end;

procedure TChatForm.ContactMenuToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  PopUp_Top(ContactMenuToolButton, ChatUserPopupMenu);
end;

procedure TChatForm.ClearChatSpeedButtonClick(Sender: TObject);
var
  Doc: string;
begin
  // Очищаем окно чата от истории сообщений
  HTMLChatViewer.Clear;
  // Добавляем стили
  Doc := HTMLStyle;
  LoadHTMLStrings(HTMLChatViewer, Doc);
end;

{$ENDREGION}
{$REGION 'CloseTabBitBtnClick'}

procedure TChatForm.CloseTabBitBtnClick(Sender: TObject);
var
  I: Integer;
begin
  // Закрываем вкладку чата
  with ChatPageToolBar do
  begin
    if ButtonCount = 1 then
    begin
      ChatForm.Hide;
      // Ставим метку для удаления кнопки (против глюка в wine)
      Buttons[0].AutoSize := False;
      Exit;
    end;
    for I := 0 to ButtonCount - 1 do
    begin
      if Buttons[I].Down then
      begin
        RemoveChatPageButton(Buttons[I]);
        Break;
      end;
    end;
    // Испраляем глюк тулбара закладок чата (те кто писал ComCtrls.pas - пиздюки)
    ChatPageToolBar.Realign;
    // Активируем параметры другого чата
    Buttons[0].Down := True;
    CreateNewChat(Buttons[0]);
  end;
end;

{$ENDREGION}
{$REGION 'ShowAllHistoryClick'}

procedure TChatForm.ShowAllHistoryClick(Sender: TObject);
{var
  Doc: string;}
begin
  {// Ищем эту запись в Ростере и помечаем что сообщения прочитаны и получаем параметры
  RosterItem := RosterForm.ReqRosterItem(InfoPanel2.Caption);
  if RosterItem <> nil then
    begin
      with RosterItem do
        begin
          // Проверяем загружена ли история
          if SubItems[13] = EmptyStr then
            Exit
            // Отображаем историю в чате
          else
            begin
              // Очистили компонент истории и выводим надпись, что история загружается
              Doc := HTMLStyle;
              Doc := Doc + '<span class=b>' + Lang_Vars[116].L_S + '</span>';
              LoadHTMLStrings(HTMLChatViewer, Doc);
              HTMLChatViewer.Refresh;
              // Добавляем стили
              Doc := HTMLStyle;
              // Загружаем из истории указанное количесво сообщений
              if (Sender as TMenuItem).Tag = 1 then
                Doc := Doc + SubItems[13]
              else if (Sender as TMenuItem).Tag = 2 then
                Doc := Doc + TailLineTail(SubItems[13], 100)
              else if (Sender as TMenuItem).Tag = 3 then
                Doc := Doc + TailLineTail(SubItems[13], 50)
              else if (Sender as TMenuItem).Tag = 4 then
                Doc := Doc + TailLineTail(SubItems[13], 20);
              if not V_TextSmilies then
                CheckMessage_Smilies(Doc);
              SetLength(Doc, Length(Doc) - 6);
              Doc := Doc + '<HR>';
              LoadHTMLStrings(HTMLChatViewer, Doc);
              // Ставим каретку в самый низ текста
              HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
              HTMLChatViewer.CaretPos := Length(Doc);
            end;
        end;
    end;}
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.CloseTabSpeedButtonDropClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup_down(CloseTabSpeedButtonDrop, CloseTabPopupMenu);
end;

procedure TChatForm.ChatHTMLTextCopyClick(Sender: TObject);
begin
  // Копируем выделенный текст в буфер обмена
  HTMLChatViewer.CopyToClipboard;
end;

procedure TChatForm.MemoPopupMenuPopup(Sender: TObject);
begin
  // Управляем пунктами меню
  if InputRichEdit.SelLength = 0 then
  begin
    CutMemo.Enabled := False;
    CopyMemo.Enabled := False;
  end
  else
  begin
    CutMemo.Enabled := True;
    CopyMemo.Enabled := True;
  end;
end;

procedure TChatForm.CutMemoClick(Sender: TObject);
begin
  // Вырезаем в буфер обмена
  InputRichEdit.CutToClipboard;
end;

procedure TChatForm.ChatHTMLAllTextCopyClick(Sender: TObject);
begin
  // Выделяем всё и копируем в буфер обмена
  HTMLChatViewer.SelectAll;
  HTMLChatViewer.CopyToClipboard;
end;

procedure TChatForm.InputRichEditChange(Sender: TObject);
begin
  // Убираем из поля ввода текста сишний символ перехода на новую строку
  if InputRichEdit.Text = C_RN then
    InputRichEdit.Clear;
  // Отображаем длинну введённого текста
  TextLenPanel.Caption := IntToStr(InputRichEdit.GetTextLen);
end;

{$ENDREGION}
{$REGION 'InputRichEditKeyDown'}

procedure TChatForm.InputRichEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Переносим каретку в самый конец текста
  if (GetKeyState(VK_CONTROL) >= 0) and (Key = 13) and (EnterKeyToolButton.Down) then
    InputRichEdit.SelStart := InputRichEdit.GetTextLen;
  // Если зажата клавиша контрл и нажата клавиша интер и не нажата кнопка отправки по интер, то отправляем сообщение
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 13) and (not EnterKeyToolButton.Down) then
  begin
    // Переносим каретку в самый конец текста
    InputRichEdit.SelStart := InputRichEdit.GetTextLen;
    // Отправляем сообщение
    SendMessageBitBtnClick(Self);
  end;
  // Если зажата клавиша контрл и нажата клавиша "s", то открываем окно смайлов
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 83) then
    SmiliesSpeedButtonClick(Self);
end;

{$ENDREGION}
{$REGION 'InputRichEditKeyPress'}

procedure TChatForm.InputRichEditKeyPress(Sender: TObject; var Key: Char);
label
  X;
var
  MsgD, Msg, HMsg, HistoryFile: string;
begin
  // Если поле идентификатора пользователя пустое, то выходим от сюда
  if UIN_Panel.Caption = EmptyStr then
    Exit;
  // Если нажата клавиша не интер, то если включен режим звуковой клавиатуры, то воспроизводим звуки
  if Key <> #13 then
  begin
    // Если включён режим звука нажатия клавиш, то играем звуки
    if Assigned(SettingsForm) then
      if SettingsForm.KeyboardSoundsCheckBox.Checked then
      begin
        if (Key = #8) and (InputRichEdit.Text <> EmptyStr) then
          ImPlaySnd(9)
        else if Key <> #8 then
          ImPlaySnd(8);
      end;
    // Если нажата кнопка отправки оповещения о печати текста
    if TypingTextToolButton.Down then
    begin
      { if not MainForm.ICQTypeTextTimer.Enabled then
        begin
        UIN := InfoPanel2.Caption;
        //if ICQ_Work_Phaze then ICQ_SendTextTyping(TextTypeForUIN, '02');
        MainForm.ICQTypeTextTimer.Enabled := true;
        end
        else MainForm.ICQTypeTextTimer.Enabled := true; }
    end;
    // Выходим
    Exit;
  end;
  // Если нажата клавиша интер и кнопка отправки по интер
  if (Key = #13) and (EnterKeyToolButton.Down) then
    // Если зажата клавиша Шифт
    if GetKeyState(VK_SHIFT) < 0 then
      Exit
    else
    begin
      X: ;
      // Обнуляем символ клавиши
      Key := #0;
      // Если поле ввода пустое, то выходим
      if InputRichEdit.GetTextLen = 0 then
      begin
        // Очищаем поле ввода от перевода каретки
        InputRichEdit.Clear;
        // Закрываем текущую вкладку
        CloseTabBitBtnClick(nil);
        // Выходим от сюда
        Exit;
      end;
      // Если нажата кнопка звука нажатия клавиш, то играем звуки
      if Assigned(SettingsForm) then
        if SettingsForm.KeyboardSoundsCheckBox.Checked then
          ImPlaySnd(10);
      // Копируем текст сообщения
      Msg := TrimRight(InputRichEdit.Text);
      // Переводим сообщение если активна функция Gtrans
      {if GtransSpeedButton.Down then
      begin
        // Если форма перевода не создана, то создаём её
        if not Assigned(GTransForm) then
          GTransForm := TGTransForm.Create(MainForm);
        // Заполняем переменные для перевода
        with GTransForm.GtransListView.Items.Add do
        begin
          ImageIndex := 166;
          SubItems.Add(UIN_Panel.Caption);
          SubItems.Add(Msg);
          SubItems.Add(User_Proto);
        end;
        NotifyPanel.Caption := Lang_Vars[87].L_S;
        // Очищаем поле ввода теста
        InputRichEdit.Clear;
        InputRichEditChange(Self);
        // Выходим и предоставляем заверщить отправку сообщения технологии Gtans
        Exit;
      end;}
      HMsg := Text2XML(Msg);
      // Добавляем сообщение в файл истории и в чат
      MsgD := V_YouAt + C_BN + C_QN + DateTimeChatMess + C_EN;
      // Форматируем сообщение под html формат
      CheckMessage_BR(HMsg);
      CheckMessage_ClearTag(HMsg);
      // Если тип контакта ICQ, то отправляем сообщение по ICQ протоколу
      if User_Proto = C_ICQ then
      begin
        // Если нет подключения к серверу ICQ, то выходим
        if NotProtoOnline(C_ICQ) then
          Exit;
        // Заканчиваем оповещение о наборе текста
        // if MainForm.ICQTypeTextTimer.Enabled then MainForm.ICQTypeTextTimerTimer(self);
        // Отправляем сообщение в юникод формате
        ICQ_SendMessage_0406(UIN_Panel.Caption, Msg, True);
        // Формируем файл с историей
        HistoryFile := V_ProfilePath + C_HistoryFolder + User_Proto + C_BN + ICQ_LoginUIN + C_BN + UIN_Panel.Caption + C_Htm_Ext;
      end
      else if User_Proto = C_Jabber then
      begin
        // Если нет подключения к серверу Jabber, то выходим
        if NotProtoOnline(C_Jabber) then
          Exit;
        // Отправляем сообщение
        Jab_SendMessage(UIN_Panel.Caption, Msg);
        // Формируем файл с историей
        HistoryFile := V_ProfilePath + C_HistoryFolder + User_Proto + C_BN + Jabber_LoginUIN + C_BN + UIN_Panel.Caption + C_Htm_Ext;
      end
      else if User_Proto = C_Mra then
      begin
        // Если нет подключения к серверу MRA, то выходим
        if NotProtoOnline(C_Mra) then
          Exit;
        // Отправляем сообщение
        MRA_SendMessage(UIN_Panel.Caption, Msg);
        // Формируем файл с историей
        HistoryFile := V_ProfilePath + C_HistoryFolder + User_Proto + C_BN + MRA_LoginUIN + C_BN + UIN_Panel.Caption + C_Htm_Ext;
      end
      else
        Exit;
      // Записываем историю в файл этого контакта
      HMsg := Text2XML(HMsg);
      CheckMessage_BR(HMsg);
      DecorateURL(HMsg);
      SaveTextInHistory(Format(C_HistoryOut, [MsgD, HMsg]), HistoryFile);
      // Если включены графические смайлики, то форматируем сообщение под смайлы
      if not V_TextSmilies then
        CheckMessage_Smilies(HMsg);
      // Увеличиваем счётчик исходящих сообщений
      Inc(OutMessIndex);
      // Добавляем в чат сообщение
      AddChatText(MsgD, HMsg);
      // Прокручиваем чат до конца
      HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
      // Очищаем поле ввода теста
      InputRichEdit.Clear;
      InputRichEditChange(nil);
      // Выходим
      Exit;
    end;
  // Если нажата клавиша интер и не нажата кнопка отправки по интер и зажата клавиша сонтрл, то переходим к отправке сообщения
  if (Key = #13) and (not EnterKeyToolButton.Down) and (GetKeyState(VK_CONTROL) < 0) then
    goto X;
  // Если нажата кнопка "отправить" сообщение
  if (Key = #13) and (not EnterKeyToolButton.Down) and (Sender.ClassName = 'TBitBtn') then
    goto X;
end;

{$ENDREGION}
{$REGION 'RemoveChatPageButton'}

procedure TChatForm.RemoveChatPageButton(ChatButton: TToolButton);
begin
  // Уничтожаем кнопку закладки чата
  ChatPageToolBar.RemoveControl(ChatButton);
  ChatButton.Parent := nil;
  ChatButton.OnMouseDown := nil;
  ChatButton.OnContextPopup := nil;
  ChatButton.PopupMenu := nil;
  FreeAndNil(ChatButton);
end;

{$ENDREGION}

end.

