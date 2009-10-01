// JCL_DEBUG_EXPERT_INSERTJDBG OFF
program HistoryPacker;

uses
  Windows,
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm};

{$R *.res}
{$SETPEFlAGS IMAGE_FILE_RELOCS_STRIPPED or
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
