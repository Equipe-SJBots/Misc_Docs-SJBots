unit RCCalcL;

interface

uses
  RcCalc0,
  IniFiles,
  StdCtrls,
  ComCtrls,
  Forms,
  Math,
  Graphics,
  Classes,
  SysUtils;


type
  TModelType = (mtSlow, mtTrainer, mtScale, mtSport, mtPylon, mtGlider, mtAcro, mt3D);
  TModelParm = record
                 Desc     : array[1..2] of string;
                 ThrustMin,
                 ThrustMax,
                 PitchMin,
                 PitchMax,
                 Dmin,
                 Dmax : integer;
               end;
var
  Path,
  PathProp,
  PathAirfoil,
  PathPolar,
  PathMotor,
  PathModel : string;
const
  Gravity = 9.8; // m/s^2
  Density = 0.61; // air density
  Viscosity = 70000;
  ModelParm : array [TModelType] of TModelParm =
              (
                (Desc: ('Slow'        ,'Slow'      ); ThrustMin: 50; ThrustMax:100;PitchMin:120;PitchMax:200; DMin: 20; DMax: 50;),
                (Desc: ('Treinador'   ,'Trainer'   ); ThrustMin: 50; ThrustMax:100;PitchMin:150;PitchMax:300; DMin: 10; DMax: 40;),
                (Desc: ('Escala'      ,'Scale'     ); ThrustMin: 50; ThrustMax:100;PitchMin:150;PitchMax:300; DMin: 10; DMax: 25;),
                (Desc: ('Esporte'     ,'Sport'     ); ThrustMin: 60; ThrustMax:150;PitchMin:150;PitchMax:400; DMin: 10; DMax: 30;),
                (Desc: ('Pylon'       ,'Pylon'     ); ThrustMin: 70; ThrustMax:100;PitchMin:200;PitchMax:800; DMin: 10; DMax: 20;),
                (Desc: ('Motoplanador','E-Glider'  ); ThrustMin: 50; ThrustMax:100;PitchMin:150;PitchMax:300; DMin: 10; DMax: 25;),
                (Desc: ('Acrobático'  ,'Aerobatics'); ThrustMin: 80; ThrustMax:200;PitchMin:150;PitchMax:300; DMin: 10; DMax: 40;),
                (Desc: ('3D'          ,'3D'        ); ThrustMin:150; ThrustMax:250;PitchMin:150;PitchMax:200; DMin: 20; DMax: 40;)
              );

type
  TPropeller = class (TObject)
    FFilename : string;
    Diameter,
    Pitch : double;
    Nprop : integer;
    Prop  : array [1..200] of
            record
              Rot,
              Thrust : integer;
            end;
    constructor Create (Fname : string);
    procedure GetPropSize;
  public
    function CalcRPM (Thrust : double) : integer;
    function CalcThrust (RPM : integer) : double;
    function CalcPitch  (RPM : integer) : double;
    function CalcPower  (RPM : integer) : double;
  end;

  TMotor = class (TObject)
    constructor Create (Ini: TIniFile; Id: string);
  public
    Desc,
    Name,
    Motor,
    Classe,
    Prop  : string;
    Gear,
    Volts,
    Current,
    Thrust,
    Diameter,
    Pitch,
    PowerIn,
    PowerOut : double;
    RPM : integer;
  end;

  TMotors = class (TStringList)
    constructor Create (Fname : string);
  public
    Ini : TIniFile;
    procedure GetMotors (MT : TModelType; Wingspan,Weight: integer; Cruise:double; N:integer;List : TListView);
  end;

  TCoord = class(TObject)
  public
    X,
    Y : double;
    constructor Create (AX, AY : double);
  end;

  TAirfoil = class (TObject)
    FFilename : string;
    FDescr    : string;
    FList     : TList;
    constructor Create (Fname : string);
  public
    procedure Draw (BMP : TBitmap; W, H : integer);
  end;

  TPolar = class (TObject)
    FFilename : string;
    NPolars : integer;
    Polars  : array [1..200] of
              record
                A,
                CL,
                CD : double;
              end;
    StallSpeed,
    BestSpeed,
    SafeSpeed,
    UserSpeed  : record
                   R,
                   CL,
                   CD,
                   Alpha,
                   Speed : double;
                 end;
    constructor Create (Fname : string);
    procedure AddPolar (A, CL, CD : double);
  public
    function FindCL (CL : double) : integer;
    function CalcCL (Weight, Area, Speed : double) : double;
    function GetCL (A : double) : double;
    function GetCD (A : double) : double;
    function GetAlpha (CL : double) : double;
    function CalcSpeed (W, CL, S : double) : double;
    function CalcStallSpeed (W, S : double) : double;
    function CalcBestSpeed (W, S : double) : double;
    function CalcSafeSpeed (W, S : double) : double;
    function CalcReynolds (S, L : double) : double;
  end;

function GetItem (var S : string) : string;
function GetLine (var S : string) : string;
function IsNumber (S : string) : boolean;
function Str2Float (S : string) : double;
function Float2Str (F : double; D : integer) : string;
procedure SetCombo (Cbx : TComboBox; S : string);

implementation

function GetItem (var S : string) : string;
var
  P : integer;
begin
  P := Pos (' ', S);
  if P = 0 then
    P := Pos (',', S);
  if P = 0 then
    P := Pos (';', S);
  if P > 0 then
    begin
      Result := Copy (S,1,P-1);
      S := Trim (Copy (S, P+1, Length(S)));
    end
  else
    begin
      Result := S;
      S := '';
    end;
end;

function GetLine (var S : string) : string;
var
  P : integer;
begin
  P := Pos (#10, S);
  if P = 0 then
    P := Pos (#13, S);
  if P > 0 then
    begin
      Result := Copy (S,1,P-1);
      System.Delete (S,1,P);
    end
  else
    begin
      Result := S;
      S := '';
    end;
end;

function IsNumber (S : string) : boolean;
begin
  try
    StrToInt (S);
    Result := true;
  except
    Result :=false;
  end;
end;

function Str2Float (S : string) : double;
var
  E : integer;
begin
  Val (S, Result, E);
  if E > 0 then
    Result := 0;
//    raise Exception.Create ('Numeric error');
end;

function Float2Str (F : double;D: integer) : string;
var
  S : string;
begin
  Str (F:1:D, S);
  while (Copy (S,Length(S),1) = '0') and
        (Pos ('.',S) > 0) do
    SetLength (S,Length(S)-1);
  while Copy (S,Length(S),1) = '.' do
    SetLength (S,Length(S)-1);
  Result := S;
end;

constructor TPropeller.Create (Fname : string);
var
  T : File;
  B : string;
  Rot,
  Thr : integer;
  S   : string;
begin
  inherited Create;

  if Fname = '' then
    exit;

  FFilename := FName;

  FileMode := 2;
  AssignFile (T, FFilename);
  Reset (T,1);
  SetLength (B, FileSize (T));
  BlockRead (T, B[1], FileSize (T));
  CloseFile (T);

  Nprop := 0;
  FillChar (Prop,SizeOf(Prop),0);
  while B <> '' do
    begin
      S := Trim (GetLine (B));
      Rot := StrToIntDef (GetItem (S),0);
      Thr := StrToIntDef (GetItem (S),0);
      Inc (Nprop);
      Prop[Nprop].Rot    := Rot;
      Prop[Nprop].Thrust := Thr;
    end;
  GetPropSize;
end;

procedure TPropeller.GetPropSize;
var
  S,
  D,
  P : string;
  Ct: integer;
begin
  S := ExtractFilename (FFilename);
  for Ct := 1 to Length (S)-3 do
    if IsNumber (Copy (S,Ct  ,1)) and
       IsNumber (Copy (S,Ct+1,1)) and
       IsNumber (Copy (S,Ct+2,1)) and
       IsNumber (Copy (S,Ct+3,1)) and
       IsNumber (Copy (S,Ct+4,1)) and 
       IsNumber (Copy (S,Ct+5,1)) then
      begin
        D := Copy (S,Ct  ,3);
        P := Copy (S,Ct+3,3);
        if D >='20' then
          Diameter := StrToIntDef (D,0)/100
        else
          Diameter := StrToIntDef (D,0)/10;
        Pitch := StrToIntDef (P,0)/100;
        exit;
      end;

  for Ct := 1 to Length (S)-3 do
    if IsNumber (Copy (S,Ct  ,1)) and
       IsNumber (Copy (S,Ct+1,1)) and
       IsNumber (Copy (S,Ct+2,1)) and
       IsNumber (Copy (S,Ct+3,1)) then
      begin
        D := Copy (S,Ct  ,2);
        P := Copy (S,Ct+2,2);
        if D >='20' then
          Diameter := StrToIntDef (D,0)/10
        else
          Diameter := StrToIntDef (D,0);
        Pitch := StrToIntDef (P,0)/10;
        exit;
      end;
end;

function TPropeller.CalcRPM (Thrust : double) : integer;
var
  T1,
  T2,
  Ct,
  R : integer;
  R1,
  R2,
  K    : double;
begin
  R1 := 0;
  R2 := 0;
  T1 := 0;
  T2 := 0;
  R  := 0;
  for Ct := 1 to Nprop do
    begin
      if Prop [Ct].Thrust = Thrust then
        begin
          R := Prop[Ct].Rot;
          break;
        end
      else
        if Prop [Ct].Thrust < Thrust then
          begin
            R1 := Prop[Ct].Rot;
            T1 := Prop[Ct].Thrust;
          end
        else
          begin
            R2 := Prop[Ct].Rot;
            T2 := Prop[Ct].Thrust;
            break;
          end;
    end;
  if R = 0 then
    try
//    K := (T2-T1) / (sqr (R2) - sqr (R1));
//    R := Round (T1 + K * (Sqr (RPM) - sqr(R1)));
      K := (R2-R1) / (T2-T1);
      R := Round (R1 + K * (Thrust - T1));
    except
      R := 0;
    end;
  Result := R;
end;

function TPropeller.CalcThrust (RPM : integer) : double;
var
  T1,
  T2,
  Ct,
  T : integer;
  R1,
  R2,
  K    : double;
begin
  R1 := 0;
  R2 := 0;
  T1 := 0;
  T2 := 0;
  T  := 0;
  for Ct := 1 to Nprop do
    begin
      if Prop [Ct].Rot = RPM then
        begin
          T := Prop[Ct].Thrust;
          break;
        end
      else
        if Prop [Ct].Rot < RPM then
          begin
            R1 := Prop[Ct].Rot;
            T1 := Prop[Ct].Thrust;
          end
        else
          begin
            R2 := Prop[Ct].Rot;
            T2 := Prop[Ct].Thrust;
            break;
          end;
    end;
  if T = 0 then
    try
      K := (T2-T1) / (sqr (R2) - sqr (R1));
      T := Round (T1 + K * (Sqr (RPM) - sqr(R1)));
    except
      T := 0;
    end;
  Result := T;
end;

function TPropeller.CalcPitch (RPM : integer) : double;
begin
  Result := RPM/60 * Pitch * 0.0254; // m/s
end;

function TPropeller.CalcPower (RPM : integer) : double;
begin
  Result := CalcPitch (RPM) * CalcThrust (RPM) * Gravity / 1000; // Watts
end;

constructor TAirfoil.Create (Fname : string);
var
  T : File;
  B : string;
  X,
  Y : double;
  S : string;
begin
  inherited Create;

  if FName = '' then
    exit;

  FFilename := FName;

  FileMode := 2;
  AssignFile (T, FFilename);
  Reset (T,1);
  SetLength (B, FileSize (T));
  BlockRead (T, B[1], FileSize (T));
  CloseFile (T);

  FList := TList.Create;

  Fdescr := Trim (GetLine (B));
  while B <> '' do
    begin
      S := Trim (GetLine (B));
      try
        X := Str2Float (GetItem (S));
        Y := Str2Float (GetItem (S));
        FList.Add (TCoord.Create (X, Y));
      except
      end;
    end;
end;

procedure TAirfoil.Draw (BMP : TBitmap; W, H : integer);
var
  Coord: TCoord;
  X,
  Y,
  DX,
  DY,
  MinX,
  MinY,
  MaxX,
  MaxY,
  ScaleX,
  ScaleY,
  Scale : double;
  PX,
  PY,
  Ct   : integer;
  First: boolean;
begin
  MaxX := -1E60;
  MaxY := -1E60;;
  MinX := +1E60;
  MinY := +1E60;

  for Ct := 0 to FList.Count-1 do
    begin
      Coord := FList[Ct];
      X := Coord.X;
      Y := Coord.Y;
      if X > MaxX then MaxX := X;
      if Y > MaxY then MaxY := Y;
      if X < MinX then MinX := X;
      if Y < MinY then MinY := Y;
    end;
  DX := MaxX - MinX;
  DY := MaxY - MinY;
  if DX > 0 then
    ScaleX := W / DX
  else
    ScaleX := 0;
  if DY > 0 then
    ScaleY := H / DY
  else
    ScaleY := 0;

  BMP.Assign (NIL);
  BMP.Width := W;
  BMP.Height:= H;
  PX := BMP.Width - 2 -
        BMP.Canvas.TextWidth (Fdescr);
  PY := 1;
  BMP.Canvas.TextOut (PX, PY, Fdescr);
  First := true;
  Scale := Min (ScaleX, ScaleY);

  for Ct := 0 to FList.Count-1 do
    begin
      Coord := FList[Ct];
      X := Coord.X;
      Y := Coord.Y;

      PX := Round (Scale * (X - MinX));
      PY := H-1 - Round (Scale * (Y - MinY));
      if First then
        begin
          BMP.Canvas.MoveTo (PX, PY);
          First := false;
        end
      else
        BMP.Canvas.LineTo (PX, PY);
    end;
end;

constructor TCoord.Create (AX, AY : double);
begin
  inherited Create;
  X := AX;
  Y := AY;
end;

constructor TPolar.Create (FName : string);
var
  T : File;
  B : string;
  Istall,
  Ct: integer;
  A,
  CL,
  CD,
  CDp,
  R : double;
  S : string;
begin
  inherited Create;
  
  FillChar (Polars, SizeOf (Polars), 0);
  NPolars := 0;
  FillChar (BestSpeed, SizeOf (BestSpeed), 0);
  FillChar (StallSpeed, SizeOf (StallSpeed), 0);

  if FName = '' then
    exit;

  FileMode := 2;
  FFilename := FName;
  AssignFile (T, FFilename);
  Reset (T,1);
  SetLength (B, FileSize (T));
  BlockRead (T, B[1], FileSize (T));
  CloseFile (T);
  while B <> '' do
    begin
      S := Trim (GetLine (B));
      try
        A  := Str2Float (GetItem (S));
        CL := Str2Float (GetItem (S));
        CD := Str2Float (GetItem (S));
        try
          CDp := Str2Float (GetItem (S));
        except
          CDp := 0;
        end;
        if Cd > 0 then
          AddPolar (A, CL, CD+CDp);
      except
      end;
    end;
  Istall := 0;
  for Ct := 1 to NPolars do
    begin
      if Polars [Ct].CD > 0 then
        begin
          R := Polars [Ct].CL / Polars [Ct].CD;
          if R > BestSpeed.R then
            begin
              BestSpeed.R     := R;
              BestSpeed.CL    := Polars[Ct].CL;
              BestSpeed.CD    := Polars[Ct].CD;
              BestSpeed.Alpha := Polars[Ct].A;
            end;
          if Polars[Ct].CL > StallSpeed.CL then
            begin
              Istall := Ct;
              StallSpeed.R     := R;
              StallSpeed.CL    := Polars[Ct].CL;
              StallSpeed.CD    := Polars[Ct].CD;
              StallSpeed.Alpha := Polars[Ct].A;
            end;
        end;
    end;
  NPolars := Istall;
end;

procedure TPolar.AddPolar (A, CL, CD : double);
var
  X,Y,P,Ct : integer;
begin
  X := 1;
  Y := NPolars;
  P := 0;
  while X <= Y do
    begin
      P := (X + Y) div 2;
      if A < Polars[P].A then
        Y := P-1
      else
        if A > Polars[P].A then
          X := P+1
        else
          break;
    end;
  if P = 0 then
    begin
      if NPolars < High (Polars) then
        Inc (NPolars);
      P := NPolars;
    end
  else
    if Polars[P].A <> A then
      begin
        if NPolars < High (Polars) then
          Inc (NPolars);
        for Ct := NPolars downto P+1 do
          Polars[Ct] := Polars [Ct-1];
      end;
  Polars[P].A := A;
  Polars[P].CL:= CL;
  Polars[P].CD:= CD;
end;

function TPolar.FindCL (CL : double) : integer;
var
  Ct : integer;
  Diff,
  BestDiff : double;
  BestI  : integer;
begin
  BestDiff := 99999999;
  BestI    := 0;
  for Ct := 1 to NPolars do
    begin
      Diff := Abs (Polars [Ct].CL - CL);
      if Diff < BestDiff then
        begin
          BestDiff := Diff;
          BestI    := Ct;
        end;
    end;
  Result := BestI;
end;

function TPolar.CalcCL (Weight, Area, Speed : double) : double;
begin
  Result := (Gravity*Weight/1000) / (sqr (Speed) * Density * Area/100);
end;

function TPolar.GetCL (A : double) : double;
var
  Ct : integer;
  CL,
  A1,
  C1,
  A2,
  C2,
  K : double;
begin
  A  := 0;
  A1 := 0;
  C1 := 0;
  A2 := 0;
  C2 := 0;
  for Ct := 1 to NPolars do
    begin
      if Abs (Polars [Ct].A - A) < 0.001 then
        begin
          Result := Polars [Ct].CL;
          exit;
        end
      else
        if Polars [Ct].A < A then
          begin
            A1 := Polars[Ct].A;
            C1 := Polars[Ct].CL;
          end
        else
          begin
            A2 := Polars[Ct].A;
            C2 := Polars[Ct].CL;
            break;
          end;
    end;
  try
    K := (C2-C1) / (A2-A1);
    CL := Round (C1 + K * (A - A1));
  except
    CL := 0;
  end;
  Result := CL;
end;

function TPolar.GetCD (A : double) : double;
var
  Ct : integer;
  CD,
  A1,
  C1,
  A2,
  C2,
  K : double;
begin
  A  := 0;
  A1 := 0;
  C1 := 0;
  A2 := 0;
  C2 := 0;
  for Ct := 1 to NPolars do
    begin
      if Abs (Polars [Ct].A - A) < 0.001 then
        begin
          Result := Polars [Ct].CD;
          exit;
        end
      else
        if Polars [Ct].A < A then
          begin
            A1 := Polars[Ct].A;
            C1 := Polars[Ct].CD;
          end
        else
          begin
            A2 := Polars[Ct].A;
            C2 := Polars[Ct].CD;
            break;
          end;
    end;
  try
    K := (C2-C1) / (A2-A1);
    CD := Round (C1 + K * (A - A1));
  except
    CD := 0;
  end;
  Result := CD;
end;

function TPolar.GetAlpha (CL : double) : double;
var
  Ct : integer;
  Alpha,
  A1,
  C1,
  A2,
  C2,
  K : double;
begin
  A1 := 0;
  C1 := 0;
  A2 := 0;
  C2 := 0;
  for Ct := 1 to NPolars do
    begin
      if Abs (Polars [Ct].CL - CL) < 0.00001 then
        begin
          Result := Polars [Ct].A;
          exit;
        end
      else
        if Polars [Ct].CL < CL then
          begin
            A1 := Polars[Ct].A;
            C1 := Polars[Ct].CL;
          end
        else
          begin
            A2 := Polars[Ct].A;
            C2 := Polars[Ct].CL;
            break;
          end;
    end;
  try
    K := (A2-A1) / (C2-C1);
    Alpha := Round (A1 + K * (CL - C1));
  except
    Alpha := 0;
  end;
  Result := Alpha;
end;

function TPolar.CalcSpeed (W, CL, S : double) : double;
begin
  Result := sqrt ( (Gravity*W/1000) / (CL * Density * S/100) );
end;

function TPolar.CalcStallSpeed (W, S : double) : double;
begin
  Result := sqrt ( (Gravity*W/1000) / (StallSpeed.CL * Density * S/100) );
end;

function TPolar.CalcBestSpeed (W, S : double) : double;
begin
  Result := sqrt ( (Gravity*W/1000) / (BestSpeed.CL * Density * S/100) );
end;

function TPolar.CalcSafeSpeed (W, S : double) : double;
var
  Stall : double;
begin
  Stall :=  CalcStallSpeed (W, S);
  Result := Max (Stall*1.2, Stall+3);
end;

function TPolar.CalcReynolds (S, L : double) : double;
begin
  Result := S * L * Viscosity / 100;
end;

constructor TMotor.Create (Ini : TIniFile; Id : string);
var
  Prp : TPropeller;
begin
  inherited Create;
  Name    := Id;
  Motor   := Ini.ReadString (Id, 'Name','');
  Classe  := Ini.ReadString (Id, 'Class','');
  Prop    := Ini.ReadString (Id, 'Prop','');
  Volts   := Str2Float   (Ini.ReadString (Id, 'Volts'   ,''));
  Gear    := Str2Float   (Ini.ReadString (Id, 'Gear'    ,''));
  Current := Str2Float   (Ini.ReadString (Id, 'Current' ,''));
  Thrust  := StrToIntDef (Ini.ReadString (Id, 'Thrust'  ,''),0);
  RPM     := StrToIntDef (Ini.ReadString (Id, 'RPM'     ,''),0);
  Diameter:= Str2Float   (Ini.ReadString (Id, 'Diameter',''));
  Pitch   := Str2Float   (Ini.ReadString (Id, 'Pitch'   ,''));
  PowerIn := Str2Float   (Ini.ReadString (Id, 'PowerIn' ,''));
  PowerOut:= Str2Float   (Ini.ReadString (Id, 'PowerOut',''));
  Prp := NIL;
  if (Thrust   = 0) or
     (RPM      = 0) or
     (Pitch    = 0) or
     (Diameter = 0) or
     (PowerIn  = 0) or
     (PowerOut = 0) then
    if FileExists (PathProp+Prop+'.csv') then
      try
        Prp := TPropeller.Create(PathProp+Prop+'.csv');
        if RPM < 1 then
          RPM := Prp.CalcRPM(Thrust);
        if Thrust < 1 then
          Thrust := Prp.CalcThrust(RPM);
        if Pitch < 1 then
          Pitch := Prp.CalcPitch(RPM);
        if PowerIn = 0 then
          PowerIn := Current*Volts;
        if PowerOut = 0 then
          PowerOut := Prp.CalcPower(RPM);
        if Diameter = 0 then
          Diameter := Prp.Diameter;
        Ini.WriteInteger(Id, 'Thrust'  , Round(Thrust));
        Ini.WriteInteger(Id, 'RPM'     , Round(RPM   ));
        Ini.WriteString (Id, 'Pitch'   , Float2Str(Pitch   ,2));
        Ini.WriteString (Id, 'Diameter', Float2Str(Diameter,1));
        Ini.WriteString (Id, 'PowerIn' , Float2Str(PowerIn ,2));
        Ini.WriteString (Id, 'PowerOut', Float2Str(PowerOut,2));
      except
      end;
  if Assigned (Prp) then
    FreeAndNil (Prp);
end;

constructor TMotors.Create (Fname : string);
var
  List : TStringList;
  Ct   : integer;
begin
  inherited Create;
  MsgSplash('Loading motor parameters',0,0);
  Ini := TIniFile.Create (FName);
  List := TStringList.Create;
  Ini.ReadSections (List);
  for Ct := 0 to List.Count-1 do
    begin
      MsgSplash('Loading motor parameters',Ct,List.Count);
      AddObject (List[Ct], TMotor.Create (Ini,List[Ct]));
      Application.ProcessMessages;
    end;
  Ini.Free;
end;

procedure TMotors.GetMotors (MT : TModelType; Wingspan, Weight: integer; Cruise:double; N:integer;List : TListView);
var
  Ct : integer;
  T  : double;
  M  : TMotor;
  Item : TListItem;
  Tmin,
  Tmax,
  Pmin,
  Pmax,
  Dmin,
  Dmax : double;
begin
  if N < 1 then
    N := 1;
  T := Weight/N;
  List.Items.Clear;
  if (Wingspan > 0) and (Weight > 0) and (Cruise > 1) then
    begin
      Tmin := Weight * ModelParm [MT].ThrustMin / 100 / N;
      Tmax := Weight * ModelParm [MT].ThrustMax / 100 / N;
      Pmin := Cruise * ModelParm [MT].PitchMin  / 100;
      Pmax := Cruise * ModelParm [MT].PitchMax  / 100;
      Dmin := Wingspan*ModelParm [MT].Dmin      / 100 / 2.54 / sqrt(N);
      Dmax := Wingspan*ModelParm [MT].Dmax      / 100 / 2.54 / sqrt(N);

      for Ct := 0 to Count-1 do
        begin
          M := TMotor (Objects[Ct]);
          if (M.Thrust  >= Tmin) and
             (M.Thrust  <= Tmax) and
             (M.Pitch   >= Pmin) and
             (M.Pitch   <= Pmax) and
             (M.Diameter>= Dmin) and
             (M.Diameter<= Dmax) then
            begin
              Item := List.Items.Add;
              Item.Caption := M.Motor;
              Item.SubItems.Add (M.Classe);
              if (Abs (M.Gear-1) < 0.001) or (Abs (M.Gear) < 0.001) then
                Item.SubItems.Add ('DD')
              else
                Item.SubItems.Add (Float2Str (M.Gear,2)+':1');
              Item.SubItems.Add(M.Prop);
              Item.SubItems.Add(IntToStr(M.RPM));
              Item.SubItems.Add(Float2Str (M.Volts   ,1)+'V');
              Item.SubItems.Add(Float2Str (M.Current ,1)+'A');
              Item.SubItems.Add(Float2Str (M.PowerIn ,1)+'W');
              Item.SubItems.Add(Float2Str (M.Thrust  ,0)+'g');
              Item.SubItems.Add(Float2Str (M.Pitch   ,1)+'m/s');
              Item.SubItems.Add(Float2Str (M.PowerOut,1)+'W');
              if M.PowerIn > 0 then
                Item.SubItems.Add(IntToStr(Round(100*M.PowerOut/M.PowerIn))+'%')
              else
                Item.SubItems.Add('*');
            end;
        end;
    end;
end;

procedure SetCombo (Cbx : TComboBox; S : string);
var
  Ct : integer;
begin
  for Ct := 0 to Cbx.Items.Count-1 do
    if Cbx.Items[Ct] = S then
      begin
        Cbx.ItemIndex := Ct;
        break;
      end;
end;


begin
  Path := ExtractFilePath (Application.ExeName);
  PathProp    := Path+'Prop\';
  PathAirfoil := Path+'Airfoil\';
  PathPolar   := Path+'Polar\';
  PathMotor   := Path+'Motor\';
  PathModel   := Path+'Model\';
  ForceDirectories (PathModel);
end.
