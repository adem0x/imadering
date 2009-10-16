// Изменения для проекта IMadering

{ ****************************************** }
{ ************* UnitLogger.pas ************* }
{ ** @author: Sergey Melnikov ************** }
{ ** @EMail: Melnikov.Sergey.V@gmail.com *** }
{ ** @Created: 08.2009 ********************* }
{ ****************************************** }
{ ****************************************** }

unit UnitLogger;

interface

uses
  SysUtils,
  Classes,
  SyncObjs;

const
  LogFileName = 'Profile\Imadering.log';

type
  TLogLevel = (LInfo, LWarning, LError, LNoLog);
  // lInfo - Полная отладочная информация.
  // lWarning - Варнинги или замечания о общем ходе работы программы.
  // lError - Ошибки или исключения.
  // lNoLog - Не логировать работу программы (не рекомендуется).

  ILogger = interface
    // Записывает сообщение в лог файл
    // "Text" - Текст сообщения
    // "Level" - Уровеь важности сообщения
    // "PrintStack" - Записать ли в лог стек вызовов
    procedure WriteMessage(const Text: string; Level: TLogLevel = LWarning; const PrintStack: Boolean = False); overload;

    // "ClassName" - Имя класса, вызвавшего сообщение
    procedure WriteMessage(const ClassName, Text: string; Level: TLogLevel = LWarning; const PrintStack: Boolean = False); overload;

    // Записывает сообщение в лог файл. Стек записывается всегда!
    // "Error" - Экземпляр возбужденного исключения
    procedure WriteMessage(const Error: Exception); overload;

    // "Format" - Форматный вывод
    // "Args" - Аргументы форматного вывода
    procedure WriteMessage(const Format: string; const Args: array of const ; Level: TLogLevel = LWarning;
      const PrintStack: Boolean = False); overload;
  end;

{$HINTS OFF}

  TLogger = class(TInterfacedObject, ILogger)
  private
    CSection: TCriticalSection;
    LogFile: TStringList;
    FFullLogPath: string;
    FLogLevel: TLogLevel;
    procedure IsOlderDay;

  protected
    constructor Create;
    destructor Destroy; override;
    procedure UpdateFullPath;

  public
    // Singleton. Точка доступа
    class var Instance: ILogger;

    procedure WriteMessage(const Text: string; Level: TLogLevel = LWarning; const PrintStack: Boolean = False); overload;
    procedure WriteMessage(const ClassName, Text: string; Level: TLogLevel = LWarning; const PrintStack: Boolean = False); overload;
    procedure WriteMessage(const Error: Exception); overload;
    procedure WriteMessage(const Format: string; const Args: array of const ; Level: TLogLevel = LWarning;
      const PrintStack: Boolean = False); overload;

    // Выставляет неодходимый уровень логирования
    property LogLevel: TLogLevel read FLogLevel write FLogLevel default LInfo;

  end;

{$HINTS ON}

implementation

uses
  Windows,
  JCLDebug,
  VarsUnit,
  MainUnit,
  LogUnit,
  UtilsUnit;

{ TLogger }

constructor TLogger.Create;
begin
  inherited Create;
  // Создаём критическую секцию для синхронизации
  CSection := TCriticalSection.Create;
  // Обнуляем объект
  LogFile := nil;
  // Путь до профиля для записи файла лога ошибок
  FFullLogPath := ProfilePath + LogFileName;
end;

destructor TLogger.Destroy;
begin
  // Уничтожаем критическую секцию
  FreeAndNil(CSection);
  inherited;
end;

procedure TLogger.IsOlderDay;
var
  Date: TDateTime;
  Curday, Logday: Integer;
begin
  // Если лог пустой, то выходим
  if LogFile.Count < 1 then
    Exit;
  // Получаем из лога дату его создания
  Date := StrToDateTimeDef(LogFile[0], 0);
  // Получаем день создания лога и текущий день
  Curday := StrToInt(FormatDateTime('DD', Now));
  Logday := StrToInt(Formatdatetime('DD', Date));
  // Если дни не совпадают, то обнуляем лог
  if Curday <> Logday then
    begin
      LogFile.Clear;
      LogFile.Add(DateToStr(Now));
    end;
end;

procedure TLogger.UpdateFullPath;
begin
  // Обновляем путь до профиля
  FFullLogPath := ProfilePath + LogFileName;
end;

procedure TLogger.WriteMessage(const Text: string; Level: TLogLevel; const PrintStack: Boolean);
var
  StrList: TStringList;
  Stack, ForLog: string;
begin
  // Входим в синхронизацию
  CSection.Enter;
  // Обновляем путь до профиля
  UpdateFullPath;
  try
    try
      // Если лист с ошибками ещё не существует, то создаём его
      if LogFile = nil then
        begin
          LogFile := TStringList.Create;
          // Если файл с логом ошибок существует, то загружаем его
          if FileExists(FFullLogPath) then
            begin
              LogFile.LoadFromFile(FFullLogPath);
              // Проверяем лог на дату создания
              IsOlderDay;
            end
          else
            LogFile.Add(DateToStr(Now)); // Пишем в лог текущую дату
        end;
      // Если уровень лога в пределах логирования, пишем всё в лог
      if Level >= FLogLevel then
        begin
          if PrintStack then
            begin
              StrList := TStringList.Create;
              try
                JclLastExceptStackListToStrings(StrList, True, True, True, True);
                StrList.Delimiter := #13;
                Stack := StrList.Text;
              finally
                FreeAndNil(StrList);
              end;
              LogFile.Add(Format('%s %s (%d) %d - %s at %s', [DateToStr(Now), TimeToStr(Now), GetCurrentThreadId, Ord(Level), Text, Stack])
                );
              ForLog := Format('(%d) %d - %s at %s', [GetCurrentThreadId, Ord(Level), Text, Stack]);
            end
          else
            begin
              LogFile.Add(Format('%s %s (%d) %d - %s', [DateToStr(Now), TimeToStr(Now), GetCurrentThreadId, Ord(Level), Text]));
              ForLog := Format('(%d) %d - %s', [GetCurrentThreadId, Ord(Level), Text]);
            end;
          // Сохраняем лог в файл в юникоде
          LogFile.SaveToFile(FFullLogPath, TEncoding.Unicode);
          // Выводим сообщение с ошибкой в окно лога и отображаем окно лога
          XShowForm(LogForm);
          XLog(Format(Log_Exception, [ForLog, FFullLogPath]));
        end;
    except
      //
    end;
  finally
    // Выходим из синхронизации
    CSection.Leave;
  end;
end;

procedure TLogger.WriteMessage(const Error: Exception);
begin
  if Error.ClassType <> EAbort then
    WriteMessage(Format('EXCEPTION: %s with message "%s"', [Error.ClassName, Error.message]), LError, True);
end;

procedure TLogger.WriteMessage(const ClassName, Text: string; Level: TLogLevel; const PrintStack: Boolean);
begin
  WriteMessage(ClassName + ': ' + Text, Level, PrintStack);
end;

procedure TLogger.WriteMessage(const Format: string; const Args: array of const ; Level: TLogLevel; const PrintStack: Boolean);
begin
  WriteMessage(SysUtils.Format(Format, Args), Level, PrintStack);
end;

initialization

// Запускаем эксперт ошибок
JclStartExceptionTracking;
TLogger.Instance := TLogger.Create;

finalization

// Останавливаем эксперт ошибок
JclStopExceptionTracking;

end.
