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
    KeySoundToolButton: TToolButton;
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
    InfoPanel2: TPanel;
    InfoPanel4: TPanel;
    TopInfoPanelL: TPanel;
    InfoPanel1: TPanel;
    InfoPanel3: TPanel;
    UniqToolButton: TToolButton;
    FlagImage: TImage;
    ChatHTMLQTextTwitter: TMenuItem;
    GenderImage: TImage;
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
    procedure InfoPanel1Click(Sender: TObject);
    procedure InfoPanel2Click(Sender: TObject);
    procedure GtransSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ChatHTMLQTextTwitterClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure HTMLChatViewerMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
    f_t, f_l, f_h, f_w: integer;
    HTMLStyle: string;
    LastClick: Tdatetime;
    ButtonInd: Integer;
    TabMenuToolButton: TToolButton;
    // Zundo: string;
    procedure QuickMessClick(Sender: TObject);

  public
    { Public declarations }
    OutMessIndex: LongInt;
    ChatButton: TButtonItem;
    UserType: string;
    UserAvatarHash: string;
    procedure TranslateForm;
    procedure CheckMessage_ClearTag(var Msg: string);
    procedure AddChatText(Nick_Time, Mess_Text: string; MessIn: Boolean = False);
    procedure CreateFastReplyMenu;
    function AddMessInActiveChat(CNick, CPopMsg, CId, CMsgD, CMess: string): Boolean;
    procedure CreateNewChat(CButton: TToolButton);
    procedure RemoveChatPageButton(ChatButton: TToolButton);
    procedure Save_Input_Text(S_UIN: string);
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
  IcqContactInfoUnit,
  UtilsUnit,
  RosterUnit,
  JabberProtoUnit,
  FileTransferUnit,
  GtransUnit,
  MraProtoUnit,
  UniqUnit,
  OverbyteIcsUrl,
  IcqReqAuthUnit;

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
  UIN, HistoryFile, Doc, HistoryText, ImageFile: string;
  RosterItem: TListItem;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Применяем параметры нового чата
  UIN := CButton.HelpKeyword;
  // Ищем эту запись в Ростере и помечаем что сообщения прочитаны и получаем параметры
  RosterItem := RosterForm.ReqRosterItem(UIN);
  if RosterItem <> nil then
    begin
      with RosterItem do
        begin
          // Выставляем параметры этого контакта
          SubItems[36] := EmptyStr;
          CButton.Caption := URLDecode(SubItems[0]);
          CButton.Tag := StrToInt(SubItems[6]);
          CButton.ImageIndex := CButton.Tag;
          CButton.Hint := URLDecode(SubItems[34]);
          UserAvatarHash := Hex2Text(SubItems[29]);
          UserType := SubItems[3];
          // Вставляем ранее набранный текст в поле набора
          InputRichEdit.Text := URLDecode(SubItems[14]);
          // Загружаем файл истории сообщений
          if UserType = C_Icq then
            HistoryFile := V_ProfilePath + C_HistoryFolder + UserType + C_BN + ICQ_LoginUIN + C_BN + UIN + '.htm'
          else if UserType = C_Jabber then
            HistoryFile := V_ProfilePath + C_HistoryFolder + UserType + C_BN + Jabber_LoginUIN + C_BN + UIN + '.htm'
          else if UserType = C_Mra then
            HistoryFile := V_ProfilePath + C_HistoryFolder + UserType + C_BN + MRA_LoginUIN + C_BN + UIN + '.htm';
          if FileExists(HistoryFile) then
            begin
              // Проверяем создавать или нет архив истории
              if CreateHistoryArhive(HistoryFile) then
                begin
                  // Если сжатие истории закончено успешно, то удаляем файл истории
                  DeleteFile(HistoryFile);
                  // Сообщаем о создании архива и записываем это в новый файл для памятки
                  HistoryText := '<span class=d>' + HistoryCompressedL + '</span><br><br>';
                  SaveTextInHistory(HistoryText, HistoryFile);
                end
              else
                HistoryText := Readfromfile(HistoryFile, true);
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
              Doc := Doc + '<HR>';
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
          InfoPanel1.Caption := NameAndLast(UIN, UserType);
          // Ставим город и возраст в информационное поле
          InfoPanel3.Caption := V_GetCityPanel;
          InfoPanel4.Caption := V_GetAgePanel;
          // Ставим флаг страны
          ImageFile := V_MyPath + 'Icons\Flags\' + V_GetFlagImage + '.gif';
          if FileExists(ImageFile) then
            FlagImage.Picture.LoadFromFile(ImageFile)
          else
            FlagImage.Picture.Assign(nil);
          // Ставим иконку пола
          ImageFile := V_MyPath + 'Icons\' + V_CurrentIcons + '\' + V_GetGenderImage + '.gif';
          if FileExists(ImageFile) then
            GenderImage.Picture.LoadFromFile(ImageFile)
          else
            GenderImage.Picture.Assign(nil);
          // Ставим клиент в информационное поле
          if SubItems[32] <> EmptyStr then
            begin
              NotifyPanel.Caption := SubItems[32];
              NotifyPanel.Hint := SubItems[32];
            end
          else
            begin
              NotifyPanel.Caption := '...';
              NotifyPanel.Font.Color := ClWindowText;
            end;
          // Выводим текст доп. статуса и иконку доп статуса
          if SubItems[31] <> EmptyStr then
            begin
              Doc := UTF8ToString(HTMLChatViewer.DocumentSource);
              // Если есть и иконка доп. статуса
              if SubItems[7] <> '-1' then
                Doc := Doc + '<IMG NAME=x SRC="" ALIGN=ABSMIDDLE BORDER=0> ';
              Doc := Doc + '<span class=d>' + URLDecode(SubItems[31]) + '</span><br><br>';
              LoadHTMLStrings(HTMLChatViewer, Doc);
              // Преобразуем и подгружаем иконку доп. статуса
              if SubItems[7] > '-1' then
                begin
                  V_XStatusImg.Assign(nil);
                  MainForm.AllImageList.GetBitmap(StrToInt(SubItems[7]), V_XStatusImg);
                  V_XStatusMem.Clear;
                  V_XStatusImg.SaveToStream(V_XStatusMem);
                  HTMLChatViewer.ReplaceImage('x', V_XStatusMem);
                end;
            end;
          // Ставим каретку в самый низ текста
          HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
          HTMLChatViewer.CaretPos := Length(Doc);
          // Выставляем параметры перевода для этого контакта
          GtransSpeedButton.Down := False;
          // Инициализируем XML
          JvXML_Create(JvXML);
          try
            with JvXML do
              begin
                if FileExists(V_ProfilePath + C_AnketaFolder + UserType + C_BN + UIN + '.usr') then
                  begin
                    LoadFromFile(V_ProfilePath + C_AnketaFolder + UserType + C_BN + UIN + '.usr');
                    if Root <> nil then
                      begin
                        XML_Node := Root.Items.ItemNamed[C_UniqGT];
                        if XML_Node <> nil then
                          GtransSpeedButton.Down := XML_Node.BoolValue;
                      end;
                  end;
              end;
          finally
            JvXML.Free;
          end;
        end;
    end;
  if InfoPanel1.Caption = EmptyStr then
    InfoPanel1.Caption := CButton.Caption;
  // Ставим учётную запись контакта в информационное поле
  InfoPanel2.Caption := UIN;
  // Ставим курсор в мемо после последнего символа
  InputRichEdit.SelStart := InputRichEdit.GetTextLen;
  // Ставим фокус в поле ввода текста
  if (InputRichEdit.CanFocus) and (ChatForm.Visible) then
    InputRichEdit.SetFocus;
  // Удаляем отметку о сообщении из списка очереди входящих сообщений
  RosterForm.DellcIdInMessList(UIN);

  // Загружаем аватар
  { if (Length(UserAvatarHash) = 32) and ((FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')) or
    (FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.gif')) or
    (FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.bmp'))) then
    begin
    if FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.jpg') then
    ContactImage.Picture.LoadFromFile(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')
    else if FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.gif') then
    ContactImage.Picture.LoadFromFile(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.gif')
    else if FileExists(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.bmp') then
    ContactImage.Picture.LoadFromFile(ProfilePath + 'Profile\Avatars\' + UserAvatarHash + '.bmp');
    end
    else
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
    end; }

end;

{$ENDREGION}
{$REGION 'AddMessInActiveChat'}

function TChatForm.AddMessInActiveChat(CNick, CPopMsg, CId, CMsgD, CMess: string): Boolean;
begin
  Result := False;
  if Visible then
    begin
      // Если открыт текущий чат с этим контактом
      if InfoPanel2.Caption = CId then
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
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TChatForm.QRepSpeedButtonClick(Sender: TObject);
begin
  // Открываем меню над этим элементом
  Popup(QRepSpeedButton, QmessPopupMenu);
end;

procedure TChatForm.QRepSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем меню над этим элементом
  if Button = MbRight then
    Popup(QRepSpeedButton, QmessPopupMenu);
end;

procedure TChatForm.QSpeedButtonClick(Sender: TObject);
var
  RosterItem: TListItem;
begin
  // Достаём из Ростера последнее сообщение от этого контакта
  RosterItem := RosterForm.ReqRosterItem(InfoPanel2.Caption);
  if RosterItem <> nil then
    begin
      if RosterItem.SubItems[15] <> EmptyStr then
        InputRichEdit.Lines.Add('> ' + URLDecode(RosterItem.SubItems[15]));
    end;
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
      List.Add(QReply1L);
      List.Add(QReply2L);
      List.Add(QReply3L);
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
label
  X;
var
  I: Integer;
begin
  // Если вкладки есть, то закрываем те что со статусом оффлайн
  with ChatPageToolBar do
    begin
    X :;
      // Сканируем вкладки
      for I := 0 to ButtonCount - 1 do
        begin
          case Buttons[I].Tag of
            9, 23, 25, 30, 41, 42, 80, 214: begin
                RemoveChatPageButton(Buttons[I]);
                // Прорисовываем интерфейс
                Update;
                // Прыгаем на повторение скана
                goto X;
              end;
          end;
        end;
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
label
  X;
var
  I: Integer;
begin
  // Если вкладки присутствуют, то закрываем все кроме текущей
  with ChatPageToolBar do
    begin
    X :;
      if ButtonCount > 1 then
        begin
          for I := 0 to ButtonCount - 1 do
            if not Buttons[I].Down then
              begin
                RemoveChatPageButton(Buttons[I]);
                Update;
                goto X;
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
  if not Assigned(IcqReqAuthForm) then
    IcqReqAuthForm := TIcqReqAuthForm.Create(Self);
  // Делаем запрос в форме на обновление программы
  IcqReqAuthForm.PostInTwitter(S);
  // Отображаем окно
  XShowForm(IcqReqAuthForm);
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
  Popup(SendFileSpeedButton, FileTransferPopupMenu);
end;

procedure TChatForm.SendFileSpeedButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Открываем меню над этим элементом
  if Button = MbRight then
    Popup(SendFileSpeedButton, FileTransferPopupMenu);
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
  if not Assigned(IcqContactInfoForm) then
    IcqContactInfoForm := TIcqContactInfoForm.Create(MainForm);
  // Присваиваем UIN инфу которого хотим смотреть
  IcqContactInfoForm.ReqUIN := InfoPanel2.Caption;
  IcqContactInfoForm.ReqProto := UserType;
  // Загружаем информацию о нем
  IcqContactInfoForm.LoadUserUnfo;
  // Отображаем окно на передний план
  XShowForm(IcqContactInfoForm);
end;

procedure TChatForm.InfoPanel1Click(Sender: TObject);
begin
  // Копируем в буфер обмена ник или имя и отчество контакта
  SetClipboardText(InfoPanel1.Caption);
end;

procedure TChatForm.InfoPanel2Click(Sender: TObject);
begin
  // Копируем в буфер обмена ник или имя и отчество контакта
  SetClipboardText(InfoPanel2.Caption);
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

procedure TChatForm.Save_Input_Text(S_UIN: string);
var
  RosterItem: TListItem;
begin
  // Сохраняем набранный текст для этой вкладки
  if S_UIN <> EmptyStr then
    begin
      RosterItem := RosterForm.ReqRosterItem(S_UIN);
      if RosterItem <> nil then
        RosterItem.SubItems[14] := URLEncode(InputRichEdit.Text);
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
            Save_Input_Text(InfoPanel2.Caption);
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
  if UserType = C_Icq then
    UniqForm.AccountPanel.Caption := Lang_Vars[20].L_S + C_BN + UpperCase(C_Icq) + C_TN + InfoPanel2.Caption
  else if UserType = C_Jabber then
    UniqForm.AccountPanel.Caption := Lang_Vars[20].L_S + C_BN + C_Jabber + C_TN + InfoPanel2.Caption;
  // Отображаем окно
  XShowForm(UniqForm);
end;

{$ENDREGION}
{$REGION 'SendUpWapRu'}

procedure TChatForm.SendUpWapRuClick(Sender: TObject);
var
  Fsize: LongInt;
begin
  if NotProtoOnline(UserType) then
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
          DAShow(Lang_Vars[18].L_S, S_FileTransfer6, EmptyStr, 133, 3, 0);
          Exit;
        end;
      // Выбираем способ передачи файла
      Tag := (Sender as TMenuItem).Tag; // 1 - UpWap.ru
      TopInfoPanel.Caption := S_FileTransfer1 + InfoPanel1.Caption;
      T_UIN := InfoPanel2.Caption;
      T_UserType := UserType;
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
  RosterItem: TListItem;
  ChatTabB: TToolButton;
begin
  // Сбрасываем иконку в активной вкладке в окне чата
  ChatTabB := RosterForm.ReqChatPage(InfoPanel2.Caption);
  if ChatTabB = nil then
    Exit;
  ChatTabB.ImageIndex := ChatTabB.Tag;
  // Сбрасываем иконку сообщения в Ростере
  RosterItem := RosterForm.ReqRosterItem(InfoPanel2.Caption);
  if RosterItem <> nil then
    RosterItem.SubItems[36] := EmptyStr;
  // Удаляем отметку о сообщении из списка очереди входящих сообщений
  RosterForm.DellcIdInMessList(InfoPanel2.Caption);
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
                    Top := XML_Node.Properties.IntValue('t');
                    Left := XML_Node.Properties.IntValue('l');
                    Height := XML_Node.Properties.IntValue('h');
                    Width := XML_Node.Properties.IntValue('w');
                    f_t := Top;
                    f_l := Left;
                    f_h := Height;
                    f_w := Width;
                    if XML_Node.Properties.BoolValue('max', False) then
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
                    // Загружаем "звук нажатия клавиш"
                    Sub_Node := XML_Node.Items.ItemNamed[C_ChatFormKS];
                    if Sub_Node <> nil then
                      KeySoundToolButton.Down := Sub_Node.BoolValue;
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
  AvatarFile := V_MyPath + 'Icons\' + V_CurrentIcons + '\noavatar.gif';
  if FileExists(AvatarFile) then
    V_NoAvatar.Picture.LoadFromFile(AvatarFile);
  // Создаём иконки подтвержения сообщений
  V_OutMessage2 := TMemoryStream.Create;
  OutMessage2File := V_MyPath + 'Icons\' + V_CurrentIcons + '\outmess2.gif';
  if FileExists(OutMessage2File) then
    V_OutMessage2.LoadFromFile(OutMessage2File);
  V_OutMessage3 := TMemoryStream.Create;
  OutMessage3File := V_MyPath + 'Icons\' + V_CurrentIcons + '\outmess3.gif';
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
  HTMLStyle := '<html><head>' + V_ChatCSS + '<title>Chat</title></head><body>';
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
            XML_Node.Properties.Add('max', True);
            XML_Node.Properties.Add('t', f_t);
            XML_Node.Properties.Add('l', f_l);
            XML_Node.Properties.Add('h', f_h);
            XML_Node.Properties.Add('w', f_w);
          end
        else
          begin
            XML_Node.Properties.Add('max', False);
            XML_Node.Properties.Add('t', Top);
            XML_Node.Properties.Add('l', Left);
            XML_Node.Properties.Add('h', Height);
            XML_Node.Properties.Add('w', Width);
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
        XML_Node.Items.Add(C_ChatFormKS, KeySoundToolButton.Down);
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
            if FileExists(V_ProfilePath + C_AnketaFolder + UserType + C_BN + InfoPanel2.Caption + '.usr') then
              LoadFromFile(V_ProfilePath + C_AnketaFolder + UserType + C_BN + InfoPanel2.Caption + '.usr');
            if Root <> nil then
              begin
                // Находим раздел gtrans если он есть
                XML_Node := Root.Items.ItemNamed[C_UniqGT];
                if XML_Node <> nil then
                  XML_Node.Clear
                else
                  XML_Node := Root.Items.Add(C_UniqGT);
                // Сохраняем состояние GTrans
                XML_Node.BoolValue := False;
                // Записываем сам файл
                SaveToFile(V_ProfilePath + C_AnketaFolder + UserType + C_BN + InfoPanel2.Caption + '.usr');
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
    end
  else
    begin
      ChatHTMLTextCopy.Enabled := True;
      ChatHTMLQText.Enabled := True;
      ChatHTMLQTextTwitter.Enabled := True;
    end;
end;

procedure TChatForm.HistorySpeedButtonClick(Sender: TObject);
begin
  // Открываем окно истории
  if not Assigned(HistoryForm) then
    HistoryForm := THistoryForm.Create(Self);
  // Загружаем файл истории для текущего чата
  HistoryForm.ReqCType := UserType;
  HistoryForm.ReqHUIN := InfoPanel2.Caption;
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
    Popup(HistorySpeedButton, HistoryShowPopupMenu);
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
  // При нажатии комбинации клавиш Ctrl + C в истории чата
  // копируем выделенный текст в буфер обмена
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
  Popup(ContactMenuToolButton, ChatUserPopupMenu);
end;

procedure TChatForm.ContactMenuToolButtonContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  // Открываем меню над этим элементом
  Popup(ContactMenuToolButton, ChatUserPopupMenu);
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
var
  Doc: string;
  RosterItem: TListItem;
begin
  // Ищем эту запись в Ростере и помечаем что сообщения прочитаны и получаем параметры
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
              Doc := Doc + '<span class=b>' + HistoryLoadFileL + '</span>';
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
    end;
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
{ var
  list: TStringList;
  Selected, YesConvert: boolean;
  buf, Outbuf, temp: string;
  HMemo: HWND;
  i, ii: integer;

  procedure ReplaceText(Str: string);
  begin
  SendMessage(HMemo, EM_REPLACESEL, 0, Longint(PChar(Str)));
  end;

  function GetSelText(var Str: string): boolean;
  begin
  result := false;
  if self.InputMemo.SelText <> EmptyStr then
  begin
  result := true;
  Str := self.InputMemo.SelText;
  end
  else
  Str := self.InputMemo.Text;
  end; }
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
  //
  { if (GetKeyState(VK_CONTROL) < 0) and (Key = 82) then
    begin
    if not FileExists(MyPath + 'Langs\chars_r.txt') then Exit;
    HMemo := self.InputMemo.Handle;
    if HMemo = 0 then Exit;
    Selected := GetSelText(buf);
    if Length(buf) = 0 then Exit;
    Zundo := self.InputMemo.Text;
    list := TStringList.Create;
    list.LoadFromFile(MyPath + 'Langs\chars_r.txt');
    //
    for i := 1 to Length(buf) do
    begin
    YesConvert := false;
    for ii := 0 to list.Count - 1 do
    begin
    temp := Parse('=', list.Strings[ii], 1);
    if buf[i] = temp then
    begin
    Outbuf := Outbuf + Parse('=', list.Strings[ii], 2);
    YesConvert := true;
    Break;
    end;
    end;
    if not YesConvert then Outbuf := Outbuf + buf[i];
    end;
    //
    list.Free;
    if Selected then ReplaceText(Outbuf)
    else SetWindowText(HMemo, PChar(Outbuf));
    SendMessage(HMemo, EM_SETSEL, Length(self.InputMemo.Text), Length(self.InputMemo.Text));
    end;
    //
    if (GetKeyState(VK_CONTROL) < 0) and (Key = 84) then
    begin
    if not FileExists(MyPath + 'Langs\chars_t.txt') then Exit;
    HMemo := self.InputMemo.Handle;
    if HMemo = 0 then Exit;
    Selected := GetSelText(buf);
    if Length(buf) = 0 then Exit;
    Zundo := self.InputMemo.Text;
    list := TStringList.Create;
    list.LoadFromFile(MyPath + 'Langs\chars_t.txt');
    //
    for i := 1 to Length(buf) do
    begin
    YesConvert := false;
    for ii := 0 to list.Count - 1 do
    begin
    temp := Parse('=', list.Strings[ii], 1);
    if buf[i] = temp then
    begin
    Outbuf := Outbuf + Parse('=', list.Strings[ii], 2);
    YesConvert := true;
    Break;
    end;
    end;
    if not YesConvert then Outbuf := Outbuf + buf[i];
    end;
    //
    list.Free;
    if Selected then ReplaceText(Outbuf)
    else SetWindowText(HMemo, PChar(Outbuf));
    SendMessage(HMemo, EM_SETSEL, Length(self.InputMemo.Text), Length(self.InputMemo.Text));
    end;
    //
    if (GetKeyState(VK_CONTROL) < 0) and (Key = 90) then
    begin
    if Zundo > EmptyStr then self.InputMemo.Text := Zundo;
    self.InputMemo.SelStart := self.InputMemo.GetTextLen;
    Zundo := EmptyStr;
    end; }
end;

{$ENDREGION}
{$REGION 'InputRichEditKeyPress'}

procedure TChatForm.InputRichEditKeyPress(Sender: TObject; var Key: Char);
label
  X;
var
  MsgD, Msg, HMsg, HistoryFile: string;
begin
  // Если поле идентификатора пользователя пустое, то выходим от сюда (в будущем сделать чтобы закрывалось окно)
  if InfoPanel2.Caption = EmptyStr then
    Exit;
  // Если нажата клавиша не интер, то если включен режим звуковой клавиатуры, то воспроизводим звуки
  if Key <> #13 then
    begin
      // Если нажата кнопка звука нажатия клавиш, то играем звуки
      if KeySoundToolButton.Down then
        begin
          if (Key = #8) and (InputRichEdit.Text <> EmptyStr) then
            ImPlaySnd(10)
          else if Key <> #8 then
            ImPlaySnd(9);
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
      X :;
        // Обнуляем символ клавиши
        Key := #0;
        // Если поле ввода пустое, то выходим
        if InputRichEdit.GetTextLen = 0 then
          Exit;
        // Если нажата кнопка звука нажатия клавиш, то играем звуки
        if KeySoundToolButton.Down then
          ImPlaySnd(11);
        // Копируем текст сообщения
        Msg := Trim(InputRichEdit.Text);
        // Переводим сообщение если активна функция Gtrans
        if GtransSpeedButton.Down then
          begin
            // Если форма перевода не создана, то создаём её
            if not Assigned(GTransForm) then
              GTransForm := TGTransForm.Create(MainForm);
            // Заполняем переменные для перевода
            with GTransForm.GtransListView.Items.Add do
              begin
                ImageIndex := 166;
                SubItems.Add(InfoPanel2.Caption);
                SubItems.Add(Msg);
                SubItems.Add(UserType);
              end;
            NotifyPanel.Caption := GtransProcessL;
            // Очищаем поле ввода теста
            InputRichEdit.Clear;
            InputRichEditChange(Self);
            // Выходим и предоставляем заверщить отправку сообщения технологии Gtans
            Exit;
          end;
        HMsg := Msg;
        // Добавляем сообщение в файл истории и в чат
        MsgD := V_YouAt + ' [' + DateTimeChatMess + ']';
        // Форматируем сообщение под html формат
        CheckMessage_BR(HMsg);
        CheckMessage_ClearTag(HMsg);
        CheckMessage_BR(HMsg);
        DecorateURL(HMsg);
        // Если тип контакта ICQ, то отправляем сообщение по ICQ протоколу
        if UserType = C_Icq then
          begin
            // Если нет подключения к серверу ICQ, то выходим
            if NotProtoOnline(C_Icq) then
              Exit;
            // Заканчиваем оповещение о наборе текста
            // if MainForm.ICQTypeTextTimer.Enabled then MainForm.ICQTypeTextTimerTimer(self);
            // Отправляем сообщение в юникод формате
            ICQ_SendMessage_0406(InfoPanel2.Caption, Msg, True);
            // Формируем файл с историей
            HistoryFile := V_ProfilePath + C_HistoryFolder + UserType + C_BN + ICQ_LoginUIN + C_BN + InfoPanel2.Caption + '.htm';
          end
        else if UserType = C_Jabber then
          begin
            // Если нет подключения к серверу Jabber, то выходим
            if NotProtoOnline(C_Jabber) then
              Exit;
            // Отправляем сообщение
            Jab_SendMessage(InfoPanel2.Caption, Msg);
            // Формируем файл с историей
            HistoryFile := V_ProfilePath + C_HistoryFolder + UserType + C_BN + Jabber_LoginUIN + C_BN + InfoPanel2.Caption + '.htm';
          end
        else if UserType = C_Mra then
          begin
            // Если нет подключения к серверу MRA, то выходим
            if NotProtoOnline(C_Mra) then
              Exit;
            // Отправляем сообщение
            MRA_SendMessage(InfoPanel2.Caption, Msg);
            // Формируем файл с историей
            HistoryFile := V_ProfilePath + C_HistoryFolder + UserType + C_BN + MRA_LoginUIN + C_BN + InfoPanel2.Caption + '.htm';
          end
        else
          Exit;
        // Записываем историю в файл этого контакта
        SaveTextInHistory('<span class=a>' + MsgD + '</span><br><span class=c>' + HMsg + '</span><br><br>', HistoryFile);
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
        InputRichEditChange(Self);
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
