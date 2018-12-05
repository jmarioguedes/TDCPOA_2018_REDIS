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

  REST.JSON,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type

  TExemplo = class
  private
    FPID  : Cardinal;
    FNome : string;
    FIdade: ShortInt;
    FFrase: string;
  published
    property PID  : Cardinal read FPID write FPID;
    property Nome : string read FNome write FNome;
    property Idade: ShortInt read FIdade write FIdade;
    property Frase: string read FFrase write FFrase;
  end;

  TForm5 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Label2: TLabel;
    Timer1: TTimer;
    Button3: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure TForm5.Button3Click(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar(Application.ExeName), nil, nil, SW_SHOW);
end;

procedure TForm5.EnfileirarComando;
var
  oExemplo     : TExemplo;
  sConteudoJSON: string;
begin
  oExemplo := TExemplo.Create;

  try
    oExemplo.PID   := Self.FPID;
    oExemplo.Nome  := Self.LabeledEdit2.Text;
    oExemplo.Idade := StrToInt(Self.LabeledEdit3.Text);
    oExemplo.Frase := Self.LabeledEdit4.Text;

    sConteudoJSON := TJson.ObjectToJsonString(oExemplo);

    Self.FConn.RPUSH(Self.NomeDaFila, [sConteudoJSON]);
  finally
    oExemplo.Free;
  end;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  Self.FPID := GetCurrentProcessID;

  Self.LabeledEdit1.Text := Self.FPID.ToString;

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
