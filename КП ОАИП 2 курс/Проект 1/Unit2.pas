unit Unit2;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.MPlayer, Vcl.Menus, unit5, Vcl.Imaging.pngimage, ShellAPI;
type
  TForm2 = class(TForm)
    ComboBox1: TComboBox;
    Image1: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Image2: TImage;
    Label2: TLabel;
    Image3: TImage;
    Label3: TLabel;
    Image4: TImage;
    Label4: TLabel;
    Image5: TImage;
    Label5: TLabel;
    ComboBox2: TComboBox;
    MediaPlayer1: TMediaPlayer;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure CreateParams(var params:TcreateParams); override;
    procedure Image2Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var lvlnum: Integer;
  end;
const
nazv='Развиваем внимательность';
var
  Form2: TForm2;
  backgroundPath:string;
  acttimes:integer;
implementation
{$R *.dfm}
uses unit3, unit1;
// открытие формы со статистикой
procedure TForm2.Image4Click(Sender: TObject);
begin
Form2.Visible:=False;
Form5.Visible:=True;
end;
// открытие формы со статистикой
procedure TForm2.Label4Click(Sender: TObject);
begin
Form2.Visible:=False;
Form5.Visible:=True;
end;
//ВЫБОР ФОНА
procedure TForm2.ComboBox1Change(Sender: TObject);
begin
backgroundPath := ExtractFilePath(ParamStr(0))+'files/f' + inttostr(ComboBox1.ItemIndex+1) + '.bmp';
image1.Picture.LoadFromFile(backgroundPath);
end;
// установка заднего фона и прочих значений по умолчанию
procedure TForm2.FormCreate(Sender: TObject);
begin
acttimes := 0;
backgroundPath := ExtractFilePath(ParamStr(0))+'files/f1.bmp';
image1.Picture.LoadFromFile(backgroundPath);
form2.Caption:=nazv;
end;
//показать ПРАВИЛА
procedure TForm2.Image2Click(Sender: TObject);
var
  f: textfile;
  tf: TStringList;
begin
  tf := TStringList.Create;
  tf.LoadFromFile(ExtractFilePath(ParamStr(0))+'files/rules.txt'); // указываете путь к файлу с текстом
  MessageBox(0, PChar(tf.Text), 'Правила', MB_OK); // выводим текст из TStringList
end;
//показать ПРАВИЛА
procedure TForm2.Label2Click(Sender: TObject);
var
  f: textfile;
  tf: TStringList;
begin
  tf := TStringList.Create;
  tf.LoadFromFile(ExtractFilePath(ParamStr(0))+'files/rules.txt'); // указываете путь к файлу с текстом
  MessageBox(0, PChar(tf.Text), 'Правила', MB_OK); // выводим текст из TStringList
end;
//показать ПРАВИЛА
procedure TForm2.N2Click(Sender: TObject);
var
  f: textfile;
  tf: TStringList;
begin
  tf := TStringList.Create;
  tf.LoadFromFile(ExtractFilePath(ParamStr(0))+'files/rules.txt'); // указываете путь к файлу с текстом
  MessageBox(0, PChar(tf.Text), 'Правила', MB_OK); // выводим текст из TStringList
end;
//ВЫБОР МУЗЫКИ
procedure TForm2.ComboBox2Change(Sender: TObject);
begin
case ComboBox2.ItemIndex of
1: begin
MediaPlayer1.FileName := 'files/dinamic1.mp3';
MediaPlayer1.Open;
MediaPlayer1.Play;
end;
0: begin
MediaPlayer1.FileName := 'files/dinamic2.mp3';
MediaPlayer1.Open;
MediaPlayer1.Play;
end;
2: begin
MediaPlayer1.FileName := 'files/calm1.mp3';
MediaPlayer1.Open;
MediaPlayer1.Play;
end;
4: begin
MediaPlayer1.FileName := 'files/calm2.mp3';
MediaPlayer1.Open;
MediaPlayer1.Play;
end;
3:begin
MediaPlayer1.FileName := 'files/zvuki-gitary.mp3';
MediaPlayer1.Open;
MediaPlayer1.Play;
end;
end;
end;
// создание иконки приложения в панели инструментов
procedure TForm2.CreateParams(var params:TcreateParams);
begin
  inherited CreateParams(params);
  Params.ExStyle := params.ExStyle or WS_EX_APPWINDOW;
  params.WndParent := GetDesktopWindow;
end;
//ВЫХОД
procedure TForm2.N3Click(Sender: TObject);
begin
form1.Close;
end;
// вывод справки
procedure TForm2.N4Click(Sender: TObject);
begin
  ShellExecute(0, PChar('Open'),PChar(ExtractFilePath(ParamStr(0))+'files/справка.chm'),nil,nil,SW_SHOW);
end;
//ВЫХОД
procedure TForm2.Label5Click(Sender: TObject);
begin
form1.Close;
end;
//ВЫХОД
procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.Close;
end;
//ВЫХОД
procedure TForm2.Image5Click(Sender: TObject);
begin
form1.Close;
end;
//АКТИВАЦИЯ
procedure TForm2.FormActivate(Sender: TObject);
begin
if acttimes <=0 then begin
acttimes := acttimes + 1;
MediaPlayer1.FileName := 'files/dinamic2.mp3';
MediaPlayer1.Open;
MediaPlayer1.Play;
end;
end;
//ИГРАТЬ
procedure TForm2.Image3Click(Sender: TObject);
begin
form2.Visible := false;
form3.Visible:=true;
end;
//ИГРАТЬ
procedure TForm2.Label3Click(Sender: TObject);
begin
form2.Visible := false;
form3.Visible:=true;
end;
//ИГРАТЬ
procedure TForm2.N1Click(Sender: TObject);
begin
form2.Visible := false;
form3.Visible:=true;
end;
end.
