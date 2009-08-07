program HistoryPacker;

uses
  RtlVclOptimize,
  VCLFixPack,
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'History Packer';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
