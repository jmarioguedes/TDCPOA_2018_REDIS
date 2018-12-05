unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,

  REST.JSON,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type

  TExemplo = class
    PID: Integer;
    Nome: string;
    Idade: Integer;
    Frase: string;
  end;

  TForm5 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Label2: TLabel;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FPID : Cardinal;
    FConn: IRedisClient;
    function GetNomeDaFila: string;
    procedure EnfileirarComando;
  public
    { Public declarations }
    property NomeDaFila: string read GetNomeDaFila;
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
begin
  Self.EnfileirarComando;
end;

procedure TForm5.EnfileirarComando;
var
  oExemplo     : TExemplo;
  sConteudoJSON: string;
begin
  oExemplo := TExemplo.Create;

  try
    oExemplo.PID   := GetCurrentProcessID;
    oExemplo.Idade := 41;
    oExemplo.Nome  := 'JOSÉ MARIO SILVA GUEDES';
    oExemplo.Frase := 'O RATO ROEU A ROUPA DO REI DE ROMA';

    sConteudoJSON := TJson.ObjectToJsonString(oExemplo);

    Self.FConn.RPUSH(Self.NomeDaFila, [sConteudoJSON]);
  finally
    oExemplo.Free;
  end;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  Self.FPID := GetCurrentProcessID;

  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;

  Self.Timer1.Enabled := True;
end;

function TForm5.GetNomeDaFila: string;
begin
  Result := Self.Edit1.Text;
end;

procedure TForm5.Timer1Timer(Sender: TObject);
var
  iQuantidade: Integer;
begin
  iQuantidade := Self.FConn.LLEN(Self.NomeDaFila);

  Self.Label2.Caption := Format('%d elementos na fila', [iQuantidade]);
end;

end.
