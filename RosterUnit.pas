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
  JvSimpleXml,
  ChatUnit;
{$ENDREGION}

{$REGION 'Procedures and Functions'}
procedure UpdateFullCL;
procedure ClearContacts(CType: string);
procedure OpenChatPage(CButton: TButtonItem; Proto: string);
function RosterGetItem(R_Proto, R_Section, R_Item, R_Value: string): TJvSimpleXmlElem;
procedure RosterUpdateProp(R_Node: TJvSimpleXmlElem; R_Prop, R_Value: string);
procedure DellcIdInMessList(CId: string);
function ReqChatPage(CId: string): TToolButton;
function ReqCLContact(CProto, CId: string): TButtonItem;
{$ENDREGION}

implementation

{$REGION 'MyUses'}
uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  OverbyteIcsUrl,
  IcqProtoUnit;
{$ENDREGION}

{$REGION 'OpenChatPage'}

procedure OpenChatPage(CButton: TButtonItem; Proto: string);
label
  A;
var
  ChatTab: TToolButton;
  I: Integer;
  Get_Node: TJvSimpleXmlElem;
begin
  if (CButton <> nil) and (Proto <> EmptyStr) then
  begin
    // Если окно чата не создано, то создаём его
    if not Assigned(ChatForm) then
      Application.CreateForm(TChatForm, ChatForm);
    with ChatForm do
    begin
      // Сохраняем набранный текст для открытой вкладки в чате
      Save_Input_Text;
      // Открываем вкладку в чате
      with ChatPageToolBar do
      begin
        // Удаляем кнопку с меткой удаления (против глюка в Wine)
        if (ButtonCount = 1) and (Buttons[0].AutoSize = False) then
          RemoveChatPageButton(Buttons[0]);
        // Ищем вкладку в табе
        for I := 0 to ButtonCount - 1 do
        begin
          if Buttons[I].HelpKeyword = CButton.UIN then
          begin
            Buttons[I].Down := True;
            CreateNewChat(Buttons[I]);
            // Выходим
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
        User_Proto := Proto;
        CreateNewChat(ChatTab);
      end;
      A: ;
      // Испраляем глюк тулбара закладок чата (те кто писал ComCtrls.pas - пиздюки)
      ChatPageToolBar.Realign;
      // Отображаем окно сообщений
      XShowForm(ChatForm);
      // Ставим фокус в поле ввода текста
      if (InputRichEdit.CanFocus) and (ChatForm.Visible) then
        InputRichEdit.SetFocus;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'UpdateFullCL'}

procedure UpdateFullCL;
label
  A;
var
  I, G, K, S: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Group_Yes, Contact_Yes: Boolean;
  JvXML: TJvSimpleXml;
begin
  with MainForm.ContactList do
  begin
    try
      // Начинаем обновление КЛ
      Categories.BeginUpdate;
      // Сканируем Ростер
      if V_Roster <> nil then
      begin
        with V_Roster do
        begin
          if Root <> nil then
          begin
            // --------------------------------------------------------------------------------------------------------------------------
            // Добавляем MRA контакты в КЛ
            XML_Node := Root.Items.ItemNamed[C_Mra];
            if XML_Node <> nil then
            begin
              // Открываем раздел с группами
              Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
              if Sub_Node <> nil then
              begin
                // Запускаем цикл сканирования групп
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    // Сканируем группы КЛ
                    Group_Yes := False;
                    for G := 0 to Categories.Count - 1 do
                    begin
                      if (Categories[G].GroupId = Tri_Node.Properties.Value(C_Id)) and (Categories[G].GroupType = C_Mra) then
                      begin
                        // Если такую группу нашли
                        Group_Yes := True;
                        // Обновляем название этой группы
                        Categories[G].Caption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        Categories[G].GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        Break;
                      end;
                    end;
                    // Если такую группу не нашли, то добавляем её
                    if not Group_Yes then
                    begin
                      with Categories.Add do
                      begin
                        Caption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        GroupId := Tri_Node.Properties.Value(C_Id);
                        GroupType := C_Mra;
                        GroupImage := 66;
                      end;
                    end;
                  end;
                end;
              end;
              // Открываем раздел с контактами
              Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
              if Sub_Node <> nil then
              begin
                // Запускаем цикл сканирования контактов
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    A: ;
                    // Запоминаем статус этого контакта
                    S := Tri_Node.Properties.IntValue(C_Status);
                    // Сканируем группу контакта в КЛ
                    Group_Yes := False;
                    Contact_Yes := False;
                    for G := 0 to Categories.Count - 1 do
                    begin
                      // Если такую группу нашли
                      if (RightStr(Categories[G].GroupId, 4) = Tri_Node.Properties.Value(C_Group + C_Id)) and (Categories[G].GroupType = C_Mra) then
                      begin
                        Group_Yes := True;
                        // Начинаем поиск в ней этого контакта
                        for K := 0 to Categories[G].Items.Count - 1 do
                        begin
                          if Categories[G].Items[K].UIN = Tri_Node.Properties.Value(C_Login) then
                          begin
                            // Если такой контакт нашли
                            Contact_Yes := True;
                            // Обновляем параметры этого контакта
                            with Categories[G].Items[K] do
                            begin
                              Status := S;
                              if Tri_Node.Properties.Value(C_Mess) = C_XX then
                                ImageIndex := 165
                              else
                                ImageIndex := S;
                              XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                              CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                              // Если статус в сети
                              if (S <> 23) and (S <> 25) and (S <> 275) then
                              begin
                                // Поднимаем этот контакт вверх группы
                                index := 0;
                                // Назначаем ему синий цвет
                                NickColor := 2;
                              end
                              else // Если статус не в сети и скрывать оффлайн контакты
                              begin
                                if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[G].GroupId <> C_NoCL) and (Categories[G].GroupId <> C_Phone_m2) then
                                  Free
                                else
                                begin
                                  // Опускаем контакт в конец группы
                                  index := Categories[G].Items.Count - 1;
                                  // Назначаем ему темнокрасный цвет
                                  if Categories[G].GroupId <> C_NoCL then
                                    NickColor := 1
                                  else
                                    NickColor := 0;
                                end;
                              end;
                              // Hint := URLDecode(Items[I].SubItems[34]);
                            end;
                            Break;
                          end;
                        end;
                        // Добавляем контакт в эту группу в КЛ
                        if not Contact_Yes then
                        begin
                          // Если статус не в сети и скрывать оффлайн контакты
                          if (S = 23) and (MainForm.OnlyOnlineContactsToolButton.Down) and //
                          (Categories[G].GroupId <> C_NoCL) and (Categories[G].GroupId <> C_Phone_m2) then
                            Continue;
                          // Добавляем контакт
                          with Categories[G].Items.Add do
                          begin
                            Caption := Trim(URLDecode(Tri_Node.Properties.Value(C_Nick)));
                            if Caption = EmptyStr then
                              Caption := Tri_Node.Properties.Value(C_Login);
                            UIN := Tri_Node.Properties.Value(C_Login);
                            Status := S;
                            if Tri_Node.Properties.Value(C_Mess) = C_XX then
                              ImageIndex := 165
                            else
                              ImageIndex := S;
                            XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                            CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                            PImageIndex := -1;
                            // Если статус в сети
                            if (S <> 23) and (S <> 275) and (S <> 312) then
                            begin
                              // Поднимаем этот контакт вверх группы
                              index := 0;
                              // Назначаем ему синий цвет
                              NickColor := 2;
                            end
                            else
                            begin
                              if Categories[G].GroupId <> C_NoCL then
                                NickColor := 1
                              else
                                NickColor := 0;
                            end;
                            ContactType := C_Mra;
                            // Hint := URLDecode(Items[I].SubItems[34]);
                          end;
                        end;
                        Break;
                      end;
                    end;
                    // Если такая группа не была найдена
                    if not Group_Yes then
                    begin
                      // Добавляем такие контакты в специальную группу
                      Tri_Node.Properties.ItemNamed[C_Group + C_Id].Value := C_AuthNone;
                      goto A;
                    end;
                  end;
                end;
              end;
            end;
            // --------------------------------------------------------------------------------------------------------------------------
            // Добавляем ICQ контакты в КЛ
            XML_Node := Root.Items.ItemNamed[C_Icq];
            if XML_Node <> nil then
            begin
              // Открываем раздел с группами
              Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
              if Sub_Node <> nil then
              begin
                // Запускаем цикл сканирования групп
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    // Сканируем группы КЛ
                    Group_Yes := False;
                    for G := 0 to Categories.Count - 1 do
                    begin
                      if (Categories[G].GroupId = Tri_Node.Properties.Value(C_Id)) and (Categories[G].GroupType = C_Icq) then
                      begin
                        // Если такую группу нашли
                        Group_Yes := True;
                        // Обновляем название этой группы
                        Categories[G].Caption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        Categories[G].GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        Break;
                      end;
                    end;
                    // Если такую группу не нашли, то добавляем её
                    if not Group_Yes then
                    begin
                      with Categories.Add do
                      begin
                        Caption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        GroupId := Tri_Node.Properties.Value(C_Id);
                        GroupType := C_Icq;
                        GroupImage := 242;
                        // Сворачиваем группу временных контактов
                        if GroupId = '0000' then
                          Collapsed := True;
                      end;
                    end;
                  end;
                end;
              end;
              // Открываем раздел с контактами
              Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
              if Sub_Node <> nil then
              begin
                // Запускаем цикл сканирования контактов
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    // Запоминаем статус этого контакта
                    S := Tri_Node.Properties.IntValue(C_Status);
                    // Сканируем группу контакта в КЛ
                    Group_Yes := False;
                    Contact_Yes := False;
                    for G := 0 to Categories.Count - 1 do
                    begin
                      // Если такую группу нашли
                      if (Categories[G].GroupId = Tri_Node.Properties.Value(C_Group + C_Id)) and (Categories[G].GroupType = C_Icq) then
                      begin
                        Group_Yes := True;
                        // Начинаем поиск в ней этого контакта
                        for K := 0 to Categories[G].Items.Count - 1 do
                        begin
                          if Categories[G].Items[K].UIN = Tri_Node.Properties.Value(C_Login) then
                          begin
                            // Если такой контакт нашли
                            Contact_Yes := True;
                            // Обновляем параметры этого контакта
                            with Categories[G].Items[K] do
                            begin
                              Status := S;
                              if Tri_Node.Properties.Value(C_Mess) = C_XX then
                                ImageIndex := 165
                              else
                                ImageIndex := S;
                              XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                              CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                              // Если статус в сети
                              if (S <> 9) and (S <> 80) and (S <> 214) then
                              begin
                                // Поднимаем этот контакт вверх группы
                                index := 0;
                                // Назначаем ему синий цвет
                                NickColor := 2;
                              end
                              else // Если статус не в сети и скрывать оффлайн контакты
                              begin
                                if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[G].GroupId <> C_NoCL) and (Categories[G].GroupId <> C_Phone_m2) then
                                  Free
                                else
                                begin
                                  // Опускаем контакт в конец группы
                                  index := Categories[G].Items.Count - 1;
                                  // Назначаем ему темнокрасный цвет
                                  if Categories[G].GroupId <> C_NoCL then
                                    NickColor := 1
                                  else
                                    NickColor := 0;
                                end;
                              end;
                              // Hint := URLDecode(Items[I].SubItems[34]);
                            end;
                            Break;
                          end;
                        end;
                        // Добавляем контакт в эту группу в КЛ
                        if not Contact_Yes then
                        begin
                          // Если статус не в сети и скрывать оффлайн контакты
                          if (S = 9) and (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[G].GroupId <> C_NoCL) then
                            Continue;
                          // Добавляем контакт
                          with Categories[G].Items.Add do
                          begin
                            Caption := Trim(URLDecode(Tri_Node.Properties.Value(C_Nick)));
                            if Caption = EmptyStr then
                              Caption := Tri_Node.Properties.Value(C_Login);
                            UIN := Tri_Node.Properties.Value(C_Login);
                            Status := S;
                            if Tri_Node.Properties.Value(C_Mess) = C_XX then
                              ImageIndex := 165
                            else
                              ImageIndex := S;
                            XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                            CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                            PImageIndex := -1;
                            // Если статус в сети
                            if (S <> 9) and (S <> 214) then
                            begin
                              // Поднимаем этот контакт вверх группы
                              index := 0;
                              // Назначаем ему синий цвет
                              NickColor := 2;
                            end
                            else
                            begin
                              if Categories[G].GroupId <> C_NoCL then
                                NickColor := 1
                              else
                                NickColor := 0;
                            end;
                            ContactType := C_Icq;
                            // Hint := URLDecode(Items[I].SubItems[34]);
                          end;
                        end;
                        Break;
                      end;
                    end;
                  end;
                end;
              end;
            end;
            // --------------------------------------------------------------------------------------------------------------------------
            // Добавляем Jabber контакты в КЛ
            XML_Node := Root.Items.ItemNamed[C_Jabber];
            if XML_Node <> nil then
            begin
              // Открываем раздел с группами
              Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
              if Sub_Node <> nil then
              begin
                // Запускаем цикл сканирования групп
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    // Сканируем группы КЛ
                    Group_Yes := False;
                    for G := 0 to Categories.Count - 1 do
                    begin
                      if (Categories[G].GroupId = Tri_Node.Properties.Value(C_Id)) and (Categories[G].GroupType = C_Jabber) then
                      begin
                        // Если такую группу нашли
                        Group_Yes := True;
                        // Обновляем название этой группы
                        Categories[G].Caption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        Categories[G].GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        Break;
                      end;
                    end;
                    // Если такую группу не нашли, то добавляем её
                    if not Group_Yes then
                    begin
                      with Categories.Add do
                      begin
                        Caption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Name));
                        GroupId := Tri_Node.Properties.Value(C_Id);
                        GroupType := C_Jabber;
                        GroupImage := 43;
                      end;
                    end;
                  end;
                end;
              end;
              // Открываем раздел с контактами
              Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
              if Sub_Node <> nil then
              begin
                // Запускаем цикл сканирования контактов
                for I := 0 to Sub_Node.Items.Count - 1 do
                begin
                  Tri_Node := Sub_Node.Items.Item[I];
                  if Tri_Node <> nil then
                  begin
                    // Запоминаем статус этого контакта
                    S := Tri_Node.Properties.IntValue(C_Status);
                    // Сканируем группу контакта в КЛ
                    Group_Yes := False;
                    Contact_Yes := False;
                    for G := 0 to Categories.Count - 1 do
                    begin
                      // Если такую группу нашли
                      if (Categories[G].GroupId = Tri_Node.Properties.Value(C_Group + C_Id)) and (Categories[G].GroupType = C_Jabber) then
                      begin
                        Group_Yes := True;
                        // Начинаем поиск в ней этого контакта
                        for K := 0 to Categories[G].Items.Count - 1 do
                        begin
                          if Categories[G].Items[K].UIN = Tri_Node.Properties.Value(C_Login) then
                          begin
                            // Если такой контакт нашли
                            Contact_Yes := True;
                            // Обновляем параметры этого контакта
                            with Categories[G].Items[K] do
                            begin
                              Status := S;
                              if Tri_Node.Properties.Value(C_Mess) = C_XX then
                                ImageIndex := 165
                              else
                                ImageIndex := S;
                              XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                              CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                              // Если статус в сети
                              if (S <> 30) and (S <> 42) then
                              begin
                                // Поднимаем этот контакт вверх группы
                                index := 0;
                                // Назначаем ему синий цвет
                                NickColor := 2;
                              end
                              else // Если статус не в сети и скрывать оффлайн контакты
                              begin
                                if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[G].GroupId <> C_NoCL) then
                                  Free
                                else
                                begin
                                  // Опускаем контакт в конец группы
                                  index := Categories[G].Items.Count - 1;
                                  // Назначаем ему темнокрасный цвет
                                  if Categories[G].GroupId <> C_NoCL then
                                    NickColor := 1
                                  else
                                    NickColor := 0;
                                end;
                              end;
                              // Hint := URLDecode(Items[I].SubItems[34]);
                            end;
                            Break;
                          end;
                        end;
                        // Добавляем контакт в эту группу в КЛ
                        if not Contact_Yes then
                        begin
                          // Если статус не в сети и скрывать оффлайн контакты
                          if (S = 30) and (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[G].GroupId <> C_NoCL) then
                            Continue;
                          // Добавляем контакт
                          with Categories[G].Items.Add do
                          begin
                            Caption := Trim(URLDecode(Tri_Node.Properties.Value(C_Nick)));
                            if Caption = EmptyStr then
                              Caption := Tri_Node.Properties.Value(C_Login);
                            UIN := Tri_Node.Properties.Value(C_Login);
                            Status := S;
                            if Tri_Node.Properties.Value(C_Mess) = C_XX then
                              ImageIndex := 165
                            else
                              ImageIndex := S;
                            XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                            CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                            PImageIndex := -1;
                            // Если статус в сети
                            if (S <> 30) and (S <> 42) then
                            begin
                              // Поднимаем этот контакт вверх группы
                              index := 0;
                              // Назначаем ему синий цвет
                              NickColor := 2;
                            end
                            else
                            begin
                              if Categories[G].GroupId <> C_NoCL then
                                NickColor := 1
                              else
                                NickColor := 0;
                            end;
                            ContactType := C_Jabber;
                            // Hint := URLDecode(Items[I].SubItems[34]);
                          end;
                        end;
                        Break;
                      end;
                    end;
                    // Если такую группу не нашли
                    if not Group_Yes then
                    begin
                      with Categories.Add do
                      begin
                        Caption := URLDecode(Tri_Node.Properties.Value(C_Group + C_Id));
                        GroupCaption := URLDecode(Tri_Node.Properties.Value(C_Group + C_Id));
                        GroupId := Tri_Node.Properties.Value(C_Group + C_Id);
                        GroupType := C_Jabber;
                        GroupImage := 43;
                        // Если статус не в сети и скрывать оффлайн контакты
                        if (S = 9) and (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[G].GroupId <> C_NoCL) then
                          Continue;
                        // Добавляем контакт в эту группу в КЛ
                        with Items.Add do
                        begin
                          Caption := Trim(URLDecode(Tri_Node.Properties.Value(C_Nick)));
                          if Caption = EmptyStr then
                            Caption := Tri_Node.Properties.Value(C_Login);
                          UIN := Tri_Node.Properties.Value(C_Login);
                          Status := S;
                          if Tri_Node.Properties.Value(C_Mess) = C_XX then
                            ImageIndex := 165
                          else
                            ImageIndex := S;
                          XImageIndex := Tri_Node.Properties.IntValue(C_XStatus);
                          CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                          PImageIndex := -1;
                          // Если статус в сети
                          if (S <> 30) and (S <> 42) then
                          begin
                            // Поднимаем этот контакт вверх группы
                            index := 0;
                            // Назначаем ему синий цвет
                            NickColor := 2;
                          end
                          else
                          begin
                            if Categories[G].GroupId <> C_NoCL then
                              NickColor := 1
                            else
                              NickColor := 0;
                          end;
                          ContactType := C_Jabber;
                          // Hint := URLDecode(Items[I].SubItems[34]);
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
            // Если группы "телефонных контактов" и "вне групп" и "не в списке" и "игнорируемые" пустые то удаляем их
            // Если активен режим "Скрывать пустые группы"
            I := 0;
            for G := 0 to Categories.Count - 1 do
            begin
              if (Categories[I].GroupId = C_Phone_m2) or (Categories[I].GroupId = C_AuthNone) or //
              (Categories[I].GroupId = C_NoCL) or (Categories[I].GroupId = C_IgCL) or MainForm.HideEmptyGroups.Checked then
              begin
                if Categories[I].Items.Count = 0 then
                begin
                  Categories[I].Free;
                  Dec(I);
                end;
              end;
              Inc(I);
            end;
            // Вычисляем количесво контактов и количество онлайн-контактов в группах КЛ
            for G := 0 to Categories.Count - 1 do
            begin
              if ((Categories[G].GroupId = '0000') and (Categories[G].GroupType = C_Icq)) //
              or (Categories[G].GroupId = C_NoCL) or (Categories[G].Items.Count = 0) //
              or (MainForm.OnlyOnlineContactsToolButton.Down) //
              or ((Categories[G].GroupId = C_Phone_m2) and (Categories[G].GroupType = C_Mra)) then
                Categories[G].Caption := Categories[G].GroupCaption + C_BN + '-' + C_BN + IntToStr(Categories[G].Items.Count)
              else
              begin
                I := Categories[G].Items.Count;
                for K := 0 to Categories[G].Items.Count - 1 do
                  case Categories[G].Items[K].Status of
                    9, 23, 25, 30, 41, 42, 80, 83, 84, 214, 298, 299, 300, 312: Dec(I);
                  end;
                Categories[G].Caption := Categories[G].GroupCaption + C_BN + '-' + C_BN + Format('%d/%d', [I, Categories[G].Items.Count]);
              end;
            end;
            // Восстанавливаем состояние свёрнутых групп
            if V_CollapseGroupsRestore then
            begin
              // Ищем раздел состояния групп
              XML_Node := Root.Items.ItemNamed[C_Group + C_SS];
              if XML_Node <> nil then
              begin
                for G := 0 to Categories.Count - 1 do
                begin
                  Sub_Node := XML_Node.Items.ItemNamed[ChangeCP(URLEncode(Categories[G].GroupCaption + Categories[G].GroupType + Categories[G].GroupId))];
                  if Sub_Node <> nil then
                    Categories[G].Collapsed := Sub_Node.Properties.BoolValue(C_CS);
                end;
              end;
              V_CollapseGroupsRestore := False;
            end;
          end;
        end;
      end;
    finally
      // Заканчиваем обновление КЛ
      Categories.EndUpdate;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'ClearContacts'}

procedure ClearContacts(CType: string);
var
  I, Z: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Удаляем контакты из Ростера
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Очищаем раздел протокола если он есть
        XML_Node := Root.Items.ItemNamed[CType];
        if XML_Node = nil then
          XML_Node := Root.Items.Add(CType)
        else
          XML_Node.Clear;
        // Создаём в разделе протокола секцию групп
        Sub_Node := XML_Node.Items.Add(C_Group + C_SS);
        // Добавляем группу для контактов "не в списке"
        Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_NoCL);
        Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[33].L_S));
        Tri_Node.Properties.Add(C_Id, C_NoCL);
        // Создаём в разделе протокола секцию контактов
        XML_Node.Items.Add(C_Contact + C_SS);
      end;
    end;
  end;
  // Удаляем контакты в КЛ
  with MainForm.ContactList do
  begin
    Z := 0;
    for I := 0 to Categories.Count - 1 do
    begin
      // Удаляем все группы протокола
      if Categories[Z].GroupType = CType then
      begin
        Categories[Z].Free;
        Dec(Z);
      end;
      Inc(Z);
    end;
  end;
end;
{$ENDREGION}
{$REGION 'GetRosterItem'}

function RosterGetItem(R_Proto, R_Section, R_Item, R_Value: string): TJvSimpleXmlElem;
var
  I: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Получаем из Ростера искомую ноду
  Result := nil;
  if (R_Proto <> EmptyStr) and (R_Section <> EmptyStr) and (R_Item <> EmptyStr) and (R_Value <> EmptyStr) then
  begin
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          // Ищем раздел нужного нам протокола
          XML_Node := Root.Items.ItemNamed[R_Proto];
          if XML_Node <> nil then
          begin
            // Ищем нужную нам секцию в этом протоколе
            Sub_Node := XML_Node.Items.ItemNamed[R_Section];
            if Sub_Node <> nil then
            begin
              // Ищем параметр этого контакта
              for I := 0 to Sub_Node.Items.Count - 1 do
              begin
                Tri_Node := Sub_Node.Items.Item[I];
                if Tri_Node <> nil then
                begin
                  if Tri_Node.Properties.Value(R_Item) = R_Value then
                  begin
                    // Получаем искомую ноду
                    Result := Tri_Node;
                    // Прерываем цикл
                    Break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'RosterUpdateProp'}

procedure RosterUpdateProp(R_Node: TJvSimpleXmlElem; R_Prop, R_Value: string);
var
  XML_Prop: TJvSimpleXMLProp;
begin
  // Обновляем или добавляем параметр в ростере
  XML_Prop := R_Node.Properties.ItemNamed[R_Prop];
  if XML_Prop <> nil then
    XML_Prop.Value := R_Value
  else
    R_Node.Properties.Add(R_Prop, R_Value);
end;
{$ENDREGION}
{$REGION 'DellcIdInMessList'}

procedure DellcIdInMessList(CId: string);
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
{$REGION 'ReqChatPage'}

function ReqChatPage(CId: string): TToolButton;
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
{$REGION 'ReqCLContact'}

function ReqCLContact(CProto, CId: string): TButtonItem;
var
  G, K: Integer;
begin
  Result := nil;
  // Ищем контакт в КЛ
  with MainForm.ContactList do
  begin
    for G := 0 to Categories.Count - 1 do
    begin
      for K := 0 to Categories[G].Items.Count - 1 do
      begin
        if (Categories[G].Items[K].ContactType = CProto) and (Categories[G].Items[K].UIN = CId) then
        begin
          Result := Categories[G].Items[K];
          // Выходим из циклов
          Exit;
        end;
      end;
    end;
  end;
end;
{$ENDREGION}
end.

