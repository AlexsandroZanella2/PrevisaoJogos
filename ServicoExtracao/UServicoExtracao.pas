unit UServicoExtracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FIBDatabase, pFIBDatabase, Data.DB,
  FIBDataSet, pFIBDataSet, Vcl.StdCtrls, Vcl.Buttons, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.OleCtrls, SHDocVw, ActiveX,iniFiles;

type
  TServicoExtracao = class(TForm)
    BitBtn1           : TBitBtn;
    DataBase: TpFIBDatabase;
    DataSet: TpFIBDataSet;
    Transacao: TpFIBTransaction;
    Button1: TButton;
    DataSource: TDataSource;
    Memo1             : TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  ServicoExtracao : TServicoExtracao;
  ListaLinks      : TstringList;
  DadosAdicionar  : TStringList;
  pagina          :string;
  retorno         :TstringList;
  posicao         :integer;
  identificador   :string;

implementation

{$R *.dfm}

procedure GeraListalinks;
var
a              : tstringlist;
y,m,d          : integer;
mm,dd:string;
begin
  if ListaLinks = nil then
  ListaLinks := tstringlist.Create;
  ListaLinks.Text :='';
  //Gerar datas no foprmato AAAA-MM-DD
  //Salvar em StringList
  for y := 2005 to 2020 do begin
    for m := 1 to 12 do begin
        mm:= inttostr(m);
        if length(mm) = 1 then
        mm := '0'+mm;
      for d := 1 to 30 do begin
        dd:= inttostr(m);
        if length(dd) = 1 then
        dd := '0'+dd;
        ListaLinks.add('https://www.goal.com/br/resultados/' + inttostr(y)+'-'+mm+'-'+dd) ;
      end;
    end;
  end;

  //a.Destroy;
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

procedure ExtrairJogos(AURL: string);
var
times, ano,mes,dia,hora,scoreTime1,scoreTime2: string;
begin
  //extracao
    identificador:= '<meta itemprop="name" content="';
    pagina := GetURL(AURL);

    while pagina.Contains(identificador) do begin
        posicao := pos(identificador, pagina)+length(identificador);
        pagina  := copy(pagina,posicao);
          times:= copy(pagina,1,pos('"', pagina)-1);
        pagina := copy(pagina, pos('<meta itemprop="startDate" content="',pagina));
          ano  := copy(pagina,1,pos('-',pagina)-1);
        pagina := copy(pagina,6);
          mes  := copy(pagina,1,2);
        pagina := copy(pagina,4);
          dia  := copy(pagina,1,2);
          hora := copy(pagina,4,8);
        pagina := copy(pagina,pos('data-bind="scoreHome">',pagina)+length('data-bind="scoreHome">'));
          scoreTime1 := copy(pagina,1,pos('<',pagina));
        pagina := copy(pagina,pos('data-bind="scoreAway">',pagina)+length('data-bind="scoreAway">'));
          scoreTime2 := copy(pagina,1,pos('<',pagina));
        DadosAdicionar.add(  dia+'.'+mes+'.'+ano+'|'+hora+'|'+scoretime1+'|'+times+'|'+scoretime2   );
    end;



end;

procedure TServicoExtracao.BitBtn1Click(Sender: TObject);
var
i           :integer;
begin
    DadosAdicionar := TStringList.Create;
    // memo1.Lines.Text := GetURL('www.goal.com/br/resultados/');
     for i := 0 to ListaLinks.Count -1 do begin
          ExtrairJogos(ListaLinks.Strings[i]);
     end;
     memo1.Lines.Text := DadosAdicionar.Text;
end;

procedure TServicoExtracao.FormCreate(Sender: TObject);
var
Config      : TiniFile;
ipBanco     : string;
localBanco  : string;
begin
     try
        config      := TiniFile.Create(EXTRACTFILEPATH(Application.ExeName)+'config.ini');
        ipBanco    := config.ReadString('config','ipbanco','');
        localBanco := config.ReadString('config','localbanco','');
        database.DBName := ipBanco + ':' + localBanco;
     except
        showmessage('Arquivo Config.ini não encontrado!');
     end;


     try
        database.Connected := true;
     except
        showmessage('Não foi possível conectar ao banco ' + database.DBName + '!');
     end;


    if config <> nil then
        config.Destroy;
    // dataset.Active :=true;
    GeraListalinks;
end;

end.
