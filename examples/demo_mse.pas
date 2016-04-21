program demo_mse;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
{$ifdef FPC}
 {$ifdef mswindows}{$apptype gui}{$endif}
{$endif}
uses
 {$ifdef FPC}{$ifdef unix}cthreads,{$endif}{$endif} 
  SysUtils,  msegui, main, RunOnce_PostIt;
 
 var
  mymessage: string;  
  
begin
   mymessage := 'On ' + FormatDateTime('tt', now) + '  -' + applicationname + '-  with';
    if ParamStr(1) = '' then
      mymessage := mymessage + 'out parameter was entered.'
    else
      mymessage := mymessage + '  -' + ParamStr(1) + '-  as first parameter was entered.';

   RunOnce(mymessage);     
   
 application.createform(tmainfo,mainfo);
  application.run;
end.
