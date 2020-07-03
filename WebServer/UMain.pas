unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, IdCustomHTTPServer,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdHTTPServer, Vcl.ExtCtrls,
  Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Buttons, SysTypes, ServerMethodsUnit1,ServerUtils,
  FIBDatabase, pFIBDatabase, Data.DB, FIBDataSet, pFIBDataSet, FIBQuery,
  pFIBQuery;

type
  Tfrm_Main = class(TForm)
    IdHTTPServer1: TIdHTTPServer;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    btnAtivar: TBitBtn;
    txtinfolabel: TLabel;
    btnParar: TBitBtn;
    memoResp: TMemo;
    memoReq: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    pFIBQuery1: TpFIBQuery;
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure btnAtivarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
    procedure IdHTTPServer1CommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
    procedure LoglastRequest (ARequestInfo: TIdHTTPRequestInfo);
    procedure LogLastResponse (AResponseInfo: TIdHTTPResponseInfo);
  public
    { Public declarations }
  end;

var
  frm_Main: Tfrm_Main;
  CriticalSection: TRTLCriticalSection;

implementation

{$R *.dfm}

procedure Tfrm_Main.LoglastRequest (ARequestInfo: TIdHTTPRequestInfo);
Begin
     EnterCriticalSection(CriticalSection);
     memoReq.Lines.Add(ARequestInfo.UserAgent + #13 + #10 +
                       ARequestInfo.RawHTTPCommand);
     LeaveCriticalSection(CriticalSection);
End;

procedure Tfrm_Main.LogLastResponse (AResponseInfo: TIdHTTPResponseInfo);
Begin
     EnterCriticalSection(CriticalSection);
     memoResp.Lines.Add(AResponseInfo.ContentText);
     LeaveCriticalSection(CriticalSection);
End;

procedure Tfrm_Main.ApplicationEvents1Minimize(Sender: TObject);
begin
   // Quando minimizado mostra o Balloon
     Self.Hide();
     Self.WindowState := wsMinimized;
     TrayIcon1.Visible := True;
     TrayIcon1.Animate := True;
     TrayIcon1.ShowBalloonHint;
end;

procedure Tfrm_Main.btnAtivarClick(Sender: TObject);
begin
      IdHTTPServer1.Active := True;
      txtInfoLabel.Caption := 'Aguardando requisições...';
end;

procedure Tfrm_Main.btnPararClick(Sender: TObject);
begin
      IdHTTPServer1.Active := False;
      txtInfoLabel.Caption := 'WebService parado.';
end;

procedure Tfrm_Main.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
Var
     Cmd           : String;
     Argumentos    : TArguments;
     ServerMethod1 : TServerMethods1;
     JSONStr       : string;
begin
     Cmd := ARequestInfo.RawHTTPCommand;
     if (UpperCase(Copy (Cmd, 1, 3)) = 'GET') OR
        (UpperCase(Copy (Cmd, 1, 4)) = 'POST') OR
        (UpperCase(Copy (Cmd, 1, 3)) = 'HEAD')
     then Begin
        Argumentos    := TServerUtils.ParseRESTURL (ARequestInfo.URI);
        ServerMethod1 := TServerMethods1.Create (nil);
        Try
           LoglastRequest (ARequestInfo);
           If UpperCase(Copy (Cmd, 1, 3)) = 'GET' Then
              JSONStr := ServerMethod1.CallGETServerMethod(Argumentos);
           If UpperCase(Copy (Cmd, 1, 4)) = 'POST' Then
              JSONStr := ServerMethod1.CallPOSTServerMethod(Argumentos);

           AResponseInfo.ContentText := JSONStr;
           LoglastResponse (AResponseInfo);
           AResponseInfo.WriteContent;
        Finally
           ServerMethod1.Free;
        End;
     end;
end;

procedure Tfrm_Main.IdHTTPServer1CommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
Var
     Cmd           : String;
     Argumentos    : TArguments;
     ServerMethod1 : TServerMethods1;
     JSONStr       : string;
begin
     Cmd := ARequestInfo.RawHTTPCommand;                                       //1
     if (UpperCase(Copy (Cmd, 1, 3)) = 'PUT') OR
        (UpperCase(Copy (Cmd, 1, 6)) = 'DELETE')
     then Begin
        Argumentos    := TServerUtils.ParseRESTURL (ARequestInfo.URI);
        ServerMethod1 := TServerMethods1.Create (nil);
        Try
           LoglastRequest (ARequestInfo);
           If UpperCase(Copy (Cmd, 1, 3)) = 'PUT' Then
              JSONStr := ServerMethod1.CallPUTServerMethod(Argumentos);
           If UpperCase(Copy (Cmd, 1, 6)) = 'DELETE' Then
              JSONStr := ServerMethod1.CallDELETEServerMethod(Argumentos);

           AResponseInfo.ContentText := JSONStr;
           LoglastResponse (AResponseInfo);
           AResponseInfo.WriteContent;
        Finally
           ServerMethod1.Free;
        End;
     end;
end;

procedure Tfrm_Main.TrayIcon1Click(Sender: TObject);
begin
    // Minimiza para o Tray
     TrayIcon1.Visible := False;
     Show();
     WindowState := wsNormal;
     Application.BringToFront();
end;

initialization
  InitializeCriticalSection(CriticalSection);

finalization
  DeleteCriticalSection(CriticalSection);

end.
