unit RosterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, JvExComCtrls, JvListView, CategoryButtons;

type
  TRosterForm = class(TForm)
    RosterJvListView: TJvListView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ClearContacts(cType: string);
    procedure UpdateFullCL;
    function ReqRosterItem(cId: string): TListItem;
    function ReqCLContact(cId: string): TButtonItem;
    procedure RosterItemSetFull(sItem: TListItem);
    procedure AddHistory(cItem: TListItem; cMsgD, cMess: string);
    procedure OpenChatPage(cId: string);
    procedure ResetGroupSelected;
  end;

var
  RosterForm: TRosterForm;

implementation

{$R *.dfm}

uses
  MainUnit, IcqProtoUnit, UtilsUnit, VarsUnit, ChatUnit;

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
      //--Размораживаем фэйс
      Application.ProcessMessages;
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
        //--Размораживаем фэйс
        Application.ProcessMessages;
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
  //--Удаляем отметку о сообщении из списка очереди входящих сообщений
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
        //--Размораживаем фэйс
        Application.ProcessMessages;
      end;
    end;
  except
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
      HistoryFile := MyPath + 'Profile\History\' + SubItems[3] + '_' + Caption + '.z';
      if FileExists(HistoryFile) then
      begin
        try
          //--Распаковываем файл с историей
          UnZip_File(HistoryFile, MyPath + 'Profile\History\');
          //--Записываем историю в хранилище у этого контакта
          hFile := MyPath + 'Profile\History\' + SubItems[3] + '_History.htm';
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
    Checked := true;
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
    //--Размораживаем фэйс
    Application.ProcessMessages;
  end;
end;

procedure TRosterForm.UpdateFullCL;
label
  jl, il;
var
  i, c, cc: integer;
begin
  //--Обрабатываем весь Ростер
  with RosterJvListView do
  begin
    with MainForm.ContactList do
    begin
      for i := 0 to Items.Count - 1 do
      begin
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
                  //--Обновляем информацию для этого контакта в КЛ
                  Categories[c].Items[cc].Status := StrToInt(Items[i].SubItems[6]);
                  Categories[c].Items[cc].ImageIndex := Categories[c].Items[cc].Status;
                  with Categories[c].Items[cc] do
                  begin
                    //--Если статус в сети
                    if (Status <> 30) and (Status <> 41) and (Status <> 42) then
                    begin
                      //--Поднимаем этот контакт в верх группы
                      Categories[c].Items[cc].Index := 0;
                    end
                    else //--Если статус не в сети и скрывать оффлайн контакты
                    begin
                      if (MainForm.OnlyOnlineContactsToolButton.Down) and
                        (Categories[c].GroupId <> 'NoCL') then Categories[c].Items[cc].Free;
                    end;
                  end;
                  //--Продолжаем сканирование Ростера
                  goto jl;
                end;
                //--Размораживаем фэйс
                Application.ProcessMessages;
              end;
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
              goto jl;
            end;
            //--Размораживаем фэйс
            Application.ProcessMessages;
          end;
          //--Если такую группу не нашли
          //--Добавляем группу и этот контакт в неё
          with Categories.Add do
          begin
            Caption := RosterJvListView.Items[i].SubItems[1];
            GroupCaption := RosterJvListView.Items[i].SubItems[1];
            GroupType := 'Jabber';
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
          jl: ;
          Continue;
        end
        //--Добавляем ICQ контакты в КЛ
        else if Items[i].SubItems[3] = 'Icq' then
        begin
          if (Length(Items[i].Caption) = 4) and (Items[i].SubItems[0] = '') then
          begin //--Группа ICQ
            if (not ICQ_Show_HideContacts) and (Items[i].Caption = '0000') then goto il;
            for c := 0 to Categories.Count - 1 do
            begin
              //--Если такую группу нашли
              if (Categories[c].GroupId = Items[i].Caption) and (Categories[c].GroupType = 'Icq') then goto il;
              //--Размораживаем фэйс
              Application.ProcessMessages;
            end;
            //--Если такую группу не нашли, то добавляем её
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
            if (not ICQ_Show_HideContacts) and (Items[i].SubItems[1] = '0000') then goto il;
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
                      Status := StrToInt(Items[i].SubItems[6]);
                      ImageIndex := Status;
                      ImageIndex1 := StrToInt(Items[i].SubItems[7]);
                      ImageIndex2 := StrToInt(Items[i].SubItems[8]);
                      //--Если статус в сети
                      if (Status <> 9) and (Status <> 80) and (Status <> 214) then
                      begin
                        //--Поднимаем этот контакт в верх группы
                        Categories[c].Items[cc].Index := 0;
                      end
                      else //--Если статус не в сети и скрывать оффлайн контакты
                      begin
                        if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[c].GroupId <> 'NoCL') and
                          (Categories[c].GroupId <> '0000') then Categories[c].Items[cc].Free;
                      end;
                    end;
                    //--Продолжаем сканирование Ростера
                    goto il;
                  end;
                  //--Размораживаем фэйс
                  Application.ProcessMessages;
                end;
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
                goto il;
              end;
              //--Размораживаем фэйс
              Application.ProcessMessages;
            end;
          end;
          il: ;
          Continue;
        end
        //--Добавляем MRA контакты в КЛ
        else if Items[i].SubItems[3] = 'Mra' then
        begin

        end;
      end;
      //--Размораживаем фэйс
      Application.ProcessMessages;
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
        //--Размораживаем фэйс
        Application.ProcessMessages;
      end;
      //--Размораживаем фэйс
      Application.ProcessMessages;
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
end;

procedure TRosterForm.ClearContacts(cType: string);
label
  a;
var
  i: integer;
begin
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
      //--Размораживаем фэйс
      Application.ProcessMessages;
    end;
    Items.EndUpdate;
  end;
end;

end.

