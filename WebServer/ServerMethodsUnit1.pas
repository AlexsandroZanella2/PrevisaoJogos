unit ServerMethodsUnit1;

interface

uses System.Math, System.SysUtils, System.Classes, System.JSON, Dialogs, ServerUtils, SysTypes, vcl.Forms,FIBDatabase, pFIBDatabase,
Data.DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, dateutils;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
    Function ReturnErro : String;

    {_____________CADASTRO__________________________}

    // http://localhost:8080/PutNovoCadastro/fulano/senha/email/cpf/filtroprobs/dtnascimento
    function PutNovoCadastro (Nome, Senha, email, cpf,filtroprobs, dtnascimento  : String) : String;

    // http://localhost:8080/ConsultaCadastro/nome.CPF.email/senha
    function ConsultaCadastro (NomeEmailCpf,Senha : String) : String;

    // http://localhost:8080/AtualizaCadastro/OldNome/NewNome/OldPass/newPass/OldEmail/NewEmail/OldFiltroProbs/NewFiltroProbs
    function AtualizaCadastro  (OldNome,             // Nome Antigo
                                NewNome,             // Nome Novo
                                OldPass,             // Senha Antiga
                                newPass,             // Senha Nova
                                OldEmail,            // Email Antigo
                                NewEmail,            // Email Novo
                                OldFiltroProbs,      // Filtro de probalilidades antigo
                                NewFiltroProbs : String) : String;// '' novo

    // http://localhost:8080/ExcluiCadastro/NomeCadastro/senha/email,cpf
    function ExcluiCadastro (Nome, senha, email, cpf : String) : String;

    {_____________JOGOS__________________________}

     // http://localhost:8080/GetListaJogosPassados/usuario/senha/data
    function GetListaJogosPassados(usuario,senha,data:string) : String;

    // http://localhost:8080/GetListaJogosFuturos/usuario/senha/probs
    function GetListaJogosFuturos(usuario,senha,probs:string)  : String;

    // http://localhost:8080/GetListaJogosAtuais/usuario/senha/probs
    function GetListaJogosAtuais(usuario,senha,probs:string)   : String;


    function GetValidarAssinatura(usuario, senha, chaveD:string):string;
      //http://botstenisdemesa.ddns.net:8080/GetValidaAssinatura/usuario/senha/chave

    function GetFFRjkSFDc(tempo:string):string;
      //http://botstenisdemesa.ddns.net:8080/GetFFRjkSFDc/tempo
  public
    { Public declarations }
    Constructor Create              (aOwner     : TComponent); Override;
    Destructor Destroy; Overload;
    function CallGETServerMethod    (Argumentos : TArguments) : String;
    function CallPUTServerMethod    (Argumentos : TArguments) : string;
    function CallDELETEServerMethod (Argumentos : TArguments) : string;
    function CallPOSTServerMethod   (Argumentos : TArguments) : string;
    const chave = '*&&¨%&%$&#¨$#@¨³£¢¬²³¬~]´~]/;;.gfhkmSDFFR$345%#5459ihj*+.fd';
  end;
{$METHODINFO OFF}

var
  database          : TpFibDatabase     ;
  transacao_dataset : TpFibTransaction  ;
  transacao_Query   : TpFibTransaction  ;
  transacao_Aux     : TpFibTransaction  ;
  dataset           : TpFibDataset      ;
  Query             : TpFibQuery        ;
  Aux               : TpFibDataset      ;

implementation


uses System.StrUtils;


Constructor TServerMethods1.Create (aOwner : TComponent);
Begin
     inherited Create (aOwner);
     database           :=  TpFIBDatabase.Create(nil)     ;
     transacao_dataset  :=  TpFIBTransaction.Create(nil)  ;
     transacao_Query    :=  TpFIBTransaction.Create(nil)  ;
     transacao_Aux      :=  TpFIBTransaction.Create(nil)  ;
     Dataset            :=  TpFIBDataSet.Create(nil)      ;
     Query              :=  TpFIBQuery.Create(nil)        ;
     Aux                :=  TpFIBDataSet.Create(nil)        ;

     database.ConnectParams.Password := 'masterkey';
     database.ConnectParams.UserName := 'SYSDBA';
     database.DBName              := 'localhost:C:\ServicoExtracao\DADOS.FDB';
     database.SQLDialect          := 3;
     database.DefaultTransaction  := transacao_dataset;

     Dataset.Database             := database;
     Query.Database               := database;
     Aux.Database                 := database;

     dataset.Transaction          := transacao_dataset;
     Query.Transaction            := transacao_Query;
     Aux.Transaction              := transacao_Aux;

     transacao_dataset.DefaultDatabase  := database;
     transacao_Query.DefaultDatabase    := database;
     transacao_Aux.DefaultDatabase      := database;

End;

Destructor TServerMethods1.Destroy;
begin
     inherited;
End;


function Cripto(Action, Src, Key: string): string;
var
  KeyLen: Integer;
  KeyPos: Integer;
  offset: Integer;
  dest: string;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
  s: string[255];
  C: array [0 .. 255] of Byte absolute s;
begin
  if Src = '' then
  begin
    result := '';
    exit;
  end;
  dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
//  SrcPos := 0;
//  SrcAsc := 0;
  Range := 256;
  if Action = UpperCase('E') then
  begin
    Randomize;
    offset := Random(Range);
    dest := format('%1.2x', [offset]);
    for SrcPos := 1 to Length(Src) do
    begin
      SrcAsc := (Ord(Src[SrcPos]) + offset) MOD 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      dest := dest + format('%1.2x', [SrcAsc]);
      offset := SrcAsc;
    end;
  end;
  if Action = UpperCase('D') then
  begin
    offset := StrToInt('$' + Copy(Src, 1, 2));
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$' + Copy(Src, SrcPos, 2));
      if KeyPos < KeyLen Then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= offset then
        TmpSrcAsc := 255 + TmpSrcAsc - offset
      else
        TmpSrcAsc := TmpSrcAsc - offset;
      dest := dest + chr(TmpSrcAsc);
      offset := SrcAsc;
      SrcPos := SrcPos + 2;
    until SrcPos >= Length(Src);
  end;
  Cripto := dest;
end;

Function TServerMethods1.ReturnErro : String;
Var
     WSResult : TResultErro;
begin
     WSResult.STATUS   := -1;
     WSResult.MENSAGEM := 'Total de argumentos incorretos';
     Result := TServerUtils.Result2JSON(WSResult);
end;

function TServerMethods1.CallGETServerMethod (Argumentos : TArguments) : string;
begin
     if UpperCase(Argumentos[0]) = UpperCase('ConsultaCadastro') then begin
        if Length (Argumentos) = 3 then
           Result := ConsultaCadastro (Argumentos[1],Argumentos[2])
        Else
           Result := ReturnErro;
     end;
         // http://localhost:8080/GetListaJogosPassados/usuario/senha/data
     if UpperCase(Argumentos[0]) = UpperCase('GetListaJogosPassados') then begin
        if Length (Argumentos) = 4 then
           Result := GetListaJogosPassados(Argumentos[1],Argumentos[2],Argumentos[3])
        Else
           Result := ReturnErro;
     end;

     if UpperCase(Argumentos[0]) = UpperCase('GetListaJogosFuturos') then begin
        if Length (Argumentos) = 4 then
           Result := GetListaJogosFuturos(Argumentos[1],Argumentos[2],Argumentos[3])
        Else
           Result := ReturnErro;
     end;

     if UpperCase(Argumentos[0]) = UpperCase('GetValidarAssinatura') then begin
        if Length (Argumentos) = 4 then
           Result := GetValidarAssinatura(Argumentos[1],Argumentos[2],Argumentos[3])
        Else
           Result := ReturnErro;
     end;

     if UpperCase(Argumentos[0]) = UpperCase('GetFFRjkSFDc') then begin
        if Length (Argumentos) = 2 then
           Result := GetFFRjkSFDc(Argumentos[1])
        Else
           Result := 'Houve algum problema ao solicitar, entre em contato com o administrador';
     end;


     if UpperCase(Argumentos[0]) = UpperCase('GetListaJogosAtuais') then begin
        if Length (Argumentos) = 4 then
           Result := GetListaJogosAtuais(Argumentos[1],Argumentos[2],Argumentos[3])
        Else
           Result := ReturnErro;
     end;

     if UpperCase(Argumentos[0]) = UpperCase('PutNovoCadastro') then begin
        if Length (Argumentos) = 7 then
           Result := PutNovoCadastro (Argumentos[1], Argumentos[2],Argumentos[3],Argumentos[4],Argumentos[5],Argumentos[6])
        Else
           Result := ReturnErro;
     end;

     if UpperCase(Argumentos[0]) = UpperCase('AtualizaCadastro') then begin
        if Length (Argumentos) = 9 then
            //OldNome, NewNome,OldPass, newPass, OldFiltroProbs, NewFiltroProbs
           Result := AtualizaCadastro (Argumentos[1], Argumentos[2],Argumentos[3], Argumentos[4],Argumentos[5], Argumentos[6],Argumentos[7], Argumentos[8])
        Else
           Result := ReturnErro;
     end;
end;

function TServerMethods1.CallPOSTServerMethod (Argumentos : TArguments) : string;
           //OldNome, NewNome,OldPass, newPass, OldFiltroProbs, NewFiltroProbs
begin
     if UpperCase(Argumentos[0]) = UpperCase('AtualizaCadastro') then begin
        if Length (Argumentos) = 9 then
           Result := AtualizaCadastro (Argumentos[1], Argumentos[2],Argumentos[3], Argumentos[4],Argumentos[5], Argumentos[6],Argumentos[7], Argumentos[8])
        Else
           Result := ReturnErro;
     end;
end;

function TServerMethods1.CallPUTServerMethod (Argumentos : TArguments) : string;
         // /PutNovoCadastro/fulano/senha/email/cpf/filtroprobs/nascimento
begin
     if UpperCase(Argumentos[0]) = UpperCase('PutNovoCadastro') then begin
        if Length (Argumentos) = 7 then
           Result := PutNovoCadastro (Argumentos[1], Argumentos[2],Argumentos[3],Argumentos[4],Argumentos[5],Argumentos[6])
        Else
           Result := ReturnErro;
     end;
end;

function TServerMethods1.CallDELETEServerMethod (Argumentos : TArguments) : string;
begin
     if UpperCase(Argumentos[0]) = UpperCase('ExcluiCadastro') then begin
        if Length (Argumentos) = 5 then
           Result := ExcluiCadastro (Argumentos[1],Argumentos[2],Argumentos[3],Argumentos[4])
        Else
           Result := ReturnErro;
     end;
end;

// Aqui voce vai
// 1 - Conectar com o Banco
// 2 - Executar a query
// 3 - Fechar conexão com o banco
// 4 - Retornar o resultado em JSON

// Foi usado um Arquivo Texto para armazenar dados e um StringList
// o objetivo aqui é apenas mostrar como é um WebService REST + JSON
// e suas operações, o codigo de banco fica por sua conta.

function TServerMethods1.PutNovoCadastro (Nome, Senha, email, cpf,filtroprobs, dtnascimento : String) : String;
Var                               //http://localhost:8080/PutNovoCadastro/teste/senha/email/111.111.111-11/20/01.01.1999
     JSONObject : TJSONObject;
Begin
     JSONObject := TJSONObject.Create;
     try
         //Pesquisa cpf
         database.Open;


         dataset.Close;
         dataset.SelectSQL.Text := 'select * from usuarios ' +
                                   'where cpf   = '  +char(39) + cpf +char(39);
         dataset.Open;
         dataset.First;
         // se nao existe: registrar
         if dataset.Eof then begin
           query.SQL.Text := 'insert into USUARIOS '+
                             'values(GEN_ID(gen_usuarios_id,1)'               +', ' +
                                         char(39) + nome + char(39)+ ' , '+
                                         char(39) + senha+ char(39)+ ' , '+
                                         char(39) + email+ char(39)+ ' , '+
                                         char(39) + cpf  + char(39)+ ' , '+
                                         char(39)+ formatdatetime('dd.MM.yyyy ',now) + '23:59' + char(39)+' , '+
                                         filtroprobs + ' , '+
                                         char(39) + dtnascimento + char(39) + ')';

            try
              if (database.Connected = false) or (transacao_Query.Active = false) then begin
                  database.Open;
                  transacao_Query.Active := true;
              end;
              query.ExecQuery;
              transacao_Query.Commit;
            finally
              JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
              JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Inserido com sucesso'));
              Result := JSONObject.ToString;
            end;
         end else begin

         //se existe: erro

            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'Usuário já cadastrado'));
            Result := JSONObject.ToString;
         end;



     Finally
         JSONObject.Free;
     end;
     dataset.Close;
End;

function TServerMethods1.ConsultaCadastro (NomeEmailCpf,Senha : String) : String;
Var
     List : TStringList;
     JSONObject : TJSONObject;
     ID : Integer;
Begin
     JSONObject := TJSONObject.Create;
     try
         //Busca o Cadastro no Banco
         database.Open;


         dataset.Close;
         dataset.SelectSQL.Text := 'select * from usuarios ' +
                                   'where senha = '+char(39)+Senha+char(39)+ ' ' +
                                   'and ((cpf = '+char(39)+ NomeEmailCpf +char(39)+') or (' +
                                   'nome = '+char(39)+ NomeEmailCpf + char(39)+') or ('+
                                   'email = '+char(39)+ NomeEmailCpf +char(39)+')) ';

         dataset.Open;
         dataset.First;
           //SE HÁ O USUÁRIO
         if not(dataset.Eof) then begin
              //true = vazio        not = Falso
              //falso = há registro not = True
            JSONObject.AddPair(TJSONPair.Create('USER', dataset.FieldByName('nome').AsString));
            JSONObject.AddPair(TJSONPair.Create('EMAIL', dataset.FieldByName('email').AsString));
            JSONObject.AddPair(TJSONPair.Create('CPF', dataset.FieldByName('cpf').AsString));
            JSONObject.AddPair(TJSONPair.Create('DATAPERMISSAO', formatdatetime('dd.MM.yyyy hh:mm',strtodatetime(dataset.FieldByName('data_permissao').AsString))));
            JSONObject.AddPair(TJSONPair.Create('FILTRO', dataset.FieldByName('perc_filtro_jogos').AsString));
            JSONObject.AddPair(TJSONPair.Create('NASC', dataset.FieldByName('nascimento').AsString));
            JSONObject.AddPair(TJSONPair.Create('CHAVE', dataset.FieldByName('cod').AsString));
            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'lOGINOK'));
            Result := JSONObject.ToString;
         end else begin
            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'LOGINERROR'));
            Result := JSONObject.ToString;
         end;

     Finally
         JSONObject.Free;
     end;
end;

function TServerMethods1.GetFFRjkSFDc(tempo:string):string;
var
dataNova:tdate;
datastring:string;
datacriptada:string;
i:integer;
LJsonObject : TJSONObject;
begin
try
  i:= strtoint(tempo);
  dataNova := IncMonth(now, i);
  datastring := FormatDateTime('dd.MM.yyyy',dataNova);
  datacriptada := Cripto('E',(datastring + ' 23:59'),chave);

            Result := 'Essa é sua chave de ativação de assinatura: '+ datacriptada;
except
  ShowMessage('Parâmetros incorretos!');
end;
end;

function TServerMethods1.GetValidarAssinatura(usuario: string; senha: string; chaveD: string):string;
Var
     ID          : Integer;
     LJson       : TJSONObject;
     LJsonObject : TJSONObject;
     LArr        : TJSONArray;
     permissaoTExt:string;
     permissaoDateTime:tDateTime;
     t1,t2,t3:string;
Begin
     LJsonObject := TJSONObject.Create;
     LArr        := TJSONArray.Create;

     database.Open;


     dataset.Close;
     dataset.SelectSQL.Text :=  'select * from usuarios '+
                                'where ((nome = '+char(39)+usuario+char(39)+ ') or ( '+
                                'cpf = '+char(39)+usuario+char(39)+ ') or ( '+
                                'email = '+char(39)+usuario+char(39)+ ')) '+
                                'and senha = '+char(39)+senha+char(39);

     dataset.Open;
     dataset.First;
  if not(dataset.Eof) then begin

     try
        permissaoTExt := Cripto('D',chaveD,chave );
        permissaoDateTime := strtodatetime(permissaoTExt);
     except
            LJsonObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            LJsonObject.AddPair(TJSONPair.Create('MENSAGEM', 'LOGINERROR'));
            Result := LJsonObject.ToString;
            abort;
     end;



     try

         dataset.Close;
         query.SQL.Text := 'update Jogos_tenismesa '+
                           'set data_permissao = ' + char(39) +permissaoTExt+char(39) + ' ' +
                           'where cpf = '+ char(39) +usuario+char(39);


          if (database.Connected = false) or (transacao_Query.Active = false) then begin
                  database.Open;
                  transacao_Query.Active := true;
              end;
              query.ExecQuery;
              transacao_Query.Commit;



     finally
            LJsonObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            LJsonObject.AddPair(TJSONPair.Create('MENSAGEM', permissaoTExt));
            Result := LJsonObject.ToString;
     end;

  end else begin
        try
            LJsonObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            LJsonObject.AddPair(TJSONPair.Create('MENSAGEM', 'LOGINERROR'));
            Result := LJsonObject.ToString;
        finally
            LJsonObject.Free;
        end;
  end;
end;

function TServerMethods1.GetListaJogosPassados(usuario,senha,data:string) : String;
      // http://localhost:8080/GetListaJogosPassados/usuario/senha/data
Var
     ID          : Integer;
     LJson       : TJSONObject;
     LJsonObject : TJSONObject;
     LArr        : TJSONArray;
Begin
     LJsonObject := TJSONObject.Create;
     LArr        := TJSONArray.Create;

     database.Open;


     dataset.Close;
     dataset.SelectSQL.Text :=  'select * from usuarios '+
                                'where ((nome = '+char(39)+usuario+char(39)+ ') or ( '+
                                'cpf = '+char(39)+usuario+char(39)+ ') or ( '+
                                'email = '+char(39)+usuario+char(39)+ ')) '+
                                'and senha = '+char(39)+senha+char(39) + ' ' +
                                'and data_permissao >= ' + char(39) + formatdatetime('dd.MM.yyyy hh:mm',now)+char(39);

     dataset.Open;
     dataset.First;
  if not(dataset.Eof) then begin

     try

         dataset.Close;
         dataset.SelectSQL.Text :='select * from jogos_tenismesa '+
                                  'where  data_jogo < ' + char(39) +
                                  data +' 23:59'+char(39) + ' '+
                                  'and data_jogo > '+ char(39) + data + ' 00:00'+char(39);
         dataset.Open;
         dataset.First;

         while not(dataset.Eof) do Begin
             LJson := TJSONObject.Create;
             LJson.AddPair(TJSONPair.Create('CODIGO', dataset.FieldByName('codigo').AsString));
             LJson.AddPair(TJSONPair.Create('COMPETICAO', dataset.FieldByName('nome_competicao').AsString));
             LJson.AddPair(TJSONPair.Create('JOGADORES', (dataset.FieldByName('jogador1').AsString + ' X ' + dataset.FieldByName('jogador2').AsString)));
             LJson.AddPair(TJSONPair.Create('RESULTADO', (dataset.FieldByName('resultado1').AsString + ' : ' + dataset.FieldByName('resultado2').AsString)));
             LJson.AddPair(TJSONPair.Create('DATAJOGO', formatdatetime('dd.MM.yyyy hh:mm',strtodatetime(dataset.FieldByName('data_jogo').Asstring))));
             LJson.AddPair(TJSONPair.Create('TIPO', dataset.FieldByName('tipo').AsString));
             LJson.AddPair(TJSONPair.Create('NUMSETS', dataset.FieldByName('num_sets').AsString));
             LJson.AddPair(TJSONPair.Create('PONTOSJ1', dataset.FieldByName('pontosj1').AsString));
             LJson.AddPair(TJSONPair.Create('PONTOSJ2', dataset.FieldByName('pontosj2').AsString));
             LJson.AddPair(TJSONPair.Create('TOTALPONTOS', dataset.FieldByName('totalpontos').AsString));
             LArr.Add(LJson);
             dataset.Next;
         End;

         LJsonObject.AddPair(TJSONPair.Create('JOGOS', LArr));
         Result := LJsonObject.ToString;
     Finally
         dataset.Close;
         LJsonObject.Free;
     end;
  end else begin
        try
            LJsonObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            LJsonObject.AddPair(TJSONPair.Create('MENSAGEM', 'LOGINERROR'));
            Result := LJsonObject.ToString;
        finally
            LJsonObject.Free;
        end;
  end;
end;

function TServerMethods1.GetListaJogosFuturos(usuario,senha,probs:string) : String;
Var
     ID          : Integer;
     LJson       : TJSONObject;
     LJsonObject : TJSONObject;
     LArr        : TJSONArray;
Begin
     LJsonObject := TJSONObject.Create;
     LArr        := TJSONArray.Create;

     database.Open;


     dataset.Close;
     dataset.SelectSQL.Text :=  'select * from usuarios '+
                                'where ((nome = '+char(39)+usuario+char(39)+ ') or ( '+
                                'cpf = '+char(39)+usuario+char(39)+ ') or ( '+
                                'email = '+char(39)+usuario+char(39)+ ')) '+
                                'and senha = '+char(39)+senha+char(39) + ' ' +
                                'and data_permissao >= ' + char(39) + formatdatetime('dd.MM.yyyy hh:mm',now)+char(39);

     dataset.Open;
     dataset.First;
  if not(dataset.Eof) then begin
    try

         dataset.Close;
         dataset.SelectSQL.Text :='select * from jogos_tenismesa '+
                                  'where  data_jogo > ' + char(39)+formatdatetime('dd.MM.yyyy ',incday(now,+1))+'00:00'+char(39);
         dataset.Open;
         dataset.First;

         while not(dataset.Eof) do Begin
             LJson := TJSONObject.Create;
             LJson.AddPair(TJSONPair.Create('CODIGO', dataset.FieldByName('codigo').AsString));
             LJson.AddPair(TJSONPair.Create('COMPETICAO', dataset.FieldByName('nome_competicao').AsString));
             LJson.AddPair(TJSONPair.Create('JOGADORES', (dataset.FieldByName('jogador1').AsString + ' X ' + dataset.FieldByName('jogador2').AsString)));
             LJson.AddPair(TJSONPair.Create('DATAJOGO', formatdatetime('dd.MM.yyyy hh:mm',strtodatetime(dataset.FieldByName('data_jogo').Asstring))));
             LJson.AddPair(TJSONPair.Create('TIPO', dataset.FieldByName('tipo').AsString));
             LJson.AddPair(TJSONPair.Create('PROB1', dataset.FieldByName('PROB1').AsString));
             LJson.AddPair(TJSONPair.Create('PROB2', dataset.FieldByName('PROB2').AsString));
             LJson.AddPair(TJSONPair.Create('PREVNUMSETS', dataset.FieldByName('prev_num_sets').AsString));
             LJson.AddPair(TJSONPair.Create('PREVPONTOSJ1', dataset.FieldByName('prev_pontosj1').AsString));
             LJson.AddPair(TJSONPair.Create('PREVPONTOSJ2', dataset.FieldByName('prev_pontosj2').AsString));
             LJson.AddPair(TJSONPair.Create('PREVTOTALPONTOS', dataset.FieldByName('prev_totalpontos').AsString));
             LArr.Add(LJson);
             dataset.Next;
         End;

         LJsonObject.AddPair(TJSONPair.Create('JOGOS', LArr));
         Result := LJsonObject.ToString;
     Finally
         dataset.Close;
         LJsonObject.Free;
     end;
  end;
End;

function TServerMethods1.GetListaJogosAtuais(usuario,senha,probs:string) : String;
Var
     ID          : Integer;
     LJson       : TJSONObject;
     LJsonObject : TJSONObject;
     LArr        : TJSONArray;
Begin
     LJsonObject := TJSONObject.Create;
     LArr        := TJSONArray.Create;

     database.Open;


     dataset.Close;
     dataset.SelectSQL.Text :=  'select * from usuarios '+
                                'where ((nome = '+char(39)+usuario+char(39)+ ') or ( '+
                                'cpf = '+char(39)+usuario+char(39)+ ') or ( '+
                                'email = '+char(39)+usuario+char(39)+ ')) '+
                                'and senha = '+char(39)+senha+char(39) + ' ' +
                                'and data_permissao >= ' + char(39) + formatdatetime('dd.MM.yyyy hh:mm',now)+char(39);

     dataset.Open;
     dataset.First;
  if not(dataset.Eof) then begin
    try

         dataset.Close;
         dataset.SelectSQL.Text :='select * from jogos_tenismesa '+
                                  'where  data_jogo < ' + char(39) +
                                  formatdatetime('dd.MM.yyyy',now) +' 23:59'+char(39) + ' '+
                                  'and data_jogo > '+ char(39) + formatdatetime('dd.MM.yyyy',now) + ' 00:00'+char(39) + ' '+
                                  'and ((prob1 > '+ probs+') or (prob2 > '+ probs +'))';
         dataset.Open;
         dataset.First;

         while not(dataset.Eof) do Begin
             LJson := TJSONObject.Create;
             LJson.AddPair(TJSONPair.Create('CODIGO', dataset.FieldByName('codigo').AsString));
             LJson.AddPair(TJSONPair.Create('COMPETICAO', dataset.FieldByName('nome_competicao').AsString));
             LJson.AddPair(TJSONPair.Create('JOGADORES', (dataset.FieldByName('jogador1').AsString + ' X ' + dataset.FieldByName('jogador2').AsString)));
             LJson.AddPair(TJSONPair.Create('RESULTADO', (dataset.FieldByName('resultado1').AsString + ' : ' + dataset.FieldByName('resultado2').AsString)));
             LJson.AddPair(TJSONPair.Create('DATAJOGO', formatdatetime('dd.MM.yyyy hh:mm',strtodatetime(dataset.FieldByName('data_jogo').Asstring))));
             LJson.AddPair(TJSONPair.Create('TIPO', dataset.FieldByName('tipo').AsString));
             LJson.AddPair(TJSONPair.Create('NUMSETS', dataset.FieldByName('num_sets').AsString));
             LJson.AddPair(TJSONPair.Create('PONTOSJ1', dataset.FieldByName('pontosj1').AsString));
             LJson.AddPair(TJSONPair.Create('PONTOSJ2', dataset.FieldByName('pontosj2').AsString));
             LJson.AddPair(TJSONPair.Create('TOTALPONTOS', dataset.FieldByName('totalpontos').AsString));
             LJson.AddPair(TJSONPair.Create('PROB1', dataset.FieldByName('PROB1').AsString));
             LJson.AddPair(TJSONPair.Create('PROB2', dataset.FieldByName('PROB2').AsString));
             LJson.AddPair(TJSONPair.Create('PREVNUMSETS', dataset.FieldByName('prev_num_sets').AsString));
             LJson.AddPair(TJSONPair.Create('PREVPONTOSJ1', dataset.FieldByName('prev_pontosj1').AsString));
             LJson.AddPair(TJSONPair.Create('PREVPONTOSJ2', dataset.FieldByName('prev_pontosj2').AsString));
             LJson.AddPair(TJSONPair.Create('PREVTOTALPONTOS', dataset.FieldByName('prev_totalpontos').AsString));
             LArr.Add(LJson);
             dataset.Next;
         End;

         LJsonObject.AddPair(TJSONPair.Create('JOGOS', LArr));
         Result := LJsonObject.ToString;
     Finally
         dataset.Close;
         LJsonObject.Free;
     end;
  end;
End;

function TServerMethods1.AtualizaCadastro (OldNome, NewNome,OldPass, newPass,OldEmail, NewEmail, OldFiltroProbs, NewFiltroProbs : String) : String;
Var
     JSONObject : TJSONObject;
Begin
     JSONObject := TJSONObject.Create;
     try
         //Pesquisa cpf
         database.Open;


         dataset.Close;
         dataset.SelectSQL.Text := 'select * from usuarios ' +
                                   'where nome   = '  +char(39) + OldNome +char(39) + ' '+
                                   'and senha = ' +char(39) + OldPass +char(39) + ' '+
                                   'and email = '+char(39) + OldNome +char(39) ;
         dataset.Open;
         dataset.First;


         if not (dataset.Eof) then Begin
            Query.SQL.Text := 'update usuarios ' +
                              'set nome = ' +char(39) + NewNome +char(39) + ' , '+
                              'senha = ' +char(39) + NewPass +char(39) + ' , '+
                              'email = ' +char(39) + NewEmail +char(39) + ' , '+
                              'perc_filtro_jogos = ' +char(39) + NewFiltroProbs +char(39) ;


          try
              if (database.Connected = false) or (transacao_Query.Active = false) then begin
                  database.Open;
                  transacao_Query.Active := true;
              end;
              query.ExecQuery;
              transacao_Query.Commit;
            finally
              JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
              JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'SUCESS'));
              Result := JSONObject.ToString;
            end;
         End else begin
            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'LOGINERROR'));
         end;
         Result := JSONObject.ToString;
     Finally
         JSONObject.Free;
     end;
end;

function TServerMethods1.ExcluiCadastro (Nome, senha, email, cpf : String) : String;
Var
     JSONObject : TJSONObject;
Begin
     JSONObject := TJSONObject.Create;
     try
        dataset.Close;
        dataset.SelectSQL.Text := 'select * from usuarios '+
                                  'where nome = ' + char(39)+Nome+char(39)+ ' '+
                                  'and senha = ' + char(39)+Senha+char(39)+ ' '+
                                  'and email = ' + char(39)+email+char(39)+ ' '+
                                  'and cpf = ' + char(39)+cpf+char(39);
         dataset.open;
         dataset.First;


         if not (dataset.Eof) then Begin
            Query.SQL.Text := 'delete from usuarios '+
                              'where nome = ' + char(39)+Nome+char(39)+ ' '+
                                  'and senha = ' + char(39)+Senha+char(39)+ ' '+
                                  'and email = ' + char(39)+email+char(39)+ ' '+
                                  'and cpf = ' + char(39)+cpf+char(39);
          try
              if (database.Connected = false) or (transacao_Query.Active = false) then begin
                  database.Open;
                  transacao_Query.Active := true;
              end;
              query.ExecQuery;
              transacao_Query.Commit;
            finally
              JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
              JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'SUCESS'));
              Result := JSONObject.ToString;
            end;
         End else begin
            JSONObject.AddPair(TJSONPair.Create('STATUS', 'OK'));
            JSONObject.AddPair(TJSONPair.Create('MENSAGEM', 'LOGINERROR'));
         end;
         Result := JSONObject.ToString;
     Finally
         JSONObject.Free;
     end;
end;


end.




