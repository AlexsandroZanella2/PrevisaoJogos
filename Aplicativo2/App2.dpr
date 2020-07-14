program App2;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit15 in 'Unit15.pas' {Form15},
  UFormAbertura in 'UFormAbertura.pas' {FormAbertura};

{$R *.res}

begin
  Application.Initialize;

 // FormAbertura:=TFormAbertura.Create(Application);
 // FormAbertura.show;

  Application.CreateForm(TFormAbertura, FormAbertura);
  Application.CreateForm(TForm15, Form15);
  // FormAbertura.Hide; {Esconde o FormAbertura}
 // FormAbertura.Free; {Libera Memória}

  Application.Run;
end.
