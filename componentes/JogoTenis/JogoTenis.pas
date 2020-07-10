unit JogoTenis;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Colors;

type
  TJogoTenis = class(TPanel)
  private
    { Private declarations }
    pCodJogo          :string;
    pCompeticao       :string;
    pJogadores        :string;
    pResultado        :string;
    pTipo             :string;
    pDataJogo         :string;
    pNumSets          :string;
    pPontosJ1         :string;
    pPontosJ2         :string;
    pTotalPontos      :string;
    pProb1            :string;
    pProb2            :string;
    pPrevNumSets      :string;
    pPrevPontosJ1     :string;
    pPrevPontosJ2     :string;
    pPrevTotalPontos  :string;

    function  GetCodJogo              :string;
    procedure SetCodJogo        (Value:string);
    function  GetCompeticao           :string;
    procedure SetCompeticao     (Value:string);
    function  GetJogadores            :string;
    procedure SetJogadores      (Value:string);
    function  GetResultado            :string;
    procedure SetResultado      (Value:string);
    function  GetTipo                 :string;
    procedure SetTipo           (Value:string);
    function  GetDataJogo             :string;
    procedure SetDataJogo       (Value:string);
    function  GetNumSets              :string;
    procedure SetNumSets        (Value:string);
    function  GetPontosJ1             :string;
    procedure SetPontosJ1       (Value:string);
    function  GetPontosJ2             :string;
    procedure SetPontosJ2       (Value:string);
    function  GetTotalPontos          :string;
    procedure SetTotalPontos    (Value:string);
    function  GetProb1                :string;
    procedure SetProb1          (Value:string);
    function  GetProb2                :string;
    procedure SetProb2          (Value:string);
    function  GetPrevNumSets          :string;
    procedure SetPrevNumSets    (Value:string);
    function  GetPrevPontosJ1         :string;
    procedure SetPrevPontosJ1   (Value:string);
    function  GetPrevPontosJ2         :string;
    procedure SetPrevPontosJ2   (Value:string);
    function  GetPrevTotalPontos      :string;
    procedure SetPrevTotalPontos(Value:string);


  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

  published
    { Published declarations }
    property CodJogo          :string read GetCodJogo         write SetCodJogo;
    property Competicao       :string read GetCompeticao      write SetCompeticao;
    property Jogadores        :string read GetJogadores       write SetJogadores;
    property Resultado        :string read GetResultado       write SetResultado;
    property Tipo             :string read GetTipo            write SetTipo;
    property DataJogo         :string read GetDataJogo        write SetDataJogo;
    property NumSets          :string read GetNumSets         write SetNumSets;
    property PontosJ1         :string read GetPontosJ1        write SetPontosJ1;
    property PontosJ2         :string read GetPontosJ2        write SetPontosJ2;
    property TotalPontos      :string read GetTotalPontos     write SetTotalPontos;
    property Prob1            :string read GetProb1           write SetProb1;
    property Prob2            :string read GetProb2           write SetProb2;
    property PrevNumSets      :string read GetPrevNumSets     write SetPrevNumSets;
    property PrevPontosJ1     :string read GetPrevPontosJ1    write SetPrevPontosJ1;
    property PrevPontosJ2     :string read GetPrevPontosJ2    write SetPrevPontosJ2;
    property PrevTotalPontos  :string read GetPrevTotalPontos write SetPrevTotalPontos;


  end;

procedure Register;

implementation

constructor TJogoTenis.Create(AOwner: TComponent);
begin
  //
end;

procedure Register;
begin
  RegisterComponents('Standard', [TJogoTenis]);
end;

end.
