unit formMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,   REST.Types, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  REST.Response.Adapter, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm2 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btnPut: TButton;
    btnGet: TButton;
    btnPost: TButton;
    btnDelete: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Memo2: TMemo;
    Label2: TLabel;
    FDMemTable1: TFDMemTable;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    DataSource1: TDataSource;
    RESTResponse2: TRESTResponse;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    procedure btnPutClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    procedure ListAlunos;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.ListAlunos;
begin
     Memo2.Lines.Clear;
     Memo2.Lines.Add(RESTResponse1.Content);

     RESTClient2.BaseURL := 'http://localhost:8080/GetListaAlunos';
     RESTRequest2.Method := TRESTRequestMethod.rmGET;
     RESTRequest2.Execute;
     Memo1.Lines.Clear;
     Memo1.Lines.add(RESTResponse2.Content);
end;


procedure TForm2.btnGetClick(Sender: TObject);
Var
     Aluno : String;
begin
     Aluno := InputBox('Rest Client', 'Nome do aluno', '');
     if Aluno <> '' then Begin
        RESTClient1.BaseURL := 'http://localhost:8080/ConsultaAluno/' + Aluno;
        RESTRequest1.Method := TRESTRequestMethod.rmGET;
        RESTRequest1.Execute;
        ListAlunos;
     End;
end;

procedure TForm2.btnPostClick(Sender: TObject);
Var
     Aluno : String;
     NomeNovo : string;
begin
     Aluno := InputBox('Rest Client', 'Nome do aluno', '');
     if Aluno <> '' then Begin
        NomeNovo := InputBox('Rest Client', 'Alterar Nome para', '');
        if NomeNovo <> '' then Begin
           RESTClient1.BaseURL := 'http://localhost:8080/AtualizaAluno/' + Aluno + '/' + NomeNovo;
           RESTRequest1.Method := TRESTRequestMethod.rmPOST;
           RESTRequest1.Execute;
           ListAlunos;
        End;
     End;
end;

procedure TForm2.btnPutClick(Sender: TObject);
Var
     Aluno : String;
begin
     Aluno := InputBox('Rest Client', 'Nome do aluno', '');
     if Aluno <> '' then Begin
        RESTClient1.BaseURL := 'http://localhost:8080/InsereAluno/' + Aluno;
        RESTRequest1.Method := TRESTRequestMethod.rmPUT;
        RESTRequest1.Execute;
        ListAlunos;
     End;
end;

procedure TForm2.btnDeleteClick(Sender: TObject);
Var
     Aluno : String;
begin
     Aluno := InputBox('Rest Client', 'Nome do aluno', '');
     if Aluno <> '' then Begin
        RESTClient1.BaseURL := 'http://localhost:8080/ExcluiAluno/' + Aluno;
        RESTRequest1.Method := TRESTRequestMethod.rmDELETE;
        RESTRequest1.Execute;
        ListAlunos;
     End;
end;

end.
