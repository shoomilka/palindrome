program poly;
{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

function isPoly(i:integer):boolean;
var s:string;
begin
  s:=IntToStr(i);
  Result:=false;
  if i>=100000 then
    begin
      if (s[1]=s[6]) and (s[2]=s[5]) and (s[3]=s[4]) then Result:=true;
    end
  else
    begin
      if (s[1]=s[5]) and (s[2]=s[4]) then Result:=true;
    end;
end;

procedure pMain();
var i,j,iPol,iTempe:integer;
begin
  iPol:=0;
  for i:=999 downto 100 do
    begin
      for j:=i downto 100 do
        begin
          iTempe:=i*j;
          if isPoly(iTempe) then
            if iTempe>iPol then iPol:=iTempe;
        end;
    end;
  WriteLn(iPol);
end;

function isNear(iCurr:integer):integer;
var iX,iY,i,iTempe:integer;
begin
  Result:=0;
  iX:=iCurr+2;
  iY:=iCurr+1;
  for i:=iCurr+1 to 998 do
    begin
      iTempe:=iX*iY;
      if isPoly(iTempe) and (Result<iTempe) then
        begin
          Result:=iTempe;
        end;
      iY:=iY-1;
      iTempe:=iX*iY;
      if isPoly(iTempe) and (Result<iTempe) then
        begin
          Result:=iTempe;
        end;
      iX:=iX+1;
    end;
end;

procedure pRever(iCurr:integer; var iPol:integer; var bFlag:boolean);
var iTempe,i:integer;
  iM:int64;
begin
    iTempe:=iCurr*iCurr;
    if isPoly(iTempe) and (iPol<iTempe) then
          begin
            iPol:=iTempe;
            bFlag:=true;
          end
    else
      begin
        iTempe:=isNear(iCurr-1);
        if iTempe>iPol then
          begin
            iPol:=iTempe;
            iM:=Trunc(sqrt(iPol));
            for i:=iM to (iCurr-1) do
              begin
                pRever(i,iPol,bFlag);      
              end;
            bFlag:=true;
          end;
      end;
end;

procedure pMainSE();
var
  iPol:integer;
  iCurr:integer;
  bFlag:boolean;
begin
  iCurr:=999;
  iPol:=0;
  bFlag:=false;
  repeat
    pRever(iCurr,iPol,bFlag);
    iCurr:=iCurr-1;
  until (bFlag);
WriteLn(iPol);
end;

var i:integer;
  eTime:extended;
const co=5000;
begin
  eTime:=GetTickCount;
  for i:=1 to co do
    begin
      pMainSE;
    end;
  eTime:=(GetTickCount-eTime)/co;
  Write(eTime);
  WriteLn(' ms');
  ReadLn;
end.
