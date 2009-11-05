﻿program Imadering;

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
  SMSsendUnit in 'SMSsendUnit.pas' {SMSsendForm},
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
  UtilsUnit in 'UtilsUnit.pas',
  VarsUnit in 'VarsUnit.pas',
  LogUnit in 'LogUnit.pas' {LogForm},
  GtransUnit in 'GtransUnit.pas' {GTransForm},
  ButtonGroup in 'lib\ButtonGroup.pas',
  CategoryButtons in 'lib\CategoryButtons.pas',
  ComCtrls in 'lib\ComCtrls.pas',
  htmlgif1 in 'lib\htmlgif1.pas',
  HTMLView in 'lib\HTMLView.pas',
  JvDesktopAlert in 'lib\JvDesktopAlert.pas',
  JvDesktopAlertForm in 'lib\JvDesktopAlertForm.pas',
  JvHint in 'lib\JvHint.pas',
  JvListView in 'lib\JvListView.pas',
  Menus in 'lib\Menus.pas',
  OverbyteIcsLIBEAY in 'lib\OverbyteIcsLIBEAY.pas',
  OverbyteIcsSSLEAY in 'lib\OverbyteIcsSSLEAY.pas',
  rXML in 'lib\rXML.pas',
  SimpleXML in 'lib\SimpleXML.pas',
  XMLStand in 'lib\XMLStand.pas';

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED or
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP or IMAGE_FILE_NET_RUN_FROM_SWAP}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'IMadering';
  // Устанавливаем приоритет приложению
  //SetPriorityClass(GetCurrentProcess, HIGH_PRIORITY_CLASS);
  //SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST);
  // Изначально скрываем главную форму
  Application.ShowMainForm := False;
  Application.CreateForm(TMainForm, MainForm);
  ShowWindow(Application.Handle, SW_HIDE);
  Application.Run;
end.