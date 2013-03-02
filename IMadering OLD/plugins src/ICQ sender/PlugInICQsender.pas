unit PlugInICQsender;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Forms, Controls,
  JvPlugin, SendUnit;

type
  TICQsender = class(TJvPlugIn)
    procedure ICQsenderCommands0Execute(Sender: TObject);
    procedure JvPlugInConfigure(Sender: TObject);
    procedure JvPlugInDestroy(Sender: TObject);
    procedure JvPlugInPluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
  private
    { Private declarations }
  public
    { Public declarations }
end;

function RegisterPlugin: TJvPlugIn; stdcall;

implementation

{$R *.dfm}

// IMPORTANT NOTE: If you change the name of the Plugin container,
// you must set the type below to the same type. (Delphi changes
// the declaration, but not the procedure itself. Both the return
// type and the type created must be the same as the declared type above.
function RegisterPlugin: TJvPlugIn;
begin
  Result := TICQsender.Create(nil);
end;

procedure TICQsender.ICQsenderCommands0Execute(Sender: TObject);
begin
  if not Assigned(SendForm) then
    SendForm := TSendForm.Create(self);
  SendForm.Show;
end;

procedure TICQsender.JvPlugInConfigure(Sender: TObject);
begin
  if not Assigned(SendForm) then
    SendForm := TSendForm.Create(self);
  SendForm.Show;
end;

procedure TICQsender.JvPlugInDestroy(Sender: TObject);
begin
  if Assigned(SendForm) then
    FreeAndNil(SendForm);
end;

procedure TICQsender.JvPlugInPluginMessage(Sender: TObject; APluginMessage: Integer; AMessageText: string);
begin
  if Assigned(SendForm) then
  begin
    with SendForm do
    begin
      if APluginMessage = 12 then
      begin
        Copyright := SendData;
        Exit;
      end;
      if APluginMessage = 13 then
      begin
        SendData := EmptyStr;
        Copyright := EmptyStr;
        Exit;
      end;
    end;
  end;
end;

end.
