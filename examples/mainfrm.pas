{ To test this demo, try to run one more time the application.... }


unit mainfrm;

{$mode objfpc}{$H+}

interface

uses
  RunOnce_PostIt, Forms,
  StdCtrls;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure CatchMessage(Sender: TObject);
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

procedure TMainForm.CatchMessage(Sender: TObject);
begin
  PostIt;
  if TheMessage <> '' then
    label1.Caption := TheMessage;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  InitMessage(self, @CatchMessage, 1000);
end;


end.

