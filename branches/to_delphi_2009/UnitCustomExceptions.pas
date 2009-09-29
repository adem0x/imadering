unit UnitCustomExceptions;

interface

  uses classes, SysUtils;

  type
    TPluginException = class(Exception)
      constructor Create(ErrCode: HRESULT);
    end;

implementation

{ TPluginException }

constructor TPluginException.Create(ErrCode: HRESULT);
begin
  inherited Create(SysErrorMessage(ErrCode));
end;

end.
