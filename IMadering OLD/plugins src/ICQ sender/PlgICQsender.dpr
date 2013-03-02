// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
library PlgICQsender;

uses
  ShareMem,
  PlugInICQsender in 'PlugInICQsender.pas' {ICQsender: TJvPlugIn},
  SendUnit in 'SendUnit.pas' {SendForm};

{$R *.res}

exports
  RegisterPlugin;

begin
end.
