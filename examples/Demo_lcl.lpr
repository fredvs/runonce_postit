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

   mymessage := 'On ' + FormatDateTime('tt', now) + '  -' + applicationname + '-  with' ;
    if ParamStr(1) = '' then mymessage := mymessage + 'out parameter was entered.' else
    mymessage := mymessage + '  -' + ParamStr(1) + '-  as first parameter was entered.' ;

   RunOnce(mymessage);

   Application.Initialize;
   Application.CreateForm(TMainForm, MainForm);
   Application.Run;
end.
