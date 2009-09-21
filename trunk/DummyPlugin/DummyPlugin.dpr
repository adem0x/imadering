{******************************************}
{*************IMadeRing project************}
{**************DummyPlugin.dpr*************}
{**  @author: Sergey Melnikov              }
{**  @EMail: Melnikov.Sergey.V@gmail.com   }
{**  @Created: 09.2009                     }
{******************************************}
{******************************************}

library DummyPlugin;

uses
  SysUtils,
  Classes,
  UnitPluginInterface in '..\UnitPluginInterface.pas',
  DummyPluginUnit in 'DummyPluginUnit.pas';

{$R *.res}

function IsIMRPlugin: HRESULT; stdcall;
begin
  result := PluginIDMagicConst;
end;

function CreatePluginInstance(const IID: TGUID; var Obj: IUnknown): HRESULT; stdcall;
var
  Plugin: TDummyPlugin;
begin
  result := S_FALSE;

  Plugin := TDummyPlugin.Create;
  if Plugin.GetInterface(IID, obj) then
    result := S_OK
  else
    result := E_NOINTERFACE;

end;


{---------------------------------------------------}

exports
  IsIMRPlugin, CreatePluginInstance;

begin
end.
