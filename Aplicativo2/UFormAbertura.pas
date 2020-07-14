unit UFormAbertura;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts;

type
  TFormAbertura = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Image1: TImage;
    Layout2: TLayout;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbertura: TFormAbertura;

implementation

{$R *.fmx}

end.
