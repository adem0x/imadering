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

procedure UpdateFullCL;

implementation

{$REGION 'MyUses'}
uses
  MainUnit,
  VarsUnit,
  UtilsUnit,
  OverbyteIcsUrl;
{$ENDREGION}

procedure UpdateFullCL;
var
  I, G, K: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Group_Yes, Contact_Yes: Boolean;
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
                        GroupImage := 268;
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
                              Status := Tri_Node.Properties.IntValue(C_Status);
                              ImageIndex := Status;
                              XImageIndex := -1;
                              CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                              if Tri_Node.Properties.Value(C_Email) = C_Phone then
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
                        // Определяем режим КЛ
                        {if (MainForm.OnlyOnlineContactsToolButton.Down) and (Categories[C].GroupId <> C_NoCL) and ((S = 23) or (S = 25)) then
                          goto X;}
                        // Добавляем контакт в эту группу в КЛ
                        if not Contact_Yes then
                        begin
                          with Categories[G].Items.Add do
                          begin
                            Caption := URLDecode(Tri_Node.Properties.Value(UpCaseOne(C_Nick)));
                            UIN := Tri_Node.Properties.Value(C_Email);
                            Status := Tri_Node.Properties.IntValue(C_Status);
                            ImageIndex := Status;
                            XImageIndex := -1;
                            CImageIndex := Tri_Node.Properties.IntValue(C_Client);
                            ContactType := C_Mra;
                            if UIN = C_Phone then
                            begin
                              Status := 275;
                              ImageIndex := 275;
                            end;
                            // Hint := URLDecode(Items[I].SubItems[34]);
                            if Categories[G].GroupId <> C_NoCL then
                              NickColor := 1
                            else
                              NickColor := 0;
                          end;
                          Contact_Yes := True;
                        end;
                      end;
                      // Если контакт был найден в греппе
                      if Contact_Yes then
                        Break;
                    end;
                  end;
                end;
              end;
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

end.

