{******************************************}
{*************IMadeRing project************}
{**********UnitPluginObserver.pas**********}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}

unit UnitPluginObserver;

interface

  uses UnitPluginInterface, SysUtils, classes;

  type
    /// <summary>Описывает сообщение, на которое подписан плагин</summary>
    TRegisteredEvent = class(TObject)
      /// <summary>Тип сообщение</summary>
      EventType: TEventType;
      /// <summary>До или после события</summary>
      EventAlign: TEventAlignType;
    end;

    TRegisteredPlugin = class(TObject)
      protected
        FPlugin: IIMRPlugin;
        FRegisteredEvents: TList;
        FName: string;
        procedure GatherPluginEvents();
      public
        property Name: string read FName;
        property Plugin: IIMRPlugin read FPlugin;
        constructor Create(__Plugin: IIMRPlugin);
        destructor destroy; override;

        class function GetPluginName(__Plugin: IIMRPlugin): string;
      end;

    /// <summary>см. паттерн Observer</summary>
    TPluginObserver = class (TObject)
      FPlugins: TList;
    public
      procedure Attach(__Plugin: IIMRPlugin);
      procedure Detach(__Plugin: IIMRPlugin);
      procedure Notify(Event: TEventType; EventAlign: TEventAlignType);

      constructor Create();
      destructor Destroy(); override;
    end;

  var
    PluginObserver: TPluginObserver;

implementation

uses UnitLogger, windows, UnitCustomExceptions;

{$REGION 'TRegisteredPlugin' }

constructor TRegisteredPlugin.Create(__Plugin: IIMRPlugin);
var
  NameLen: Integer;
  Status: HRESULT;
begin
  inherited Create();
  FRegisteredEvents := TList.Create;
  FPlugin := __Plugin;
  FName := TRegisteredPlugin.GetPluginName(__Plugin);
    
  GatherPluginEvents;
end;

destructor TRegisteredPlugin.destroy;
var
  Obj: pointer;
begin
  for Obj in FRegisteredEvents do begin
    TObject(Obj).Free();
  end;
  FreeAndNil(FRegisteredEvents);
  inherited;
end;

procedure TRegisteredPlugin.GatherPluginEvents;
var
  i: Integer;
  len: Integer;
  Event: TRegisteredEvent;
begin
  try
    len := FPlugin.GetEventsCount;
    FRegisteredEvents.Capacity := len;

    for I := 0 to len - 1 do begin
      Event := TRegisteredEvent.Create;
      if FPlugin.RegisterCallBack(Event.EventType, Event.EventAlign, i) <> S_OK then
        exit;
      FRegisteredEvents.Add(Event);
    end;
    
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;  
end;

class function TRegisteredPlugin.GetPluginName(__Plugin: IIMRPlugin): string;
var
  Name: WideString;
  Status: HRESULT;
  NameLen: Integer;
begin
  try
    NameLen := __Plugin.GetPluginName(nil);
    if NameLen < 1 then
      RaiseLastOSError;
    SetLength(Name, NameLen);

    Status := __Plugin.GetPluginName(PWideChar(Name));
    if FAILED(Status) then
      raise TPluginException.Create(Status);

    result := Name;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;
end;

{$ENDREGION}

{$REGION 'TPluginObserver' }

procedure TPluginObserver.Attach(__Plugin: IIMRPlugin);
var
  Plugin: TRegisteredPlugin;
begin
  Plugin := TRegisteredPlugin.Create(__Plugin);
  Self.FPlugins.Add(Plugin);
end;

constructor TPluginObserver.Create;
begin
  inherited Create;
  FPlugins := TList.Create;
end;

destructor TPluginObserver.Destroy;
var
  Obj: pointer;
begin
  for Obj in FPlugins do begin
    TObject(Obj).Free();
  end;
  FreeAndNil(FPlugins);

  inherited;
end;

procedure TPluginObserver.Detach(__Plugin: IIMRPlugin);
var
  PluginName: String;
  tPlugin: Integer;
  i: Integer;
begin
  try
    PluginName := TRegisteredPlugin.GetPluginName(__Plugin);
    for I := FPlugins.Count - 1 downto 0 do begin
      if TRegisteredPlugin(FPlugins[i]).Name = PluginName then begin
        TRegisteredPlugin(FPlugins[i]).Free;
        FPlugins.Delete(i);
        exit;
      end;
    end;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;
end;

procedure TPluginObserver.Notify(Event: TEventType;
  EventAlign: TEventAlignType);
begin
  //
end;

{$ENDREGION}

initialization
  PluginObserver := TPluginObserver.Create;

finalization
  PluginObserver.Free;

end.
