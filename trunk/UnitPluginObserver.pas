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

  uses UnitPluginInterface, SysUtils, classes, Contnrs;

  type
    /// <summary>Описывает сообщение, на которое подписан плагин</summary>
    TRegisteredEvent = class(TObject)
      /// <summary>Тип сообщение</summary>
      EventType: TEventType;
    end;

    TRegisteredPlugin = class(TObject)
      protected
        FPlugin: IIMRPlugin;
        
        FName: string;
        procedure GatherPluginEvents();
      public
        RegisteredEvents: TObjectList;
        
        property Name: string read FName;
        property Plugin: IIMRPlugin read FPlugin;
        constructor Create(__Plugin: IIMRPlugin);
        destructor destroy; override;

        class function GetPluginName(__Plugin: IIMRPlugin): string;
      end;

    /// <summary>Дочерний класс, выбирающий политику продолжения выполнения</summary>  
    TObserverStratege = class(TObject)
      FStates: array of boolean;
      procedure ApplyStatus(Status: Boolean); virtual;
      function GetAnswer: Boolean; virtual; abstract;
      procedure ResetState; virtual;
    end;

    TObserverStrategeFullOk = class(TObserverStratege)
      function GetAnswer: Boolean; override;
    end;

    TObserverStrategeFullFalse = class(TObserverStratege)
      function GetAnswer: Boolean; override;    
    end;
    
    ClassObserverStratege = class of TObserverStratege;      

    /// <summary>см. паттерн Observer</summary>
    TPluginObserver = class (TObject)
      protected
        FPlugins: TObjectList;
        FStratege: TObserverStratege;
        FPluginsByEvent: array[TEventType] of TObjectList;
        function GetPluginName(i: Integer): string;
        constructor Create(StrategeClass: ClassObserverStratege);
        destructor Destroy(); override;
      public
        property PluginNames[i: Integer]: string read GetPluginName;
        procedure ShowConfig(i: Integer);
        function GetPluginCount: Integer;
        function Attach(__Plugin: IIMRPlugin): string;
        procedure Detach(__Plugin: IIMRPlugin);
        /// <summmary>Уведомить плагины о каком-либо действии</summary>
        function Notify(const EventType: TEventType; const Protocol: TProtocol; Data: Pointer):  boolean;
    end;   


  var
    PluginObserver: TPluginObserver;

implementation

uses UnitLogger, windows, UnitCustomExceptions, VarsUnit;

{$REGION 'TRegisteredPlugin' }

constructor TRegisteredPlugin.Create(__Plugin: IIMRPlugin);
var
  NameLen: Integer;
  Status: HRESULT;
begin
  inherited Create();
  RegisteredEvents := TObjectList.Create(true);
  FPlugin := __Plugin;
  if FAILED(FPlugin.Init(-1)) then
    RaiseLastOSError;
  FName := TRegisteredPlugin.GetPluginName(__Plugin);

  GatherPluginEvents;
end;

destructor TRegisteredPlugin.destroy;
var
  Obj: TObject;
begin
  FPlugin.Quit;
  FreeAndNil(RegisteredEvents);
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
    RegisteredEvents.Capacity := len;

    for I := 0 to len - 1 do begin
      Event := TRegisteredEvent.Create;
      if FPlugin.RegisterCallBack(Event.EventType, i) <> S_OK then
        exit;
      RegisteredEvents.Add(Event);
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

function TPluginObserver.Attach(__Plugin: IIMRPlugin): string;
var
  Plugin: TRegisteredPlugin;
  Event: TRegisteredEvent;
  p: Pointer;
begin
  Plugin := TRegisteredPlugin.Create(__Plugin);
  
  Self.FPlugins.Add(Plugin);
  for p in Plugin.RegisteredEvents do begin
    Event := TRegisteredEvent(p);
    Self.FPluginsByEvent[Event.EventType].Add(Plugin);
  end;

  result := Plugin.Name;
end;

constructor TPluginObserver.Create(StrategeClass: ClassObserverStratege);
var
  i: Integer;
  List: TEventType;
begin
  inherited Create;
  FPlugins := TObjectList.Create(true);

  //SetLength(Self.FPluginsByEvent, CONST_EVENTS_COUNT);
  //for I := 0 to High(FPluginsByEvent) - 1 do
  for List := Low(List) to High(List) do
  begin
    FPluginsByEvent[List] := TObjectList.Create(false);    
  end;

  FStratege := TObserverStratege(StrategeClass.NewInstance);
end;

destructor TPluginObserver.Destroy;
begin
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

function TPluginObserver.GetPluginCount: Integer;
begin
  result := FPlugins.Count;
end;

function TPluginObserver.GetPluginName(i: Integer): string;
begin
  try
    result := TRegisteredPlugin(FPlugins[i]).Name;  
  except
    on E: Exception do begin
      UnitLogger.TLogger.Instance.WriteMessage(e);
    end;
  end;
end;

function TPluginObserver.Notify(const EventType: TEventType; const Protocol: TProtocol; Data: Pointer): boolean;
var
  iter_Plugin: TRegisteredPlugin;
  Event: TObject;
  Context: UnitPluginInterface.TContext;
  Status: HRESULT;
  p: Pointer;
begin
  Context.cSize := SizeOf(Context);
  Context.ActiveProtocol := Protocol; 
  Context.ContinueExecution := Cardinal(true);
  
  FStratege.ResetState;
  
  for p in FPluginsByEvent[EventType] do begin
    iter_Plugin := TRegisteredPlugin(p);
    try
      Status := iter_Plugin.FPlugin.NotifyPlugin(Context, EventType, Data);
      if Failed(Status) then
        raise TPluginException.Create(Status);
    except
      on E: Exception do begin
        TLogger.Instance.WriteMessage(e);
        Context.ContinueExecution := Cardinal(true);
      end;
    end;
    FStratege.ApplyStatus(Boolean(Context.ContinueExecution));
  end;

  result := FStratege.GetAnswer;
end;

procedure TPluginObserver.ShowConfig(i: Integer);
begin
  if (i < 0) or (i > FPlugins.Count) then
    exit;

  TRegisteredPlugin(FPlugins[i]).FPlugin.Configure(PWideChar(ProfilePath));
end;

{$ENDREGION}

{$REGION 'Observer Strateges' }

function TObserverStrategeFullOk.GetAnswer: Boolean;
var
  t: Boolean;
begin
  result := true;
  for t in FStates do
    if not t then
      result := false;
end;

function TObserverStrategeFullFalse.GetAnswer: Boolean;
var
  t: Boolean;
begin
  result := false;
  for t in FStates do
    if t then
      result := true;    
end;

//////////////////////////

procedure TObserverStratege.ApplyStatus(Status: Boolean);
begin
  SetLength(FStates, High(FStates) + 2);
  FStates[High(FStates)] := Status;
end;

procedure TObserverStratege.ResetState;
begin
  SetLength(FStates, 0);
end;

{$ENDREGION}

initialization
  PluginObserver := TPluginObserver.Create(TObserverStrategeFullFalse);

finalization
  PluginObserver.Free;

end.
