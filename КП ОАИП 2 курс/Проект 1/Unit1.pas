unit Unit1;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Unit2, unit4;
type
  TForm1 = class(TForm)
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    Image1: TImage;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
nazv='��������� ��������������';
var
  Form1: TForm1;
implementation
{$R *.dfm}
// �������� ������ � �������� �� ���������
procedure TForm1.FormCreate(Sender: TObject);
begin
Createmaxlevel;
CreateLeaderBoard;
form1.Caption:=nazv;
end;
// ���������� �������� � �������� ������� ����� �� � ���������
procedure TForm1.Timer1Timer(Sender: TObject);
begin
if ProgressBar1.Position < ProgressBar1.Max then
ProgressBar1.Position:=ProgressBar1.Position+7
else begin Timer1.Enabled:=False;
form2.show;
form1.hide;
end;
end;
end.
