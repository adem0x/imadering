{******************************************}
{*************IMadeRing project************}
{************DummyPluginUnit.pas***********}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}

unit CustomPluginUnit;

interface

  uses dialogs, SysUtils, classes, windows, unitPluginInterface;

  type

    ClassTPlugin = class of TCustomPlugin;

    TCustomPlugin = class abstract (TInterfacedObject, IIMRPlugin)
      function Init(AppVersion: Integer): HRESULT; virtual; stdcall;
      function Quit: HRESULT; virtual; stdcall;
      function Configure(ProfilePath: PWideChar): HRESULT; virtual; stdcall;

      /// <summary>Вызываем как WinApi. первый раз узнаем размер, потом с уже выделенной памятью!</summary>
      function GetPluginName(Data: PWideChar): Integer; virtual; stdcall;

      function GetEventsCount: Integer; stdcall;
      function RegisterCallBack(var EventTime: TEventType; const i: Integer): HRESULT; stdcall;

      function NotifyPlugin(const Context: TContext; Event: TEventType; Data: Pointer): HRESULT; stdcall;

      //--Abstract method declorations
      function EventApplicationLoaded(Data: PApplicationLoadedParams): HRESULT; virtual; abstract;
      function EventAuthorization(Data: PAuthorizationParams): HRESULT; virtual; abstract;
      function EventDisconnect(Data: PDisconnectParams): HRESULT; virtual; abstract;
      function EventContactChangeStatus(Data: PContactChangeStatusParams): HRESULT; virtual; abstract;
      function EventWriteMessage(Data: PContactWriteMessageParams): HRESULT; virtual; abstract;
    end;

var
  ClassOfPlugin: ClassTPlugin;

implementation

  uses LogForm;

resourcestring
  StrPluginName = 'DummyPlugin';

{ TMyPlugin }

function TCustomPlugin.Configure(ProfilePath: PWideChar): HRESULT;
begin
  result := S_OK;
end;

function TCustomPlugin.GetEventsCount: Integer;
begin
  result := 5;
end;

procedure StringToPWide(sStr: string; var Data: PWideChar);
var
  iSize: integer;
  iNewSize: integer;
begin
  iSize := Length(sStr) + 1;
  iNewSize := iSize * 2;

  MultiByteToWideChar(CP_ACP, 0, PChar(sStr), iSize, Data, iNewSize);
end;

function TCustomPlugin.GetPluginName(Data: PWideChar): Integer;
begin
  if Data = nil then
    result := Length(StrPluginName)
  else begin
    //--а теперь извращаемся с юникодом!
    StringToPWide(StrPluginName, Data);
    result := S_OK;
  end;
end;

function TCustomPlugin.Init(AppVersion: Integer): HRESULT;
begin
  result := S_OK;
end;

function TCustomPlugin.NotifyPlugin(const Context: TContext; Event: TEventType;
  Data: Pointer): HRESULT; stdcall;
begin
  result := S_FALSE;
  try
    case Event of
      eApplicationLoaded: result := EventApplicationLoaded(PApplicationLoadedParams(Data));
      eAuthorization: result := EventAuthorization(PAuthorizationParams(Data));
      eDisconnect: result := EventDisconnect(PDisconnectParams(Data));
      eContactChangeStatus: result := EventContactChangeStatus(PContactChangeStatusParams(Data));
      eWriteMessage: result := EventWriteMessage(PContactWriteMessageParams(Data));
    end;
  except
  end;
end;

function TCustomPlugin.Quit: HRESULT;
begin
  result := S_OK;
end;

function TCustomPlugin.RegisterCallBack(var EventTime: TEventType; const i: Integer): HRESULT;
begin
  EventTime := TEventType(i);
  result := S_OK;
end;

end.
