unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Threading,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Rest.Json,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type

{$M+}
  TMensagem = class(TObject)
  private
    FRemetente: string;
    FMensagem : string;
  published
    property Remetente: string read FRemetente write FRemetente;
    property Mensagem : string read FMensagem write FMensagem;
  end;
{$M-}

  TForm7 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    Label4: TLabel;
    Panel4: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Memo1: TMemo;
    Button2: TButton;
    Label5: TLabel;
    Edit2: TEdit;
    Button3: TButton;
    Label6: TLabel;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);

  const
    RAIZ_NOME_CANAL = 'TDC:2018:POA:NOTIFICA:';
  private
    { Private declarations }
    FConn    : IRedisClient;
    FTask    : ITask;
    FEncerrar: Boolean;
    function GetCanalAssinado: string;
    procedure IniciarAssinatura;
    procedure PublicarMensagem;
    function GetCanalPublicado: string;
    property CanalAssinado: string read GetCanalAssinado;
    property CanalPublicado: string read GetCanalPublicado;
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar(Application.ExeName), nil, nil, SW_SHOW);
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  Self.IniciarAssinatura;
  Self.Button2.Enabled := False;
  Self.Edit1.Enabled   := True;
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
  Self.PublicarMensagem;
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.FEncerrar := True;

  if Assigned(Self.FTask) then
  begin
    TTask.WaitForAll([Self.FTask]);
  end;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;

  Self.Memo1.Clear;
  Self.Label1.Caption := TForm7.RAIZ_NOME_CANAL;
  Self.FEncerrar      := False;
end;

function TForm7.GetCanalAssinado: string;
begin
  Result := Format('%s%s#', [TForm7.RAIZ_NOME_CANAL, Self.Edit1.Text]);
end;

function TForm7.GetCanalPublicado: string;
begin
  Result := Format('%s%s#', [TForm7.RAIZ_NOME_CANAL, Self.Edit2.Text]);
end;

procedure TForm7.IniciarAssinatura;
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
        [Self.CanalAssinado],

        // Método anônimo que trata a mensagem recebida
        procedure(ACanal: string; AMensagem: string)
        var
          oMensagem: TMensagem;
        begin
          oMensagem := TJson.JsonToObject<TMensagem>(AMensagem);
          try

            Memo1.Lines.Add(Format('%s - %s', [oMensagem.Remetente, oMensagem.Mensagem]));
          finally
            oMensagem.Free;
          end;
        end,

      // Método anônimo que que determinará a continuidade (True) ou o encerramento (False) do SUBSCRIBE
        function: Boolean
        begin
          Result := Assigned(Self) and not Self.FEncerrar;
        end,

      // Método anônimo a ser executado após a efetivação da assinatura
        procedure
        begin
          Self.Memo1.Lines.Add('Assinatura em andamento!')
        end); // oRedis.SUBSCRIBE                          fv

      // Encerra a conexão com o Redis
      oRedis.Disconnect;
    end) // Self.FTask := TTask.Run(
end;

procedure TForm7.PublicarMensagem;
var
  oMensagem: TMensagem;
  sMensagem: string;
begin
  oMensagem := TMensagem.Create;
  try
    oMensagem.Remetente := Self.Edit1.Text;
    oMensagem.Mensagem  := Self.Edit3.Text;

    sMensagem := TJson.ObjectToJsonString(oMensagem);

    Self.FConn.PUBLISH(Self.CanalPublicado, sMensagem);
    Self.Memo1.Lines.Add(Format('%s - %s', [oMensagem.Remetente, oMensagem.Mensagem]));

    Self.Edit3.Clear;
  finally
    oMensagem.Free;
  end;
end;

end.
