unit UExtract;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Vcl.ExtCtrls,System.Net.HttpClient, System.Net.HttpClientComponent, iniFiles,
  Data.DB, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase, FIBQuery,
  pFIBQuery, DateUtils, vcl.Forms,ShellAPI;

type
  TService1 = class(TService)
    database: TpFIBDatabase;
    transacao: TpFIBTransaction;
    query: TpFIBQuery;
    dataset: TpFIBDataSet;
    transSelect: TpFIBTransaction;
    datasetCODIGO: TFIBIntegerField;
    datasetDATA_JOGO: TFIBDateTimeField;
    datasetJOGADOR1: TFIBStringField;
    datasetJOGADOR2: TFIBStringField;
    datasetRESULTADO1: TFIBIntegerField;
    datasetRESULTADO2: TFIBIntegerField;
    datasetNOME_COMPETICAO: TFIBStringField;
    datasetLINK: TFIBStringField;
    datasetTIPO: TFIBStringField;
    datasetPROB1: TFIBIntegerField;
    datasetPROB2: TFIBIntegerField;
    datasetSET_1: TFIBIntegerField;
    datasetSET_1_: TFIBIntegerField;
    datasetSET_2: TFIBIntegerField;
    datasetSET_2_: TFIBIntegerField;
    datasetSET_3: TFIBIntegerField;
    datasetSET_3_: TFIBIntegerField;
    datasetSET_4: TFIBIntegerField;
    datasetSET_4_: TFIBIntegerField;
    datasetSET_5: TFIBIntegerField;
    datasetSET_5_: TFIBIntegerField;
    procedure CargaTenis;
    procedure CargaTenisRealTime;
    procedure AtualizaProbabilidades;
    function ifthen(Bool:boolean;seTrue, seFalse:string): string;
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Service1        : TService1   ;
  ListaLinks      : TstringList ;
  DadosAdicionar  : TStringList ;
  pagina          :tstringlist  ;
  retorno         :TstringList  ;
  posicao         :integer      ;
  identificador   :string       ;
  HoraCargaDiaria :ttime        ;
  TempoAtrasoAttJogos:integer   ;
  Pastalogs       :string       ;
  horaAgora       : ttime       ;
  tempo_scans     :integer      ;
  horascandiario  :ttime        ;
  horaScanDiarioFim:ttime     ;
  LogExecucao: tstringList;
  LogerificaErro, cargaDexecutado, cargaRealExecutado:boolean;
  ErroIniFile, ErroSetConfigs, ErroConexaoBanco, ErroAtualizarProbabil, ErroCargaD, ErroCargaReal: boolean;

implementation

{$R *.dfm}

procedure TService1.AtualizaProbabilidades;
begin
  ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'ServiceProc.exe'), nil, nil, SW_SHOWNORMAL);
end;

function RemoveAcentos(aText : string) : string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸Ò˝¿¬ ‘€√’¡…Õ”⁄«‹—›';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
begin;
  for x := 1 to Length(aText) do
  try
    if (Pos(aText[x], ComAcento) <> 0) then
      aText[x] := SemAcento[ Pos(aText[x], ComAcento) ];
  except on E: Exception do
    raise Exception.Create('Erro no processo.');
  end;

  Result := aText;
end;

function TService1.ifthen(Bool:boolean;seTrue, seFalse:string):string;
begin
  if Bool then begin
    result:= seTrue;
  end else begin
    result:= seFalse;
  end;
end;

function GetURL(const AURL: string): string;
var
  HttpClient  : THttpClient;
  HttpResponse: IHttpResponse;
begin
  HttpClient := THttpClient.Create;
  try
    HttpResponse := HttpClient.Get(AURL);
    Result := HttpResponse.ContentAsString();
  finally
    HttpClient.Free;
  end;
end;

procedure TService1.CargaTenisRealTime;
var
time1,time2,scoreTime1,hora,scoreTime2,competicao,link: string;
i,g,h:integer;
dataJogos:tdate;
j: tdatetime;
teste : string;
set1,set2,set3,set4,set5,set6,set7,set1_,set2_,set3_,set4_,set5_,set6_,set7_, registrosAtualizar:integer;
begin
  //extracao
    pagina := tstringlist.create;
    dataset.Close;
    dataset.SelectSQL.Text := 'select * from JOGOS_TENISMESA where DATA_JOGO <= ' +
                              char(39) + formatdatetime('dd.MM.yyyy',now)+' '+
                              formatdatetime('hh:mm',IncMinute(now, TempoAtrasoAttJogos)) + char(39) +
                              ' and tipo = ' + char(39) + 'P' + char(39);
    dataset.Open;
    dataset.First;
    while not (DataSet.Eof) do
    begin
            pagina.text := getURL('https://m.flashscore.com.br/jogo/'+dataset.FieldValue('link',false));
            if pagina.text.contains('<div class="detail">Encerrado') then begin
            try
               try
               pagina.text    := copy(pagina.text,pos('class="detail"><b>',pagina.text)+length('class="detail"><b>'));
                  scoreTime1  := copy(pagina.text, 1,pos(':',pagina.text)-1);
               pagina.text    := copy(pagina.text, pos(':',pagina.text)+1);
                  scoreTime2  := copy(pagina.text, 1,pos('<',pagina.text)-1);
               pagina.text    := copy(pagina.text,pos('</b>  (',pagina.text)+length('</b>  ('));
               pagina.text    := copy(pagina.text,1,pos(')',pagina.text));
                  set1     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  set1_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set2     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  set2_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set3     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
              if (strtoint(scoreTime1) + strtoint(scoreTime2)) = 3 then
                  set3_    := strtoint(copy(pagina.text,1,pos(')',pagina.text)-1));
               except
                 LogExecucao.Add('Falha no setor 1 de CargaTenisRealTime');
                 LogerificaErro :=true;
                 LogExecucao.Add('');
                 ErroCargaReal := TRUE;
               end;
             try
              if (strtoint(scoreTime1) + strtoint(scoreTime2)) > 3 then begin
                  set3_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set4     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  if (strtoint(scoreTime1) + strtoint(scoreTime2)) = 4 then begin
                      set4_    := strtoint(copy(pagina.text,1,pos(')',pagina.text)-1));
                  end else begin
                  set4_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
                  end;
              end else begin
                  set4  := 0;
                  set4_ := 0;
              end;
             except
                 LogExecucao.Add('Falha no setor 2 de CargaTenisRealTime');
                 LogExecucao.Add('');
                 LogerificaErro := true;
                 ErroCargaReal := TRUE;
             end;

             try
              if (strtoint(scoreTime1) + strtoint(scoreTime2)) > 4 then begin
               pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set5     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  if (strtoint(scoreTime1) + strtoint(scoreTime2)) = 5 then begin
                    set5_    := strtoint(copy(pagina.text,1,pos(')',pagina.text)-1));
                  end else begin
                    set5_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
                  end;
              end else begin
                  set5     := 0;
                  set5_    := 0;
              end;
             except
                 LogExecucao.Add('Falha no setor 3 de CargaTenisRealTime');
                 LogExecucao.Add('');
                 LogerificaErro := true;
                 ErroCargaReal := TRUE;
             end;

             try
              if (strtoint(scoreTime1) + strtoint(scoreTime2)) > 5 then begin
                pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set6     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  if (strtoint(scoreTime1) + strtoint(scoreTime2)) = 6 then begin
                    set6_    := strtoint(copy(pagina.text,1,pos(')',pagina.text)-1));
                  end else begin
                    set6_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
                  end;
              end;
             except
                LogExecucao.Add('Falha no setor 4 de CargaTenisRealTime');
                LogExecucao.Add('');
                LogerificaErro := true;
                ErroCargaReal := TRUE;
             end;

             try
              if (strtoint(scoreTime1) + strtoint(scoreTime2)) > 6 then begin
                pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set7     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  if (strtoint(scoreTime1) + strtoint(scoreTime2)) = 7 then begin
                    set7_    := strtoint(copy(pagina.text,1,pos(')',pagina.text)-1));
                  end else begin
                    set7_    := strtoint(copy(pagina.text,1,pos(',',pagina.text)-1));
                  end;
              end;
             except
                 LogExecucao.Add('Falha no setor 5 de CargaTenisRealTime');
                 LogExecucao.Add('');
                 LogerificaErro := true;
                 ErroCargaReal := TRUE;
             end;


               cargaRealExecutado := true;
            except
               LogExecucao.add(datetimetostr(now) + ' : N„o foi possÌvel processar o registro cÛdigo ' +dataset.FieldByName('codigo').AsString + '!');
               LogerificaErro := true;
               ErroCargaReal := TRUE;
            end;

                try
                      Query.SQL.Text:= 'update JOGOS_TENISMESA '+
                                'set tipo = '+char(39)+'E'+char(39)+ ' , '+
                                'resultado1 = ' + scoreTime1 + ' , ' +
                                'resultado2 = ' + scoreTime2 + ' , ' +
                                'prob1 = '+ifthen((scoretime1 > scoretime2),'100','0')+ ' , ' +
                                'prob2 = '+ifthen((scoretime1 > scoretime2),'0','100')+ ' , ' +
                                'SET_1  = ' + inttostr(set1) + ' , ' +
                                'SET_1_ = ' + inttostr(set1_)+ ' , ' +
                                'SET_2  = ' + inttostr(set2 )+ ' , ' +
                                'SET_2_ = ' + inttostr(set2_)+ ' , ' +
                                'SET_3  = ' + inttostr(set3 )+ ' , ' +
                                'SET_3_ = ' + inttostr(set3_)+ ' , ' +
                                'SET_4  = ' + inttostr(set4 )+ ' , ' +
                                'SET_4_ = ' + inttostr(set4_)+ ' , ' +
                                'SET_5  = ' + inttostr(set5 )+ ' , ' +
                                'SET_5_ = ' + inttostr(set5_)+ ' , '    +
                                'SET_6  = ' + inttostr(set5 )+ ' , ' +
                                'SET_6_ = ' + inttostr(set5_)+ ' , '    +
                                'SET_7  = ' + inttostr(set5 )+ ' , ' +
                                'SET_7_ = ' + inttostr(set5_)+ ' '    +
                                'where codigo = ' + inttostr(dataset.FieldByName('codigo').Asinteger)
                                ;

                  if transacao.active = false or database.Connected = false then begin
                      database.Connected := true;
                      transacao.active := true
                  end;
                    query.ExecQuery;
                    LogExecucao.Add('SUCESSO: Atualizado Registro n˙mero: '+ (inttostr(dataset.FieldByName('codigo').AsInteger)));
                  cargaRealExecutado := true;
                except
                    LogExecucao.add(datetimetostr(now) + ' : N„o foi possÌvel atualizar o registro cÛdigo ' +dataset.FieldByName('codigo').AsString + '!');
                    LogerificaErro := true;
                    ErroCargaReal := TRUE;
                end;

            end else if pagina.text.contains('class="detail">Cancelado') then begin
                 try
                 Query.SQL.Text:= 'update JOGOS_TENISMESA '+
                                'set tipo = '+char(39)+'C'+char(39)+ ' , '+
                                'resultado1 = 0 , ' +
                                'resultado2 = 0 , ' +
                                'prob1 = 0 , '  +
                                'prob2 = 0 , '  +
                                'SET_1  = 0 , ' +
                                'SET_1_ = 0 , ' +
                                'SET_2  = 0 , ' +
                                'SET_2_ = 0 , ' +
                                'SET_3  = 0 , ' +
                                'SET_3_ = 0 , ' +
                                'SET_4  = 0 , ' +
                                'SET_4_ = 0 , ' +
                                'SET_5  = 0 , ' +
                                'SET_5_ = 0 , ' +
                                'SET_6  = 0 , ' +
                                'SET_6_ = 0 , ' +
                                'SET_7  = 0 , ' +
                                'SET_7_ = 0 '   +
                                'where codigo = ' + inttostr(dataset.FieldByName('codigo').Asinteger)
                                ;
                    if transacao.active = false or database.Connected = false then begin
                      database.Connected := true;
                      transacao.active := true
                  end;
                  query.ExecQuery;
                  LogExecucao.Add('SUCESSO: Atualizado Registro n˙mero: '+ (dataset.FieldByName('codigo').AsString));
                  cargaRealExecutado := true;
                 except
                      LogExecucao.add(datetimetostr(now) + ' : N„o foi possÌvel atualizar o registro cÛdigo ' +dataset.FieldByName('codigo').AsString + '!');
                      LogerificaErro := true;
                      ErroCargaReal := TRUE;
                 end;
            end;
            dataset.next;
    end;

    pagina.destroy;
    if ErroCargaReal = false then
    cargaRealExecutado := true;

end;

//extracao DIARIA
procedure TService1.CargaTenis;
var
time1,time2, ano,mes,dia,scoreTime1,hora,scoreTime2,competicao,link: string;
i,g:integer;
dataJogos:tdate;
j: tdatetime;
teste : string;
begin
    dataset.Close;
    dataset.SelectSQL.Text := 'select * from JOGOS_TENISMESA where DATA_JOGO > ' +
                              char(39) + formatdatetime('dd.MM.yyyy',IncDay(now,1))+' 00:00 ' + char(39);
    dataset.open;
     if (DataSet.Eof) then begin
     dataset.close;
    dataJogos := IncDay(now, 1);
    i:=0;
    pagina := tstringlist.create;
    identificador:= 'OTHERS - ';

    pagina.Text := GetURL('https://m.flashscore.com.br/tenis-de-mesa/?d=1');
    while pagina.Text.Contains('<span>') and not pagina.Text.Contains('<span>Jogo n„o encontrado.</span>') do begin
        if i = 0 then begin
          posicao := pos(identificador, pagina.Text)+length(identificador);
          pagina.Text  := copy(pagina.Text,posicao);
            competicao := copy(pagina.Text,1, pos('<',pagina.text)-1);
            competicao := RemoveAcentos(competicao);
          i:=1;
        end;
        pagina.Text := copy(pagina.Text,pos('<span>',pagina.text)+length('<span>'));
          j         := (strtodatetime(datetostr(dataJogos) +' '+ copy(pagina.Text,1,5)));
          hora      :=  formatdatetime('dd.MM.yyyy hh:mm',j);
        pagina.Text := copy(pagina.Text,13);
          time1     := copy(pagina.Text,1,pos(' -',pagina.Text)-1);
          time1     := RemoveAcentos(time1);
        pagina.Text := copy(pagina.Text,pos(time1,pagina.Text)+length(time1+' - '));
          time2     := copy(pagina.Text,1,pos(' <a href="',pagina.Text)-1);
          time2     := RemoveAcentos(time2);
          link      := copy(pagina.text,(pos('href="/jogo/',pagina.text)+length('href="/jogo/')),8);
        pagina.Text := copy(pagina.Text,pos('" class="sched">',pagina.Text)+length('" class="sched">'));
          scoretime1:= copy(pagina.Text,1,pos(':',pagina.Text)-1);
        pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
          scoretime2:= copy(pagina.Text,1,pos('<',pagina.text)-1);

        teste       := copy(pagina.text,1,pos('<span>',pagina.text));
        if teste.contains(identificador) then begin
           teste    := copy(teste,pos(identificador,teste)+length(identificador));
           competicao := copy(teste,1,(pos('<',teste)-1));
           competicao := RemoveAcentos(competicao);
        end;

       try
          query.SQL.Text := 'insert into JOGOS_TENISMESA '                                +
                            'values(GEN_ID(gen_jogos_tenismesa_id,1)'               +', ' +
                            char(39) + hora + char(39)                              +', ' +
                            char(39) + time1      + char(39)                        +', ' +
                            char(39) + time2      + char(39)                        +', ' +
                            '-1'                                                    +', ' +
                            '-1'                                                    +', ' +
                            char(39) + competicao + char(39)                        +', ' +
                            char(39) + link       + char(39)                        +', ' +
                            char(39) + 'P'  + char(39)                              +', ' +
                            '-1'                                                    +', ' +
                            '-1'                                                    +', ' +
                            '-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1' + ')';

          if transacao.active = false or database.Connected = false then begin
              database.Connected := true;
              transacao.active := true
          end;
          query.ExecQuery;
          cargaDexecutado := true;
       except
          LogExecucao.Add(datetimetostr(now()) + ': ' + 'N„o foi possÌvel atualizar o banco de dados');
          LogerificaErro := true;
          ErroCargaD := true;
       end;


    end;
    if LogerificaErro then
       LogExecucao.Add('Fim do Log de Carga di·ria');
       LogExecucao.Add('');
       LogExecucao.Add('__________________________________________________________________________________');
       LogExecucao.Add('');
    pagina.destroy;
    DadosAdicionar.Destroy;
    if ErroCargaD = false then
      cargaDexecutado := true;
  end;


end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService1.ServiceCreate(Sender: TObject);
var
Config      : TiniFile;
ipBanco     : string;
localBanco  : string;
g:integer;
controletempo:ttime;
teste_scans:string;
teste_horaD:string;
teste_horaDF:string;
teste_TempoAtrasoAttJogos:string;
 chamadoProba:boolean;
nomeLog: string;
begin

  g:=0;

     try
        config              :=  TIniFile.create(ExtractFilePath(Application.ExeName) + 'config.ini');
        ipBanco             :=  config.ReadString('config','ipbanco','');
        localBanco          :=  config.ReadString('config','localbanco','');
        teste_scans         :=  config.ReadString('config','tempo_scans','');
        tempo_scans         :=  strtoint(config.ReadString('config','tempo_scans',''));
        teste_horaD         :=  config.ReadString('config','hora_extracao_diaria','');
        horaScanDiario      :=  strtotime(config.ReadString('config','hora_extracao_diaria',''));
        teste_horaD         :=  config.ReadString('config','hora_extracao_diaria_fim','');
        horaScanDiarioFim   :=  strtotime(config.ReadString('config','hora_extracao_diaria_fim',''));
        teste_TempoAtrasoAttJogos:= config.ReadString('config','tempo_atraso_att_jogos','');
        TempoAtrasoAttJogos :=  strtoint(config.ReadString('config','tempo_atraso_att_jogos',''));
        Pastalogs           :=  config.ReadString('config','pasta_logs','');
        Pastalogs           :=  Pastalogs + '\';
        database.DBName     :=  ipBanco + ':' + localBanco;
     except
        ErroIniFile := true;
     end;

     try
        database.Connected  := true;
        transacao.active    :=true;
     except
        ErroConexaoBanco := true;
     end;

     try
     if ipBanco = '' then
        ipBanco := 'localhost';
     if localBanco = '' then
        localBanco := 'C:\ServicoExtracao\DADOS.FDB';
     if teste_horaD = '' then
        horaScanDiario := strtotime('08:00:00');
     if teste_horaDF ='' then
        horaScanDiarioFim := strtotime('08:15:00');
     if teste_TempoAtrasoAttJogos = '' then
        TempoAtrasoAttJogos := -20;
     if teste_scans = '' then
     tempo_scans := 900;
     if (PastaLogs = '\') or (PastaLogs = '') then
     Pastalogs := 'C:\ServicoExtracao\logs\';
     except
       ErroSetConfigs := true;
     end;

   while (g=0) do begin
       LogExecucao := tstringlist.Create;

          try
           CargaTenis;
          except
            ErroCargaD := true;
          end;
          if (not ErroCargaD) and cargaDexecutado then
            cargaDexecutado:= true;
          try
            CargaTenisRealTime;
          except
            ErroCargaReal := true;
          end;
          if (not ErroCargaReal) and cargaRealExecutado then
            cargaRealExecutado :=true;
          try
            AtualizaProbabilidades;
          except
            ErroAtualizarProbabil := TRUE;
          end;
             if not ErroAtualizarProbabil then
                chamadoProba :=true;
            try
              if LogerificaErro     or
             ErroIniFile        or
             ErroConexaoBanco   or
             ErroSetConfigs     or
             ErroCargaD         or
             ErroCargaReal      or
             ErroAtualizarProbabil
             then begin
               nomeLog := 'LogErros';
               LogerificaErro := false;
             end else begin
               nomeLog := 'Log';
             end;
              if ErroIniFile or ErroConexaoBanco or ErroSetConfigs or ErroCargaD or ErroCargaReal or ErroAtualizarProbabil then begin
                  LogExecucao.Add('Dados da execuÁ„o              ');
                  LogExecucao.Add('Data                           : ' + formatdatetime('dd/MM/yyyy',now));
                  LogExecucao.Add('Hora                           : ' + formatdatetime('hh:mm:ss',now));
                  LogExecucao.Add('Arquivo de configuraÁ„o        : ' + ExtractFilePath(Application.ExeName) + 'config.ini');
                  LogExecucao.Add('EndereÁo do Banco de dados     : ' +ipBanco);
                  LogExecucao.Add('Local do banco de Dados        : ' +localBanco);
                  LogExecucao.Add('Tempo entre cada scan(segundos): ' +inttostr(tempo_scans));
                  LogExecucao.Add('Tempo de atraso att dos jogos  : ' +inttostr(TempoAtrasoAttJogos));
                  LogExecucao.Add('Pasta dos Logs                 : ' +Pastalogs);
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
              end;
              if ErroIniFile then begin
                  LogExecucao.Add('N„o foi possÌvel acessar o config.ini.');
                  LogExecucao.Add(' verifique as configuraÁıes de acesso do windows');
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
                  ErroIniFile := false;
              end;
              if ErroConexaoBanco then begin
                  LogExecucao.Add(' N√O FOI POSSIVEL CONECTAR AO BANCO');
                  LogExecucao.Add(' Verifique se o servico Firebird est· correto e se o banco de dados existe!');
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
                  ErroConexaoBanco := false;
              end;
              if ErroSetConfigs then begin
                  LogExecucao.Add('ERROFATAL: pare o processo imediatamente e inicie novamente');
                  LogExecucao.Add('Se est· vendo essa mensagem, provavelmente seu servidor est· com danos fÌsicos,');
                  LogExecucao.Add('como processador com pasta termica seca ou caiu um raio nele...');
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
                  ErroSetConfigs := false;
              end;
              if ErroCargaD then begin
                  LogExecucao.Add(' ERRO NA CARGA DI¡RIA');
                  LogExecucao.Add('Houve algum problema ao efetuar a carga di·ria dos jogos futuros');
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
                  ErroCargaD := false;
              end;
              if ErroCargaReal then begin
                  LogExecucao.Add(' ERRO NA CARGA EM TEMPO REAL');
                  LogExecucao.Add('Houve algum problema ao efetuar a carga di·ria dos jogos encerrados recentemente');
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
                  ErroCargaReal := false;
              end;
              if ErroAtualizarProbabil then begin
                  LogExecucao.Add(' ERRO NA CHAMADA DE EXECU«√O DO SERVI«O DE CALCULOS');
                  LogExecucao.Add('N„o foi possÌvel executar o processo de c·lculos,');
                  LogExecucao.Add('Verifique a situaÁ„o de seu Sistema, isso È um problema no seu servidor');
                  LogExecucao.Add('');
                  LogExecucao.Add('___________________________________________________________________________');
                  LogExecucao.Add('');
                  ErroAtualizarProbabil := false;
              end;
              if (not ErroCargaD) and ( not cargaDExecutado) then begin
                  LogExecucao.Add('SUCESSO: os jogos de amanh„ j· est„o atualizados.');
                  LogExecucao.Add('');
              end;
              if cargaDexecutado then begin
                  LogExecucao.Add('SUCESSO: Carga em tempo real de jogos futuros realizada com 100% de sucesso.');
                  LogExecucao.Add('');
                  cargaDexecutado := false;
              end;
              if cargaRealExecutado then begin
                  LogExecucao.Add('SUCESSO: Carga em tempo real de jogos encerrados realizada com 100% de sucesso.');
                  LogExecucao.Add('');
                  cargaRealExecutado := false;
              end;
              if chamadoProba then begin
                  LogExecucao.Add('CHAMADA: Iniciado ServiÁo de calculos de Probalilidades.');
                  LogExecucao.Add('');
                  chamadoProba := false;
              end;
            finally
            end;
              LogExecucao.SaveToFile(Pastalogs + nomeLog + formatdatetime('dd.mm.yyyy.hhmm.ss',now) + '.txt');

          LogExecucao.Destroy;
          sleep(tempo_scans * 1000);
      end;

   LogExecucao.Destroy;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
    Application.Destroy;
end;



end.



