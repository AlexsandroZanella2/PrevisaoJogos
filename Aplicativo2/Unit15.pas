unit Unit15;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Gestures, FMX.Colors,
  FMX.DateTimeCtrls, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  System.ImageList, FMX.ImgList, System.IOUtils, iniFiles, DateUtils, IdURI,
   FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText, Androidapi.Jni.Net,
    Androidapi.Jni.JavaTypes, Androidapi.Helpers, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

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
    Layout13: TLayout;
    Layout4: TLayout;
    Image1: TImage;
    stMenu: TSpeedButton;
    ActionList1: TActionList;
    GestureManager1: TGestureManager;
    PreviousTabAction1: TPreviousTabAction;
    NextTabAction1: TNextTabAction;
    ltFiltros: TLayout;
    Layout24: TLayout;
    Image3: TImage;
    Layout25: TLayout;
    DateEdit1: TDateEdit;
    ltDadosJogos: TLayout;
    ltNewUser: TLayout;
    TabItem1: TTabItem;
    ToolBar1: TToolBar;
    SpeedButton3: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label1: TLabel;
    VertScrollBox1: TVertScrollBox;
    Layout34: TLayout;
    Layout35: TLayout;
    Label9: TLabel;
    Layout36: TLayout;
    CheckBox4: TCheckBox;
    Layout39: TLayout;
    Edit3: TEdit;
    Edit5: TEdit;
    Edit9: TEdit;
    Layout3D2: TLayout3D;
    Layout40: TLayout;
    Layout41: TLayout;
    Layout42: TLayout;
    Layout43: TLayout;
    Layout44: TLayout;
    Layout45: TLayout;
    Layout46: TLayout;
    Edit10: TEdit;
    SpeedButton2: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    TabItem2: TTabItem;
    ToolBar2: TToolBar;
    SpeedButton10: TSpeedButton;
    Label13: TLabel;
    Image5: TImage;
    Layout31: TLayout;
    Image6: TImage;
    Layout32: TLayout;
    Layout33: TLayout;
    TabItem3: TTabItem;
    ToolBar4: TToolBar;
    SpeedButton11: TSpeedButton;
    Label10: TLabel;
    Layout37: TLayout;
    TabItem4: TTabItem;
    ToolBar5: TToolBar;
    SpeedButton12: TSpeedButton;
    Label14: TLabel;
    Layout38: TLayout;
    VertScrollBox2: TVertScrollBox;
    Image4: TImage;
    Label7: TLabel;
    Layout1: TLayout;
    RoundRect4: TRoundRect;
    Label8: TLabel;
    Layout21: TLayout;
    Layout22: TLayout;
    Layout23: TLayout;
    Layout26: TLayout;
    RoundRect5: TRoundRect;
    Label12: TLabel;
    Layout27: TLayout;
    Layout28: TLayout;
    CheckBox3: TCheckBox;
    Layout29: TLayout;
    Layout30: TLayout;
    CheckBox5: TCheckBox;
    Layout9: TLayout;
    Label11: TLabel;
    VertScrollBox3: TVertScrollBox;
    VertScrollBox5: TVertScrollBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    TabItem5: TTabItem;
    ToolBar7: TToolBar;
    Label15: TLabel;
    VertScrollBox6: TVertScrollBox;
    Layout14: TLayout;
    Edit4: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Layout3D1: TLayout3D;
    Layout15: TLayout;
    Layout47: TLayout;
    Layout48: TLayout;
    Layout49: TLayout;
    Layout51: TLayout;
    Edit8: TEdit;
    Edit11: TEdit;
    DateEdit2: TDateEdit;
    Image7: TImage;
    CheckBox6: TCheckBox;
    Layout50: TLayout;
    Layout52: TLayout;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    Label16: TLabel;
    Label17: TLabel;
    Layout53: TLayout;
    RoundRect6: TRoundRect;
    Label18: TLabel;
    Layout54: TLayout;
    Layout55: TLayout;
    Label19: TLabel;
    Layout56: TLayout;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Layout57: TLayout;
    rrRegistrar: TRoundRect;
    lbRegistrar: TLabel;
    Layout58: TLayout;
    rrTenhoConta: TRoundRect;
    lbTenhoConta: TLabel;
    RESTNovoCadastro: TRESTClient;
    RESTLogin: TRESTClient;
    RESTAtualizaCadastro: TRESTClient;
    RESTExcluiCadastro: TRESTClient;
    RESTJogosPassados: TRESTClient;
    RESTJogosFuturos: TRESTClient;
    RESTJogosAtuais: TRESTClient;
    RESTReqLogin: TRESTRequest;
    RESTResLogin: TRESTResponse;
    procedure FormCreate(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure CarregaDados;
    function Login(user,pass:string):boolean;
    procedure VerificaLogin;
    procedure Label9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure rrRegistrarClick(Sender: TObject);
    procedure rrTenhoContaClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure RoundRect6Click(Sender: TObject);
    procedure RoundRect3Click(Sender: TObject);
    procedure RoundRect2Click(Sender: TObject);
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

const linkServer          = 'http://botstenisdemesa.ddns.net:8080/';

const lsNovoCadastro      = 'http://botstenisdemesa.ddns.net:8080/PutNovoCadastro/';
                          //fulano/senha/email/cpf/filtroprobs/dtnascimento
const lsLogin             = 'http://botstenisdemesa.ddns.net:8080/ConsultaCadastro/';
                          //nome.CPF.email/senha
const lsAtualizaCadastro  = 'http://botstenisdemesa.ddns.net:8080/AtualizaCadastro/';
                          //OldNome/NewNome/OldPass/newPass/OldEmail/NewEmail/OldFiltroProbs/NewFiltroProbs
const lsExcluiCadastro    = 'http://botstenisdemesa.ddns.net:8080/ExcluiCadastro/';
                         //NomeCadastro/senha/email/cpf
const lsJogosPassados     = 'http://botstenisdemesa.ddns.net:8080/GetListaJogosPassados/';
                         //usuario/senha/data
const lsJogosFuturos      = 'http://botstenisdemesa.ddns.net:8080/GetListaJogosFuturos/';
                         //usuario/senha/probs
const lsJogosAtuais       = 'http://botstenisdemesa.ddns.net:8080/GetListaJogosAtuais/';
                         //usuario/senha/probs

implementation

{$R *.fmx}

procedure TForm15.VerificaLogin;
begin
     if logOK then begin
        ltNewUser.Visible := false;
        lbUsuario.Text := usuario;
        lbCPF.Text     := CPF;
        ltLogReg.Visible:= false;
        label8.Text := formatdatetime('dd/MM/yyyy hh:mm',dataPermissao);
        if now > incday(dataPermissao,-3) then begin
            ltAssinar.Visible := true;
        end else begin
            ltAssinar.Visible := False;
        end;

     end else begin

     end;
end;

function OpenURL(const URL: string; const DisplayError: Boolean = False): Boolean;
var
  Intent: JIntent;
begin
// There may be an issue with the geo: prefix and URLEncode.
// will need to research
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
    TJnet_Uri.JavaClass.parse(StringToJString(URL)));
  try
    TAndroidHelper.Activity.startActivity(Intent);
    exit(true);
  except
    on e: Exception do
    begin
      if DisplayError then ShowMessage('Error: ' + e.Message);
      exit(false);
    end;
  end;
end;

procedure TForm15.Label6Click(Sender: TObject);
begin
    if CheckBox1.IsChecked then begin
      OpenURL('',false)
    end;
end;

procedure TForm15.Label9Click(Sender: TObject);
begin
    if CheckBox4.IsChecked = true then begin
      CheckBox4.IsChecked := false;
    end else begin
      CheckBox4.IsChecked := true;
    end;

end;

function TForm15.Login(user,pass:string):Boolean;
begin
  //
  RESTLogin.BaseURL := lsLogin + user + '/' + pass;
  RESTReqLogin.Method := TRESTRequestMethod.rmGET;
  RESTReqLogin.Execute;
  ShowMessage(RESTResLogin.Content);

  if not RESTResLogin.Content.Contains('LOGINERROR') then begin
    Result := true;
  end else begin
    Result := False;
  end;

end;

procedure TForm15.RoundRect2Click(Sender: TObject);
begin
     Login(edit1.Text,edit2.Text);
     VerificaLogin;
end;

procedure TForm15.RoundRect3Click(Sender: TObject);
begin
     MultiView1.Visible := false;
     TabControl3.ActiveTab := TabItem5;
end;

procedure TForm15.RoundRect6Click(Sender: TObject);
begin
    TabControl3.ActiveTab := TabItem5;
end;

procedure TForm15.rrRegistrarClick(Sender: TObject);
begin
    //Registrar
    if CheckBox6.IsChecked then
    ShowMessage('Aqui é realizada a requisição de cadastro!');
end;

procedure TForm15.rrTenhoContaClick(Sender: TObject);
begin
   MultiView1.Visible := true;
end;

procedure TForm15.SpeedButton10Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem8;
end;

procedure TForm15.SpeedButton11Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem8;
end;

procedure TForm15.SpeedButton12Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem8;
end;

procedure TForm15.SpeedButton14Click(Sender: TObject);
begin
     TabControl3.ActiveTab := TabItem4;
end;

procedure TForm15.SpeedButton2Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem1;
end;

procedure TForm15.SpeedButton3Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem8;
end;

procedure TForm15.SpeedButton4Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem7;
end;

procedure TForm15.SpeedButton8Click(Sender: TObject);
begin
    TabControl3.ActiveTab := TabItem3;
end;

procedure TForm15.SpeedButton9Click(Sender: TObject);
begin
   TabControl3.ActiveTab := TabItem2;
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
      logOk := False;
    end;
  end else begin
      logOK := false;
      dataPermissao := incday(now,-1);
  end;
end;

procedure TForm15.CheckBox1Click(Sender: TObject);
begin
      if checkbox1.IsChecked then begin
        checkbox2.IsChecked := false;
      end;
end;

procedure TForm15.CheckBox2Click(Sender: TObject);
begin
       if checkbox2.IsChecked then begin
        checkbox1.IsChecked := false;
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

     VerificaLogin;
end;

end.
