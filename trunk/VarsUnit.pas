{*******************************************************************************
  Copyright (c) 2004-2009 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
*******************************************************************************}

unit VarsUnit;

interface

uses
  SysUtils, Classes, ExtCtrls, JvDesktopAlert;

const
  Bild_Version = '5.0.0 alpha';
  Update_Version = 500;
  PassKey = 12345;

const
  SecsPerDay = 86400;
  Hour = 3600000 / MSecsPerDay;
  Minute = 60000 / MSecsPerDay;
  Second = 1000 / MSecsPerDay;
  DTseconds = 1 / (SecsPerDay);
  dblClickTime = 0.6 * DTseconds;

var
  //--���������� ����� ��� ���� ���������
  MyPath: string;
  CurrentIcons: string = 'Imadering';
  CurrentLang: string = '';
  CurrentSmiles: string = 'Imadering';
  CurrentSounds: string = 'Imadering';
  ProgramCloseCommand: boolean = false;
  FirstStart: boolean = false;
  TrayProtoClickMenu: string = '';
  AlphaBlendInactive: boolean = false;
  RoasterAlphaBlend: boolean = false;
  RoasterAlphaValue: integer = 255;
  AccountToNick: TStringList;
  AvatarServiceDisable: boolean = false;
  UpdateAuto: boolean = true;
  SettingsFileName: string = 'Profile\IMadeSettings.xml';

  //--���������� ������
  SoundON: boolean = true;
  SoundIncMsg: boolean = true;
  SoundIncMsgPath: string = '';

  //--���������� ��� �����
  RestoreFromTrayStr: string = '�������� IMadering';
  HideInTrayStr: string = '������ IMadering';
  DevelMess: string = '������ ������� ��������� � ����������! ������� �� ������������ �������.';
  SoundOnHint: string = '<b>�������� �����</b>';
  SoundOffHint: string = '<b>��������� �����</b>';
  OnlyOnlineOn: string = '<b>�������� ������� ��������</b>';
  OnlyOnlineOff: string = '<b>������ ������� ��������</b>';
  FirstStartNextButton: string = '�����';
  FirstStartProtoSelectAlert: string = '�� ������ �� ���� ��������! � ����� ������ �������� ICQ ����� ������ �������������.';
  NewVersionIMaderingYES1: string = '�������� ����� ������ IMadering.' + #13#10 + #13#10 + '��� ������������ ������� �� ���� www.imadering.com';
  NewVersionIMaderingYES2: string = '�������� ����� ������ IMadering.' + #13#10 + #13#10 + '��� ������������ ������� �� ���� www.imadering.com';
  NewVersionIMaderingNO: string = '����� ������ �� ����������.';
  InformationHead: string = '����������';
  ErrorHead: string = '������';
  AlertHead: string = '�������� ����������';
  WarningHead: string = '��������!';
  ICQAccountInfo: string = '������� ������ ICQ#:';
  ICQAccountInfo_1: string = '����� ��� ��� ������������ � ICQ �������, ������� ������� � ���������� ���� ICQ ����� � ������!';
  PassLabelInfo: string = '������:';
  RegPanelInfo_1: string = '������� ������� ����������� ...';
  ParsingPktError: string = '��������� ���������� ������ ������ ������ ���������� �� �������.';
  SocketConnErrorInfo_1: string = '���������� � �������� �� �����������. ��������� ���� ����������� � ��������.';
  SocketConnErrorInfo_2: string = '������ �� ������.';
  SocketConnErrorInfo_3: string = '����������� ������';
  SocketConnErrorInfo_4: string = '����������� ���������!';
  ICQRegNewInfo_1: string = '��������, � ����������� ��������.';
  RegNewAlert_1: string = '������� ������ ��� ����� ������� ������.';
  RegNewAlert_2: string = '������� ����� �� ��������.';
  UnknownError: string = '����������� ������';
  AddContactError: string = '������ ��� ���������� ��������.';
  AddGroupError: string = '������ ��� ���������� ������.';
  DelGroupError: string = '������ ��� �������� ������.';
  ICQxUIN: string = '��� ����� ICQ ������������ �� ������ ����������.';
  PassChangeAlert_1: string = '������ �� ��� �������. ������� ��� ����� ������ ����� �������.';
  PassChangeAlert_2: string = '������ �������.';
  OnlineAlert: string = '��� ���������� ����� �������� ���������� ������������.';
  HideContactGroupCaption: string = '���������';
  NoInListGroupCaption: string = '�� � ������';
  ConnTimeL: string = '���������:';
  RegDateL: string = '���. ����:';
  ChatDateL: string = '��������� ���:';
  ProtoVerL: string = '������ ���������:';
  ClientVariableL: string = '��������� ������:';
  CellularPhoneL: string = '�������:';
  NoteL: string = '�������:';
  EmailL: string = 'Email:';
  UpDate1L: string = '�������� ������ �������������?';
  UpDate2L: string = '�� ����������� ����� www.imadering.com �������� ���������� ��������� IMadering';
  UpDate3L: string = '����������';
  UpDate4L: string = '��������� ��������������� ���������� �� �������.' + #13#10 + '�������� ���� www.imadering.com � ���������� ������ ������ IMadering.';
  QReply1L: string = '������!';
  QReply2L: string = '��� ����?';
  QReply3L: string = '����';
  HistoryDelL: string = '�� ������������� ������ ������� ������� ���������?';
  CloseChatWindowsL: string = '���������� ������ ���� ����!';
  TypingTextL: string = '��������...';
  ClientL: string = '������:';
  StatusL: string = '������:';
  OnlineInfo1L: string = '���� ������ ����� ����������';
  OnlineInfo2L: string = '���� ��������� � ����';
  OnlineInfo3L: string = '����� ���������� Away ���������';
  OnlineInfo4L: string = 'URL ������ �� �������';
  OnlineInfo5L: string = 'IP ����� ICQ �������';
  OnlineInfo6L: string = 'Hash �������';
  OnlineInfo7L: string = '������� � ��������� ������ ���������';
  PassChangeOKL: string = '������ �������';
  AnketaSaveOKL: string = '���� ������ ������� ��������� �� �������.';
  InfoOKL: string = '���������� � �������� �������!';
  InfoReqL: string = '��������� ����������...';
  InfoCaptionL: string = '���������� � ��������';
  InfoNickL: string = '���:';
  InfoNameL: string = '���:';
  InfoHomeL: string = '���:';
  InfoAdressL: string = '�����:';
  InfoStateL: string = '����:';
  InfoZipL: string = '������:';
  InfoGenderL: string = '���:';
  InfoGender1L: string = '�������';
  InfoGender2L: string = '�������';
  InfoAgeL: string = '�������:';
  InfoBirDate: string = '���� ��������:';
  InfoOHomeL: string = '����� ��������:';
  InfoWorkL: string = '������:';
  InfoCompanyL: string = '��������:';
  InfoDeportL: string = '�����:';
  InfoPositionL: string = '���������:';
  InfoOccupationL: string = '���������:';
  InfoWebSiteL: string = '����:';
  InfoPhoneL: string = '�������:';
  InfoFaxL: string = '����:';
  InfoCellularL: string = '�������:';
  InfowPhoneL: string = '������� �������:';
  InfowFaxL: string = '������� ����:';
  InfoInterestsL: string = '��������:';
  InfoAboutL: string = '� ����:';
  InfoHomePageL: string = '�������� ���������:';
  InfoLastUpDateL: string = '���� ���������� ���������� ������:';
  InfoLangL: string = '�������� �������:';
  InfoMaritalL: string = '����:';
  InfoSexualL: string = '����������� ����������:';
  InfoHeightL: string = '����:';
  InfoReligL: string = '�������:';
  InfoSmokL: string = '�������:';
  InfoHairL: string = '���� �����:';
  InfoChildrenL1: string = '�����:';
  InfoChildrenL2: string = '�����, ��� 8';
  InfoChildrenL3: string = '���';
  DellContactL: string = '������� "%s" ����� �����. �� �������?';
  DellYourSelfL: string = '������� ���� �� ������ ��������: %s. �� �������?';
  HistoryNotFile: string = '������� ��������� � ���� ��������� �����������';
  GroupInv: string = ' �� ';

  ConnectErrors_0001: string = '������������ ����� ICQ ��� ������.';
  ConnectErrors_0002: string = '������ �������� ����������.';
  ConnectErrors_0003: string = '������ �����������.';
  ConnectErrors_0004: string = '�������� ����� ICQ ��� ������.';
  ConnectErrors_0005: string = '�������� ����� ICQ ��� ������.';
  ConnectErrors_0006: string = '���������� ������.';
  ConnectErrors_0007: string = '��� �������� ������� ������.';
  ConnectErrors_0008: string = '��� ������� ������ ���� �������.';
  ConnectErrors_0009: string = '��� ������������ ������� ������.';
  ConnectErrors_000A: string = '��� ������� � ����.';
  ConnectErrors_000B: string = '��� ������� � ����������.';
  ConnectErrors_000C: string = '�������� ���� � ���� ������.';
  ConnectErrors_000D: string = '�������� ������ ����.';
  ConnectErrors_000E: string = '�������� ������ ����������.';
  ConnectErrors_000F: string = '���������� ��������� ������.';
  ConnectErrors_0010: string = '������ �������� ��������.';
  ConnectErrors_0011: string = '������������ ���� ������� ������ ��������������.';
  ConnectErrors_0012: string = '������ ��������������� � ����.';
  ConnectErrors_0013: string = '������ �������� � ����.';
  ConnectErrors_0014: string = '������ ��������� �����.';
  ConnectErrors_0015: string = '������ ��������� ��������.';
  ConnectErrors_0016: string = '��������� ������ ����������� � ����� IP-������.';
  ConnectErrors_0017: string = '��������� ������ ����������� � ����� IP-������.';
  ConnectErrors_0018: string = '�������� ����� �����������! ���������� ������������ �����.';
  ConnectErrors_0019: string = '��� ������� ������ ����� ��������� ������� ��������������. ���������� �����.';
  ConnectErrors_001A: string = '�������� �������� ���������� � ����.';
  ConnectErrors_001B: string = '�� ����������� ������ ������ �������. �������� ������.';
  ConnectErrors_001C: string = '�� ����������� ������ ������ �������. ������������� �������� ������.';
  ConnectErrors_001D: string = '�������� ����� �����������! ���������� ������������ �����.';
  ConnectErrors_001E: string = '���������� ������������������ � ����. ���������� �����.';
  ConnectErrors_0020: string = '�������� SecureID.';
  ConnectErrors_0022: string = '��� ������� ������ ���������� ��-�� ������ �������� (������ 13).';

  LStatus1: string = '����� ���������';
  LStatus2: string = '����';
  LStatus3: string = '���������';
  LStatus4: string = '����';
  LStatus5: string = '�� ������';
  LStatus6: string = '�����';
  LStatus7: string = '������';
  LStatus8: string = '����������';
  LStatus9: string = '�����';
  LStatus10: string = '�� ����������';
  LStatus11: string = '� ����';
  LStatus12: string = '���������';
  LStatus13: string = '��������� ��� ����';
  LStatus14: string = '�� � ����';
  LStatus15: string = '�������������';
  LStatus16: string = '������������';
  LStatus17: string = '���������� �����������';


  //--���������� ���������� ����������� ���������
  FDAOptions: TJvDesktopAlertOptions;
  DACount: integer = 0;
  DATimeShow: integer = 7000;
  DAPos: integer = 3;
  DAStyle: integer = 0;

  //--���������� ��� ���� ����
  NoAvatar: TImage;
  OutMessage2: TMemoryStream;
  OutMessage3: TMemoryStream;
  QReplyAutoSend: boolean = false;
  SmilesList: TStringList;
  InMessList: TStringList;
  TextSmilies: boolean = false;
  YouAt: string = 'I';
  ChatFontSize: string = '9';

  //--������ ��� ����������� � About
  AboutList: array[1..14] of string = (
    '����� ������� � ������� �����������;������ ��������',
    '����������������;������ ������',
    '����������������;Francois PIETTE (Ics components)',
    '����������������;David Baldwin (HTML components)',
    '����������������;Project Jedi (jvcl components)',
    '����������������;������ ������ (SimpleXML ���������)',
    '����������������;Polaris Software (rXML ���������)',    
    '����������������;Anders Melander (GIFImage component)',
    '������;ϸ�� ��������',
    '������;Michael Niedermayr (www.greensmilies.com)',
    '������������ � ���������;����� �������',
    '����������� �������������;��������� ����������',
    '����������� �������������;�������� ����������',
    'IMadering;������� ����!'
    );

  //--������
  G_ProxyEnabled: boolean;
  G_ProxyType: string;
  G_ProxyTypeIndex: integer;
  G_ProxyVersion: string;
  G_ProxyVersionIndex: integer;
  G_ProxyHost: string;
  G_ProxyPort: string;
  G_ProxyAuthorize: boolean;
  G_ProxyLogin: string;
  G_ProxyPassword: string;
  G_ProxyNTLM: boolean;

implementation

end.

