program RCcalc;

uses
  Forms,
  RCcalc1 in 'RCcalc1.pas' {FormMain},
  RCcalc2 in 'RCcalc2.pas' {FormImportAirfoil},
  RCCalcL in 'RCCalcL.pas',
  RcCalcC in 'RcCalcC.pas',
  RcCalc0 in 'RcCalc0.pas' {FormSplash};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormSplash, FormSplash);
  Application.Run;
end.
