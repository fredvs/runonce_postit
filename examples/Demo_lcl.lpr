program Demo_lcl;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
  cthreads, {$ENDIF} {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  mainfrm,
  RunOnce_PostIt,
  SysUtils { you can add units after this };

{$R *.res}

var
  mymessage: string;

begin
  mymessage := 'This is message from ' + ApplicationName + ' on ' +
    FormatDateTime('dddd', now) + ' ' + FormatDateTime('dd', now) +
    ' ' + FormatDateTime('mmmm', now) + ' ' + FormatDateTime('yyyy', now) +
    ', ' + FormatDateTime('tt', now);

  RunOnce(mymessage);
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
