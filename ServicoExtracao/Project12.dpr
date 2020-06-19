program Project12;

uses
  Vcl.Forms,
  UServicoExtracao in 'UServicoExtracao.pas' {ServicoExtracao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServicoExtracao, ServicoExtracao);
  Application.Run;
end.
