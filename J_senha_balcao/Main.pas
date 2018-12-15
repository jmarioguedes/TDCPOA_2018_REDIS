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
  Vcl.Samples.Spin,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type
  TForm9 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FConn: IRedisClient;
    procedure RecuperarProximo;
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.Button1Click(Sender: TObject);
begin
  Self.RecuperarProximo;
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;
end;

procedure TForm9.RecuperarProximo;
var
  oProximo : TRedisArray;
  sMensagem: string;
  sBalcao  : string;
  sSenha   : string;
begin
  Self.Label2.Caption := 'Buscando ...';
  Application.ProcessMessages;

  oProximo := Self.FConn.BLPOP(['TDC:POA:2018:SENHA:FILA#'], 10);
  if oProximo.HasValue then
  begin
    Self.Label2.Caption := oProximo.Value[1].Value;
    Application.ProcessMessages;

    sBalcao := Self.SpinEdit1.Value.ToString;
    sSenha  := oProximo.Value[1].Value;

    sMensagem := Format('%s|%s', [sBalcao, sSenha]);
    Self.FConn.PUBLISH('TDC:POA:2018:SENHA:PUBSUB#', sMensagem);
  end else begin
    Self.Label2.Caption := 'NINGUÉM';
    Application.ProcessMessages;
  end;

end;

end.
