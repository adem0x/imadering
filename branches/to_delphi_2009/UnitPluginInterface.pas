{******************************************}
{*************IMadeRing project************}
{*********UnitPluginInterface.pas**********}
{**  @author: Sergey Melnikov            **}
{**  @EMail: Melnikov.Sergey.V@gmail.com **}
{**  @Created: 09.2009                   **}
{******************************************}
{******************************************}

unit UnitPluginInterface;

interface

{

  События, на которые можно будет вешать события плагина:
    1. Загрузка приложения
    2. Авторизация
    3. Разъединение
    4. Контакт изменил статус
    5. Контакт написал сообщение
    6. ...

    Для каждого из событий кроме 1, 3 введено поле Continue параметра Context, являющееся флагом
    продолжения обработки события приложением. 

  Что необходимо предоставлять плагину:
    1.1. Версия приложения
    1.2. Путь к профилю
    1.3. ...
    2.1. Логин пользователя
    2.2. Сервер
    2.3. Порт
    2.4. Активность SSL
    2.5. ...
    3.1. Код ошибки
    3.2. Сервер
    3.3. Порт
    3.4. Активность SSL
    3.5. ...
    4.1. ID контакта
    4.2. Отображаемое имя
    4.3. Прошлый статус
    4.4. Новый статус
    4.5. ...
    5.1. ID контакта
    5.2. Отображаемое имя
    5.3. Текст сообщения
    5.4. Контакт в контакт-листе?
    5.5. ...
 }
const
  PluginIDMagicConst: HRESULT = 788112009;
  IID_IIMRPlugin = '{58DC42FE-AA44-4996-8048-CB9455010B78}';
  CONST_EVENTS_COUNT = 5;

type

  TEventType = (eApplicationLoaded, eAuthorization, eDisconnect, eContactChangeStatus,
    eWriteMessage);
  TProtocol = (pICQ, pMRA, pJabber, pAny);
  TMessageDirection = (mdTOme, mdFROMme);

  PApplicationLoadedParams = ^TApplicationLoadedParams;
  TApplicationLoadedParams = packed record
    cSize: Cardinal;
    AppVersion: Cardinal;
    ProfilePath: PWideChar;
  end;

  PAuthorizationParams = ^TAuthorizationParams;
  TAuthorizationParams = packed record
    cSize: Cardinal;
    UserLogin: PWideChar;
    Server: PWideChar;
    Port: Cardinal;
    IsSSLActive: Cardinal;
  end;

  PDisconnectParams = ^TDisconnectParams;
  TDisconnectParams = packed record
    cSize: Cardinal;
    ErrorCode: Cardinal;
    Server: PWideChar;
    Port: Cardinal;
    IsSSLActive: Cardinal;
  end;

  PContactChangeStatusParams = ^TContactChangeStatusParams;
  TContactChangeStatusParams = packed record
    cSize: Cardinal;
    ContactID: PWideChar;
    ContactCaption: PWideChar;
    LastStatus: PWideChar;
    NewStatus: PWideChar;
  end;

  PContactWriteMessageParams = ^TContactWriteMessageParams;
  TContactWriteMessageParams = packed record
    cSize: Cardinal;
    FromContactID: PWideChar;
    FromContactCaption: PWideChar;
    ToContactID: PWideChar;
    ToContactCaption: PWideChar;
    MessageText: PWideChar;
    Direction: TMessageDirection;
  end;

  //Контекст программы. глобальные поля.
  TContext = record
    /// <summary>Размер записи. для контроля доступе к памяти и одинаковости
    /// версий записи</summary>
    cSize: Integer;
    /// <summary>Активный протокол</summary>
    ActiveProtocol: TProtocol;
    /// <summary>Флаг продолжения обработки</summary>
    ContinueExecution: Cardinal;
  end;

  //TCallBackFunction = function(const Context: TContext; Event: TEventType; Data: Pointer): HRESULT; stdcall;

  IIMRPlugin = interface(IUnknown)
    [IID_IIMRPlugin]
      function Init(AppVersion: Integer): HRESULT; stdcall;
      function Configure(ProfilePath: PWideChar): HRESULT; stdcall;
      function Quit: HRESULT; stdcall;

      /// <summary>Вызываем как WinApi. первый раз узнаем размер, потом с уже выделенной памятью!</summary>
      function GetPluginName(Data: PWideChar): Integer; stdcall;

      /// <summary>Возвращает количество событий, на которые реагирует плагин</summary>
      function GetEventsCount: Integer; stdcall;
      /// <summary>Возвращает информацию о том, на какие конкретно событий подписан плагин</summary>
      function RegisterCallBack(var EventTime: TEventType; const i: Integer): HRESULT; stdcall;

      /// <summary>Уведосить плагин о событии</summary>
      function NotifyPlugin(const Context: TContext; Event: TEventType; Data: Pointer): HRESULT; stdcall;
  end;

implementation

end.
