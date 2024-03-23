unit RcCalc0;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormSplash = class(TForm)
    Label1: TLabel;
    LblMsg: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar: TProgressBar;
  private { Private declarations }
  public  { Public declarations }
  end;

var
  FormSplash: TFormSplash;

procedure ShowSplash;
procedure HideSplash;
procedure MsgSplash (S : string; P, M : integer);

implementation

{$R *.dfm}

procedure ShowSplash;
begin
  if not Assigned (FormSplash) then
    FormSplash := TFormSplash.Create (Application);
  FormSplash.Show;
end;

procedure HideSplash;
begin
  if Assigned (FormSplash) then
    FreeAndNil (FormSplash);
end;

procedure MsgSplash (S : string; P, M : integer);
begin
  if not Assigned (FormSplash) then
    ShowSplash;
  FormSplash.LblMsg.Caption := S;
  FormSplash.ProgressBar.Visible  := M > 0; 
  FormSplash.ProgressBar.Max      := M;
  FormSplash.ProgressBar.Position := P;
end;

end.
