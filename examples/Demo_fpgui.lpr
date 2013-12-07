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
    Label1: TfpgLabel;

    {@VFD_HEAD_END: Tmainfrm}
  public
    procedure CatchMessage(Sender: TObject);
    procedure AfterCreate; override;
    procedure btnCloseClick(Sender: TObject);
  end;

  {@VFD_NEWFORM_DECL}

  {@VFD_NEWFORM_IMPL}

var
  mymessage: string;


  procedure Tmainfrm.btnCloseClick(Sender: TObject);
  begin
    Close;
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

    btnClose := TfpgButton.Create(self);
    with btnClose do
    begin
      Name := 'btnClose';
      SetPosition(245, 70, 60, 23);
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
        'Waiting for some message from me... Try to load a other instance of the application.';
    end;


    {@VFD_BODY_END: Simpleplayer}
    {%endregion}

    //////////////////////

    InitMessage(self, @CatchMessage, 1000);

  end;

  procedure Tmainfrm.CatchMessage(Sender: TObject);
  begin
    PostIt;
    if TheMessage <> '' then
     {$IF DEFINED(LCL)}
      label1.Caption := TheMessage;            /// for lcl
    {$else}
    label1.Text := TheMessage;                /// for fpGUI
   {$endif}

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
