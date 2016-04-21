unit main;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 RunOnce_PostIt,
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msestat,msemenus,msegui,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets;

type
 tmainfo = class(tmainform)
   label1: tlabel;
   tbutton1: tbutton;
   tbutton2: tbutton;
   procedure dontgetmessage(const sender: TObject);
   procedure getmessage(const sender: TObject);
   procedure onCatchMessage ;
   procedure aftercreated(const sender: TObject);
   procedure onformdestroy(const sender: TObject);
 end;
var
 mainfo: tmainfo;
implementation
uses
 main_mfm;
 
procedure tmainfo.onCatchMessage;
begin
  label1.Caption := TheMessage;
end;   
 
procedure tmainfo.dontgetmessage(const sender: TObject);
begin
StopMessage;
end;

procedure tmainfo.getmessage(const sender: TObject);
begin
 StartMessage(@onCatchMessage, 1000000); //// StartMessage(procedure, timer-interval)  
end;

procedure tmainfo.aftercreated(const sender: TObject);
begin
 InitMessage;
 StartMessage(@mainfo.onCatchMessage, 1000000);  //// StartMessage(procedure, timer-interval)   
end;

procedure tmainfo.onformdestroy(const sender: TObject);
begin
FreeRunOnce;  
end;
 
end.
