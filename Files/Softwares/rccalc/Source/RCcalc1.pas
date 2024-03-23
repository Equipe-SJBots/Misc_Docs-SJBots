unit RCcalc1;

interface

uses
  Math, ShellAPI, FileCtrl, IniFiles, RCCalcL, RcCalcC,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, TeeFunci,
  Buttons, Menus, Spin, ComCtrls;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Perfil1: TMenuItem;
    Sair1: TMenuItem;
    Importar1: TMenuItem;
    Language1: TMenuItem;
    Portuguese1: TMenuItem;
    English1: TMenuItem;
    GerarNACA1: TMenuItem;
    Ajuda1: TMenuItem;
    Sobre1: TMenuItem;
    Pages: TPageControl;
    TabFoil: TTabSheet;
    Image1: TImage;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    TeeFunction1: TMultiplyTeeFunction;
    TabFlight: TTabSheet;
    TabMotor: TTabSheet;
    Label1: TLabel;
    EditSpan: TSpinEdit;
    Label5: TLabel;
    Label2: TLabel;
    EditChord: TSpinEdit;
    Label6: TLabel;
    Label9: TLabel;
    EditWeight: TSpinEdit;
    Label8: TLabel;
    Label4: TLabel;
    EditR: TEdit;
    EditArea: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EditLoad: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label31: TLabel;
    Label38: TLabel;
    EditVuser: TSpinEdit;
    EditVsafe: TEdit;
    EditVbest: TEdit;
    EditVstall: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label32: TLabel;
    Label39: TLabel;
    EditVuserK: TEdit;
    EditVsafeK: TEdit;
    EditVbestK: TEdit;
    EditVstallK: TEdit;
    Label21: TLabel;
    Label20: TLabel;
    Label33: TLabel;
    Label40: TLabel;
    EditAuser: TEdit;
    EditAsafe: TEdit;
    EditAbest: TEdit;
    EditAstall: TEdit;
    EditDstall: TEdit;
    EditDbest: TEdit;
    EditDsafe: TEdit;
    EditDuser: TEdit;
    Label41: TLabel;
    Label34: TLabel;
    Label7: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label19: TLabel;
    Panel1: TPanel;
    Label45: TLabel;
    EditQtd: TSpinEdit;
    Label46: TLabel;
    Label25: TLabel;
    EditProp: TComboBox;
    Label24: TLabel;
    EditRot: TSpinEdit;
    Label30: TLabel;
    Label27: TLabel;
    Label44: TLabel;
    EditPower: TEdit;
    EditPitch: TEdit;
    EditThrust: TSpinEdit;
    Label26: TLabel;
    Label28: TLabel;
    Label43: TLabel;
    EditPitchK: TEdit;
    EditPct: TEdit;
    Label37: TLabel;
    Label29: TLabel;
    Label35: TLabel;
    EditPropD: TEdit;
    Label36: TLabel;
    EditPropP: TEdit;
    Label42: TLabel;
    Panel2: TPanel;
    Label47: TLabel;
    ChkBrushed: TRadioButton;
    ChkBrushless: TRadioButton;
    ListMotors: TListView;
    EditType: TComboBox;
    Label48: TLabel;
    Label23: TLabel;
    EditFoil: TComboBox;
    BtnPolar: TSpeedButton;
    Label3: TLabel;
    EditPolar: TComboBox;
    PnlType: TPanel;
    Label50: TLabel;
    PnlThrust: TPanel;
    PnlPitch: TPanel;
    Label49: TLabel;
    Panel3: TPanel;
    EditName: TEdit;
    Label51: TLabel;
    N1: TMenuItem;
    Abrir1: TMenuItem;
    Salvar1: TMenuItem;
    DlgOpen: TOpenDialog;
    DlgSave: TSaveDialog;
    procedure EditChange(Sender: TObject);
    procedure EditPolarChange(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditFoilChange(Sender: TObject);
    procedure EditPropChange(Sender: TObject);
    procedure EditRotChange(Sender: TObject);
    procedure EditRotKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPolarClick(Sender: TObject);
    procedure EditVuserChange(Sender: TObject);
    procedure Importar1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Portuguese1Click(Sender: TObject);
    procedure English1Click(Sender: TObject);
    procedure GerarNACA1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure EditThrustChange(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure ChkBrushedClick(Sender: TObject);
    procedure ChkBrushlessClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditQtdChange(Sender: TObject);
    procedure ListMotorsDblClick(Sender: TObject);
    procedure EditQtdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditTypeChange(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Salvar1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private { Private declarations }
    Propeller : TPropeller;
    Airfoil   : TAirfoil;
    Polar     : TPolar;
    Brushed,
    Brushless : TMotors;
    Lang: integer;
    Filename : string;
    procedure GetMotors;
    function GetText (S : string) : string;
    procedure Recalc;
    procedure RecalcUser;
    procedure LoadPolar (S : string);
    procedure LoadFoil  (S : string);
    procedure LoadProp  (S : string);
    procedure PlotPolar;
    procedure CalcProp (T : boolean);
    procedure CalcPolar (Re : array of integer);
    procedure LoadFoils;
    procedure LoadProps;
    procedure CheckLanguage;
    procedure SetLanguage;
    function  CheckNACA (S : string) : boolean;
    procedure CalcFoil (Naca : string);
    procedure OpenModel (Filename : string);
    procedure SaveModel (Filename : string);
  public  { Public declarations }
  end;

var
  FormMain: TFormMain;


implementation

{$R *.DFM}
uses
  RcCalc0,
  RCcalc2;

procedure TFormMain.EditChange(Sender: TObject);
begin
  Recalc;
end;

procedure TFormMain.RecalcUser;
var
  C,
  W,
  S,
  Duser : double;
begin
  C := EditChord.Value;
  W := EditSpan.Value;
  S := C * W / 100;
  try
    Polar.UserSpeed.Speed := EditVuser.Value;
    Polar.UserSpeed.CL := Polar.CalcCL (EditWeight.Value, S, Polar.UserSpeed.Speed);
    Polar.UserSpeed.Alpha := Polar.GetAlpha (Polar.UserSpeed.CL);
    Polar.UserSpeed.CD    := Polar.GetCD (Polar.UserSpeed.Alpha);
  except
    Polar.SafeSpeed.Speed := 0;
  end;
  Duser  := Polar.UserSpeed.CD * 0.61 * sqr(Polar.UserSpeed.Speed) * S/100;

  EditVuserK.Text := FormatFloat ('#0.0', EditVuser.Value*3.6);
  EditAuser .Text := FormatFloat ('#0.0°', Polar.UserSpeed.Alpha);
  EditDuser .Text := FormatFloat ('#0.0', 1000 * Duser / 9.8);
end;

procedure TFormMain.Recalc;
var
  C,
  W,
  S,
  L,
  Dstall,
  Dbest,
  Dsafe : double;
  T     : TModelType;
begin
  C := EditChord.Value;
  W := EditSpan.Value;
  S := C * W / 100;
  if S > 0 then
    L := EditWeight.Value / S
  else
    L := 0;
  EditArea.Text := FormatFloat  ('#0.0', S);
  EditLoad.Text := FormatFloat  ('#0.0', L);
  try
    Polar.StallSpeed.Speed := Polar.CalcStallSpeed (EditWeight.Value, S);
    Polar.BestSpeed.Speed  := Polar.CalcBestSpeed  (EditWeight.Value, S);
    Polar.SafeSpeed.Speed  := Polar.CalcSafeSpeed  (EditWeight.Value, S);
    Polar.SafeSpeed.CL    := Polar.CalcCL (EditWeight.Value, S, Polar.SafeSpeed.Speed);
    Polar.SafeSpeed.Alpha := Polar.GetAlpha (Polar.SafeSpeed.CL);
    Polar.SafeSpeed.CD    := Polar.GetCD    (Polar.SafeSpeed.Alpha);
  except
    Polar.StallSpeed.Speed := 0;
    Polar.BestSpeed.Speed := 0;
    Polar.SafeSpeed.Speed := 0;
  end;
  Dstall := Polar.StallSpeed.CD * 0.61 * sqr(Polar.StallSpeed.Speed) * S/100;
  Dbest  := Polar.BestSpeed.CD * 0.61 * sqr(Polar.BestSpeed.Speed) * S/100;
  Dsafe  := Polar.SafeSpeed.CD * 0.61 * sqr(Polar.SafeSpeed.Speed) * S/100;

  EditVstall .Text := FormatFloat ('#0.0' , Polar.StallSpeed.Speed);
  EditVstallK.Text := FormatFloat ('#0.0' , Polar.StallSpeed.Speed*3.6);
  EditAstall .Text := FormatFloat ('#0.0°', Polar.StallSpeed.Alpha);
  EditVbest  .Text := FormatFloat ('#0.0' , Polar.BestSpeed.Speed);
  EditVbestK .Text := FormatFloat ('#0.0' , Polar.BestSpeed.Speed*3.6);
  EditAbest  .Text := FormatFloat ('#0.0°', Polar.bestSpeed.Alpha);
  EditVsafe  .Text := FormatFloat ('#0.0' , Polar.SafeSpeed.Speed);
  EditVsafeK .Text := FormatFloat ('#0.0' , Polar.SafeSpeed.Speed*3.6);
  EditAsafe  .Text := FormatFloat ('#0.0°', Polar.SafeSpeed.Alpha);

  EditDstall.Text := FormatFloat ('#0.0', 1000 * Dstall / 9.8);
  EditDbest .Text := FormatFloat ('#0.0', 1000 * Dbest / 9.8);
  EditDsafe .Text := FormatFloat ('#0.0', 1000 * Dsafe / 9.8);

  EditR.Text := IntToStr (Round (Polar.CalcReynolds (Polar.BestSpeed.Speed, EditChord.Value)));

  RecalcUser;
  CalcProp (false);

  for T := Low(ModelParm) to High(ModelParm) do
    if EditType.Text = ModelParm[T].Desc[Lang] then
      break;
  PnlType.Caption := '';
  case T of
    mtSlow    : if Polar.BestSpeed.Speed > 5 then
                  PnlType.Caption := 'Muito rápido para SlowFly';
    mtTrainer : if Polar.BestSpeed.Speed > 8 then
                  PnlType.Caption := 'Muito rápido para treinador';
  end;
end;

procedure TFormMain.LoadFoils;
var
  SR : TSearchRec;
begin
  MsgSplash('Loading foil parameters',0,0);
  EditFoil.Items.Clear;
  if FindFirst (PathAirfoil+'*.dat', faArchive, SR) = 0 then
    repeat
      EditFoil.Items.Add (ChangeFileExt (SR.Name,''));
    until FindNext (SR) <> 0;
  FindClose (SR);
end;

procedure TFormMain.LoadProps;
var
  SR : TSearchRec;
begin
  MsgSplash('Loading propeller parameters',0,0);
  if FindFirst (PathProp+'*.csv', faArchive, SR) = 0 then
    repeat
      EditProp.Items.Add (ChangeFileExt (SR.Name, ''));
    until FindNext (SR) <> 0;
  FindClose (SR);
end;


procedure TFormMain.LoadPolar (S : string);
begin
  if Assigned(Polar) then
    Polar.Free;
  Polar := TPolar.Create (PathPolar+S+'.dat');

  PlotPolar;
end;

procedure TFormMain.LoadFoil (S : string);
begin
  if Assigned (Airfoil) then
    begin
      Airfoil.Free;
      Airfoil := NIL;
    end;
  Airfoil := TAirfoil.Create (PathAirfoil+S+'.dat');
  Airfoil.Draw (Image1.Picture.Bitmap, Image1.Width, Image1.Height);
end;


procedure TFormMain.LoadProp (S : string);
begin
  if Assigned (Propeller) then
    Propeller.Free;
  Propeller := TPropeller.Create (PathProp+S+'.csv');
  CalcProp (false);
end;

procedure TFormMain.CalcProp;
var
  Pct : integer;
  Thrust,
  Pitch,
  Power: double;
begin
  EditRot  .OnChange := NIL;
  EditThrust.OnChange := NIL;

  Thrust := EditQtd.Value * Propeller.CalcThrust (EditRot.Value);
  Pitch  := Propeller.CalcPitch (EditRot.Value);
  Power  := EditQtd.Value * Propeller.CalcPower (EditRot.Value);

  if not T then
    EditThrust.Text := IntToStr (Round (Thrust));

  if EditWeight.Value > 0 then
    begin
      Pct := Round (100 * Thrust / EditWeight.Value);
      EditPct.Text := IntToStr (Pct);
      case Pct of
        0..32 : begin
                  EditPct.Color := clRed;
                  PnlThrust.Caption := GetText ('Thrust1');
                end;
        33..50: begin
                  EditPct.Color := clRed or clYellow;
                  PnlThrust.Caption := GetText ('Thrust2');
                end;
        51..60: begin
                  EditPct.Color := clYellow;
                  PnlThrust.Caption := GetText ('Thrust3');
                end;
        61..80: begin
                  EditPct.Color := clGreen;
                  PnlThrust.Caption := GetText ('Thrust4');
                end;
        81..100: begin
                  EditPct.Color := clBlue;
                  PnlThrust.Caption := GetText ('Thrust5');
                end;
       101..129: begin
                   EditPct.Color := clBlue;
                   PnlThrust.Caption := GetText ('Thrust6');
                 end;
       131..160: begin
                   EditPct.Color := clBlue;
                   PnlThrust.Caption := GetText ('Thrust7');
                 end;
       161..200: begin
                   EditPct.Color := clBlue;
                   PnlThrust.Caption := GetText ('Thrust8');
                 end;
       201..
       MAXlong: begin
                  EditPct.Color := clBlue;
                  PnlThrust.Caption := GetText ('Thrust9');
                end;
      else
        EditPct.Color := clBtnFace;
        PnlThrust.Caption := '';
        EditPct.Text := '';
      end
    end
  else
    begin
      EditPct.Color := clBtnFace;
      PnlThrust.Caption := '';
      EditPct.Text := '';
    end;

  EditPitch.Text := FormatFloat ('#0.0', Pitch);
  EditPitchK.Text := FormatFloat ('#0.0', Pitch*3.6);
  if Pitch >= Polar.SafeSpeed.Speed then
    begin
      EditPitch.Color := clBtnFace;
      EditPitchK.Color := clBtnFace;

      PnlPitch.Caption := '';
    end
  else
   begin
      EditPitch.Color := clRed;
      EditPitchK.Color := clRed;

      PnlPitch.Caption := GetText ('LowPitch');
    end;
  EditPower.Text := FormatFloat ('#0.0', Power);

  EditRot   .OnChange := EditRotChange;
  EditThrust.OnChange := EditThrustChange;
end;

procedure TFormMain.PlotPolar;
var
  Ct : integer;
  MinA,
  MaxA,
  MinCL,
  MaxCL,
  MinCD,
  MaxCD : double;
begin
  MinA  := 1E60;
  MaxA  := -1E60;
  MinCL := 1E60;
  MaxCL := -1E60;
  MinCD := 1E60;
  MaxCD := -1E60;
  for Ct := 1 to Polar.NPolars do
    begin
      if Polar.Polars[Ct].A < MinA then
        MinA := Polar.Polars[Ct].A;
      if Polar.Polars[Ct].A > MaxA then
        MaxA := Polar.Polars[Ct].A;
      if Polar.Polars[Ct].CL < MinCL then
        MinCL := Polar.Polars[Ct].CL;
      if Polar.Polars[Ct].CL > MaxCL then
        MaxCL := Polar.Polars[Ct].CL;
      if Polar.Polars[Ct].CD < MinCD then
        MinCD := Polar.Polars[Ct].CD;
      if Polar.Polars[Ct].CD > MaxCD then
        MaxCD := Polar.Polars[Ct].CD;
    end;

  Chart1.SeriesList.Series[0].Clear;
  Chart1.SeriesList.Series[1].Clear;
  Chart1.SeriesList.Series[2].Clear;
  for Ct := 1 to Polar.NPolars do
    begin
      Chart1.SeriesList.Series[0].AddXY (Polar.Polars[Ct].A, Polar.Polars[Ct].CL, '', clRed);
      Chart1.SeriesList.Series[1].AddXY (Polar.Polars[Ct].A, Polar.Polars[Ct].CD, '', clGreen);
      if Polar.Polars[Ct].CD > 0 then
        Chart1.SeriesList.Series[2].AddXY (Polar.Polars[Ct].A, MaxCD*Polar.Polars[Ct].CL/Polar.Polars[Ct].CD, '', clYellow);
    end;
end;

procedure TFormMain.EditPolarChange(Sender: TObject);
begin
  if EditPolar.ItemIndex >= 0 then
    begin
      LoadPolar (EditPolar.Text);
      Chart1.Title.Text.Text := EditPolar.Text;
      Recalc;
    end;
end;

procedure TFormMain.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Recalc;
end;

procedure TFormMain.EditFoilChange(Sender: TObject);
var
  SR : TSearchRec;
  S  : string;
begin
  if EditFoil.ItemIndex >= 0 then
    begin
      LoadFoil (EditFoil.Text);

      EditPolar.Items.Clear;
      S := PathPolar+EditFoil.Text+'*.dat';
      if FindFirst (S, faArchive, SR) = 0 then
        repeat
          EditPolar.Items.Add (ChangeFileExt (SR.Name,''));
        until FindNext (SR) <> 0;
      FindClose (SR);
      BtnPolar.Enabled := EditFoil.Text <> '';
      EditPolar.Enabled := EditPolar.Items.Count > 0;
      if EditPolar.Enabled then
        EditPolar.Color := clWindow
      else
        EditPolar.Color := clBtnFace;
    end;
end;

procedure TFormMain.CalcPolar (Re : array of integer);
var
  Ct : integer;
  Cmd,
  Bat : TStringList;
  Fexe,
  Fbat,
  Fname,
  Fpar: string;
begin
  Fexe  := Path + 'xfoil.exe';
  Fbat  := Path + 'temp\'+EditFoil.Text+'.bat';

  Bat := TStringList.Create;
  for Ct := Low (Re) to High (Re) do
    begin
      Fname := Path + 'temp\'+EditFoil.Text+'_'+IntToStr(Re[Ct])+'.dat';
      Fpar  := Path + 'temp\'+EditFoil.Text+'_'+IntToStr(Re[Ct])+'.cmd';
      ForceDirectories (Path + 'temp');
      Cmd := TStringList.Create;
      Cmd.Add ('LOAD '+Path+'airfoil\'+EditFoil.Text+'.dat');
      Cmd.Add ('');
      Cmd.Add ('GDES');  // (enter GDES menu)        |
      Cmd.Add ('CADD');  // (add points at corners)  |  These commands are optional,
      Cmd.Add ('');      // (accept default input)   |  and are recommended only for
      Cmd.Add ('');      // (accept default input)   |  Eppler and Selig airfoils
      Cmd.Add ('');      // (accept default input)   |  to give smoother LE shapes
      Cmd.Add ('');      // (return to Top Level)    |
      Cmd.Add ('PANE');  //(optional: use if input airfoil_file.dat has inadequate points)
      Cmd.Add ('OPER');  //(enter OPER menu)
      Cmd.Add ('VISC '+IntToStr(Re[Ct])); //(toggle viscous mode, with Re = 200000)
      Cmd.Add ('TYPE 2');          //(optional: use if constant-lift polars are to be used)
      Cmd.Add ('ALFA -2');         //(specify minimum alpha (must give CL>0 for Type 2 polar))
      Cmd.Add ('PACC');            //(toggle auto accumulation on for new polar 1)
      Cmd.Add (Path + 'polar\'+EditFoil.Text+'-'+IntToStr (Re[Ct])+'.dat');     //(choose polar save filename, or <return> for no file writing)
      Cmd.Add ('');                //(decline dump file writing)
      Cmd.Add ('ASEQ -2 4 0.2');
      Cmd.Add ('PPLO');
      Cmd.Add ('ASEQ 4.2 8 0.2');
      Cmd.Add ('PPLO');
      Cmd.Add ('ASEQ 8.2 12 0.2');
      Cmd.Add ('PPLO');
      Cmd.Add ('ASEQ 12.2 16 0.2');
      Cmd.Add ('PPLO');
      Cmd.Add ('ASEQ 16.2 20 0.2');
      Cmd.Add ('PPLO');
      Cmd.Add ('PACC');
      Cmd.Add ('');

      Cmd.Add ('QUIT');
      Cmd.SaveToFile (Fpar);
      Cmd.Free;

      Bat.Add (Fexe + '<' + Fpar);
      Bat.Add ('del '+Fpar);
    end;
  Bat.Add ('del '+Fbat);
  Bat.SaveToFile (Fbat);
  Bat.Free;
  ShellExecute (Handle, 'open', Pchar(Fbat), '', Pchar(Path), sw_hide);
end;

procedure TFormMain.EditPropChange(Sender: TObject);
begin
  if EditProp.ItemIndex >= 0 then
    begin
      LoadProp (EditProp.Text);
      EditPropD.Text := FormatFloat ('#0.0', Propeller.Diameter);
      EditPropP.Text := FormatFloat ('#0.0', Propeller.Pitch   );
    end;
end;

procedure TFormMain.EditRotChange(Sender: TObject);
begin
  CalcProp (false);
end;

procedure TFormMain.EditRotKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CalcProp (false);
end;

procedure TFormMain.BtnPolarClick(Sender: TObject);
begin
  CalcPolar ([40000,60000,80000,100000,120000,140000,160000,200000]);
end;

procedure TFormMain.EditVuserChange(Sender: TObject);
begin
  RecalcUser;
end;

procedure TFormMain.Importar1Click(Sender: TObject);
begin
  if RCCalc2.ImportAirfoil then
    LoadFoils;
end;

procedure TFormMain.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Pages.ActivePageIndex := 0;
  Polar     := TPolar    .Create ('');
  Airfoil   := TAirfoil  .Create ('');
  Propeller := TPropeller.Create ('');
  Brushed   := TMotors.Create(PathMotor+'Brushed.ini');
  Brushless := TMotors.Create(PathMotor+'Brushless.ini');

  LoadFoils;
  LoadProps;
  CheckLanguage;

  HideSplash;
end;

function TFormMain.GetText (S : string) : string;
var
  Ct : integer;
begin
  for Ct := 1 to High(LangPack) do
    if AnsiCompareText (S, LangPack [Ct, 0]) = 0 then
      begin
        Result := LangPack [Ct, Lang];
        break;
      end;
end;

procedure TFormMain.CheckLanguage;
var
  Ct1,
  Ct2,
  I : integer;
  Ctl : TComponent;
  List: TStringList;
  S   : string;
begin
  List := TStringList.Create;
  for Ct1 := 0 to ComponentCount-1 do
    begin
      Ctl := Components[Ct1];

      I := -1;
      for Ct2 := 1 to High(LangPack) do
        if Ctl.Name = LangPack [Ct2, 0] then
          begin
            I := Ct2;
            break;
          end;
      if I < 0 then
        begin
          if Ctl is TLabel then
            S := TLabel(Ctl).Caption
          else
            if Ctl is TMenuItem then
              S := TMenuItem(Ctl).Caption
            else
              S := '';
          if Trim (S) <> '' then
            List.Add ('   ,('''+Ctl.Name+''', '''+S+''', '''+S+''')');
        end;
    end;
  if List.Count > 0 then
    begin
      List.Insert (0,'const');
      List.Insert (1,'  LangPack: array [0..'+IntToStr(List.Count-1+High(LangPack))+',0..2] of string=');
      List.Insert (2, '   ((''Languages'', ''Português'', ''English'')');
      for Ct2 := 1 to High (LangPack) do
        List.Insert (Ct2+2,'   ,('''+LangPack[Ct2,0]+''', '''+LangPack[Ct2,1]+''', '''+LangPack[Ct2,2]+''')');
      List.Add ('  );');
      List.SaveToFile ('c:\RCcalc.txt');
      ShellExecuteA (0, 'open', 'c:\rccalc.txt', '', '', sw_show)
    end;
  List.Free;

  with TIniFile.Create ('RCcalc.ini') do
    begin
      Lang := ReadInteger ('Language', 'id', 0);
      if Lang < 1 then
        Lang := 1;
      if Lang > High (LangPack[0]) then
        Lang := High (LangPack [0]);
      Free;
    end;
  SetLanguage;
end;

procedure TFormMain.Portuguese1Click(Sender: TObject);
begin
  Lang := 1;
  SetLanguage;
end;

procedure TFormMain.English1Click(Sender: TObject);
begin
  Lang := 2;
  SetLanguage;
end;

procedure TFormMain.SetLanguage;
var
  Ct1,
  Ct2 : integer;
  Ctl : TComponent;
  S   : string;
  T   : TModelType;
  I   : integer;
begin
  with TIniFile.Create ('RCcalc.ini') do
    begin
      WriteInteger ('Language', 'id', Lang);
      Free;
    end;
  for Ct1 := 0 to ComponentCount-1 do
    begin
      Ctl := Components[Ct1];
      for Ct2 := 1 to High(LangPack) do
        if Ctl.Name = LangPack [Ct2, 0] then
          begin
            S := LangPack [Ct2, Lang];
            if Ctl is TLabel then
              TLabel(Ctl).Caption := S
            else
              if Ctl is TMenuItem then
                TMenuItem(Ctl).Caption := S;
            break;
          end;
    end;
  I := EditType.ItemIndex;
  if I < 0 then
    I := 0;
  EditType.Items.Clear;
  for T := Low(ModelParm) to High(ModelParm) do
    EditType.Items.Add(ModelParm[T].Desc[Lang]);
  EditType.ItemIndex := I;
end;

procedure TFormMain.GerarNACA1Click(Sender: TObject);
var
  S : string;
begin
  S := InputBox ('NACA airfoil', 'NACA', '');
  if S <> '' then
    if CheckNaca (S) then
      begin
        CalcFoil (S);
        Sleep (2000);
        LoadFoils;
      end;
end;

procedure TFormMain.CalcFoil (Naca : string);
var
  Cmd,
  Bat : TStringList;
  Fexe,
  Fbat,
  Fname,
  Path,
  Fpar: string;
begin
  Fexe  := Path + 'xfoil.exe';
  Fbat  := Path + 'temp\NACA'+Naca+'.bat';

  Bat := TStringList.Create;
  Fname := Path + 'temp\NACA'+Naca+'.dat';
  Fpar  := Path + 'temp\NACA'+Naca+'.cmd';
  ForceDirectories (Path + 'temp');
  Cmd := TStringList.Create;
  Cmd.Add ('NACA '+Naca);
  Cmd.Add ('SAVE '+Path+'airfoil\NACA'+Naca+'.dat');
  Cmd.Add ('QUIT');
  Cmd.SaveToFile (Fpar);
  Cmd.Free;

  Bat.Add (Fexe + '<' + Fpar);
  Bat.Add ('del '+Fpar);
  Bat.Add ('del '+Fbat);
  Bat.SaveToFile (Fbat);
  Bat.Free;
  ShellExecute (Handle, 'open', Pchar(Fbat), '', Pchar(Path), sw_hide);
end;

function TFormMain.CheckNACA (S : string) : boolean;
begin
  Result := false;
  if Length(Trim(S)) > 5 then
    begin
      Application.MessageBox (Pchar(GetText ('ErroNACA2')),
                              Pchar(GetText ('Erro')), mb_IconExclamation);
      exit;
    end;
  if StrTOIntDef (S,0) < 1 then
    begin
      Application.MessageBox (Pchar(GetText('ErroNACA3')), 'Erro', mb_IconExclamation);
      exit;
    end;
  if Length (S) = 5 then
    if (Copy (S,1,2) < '21') or
       (Copy (S,1,2) > '25') or
       (Copy (S,3,1) <> '0') then
      begin
        Application.MessageBox (Pchar(GetText ('ErroNACA1')),
                                Pchar(GetText ('Erro')), mb_IconExclamation);
        exit;
      end;
  Result :=  true;
end;


procedure TFormMain.Sobre1Click(Sender: TObject);
begin
  Application.MessageBox (Pchar (GetText ('AboutText' )),
                          Pchar (GetText ('AboutTitle')), mb_IconInformation);
end;

procedure TFormMain.EditThrustChange(Sender: TObject);
var
  R : integer;
begin
  R := Propeller.CalcRPM (StrToIntDef (EditThrust.Text, 0));
  if Abs (R - EditRot.Value) > 50 then
    begin
      EditRot.OnChange := NIL;
      EditRot.Value := R;
      CalcProp (true);
    end;
end;

procedure TFormMain.PagesChange(Sender: TObject);
begin
  if Pages.ActivePage = TabMotor then
    GetMotors;
end;

procedure TFormMain.GetMotors;
var
  T : TModelType;
begin
  for T := Low(ModelParm) to High(ModelParm) do
    if EditType.Text = ModelParm[T].Desc[Lang] then
      begin
        if ChkBrushed.Checked then
          Brushed.GetMotors (T,
                             EditSpan.Value,
                             EditWeight.Value,
                             Polar.SafeSpeed.Speed,
                             EditQtd.Value,
                             ListMotors)
        else
          Brushless.GetMotors (T,
                               EditSpan.Value,
                               EditWeight.Value,
                               Polar.SafeSpeed.Speed,
                               EditQtd.Value,
                               ListMotors);
        break;
      end;
end;

procedure TFormMain.ChkBrushedClick(Sender: TObject);
begin
  GetMotors;
end;

procedure TFormMain.ChkBrushlessClick(Sender: TObject);
begin
  GetMotors;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  SaveModel (PathModel + 'default.rcd');

  FreeAndNil (Polar    );
  FreeAndNil (Airfoil  );
  FreeAndNil (Propeller);
  FreeAndNil (Brushed  );
  FreeAndNil (Brushless);
end;

procedure TFormMain.EditQtdChange(Sender: TObject);
begin
  GetMotors;
  CalcProp (false);
end;

procedure TFormMain.ListMotorsDblClick(Sender: TObject);
var
  Prop:string;
  RPM :integer;
  Ct  :integer;
begin
  if Assigned(ListMotors.ItemFocused) then
    begin
      Prop := ListMotors.ItemFocused.SubItems[2];
      RPM  := StrToIntDef(ListMotors.ItemFocused.SubItems[3],0);
      for Ct := 0 to EditProp.Items.Count-1 do
        if EditProp.Items[Ct] = Prop then
          begin
            EditProp.ItemIndex := Ct;
            EditPropChange (EditProp);
            break;
          end;
      EditRot.Value := RPM;
    end;
end;

procedure TFormMain.EditQtdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  GetMotors;
  CalcProp (false);
end;

procedure TFormMain.EditTypeChange(Sender: TObject);
begin
  Recalc;
end;

procedure TFormMain.Abrir1Click(Sender: TObject);
begin
  if Filename = '' then
    DlgOpen.Filename := PathModel+'*.rcd'
  else
    DlgOpen.Filename := Filename;
  DlgOpen.InitialDir := PathModel;
  if DlgOpen.Execute then
    if FileExists (DlgOpen.Filename) then
      begin
        OpenModel (DlgOpen.FileName);
        Filename := DlgOpen.Filename;
      end;
end;

procedure TFormMain.Salvar1Click(Sender: TObject);
begin
  if Filename = '' then
    DlgSave.FileName := PathModel + EditName.Text +'.rcd'
  else
    DlgSave.Filename := Filename;
  DlgSave.InitialDir := PathModel;
  if DlgSave.Execute then
    begin
      SaveModel (DlgSave.FileName);
      Filename := DlgSave.Filename;
    end;
end;

procedure TFormMain.OpenModel (Filename : string);
var
  Ini : TIniFile;
begin
  Ini := TIniFile.Create (Filename);
  EditName  .Text  := Ini.ReadString ('Model', 'Name', '');
  SetCombo (EditFoil , Ini.ReadString ('Airfoil', 'Airfoil', ''));
  EditFoilChange(EditFoil);
  SetCombo (EditPolar, Ini.ReadString ('Airfoil', 'Polar'  , ''));
  EditPolarChange(EditPolar);
  EditSpan  .Value := Ini.ReadInteger ('Airfoil', 'Span' , 0);
  EditChord .Value := Ini.ReadInteger ('Airfoil', 'Chord', 0);
  EditWeight.Value := Ini.ReadInteger ('Model', 'Weight', 0);
  SetCombo (EditType, Ini.ReadString  ('Model', 'Type'  , ''));
  Recalc;

  ChkBrushless.Checked := Ini.ReadBool    ('Motor', 'Brushless', false);
  ChkBrushed  .Checked := Ini.ReadBool    ('Motor', 'Brushed'  , true);
  EditQtd     .Value   := Ini.ReadInteger ('Motor', 'Qtd'      , 0);
  SetCombo (EditProp, Ini.ReadString  ('Motor', 'Prop' , ''));
  EditRot   .OnChange := NIL;
  EditThrust.OnChange := NIL;
  EditRot     .Value   := Ini.ReadInteger ('Motor', 'Rot'   , 0);
  EditThrust  .Value   := Ini.ReadInteger ('Motor', 'Thrust', 0);
  if EditProp.ItemIndex >= 0 then
    begin
      LoadProp (EditProp.Text);
      EditPropD.Text := FormatFloat ('#0.0', Propeller.Diameter);
      EditPropP.Text := FormatFloat ('#0.0', Propeller.Pitch   );
    end;
  CalcProp(false);
  Ini.Free;
end;

procedure TFormMain.SaveModel (Filename : string);
var
  Ini : TIniFile;
begin
  Ini := TIniFile.Create (Filename);

  Ini.WriteString  ('Model'  , 'Name'   , EditName  .Text );
  Ini.WriteString  ('Airfoil', 'Airfoil', EditFoil  .Text );
  Ini.WriteString  ('Airfoil', 'Polar'  , EditPolar .Text );
  Ini.WriteInteger ('Airfoil', 'Span'   , EditSpan  .Value);
  Ini.WriteInteger ('Airfoil', 'Chord'  , EditChord .Value);
  Ini.WriteInteger ('Model'  , 'Weight' , EditWeight.Value);
  Ini.WriteString  ('Model'  , 'Type'   , EditType  .Text );

  Ini.WriteBool    ('Motor', 'Brushless', ChkBrushless.Checked);
  Ini.WriteBool    ('Motor', 'Brushed'  , ChkBrushed  .Checked);
  Ini.WriteInteger ('Motor', 'Qtd'      , EditQtd     .Value  );
  Ini.WriteString  ('Motor', 'Prop'     , EditProp    .Text   );
  Ini.WriteInteger ('Motor', 'Rot'      , EditRot     .Value  );
  Ini.WriteInteger ('Motor', 'Thrust'   , EditThrust  .Value  );

  Ini.Free;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  OpenModel (PathModel + 'default.rcd');
end;

end.


