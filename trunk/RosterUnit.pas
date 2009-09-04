{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit RosterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, JvExComCtrls, JvListView, CategoryButtons, Menus;

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
    procedure ClearContacts(cType: string);
    procedure UpdateFullCL;
    function ReqRosterItem(cId: string): TListItem;
    function ReqCLContact(cId: string): TButtonItem;
    function ReqChatPage(cId: string): TTabSheet;
    procedure RosterItemSetFull(sItem: TListItem);
    procedure AddHistory(cItem: TListItem; cMsgD, cMess: string);
    procedure OpenChatPage(cId: string);
    procedure ResetGroupSelected;
    procedure DellcIdInMessList(cId: string);
  end;

var
  RosterForm: TRosterForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UtilsUnit, VarsUnit, ChatUnit;

function TRosterForm.ReqChatPage(cId: string): TTabSheet;
var
  i: integer;
begin
  Result := nil;
  //--Ищем вкладку в окне чата
  if Assigned(ChatForm) then
  begin
    with ChatForm.ChatPageControl do
    begin
      for i := 0 to PageCount - 1 do
      begin
        if Pages[i].HelpKeyword = cId then
        begin
          Result := Pages[i];
          //--Выходим из цикла
          Break;
        end;
      end;
    end;
  end;
end;

procedure TRosterForm.DellcIdInMessList(cId: string);
var
  i: integer;
begin
  //--Удаляем отметку о сообщении из списка очереди входящих сообщений
  if Assigned(InMessList) then
  begin
    try
      with InMessList do
      begin
        for i := 0 to Count - 1 do
        begin
          if Strings[i] = cId then
          begin
            Delete(i);
            Break;
          end;
        end;
      end;
    except
    end;
  end;
end;

procedure TRosterForm.ResetGroupSelected;
var
  i: integer;
begin
  //--Сбрасываем выделение заголовка группы при клике по любому контакту
  with MainForm.ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      if Categories[i].GroupSelected = true then
      begin
        Categories[i].GroupSelected := false;
        //--Перерисовываем заголовок группы
        ShareUpdateCategory(Categories[i]);
        //--Выходим из цикла
        Break;
      end;
    end;
  end;
end;

procedure TRosterForm.OpenChatPage(cId: string);
label
  a;
var
  Sheet: TTabSheet;
  i: integer;
begin
  //--Если окно чата не создано, то создаём его
  if not Assigned(ChatForm) then ChatForm := TChatForm.Create(self);
  //--Ищем вкладку в табе
  with ChatForm do
  begin
    with ChatPageControl do
    begin
      for i := 0 to PageCount - 1 do
      begin
        if Pages[i].HelpKeyword = cId then
        begin
          ActivePageIndex := Pages[i].PageIndex;
          //--Выходим из цикла
          goto a;
        end;
      end;
    end;
    //--Если вкладку не нашли, то создаём её
    Sheet := TTabSheet.Create(self);
    Sheet.Caption := cId;
    Sheet.HelpKeyword := cId;
    Sheet.ShowHint := true;
    Sheet.PageControl := ChatPageControl;
    ChatPageControl.ActivePageIndex := Sheet.PageIndex;
    a: ;
    //--Показываем компонент табов
    ChatPageControl.Visible := true;
    //--Активируем чат и применяем параметры в окне чата
    ChatPageControlChange(self);
    //--Отображаем окно сообщений
    if Visible then ShowWindow(ChatForm.Handle, SW_RESTORE);
    Show;
    //--Ставим фокус в поле ввода текста
    if (InputMemo.CanFocus) and (Visible) then InputMemo.SetFocus;
  end;
end;

procedure TRosterForm.AddHistory(cItem: TListItem; cMsgD, cMess: string);
var
  HistoryFile, hFile: string;
begin
  with cItem do
  begin
    //--Проверяем загружена ли история уже
    if SubItems[13] = EmptyStr then
    begin
      //--Загружаем файл истории сообщений
      HistoryFile := ProfilePath + 'Profile\History\' + SubItems[3] + '_' + Caption + '.z';
      if FileExists(HistoryFile) then
      begin
        try
          //--Распаковываем файл с историей
          UnZip_File(HistoryFile, ProfilePath + 'Profile\History\');
          //--Записываем историю в хранилище у этого контакта
          hFile := ProfilePath + 'Profile\History\' + SubItems[3] + '_History.htm';
          SubItems[13] := ReadFromFile(hFile);
          //--Удаляем уже не нужный распакованный файл с историей
          if FileExists(hFile) then DeleteFile(hFile);
        except
        end;
      end;
    end;
    //--Добавляем историю в этот контакт
    SubItems[13] := SubItems[13] + '<span class=b>' + cMsgD +
      '</span><br><span class=c>' + cMess + '</span><br><br>' + #13#10;
    //--Ставим флаг этому контакту, что история изменилась
    SubItems[36] := 'X';
  end;
end;

procedure TRosterForm.RosterItemSetFull(sItem: TListItem);
var
  i: integer;
begin
  for i := 1 to RosterJvListView.Columns.Count - 1 do
  begin
    case i of
      7, 8, 9: sItem.SubItems.Add('-1');
      19, 20, 36: sItem.SubItems.Add('0');
    else sItem.SubItems.Add('');
    end;
  end;
end;

procedure TRosterForm.RosterJvListViewGetImageIndex(Sender: TObject;
  Item: TListItem);
begin
  //--Выставляем иконки в Ростере
  if (Item.SubItems[3] = 'Icq') and (Length(Item.Caption) = 4) then Item.ImageIndex := 227
  else if Item.SubItems[3] = 'Icq' then Item.ImageIndex := 81
  else if Item.SubItems[3] = 'Jabber' then Item.ImageIndex := 43
  else if Item.Caption = 'NoCL' then Item.ImageIndex := 227;
end;

procedure TRosterForm.UpdateFullCL;
label
  x, a;
var
  i, c, cc, s: integer;
begin
  //--Обрабатываем весь Ростер
  with RosterJvListView do
  begin
    with MainForm.ContactList do
    begin
      for i := 0 to Items.Count - 1 do
      begin
        //--Получаем статус контакта заранее
        s := StrToInt(Items[i].SubItems[6]);
        //--Добавляем Jabber контакты в КЛ
        if Items[i].SubItems[3] = 'Jabber' then
        begin
          //--Ищем группу контакта в КЛ
          for c := 0 to Categories.Count - 1 do
          begin
            //--Если такую группу нашли
            if (Categories[c].GroupCaption = Items[i].SubItems[1]) and (Categories[c].GroupType = 'Jabber') then
            begin
              //--Начинаем поиск в ней этого контакта
              for cc := 0 to Categories[c].Items.Count - 1 do
              begin
                if Categories[c].Items[cc].UIN = Items[i].Caption then
                begin
                  with Categories[c].Items[cc] do
                  begin
                    //--Обновляем информацию для этого контакта в КЛ
                    Status := s;
                    ImageIndex := s;
                    //--Если статус в сети
                    if (Status <> 30) and (Status <> 41) and (Status <> 42) then
                    begin
                      //--Поднимаем этот контакт вверх группы
                      Index := 0;
                    end
                    else //--Если статус не в сети и скрывать оффлайн контакты
                    begin
                      if (MainForm.OnlyOnlineContactsToolButton.Down) and
                        (Categories[c].GroupId <> 'NoCL') then Free
                      else Index := Categories[c].Items.Count - 1;
                    end;
                  end;
                  //--Продолжаем сканирование Ростера
                  goto x;
                end;
              end;
              //--Определяем режим КЛ
              if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[c].GroupId <> 'NoCL') and
                ((s = 30) or (s = 41) or (s = 42)) then goto x;
              //--Добавляем контакт в эту группу в КЛ
              with Categories[c].Items.Add do
              begin
                Caption := Items[i].SubItems[0];
                UIN := Items[i].Caption;
                Status := 30;
                ImageIndex := 30;
                ImageIndex1 := -1;
                ImageIndex2 := -1;
                ContactType := 'Jabber';
              end;
              //--Продолжаем сканирование Ростера
              goto x;
            end;
          end;
          //--Если такую группу не нашли
          //--Добавляем группу и этот контакт в неё
          with Categories.Add do
          begin
            Caption := RosterJvListView.Items[i].SubItems[1];
            GroupCaption := RosterJvListView.Items[i].SubItems[1];
            GroupType := 'Jabber';
            //--Определяем режим КЛ
            if (MainForm.OnlyOnlineContactsToolButton.Down) and
              (RosterJvListView.Items[i].Caption <> 'NoCL') and
              ((s = 30) or (s = 41) or (s = 42)) then goto x;
            //--Добавляем контакт в эту группу в КЛ
            with Items.Add do
            begin
              Caption := RosterJvListView.Items[i].SubItems[0];
              UIN := RosterJvListView.Items[i].Caption;
              Status := 30;
              ImageIndex := 30;
              ImageIndex1 := -1;
              ImageIndex2 := -1;
              ContactType := 'Jabber';
            end;
          end;
        end
        //--Добавляем ICQ контакты в КЛ
        else if Items[i].SubItems[3] = 'Icq' then
        begin
          if (Length(Items[i].Caption) = 4) and (Items[i].SubItems[0] = '') then
          begin //--Группа ICQ
            for c := 0 to Categories.Count - 1 do
            begin
              //--Если такую группу нашли
              if (not ICQ_Show_HideContacts) and (Categories[c].GroupId = '0000') then
              begin
                Categories[c].Free;
                goto x;
              end;
              if (Categories[c].GroupId = Items[i].Caption) and (Categories[c].GroupType = 'Icq') then goto x;
            end;
            //--Если такую группу не нашли, то добавляем её
            if (not ICQ_Show_HideContacts) and (Items[i].Caption = '0000') then goto x;
            with Categories.Add do
            begin
              Caption := RosterJvListView.Items[i].SubItems[1];
              GroupCaption := RosterJvListView.Items[i].SubItems[1];
              GroupId := RosterJvListView.Items[i].Caption;
              GroupType := 'Icq';
              if GroupId = '0000' then Collapsed := true; //--Сворачиваем группу временных контактов
            end;
          end
          else //--Контакт
          begin
            if (not ICQ_Show_HideContacts) and (Items[i].SubItems[1] = '0000') then goto x;
            //--Ищем группу контакта в КЛ
            for c := 0 to Categories.Count - 1 do
            begin
              //--Если такую группу нашли
              if (Categories[c].GroupId = Items[i].SubItems[1]) and (Categories[c].GroupType = 'Icq') then
              begin
                //--Начинаем поиск в ней этого контакта
                for cc := 0 to Categories[c].Items.Count - 1 do
                begin
                  if Categories[c].Items[cc].UIN = Items[i].Caption then
                  begin
                    with Categories[c].Items[cc] do
                    begin
                      //--Обновляем информацию для этого контакта в КЛ
                      Status := s;
                      ImageIndex := s;
                      ImageIndex1 := StrToInt(Items[i].SubItems[7]);
                      ImageIndex2 := StrToInt(Items[i].SubItems[8]);
                      //--Если статус в сети
                      if (Status <> 9) and (Status <> 80) and (Status <> 214) then
                      begin
                        //--Поднимаем этот контакт вверх группы
                        Index := 0;
                      end
                      else //--Если статус не в сети и скрывать оффлайн контакты
                      begin
                        if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[c].GroupId <> 'NoCL') and
                          (Categories[c].GroupId <> '0000') then Free
                        else Index := Categories[c].Items.Count - 1;
                      end;
                    end;
                    //--Продолжаем сканирование Ростера
                    goto x;
                  end;
                end;
                //--Определяем режим КЛ
                if (MainForm.OnlyOnlineContactsToolButton.Down) and
                  (Categories[c].GroupId <> 'NoCL') and
                  (Categories[c].GroupId <> '0000') and
                  ((s = 9) or (s = 80) or (s = 214)) then goto x;
                //--Добавляем контакт в эту группу в КЛ
                with Categories[c].Items.Add do
                begin
                  Caption := Items[i].SubItems[0];
                  UIN := Items[i].Caption;
                  Status := 9;
                  ImageIndex := 9;
                  ImageIndex1 := -1;
                  ImageIndex2 := -1;
                  ContactType := 'Icq';
                end;
                //--Продолжаем сканирование Ростера
                goto x;
              end;
            end;
          end;
        end
        //--Добавляем MRA контакты в КЛ
        else if Items[i].SubItems[3] = 'Mra' then
        begin

        end;
        x: ;
      end;
      //--Если активен режим "Скрывать пустые группы"
      if MainForm.HideEmptyGroups.Checked then
      begin
        //--Сканируем КЛ и удаляем пустые группы
        a: ;
        for i := 0 to Categories.Count - 1 do
          if Categories[i].Items.Count = 0 then
          begin
            Categories[i].Free;
            goto a;
          end;
      end;
      //--Вычисляем количесво контактов и количество онлайн-контактов в группах локального КЛ
      for c := 0 to Categories.Count - 1 do
      begin
        if (Categories[c].GroupId = '0000') or (Categories[c].GroupId = 'NoCL') or
          (Categories[c].Items.Count = 0) or (MainForm.OnlyOnlineContactsToolButton.Down) then
            Categories[c].Caption := Categories[c].GroupCaption + ' - ' + IntToStr(Categories[c].Items.Count)
        else
        begin
          i := Categories[c].Items.Count;
          for cc := 0 to Categories[c].Items.Count - 1 do
            case Categories[c].Items[cc].Status of
              9, 30, 41, 42, 80, 214: dec(i);
            end;
          Categories[c].Caption := Categories[c].GroupCaption + ' - ' + IntToStr(i) + GroupInv + IntToStr(Categories[c].Items.Count);
        end;
      end;
    end;
  end;
end;

function TRosterForm.ReqRosterItem(cId: string): TListItem;
begin
  //--Обрабатываем запись в Ростере
  Result := RosterJvListView.FindCaption(0, cId, true, true, false);
end;

function TRosterForm.ReqCLContact(cId: string): TButtonItem;
label
  x;
var
  i, ii: integer;
begin
  Result := nil;
  //--Ищем контакт в КЛ
  with MainForm.ContactList do
  begin
    for i := 0 to Categories.Count - 1 do
    begin
      for ii := 0 to Categories[i].Items.Count - 1 do
      begin
        if Categories[i].Items[ii].UIN = cId then
        begin
          Result := Categories[i].Items[ii];
          //--Выходим из циклов
          goto x;
        end;
      end;
    end;
  end;
  x: ;
end;

procedure TRosterForm.FormCreate(Sender: TObject);
begin
  //--Устанавливаем иконку окна
  MainForm.AllImageList.GetIcon(1, Icon);
  //--Помещаем кнопку формы в таскбар и делаем независимой
  SetWindowLong(Handle, GWL_HWNDPARENT, 0);
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
  //--Загружаем копию локальную списка контактов
  if FileExists(ProfilePath + 'Profile\ContactList.dat') then
    RosterJvListView.LoadFromFile(ProfilePath + 'Profile\ContactList.dat');
end;

procedure TRosterForm.ClearContacts(cType: string);
label
  a, b;
var
  i: integer;
begin
  //--Удаляем контакты в Ростере
  with RosterJvListView do
  begin
    Items.BeginUpdate;
    a: ;
    for i := 0 to Items.Count - 1 do
    begin
      //--Удаляем все контакты протокола
      if Items[i].SubItems[3] = cType then
      begin
        Items[i].Delete;
        goto a;
      end;
    end;
    Items.EndUpdate;
  end;
  //--Удаляем контакты в КЛ
  with MainForm.ContactList do
  begin
    b: ;
    for i := 0 to Categories.Count - 1 do
    begin
      //--Удаляем группы с контактами протокола
      if Categories[i].GroupType = cType then
      begin
        Categories[i].Free;
        goto b;
      end;
    end;
  end;
end;

procedure TRosterForm.ClearICQClick(Sender: TObject);
begin
  //--Стираем в Ростере все ICQ контакты
  ClearContacts('Icq');
  //--Запускаем обработку Ростера
  UpdateFullCL;
end;

procedure TRosterForm.ClearJabberClick(Sender: TObject);
begin
  //--Стираем в Ростере все Jabber контакты
  ClearContacts('Jabber');
  //--Запускаем обработку Ростера
  UpdateFullCL;
end;

procedure TRosterForm.ClearMRAClick(Sender: TObject);
begin
  //--Стираем в Ростере все MRA контакты
  ClearContacts('Mra');
  //--Запускаем обработку Ростера
  UpdateFullCL;
end;

end.

