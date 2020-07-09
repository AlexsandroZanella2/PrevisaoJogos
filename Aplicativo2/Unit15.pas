unit Unit15;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Gestures, FMX.Colors,
  FMX.DateTimeCtrls, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  System.ImageList, FMX.ImgList, System.IOUtils, iniFiles, DateUtils;

type
  TForm15 = class(TForm)
    TabControl3: TTabControl;
    TabItem7: TTabItem;
    ToolBar3: TToolBar;
    SpeedButton1: TSpeedButton;
    VertScrollBox4: TVertScrollBox;
    TabItem8: TTabItem;
    ToolBar6: TToolBar;
    Label4: TLabel;
    SpeedButton4: TSpeedButton;
    VertScrollBox7: TVertScrollBox;
    MultiView1: TMultiView;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Image2: TImage;
    lbUsuario: TLabel;
    lbCPF: TLabel;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    ltLogReg: TLayout;
    Layout6: TLayout;
    lbLoginUsr: TLabel;
    Layout8: TLayout;
    Label2: TLabel;
    Layout5: TLayout;
    Edit1: TEdit;
    Layout7: TLayout;
    Edit2: TEdit;
    Layout16: TLayout;
    Layout17: TLayout;
    Layout18: TLayout;
    RoundRect2: TRoundRect;
    Label3: TLabel;
    Layout19: TLayout;
    RoundRect3: TRoundRect;
    Label5: TLabel;
    Layout20: TLayout;
    ltAssinar: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    RoundRect1: TRoundRect;
    Label6: TLabel;
    Layout12: TLayout;
    Layout14: TLayout;
    CheckBox1: TCheckBox;
    Layout13: TLayout;
    Layout15: TLayout;
    CheckBox2: TCheckBox;
    Layout4: TLayout;
    Image1: TImage;
    stMenu: TSpeedButton;
    ActionList1: TActionList;
    GestureManager1: TGestureManager;
    PreviousTabAction1: TPreviousTabAction;
    NextTabAction1: TNextTabAction;
    Layout1: TLayout;
    Layout9: TLayout;
    Label7: TLabel;
    Layout21: TLayout;
    Layout22: TLayout;
    ColorButton1: TColorButton;
    Label8: TLabel;
    Layout23: TLayout;
    Edit4: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    ltFiltros: TLayout;
    Layout24: TLayout;
    Image3: TImage;
    Layout25: TLayout;
    DateEdit1: TDateEdit;
    Layout3D1: TLayout3D;
    Layout26: TLayout;
    Layout27: TLayout;
    Layout28: TLayout;
    Layout29: TLayout;
    Layout30: TLayout;
    Layout31: TLayout;
    Layout32: TLayout;
    CheckBox3: TCheckBox;
    Layout33: TLayout;
    Edit6: TEdit;
    SpeedButton2: TSpeedButton;
    ltDadosJogos: TLayout;
    ltNewUser: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure CarregaDados;
    function Login(user,pass:string):boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;
  logOK: boolean;
  usuario: string;
  senha: string;
  dataPermissao : tdatetime;
  dtNascimento:string;
  filtroProbs: string;
  email: string;
  cpf:string;
  Config:tiniFile;

implementation

{$R *.fmx}

function TForm15.Login(user,pass:string):Boolean;
begin
  //
  Result := true;
end;

procedure TForm15.CarregaDados;
var
asd:tstringlist;
begin
  if TFile.Exists(System.IOUtils.TPath.Combine(System.IOUtils.tpath.getdocumentspath,'system.ini')) then begin
    try
    config := TIniFile.Create(System.IOUtils.TPath.Combine(System.IOUtils.tpath.getdocumentspath,'system.ini'));
    usuario := Config.readString('CONFIG','usuario','');
    senha   := Config.readString('CONFIG','senha','');
    cpf := Config.readString('CONFIG','cpf','');
    email := Config.ReadString('CONFIG','email','');
    dataPermissao := strtodatetime(Config.ReadString('CONFIG','permissao',''));
    dtNascimento  := Config.ReadString('CONFIG','nascimento','');
    filtroProbs   := Config.ReadString('CONFIG','filtroprobs','');
    logOK := Login(cpf,senha);
    except
      logOk := true;
    end;
  end else begin
      logOK := true;

    try
     asd := TStringList.Create;
     asd.Add('[CONFIG]');
     ASD.Add('cpf='+'000.000.000-00');
     asd.Add('usuario='+'Alexsandro Zanella');
     asd.Add('email=teste@teste.com');
     asd.Add('permissao=30.12.2099 00:00');
     asd.Add('nascimento=01.01.1999');
     asd.Add('senha=teste');
     asd.Add('filtroprobs=60');
     asd.SaveToFile(System.IOUtils.TPath.Combine(System.IOUtils.tpath.getdocumentspath,'system.ini'));
    finally
      ShowMessage('Arquivo criado!');
    end;

  end;
end;

procedure TForm15.DateEdit1Change(Sender: TObject);
begin
    if logOK then begin
         if formatdatetime('dd/MM/yyyy',DateEdit1.Date) = formatdatetime('dd/MM/yyyy',now) then begin
           // http://localhost:8080/GetListaJogosAtuais/usuario/senha/probs
         end;
         if formatdatetime('dd/MM/yyyy',DateEdit1.Date) > formatdatetime('dd/MM/yyyy',now) then begin
           // http://localhost:8080/GetListaJogosFuturos/usuario/senha/probs
         end;
         if formatdatetime('dd/MM/yyyy',DateEdit1.Date) < formatdatetime('dd/MM/yyyy',now) then begin
           // http://localhost:8080/GetListaJogosPassados/usuario/senha/data
         end;
    end;
end;

procedure TForm15.FormCreate(Sender: TObject);

begin
     DateEdit1.Date := strtodate(formatdatetime('dd/MM/yyyy',now));
     CarregaDados;

     if logOK then begin
        ltNewUser.Visible := false;
        lbUsuario.Text := usuario;
        lbCPF.Text     := CPF;
        ltLogReg.Visible:= false;
        if now > incday(dataPermissao,-3) then begin
            ltAssinar.Visible := true;
        end else begin
            ltAssinar.Visible := False;
        end;

     end;
end;

end.
