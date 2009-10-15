// Изменения для проекта IMadering

unit rXML;

interface

uses
  Windows, Classes, SysUtils, SimpleXML, XMLStand, Dialogs;

// Идентификатор служебного тега
const
  ServiceTag = '<?xml version';

  // Описание версии XML
const
  XMLVersion = ServiceTag + '="1.0" encoding="UTF-16"?>';

type
  TrXML = class
  private
    FVersion: Boolean;
    FDoc: IXmlDocument;
    // Если 1-ая нода служебная, то не используем ее и
    // FNodePad должна быть 1, типа смещение ноды.
    FNodePad: Integer;
    FFollowNode: IXmlNode; // Текущая нода
    FCurrentPath: string;
    // Делаем попытку открыть ноду на 1 уровень ниже, чем у FollowNode
    // Если нет такой ноды, а есть параметр CanCreate, то пытаемся такую ноду создать
    function Open1Node(const AName: string; CanCreate: Boolean; Num: Integer)
      : Boolean;
    function GetNode: IXmlNode;
    function GetValueName(Index: Integer): string;
    function GetKeyName(Index: Integer): string;
    function GetText: string;
    procedure SetText(const Value: string);
  public
    constructor Create;
    procedure CloseKey;
    function CreateKey(const Key: string): Boolean;
    function DeleteKey(const Key: string): Boolean;
    function DeleteValue(const Name: string): Boolean;
    procedure GetKeyNames(Strings: TStrings);
    procedure GetValueNames(Strings: TStrings);
    function HasSubKeys: Boolean;
    function KeyExists(const Key: string): Boolean;
    function OpenKey(const Key: string; CanCreate: Boolean = False;
      Num: Integer = 0): Boolean;
    function GetKeyCount(const Name: string = ''): Integer;
    function GetValueCount: Integer;
    function ReadBool(const Name: string; Default: Boolean = False): Boolean;
    function ReadDate(const Name: string): TDateTime;
    function ReadDateTime(const Name: string): TDateTime;
    function ReadFloat(const Name: string; Default: double = 0): double;
    function ReadInteger(const Name: string; Default: Integer = 0): Integer;
    function ReadString(const Name: string): string;
    function ReadTime(const Name: string): TDateTime;
    function ValueExists(const Name: string): Boolean;
    procedure WriteBool(const Name: string; Value: Boolean);
    procedure WriteDate(const Name: string; Value: TDateTime);
    procedure WriteDateTime(const Name: string; Value: TDateTime);
    procedure WriteFloat(const Name: string; Value: double);
    procedure WriteInteger(const Name: string; Value: Integer);
    procedure WriteString(const Name, Value: string);
    procedure WriteTime(const Name: string; Value: TDateTime);
    function GetKeyValue(const AName: string): string;
    procedure SetKeyValue(const AName, aValue: string);
    function GetCurrentPath(): string;
    procedure Merge(const aText: string);
    procedure SetXMLVersionEnabled(aEnabled: Boolean);
    // XML текст для данной ветки
    function GetKeyXML: string;
    function GetKeyText: string;
    procedure SetKeyXML(const aValue: string);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    property FollowNode: IXmlNode read FFollowNode;
    property CurrentPath: string read GetCurrentPath;
    property Text: string read GetText write SetText;
    property ValueNames[Index: Integer]: string read GetValueName;
    property KeyNames[Index: Integer]: string read GetKeyName;
    property Version: Boolean read FVersion write FVersion;
    property KeyCount[const AName: string]: Integer read GetKeyCount;
    property ValueCount: Integer read GetValueCount;
    property KeyXML: string read GetKeyXML write SetKeyXML;
    property KeyValues[const AName: string]
      : string read GetKeyValue write SetKeyValue;
  end;

implementation

constructor TrXML.Create;
begin
  inherited;
  FVersion := True;
  FDoc := CreateXmlDocument;
  CloseKey;
end;

procedure TrXML.CloseKey;
var
  S: string;
begin
  FFollowNode := nil;
  FCurrentPath := '';
  // Сразу определим, служебная ли 1-ая нода
  FNodePad := 0;
  if FDoc.ChildNodes.Count <> 0 then
  begin
    S := FDoc.ChildNodes[0].XML;
    S := Copy(S, 1, length(ServiceTag));
    if AnsiCompareText(S, ServiceTag) = 0 then
      FNodePad := 1;
  end;
end;

function TrXML.CreateKey(const Key: string): Boolean;
var
  LastFollowNode: IXmlNode;
  S: string;
begin
  LastFollowNode := FFollowNode;
  S := FCurrentPath;
  Result := OpenKey(Key, True);
  FFollowNode := LastFollowNode;
  FCurrentPath := S;
end;

function TrXML.DeleteKey(const Key: string): Boolean;
var
  I: IXmlNode;
  S: string;
begin
  S := FCurrentPath;
  Result := OpenKey(Key, False);
  if not Result then
    Exit;
  I := FFollowNode;
  FFollowNode := I.ParentNode;
  FFollowNode.RemoveChild(I);
  CloseKey;
  if KeyExists(S) then
    OpenKey(S, False);
end;

function TrXML.DeleteValue(const Name: string): Boolean;
begin
  Result := ValueExists(Name);
  GetNode.RemoveAttr(Name);
end;

function TrXML.GetKeyXML: string;
begin
  Result := Trim(GetNode.XML);
end;

function TrXML.GetKeyText: string;
begin
  Result := Trim(GetNode.Text);
end;

procedure TrXML.SetKeyXML(const aValue: string);
begin
  GetNode.LoadNodeXML(aValue);
end;

function TrXML.GetKeyName(Index: Integer): string;
begin
  if FFollowNode = nil then
    Result := FDoc.ChildNodes[Index + FNodePad].NodeName
  else
    Result := FFollowNode.ChildNodes[index].NodeName;
end;

function TrXML.GetKeyCount(const Name: string = ''): Integer;
var
  I: Integer;
begin
  if FFollowNode = nil then
  begin
    if Name <> EmptyStr then
    begin
      Result := 0;
      for I := FNodePad to FDoc.ChildNodes.Count - 1 do
        if AnsiCompareText(Name, FDoc.ChildNodes[I].NodeName) = 0 then
          Inc(Result);
    end
    else
      Result := FDoc.ChildNodes.Count - FNodePad;
    Exit;
  end;
  if Name <> EmptyStr then
  begin
    Result := 0;
    for I := 0 to FFollowNode.ChildNodes.Count - 1 do
      if AnsiCompareText(Name, FFollowNode.ChildNodes[I].NodeName) = 0 then
        Inc(Result);
  end
  else
    Result := FFollowNode.ChildNodes.Count;
end;

procedure TrXML.GetKeyNames(Strings: TStrings);
var
  j: Integer;
  I: IXmlNode;
  n: Integer;
begin
  Strings.Clear;
  I := FFollowNode;
  n := 0;
  if I = nil then
  begin
    I := FDoc;
    n := FNodePad;
  end;
  for j := n to I.ChildNodes.Count - 1 do
    Strings.Add(I.ChildNodes[j].NodeName);
end;

function TrXML.GetNode: IXmlNode;
begin
  Result := FFollowNode;
  if Result = nil then
    Result := FDoc;
end;

function TrXML.GetValueName(Index: Integer): string;
begin
  Result := GetNode.AttrNames[Index];
end;

procedure TrXML.GetValueNames(Strings: TStrings);
var
  I: IXmlNode;
  j: Integer;
begin
  Strings.Clear;
  I := GetNode;
  for j := 0 to I.AttrCount - 1 do
    Strings.Add(I.AttrNames[j]);
end;

function TrXML.GetText: string;

// Строка из начала подлежит уничтожению
  function IsForDelete(const S: string): Boolean;
  begin
    Result := True;
    if Trim(S) = '' then
      Exit;
    if AnsiCompareText(ServiceTag, Copy(S, 1, length(ServiceTag))) = 0 then
      Exit;
    Result := False;
  end;

var
  Strings: TStringList;
begin
  Result := FDoc.XML;
  Strings := TStringList.Create;
  try
    Strings.Text := Result;
    // Удаляем пустые строки в начале
    while (Strings.Count > 0) and IsForDelete(Strings[0]) do
      Strings.Delete(0);
    if FVersion then
      Strings.Insert(0, XMLVersion);
    Result := Strings.Text;
  finally
    Strings.Free;
  end;
end;

function TrXML.HasSubKeys: Boolean;
begin
  if FFollowNode = nil then
  begin
    Result := (FDoc.ChildNodes.Count > FNodePad);
    Exit;
  end;
  Result := (FFollowNode.ChildNodes.Count <> 0);
end;

function TrXML.KeyExists(const Key: string): Boolean;
begin
  Result := False; // Warning
  try
    Result := OpenKey(Key);
  finally
    if Result then
      OpenKey('..');
  end;
end;

procedure TrXML.LoadFromFile(const FileName: string);
begin
  FDoc.Load(FileName);
  CloseKey;
end;

procedure TrXML.LoadFromStream(Stream: TStream);
begin
  FDoc.Load(Stream);
  CloseKey;
end;

function TrXML.Open1Node(const AName: string; CanCreate: Boolean; Num: Integer)
  : Boolean;
var
  I: IXmlNode;
  n, j: Integer;
  Founded: Integer;
begin
  Result := True;
  I := FFollowNode;
  n := 0;
  if I = nil then
  begin
    I := FDoc;
    n := FNodePad;
  end;
  // Проверим, не переход ли это на уровень выше
  if AName = '..' then
  begin
    if FFollowNode = nil then
      Exit;
    FFollowNode := FFollowNode.ParentNode;
    if AnsiCompareText(FFollowNode.NodeName, '#document') = 0 then
      FFollowNode := nil;
    Exit;
  end;
  // Ищем ноду с нужным названием
  Founded := 0;
  for j := n to I.ChildNodes.Count - 1 do
    if I.ChildNodes[j].NodeName = AName then
    begin
      Inc(Founded);
      if Founded > Num then
      begin
        FFollowNode := I.ChildNodes[j];
        Exit;
      end;
    end;
  // Не нашли
  if not CanCreate then
  begin
    Result := False;
    Exit;
  end;
  // Необходимо создать ноду
  { n := I.ChildNodes.Count;
    I.AppendElement(AName);
    if n = I.ChildNodes.Count then
    begin
    Result := false;
    Exit;
    end;
    FFollowNode := I.ChildNodes[ I.ChildNodes.Count - 1 ]; }
  FFollowNode := I.AppendElement(AName);
end;

function TrXML.OpenKey(const Key: string; CanCreate: Boolean; Num: Integer)
  : Boolean;
var
  LastFollowNode: IXmlNode;
  S, S1, sOldPath: string;
  I, n, k: Integer;
begin
  Result := True;
  if Key = EmptyStr then
    Exit;
  LastFollowNode := FFollowNode;
  sOldPath := FCurrentPath;
  // Начинаем открывать
  S := Key;
  if S[1] = '\' then
  begin
    CloseKey;
    S := Copy(S, 2, length(S) - 1);
  end;
  // Поехали
  n := WordCount(S, ['\']);
  for I := 1 to n do
  begin
    S1 := ExtractWord(I, S, ['\']);
    Result := Open1Node(S1, CanCreate, iif(I = n, Num, 0));
    if not Result then
    begin
      FFollowNode := LastFollowNode;
      FCurrentPath := sOldPath;
      Exit;
    end;
    if S1 = '..' then
    begin
      k := length(FCurrentPath);
      while k > 1 do
      begin
        if FCurrentPath[k] = '\' then
          Break;
        Dec(k);
      end;
      FCurrentPath := Copy(FCurrentPath, 1, k - 1);
    end
    else
      FCurrentPath := FCurrentPath + '\' + S1;
  end;
end;

function TrXML.ReadBool(const Name: string; Default: Boolean = False): Boolean;
begin
  Result := GetNode.GetBoolAttr(Name, Default)
end;

function TrXML.ReadDate(const Name: string): TDateTime;
begin
  Result := StrToDateFix(ReadString(Name));
end;

function TrXML.ReadDateTime(const Name: string): TDateTime;
begin
  Result := StrToDateTimeFix(ReadString(Name));
end;

function TrXML.ReadFloat(const Name: string; Default: double = 0): double;
begin
  Result := GetNode.GetFloatAttr(Name, Default);
end;

function TrXML.ReadInteger(const Name: string; Default: Integer = 0): Integer;
begin
  Result := GetNode.GetIntAttr(Name, Default);
end;

function TrXML.ReadString(const Name: string): string;
begin
  Result := GetNode.GetAttr(Name);
end;

function TrXML.ReadTime(const Name: string): TDateTime;
begin
  Result := StrToTimeFix(ReadString(Name));
end;

procedure TrXML.SaveToFile(const FileName: string);
var
  f: file;
  S: string;
begin
  AssignFile(f, FileName);
  Rewrite(f, 1);
  try
    S := Text;
    BlockWrite(f, S[1], length(S) * SizeOf(S[1]));
  finally
    CloseFile(f);
  end;
end;

procedure TrXML.SaveToStream(Stream: TStream);
var
  S: string;
begin
  S := GetText;
  Stream.WriteBuffer(S[1], length(S) * SizeOf(TXmlChar));
end;

procedure TrXML.SetText(const Value: string);
begin
  FDoc.LoadXML(Value);
  CloseKey;
end;

function TrXML.GetValueCount: Integer;
begin
  Result := GetNode.AttrCount;
end;

function TrXML.ValueExists(const Name: string): Boolean;
var
  j: Integer;
  I: IXmlNode;
begin
  Result := False;
  I := GetNode;
  for j := 0 to I.AttrCount - 1 do
    if Name = I.AttrNames[j] then
    begin
      Result := True;
      Break;
    end;
end;

procedure TrXML.WriteBool(const Name: string; Value: Boolean);
begin
  GetNode.SetBoolAttr(Name, Value);
end;

procedure TrXML.WriteDate(const Name: string; Value: TDateTime);
begin
  GetNode.SetAttr(Name, DateToStrFix(Value));
end;

procedure TrXML.WriteDateTime(const Name: string; Value: TDateTime);
begin
  GetNode.SetAttr(Name, DateTimeToStrFix(Value));
end;

procedure TrXML.WriteFloat(const Name: string; Value: double);
begin
  GetNode.SetFloatAttr(Name, Value);
end;

procedure TrXML.WriteInteger(const Name: string; Value: Integer);
begin
  GetNode.SetIntAttr(Name, Value);
end;

procedure TrXML.WriteString(const Name, Value: string);
begin
  GetNode.SetAttr(Name, Value);
end;

procedure TrXML.WriteTime(const Name: string; Value: TDateTime);
begin
  GetNode.SetAttr(Name, TimeToStrFix(Value));
end;

procedure TrXML.SetXMLVersionEnabled(aEnabled: Boolean);
begin
  FVersion := aEnabled;
end;

function TrXML.GetKeyValue(const AName: string): string;
begin
  Result := EmptyStr;
  if not KeyExists(AName) then
    Exit;
  if OpenKey(AName, False) then
    try
      Result := ReadString('value');
    finally
      OpenKey('..', False);
    end;
end;

procedure TrXML.SetKeyValue(const AName, aValue: string);
begin
  if OpenKey(AName, True) then
    try
      WriteString('value', aValue);
    finally
      OpenKey('..', False);
    end;
end;

procedure TrXML.Merge(const aText: string);
var
  x: TrXML;

  procedure __appendxml(aCanCreate: Boolean);
  var
    I: Integer;
    k, S: string;
  begin
    for I := 0 to x.ValueCount - 1 do
    begin
      k := x.ValueNames[I];
      S := x.ReadString(k);
      WriteString(k, S);
    end;
    for I := 0 to x.KeyCount[''] - 1 do
    begin
      k := x.KeyNames[I];
      if x.OpenKey(k, aCanCreate) then
      begin
        if OpenKey(k, aCanCreate) then
        begin
          __appendxml(True);
          OpenKey('..', False);
        end;
        x.OpenKey('..', False);
      end;
    end;
  end;

begin
  OpenKey('\');
  x := TrXML.Create();
  try
    x.Text := aText;
    __appendxml(False);
  finally
    x.Free();
  end;
end;

function TrXML.GetCurrentPath: string;
begin
  Result := FCurrentPath;
end;

end.
