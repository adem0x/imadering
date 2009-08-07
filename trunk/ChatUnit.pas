{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit ChatUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Htmlview, StrUtils, Menus, ExtCtrls, StdCtrls, Buttons,
  CategoryButtons, VarsUnit, ShellApi, MMsystem, GIFImage, rXML,
  ComCtrls, CommCtrl, ToolWin;

type
  TWmMoving = record
    Msg: Cardinal;
    fwSide: Cardinal;
    lpRect: PRect;
    Result: Integer;
  end;

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
    InputMemo: TMemo;
    MyAvatarPanel: TPanel;
    MyAvatarImage: TImage;
    HTMLMsg: THTMLViewer;
    ChatSplitter: TSplitter;
    HtmlPanel: TPanel;
    HTMLChatViewer: THTMLViewer;
    TopChatFormPanel: TPanel;
    InfoPanel1: TPanel;
    InfoPanel2: TPanel;
    InfoContactSpeedButton: TSpeedButton;
    EditContactSpeedButton: TSpeedButton;
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
    SearchAvatarTimer: TTimer;
    QmessPopupMenu: TPopupMenu;
    ChatPageControl: TPageControl;
    InfoPanel3: TPanel;
    InfoPanel4: TPanel;
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
    procedure FormCreate(Sender: TObject);
    procedure MyAvatarPanelSpeedButtonClick(Sender: TObject);
    procedure ChatSplitterMoved(Sender: TObject);
    procedure InputMemoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ChatCategoryButtonsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ChatCategoryButtonsHotButton(Sender: TObject;
      const Button: TButtonItem);
    procedure ChatCategoryButtonsButtonClicked(Sender: TObject;
      const Button: TButtonItem);
    procedure CloseTabAllClick(Sender: TObject);
    procedure CloseTabAllNoCurrentClick(Sender: TObject);
    procedure CloseTabAllOfflineClick(Sender: TObject);
    procedure InputMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChatSettingsToolButtonClick(Sender: TObject);
    procedure InputMemoKeyPress(Sender: TObject; var Key: Char);
    procedure EditContactSpeedButtonClick(Sender: TObject);
    procedure ShowAllHistoryClick(Sender: TObject);
    procedure InfoContactSpeedButtonClick(Sender: TObject);
    procedure ChatHTMLTextCopyClick(Sender: TObject);
    procedure HTMLChatViewerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    procedure SearchAvatarTimerTimer(Sender: TObject);
    procedure ChatFontToolButtonClick(Sender: TObject);
    procedure HTMLChatViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure ChatPageControlChange(Sender: TObject);
    procedure ChatPageControlMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChatPageControlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SmiliesSpeedButtonClick(Sender: TObject);
    procedure QSpeedButtonClick(Sender: TObject);
    procedure QRepSpeedButtonClick(Sender: TObject);
    procedure HistorySpeedButtonClick(Sender: TObject);
    procedure HistorySpeedButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClearChatSpeedButtonClick(Sender: TObject);
    procedure ContactAvatarPanelSpeedButtonClick(Sender: TObject);
    procedure SendMessageBitBtnClick(Sender: TObject);
    procedure SendMessageSpeedButtonDropClick(Sender: TObject);
    procedure CloseTabBitBtnClick(Sender: TObject);
    procedure CloseTabSpeedButtonDropClick(Sender: TObject);
    procedure SendAllOnlineClick(Sender: TObject);
    procedure SendAllClick(Sender: TObject);
    procedure SendFileSpeedButtonClick(Sender: TObject);
    procedure ContactMenuToolButtonClick(Sender: TObject);
    procedure TypingTextToolButtonClick(Sender: TObject);
  private
    { Private declarations }
    lastClick: Tdatetime;
    ButtonInd: integer;
    //Zundo: string;
    HintInd: integer;
    procedure QuickMessClick(Sender: TObject);
  public
    { Public declarations }
    OutMessIndex: integer;
    ChatButton: TButtonItem;
    MultiTabForm: boolean;
    UserType: string;
    UserStatus: integer;
    UserUtf8Support: boolean;
    UserAvatarHash: string;
    procedure TranslateForm;
    procedure CheckMessage_Smilies(var msg: string);
    procedure CheckMessage_BR(var msg: string);
    procedure CheckMessage_ClearTag(var msg: string);
    procedure AddChatText(Nick_Time, Mess_Text: string; MessIn: boolean = false);
    procedure CreateFastReplyMenu;
    function pageIdxAt(x, y: integer): integer;
  end;

var
  ChatForm: TChatForm;
  ChatCSS: string = '<style type="text/css">' +
  'body, span { color: #000000; font: 12px tahoma, verdana; }' +
    'hr { margin: 5px; border: none; color: gray; background-color: gray; height: 1px; }' +
    '.a { font: bold 11px tahoma, verdana; color: blue; }' +
    '.b { font: bold 11px tahoma, verdana; color: red; }' +
    '.c { font: 12px tahoma, verdana; color: black; }' +
    '.d { font: bold 11px tahoma, verdana; color: green; }' +
    '</style>';

implementation

{$R *.dfm}

uses
  MainUnit, SmilesUnit, SettingsUnit, IcqProtoUnit, HistoryUnit,
  IcqContactInfoUnit, UtilsUnit;

function TChatForm.pageIdxAt(x, y: integer): integer;
var
  R: Trect;
begin
  result := 0;
  while result < ChatPageControl.PageCount do
  begin
    SendMessage(ChatPageControl.Handle, TCM_GETITEMRECT, result, Longint(@R));
    if ptInRect(R, point(x, y)) then
      exit;
    inc(result);
  end;
  result := -1;
end;

procedure TChatForm.QRepSpeedButtonClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup(QRepSpeedButton, QMessPopupMenu);
end;

procedure TChatForm.QSpeedButtonClick(Sender: TObject);
var
  i, ii: integer;
begin
  //--Достаём из КЛ последнее сообщение от этого контакта
  with MainForm.ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      for ii := 0 to Categories[i].Items.Count - 1 do
      begin
        if Categories[i].Items[ii].UIN = InfoPanel2.Caption then
        begin
          if Categories[i].Items[ii].QuoteMsg > EmptyStr then
            InputMemo.Lines.Add('> ' + Categories[i].Items[ii].QuoteMsg);
        end;
      end;
    end;
  end;
end;

procedure TChatForm.QuickMessClick(Sender: TObject);
begin
  //--Вставляем в поле ввода текст из меню быстрых ответов
  InputMemo.SelText := TMenuItem(Sender).Hint;
end;

procedure TChatForm.CreateFastReplyMenu;
var
  i: integer;
  list: TStringList;
begin
  //--Создаём временный лист строк
  list := TStringList.Create;
  //--Если файл с быстрыми ответами найден, то загружаем его
  if FileExists(MyPath + 'Profile\QReply.txt') then list.LoadFromFile(MyPath + 'Profile\QReply.txt')
  else
  begin
    //--Иначе добавляем быстрые ответы по умолчанию
    list.Add(QReply1L);
    list.Add(QReply2L);
    list.Add(QReply3L);
  end;
  try
    //--Добаляем быстрые ответы в раздел меню поля ввода текста
    with MemoPopupMenu.Items.Items[0] do
    begin
      for I := 0 to List.Count - 1 do
      begin
        if list.Strings[I] <> EmptyStr then
        begin
          Add(NewItem(list.Strings[I], 0, False, True, QuickMessClick, 0, 'MenuItem' + IntToStr(I)));
          //--Добавляем и в хинты, против глюка акселя
          Items[I].Hint := list.Strings[I];
          //--Назначаем иконку для пункта меню
          Items[I].ImageIndex := 157;
        end;
      end;
    end;
    //--Добавляем быстрые ответы в меню быстрых ответов
    with QmessPopupMenu.Items do
    begin
      for I := 0 to List.Count - 1 do
      begin
        if list.Strings[I] <> EmptyStr then
        begin
          Add(NewItem(list.Strings[I], 0, False, True, QuickMessClick, 0, 'MenuItem' + IntToStr(I)));
          //--Добавляем и в хинты, против глюка акселя
          Items[I].Hint := list.Strings[I];
          //--Назначаем иконку для пункта меню
          Items[I].ImageIndex := 157;
        end;
      end;
    end;
  finally
    list.Free;
  end;
end;

procedure TChatForm.ChatCategoryButtonsButtonClicked(Sender: TObject;
  const Button: TButtonItem);
var
  diff: TdateTime;
begin
  //--Проверяем двойной клик
  diff := now - lastClick;
  lastClick := now;
  if (diff < dblClickTime) and (ButtonInd = Button.Index) then
  begin
    ButtonInd := -1;
    //--В будущем вставка ника в поле ввода для жаббер конференций
    Exit;
  end;
  ButtonInd := Button.Index;
end;

procedure TChatForm.ChatCategoryButtonsContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  FCursor: TPoint;
begin
  Handled := true;
  ChatCategoryButtons.FocusedItem := nil;
  ChatCategoryButtons.SelectedItem := ChatButton;
  GetCursorPos(FCursor);
  //if ChatButton <> nil then MainForm.ICQContactPopupMenu.Popup(FCursor.X + 1, FCursor.Y + 1)
  //else MainForm.RoasterPopupMenu.Popup(FCursor.X + 1, FCursor.Y + 1);
end;

procedure TChatForm.ChatCategoryButtonsHotButton(Sender: TObject;
  const Button: TButtonItem);
begin
  //--Запоминаем над какой кнопкой происходит действие
  if Button <> nil then ChatButton := Button
  else ChatButton := nil;
end;

procedure TChatForm.CheckMessage_Smilies(var msg: string);
var
  ImgTag1, ImgTag2, Cod: string;
  I, II: integer;

  function GenTag(Path: string): string;
  begin
    Result := ImgTag1 + Path + ImgTag2;
  end;

begin
  //--Определяем html тэги для вставки смайлов заместо их текстовых обозначений
  ImgTag1 := '<img src="' + MyPath + 'Smilies\' + CurrentSmiles + '\';
  ImgTag2 := '" ALIGN=ABSMIDDLE BORDER="0">';
  //--Сканируем список кодов смайлов на совпадения
  for I := 1 to SmilesList.Count - 1 do
  begin
    for II := 1 to 20 do
    begin
      Cod := Parse(',', SmilesList.Strings[I], II);
      if Cod > EmptyStr then msg := AnsiReplaceText(msg, Cod, GenTag(IntToStr(I) + '.gif'))
      else Break;
    end;
  end;
end;

procedure TChatForm.CheckMessage_BR(var msg: string);
begin
  //--Заменяем все переходы на новую строку в сообщении на соответствующий тэг
  msg := AnsiReplaceText(msg, #13#10, '<BR>');
end;

procedure TChatForm.CheckMessage_ClearTag(var msg: string);
var
  Doc: string;
begin
  //--Вырезаем таким образом все левые тэги из сообщения оставляя чистый текст
  HTMLMsg.Clear;
  Doc := msg;
  HTMLMsg.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
  HTMLMsg.SelectAll;
  msg := HTMLMsg.SelText;
end;

procedure TChatForm.AddChatText(Nick_Time, Mess_Text: string; MessIn: boolean = false);
var
  Doc: string;
begin
  try
    Doc := HTMLChatViewer.DocumentSource;
    if MessIn then Doc := Doc + '<IMG NAME=i SRC="' + MyPath + 'Icons\' + CurrentIcons + '\inmess.gif" ALIGN=ABSMIDDLE BORDER=0><span class=b> ' + Nick_Time + '</span><br>'
    else Doc := Doc + '<IMG NAME=o' + IntToStr(OutMessIndex) + ' SRC="' + MyPath + 'Icons\' + CurrentIcons + '\outmess1.gif" ALIGN=ABSMIDDLE BORDER=0><span class=a> ' + Nick_Time + '</span><br>';
    Doc := Doc + '<span class=c>' + Mess_Text + '</span><br><br>';
    HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
  except
  end;
end;

procedure TChatForm.InputMemoChange(Sender: TObject);
begin
  //--Убираем из поля ввода текста сишний символ перехода на новую строку
  if InputMemo.Text = #13#10 then InputMemo.Clear;
  //--Отображаем длинну введённого текста
  TextLenPanel.Caption := IntToStr(InputMemo.GetTextLen);
end;

procedure TChatForm.InputMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{var
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
  end;}

begin
  //--Если зажата клавиша контрл и нажата клавиша интер и не нажата кнопка отправки по интер, то отправляем сообщение
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 13) and (not EnterKeyToolButton.Down) then SendMessageBitBtnClick(self);
  //--Если зажата клавиша контрл и нажата клавиша "s", то открываем окно смайлов
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 83) then SmiliesSpeedButtonClick(self);
  //
  {if (GetKeyState(VK_CONTROL) < 0) and (Key = 82) then
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
        Application.ProcessMessages;
      end;
      if not YesConvert then Outbuf := Outbuf + buf[i];
      Application.ProcessMessages;
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
        Application.ProcessMessages;
      end;
      if not YesConvert then Outbuf := Outbuf + buf[i];
      Application.ProcessMessages;
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
  end;}
end;

procedure TChatForm.InputMemoKeyPress(Sender: TObject; var Key: Char);
label
  x;
var
  msgD, msg, UIN: string;
  i, ii: integer;
begin
  //--Если поле идентификатора пользователя пустое, то выходим от сюда (в будущем сделать чтобы закрывалось окно)
  if InfoPanel2.Caption = EmptyStr then Exit;
  //--Если нажата клавиша не интер, то если включен режим звуковой клавиатуры, то воспроизводим звуки
  if key <> #13 then
  begin
    //--Если нажата кнопка звука нажатия клавиш, то играем звуки
    if KeySoundToolButton.Down then
    begin
      try
        if (key = #8) and (InputMemo.Text <> EmptyStr) then
        begin
          if FileExists(MyPath + 'Sounds\' + CurrentSounds + '\Back.wav') then
            sndPlaySound(PChar(MyPath + 'Sounds\' + CurrentSounds + '\Back.wav'), SND_ASYNC);
        end
        else
        begin
          if (key <> #8) then
          begin
            if FileExists(MyPath + 'Sounds\' + CurrentSounds + '\Type.wav') then
              sndPlaySound(PChar(MyPath + 'Sounds\' + CurrentSounds + '\Type.wav'), SND_ASYNC);
          end;
        end;
      except
      end;
    end;
    //--Если нажата кнопка отправки оповещения о печати текста
    if TypingTextToolButton.Down then
    begin
      {if not MainForm.ICQTypeTextTimer.Enabled then
      begin
        UIN := InfoPanel2.Caption;
        //if ICQ_Work_Phaze then ICQ_SendTextTyping(TextTypeForUIN, '02');
        MainForm.ICQTypeTextTimer.Enabled := true;
      end
      else MainForm.ICQTypeTextTimer.Enabled := true;}
    end;
    //--Выходим
    Exit;
  end;
  //--Если нажата клавиша интер и кнопка отправки по интер
  if (Key = #13) and (EnterKeyToolButton.Down) then
    //--Если зажата клавиша Шифт
    if GetKeyState(VK_SHIFT) < 0 then Exit
    else
    begin
      x: ;
      //--Обнуляем символ клавиши
      Key := #0;
      //--Если поле ввода пустое, то выходим
      if InputMemo.GetTextLen = 0 then Exit;
      //--Если нажата кнопка звука нажатия клавиш, то играем звуки
      if KeySoundToolButton.Down then
      begin
        try
          if FileExists(MyPath + 'Sounds\' + CurrentSounds + '\Send.wav') then
            sndPlaySound(PChar(MyPath + 'Sounds\' + CurrentSounds + '\Send.wav'), SND_ASYNC);
        except
        end;
      end;
      //--Узнаём Идентификатор пользователя
      UIN := InfoPanel2.Caption;
      //--Копируем текст сообщения
      msg := InputMemo.Text;
      //--Если тип контакта ICQ, то отправляем сообщение по ICQ протоколу
      if UserType = 'Icq' then
      begin
        //--Если нет подключения к серверу ICQ, то выходим
        if not ICQ_Work_Phaze then Exit;
        //--Заканчиваем оповещение о наборе текста
        //if MainForm.ICQTypeTextTimer.Enabled then MainForm.ICQTypeTextTimerTimer(self);
        //--Если статус пользователя не оффлайн и есть поддержка UTF-8 сообщений, то отправляем сообщение в юникоде.
        //Иначе отправляем сообщение в старом анси формате
        if (UserStatus <> 9) and (UserUtf8Support) then ICQ_SendMessage_0406(UIN, msg, false)
        else ICQ_SendMessage_0406(UIN, msg, true);
      end
      else Exit;
      //--Добавляем сообщение в файл истории и в чат
      msgD := YouAt + ' [' + DateTimeChatMess + ']';
      //--Форматируем сообщение под html формат
      CheckMessage_BR(msg);
      CheckMessage_ClearTag(msg);
      CheckMessage_BR(msg);
      DecorateURL(msg);
      //--Записываем историю в этот контакт
      with MainForm.ContactList do
      begin
        for I := 0 to Categories.Count - 1 do
        begin
          for II := 0 to Categories[I].Items.Count - 1 do
          begin
            if Categories[I].Items[II].UIN = UIN then
            begin
              Categories[I].Items[II].History := Categories[I].Items[II].History +
                '<span class=a>' + msgD + '</span><br><span class=c>' + msg + '</span><br><br>' + #13#10;
              //--Ставим флаг этому контакту, что история изменилась
              Categories[I].Items[II].HistoryChange := true;
            end;
            //--Не замораживаем интерфэйс
            Application.ProcessMessages;
          end;
        end;
      end;
      //--Если включены графические смайлики, то форматируем сообщение под смайлы
      if not TextSmilies then CheckMessage_Smilies(msg);
      //--Увеличиваем счётчик исходящих сообщений
      Inc(OutMessIndex);
      //--Добавляем в чат сообщение
      AddChatText(msgD, msg);
      //--Прокручиваем чат до конца
      HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
      //--Очищаем поле ввода теста
      InputMemo.Clear;
      InputMemoChange(self);
      //--Выходим
      Exit;
    end;
  //--Если нажата клавиша интер и не нажата кнопка отправки по интер и зажата клавиша сонтрл, то переходим к отправке сообщения
  if (Key = #13) and (not EnterKeyToolButton.Down) and (GetKeyState(VK_CONTROL) < 0) then goto x;
  //--Если нажата кнопка "отправить" сообщение
  if (Key = #13) and (not EnterKeyToolButton.Down) and (sender.ClassName = 'TBitBtn') then goto x;
end;

procedure TChatForm.CloseTabAllOfflineClick(Sender: TObject);
label
  x;
var
  i: integer;
begin
  //--Если вкладки есть, то закрываем те что со статусом оффлайн
  with ChatPageControl do
  begin
    if Visible then
    begin
      x: ;
      //--Сканируем вкладки
      for i := 0 to PageCount - 1 do
      begin
        //--Если вкладка оффлайн или не авториз. или статус неизвестен, то закрываем её
        if (Pages[i].ImageIndex = 9) or (Pages[i].ImageIndex = 80) or
          (Pages[i].ImageIndex = 214) then
        begin
          Pages[i].Free;
          //--Прыгаем на повторение скана
          goto x;
        end;
        //--Не замораживаем интерфейс
        Application.ProcessMessages;
      end;
      //--Если вкладки все закрыты, то закрываем окно чата
      if PageCount = 0 then Close
      //--Регулируем высоту вкладок для мультилайн режима
      else Height := ActivePage.Top - 3;
    end;
  end;
end;

procedure TChatForm.CloseTabAllNoCurrentClick(Sender: TObject);
var
  i: integer;
begin
  //--Если вкладки присутствуют, то закрываем все кроме текущей
  with ChatPageControl do
  begin
    if Visible then
    begin
      //--Переводим активную вкладку в самое начало вкладок
      ActivePage.PageIndex := 0;
      //--Закрываем все остальные вкладки в цикле
      if PageCount > 1 then ActivePageIndex := 1;
      for i := 1 to PageCount - 1 do
        if PageCount > 1 then ActivePage.Free;
    end;
  end;
end;

procedure TChatForm.CloseTabAllClick(Sender: TObject);
begin
  //--Закрываем все вкладки чата
  with ChatPageControl do
  begin
    //--Если вкладки активны
    if Visible then
    begin
      //--Прячем компонент вкладок чтобы не мерцал
      Visible := false;
      //--Поочередно закрываем все вкладки
      while PageCount > 0 do ActivePage.Free;
    end;
  end;
  //--Закрываем окно чата
  Close;
end;

procedure TChatForm.CopyMemoClick(Sender: TObject);
begin
  //--Копируем выделенный текст из поля ввода в буфер обмена
  InputMemo.CopyToClipboard;
end;

procedure TChatForm.ChatHTMLQTextClick(Sender: TObject);
var
  Str: string;
begin
  //--Цитируем выделенный текст в поле ввода и подставляем в начало каждой строки символ >
  HTMLChatViewer.CopyToClipboard;
  InputMemo.SelText := '> ';
  InputMemo.PasteFromClipboard;
  InputMemo.Text := Trim(InputMemo.Text);
  Str := AnsiReplaceText(InputMemo.Text, #13#10, #13#10 + '> ');
  InputMemo.Text := Str + #13#10;
  InputMemo.SelStart := InputMemo.GetTextLen;
  if InputMemo.CanFocus then InputMemo.SetFocus;
end;

procedure TChatForm.CopyAllMemoClick(Sender: TObject);
begin
  //--Копируем весь текст из поля ввода в буфер обмена
  InputMemo.SelectAll;
  InputMemo.CopyToClipboard;
end;

procedure TChatForm.PasteMemoClick(Sender: TObject);
begin
  //--Вставляем в поле ввода текст из буфера обмена
  InputMemo.PasteFromClipboard;
end;

procedure TChatForm.ChatPageControlChange(Sender: TObject);
label
  x;
var
  UIN, HistoryFile, Doc: string;
  I, II, N: integer;
begin
  //--Если пустая вкладка, то выходим
  if ChatPageControl.ActivePage = nil then Exit;
  //--Изменяем размер компонента вкладок
  ChatPageControl.Height := ChatPageControl.ActivePage.Top - 3;
  //--Получаем учётную запись контакта
  UIN := ChatPageControl.ActivePage.HelpKeyword;
  //--Помечаем в КЛ, что сообщения от этого контакта прочитаны
  with MainForm.ContactList do
  begin
    for I := 0 to Categories.Count - 1 do
    begin
      for II := 0 to Categories[I].Items.Count - 1 do
      begin
        if Categories[I].Items[II].UIN = UIN then
        begin
          //--Кнопка в КЛ
          Categories[I].Items[II].Msg := false;
          Categories[I].Items[II].ImageIndex := Categories[I].Items[II].Status;
          //--Кнопка во вкладках
          ChatPageControl.ActivePage.Tag := Categories[I].Items[II].Status;
          ChatPageControl.ActivePage.ImageIndex := Categories[I].Items[II].Status;
          InputMemo.Text := Categories[I].Items[II].InputText;
          UserStatus := Categories[I].Items[II].Status;
          UserUtf8Support := Categories[I].Items[II].Utf8Supported;
          UserAvatarHash := Categories[I].Items[II].IconHash;
          //--Тип контакта
          UserType := Categories[I].Items[II].ContactType;
          //--Проверяем загружена ли история уже
          if Categories[I].Items[II].History = EmptyStr then
          begin
            //--Загружаем файл истории сообщений
            HistoryFile := MyPath + 'Profile\History\' + UserType + '_' + UIN + '.z';
            if FileExists(HistoryFile) then
            begin
              try
                //--Распаковываем файл с историей
                UnZip_File(HistoryFile, MyPath + 'Profile\History\');
                //--Записываем историю в хранилище у этого контакта
                Categories[I].Items[II].History := ReadFromFile(MyPath + 'Profile\History\Icq_History.htm');
                //--Удаляем уже не нужный распакованный файл с историей
                if FileExists(MyPath + 'Profile\History\Icq_History.htm') then DeleteFile(MyPath + 'Profile\History\Icq_History.htm');
              except
              end;
            end;
          end;
          //--Отображаем историю в чате
          if Categories[I].Items[II].History <> EmptyStr then
          begin
            //--Очищаем чат от другой истории
            HTMLChatViewer.Clear;
            //--Добавляем стили
            Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
            //--Загружаем из файла истории указанное количесво сообщений
            Doc := Doc + TailLineTail(Categories[I].Items[II].History, 5);
            if not TextSmilies then CheckMessage_Smilies(Doc);
            SetLength(Doc, Length(Doc) - 6);
            Doc := Doc + '<HR>';
            HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
            //--Ставим каретку в самый низ текста
            HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
            HTMLChatViewer.CaretPos := Length(Doc);
          end
          else
          begin
            //--Очищаем чат от другой истории
            HTMLChatViewer.Clear;
            //--Добавляем стили
            Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
            HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
          end;
          //--Выходим из цыкла если нашли контакт
          goto x;
        end;
        //--Не замораживаем интерфэйс
        Application.ProcessMessages;
      end;
    end;
  end;
  x: ;
  //--Ставим флаг о том что непрочитанных сообщений во вкладке нет
  ChatPageControl.ActivePage.Margins.Left := 0;
  //--Ставим имя и фамилию в информационное поле
  InfoPanel1.Caption := NameAndLast(UIN);
  if InfoPanel1.Caption = EmptyStr then InfoPanel1.Caption := ChatPageControl.ActivePage.Caption;
  //--Ставим учётную запись контакта в информационное поле
  InfoPanel2.Caption := UIN;
  //--Ставим курсор в мемо после последнего символа
  InputMemo.SelStart := InputMemo.GetTextLen;
  //--Ставим фокус в поле ввода текста
  if (InputMemo.CanFocus) and (ChatForm.Visible) then InputMemo.SetFocus;
  //--Удаляем отметку о сообщении из списка очереди входящих сообщений
  try
    N := InMessList.IndexOf(UIN);
    if N > -1 then InMessList.Delete(N);
  except
  end;
  //--Загружаем аватар
  {if (Length(UserAvatarHash) = 32) and ((FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')) or
    (FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.gif')) or
    (FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.bmp'))) then
  begin
    if FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.jpg') then
      ContactImage.Picture.LoadFromFile(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.jpg')
    else if FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.gif') then
      ContactImage.Picture.LoadFromFile(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.gif')
    else if FileExists(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.bmp') then
      ContactImage.Picture.LoadFromFile(MyPath + 'Profile\Avatars\' + UserAvatarHash + '.bmp');
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
  end;}
end;

procedure TChatForm.ChatPageControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  diff: TdateTime;
begin
  //--Обрабатываем нажатия кнопок мыши по вкладке
  case button of
    mbRight: //--Если нажали правой клавишей мыши
      begin
        i := pageIdxAt(x, y);
        if i < 0 then Exit;
        //
      end;
    mbLeft: //--Если нажали левой клавишей мыши
      begin
        //--Проверяем двойной клик
        diff := now - lastClick;
        lastClick := now;
        //--Если двойной клик, то закрываем вкладку и выходим
        if (diff < dblClickTime) and (ButtonInd = ChatPageControl.ActivePageIndex) then
        begin
          ButtonInd := -1;
          CloseTabBitBtnClick(self);
          Exit;
        end;
        //--Запоминаем индекс нажатой вкладки
        ButtonInd := ChatPageControl.ActivePageIndex;
      end;
    mbMiddle: //--Если нажали средней клавишей мыши
      begin
        i := pageIdxAt(x, y);
        if i < 0 then Exit;
        //
      end;
  end;
end;

procedure TChatForm.ChatPageControlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  //--Вычисляем над какой вкладкой у нас курсор, чтобы показать подсказку
  if pageIdxAt(X, Y) <> HintInd then Application.CancelHint;
  //--Присваиваем подсказку для контакта компоненту вкладок
  ChatPageControl.Hint := ChatPageControl.Pages[pageIdxAt(X, Y)].Hint;
  //--Запоминаем индекс вкладки с подсказкой
  HintInd := pageIdxAt(X, Y);
end;

procedure TChatForm.SearchAvatarTimerTimer(Sender: TObject);
begin
  {//--JPG
  if (FileExists(Mypath + 'Users\Avatars\' + UserAvatarHash + '.jpg')) then
  begin
    self.SearchAvatarTimer.Enabled := false;
    self.MyAvatarImage.Picture.LoadFromFile(Mypath + 'Users\Avatars\' + UserAvatarHash + '.jpg');
    Exit;
  end;
  //--GIF
  if (FileExists(Mypath + 'Users\Avatars\' + UserAvatarHash + '.gif')) then
  begin
    self.SearchAvatarTimer.Enabled := false;
    self.MyAvatarImage.Picture.LoadFromFile(Mypath + 'Users\Avatars\' + UserAvatarHash + '.gif');
    Exit;
  end;
  //--BMP
  if (FileExists(Mypath + 'Users\Avatars\' + UserAvatarHash + '.bmp')) then
  begin
    self.SearchAvatarTimer.Enabled := false;
    self.MyAvatarImage.Picture.LoadFromFile(Mypath + 'Users\Avatars\' + UserAvatarHash + '.bmp');
    Exit;
  end;}
end;

procedure TChatForm.SendAllClick(Sender: TObject);
begin
  //--
  ShowMessage(DevelMess);
end;

procedure TChatForm.SendAllOnlineClick(Sender: TObject);
begin
  //--
  ShowMessage(DevelMess);
end;

procedure TChatForm.SendFileSpeedButtonClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TChatForm.SendMessageBitBtnClick(Sender: TObject);
var
  k: Char;
begin
  //--Вызываем событие нажатия клавиши интер для поля ввода текста
  k := #13;
  InputMemoKeyPress(Sender, k);
  //--Ставим фокус курсора в поле ввода
  if (ChatForm.InputMemo.CanFocus) and (ChatForm.Visible) then ChatForm.InputMemo.SetFocus;
end;

procedure TChatForm.MyAvatarPanelSpeedButtonClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  //--Прячем панель с аватаркой
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
end;

procedure TChatForm.InfoContactSpeedButtonClick(Sender: TObject);
begin
  //--Открываем окно информации о контакте
  if not Assigned(IcqContactInfoForm) then IcqContactInfoForm := TIcqContactInfoForm.Create(MainForm);
  //--Присваиваем UIN инфу которого хотим смотреть
  IcqContactInfoForm.ReqUIN := InfoPanel2.Caption;
  //--Загружаем информацию о нем
  IcqContactInfoForm.LoadUserUnfo;
  //--Отображаем окно на передний план
  if IcqContactInfoForm.Visible then ShowWindow(IcqContactInfoForm.Handle, SW_RESTORE);
  IcqContactInfoForm.Show;
  SetForeGroundWindow(IcqContactInfoForm.Handle);
end;

procedure TChatForm.EditContactSpeedButtonClick(Sender: TObject);
begin
  //--
  ShowMessage(DevelMess);
end;

procedure TChatForm.ChatSplitterMoved(Sender: TObject);
begin
  //--
  MyAvatarPanelSpeedButton.Refresh;
  MyAvatarPanel.Refresh;
end;

procedure TChatForm.ChatFontToolButtonClick(Sender: TObject);
begin
  //--
  ShowMessage(DevelMess);
end;

procedure TChatForm.ChatSettingsToolButtonClick(Sender: TObject);
begin
  //--Отображаем окно настроек в разделе окно сообщений
  if Assigned(SettingsForm) then
  begin
    //--Отображаем окно
    SettingsForm.Show;
    //--Активируем раздел
    SettingsForm.JvPageList1.ActivePageIndex := 2;
    SettingsForm.SettingButtonGroup.ItemIndex := 2;
    //--Выводим окно на самый передний план, против глюков в вин и вайн
    SetForeGroundWindow(SettingsForm.Handle);
  end;
end;

procedure TChatForm.TranslateForm;
begin
  //--Переводим форму на другие языки

end;

procedure TChatForm.TypingTextToolButtonClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TChatForm.FormActivate(Sender: TObject);
label
  x;
var
  i, ii, N: integer;
begin
  //--Сбрасываем иконку сообщения в КЛ
  if Assigned(MainForm) then
  begin
    with MainForm.ContactList do
    begin
      for i := 0 to Categories.Count - 1 do
      begin
        for ii := 0 to Categories[i].Items.Count - 1 do
        begin
          if Categories[i].Items[ii].UIN = InfoPanel2.Caption then
          begin
            Categories[i].Items[ii].Msg := false;
            Categories[i].Items[ii].ImageIndex := Categories[i].Items[ii].Status;
            goto x;
          end;
          Application.ProcessMessages;
        end;
      end;
    end;
    //--Удаляем отметку о сообщении из списка очереди входящих сообщений
    try
      N := InMessList.IndexOf(InfoPanel2.Caption);
      if N > -1 then InMessList.Delete(N);
    except
    end;
  end;
  x: ;
  //--Сбрасываем иконку в активной вкладке в окне чата
  if ChatPageControl.ActivePage = nil then Exit;
  ChatPageControl.ActivePage.Margins.Left := 0;
  ChatPageControl.ActivePage.ImageIndex := ChatPageControl.ActivePage.Tag;
end;

procedure TChatForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //--Выводим на передний план окно со списком контактов
  BringWindowToTop(MainForm.Handle);
end;

procedure TChatForm.FormCreate(Sender: TObject);
begin
  //--Инициализируем XML
  with TrXML.Create() do try
    //--Загружаем настройки
    if FileExists(MyPath + SettingsFileName) then begin
      LoadFromFile(MyPath + SettingsFileName);
      //--Загружаем позицию окна
      if OpenKey('settings\forms\chatform\position') then try
        Top := ReadInteger('top');
        Left := ReadInteger('left');
        Height := ReadInteger('height');
        Width := ReadInteger('width');
        //--Загружаем позицию сплитеров
        BottomChatFormPanel.Height := ReadInteger('chat-splitter', 130);
        ChatCategoryButtons.Width := ReadInteger('group-splitter', 130);
        //--Определяем не находится ли окно за пределами экрана
        while Top + Height > Screen.Height do
          Top := Top - 50;
        while Left + Width > Screen.Width do
          Left := Left - 50;
      finally
        CloseKey();
      end;

      //--Загружаем "отправлять по интер"
      if OpenKey('settings\forms\chatform\send-enter') then try
        EnterKeyToolButton.Down := ReadBool('value');
      finally
        CloseKey();
      end;

      //--Загружаем отправлять отчёт о печати текста
      if OpenKey('settings\forms\chatform\send-typing-notify') then try
        TypingTextToolButton.Down := ReadBool('value');
      finally
        CloseKey();
      end;

      //--Загружаем "звук нажатия клавиш"
      if OpenKey('settings\forms\chatform\key-sound') then try
        KeySoundToolButton.Down := ReadBool('value');
      finally
        CloseKey();
      end;

      //--Загружаем состояние панелей аватар
      if OpenKey('settings\forms\chatform\avatar-panels') then try
        ContactAvatarPanel.Width := ReadInteger('contact-avatar', 68);
        if ContactAvatarPanel.Width = 0 then begin
          ContactAvatarPanelSpeedButton.NumGlyphs := 1;
          InfoPanel1.Left := 9;
          InfoPanel3.Left := 9;
          InfoPanel1.Width := Width - 238;
          InfoPanel3.Width := InfoPanel1.Width;
        end;
        MyAvatarPanel.Width := ReadInteger('my-avatar', 68);
        if MyAvatarPanel.Width = 0 then
          MyAvatarPanelSpeedButton.NumGlyphs := 4;
      finally
        CloseKey();
      end;
    end;
  finally
    Free();
  end;
  //--Включаем двойной буферинг для вкладок
  ChatPageControl.DoubleBuffered := true;
  //--Устанавливаем начальный индекс подсказки
  HintInd := -1;
  //--Присваиваем окну и кнопкам иконки
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
  //--Создаём хранитель картинки пустой аватары для быстрого её отображения
  NoAvatar := TImage.Create(MainForm);
  if FileExists(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif') then
    NoAvatar.Picture.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\noavatar.gif');
  //--Создаём иконки подтвержения сообщений
  OutMessage2 := TMemoryStream.Create;
  if FileExists(MyPath + 'Icons\' + CurrentIcons + '\outmess2.gif') then
    OutMessage2.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\outmess2.gif');
  //
  OutMessage3 := TMemoryStream.Create;
  if FileExists(MyPath + 'Icons\' + CurrentIcons + '\outmess3.gif') then
    OutMessage3.LoadFromFile(MyPath + 'Icons\' + CurrentIcons + '\outmess3.gif');
  //--Присваиваем картинку пустой аватары в места для аватар
  ContactAvatarImage.Picture.Assign(NoAvatar.Picture);
  MyAvatarImage.Picture.Assign(NoAvatar.Picture);
  //--Переводим форму на другие языки
  TranslateForm;
  //--Создаём меню быстрых ответов
  CreateFastReplyMenu;
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //--Делаем окно прилипающим к краям экрана
  ScreenSnap := true;
  //--Пока скрываем всегда отображение участников конференции
  ChatCategoryButtons.Visible := false;
  GroupSplitter.Visible := false;
end;

procedure TChatForm.FormDestroy(Sender: TObject);
begin
  //--Создаём необходимые папки
  ForceDirectories(MyPath + 'Profile');
  //--Сохраняем настройки положения окна чата в xml
  with TrXML.Create() do try
    if FileExists(MyPath + SettingsFileName) then
      LoadFromFile(MyPath + SettingsFileName);
    //--Сохраняем позицию окна
    if OpenKey('settings\forms\chatform\position', True) then try
      WriteInteger('top', Top);
      WriteInteger('left', Left);
      WriteInteger('height', Height);
      WriteInteger('width', Width);
      //--Сохраняем позицию сплитеров
      WriteInteger('chat-splitter', BottomChatFormPanel.Height);
      WriteInteger('group-splitter', ChatCategoryButtons.Width);
    finally
      CloseKey();
    end;

    //--Сохраняем "отправлять по интер"
    if OpenKey('settings\forms\chatform\send-enter', True) then try
      WriteBool('value', EnterKeyToolButton.Down);
    finally
      CloseKey();
    end;

    //--Сохраняем отправлять отчёт о печати текста
    if OpenKey('settings\forms\chatform\send-typing-notify', True) then try
      WriteBool('value', TypingTextToolButton.Down);
    finally
      CloseKey();
    end;

    //--Сохраняем "звук нажатия клавиш"
    if OpenKey('settings\forms\chatform\key-sound', True) then try
      WriteBool('value', KeySoundToolButton.Down);
    finally
      CloseKey();
    end;

    //--Сохраняем состояние панелей аватар
    if OpenKey('settings\forms\chatform\avatar-panels', True) then try
      WriteInteger('contact-avatar', ContactAvatarPanel.Width);
      WriteInteger('my-avatar', MyAvatarPanel.Width);
    finally
      CloseKey();
    end;

    //--Записываем сам файл
    SaveToFile(MyPath + SettingsFileName);
  finally
    Free();
  end;
end;

procedure TChatForm.FormResize(Sender: TObject);
begin
  //--Если пустая вкладка, то выходим
  if ChatPageControl.ActivePage = nil then Exit;
  //--Регулируем высоту вкладок для мультилайн режима
  ChatPageControl.Height := ChatPageControl.ActivePage.Top - 3;
end;

procedure TChatForm.HtmlPopupMenuPopup(Sender: TObject);
begin
  //--Проверяем есть ли выделенный текст в истории чата
  if HTMLChatViewer.SelLength = 0 then
  begin
    ChatHTMLTextCopy.Enabled := false;
    ChatHTMLQText.Enabled := false;
  end
  else
  begin
    ChatHTMLTextCopy.Enabled := true;
    ChatHTMLQText.Enabled := true;
  end;
end;

procedure TChatForm.HistorySpeedButtonClick(Sender: TObject);
begin
  //--Открываем окно истории
  if not Assigned(HistoryForm) then HistoryForm := THistoryForm.Create(self);
  //--Загружаем файл истории для текущего чата
  HistoryForm.LoadHistoryFromFile(InfoPanel2.Caption);
  //--Отображаем окно на передний план
  ShowWindow(HistoryForm.Handle, SW_RESTORE);
  HistoryForm.Show;
  SetForeGroundWindow(HistoryForm.Handle);
end;

procedure TChatForm.HistorySpeedButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //--Открываем меню над этим элементом
  if Button = mbRight then Popup(HistorySpeedButton, HistoryShowPopupMenu);
end;

procedure TChatForm.HTMLChatViewerHotSpotClick(Sender: TObject; const SRC: string;
  var Handled: Boolean);
begin
  Handled := true;
  //--Открываем ссылку из чата во внешнем браузере
  ShellExecute(Application.Handle, 'open', PChar(SRC), nil, nil, SW_SHOWNORMAL);
end;

procedure TChatForm.HTMLChatViewerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //--При нажатии комбинации клавиш контрл + с в истории чата
  //копируем выделенный текст в буфер обмена
  if (GetKeyState(VK_CONTROL) < 0) and (Key = 67) then
  begin
    HTMLChatViewer.CopyToClipboard;
  end;
end;

procedure TChatForm.SmiliesSpeedButtonClick(Sender: TObject);
var
  xPoint: TPoint;
begin
  //--Если окно не создано ещё, то создаём его
  if not Assigned(SmilesForm) then SmilesForm := TSmilesForm.Create(MainForm);
  //--Вычисляем позицию над вызывающим контролом
  xPoint := Point(SmiliesSpeedButton.Width, SmiliesSpeedButton.Top);
  with SmiliesSpeedButton.ClientToScreen(xPoint) do
  begin
    SmilesForm.Left := X - SmiliesSpeedButton.Width;
    SmilesForm.Top := (Y - SmilesForm.Height) - 2;
  end;
  {//--Отображаем окно смайлов
  SmilesForm.Show;
  //--Выводим окно на самый передний план, против глюков в вин и вайн
  SetForeGroundWindow(SmilesForm.Handle);
  BringWindowToTop(SmilesForm.Handle);}
  SetWindowPos(SmilesForm.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
    SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOREDRAW or SWP_NOSENDCHANGING);
  SmilesForm.Show;
end;

procedure TChatForm.SendMessageSpeedButtonDropClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup_down(SendMessageSpeedButtonDrop, SendPopupMenu);
end;

procedure TChatForm.ContactAvatarPanelSpeedButtonClick(Sender: TObject);
var
  FCursor: TPoint;
begin
  //--Прячем панель с аватаркой
  GetCursorPos(FCursor);
  if ContactAvatarPanelSpeedButton.NumGlyphs = 4 then
  begin
    ContactAvatarPanel.Width := 0;
    ContactAvatarPanelSpeedButton.NumGlyphs := 1;
    SetCursorPos(FCursor.X - 68, FCursor.Y);
    InfoPanel1.Left := ContactAvatarPanelSpeedButton.Left + 8;
    InfoPanel3.Left := InfoPanel1.Left;
    InfoPanel1.Width := InfoPanel2.Left - 15;
    InfoPanel3.Width := InfoPanel1.Width;
  end
  else
  begin
    ContactAvatarPanel.Width := 68;
    ContactAvatarPanelSpeedButton.NumGlyphs := 4;
    SetCursorPos(FCursor.X + 68, FCursor.Y);
    InfoPanel1.Left := ContactAvatarPanelSpeedButton.Left + 8;
    InfoPanel3.Left := InfoPanel1.Left;
    InfoPanel1.Width := InfoPanel2.Left - 83;
    InfoPanel3.Width := InfoPanel1.Width;
  end;
end;

procedure TChatForm.ContactMenuToolButtonClick(Sender: TObject);
begin
  ShowMessage(DevelMess);
end;

procedure TChatForm.ClearChatSpeedButtonClick(Sender: TObject);
var
  Doc: string;
begin
  //--Очищаем окно чата от истории сообщений
  HTMLChatViewer.Clear;
  Doc := EmptyStr;
  HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
end;

procedure TChatForm.CloseTabBitBtnClick(Sender: TObject);
begin
  //--Закрываем вкладку чата
  if (ChatPageControl.Visible) and (ChatPageControl.PageCount > 0) then
  begin
    ChatPageControl.ActivePage.Free;
    //--Если вкладок больше нет, то закрываем окно
    if ChatPageControl.PageCount = 0 then Close
    else ChatPageControlChange(self);
  end;
end;

procedure TChatForm.CloseTabSpeedButtonDropClick(Sender: TObject);
begin
  //--Открываем меню над этим элементом
  Popup_down(CloseTabSpeedButtonDrop, CloseTabPopupMenu);
end;

procedure TChatForm.ShowAllHistoryClick(Sender: TObject);
label
  x;
var
  Doc: string;
  I, II: integer;
begin
  //--Проверяем состояние истории для этого контакта
  with MainForm.ContactList do
  begin
    for I := 0 to Categories.Count - 1 do
    begin
      for II := 0 to Categories[I].Items.Count - 1 do
      begin
        if Categories[I].Items[II].UIN = InfoPanel2.Caption then
        begin
          //--Проверяем загружена ли история уже
          if Categories[I].Items[II].History = EmptyStr then goto x;
          //--Отображаем историю в чате
          if Categories[I].Items[II].History <> EmptyStr then
          begin
            //--Очистили компонент истории и выводим надпись, что история загружается
            Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
            Doc := Doc + '<span class=b>' + HistoryLoadFileL + '</span>';
            HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
            HTMLChatViewer.Refresh;
            //--Добавляем стили
            Doc := '<html><head>' + ChatCSS + '<title>Chat</title></head><body>';
            //--Загружаем из файла истории указанное количесво сообщений
            if (Sender as TMenuItem).Tag = 1 then Doc := Doc + Categories[I].Items[II].History
            else if (Sender as TMenuItem).Tag = 2 then Doc := Doc + TailLineTail(Categories[I].Items[II].History, 100)
            else if (Sender as TMenuItem).Tag = 3 then Doc := Doc + TailLineTail(Categories[I].Items[II].History, 50)
            else if (Sender as TMenuItem).Tag = 4 then Doc := Doc + TailLineTail(Categories[I].Items[II].History, 20);
            if not TextSmilies then ChatForm.CheckMessage_Smilies(Doc);
            SetLength(Doc, Length(Doc) - 6);
            Doc := Doc + '<HR>';
            HTMLChatViewer.LoadFromBuffer(PChar(Doc), Length(Doc), EmptyStr);
            //--Ставим каретку в самый низ текста
            HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
            HTMLChatViewer.CaretPos := Length(Doc);
          end;
          //--Выходим из цыкла если нашли контакт
          goto x;
        end;
        //--Не замораживаем интерфэйс
        Application.ProcessMessages;
      end;
    end;
  end;
  x: ;
end;

procedure TChatForm.ChatHTMLTextCopyClick(Sender: TObject);
begin
  //--Копируем выделенный текст в буфер обмена
  HTMLChatViewer.CopyToClipboard;
end;

procedure TChatForm.MemoPopupMenuPopup(Sender: TObject);
begin
  //--Управляем пунктами меню
  if InputMemo.SelLength = 0 then
  begin
    CutMemo.Enabled := false;
    CopyMemo.Enabled := false;
  end
  else
  begin
    CutMemo.Enabled := true;
    CopyMemo.Enabled := true;
  end;
end;

procedure TChatForm.CutMemoClick(Sender: TObject);
begin
  //--Вырезаем в буфер обмена
  InputMemo.CutToClipboard;
end;

procedure TChatForm.ChatHTMLAllTextCopyClick(Sender: TObject);
begin
  //--Выделяем всё и копируем в буфер обмена
  HTMLChatViewer.SelectAll;
  HTMLChatViewer.CopyToClipboard;
end;

end.

