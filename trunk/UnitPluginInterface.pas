{******************************************}
{*************IMadeRing project************}
{*********UnitPluginInterface.pas**********}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}


unit UnitPluginInterface;

interface

const
  PluginIDMagicConst: HRESULT = 788112009;
  IID_IIMRPlugin = '{58DC42FE-AA44-4996-8048-CB9455010B78}';

type
  TEventAlignType = (PreEvent, PostEvent);
  TEventType = (UserLogged, UserAdded);

  //Контекст программы. глобальные поля.
  TContext = record
    /// <summary>Размер записи. для контроля доступе к памяти и одинаковости
    /// версий записи</summary>
    cSize: Integer;
  end;

  TCallBackFunction = function(const Context: TContext; Event: TEventType; Data: Pointer): HRESULT; stdcall;

  IIMRPlugin = interface(IUnknown)
    [IID_IIMRPlugin]
      function Init(AppVersion: Integer): HRESULT; stdcall;
      function Quit: HRESULT; stdcall;

      /// <summary>Вызываем как WinApi. первый раз узнаем размер, потом с уже выделенной памятью!</summary>
      function GetPluginName(Data: PWideChar): Integer; stdcall;

      function GetEventsCount: Integer; stdcall;
      function RegisterCallBack(var EventTime: TEventType; var EventAlign:
              TEventAlignType; const i: Integer): HRESULT; stdcall;

      function Notify(const Context: TContext; Event: TEventType; EventAlign:
              TEventAlignType; Data: Pointer): HRESULT; stdcall;
      //function SetCallBackFunction(var Func: TCallBackFunction): HRESULT;
  end;

implementation

end.
