unit RCcalc2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ExtDlgs, Buttons, StdCtrls;

type
  TFormImportAirfoil = class(TForm)
    Panel1: TPanel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    EditFile: TEdit;
    SpeedButton1: TSpeedButton;
    DlgOpen: TOpenPictureDialog;
    Label2: TLabel;
    EditName: TEdit;
    Label3: TLabel;
    Image1: TImage;
    Img: TImage;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure EditFileExit(Sender: TObject);
  private { Private declarations }
    Filename : string;
    procedure LoadFile;
  public  { Public declarations }
  end;

var
  FormImportAirfoil: TFormImportAirfoil;

function ImportAirfoil : boolean;

implementation

{$R *.DFM}

function ImportAirfoil : boolean;
begin
  with TFormImportAirfoil.Create (Application) do
    begin
      Result := ShowModal = mrOk;
      Free;
    end;
end;


procedure TFormImportAirfoil.LoadFile;
begin
  if (AnsiCompareText (Filename,EditFile.Text) <> 0) and
     FileExists (EditFile.Text) then
    begin
      Filename := EditFile.Text;
      Img.Picture.LoadFromFile (Filename);
    end;
end;

procedure TFormImportAirfoil.SpeedButton1Click(Sender: TObject);
begin
  DlgOpen.Filename := EditFile.Text;
  if DlgOpen.Execute then
    begin
      EditFile.Text := DlgOpen.FileName;
      LoadFile;
    end;
end;

procedure TFormImportAirfoil.BtnOkClick(Sender: TObject);
var
  W,
  H,
  X,
  Y,
  PrevY: integer;
  List : TStringList;
  ClBlank : TColor;
  SX,
  SY : string;
begin
  W := Img.Picture.Bitmap.Width;
  H := Img.Picture.Bitmap.Height;
  List := TStringList.Create;
  List.Add (EditName.Text);
  ClBlank := Img.Picture.Bitmap.Canvas.Pixels [0,0];
  PrevY := 0;
  for X := W-1 downto 0 do
    for Y := 0 to H-1 do
      begin
        if Img.Picture.Bitmap.Canvas.Pixels[X,Y] <> ClBlank then
          begin
            if Y <> PrevY then
              begin
                PrevY := Y;
                Str (X/W:1:6, SX);
                Str ((H-Y)/W:1:6, SY);
                List.Add (SX+' '+SY);
              end;
            break;
          end;
      end;
  PrevY := 0;
  for X := 0 to W-1 do
    for Y := H-1 downto 0 do
      begin
        if Img.Picture.Bitmap.Canvas.Pixels[X,Y] <> ClBlank then
          begin
            if Y <> PrevY then
              begin
                PrevY := Y;
                Str (X/W:1:6, SX);
                Str ((H-Y)/W:1:6, SY);
                List.Add (SX+' '+SY);
              end;
            break;
          end;
      end;
  if List.Count > 1 then
    List.Add (List[1]);
  List.SaveToFile (ExtractFilePath (Application.ExeName)+'Airfoil\'+
                   ChangeFileExt (ExtractFilename (EditFile.Text), '.dat'));
  List.Free;
end;

procedure TFormImportAirfoil.EditFileExit(Sender: TObject);
begin
  LoadFile;
end;

end.
