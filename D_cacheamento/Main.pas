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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageJSON,
  Vcl.StdCtrls,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values

    ;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Memo1: TMemo;
    Button2: TButton;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FConn: IRedisClient;
    procedure TotalizarPorUF;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
  Self.TotalizarPorUF;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  ShellExecute(0, PChar('open'), PChar(Application.ExeName), nil, nil, SW_SHOW);
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  Self.Memo1.Clear;
  Self.FDConnection1.Open;
  Self.FConn := TRedisClient.Create('localhost', 6379);
  Self.FConn.Connect;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
  if Self.CheckBox1.Enabled then
  begin
    Self.Timer1.Enabled := False;

    Self.TotalizarPorUF;

    Self.Timer1.Enabled := True;
  end;
end;

procedure TForm4.TotalizarPorUF;
const
  CHAVE     = 'TDC:POA:2018:VENDAS:UF#';
  SETE_DIAS = 60 * 60 * 24 * 7;
var
  cInicio: Cardinal;
  oDados : TRedisString;
  oStream: TStringStream;
  sOrigem: string;
begin
  cInicio := GetTickCount;
  oStream := TStringStream.Create;

  try
    Self.FDQuery1.Close;

    oDados := Self.FConn.GET(CHAVE);

    if oDados.HasValue then
    begin
      sOrigem := 'REDIS';
      oStream.WriteString(oDados);
      oStream.Seek(0, 0);
      Self.FDQuery1.LoadFromStream(oStream, sfJSON);
      Self.FConn.EXPIRE(CHAVE, SETE_DIAS)
    end else begin
      sOrigem := 'RDBMS';
      Self.FDQuery1.Open;
      Self.FDQuery1.SaveToStream(oStream, sfJSON);
      oStream.Seek(0, 0);
      Self.FConn.&SET(CHAVE, oStream.DataString, SETE_DIAS)
    end;
  finally
    oStream.Free;
    Self.Memo1.Lines.Add(Format('%s: %g segundos', [sOrigem, (GetTickCount - cInicio) / 1000]));
  end;
end;

end.
