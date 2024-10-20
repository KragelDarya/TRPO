unit Unit3;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, shellapi,
  Vcl.Buttons, Vcl.Grids, Vcl.Menus, Vcl.Imaging.pngimage, DateUtils, unit4;
type
  TForm3 = class(TForm)
    Image1: TImage;
    lblTime: TLabel;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    ccGreen: TCheckBox;
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Image2: TImage;
    Label1: TLabel;
    Image3: TImage;
    Label2: TLabel;
    Image4: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure StartTimer();
    procedure SetDesItems();
    procedure CreateParams(var params:TcreateParams); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ccGreenClick(Sender: TObject);
    procedure RepaintGreen();
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
        Bitmap: TBitmap;
    procedure Prepare(n: integer);
    procedure SetNumbers;
  public
    { Public declarations }
  end;
const
  nazv='��������� ��������������';
  max_n=9;   //����. ������ ����
type TStatusCell=(scWhite, scGreen);//������ ������ - �� �������/�������
type TGameStatus=(STOP, PLAY);//������ ���� - �����������/��������
type TCell= Record
  num: integer;// - ����� � ������
  StatusCell: TStatusCell
end;
var
  Form3: TForm3;
  //����� ����� �� ����:
  AllNumbers: integer;
  //������� ����� �� ����:
  ReadyNumbers: integer;
  //������, � ������� �������� ���������� � ����:
  masPole: array[0..max_n, 0..max_n] of TCell;
  //
  time,time0, stopTime, starttime: TDateTime;
  lastTimeLikeStr : string;
  //������������� ����� �����:
  switch: integer= 1;
  //������ ����:
  GameStatus: TGameStatus= STOP;
  lvlnum:integer;
implementation
{$R *.dfm}
uses unit2, unit1;
//�������� ������ ��˨��� ������
procedure TForm3.RepaintGreen();
begin
  if ccGreen.Checked then begin
    StringGrid1.Repaint;
    StringGrid1.Invalidate;
    label4.Caption := inttostr(ReadyNumbers+1);
    label4.Visible := true;
    label5.Visible := true;
  end
  else
  begin
    label4.Visible := false;
    label5.Visible := false;
  end;
end;
procedure TForm3.ccGreenClick(Sender: TObject);
begin
  RepaintGreen();
end; //�������������
//����� ������
procedure TForm3.ComboBox1Change(Sender: TObject);
begin
label4.Caption := '1';
lvlnum:=(ComboBox1.ItemIndex+5);
if LoadMaxLevel	>= lvlnum then
  Prepare(lvlnum);
GameStatus:= PLAY;
RepaintGreen();
end; //����� ������
//���������� ��������� � ����������� ������ � ComboBox
procedure TForm3.SetDesItems();
begin
  for var i := 0 to ComboBox1.GetCount-1 do begin
  if i+5 > LoadMaxLevel then
  ComboBox1.Items[i] := ComboBox1.Items[i][1] + ' ����������'
  else
  ComboBox1.Items[i] := ComboBox1.Items[i][1] + 'x' + ComboBox1.Items[i][1];
end;
end;
//��������� �����
procedure TForm3.FormActivate(Sender: TObject);
begin
lvlnum:=(ComboBox1.ItemIndex+6);
RepaintGreen;
SetDesItems();
GameStatus := Play;
label4.Visible := False;
label4.Caption := '1';
time0:=Now;
time := Now - Now;
image1.Picture.LoadFromFile(unit2.backgroundPath);
form3.Caption:=nazv;
StartTimer;
Prepare(5);
end;
//��������
procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form2.Show;
end;
//�������� ������ ���������� � ������ ������������
procedure TForm3.CreateParams(var params:TcreateParams);
begin
  inherited CreateParams(params);
  Params.ExStyle := params.ExStyle or WS_EX_APPWINDOW;
  params.WndParent := GetDesktopWindow;
end;
//���������� �����
procedure TForm3.FormDestroy(Sender: TObject);
begin
  Bitmap.Free;
  Timer1.Enabled:= False;
end;
//������� �� ������� �����
procedure TForm3.Image2Click(Sender: TObject);
begin
  form2.Visible := true;
  form3.visible:=false;
  ccGreen.Checked := false;
end;
procedure TForm3.Label1Click(Sender: TObject);
begin
  form2.Visible := true;
  form3.visible:=false;
  ccGreen.Checked := false;
end;
procedure TForm3.N1Click(Sender: TObject);
begin
  form2.Visible := true;
  form3.visible:=false;
  ccGreen.Checked := false;
end;
 //����������
 procedure TForm3.Image3Click(Sender: TObject);
begin
  //��������� ������:
  stopTime := now;
  Timer1.Enabled:= False;
  GameStatus:= STOP;
end;
procedure TForm3.Label2Click(Sender: TObject);
begin
  //��������� ������:
  stopTime := now;
  Timer1.Enabled:= False;
  GameStatus:= STOP;
end;
//�����
procedure TForm3.N2Click(Sender: TObject);
begin
  form1.close;
end;
//�������
procedure TForm3.N3Click(Sender: TObject);
var
  f: textfile;
  tf: TStringList;
begin
  tf := TStringList.Create;
  tf.LoadFromFile(ExtractFilePath(ParamStr(0))+'files/rules.txt'); // ���������� ���� � ����� � �������
  MessageBox(0, PChar(tf.Text), '�������', MB_OK); // ������� ����� �� TStringList
end;
// ����� �������
 procedure TForm3.N4Click(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'),PChar(ExtractFilePath(ParamStr(0))+ 'files/�������.chm'),nil,nil,SW_SHOW);
end;
//����������
procedure TForm3.Image4Click(Sender: TObject);
begin
  if GameStatus= PLAY then exit;
  GameStatus:= PLAY;
  //�������� ������:
  Timer1.Enabled:= True;
  //������ ����� ������ ������������:
  time0 := time0 + now - stoptime - 1;
  StartTimer();
end;
procedure TForm3.Label3Click(Sender: TObject);
begin
  if GameStatus= PLAY then exit;
  GameStatus:= PLAY;
  //�������� ������:
  Timer1.Enabled:= True;
  //������ ����� ������ ������������:
  time0 := time0 + now - stoptime - 1;
  StartTimer();
end;
//������
procedure TForm3.StartTimer();
begin
if GameStatus= PLAY then exit;
  GameStatus:= PLAY;
  //�������� ������:
  Timer1.Enabled:= True;
end;
//��������� � ����
procedure TForm3.Prepare(n: integer);
var
  w, h, lw: integer;
begin
  //������ ������ � ��������:
  timer1.Enabled := true;
  label3.Enabled := true;
  image4.Enabled := true;
  label2.Enabled := true;
  image3.Enabled := true;
  time0 := now;
  time := now;
  stopTime := now;
  w:= StringGrid1.DefaultColWidth;
  h:= StringGrid1.DefaultRowHeight;
  //������� �����:
  lw:= StringGrid1.GridLineWidth;
  //������� �������� ���� � �������:
  StringGrid1.ColCount:= n;
  StringGrid1.RowCount:= StringGrid1.ColCount;
  //������� �������� ���� � ��������:
  StringGrid1.Width:= 11 + (w + lw)* n;
  StringGrid1.Height:= 11 + (h + lw)* n;
  StringGrid1.Left:= (ClientWidth-StringGrid1.Width) div 2;
  StringGrid1.Top:= (ClientHeight-StringGrid1.Height) div 2;
  //����� ����� �� ����:
  AllNumbers:= n * n;
  //�� ���� ����� �� �������:
  ReadyNumbers:= 0;
  //���������� ����� � �����
  SetNumbers;
  caption:= nazv;
  switch:= 1;
  StringGrid1.Invalidate;
end;
 //���������� ������ �������� ����
procedure TForm3.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  sNum: string;
  n: integer;
begin
  //���� ������: �����, ���� ����� ��� �� �������,
  //������ - ���� ������� � ��������� �������� ������
  if masPole[ACol, ARow].StatusCell= scWhite then
    StringGrid1.Canvas.Brush.Color:= clWhite
  else
    if ccGreen.Checked then StringGrid1.Canvas.Brush.Color:= RGB(0,255,0);
  StringGrid1.Canvas.FillRect(Rect);
  //������� ����� � ������ (ACol, ARow) ��������������� ������:
  n:= masPole[ACol, ARow].num;
  StringGrid1.Canvas.Font.Size:= 21;
  StringGrid1.Canvas.Font.Style:= StringGrid1.Font.Style+ [fsBold];
  StringGrid1.Canvas.Font.Color:= clBlack;
  sNum:= inttostr(n);
  with Rect, StringGrid1.Canvas do
    textrect(Rect, left+(right-left-textwidth(sNum)) div 2,
             top+(bottom-top-textheight(sNum)) div 2, sNum);
end;
//������� �����
procedure TForm3.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol,ARow: integer;
  n: integer;
begin
  if GameStatus<> PLAY then exit; //- ��� ������!
  //���������� ����:
  StringGrid1.MouseToCell(x,y,ACol,ARow);
  //����� � ������:
  n:= masPole[ACol,ARow].num;
  if (n <> succ(ReadyNumbers)) then //- �� ��������� �����!
    MessageBeep(MB_ICONASTERISK)
    else begin
      masPole[ACol,ARow].StatusCell:= scGreen;
      //����� ��� ���� �����:
      inc(ReadyNumbers);
      if ReadyNumbers < allnumbers then
        label4.Caption := inttostr(ReadyNumbers+1)
    end;
end;
//������ � ��������
procedure TForm3.Timer1Timer(Sender: TObject);
var
  s,p: string;
  min, sec: string;
  i, j: integer;
  flg: boolean;
begin
  if (time0 <> 0) then begin
  //����� ����:
  time:=(now-time0);
  sec:= inttostr(SecondOf(time));
  min:= inttostr(MinuteOf(time));

  if MinuteOf(time) > 59 then begin
    Timer1.Enabled:= False;
    s:= '���� ����� �����������!'#13#10'���������� �����';
    GameStatus:= STOP;
    Application.MessageBox(pChar(s), nazv, IDOK);
    exit
  end;
  if strtoint(sec) < 10 then sec:= '0' + sec;
  if strtoint(min) < 10 then min:= '0' + min;
  //�� ������ �� ������?
  if ReadyNumbers	>= allNumbers then begin
    image4.Enabled := false;
    label3.Enabled := false;
    label2.Enabled := false;
    image3.Enabled := false;
    sec := inttostr(strtoint(sec) - 1);
    GameStatus:= STOP;
    Timer1.Enabled:= False;
    SaveLevel(lvlnum+1);
    SaveTimeInLeaderBoard(lastTimeLikeStr, lvlnum);
    SetDesItems();
    p:= '�����������!'#13#10'�� ���������� � ��������! '#13#10''+'���� �����   '+ lasttimelikestr+''#13#10'��� ������ ���������: ' + GetBestResult(lvlnum);
    MessageBox(Application.Handle, pChar(p), nazv, MB_OK);
  end;
  end;
    lblTime.caption:= '���� �����   ' + min + ':' + sec;
    lasttimelikestr := min + ':' + sec;
end;
//���������� �����
procedure TForm3.SetNumbers;
var
  i, j, n, m: integer;
  iMas: array[1..max_n * max_n] of boolean;
  flg: boolean;
begin
  //"����������" �����:
  Randomize;
  //������ ����:
  m:= StringGrid1.ColCount;
  //�� ���� ����� �� ���������� � �����:
  for i:= 1 to max_n * max_n do iMas[i]:= false;
  //����������� �����:
    for j:= 0 to m-1 do  begin
      for i:= 0 to m-1 do begin
        flg:= false; //- ����� �� �������
        repeat
          //��������� �����:
         n:= Random(AllNumbers)+ 1;
          if iMas[n]= false then begin //- ������ ����� �� ����
            iMas[n]:= True;        //- ����� �����
            masPole[i, j].num:= n; //- ������� ��� � ������
            flg:= True;            //- ����� �������
            //�����a �� �������:
            masPole[i, j].StatusCell:= scWhite;
          end;
        until flg= True; //���������, ���� �� ����� ������� �����
      end;
    end;
  end;//SetNumbers
end.
