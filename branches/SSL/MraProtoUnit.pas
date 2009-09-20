unit MraProtoUnit;

interface

uses
  Windows, MainUnit, MraOptionsUnit, SysUtils, JvTrayIcon,
  Dialogs, OverbyteIcsWSocket, ChatUnit, MmSystem, Forms,
  ComCtrls, Messages, Classes, IcqContactInfoUnit, UnitCrypto, VarsUnit,
  Graphics, CategoryButtons, rXML, JvZLibMultiple, RosterUnit;

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
  MRA_CurrentStatus: integer = 23;
  MRA_CurrentStatus_bac: integer = 23;
  MRA_Reconnect: boolean = false;

procedure MRA_GoOffline;

implementation

uses
  UtilsUnit;

procedure MRA_GoOffline;
var
  i: integer;
begin
  //--Отключаем таймер факстатуса, пингов
  MainForm.UnstableMRAStatus.Checked := false;
  with MainForm.JvTimerList do
  begin
    Events[10].Enabled := false;
  end;
  //--Если существует форма настроек протокола MRA, то блокируем там контролы
  if Assigned(MraOptionsForm) then
  begin
    with MraOptionsForm do
    begin
      MRAEmailEdit.Enabled := true;
      MRAEmailEdit.Color := clWindow;
      PassEdit.Enabled := true;
      PassEdit.Color := clWindow;
    end;
  end;
  //--Активируем фазу оффлайн и обнуляем буферы пакетов
  MRA_Connect_Phaze := false;
  MRA_HTTP_Connect_Phaze := false;
  MRA_BosConnect_Phaze := false;
  MRA_Work_Phaze := false;
  MRA_Offline_Phaze := true;
  MRA_myBeautifulSocketBuffer := EmptyStr;
  MRA_HexPkt := EmptyStr;
  //--Если сокет подключён, то отсылаем пакет "до свидания"
  with MainForm do
  begin
    {if MRAWSocket.State = wsConnected then
      MRAWSocket.SendStr();}
    //--Закрываем сокет
    MRAWSocket.Abort;
    //--Ставим иконку и значение статуса оффлайн
    MRA_CurrentStatus := 23;
    MRAToolButton.ImageIndex := MRA_CurrentStatus;
    MRATrayIcon.IconIndex := MRA_CurrentStatus;
    //--Подсвечиваем в меню статуса MRA статус оффлайн
    MRAStatusOffline.Default := true;
  end;
  //--Активируем флаг остановки потока сжатия истории
  ZipThreadStop := true;
  //--Если поток сжатия истории не остановился ещё, то ждём его остановки
  while not MainForm.ZipHistoryThread.Terminated do Sleep(10);
  //--Сохраняем историю сообщений, но уже не в потоке
  ZipThreadStop := false;
  MainForm.ZipHistory;
  //--Обнуляем события и переменные в Ростере
  with RosterForm.RosterJvListView do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      if Items[i].SubItems[3] = 'Mra' then
      begin
        Items[i].SubItems[6] := '23';
        Items[i].SubItems[7] := '-1';
        Items[i].SubItems[8] := '-1';
        Items[i].SubItems[13] := '';
        Items[i].SubItems[15] := '';
        Items[i].SubItems[16] := '';
        Items[i].SubItems[18] := '0';
        Items[i].SubItems[19] := '0';
        Items[i].SubItems[35] := '0';
      end;
    end;
  end;
  //--Запускаем обработку Ростера
  RosterForm.UpdateFullCL;
end;

end.
