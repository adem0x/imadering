unit MraProtoUnit;

interface

var
  MRA_Bos_IP: string;
  MRA_Bos_Port: string;
  MRA_myBeautifulSocketBuffer: string;
  MRA_LoginServerAddr: string = 'mrim.mail.ru';
  MRA_LoginServerPort: string = '2042';
  MRA_HexPkt: string;
  MRA_LoginUIN: string = '';
  MRA_LoginPassword: string = '';
  //--Фазы работы начало
  MRA_Connect_Phaze: boolean = false;
  MRA_HTTP_Connect_Phaze: boolean = false;
  MRA_BosConnect_Phaze: boolean = false;
  MRA_Work_Phaze: boolean = false;
  MRA_Offline_Phaze: boolean = true;
  //--Фазы работы конец
  MRA_CurrentStatus: integer = 9;
  MRA_CurrentStatus_bac: integer = 9;

implementation

end.
