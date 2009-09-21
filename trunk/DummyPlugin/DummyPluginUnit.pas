{******************************************}
{*************IMadeRing project************}
{************DummyPluginUnit.pas***********}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}

unit DummyPluginUnit;

interface

  uses unitPluginInterface, classes;

  type
    TDummyPlugin = class (TInterfacedObject, IIMRPlugin)
      function Init(AppVersion: Integer): HRESULT; stdcall;
      function Quit: HRESULT; stdcall;

      /// <summary>Вызываем как WinApi. первый раз узнаем размер, потом с уже выделенной памятью!</summary>
      function GetPluginName(Data: PWideChar): Integer; stdcall;

      function GetEventsCount: Integer; stdcall;
      function RegisterCallBack(var EventTime: TEventType; var EventAlign:
                      TEventAlignType; const i: Integer): HRESULT; stdcall;

      function Notify(const Context: TContext; Event: TEventType; EventAlign:
                      TEventAlignType; Data: Pointer): HRESULT; stdcall;
    end;

implementation

  uses dialogs, SysUtils;

resourcestring
  StrPluginName = 'DummyPlugin';

{ TMyPlugin }

function TDummyPlugin.GetEventsCount: Integer;
begin
  result := 2;
end;

function TDummyPlugin.GetPluginName(Data: PWideChar): Integer;
var
  PluginName: PWideChar;
begin
  if Data = nil then
    result := Length(StrPluginName)
  else begin
    //а теперь извращаемся с юникодом!
    StringToWideChar(StrPluginName, Data, Length(StrPluginName));
    result := S_OK;
  end;
end;

function TDummyPlugin.Init(AppVersion: Integer): HRESULT;
begin
  result := S_OK;
end;

function TDummyPlugin.Notify(const Context: TContext; Event: TEventType;
  EventAlign: TEventAlignType; Data: Pointer): HRESULT;
begin
  ShowMessage(IntTostr(Ord(Event)) + IntToStr(Ord(EventAlign)));
end;

function TDummyPlugin.Quit: HRESULT;
begin
  result := S_OK;
end;

function TDummyPlugin.RegisterCallBack(var EventTime: TEventType;
      var EventAlign: TEventAlignType; const i: Integer): HRESULT;
begin
  case i of
    0: EventTime := UserLogged;
    1: EventTime := UserAdded;
  end;
  EventAlign := PreEvent;

  result := S_OK;
end;

end.
