unit JogoTenis;

interface

uses
  System.SysUtils, System.Classes, FMX.Objects, FMX.Types, FMX.Colors, FMX.Layouts, FMX.StdCtrls,
  System.UITypes ;

type
  TJogoTenis = class(TLayout)
  private
    { Private declarations }
    pCodJogo          :string;
    pCompeticao       :string;
    pJogador1         :string;
    pJogador2         :string;
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
    function  GetJogador1            :string;
    procedure SetJogador1      (Value:string);
    function  GetJogador2            :string;
    procedure SetJogador2      (Value:string);
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
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    procedure CriaLayoutJogadores   ;
      procedure CriaLabelXJogadores ;
        procedure CriaLabelJogador1 ;
        procedure CriaLabelJogador2 ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    procedure CriaLayoutPontuacao   ;
      procedure CriaLabelPontosJ1   ;
      procedure CriaLabelPontosJ2   ;
      procedure CriaLabelXPontuacao ;
        procedure CriaLabelSetsJ1   ;
        procedure CriaLabelSetsJ2   ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    procedure CriaLayoutLiga        ;
      procedure CriaLabelCompeticao ;
      procedure CriaLabelDataCompeticao;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    procedure CriaLayoutSeparador   ;
      procedure CriaLabelSeparador  ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

  protected
    { Protected declarations }
  public
    { Public declarations }
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    FLayoutJogadores        : TLayout ;
      FLabelXJogadores      : TLabel  ;
        FLabelJogador1      : TLabel  ;
        FLabelJogador2      : TLabel  ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    FLayoutPontuacao        : TLayout ;
      FLabelPontosJ1        : TLabel  ;
      FLabelPontosJ2        : TLabel  ;
      FLabelXPontuacao      : TLabel  ;
        FLabelSetsJ1        : TLabel  ;
        FLabelSetsJ2        : TLabel  ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    FLayoutLiga             : TLayout ;
      FLabelCompeticao      : TLabel  ;
      FLabelDataCompeticao  : TLabel  ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    FLayoutSeparador        : TLayout ;
      FLabelSeparador       : TLabel  ;
{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}
    const CorBlack = TColor($000000);
    const CorRed   = TColor($0000FF);
    const CorGreen = TColor($008000);
    const CorCinza = TColor($D3D3D3);
    constructor Create(AOwner: TComponent); overload;
    constructor Create(cCodJogo, cCompeticao, cJogador1, cJogador2, cResultado,
                       cTipo, cDataJogo, cNumSets, cPontosJ1, cPontosJ2, cTotalPontos, cProb1, cProb2,
                       cPrevNumSets, cPrevPontosJ1, cPrevPontosJ2, cPrevTotalPontos:string;AOwner: TComponent); overload;
    destructor  Destroy;                    override;


  published
    { Published declarations }
    property CodJogo          :string read GetCodJogo         write SetCodJogo;
    property Competicao       :string read GetCompeticao      write SetCompeticao;
    property Jogador1         :string read GetJogador1        write SetJogador1;
    property Jogador2         :string read GetJogador2        write SetJogador2;
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

constructor TJogoTenis.Create(cCodJogo, cCompeticao, cJogador1, cJogador2, cResultado,
                       cTipo, cDataJogo, cNumSets, cPontosJ1, cPontosJ2, cTotalPontos, cProb1, cProb2,
                       cPrevNumSets, cPrevPontosJ1, cPrevPontosJ2, cPrevTotalPontos:string;AOwner: TComponent);
begin
  inherited Create(AOwner);
        Height          :=  105    ;
        Width           :=  200   ;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        Align := TAlignLayout.Top;

        pCodJogo          := cCodJogo         ;
        pCompeticao       := cCompeticao      ;
        pJogador1         := cJogador1        ;
        pJogador2         := cJogador2        ;
        pResultado        := cResultado       ;
        pTipo             := cTipo            ;
        pDataJogo         := cDataJogo        ;
        pNumSets          := cNumSets         ;
        pPontosJ1         := cPontosJ1        ;
        pPontosJ2         := cPontosJ2        ;
        pTotalPontos      := cTotalPontos     ;
        pProb1            := cProb1           ;
        pProb2            := cProb2           ;
        pPrevNumSets      := cPrevNumSets     ;
        pPrevPontosJ1     := cPrevPontosJ1    ;
        pPrevPontosJ2     := cPrevPontosJ2    ;
        pPrevTotalPontos  := cPrevTotalPontos ;

        CriaLayoutJogadores;
        CriaLayoutPontuacao;
        CriaLayoutLiga;
        CriaLayoutSeparador;
end;

constructor TJogoTenis.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
        Height          :=  105    ;
        Width           :=  200   ;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        Align := TAlignLayout.Top;
        CriaLayoutJogadores;
        CriaLayoutPontuacao;
        CriaLayoutLiga;
        CriaLayoutSeparador;
end;

destructor TJogoTenis.Destroy;
begin
   inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Standard', [TJogoTenis]);
end;

{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

procedure TJogoTenis.CriaLayoutJogadores;
begin
  FLayoutJogadores := TLayout.Create(Self);
    with FLayoutJogadores do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Top   ;
        Height          :=  33    ;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelXJogadores;
      end;
end;

procedure TJogoTenis.CriaLabelXJogadores;
begin
  FLabelXJogadores := TLabel.Create(Self);
    with FLabelXJogadores do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Client;
        Text            := 'X';
        TextSettings.Font.Size := 18;
        TextSettings.FontColor := TColor($000000);
        TextSettings.HorzAlign := TTextAlign.Center;
        TextSettings.VertAlign := TTextAlign.Center;
        Visible         :=  True  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelJogador1;
        CriaLabelJogador2;
      end;
end;


procedure TJogoTenis.CriaLabelJogador1;
begin
  FLabelJogador1 := TLabel.Create(Self);
    with FLabelJogador1 do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Left;
        Text            := pJogador1;
        TextSettings.Font.Size := 18;
        TextSettings.FontColor := CorBlack;
        TextSettings.HorzAlign := TTextAlign.Trailing;
        TextSettings.VertAlign := TTextAlign.Center;
        Visible         :=  True  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

procedure TJogoTenis.CriaLabelJogador2;
begin
  FLabelJogador2 := TLabel.Create(Self);
    with FLabelJogador2 do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Right;
        Text            := pJogador2;
        TextSettings.Font.Size := 18;
        TextSettings.FontColor := CorBlack;
        TextSettings.HorzAlign := TTextAlign.Leading;
        TextSettings.VertAlign := TTextAlign.Center;
        Visible         :=  True  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

procedure TJogoTenis.CriaLayoutPontuacao;
begin
  FLayoutPontuacao := TLayout.Create(Self);
    with FLayoutPontuacao do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Top   ;
        Height          :=  33    ;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelPontosJ1         ;
        CriaLabelPontosJ2         ;
        CriaLabelXPontuacao       ;
      end;
end;

procedure TJogoTenis.CriaLabelPontosJ1;
begin
  FLabelPontosJ1 := TLabel.Create(Self);
    with FLabelPontosJ1 do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Left   ;
        if pTipo = 'P' then begin
          Text := pPrevPontosJ1;
        end else if pTipo = 'E' then begin
          Text := pPontosJ1;
        end else if pTipo = 'C' then begin
          Text := '-';
        end else begin
          Text := '-';
        end;
        TextSettings.FontColor := CorBlack;
        TextSettings.Font.Size := 18;
        TextSettings.HorzAlign := TTextAlign.Leading;
        Width                  := 82;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

procedure TJogoTenis.CriaLabelPontosJ2;
begin
  FLabelPontosJ2 := TLabel.Create(Self);
    with FLabelPontosJ2 do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Right   ;
        if pTipo = 'P' then begin
          Text := pPrevPontosJ2;
        end else if pTipo = 'E' then begin
          Text := pPontosJ2;
        end else if pTipo = 'C' then begin
          Text := '-';
        end else begin
          Text := '-';
        end;
        TextSettings.FontColor := CorBlack;
        TextSettings.Font.Size := 18;
        TextSettings.HorzAlign := TTextAlign.Trailing;
        Width                  := 82;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

procedure TJogoTenis.CriaLabelXPontuacao;
begin
  FLabelXPontuacao := TLabel.Create(Self);
    with FLabelXPontuacao do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.HorzCenter;
        Text            := 'X';
        TextSettings.FontColor := CorBlack;
        TextSettings.Font.Size := 18;
        TextSettings.HorzAlign := TTextAlign.Center;
        Height                  := 33;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelSetsJ1;
        CriaLabelSetsJ2;
      end;
end;

procedure TJogoTenis.CriaLabelSetsJ1;
begin
  FLabelSetsJ1 := TLabel.Create(Self);
    with FLabelSetsJ1 do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Left;

        if pTipo = 'E' then begin
           Text            := copy(pResultado, 1, pos(':',pResultado)-1);
           if strtoint(Text) > strtoint(copy(pResultado, pos(':',pResultado)+1)) then begin
              TextSettings.FontColor := CorGreen;
           end else if strtoint(Text) < strtoint(copy(pResultado, pos(':',pResultado)+1)) then begin
              TextSettings.FontColor := CorRed;
           end else begin
              TextSettings.FontColor := CorBlack;
           end;

        end else if pTipo = 'P' then begin
           Text           := pProb1;
           if strtoint(Text) > 50 then begin
              TextSettings.FontColor := CorGreen;
           end else if strtoint(Text) < 50 then begin
              TextSettings.FontColor := CorRed;
           end else begin
              TextSettings.FontColor := CorBlack;
           end;
           Text := Text + '%';
        end else if pTipo = 'C' then begin
           Text := '-';

        end else begin
           Text := '-';
        end;

        TextSettings.Font.Size := 18;
        TextSettings.HorzAlign := TTextAlign.Center;
        Height                  := 33;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

procedure TJogoTenis.CriaLabelSetsJ2;
begin
  FLabelSetsJ2 := TLabel.Create(Self);
    with FLabelSetsJ2 do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Left;

        if pTipo = 'E' then begin
           Text            := copy(pResultado, pos(':',pResultado)+1);

           if strtoint(Text) > strtoint(copy(pResultado, 1, pos(':',pResultado)-1)) then begin
              TextSettings.FontColor := CorGreen;
           end else if strtoint(Text) < strtoint(copy(pResultado, pos(':',pResultado)+1)) then begin
              TextSettings.FontColor := CorRed;
           end else begin
              TextSettings.FontColor := corBlack;
           end;
           Text := Text + '%';

        end else if pTipo = 'P' then begin
           Text           := pProb1;
           if strtoint(Text) > 50 then begin
              TextSettings.FontColor := corGreen;
           end else if strtoint(Text) < 50 then begin
              TextSettings.FontColor := corRed;
           end else begin
              TextSettings.FontColor := corBlack;
           end;
           Text := Text + '%';
        end else if pTipo = 'C' then begin
           Text := '-';

        end else begin
           Text := '-';
        end;

        TextSettings.Font.Size := 18;
        TextSettings.HorzAlign := TTextAlign.Center;
        Height                  := 33;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

procedure TJogoTenis.CriaLayoutLiga;
begin
  FLayoutLiga := TLayout.Create(Self);
    with FLayoutLiga do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Top   ;
        Height          :=  33    ;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelCompeticao       ;
      end;
end;

procedure TJogoTenis.CriaLabelCompeticao;
begin
  FLabelCompeticao := TLabel.Create(Self);
    with FLabelCompeticao do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Client   ;
        if pTipo = 'P' then begin
        Text            := pCompeticao + ' - ' + pPrevTotalPontos;
        end else if ptipo = 'E' then begin
          Text := pCompeticao + ' - ' + pTotalPontos;
        end else if pTipo = 'C' then begin
          Text := pCompeticao + ' - Cancelado';
        end;
        TextSettings.FontColor := corBlack;
        TextSettings.Font.Size := 14;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelDataCompeticao   ;
      end;
end;

procedure TJogoTenis.CriaLabelDataCompeticao;
begin
  FLabelDataCompeticao := TLabel.Create(Self);
    with FLabelDataCompeticao do
      begin
        Parent          :=  Self                  ;
        Align           :=  TAlignLayout.Right    ;
        Text            := pDataJogo              ;
        TextSettings.FontColor := corBlack         ;
        TextSettings.Font.Size := 14              ;
        Visible         :=  true                  ;
        Margins.Left    :=  0                     ;
        Margins.Right   :=  0                     ;
        Margins.Top     :=  0                     ;
        Margins.Bottom  :=  0                     ;
      end;
end;

{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

procedure TJogoTenis.CriaLayoutSeparador;
begin
  FLayoutSeparador := TLayout.Create(Self);
    with FLayoutSeparador do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Top  ;
        Height          :=  8    ;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
        CriaLabelSeparador        ;
      end;
end;

procedure TJogoTenis.CriaLabelSeparador;
begin
  FLabelSeparador := TLabel.Create(Self);
    with FLabelSeparador do
      begin
        Parent          :=  Self  ;
        Align           :=  TAlignLayout.Client   ;
        Text            := '__________________________________________';
        TextSettings.FontColor := CorCinza;
        Visible         :=  true  ;
        Margins.Left    :=  0     ;
        Margins.Right   :=  0     ;
        Margins.Top     :=  0     ;
        Margins.Bottom  :=  0     ;
      end;
end;

{:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::}

function  TJogoTenis.GetCodJogo              :string;
begin
  result := pCodJogo;
end;

procedure TJogoTenis.SetCodJogo        (Value:string);
begin
  pCodJogo := Value;
end;

function  TJogoTenis.GetCompeticao           :string;
begin
  Result := pCompeticao;
end;

procedure TJogoTenis.SetCompeticao     (Value:string);
begin
  pCompeticao := Value;
end;

function  TJogoTenis.GetJogador1            :string;
begin
  result := pJogador1;
end;

procedure TJogoTenis.SetJogador1      (Value:string);
begin
  pJogador1 := Value;
end;

function  TJogoTenis.GetJogador2            :string;
begin
  Result := pJogador2;
end;

procedure TJogoTenis.SetJogador2      (Value:string);
begin
  pJogador2 := Value;
end;

function  TJogoTenis.GetResultado            :string;
begin
  Result := pResultado;
end;

procedure TJogoTenis.SetResultado      (Value:string);
begin
  pResultado := Value;
end;

function  TJogoTenis.GetTipo                 :string;
begin
  Result := pTipo;
end;

procedure TJogoTenis.SetTipo           (Value:string);
begin
  pTipo := Value;
end;

function  TJogoTenis.GetDataJogo             :string;
begin
  Result := pDataJogo;
end;

procedure TJogoTenis.SetDataJogo       (Value:string);
begin
  pDataJogo := Value;
end;

function  TJogoTenis.GetNumSets              :string;
begin
  Result := pNumSets;
end;

procedure TJogoTenis.SetNumSets        (Value:string);
begin
  pNumSets := Value;
end;

function  TJogoTenis.GetPontosJ1             :string;
begin
  Result := pPontosJ1;
end;

procedure TJogoTenis.SetPontosJ1       (Value:string);
begin
  pPontosJ1 := Value;
end;

function  TJogoTenis.GetPontosJ2             :string;
begin
  Result := pPontosJ2;
end;

procedure TJogoTenis.SetPontosJ2       (Value:string);
begin
  pPontosJ2 := Value;
end;

function  TJogoTenis.GetTotalPontos          :string;
begin
  Result := pTotalPontos;
end;

procedure TJogoTenis.SetTotalPontos    (Value:string);
begin
  pTotalPontos := Value;
end;

function  TJogoTenis.GetProb1                :string;
begin
  Result := pProb1;
end;

procedure TJogoTenis.SetProb1          (Value:string);
begin
  pProb1 := Value;
end;

function  TJogoTenis.GetProb2                :string;
begin
  Result := pProb2;
end;

procedure TJogoTenis.SetProb2          (Value:string);
begin
  pProb2 := Value;
end;

function  TJogoTenis.GetPrevNumSets          :string;
begin
  Result := pPrevNumSets;
end;

procedure TJogoTenis.SetPrevNumSets    (Value:string);
begin
  pPrevNumSets := Value;
end;

function  TJogoTenis.GetPrevPontosJ1         :string;
begin
  Result := pPrevPontosJ1;
end;

procedure TJogoTenis.SetPrevPontosJ1   (Value:string);
begin
  pPrevPontosJ1 := Value;
end;

function  TJogoTenis.GetPrevPontosJ2         :string;
begin
  Result := pPrevPontosJ2
end;

procedure TJogoTenis.SetPrevPontosJ2   (Value:string);
begin
  pPrevPontosJ2 := Value;
end;

function  TJogoTenis.GetPrevTotalPontos      :string;
begin
  Result :=  pPrevTotalPontos;
end;

procedure TJogoTenis.SetPrevTotalPontos(Value:string);
begin
  pPrevTotalPontos := Value;
end;

end.
