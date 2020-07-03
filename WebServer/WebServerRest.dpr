program WebServerRest;



uses
  Vcl.Forms,
  UMain in 'UMain.pas' {frm_Main},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas',
  SysTypes in 'SysTypes.pas',
  ServerUtils in 'ServerUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.Run;
end.
