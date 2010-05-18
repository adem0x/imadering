{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit RosterUnit;

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
  ComCtrls,
  JvExComCtrls,
  JvListView,
  CategoryButtons,
  Menus,
  ExtCtrls,
  StdCtrls,
  Buttons,
  JvSimpleXml;

type
  TRosterForm = class(TForm)
    RosterJvListView: TJvListView;
    RosterPopupMenu: TPopupMenu;
    BottomPanel: TPanel;
    UINEdit: TEdit;
    SearchBitBtn: TBitBtn;
    UINLabel: TLabel;
    RosterSendMessMenu: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure RosterJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
    procedure SearchBitBtnClick(Sender: TObject);
    procedure RosterSendMessMenuClick(Sender: TObject);
    procedure RosterPopupMenuPopup(Sender: TObject);
    procedure FormDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure TranslateForm;
    function ClearContacts(CType: string): Boolean;
    procedure UpdateFullCL;
    function ReqRosterItem(CId: string): TListItem;
    function ReqCLContact(CId: string): TButtonItem;
    function ReqChatPage(CId: string): TToolButton;
    procedure RosterItemSetFull(SItem: TListItem);
    procedure OpenChatPage(CButton: TButtonItem; UIN: string = '');
    procedure DellcIdInMessList(CId: string);
  end;

{$ENDREGION}

var
  RosterForm: TRosterForm;

implementation

{$R *.dfm}
{$REGION 'MyUses'}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  VarsUnit,
  ChatUnit,
  OverbyteIcsUrl;

{$ENDREGION}
{$REGION 'TranslateForm'}

procedure TRosterForm.TranslateForm;
begin
  // Создаём шаблон для перевода
  // CreateLang(Self);
  // Применяем язык
  SetLang(Self);
end;

{$ENDREGION}
{$REGION 'ReqChatPage'}

function TRosterForm.ReqChatPage(CId: string): TToolButton;
var
  I: Integer;
begin
  Result := nil;
  // Ищем вкладку в окне чата
  if Assigned(ChatForm) then
    begin
      with ChatForm.ChatPageToolBar do
        begin
          for I := 0 to ButtonCount - 1 do
            begin
              if Buttons[I].HelpKeyword = CId then
                begin
                  Result := Buttons[I];
                  // Выходим из цикла
                  Break;
                end;
            end;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'DellcIdInMessList'}

procedure TRosterForm.DellcIdInMessList(CId: string);
var
  I: Integer;
begin
  // Удаляем отметку о сообщении из списка очереди входящих сообщений
  if Assigned(V_InMessList) then
    begin
      with V_InMessList do
        begin
          for I := 0 to Count - 1 do
            begin
              if Strings[I] = CId then
                begin
                  Delete(I);
                  Break;
                end;
            end;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'OpenChatPage'}

procedure TRosterForm.OpenChatPage(CButton: TButtonItem; UIN: string = '');
label
  A;
var
  ChatTab: TToolButton;
  I: Integer;
  RosterItem: TListItem;
begin
  // Если окно чата не создано, то создаём его
  if not Assigned(ChatForm) then
    ChatForm := TChatForm.Create(MainForm);
  with ChatForm do
    begin
      // Сохраняем набранный текст для этой вкладки
      Save_Input_Text(InfoPanel2.Caption);
      with ChatPageToolBar do
        begin
          // Удаляем кнопку с меткой удаления (против глюка в Wine)
          if (ButtonCount = 1) and (Buttons[0].AutoSize = False) then
            RemoveChatPageButton(Buttons[0]);
          // Если это кнопка
          if (CButton <> nil) and (UIN = EmptyStr) then
            begin
              // Ищем вкладку в табе
              for I := 0 to ButtonCount - 1 do
                begin
                  if Buttons[I].HelpKeyword = CButton.UIN then
                    begin
                      Buttons[I].Down := True;
                      CreateNewChat(Buttons[I]);
                      // Выходим из цикла
                      goto A;
                    end;
                end;
              // Если вкладку не нашли, то создаём её
              ChatTab := TToolButton.Create(nil);
              ChatTab.Parent := ChatPageToolBar;
              ChatTab.Caption := CButton.Caption;
              ChatTab.HelpKeyword := CButton.UIN;
              ChatTab.ShowHint := True;
              ChatTab.Hint := CButton.Hint;
              ChatTab.Style := TbsCheck;
              ChatTab.AutoSize := True;
              ChatTab.Grouped := True;
              ChatTab.ImageIndex := CButton.Status;
              ChatTab.OnMouseDown := ToolButtonMouseDown;
              ChatTab.OnMouseUp := ToolButtonMouseUp;
              ChatTab.OnContextPopup := ToolButtonContextPopup;
              ChatTab.Down := True;
              ChatTab.PopupMenu := TabPopupMenu;
              CreateNewChat(ChatTab);
            end
          else if (CButton = nil) and (UIN <> EmptyStr) then
            begin
              // Ищем вкладку в табе
              for I := 0 to ButtonCount - 1 do
                begin
                  if Buttons[I].HelpKeyword = UIN then
                    begin
                      Buttons[I].Down := True;
                      CreateNewChat(Buttons[I]);
                      // Выходим из цикла
                      goto A;
                    end;
                end;
              // Ищем этот UIN в Ростере
              RosterItem := RosterForm.ReqRosterItem(UIN);
              // Если вкладку не нашли, то создаём её
              ChatTab := TToolButton.Create(nil);
              ChatTab.Parent := ChatPageToolBar;
              ChatTab.Caption := URLDecode(RosterItem.SubItems[0]);
              ChatTab.HelpKeyword := RosterItem.Caption;
              ChatTab.ShowHint := True;
              ChatTab.Hint := URLDecode(RosterItem.SubItems[34]);
              ChatTab.Style := TbsCheck;
              ChatTab.AutoSize := True;
              ChatTab.Grouped := True;
              ChatTab.ImageIndex := StrToInt(RosterItem.SubItems[6]);
              ChatTab.OnMouseDown := ToolButtonMouseDown;
              ChatTab.OnMouseUp := ToolButtonMouseUp;
              ChatTab.OnContextPopup := ToolButtonContextPopup;
              ChatTab.Down := True;
              ChatTab.PopupMenu := TabPopupMenu;
              CreateNewChat(ChatTab);
            end;
        end;
    A :;
      // Испраляем глюк тулбара закладок чата (те кто писал ComCtrls.pas - пиздюки)
      ChatPageToolBar.Realign;
      // Отображаем окно сообщений
      XShowForm(ChatForm);
      // Ставим фокус в поле ввода текста
      if (InputRichEdit.CanFocus) and (Visible) then
        InputRichEdit.SetFocus;
    end;
end;

{$ENDREGION}
{$REGION 'RosterItemSetFull'}

procedure TRosterForm.RosterItemSetFull(SItem: TListItem);
var
  I: Integer;
begin
  for I := 1 to RosterJvListView.Columns.Count - 1 do
    begin
      case I of
        7, 8, 9: SItem.SubItems.Add('-1');
        19, 20, 36: SItem.SubItems.Add('0');
      else SItem.SubItems.Add('');
      end;
    end;
end;

{$ENDREGION}
{$REGION 'RosterJvListViewGetImageIndex'}

procedure TRosterForm.RosterJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
begin
  // Выставляем иконки в Ростере
  if (Item.SubItems[3] = C_Icq) and (Length(Item.Caption) = 4) then
    Item.ImageIndex := 227
  else if Item.SubItems[3] = C_Icq then
    Item.ImageIndex := 81
  else if Item.SubItems[3] = C_Jabber then
    Item.ImageIndex := 43
  else if Item.Caption = C_NoCL then
    Item.ImageIndex := 227
  else if (Item.SubItems[3] = C_Mra) and (Length(Item.Caption) < 4) and (Item.SubItems[0] = EmptyStr) then
    Item.ImageIndex := 227
  else if Item.SubItems[3] = C_Mra then
    Item.ImageIndex := 66;
end;

{$ENDREGION}
{$REGION 'Other'}

procedure TRosterForm.RosterPopupMenuPopup(Sender: TObject);
begin
  // Проверяем условия доступности действий
  if RosterJvListView.Selected <> nil then
    begin
      if (Length(RosterJvListView.Selected.Caption) <= 4) and (RosterJvListView.Selected.SubItems[0] = EmptyStr) then
        RosterSendMessMenu.Enabled := False
      else
        RosterSendMessMenu.Enabled := True;
    end
  else
    RosterSendMessMenu.Enabled := False;
end;

procedure TRosterForm.RosterSendMessMenuClick(Sender: TObject);
begin
  // Открываем чат с этим контактом (если это контакт)
  OpenChatPage(nil, RosterJvListView.Selected.Caption);
end;

procedure TRosterForm.SearchBitBtnClick(Sender: TObject);
var
  RosterItem: TListItem;
begin
  // Выделяем в списке искомую строку
  RosterItem := ReqRosterItem(UINEdit.Text);
  RosterJvListView.Selected := RosterItem;
  if RosterItem <> nil then
    begin
      RosterItem.MakeVisible(True);
      RosterJvListView.ItemFocused := RosterItem;
      if RosterJvListView.CanFocus then
        RosterJvListView.SetFocus;
    end;
end;

function TRosterForm.ReqRosterItem(CId: string): TListItem;
begin
  // Обрабатываем запись в Ростере
  Result := RosterJvListView.FindCaption(-1, CId, False, False, False);
end;

procedure TRosterForm.FormDblClick(Sender: TObject);
begin
  // Устанавливаем перевод
  TranslateForm;
end;

{$ENDREGION}
{$REGION 'UpdateFullCL'}

procedure TRosterForm.UpdateFullCL;
label
  X,
  A;
var
  I, C, Cc, S: Integer;
  JvXML: TJvSimpleXml;
  XML_Node: TJvSimpleXmlElem;
begin
  // Обрабатываем весь Ростер
  with RosterJvListView do
    begin
      with MainForm.ContactList do
        begin
          // Начинаем обновление КЛ
          Categories.BeginUpdate;
          // Сканируем Ростер
          for I := 0 to Items.Count - 1 do
            begin
              // Получаем статус контакта заранее
              S := StrToInt(Items[I].SubItems[6]);
              // Добавляем Jabber контакты в КЛ --------------------------------------------------------------------------------------------------------------------------
              if Items[I].SubItems[3] = C_Jabber then
                begin
                  // Ищем группу контакта в КЛ
                  for C := 0 to Categories.Count - 1 do
                    begin
                      // Если такую группу нашли
                      if (Categories[C].GroupCaption = URLDecode(Items[I].SubItems[1])) and (Categories[C].GroupType = C_Jabber) then
                        begin
                          // Начинаем поиск в ней этого контакта
                          for Cc := 0 to Categories[C].Items.Count - 1 do
                            begin
                              if Categories[C].Items[Cc].UIN = Items[I].Caption then
                                begin
                                  with Categories[C].Items[Cc] do
                                    begin
                                      // Обновляем информацию для этого контакта в КЛ
                                      Status := S;
                                      ImageIndex := S;
                                      // Если статус в сети
                                      if (Status <> 30) and (Status <> 41) and (Status <> 42) then
                                        begin
                                          // Поднимаем этот контакт вверх группы
                                          index := 0;
                                          // Назначаем ему синий цвет
                                          NickColor := 2;
                                        end
                                      else // Если статус не в сети и скрывать оффлайн контакты
                                        begin
                                          if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) then
                                            Free
                                          else
                                          begin
                                            // Опускаем контакт в конец группы
                                            index := Categories[C].Items.Count - 1;
                                            // Назначаем ему темнокрасный цвет
                                            if Categories[C].GroupId <> C_NoCL then
                                              NickColor := 1
                                            else
                                              NickColor := 0;
                                          end;
                                        end;
                                    end;
                                  // Продолжаем сканирование Ростера
                                  goto X;
                                end;
                            end;
                          // Определяем режим КЛ
                          if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) and ((S = 30) or (S = 41) or (S = 42)) then
                            goto X;
                          // Добавляем контакт в эту группу в КЛ
                          with Categories[C].Items.Add do
                            begin
                              Caption := URLDecode(Items[I].SubItems[0]);
                              UIN := Items[I].Caption;
                              Status := S;
                              ImageIndex := S;
                              XImageIndex := -1;
                              CImageIndex := -1;
                              ContactType := C_Jabber;
                              if Categories[C].GroupId <> C_NoCL then
                                NickColor := 1
                              else
                                NickColor := 0;
                            end;
                          // Продолжаем сканирование Ростера
                          goto X;
                        end;
                    end;
                  // Если такую группу не нашли
                  // Добавляем группу и этот контакт в неё
                  with Categories.Add do
                    begin
                      Caption := URLDecode(RosterJvListView.Items[I].SubItems[1]);
                      GroupCaption := URLDecode(RosterJvListView.Items[I].SubItems[1]);
                      GroupType := C_Jabber;
                      // Определяем режим КЛ
                      if (MainForm.OnlyOnlineContactsToolButton.Down) and (RosterJvListView.Items[I].Caption <> C_NoCL) and ((S = 30) or (S = 41) or (S = 42)) then
                        goto X;
                      // Добавляем контакт в эту группу в КЛ
                      with Items.Add do
                        begin
                          Caption := URLDecode(RosterJvListView.Items[I].SubItems[0]);
                          UIN := RosterJvListView.Items[I].Caption;
                          Status := S;
                          ImageIndex := S;
                          XImageIndex := -1;
                          CImageIndex := -1;
                          ContactType := C_Jabber;
                          if GroupId <> C_NoCL then
                            NickColor := 1
                          else
                            NickColor := 0;
                        end;
                    end;
                end
                // Добавляем ICQ контакты в КЛ --------------------------------------------------------------------------------------------------------------------------
              else if Items[I].SubItems[3] = C_Icq then
                begin
                  if (Length(Items[I].Caption) = 4) and (Items[I].SubItems[0] = EmptyStr) then
                    begin // Группа ICQ
                      for C := 0 to Categories.Count - 1 do
                        begin
                          // Если такую группу нашли
                          if (not ICQ_Show_HideContacts) and (Categories[C].GroupId = '0000') then
                            begin
                              Categories[C].Free;
                              goto X;
                            end;
                          if (Categories[C].GroupId = Items[I].Caption) and (Categories[C].GroupType = C_Icq) then
                            begin
                              Categories[C].Caption := URLDecode(Items[I].SubItems[1]);
                              Categories[C].GroupCaption := URLDecode(Items[I].SubItems[1]);
                              goto X;
                            end;
                        end;
                      // Если такую группу не нашли, то добавляем её
                      if (not ICQ_Show_HideContacts) and (Items[I].Caption = '0000') then
                        goto X;
                      with Categories.Add do
                        begin
                          Caption := URLDecode(RosterJvListView.Items[I].SubItems[1]);
                          GroupCaption := URLDecode(RosterJvListView.Items[I].SubItems[1]);
                          GroupId := RosterJvListView.Items[I].Caption;
                          GroupType := C_Icq;
                          if GroupId = '0000' then
                            Collapsed := True; // Сворачиваем группу временных контактов
                        end;
                    end
                  else // Контакт
                    begin
                      // Создаём подсказку для этого контакта
                      Items[I].SubItems[34] := URLEncode(ICQ_CreateHint(Items[I]));
                      if (not ICQ_Show_HideContacts) and (Items[I].SubItems[1] = '0000') then
                        goto X;
                      // Ищем группу контакта в КЛ
                      for C := 0 to Categories.Count - 1 do
                        begin
                          // Если такую группу нашли
                          if (Categories[C].GroupId = Items[I].SubItems[1]) and (Categories[C].GroupType = C_Icq) then
                            begin
                              // Начинаем поиск в ней этого контакта
                              for Cc := 0 to Categories[C].Items.Count - 1 do
                                begin
                                  if Categories[C].Items[Cc].UIN = Items[I].Caption then
                                    begin
                                      with Categories[C].Items[Cc] do
                                        begin
                                          // Обновляем информацию для этого контакта в КЛ
                                          Status := S;
                                          ImageIndex := S;
                                          XImageIndex := StrToInt(Items[I].SubItems[7]);
                                          CImageIndex := StrToInt(Items[I].SubItems[8]);
                                          Hint := URLDecode(Items[I].SubItems[34]);
                                          // Если статус в сети
                                          if (Status <> 9) and (Status <> 80) and (Status <> 214) then
                                            begin
                                              // Поднимаем этот контакт вверх группы
                                              index := 0;
                                              // Назначаем ему синий цвет
                                              NickColor := 2;
                                            end
                                          else // Если статус не в сети и скрывать оффлайн контакты
                                            begin
                                              if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) and (Categories[C].GroupId <> '0000') then
                                                Free
                                              else
                                                begin
                                                  // Опускаем контакт в конец группы
                                                  index := Categories[C].Items.Count - 1;
                                                  // Назначаем ему темнокрасный цвет
                                                  if (Categories[C].GroupId <> C_NoCL) and (Categories[C].GroupId <> '0000') then
                                                    NickColor := 1
                                                  else
                                                    NickColor := 0;
                                                end;
                                            end;
                                        end;
                                      // Продолжаем сканирование Ростера
                                      goto X;
                                    end;
                                end;
                              // Определяем режим КЛ
                              if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) and (Categories[C].GroupId <> '0000') and ((S = 9) or (S = 80) or (S = 214)) then
                                goto X;
                              // Добавляем контакт в эту группу в КЛ
                              with Categories[C].Items.Add do
                                begin
                                  Caption := URLDecode(Items[I].SubItems[0]);
                                  UIN := Items[I].Caption;
                                  Status := S;
                                  ImageIndex := S;
                                  XImageIndex := StrToInt(Items[I].SubItems[7]);
                                  CImageIndex := StrToInt(Items[I].SubItems[8]);
                                  ContactType := C_Icq;
                                  Hint := URLDecode(Items[I].SubItems[34]);
                                  if (Categories[C].GroupId <> C_NoCL) and (Categories[C].GroupId <> '0000') then
                                    NickColor := 1
                                  else
                                    NickColor := 0;
                                end;
                              // Продолжаем сканирование Ростера
                              goto X;
                            end;
                        end;
                    end;
                end
                // Добавляем MRA контакты в КЛ --------------------------------------------------------------------------------------------------------------------------
              else if Items[I].SubItems[3] = C_Mra then
                begin
                  if (Length(Items[I].Caption) < 4) and (Items[I].SubItems[0] = EmptyStr) then
                    begin // Группа MRA
                      for C := 0 to Categories.Count - 1 do
                        begin
                          // Если такую группу нашли
                          if (Categories[C].GroupId = Items[I].Caption) and (Categories[C].GroupType = C_Mra) then
                            begin
                              Categories[C].Caption := URLDecode(Items[I].SubItems[1]);
                              Categories[C].GroupCaption := URLDecode(Items[I].SubItems[1]);
                              goto X;
                            end;
                        end;
                      // Если такую группу не нашли, то добавляем её
                      with Categories.Add do
                        begin
                          Caption := URLDecode(RosterJvListView.Items[I].SubItems[1]);
                          GroupCaption := URLDecode(RosterJvListView.Items[I].SubItems[1]);
                          GroupId := RosterJvListView.Items[I].Caption;
                          GroupType := C_Mra;
                        end;
                    end
                  else // Контакт
                    begin
                      // Ищем группу контакта в КЛ
                      for C := 0 to Categories.Count - 1 do
                        begin
                          // Если такую группу нашли
                          if (Categories[C].GroupId = Items[I].SubItems[1]) and (Categories[C].GroupType = C_Mra) then
                            begin
                              // Начинаем поиск в ней этого контакта
                              for Cc := 0 to Categories[C].Items.Count - 1 do
                                begin
                                  if Categories[C].Items[Cc].UIN = Items[I].Caption then
                                    begin
                                      with Categories[C].Items[Cc] do
                                        begin
                                          // Обновляем информацию для этого контакта в КЛ
                                          Status := S;
                                          ImageIndex := S;
                                          XImageIndex := StrToInt(Items[I].SubItems[7]);
                                          CImageIndex := StrToInt(Items[I].SubItems[8]);
                                          if Items[I].SubItems[4] = 'phone' then
                                            begin
                                              Status := 275;
                                              ImageIndex := 275;
                                            end;
                                          // Hint := URLDecode(Items[I].SubItems[34]);
                                          // Если статус в сети
                                          if (Status <> 23) and (Status <> 25) then
                                            begin
                                              // Поднимаем этот контакт вверх группы
                                              index := 0;
                                              // Назначаем ему синий цвет
                                              NickColor := 2;
                                            end
                                          else // Если статус не в сети и скрывать оффлайн контакты
                                            begin
                                              if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) then
                                                Free
                                              else
                                              begin
                                                // Опускаем контакт в конец группы
                                                index := Categories[C].Items.Count - 1;
                                                // Назначаем ему темнокрасный цвет
                                                if Categories[C].GroupId <> C_NoCL then
                                                  NickColor := 1
                                                else
                                                  NickColor := 0;
                                              end;
                                            end;
                                        end;
                                      // Продолжаем сканирование Ростера
                                      goto X;
                                    end;
                                end;
                              // Определяем режим КЛ
                              if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) and ((S = 23) or (S = 25)) then
                                goto X;
                              // Добавляем контакт в эту группу в КЛ
                              with Categories[C].Items.Add do
                                begin
                                  Caption := URLDecode(Items[I].SubItems[0]);
                                  UIN := Items[I].Caption;
                                  Status := S;
                                  ImageIndex := S;
                                  XImageIndex := StrToInt(Items[I].SubItems[7]);
                                  CImageIndex := StrToInt(Items[I].SubItems[8]);
                                  ContactType := C_Mra;
                                  if Items[I].SubItems[4] = 'phone' then
                                    begin
                                      Status := 275;
                                      ImageIndex := 275;
                                    end;
                                  // Hint := URLDecode(Items[I].SubItems[34]);
                                  if Categories[C].GroupId <> C_NoCL then
                                    NickColor := 1
                                  else
                                    NickColor := 0;
                                end;
                              // Продолжаем сканирование Ростера
                              goto X;
                            end;
                        end;
                    end;
                end;
            X :;
            end;
          // Если активен режим "Скрывать пустые группы"
          if MainForm.HideEmptyGroups.Checked then
            begin
              // Сканируем КЛ и удаляем пустые группы
            A :;
              for I := 0 to Categories.Count - 1 do
                if Categories[I].Items.Count = 0 then
                  begin
                    Categories[I].Free;
                    goto A;
                  end;
            end;
          // Вычисляем количесво контактов и количество онлайн-контактов в группах локального КЛ
          for C := 0 to Categories.Count - 1 do
            begin
              if (Categories[C].GroupId = '0000') or (Categories[C].GroupId = C_NoCL) or (Categories[C].Items.Count = 0) //
                or (MainForm.OnlyOnlineContactsToolButton.Down) or ((Categories[C].GroupId = '999') and (Categories[C].GroupType = C_Mra)) then
                Categories[C].Caption := Categories[C].GroupCaption + ' - ' + IntToStr(Categories[C].Items.Count)
              else
                begin
                  I := Categories[C].Items.Count;
                  for Cc := 0 to Categories[C].Items.Count - 1 do
                    case Categories[C].Items[Cc].Status of
                      9, 23, 25, 30, 41, 42, 80, 214: Dec(I);
                    end;
                  Categories[C].Caption := Categories[C].GroupCaption + ' - ' + Format(Lang_Vars[115].L_S, [I, Categories[C].Items.Count]);
                end;
            end;
          // Восстанавливаем состояние свёрнутых групп
          if V_CollapseGroupsRestore then
            begin
              // Инициализируем XML
              JvXML_Create(JvXML);
              try
                with JvXML do
                  begin
                    if FileExists(V_ProfilePath + C_GroupsFileName) then
                      begin
                        LoadFromFile(V_ProfilePath + C_GroupsFileName);
                        if Root <> nil then
                          begin
                            for C := 0 to Categories.Count - 1 do
                              begin
                                XML_Node := Root.Items.ItemNamed[ChangeCP(URLEncode(Categories[C].GroupCaption + Categories[C].GroupType + Categories[C].GroupId))];
                                if XML_Node <> nil then
                                  Categories[C].Collapsed := XML_Node.Properties.BoolValue('c');
                              end;
                          end;
                      end;
                  end;
              finally
                JvXML.Free;
              end;
              V_CollapseGroupsRestore := False;
            end;
          // Заканчиваем обновление КЛ
          Categories.EndUpdate;
        end;
    end;
end;

{$ENDREGION}
{$REGION 'ReqCLContact'}

function TRosterForm.ReqCLContact(CId: string): TButtonItem;
label
  X;
var
  I, II: Integer;
begin
  Result := nil;
  // Ищем контакт в КЛ
  with MainForm.ContactList do
    begin
      for I := 0 to Categories.Count - 1 do
        begin
          for II := 0 to Categories[I].Items.Count - 1 do
            begin
              if Categories[I].Items[II].UIN = CId then
                begin
                  Result := Categories[I].Items[II];
                  // Выходим из циклов
                  goto X;
                end;
            end;
        end;
    end;
X :;
end;

{$ENDREGION}
{$REGION 'FormCreate'}

procedure TRosterForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем иконку окна и кнопок
  MainForm.AllImageList.GetIcon(1, Icon);
  MainForm.AllImageList.GetBitmap(221, SearchBitBtn.Glyph);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Переводим форму
  TranslateForm;
  // Загружаем копию локальную списка контактов
  if FileExists(V_ProfilePath + C_ContactListFileName) then
    RosterJvListView.LoadFromCSV(V_ProfilePath + C_ContactListFileName);
end;

{$ENDREGION}
{$REGION 'ClearContacts'}

function TRosterForm.ClearContacts(CType: string): Boolean;
label
  A,
  B;
var
  I: Integer;
begin
  Result := False;
  // Удаляем контакты в Ростере
  with RosterJvListView do
    begin
      Items.BeginUpdate;
    A :;
      for I := 0 to Items.Count - 1 do
        begin
          // Удаляем все контакты протокола
          if Items[I].SubItems[3] = CType then
            begin
              Result := True;
              Items[I].Delete;
              goto A;
            end;
        end;
      Items.EndUpdate;
    end;
  // Удаляем контакты в КЛ
  if Result then
    begin
      with MainForm.ContactList do
        begin
        B :;
          for I := 0 to Categories.Count - 1 do
            begin
              // Удаляем все группы протокола
              if Categories[I].GroupType = CType then
                begin
                  Categories[I].Free;
                  goto B;
                end;
            end;
        end;
    end;
end;

{$ENDREGION}

end.
