{ ****************************************** }
{ ************* UnitLogger.pas ************* }
{ ** @author: Sergey Melnikov ************** }
{ ** @EMail: Melnikov.Sergey.V@gmail.com *** }
{ ** @Created: 08.2009 ********************* }
{ ****************************************** }
{ ****************************************** }

unit UnitLogger;

interface

uses SysUtils, classes, SyncObjs;

const
  LogFileName = 'Profile\Imadering.log';

type
  /// <summary>Уровень логирования</summary>
  /// <list type="Уровень" | "Описание">
  /// <item>
  /// <level><remarks>lInfo</remarks></level>
  /// <description>Полная отладочная информация.</description>
  /// </item>
  /// <item>
  /// <level><remarks>lWarning</remarks></level>
  /// <description>Варнинги или замечания о общем ходе работы программы</description>
  /// </item>
  /// <item>
  /// <level><remarks>lError</remarks><level>
  /// <description>Ошибки или исключения</description>
  /// </item>
  /// <item>
  /// <level><remarks>lNoLog<remarks></level>
  /// <description>Не логировать работу программы (не рекомендуется)</description>
  /// </item>
  /// </list>
  TLogLevel = (lInfo, lWarning, lError, lNoLog);

  ILogger = interface
    /// <summary>Записывает сообщение в лог файл</summary>
    /// <param name="Text">Текст сообщения</param>
    /// <param name="Level">Уровеь важности сообщения<see cref="TLogLevel"/></param>
    /// <param name="PrintStack">Записать ли в лог стек вызовов</param>
    procedure WriteMessage(const Text: string; Level: TLogLevel = lWarning;
      const PrintStack: Boolean = false); overload;
    /// <summary>Записывает сообщение в лог файл</summary>
    /// <param name="ClassName">Имя класса, вызвавшего сообщение</param>
    /// <param name="Text">Текст сообщения</param>
    /// <param name="Level">Уровеь важности сообщения<see cref="TLogLevel"/></param>
    /// <param name="PrintStack">Записать ли в лог стек вызовов</param>
    procedure WriteMessage(const ClassName, Text: string;
      Level: TLogLevel = lWarning; const PrintStack: Boolean = false); overload;
    /// <summary>Записывает сообщение в лог файл. Стек записывается всегда!</summary>
    /// <param name="Error">Экземпляр возбужденного исключения</param>
    procedure WriteMessage(const Error: Exception); overload;
    /// <summary>Записывает сообщение в лог файл</summary>
    /// <param name="Format">Форматный вывод</param>
    /// <param name="Args">Аргументы форматного вывода</param>
    /// <param name="Level">Уровеь важности сообщения<see cref="TLogLevel"/></param>
    /// <param name="PrintStack">Записать ли в лог стек вызовов</param>
    procedure WriteMessage(const Format: string; const Args: array of const ;
      Level: TLogLevel = lWarning; const PrintStack: Boolean = false); overload;
  end;
{$HINTS OFF}

  TLogger = class(TInterfacedObject, ILogger)
  private
    CSection: TCriticalSection;
    LogFile: TStringList;
    FFullLogPath: string;
    FLogLevel: TLogLevel;
    function IsOlderDay(): Boolean;
  protected
    constructor Create();
    destructor Destroy; override;
    procedure UpdateFullPath();
  public
    /// summary>Singleton. Точка доступа</summary>
    class var Instance: ILogger;

    procedure WriteMessage(const Text: string; Level: TLogLevel = lWarning;
      const PrintStack: Boolean = false); overload;
    procedure WriteMessage(const ClassName, Text: string;
      Level: TLogLevel = lWarning; const PrintStack: Boolean = false); overload;
    procedure WriteMessage(const Error: Exception); overload;
    procedure WriteMessage(const Format: string; const Args: array of const ;
      Level: TLogLevel = lWarning; const PrintStack: Boolean = false); overload;

    /// <summary>Выставляет неодходимый уровень логирования</summary>
    property LogLevel: TLogLevel read FLogLevel write FLogLevel default lInfo;

  end;
{$HINTS ON}

implementation

uses DateUtils, windows, JCLDebug, VarsUnit;

{ TLogger }

constructor TLogger.Create;
begin
  inherited Create;
  CSection := TCriticalSection.Create;
  LogFile := nil;
  FFullLogPath := ProfilePath + LogFileName;
end;

destructor TLogger.Destroy;
begin
  FreeAndNil(CSection);
  inherited;
end;

function TLogger.IsOlderDay: Boolean;
var
  Date: TDateTime;
begin
  Result := false;
  if LogFile.Count < 1 then
    Exit;
  Date := StrToDateTimeDef(LogFile[0], 0);
  if (DaysBetween(Now, Date) >= 1) then
  begin
    LogFile.Clear;
    LogFile.Add(DateToStr(Now));
    Result := true;
  end;
end;

procedure TLogger.UpdateFullPath;
begin
  FFullLogPath := ProfilePath + LogFileName;
end;

procedure TLogger.WriteMessage(const Text: string; Level: TLogLevel;
  const PrintStack: Boolean);
var
  StrList: TStringList;
  Stack: string;
begin
  CSection.Enter;
  UpdateFullPath;
  try
    try
      if LogFile = nil then
      begin
        LogFile := TStringList.Create;
        if FileExists(FFullLogPath) then
        begin
          LogFile.LoadFromFile(FFullLogPath);
          IsOlderDay;
        end
        else
          LogFile.Add(DateToStr(Now));
      end;
      if Level >= FLogLevel then
      begin
        if PrintStack then
        begin
          StrList := TStringList.Create;
          try
            JclLastExceptStackListToStrings(StrList, true, true, true, true);
            StrList.Delimiter := #13;
            Stack := StrList.Text;
          finally
            FreeAndNil(StrList);
          end;
          LogFile.Add(Format('%s %s (%d) %d - %s at %s', [DateToStr(Now),
              TimeToStr(Now), GetCurrentThreadId, ord(Level), Text, Stack]));
        end
        else
          LogFile.Add
            (Format('%s %s (%d) %d - %s', [DateToStr(Now), TimeToStr(Now),
              GetCurrentThreadId, ord(Level), Text]));
        LogFile.SaveToFile(FFullLogPath);
      end;
    except
    end;
  finally
    CSection.Leave;
  end;
end;

procedure TLogger.WriteMessage(const Error: Exception);
begin
  if Error.ClassType <> EAbort then
    WriteMessage(Format('EXCEPTION: %s with message "%s"', [Error.ClassName,
        Error.Message]), lError, true);
end;

procedure TLogger.WriteMessage(const ClassName, Text: string; Level: TLogLevel;
  const PrintStack: Boolean);
begin
  WriteMessage(ClassName + ': ' + Text, Level, PrintStack);
end;

procedure TLogger.WriteMessage(const Format: string;
  const Args: array of const ; Level: TLogLevel; const PrintStack: Boolean);
begin
  WriteMessage(SysUtils.Format(Format, Args), Level, PrintStack);
end;

initialization

JclStartExceptionTracking;
TLogger.Instance := TLogger.Create;

finalization

JclStopExceptionTracking;

end.
