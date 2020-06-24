program PainelControle;

uses
  Vcl.Forms,
  Unit13 in 'Unit13.pas' {FControl};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFControl, FControl);
  Application.Run;
end.
