program Imadering;

uses
  ShareMem,
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
  MraXStatusUnit in 'MraXStatusUnit.pas' {MraXStatusForm},
  MraOptionsUnit in 'MraOptionsUnit.pas' {MraOptionsForm},
  JabberOptionsUnit in 'JabberOptionsUnit.pas' {JabberOptionsForm},
  UpdateUnit in 'UpdateUnit.pas' {UpdateForm},
  TrafficUnit in 'TrafficUnit.pas' {TrafficForm},
  RosterUnit in 'RosterUnit.pas' {RosterForm},
  FileTransferUnit in 'FileTransferUnit.pas' {FileTransferForm},
  ShowCertUnit in 'ShowCertUnit.pas' {ShowCertForm},
  IcqProtoUnit in 'IcqProtoUnit.pas',
  JabberProtoUnit in 'JabberProtoUnit.pas',
  MraProtoUnit in 'MraProtoUnit.pas',
  VarsUnit in 'VarsUnit.pas',
  LogUnit in 'LogUnit.pas' {LogForm},
  GtransUnit in 'GtransUnit.pas' {GTransForm},
  UniqUnit in 'UniqUnit.pas' {UniqForm},
  ProfileUnit in 'ProfileUnit.pas' {ProfileForm},
  OverbyteIcsLIBEAY in 'lib\OverbyteIcsLIBEAY.pas',
  Menus in 'lib\Menus.pas',
  JvListView in 'lib\JvListView.pas',
  JvHint in 'lib\JvHint.pas',
  JvDesktopAlertForm in 'lib\JvDesktopAlertForm.pas',
  JvDesktopAlert in 'lib\JvDesktopAlert.pas',
  ComCtrls in 'lib\ComCtrls.pas',
  CategoryButtons in 'lib\CategoryButtons.pas',
  ButtonGroup in 'lib\ButtonGroup.pas',
  LoginUnit in 'LoginUnit.pas' {LoginForm},
  TwitterOptionsUnit in 'TwitterOptionsUnit.pas' {TwitterOptionsForm},
  HttpUnit in 'HttpUnit.pas' {HttpForm},
  ProfilesFolderUnit in 'ProfilesFolderUnit.pas' {ProfilesFolderForm},
  SMSUnit in 'SMSUnit.pas' {SMSForm},
  UtilsUnit in 'UtilsUnit.pas';

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED or
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'IMadering';
  // Изначально скрываем главную форму
  Application.ShowMainForm := False;
  Application.CreateForm(TMainForm, MainForm);
  ShowWindow(Application.Handle, SW_HIDE);
  Application.Run;
end.
