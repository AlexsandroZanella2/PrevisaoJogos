unit Unit15;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Gestures, FMX.Colors,
  FMX.DateTimeCtrls, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  System.ImageList, FMX.ImgList, System.IOUtils, iniFiles, DateUtils, IdURI,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  {$IF DEFINED (ANDROID)}
   FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText, Androidapi.Jni.Net,
   Androidapi.Jni.JavaTypes, Androidapi.Helpers,
  {$ENDIF}
   System.Net.HttpClient, System.Net.HttpClientComponent;

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
    sbConfEditDados: TSpeedButton;
    sbCancelaEdicDados: TSpeedButton;
    Label1: TLabel;
    VertScrollBox1: TVertScrollBox;
    Layout34: TLayout;
    Layout35: TLayout;
    Label9: TLabel;
    Layout36: TLayout;
    CheckBox4: TCheckBox;
    Layout39: TLayout;
    DUserNome: TEdit;
    DUserEmail: TEdit;
    DUserFiltro: TEdit;
    Layout3D2: TLayout3D;
    Layout40: TLayout;
    Layout41: TLayout;
    Layout42: TLayout;
    Layout43: TLayout;
    Layout45: TLayout;
    Layout46: TLayout;
    DUserSenha: TEdit;
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
    CheckBox6: TCheckBox;
    Layout50: TLayout;
    Layout52: TLayout;
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
    SpeedButton15: TSpeedButton;
    Layout59: TLayout;
    RoundRect7: TRoundRect;
    Label23: TLabel;
    RESTReqNovoCadastro: TRESTRequest;
    RESTResNovoCadastro: TRESTResponse;
    Layout60: TLayout;
    Image7: TImage;
    Label24: TLabel;
    Label25: TLabel;
    Layout44: TLayout;
    DUserCPF: TEdit;
    Layout61: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure CarregaDados;
    procedure Login(user,pass:string);
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
    procedure SpeedButton15Click(Sender: TObject);
    procedure UnLogin;
    procedure Registrar(rNome, rSenha, rEmail, rCPF, rFiltro,rNasciemnto:string);   //fulano/senha/email/cpf/filtroprobs/dtnascimento
    procedure DeletaSystemIni;
    function GetSystemPath:string;
    procedure Label23Click(Sender: TObject);
    procedure sbConfEditDadosDblClick(Sender: TObject);

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
  dtNascimento:string;
  filtroProbs: string;
  email: string;
  cpf:string;
  Config:tiniFile;
  dataPermissao:string;

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

function GetURL(const AURL: string): string;
var
  HttpClient  : THttpClient;
  HttpResponse: IHttpResponse;
begin
  HttpClient := THttpClient.Create;
  try
    HttpResponse := HttpClient.Get(AURL);
    Result := HttpResponse.ContentAsString();
  finally
    HttpClient.Free;
  end;
end;

function TForm15.GetSystemPath:string;
begin
  try
  Result:= System.IOUtils.TPath.Combine(System.IOUtils.tpath.getdocumentspath,'system.ini');
  except
    ShowMessage('Erro em TForm.GetSystemPath');
  end;
end;


procedure TForm15.DeletaSystemIni;
begin
  try
  if FileExists(System.IOUtils.TPath.Combine(System.IOUtils.tpath.getdocumentspath,'system.ini')) then begin
      DeleteFile(System.IOUtils.TPath.Combine(System.IOUtils.tpath.getdocumentspath,'system.ini'));
  end;
  except
     ShowMessage('Erro em TForm.DeletaSystemIni');
  end;
end;

procedure TForm15.UnLogin;
begin
        logOK := false;
        VerificaLogin;
end;

procedure TForm15.VerificaLogin;
var
test    :string;
daytest :string;
begin
  try
     if logOK then begin

        ltNewUser.Visible           := false          ;
        lbUsuario.Text              := usuario        ;
        lbCPF.Text                  := CPF            ;
        ltLogReg.Visible            := false          ;
        ltDadosJogos.Visible        := true           ;
        label8.Text                 := dataPermissao  ;
        SpeedButton2.Visible        := true           ;
        SpeedButton7.Visible        := true           ;
        SpeedButton15.Visible       := true           ;

        test := copy(dataPermissao,1,pos('.',dataPermissao)-1);
        daytest := formatdatetime('dd',now);
        if strtoint(daytest) > (strtoint(test)-3) then begin
            ltAssinar.Visible := true;
        end else begin
            ltAssinar.Visible := False;
        end;

        //Limpa tela de registro
        Edit4.Text := '';
        Edit6.Text := '';
        edit8.Text := '';
        edit7.Text := '';
        edit11.Text:= '';

        //preenche tela dados do Usu�rio
        DUserNome.Text  := usuario      ;
        DUserSenha.Text := senha        ;
        DUserEmail.Text := email        ;
        DUserFiltro.Text:= filtroProbs  ;
        DUserCPF.Text   := cpf          ;
        sbConfEditDados.Enabled     := true  ;
        sbCancelaEdicDados.Enabled  := true  ;
        sbConfEditDados.StyleLookup := 'composetoolbutton';
        sbConfEditDados.Visible := true;
        sbCancelaEdicDados.Visible := false;

     end else begin

        //DeletaSystemIni;

        ltNewUser.Visible       := true             ;
        lbUsuario.Text          := 'Usu�rio'        ;
        lbCPF.Text              := '000.000.000-00' ;
        ltLogReg.Visible        := true             ;
        ltAssinar.Visible       := true             ;
        ltDadosJogos.Visible    := false            ;
        SpeedButton2.Visible    := false            ;
        SpeedButton7.Visible    := false            ;
        SpeedButton15.Visible   := false            ;

        Label8.Text := '01/01/1900 00:00';

        edit1.Text  := '';
        Edit2.Text  := '';

        //apaga dados tela dados do usu�rio
        DUserNome.Text  := ''                 ;
        DUserSenha.Text := ''                 ;
        DUserEmail.Text := ''                 ;
        DUserFiltro.Text            := ''     ;
        DUserCPF.Text               := ''     ;
        sbConfEditDados.Enabled     := false  ;
        sbCancelaEdicDados.Enabled  := False  ;
        sbConfEditDados.StyleLookup := 'composetoolbutton';
        sbConfEditDados.Visible := true;
        sbCancelaEdicDados.Visible := false;
     end;
  except
      ShowMessage('Erro em TForm.VerificaLogin');
  end;
end;

{$IF DEFINED (ANDROID)}
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
{$ENDIF}

procedure TForm15.Label23Click(Sender: TObject);
begin
    MultiView1.Visible := true;
end;

procedure TForm15.Label6Click(Sender: TObject);
begin
{$IF DEFINED (ANDROID)}
    if CheckBox1.IsChecked then begin
      OpenURL('',false)
    end;
{$ENDIF}
{$IF DEFINED (MSWINDOWS)}

{$ENDIF}
end;

procedure TForm15.Label9Click(Sender: TObject);
begin
    if CheckBox4.IsChecked = true then begin
      CheckBox4.IsChecked := false;
    end else begin
      CheckBox4.IsChecked := true;
    end;

end;

procedure TForm15.Login(user,pass:string);
var
dadosLogin:tstringlist;
system : tstringlist;
begin
   try
    dadosLogin := TStringList.Create;
    system := TStringList.Create;
   except
     ShowMessage('Erro Ao criar stringlists em TForm.Login');
   end;
  //
  RESTLogin.BaseURL := lsLogin + user + '/' + pass;
  RESTReqLogin.Method := TRESTRequestMethod.rmGET;
  try
  RESTReqLogin.Execute;
  except
    ShowMessage('Sem conex�o � internet!');
    ABORT;
  end;
  ShowMessage(RESTResLogin.Content);  //TESTE DE RESPOSTA

  if RESTResLogin.Content.Contains('LOGINERROR') then begin
    abort
  end else begin
      DeletaSystemIni;
    try
      dadosLogin.Clear ;
      system.Clear;
      dadosLogin.Text := RESTResLogin.Content;
      system.Add('[CONFIG]');
      dadosLogin.Text :=          copy(dadosLogin.Text, Pos('USER',dadosLogin.Text)+7)  ;
      system.Add('usuario='+      copy(dadosLogin.Text,1,pos('","',dadosLogin.Text)-1)  );
      dadosLogin.Text :=          copy(dadosLogin.Text, Pos('EMAIL',dadosLogin.Text)+8  );
      system.Add('senha='+        pass                                                  );
      system.Add('email='+        copy(dadosLogin.Text,1,pos('","',dadosLogin.Text)-1)  );
      dadosLogin.Text :=          copy(dadosLogin.Text, Pos('CPF',dadosLogin.Text)+6    );
      system.Add('cpf='+          copy(dadosLogin.Text,1,pos('","',dadosLogin.Text)-1)  );
      dadosLogin.Text :=          copy(dadosLogin.Text, Pos('DATAPERMISSAO',dadosLogin.Text)+16);
      system.Add('permissao='+    copy(dadosLogin.Text,1,pos('","',dadosLogin.Text)-1)  );
      dadosLogin.Text :=          copy(dadosLogin.Text, Pos('FILTRO',dadosLogin.Text)+9 );
      system.Add('filtroprobs='+  copy(dadosLogin.Text,1,pos('","',dadosLogin.Text)-1)  );
      dadosLogin.Text :=          copy(dadosLogin.Text, Pos('NASC',dadosLogin.Text)+7   );
      system.Add('nascimento='+   copy(dadosLogin.Text,1,pos('","',dadosLogin.Text)-1)  );
      if dadosLogin.Text.Contains('lOGINOK') then BEGIN
        logOK := true;
      END;
      system.SaveToFile(GetSystemPath);
    except
        ShowMessage('Erro na resposta recebida!');
    end;
  end;
end;

procedure TForm15.Registrar(rNome, rSenha, rEmail, rCPF, rFiltro,rNasciemnto:string);
const b = '/';

begin
  RESTNovoCadastro.BaseURL := lsNovoCadastro + rNome + b + rSenha + b +
                              rEmail + b + rCPF +b + rFiltro + b + rNasciemnto;
  RESTReqNovoCadastro.Method := TRESTRequestMethod.rmGET;
  try
    RESTReqNovoCadastro.Execute;
  except
    ShowMessage('Sem conex�o � internet!');
    abort;
  end;

  if RESTResNovoCadastro.Content.Contains('sucesso') then begin
    Login(rCPF,rSenha);
    CarregaDados;
    VerificaLogin;
  end else begin
    ShowMessage('Usu�rio j� cadastrado');
    abort;
  end;
end;

procedure TForm15.RoundRect2Click(Sender: TObject);
begin
     Login(edit1.Text,edit2.Text);
     CarregaDados;
     VerificaLogin;
end;

procedure TForm15.RoundRect3Click(Sender: TObject);
begin
     TabControl3.ActiveTab := TabItem5;
end;

procedure TForm15.RoundRect6Click(Sender: TObject);
begin
    TabControl3.ActiveTab := TabItem5;
end;

procedure TForm15.rrRegistrarClick(Sender: TObject);
var
tc:string;
begin
    //Registrar
  if CheckBox6.IsChecked then begin
    if (edit11.Text.Length = 11)  then begin
      edit11.Text := copy(edit11.Text, 1,3)+'.'+copy(edit11.Text, 4,3)+'.'+copy(edit11.Text, 7,3)+'-'+copy(edit11.Text, 10,2);
    end else if not(edit11.Text.Length = 14) then begin
      edit11.text := '';
      showmessage('CPF Inv�lido!');
      abort;
    end;

    if edit4.Text.Length < 10 then begin
      edit4.text := '';
      showmessage('Nome Inv�lido! M�nimo 10 caracteres');
      abort;
    end;

    if edit8.Text.Length < 8 then begin
      edit8.text := '';
      showmessage('Senha Muito Curta!');
      abort;
    end;

    if not(((edit6.Text.Contains('@gmail.com')) and (Length(Edit6.Text) >= 14)) or
          (( edit6.Text.Contains('@hotmail.com')) and (Length(Edit6.Text) >= 16))) then begin
      edit6.text := '';
      showmessage('Use um Gmail ou Hotmail V�lido!');
      abort;
    end;

    tc:= edit7.Text;
    if not( tc.Contains('1') or
            tc.Contains('2') or
            tc.Contains('3') or
            tc.Contains('4') or
            tc.Contains('5') or
            tc.Contains('6') or
            tc.Contains('7') or
            tc.Contains('8') or
            tc.Contains('9') or
            tc.Contains('0')) then begin
       edit7.text := '';
      showmessage('Insira o filtro de jogos corretamente! ele definir� quais jogos ser�o exibidos a voc�, recomendamos uma certeza de no m�nimo 60% para algum jogador.');
      abort;
    end;

    if DateEdit2.Date = now then begin
      showmessage('Selecione a data de seu nascimento.');
      abort;
    end;

    Registrar(edit4.Text, Edit8.Text, edit6.Text, edit11.Text, edit7.Text, formatdatetime('dd.MM.yyyy',DateEdit2.Date));
    TabControl3.ActiveTab := TabItem7;
  end else begin
    ShowMessage('� necess�rio aceitar os termos!');
  end;
end;

procedure TForm15.rrTenhoContaClick(Sender: TObject);
begin
    TabControl3.ActiveTab := TabItem7;
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

procedure TForm15.SpeedButton15Click(Sender: TObject);
begin
   UnLogin;
   TabControl3.ActiveTab := TabItem7;
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
configIni :TIniFile;
configIni2 :TSTRINGLIST;
i : integer;
begin

  if TFile.Exists(GetSystemPath) then begin
    try
    {$IF DEFINED (MSWINDOWS)}
    configIni := TIniFile.Create(GetSystemPath);
    usuario := configIni.readString('CONFIG','usuario','');
    senha   := configIni.readString('CONFIG','senha','');
    cpf := configIni.readString('CONFIG','cpf','');
    email := configIni.ReadString('CONFIG','email','');
    dataPermissao        := configIni.ReadString('CONFIG','permissao','');
    dtNascimento  := configIni.ReadString('CONFIG','nascimento','');
    filtroProbs   := configIni.ReadString('CONFIG','filtroprobs','');
    configIni.Destroy;
    {$ENDIF}
    {$IF DEFINED (ANDROID)}
    configIni2 := TStringList.create;
    configIni2.LoadFromFile(GetSystemPath);
    for I := 0 to configIni2.Count -1 do begin
        if configIni2.Strings[i].Contains('usuario=') then begin
           usuario := copy(configIni2.Strings[i],9 );
        end;
        if configIni2.Strings[i].Contains('senha=') then begin
           senha := copy(configIni2.Strings[i],7 );
        end;
        if configIni2.Strings[i].Contains('cpf=') then begin
           cpf := copy(configIni2.Strings[i],5,14 );
        end;
        if configIni2.Strings[i].Contains('email=') then begin
           email := copy(configIni2.Strings[i],7 );
        end;
        if configIni2.Strings[i].Contains('permissao=') then begin
           datapermissao := copy(configIni2.Strings[i],11 );
        end;
        if configIni2.Strings[i].Contains('nascimento=') then begin
           dtNascimento := copy(configIni2.Strings[i],12,10 );
        end;
        if configIni2.Strings[i].Contains('filtroProbs=') then begin
           filtroProbs := copy(configIni2.Strings[i],13 );
        end;
    end;
    configIni2.Destroy;
    {$ENDIF}
    Login(cpf,senha);

    except
      logOk := False;
      dataPermissao :=  formatdatetime('dd.MM.yyyy hh:mm',incday(now,-1));
    end;
  end else begin
      logOK := false;
      dataPermissao :=  formatdatetime('dd.MM.yyyy hh:mm',incday(now,-1));
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
    try
     TabControl3.ActiveTab := TabItem7;
     DateEdit1.Date := strtodate(formatdatetime('dd/MM/yyyy',now));
     if TFile.Exists(GetSystemPath) then begin
        CarregaDados;
     end;

     VerificaLogin;
    except
      ShowMessage('Erro Fatal na inicializa��o!');
    end;
end;

procedure TForm15.sbConfEditDadosDblClick(Sender: TObject);
begin
     if logOK then begin
     sbConfEditDados.StyleLookup := 'donetoolbutton';
     sbCancelaEdicDados.Visible  := true;
     sbCancelaEdicDados.Enabled  := true;

     DUserNome.Enabled    := true;
     DUserEmail.Enabled   := true;
     DUserFiltro.Enabled  := true;
     DUserSenha.Enabled   := true;

     Layout35.Enabled     := true;
     end else begin
      sbConfEditDados.StyleLookup := 'composetoolbutton';
     sbCancelaEdicDados.Visible  := false;
     sbCancelaEdicDados.Enabled  := false;

     DUserNome.Enabled    := false;
     DUserEmail.Enabled   := false;
     DUserFiltro.Enabled  := false;
     DUserSenha.Enabled   := false;

     Layout35.Enabled     := false;
     end;
end;

end.