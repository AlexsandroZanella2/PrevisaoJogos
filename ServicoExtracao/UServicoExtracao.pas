unit UServicoExtracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FIBDatabase, pFIBDatabase, Data.DB,
  FIBDataSet, pFIBDataSet, Vcl.StdCtrls, Vcl.Buttons, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.OleCtrls, SHDocVw, ActiveX,iniFiles, Vcl.ComCtrls;

type
  TServicoExtracaoInicial = class(TForm)
    BitBtn1           : TBitBtn;
    DataBase: TpFIBDatabase;
    DataSet: TpFIBDataSet;
    Transacao: TpFIBTransaction;
    Button1: TButton;
    DataSource: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    BitBtn2: TBitBtn;
    TabSheet3: TTabSheet;
    Memo3: TMemo;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExtrairJogosFutebol(AURL: string);
    procedure BitBtn2Click(Sender: TObject);
    procedure GeraListalinks;
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  ServicoExtracaoInicial : TServicoExtracaoInicial;
  ListaLinks      : TstringList;
  DadosAdicionar  : TStringList;
  pagina          :tstringlist;
  retorno         :TstringList;
  posicao         :integer;
  identificador   :string;

implementation

{$R *.dfm}

procedure TServicoExtracaoInicial.GeraListalinks;
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
  for y := 2015 to 2020 do begin
    for m := 1 to 12 do begin
        mm:= inttostr(m);
        if length(mm) = 1 then
        mm := '0'+mm;
      for d := 1 to 31 do begin
        dd:= inttostr(d);
        if length(dd) = 1 then
        dd := '0'+dd;
        ListaLinks.add('https://www.goal.com/br/resultados/' + inttostr(y)+'-'+mm+'-'+dd) ;
      end;
    end;
  end;
  memo2.lines.text := ListaLinks.Text;
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

procedure TServicoExtracaoInicial.BitBtn2Click(Sender: TObject);
begin
    GeraListalinks;
end;

procedure TServicoExtracaoInicial.BitBtn3Click(Sender: TObject);
begin
memo3.Lines.Text := getURL(edit1.Text);
end;

procedure TServicoExtracaoInicial.ExtrairJogosFutebol(AURL: string);
var
time1,time2, ano,mes,dia,hora,scoreTime1,scoreTime2,competicao: string;
begin
  //extracao
    pagina := tstringlist.create;
    identificador:= '<span class="match-row__date">';
    pagina.Text := GetURL(AURL);
    //pagina.SaveToFile('teste.txt');
    //memo1.Lines.Text := pagina.Text;
    while pagina.Text.Contains(identificador) do begin
        posicao := pos(identificador, pagina.Text)+length(identificador);
        pagina.Text  := copy(pagina.Text,posicao);
          dia  := copy(pagina.Text,1,2);
        pagina.Text := copy(pagina.Text,4);
          mes  := copy(pagina.Text,1,2);
        pagina.Text := copy(pagina.Text,4);
          ano  := copy(pagina.Text,1,4);
        pagina.Text := copy(pagina.Text,7);
          hora := copy(pagina.Text,1,5);
        pagina.text := copy(pagina.text,pos('<b class="match-row__goals">',pagina.text)+length('<b class="match-row__goals">'));
          scoreTime1:= copy(pagina.text,1,1);
        pagina.text := copy(pagina.text,pos('<b class="match-row__goals">',pagina.text)+length('<b class="match-row__goals">'));
          scoreTime2:= copy(pagina.text,1,1);
        pagina.text := copy(pagina.text,pos('<span class="match-row__team-name">',pagina.text)+length('<span class="match-row__team-name">'));
          time1 := copy(pagina.text,1,pos('<',pagina.text)-1);
        pagina.text := copy(pagina.text,pos('<span class="match-row__team-name">',pagina.text)+length('<span class="match-row__team-name">'));
          time2 := copy(pagina.text,1,pos('<',pagina.text)-1);
        pagina.text := copy(pagina.text,pos('<span class="competition-name">',pagina.text)+length('<span class="competition-name">'));
          competicao := copy(pagina.text,1,pos('<',pagina.text)-1);

        DadosAdicionar.add(  dia+'.'+mes+'.'+ano+'|'+hora+'|'+scoretime1+'|'+time1+'|'+time2+'|'+scoretime2+'|'+competicao);
    end;


    pagina.destroy;
end;

procedure TServicoExtracaoInicial.BitBtn1Click(Sender: TObject);
var
i           :integer;
begin
    DadosAdicionar := TStringList.Create;
    // memo1.Lines.Text := GetURL('www.goal.com/br/resultados/');
     for i := 0 to memo2.Lines.Count -1 do begin
          ExtrairJogosFutebol(memo2.Lines[i]);

     end;
         memo1.Lines.Text := DadosAdicionar.Text;
end;

procedure TServicoExtracaoInicial.FormCreate(Sender: TObject);
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

end;

end.
