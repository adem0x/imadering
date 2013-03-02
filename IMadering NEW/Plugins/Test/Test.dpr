library Test;

uses
  ShareMem,
  Windows,
  PlugInPluginTest in 'PlugInPluginTest.pas' {PluginTest: TJvPlugIn},
  Test_Unit in 'Test_Unit.pas' {Test_Form};

{$E dll}

{$R *.res}

{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

{$SETPEFlAGS IMAGE_FILE_DEBUG_STRIPPED or
IMAGE_FILE_LINE_NUMS_STRIPPED or
IMAGE_FILE_LOCAL_SYMS_STRIPPED or
IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or
IMAGE_FILE_NET_RUN_FROM_SWAP}

exports
  RegisterPlugin;

begin
end.
