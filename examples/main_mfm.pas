unit main_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,main;

const
 objdata: record size: integer; data: array[0..740] of byte end =
      (size: 741; data: (
  84,80,70,48,7,116,109,97,105,110,102,111,6,109,97,105,110,102,111,8,
  98,111,117,110,100,115,95,120,3,87,1,8,98,111,117,110,100,115,95,121,
  3,222,0,9,98,111,117,110,100,115,95,99,120,3,141,2,9,98,111,117,
  110,100,115,95,99,121,3,146,0,26,99,111,110,116,97,105,110,101,114,46,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,27,99,
  111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,46,98,
  111,117,110,100,115,1,2,0,2,0,3,141,2,3,146,0,0,9,111,110,
  99,114,101,97,116,101,100,7,12,97,102,116,101,114,99,114,101,97,116,101,
  100,9,111,110,100,101,115,116,114,111,121,7,13,111,110,102,111,114,109,100,
  101,115,116,114,111,121,15,109,111,100,117,108,101,99,108,97,115,115,110,97,
  109,101,6,9,116,109,97,105,110,102,111,114,109,0,6,116,108,97,98,101,
  108,6,108,97,98,101,108,49,8,98,111,117,110,100,115,95,120,2,72,8,
  98,111,117,110,100,115,95,121,2,16,9,98,111,117,110,100,115,95,99,120,
  3,249,1,9,98,111,117,110,100,115,95,99,121,2,15,7,99,97,112,116,
  105,111,110,6,83,87,97,105,116,105,110,103,32,102,111,114,32,115,111,109,
  101,32,109,101,115,115,97,103,101,32,102,114,111,109,32,109,101,46,46,46,
  32,84,114,121,32,116,111,32,114,117,110,32,97,32,111,116,104,101,114,32,
  105,110,115,116,97,110,99,101,32,111,102,32,116,104,101,32,97,112,112,108,
  105,99,97,116,105,111,110,46,13,114,101,102,102,111,110,116,104,101,105,103,
  104,116,2,15,0,0,7,116,98,117,116,116,111,110,8,116,98,117,116,116,
  111,110,49,8,116,97,98,111,114,100,101,114,2,1,8,98,111,117,110,100,
  115,95,120,2,96,8,98,111,117,110,100,115,95,121,2,72,9,98,111,117,
  110,100,115,95,99,120,3,162,0,9,98,111,117,110,100,115,95,99,121,2,
  21,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,
  116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,
  116,101,0,7,99,97,112,116,105,111,110,6,16,68,111,110,116,32,103,101,
  116,32,109,101,115,115,97,103,101,9,111,110,101,120,101,99,117,116,101,7,
  14,100,111,110,116,103,101,116,109,101,115,115,97,103,101,0,0,7,116,98,
  117,116,116,111,110,8,116,98,117,116,116,111,110,50,8,116,97,98,111,114,
  100,101,114,2,2,8,98,111,117,110,100,115,95,120,3,104,1,8,98,111,
  117,110,100,115,95,121,2,72,9,98,111,117,110,100,115,95,99,120,3,130,
  0,9,98,111,117,110,100,115,95,99,121,2,21,5,115,116,97,116,101,11,
  15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,95,
  108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,116,
  105,111,110,6,11,71,101,116,32,109,101,115,115,97,103,101,9,111,110,101,
  120,101,99,117,116,101,7,10,103,101,116,109,101,115,115,97,103,101,0,0,
  0)
 );

initialization
 registerobjectdata(@objdata,tmainfo,'');
end.