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

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type
  TForm8 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FConn: IRedisClient;
    procedure ProximaSenha;
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
begin
  Self.ProximaSenha;
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;
end;

procedure TForm8.ProximaSenha;
var
  iNext: NativeInt;
begin
  iNext := Self.FConn.INCR('TDC:POA:2018:SENHA:CONTROLE');
  Self.FConn.RPUSH('TDC:POA:2018:SENHA:FILA', [iNext.ToString]);
  Self.Label2.Caption := iNext.ToString;
end;

end.
