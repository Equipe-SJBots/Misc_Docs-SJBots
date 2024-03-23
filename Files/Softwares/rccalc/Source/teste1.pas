unit teste1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Img: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses RCCalcL;

procedure TForm1.FormCreate(Sender: TObject);
var
  Prop : TPropeller;
  X,Y  : integer;
begin
  Prop := TPropeller.Create ('c:\ale\lift\rccalc\prop\GWS_HD_6030.csv');
  Img.Picture.Bitmap.Width := Img.Width;
  Img.Picture.Bitmap.Height:= Img.Height;
  Img.Picture.Bitmap.Canvas.Pen.Color := clBlack;
  Img.Picture.Bitmap.Canvas.MoveTo (0,0);
  for X := 0 to 400 do
    begin
      Y := Round (Prop.CalcThrust (X*50));
      Img.Picture.Bitmap.Canvas.LineTo (X,Y);
    end;
  Img.Picture.Bitmap.Canvas.Pen.Color := clRed;
  Img.Picture.Bitmap.Canvas.MoveTo (0,0);
  for X := 0 to 400 do
    begin
      Y := Round (Prop.CalcPitch (X*50));
      Img.Picture.Bitmap.Canvas.LineTo (X,Y);
    end;
  Prop.Free;
end;

end.
