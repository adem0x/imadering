unit PlugInDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin;

type
  TDemo = class(TJvPlugIn)
    procedure DemoCommands0Execute(Sender: TObject);
    procedure JvPlugInConfigure(Sender: TObject);
    procedure JvPlugInInitialize(Sender: TObject; var AllowLoad: Boolean);
    procedure JvPlugInPluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
    procedure JvPlugInDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
end;

function RegisterPlugin: TJvPlugIn; stdcall;

implementation

{$R *.dfm}

uses
  ChannelDataUnit;

// IMPORTANT NOTE: If you change the name of the Plugin container,
// you must set the type below to the same type. (Delphi changes
// the declaration, but not the procedure itself. Both the return
// type and the type created must be the same as the declared type above.
function RegisterPlugin: TJvPlugIn;
begin
  Result := TDemo.Create(nil);
end;

procedure TDemo.DemoCommands0Execute(Sender: TObject);
begin
  // Show channel windows
  if not Assigned(ChannelDataForm) then
    ChannelDataForm := TChannelDataForm.Create(self);
  ChannelDataForm.Show;
  ChannelDataForm.ChannelDataMemo.Lines.Add('> Plugin Demo Command <');
  ChannelDataForm.TestOutDataClick(nil);
end;

procedure TDemo.JvPlugInConfigure(Sender: TObject);
begin
  // Show channel windows
  if not Assigned(ChannelDataForm) then
    ChannelDataForm := TChannelDataForm.Create(self);
  ChannelDataForm.Show;
  ChannelDataForm.ChannelDataMemo.Lines.Add('> Configure plugin <');
end;

procedure TDemo.JvPlugInDestroy(Sender: TObject);
begin
  // Free Show Channel Form
  if Assigned(ChannelDataForm) then
    FreeAndNil(ChannelDataForm);
end;

procedure TDemo.JvPlugInInitialize(Sender: TObject; var AllowLoad: Boolean);
begin
  // Show channel windows
  if not Assigned(ChannelDataForm) then
    ChannelDataForm := TChannelDataForm.Create(self);
  ChannelDataForm.Show;
  ChannelDataForm.ChannelDataMemo.Lines.Add('> Plugin Initialize <');
end;

procedure TDemo.JvPlugInPluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
begin
  // Plugin Message
  if Assigned(ChannelDataForm) then
  begin
    with ChannelDataForm do
    begin
      // Out data
      if APluginMessage = 12 then
      begin
        Copyright := xOutData;
        if Copyright <> EmptyStr then
          ChannelDataMemo.Lines.Add(Copyright);
        Exit;
      end;
      if APluginMessage = 13 then
      begin
        xOutData := EmptyStr;
        Copyright := EmptyStr;
        Exit;
      end;
      // Other channels
      if FilterEnable.Checked then
      begin
        if APluginMessage = StrToInt(ChanelEdit.Text) then
          ChannelDataMemo.Lines.Add('[' + IntToStr(APluginMessage) + '] - [' + AMessageText + ']');
      end
      else
        ChannelDataMemo.Lines.Add('[' + IntToStr(APluginMessage) + '] - [' + AMessageText + ']');
    end;
  end;
end;

end.
