unit Unit4;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.Menus, Vcl.Imaging.pngimage, DateUtils;
type arr = array[1..20] of string;
procedure SaveTimeInLeaderBoard(time:string; num:integer);
function LoadLeaderBoard(num:integer): arr;
procedure SaveLevel(num:integer);
function LoadMaxLevel():integer;
procedure Createmaxlevel();
procedure CreateLeaderBoard();
function SortStrings(const Strings: arr): TStringList;
function GetBestResult(num:integer):string;
implementation
// получить лучший результат пользователя
function GetBestResult(num:integer):string;
begin
  var lb := LoadLeaderBoard(num);
  var sorted := SortStrings(lb);
  for var i := 0 to sorted.Count-1 do begin
  if sorted[i] <> '00:00' then begin
    Result := sorted[i];
    exit
    end;
  end;
end;
// сохраняет переданное время в лидерборд
procedure SaveTimeInLeaderBoard(time:string; num:integer);
var F: TextFile;
    data: arr;
begin
AssignFile(F, ExtractFilePath(ParamStr(0))+'files\'+inttostr(num)+'leaderboard.txt');
data := LoadLeaderBoard(num);
  rewrite(F);
  writeln(F, time);
  for var i := 1 to 19 do
    writeln(f, data[i]);
  Close(F);
  end;
// возвращает все строки из лидерборда
function LoadLeaderBoard(num:integer): arr;
var F: TextFile;
    s: string;
    data: arr;
begin
AssignFile(F, ExtractFilePath(ParamStr(0))+'files\'+inttostr(num)+'leaderboard.txt');
Reset(F);
for var i := 1 to 20 do begin
readln(F, s);
data[i] := s;
end;
Close(F);
Result := data;
end;
// сортирует строки лидерборда (и не только) по возрастанию
function SortStrings(const Strings: arr): TStringList;
var
  StringList: TStringList;
  i: Integer;
begin
  StringList := TStringList.Create;
  StringList.AddStrings(Strings);
  StringList.Sort;
  Result := StringList;
end;
// сохраняет переданный уровень, если он выше чем текущий записанный
procedure SaveLevel(num:integer);
var F: TextFile;
begin
AssignFile(F, ExtractFilePath(ParamStr(0))+'files\max_level.txt');
var slikei := LoadMaxLevel;
if slikei < num then begin
  Rewrite(f);
  writeln(f, inttostr(num));
  Close(f);
end;
end;
// возвращает максимальный уровень
function LoadMaxLevel():integer;
var F: TextFile;
begin
AssignFile(F, ExtractFilePath(ParamStr(0))+'files\max_level.txt');
Reset(f);
var s:='';
readln(f, s);
Close(F);
Result := strtoint(s);
end;
// создаёт файл для хранения уровня
procedure Createmaxlevel();
var F: TextFile;
begin
    if not FileExists(ExtractFilePath(ParamStr(0))+'files\max_level.txt') then begin
      AssignFile(F, ExtractFilePath(ParamStr(0))+'files\max_level.txt');
      Rewrite(F);
      writeln(F, '5');
      Close(F);
    end;
end;
// создаёт файлы для хранения данных лидерборда
procedure CreateLeaderBoard();
var F: TextFile;
var name:string;
begin
  for var i:= 5 to 9 do begin
    if not FileExists(ExtractFilePath(ParamStr(0))+'files\'+inttostr(i)+'leaderboard.txt') then begin
      AssignFile(F, ExtractFilePath(ParamStr(0))+'files\'+inttostr(i)+'leaderboard.txt');
      Rewrite(F);
      for var j:=1 to 20 do
        writeln(F, '00:00');
      Close(F);
    end;
  end;
end;
end.
