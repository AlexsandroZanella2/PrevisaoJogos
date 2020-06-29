program ServicoWeb;

{$APPTYPE CONSOLE}

uses
  Web.WebBroker,
  CGIApp,
  WebServer in 'WebServer.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
