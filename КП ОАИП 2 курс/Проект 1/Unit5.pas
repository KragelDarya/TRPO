unit Unit5;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, unit4, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;
type
  TForm5 = class(TForm)
    Memo1: TMemo;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Image7: TImage;
    Label7: TLabel;
    procedure LoadRes(num:integer);
    procedure FormActivate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form5: TForm5;
implementation
{$R *.dfm}
uses unit2;
//����� ����������
procedure TForm5.LoadRes(num:integer);
begin
  memo1.Clear;
  var leaderboard := LoadLeaderBoard(num);
  var sorted := SortStrings(leaderboard);
  for var i := 0 to sorted.Count-1 do
    if sorted[i] <> '00:00' then
      memo1.Lines.Add(sorted[i]);
  if memo1.Lines.count = 0 then
    memo1.Lines.Add('�������� ������� ����� ���������� ����������');
end;
//5X5
procedure TForm5.Image2Click(Sender: TObject);
begin
  LoadRes(5);
end;
procedure TForm5.Label1Click(Sender: TObject);
begin
  LoadRes(5);
end;
//6X6
procedure TForm5.Image3Click(Sender: TObject);
begin
  LoadRes(6);
end;
procedure TForm5.Label2Click(Sender: TObject);
begin
  LoadRes(6);
end;
//7X7
procedure TForm5.Image4Click(Sender: TObject);
begin
  LoadRes(7);
end;
procedure TForm5.Label3Click(Sender: TObject);
begin
  LoadRes(7);
end;
//8X8
procedure TForm5.Image5Click(Sender: TObject);
begin
  LoadRes(8);
end;
procedure TForm5.Label4Click(Sender: TObject);
begin
  LoadRes(8);
end;
//9X9
procedure TForm5.Image6Click(Sender: TObject);
begin
  LoadRes(9);
end;
procedure TForm5.Label5Click(Sender: TObject);
begin
  LoadRes(9);
end;
//���������
procedure TForm5.FormActivate(Sender: TObject);
begin
image1.Picture.LoadFromFile(unit2.backgroundPath);
end;
//�� �������
procedure TForm5.Image7Click(Sender: TObject);
begin
  form2.Visible := true;
  form5.visible:=false;
end;
procedure TForm5.Label7Click(Sender: TObject);
begin
  form2.Visible := true;
  form5.visible:=false;
end;
end.
