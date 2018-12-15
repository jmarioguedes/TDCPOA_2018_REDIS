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
  System.Threading,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTask: ITask;
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.FormCreate(Sender: TObject);
begin
  Self.FTask := TTask.Run(
    procedure
    var
      oRedis: IRedisClient;
    begin
      // Conexão exclusiva com o Redis
      oRedis := TRedisClient.Create('localhost', 6379);
      oRedis.Connect;

      // Inicia a assinatura dos canais (Só retorna quando encerrar a assinatura)
      oRedis.SUBSCRIBE(
        // Lista de canais sendo assinados
        ['TDC:POA:2018:SENHA:PUBSUB#'],

        // Método anônimo que trata a mensagem recebida
        procedure(ACanal: string; AMensagem: string)
        var
          iSeparador: Integer;
          sBalcao: string;
          sSenha: string;
        begin
          iSeparador := Pos('|', AMensagem);
          sBalcao := Copy(AMensagem, 0, iSeparador - 1);
          sSenha := Copy(AMensagem, iSeparador + 1, MaxInt);

          Self.Label2.Caption := 'BALCÃO ' + sBalcao;
          Self.Label3.Caption := 'SENHA ' + sSenha;
        end

        ); // oRedis.SUBSCRIBE

      // Encerra a conexão com o Redis
      oRedis.Disconnect;
    end) // Self.FTask := TTask.Run(
end;

end.
