unit RosterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, JvExComCtrls, JvListView;

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
    procedure UpdateCL(cId: string);
  end;

var
  RosterForm: TRosterForm;

implementation

{$R *.dfm}

uses
  MainUnit;

procedure TRosterForm.UpdateFullCL;
label
  jl;
var
  i, c, cc: integer;
begin
  //--Обрабатываем весь Ростер
  with RosterJvListView do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      if Items[i].Caption <> EmptyStr then
      begin
        with MainForm.ContactList do
        begin
          //--Добавляем Jabber контакты в КЛ
          if Items[i].SubItems.Strings[3] = 'Jabber' then
          begin
            //--Ищем группу контакта в КЛ
            for c := 0 to Categories.Count - 1 do
            begin
              //--Если такую группу нашли
              if (Categories[c].GroupCaption = Items[i].SubItems.Strings[1]) and
                (Categories[c].GroupType = 'Jabber') then
              begin
                //--Начинаем поиск в ней этого контакта
                for cc := 0 to Categories[c].Items.Count - 1 do
                begin
                  if Categories[c].Items[cc].UIN = Items[i].Caption then
                  begin
                    //--Обновляем информацию для этого контакта в КЛ
                    //Categories[c].Items[cc]
                    //--Продолжаем сканирование Ростера
                    goto jl;
                  end;
                  //--Размораживаем фэйс
                  Application.ProcessMessages;
                end;
                //--Добавляем контакт в эту группу в КЛ
                with Categories[c].Items.Add do
                begin
                  Caption := Items[i].SubItems.Strings[0];
                  UIN := Items[i].Caption;
                  Status := 30;
                  ImageIndex := 30;
                  ImageIndex1 := -1;
                  ImageIndex2 := -1;
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
              Caption := RosterJvListView.Items[i].SubItems.Strings[1];
              GroupCaption := RosterJvListView.Items[i].SubItems.Strings[1];
              GroupType := 'Jabber';
              //--Добавляем контакт в эту группу в КЛ
              with Items.Add do
              begin
                Caption := RosterJvListView.Items[i].SubItems.Strings[0];
                UIN := RosterJvListView.Items[i].Caption;
                Status := 30;
                ImageIndex := 30;
                ImageIndex1 := -1;
                ImageIndex2 := -1;
              end;
            end;
            jl: ;
            Continue;
          end
          //--Добавляем ICQ контакты в КЛ
          else if Items[i].SubItems.Strings[3] = 'Icq' then
          begin

          end;
        end;
      end;
      //--Размораживаем фэйс
      Application.ProcessMessages;
    end;
  end;
end;

procedure TRosterForm.UpdateCL(cId: string);
begin
  //--Обрабатываем запись в Ростере
  if RosterJvListView.FindCaption(0, cId, true, true, false) <> nil then
  begin

  end;
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
      //--Удаляем все контакты протокола ICQ
      if Items[i].SubItems.Strings[3] = cType then
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

