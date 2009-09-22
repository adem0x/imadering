program Imadering;

uses
  RtlVclOptimize,
  VCLFixPack,
  SysUtils,
  Windows,
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  SettingsUnit in 'SettingsUnit.pas' {SettingsForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  ChatUnit in 'ChatUnit.pas' {ChatForm},
  CLSearchUnit in 'CLSearchUnit.pas' {CLSearchForm},
  FirstStartUnit in 'FirstStartUnit.pas' {FirstStartForm},
  FloatingUnit in 'FloatingUnit.pas' {FloatingForm},
  HistoryUnit in 'HistoryUnit.pas' {HistoryForm},
  IcqAddContactUnit in 'IcqAddContactUnit.pas' {IcqAddContactForm},
  IcqContactInfoUnit in 'IcqContactInfoUnit.pas' {IcqContactInfoForm},
  IcqEditContactUnit in 'IcqEditContactUnit.pas' {IcqEditContactForm},
  IcqGroupManagerUnit in 'IcqGroupManagerUnit.pas' {IcqGroupManagerForm},
  IcqOptionsUnit in 'IcqOptionsUnit.pas' {IcqOptionsForm},
  IcqReqAuthUnit in 'IcqReqAuthUnit.pas' {IcqReqAuthForm},
  IcqSearchUnit in 'IcqSearchUnit.pas' {IcqSearchForm},
  IcqXStatusUnit in 'IcqXStatusUnit.pas' {IcqXStatusForm},
  SmilesUnit in 'SmilesUnit.pas' {SmilesForm},
  SMSsendUnit in 'SMSsendUnit.pas' {SMSsendForm},
  MraXStatusUnit in 'MraXStatusUnit.pas' {MraXStatusForm},
  MraOptionsUnit in 'MraOptionsUnit.pas' {MraOptionsForm},
  JabberOptionsUnit in 'JabberOptionsUnit.pas' {JabberOptionsForm},
  UpdateUnit in 'UpdateUnit.pas' {UpdateForm},
  TrafficUnit in 'TrafficUnit.pas' {TrafficForm},
  RosterUnit in 'RosterUnit.pas' {RosterForm},
  FileTransferUnit in 'FileTransferUnit.pas' {FileTransferForm},
  ShowCertUnit in 'ShowCertUnit.pas' {ShowCertForm},
  UnitCrypto in 'lib\UnitCrypto.pas',
  UnitLogger in 'lib\UnitLogger.pas',
  UnitPluginInterface in 'UnitPluginInterface.pas',
  UnitPluginObserver in 'UnitPluginObserver.pas',
  UnitCustomExceptions in 'UnitCustomExceptions.pas',
  PluginLoaderUnit in 'PluginLoaderUnit.pas';

{$R *.res}
{$SETPEFlAGS IMAGE_FILE_RELOCS_STRIPPED or
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'IMadering';
  Application.ShowMainForm := False;
  Application.CreateForm(TMainForm, MainForm);
  ShowWindow(Application.Handle, SW_HIDE);
  Application.Run;
end.

