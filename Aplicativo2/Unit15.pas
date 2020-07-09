unit Unit15;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.Gestures, FMX.Colors,
  FMX.DateTimeCtrls, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D,
  System.ImageList, FMX.ImgList;

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
    ImageList1: TImageList;
    SpeedButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;
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

procedure TForm15.FormCreate(Sender: TObject);
begin
     DateEdit1.Date := strtodate(formatdatetime('dd/MM/yyyy',now));
end;

end.
