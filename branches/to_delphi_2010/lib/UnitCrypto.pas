unit UnitCrypto;

interface

uses classes;

const
  CALG_RC4 = ((3 shl 13) or (4 shl 9) or 1);
  CALG_RC2 = ((3 shl 13) or (3 shl 9) or 2);
  def: string =
    'WrSxnCNBpJ7Ko4[e",7Ty)a0ykP)62Ce[.bAA;SuOf4*{nagx4s,;5!eHU!v=p3z';

  /// <summary>Кодирует строку</summary>
function EncryptString(s: string; pass: string; alg: Cardinal = CALG_RC4)
  : string;
/// <summary>декодирует строку</summary>
function DecryptString(s: string; pass: string; alg: Cardinal = CALG_RC4)
  : string;

/// <summary>Кодирует поток</summary>
function EncryptStream(s: TStream; pass: string; alg: Cardinal = CALG_RC4)
  : TStream;
/// <summary>декодирует поток</summary>
function DecryptStream(s: TStream; pass: string; alg: Cardinal = CALG_RC4)
  : TStream;

function GenerateUniqPassByMac(): string;

var
  PasswordByMac: string;

implementation

uses NB30, SysUtils, EncdDecd;
{$REGION 'Declarations'}

const
  ADVAPI32 = 'advapi32.dll';
  PROV_RSA_FULL = 1;
  CRYPT_VERIFYCONTEXT = $F0000000;
  CALG_SHA = ((4 shl 13) or 0 or 4);

type
  HCRYPTPROV = Cardinal;
  HCRYPTKEY = Cardinal;
  ALG_ID = Cardinal;
  PHCRYPTPROV = ^HCRYPTPROV;
  PHCRYPTKEY = ^HCRYPTKEY;
  LPAWSTR = PWideChar;
  HCRYPTHASH = Cardinal;
  PHCRYPTHASH = ^HCRYPTHASH;

function CryptReleaseContext(hProv: HCRYPTPROV; dwFlags: LongWord): LongBool;
  stdcall; external ADVAPI32 name 'CryptReleaseContext';
function CryptAcquireContext(Prov: PHCRYPTPROV; Container: LPAWSTR;
  Provider: LPAWSTR; ProvType: LongWord; Flags: LongWord): LongBool; stdcall;
external ADVAPI32 name 'CryptAcquireContextW';
function CryptEncrypt(Key: HCRYPTKEY; Hash: HCRYPTHASH; Final: LongBool;
  Flags: LongWord; Data: PBYTE; Len: PLongWord; BufLen: LongWord): LongBool;
  stdcall; external ADVAPI32 name 'CryptEncrypt';
function CryptDecrypt(Key: HCRYPTKEY; Hash: HCRYPTHASH; Final: LongBool;
  Flags: LongWord; Data: PBYTE; Len: PLongWord): LongBool; stdcall;
external ADVAPI32 name 'CryptDecrypt';
function CryptCreateHash(Prov: HCRYPTPROV; Algid: ALG_ID; Key: HCRYPTKEY;
  Flags: LongInt; Hash: PHCRYPTHASH): LongBool; stdcall;
external ADVAPI32 name 'CryptCreateHash';
function CryptHashData(Hash: HCRYPTHASH; Data: PBYTE; DataLen: LongInt;
  Flags: LongInt): LongBool; stdcall; external ADVAPI32 name 'CryptHashData';
function CryptDeriveKey(Prov: HCRYPTPROV; Algid: ALG_ID; BaseData: HCRYPTHASH;
  Flags: LongInt; Key: PHCRYPTKEY): LongBool; stdcall;
external ADVAPI32 name 'CryptDeriveKey';
function CryptDestroyHash(hHash: HCRYPTHASH): LongBool; stdcall;
external ADVAPI32 name 'CryptDestroyHash';
{$ENDREGION}
{$REGION 'ROUTINE'}

function ByteToHex(b: byte): string;
  function GetChar(b: byte): char;
  begin
    if b < 10 then
      Result := chr(Ord('0') + b)
    else
      Result := chr(Ord('A') - 10 + b);
  end;

begin
  Result := GetChar(b div 16) + GetChar(b mod 16);
end;

function StringToHex(const s: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(s) do
    Result := Result + ByteToHex(Ord(s[i]));
end;

function StrToIntDef(s: string; def: integer): integer;
var
  i, c: integer;
begin
  Val(s, i, c);
  if c = 0 then
    Result := i
  else
    Result := def;
end;

function HexToString(const s: string): string;
var
  i: integer;
begin
  Result := '';
  for i := 1 to Length(s) div 2 do
    try
      Result := Result + chr(StrToIntDef('$' + copy(s, i * 2 - 1, 2), 32));
    except
      Result := Result + '?';
    end;
end;

procedure InitPass(pass: string; alg: LongWord; var hProv: HCRYPTPROV;
  var hSKey: HCRYPTKEY);
var
  Hash: HCRYPTHASH;
begin
  CryptAcquireContext(@hProv, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT);
  CryptCreateHash(hProv, CALG_SHA, 0, 0, @Hash);
  CryptHashData(Hash, @pass[1], Length(pass), 0);
  CryptDeriveKey(hProv, alg, Hash, 0, @hSKey);
  CryptDestroyHash(Hash);
end;
{$ENDREGION}

function EncryptString(s: string; pass: string; alg: Cardinal = CALG_RC4)
  : string;
var
  p: PBYTE;
  sz: LongWord;
  hProv: HCRYPTPROV;
  hSKey: HCRYPTKEY;
begin
  InitPass(pass, alg, hProv, hSKey);
  Insert(chr(Random(256)), s, 1);
  sz := Length(s);
  GetMem(p, sz + 8);
  move(s[1], p^, sz);
  if CryptEncrypt(hSKey, 0, true, 0, p, @sz, sz + 8) then
  begin
    SetLength(Result, sz);
    move(p^, Result[1], sz);
    Result := StringToHex(Result);
  end
  else
    Result := s;
  FreeMem(p);
  CryptReleaseContext(hProv, 0);
end;

function DecryptString(s: string; pass: string; alg: Cardinal = CALG_RC4)
  : string;
var
  p: PBYTE;
  sz: LongWord;
  hProv: HCRYPTPROV;
  hSKey: HCRYPTKEY;
begin
  InitPass(pass, alg, hProv, hSKey);
  s := HexToString(s);
  sz := Length(s);
  GetMem(p, sz);
  move(s[1], p^, sz);
  if CryptDecrypt(hSKey, 0, true, 0, p, @sz) then
  begin
    SetLength(Result, sz);
    move(p^, Result[1], sz);
    delete(Result, 1, 1);
  end
  else
    Result := s;
  FreeMem(p);
  CryptReleaseContext(hProv, 0);
end;

function EncryptStream(s: TStream; pass: string; alg: Cardinal = CALG_RC4)
  : TStream;
var
  input: string;
  output: string;
begin
  SetLength(input, s.Size);
  s.Read(Pointer(input)^, s.Size);

  output := EncryptString(input, pass, alg);

  Result := TMemoryStream.Create;
  Result.WriteBuffer(Pointer(output)^, Length(output));
  Result.Seek(0, soFromBeginning);
end;

function DecryptStream(s: TStream; pass: string; alg: Cardinal = CALG_RC4)
  : TStream;
var
  input: string;
  output: string;
begin
  SetLength(input, s.Size);
  s.Read(Pointer(input)^, s.Size);

  output := DecryptString(input, pass, alg);

  Result := TMemoryStream.Create;
  Result.WriteBuffer(Pointer(output)^, Length(output));
  Result.Seek(0, soFromBeginning);
end;

// ----------------------------------------------------

function GetAdapterInfo(Lana: char): String;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := char(NCBRESET);
  NCB.ncb_lana_num := AnsiChar(Lana);
  if Netbios(@NCB) <> char(NRC_GOODRET) then
  begin
    Result := '';
    Exit;
  end;

  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := char(NCBASTAT);
  NCB.ncb_lana_num := AnsiChar(Lana);
  NCB.ncb_callname := '*';

  FillChar(Adapter, SizeOf(Adapter), 0);
  NCB.ncb_buffer := @Adapter;
  NCB.ncb_length := SizeOf(Adapter);
  if Netbios(@NCB) <> char(NRC_GOODRET) then
  begin
    Result := '';
    Exit;
  end;

  Result := IntToHex(byte(Adapter.adapter_address[0]), 2) + '-' + IntToHex
    (byte(Adapter.adapter_address[1]), 2) + '-' + IntToHex
    (byte(Adapter.adapter_address[2]), 2) + '-' + IntToHex
    (byte(Adapter.adapter_address[3]), 2) + '-' + IntToHex
    (byte(Adapter.adapter_address[4]), 2) + '-' + IntToHex
    (byte(Adapter.adapter_address[5]), 2);
end;

function GetMacAddress: string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if byte(AdapterList.Length) > 0 then
    Result := GetAdapterInfo(char(AdapterList.Lana[0]))
  else
    Result := def;
end;

function GenerateUniqPassByMac(): string;
var
  mac: String;
begin
  mac := GetMacAddress;
  Result := EncodeString(mac) + mac + EncodeString(mac);
end;

initialization

Randomize;
PasswordByMac := GenerateUniqPassByMac;

end.
