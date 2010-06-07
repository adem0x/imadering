program Imadering;

uses
  // Модули подключаемые первыми
  ShareMem,
  SysUtils,
  Windows,
  Forms,
  // Модули с формами
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
  FileTransferUnit in 'FileTransferUnit.pas' {FileTransferForm},
  ShowCertUnit in 'ShowCertUnit.pas' {ShowCertForm},
  LogUnit in 'LogUnit.pas' {LogForm},
  GtransUnit in 'GtransUnit.pas' {GTransForm},
  UniqUnit in 'UniqUnit.pas' {UniqForm},
  ProfileUnit in 'ProfileUnit.pas' {ProfileForm},
  LoginUnit in 'LoginUnit.pas' {LoginForm},
  TwitterOptionsUnit in 'TwitterOptionsUnit.pas' {TwitterOptionsForm},
  HttpUnit in 'HttpUnit.pas' {HttpForm},
  ProfilesFolderUnit in 'ProfilesFolderUnit.pas' {ProfilesFolderForm},
  SMSUnit in 'SMSUnit.pas' {SMSForm},
  GamesUnit in 'GamesUnit.pas' {GamesForm},
  // Модули без форм
  IcqProtoUnit in 'IcqProtoUnit.pas',
  JabberProtoUnit in 'JabberProtoUnit.pas',
  MraProtoUnit in 'MraProtoUnit.pas',
  VarsUnit in 'VarsUnit.pas',
  RosterUnit in 'RosterUnit.pas',
  TwitProtoUnit in 'TwitProtoUnit.pas',
  UtilsUnit in 'UtilsUnit.pas',
  // Модули библиотек
  OverbyteIcsLIBEAY in 'lib\OverbyteIcsLIBEAY.pas',
  Menus in 'lib\Menus.pas',
  JvListView in 'lib\JvListView.pas',
  JvHint in 'lib\JvHint.pas',
  JvDesktopAlertForm in 'lib\JvDesktopAlertForm.pas',
  JvDesktopAlert in 'lib\JvDesktopAlert.pas',
  ComCtrls in 'lib\ComCtrls.pas',
  CategoryButtons in 'lib\CategoryButtons.pas',
  ButtonGroup in 'lib\ButtonGroup.pas',
  ImgList in 'lib\ImgList.pas';

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED or
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.Title := 'IMadering';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
