{ *******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit RosterUnit;

interface

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
  Menus;

type
  TRosterForm = class(TForm)
    RosterJvListView: TJvListView;
    RosterPopupMenu: TPopupMenu;
    ClearICQ: TMenuItem;
    ClearJabber: TMenuItem;
    ClearMRA: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ClearICQClick(Sender: TObject);
    procedure ClearJabberClick(Sender: TObject);
    procedure RosterJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
    procedure ClearMRAClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    function ClearContacts(CType: string): Boolean;
    procedure UpdateFullCL;
    function ReqRosterItem(CId: string): TListItem;
    function ReqCLContact(CId: string): TButtonItem;
    function ReqChatPage(CId: string): TTabSheet;
    procedure RosterItemSetFull(SItem: TListItem);
    procedure AddHistory(CItem: TListItem; CMsgD, CMess: string);
    procedure OpenChatPage(CId: string);
    procedure ResetGroupSelected;
    procedure DellcIdInMessList(CId: string);
  end;

var
  RosterForm: TRosterForm;

implementation

{$R *.dfm}

uses
  MainUnit,
  IcqProtoUnit,
  UtilsUnit,
  VarsUnit,
  ChatUnit,
  RXML;

function TRosterForm.ReqChatPage(CId: string): TTabSheet;
var
  I: Integer;
begin
  Result := nil;
  // Ищем вкладку в окне чата
  if Assigned(ChatForm) then
    begin
      with ChatForm.ChatPageControl do
        begin
          for I := 0 to PageCount - 1 do
            begin
              if Pages[I].HelpKeyword = CId then
                begin
                  Result := Pages[I];
                  // Выходим из цикла
                  Break;
                end;
            end;
        end;
    end;
end;

procedure TRosterForm.DellcIdInMessList(CId: string);
var
  I: Integer;
begin
  // Удаляем отметку о сообщении из списка очереди входящих сообщений
  if Assigned(InMessList) then
    begin
      with InMessList do
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

procedure TRosterForm.ResetGroupSelected;
var
  I: Integer;
begin
  // Сбрасываем выделение заголовка группы при клике по любому контакту
  with MainForm.ContactList do
    begin
      for I := 0 to Categories.Count - 1 do
        begin
          if Categories[I].GroupSelected = True then
            begin
              Categories[I].GroupSelected := False;
              // Перерисовываем заголовок группы
              // ShareUpdateCategory(Categories[i]);
              // Выходим из цикла
              Break;
            end;
        end;
    end;
end;

procedure TRosterForm.OpenChatPage(CId: string);
label
  A;
var
  Sheet: TTabSheet;
  I: Integer;
begin
  // Если окно чата не создано, то создаём его
  if not Assigned(ChatForm) then
    ChatForm := TChatForm.Create(Self);
  // Ищем вкладку в табе
  with ChatForm do
    begin
      with ChatPageControl do
        begin
          for I := 0 to PageCount - 1 do
            begin
              if Pages[I].HelpKeyword = CId then
                begin
                  ActivePageIndex := Pages[I].PageIndex;
                  // Выходим из цикла
                  goto A;
                end;
            end;
        end;
      // Если вкладку не нашли, то создаём её
      Sheet := TTabSheet.Create(Self);
      Sheet.Caption := CId;
      Sheet.HelpKeyword := CId;
      Sheet.ShowHint := True;
      Sheet.PageControl := ChatPageControl;
      ChatPageControl.ActivePageIndex := Sheet.PageIndex;
    A :;
      // Показываем компонент табов
      ChatPageControl.Visible := True;
      // Активируем чат и применяем параметры в окне чата
      ChatPageControlChange(Self);
      // Отображаем окно сообщений
      XShowForm(ChatForm);
      // Ставим фокус в поле ввода текста
      if (InputMemo.CanFocus) and (Visible) then
        InputMemo.SetFocus;
    end;
end;

procedure TRosterForm.AddHistory(CItem: TListItem; CMsgD, CMess: string);
var
  HistoryFile, HFile: string;
begin
  with CItem do
    begin
      { // Проверяем загружена ли история уже
        if SubItems[13] = EmptyStr then
        begin
        // Загружаем файл истории сообщений
        HistoryFile := ProfilePath + 'Profile\History\' + SubItems[3]
        + '_' + Caption + '.z';
        if FileExists(HistoryFile) then
        begin
        try
        // Распаковываем файл с историей
        UnZip_File(HistoryFile, ProfilePath + 'Profile\History\');
        // Записываем историю в хранилище у этого контакта
        hFile := ProfilePath + 'Profile\History\' + SubItems[3]
        + '_History.htm';
        SubItems[13] := ReadFromFile(hFile);
        // Удаляем уже не нужный распакованный файл с историей
        if FileExists(hFile) then
        DeleteFile(hFile);
        except
        on E: Exception do
        TLogger.Instance.WriteMessage(E);
        end;
        end;
        end;
        // Добавляем историю в этот контакт
        SubItems[13] := SubItems[13] + '<span class=b>' + cMsgD +
        '</span><br><span class=c>' + cMess + '</span><br><br>' + #13#10;
        // Ставим флаг этому контакту, что есть непрочитанные сообщения
        SubItems[17] := 'X';
        SubItems[36] := 'X'; }
    end;
end;

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

procedure TRosterForm.RosterJvListViewGetImageIndex(Sender: TObject; Item: TListItem);
begin
  // Выставляем иконки в Ростере
  if (Item.SubItems[3] = 'Icq') and (Length(Item.Caption) = 4) then
    Item.ImageIndex := 227
  else if Item.SubItems[3] = 'Icq' then
    Item.ImageIndex := 81
  else if Item.SubItems[3] = 'Jabber' then
    Item.ImageIndex := 43
  else if Item.Caption = 'NoCL' then
    Item.ImageIndex := 227;
end;

procedure TRosterForm.UpdateFullCL;
label
  X,
  A;
var
  I, C, Cc, S: Integer;
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
              // Добавляем Jabber контакты в КЛ
              if Items[I].SubItems[3] = 'Jabber' then
                begin
                  // Ищем группу контакта в КЛ
                  for C := 0 to Categories.Count - 1 do
                    begin
                      // Если такую группу нашли
                      if (Categories[C].GroupCaption = Items[I].SubItems[1]) and (Categories[C].GroupType = 'Jabber') then
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
                                        end
                                      else // Если статус не в сети и скрывать оффлайн контакты
                                        begin
                                        if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> 'NoCL') then
                                        Free
                                        else
                                        index := Categories[C].Items.Count - 1;
                                        end;
                                    end;
                                  // Продолжаем сканирование Ростера
                                  goto X;
                                end;
                            end;
                          // Определяем режим КЛ
                          if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> 'NoCL') and
                            ((S = 30) or (S = 41) or (S = 42)) then
                            goto X;
                          // Добавляем контакт в эту группу в КЛ
                          with Categories[C].Items.Add do
                            begin
                              Caption := Items[I].SubItems[0];
                              UIN := Items[I].Caption;
                              Status := 30;
                              ImageIndex := 30;
                              XImageIndex := -1;
                              CImageIndex := -1;
                              ContactType := 'Jabber';
                            end;
                          // Продолжаем сканирование Ростера
                          goto X;
                        end;
                    end;
                  // Если такую группу не нашли
                  // Добавляем группу и этот контакт в неё
                  with Categories.Add do
                    begin
                      Caption := RosterJvListView.Items[I].SubItems[1];
                      GroupCaption := RosterJvListView.Items[I].SubItems[1];
                      GroupType := 'Jabber';
                      // Определяем режим КЛ
                      if (MainForm.OnlyOnlineContactsToolButton.Down) and (RosterJvListView.Items[I].Caption <> 'NoCL') and
                        ((S = 30) or (S = 41) or (S = 42)) then
                        goto X;
                      // Добавляем контакт в эту группу в КЛ
                      with Items.Add do
                        begin
                          Caption := RosterJvListView.Items[I].SubItems[0];
                          UIN := RosterJvListView.Items[I].Caption;
                          Status := 30;
                          ImageIndex := 30;
                          XImageIndex := -1;
                          CImageIndex := -1;
                          ContactType := 'Jabber';
                        end;
                    end;
                end
                // Добавляем ICQ контакты в КЛ
              else if Items[I].SubItems[3] = 'Icq' then
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
                          if (Categories[C].GroupId = Items[I].Caption) and (Categories[C].GroupType = 'Icq') then
                            begin
                              Categories[C].GroupCaption := Items[I].SubItems[1];
                              goto X;
                            end;
                        end;
                      // Если такую группу не нашли, то добавляем её
                      if (not ICQ_Show_HideContacts) and (Items[I].Caption = '0000') then
                        goto X;
                      with Categories.Add do
                        begin
                          Caption := RosterJvListView.Items[I].SubItems[1];
                          GroupCaption := RosterJvListView.Items[I].SubItems[1];
                          GroupId := RosterJvListView.Items[I].Caption;
                          GroupType := 'Icq';
                          if GroupId = '0000' then
                            Collapsed := True; // Сворачиваем группу временных контактов
                        end;
                    end
                  else // Контакт
                    begin
                      // Создаём подсказку для этого контакта
                      Items[I].SubItems[34] := ICQ_CreateHint(Items[I]);
                      if (not ICQ_Show_HideContacts) and (Items[I].SubItems[1] = '0000') then
                        goto X;
                      // Ищем группу контакта в КЛ
                      for C := 0 to Categories.Count - 1 do
                        begin
                          // Если такую группу нашли
                          if (Categories[C].GroupId = Items[I].SubItems[1]) and (Categories[C].GroupType = 'Icq') then
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
                                        Hint := Items[I].SubItems[34];
                                        // Если статус в сети
                                        if (Status <> 9) and (Status <> 80) and (Status <> 214) then
                                        begin
                                        // Поднимаем этот контакт вверх группы
                                        index := 0;
                                        end
                                        else // Если статус не в сети и скрывать оффлайн контакты
                                        begin
                                        if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> 'NoCL') and
                                        (Categories[C].GroupId <> '0000') then
                                        Free
                                        else
                                        index := Categories[C].Items.Count - 1;
                                        end;
                                        end;
                                      // Продолжаем сканирование Ростера
                                      goto X;
                                    end;
                                end;
                              // Определяем режим КЛ
                              if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> 'NoCL') and
                                (Categories[C].GroupId <> '0000') and ((S = 9) or (S = 80) or (S = 214)) then
                                goto X;
                              // Добавляем контакт в эту группу в КЛ
                              with Categories[C].Items.Add do
                                begin
                                  Caption := Items[I].SubItems[0];
                                  UIN := Items[I].Caption;
                                  Status := 9;
                                  ImageIndex := 9;
                                  XImageIndex := -1;
                                  CImageIndex := -1;
                                  ContactType := 'Icq';
                                  Hint := Items[I].SubItems[34];
                                end;
                              // Продолжаем сканирование Ростера
                              goto X;
                            end;
                        end;
                    end;
                end
                // Добавляем MRA контакты в КЛ
              else if Items[I].SubItems[3] = 'Mra' then
                begin

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
              if (Categories[C].GroupId = '0000') or (Categories[C].GroupId = 'NoCL') or (Categories[C].Items.Count = 0) or
                (MainForm.OnlyOnlineContactsToolButton.Down) then
                Categories[C].Caption := Categories[C].GroupCaption + ' - ' + IntToStr(Categories[C].Items.Count)
              else
                begin
                  I := Categories[C].Items.Count;
                  for Cc := 0 to Categories[C].Items.Count - 1 do
                    case Categories[C].Items[Cc].Status of
                      9, 30, 41, 42, 80, 214: Dec(I);
                    end;
                  Categories[C].Caption := Categories[C].GroupCaption + ' - ' + IntToStr(I) + GroupInv + IntToStr
                    (Categories[C].Items.Count);
                end;
            end;
          // Восстанавливаем состояние свёрнутых групп
          if CollapseGroupsRestore then
            begin
              with TrXML.Create() do
                try
                  if FileExists(ProfilePath + GroupsFileName) then
                    LoadFromFile(ProfilePath + GroupsFileName);
                  for C := 0 to Categories.Count - 1 do
                    begin
                      if OpenKey('groups\' + Categories[C].GroupCaption + '-' + Categories[C].GroupType + '-' + Categories[C].GroupId) then
                        try
                          Categories[C].Collapsed := ReadBool('collapsed');
                        finally
                          CloseKey();
                        end;
                    end;
                finally
                  Free();
                end;
              CollapseGroupsRestore := False;
            end;
          // Заканчиваем обновление КЛ
          Categories.EndUpdate;
        end;
    end;
end;

function TRosterForm.ReqRosterItem(CId: string): TListItem;
begin
  // Обрабатываем запись в Ростере
  Result := RosterJvListView.FindCaption(0, CId, True, True, False);
end;

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
          for Ii := 0 to Categories[I].Items.Count - 1 do
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

procedure TRosterForm.FormCreate(Sender: TObject);
begin
  // Устанавливаем иконку окна
  MainForm.AllImageList.GetIcon(1, Icon);
  // Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  // Загружаем копию локальную списка контактов
  if FileExists(ProfilePath + 'Profile\ContactList.txt') then
    RosterJvListView.LoadFromCSV(ProfilePath + 'Profile\ContactList.txt');
  XLog(LogRosterCount + IntToStr(RosterJvListView.Items.Count));
end;

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

procedure TRosterForm.ClearICQClick(Sender: TObject);
begin
  // Стираем в Ростере все ICQ контакты
  if ClearContacts('Icq') then
    if RoasterReady then
      RosterForm.UpdateFullCL;
end;

procedure TRosterForm.ClearJabberClick(Sender: TObject);
begin
  // Стираем в Ростере все Jabber контакты
  if ClearContacts('Jabber') then
    if RoasterReady then
      RosterForm.UpdateFullCL;
end;

procedure TRosterForm.ClearMRAClick(Sender: TObject);
begin
  // Стираем в Ростере все MRA контакты
  if ClearContacts('Mra') then
    if RoasterReady then
      RosterForm.UpdateFullCL;
end;

end.
