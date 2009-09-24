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
  CustomPluginUnit in 'CustomPluginUnit.pas',
  LogPluginUnit in 'LogPluginUnit.pas',
  LogForm in 'LogForm.pas' {Form1};

{$E imr}
//--линкуем иконку!
{$R RESOURCES.RES}

function IsIMRPlugin: HRESULT; stdcall;
begin
  result := PluginIDMagicConst;
end;

function CreatePluginInstance(const IID: TGUID; var Obj: IUnknown): HRESULT; stdcall;
var
  Plugin: TCustomPlugin;
begin
  result := S_FALSE;

  if not Assigned(ClassOfPlugin) then exit;


  Plugin := TCustomPlugin(ClassOfPlugin.NewInstance);
  if Plugin.GetInterface(IID, obj) then
    result := S_OK
  else begin
    result := E_NOINTERFACE;
  end;

end;


{---------------------------------------------------}

exports
  IsIMRPlugin, CreatePluginInstance;

begin
end.
