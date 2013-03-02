unit PlugInPluginTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, ImgList;

type
  TPluginTest = class(TJvPlugIn)
    Image_List: TImageList;
    procedure JvPlugInInitialize(Sender: TObject; var AllowLoad: Boolean);
    procedure PluginTestCommands0Execute(Sender: TObject);
    procedure JvPlugInConfigure(Sender: TObject);
    procedure JvPlugInPluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
    procedure JvPlugInPluginMessageWithObj(Sender: TObject; APluginMessage: Integer; AMessageText: string;
      AObj: TObject);
  private
    { Private declarations }
    procedure Test1_Click(Sender: TObject);
    procedure Test2_Click(Sender: TObject);
    procedure Parse_Event(v_Channel: Integer; v_Text, v_Object: string);
    procedure X_Form_Activate(Sender: TObject);
  public
    { Public declarations }
  end;

function RegisterPlugin: TJvPlugIn; stdcall;

var
  v_My_Path: string;
  v_My_Plugin: TPluginTest;

implementation

{$R *.dfm}

uses
  Test_Unit;

// IMPORTANT NOTE: If you change the name of the Plugin container,
// you must set the type below to the same type. (Delphi changes
// the declaration, but not the procedure itself. Both the return
// type and the type created must be the same as the declared type above.

function RegisterPlugin: TJvPlugIn;
begin
  v_My_Plugin := TPluginTest.Create(nil);
  Result := v_My_Plugin;
end;

procedure X_Show_Form(v_Self_Form: TForm; v_Main_Form: TForm = nil);
begin
  // Автоматизируем показ окон
  v_Self_Form.Show;
  SetActiveWindow(v_Self_Form.Handle);
  ShowWindow(v_Self_Form.Handle, SW_SHOW);
  if v_Self_Form.WindowState = wsMinimized then
    ShowWindow(v_Self_Form.Handle, SW_Restore);
  BringWindowToTop(v_Self_Form.Handle);
  SetForeGroundWindow(v_Self_Form.Handle);
  if v_Main_Form <> nil then
  begin
    if v_Main_Form.FormStyle = FsStayOnTop then
      v_Self_Form.FormStyle := FsStayOnTop
    else if v_Main_Form.FormStyle = FsNormal then
      v_Self_Form.FormStyle := FsNormal;
  end;
end;

procedure TPluginTest.X_Form_Activate(Sender: TObject);
var
  v_Self_Form, v_Main_Form: TForm;
begin
  // Обновляем режим отображения для окон
  v_Self_Form := (Sender as TForm);
  v_Main_Form := HostApplication.MainForm;
  if (v_Main_Form <> nil) and (v_Self_Form <> nil) then
  begin
    if v_Main_Form.FormStyle = FsStayOnTop then
      v_Self_Form.FormStyle := FsStayOnTop
    else if v_Main_Form.FormStyle = FsNormal then
      v_Self_Form.FormStyle := FsNormal;
  end;
end;

procedure TPluginTest.Parse_Event(v_Channel: Integer; v_Text, v_Object: string);
begin
  // Обрабатываем входящее событие
 { ShowMessage('Channel: ' + IntToStr(v_Channel) + #13#10
   + 'Text: ' + v_Text + #13#10
   + 'Object: ' + v_Object + #13#10
   + 'Plugin ID: ' + PluginID); }
end;

procedure TPluginTest.JvPlugInConfigure(Sender: TObject);
begin
  // Открываем окно настройки плагина
  ShowMessage('Configure plugin: ' + PluginID);
end;

procedure TPluginTest.JvPlugInInitialize(Sender: TObject; var AllowLoad: Boolean);

  function Extract_File_Name_Only(File_Path: string): string;
  var
    I: Integer;
    File_Name_Only: string;
  begin
    File_Name_Only := ExtractFileName(File_Path);
    I := Length(File_Name_Only);
    while (I > 0) and not (File_Name_Only[I] = '.') do
      Dec(I);
    if (I = 0) or (File_Name_Only[I] <> '.') then
      I := MaxInt;
    Result := Copy(File_Name_Only, 1, I - 1);
  end;

begin
  if AllowLoad then
  begin
    // Устанавливаем уникальный идентификатор плагина
    PluginID := Extract_File_Name_Only(Self.FileName);
    // Узнаём путь откуда запущена программа
    V_My_Path := ExtractFilePath(HostApplication.ExeName);
    // Создаем тестовое окно
    Test_Form := TTest_Form.Create(Self);
    // Подвязываем событие кнопок тестов
    Test_Form.Test1_Button.OnClick := Test1_Click;
    Test_Form.Test2_Button.OnClick := Test2_Click;
    // Подвязываем событие активации окна
    Test_Form.OnActivate := X_Form_Activate;
    // Устанавливаем иконку этого плагина в меню
    TJvPluginCommand(Commands.Items[0]).Caption := '<plugin_menu_icon>';
    TJvPluginCommand(Commands.Items[0]).Hint := PluginID;
    TJvPluginCommand(Commands.Items[0]).Data := 'Icons\0.ico';
    // Устанавливаем параметры тестовой команды 1
    TJvPluginCommand(Commands.Items[1]).Caption := 'Test Command';
    TJvPluginCommand(Commands.Items[1]).Hint := PluginID;
    Image_List.GetIcon(0, TJvPluginCommand(Commands.Items[1]).Icon);
    // Устанавливаем параметры команды разделителя меню
    TJvPluginCommand(Commands.Items[2]).Caption := '<plugin_menu_separator>';
    TJvPluginCommand(Commands.Items[2]).Hint := PluginID;
    // Устанавливаем параметры тестовой команды 2
    TJvPluginCommand(Commands.Items[3]).Caption := 'Settings';
    TJvPluginCommand(Commands.Items[3]).Hint := PluginID;
    TJvPluginCommand(Commands.Items[3]).Data := 'Icons\26.ico';
    TJvPluginCommand(Commands.Items[3]).OnExecute := JvPlugInConfigure;
  end;
end;

procedure TPluginTest.JvPlugInPluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
begin
  // Обрабатываем сообщения
  Parse_Event(APluginMessage, AMessageText, EmptyStr);
end;

procedure TPluginTest.JvPlugInPluginMessageWithObj(Sender: TObject; APluginMessage: Integer; AMessageText: string;
  AObj: TObject);
begin
  // Обрабатываем сообщения с объектом
  Parse_Event(APluginMessage, AMessageText, AObj.ToString);
end;

procedure TPluginTest.PluginTestCommands0Execute(Sender: TObject);
begin
  // Открываем окно теста
  if Assigned(Test_Form) then
    X_Show_Form(Test_Form, HostApplication.MainForm);
  // Заносим ID плагина в заголовок окна
  Test_Form.Caption := PluginID;
end;

procedure TPluginTest.Test1_Click(Sender: TObject);
begin
  // Отправляем событие в программу IMadering
  if HostApplication.MainForm <> nil then
  begin
    BroadcastMsgToALL(2, '<test sender="' + PluginID + '">button test1 click</test>');
  end;
end;

procedure TPluginTest.Test2_Click(Sender: TObject);
begin
  // Отправляем событие в программу IMadering
  if HostApplication.MainForm <> nil then
  begin
    BroadcastMsgToALLObj(2, '<test sender="' + PluginID + '">button test2 click</test>', Sender);
  end;
end;

end.

