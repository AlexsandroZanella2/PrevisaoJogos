program ExtracaoInicial;

uses
  Vcl.Forms,
  UServicoExtracao in 'UServicoExtracao.pas' {ServicoExtracaoInicial};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServicoExtracaoInicial, ServicoExtracaoInicial);
  Application.Run;
end.
