unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Imaging.pngimage,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values,
  Vcl.Samples.Spin

    ;

type
  TForm2 = class(TForm)
    pcExemplos: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Panel1: TPanel;
    edtChave: TEdit;
    Label1: TLabel;
    Image1: TImage;
    Memo1: TMemo;
    btnSetImage: TButton;
    btnSetText: TButton;
    Image2: TImage;
    btnGetImage: TButton;
    btnGetText: TButton;
    Memo2: TMemo;
    Button1: TButton;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    Button3: TButton;
    SpinEdit1: TSpinEdit;
    Label4: TLabel;
    Button4: TButton;
    Label5: TLabel;
    Memo3: TMemo;
    Panel2: TPanel;
    edtPadraoBusca: TEdit;
    Button6: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSetImageClick(Sender: TObject);
    procedure btnGetImageClick(Sender: TObject);
    procedure btnSetTextClick(Sender: TObject);
    procedure btnGetTextClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FConn: IRedisClient;
    function GetChave: string;
  public
    property Chave: string read GetChave;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnGetImageClick(Sender: TObject);
var
  oPNG   : TPngImage;
  oValue : TRedisString;
  oStream: TStringStream;
begin
  oStream := TStringStream.Create;
  oPNG    := TPngImage.Create;

  try
    Self.Image2.Picture := nil;

    oValue := Self.FConn.GET(Self.Chave);

    if oValue.IsNull then
    begin
      Exit;
    end;

    oStream.WriteString(oValue.Value);
    oStream.Seek(0, 0);

    oPNG.LoadFromStream(oStream);

    Self.Image2.Picture.Assign(oPNG);
  finally
    oStream.Free;
    oPNG.Free;
  end;
end;

procedure TForm2.btnGetTextClick(Sender: TObject);
var
  oValue: TRedisString;
begin
  oValue := Self.FConn.GET(Self.Chave);
  if not oValue.IsNull then
  begin
    Self.Memo2.Text := oValue.Value;
  end else begin
    Self.Memo2.Text := '[ NULO ]';
  end;
end;

procedure TForm2.btnSetImageClick(Sender: TObject);
var
  oImage: TStringStream;
begin
  oImage := TStringStream.Create;

  try
    Self.Image1.Picture.SaveToStream(oImage);
    oImage.Seek(0, 0);
    Self.FConn.&SET(Self.Chave, oImage.DataString);
  finally
    oImage.Free;
  end;
end;

procedure TForm2.btnSetTextClick(Sender: TObject);
begin
  Self.FConn.&SET(Self.Chave, Self.Memo1.Text);
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  iCount: Integer;
begin
  iCount              := Self.FConn.DEL([Self.Chave]);
  Self.Label2.Caption := Format('%d registros afetados', [iCount]);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  bRet: Boolean;
begin
  bRet := Self.FConn.EXISTS(Self.Chave);

  if bRet then
  begin
    Self.Label3.Caption    := 'A CHAVE EXISTE!';
    Self.Label3.Font.Color := clBlue;
  end else begin
    Self.Label3.Caption    := 'A *NÃO* CHAVE EXISTE!';
    Self.Label3.Font.Color := clRed;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  bRet: Boolean;
begin
  bRet := Self.FConn.EXPIRE(Self.Chave, Self.SpinEdit1.Value);
  if bRet then
  begin
    Self.Label4.Caption    := 'TEMPO DE EXPIRAÇÃO DEFINIDO COM SUCESSO';
    Self.Label4.Font.Color := clBlue;
  end else begin
    Self.Label4.Caption    := 'A CHAVE NÃO EXISTE';
    Self.Label4.Font.Color := clRed;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  iTempoRestante: Integer;
begin
  iTempoRestante := Self.FConn.TTL(Self.Chave);

  case iTempoRestante of
    - 2:
      begin
        Self.Label5.Caption    := 'A CHAVE NÃO EXISTE';
        Self.Label5.Font.Color := clRed;
      end;
    -1:
      begin
        Self.Label5.Caption    := 'A CHAVE NÃO ESTA COM TEMPO DE EXPIRAÇÃO';
        Self.Label5.Font.Color := clRed;
      end;
  else
    Self.Label5.Caption    := Format('FALTAM %d SEGUNDOS PARA A CHAVE SUMIR', [iTempoRestante]);
    Self.Label5.Font.Color := clBlue;
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar(Application.ExeName), nil, nil, SW_SHOW);
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  oChaves: TRedisArray;
  sChave : string;
begin
  oChaves := Self.FConn.KEYS(Self.edtPadraoBusca.Text);

  Self.Memo3.Clear;

  if not oChaves.IsNull then
  begin
    for sChave in oChaves.Value do
    begin
      Self.Memo3.Lines.Add(sChave);
    end;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.pcExemplos.ActivePageIndex := 0;

  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;
end;

function TForm2.GetChave: string;
begin
  Result := Self.edtChave.Text;
end;

end.
