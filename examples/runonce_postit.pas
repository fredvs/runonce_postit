(* 
RunOnce_PostIt allows your application to run only once.
If you try to run it again, you may post a message to the first running application.

RunOnce procedure is (a lot of) inspired by LSRunOnce of LazSolutions, created 
by Silvio Clecio :  http://silvioprog.com.br 

It works for lcl, fpGUI, msei and console applications.

Fred van Stappen  
fiens@hotmail.com
*)

unit RunOnce_PostIt;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows, JwaTlHelp32,
{$ENDIF}
   {$IF DEFINED(LCL)}
    ExtCtrls,       /// for lcl timer
     {$else}
   fpg_main, /// for fpgui timer
    {$endif}
  SysUtils, Classes, Process;

type
  TProc = procedure(AObject: TObject) of object;

function ExecProcess(const ACommandLine: string): string;
procedure ListProcess(const AProcess: TStringList; const AShowPID: boolean = False;
  const ASorted: boolean = True; const AIgnoreCurrent: boolean = False);

const
  CLSUtilsProcessNameValueSeparator: char = '=';

procedure RunOnce(AMessage: string);
procedure InitMessage(AOwner: TComponent; AProc: Tproc;
  const AInterval: integer = 1000);
function PostIt: string;

var
  TheMessage: string;

implementation

function PostIt: string;
var
  f: textfile;
begin
  if fileexists('.postit.tmp') then
  begin
    AssignFile(f, PChar('.postit.tmp'));
    Reset(F);
    Readln(F, TheMessage);
    CloseFile(f);
    DeleteFile('.postit.tmp');
    Result := TheMessage;
  end;
end;

procedure InitMessage(AOwner: TComponent; AProc: Tproc;
  const AInterval: integer = 1000);

var
{$IF DEFINED(LCL)}
   ATimer: TTimer;         /// for lcl timer
    {$else}
   ATimer: Tfpgtimer;             /// for fpGUI
   {$endif}
begin
  {$IF DEFINED(LCL)}
   ATimer := TTimer.Create(AOwner);         /// for lcl timer
    {$else}
   ATimer := TfpgTimer.Create(1000);           /// for fpGUI
   {$endif}

  ATimer.Interval := AInterval;
  ATimer.OnTimer := AProc;
  ATimer.Enabled := True;
end;



function ExecProcess(const ACommandLine: string): string;
const
  READ_BYTES = 2048;
var
  VStrTemp: TStringList;
  VMemoryStream: TMemoryStream;
  VProcess: TProcess;
  I64: longint;
  VBytesRead: longint;
begin
  VMemoryStream := TMemoryStream.Create;
  VProcess := TProcess.Create(nil);
  VStrTemp := TStringList.Create;
  try
    VBytesRead := 0;
{$WARN SYMBOL_DEPRECATED OFF}
    VProcess.CommandLine := ACommandLine;
{$WARN SYMBOL_DEPRECATED ON}
    VProcess.Options := [poUsePipes, poNoConsole];
    VProcess.Execute;
    while VProcess.Running do
    begin
      VMemoryStream.SetSize(VBytesRead + READ_BYTES);
      I64 := VProcess.Output.Read((VMemoryStream.Memory + VBytesRead)^, READ_BYTES);
      if I64 > 0 then
        Inc(VBytesRead, I64)
      else
        Sleep(100);
    end;
    repeat
      VMemoryStream.SetSize(VBytesRead + READ_BYTES);
      I64 := VProcess.Output.Read((VMemoryStream.Memory + VBytesRead)^, READ_BYTES);
      if I64 > 0 then
        Inc(VBytesRead, I64);
    until I64 <= 0;
    VMemoryStream.SetSize(VBytesRead);
    VStrTemp.LoadFromStream(VMemoryStream);
    Result := Trim(VStrTemp.Text);
  finally
    VStrTemp.Free;
    VProcess.Free;
    VMemoryStream.Free;
  end;
end;

procedure ListProcess(const AProcess: TStringList; const AShowPID: boolean;
  const ASorted: boolean; const AIgnoreCurrent: boolean);
var
{$IFDEF UNIX}
  I, J: integer;
  VOldNameValueSeparator: char;
{$ENDIF}
{$IFDEF MSWINDOWS}
  VSnapshotHandle: THandle;
  VProcessEntry32: TProcessEntry32;
{$ENDIF}
begin
{$IFDEF UNIX}
  VOldNameValueSeparator := AProcess.NameValueSeparator;
  AProcess.NameValueSeparator := CLSUtilsProcessNameValueSeparator;
  AProcess.Text := ExecProcess('sh -c "ps -A | awk ''{ print $4 "=" $1 }''"');
  J := AProcess.Count;
  for I := AProcess.Count downto 1 do
  begin
    if (I > J - 3) or (AIgnoreCurrent and
      (StrToIntDef(AProcess.ValueFromIndex[I - 1], -1) = integer(GetProcessID))) then
    begin
      AProcess.Delete(I - 1);
      Continue;
    end;
    if not AShowPID then
      AProcess.Strings[I - 1] := AProcess.Names[I - 1];
  end;
  AProcess.NameValueSeparator := VOldNameValueSeparator;
{$ENDIF}
{$IFDEF MSWINDOWS}
  try
    VSnapshotHandle := CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);
    VProcessEntry32.dwSize := SizeOf(TProcessEntry32);
    Process32First(VSnapshotHandle, VProcessEntry32);
    repeat
      if AIgnoreCurrent and (GetProcessID = VProcessEntry32.th32ProcessID) then
        Continue;
      if AShowPID then
        AProcess.Add(VProcessEntry32.szExeFile + CLSUtilsProcessNameValueSeparator +
          IntToStr(VProcessEntry32.th32ProcessID))
      else
        AProcess.Add(VProcessEntry32.szExeFile);
    until (not Process32Next(VSnapshotHandle, VProcessEntry32));
  except

  end;
{$ENDIF}
  if AProcess.Count > 0 then
    AProcess.Delete(0);
  AProcess.Sorted := ASorted;
end;

procedure RunOnce(AMessage: string);
var
  VProcess: TStringList;
  x, y: integer;
  f: textfile;
begin
  x := 0;
  y := 0;
  VProcess := TStringList.Create;
  ListProcess(VProcess, False, False, False);
  while x < VProcess.Count do
  begin
    if pos(ApplicationName, VProcess.Strings[x]) > 0 then
      Inc(y);
    if y > 1 then
    begin
      if AMessage <> '' then
      begin
        AssignFile(f, PChar('.postit.tmp'));
        rewrite(f);
        append(f);
        writeln(f, AMessage);
        Flush(f);
        CloseFile(f);
      end;
      Halt;
    end;
    Inc(x);
  end;
  VProcess.Free;
end;

end.
                                                                   
