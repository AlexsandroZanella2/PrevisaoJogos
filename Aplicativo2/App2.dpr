program App2;

uses
  System.StartUpCopy,
  FMX.Forms,
  system.sysUtils,
  Unit15 in 'Unit15.pas' {Form15},
  UFormAbertura in 'UFormAbertura.pas' {FormAbertura},
  JogoTenis in '..\componentes\JogoTenis\JogoTenis.pas';

{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(TForm15, Form15);
  Application.Run;
end.
