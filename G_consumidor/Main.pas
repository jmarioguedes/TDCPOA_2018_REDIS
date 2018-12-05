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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  REST.Json,

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

  TForm6 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Panel2: TPanel;
    Button1: TButton;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    Button2: TButton;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FConn: IRedisClient;
    procedure RecuperarProximoItem;
    function GetNomeDaChave: string;
    procedure LimparControles;
  public
    { Public declarations }
    property NomeDaChave: string read GetNomeDaChave;
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}
{ TForm6 }

procedure TForm6.Button1Click(Sender: TObject);
begin
  Self.LimparControles;
  Self.RecuperarProximoItem;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Self.LimparControles;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;
end;

function TForm6.GetNomeDaChave: string;
begin
  Result := Self.Edit1.Text;
end;

procedure TForm6.LimparControles;
begin
  Self.LabeledEdit1.Clear;
  Self.LabeledEdit2.Clear;
  Self.LabeledEdit3.Clear;
  Self.LabeledEdit4.Clear;

  Application.ProcessMessages;
end;

procedure TForm6.RecuperarProximoItem;
var
  oValue   : TRedisArray;
  sConteudo: string;
  oExemplo : TExemplo;
begin
  oValue := Self.FConn.BLPOP([Self.NomeDaChave], 10);

  if oValue.HasValue then
  begin
    sConteudo := oValue.Value[1].Value;
    oExemplo  := TJson.JsonToObject<TExemplo>(sConteudo);

    Self.LabeledEdit1.Text := oExemplo.PID.ToString;
    Self.LabeledEdit2.Text := oExemplo.Nome;
    Self.LabeledEdit3.Text := oExemplo.Idade.ToString;
    Self.LabeledEdit4.Text := oExemplo.Frase;

  end else begin
    MessageBox(Self.Handle, 'Não há elementos na fila', 'Atenção!', MB_OK);
  end;

end;

end.
