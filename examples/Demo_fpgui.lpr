program Demo_fpGUI;

{$mode objfpc}{$H+}
  {$DEFINE UseCThreads}

uses {$IFDEF UNIX} {$IFDEF UseCThreads} {$ENDIF} {$ENDIF}
  RunOnce_PostIt,
  SysUtils,
  Classes,
  fpg_button,
  fpg_label,
  fpg_base,
  fpg_main,
  fpg_form { you can add units after this };

type

  Tmainfrm = class(TfpgForm)

  private
    {@VFD_HEAD_BEGIN: Tmainfrm}
    btnClose: TfpgButton;
     btnStart: TfpgButton;
     btnStop: TfpgButton;
    Label1: TfpgLabel;

    {@VFD_HEAD_END: Tmainfrm}
  public
    procedure CatchMessage;
    procedure AfterCreate; override;
    procedure btnCloseClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure onDestroyForm(Sender: TObject);
  end;

  {@VFD_NEWFORM_DECL}

  {@VFD_NEWFORM_IMPL}

var
  mymessage: string;

  procedure Tmainfrm.CatchMessage;
  begin
       label1.Text := TheMessage;                /// for fpGUI
  end;

  procedure Tmainfrm.onDestroyForm(Sender: TObject);
  begin
  FreeRunOnce;
  end;

  procedure Tmainfrm.btnCloseClick(Sender: TObject);
  begin
  Close;
  end;

   procedure Tmainfrm.btnStartClick(Sender: TObject);
  begin
     StartMessage(@CatchMessage, 1000);
  end;

  procedure Tmainfrm.btnStopClick(Sender: TObject);
  begin
    StopMessage;
  end;

  procedure Tmainfrm.AfterCreate;
  begin
    {%region 'Auto-generated GUI code' -fold}

    {@VFD_BODY_BEGIN: Tmainfrm}
    Name := 'mainfrm';
    SetPosition(300, 168, 560, 100);
    WindowTitle := 'RunOnce PostIt';
    Hint := '';
    WindowPosition := wpScreenCenter;
    BackgroundColor := clmoneygreen;
    OnDestroy:= @onDestroyForm;

    btnStart := TfpgButton.Create(self);
    with btnStart do
    begin
      Name := 'btnStart';
      SetPosition(50, 70, 150, 23);
      Text := 'Enable Get Message';
      Enabled := True;
      FontDesc := '#Label1';
      Hint := '';
      ImageName := '';
      TabOrder := 6;
      onclick := @btnStartClick;
    end;

     btnStop := TfpgButton.Create(self);
    with btnStop do
    begin
      Name := 'btnStop';
      SetPosition(240, 70, 150, 23);
      Text := 'Disable Get Message';
      Enabled := True;
      FontDesc := '#Label1';
      Hint := '';
      ImageName := '';
      TabOrder := 6;
      onclick := @btnStopClick;
    end;

     btnClose := TfpgButton.Create(self);
    with btnClose do
    begin
      Name := 'btnClose';
      SetPosition(440, 70, 60, 23);
      Text := 'Close';
      Enabled := True;
      FontDesc := '#Label1';
      Hint := '';
      ImageName := '';
      TabOrder := 6;
      onclick := @btnCloseClick;
    end;

    Label1 := TfpgLabel.Create(self);
    with Label1 do
    begin
      Name := 'Label1';
      SetPosition(20, 30, 520, 30);
      FontDesc := '#Label2';
      Hint := '';
      Text :=
        'Waiting for some message... Try to load a other instance of the application.';
      Label1.Alignment:=taCenter;
    end;


    {@VFD_BODY_END: Simpleplayer}
    {%endregion}

    //////////////////////

   InitMessage  ;
   StartMessage(@CatchMessage, 1000);
  end;


  procedure MainProc;
  var
    frm: Tmainfrm;

  begin
    mymessage := 'On ' + FormatDateTime('tt', now) + '  -' + applicationname + '-  with';
    if ParamStr(1) = '' then
      mymessage := mymessage + 'out parameter was entered.'
    else
      mymessage := mymessage + '  -' + ParamStr(1) + '-  as first parameter was entered.';

    RunOnce(mymessage);

    fpgApplication.Initialize;

    frm := Tmainfrm.Create(nil);
    try
      frm.Show;
      fpgApplication.Run;
    finally
      frm.Free;
    end;
  end;

begin
  MainProc;
end.
