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
    Image1: TImage;
    Layout2: TLayout;
    Image2: TImage;
    lbUsuario: TLabel;
    lbCPF: TLabel;
    Layout3: TLayout;
    Image3: TImage;
    Layout4: TLayout;
    Layout6: TLayout;
    lbLoginUsr: TLabel;
    Layout8: TLayout;
    Label1: TLabel;
    Layout5: TLayout;
    Layout7: TLayout;
    Edit1: TEdit;
    Edit2: TEdit;
    Layout9: TLayout;
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

end.
