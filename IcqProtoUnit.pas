{ *******************************************************************************
  Copyright (c) 2004-2010 by Edyard Tolmachev
  IMadering project
  http://imadering.com
  ICQ: 118648
  E-mail: imadering@mail.ru
  ******************************************************************************* }

unit IcqProtoUnit;

interface

{$REGION 'Uses'}

uses
  Windows,
  MainUnit,
  IcqOptionsUnit,
  SysUtils,
  JvTrayIcon,
  Dialogs,
  OverbyteIcsWSocket,
  ChatUnit,
  MmSystem,
  Forms,
  ContactSearchUnit,
  ComCtrls,
  Messages,
  Classes,
  ContactInfoUnit,
  VarsUnit,
  Graphics,
  CategoryButtons,
  OverbyteIcsUrl,
  GtransUnit,
  JvSimpleXml,
  OverbyteIcsUtils,
  LogUnit;

{$ENDREGION}
{$REGION 'Const Capabilities'}

const
  // Capabilities servises
  ICQ_Servises_Caps:
    packed array[0..43] of record Cap_HEX: string;
    Cap_Name: string;
  end
  = ((Cap_HEX: '0138CA7B769A491588F213FC00979EA8'; Cap_Name: 'HTML Messages'), // 0
    (Cap_HEX: '094600004C7F11D18222444553540000'; Cap_Name: 'Short Caps'), // 1
    (Cap_HEX: '094601014C7F11D18222444553540000'; Cap_Name: 'Live Video'), // 2
    (Cap_HEX: '094601024C7F11D18222444553540000'; Cap_Name: 'Camera'), // 3
    (Cap_HEX: '094601044C7F11D18222444553540000'; Cap_Name: 'Live Audio'), // 4
    (Cap_HEX: '094601054C7F11D18222444553540000'; Cap_Name: 'Available For Call'), // 5
    (Cap_HEX: '094601074C7F11D18222444553540000'; Cap_Name: 'Multi Audio'), // 6
    (Cap_HEX: '0946010A4C7F11D18222444553540000'; Cap_Name: 'Status Text Aware'), // 7
    (Cap_HEX: '0946010B4C7F11D18222444553540000'; Cap_Name: 'RtIm'), // 8
    (Cap_HEX: '0946010C4C7F11D18222444553540000'; Cap_Name: 'Unk 010C'), // 9
    (Cap_HEX: '0946010D4C7F11D18222444553540000'; Cap_Name: 'Unk 010D'), // 10
    (Cap_HEX: '094601FF4C7F11D18222444553540000'; Cap_Name: 'Smart Caps'), // 11
    (Cap_HEX: '094613414C7F11D18222444553540000'; Cap_Name: 'Aim Voice Chat'), // 12
    (Cap_HEX: '094613434C7F11D18222444553540000'; Cap_Name: 'File Transfer'), // 13
    (Cap_HEX: '094613444C7F11D18222444553540000'; Cap_Name: 'ICQ DirectConnect'), // 14
    (Cap_HEX: '094613454C7F11D18222444553540000'; Cap_Name: 'DirectIM'), // 15
    (Cap_HEX: '094613464C7F11D18222444553540000'; Cap_Name: 'BuddyIcon'), // 16
    (Cap_HEX: '094613474C7F11D18222444553540000'; Cap_Name: 'Aim Addins'), // 17
    (Cap_HEX: '094613484C7F11D18222444553540000'; Cap_Name: 'File Sharing'), // 18
    (Cap_HEX: '094613494C7F11D18222444553540000'; Cap_Name: 'ICQ ServerRelay'), // 19
    (Cap_HEX: '0946134B4C7F11D18222444553540000'; Cap_Name: 'Send BuddyList'), // 20
    (Cap_HEX: '0946134C4C7F11D18222444553540000'; Cap_Name: 'ICQ Avatars'), // 21
    (Cap_HEX: '0946134D4C7F11D18222444553540000'; Cap_Name: 'Aim ICQ support'), // 22
    (Cap_HEX: '0946134E4C7F11D18222444553540000'; Cap_Name: 'UTF8 Messages'), // 23
    (Cap_HEX: '094913494C7F11D18222444553540000'; Cap_Name: 'Messages Type 2 support'), // 24
    (Cap_HEX: '0946E0014C7F11D18222444553540000'; Cap_Name: 'Unk E001'), // 25
    (Cap_HEX: '0946E0024C7F11D18222444553540000'; Cap_Name: 'Unk E002'), // 26
    (Cap_HEX: '0946134A4C7F11D18222444553540000'; Cap_Name: 'Games'), // 27
    (Cap_HEX: '1A093C6CD7FD4EC59D51A6474E34F5A0'; Cap_Name: 'ICQ Xtraz Support'), // 28
    (Cap_HEX: '563FC8090B6F41BD9F79422609DFA2F3'; Cap_Name: 'Typing Notifications'), // 29
    (Cap_HEX: '67361515612D4C078F3DBDE6408EA041'; Cap_Name: 'XMultiUser Chat'), // 30
    (Cap_HEX: '748F2420628711D18222444553540000'; Cap_Name: 'Chat Support'), // 31
    (Cap_HEX: '97B12751243C4334AD22D6ABF73F1492'; Cap_Name: 'RTF Messages'), // 32
    (Cap_HEX: 'B2EC8F167C6F451BBD79DC58497888B9'; Cap_Name: 'ICQ-XtZers'), // 33
    (Cap_HEX: 'B99708B53A924202B069F1E757BB2E17'; Cap_Name: 'Voice Chat'), // 34
    (Cap_HEX: '00000000000000000000000000000000'; Cap_Name: 'Zero Cap'), // 35
    (Cap_HEX: 'E362C1E9121A4B94A6267A74DE24270D'; Cap_Name: 'Push2Talk'), // 36
    (Cap_HEX: '0946F0054C7F11D18222444553540000'; Cap_Name: 'Talkonaut GTalk2VoIP'), // 37
    (Cap_HEX: '7C533FFA68004F21BCFBC7D2439AAD31'; Cap_Name: 'QIP Plugins'), // 38
    (Cap_HEX: '8C543DFC69024D25BFFAC0D3419CAF30'; Cap_Name: 'QIP Services'), // 39
    (Cap_HEX: 'D3D453198B32403BACC7D1A9E2B5813E'; Cap_Name: 'QIP-ProtectMsg'), // 40
    (Cap_HEX: 'D6687F4F3DC34BDB8A8C4C1A572763CD'; Cap_Name: 'RnQ Protect Msg'), // 41
    (Cap_HEX: '494D7365637572654370687200000601'; Cap_Name: 'ZoneLabs IMsecure'), // 42
    (Cap_HEX: 'F2E7C7F4FEAD4DFBB23536798BDF0000'; Cap_Name: 'SecureIM Trillian')); // 43

  // Capabilities clients
  ICQ_Clients_Caps:
    packed array[0..76] of record Cap_HEX: string;
    Client_Name: string;
    Client_Icon:
    Integer;
  end
  = ((Cap_HEX: '094913444C7F11D18222444553540000'; Client_Name: 'KXicq2'; Client_Icon: 189), // 2
    (Cap_HEX: '265251696E73696465'; Client_Name: '&RQ'; Client_Icon: 167), // 3
    (Cap_HEX: '00E7E0DFA9D04FE19162C8909A132A1B'; Client_Name: 'ABV ICQ'; Client_Icon: 100), // 4
    (Cap_HEX: '4167656E74574D'; Client_Name: 'Mail.Ru Agent (WM)'; Client_Icon: 311), // 5
    (Cap_HEX: '434F5245205061676572000000000000'; Client_Name: 'CORE Pager'; Client_Icon: 190), // 6
    (Cap_HEX: '445B695D4368617420'; Client_Name: 'D[i]Chat'; Client_Icon: 191), // 7
    (Cap_HEX: '44E5BFCEB096E547BD65EFD6A37E3602'; Client_Name: 'Anastasia'; Client_Icon: 192), // 8
    (Cap_HEX: '476C49435100'; Client_Name: 'GLICQ'; Client_Icon: 197), // 9
    (Cap_HEX: '494D204761746577617920'; Client_Name: 'IM Gateway'; Client_Icon: 194), // 10
    (Cap_HEX: '494D61646572696E6720436C69656E74'; Client_Name: 'IMadering Client'; Client_Icon: 0), // 11
    (Cap_HEX: '4A324D45206D406167656E74'; Client_Name: 'Mail.Ru Agent (Java)'; Client_Icon: 105), // 12
    (Cap_HEX: '4A494351'; Client_Name: 'JICQ'; Client_Icon: 195), // 13
    (Cap_HEX: '4A4954'; Client_Name: 'JIT (Jabber ICQ Transport)'; Client_Icon: 43), // 14
    (Cap_HEX: '4A696D6D'; Client_Name: 'Jimm'; Client_Icon: 102), // 15
    (Cap_HEX: '4B6F70657465204943512020'; Client_Name: 'Kopete'; Client_Icon: 181), // 16
    (Cap_HEX: '4C69637120636C69656E74'; Client_Name: 'Licq'; Client_Icon: 187), // 17
    (Cap_HEX: '4C6B90A33D2D480E89D62E4B2C10D99F'; Client_Name: 'Netvigator ICQ'; Client_Icon: 100), // 18
    (Cap_HEX: '4C6F634944'; Client_Name: 'LocID'; Client_Icon: 197), // 19
    (Cap_HEX: '4D494D2F'; Client_Name: 'Miranda IM Custom Pack'; Client_Icon: 98), // 20
    (Cap_HEX: '4D4950'; Client_Name: 'MIP Client'; Client_Icon: 196), // 21
    (Cap_HEX: '4D6972616E646141'; Client_Name: 'AIM Oscar (Miranda)'; Client_Icon: 98), // 22
    (Cap_HEX: '4D6972616E64614D'; Client_Name: 'Miranda IM'; Client_Icon: 98), // 23
    (Cap_HEX: '4D6972616E64614D6F62696C65'; Client_Name: 'Miranda IM Mobile (port by Nullbie)'; Client_Icon: 98), // 24
    (Cap_HEX: '4E6174494351'; Client_Name: 'NatICQ'; Client_Icon: 197), // 25
    (Cap_HEX: '504850436F726520'; Client_Name: 'PHPCore'; Client_Icon: 198), // 26
    (Cap_HEX: '504947454F4E21'; Client_Name: 'PIGEON'; Client_Icon: 188), // 27
    (Cap_HEX: '51ADD1907204473DA1A149F4A397A41F'; Client_Name: 'QIP PDA (Symbian)'; Client_Icon: 99), // 28
    (Cap_HEX: '522651696E73696465'; Client_Name: 'R&Q'; Client_Icon: 170), // 29
    (Cap_HEX: '53494D20636C69656E742020'; Client_Name: 'SIM'; Client_Icon: 199), // 30
    (Cap_HEX: '53494D5053494D5053494D5053494D50'; Client_Name: 'Simp Lite'; Client_Icon: - 1), // 31
    (Cap_HEX: '53494D505F50524F53494D505F50524F'; Client_Name: 'Simp Pro'; Client_Icon: - 1), // 32
    (Cap_HEX: '536D6170657220'; Client_Name: 'Smaper'; Client_Icon: 200), // 33
    (Cap_HEX: '563FC8090B6F41514950202020202021'; Client_Name: 'QIP PDA (Windows)'; Client_Icon: 99), // 34
    (Cap_HEX: '563FC8090B6F41514950202020202022'; Client_Name: 'QIP Mobile (Java)'; Client_Icon: 99), // 35
    (Cap_HEX: '563FC8090B6F41514950203230303561'; Client_Name: 'QIP 2005'; Client_Icon: 211), // 36
    (Cap_HEX: '566D49435120'; Client_Name: 'VmICQ'; Client_Icon: 197), // 37
    (Cap_HEX: '59617070'; Client_Name: 'Yapp'; Client_Icon: 201), // 38
    (Cap_HEX: '626179616E494351'; Client_Name: 'BayanICQ'; Client_Icon: 202), // 39
    (Cap_HEX: '636C696D6DA920522E4B2E20'; Client_Name: 'Climm'; Client_Icon: 203), // 40
    (Cap_HEX: '646967736279'; Client_Name: 'Digsby'; Client_Icon: - 1), // 41
    (Cap_HEX: '6963716A'; Client_Name: 'Miranda ICQJ S7&SSS'; Client_Icon: 98), // 42
    (Cap_HEX: '6963716A2053656375726520494D2020'; Client_Name: 'Miranda ICQJ S7&SSS + SecureIM'; Client_Icon: 98), // 43
    (Cap_HEX: '69637170'; Client_Name: 'Miranda ICQJ Plus'; Client_Icon: 98), // 44
    (Cap_HEX: '6A617070'; Client_Name: 'Japp'; Client_Icon: 190), // 45
    (Cap_HEX: '6D4368617420696371'; Client_Name: 'mChat'; Client_Icon: 200), // 46
    (Cap_HEX: '6D49435120A920522E4B2E20'; Client_Name: 'mIcq'; Client_Icon: 203), // 47
    (Cap_HEX: '717574696D'; Client_Name: 'qutIM'; Client_Icon: 104), // 48
    (Cap_HEX: '73696E6A'; Client_Name: 'Miranda ICQJ S!N'; Client_Icon: 98), // 49
    (Cap_HEX: '74EDC33644DF485B8B1C671A1F86099F'; Client_Name: 'IM2'; Client_Icon: 204), // 50
    (Cap_HEX: '7C737502C3BE4F3EA69F015313431E1A'; Client_Name: 'QIP Infium'; Client_Icon: 103), // 51
    (Cap_HEX: '7E11B778A3534926A80244735208C42A'; Client_Name: 'Rambler ICQ'; Client_Icon: 100), // 52
    (Cap_HEX: '8ECD90E74F1828F802ECD618A4E9DE68'; Client_Name: 'IM+'; Client_Icon: 205), // 53
    (Cap_HEX: '97B12751243C4334AD22D6ABF73F1400'; Client_Name: 'SIM (old)'; Client_Icon: 199), // 54
    (Cap_HEX: '97B12751243C4334AD22D6ABF73F1409'; Client_Name: 'Trillian'; Client_Icon: 206), // 55
    (Cap_HEX: 'A7E40A96B3A0479AB845C9E467C56B1F'; Client_Name: 'Inlux Messenger'; Client_Icon: 197), // 58
    (Cap_HEX: 'DD16F20284E611D490DB00104B9B4B7D'; Client_Name: 'ICQ for Mac'; Client_Icon: 207), // 59
    (Cap_HEX: 'FFFFFFFF6E61696D'; Client_Name: 'Naim'; Client_Icon: 203), // 60
    (Cap_HEX: '53696D706C65494D'; Client_Name: 'SimpleIM'; Client_Icon: 197), // 61
    (Cap_HEX: '7A7B7C7D7E7F0A030B04015313431E1A'; Client_Name: 'QIP 2010'; Client_Icon: 103), // 62
    (Cap_HEX: '774A696D6D'; Client_Name: 'wJimm'; Client_Icon: 102), // 63
    (Cap_HEX: '494243545320'; Client_Name: 'ICQBot.org'; Client_Icon: - 1), // 64
    (Cap_HEX: '7665723A'; Client_Name: 'PIGEON'; Client_Icon: 188), // 65
    (Cap_HEX: '6D6D6F436E75636961746F72'; Client_Name: 'PlayIT'; Client_Icon: 210), // 66
    (Cap_HEX: '656E716A'; Client_Name: 'Miranda eternity'; Client_Icon: 98), // 67
    (Cap_HEX: '094600004C7F11D1822244455354134B'; Client_Name: 'Miranda IM Custom Pack'; Client_Icon: 98), // 68
    (Cap_HEX: '445B696D5D20762E'; Client_Name: 'D[im]'; Client_Icon: 191), // 69
    (Cap_HEX: '57656249637150726F'; Client_Name: 'WebIcqPro'; Client_Icon: 208), // 70
    (Cap_HEX: '09460F084C7F11D18222444553540000'; Client_Name: 'Nimbuzz'; Client_Icon: 209), // 72
    (Cap_HEX: '09460F074C7F11D18222444553540000'; Client_Name: 'Nimbuzz'; Client_Icon: 209), // 73
    (Cap_HEX: '45535400000946'; Client_Name: 'iChat'; Client_Icon: 207), // 74
    (Cap_HEX: '178C2D9BDAA545BB8DDBF3BDBD53A10A'; Client_Name: 'ICQ Lite'; Client_Icon: 100), // 75
    (Cap_HEX: 'C8953A9F21F14FAAB0B26DE663ABF5B7'; Client_Name: 'ICQ Lite (New)'; Client_Icon: 100), // 76
    // Конченые капы
    (Cap_HEX: '2E7A6475FADF4DC8886FEA3595FDB6DF'; Client_Name: 'ICQ 2001'; Client_Icon: 100), // 0
    (Cap_HEX: '10CF40D14C7F11D18222444553540000'; Client_Name: 'ICQ 2002'; Client_Icon: 100), // 1
    (Cap_HEX: '0946E0004C7F11D18222444553540000'; Client_Name: 'ICQ 2002'; Client_Icon: 100), // 71
    (Cap_HEX: 'A0E93F374C7F11D18222444553540000'; Client_Name: 'StrICQ 1'; Client_Icon: - 1), // 56
    (Cap_HEX: 'A0E93F374FE9D311BCD20004AC96DD96'; Client_Name: 'StrICQ 2'; Client_Icon: - 1)); // 57

{$ENDREGION}
{$REGION 'Const XStatuses'}

  // XStatus
  ICQ_XStatus_Codes:
    packed array[0..42] of record XStatus_Caps: string;
    XStatus_Code: string;
    XStatus_Icon:
    Integer;
  end
  = ((XStatus_Caps: '01D8D7EEAC3B492AA58DD3D877E66B92'; XStatus_Code: 'icqmood23'; XStatus_Icon: 1), // 0 (Angry)
    (XStatus_Caps: '5A581EA1E580430CA06F612298B7E4C7'; XStatus_Code: 'icqmood1'; XStatus_Icon: 2), // 1 (Duck)
    (XStatus_Caps: '83C9B78E77E74378B2C5FB6CFCC35BEC'; XStatus_Code: 'icqmood2'; XStatus_Icon: 3), // 2 (Tired)
    (XStatus_Caps: 'E601E41C33734BD1BC06811D6C323D81'; XStatus_Code: 'icqmood3'; XStatus_Icon: 4), // 3 (Party)
    (XStatus_Caps: '8C50DBAE81ED4786ACCA16CC3213C7B7'; XStatus_Code: 'icqmood4'; XStatus_Icon: 5), // 4 (Beer)
    (XStatus_Caps: '3FB0BD36AF3B4A609EEFCF190F6A5A7F'; XStatus_Code: 'icqmood5'; XStatus_Icon: 6), // 5 (Thinking)
    (XStatus_Caps: 'F8E8D7B282C4414290F810C6CE0A89A6'; XStatus_Code: 'icqmood6'; XStatus_Icon: 7), // 6 (Eating)
    (XStatus_Caps: '80537DE2A4674A76B3546DFD075F5EC6'; XStatus_Code: 'icqmood7'; XStatus_Icon: 8), // 7 (TV)
    (XStatus_Caps: 'F18AB52EDC57491D99DC6444502457AF'; XStatus_Code: 'icqmood8'; XStatus_Icon: 9), // 8 (Friends)
    (XStatus_Caps: '1B78AE31FA0B4D3893D1997EEEAFB218'; XStatus_Code: 'icqmood9'; XStatus_Icon: 10), // 9 (Coffee)
    (XStatus_Caps: '61BEE0DD8BDD475D8DEE5F4BAACF19A7'; XStatus_Code: 'icqmood10'; XStatus_Icon: 11), // 10 (Music)
    (XStatus_Caps: '488E14898ACA4A0882AA77CE7A165208'; XStatus_Code: 'icqmood11'; XStatus_Icon: 12), // 11 (Business)
    (XStatus_Caps: '107A9A1812324DA4B6CD0879DB780F09'; XStatus_Code: 'icqmood12'; XStatus_Icon: 13), // 12 (Camera)
    (XStatus_Caps: '6F4930984F7C4AFFA27634A03BCEAEA7'; XStatus_Code: 'icqmood13'; XStatus_Icon: 14), // 13 (Funny)
    (XStatus_Caps: '1292E5501B644F66B206B29AF378E48D'; XStatus_Code: 'icqmood14'; XStatus_Icon: 15), // 14 (Phone)
    (XStatus_Caps: 'D4A611D08F014EC09223C5B6BEC6CCF0'; XStatus_Code: 'icqmood15'; XStatus_Icon: 16), // 15 (Games)
    (XStatus_Caps: '609D52F8A29A49A6B2A02524C5E9D260'; XStatus_Code: 'icqmood16'; XStatus_Icon: 17), // 16 (College)
    (XStatus_Caps: '63627337A03F49FF80E5F709CDE0A4EE'; XStatus_Code: 'icqmood0'; XStatus_Icon: 18), // 17 (Shopping)
    (XStatus_Caps: '1F7A4071BF3B4E60BC324C5787B04CF1'; XStatus_Code: 'icqmood17'; XStatus_Icon: 19), // 18 (Sick)
    (XStatus_Caps: '785E8C4840D34C65886F04CF3F3F43DF'; XStatus_Code: 'icqmood18'; XStatus_Icon: 20), // 19 (Sleeping)
    (XStatus_Caps: 'A6ED557E6BF744D4A5D4D2E7D95CE81F'; XStatus_Code: 'icqmood19'; XStatus_Icon: 21), // 20 (Surfing)
    (XStatus_Caps: '12D07E3EF885489E8E97A72A6551E58D'; XStatus_Code: 'icqmood20'; XStatus_Icon: 22), // 21 (Email)
    (XStatus_Caps: 'BA74DB3E9E24434B87B62F6B8DFEE50F'; XStatus_Code: 'icqmood21'; XStatus_Icon: 23), // 22 (Engineering)
    (XStatus_Caps: '634F6BD8ADD24AA1AAB9115BC26D05A1'; XStatus_Code: 'icqmood22'; XStatus_Icon: 24), // 23 (Typing)
    (XStatus_Caps: '2CE0E4E57C6443709C3A7A1CE878A7DC'; XStatus_Code: 'icqmood24'; XStatus_Icon: 25), // 24 (China1)
    (XStatus_Caps: '101117C9A3B040F981AC49E159FBD5D4'; XStatus_Code: 'icqmood25'; XStatus_Icon: 26), // 25 (China2)
    (XStatus_Caps: '160C60BBDD4443F39140050F00E6C009'; XStatus_Code: 'icqmood26'; XStatus_Icon: 27), // 26 (China3)
    (XStatus_Caps: '6443C6AF22604517B58CD7DF8E290352'; XStatus_Code: 'icqmood27'; XStatus_Icon: 28), // 27 (China4)
    (XStatus_Caps: '16F5B76FA9D240358CC5C084703C98FA'; XStatus_Code: 'icqmood28'; XStatus_Icon: 29), // 28 (China5)
    (XStatus_Caps: '631436FF3F8A40D0A5CB7B66E051B364'; XStatus_Code: 'icqmood29'; XStatus_Icon: 30), // 29 (De1)
    (XStatus_Caps: 'B70867F538254327A1FFCF4CC1939797'; XStatus_Code: 'icqmood30'; XStatus_Icon: 31), // 30 (De2)
    (XStatus_Caps: 'DDCF0EA971954048A9C6413206D6F280'; XStatus_Code: 'icqmood31'; XStatus_Icon: 32), // 31 (De3)
    (XStatus_Caps: 'D4E2B0BA334E4FA598D0117DBF4D3CC8'; XStatus_Code: 'icqmood32'; XStatus_Icon: 33), // 32 (RuSearch)
    (XStatus_Caps: 'CD5643A2C94C4724B52CDC0124A1D0CD'; XStatus_Code: 'icqmood33'; XStatus_Icon: 34), // 33 (RuLove)
    (XStatus_Caps: '0072D9084AD143DD91996F026966026F'; XStatus_Code: 'icqmood34'; XStatus_Icon: 35), // 34 (RuJournal)
    (XStatus_Caps: '3FB0BD36AF3B4A609EEFCF190F6A5A7E'; XStatus_Code: 'icqmood35'; XStatus_Icon: 57), // 35 (Smoke)
    (XStatus_Caps: 'E601E41C33734BD1BC06811D6C323D82'; XStatus_Code: 'icqmood36'; XStatus_Icon: - 1), // 36 (Sex)
    (XStatus_Caps: 'B7074378F50C777797775778502D0570'; XStatus_Code: 'icqmood37'; XStatus_Icon: - 45), // 37 (StDepression)
    (XStatus_Caps: 'B7074378F50C777797775778502D0575'; XStatus_Code: 'icqmood38'; XStatus_Icon: - 45), // 38 (StFFC)
    (XStatus_Caps: 'B7074378F50C777797775778502D0576'; XStatus_Code: 'icqmood39'; XStatus_Icon: - 45), // 39 (StAtHome)
    (XStatus_Caps: 'B7074378F50C777797775778502D0577'; XStatus_Code: 'icqmood40'; XStatus_Icon: - 45), // 40 (StAtWork)
    (XStatus_Caps: 'B7074378F50C777797775778502D0578'; XStatus_Code: 'icqmood41'; XStatus_Icon: - 45), // 41 (StLunch)
    (XStatus_Caps: 'B7074378F50C777797775778502D0579'; XStatus_Code: 'icqmood42'; XStatus_Icon: - 45)); // 42 (StEvil)

{$ENDREGION}
{$REGION 'Const BART_ID'}

  // Типы BART_ID
  BUDDY_ICON_SMALL = 0;
  BUDDY_ICON = 1;
  STATUS_STR = 2;
  ARRIVE_SOUND = 3;
  RICH_TEXT = 4;
  SUPERBUDDY_ICON = 5;
  RADIO_STATION = 6;
  BUDDY_ICON_BIG = 12;
  STATUS_STR_TOD = 13;
  STATUS_MOOD = 14;
  CURRENT_AV_TRACK = 15;
  DEPART_SOUND = 96;
  IM_CHROME = 129;
  IM_SOUND = 131;
  IM_CHROME_XML = 136;
  IM_CHROME_IMMERS = 137;
  EMOTICON_SET = 1024;
  ENCR_CERT_CHAIN = 1026;
  SIGN_CERT_CHAIN = 1027;
  GATEWAY_CERT = 1028;

{$ENDREGION}
{$REGION 'Const BUDDY CL'}

  // Типы BUDDY CL
  BUDDY_NORMAL = $0000; // normal contact list entry
  BUDDY_GROUP = $0001; // larger group header
  BUDDY_VISIBLE = $0002; // contact on the visible list
  BUDDY_INVISIBLE = $0003; // contact on the invisible list
  BUDDY_UPGROUP = $0004; // update group
  BUDDY_PRESENCEINFO = $0005; // presence info
  BUDDY_IGNORE = $000E; // contact on the ignore list
  BUDDY_IMPORTTIME = $0013; // import time
  BUDDY_AVATARINFO = $0014; // avatar info
  BUDDY_LASTUPDATE = $000F; // last update date
  BUDDY_AUTORIZ = $001B; // deletes contact
  BUDDY_VANITY = $001D; // vanity info
  BUDDY_DELETE = $0019; // deletes contact
  BUDDY_ICQMDIR = $0020; // icq mdir

{$ENDREGION}
{$REGION 'Const Users Statuses'}

  // Users online statuses
  ICQ_Status_ONLINE = '0000'; // Online 7
  ICQ_Status_INVISIBLE = '0100'; // Invisible 10
  ICQ_Status_AWAY = '0001'; // Away 8
  ICQ_Status_NA = '0004'; // NA 14
  ICQ_Status_NA1 = '0005'; // NA 14
  ICQ_Status_OCCUPIED = '0010'; // Occupied 12
  ICQ_Status_OCCUPIED1 = '0011'; // Occupied 12
  ICQ_Status_DND = '0002'; // Do Not Disturb 13
  ICQ_Status_DND1 = '0012'; // Do Not Disturb 13
  ICQ_Status_DND2 = '0013'; // Do Not Disturb 13
  ICQ_Status_FFC = '0020'; // Free For Chat 16
  ICQ_Status_EVIL = '3000'; // Evil [qip] 18
  ICQ_Status_DEPRESSION = '4000'; // Depression [qip] 17
  ICQ_Status_ATHOME = '5000'; // Home [qip] 19
  ICQ_Status_ATWORK = '6000'; // Work [qip] 20
  ICQ_Status_LUNCH = '2001'; // Lunch [qip] 15
  ICQ_Status_OFFLINE = 'FFFF'; // Set status to offline 9
  ICQ_Status_UNK = '8888'; // Unknown status 214
  // Не авторизован статус и иконка номер 80 предупредительная иконка номер 220

{$ENDREGION}
{$REGION 'Const Messages ID'}

  // Messages ID
  M_PLAIN = $01; // Plain message
  M_CHAT = $02; // Chat request
  M_FILE = $03; // File request
  M_URL = $04; // URL
  M_AUTH_REQ = $06; // Auth request
  M_AUTH_DENIED = $07; // Deny auth
  M_AUTH_GIVEN = $08; // Authorize
  M_SERVER = $09; // Message from OSCAR server
  M_WEB_PAGE = $0D; // Web pager message
  M_EMAIL_EXPRESS = $0E; // Email express message
  M_CONTACTS = $13; // Contact list message
  M_ADVANCED = $1A; // Plugin message described by text string
  M_UNK = $E7; // Unknown
  M_AUTOAWAY = $E8; // Auto away message
  M_AUTOBUSY = $E9; // Auto occupied message
  M_AUTONA = $EA; // Auto not available message
  M_AUTODND = $EB; // Auto do not disturb message
  M_AUTOFFC = $EC; // Auto free for chat message

{$ENDREGION}
{$REGION 'Const'}

  // Длинна заголовка в ICQ пакетах
  ICQ_FLAP_HEAD_SIZE = 6;
  // SSL сервер
  ICQ_SSL_Server = 'slogin.oscar.aol.com';

{$ENDREGION}
{$REGION 'Array Pkt Names'}

  // Расшифровка пакетов для лога
  ICQ_Pkt_Names:
    packed array[0..57] of record Pkt_Code: Integer;
    Pkt_Name:
    string;
  end
  = ((Pkt_Code: $0001; Pkt_Name: 'SRV_HELLO'), // 0
    (Pkt_Code: $0001; Pkt_Name: 'CLI_HELLO'), // 1
    (Pkt_Code: 0; Pkt_Name: 'SRV_CLOSE'), // 2
    (Pkt_Code: 0; Pkt_Name: 'CLI_CLOSE'), // 3
    (Pkt_Code: $1706; Pkt_Name: 'CLI_LOGIN_UIN'), // 4
    (Pkt_Code: $1707; Pkt_Name: 'SRV_MD5_KEY'), // 5
    (Pkt_Code: $1702; Pkt_Name: 'CLI_LOGIN'), // 6
    (Pkt_Code: $1703; Pkt_Name: 'SRV_BOS_SERVER_COOKIE'), // 7
    (Pkt_Code: $0103; Pkt_Name: 'SRV_SERVICES_SUPPORT'), // 8
    (Pkt_Code: $0115; Pkt_Name: 'SRV_WELL_KNOWN_URL'), // 9
    (Pkt_Code: $0117; Pkt_Name: 'CLI_SERVICES_SET'), // 10
    (Pkt_Code: $0118; Pkt_Name: 'SRV_SERVICES_VER'), // 11
    (Pkt_Code: $0113; Pkt_Name: 'SRV_MESSAGE_DAY'), // 12
    (Pkt_Code: $0108; Pkt_Name: 'CLI_RATE_INFO_ACK'), // 13
    (Pkt_Code: $010E; Pkt_Name: 'CLI_SELF_INFO_REQ'), // 14
    (Pkt_Code: $1302; Pkt_Name: 'CLI_SSI_RIGHTS_REQ'), // 15
    (Pkt_Code: $1305; Pkt_Name: 'CLI_CONTACTS_LIST_REQ'), // 16
    (Pkt_Code: $0202; Pkt_Name: 'CLI_LOC_RIGHTS_REQ'), // 17
    (Pkt_Code: $0302; Pkt_Name: 'CLI_BUDDY_RIGHTS_REQ'), // 18
    (Pkt_Code: $0404; Pkt_Name: 'CLI_MESS_PARAM_INFO_REQ'), // 19
    (Pkt_Code: $0902; Pkt_Name: 'CLI_PRIVACY_RIGHTS_REQ'), // 20
    (Pkt_Code: $010F; Pkt_Name: 'SRV_SELF_INFO'), // 21
    (Pkt_Code: $0203; Pkt_Name: 'SRV_LOC_RIGHTS_INFO'), // 22
    (Pkt_Code: $0303; Pkt_Name: 'SRV_BUDDY_RIGHTS_INFO'), // 23
    (Pkt_Code: $0405; Pkt_Name: 'SRV_MESS_PARAM_INFO'), // 24
    (Pkt_Code: $0903; Pkt_Name: 'SRV_PRIVACY_RIGHTS_INFO'), // 25
    (Pkt_Code: $1303; Pkt_Name: 'SRV_SSI_RIGHTS_INFO'), // 26
    (Pkt_Code: $1306; Pkt_Name: 'SRV_CONTACTS_LIST'), // 27
    (Pkt_Code: $1307; Pkt_Name: 'CLI_SSI_ACTIVATE'), // 28
    (Pkt_Code: $0204; Pkt_Name: 'CLI_SET_ONLINE_INFO'), // 29
    (Pkt_Code: $0402; Pkt_Name: 'CLI_SET_ICBM_PARAM'), // 30
    (Pkt_Code: $011E; Pkt_Name: 'CLI_SET_STATUS'), // 31
    (Pkt_Code: $0102; Pkt_Name: 'CLI_SET_READY'), // 32
    (Pkt_Code: $1502; Pkt_Name: 'CLI_ICQ_REQUEST'), // 33
    (Pkt_Code: $0410; Pkt_Name: 'CLI_AIM_MESSAGING'), // 34
    (Pkt_Code: $1304; Pkt_Name: 'CLI_CONTACTS_LIST_REQ'), // 35
    (Pkt_Code: $0407; Pkt_Name: 'SRV_MESSAGE_REQ'), // 36
    (Pkt_Code: $030B; Pkt_Name: 'SRV_CONTACT_ONLINE'), // 37
    (Pkt_Code: $030C; Pkt_Name: 'SRV_CONTACT_OFFLINE'), // 38
    (Pkt_Code: $030A; Pkt_Name: 'SRV_CONTACT_UNK_STATUS'), // 39
    (Pkt_Code: $0406; Pkt_Name: 'CLI_SEND_MESSAGE'), // 40
    (Pkt_Code: $010A; Pkt_Name: 'SRV_RATE_LIMIT_WARN'), // 41
    (Pkt_Code: $040C; Pkt_Name: 'SRV_MESSAGE_ACK'), // 42
    (Pkt_Code: $1311; Pkt_Name: 'SSI_EDIT_BEGIN'), // 43
    (Pkt_Code: $1309; Pkt_Name: 'SSI_UPDATE'), // 44
    (Pkt_Code: $1312; Pkt_Name: 'SSI_EDIT_END'), // 45
    (Pkt_Code: $1308; Pkt_Name: 'SSI_ADD'), // 46
    (Pkt_Code: $0414; Pkt_Name: 'TYPING_NOTIFICATION'), // 47
    (Pkt_Code: $1314; Pkt_Name: 'SSI_AUTH_GRANT'), // 48
    (Pkt_Code: $003C; Pkt_Name: 'CLI_PING'), // 49
    (Pkt_Code: $0121; Pkt_Name: 'SRV_EXT_STATUS'), // 50
    (Pkt_Code: $0B02; Pkt_Name: 'SRV_SET_REPORT_INTERVAL'), // 51
    (Pkt_Code: $0417; Pkt_Name: 'SRV_AIM_MESSAGING'), // 52
    (Pkt_Code: $130E; Pkt_Name: 'SRV_SSI_MOD_ACK'), // 53
    (Pkt_Code: $1503; Pkt_Name: 'SRV_META_REPLY'), // 54
    (Pkt_Code: $1319; Pkt_Name: 'SRV_SSI_AUTH_REQ'), // 55
    (Pkt_Code: $0206; Pkt_Name: 'SRV_USER_ONLINE_INFO'), // 56
    (Pkt_Code: $130A; Pkt_Name: 'CLI_SSI_DELETE')); // 57

{$ENDREGION}
{$REGION 'Vars'}

var
  ICQ_Bos_IP: string;
  ICQ_Bos_Port: string;
  ICQ_myBeautifulSocketBuffer: string;
  ICQ_LoginServerAddr: string = 'login.icq.com';
  ICQ_LoginServerPort: string = '5190';
  ICQ_BuffPkt: string;
  // ICQ_RegUIN_HexPkt: string;
  ICQ_Avatar_HexPkt: string;
  ICQ_LoginUIN: string;
  ICQ_LoginPassword: string;
  ICQ_ChangePassword: string = '';
  // Фазы работы начало
  ICQ_Connect_Phaze: Boolean = False;
  ICQ_HTTP_Connect_Phaze: Boolean = False;
  ICQ_BosConnect_Phaze: Boolean = False;
  ICQ_Work_Phaze: Boolean = False;
  ICQ_Offline_Phaze: Boolean = True;
  // Фазы работы конец
  ICQ_CurrentStatus: Integer = 9;
  ICQ_CurrentStatus_bac: Integer = 9;
  ICQ_X_CurrentStatus: Integer = 0;
  ICQ_X_CurrentStatus_Cap: string = '';
  ICQ_X_CurrentStatus_Code: string = '';
  ICQ_X_CurrentStatus_Text: string = '';
  ICQ_Seq: Word = $1000;
  ICQ_Avatar_Seq: Word = $2000;
  ICQ_Bos_Cookie: string;
  ICQ_Online_IP: string;
  ICQ_MyUIN_RegTime: string;
  ICQ_CollSince, ICQ_SendMess, ICQ_OnlineDays, ICQ_AwayMess, ICQ_RecMess, ICQ_LastActive: string; // Vanity info
  ICQ_MyIcon_Hash: string;
  ICQ_KeepAlive: Boolean = True;
  ICQ_Reconnect: Boolean = False;
  // SSI begin
  ICQ_SSI_Phaze: Boolean = False;
  ICQ_Add_Contact_Phaze: Boolean = False;
  ICQ_Add_Contact_Auth: Boolean = False;
  ICQ_Ren_Contact_Phaze: Boolean = False;
  ICQ_Dell_Contact_Phaze: Boolean = False;
  ICQ_Add_UIN, ICQ_Add_GroupId, ICQ_Add_cId, ICQ_Add_Nick, ICQ_Add_Group_Name: string;
  ICQ_Add_Group_Phaze: Boolean = False;
  ICQ_Ren_Group_Phaze: Boolean = False;
  ICQ_Dell_Group_Phaze: Boolean = False;
  // SSI end
  ICQ_ReqInfo_UIN: string;
  ICQ_Avatar_Connect_Phaze: Boolean = False;
  ICQ_Avatar_Work_Phaze: Boolean = False;
  ICQ_Avatar_Cookie: string = '';
  ICQ_GetAvatar_UIN: string = '';
  ICQ_GetAvatar_Hash: string = '';
  ICQ_WebAware_Enabled: Boolean = False;
  ICQ_BirthDay_Enabled: Boolean = False;
  ICQ_PrivatStatus_Enabled: Boolean = True;
  ICQ_UpdatePrivateGroup_Code: string;
  MyConnTime: string;
  NewKL: Boolean;
  ICQ_Bos_Addr: string = '';
  ICQ_ClientLoginID: string = 'TestBuddy AOL Instant Messenger (SM)';

{$ENDREGION}
{$REGION 'Procedures and Functions'}

procedure ICQ_NotifyUserStatus(UIN, IStatus, IClient: string; IColor: Integer);
procedure ICQ_GoOffline;
function ICQ_MD5CliLoginPkt(CPass, CKey: RawByteString): string;
function ICQ_NotifyAuthCookieError(ErrCode: string): string;
function ICQ_CliCookiePkt(Cookie: string): string;
function ICQ_CliFamilyPkt: string;
procedure ICQ_Parse_010F(PktData: string);
function ICQ_Parse_1306(PktData: string): Boolean;
function ICQ_GenerateClientCaps(ClientName, CVer: string): string;
function ICQ_CliSetOnlineInfoPkt(XClient, XVer, XStatusCap, Cap1, Cap2, Cap3: string): string;
function ICQ_CliSetICBMparametersPkt: string;
function ICQ_CliSetFullStatusPkt: string;
function ICQ_StatusImgId2Code(ImgId: Integer): string;
function ICQ_CliClientReadyPkt: string;
function ICQ_CreateShortStatusPkt: string;
procedure ICQ_UserUnkStatus_030A(PktData: string);
procedure ICQ_UserOnline_Event(UIN, Status, UserClass, IntIP, IntPort, ExtIP, ConnFlag, ProtoVer, TimeReg, CapsId, Caps, IconHash, ConnTime: string);
function ICQ_StatusCode2ImgId(StatusCode: string): Integer;
procedure ICQ_UserOnline_030B(PktData: string; CheckStatus: Boolean);
procedure ICQ_UserOffline_030C(PktData: string);
procedure ICQ_SendMessage_0406(SUIN, SMsg: string; InUnicode: Boolean);
procedure ICQ_ReqMessage_0407(PktData: string);
procedure ICQ_ReqMsgNotify(UIN, Msg, Status, UserClass, IntIP, IntPort, ExtIP, TimeReg, IconHash, ConnTime: string; GTrans: Boolean = False);
// procedure ICQ_SendRegNewUIN(Pass, ImgWord: string);
procedure ICQ_SearchPoUIN_new(SUIN: string);
procedure ICQ_SearchPoEmail_new(SEmail: string);
procedure ICQ_SearchPoText_new(SText: string; OnlyOn: Boolean);
procedure ICQ_Parse_SNAC_1503(PktData: string);
procedure ICQ_NotifyAddSearchResults(AUIN, ANick, AFirst, ALast, AAge, AEmail, ACountry, ACity: string; AGender, AStatus: Integer; AAuth, AEndSearch: Boolean);
procedure ICQ_ReqStatus0215(UIN: string);
procedure ICQ_SetInfoP;
procedure ICQ_SetStatusXText(XText, XCode: string);
procedure ICQ_DeleteTempContact(UIN, CId, CType, TimeId: string);
procedure ICQ_AddStart;
procedure ICQ_AddEnd;
procedure ICQ_DeleteContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
procedure ICQ_SendGrandAuth(UIN: string);
procedure ICQ_SendYouAdded(UIN: string);
procedure ICQ_DellMyFromCL(UIN: string);
procedure ICQ_AddContact(UIN, GroupId, CId, Nick: string; NoAuth: Boolean);
procedure ICQ_Parse_130E_UpdateAck(PktData: string);
procedure ICQ_UpdateGroup_AddContact(GrCaption, IGroupId: string; CiDlist: TStringList);
procedure ICQ_DeleteGroup(GName, GId: string);
procedure ICQ_UpdateGroup_AddGroup(GiDlist: TStringList);
procedure ICQ_AddGroup(GName, GId: string);
procedure ICQ_RenameAndEditContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
procedure ICQ_DeleteTempContactMulti(TCList: TStringList);
procedure ICQ_ReqAuthSend(UIN, Mess: string);
procedure ICQ_ReqInfo_New_Pkt(SUIN: string);
// procedure ICQ_ReqInfo_New_Pkt_1(sUIN: string);
procedure ICQ_SaveNew_InfoPkt(CUIN, CNick, CFirst, CLast, CGender, CAddress, CCity, CState, CZip, OCity, OState, Phone1, Phone2, Phone3, Phone4, Phone5, CHomePage, WCity, WState, WZip, WAddress,
  WCorp, WDep, WProf, WSite, Int1, Int2, Int3, Int4, CAbout, CDay, CMon, CYear, CEmail1, CEmail2, CEmail3: string; CCountry, OCountry, Lang1, Lang2, Lang3, WCountry, WOccup, Int_id1, Int_id2,
  Int_id3, Int_id4, CMarital, CSexual, CHeight, CRelig, CSmok, CHair, CChildren: Integer);
procedure ICQ_UserSentTyping_0414(PktData: string);
procedure ICQ_SRV_MSGACK_ADVANCED(PktData: string; ClientOk: Boolean);
// procedure ICQ_Send_SMS(CNumber, Smstext: string);
function ICQ_StatusCode2String(StatusCode: string): string;
procedure ICQ_SearchNewBase(NickName, FirstName, LastName, City, Keywords: string; Gender, AgeRange, Marital, Country, Language, PageIndex: Integer; OnlineOnly: Boolean);
procedure ICQ_GetAvatarBosServer;
procedure ICQ_Parse_0105(PktData: string);
procedure ICQ_GetAvatarImage(AUIN, AHash: string);
procedure ICQ_Parse_UserAvatar(PktData: string);
procedure ICQ_SaveInfo_Auth_WebAvare(IAuth, IWebAvare: Boolean);
procedure ICQ_UpdatePrivate_Group(InvizStatus: string);
procedure ICQ_PassChange(Pass: string);
function ICQ_CreateHint(RosterItem: TListItem): string;

{$ENDREGION}

implementation

{$REGION 'MyUses'}

uses
  UtilsUnit,
  OverbyteIcsMD5,
  RosterUnit;

{$ENDREGION}
{$REGION 'ICQ_PassChange'}

procedure ICQ_PassChange(Pass: string);
var
  Len: Integer;
  Pkt, Pkt1: string;
begin
  // Собираем пакет для смены пароля
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'd007' + IntToHex(Random($9000), 4) + '2e04' + IntToHex(Swap16(Length(Pass)), 4) + Text2Hex(Pass) + '00';
  Len := Length(Hex2Text(Pkt1));
  Pkt1 := IntToHex((Len + 2), 4) + IntToHex(Swap16(Len), 4) + Pkt1;
  Pkt := '00150002000000000000' + '0001' + Pkt1;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SaveInfo_Auth_WebAvare'}

procedure ICQ_SaveInfo_Auth_WebAvare(IAuth, IWebAvare: Boolean);
var
  Pkt, Pkt1, Pkt2, Pkt3, IA, IW: string;
  Len, Len1, Len2: Integer;
begin
  // Собираем пакет для сохранения настройки авторизации и вебаваре статуса
  if IAuth then
    IA := '0000'
  else
    IA := '0001';
  if IWebAvare then
    IW := '01'
  else
    IW := '00';
  Randomize;
  Pkt3 := '019A0002' + IA + '02120001' + IW;
  Len2 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B90FD2000000000000000004E3000000020003' + IntToHex(Len2, 4) + Pkt3;
  Len1 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'D20F' + IntToHex(Swap16(Len1), 4) + Pkt2;
  Len := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000004' + '0001' + IntToHex(Len + 2, 4) + IntToHex(Swap16(Len), 4) + Pkt1;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_Parse_UserAvatar'}

procedure ICQ_Parse_UserAvatar(PktData: string);
{ var
  aUIN, ImageStr, ImageHex, iHash, ImageType: string;
  Len: integer;
  ImageData: TMemoryStream; }
begin
  { Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    aUIN := Hex2Text(NextData(PktData, Len));
    NextData(PktData, 4); //--skip 0001
    NextData(PktData, 2); //--skip xx
    Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    iHash := NextData(PktData, Len); //--get hash
    NextData(PktData, 2); //--skip xx
    NextData(PktData, 4); //--skip 0001
    NextData(PktData, 2); //--skip xx
    Len := HexToInt(NextData(PktData, 2));
    Len := Len * 2;
    NextData(PktData, Len); //--skip hash
    //
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    ImageHex := NextData(PktData, Len);
    ImageStr := Hex2Text(ImageHex);
    if ImageHex > EmptyStr then
    begin
    ImageData := TMemoryStream.Create;
    try
    ImageData.Write(ImageStr[1], Length(ImageStr));
    ImageType := NextData(ImageHex, 4);
    if ImageType = 'FFD8' then
    ImageData.SaveToFile(MyPath + 'Users\Avatars\' + iHash + '.jpg')
    else if ImageType = '4749' then
    ImageData.SaveToFile(MyPath + 'Users\Avatars\' + iHash + '.gif')
    else if ImageType = '424D' then
    ImageData.SaveToFile(MyPath + 'Users\Avatars\' + iHash + '.bmp');
    finally
    ImageData.Free;
    end;
    end; }
end;

{$ENDREGION}
{$REGION 'ICQ_GetAvatarImage'}

procedure ICQ_GetAvatarImage(AUIN, AHash: string);
{ var
  Pkt: string; }
begin
  { //--Собираем пакет запроса аватара контакта
    Pkt := '00100006000050000006' + IntToHex(Length(aUIN), 2) + Text2Hex(aUIN) +
    '0100010010' + aHash;
    //--Отсылаем пакет
    SendFLAP_Avatar('2', Pkt); }
end;

{$ENDREGION}
{$REGION 'ICQ_Parse_0105'}

procedure ICQ_Parse_0105(PktData: string);
{ var
  Len: integer;
  BosIP: string; }
begin
  { NextData(PktData, 16);
    while Length(PktData) > 0 do
    begin
    case HexToInt(NextData(PktData, 4)) of
    $0005:
    begin
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    BosIP := Hex2Text(NextData(PktData, Len));
    end;
    $0006:
    begin
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    ICQ_Avatar_Cookie := NextData(PktData, Len);
    end
    else
    begin
    Len := HexToInt(NextData(PktData, 4));
    Len := Len * 2;
    NextData(PktData, Len);
    end;
    end;
    end;
    //
    if (BosIP > EmptyStr) and (ICQ_Avatar_Cookie > EmptyStr) then
    begin
    try
    ICQ_Avatar_Work_Phaze := false;
    //
    MainForm.ICQAvatarWSocket.Addr := BosIP;
    MainForm.ICQAvatarWSocket.Port := '5190';
    MainForm.ICQAvatarWSocket.Proto := 'tcp';
    //
    MainForm.ICQAvatarWSocket.Connect;
    except
    on E: Exception do
    TLogger.Instance.WriteMessage(E);
    end;
    end; }
end;

{$ENDREGION}
{$REGION 'ICQ_GetAvatarBosServer'}

procedure ICQ_GetAvatarBosServer;
begin
  // Отсылаем запрос адреса сервера аватар
  // SendFLAP('2', '00010004000048C40004' + '0010');
end;

{$ENDREGION}
{$REGION 'ICQ_SearchNewBase'}

procedure ICQ_SearchNewBase(NickName, FirstName, LastName, City, Keywords: string; Gender, AgeRange, Marital, Country, Language, PageIndex: Integer; OnlineOnly: Boolean);
var
  Pkt, PktSub, Utf8_Nick, Utf8_First, Utf8_Last, Utf8_City, Utf8_Key: RawByteString;
  Len: Integer;
begin
  // Преобразуем строки в UTF-8
  Utf8_Nick := UTF8Encode(NickName);
  Utf8_First := UTF8Encode(FirstName);
  Utf8_Last := UTF8Encode(LastName);
  Utf8_City := UTF8Encode(City);
  Utf8_Key := UTF8Encode(Keywords);
  // Обнуляем переменные
  Pkt := EmptyStr;
  PktSub := EmptyStr;
  // Формируем код возраста
  case AgeRange of
    1: PktSub := '0011000D';
    2: PktSub := '00160012';
    3: PktSub := '001D0017';
    4: PktSub := '0027001E';
    5: PktSub := '00310028';
    6: PktSub := '003B0032';
    7: PktSub := '0078003C';
  end;
  if PktSub <> EmptyStr then
    PktSub := '01540004' + PktSub;
  // Формируем основной пакет
  if NickName <> EmptyStr then
    Pkt := '0078' + IntToHex(Length(Utf8_Nick), 4) + Text2Hex(Utf8_Nick);
  if FirstName <> EmptyStr then
    Pkt := Pkt + '0064' + IntToHex(Length(Utf8_First), 4) + Text2Hex(Utf8_First);
  if LastName <> EmptyStr then
    Pkt := Pkt + '006E' + IntToHex(Length(Utf8_Last), 4) + Text2Hex(Utf8_Last);
  if City <> EmptyStr then
    Pkt := Pkt + '00A0' + IntToHex(Length(Utf8_City), 4) + Text2Hex(Utf8_City);
  if Gender > -1 then
    Pkt := Pkt + '00820001' + IntToHex(Gender, 2);
  if Marital > -1 then
    Pkt := Pkt + '012C0002' + IntToHex(Marital, 4);
  if Country > -1 then
    Pkt := Pkt + '00BE0004' + IntToHex(Country, 8);
  Pkt := Pkt + PktSub;
  if Language > -1 then
    Pkt := Pkt + '00FA0002' + IntToHex(Language, 4);
  if OnlineOnly then
    Pkt := Pkt + '013600020001';
  if Keywords <> EmptyStr then
    Pkt := Pkt + '017C' + IntToHex(Length(Utf8_Key), 4) + Text2Hex(Utf8_Key);
  Pkt := '05B90FA0000000000000000004E3000000020002' + IntToHex(PageIndex, 4) + '0001' + IntToHex(Length(Hex2Text(Pkt)), 4) + Pkt;
  Pkt := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'A00F' + IntToHex(Length(Hex2Text(Pkt)), 4) + Pkt;
  Len := Length(Hex2Text(Pkt));
  Pkt := '00150002000000000002' + '0001' + IntToHex(Len + 2, 4) + IntToHex(Swap16(Len), 4) + Pkt;
  // Отправляем пакет
  ICQ_ReqInfo_UIN := EmptyStr;
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_StatusCode2String'}

function ICQ_StatusCode2String(StatusCode: string): string;
var
  ShortStatus: string;
begin
  // Обрезаем статус до 4 символов для чистоты распознавания статуса
  ShortStatus := RightStr(StatusCode, 4);
  //
  Result := Lang_Vars[81].L_S;
  if ShortStatus = ICQ_Status_ONLINE then
    Result := Lang_Vars[77].L_S
  else if ShortStatus = ICQ_Status_AWAY then
    Result := Lang_Vars[73].L_S
  else if ShortStatus = ICQ_Status_OFFLINE then
    Result := Lang_Vars[80].L_S
  else if ShortStatus = ICQ_Status_INVISIBLE then
    Result := Lang_Vars[78].L_S
  else if ShortStatus = ICQ_Status_OCCUPIED then
    Result := Lang_Vars[75].L_S
  else if ShortStatus = ICQ_Status_OCCUPIED1 then
    Result := Lang_Vars[75].L_S
  else if ShortStatus = ICQ_Status_DND then
    Result := Lang_Vars[76].L_S
  else if ShortStatus = ICQ_Status_DND1 then
    Result := Lang_Vars[76].L_S
  else if ShortStatus = ICQ_Status_DND2 then
    Result := Lang_Vars[76].L_S
  else if ShortStatus = ICQ_Status_NA then
    Result := Lang_Vars[74].L_S
  else if ShortStatus = ICQ_Status_NA1 then
    Result := Lang_Vars[74].L_S
  else if ShortStatus = ICQ_Status_LUNCH then
    Result := Lang_Vars[72].L_S
  else if ShortStatus = ICQ_Status_FFC then
    Result := Lang_Vars[67].L_S
  else if ShortStatus = ICQ_Status_DEPRESSION then
    Result := Lang_Vars[69].L_S
  else if ShortStatus = ICQ_Status_EVIL then
    Result := Lang_Vars[68].L_S
  else if ShortStatus = ICQ_Status_ATHOME then
    Result := Lang_Vars[70].L_S
  else if ShortStatus = ICQ_Status_ATWORK then
    Result := Lang_Vars[71].L_S
  else if ShortStatus = ICQ_Status_UNK then
    Result := Lang_Vars[81].L_S;
end;

{$ENDREGION}
{$REGION 'ICQ_CreateHint'}

function ICQ_CreateHint(RosterItem: TListItem): string;
var
  LnLf, XText: string;
begin
  // Формируем всплывающую подсказку для контакта ICQ
  if RosterItem <> nil then
  begin
    // Учётная запись
    Result := '<b>UIN: ' + RosterItem.Caption + '</b>';
    // Ник
    if RosterItem.SubItems[0] <> RosterItem.Caption then
      Result := Result + '<br><b>' + URLDecode(RosterItem.SubItems[0]) + '</b>';
    Result := Result + '<br>';
    // Имя и Фамилия
    //LnLf := NameAndLast(RosterItem.Caption, RosterItem.SubItems[3]);
    if LnLf <> EmptyStr then
      Result := Result + '<b>' + LnLf + '</b><br>';
    // Если стасут оффлайн или неизвестный, то пишем "Не в сети"
    if (RosterItem.SubItems[6] = '9') or (RosterItem.SubItems[6] = '214') then
      Result := Result + Lang_Vars[47].L_S + C_TN + '<font color=clred>' + ICQ_StatusCode2String(ICQ_StatusImgId2Code(9))
        // Если статус требует авторизации, то пишем об этом
    else if RosterItem.SubItems[6] = '80' then
      Result := Result + Lang_Vars[47].L_S + C_TN + '<font color=clred>' + Lang_Vars[82].L_S
        // Определяем статус и пишем его словами
    else
      Result := Result + Lang_Vars[47].L_S + C_TN + '<font color=clblue>' + ICQ_StatusCode2String(ICQ_StatusImgId2Code(StrToInt(RosterItem.SubItems[6])));
    Result := Result + '</font>';
    // Если есть текст доп. статуса, то пишем его
    if RosterItem.SubItems[31] <> EmptyStr then
    begin
      XText := URLDecode(RosterItem.SubItems[31]);
      if Length(XText) > 20 then
        XText := Copy(XText, 1, 20) + '...';
      Result := Result + '<br><font color=clred>' + XText + '</font>';
    end;
    // Время подключения
    if RosterItem.SubItems[30] <> EmptyStr then
      Result := Result + '<br>' + Lang_Vars[35].L_S + C_TN + RosterItem.SubItems[30];
    // Дата регистрации UIN
    if RosterItem.SubItems[26] <> EmptyStr then
      Result := Result + '<br>' + Lang_Vars[36].L_S + C_TN + RosterItem.SubItems[26];
    // Версия протокола
    if RosterItem.SubItems[25] <> EmptyStr then
      Result := Result + '<br>' + Lang_Vars[37].L_S + C_TN + RosterItem.SubItems[25];
    // Клиент
    if RosterItem.SubItems[32] <> EmptyStr then
      Result := Result + '<br>' + Lang_Vars[38].L_S + C_TN + RosterItem.SubItems[32];
    // Телефон
    if RosterItem.SubItems[9] <> EmptyStr then
      Result := Result + '<br>' + Lang_Vars[39].L_S + C_TN + URLDecode(RosterItem.SubItems[9]);
    // Заметка
    if RosterItem.SubItems[10] <> EmptyStr then
      Result := Result + '<br>' + Lang_Vars[40].L_S + C_TN + URLDecode(RosterItem.SubItems[10]);
    // Email
    if RosterItem.SubItems[11] <> EmptyStr then
      Result := Result + '<br>' + C_Email + C_TN + URLDecode(RosterItem.SubItems[11]);
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_Send_SMS'}

{ procedure ICQ_Send_SMS(CNumber, Smstext: string);
  var
  Pkt: string;
  Utf8Mess: string;
  CoocId: string;
  begin
  //--Собираем пакет для отправки SMS (в россии перехватывает рамблер)
  Utf8Mess := StrToUtf8(smstext);
  Randomize;
  CoocId := IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4) +
  IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4);
  Pkt := '00040006000000000006' + CoocId +
  '0001' + IntToHex(Length(cNumber), 2) + Text2Hex(cNumber) + '0002' + IntToHex((Length(Utf8Mess) + 13), 4) + '05010001010101' +
  IntToHex((Length(Utf8Mess) + 4), 4) + '00000000' + Text2Hex(Utf8Mess) + '0003000000060000';
  //--Отсылаем пакет
  SendFLAP('2', Pkt);
  end; }

{$ENDREGION}
{$REGION 'ICQ_SRV_MSGACK_ADVANCED'}

procedure ICQ_SRV_MSGACK_ADVANCED(PktData: string; ClientOk: Boolean);
var
  UIN: string;
  Len: Integer;
begin
  // Пропускаем 16 символов кукисов и 4 символа канала
  NextData(PktData, 10);
  // Получаем длинну UIN получателя сообщения
  Len := HexToInt(Text2Hex(NextData(PktData, 1)));
  // Получаем UIN
  UIN := NextData(PktData, Len);
  // Если окно чата создано и UIN совпадает с активной закладкой, то заменяем иконку сообщения
  if Assigned(ChatForm) then
  begin
    with ChatForm do
    begin
      // Если UIN активной вкладки совпадает с UIN из подтверждения
      if UIN_Panel.Caption = UIN then
      begin
        if not ClientOk then
          // Заменяем последнюю икоку исходящих сообщений на зелёную
          HTMLChatViewer.ReplaceImage('o' + IntToStr(OutMessIndex), V_OutMessage2)
        else
          // Если это уже подтвержение от клиента, то заменяем на зелёную с галочкой
          HTMLChatViewer.ReplaceImage('o' + IntToStr(OutMessIndex), V_OutMessage3);
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_UserSentTyping_0414'}

procedure ICQ_UserSentTyping_0414(PktData: string);
var
  UIN, Doc: string;
  Typing, CloseW: Boolean;
  Len: Integer;
begin
  Typing := False;
  CloseW := False;
  // Пропускаем кукисы 16 символов и канал 4 символа
  NextData(PktData, 10);
  // Получаем длинну UIN отправителя нотификации о печати сообщения
  Len := HexToInt(Text2Hex(NextData(PktData, 1)));
  // Получаем UIN
  UIN := NextData(PktData, Len);
  case HexToInt(Text2Hex(NextData(PktData, 2))) of
    $0001, $0002: Typing := True; // Начал печатать или продолжает печатать
    $000F: CloseW := True // Закрыл окно чата (приходит от ICQ 6)
  else
    begin
      Typing := False;
      CloseW := False;
    end;
  end;
  // Ставим метку о печати сообщения в Ростере

  // Отображаем событие о печати сообщения в окне чата
  if Assigned(ChatForm) then
  begin
    with ChatForm do
    begin
      if UIN_Panel.Caption = UIN then
      begin
        if CloseW then
        begin
          // Добавляем в чат сообщение о закрытиеи чата собеседником
          Doc := UTF8ToString(HTMLChatViewer.DocumentSource);
          Doc := Doc + '<span class=d>' + Lang_Vars[45].L_S + '</span><br><br>';
          LoadHTMLStrings(HTMLChatViewer, Doc);
          // Прокручиваем чат до конца
          HTMLChatViewer.VScrollBarPosition := HTMLChatViewer.VScrollBar.Max;
        end;
        // Ставим сообщение о наборе текста
        if Typing then
        begin
          NotifyPanel.Font.Color := ClBlue;
          NotifyPanel.Caption := Lang_Vars[46].L_S;
        end
        else // Сбрасываем сообщение о наборе текста
        begin
          NotifyPanel.Font.Color := ClWindowText;
          NotifyPanel.Caption := '...';
        end;
      end;
    end;
  end;
  // Выводим нотификации о печати и закрытии окна чата всплывающими сообщениями

end;

{$ENDREGION}
{$REGION 'ICQ_SaveNew_InfoPkt'}

procedure ICQ_SaveNew_InfoPkt(CUIN, CNick, CFirst, CLast, CGender, CAddress, CCity, CState, CZip, OCity, OState, Phone1, Phone2, Phone3, Phone4, Phone5, CHomePage, WCity, WState, WZip, WAddress,
  WCorp, WDep, WProf, WSite, Int1, Int2, Int3, Int4, CAbout, CDay, CMon, CYear, CEmail1, CEmail2, CEmail3: string; CCountry, OCountry, Lang1, Lang2, Lang3, WCountry, WOccup, Int_id1, Int_id2,
  Int_id3, Int_id4, CMarital, CSexual, CHeight, CRelig, CSmok, CHair, CChildren: Integer);
{ var
  Pkt, Pkt1, Pkt2, Pkt3: string;
  Len, Len1, Len2: integer;

  function Nick_First_Last: string;
  var
  iPkt, utf8_Nick, utf8_First, utf8_Last: string;
  begin
  utf8_Nick := StrToUtf8(cNick);
  utf8_First := StrToUtf8(cFirst);
  utf8_Last := StrToUtf8(cLast);
  iPkt := '0078' + IntToHex(Length(utf8_Nick), 4) + Text2Hex(utf8_Nick) +
  '0064' + IntToHex(Length(utf8_First), 4) + Text2Hex(utf8_First) +
  '006E' + IntToHex(Length(utf8_Last), 4) + Text2Hex(utf8_Last);
  Result := iPkt;
  end;

  function Gender_Addres: string;
  var
  iPkt, iPkt1, utf8_Address, utf8_City, utf8_State, utf8_Zip: string;
  iLen: integer;
  begin
  utf8_Address := StrToUtf8(cAddress);
  utf8_City := StrToUtf8(cCity);
  utf8_State := StrToUtf8(cState);
  utf8_Zip := StrToUtf8(cZip);
  iPkt1 := '0064' + IntToHex(Length(utf8_Address), 4) + Text2Hex(utf8_Address) +
  '006E' + IntToHex(Length(utf8_City), 4) + Text2Hex(utf8_City) + '0078' +
  IntToHex(Length(utf8_State), 4) + Text2Hex(utf8_State) + '0082' +
  IntToHex(Length(utf8_Zip), 4) + Text2Hex(utf8_Zip) + '008C0004' +
  IntToHex(cCountry, 8);
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '008200010' + cGender + '0096' + IntToHex(iLen + 4, 4) + '0001' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Original_Address: string;
  var
  iPkt, iPkt1, utf8_City, utf8_State: string;
  iLen: integer;
  begin
  utf8_City := StrToUtf8(oCity);
  utf8_State := StrToUtf8(oState);
  iPkt1 := '00640000' +
  '006E' + IntToHex(Length(utf8_City), 4) + Text2Hex(utf8_City) + '0078' +
  IntToHex(Length(utf8_State), 4) + Text2Hex(utf8_State) + '00820000' +
  '008C0004' + IntToHex(oCountry, 8);
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '00A0' + IntToHex(iLen + 4, 4) + '0001' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Langs: string;
  var
  iPkt: string;
  begin
  iPkt := '00AA0002' + IntToHex(Lang1, 4) + '00B40002' + IntToHex(Lang2, 4) +
  '00BE0002' + IntToHex(Lang3, 4);
  Result := iPkt;
  end;

  function Phones: string;
  var
  iPkt, iPkt1, utf8_Phone1, utf8_Phone2, utf8_Phone3, utf8_Phone4, utf8_Phone5: string;
  Phone1_Pkt, Phone2_Pkt, Phone3_Pkt, Phone4_Pkt, Phone5_Pkt: string;
  iLen, Phone1_Len, Phone2_Len, Phone3_Len, Phone4_Len, Phone5_Len: integer;
  begin
  utf8_Phone1 := StrToUtf8(Phone1);
  utf8_Phone2 := StrToUtf8(Phone2);
  utf8_Phone3 := StrToUtf8(Phone3);
  utf8_Phone4 := StrToUtf8(Phone4);
  utf8_Phone5 := StrToUtf8(Phone5);
  //
  Phone1_Pkt := Text2Hex(utf8_Phone1) + '006E00020001';
  Phone1_Len := Length(utf8_Phone1);
  Phone2_Pkt := Text2Hex(utf8_Phone2) + '006E00020004';
  Phone2_Len := Length(utf8_Phone2);
  Phone3_Pkt := Text2Hex(utf8_Phone3) + '006E00020003';
  Phone3_Len := Length(utf8_Phone3);
  Phone4_Pkt := Text2Hex(utf8_Phone4) + '006E00020002';
  Phone4_Len := Length(utf8_Phone4);
  Phone5_Pkt := Text2Hex(utf8_Phone5) + '006E00020005';
  Phone5_Len := Length(utf8_Phone5);
  //
  iPkt1 := '0006' + IntToHex(Phone1_Len + 10, 4) + '0064' + IntToHex(Phone1_Len, 4) + Phone1_Pkt +
  IntToHex(Phone2_Len + 10, 4) + '0064' + IntToHex(Phone2_Len, 4) + Phone2_Pkt +
  IntToHex(Phone3_Len + 10, 4) + '0064' + IntToHex(Phone3_Len, 4) + Phone3_Pkt +
  IntToHex(Phone4_Len + 10, 4) + '0064' + IntToHex(Phone4_Len, 4) + Phone4_Pkt +
  IntToHex(Phone5_Len + 10, 4) + '0064' + IntToHex(Phone5_Len, 4) + Phone5_Pkt +
  '000A00640000006E00020006';
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '00C8' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function HomePage: string;
  var
  iPkt, utf8_HomePage: string;
  begin
  utf8_HomePage := cHomePage;
  iPkt := '00FA' + IntToHex(Length(utf8_HomePage), 4) + Text2Hex(utf8_HomePage);
  Result := iPkt;
  end;

  function Works: string;
  var
  iPkt, iPkt1, utf8_City, utf8_State, utf8_Zip, utf8_Address, utf8_Corp, utf8_Dep, utf8_Prof, utf8_Site: string;
  iLen: integer;
  begin
  utf8_City := StrToUtf8(wCity);
  utf8_State := StrToUtf8(wState);
  utf8_Zip := StrToUtf8(wZip);
  utf8_Address := StrToUtf8(wAddress);
  utf8_Corp := StrToUtf8(wCorp);
  utf8_Dep := StrToUtf8(wDep);
  utf8_Prof := StrToUtf8(wProf);
  utf8_Site := StrToUtf8(wSite);
  //
  iPkt1 := '0064' + IntToHex(Length(utf8_Prof), 4) + Text2Hex(utf8_Prof) +
  '006E' + IntToHex(Length(utf8_Corp), 4) + Text2Hex(utf8_Corp) + '007D' +
  IntToHex(Length(utf8_Dep), 4) + Text2Hex(utf8_Dep) + '0078' +
  IntToHex(Length(utf8_Site), 4) + Text2Hex(utf8_Site) + '00820002' +
  IntToHex(wOccup, 4) + '008C00020000' + '00960008000000000000000000a000080000000000000000' +
  '00AA' + IntToHex(Length(utf8_Address), 4) + Text2Hex(utf8_Address) +
  '00B4' + IntToHex(Length(utf8_City), 4) + Text2Hex(utf8_City) + '00BE' +
  IntToHex(Length(utf8_State), 4) + Text2Hex(utf8_State) + '00C8' +
  IntToHex(Length(utf8_Zip), 4) + Text2Hex(utf8_Zip) + '00D20004' + IntToHex(wCountry, 8);
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '0118' + IntToHex(iLen + 4, 4) + '0001' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Interest: string;
  var
  iPkt, iPkt1, utf8_Int1, utf8_Int2, utf8_Int3, utf8_Int4: string;
  Int1_Pkt, Int2_Pkt, Int3_Pkt, Int4_Pkt: string;
  iLen, Int1_Len, Int2_Len, Int3_Len, Int4_Len: integer;
  begin
  utf8_Int1 := StrToUtf8(Int1);
  utf8_Int2 := StrToUtf8(Int2);
  utf8_Int3 := StrToUtf8(Int3);
  utf8_Int4 := StrToUtf8(Int4);
  //
  Int1_Pkt := Text2Hex(utf8_Int1) + '006E0002' + IntToHex(Int_id1, 4);
  Int1_Len := Length(utf8_Int1);
  Int2_Pkt := Text2Hex(utf8_Int2) + '006E0002' + IntToHex(Int_id2, 4);
  Int2_Len := Length(utf8_Int2);
  Int3_Pkt := Text2Hex(utf8_Int3) + '006E0002' + IntToHex(Int_id3, 4);
  Int3_Len := Length(utf8_Int3);
  Int4_Pkt := Text2Hex(utf8_Int4) + '006E0002' + IntToHex(Int_id4, 4);
  Int4_Len := Length(utf8_Int4);
  //
  iPkt1 := '0004' + IntToHex(Int1_Len + 10, 4) + '0064' + IntToHex(Int1_Len, 4) + Int1_Pkt +
  IntToHex(Int2_Len + 10, 4) + '0064' + IntToHex(Int2_Len, 4) + Int2_Pkt +
  IntToHex(Int3_Len + 10, 4) + '0064' + IntToHex(Int3_Len, 4) + Int3_Pkt +
  IntToHex(Int4_Len + 10, 4) + '0064' + IntToHex(Int4_Len, 4) + Int4_Pkt;
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '0122' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end;

  function Marital_About: string;
  var
  iPkt, utf8_About: string;
  begin
  utf8_About := StrToUtf8(cAbout);
  iPkt := '012C0002' + IntToHex(cMarital, 4) + '0186' + IntToHex(Length(utf8_About), 4) + Text2Hex(utf8_About);
  Result := iPkt;
  end;

  function Birg: string;
  var
  Date64: Int64;
  sDate64: TDateTime absolute Date64;
  iPkt, DateHex: string;
  begin
  if (cDay > EmptyStr) and (cMon > EmptyStr) and (cYear > EmptyStr) then
  begin
  sDate64 := StrToDate(cDay + '.' + cMon + '.' + cYear);
  sDate64 := sDate64 - 48 * Hour; //--fuck + 2 days :(
  DateHex := Int64ToHex(Date64);
  NextData(DateHex, 1); //--skip $
  iPkt := '01A40008' + DateHex;
  end
  else iPkt := '01A40008' + '0000000000000000';
  Result := iPkt;
  end;

  function Sexual_Height_Relig_Smok_Hair_Children: string;
  var
  iPkt: string;
  begin
  iPkt := '01540002' + IntToHex(cSexual, 4) + '01680002' + IntToHex(cHeight, 4) +
  '014A0002' + IntToHex(cRelig, 4) + '015E0002' + IntToHex(cSmok, 4) +
  '01720002' + IntToHex(cHair, 4) + '01400002' + IntToHex(cChildren, 4);
  Result := iPkt;
  end;

  function Emails: string;
  var
  iPkt, iPkt1, utf8_Email1, utf8_Email2, utf8_Email3: string;
  Email1_Pkt, Email2_Pkt, Email3_Pkt: string;
  iLen, Email1_Len, Email2_Len, Email3_Len: integer;
  begin
  utf8_Email1 := StrToUtf8(cEmail1);
  utf8_Email2 := StrToUtf8(cEmail2);
  utf8_Email3 := StrToUtf8(cEmail3);
  //
  Email1_Len := Length(utf8_Email1);
  Email1_Pkt := IntToHex(Email1_Len + 10, 4) + '00780002FFFF0064' +
  IntToHex(Email1_Len, 4) + Text2Hex(utf8_Email1);
  Email2_Len := Length(utf8_Email2);
  Email2_Pkt := IntToHex(Email2_Len + 10, 4) + '0078000200000064' +
  IntToHex(Email2_Len, 4) + Text2Hex(utf8_Email2);
  Email3_Len := Length(utf8_Email3);
  Email3_Pkt := IntToHex(Email3_Len + 10, 4) + '0078000200000064' +
  IntToHex(Email3_Len, 4) + Text2Hex(utf8_Email3);
  //
  iPkt1 := '0003' + Email1_Pkt + Email2_Pkt + Email3_Pkt;
  iLen := Length(Hex2Text(iPkt1));
  iPkt := '008C' + IntToHex(iLen, 4) + iPkt1;
  Result := iPkt;
  end; }

begin
  { Randomize;
    Pkt3 := Nick_First_Last + Gender_Addres + Original_Address + Langs + Phones +
    HomePage + Works + Interest + Marital_About + Birg + Emails +
    Sexual_Height_Relig_Smok_Hair_Children + '01F900020000';
    Len2 := Length(Hex2Text(Pkt3));
    Pkt2 := '05B90FD2000000000000000004E3000000020003' + IntToHex(Len2, 4) + Pkt3;
    Len1 := Length(Hex2Text(Pkt2));
    Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) +
    'D20F' + IntToHex(Swap16(Len1), 4) + Pkt2;
    Len := Length(Hex2Text(Pkt1));
    Pkt := '00150002000000000004' + '0001' + IntToHex(Len + 2, 4) + IntToHex(Swap16(Len), 4) + Pkt1;
    //
    SendFLAP('2', Pkt); }
end;

{$ENDREGION}
{$REGION 'ICQ_ReqInfo_New_Pkt'}

procedure ICQ_ReqInfo_New_Pkt(SUIN: string);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
begin
  // Составляем пакет с запросом инфы о контакте (новый способ QIP)
  Pkt3 := '0032' + IntToHex(Length(SUIN), 4) + Text2Hex(SUIN); // Req UIN
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B90FA0000000000000000004E300000002000300000001' + IntToHex(Len3, 4) + Pkt3; // Unk
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) // Owner UIN
  + 'D007' // Metainfo Request (2000)
  + IntToHex(Random($AAAA), 4) // Request Sequence Number
  + 'A00F' + IntToHex(Swap16(Len2), 4) + Pkt2; // Meta Request Subtype (Fullinfo Request)
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '001500020000' + IntToHex(StrToInt(SUIN), 8) // Pkt Head
  + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1; // Encapsulated ICQ Meta Data
  // Запоминаем UIN кого мы запрашивали
  ICQ_ReqInfo_UIN := SUIN;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_ReqInfo_New_Pkt_1'}

{ procedure ICQ_ReqInfo_New_Pkt_1(sUIN: string);
  var
  Len1, Len2, Len3: integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
  begin
  //--Составляем пакет с запросом инфы о контакте (новый способ ICQ6)
  Pkt3 := '0032' + IntToHex(Length(sUIN), 4) + Text2Hex(sUIN);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B900028000000000000006000100020002000004E300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) +
  'A00F' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '001500020000' + IntToHex(StrToInt(sUIN), 8) + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  //--Запоминаем UIN кого мы запрашивали
  ICQ_ReqInfo_UIN := sUIN;
  //--Отсылаем пакет
  SendFLAP('2', Pkt);
  end; }

{$ENDREGION}
{$REGION 'ICQ_ReqAuthSend'}

procedure ICQ_ReqAuthSend(UIN, Mess: string);
var
  Pkt, Utf8Mess: RawByteString;
begin
  // Собираем пакет запроса авторизации
  Utf8Mess := UTF8Encode(Mess);
  Pkt := '00130018000000000018' + IntToHex(Length(UIN), 2) + Text2Hex(UIN) + IntToHex(Length(Utf8Mess), 4) + Text2Hex(Utf8Mess) + '0000';
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_DeleteTempContactMulti'}

procedure ICQ_DeleteTempContactMulti(TCList: TStringList);
var
  Pkt, Pkt1, Pkt2: string;

  function CreateDelTempContsPkt: string;
  label
    X;
  var
    I, C, A, ZLen: Integer;
    ZUIN, ZId, ZType, ZTimeId: string;
  begin
    Pkt := EmptyStr;
    Pkt1 := EmptyStr;
    Pkt2 := EmptyStr;
    if TCList.Count > 50 then
      C := 50
    else
      C := TCList.Count - 1;
    for I := 0 to C do
    begin
      ZUIN := EmptyStr;
      ZId := EmptyStr;
      ZType := EmptyStr;
      ZTimeId := EmptyStr;
      Pkt2 := EmptyStr;
      ZUIN := Parse(';', TCList.Strings[I], 1);
      ZId := Parse(';', TCList.Strings[I], 2);
      ZType := Parse(';', TCList.Strings[I], 3);
      ZTimeId := Parse(';', TCList.Strings[I], 4);
      Pkt2 := '006d' + ZTimeId;
      if ZTimeId = EmptyStr then
        Pkt2 := Pkt2 + '000100';
      ZLen := Length(Hex2Text(Pkt2));
      Pkt1 := Pkt1 + IntToHex(Length(ZUIN), 4) + Text2Hex(ZUIN) + '0000' + ZId + ZType + IntToHex(ZLen, 4) + Pkt2;
    end;
    A := 0;
    X: ;
    if A <= C then
    begin
      TCList.Delete(0);
      A := A + 1;
      goto X;
    end;
    Pkt := '0013000A00000000000A' + Pkt1;
    Result := Pkt;
  end;

begin
  while TCList.Count > 0 do
    ICQ_SendPkt('2', CreateDelTempContsPkt);
end;

{$ENDREGION}
{$REGION 'ICQ_DellMyFromCL'}

procedure ICQ_DellMyFromCL(UIN: string);
var
  Pkt: string;
begin
  // Формируем пакет
  Pkt := '00130016000000000016' + IntToHex(Length(UIN), 2) + Text2Hex(UIN);
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SendYouAdded'}

procedure ICQ_SendYouAdded(UIN: string);
var
  Pkt, Rand1, Rand2, Rand3: string;
begin
  // Создаём рандомные куки
  Rand1 := IntToHex(Random($AAAA), 4);
  Rand2 := IntToHex(Random($AAAA), 4);
  Rand3 := IntToHex(Random($AAAA), 4);
  // Формируем пакет
  Pkt := '00040006000000000006' + '0000' + Rand1 + Rand2 + '00000002' + IntToHex(Length(UIN), 2) + Text2Hex(UIN) + '0005005E00000000' + Rand1 + Rand2 +
    '0000' + ICQ_Servises_Caps[19].Cap_HEX + '000A00020001000F0000271100361B000A00000' + '0000000000000000000000000000000000300000000' + Rand3 + '0E00' + Rand3 +
    '0000000000000000000000000C000000040001000000030000';
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SendGrandAuth'}

procedure ICQ_SendGrandAuth(UIN: string);
var
  Pkt: string;
begin
  // Формируем пакет Гранд авторизации
  Pkt := '00130014000000000014' + IntToHex(Length(UIN), 2) + Text2Hex(UIN) + '00000000';
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_AddStart'}

procedure ICQ_AddStart;
begin
  // Открываем сессию работы с серверным КЛ
  ICQ_SendPkt('2', '00130011000000000011');
end;

{$ENDREGION}
{$REGION 'ICQ_AddEnd'}

procedure ICQ_AddEnd;
begin
  // Закрываем сессию работы с серверным КЛ
  ICQ_SendPkt('2', '00130012000000000012');
end;

{$ENDREGION}
{$REGION 'ICQ_UpdateGroup_AddContact'}

procedure ICQ_UpdateGroup_AddContact(GrCaption, IGroupId: string; CiDlist: TStringList);
var
  I, Len1, Len2: Integer;
  Pkt, Pkt1, Pkt2: RawByteString;
  Utf8Capt: UTF8String;
begin
  // Обновляем группу при добавлении контакта в серверном КЛ
  Utf8Capt := UTF8Encode(GrCaption);
  for I := 0 to CiDlist.Count - 1 do
  begin
    Pkt2 := Pkt2 + CiDlist.Strings[I];
  end;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := '00C8' + IntToHex(Len2, 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00130009000000000009' + IntToHex(Length(Utf8Capt), 4) + Text2Hex(Utf8Capt) + IGroupId + '00000001' + IntToHex(Len1, 4) + Pkt1;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_DeleteGroup'}

procedure ICQ_DeleteGroup(GName, GId: string);
var
  Pkt: RawByteString;
  Utf8Name: RawByteString;
begin
  // Формируем пакет удаления группы
  Utf8Name := UTF8Encode(GName);
  Pkt := '0013000A00000000000A' + IntToHex(Length(Utf8Name), 4) + Text2Hex(Utf8Name) + GId + '00000001000400C80000';
  // Открываем сессию
  ICQ_AddStart;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_UpdateGroup_AddGroup'}

procedure ICQ_UpdateGroup_AddGroup(GiDlist: TStringList);
var
  I, Len1, Len2: Integer;
  Pkt, Pkt1, Pkt2: string;
begin
  // Обновляем группу при добавлении группы в серверном КЛ
  for I := 0 to GiDlist.Count - 1 do
  begin
    Pkt2 := Pkt2 + GiDlist.Strings[I];
  end;
  Pkt2 := Pkt2 + ICQ_Add_GroupId;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := '00c8' + IntToHex(Len2, 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00130009000000000009' + '0000000000000001' + IntToHex(Len1, 4) + Pkt1;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_AddGroup'}

procedure ICQ_AddGroup(GName, GId: string);
var
  Pkt: RawByteString;
  Utf8Name: RawByteString;
begin
  // Формируем пакет добавления группы в серверный КЛ
  Utf8Name := UTF8Encode(GName);
  Pkt := '00130008000000000008' + IntToHex(Length(Utf8Name), 4) + Text2Hex(Utf8Name) + GId + '00000001000400C80000';
  // Открываем сессию
  ICQ_AddStart;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_RenameAndEditContact'}

procedure ICQ_RenameAndEditContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
var
  Len: Integer;
  Pkt, Pkt1: RawByteString;
  Utf8Nick, Utf8Cell, Utf8Email, Utf8Zametka: RawByteString;
begin
  // Переводим в UTF-8
  Utf8Nick := UTF8Encode(Nick);
  Utf8Cell := UTF8Encode(Cell);
  Utf8Email := UTF8Encode(Email);
  Utf8Zametka := UTF8Encode(Zametka);
  // Формируем пакет
  Pkt1 := '0131' + IntToHex(Length(Utf8Nick), 4) + Text2Hex(Utf8Nick) + '013A' + IntToHex(Length(Utf8Cell), 4) + Text2Hex(Utf8Cell) + '013C' + IntToHex(Length(Utf8Zametka), 4) + Text2Hex(Utf8Zametka)
    + '0137' + IntToHex(Length(Utf8Email), 4) + Text2Hex(Utf8Email);
  Len := Length(Hex2Text(Pkt1));
  Pkt := '00130009000000000009' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + GroupId + Id + '0000' + IntToHex(Len, 4) + Pkt1;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_Parse_130E_UpdateAck'}

procedure ICQ_Parse_130E_UpdateAck(PktData: string);
var
  Z: Integer;
  ContactsIds: TStringList;
  GroupsIds: TStringList;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;

  procedure BuildContactsIds(GId: string);
  var
    I: Integer;
  begin
    // Составляем список групп из Ростера
    if V_Roster <> nil then
    begin
      with V_Roster do
      begin
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Icq];
          if XML_Node <> nil then
          begin
            // Открываем раздел групп
            Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
            if Sub_Node <> nil then
            begin
              for I := 0 to Sub_Node.Items.Count - 1 do
              begin
                Tri_Node := Sub_Node.Items.Item[I];
                if Tri_Node <> nil then
                begin
                  if Tri_Node.Properties.Value(C_Group + C_Id) = GId then
                    ContactsIds.Add(Tri_Node.Properties.Value(C_Id));
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

begin
  // Если это не фаза работы с серверным КЛ, то выходим
  if not ICQ_SSI_Phaze then
    Exit;
  // Если это фаза добавления контакта
  if ICQ_Add_Contact_Phaze then
  begin
    // Смотрим на ответ сервера
    case HexToInt(Text2Hex(NextData(PktData, 2))) of
      $0000:
        begin
          // Создаём список для занесения в него всех идентификаторов контактов
          ContactsIds := TStringList.Create;
          try
            // Заносим в список все идентификаторы контактов из этой группы
            BuildContactsIds(ICQ_Add_GroupId);
            // Добавляем в список новый идентификатор контакта
            ContactsIds.Add(ICQ_Add_cId);
            // Обновляем группу в серверном КЛ
            ICQ_UpdateGroup_AddContact(ICQ_Add_Group_Name, ICQ_Add_GroupId, ContactsIds);
          finally
            ContactsIds.Free;
          end;
          // Закрываем сессию добавления контакта
          ICQ_SSI_Phaze := False;
          ICQ_Add_Contact_Phaze := False;
          ICQ_AddEnd;
          // Успешно добавляем контакт в локальный список контактов
          if V_Roster <> nil then
          begin
            with V_Roster do
            begin
              if Root <> nil then
              begin
                // Ищем раздел MRA
                XML_Node := Root.Items.ItemNamed[C_Icq];
                if XML_Node <> nil then
                begin
                  // Ищем раздел контактов
                  Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                  if Sub_Node <> nil then
                  begin
                    // Добавляем этот контакт в эту группу
                    Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                    Tri_Node.Properties.Add(C_Login, URLEncode(ICQ_Add_UIN));
                    Tri_Node.Properties.Add(C_Group + C_Id, ICQ_Add_GroupId);
                    Tri_Node.Properties.Add(C_Status, 9);
                    Tri_Node.Properties.Add(C_Nick, URLEncode(ICQ_Add_Nick));
                    if ICQ_Add_Contact_Auth then
                    begin
                      Tri_Node.Properties.Add(C_Auth, C_AuthNone);
                      Tri_Node.Properties.Add(C_Client, '220');
                    end
                    else
                      Tri_Node.Properties.Add(C_Auth, C_AuthBoth);
                    ICQ_Add_Contact_Auth := False;
                  end;
                end;
              end;
            end;
          end;
          // Строим локальный КЛ
          UpdateFullCL;
          // Сообщаем об успешном добавлении контакта
          DAShow(Lang_Vars[16].L_S + C_BN + C_Icq, Lang_Vars[107].L_S, EmptyStr, 133, 3, 0);
        end;
      $000E:
        begin
          ICQ_Add_Contact_Auth := True;
          // Закрываем сессию
          ICQ_AddEnd;
          // Добавляем контакт уже как неавторизованный
          ICQ_AddContact(ICQ_Add_UIN, ICQ_Add_GroupId, ICQ_Add_cId, ICQ_Add_Nick, True);
        end
    else
      begin
        // Закрываем сессию добавления контакта
        ICQ_SSI_Phaze := False;
        ICQ_Add_Contact_Phaze := False;
        ICQ_AddEnd;
        // Сообщаем об ошибке добавления нового контакта в серверный КЛ
        DAShow(Lang_Vars[17].L_S + C_BN + C_Icq, Lang_Vars[106].L_S, EmptyStr, 134, 2, 0);
      end;
    end;
  end
  else if ICQ_Dell_Contact_Phaze then // Если это фаза удаления контакта
  begin
    // Закрываем сессию удаления контакта
    ICQ_SSI_Phaze := False;
    ICQ_Dell_Contact_Phaze := False;
    // Смотрим на ответ сервера
    if HexToInt(Text2Hex(NextData(PktData, 2))) = $0000 then
      DAShow(Lang_Vars[16].L_S + C_BN + C_Icq, Lang_Vars[162].L_S, EmptyStr, 133, 3, 0)
    else
      DAShow(Lang_Vars[17].L_S + C_BN + C_Icq, Lang_Vars[163].L_S, EmptyStr, 134, 2, 0);
  end
  else if ICQ_Add_Group_Phaze then // Если это фаза добавления группы
  begin
    case HexToInt(Text2Hex(NextData(PktData, 2))) of
      $0000:
        begin
          // Создаём список для занесения в него идентификаторов групп
          GroupsIds := TStringList.Create;
          try
            // Заносим в список идентификаторы групп
            if V_Roster <> nil then
            begin
              with V_Roster do
              begin
                if Root <> nil then
                begin
                  XML_Node := Root.Items.ItemNamed[C_Icq];
                  if XML_Node <> nil then
                  begin
                    // Открываем раздел групп
                    Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
                    if Sub_Node <> nil then
                    begin
                      for Z := 0 to Sub_Node.Items.Count - 1 do
                      begin
                        Tri_Node := Sub_Node.Items.Item[Z];
                        if Tri_Node <> nil then
                        begin
                          if (Tri_Node.Properties.Value(C_Id) = C_NoCL) or (Tri_Node.Properties.Value(C_Id) = '0000') then
                            Continue;
                          GroupsIds.Add(Tri_Node.Properties.Value(C_Id));
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
            // Обновляем группы на сервере и закрываем сессию
            ICQ_UpdateGroup_AddGroup(GroupsIds);
            ICQ_AddEnd;
            ICQ_SSI_Phaze := False;
            ICQ_Add_Group_Phaze := False;
          finally
            GroupsIds.Free;
          end;
          // Добавляем группу в локальный КЛ
          if V_Roster <> nil then
          begin
            with V_Roster do
            begin
              if Root <> nil then
              begin
                XML_Node := Root.Items.ItemNamed[C_Icq];
                if XML_Node <> nil then
                begin
                  // Открываем раздел групп
                  Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
                  if Sub_Node <> nil then
                  begin
                    Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                    Tri_Node.Properties.Add(C_Name, URLEncode(ICQ_Add_Nick));
                    Tri_Node.Properties.Add(C_Id, ICQ_Add_GroupId);
                  end;
                end;
              end;
            end;
          end;
          // Строим локальный КЛ
          UpdateFullCL;
          // Сообщаем об успешном добавлении группы
          DAShow(Lang_Vars[16].L_S + C_BN + C_Icq, Lang_Vars[101].L_S, EmptyStr, 133, 3, 0);
        end
    else
      begin
        // Закрываем сессию добавления группы
        ICQ_AddEnd;
        ICQ_SSI_Phaze := False;
        ICQ_Add_Group_Phaze := False;
        // Сообщаем об ошибке добавления новой группы в серверный КЛ
        DAShow(Lang_Vars[17].L_S + C_BN + C_Icq, Lang_Vars[98].L_S, EmptyStr, 134, 2, 0);
      end;
    end;
  end
  else if ICQ_Ren_Group_Phaze then // Если это фаза переименования группы
  begin
    // Закрываем сессию удаления контакта
    ICQ_SSI_Phaze := False;
    ICQ_Ren_Contact_Phaze := False;
    // Смотрим на ответ сервера
    if HexToInt(Text2Hex(NextData(PktData, 2))) = $0000 then
      DAShow(Lang_Vars[16].L_S + C_BN + C_Icq, Lang_Vars[49].L_S, EmptyStr, 133, 3, 0)
    else
      DAShow(Lang_Vars[17].L_S + C_BN + C_Icq, Lang_Vars[164].L_S, EmptyStr, 134, 2, 0);
  end
  else if ICQ_Dell_Group_Phaze then // Если это фаза удаления группы
  begin
    case HexToInt(Text2Hex(NextData(PktData, 2))) of
      $0000:
        begin
          GroupsIds := TStringList.Create;
          try
            // Заносим в список идентификаторы групп
            if V_Roster <> nil then
            begin
              with V_Roster do
              begin
                if Root <> nil then
                begin
                  XML_Node := Root.Items.ItemNamed[C_Icq];
                  if XML_Node <> nil then
                  begin
                    // Открываем раздел групп
                    Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
                    if Sub_Node <> nil then
                    begin
                      for Z := 0 to Sub_Node.Items.Count - 1 do
                      begin
                        Tri_Node := Sub_Node.Items.Item[Z];
                        if Tri_Node <> nil then
                        begin
                          if (Tri_Node.Properties.Value(C_Id) = C_NoCL) or (Tri_Node.Properties.Value(C_Id) = '0000') then
                            Continue;
                          GroupsIds.Add(Tri_Node.Properties.Value(C_Id));
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
            // Обновляем группы на сервере
            ICQ_UpdateGroup_AddGroup(GroupsIds);
            ICQ_AddEnd;
          finally
            GroupsIds.Free;
          end;
          // Закрываем сесиию удаления группы
          ICQ_SSI_Phaze := False;
          ICQ_Dell_Group_Phaze := False;
          // Сообщаем об успешном добавлении группы
          DAShow(Lang_Vars[16].L_S + C_BN + C_Icq, Lang_Vars[100].L_S, EmptyStr, 133, 3, 0);
        end
    else
      begin
        // Закрываем сессию удаления группы
        ICQ_AddEnd;
        ICQ_SSI_Phaze := False;
        ICQ_Dell_Group_Phaze := False;
        DAShow(Lang_Vars[17].L_S + C_BN + C_Icq, Lang_Vars[99].L_S, EmptyStr, 134, 2, 0);
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_AddContact'}

procedure ICQ_AddContact(UIN, GroupId, CId, Nick: string; NoAuth: Boolean);
var
  Len: Integer;
  Pkt, Pkt1: RawByteString;
  Utf8Nick: UTF8String;
begin
  // Формируем пакет для добавления нового контакта в серверный КЛ
  Utf8Nick := UTF8Encode(Nick);
  Pkt1 := '0131' + IntToHex(Length(Utf8Nick), 4) + Text2Hex(Utf8Nick) + '013A0000013C000001370000';
  if NoAuth then
    Pkt1 := Pkt1 + '00660000';
  Len := Length(Hex2Text(Pkt1));
  Pkt := '00130008000000000008' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + GroupId + CId + '0000' + IntToHex(Len, 4) + Pkt1;
  // Запоминаем переменные нового контакта
  ICQ_Add_UIN := UIN;
  ICQ_Add_GroupId := GroupId;
  ICQ_Add_cId := CId;
  ICQ_Add_Nick := Nick;
  // Открываем сессию
  ICQ_AddStart;
  // Отправляем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_DeleteContact'}

procedure ICQ_DeleteContact(UIN, GroupId, Id, Nick, Cell, Email, Zametka: string);
var
  Len: Integer;
  Pkt, Pkt1: RawByteString;
  Utf8Nick, Utf8Cell, Utf8Email, Utf8Zametka: RawByteString;
begin
  // Переводим все в кодировку UTF-8
  Utf8Nick := UTF8Encode(Nick);
  Utf8Cell := UTF8Encode(Cell);
  Utf8Email := UTF8Encode(Email);
  Utf8Zametka := UTF8Encode(Zametka);
  // Формируем пакет
  Pkt1 := '0131' + IntToHex(Length(Utf8Nick), 4) + Text2Hex(Utf8Nick) + '013A' + IntToHex(Length(Utf8Cell), 4) + Text2Hex(Utf8Cell) + '013C' + IntToHex(Length(Utf8Zametka), 4) + Text2Hex(Utf8Zametka)
    + '0137' + IntToHex(Length(Utf8Email), 4) + Text2Hex(Utf8Email);
  Len := Length(Hex2Text(Pkt1));
  Pkt := '0013000A00000000000A' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + GroupId + Id + '0000' + IntToHex(Len, 4) + Pkt1;
  // Открываем сессию для работы с серверным списком контактов
  ICQ_AddStart;
  // Отправляем пакет
  ICQ_SendPkt('2', Pkt);
  // Закрываем сессию
  ICQ_AddEnd;
end;

{$ENDREGION}
{$REGION 'ICQ_DeleteTempContact'}

procedure ICQ_DeleteTempContact(UIN, CId, CType, TimeId: string);
var
  Len: Integer;
  Pkt, Pkt1, Tid: string;
begin
  // Формируем пакет удаления временных контактов из списка
  Tid := Hex2Text(TimeId);
  Pkt1 := '006D' + IntToHex(Length(Tid), 4) + Text2Hex(Tid);
  Len := Length(Hex2Text(Pkt1));
  Pkt := '0013000A00000000000A' + IntToHex(Length(UIN), 4) + Text2Hex(UIN) + '0000' + CId + CType + IntToHex(Len, 4) + Pkt1;
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SetStatusXText'}

procedure ICQ_SetStatusXText(XText, XCode: string);
var
  Len: Integer;
  Pkt, Pkt1: RawByteString;
  Utf8XText: RawByteString;
begin
  // Формируем пакет установки доп. статуса и подписи к нему
  if XText <> EmptyStr then
  begin
    Utf8XText := UTF8Encode(XText);
    Pkt1 := '0002' + '04' + IntToHex(Length(Utf8XText) + 4, 2) + IntToHex(Length(Utf8XText), 4) + Text2Hex(Utf8XText) + '0000' + '000E' + IntToHex(Length(XCode), 4) + Text2Hex(XCode);
  end
  else
    Pkt1 := '00020000000E0000';
  Len := Length(Hex2Text(Pkt1));
  Pkt := '0001001e00000000001e' + '001D' + IntToHex(Len, 4) + Pkt1;
  // Отправляем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SetInfoP'}

procedure ICQ_SetInfoP;
var
  Pkt: string;
begin
  Pkt := '00020004000000000004' + '00040000';
  // Отправляем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_ReqStatus0215'}

procedure ICQ_ReqStatus0215(UIN: string);
var
  Pkt: string;
begin
  // Составляем пакет для принудительного запроса статуса контакта
  Pkt := '000200150000' + '00000000' + '00000005' + IntToHex(Length(UIN), 2) + Text2Hex(UIN);
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_NotifyAddSearchResults'}

procedure ICQ_NotifyAddSearchResults(AUIN, ANick, AFirst, ALast, AAge, AEmail, ACountry, ACity: string; AGender, AStatus: Integer; AAuth, AEndSearch: Boolean);
var
  ListItemD: TListItem;
  Gend: string;
  I: Integer;
begin
  if Assigned(ContactSearchForm) then
  begin
    with ContactSearchForm do
    begin
      // Если UIN пустой и конец поиска, то сообщаем, что не найден
      if (AUIN = EmptyStr) and (AEndSearch) then
      begin
        StatusPanel.Caption := Lang_Vars[123].L_S;
        Exit;
      end;
      // Если конец поиска, то сообщаем, что поиск завершён
      if AEndSearch then
        StatusPanel.Caption := Lang_Vars[122].L_S;
      // Проверяем есть ли уже такой контакт в списке найденных
      for I := 0 to SearchResultJvListView.Items.Count - 1 do
      begin
        // Если нашли, то выходим
        if SearchResultJvListView.Items[I].SubItems[1] = AUIN then
          Exit;
      end;
      // Начинаем добавление записи в список найденных
      SearchResultJvListView.Items.BeginUpdate;
      try
        ListItemD := SearchResultJvListView.Items.Add;
        with ListItemD do
        begin
          Checked := False;
          Caption := EmptyStr; // Иконка анкеты
          SubItems.Add(EmptyStr); // Иконка чата
          SubItems.Add(AUIN);
          case AStatus of
            0: SubItemImages[1] := 241;
            1: SubItemImages[1] := 242;
            2: SubItemImages[1] := 243
          else
            SubItemImages[1] := 243;
          end;
          SubItems.Add(ANick);
          SubItems.Add(AFirst);
          SubItems.Add(ALast);
          case AGender of
            0: Gend := EmptyStr;
            1: Gend := Parse(' ', GenderComboBox.Items.Strings[1], 2);
            2: Gend := Parse(' ', GenderComboBox.Items.Strings[2], 2);
          end;
          if (Gend <> EmptyStr) and (AAge <> '0') then
            Gend := Gend + ' - ' + AAge
          else if AAge <> '0' then
            Gend := AAge;
          SubItems.Add(Gend);
          if AAuth then
            SubItems.Add(Lang_Vars[124].L_S)
          else
            SubItems.Add(Lang_Vars[125].L_S);
          SubItems.Add(EmptyStr); // Иконка быстрых сообщений
          SubItems.Add(ACountry);
          SubItems.Add(ACity);
          SubItems.Add(AEmail);
        end;
      finally
        SearchResultJvListView.Items.EndUpdate;
      end;
    end;
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_Parse_SNAC_1503'}

procedure ICQ_Parse_SNAC_1503(PktData: string);
label
  X;
var
  UIN, Nick, First, Last, City, State, Phone, Fax, Address: string;
  Cellular, WPhone, WFax, Zip, HomePage, OCity, OState: string;
  Country, Gender, Lang1, Lang2, Lang3, Relig, Sexual: Word;
  Company, Department, Position, About, Int1, Int2, Int3, Int4: string;
  OCountry, WCountry, Occupation, I1, I2, I3, I4, Marital, Children: Word;
  Email, Email1, Email2, Email3, WSite, WAddress, WCity, WState, WZip: string;
  Smok, Height, Hair: Word;
  IYear, IMonth, IDay: Word;
  I, Ii, MsgLen, Count, Age, SStatus, BMRes: Integer;
  Auth, EndSearch, WebAware: Boolean;
  Date64: Int64;
  SDate64: TDateTime absolute Date64;
  TLV, SubPkt, LastUpdateInfo, ACountry, S_Log, PTLV: string;
  CLContact: TButtonItem;
  ChatPage: TToolButton;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node: TJvSimpleXmlElem;
  Get_Node: TJvSimpleXmlElem;
begin
  // Сканируем тело пакета на нужные нам TLV
  PTLV := Text2Hex(NextData(PktData, 2));
  case HexToInt(PTLV) of
    $AA00: // Пароль на учётную запись успешно изменён
      begin
        if HexToInt(Text2Hex(NextData(PktData, 1))) = $0A then
        begin
          ICQ_LoginPassword := ICQ_ChangePassword;
          // Информируем об успешной смене пароля
          DAShow(Lang_Vars[16].L_S, Lang_Vars[30].L_S, EmptyStr, 133, 3, 0);
          Exit;
        end;
      end;
    $DC0F: // Анкетная информация успешно изменена
      begin
        if HexToInt(Text2Hex(NextData(PktData, 1))) = $0A then
        begin
          ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
          DAShow(Lang_Vars[16].L_S, Lang_Vars[54].L_S, EmptyStr, 133, 3, 0);
          Exit;
        end;
      end;
    $B40F, $AA0F: // Большая информация о контакте и в поиске тоже она же
      begin
        // Проверяем метку о наличие положительных данных 1
        if HexToInt(Text2Hex(NextData(PktData, 1))) <> $0A then
        begin
          // Заканчиваем поиск
          EndSearch := True;
          ICQ_NotifyAddSearchResults(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, 0, 0, False, EndSearch);
          Exit;
        end;
        // Сбрасываем флаг об авторизации
        Auth := False;
        // Проверяем метку о наличие положительных данных 2
        if HexToInt(Text2Hex(NextData(PktData, 2))) = $1D00 then
        begin
          // Заканчиваем поиск
          EndSearch := True;
          ICQ_NotifyAddSearchResults(EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, 0, 0, False, EndSearch);
          Exit;
        end;
        // Делаем поиск с целью найти конец непонятных данных и обрезаем пакет по это место
        BMRes := Pos(#$00#$32#$00, PktData);
        if BMRes > 0 then
          S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, BMRes - 1)) + C_RN
        else
          Exit;
        // Сбрасываем все переменные
        Age := 0;
        Gender := 0;
        SStatus := 0;
        Country := 0;
        Lang1 := 0;
        Lang2 := 0;
        Lang3 := 0;
        OCountry := 0;
        Marital := 0;
        Children := 0;
        Relig := 0;
        Sexual := 0;
        Smok := 0;
        Height := 0;
        Hair := 0;
        I1 := 0;
        I2 := 0;
        I3 := 0;
        I4 := 0;
        WCountry := 0;
        Occupation := 0;
        IYear := 0;
        IMonth := 0;
        IDay := 0;
        WebAware := False;
        // Начинаем сканировать нужные нам TLV пока длинна пакета больше нуля
        while Length(PktData) > 0 do
        begin
          TLV := Text2Hex(NextData(PktData, 2));
          case HexToInt(TLV) of
            $0032: // Получаем UIN
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                UIN := NextData(PktData, MsgLen);
                S_Log := S_Log + C_Login + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + UIN + C_RN;
              end;
            $0050: // Получаем Email
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Email := Trim(Utf8ToString(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Email + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Email + C_RN;
              end;
            $0064: // Получаем Имя
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                First := Trim(Utf8ToString(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_First + C_Name + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + First + C_RN;
              end;
            $006E: // Получаем Фамилию
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Last := Trim(Utf8ToString(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Last + C_Name + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Last + C_RN;
              end;
            $0078: // Получаем Ник
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Nick := Trim(Utf8ToString(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Nick + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Nick + C_RN;
              end;
            $0082: // Получаем Пол
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Gender := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Gender + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Gender) + C_RN;
              end;
            $0190: // Получаем Статус
              begin
                NextData(PktData, 3);
                SStatus := HexToInt(Text2Hex(NextData(PktData, 1)));
                S_Log := S_Log + C_Status + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(SStatus) + C_RN;
              end;
            $01A4: // Получаем Дату рождения в 64 битном формате
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Date64 := HexToInt64(Text2Hex(NextData(PktData, MsgLen)));
                if Date64 > 0 then
                begin
                  SDate64 := SDate64 + (48 * С_Hour);
                  // Вычисляем возраст
                  Age := CalculateAge(SDate64, Date);
                  // Разбираем дату на день - месяц - год
                  DecodeDate(SDate64, IYear, IMonth, IDay);
                end;
                S_Log := S_Log + C_Age + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Age) + C_RN;
              end;
            $0096: // Получаем суб TLV с инфой о месте жительства
              begin
                // Получаем длинну суб TLV
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                // Если данные не пустые
                if MsgLen > 2 then
                begin
                  SubPkt := NextData(PktData, MsgLen);
                  S_Log := S_Log + C_MaskPass + C_BN + C_HomeInfo + C_BN + C_MaskPass + C_RN;
                  // Пропускаем данные
                  NextData(SubPkt, 4);
                  // Сканируем на нужные нам TLV
                  while Length(SubPkt) > 0 do
                  begin
                    TLV := Text2Hex(NextData(SubPkt, 2));
                    case HexToInt(TLV) of
                      $008C: // Получаем код Страны
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          Country := HexToInt(Text2Hex(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Country + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Country) + C_RN;
                        end;
                      $0078: // Получаем Штат
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          State := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_State + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + State + C_RN;
                        end;
                      $006E: // Получаем Город
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          City := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_City + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + City + C_RN;
                        end;
                      $0064: // Получаем Адрес
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          Address := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Address + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Address + C_RN;
                        end
                    else
                      begin
                        // Если пакет содержит другие TLV, то пропускаем их
                        MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                        S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubPkt, MsgLen)) + C_RN;
                      end;
                    end;
                  end;
                  S_Log := S_Log + C_MaskPass + C_MaskPass + C_RN;
                end
                else // Пропускаем пустые данные
                  NextData(PktData, MsgLen);
              end;
            $00AA: // Получаем Язык 1
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Lang1 := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Lang + '1' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Lang1) + C_RN;
              end;
            $00B4: // Получаем Язык 2
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Lang2 := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Lang + '2' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Lang2) + C_RN;
              end;
            $00BE: // Получаем Язык 3
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Lang3 := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Lang + '3' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Lang3) + C_RN;
              end;
            $012C: // Получаем статус Брака (холост, женат и т.д.)
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Marital := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Marital + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Marital) + C_RN;
              end;
            $0140: // Получаем количество Детей
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Children := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Children + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Children) + C_RN;
              end;
            $014A: // Получаем Религию
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Relig := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Relig + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Relig) + C_RN;
              end;
            $0154: // Получаем Сексуальную ориентацию
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Sexual := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Sexual + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Sexual) + C_RN;
              end;
            $015E: // Получаем Курительный статус
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Smok := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Smok + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Smok) + C_RN;
              end;
            $0168: // Получаем Рост
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Height := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Height + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Height) + C_RN;
              end;
            $0172: // Получаем Цвет волос
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Hair := HexToInt(Text2Hex(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_Hair + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Hair) + C_RN;
              end;
            $0186: // Получаем "О себе..."
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                About := Trim(Utf8ToString(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_AboutInfo + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + About + C_RN;
              end;
            $00A0: // Получаем суб TLV о месте рождения
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                // Если данные не пустые
                if MsgLen > 2 then
                begin
                  SubPkt := NextData(PktData, MsgLen);
                  S_Log := S_Log + C_MaskPass + C_BN + C_OHomeInfo + C_BN + C_MaskPass + C_RN;
                  // Пропускаем данные
                  NextData(SubPkt, 4);
                  // Сканируем на нужные TLV
                  while Length(SubPkt) > 0 do
                  begin
                    TLV := Text2Hex(NextData(SubPkt, 2));
                    case HexToInt(TLV) of
                      $008C: // Получаем код Страны
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          OCountry := HexToInt(Text2Hex(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Country + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(OCountry) + C_RN;
                        end;
                      $0078: // Получаем Штат
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          OState := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_State + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + OState + C_RN;
                        end;
                      $006E: // Получаем Город
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          OCity := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_City + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + OCity + C_RN;
                        end
                    else
                      begin
                        // Если пакет содержит другие TLV, то пропускаем их
                        MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                        S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubPkt, MsgLen)) + C_RN;
                      end;
                    end;
                  end;
                  S_Log := S_Log + C_MaskPass + C_MaskPass + C_RN;
                end
                else // Пропускаем пустые данные
                  NextData(PktData, MsgLen);
              end;
            $0118: // Получаем суб TLV о месте работы
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                // Если данные не пустые
                if MsgLen > 2 then
                begin
                  SubPkt := NextData(PktData, MsgLen);
                  S_Log := S_Log + C_MaskPass + C_BN + C_WorkInfo + C_BN + C_MaskPass + C_RN;
                  // Пропускаем данные
                  NextData(SubPkt, 4);
                  // Сканируем на нужные TLV
                  while Length(SubPkt) > 0 do
                  begin
                    TLV := Text2Hex(NextData(SubPkt, 2));
                    case HexToInt(TLV) of
                      $00D2: // Получаем код Страны
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          WCountry := HexToInt(Text2Hex(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Country + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(WCountry) + C_RN;
                        end;
                      $00C8: // Получаем Зип
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          WZip := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Zip + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WZip + C_RN;
                        end;
                      $00BE: // Получаем Штат
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          WState := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_State + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WState + C_RN;
                        end;
                      $00B4: // Получаем Город
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          WCity := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_City + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WCity + C_RN;
                        end;
                      $00AA: // Получаем Адрес
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          WAddress := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Address + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WAddress + C_RN;
                        end;
                      $0082: // Получаем Профессию
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          Occupation := HexToInt(Text2Hex(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Occup + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(Occupation) + C_RN;
                        end;
                      $0078: // Получаем Сайт
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          WSite := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Site + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WSite + C_RN;
                        end;
                      $007D: // Получаем Отдел
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          Department := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Dep + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Department + C_RN;
                        end;
                      $006E: // Получаем Компанию
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          Company := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Corp + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Company + C_RN;
                        end;
                      $0064: // Получаем Позицию
                        begin
                          MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          Position := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Prof + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Position + C_RN;
                        end
                    else
                      begin
                        // Если пакет содержит другие TLV, то пропускаем их
                        MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                        S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubPkt, MsgLen)) + C_RN;
                      end;
                    end;
                  end;
                  S_Log := S_Log + C_MaskPass + C_MaskPass + C_RN;
                end
                else // Пропускаем пустые данные
                  NextData(PktData, MsgLen);
              end;
            $008C: // Получаем суб TLV с Email ящиками
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                // Если данные не пустые
                if MsgLen > 2 then
                begin
                  SubPkt := NextData(PktData, MsgLen);
                  S_Log := S_Log + C_MaskPass + C_BN + C_EmailsInfo + C_SS + C_BN + C_MaskPass + C_RN;
                  // В цикле смотрим сколько ящиков указано
                  for I := 1 to HexToInt(Text2Hex(NextData(SubPkt, 2))) do
                  begin
                    NextData(SubPkt, 4); // Пропускаем данные
                    MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                    case I of
                      1:
                        begin
                          Email1 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Email + '1' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Email1 + C_RN;
                        end;
                      2:
                        begin
                          Email2 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Email + '2' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Email2 + C_RN;
                        end;
                      3:
                        begin
                          Email3 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Email + '3' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Email3 + C_RN;
                        end;
                    end;
                    // Пропускаем какие-то данные
                    S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubPkt, 12)) + C_RN;
                  end;
                  S_Log := S_Log + C_MaskPass + C_MaskPass + C_RN;
                end
                else // Пропускаем пустые данные
                  NextData(PktData, MsgLen);
              end;
            $0122: // Получаем суб TLV c Интересами
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                // Если данные не пустые
                if MsgLen > 2 then
                begin
                  SubPkt := NextData(PktData, MsgLen);
                  S_Log := S_Log + C_MaskPass + C_BN + C_IntInfo + C_BN + C_MaskPass + C_RN;
                  // Смотрим в цикле сколько указано интересов
                  for I := 1 to HexToInt(Text2Hex(NextData(SubPkt, 2))) do
                  begin
                    NextData(SubPkt, 4);
                    MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                    case I of
                      1:
                        begin
                          Int1 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          NextData(SubPkt, 4);
                          I1 := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          S_Log := S_Log + C_IntInfo + '1' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Int1 + C_BN + C_QN + IntToStr(I1) + C_EN + C_RN;
                        end;
                      2:
                        begin
                          Int2 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          NextData(SubPkt, 4);
                          I2 := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          S_Log := S_Log + C_IntInfo + '2' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Int2 + C_BN + C_QN + IntToStr(I2) + C_EN + C_RN;
                        end;
                      3:
                        begin
                          Int3 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          NextData(SubPkt, 4);
                          I3 := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          S_Log := S_Log + C_IntInfo + '3' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Int3 + C_BN + C_QN + IntToStr(I3) + C_EN + C_RN;
                        end;
                      4:
                        begin
                          Int4 := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          NextData(SubPkt, 4);
                          I4 := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                          S_Log := S_Log + C_IntInfo + '4' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Int4 + C_BN + C_QN + IntToStr(I4) + C_EN + C_RN;
                        end;
                    end;
                  end;
                  S_Log := S_Log + C_MaskPass + C_MaskPass + C_RN;
                end
                else // Пропускаем пустые данные
                  NextData(PktData, MsgLen);
              end;
            $00C8: // Получаем суб TLV с телефонами
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                // Если данные не пустые
                if MsgLen > 2 then
                begin
                  SubPkt := NextData(PktData, MsgLen);
                  S_Log := S_Log + C_MaskPass + C_BN + C_PhoneInfo + C_BN + C_MaskPass + C_RN;
                  // В цикле смотрим сколько указано телефонов
                  for I := 1 to HexToInt(Text2Hex(NextData(SubPkt, 2))) do
                  begin
                    NextData(SubPkt, 4);
                    MsgLen := HexToInt(Text2Hex(NextData(SubPkt, 2)));
                    case I of
                      1:
                        begin
                          Phone := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Phone + '1' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Phone + C_RN;
                        end;
                      2:
                        begin
                          Fax := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Phone + '2' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Fax + C_RN;
                        end;
                      3:
                        begin
                          Cellular := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Phone + '3' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Cellular + C_RN;
                        end;
                      4:
                        begin
                          WPhone := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Phone + '4' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WPhone + C_RN;
                        end;
                      5:
                        begin
                          WFax := Trim(Utf8ToString(NextData(SubPkt, MsgLen)));
                          S_Log := S_Log + C_Phone + '5' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + WFax + C_RN;
                        end;
                    end;
                    // Пропускаем какие-то данные
                    S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubPkt, 6)) + C_RN;
                  end;
                  S_Log := S_Log + C_MaskPass + C_MaskPass + C_RN;
                end
                else // Пропускаем пустые данные
                  NextData(PktData, MsgLen);
              end;
            $00FA: // Получаем Домашнюю страничку
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                HomePage := Trim(Utf8ToString(NextData(PktData, MsgLen)));
                S_Log := S_Log + C_HomePage + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + HomePage + C_RN;
              end;
            $0046:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Registered' + C_BN + C_Name + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Trim(Utf8ToString(NextData(PktData, MsgLen))) + C_RN;
              end;
            $0055:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Pending' + C_BN + C_Email + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Trim(Utf8ToString(NextData(PktData, MsgLen))) + C_RN;
              end;
            $003C:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Private Key' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $024E:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Validated' + C_BN + 'Mobile' + C_BN + C_Phone + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Trim(Utf8ToString(NextData(PktData, MsgLen))) + C_RN;
              end;
            $0226:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'MyLine' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Trim(Utf8ToString(NextData(PktData, MsgLen))) + C_RN;
              end;
            $021C:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'BetaFlag' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01FE:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Looking For' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01F9:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Privacy Level' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01F4:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Exposure Level' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01EA:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Allow Promotion' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01E0:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Service Flag' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01D6:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Account Type' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01C2:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Local Language' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToStr(HexToInt(Text2Hex(NextData(PktData, MsgLen)))) + C_RN;
              end;
            $01B8:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'HasPhoto' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $01AE:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'PartnerIDs' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Trim(Utf8ToString(NextData(PktData, MsgLen))) + C_RN;
              end;
            $017C:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'TimeZone' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $0136:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Anniversary' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $0124:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Interests Background' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $0123:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Interests Group' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $010E:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Studies' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $0104:
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + 'Education Level' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
              end;
            $0212: // Получаем ВебАваре флаг
              begin
                NextData(PktData, 2);
                if HexToInt(Text2Hex(NextData(PktData, 1))) = $01 then
                  WebAware := True;
                S_Log := S_Log + C_WebAware + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + BoolToStr(WebAware) + C_RN;
              end;
            $019A: // Получаем флаг авторизации
              begin
                NextData(PktData, 3);
                if HexToInt(Text2Hex(NextData(PktData, 1))) = $00 then
                  Auth := True;
                S_Log := S_Log + C_Auth + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + BoolToStr(Auth) + C_RN;
              end;
            $01CC: // Получаем Время последнего изменения инфы
              begin
                MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
                Date64 := HexToInt64(Text2Hex(NextData(PktData, MsgLen)));
                if Date64 > 0 then
                begin
                  SDate64 := SDate64 + (48 * С_Hour);
                  LastUpdateInfo := DateTimeToStr(SDate64);
                  S_Log := S_Log + C_LastChange + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + LastUpdateInfo + C_RN;
                end;
              end
          else
            begin
              // Если пакет содержит другие TLV, то пропускаем их
              MsgLen := HexToInt(Text2Hex(NextData(PktData, 2)));
              S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, MsgLen)) + C_RN;
            end;
          end;
        end;
        // Начинаем обработку данных полученных из пакета с инфой
        // Проверяем делали ли мы запрос на информацию о контакте или это был поиск
        // При поиске контактов запрошенный UIN должен быть пустой
        if ICQ_ReqInfo_UIN <> EmptyStr then
        begin
          // Добавляем ник контакта в список ников
          if Assigned(V_AccountToNick) then
          begin
            // Если ник не пустой и ник не равен UIN
            if (Nick > EmptyStr) and (Nick <> UIN) then
            begin
              // Если такого контакта ещё нет в списке ников, то добавляем его ник
              if SearchNickInCash(C_Icq, UIN) = UIN then
              begin
                V_AccountToNick.Add(C_Icq + C_BN + UrlEncode(UIN) + C_LN + UrlEncode(Nick));
                V_AccountToNick.SaveToFile(V_ProfilePath + C_Nick_BD_FileName, TEncoding.Unicode);
              end;
            end;
          end;
          // Если ник не пустой и ник не равен UIN
          if (Nick > EmptyStr) and (Nick <> UIN) then
          begin
            // Присваиваем этот ник записи в Ростере
            Get_Node := RosterGetItem(C_Icq, C_Contact + C_SS, C_Login, URLEncode(UIN));
            if Get_Node <> nil then
            begin
              if Get_Node.Properties.Value(C_Nick) = URLEncode(UIN) then
              begin
                RosterUpdateProp(Get_Node, C_Nick, URLEncode(Nick));
                // Ищем вкладку в окне чата и ей присваиваем Ник
                if Assigned(ChatForm) then
                begin
                  ChatPage := ReqChatPage(UrlEncode(UIN));
                  if ChatPage <> nil then
                    ChatPage.Caption := Nick;
                end;
                // Ищем этот контакт в КЛ и присваиваем ей ник
                CLContact := ReqCLContact(C_Icq, UrlEncode(UIN));
                if CLContact <> nil then
                  CLContact.Caption := Nick;
              end;
            end;
          end;
          // Сохраняем полученные данные в локальный файл инфы о контакте
          // Инициализируем XML
          JvXML_Create(JvXML);
          try
            with JvXML do
            begin
              // Загружаем файл и инфой о контакте
              if FileExists(V_ProfilePath + C_AnketaFolder + C_Icq + C_BN + UIN + C_XML_Ext) then
                LoadFromFile(V_ProfilePath + C_AnketaFolder + C_Icq + C_BN + UIN + C_XML_Ext);
              if Root <> nil then
              begin
                // Очищаем раздел инфы контакта
                XML_Node := Root.Items.ItemNamed[C_Infos];
                if XML_Node = nil then
                  XML_Node := Root.Items.Add(C_Infos);
                XML_Node.Clear;
                // Записываем имена
                Sub_Node := XML_Node.Items.Add(C_NameInfo);
                Sub_Node.Properties.Add(C_Nick, URLEncode(Nick));
                Sub_Node.Properties.Add(C_First, URLEncode(First));
                Sub_Node.Properties.Add(C_Last, URLEncode(Last));
                // Записываем персональную информацию
                Sub_Node := XML_Node.Items.Add(C_PerInfo);
                Sub_Node.Properties.Add(C_Gender, Gender);
                Sub_Node.Properties.Add(C_Auth, Auth);
                Sub_Node.Properties.Add(C_WebAware, WebAware);
                Sub_Node.Properties.Add(C_HomePage, URLEncode(HomePage));
                Sub_Node.Properties.Add(C_LastChange, LastUpdateInfo);
                // Записываем место проживания
                Sub_Node := XML_Node.Items.Add(C_HomeInfo);
                Sub_Node.Properties.Add(C_Address, URLEncode(Address));
                Sub_Node.Properties.Add(C_City, URLEncode(City));
                Sub_Node.Properties.Add(C_State, URLEncode(State));
                Sub_Node.Properties.Add(C_Zip, URLEncode(Zip));
                Sub_Node.Properties.Add(C_Country, Country);
                // Записываем место рождения
                Sub_Node := XML_Node.Items.Add(C_OHomeInfo);
                Sub_Node.Properties.Add(C_Country, OCountry);
                Sub_Node.Properties.Add(C_City, URLEncode(OCity));
                Sub_Node.Properties.Add(C_State, URLEncode(OState));
                // Записываем языки
                Sub_Node := XML_Node.Items.Add(C_LangInfo);
                Sub_Node.Properties.Add(C_Lang + '1', Lang1);
                Sub_Node.Properties.Add(C_Lang + '2', Lang2);
                Sub_Node.Properties.Add(C_Lang + '3', Lang3);
                // Записываем телефоны
                Sub_Node := XML_Node.Items.Add(C_PhoneInfo);
                Sub_Node.Properties.Add(C_Phone + '1', URLEncode(Phone));
                Sub_Node.Properties.Add(C_Phone + '2', URLEncode(Fax));
                Sub_Node.Properties.Add(C_Phone + '3', URLEncode(Cellular));
                Sub_Node.Properties.Add(C_Phone + '4', URLEncode(WPhone));
                Sub_Node.Properties.Add(C_Phone + '5', URLEncode(WFax));
                // Записываем инфу о работе
                Sub_Node := XML_Node.Items.Add(C_WorkInfo);
                Sub_Node.Properties.Add(C_City, URLEncode(WCity));
                Sub_Node.Properties.Add(C_State, URLEncode(WState));
                Sub_Node.Properties.Add(C_Zip, URLEncode(WZip));
                Sub_Node.Properties.Add(C_Address, URLEncode(WAddress));
                Sub_Node.Properties.Add(C_Corp, URLEncode(Company));
                Sub_Node.Properties.Add(C_Dep, URLEncode(Department));
                Sub_Node.Properties.Add(C_Prof, URLEncode(Position));
                Sub_Node.Properties.Add(C_Site, URLEncode(WSite));
                Sub_Node.Properties.Add(C_Country, WCountry);
                Sub_Node.Properties.Add(C_Occup, Occupation);
                // Записываем идентификаторы интересов
                Sub_Node := XML_Node.Items.Add(C_IntIdInfo);
                Sub_Node.Properties.Add(C_Id + '1', I1);
                Sub_Node.Properties.Add(C_Id + '2', I2);
                Sub_Node.Properties.Add(C_Id + '3', I3);
                Sub_Node.Properties.Add(C_Id + '4', I4);
                // Записываем интересы
                Sub_Node := XML_Node.Items.Add(C_IntInfo);
                Sub_Node.Properties.Add(C_CS + '1', URLEncode(Int1));
                Sub_Node.Properties.Add(C_CS + '2', URLEncode(Int2));
                Sub_Node.Properties.Add(C_CS + '3', URLEncode(Int3));
                Sub_Node.Properties.Add(C_CS + '4', URLEncode(Int4));
                // Записываем "О себе"
                XML_Node.Items.Add(C_AboutInfo, URLEncode(About));
                // Записываем дату рождения
                Sub_Node := XML_Node.Items.Add(C_AgeInfo);
                Sub_Node.Properties.Add(C_Age, Age);
                Sub_Node.Properties.Add(C_Day, IDay);
                Sub_Node.Properties.Add(C_Month, IMonth);
                Sub_Node.Properties.Add(C_Year, IYear);
                // Записываем Email адреса
                Sub_Node := XML_Node.Items.Add(C_EmailsInfo);
                Sub_Node.Properties.Add(C_Email + '0', URLEncode(Email));
                Sub_Node.Properties.Add(C_Email + '1', URLEncode(Email1));
                Sub_Node.Properties.Add(C_Email + '2', URLEncode(Email2));
                Sub_Node.Properties.Add(C_Email + '3', URLEncode(Email3));
                // Записываем доп. параметры
                Sub_Node := XML_Node.Items.Add(C_PersInfo);
                Sub_Node.Properties.Add(C_Marital, Marital);
                Sub_Node.Properties.Add(C_Sexual, Sexual);
                Sub_Node.Properties.Add(C_Height, Height);
                Sub_Node.Properties.Add(C_Relig, Relig);
                Sub_Node.Properties.Add(C_Smok, Smok);
                Sub_Node.Properties.Add(C_Hair, Hair);
                Sub_Node.Properties.Add(C_Children, Children);
              end;
              // Создаём необходимые папки
              ForceDirectories(V_ProfilePath + C_AnketaFolder);
              // Записываем сам файл
              SaveToFile(V_ProfilePath + C_AnketaFolder + C_Icq + C_BN + UIN + C_XML_Ext);
            end;
          finally
            JvXML.Free;
          end;
          // Отображаем в окне информации о контакте полученные данные
          if Assigned(ContactInfoForm) then
          begin
            if ContactInfoForm.ReqUIN = UIN then
              ContactInfoForm.LoadUserUnfo;
          end;
          // Отображаем параметры настройки Авторизации и Вебаваре статуса в настройках ICQ
          if Assigned(IcqOptionsForm) then
          begin
            if UIN = ICQ_LoginUIN then
            begin
              with IcqOptionsForm do
              begin
                // Выстявляем значения приватности из пакета своей инфы
                NoAutoAuthRadioButton.Checked := Auth;
                if not NoAutoAuthRadioButton.Checked then
                  YesAutoAuthRadioButton.Checked := True;
                ShowWebAwareCheckBox.Checked := WebAware;
                // Деактивируем кнопку
                ApplyButton.Enabled := False;
              end;
            end;
          end;
          // Активируем статус Вебаваре если он включён
          if UIN = ICQ_LoginUIN then
          begin
            if WebAware then
              ICQ_WebAware_Enabled := True
            else
              ICQ_WebAware_Enabled := False;
            ICQ_SendPkt('2', ICQ_CreateShortStatusPkt);
          end;
        end
        else
        begin
          // Получаем текст страны из кода
          if Assigned(IcqOptionsForm) then
            ACountry := IcqOptionsForm.CountryInfoComboBox.Items.Values[C_QN + IntToStr(Country) + C_EN];
          // Обрабатываем результаты поиска
          ICQ_NotifyAddSearchResults(UIN, Nick, First, Last, IntToStr(Age), StrArrayToStr([Email, Email1, Email2, Email3]), ACountry, City, Gender, SStatus, Auth, True);
        end;
      end;
  else
    S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + PTLV;
  end;
  // Пишем в лог данные пакета
  if S_Log <> EmptyStr then
    XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[54].Pkt_Name, Trim(S_Log), C_Icq);
end;

{$ENDREGION}
{$REGION 'ICQ_SearchPoText_new'}

procedure ICQ_SearchPoText_new(SText: string; OnlyOn: Boolean);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
  Online: string;
begin
  { 0136-0002-0001 }// Добавочный к пакету TLV "только в сети"
  // Формируем пакет поиска по ключевым словам
  if OnlyOn then
    Online := '013600020001'
  else
    Online := EmptyStr;
  Pkt3 := '017c' + IntToHex(Length(SText), 4) + Text2Hex(SText) + Online;
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05b90fa0000000000000000004e300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'a00f' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000000' + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Обнуляем флаг запроса анкеты контакта
  ICQ_ReqInfo_UIN := EmptyStr;
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SearchPoEmail_new'}

procedure ICQ_SearchPoEmail_new(SEmail: string);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
begin
  // Формируем пакет поиска по Email
  Pkt3 := '0050' + IntToHex(Length(SEmail), 4) + Text2Hex(SEmail);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05b90fa0000000000000000004e300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'a00f' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000000' + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Обнуляем флаг запроса анкеты контакта
  ICQ_ReqInfo_UIN := EmptyStr;
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_SearchPoUIN_new'}

procedure ICQ_SearchPoUIN_new(SUIN: string);
var
  Len1, Len2, Len3: Integer;
  Pkt, Pkt1, Pkt2, Pkt3: string;
begin
  // Делаем поиск контакта по UIN
  Pkt3 := '0032' + IntToHex(Length(SUIN), 4) + Text2Hex(SUIN);
  Len3 := Length(Hex2Text(Pkt3));
  Pkt2 := '05B90FA0000000000000000004E300000002000200000001' + IntToHex(Len3, 4) + Pkt3;
  Len2 := Length(Hex2Text(Pkt2));
  Pkt1 := IntToHex(Swap32(StrToInt(ICQ_LoginUIN)), 8) + 'D007' + IntToHex(Random($AAAA), 4) + 'A00F' + IntToHex(Swap16(Len2), 4) + Pkt2;
  Len1 := Length(Hex2Text(Pkt1));
  Pkt := '00150002000000000000' + '0001' + IntToHex(Len1 + 2, 4) + IntToHex(Swap16(Len1), 4) + Pkt1;
  // Обнуляем флаг запроса анкеты контакта
  ICQ_ReqInfo_UIN := EmptyStr;
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_StatusCode2ImgId'}

function ICQ_StatusCode2ImgId(StatusCode: string): Integer;
var
  ShortStatus: string;
begin
  ShortStatus := RightStr(StatusCode, 4);
  Result := 7;
  if ShortStatus = ICQ_Status_ONLINE then
    Result := 7
  else if ShortStatus = ICQ_Status_AWAY then
    Result := 8
  else if ShortStatus = ICQ_Status_OFFLINE then
    Result := 9
  else if ShortStatus = ICQ_Status_INVISIBLE then
    Result := 10
  else if ShortStatus = ICQ_Status_OCCUPIED then
    Result := 12
  else if ShortStatus = ICQ_Status_OCCUPIED1 then
    Result := 12
  else if ShortStatus = ICQ_Status_DND then
    Result := 13
  else if ShortStatus = ICQ_Status_DND1 then
    Result := 13
  else if ShortStatus = ICQ_Status_DND2 then
    Result := 13
  else if ShortStatus = ICQ_Status_NA then
    Result := 14
  else if ShortStatus = ICQ_Status_NA1 then
    Result := 14
  else if ShortStatus = ICQ_Status_LUNCH then
    Result := 15
  else if ShortStatus = ICQ_Status_FFC then
    Result := 16
  else if ShortStatus = ICQ_Status_DEPRESSION then
    Result := 17
  else if ShortStatus = ICQ_Status_EVIL then
    Result := 18
  else if ShortStatus = ICQ_Status_ATHOME then
    Result := 19
  else if ShortStatus = ICQ_Status_ATWORK then
    Result := 20
  else if ShortStatus = ICQ_Status_UNK then
    Result := 214;
end;

{$ENDREGION}
{$REGION 'ICQ_SendMessage_0406'}

procedure ICQ_SendMessage_0406(SUIN, SMsg: string; InUnicode: Boolean);
const
  Cap1 = '{0946134E-4C7F-11D1-8222-444553540000}';
var
  Len1, Len2: Integer;
  Pkt, Pkt1, Pkt2: RawByteString;
  OrigMsg: string;
  CoocId: RawByteString;
  CoocId1: RawByteString;
  UnicodeMess: string;
  Utf8Mess: Utf8String;
begin
  // Запоминаем текст сообщения
  OrigMsg := SMsg;
  // Отправляем сообщение кусками (ограничения протокола)
  while Length(OrigMsg) > 0 do
  begin
    if InUnicode then
      UnicodeMess := NextData(OrigMsg, 1200)
    else
      Utf8Mess := UTF8Encode(NextData(OrigMsg, 3000));
    Randomize;
    CoocId := IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4) + IntToHex(Random($AAAA), 4);
    CoocId1 := IntToHex(Random($AAAA), 4);
    // Старый формат сообщений (псевдо юникод кодировка)
    if InUnicode then
    begin
      Pkt := '00040006000000000006' + CoocId + '0001' + IntToHex(Length(SUIN), 2) + Text2Hex(SUIN) + '0002' + IntToHex(((Length(UnicodeMess) * SizeOf(Char)) + 14), 4)
        + '0501000201060101' + IntToHex(((Length(UnicodeMess) * SizeOf(Char)) + 4), 4) + '00020000' + Text2UnicodeBEHex(UnicodeMess) + '00060000';
    end
    else
    begin
      // Новый формат сообщений (UTF-8 кодировка)
      Pkt2 := '1b000a000000000000000000000000000000000000000300000000' + CoocId1 + '0e00' + CoocId1 + '00000000000000000000000001000000' + '0400' + IntToHex(Swap16((Length(Utf8Mess) + 1)), 4)
        + Text2Hex(Utf8Mess) + '0000000000ffffff0026000000' + Text2Hex(Cap1);
      Len2 := Length(Hex2Text(Pkt2));
      Pkt1 := '0000' + CoocId + ICQ_Servises_Caps[19].Cap_HEX + '000a00020001' + '000f0000' + '2711' + IntToHex(Len2, 4) + Pkt2;
      Len1 := Length(Hex2Text(Pkt1));
      Pkt := '00040006000000000006' + CoocId + '0002' + IntToHex(Length(SUIN), 2) + Text2Hex(SUIN) + '0005' + IntToHex(Len1, 4) + Pkt1 + '00030000';
    end;
    // Отправляем пакет
    ICQ_SendPkt('2', Pkt);
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_ReqMsgNotify'}

procedure ICQ_ReqMsgNotify(UIN, Msg, Status, UserClass, IntIP, IntPort, ExtIP, TimeReg, IconHash, ConnTime: string; GTrans: Boolean = False);
label
  X;
var
  Nick, Mess, MsgD, PopMsg, HistoryFile: string;
  GtransMsg: Boolean;
  JvXML: TJvSimpleXml;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Contact_Yes: Boolean;
  I: Integer;
begin
  GtransMsg := False;
  // Если сообщение пустое, то выходим
  if Msg = EmptyStr then
    Exit;
  // Если окно сообщений не было создано, то создаём его
  if not Assigned(ChatForm) then
    Application.CreateForm(TChatForm, ChatForm);
  // Обрабатываем сообщение на наличие формата HTML
  if Copy(Msg, 1, 6) = '<HTML>' then
    ChatForm.CheckMessage_ClearTag(Msg);
  // Окончательно обрабатываем сообщение
  Mess := Text2XML(Msg);
  CheckMessage_BR(Mess);
  ChatForm.CheckMessage_ClearTag(Mess);
  // Если это сообщение с переводом, то переходим дальше
  if GTrans then
    goto X;
  // Если для этого контакта активна функция перевода, то отправляем сообщение в список буфера для автоматического перевода
  JvXML_Create(JvXML);
  try
    with JvXML do
    begin
      if FileExists(V_ProfilePath + C_AnketaFolder + C_Icq + C_BN + UIN + C_XML_Ext) then
      begin
        LoadFromFile(V_ProfilePath + C_AnketaFolder + C_Icq + C_BN + UIN + C_XML_Ext);
        if Root <> nil then
        begin
          XML_Node := Root.Items.ItemNamed[C_Gtrans];
          if XML_Node <> nil then
            GtransMsg := XML_Node.BoolValue;
        end;
      end;
    end;
  finally
    JvXML.Free;
  end;
  if GtransMsg then
  begin
    if not Assigned(GTransForm) then
      Application.CreateForm(TGTransForm, GTransForm);
    with GTransForm.GtransListView.Items.Add do
    begin
      // Изменяем направление перевода для исходящих и входящих сообщений
      ImageIndex := 167;
      SubItems.Add(UIN);
      SubItems.Add(Mess);
      SubItems.Add(C_Icq);
    end;
    // Выходим
    Exit;
  end;
  // Обрабатываем сообщение
  X: ;
  PopMsg := Mess;
  // Ищем этот контакт в Ростере
  Contact_Yes := False;
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Ищем раздел MRA
        XML_Node := Root.Items.ItemNamed[C_Icq];
        if XML_Node <> nil then
        begin
          // Ищем раздел контактов
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
          if Sub_Node <> nil then
          begin
            for I := 0 to Sub_Node.Items.Count - 1 do
            begin
              Tri_Node := Sub_Node.Items.Item[i];
              if Tri_Node <> nil then
              begin
                // Если нашли этот контакт
                if Tri_Node.Properties.Value(C_Login) = UrlEncode(UIN) then
                begin
                  Contact_Yes := True;
                  // Записываем входяшее сообщение
                  RosterUpdateProp(Tri_Node, C_InMess, UrlEncode(Mess));
                  // Ник контакта из Ростера
                  Nick := URLDecode(Tri_Node.Properties.Value(C_Nick));
                  // Дата сообщения
                  MsgD := Nick + C_BN + C_QN + DateTimeChatMess + C_EN;
                  // Ставим метку о непрочитанном сообщении
                  RosterUpdateProp(Tri_Node, C_Mess, C_XX);
                  // Прерываем цикл
                  Break;
                end;
              end;
            end;
            // Если контакт в Ростере не нашли
            if not Contact_Yes then
            begin
              // Ищем его Ник в файле-кэше ников
              Nick := SearchNickInCash(C_Icq, UIN);
              // Дата сообщения
              MsgD := Nick + C_BN + C_QN + DateTimeChatMess + C_EN;
              // Добавляем этот контакт в эту группу
              Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
              Tri_Node.Properties.Add(C_Login, URLEncode(UIN));
              Tri_Node.Properties.Add(C_Group + C_Id, C_NoCL);
              Tri_Node.Properties.Add(C_Status, 214);
              Tri_Node.Properties.Add(C_Nick, URLEncode(Nick));
              Tri_Node.Properties.Add(C_InMess, UrlEncode(Mess));
              Tri_Node.Properties.Add(C_Mess, C_XX);
              // Запрашиваем анкету неопознанных контактов
              if Nick = UIN then
                if ICQ_Work_Phaze then
                  ICQ_ReqInfo_New_Pkt(UIN);
            end;
          end;
        end;
      end;
    end;
  end;
  // Записываем история в файл истории с этим контактов
  HistoryFile := V_ProfilePath + C_HistoryFolder + C_Icq + C_BN + ICQ_LoginUIN + C_BN + UIN + C_Htm_Ext;
  Mess := Text2XML(Mess);
  CheckMessage_BR(Mess);
  DecorateURL(Mess);
  SaveTextInHistory(Format(C_HistoryIn, [MsgD, Mess]), HistoryFile);
  // Добавляем сообщение в текущий чат
  if not ChatForm.AddMessInActiveChat(Nick, PopMsg, UrlEncode(UIN), MsgD, Mess) then
    UpdateFullCL;
end;

{$ENDREGION}
{$REGION 'ICQ_ReqMessage_0407'}

procedure ICQ_ReqMessage_0407(PktData: string);
label
  X,
    Y,
    Z,
    E;
var
  UIN, Msg, UserClass, Status, TimeReg, IconHash, ConnTime: string;
  SubData, ExtIP, IntPort, IntIP, Desc, URL, TLV: string;
  I, Count, MsgLen: Integer;
  Len, ULen, CharsetNumber: Word;
  FSize: LongWord;
  MsgType: Word;
  S_Log: string;
begin
  // Пропускаем раздел куков
  NextData(PktData, 8);
  // Начинаем разбор входящего сообщения
  TLV := Text2Hex(NextData(PktData, 2));
  case HexToInt(TLV) of
    $0001:
      begin
        Len := HexToInt(Text2Hex(NextData(PktData, 1)));
        UIN := NextData(PktData, Len);
        S_Log := S_Log + C_MsgCannel + C_TN + C_BN + TLV + C_RN;
        S_Log := S_Log + C_Login + C_TN + C_BN + UIN + C_RN;
        NextData(PktData, 2); // Пропускаем что-то
        Count := HexToInt(Text2Hex(NextData(PktData, 2))); // Узнаём количество TLV в пакете
        if Count < 1 then
          goto X;
        for I := 0 to Count - 1 do
        begin
          TLV := Text2Hex(NextData(PktData, 2));
          case HexToInt(TLV) of
            $0001: // Класс контакта (вдруг админ постучит)
              begin
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                UserClass := Text2Hex(NextData(PktData, Len));
                S_Log := S_Log + C_UserClass + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + UserClass + C_RN;
              end;
            $0006: // Статус
              begin
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                Status := Text2Hex(NextData(PktData, Len));
                S_Log := S_Log + C_Status + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Status + C_RN;
              end;
            $0005: // Дата регистраций UIN
              begin
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
                S_Log := S_Log + C_RegDate + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + TimeReg + C_RN;
              end;
            $001D: // Аватар хэш и другие доп. статусы
              begin
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                IconHash := NextData(PktData, Len);
                S_Log := S_Log + C_AvatarHash + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(IconHash) + C_RN;
              end;
            $000F: // Время в сети
              begin
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + C_TimeOnline + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
              end;
            $0003: // Время подключения
              begin
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
                S_Log := S_Log + C_SignonTime + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ConnTime + C_RN;
              end
          else
            begin
              // Если есть другие TLV, то пропускаем их
              Len := HexToInt(Text2Hex(NextData(PktData, 2)));
              S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
            end;
          end;
        end;
        X: ;
        while Length(PktData) > 0 do
        begin
          // Флаги кодировок
          { 0000: US-ASCII
            0001: Plain
            0002: UCS-2BE
            0003: local 8bit encoding, iso-8859-1, cp-1257, cp-1251 }
          TLV := Text2Hex(NextData(PktData, 2));
          case HexToInt(TLV) of
            $0002:
              begin
                NextData(PktData, 4); // TLV length + Unknown const
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                NextData(PktData, Len); // Counts of following bytes + following bytes
                NextData(PktData, 2); // x0101, Unknown, constant
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                ULen := Len - 4; // Length of the message + 4
                CharsetNumber := HexToInt(Text2Hex(NextData(PktData, 2))); // The encoding used for the message
                // CharsetSubset := HexToInt(Text2Hex(NextData(PktData, 2))); //Unknown; seen: 0x0000 = 0, 0xffff = -1
                NextData(PktData, 2);
                Msg := NextData(PktData, ULen);
                if Msg <> EmptyStr then
                begin
                  if CharsetNumber = $0002 then
                    Msg := UnicodeBEHex2Text(Text2Hex(Msg))
                  else if (CharsetNumber = $0000) or (CharsetNumber = $0001) or (CharsetNumber = $0003) then // Изза ошибок в кодировке QIP 2005
                  begin
                    if IsValidUnicode(Msg, False) then
                      Msg := UnicodeBEHex2Text(Text2Hex(Msg));
                  end;
                end;
                S_Log := S_Log + C_InMess + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Msg + C_RN;
              end
          else
            begin
              // Если есть другие TLV, то пропускаем их
              Len := HexToInt(Text2Hex(NextData(PktData, 2)));
              S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
            end;
          end;
        end;
      end;
    $0002, $0005, $0006:
      begin
        Len := HexToInt(Text2Hex(NextData(PktData, 1)));
        UIN := NextData(PktData, Len);
        S_Log := S_Log + C_MsgCannel + C_TN + C_BN + TLV + C_RN;
        S_Log := S_Log + C_Login + C_TN + C_BN + UIN + C_RN;
        NextData(PktData, 2); // Пропускаем что-то
        Count := HexToInt(Text2Hex(NextData(PktData, 2))); // Узнаём количество TLV в пакете
        if Count < 1 then
          goto Y;
        for I := 0 to Count - 1 do
        begin
          TLV := Text2Hex(NextData(PktData, 2));
          case HexToInt(TLV) of
            $0001:
              begin // Класс контакта (вдруг админ постучит)
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                UserClass := Text2Hex(NextData(PktData, Len));
                S_Log := S_Log + C_UserClass + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + UserClass + C_RN;
              end;
            $0006:
              begin // Статус
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                Status := Text2Hex(NextData(PktData, Len));
                S_Log := S_Log + C_Status + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Status + C_RN;
              end;
            $0005:
              begin // Дата регистраций UIN
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
                S_Log := S_Log + C_RegDate + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + TimeReg + C_RN;
              end;
            $001D:
              begin // Аватар хэш и другие доп. статусы
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                IconHash := NextData(PktData, Len);
                S_Log := S_Log + C_AvatarHash + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(IconHash) + C_RN;
              end;
            $000F:
              begin // Время в сети
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + C_TimeOnline + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
              end;
            $0003:
              begin // Время подключения
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
                S_Log := S_Log + C_SignonTime + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ConnTime + C_RN;
              end
          else
            begin
              // Если есть другие TLV, то пропускаем их
              Len := HexToInt(Text2Hex(NextData(PktData, 2)));
              S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
            end;
          end;
        end;
        Y: ;
        while Length(PktData) > 0 do
        begin
          case HexToInt(Text2Hex(NextData(PktData, 2))) of
            $0005:
              begin
                FSize := HexToInt(Text2Hex(NextData(PktData, 2)));
                if HexToInt(Text2Hex(NextData(PktData, 2))) <> 0 then
                begin
                  NextData(PktData, (FSize) - 2);
                  Continue;
                end;
                NextData(PktData, 8 + 16); // Пропускаем msg-id cookie и capability
                while Length(PktData) > 0 do
                begin
                  TLV := Text2Hex(NextData(PktData, 2));
                  case HexToInt(TLV) of
                    $0003:
                      begin // Внутренний IP
                        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                        IntIP := NumToIp(Swap32(HexToInt(Text2Hex(NextData(PktData, Len)))));
                      end;
                    $0004:
                      begin // Внешний IP
                        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                        ExtIP := NumToIp(Swap32(HexToInt(Text2Hex(NextData(PktData, Len)))));
                        S_Log := S_Log + C_ExtIP + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ExtIP + C_RN;
                      end;
                    $0005:
                      begin // Внутренний порт
                        IntPort := IntToStr(HexToInt(Text2Hex(NextData(PktData, 4))));
                        S_Log := S_Log + C_IntIP + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntIP + C_TN + IntPort + C_RN;
                      end;
                    $2711:
                      begin // Сообщение
                        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                        SubData := NextData(PktData, Len);
                        // If this value is not present, this is not a message packet.
                        // Also, ICQ2001b does not send an ACK, SNAC(4,B), if this is not 0x1B.
                        if NextData(SubData, 1) <> #$1B then
                          goto E;
                        NextData(SubData, 26 + 6 + 12); // 1B - 1 Len + FFSeq + Unknown
                        MsgType := HexToInt(Text2Hex((NextData(SubData, 1))));
                        S_Log := S_Log + C_Mess + C_Type + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToHex(MsgType, 1) + C_RN;
                        NextData(SubData, 1 + 2 + 2); // MsgFlag + status code + priority code
                        if MsgType = M_FILE then // File request
                        begin
                          goto E;
                        end
                        else if MsgType = M_CONTACTS then // Contact list message
                        begin
                          goto E;
                        end
                        else if MsgType = M_ADVANCED then
                        begin
                          goto E;
                        end
                        else
                        begin
                          MsgLen := Swap16(HexToInt(Text2Hex(NextData(SubData, 2))));
                          Dec(MsgLen);
                          // Получаем сообщение
                          Msg := NextData(SubData, MsgLen);
                          if IsUtf8Valid(Msg) then // Изза ошибок в кодировке QIP 2005
                            Msg := UTF8ToString(Msg);
                          S_Log := S_Log + C_InMess + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Msg + C_RN;
                          if Msg <> EmptyStr then
                          begin
                            if MsgType = M_URL then
                            begin
                              Desc := Copy(Msg, 0, Pos(#$FE, Msg) - 1);
                              URL := Copy(Msg, Pos(#$FE, Msg) + 1, Length(Msg) - Pos(#$FE, Msg));
                              Msg := URL + C_RN + Desc;
                            end;
                          end;
                        end;
                      end
                  else
                    begin
                      // Если есть другие TLV, то пропускаем их
                      Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                      S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
                    end;
                  end;
                end;
              end
          else
            begin
              // Если есть другие TLV, то пропускаем их
              Len := HexToInt(Text2Hex(NextData(PktData, 2)));
              S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
            end;
          end;
        end;
      end;
    $0004:
      begin
        Len := HexToInt(Text2Hex(NextData(PktData, 1)));
        UIN := NextData(PktData, Len);
        S_Log := S_Log + C_MsgCannel + C_TN + C_BN + TLV + C_RN;
        S_Log := S_Log + C_Login + C_TN + C_BN + UIN + C_RN;
        NextData(PktData, 2); // Пропускаем что-то
        Count := HexToInt(Text2Hex(NextData(PktData, 2))); // Узнаём количество TLV в пакете
        if Count < 1 then
          goto Z;
        for I := 0 to Count - 1 do
        begin
          TLV := Text2Hex(NextData(PktData, 2));
          case HexToInt(TLV) of
            $0001:
              begin // Класс контакта (вдруг админ постучит)
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                UserClass := Text2Hex(NextData(PktData, Len));
                S_Log := S_Log + C_UserClass + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + UserClass + C_RN;
              end;
            $0006:
              begin // Статус
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                Status := Text2Hex(NextData(PktData, Len));
                S_Log := S_Log + C_Status + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Status + C_RN;
              end;
            $0005:
              begin // Дата регистраций UIN
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
                S_Log := S_Log + C_RegDate + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + TimeReg + C_RN;
              end;
            $001D:
              begin // Аватар хэш и другие доп. статусы
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                IconHash := NextData(PktData, Len);
                S_Log := S_Log + C_AvatarHash + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(IconHash) + C_RN;
              end;
            $000F:
              begin // Время в сети
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                S_Log := S_Log + C_TimeOnline + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
              end;
            $0003:
              begin // Время подключения
                Len := HexToInt(Text2Hex(NextData(PktData, 2)));
                ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
                S_Log := S_Log + C_SignonTime + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ConnTime + C_RN;
              end
          else
            begin
              // Если есть другие TLV, то пропускаем их
              Len := HexToInt(Text2Hex(NextData(PktData, 2)));
              S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
            end;
          end;
        end;
        Z: ;
        if HexToInt(Text2Hex(NextData(PktData, 2))) = $0005 then
        begin
          NextData(PktData, 2);
          NextData(PktData, 4); // UIN
          MsgType := HexToInt(Text2Hex(NextData(PktData, 1)));
          S_Log := S_Log + C_Mess + C_Type + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntToHex(MsgType, 1) + C_RN;
          NextData(PktData, 1); // MsgFlag
          MsgLen := Swap16(HexToInt(Text2Hex(NextData(PktData, 2))));
          Dec(MsgLen);
          Msg := NextData(PktData, MsgLen);
          if IsUtf8Valid(Msg) then // Изза ошибок в кодировке QIP 2005
            Msg := UTF8ToString(Msg);
          S_Log := S_Log + C_InMess + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Msg + C_RN;
          if Msg <> EmptyStr then
          begin
            if MsgType = M_URL then
            begin
              Desc := Copy(Msg, 0, Pos(#$FE, Msg) - 1);
              URL := Copy(Msg, Pos(#$FE, Msg) + 1, Length(Msg) - Pos(#$FE, Msg));
              Msg := URL + C_RN + Desc;
            end
            else if MsgType = M_WEB_PAGE then
            begin
              goto E;
            end;
          end;
        end;
      end
  else
    begin
      S_Log := S_Log + Log_Unk_Data + C_RN + Trim(Dump(PktData)) + C_RN;
      goto E;
    end;
  end;
  // Передаём полученные данные для события входящего сообщения
  ICQ_ReqMsgNotify(UIN, Msg, Status, UserClass, IntIP, IntPort, ExtIP, TimeReg, IconHash, ConnTime);
  E: ;
  // Пишем данные пакета в лог
  XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[36].Pkt_Name, Trim(S_Log), C_Icq);
end;

{$ENDREGION}
{$REGION 'ICQ_UserOnline_Event'}

procedure ICQ_UserOnline_Event(UIN, Status, UserClass, IntIP, IntPort, ExtIP, ConnFlag, ProtoVer, TimeReg, CapsId, Caps, IconHash, ConnTime: string);
var
  I, StatusIcoInd, IXStat, IClient: Integer;
  BartID, BartLength, BartSubLen: Integer;
  //Utf8Sup: Boolean;
  IHash, IXText, PClient, IXStatNew, S_Log: string;
  Get_Node: TJvSimpleXmlElem;
begin
  // Получаем номер иконки из статуса
  StatusIcoInd := ICQ_StatusCode2ImgId(Status);
  // Доп. статус и клиент по умолчанию
  IXStat := -1;
  IClient := -1;
  // Разбираем субпакет с хэш аватары и доп. статусами
  while Length(IconHash) > 0 do
  begin
    // Получаем идентификатор Bart_ID
    BartID := HexToInt(Text2Hex(NextData(IconHash, 2)));
    // Проверяем флаг
    if BartID <> 15 then
      NextData(IconHash, 1);
    // Получаем длинну барт данных
    BartLength := HexToInt(Text2Hex(NextData(IconHash, 1)));
    // Если длинна барт данных больше нуля, то сканируем на нужные нам TLV
    if BartLength <> 0 then
    begin
      case BartID of
        BUDDY_ICON: IHash := NextData(IconHash, BartLength); // Хэш-аватара
        STATUS_MOOD: // Название x-статуса (картинка)
          begin
            IXStatNew := NextData(IconHash, BartLength);
            S_Log := S_Log + C_XX + C_Status + C_TN + C_BN + IXStatNew + C_RN;
            // Преобразуем новый тип доп. статуса в номер иконки
            for I := Low(ICQ_XStatus_Codes) to High(ICQ_XStatus_Codes) do
            begin
              if ICQ_XStatus_Codes[I].XStatus_Code = IXStatNew then
              begin
                IXStat := ICQ_XStatus_Codes[I].XStatus_Icon + 44;
                S_Log := S_Log + C_XX + C_Status + C_TN + C_BN + ICQ_XStatus_Codes[I].XStatus_Code + C_RN;
                Break;
              end;
            end;
          end;
        STATUS_STR: // Текст x-статуса
          begin
            BartSubLen := HexToInt(Text2Hex(NextData(IconHash, 2)));
            IXText := Utf8ToString(NextData(IconHash, BartSubLen));
            S_Log := S_Log + C_XX + C_Mess + C_TN + C_BN + IXText + C_RN;
            if BartLength - BartSubLen > 0 then
              NextData(IconHash, BartLength - BartSubLen); // Тупые байты
          end;
      else
        S_Log := S_Log + 'Bart' + C_Unk + C_TN + C_BN + Text2Hex(NextData(IconHash, BartLength)) + C_RN;
      end;
    end;
  end;
  // Ищем доп. статус в капабилитисах (старый способ передачи доп. статусов)
  if IXStat = -1 then
  begin
    for I := Low(ICQ_XStatus_Codes) to High(ICQ_XStatus_Codes) do
    begin
      if Pos(ICQ_XStatus_Codes[I].XStatus_Caps, Caps) > 0 then
      begin
        IXStat := ICQ_XStatus_Codes[I].XStatus_Icon + 44;
        S_Log := S_Log + C_XX + C_Status + C_TN + C_BN + ICQ_XStatus_Codes[I].XStatus_Code + C_RN;
        Break;
      end;
    end;
  end;
  // Ищем идентификаторы клиентов в капабилитисах
  PClient := EmptyStr;
  for I := Low(ICQ_Clients_Caps) to High(ICQ_Clients_Caps) do
  begin
    if Pos(ICQ_Clients_Caps[I].Cap_HEX, Caps) > 0 then
    begin
      PClient := ICQ_Clients_Caps[I].Client_Name;
      IClient := ICQ_Clients_Caps[I].Client_Icon;
      S_Log := S_Log + C_Client + C_TN + C_BN + ICQ_Clients_Caps[I].Client_Name + C_RN;
      Break;
    end;
  end;
  // Ищем поддержку UTF-8 сообщений
  {if ((Pos(ICQ_Servises_Caps[23].Cap_HEX, Caps) > 0) or (Pos('134E', CapsId) > 0)) and (ProtoVer <> '0') then
    Utf8Sup := True
  else
    Utf8Sup := False;}
  // Обновляем отображение контакта в Ростере
  Get_Node := RosterGetItem(C_Icq, C_Contact + C_SS, C_Login, URLEncode(UIN));
  if Get_Node <> nil then
  begin
    RosterUpdateProp(Get_Node, C_Status, IntToStr(StatusIcoInd));
    RosterUpdateProp(Get_Node, C_XStatus + C_Name, URLEncode(IXStatNew));
    RosterUpdateProp(Get_Node, C_XStatus, IntToStr(IXStat));
    RosterUpdateProp(Get_Node, C_XText, URLEncode(IXText));
    RosterUpdateProp(Get_Node, C_Client + C_Name, PClient);
    RosterUpdateProp(Get_Node, C_Client, IntToStr(IClient));
  end;
  // Запускаем таймер задержку событий Ростера
  MainForm.JvTimerList.Events[11].Enabled := False;
  MainForm.JvTimerList.Events[11].Enabled := True;
  // Пишем в лог
  if S_Log <> EmptyStr then
    XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[37].Pkt_Name, Trim(S_Log), C_Icq);
end;

{$ENDREGION}
{$REGION 'ICQ_UserUnkStatus_030A'}

procedure ICQ_UserUnkStatus_030A(PktData: string);
var
  UIN: string;
  Len: Integer;
begin
  // Получаем длинну UIN
  Len := HexToInt(Text2Hex(NextData(PktData, 1)));
  UIN := NextData(PktData, Len);
  // Запускаем событие контакт онлайн с неизвестным статусом номер иконки 214
  ICQ_UserOnline_Event(UIN, '88888888', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr);
end;

{$ENDREGION}
{$REGION 'ICQ_UserOnline_030B'}

procedure ICQ_UserOnline_030B(PktData: string; CheckStatus: Boolean);
label
  X;
var
  UIN, IconHash, UserClass, TimeReg, ConnTime, Status: string;
  Cap, CapsId, Caps, IntPort, ProtoVer, IntIP, ExtIP, ConnFlag: string;
  Count, I, V: Word;
  Len: Integer;
  TLV, DCInfo, S, S_Log: string;
begin
  // Назначаем по умолчанию дефолтный статус
  Status := 'FFFFFFFF';
  // Получаем длинну UIN
  Len := HexToInt(Text2Hex(NextData(PktData, 1)));
  // Получаем UIN чей статус нам прислал сервак
  UIN := NextData(PktData, Len);
  S_Log := S_Log + C_Login + C_TN + C_BN + UIN + C_RN;
  // Пропускаем варнинглэвел (в icq всегда равен нулю)
  NextData(PktData, 2);
  // Получаем количество вложенных в пакет TLV
  Count := HexToInt(Text2Hex(NextData(PktData, 2)));
  // Если ноль TLV, то прыгаем в конец процедуры
  if Count < 1 then
    goto X;
  // Сканируем TLV в цикле
  for I := 0 to Count - 1 do
  begin
    TLV := Text2Hex(NextData(PktData, 2));
    case HexToInt(TLV) of
      $0001: // Класс контакта (вдруг админ постучит)
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          UserClass := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + C_UserClass + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + UserClass + C_RN;
        end;
      $000C: // DC информация
        begin
          // Узнаём длинну пакета с DC информацией
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          DCInfo := NextData(PktData, Len);
          // Внутрений IP адрес и порт
          IntIP := NumToIp(Swap32(HexToInt(Text2Hex(NextData(DCInfo, 4)))));
          IntPort := IntToStr(HexToInt(Text2Hex(NextData(DCInfo, 4))));
          S_Log := S_Log + C_IntIP + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + IntIP + C_TN + IntPort + C_RN;
          // Флаг подключения и версия протокола
          ConnFlag := Text2Hex(NextData(DCInfo, 1)); // Флаг подключения
          S_Log := S_Log + 'ConnFlag' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ConnFlag + C_RN;
          ProtoVer := IntToStr(HexToInt(Text2Hex(NextData(DCInfo, 2))));
          S_Log := S_Log + 'ProtoVer' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ProtoVer + C_RN;
          // Дополнительные поля для как правило для нужд программистов
          S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(DCInfo, 4)) + C_RN;
          S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(DCInfo, 8)) + C_RN;
          S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(DCInfo, 4)) + C_RN;
          S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(DCInfo, 4)) + C_RN;
          S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(DCInfo, 6)) + C_RN;
        end;
      $000A: // Внешний IP адрес
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          ExtIP := NumToIp(Swap32(HexToInt(Text2Hex(NextData(PktData, Len)))));
          S_Log := S_Log + C_ExtIP + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ExtIP + C_RN;
        end;
      $0006: // Статус
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          Status := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + C_Status + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Status + C_RN;
        end;
      $0005: // Дата регистраций UIN
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          TimeReg := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
          S_Log := S_Log + C_RegDate + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + TimeReg + C_RN;
        end;
      $0019: // Укороченные капабилитисы
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          CapsId := Text2Hex(NextData(PktData, Len));
          S := EmptyStr;
          while Length(CapsId) > 0 do
          begin
            Cap := NextData(CapsId, 4);
            if Assigned(LogForm) then
            begin
              if LogForm.ICQDumpSpeedButton.Down then
              begin
                // Ищем названия капов характеристик
                for V := Low(ICQ_Servises_Caps) to High(ICQ_Servises_Caps) do
                begin
                  if (ICQ_Servises_Caps[V].Cap_HEX[5] + ICQ_Servises_Caps[V].Cap_HEX[6] + ICQ_Servises_Caps[V].Cap_HEX[7] + ICQ_Servises_Caps[V].Cap_HEX[8]) = Cap then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_Servises_Caps[V].Cap_Name + C_EN;
                    Break;
                  end;
                end;
              end;
            end;
            S := S + Cap + C_BN + C_PN + C_BN;
          end;
          CapsId := S;
          S_Log := S_Log + C_Caps + C_Id + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + CapsId + C_RN;
        end;
      $000D: // Полные капабилитисы
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          Caps := Text2Hex(NextData(PktData, Len));
          S := EmptyStr;
          while Length(Caps) > 0 do
          begin
            Cap := NextData(Caps, 32);
            if Assigned(LogForm) then
            begin
              if LogForm.ICQDumpSpeedButton.Down then
              begin
                // Ищем названия капов характеристик
                for V := Low(ICQ_Servises_Caps) to High(ICQ_Servises_Caps) do
                begin
                  if ICQ_Servises_Caps[V].Cap_HEX = Cap then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_Servises_Caps[V].Cap_Name + C_EN;
                    Break;
                  end;
                end;
                // Ищем названия капов Xстатусов
                for V := Low(ICQ_XStatus_Codes) to High(ICQ_XStatus_Codes) do
                begin
                  if ICQ_XStatus_Codes[V].XStatus_Caps = Cap then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_XStatus_Codes[V].XStatus_Code + C_EN;
                    Break;
                  end;
                end;
                // Ищем названия капов клиентов
                for V := Low(ICQ_Clients_Caps) to High(ICQ_Clients_Caps) do
                begin
                  if Pos(ICQ_Clients_Caps[V].Cap_HEX, Cap) > 0 then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_Clients_Caps[V].Client_Name + C_EN;
                    Break;
                  end;
                end;
              end;
            end;
            S := S + Cap + C_BN + C_PN + C_BN;
          end;
          Caps := S;
          S_Log := S_Log + C_Caps + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Caps + C_RN;
        end;
      $001D: // Аватар хэш и другие доп. статусы
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          IconHash := NextData(PktData, Len);
          S_Log := S_Log + C_AvatarHash + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(IconHash) + C_RN;
        end;
      $000F: // Время в сети
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S_Log := S_Log + C_TimeOnline + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
        end;
      $0003: // Время подключения
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          ConnTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
          S_Log := S_Log + C_SignonTime + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ConnTime + C_RN;
        end
    else
      begin
        // Если есть другие TLV, то пропускаем их
        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
        S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
      end;
    end;
  end;
  X: ;
  // Пишем данные пакета в лог
  XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[37].Pkt_Name, Trim(S_Log), C_Icq);
  // Если это была проверка статуса то выводим сообщение
  if CheckStatus then
  begin
    {if Status <> 'FFFFFFFF' then
      ICQ_NotifyUserStatus(UIN, ICQ_StatusCode2String(Status), ICQ_ClientCap2String(Caps), 0)
    else
      ICQ_NotifyUserStatus(UIN, ICQ_StatusCode2String(Status), EmptyStr, 2);}
  end
  else
  begin
    // Передаём полученные данные другой процедуре для их финальной обработки
    ICQ_UserOnline_Event(UIN, Status, UserClass, IntIP, IntPort, ExtIP, ConnFlag, ProtoVer, TimeReg, CapsId, Caps, IconHash, ConnTime);
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_UserOffline_030C'}

procedure ICQ_UserOffline_030C(PktData: string);
var
  UIN: string;
  Len: Integer;
begin
  // Получаем длинну UIN
  Len := HexToInt(Text2Hex(NextData(PktData, 1)));
  UIN := NextData(PktData, Len);
  //XLog(C_Icq + Log_Get + Log_User_Offline_Event + UIN, C_Icq);
  // Ещё есть данные для расшифровки

  // Запускаем событие контакт онлайн со статусом оффлайн номер иконки 9
  ICQ_UserOnline_Event(UIN, 'FFFFFFFF', EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr, EmptyStr);
end;

{$ENDREGION}
{$REGION 'ICQ_CliClientReadyPkt'}

function ICQ_CliClientReadyPkt: string;
var
  Pkt: string;
begin
  Pkt := '00010002000000000002' // Pkt Head
  + '002200010110164F' // Unknown Family (0x22)
  + '000100040110164F' // AIM Generic (0x1)
  + '001300040110164F' // AIM SSI (0x13)
  + '000200010110164F' // AIM Location (0x2)
  + '000300010110164F' // AIM Buddylist (0x3)
  + '001500010110164F' // AIM ICQ (0x15)
  + '000400010110164F' // AIM Messaging (0x4)
  + '000600010110164F' // AIM Invitation (0x6)
  + '000900010110164F' // AIM BOS (0x9)
  + '000A00010110164F' // AIM User Lookup (0xa)
  + '000B00010110164F'; // AIM Stats (0xb)
  Result := Pkt;
end;

{$ENDREGION}
{$REGION 'ICQ_StatusImgId2Code'}

function ICQ_StatusImgId2Code(ImgId: Integer): string;
var
  Xxxx, Ffff: string;
begin
  // Назначаем первую половину статуса (четыре первых символа)
  Xxxx := '1000';
  Ffff := 'FFFF';
  // Формируем флаги для первой половины статуса
  if ICQ_WebAware_Enabled then
    Xxxx := '1001';
  if ICQ_BirthDay_Enabled then
    Xxxx := '1008';
  if (ICQ_WebAware_Enabled) and (ICQ_BirthDay_Enabled) then
    Xxxx := '1009';
  // Формируем флаги для второй половины статуса
  case ImgId of
    7: Result := Xxxx + ICQ_Status_ONLINE;
    8: Result := Xxxx + ICQ_Status_AWAY;
    9: Result := Ffff + ICQ_Status_OFFLINE;
    10: Result := Xxxx + ICQ_Status_INVISIBLE;
    11: Result := Xxxx + ICQ_Status_INVISIBLE;
    12: Result := Xxxx + ICQ_Status_OCCUPIED;
    13: Result := Xxxx + ICQ_Status_DND;
    14: Result := Xxxx + ICQ_Status_NA;
    15: Result := Xxxx + ICQ_Status_LUNCH;
    16: Result := Xxxx + ICQ_Status_FFC;
    17: Result := Xxxx + ICQ_Status_DEPRESSION;
    18: Result := Xxxx + ICQ_Status_EVIL;
    19: Result := Xxxx + ICQ_Status_ATHOME;
    20: Result := Xxxx + ICQ_Status_ATWORK;
  else
    Result := Xxxx + ICQ_Status_ONLINE;
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_UpdatePrivate_Group'}

procedure ICQ_UpdatePrivate_Group(InvizStatus: string);
var
  Pkt: string;
begin
  // Если код приватных групп пустой, то выходим
  if ICQ_UpdatePrivateGroup_Code = EmptyStr then
    Exit;
  // Формируем пакет
  Pkt := '00130009000000000009' + '00000000' + ICQ_UpdatePrivateGroup_Code + '0004002100CA0001' + InvizStatus + '00CB0004FFFFFFFF00D000010100D10001' + '0100D200010100D3000101';
  // Отсылаем пакет
  ICQ_SendPkt('2', Pkt);
end;

{$ENDREGION}
{$REGION 'ICQ_CreateShortStatusPkt'}

function ICQ_CreateShortStatusPkt: string;
var
  Pkt: string;
begin
  // В зависимости от приватного статуса отсылаем пакет видимости для групп
  if (ICQ_CurrentStatus = 10) or (ICQ_CurrentStatus = 11) then
  begin
    ICQ_PrivatStatus_Enabled := True;
    if ICQ_CurrentStatus = 10 then
      ICQ_UpdatePrivate_Group('03');
    if ICQ_CurrentStatus = 11 then
      ICQ_UpdatePrivate_Group('02');
  end
  else if ICQ_PrivatStatus_Enabled then
  begin
    ICQ_PrivatStatus_Enabled := False;
    ICQ_UpdatePrivate_Group('04');
  end;
  // Формируем пакет
  Pkt := '0001001E00000000001E' // Pkt Head
  + '00060004' + ICQ_StatusImgId2Code(ICQ_CurrentStatus); // Online Status
  Result := Pkt;
end;

{$ENDREGION}
{$REGION 'ICQ_CliSetFirstStatusPkt'}

function ICQ_CliSetFullStatusPkt: string;
var
  Pkt: string;
begin
  Pkt := '0001001E00000000001E' // Pkt Head
  + '00060004' + ICQ_StatusImgId2Code(ICQ_CurrentStatus_bac) // Online status
  + '000800020000' // Unk
  + '000C0025' // DC Info
  + '00000000' // Internal IP address
  + '00000000' // TCP Port
  + '04' // DC not possible
  + '0009' // Protocol Version
  + '00000000' // Authorization Cookie
  + '0000' // Web Front Port
  + '00000000' // Client Futures
  + '00000000' // Last Info Update
  + '00000000' // Last Extended Info Update (DcInfo1)
  + '00000000' // Last Extended Status Update (DcInfo2)
  + '00000000' // Unk (DcInfo3)
  + '001F00020000'; // Upper bytes of Nick Flags
  Result := Pkt;
end;

{$ENDREGION}
{$REGION 'ICQ_CliSetICBMparametersPkt'}

function ICQ_CliSetICBMparametersPkt: string;
var
  Pkt: string;
begin
  Pkt := '00040002000000000002' // Pkt Head
  + '0000' // Chanel to setup
  + '0000070B' // Message Flags
  + '1F40' // Max SNAC Size
  + '03E7' // Max sender warn level
  + '03E7' // max receiver warn level
  + '00000000'; // Minimum message interval (milliseconds)
  Result := Pkt;
end;

{$ENDREGION}
{$REGION 'ICQ_CliSetFirstOnlineInfoPkt'}

function ICQ_CliSetOnlineInfoPkt(XClient, XVer, XStatusCap, Cap1, Cap2, Cap3: string): string;
var
  Pkt, Caps: string;
begin
  Caps := ICQ_GenerateClientCaps(XClient, XVer);
  Caps := Caps + XStatusCap + Text2Hex(Cap1 + Cap2 + Cap3);
  Pkt := '00020004000000000004' // Pkt Head
  + '0005' + IntToHex(Length(Hex2Text(Caps)), 4) + Caps; // Client Capabilities
  Result := Pkt;
end;

{$ENDREGION}
{$REGION 'ICQ_Parse_1306'}

function ICQ_Parse_1306(PktData: string): Boolean;
const
  C_ChangeTime = 'ChangeTime';
var
  Len, Count, I: Integer;
  CLTimeStamp: DWord;
  SubData, QSN, QGroupId, QID, QType, QNick, TLV, S_Log: string;
  QPhone, QNote, QEmail, QTimeId: string;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
  Dt: TDateTime;
begin
  // Ставим не законченный результат разбора пакета (пока все части пакета не придут нужно ждать их от сервера)
  Result := False;
  // Пропускаем версию КЛ
  NextData(PktData, 1);
  // Получаем количесво записей в нашем КЛ
  Count := HexToInt(Text2Hex(NextData(PktData, 2)));
  S_Log := S_Log + C_Item + C_SS + C_BN + C_Count + C_TN + C_BN + IntToStr(Count) + C_RN;
  // Разбираем записи
  // Начинаем добаление записей контактов в Ростер
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Открываем раздел ICQ в ростере
        XML_Node := Root.Items.ItemNamed[C_Icq];
        // В цикле перебираем все пункты
        for I := 0 to Count - 1 do
        begin
          // Длинна записи
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          // Получаем имя записи
          QSN := Utf8ToString(NextData(PktData, Len));
          S_Log := S_Log + C_Item + C_BN + C_PN + C_BN + C_Name + C_TN + C_BN + QSN + C_LN + C_BN;
          // Получаем идентификатор группы
          QGroupId := Text2Hex(NextData(PktData, 2));
          S_Log := S_Log + C_Group + C_Id + C_TN + C_BN + QGroupId + C_LN + C_BN;
          // Идентификатор записи
          QID := Text2Hex(NextData(PktData, 2));
          S_Log := S_Log + C_Id + C_TN + C_BN + QID + C_LN + C_BN;
          // Тип записи
          QType := Text2Hex(NextData(PktData, 2));
          S_Log := S_Log + 'Type' + C_TN + C_BN + QType + C_LN + C_BN;
          // Длинна TLV записи
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          // Получаем субпакет записи
          SubData := NextData(PktData, Len);
          // Определяем действие по типу записи
          case HexToInt(QType) of
            BUDDY_NORMAL: // Нормальный контакт
              begin
                // Открываем раздел контактов
                Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                if Sub_Node = nil then
                  Sub_Node := XML_Node.Items.Add(C_Contact + C_SS);
                // Добавляем контакт в Ростер
                Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(QSN));
                Tri_Node.Properties.Add(C_Group + C_Id, QGroupId);
                Tri_Node.Properties.Add(C_Status, 9);
                Tri_Node.Properties.Add(C_Id, QID);
                Tri_Node.Properties.Add(C_Auth, C_AuthBoth);
                Tri_Node.Properties.Add(C_Type, QType);
                // Сканируем субпакет на наличие нужных нам TLV пока длинна пакета больше нуля
                while Length(SubData) > 0 do
                begin
                  TLV := Text2Hex(SubData[1] + SubData[2]);
                  case HexToInt(Text2Hex(NextData(SubData, 2))) of
                    $0131: // Ник контакта
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        QNick := Utf8ToString(NextData(SubData, Len));
                        S_Log := S_Log + C_Nick + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + QNick + C_LN + C_BN;
                        if QNick <> EmptyStr then
                          Tri_Node.Properties.Add(C_Nick, URLEncode(QNick));
                      end;
                    $013A: // Номер сотового телефона
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        QPhone := Utf8ToString(NextData(SubData, Len));
                        S_Log := S_Log + C_Phone + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + QPhone + C_LN + C_BN;
                        Tri_Node.Properties.Add(C_Phone, URLEncode(QPhone));
                      end;
                    $0066: // Не авторизованый контакт
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        NextData(SubData, Len);
                        S_Log := S_Log + C_Auth + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + C_AuthNone + C_LN + C_BN;
                        // Ставим флаг что контакт требует авторизации и ставим предупредительную иконку
                        RosterUpdateProp(Tri_Node, C_Auth, C_AuthNone);
                        RosterUpdateProp(Tri_Node, C_Client, '220');
                      end;
                    $013C: // Заметка о контакте
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        QNote := Utf8ToString(NextData(SubData, Len));
                        S_Log := S_Log + C_Note + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + QNote + C_LN + C_BN;
                        Tri_Node.Properties.Add(C_Note, URLEncode(QNote));
                      end;
                    $0137: // Email контакта
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        QEmail := Utf8ToString(NextData(SubData, Len));
                        S_Log := S_Log + C_Email + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + QEmail + C_LN + C_BN;
                        Tri_Node.Properties.Add(C_Email, URLEncode(QEmail));
                      end;
                    $006D: // TimeId
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        QTimeId := Text2Hex(NextData(SubData, Len));
                        S_Log := S_Log + C_Time + C_Id + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + QTimeId + C_LN + C_BN;
                        Tri_Node.Properties.Add(C_Time + C_Id, QTimeId);
                      end
                  else
                    begin
                      // Если пакет содержит другие TLV, то пропускаем их
                      Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                      S_Log := S_Log + C_Unk + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubData, Len)) + C_LN + C_BN;
                    end;
                  end;
                end;
              end;
            BUDDY_GROUP: // Группа
              begin
                // Открываем раздел групп
                Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
                if Sub_Node = nil then
                  Sub_Node := XML_Node.Items.Add(C_Group + C_SS);
                // Нулевая группа для временных контактов в серверном КЛ
                if QGroupId = '0000' then
                begin
                  Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                  Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[32].L_S));
                  Tri_Node.Properties.Add(C_Id, QGroupId);
                end
                else
                begin
                  // Стандартная група
                  if QGroupId <> '0000' then
                  begin
                    // Если есть хоть одна группа, то отключаем режим "нового" КЛ
                    NewKL := False;
                    // Записываем группу
                    Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                    Tri_Node.Properties.Add(C_Name, URLEncode(QSN));
                    Tri_Node.Properties.Add(C_Id, QGroupId);
                  end;
                end;
              end;
            BUDDY_UPGROUP: // Код для приватных групп
              begin
                ICQ_UpdatePrivateGroup_Code := QID;
                S_Log := S_Log + 'PrivateGroupId' + C_TN + C_BN + QID + C_LN;
              end;
            BUDDY_IGNORE: // Игнорируемые контакты
              begin
                {// Открываем раздел контактов
                Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                if Sub_Node = nil then
                  Sub_Node := XML_Node.Items.Add(C_Contact + C_SS);
                // Добавляем контакт в Ростер
                Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(QSN));
                Tri_Node.Properties.Add(C_Group + C_Id, C_IgCL);
                Tri_Node.Properties.Add(C_Status, 9);
                Tri_Node.Properties.Add(C_Id, QID);
                Tri_Node.Properties.Add(C_Type, QType);}
              end;
            BUDDY_INVISIBLE: // Невидящие контакты
              begin
                {// Открываем раздел контактов
                Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                if Sub_Node = nil then
                  Sub_Node := XML_Node.Items.Add(C_Contact + C_SS);
                // Добавляем контакт в Ростер
                Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(QSN));
                Tri_Node.Properties.Add(C_Group + C_Id, QGroupId);
                Tri_Node.Properties.Add(C_Status, 9);
                Tri_Node.Properties.Add(C_Id, QID);
                Tri_Node.Properties.Add(C_Type, QType);}
              end;
            BUDDY_VISIBLE: // Видящие контакты
              begin
                {// Открываем раздел контактов
                Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                if Sub_Node = nil then
                  Sub_Node := XML_Node.Items.Add(C_Contact + C_SS);
                // Добавляем контакт в Ростер
                Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(QSN));
                Tri_Node.Properties.Add(C_Group + C_Id, QGroupId);
                Tri_Node.Properties.Add(C_Status, 9);
                Tri_Node.Properties.Add(C_Id, QID);
                Tri_Node.Properties.Add(C_Type, QType);}
              end;
            BUDDY_DELETE, BUDDY_AUTORIZ: // Временные контакты из нулевой группы
              begin
                // Открываем раздел контактов
                Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
                if Sub_Node = nil then
                  Sub_Node := XML_Node.Items.Add(C_Contact + C_SS);
                // Добавляем контакт в Ростер
                Tri_Node := Sub_Node.Items.Add(C_Contact + C_DD + IntToStr(Sub_Node.Items.Count + 1));
                Tri_Node.Properties.Add(C_Login, URLEncode(QSN));
                Tri_Node.Properties.Add(C_Group + C_Id, QGroupId);
                Tri_Node.Properties.Add(C_Status, 214);
                Tri_Node.Properties.Add(C_Id, QID);
                Tri_Node.Properties.Add(C_Type, QType);
                // Делаем поиск ника в кэше ников
                Tri_Node.Properties.Add(C_Nick, SearchNickInCash(C_Icq, UrlEncode(QSN)));
                // Сканируем пакет на нужные нам TLV
                while Length(SubData) > 0 do
                begin
                  TLV := Text2Hex(NextData(SubData, 2));
                  case HexToInt(TLV) of
                    $006D: // TimeId
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        QTimeId := Text2Hex(NextData(SubData, Len));
                        S_Log := S_Log + C_Time + C_Id + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + QTimeId + C_LN + C_BN;
                        Tri_Node.Properties.Add(C_Time + C_Id, QTimeId);
                      end
                  else
                    begin
                      // Если пакет содержит другие TLV, то пропускаем их
                      Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                      S_Log := S_Log + C_Unk + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubData, Len)) + C_LN + C_BN;
                    end;
                  end;
                end;
              end;
            BUDDY_VANITY: // Информация о нашей деятельности на этом UIN
              begin
                // Сканируем пакет на нужные нам TLV
                while Length(SubData) > 0 do
                begin
                  TLV := Text2Hex(NextData(SubData, 2));
                  case HexToInt(TLV) of
                    $0067: // Начало сбора статистики
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        ICQ_CollSince := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(SubData, Len)))));
                        S_Log := S_Log + 'CollSince' + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_CollSince + C_LN + C_BN;
                      end;
                    $0150: // Всего отправлено сообщений
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        ICQ_SendMess := IntToStr(HexToInt(Text2Hex(NextData(SubData, Len))));
                        S_Log := S_Log + C_OutMess + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_SendMess + C_LN + C_BN;
                      end;
                    $0151: // Дней проведено в сети
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        Dt := HexToInt(Text2Hex(NextData(SubData, Len))) / 86400;
                        ICQ_OnlineDays := IntToStr(Trunc(Dt));
                        S_Log := S_Log + 'OnlineDays' + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_OnlineDays + C_LN + C_BN;
                      end;
                    $0152: // Всего отправлено Away сообщений
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        ICQ_AwayMess := IntToStr(HexToInt(Text2Hex(NextData(SubData, Len))));
                        S_Log := S_Log + 'AwayMess' + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_AwayMess + C_LN + C_BN;
                      end;
                    $0153: // Всего получено сообщений
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        ICQ_RecMess := IntToStr(HexToInt(Text2Hex(NextData(SubData, Len))));
                        S_Log := S_Log + C_InMess + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_RecMess + C_LN + C_BN;
                      end;
                    $0160: // Активность
                      begin
                        Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                        ICQ_LastActive := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(SubData, Len)))));
                        S_Log := S_Log + 'LastActive' + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_LastActive + C_LN + C_BN;
                      end
                  else
                    begin
                      // Если пакет содержит другие TLV, то пропускаем их
                      Len := HexToInt(Text2Hex(NextData(SubData, 2)));
                      S_Log := S_Log + C_Unk + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(SubData, Len)) + C_LN + C_BN;
                    end;
                  end;
                end;
                // Отображаем эти переменные в окне настроек ICQ
                if Assigned(IcqOptionsForm) then
                  IcqOptionsForm.SetOnlineVars;
              end;
          end;
          S_Log := S_Log + C_RN;
        end;
        // Открываем раздел групп
        Sub_Node := XML_Node.Items.ItemNamed[C_Group + C_SS];
        if Sub_Node = nil then
          Sub_Node := XML_Node.Items.Add(C_Group + C_SS);
        // Добавляем группу для контактов "не в списке"
        Tri_Node := Sub_Node.Items.ItemNamed[C_Group + C_DD + C_NoCL];
        if Tri_Node = nil then
        begin
          Tri_Node := Sub_Node.Items.Add(C_Group + C_DD + C_NoCL);
          Tri_Node.Properties.Add(C_Name, URLEncode(Lang_Vars[33].L_S));
          Tri_Node.Properties.Add(C_Id, C_NoCL);
        end;
      end;
    end;
  end;
  // Финальное время контакт листа
  CLTimeStamp := HexToInt(Text2Hex(NextData(PktData, 4)));
  if CLTimeStamp <> 0 then
    S_Log := S_Log + C_ChangeTime + C_TN + C_BN + DateTimeToStr(UnixToDateTime(CLTimeStamp)) + C_RN
  else
    S_Log := S_Log + C_ChangeTime + C_TN + C_BN + '0' + C_RN;
  // Пишем в лог данные пакета
  XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[27].Pkt_Name, Trim(S_Log), C_Icq);
  // Если время больше нуля, то заканчиваем с наполнением КЛ
  if CLTimeStamp <> 0 then
  begin
    // Если это обсолютно пустой и новый КЛ, то создаём первую в его жизни группу (обязательное условие)
    if NewKL then
    begin
      // Стартуем фазу добавления группы
      ICQ_Add_Nick := 'General';
      // Рандомизируем случайный идентификатор
      Randomize;
      ICQ_Add_GroupId := IntToHex(Random($7FFF), 4);
      ICQ_Add_Group_Phaze := True;
      ICQ_SSI_Phaze := True;
      ICQ_AddGroup(ICQ_Add_Nick, ICQ_Add_GroupId);
    end;
    // Объявляем финальный результат разбора всего пакета
    Result := True;
    // Запускаем обработку Ростера
    V_CollapseGroupsRestore := True;
    UpdateFullCL;
  end;
end;

{$ENDREGION}
{$REGION 'ICQ_Parse_010F'}

procedure ICQ_Parse_010F(PktData: string);
var
  Len, Count, I, V: Integer;
  TLV, S_Log, S, Cap, Caps: string;
begin
  // Если пакет пустой, то выходим
  if PktData = EmptyStr then
    Exit;
  // Пропускаем наш UIN
  Len := HexToInt(Text2Hex(NextData(PktData, 1)));
  S_Log := S_Log + C_Login + C_TN + C_BN + NextData(PktData, Len) + C_RN;
  // Пропускаем уровень предупреждений (в icq протоколе всегда равен 0)
  NextData(PktData, 2);
  // Получаем количесво вложенных в пакет TLV
  Count := HexToInt(Text2Hex(NextData(PktData, 2)));
  for I := 0 to Count - 1 do
  begin
    TLV := Text2Hex(NextData(PktData, 2));
    // Сканируем пакет на наличие нужных нам TLV
    case HexToInt(TLV) of
      $0001:
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + C_UserClass + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
        end;
      $0006:
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + C_Status + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
        end;
      $000D:
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          Caps := Text2Hex(NextData(PktData, Len));
          S := EmptyStr;
          while Length(Caps) > 0 do
          begin
            Cap := NextData(Caps, 32);
            if Assigned(LogForm) then
            begin
              if LogForm.ICQDumpSpeedButton.Down then
              begin
                // Ищем названия капов характеристик
                for V := Low(ICQ_Servises_Caps) to High(ICQ_Servises_Caps) do
                begin
                  if ICQ_Servises_Caps[V].Cap_HEX = Cap then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_Servises_Caps[V].Cap_Name + C_EN;
                    Break;
                  end;
                end;
                // Ищем названия капов Xстатусов
                for V := Low(ICQ_XStatus_Codes) to High(ICQ_XStatus_Codes) do
                begin
                  if ICQ_XStatus_Codes[V].XStatus_Caps = Cap then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_XStatus_Codes[V].XStatus_Code + C_EN;
                    Break;
                  end;
                end;
                // Ищем названия капов клиентов
                for V := Low(ICQ_Clients_Caps) to High(ICQ_Clients_Caps) do
                begin
                  if Pos(ICQ_Clients_Caps[V].Cap_HEX, Cap) > 0 then
                  begin
                    Cap := Cap + C_BN + C_QN + ICQ_Clients_Caps[V].Client_Name + C_EN;
                    Break;
                  end;
                end;
              end;
            end;
            S := S + Cap + C_BN + C_PN + C_BN;
          end;
          Caps := S;
          S_Log := S_Log + C_Caps + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Caps + C_RN;
        end;
      $000C:
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + 'DC Info' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
        end;
      $000F:
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + 'IdleTime' + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
        end;
      $0003:
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
          S_Log := S_Log + C_SignonTime + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
        end;
      $001D: // Аватар хэш и другие доп. статусы
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          S := Text2Hex(NextData(PktData, Len));
          S_Log := S_Log + C_AvatarHash + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + S + C_RN;
        end;
      $0005: // Дата регистрации нашего UIN
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          ICQ_MyUIN_RegTime := DateTimeToStr(UnixToDateTime(HexToInt(Text2Hex(NextData(PktData, Len)))));
          S_Log := S_Log + C_RegDate + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_MyUIN_RegTime + C_RN;
          // Отображаем это в окне настроек ICQ
          if Assigned(IcqOptionsForm) then
            IcqOptionsForm.RegDateInfoEdit.Text := ICQ_MyUIN_RegTime;
        end;
      $000A: // Наш внешний IP адрес
        begin
          Len := HexToInt(Text2Hex(NextData(PktData, 2)));
          ICQ_Online_IP := NumToIp(Swap32(HexToInt(Text2Hex(NextData(PktData, Len)))));
          S_Log := S_Log + C_ExtIP + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + ICQ_Online_IP + C_RN;
          // Отображаем это в окне настроек ICQ
          if Assigned(IcqOptionsForm) then
            IcqOptionsForm.ExternalIPInfoEdit.Text := ICQ_Online_IP;
        end
    else
      begin
        // Если пакет содержит другие TLV, то пропускаем их
        Len := HexToInt(Text2Hex(NextData(PktData, 2)));
        S_Log := S_Log + C_Unk + C_BN + C_PN + C_BN + C_TLV + C_TN + C_BN + TLV + C_BN + C_Value + C_TN + C_BN + Text2Hex(NextData(PktData, Len)) + C_RN;
      end;
    end;
  end;
  // Пишем в лог данные пакета
  XLog(C_Icq + C_BN + Log_Parsing + C_BN + ICQ_Pkt_Names[21].Pkt_Name, Trim(S_Log), C_Icq);
end;

{$ENDREGION}
{$REGION 'ICQ_CliFamilyPkt'}

function ICQ_CliFamilyPkt: string;
begin
  Result := '00010017000000000017' // Pkt Head
  + '00220001' // Unknown Family (0x22), Version: 1
  + '00010004' // AIM Generic (0x1), Version: 4
  + '00130004' // AIM SSI (0x13), Version: 4
  + '00020001' // AIM Location (0x2), Version: 1
  + '00030001' // AIM Buddylist (0x3), Version: 1
  + '00150001' // AIM ICQ (0x15), Version: 1
  + '00040001' // AIM Messaging (0x4), Version: 1
  + '00060001' // AIM Invitation (0x6), Version: 1
  + '00090001' // AIM BOS (0x9), Version: 1
  + '000A0001' // AIM User Lookup (0xa), Version: 1
  + '000B0001'; // AIM Stats (0xb), Version: 1
end;

{$ENDREGION}
{$REGION 'ICQ_CliCookiePkt'}

function ICQ_CliCookiePkt(Cookie: string): string;
begin
  Result := '00000001' // Proto Ver
  + '0006' + IntToHex(Length(Hex2Text(Cookie)), 4) + Cookie // Auth Cookie
  + '0003' + IntToHex(Length(ICQ_ClientLoginID), 4) + Text2Hex(ICQ_ClientLoginID) // Client Id string
  + '001700020007' // Client Major Ver
  + '001800020002' // Client Minor Ver
  + '001900020000' // Client Lesser Ver
  + '001A00020C57' // Client Build Number
  + '00160002010A' // Client Id Number
  + '0014000400007539' // Client Distribution Number
  + '000F' + IntToHex(Length(V_CurrentLang), 4) + Text2Hex(V_CurrentLang) // Client Lang
  + '000E' + IntToHex(Length(V_CurrentLang), 4) + Text2Hex(V_CurrentLang) // Client Country
  + '0094000100' // Unk
  + '004A000101' // Use SSL
  + '8003000400100000'; // Unk
end;

{$ENDREGION}
{$REGION 'ICQ_MD5CliLoginPkt'}

function ICQ_MD5CliLoginPkt(CPass, CKey: RawByteString): string;
var
  CLIENT_MD5_STRING: RawByteString;
  MD5hash: string;
  State: TMd5Context;
  Digest: TMD5Digest;
begin
  // Уменьшаем длинну пароля до 8 символов (ограничение протокола ICQ)
  if Length(ICQ_LoginPassword) > 8 then
    Setlength(ICQ_LoginPassword, 8);
  // Вычисляем MD5 хэш пароля
  CLIENT_MD5_STRING := 'AOL Instant Messenger (SM)';
  MD5Init(State);
  MD5UpdateBuffer(State, PByteArray(@CPass[1]), Length(CPass));
  MD5Final(Digest, State);
  MD5Init(State);
  MD5UpdateBuffer(State, PByteArray(@CKey[1]), Length(CKey));
  MD5UpdateBuffer(State, PByteArray(@Digest), SizeOf(TMD5Digest));
  MD5UpdateBuffer(State, PByteArray(@CLIENT_MD5_STRING[1]), Length(CLIENT_MD5_STRING));
  MD5Final(Digest, State);
  MD5hash := PacketToHex(@Digest, SizeOf(TMD5Digest));
  // Формируем пакет
  Result := '00170002000000000000' // Pkt Head
  + '0001' + IntToHex(Length(ICQ_LoginUIN), 4) + Text2Hex(ICQ_LoginUIN) // Screen Name
  + '00250010' + MD5hash // Password Hash (MD5)
  + '004C0000' // Unk
  + '0003' + IntToHex(Length(ICQ_ClientLoginID), 4) + Text2Hex(ICQ_ClientLoginID) // Client Id string
  + '001700020007' // Client Major Ver
  + '001800020002' // Client Minor Ver
  + '001900020000' // Client Lesser Ver
  + '001A00020C57' // Client Build Number
  + '00160002010A' // Client Id Number
  + '0014000400007539' // Client Distribution Number
  + '000F' + IntToHex(Length(V_CurrentLang), 4) + Text2Hex(V_CurrentLang) // Client Lang
  + '000E' + IntToHex(Length(V_CurrentLang), 4) + Text2Hex(V_CurrentLang) // Client Country
  + '0094000100' // Unk
  + '004A000101'; // Use SSL
end;

{$ENDREGION}
{$REGION 'ICQ_NotifyUserStatus'}

procedure ICQ_NotifyUserStatus(UIN, IStatus, IClient: string; IColor: Integer);
{var
  Client, Nick: string;}
begin
  // Ищем ник этой учётной записи в КЛ
  {RosterItem := RosterForm.ReqRosterItem(UIN);
  if RosterItem <> nil then
    Nick := RosterItem.SubItems[0];
  if Nick > EmptyStr then
    Nick := InfoNickL + C_BN + Nick;
  if IClient > EmptyStr then
    Client := Lang_Vars[38].L_S + C_TN + IClient;}
  // Отображаем всплывающим сообщением статус контакта
  //DAShow(Lang_Vars[16].L_S, Nick + C_RN + 'ICQ#: ' + UIN + C_RN + Lang_Vars[47].L_S + C_TN + IStatus + C_RN + Client, EmptyStr, 133, IColor, 0);
end;

{$ENDREGION}
{$REGION 'ICQ_NotifyAuthCookieError'}

function ICQ_NotifyAuthCookieError(ErrCode: string): string;
begin
  // Пытаемся узнать расшифровку кода ошибки
  if ErrCode = '0001' then
    Result := ConnectErrors_0001
  else if ErrCode = '0002' then
    Result := ConnectErrors_0002
  else if ErrCode = '0003' then
    Result := ConnectErrors_0003
  else if ErrCode = '0004' then
    Result := ConnectErrors_0004
  else if ErrCode = '0005' then
    Result := ConnectErrors_0005
  else if ErrCode = '0006' then
    Result := ConnectErrors_0006
  else if ErrCode = '0007' then
    Result := ConnectErrors_0007
  else if ErrCode = '0008' then
    Result := ConnectErrors_0008
  else if ErrCode = '0009' then
    Result := ConnectErrors_0009
  else if ErrCode = '000A' then
    Result := ConnectErrors_000A
  else if ErrCode = '000B' then
    Result := ConnectErrors_000B
  else if ErrCode = '000C' then
    Result := ConnectErrors_000C
  else if ErrCode = '000D' then
    Result := ConnectErrors_000D
  else if ErrCode = '000E' then
    Result := ConnectErrors_000E
  else if ErrCode = '000F' then
    Result := ConnectErrors_000F
  else if ErrCode = '0010' then
    Result := ConnectErrors_0010
  else if ErrCode = '0011' then
    Result := ConnectErrors_0011
  else if ErrCode = '0012' then
    Result := ConnectErrors_0012
  else if ErrCode = '0013' then
    Result := ConnectErrors_0013
  else if ErrCode = '0014' then
    Result := ConnectErrors_0014
  else if ErrCode = '0015' then
    Result := ConnectErrors_0015
  else if ErrCode = '0016' then
    Result := ConnectErrors_0016
  else if ErrCode = '0017' then
    Result := ConnectErrors_0017
  else if ErrCode = '0018' then
    Result := ConnectErrors_0018
  else if ErrCode = '0019' then
    Result := ConnectErrors_0019
  else if ErrCode = '001A' then
    Result := ConnectErrors_001A
  else if ErrCode = '001B' then
    Result := ConnectErrors_001B
  else if ErrCode = '001C' then
    Result := ConnectErrors_001C
  else if ErrCode = '001D' then
    Result := ConnectErrors_001D
  else if ErrCode = '001E' then
    Result := ConnectErrors_001E
  else if ErrCode = '0020' then
    Result := ConnectErrors_0020
  else if ErrCode = '0022' then
    Result := ConnectErrors_0022
  else
    Result := Lang_Vars[24].L_S + C_BN + C_QN + ErrCode + C_EN;
  XLog(C_Icq, Result, C_Icq);
end;

{$ENDREGION}
{$REGION 'ICQ_GoOffline'}

procedure ICQ_GoOffline;
var
  I: Integer;
  XML_Node, Sub_Node, Tri_Node: TJvSimpleXmlElem;
begin
  // Отключаем таймер факстатуса, пингов
  MainForm.UnstableICQStatus.Checked := False;
  with MainForm.JvTimerList do
  begin
    Events[4].Enabled := False;
    Events[5].Enabled := False;
  end;
  // Если существует форма настроек протокола ICQ, то блокируем там контролы
  if Assigned(IcqOptionsForm) then
  begin
    with IcqOptionsForm do
    begin
      NoAutoAuthRadioButton.Enabled := False;
      YesAutoAuthRadioButton.Enabled := False;
      ShowWebAwareCheckBox.Enabled := False;
      ICQUINEdit.Enabled := True;
      ICQUINEdit.Color := ClWindow;
      PassEdit.Enabled := True;
      PassEdit.Color := ClWindow;
    end;
  end;
  // Активируем фазу оффлайн и обнуляем буферы пакетов
  ICQ_Connect_Phaze := False;
  ICQ_HTTP_Connect_Phaze := False;
  ICQ_BosConnect_Phaze := False;
  ICQ_Work_Phaze := False;
  ICQ_Offline_Phaze := True;
  ICQ_SSI_Phaze := False;
  ICQ_myBeautifulSocketBuffer := EmptyStr;
  ICQ_BuffPkt := EmptyStr;
  // Обнуляем переменные протокола
  ICQ_Online_IP := EmptyStr;
  ICQ_MyUIN_RegTime := EmptyStr;
  ICQ_MyIcon_Hash := EmptyStr;
  ICQ_UpdatePrivateGroup_Code := EmptyStr;
  ICQ_CollSince := EmptyStr;
  ICQ_SendMess := EmptyStr;
  ICQ_OnlineDays := EmptyStr;
  ICQ_AwayMess := EmptyStr;
  ICQ_RecMess := EmptyStr;
  ICQ_LastActive := EmptyStr;
  // Если сокет подключён, то отсылаем пакет "до свидания"
  with MainForm do
  begin
    if ICQWSocket.State = WsConnected then
      ICQWSocket.SendStr(Hex2Text('2A04' + IntToHex(ICQ_Seq, 4) + '0000'));
    // Закрываем сокет
    ICQWSocket.Abort;
    // Ставим иконку и значение статуса оффлайн
    ICQ_CurrentStatus := 9;
    ICQToolButton.ImageIndex := ICQ_CurrentStatus;
    //ICQTrayIcon.IconIndex := ICQ_CurrentStatus;
    // Подсвечиваем в меню статуса ICQ статус оффлайн
    ICQStatusOffline.default := True;
  end;
  // Обнуляем счётчики пакетов
  ICQ_Seq := $1000;
  ICQ_Avatar_Seq := $2000;
  // Обнуляем статусы в Ростере
  if V_Roster <> nil then
  begin
    with V_Roster do
    begin
      if Root <> nil then
      begin
        // Ищем раздел ICQ
        XML_Node := Root.Items.ItemNamed[C_Icq];
        if XML_Node <> nil then
        begin
          // Ищем раздел контактов
          Sub_Node := XML_Node.Items.ItemNamed[C_Contact + C_SS];
          if Sub_Node <> nil then
          begin
            for I := 0 to Sub_Node.Items.Count - 1 do
            begin
              Tri_Node := Sub_Node.Items.Item[i];
              if Tri_Node <> nil then
              begin
                if Tri_Node.Properties.IntValue(C_Status) <> 214 then
                begin
                  RosterUpdateProp(Tri_Node, C_Status, '9');
                  RosterUpdateProp(Tri_Node, C_XStatus, '-1');
                  RosterUpdateProp(Tri_Node, C_XStatus + C_Name, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_XText, EmptyStr);
                  RosterUpdateProp(Tri_Node, C_Client, '-1');
                  RosterUpdateProp(Tri_Node, C_Client + C_Name, EmptyStr);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  // Запускаем обработку Ростера
  UpdateFullCL;
end;

{$ENDREGION}
{$REGION 'ICQ_GenerateClientCaps'}

function ICQ_GenerateClientCaps(ClientName, CVer: string): string;
begin
  Result := '0946134D4C7F11D18222444553540000' + '094600004C7F11D18222444553540000' + '094613444C7F11D18222444553540000' //
  + '094613494C7F11D18222444553540000' + '0946134E4C7F11D18222444553540000' + '563FC8090B6F41BD9F79422609DFA2F3' + '494D61646572696E6720436C69656E74';
end;

{$ENDREGION}

end.

