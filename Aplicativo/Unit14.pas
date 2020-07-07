unit Unit14;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.StdCtrls, FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Edit;

type
  TForm14 = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    stMenu: TSpeedButton;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Image2: TImage;
    lbUsuario: TLabel;
    lbCPF: TLabel;
    Layout3: TLayout;
    ltAssinar: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    RoundRect1: TRoundRect;
    Label2: TLabel;
    Layout12: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    CheckBox1: TCheckBox;
    Layout15: TLayout;
    CheckBox2: TCheckBox;
    Rectangle2: TRectangle;
    ltLogReg: TLayout;
    Layout6: TLayout;
    lbLoginUsr: TLabel;
    Layout8: TLayout;
    Label1: TLabel;
    Layout5: TLayout;
    Edit1: TEdit;
    Layout7: TLayout;
    Edit2: TEdit;
    MultiView2: TMultiView;
    Layout16: TLayout;
    Layout17: TLayout;
    Layout18: TLayout;
    RoundRect2: TRoundRect;
    Label3: TLabel;
    Layout19: TLayout;
    RoundRect3: TRoundRect;
    Label4: TLabel;
    Layout20: TLayout;
    Layout4: TLayout;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;
  logok: boolean;
  usuario: string;
  senha: string;
  dataPermissao : string;
  dtNascimento:string;
  filtroProbs: string;
  email: string;
  cpf:string;



implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}
{$R *.Macintosh.fmx MACOS}
{$R *.iPhone55in.fmx IOS}

end.
