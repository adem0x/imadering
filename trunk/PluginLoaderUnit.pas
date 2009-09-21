{******************************************}
{*************IMadeRing project************}
{***********PluginLoaderUnit.pas***********}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}

unit PluginLoaderUnit;

interface

  {Использование:
    {loader := TPluginLoader.Create();
  loader.LoadPlugin('Z:\IM\imadering\DummyPlugin\DummyPlugin.dll');}

  uses classes, SysUtils;

  const
    NULL = 0;

  type

    TDllTestFunc = function: HRESULT; stdcall;
    TDllInstanceFunc = function(const IID: TGUID; var Obj: IUnknown): HRESULT; stdcall;

    TPluginLoader = class(TObject)
      private
        FLibraries: TList;
      public
        constructor Create();
        destructor Destory();
        function LoadPlugin(DllPath: string): HRESULT;

        /// <summary>Если библиотека наш плагин - возвращаем
        ///  хэндл. в противном случае баранку</summary>a
        class function CheckLibrary(DllPath: string): HRESULT;
    end;

implementation

  uses Windows, UnitPluginInterface, UnitPluginObserver, UnitLogger;

resourcestring
  StrIsIMRPlugin = 'IsIMRPlugin';
  StrCreatePluginInstance = 'CreatePluginInstance';

{ TPluginLoader }

class function TPluginLoader.CheckLibrary(DllPath: string): HRESULT;
var
  LibHandle: THandle;
  TestFunc: TDllTestFunc;
  CreateInstanceFunc: TDllInstanceFunc;
begin
  result := NULL;

  try
    LibHandle := LoadLibrary(PChar(DllPath));
    //загрузилась!
    if LibHandle <> NULL then begin
      @TestFunc := GetProcAddress(LibHandle, PAnsiChar(StrIsIMRPlugin));
      if Addr(TestFunc) <> nil then begin
        //возвращает ли возможный магическукю константу?
        if TestFunc = PluginIDMagicConst then
          result := LibHandle;
      end;
      //если не наша библиотека - выгружаем ее...
      if result = NULL then
        FreeLibrary(LibHandle);

    end else begin
      //или не загрузилась...
      result := NULL;
    end;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;
end;

constructor TPluginLoader.Create;
begin

end;

destructor TPluginLoader.Destory;
begin

end;

function TPluginLoader.LoadPlugin(DllPath: string): HRESULT;
var
  LibHandle: THandle;
  NewInstanceFunc: TDllInstanceFunc;
  Obj: IUnknown;
  Plugin: IIMRPlugin;
  status: HRESULT;
begin
  try
    result := S_FALSE;

    LibHandle := TPluginLoader.CheckLibrary(DllPath);
    if LibHandle = NULL then
      exit;

    @NewInstanceFunc := GetProcAddress(LibHandle, PAnsiChar(StrCreatePluginInstance));
    if addr(NewInstanceFunc) = nil then begin
      exit;
    end;

    //ну чем, не COM?)) аналог CoCreateInstance
    NewInstanceFunc(IIMRPlugin, Obj);

    //получили объект плагина!
    status := Obj.QueryInterface(IIMRPlugin, Plugin);
    if FAILED(status) then
      RaiseLastOSError;

    PluginObserver.Attach(Plugin);

    result := S_OK;
  except
    on E: Exception do
      TLogger.Instance.WriteMessage(e);
  end;
end;

end.
