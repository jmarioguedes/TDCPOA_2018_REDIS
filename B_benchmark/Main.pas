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
  Vcl.Samples.Spin,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type

  TBenchmark = class(TThread)
  private
    FMaxValue: Integer;
    FConn    : IRedisClient;

    procedure CriarChaves;
    procedure RecuperarChaves;
    procedure DeletarChaves;

    procedure Log(const AEtapa: string; const ATime: Extended);

  public
    constructor Create(const MaxValue: Integer); reintroduce;
    procedure Execute; override;
  end;

  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FBenchmark: TBenchmark;
    procedure QuandoTerminar(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
{ TBenchmark }

constructor TBenchmark.Create(const MaxValue: Integer);
begin
  inherited Create(True);
  Self.FMaxValue := MaxValue;
  Self.FConn     := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Self.Memo1.Lines.Add('----------------------------------------------------');
  Self.Memo1.Lines.Add(Format('Manipulando %d chaves', [Self.SpinEdit1.Value]));

  Self.FBenchmark                 := TBenchmark.Create(Self.SpinEdit1.Value);
  Self.FBenchmark.FreeOnTerminate := True;
  Self.FBenchmark.OnTerminate     := Self.QuandoTerminar;
  Self.FBenchmark.Start;

  Self.Button1.Enabled := False;
end;

procedure TBenchmark.CriarChaves;
var
  cInit  : Cardinal;
  i      : Integer;
  sChave : string;
  sValue : string;
  sNumber: string;
begin
  cInit := GetTickCount;

  for i := 1 to Self.FMaxValue do
  begin
    sNumber := FormatFloat('00000', i);
    sChave  := Format('TDC:POA:BENCHMARK:%s#', [sNumber]);
    sValue  := Format('Conteúdo da chave #%d', [i]);

    Self.FConn.&SET(sChave, sValue);
  end;

  Self.Log('CriarChaves', (GetTickCount() - cInit) / 1000);
end;

procedure TBenchmark.DeletarChaves;
var
  i      : Integer;
  sNumber: string;
  sChave : string;
  cInit  : Cardinal;
begin
  cInit := GetTickCount;

  for i := 1 to Self.FMaxValue do
  begin
    sNumber := FormatFloat('00000', i);
    sChave  := Format('TDC:POA:BENCHMARK:%s#', [sNumber]);

    Self.FConn.DEL([sChave]);
  end;

  Self.Log('DeletarChaves', (GetTickCount() - cInit) / 1000);
end;

procedure TBenchmark.Execute;
begin
  inherited;

  Self.CriarChaves();
  Self.RecuperarChaves();
  Self.DeletarChaves();
end;

procedure TBenchmark.Log(const AEtapa: string; const ATime: Extended);
begin
  Self.Queue(
    procedure
    begin
      Form3.Memo1.Lines.Add(Format('%s - %f segundos', [AEtapa, ATime]));
    end);
end;

procedure TBenchmark.RecuperarChaves;
var
  i      : Integer;
  sNumber: string;
  sChave : string;
  sValue : string;
  oValue : TRedisString;
  cInit  : Cardinal;
begin
  cInit := GetTickCount;

  for i := 1 to Self.FMaxValue do
  begin
    sNumber := FormatFloat('00000', i);
    sChave  := Format('TDC:POA:BENCHMARK:%s#', [sNumber]);
    sValue  := Format('Conteúdo da chave #%d', [i]);

    oValue := Self.FConn.GET(sChave);
    if (oValue.IsNull) or (oValue.Value <> sValue) then
    begin
      raise Exception.Create('Não retornou o valor esperado');
    end;
  end;

  Self.Log('RecuperarChaves', (GetTickCount() - cInit) / 1000);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar(Application.ExeName), nil, nil, SW_SHOW);
end;

procedure TForm3.QuandoTerminar(Sender: TObject);
begin
  Self.Button1.Enabled := True;
  ShowMessage('Fim do processamento!');
end;

end.
