unit ServerUtils;

interface

Uses
    SysTypes, System.SysUtils, RegularExpressions, IdURI, IdGlobal;

type
    TServerUtils = class
      class function ParseRESTURL (const Cmd : string): TArguments;
      class function Result2JSON (wsResult : TResultErro) : String;
    end;

implementation

// Retorna um array de strings com os parametros vindos da URL
// Ex de Cmd : 'GET /NomedoMetodo/Argumento1/Argumento2/ArgumentoN HTTP/1.1'
class function TServerUtils.ParseRESTURL (const Cmd : string): TArguments;
Var
     NewCmd       : String;
     iHttp        : Integer;
     ArraySize    : Integer;
     iBar1, IBar2 : Integer;
     Cont         : Integer;
begin
     NewCmd    := Cmd;
     ArraySize := TRegEx.Matches(NewCmd, '/').Count;
     SetLength(Result, ArraySize);
     NewCmd    := NewCmd + '/';

     iBar1 := Pos ('/', NewCmd);
     Delete (NewCmd, 1, iBar1);

     for Cont := 0 to ArraySize - 1 do begin
         iBar2 := Pos ('/', NewCmd);

            Result [Cont] := TIdURI.URLDecode (Copy (NewCmd, 1, iBar2 - 1), IndyTextEncoding (encUTF8));
         Delete (NewCmd, 1, iBar2);
     end;
end;

class function TServerUtils.Result2JSON (wsResult : TResultErro) : String;
Var
     SB: TStringBuilder;
begin
     SB := TStringBuilder.Create();
     SB.Append('{');
     SB.Append('"STATUS":"' + IntToStr(wsResult.STATUS) + '"');
     SB.Append(',"MENSAGEM":"' + wsResult.MENSAGEM + '"');
     SB.Append('}');

     Result := SB.ToString;
     SB.Free;
end;

end.

