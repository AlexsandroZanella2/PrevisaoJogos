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
    transSelect: TpFIBTransaction;
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
LogErros:tstringList;
set1,set2,set3,set4,set5,set1_,set2_,set3_,set4_,set5_, registrosAtualizar:integer;
begin
  //extracao
    LogErros := tstringlist.Create;
    dadosAdicionar := tstringlist.create;
    //dataJogos := IncDay(now, 1);
    //i:=0;
    pagina := tstringlist.create;
    //identificador:= '<div class="detail"><b>';
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
               pagina.text    := copy(pagina.text,pos('class="detail"><b>',pagina.text)+length('class="detail"><b>'));
                  scoreTime1  := copy(pagina.text, 1,pos(':',pagina.text)-1);
               pagina.text    := copy(pagina.text, pos(':',pagina.text)+1);
                  scoreTime2  := copy(pagina.text, 1,pos('<',pagina.text)-1);
               pagina.text    := copy(pagina.text,pos('</b>  (',pagina.text)+length('</b>  ('));
               pagina.text    := copy(pagina.text,1,pos(')',pagina.text));
              // pagina.text    := copy(pagina.text,1,length(pagina.text)-2);
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

              if (strtoint(scoreTime1) + strtoint(scoreTime2)) > 4 then begin
               pagina.text := copy(pagina.text,pos(',',pagina.text)+1);
                  set5     := strtoint(copy(pagina.text,1,pos(':',pagina.text)-1));
               pagina.text := copy(pagina.text,pos(':',pagina.text)+1);
                  set5_    := strtoint(copy(pagina.text,1,pos(')',pagina.text)-1));
              end else begin
                  set5     := 0;
                  set5_    := 0;
              end;
            except
               logErros.add(datetimetostr(now) + ' : N„o foi possÌvel atualizar o registro cÛdigo ' +dataset.FieldByName('codigo').AsString + '!');
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
                                'SET_5_ = ' + inttostr(set5_)+' '    +
                                'where codigo = ' + (dataset.FieldByName('codigo').AsString)
                                ;

                  if transacao.active = false or database.Connected = false then begin
                      database.Connected := true;
                      transacao.active := true
                  end;
                    query.ExecQuery;
                    DadosAdicionar.Add('SUCESSO: Atualizado Registro n˙mero: '+ (dataset.FieldByName('codigo').AsString))
                except
                    logErros.add(datetimetostr(now) + ' : N„o foi possÌvel atualizar o registro cÛdigo ' +dataset.FieldByName('codigo').AsString + '!');

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
                                'SET_5_ = 0 '        +
                                'where codigo = ' + (dataset.FieldByName('codigo').AsString)
                                ;
                    if transacao.active = false or database.Connected = false then begin
                      database.Connected := true;
                      transacao.active := true
                  end;
                  query.ExecQuery;
                  DadosAdicionar.Add('SUCESSO: Atualizado Registro n˙mero: '+ (dataset.FieldByName('codigo').AsString))
                 except
                      logErros.add(datetimetostr(now) + ' : N„o foi possÌvel atualizar o registro cÛdigo ' +dataset.FieldByName('codigo').AsString + '!');
                 end;
            end;
            dataset.next;
           // dataset.CloseOpen(false);
    end;

  if LogErros.Text <> '' then begin
    try
      LogErros.SaveToFile(Pastalogs+'LogErros'+ formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
    except
      LogErros.Add('ERRO LOCAL:N„o foi possÌvel salvar na pasta informada: '+ Pastalogs);
      LogErros.SaveToFile(Pastalogs+'LogErros'+ formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
    end;
  end;

    if DadosAdicionar.Text <> '' then begin
        try
          DadosAdicionar.SaveToFile(Pastalogs + 'LogGeral' + formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
        except
          DadosAdicionar.Add('ERRO LOCAL:N„o foi possÌvel salvar na pasta informada: '+ Pastalogs);
          DadosAdicionar.SaveToFile( 'LogGeral' + formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
        end;
    end;

    pagina.destroy;
    DadosAdicionar.Destroy;
end;

//extracao DIARIA
procedure TService1.CargaTenis;
var
time1,time2, ano,mes,dia,scoreTime1,hora,scoreTime2,competicao,link: string;
i,g:integer;
dataJogos:tdate;
j: tdatetime;
teste : string;
LogErros:tstringList;
begin

    LogErros := tstringlist.Create;
    dadosAdicionar := tstringlist.create;
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
          query.SQL.Text := 'insert into JOGOS_TENISMESA '              +
                            'values(GEN_ID(gen_jogos_tenismesa_id,1), '                   +
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
                            '-1,-1,-1,-1,-1,-1,-1,-1,-1,-1' + ')';

          if transacao.active = false or database.Connected = false then begin
              database.Connected := true;
              transacao.active := true
          end;
          query.ExecQuery;
          DadosAdicionar.Add('Registro Di·rio Atualizado.');
       except
          LogErros.Add(datetimetostr(now()) + ': ' + 'N„o foi possÌvel atualizar o banco de dados');
       end;



    end;
    if DadosAdicionar.Text <> '' then
    try
      DadosAdicionar.SaveToFile(Pastalogs + 'DadosCarga' + formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
    except
      DadosAdicionar.Add('ERRO LOCAL:N„o foi possÌvel salvar na pasta informada: '+ Pastalogs);
      DadosAdicionar.SaveToFile('DadosCarga' + formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
    end;
    if LogErros.Text <> '' then
    try
      LogErros.SaveToFile(Pastalogs+'LogErrosCarga'+ formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
    except
      LogErros.add('ERRO LOCAL:N„o foi possÌvel salvar na pasta informada: '+ Pastalogs);
      LogErros.SaveToFile(Pastalogs+'LogErrosCarga'+ formatdatetime('dd.MM.yyy.hhmm',now) +'.txt');
    end;
    pagina.destroy;
    DadosAdicionar.Destroy;
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
LogExecucao: tstringList;
g:integer;
controletempo:ttime;
teste_scans:string;
begin

  g:=0;

     try
        config              :=  TIniFile.create(ExtractFilePath(Application.ExeName) + 'config.ini');
        ipBanco             :=  config.ReadString('config','ipbanco','');
        localBanco          :=  config.ReadString('config','localbanco','');
        teste_scans         :=  config.ReadString('config','tempo_scans','');
        tempo_scans         :=  strtoint(config.ReadString('config','tempo_scans',''));
        horaScanDiario      :=  strtotime(config.ReadString('config','hora_extracao_diaria',''));
        horaScanDiarioFim   :=  strtotime(config.ReadString('config','hora_extracao_diaria_fim',''));
        TempoAtrasoAttJogos :=  strtoint(config.ReadString('config','tempo_atraso_att_jogos',''));
        Pastalogs           :=  config.ReadString('config','pasta_logs','');
        Pastalogs           :=  Pastalogs + '\';
        database.DBName     :=  ipBanco + ':' + localBanco;

     except
       // showmessage('Arquivo Config.ini n„o encontrado!');
     end;


     try
        database.Connected  := true;
        transacao.active    :=true;
     except
        LogExecucao := tstringlist.Create;
        LogExecucao.Add(formatdatetime('dd-MM-yyyy hh:mm',now) + ' N√O FOI POSSIVEL CONECTAR AO BANCO');
      LogExecucao.SaveToFile(Pastalogs + 'LogStarts'+ formatdatetime('dd.MM.yyyy.hhmm',now) +'.txt');
      LogExecucao.Destroy;
        application.Destroy;
     end;

     if teste_scans = '' then
     tempo_scans := 900;
     if PastaLogs = '\' then
     Pastalogs := 'C:\ServicoExtracao\logs\';

   while (g=0) do begin
      if now() > IncMinute(controletempo,tempo_scans) then begin
       LogExecucao := tstringlist.Create;
       horaAgora:= now();
       if (horaAgora > horaScanDiario) and
          (horaAgora < horaScanDiarioFim)then begin
           CargaTenis;
       end;
          CargaTenisRealTime;
          try
          AtualizaProbabilidades;
          except
          end;
          LogExecucao.Add(formatdatetime('dd-MM-yyyy hh:mm',now) + ' EXECU«√O BEM SUCEDIDA');
          LogExecucao.SaveToFile(Pastalogs + 'LogStarts'+ formatdatetime('dd.MM.yyyy.hhmm',now) +'_.txt');
          LogExecucao.Destroy;
          sleep(tempo_scans * 1000);
      end;
     end;
   LogExecucao.Destroy;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
    Application.Destroy;
end;



end.



