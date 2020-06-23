unit UProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Data.DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, FIBDatabase, iniFiles,
  pFIBDatabase, Forms;

type
  TService13 = class(TService)
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
    procedure ServiceCreate(Sender: TObject);
    procedure AtualizaProbabilidades;
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Service13: TService13;
  Pastalogs:  string;

implementation

{$R *.dfm}

function CalcProbab(RodadasJ1,RodadasJ2,PontosJ1,PontosJ2,SomaRodadas,SomaPontos:integer):integer;
var
ProbRodadas1,ProbJogos1:Double;
ProbRodadas2,ProbJogos2:Double;
Prob1Vencer:Double;
begin
  //
    ProbRodadas1  := (RodadasJ1 * 100)/SomaRodadas;
    ProbJogos1    := (PontosJ1  * 100)/SomaPontos;

    ProbRodadas2  := 100 - ProbRodadas1;
    ProbJogos2    := 100 - ProbJogos1;

    Prob1Vencer := (ProbRodadas1 + ProbJogos1)/2;

    result := Trunc(Prob1Vencer);
end;

procedure TService13.AtualizaProbabilidades;
var
jogador1, jogador2:string;
Prob1,Prob2,j:integer;
LogErros,dadosAdicionar: tstringList;
set1,set2,set3,set4,set5,set1_,set2_,set3_,set4_,set5_ :integer;
rodadasJ1, RodadasJ2, pontosJ1, PontosJ2:integer;
totCalc:integer;
begin
 //
    rodadasJ1 := 0;
    rodadasJ2 := 0;
    pontosJ1  := 0;
    pontosJ2  := 0;

    LogErros := tstringlist.Create;
    dadosAdicionar := tstringlist.create;

    dataset.Close;
    dataset.SelectSQL.Text := 'select * from JOGOS_TENISMESA where DATA_JOGO > ' +
                              char(39) + formatdatetime('dd.MM.yyyy hh:mm',now)+ char(39) +
                              ' and tipo = ' + char(39) + 'P' + char(39);
    dataset.Open;
    dataset.First;
    while not (DataSet.Eof) do
    begin
             jogador1 := dataset.FieldByName('JOGADOR1').AsString;
             jogador2 := dataset.FieldByName('JOGADOR2').AsString;
                try
                  query.Close;
                  query.SQL.Text := 'select sum(resultado1) rodadasJ1, sum(set_1 + set_2 + set_3 + set_4 + set_5 ) pontosJ1 '+
                                            'from jogos_tenismesa '+
                                            'where jogos_tenismesa.tipo = '+ char(39) + 'E' + char(39) +
                                            'and resultado1 >= 0 '+
                                            'and jogador1 = ' + char(39) + jogador1 + char(39); ;
                  query.Open;
                  if not query.Eof then begin
                    rodadasJ1 := query.FieldByName('rodadasJ1').AsInteger;
                    pontosJ1  := query.FieldByName('pontosJ1').AsInteger;
                  end;

                  query.Close;
                  query.SQL.Text := 'select sum(resultado2) rodadasJ1, sum(set_1_ + set_2_ + set_3_ + set_4_ + set_5_ ) pontosJ1 '+
                                            'from jogos_tenismesa '+
                                            'where jogos_tenismesa.tipo = '+ char(39) + 'E' + char(39) +
                                            'and resultado2 >= 0 '+
                                            'and jogador2 = ' + char(39) + jogador1 + char(39); ;

                   query.Open;
                  if not query.Eof then begin
                    rodadasJ1 := rodadasJ1 + query.FieldByName('rodadasJ1').AsInteger;
                    pontosJ1  := pontosJ1 + query.FieldByName('pontosJ1').AsInteger;
                  end;

                   query.Close;
                  query.SQL.Text := 'select sum(resultado1) rodadasJ2, sum(set_1 + set_2 + set_3 + set_4 + set_5 ) pontosJ2 '+
                                            'from jogos_tenismesa '+
                                            'where jogos_tenismesa.tipo = '+ char(39) + 'E' + char(39) +
                                            'and resultado1 >= 0 '+
                                            'and jogador1 = ' + char(39) + jogador2 + char(39); ;
                  query.Open;
                  if not query.Eof then begin
                    rodadasJ2 := query.FieldByName('rodadasJ2').AsInteger;
                    pontosJ2  := query.FieldByName('pontosJ2').AsInteger;
                  end;

                   query.Close;
                  query.SQL.Text := 'select sum(resultado2) rodadasJ2, sum(set_1_ + set_2_ + set_3_ + set_4_ + set_5_ ) pontosJ2 '+
                                            'from jogos_tenismesa '+
                                            'where jogos_tenismesa.tipo = '+ char(39) + 'E' + char(39) +
                                            'and resultado2 >= 0 '+
                                            'and jogador2 = ' + char(39) + jogador2 + char(39); ;
                  query.Open;
                  if not query.Eof then begin
                    rodadasJ2 := rodadasJ2 + query.FieldByName('rodadasJ2').AsInteger;
                    pontosJ2  := pontosJ2 + query.FieldByName('pontosJ2').AsInteger;
                  end;
                   query.Close;

                   if (RodadasJ1 = 0) or (RodadasJ2 = 0) then begin
                      RodadasJ1 := 50;
                      RodadasJ2 := 50;
                   end;
                   if (pontosJ1 = 0) or (PontosJ2 = 0) then begin
                      pontosJ1 := 50;
                      PontosJ2 := 50;
                   end;

                   prob1 := CalcProbab(rodadasJ1,rodadasJ2,PontosJ1,PontosJ2,(rodadasJ1+rodadasJ2),(PontosJ1+PontosJ2));
                   prob2 := 100 - prob1;

                   query.SQL.Text := 'update jogos_tenismesa '      +
                                     'set Prob1 = ' + prob1 + ' , ' +
                                     'prob2 = '     + Prob2         +
                                     'where tipo = ' + char(39)+ 'P' +char(39) +
                                     'and codigo = ' + dataset.FieldByName('codigo').AsInteger;
                   query.ExecQuery;


                except
                  LogErros.add(datetimetostr(now) + ' : Não foi possível atualizar o registro código ' +dataset.FieldByName('codigo').AsString + '!');;
                  LogErros.add('SQL: ' + query.SQL.Text);
                end;

    end;
    LogErros.SaveToFile(Pastalogs + 'LogErroCalculo'+ formatdatetime('dd.MM.yyyy.hhmm',now) +'.txt');
    LogErros.Destroy;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service13.Controller(CtrlCode);
end;

function TService13.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService13.ServiceCreate(Sender: TObject);
var
Config      : TiniFile;
ipBanco     : string;
localBanco  : string;
LogExecucao: tstringList;
g:integer;
controletempo:ttime;
teste_scans:string;
teste_horaD:string;
teste_horaDF:string;
teste_TempoAtrasoAttJogos:string;
ErroIniFile, ErroSetPastaLogs, ErroConexaoBanco, ErroAtualizarProbabil: boolean;
begin


     try
        config              :=  TIniFile.create(ExtractFilePath(Application.ExeName) + 'config.ini');
        ipBanco             :=  config.ReadString('config','ipbanco','');
        localBanco          :=  config.ReadString('config','localbanco','');
        Pastalogs           :=  config.ReadString('config','pasta_logs','');
        Pastalogs           :=  Pastalogs + '\';
        database.DBName     :=  ipBanco + ':' + localBanco;

     except
        ErroIniFile := true;
     end;

     try
        if (PastaLogs = '\') or (Pastalogs = '') then
          Pastalogs := 'C:\ServicoExtracao\logs\';
     except
        ErroSetPastaLogs := true;
     end;

     try
        database.Connected  := true;
        transacao.active    :=true;
     except
        ErroConexaoBanco := true;
     end;

     try
       AtualizaProbabilidades;
     except
       ErroAtualizarProbabil := true;
     end;

     try
        LogExecucao := tstringlist.Create;
        if ErroIniFile or ErroSetPastaLogs or ErroConexaoBanco or ErroConexaoBanco then begin
          LogExecucao.Add('Log de erros de execução dos calculos de probabilidades.');
          LogExecucao.Add('Data: ' + formatdatetime('dd/MM/yyyy',now));
          LogExecucao.Add('Hora: ' + formatdatetime('hh:mm',now));
          LogExecucao.Add('');
          LogExecucao.Add('___________________________________________________________________________');
          LogExecucao.Add('');
        end;
        if ErroIniFile then begin
          LogExecucao.Add('Não foi possível acessar o config.ini.');
          LogExecucao.Add(' verifique as configurações de acesso do windows');
          LogExecucao.Add('');
          LogExecucao.Add('___________________________________________________________________________');
          LogExecucao.Add('');
        end;
        if ErroSetPastaLogs then begin
          LogExecucao.Add('ERROFATAL: pare o processo imediatamente e inicie novamente');
          LogExecucao.Add('');
          LogExecucao.Add('___________________________________________________________________________');
          LogExecucao.Add('');
        end;
        if ErroConexaoBanco then begin
          LogExecucao.Add(' NÃO FOI POSSIVEL CONECTAR AO BANCO');
          LogExecucao.Add('');
          LogExecucao.Add('___________________________________________________________________________');
          LogExecucao.Add('');
        end;
        if ErroAtualizarProbabil then begin
          LogExecucao.Add(' NÃO FOI POSSIVEL ATUALIZAR AS PROBABILIDADES');
          LogExecucao.Add('');
          LogExecucao.Add('___________________________________________________________________________');
          LogExecucao.Add('');
        end;
        if LogExecucao.Text <> '' then
        LogExecucao.SaveToFile(formatdatetime('LogProcessamento.'+'dd.mm.yyyy.hhmm.ss',now) + '.txt');
        LogExecucao.Destroy;
     finally

     end;
end;

end.
