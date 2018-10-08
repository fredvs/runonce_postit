{ To test this demo, try to run one more time the application.... }


unit mainfrm;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,
  RunOnce_PostIt, Forms,
  StdCtrls, Classes;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure onCatchMessage ;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.onCatchMessage;
begin
  label1.Caption := TheMessage;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeRunOnce ;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  StopMessage;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  StartMessage(@onCatchMessage, 1000); //// StartMessage(procedure, timer-interval)
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  InitMessage(self);
  StartMessage(@onCatchMessage, 1000);  //// StartMessage(procedure, timer-interval)
 end;


end.

