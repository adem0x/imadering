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
{$ENDREGION}

{$REGION 'Procedures and Functions'}
procedure UpdateFullCL;
procedure ClearContacts(CType: string);
{$ENDREGION}

implementation

{$REGION 'MyUses'}
uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  OverbyteIcsUrl;
{$ENDREGION}

{$REGION 'UpdateFullCL'}

procedure UpdateFullCL;
label
  A, Z;
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
                        GroupImage := 311;
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
                    // Определяем режим КЛ (если отображать только онлайн контакты)
                    if (MainForm.OnlyOnlineContactsToolButton.Down and (Tri_Node.Properties.Value(C_Group + C_Id) <> C_NoCL)) and ((S = 23) or (S = 25)) then
                      Continue;
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
                          if Categories[G].Items[K].UIN = Tri_Node.Properties.Value(C_Email) then
                          begin
                            // Если такой контакт нашли
                            Contact_Yes := True;
                            // Обновляем параметры этого контакта
                            with Categories[G].Items[K] do
                            begin
                              Status := S;
                              ImageIndex := S;
                              XImageIndex := -1;
                              CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                              if Tri_Node.Properties.Value(C_Email) = C_Phone then
                              begin
                                Status := 275;
                                ImageIndex := 275;
                              end;
                              // Hint := URLDecode(Items[I].SubItems[34]);
                              // Если статус в сети
                              if (S <> 23) and (S <> 25) then
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
                            end;
                            Break;
                          end;
                        end;
                        // Добавляем контакт в эту группу в КЛ
                        if not Contact_Yes then
                        begin
                          with Categories[G].Items.Add do
                          begin
                            Caption := Trim(URLDecode(Tri_Node.Properties.Value(UpCaseOne(C_Nick))));
                            if Caption = EmptyStr then
                              Caption := Tri_Node.Properties.Value(C_Email);
                            UIN := Tri_Node.Properties.Value(C_Email);
                            Status := S;
                            ImageIndex := S;
                            XImageIndex := -1;
                            CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                            ContactType := C_Mra;
                            // Hint := URLDecode(Items[I].SubItems[34]);
                            if Categories[G].GroupId <> C_NoCL then
                              NickColor := 1
                            else
                              NickColor := 0;
                          end;
                          Break;
                        end;
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
              // Если группы "телефонных контактов" и "вне групп" пустые то удаляем их
              for G := 0 to Categories.Count - 1 do
              begin
                if (Categories[G].GroupId = LeftStr(C_Phone, 4)) or (Categories[G].GroupId = C_AuthNone) then
                begin
                  if Categories[G].Items.Count = 0 then
                    Categories[G].Free;
                end;
              end;
            end;
            // --------------------------------------------------------------------------------------------------------------------------
            // Добавляем ICQ контакты в КЛ

            // --------------------------------------------------------------------------------------------------------------------------
            // Добавляем Jabber контакты в КЛ

            // Если активен режим "Скрывать пустые группы"
            if MainForm.HideEmptyGroups.Checked then
            begin
              // Сканируем КЛ и удаляем пустые группы
              Z: ;
              for I := 0 to Categories.Count - 1 do
                if Categories[I].Items.Count = 0 then
                begin
                  Categories[I].Free;
                  goto Z;
                end;
            end;
            // Вычисляем количесво контактов и количество онлайн-контактов в группах КЛ
            for G := 0 to Categories.Count - 1 do
            begin
              if ((Categories[G].GroupId = '0000') and (Categories[G].GroupType = C_Icq)) //
              or (Categories[G].GroupId = C_NoCL) or (Categories[G].Items.Count = 0) //
              or (MainForm.OnlyOnlineContactsToolButton.Down) //
              or ((Categories[G].GroupId = LeftStr(C_Phone, 4)) and (Categories[G].GroupType = C_Mra)) then
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
                      for G := 0 to Categories.Count - 1 do
                      begin
                        XML_Node := Root.Items.ItemNamed[ChangeCP(URLEncode(Categories[G].GroupCaption + Categories[G].GroupType + Categories[G].GroupId))];
                        if XML_Node <> nil then
                          Categories[G].Collapsed := XML_Node.Properties.BoolValue(C_CS);
                      end;
                    end;
                  end;
                end;
              finally
                JvXML.Free;
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
label
  A;
var
  I: Integer;
begin
  // Удаляем контакты в КЛ
  with MainForm.ContactList do
  begin
    A: ;
    for I := 0 to Categories.Count - 1 do
    begin
      // Удаляем все группы протокола
      if Categories[I].GroupType = CType then
      begin
        Categories[I].Free;
        goto A;
      end;
    end;
  end;
end;
{$ENDREGION}

end.

