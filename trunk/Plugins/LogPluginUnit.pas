{******************************************}
{*************IMadeRing project************}
{************DummyPluginUnit.pas***********}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}


unit LogPluginUnit;

interface

  uses CustomPluginUnit, unitPluginInterface, LogForm;

  type
    TSimplePlugin = class(TCustomPlugin)
      FForm : TLogForm;
      function Init(AppVersion: Integer): HRESULT; override; stdcall;
      function Quit: HRESULT; override; stdcall;
      function EventApplicationLoaded(Data: PApplicationLoadedParams): HRESULT; override;
      function EventAuthorization(Data: PAuthorizationParams): HRESULT; override;
      function EventDisconnect(Data: PDisconnectParams): HRESULT; override;
      function EventContactChangeStatus(Data: PContactChangeStatusParams): HRESULT; override;
      function EventWriteMessage(Data: PContactWriteMessageParams): HRESULT; override;
    end;

implementation

  uses SysUtils;

{ TSimplePlugin }

function TSimplePlugin.EventApplicationLoaded(
  Data: PApplicationLoadedParams): HRESULT;
begin
  FForm.AddMessage('Application loaded!!!!');
end;

function TSimplePlugin.EventAuthorization(Data: PAuthorizationParams): HRESULT;
begin
  FForm.AddMessage('Authorization!');
end;

function TSimplePlugin.EventContactChangeStatus(
  Data: PContactChangeStatusParams): HRESULT;
begin
  FForm.AddMessage('Shange status');
end;

function TSimplePlugin.EventWriteMessage(
  Data: PContactWriteMessageParams): HRESULT;
begin
  FForm.AddMessage(Format('write message from "%s" to "%s": %s', [String(Data^.FromContactID), String(Data^.ToContactID), String(Data^.MessageText)]));
end;

function TSimplePlugin.EventDisconnect(Data: PDisconnectParams): HRESULT;
begin
  FForm.AddMessage('Disconnected...');
end;

function TSimplePlugin.Init(AppVersion: Integer): HRESULT;
begin
  FForm := TLogForm.Create(nil);
  FForm.Show;
end;

function TSimplePlugin.Quit: HRESULT;
begin
  FreeAndNil(FForm);
end;

initialization
  ClassOfPlugin := TSimplePlugin;

end.
