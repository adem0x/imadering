// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF

library PlgDemo;

uses
  ShareMem,
  PlugInDemo in 'PlugInDemo.pas' {Demo: TJvPlugIn},
  ChannelDataUnit in 'ChannelDataUnit.pas' {ChannelDataForm};

{$R *.res}

exports
  RegisterPlugin;

begin
end.
