unit uDmConnection;

interface

uses
  Winapi.Messages, System.SysUtils, System.Classes, Data.DbxSqlite, Data.DB, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FMX.Dialogs;

type
  TdmConnection = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    fdqSearch: TFDQuery;
    fdtClient: TFDTable;
    fdtClientid: TFDAutoIncField;
    fdtClientname: TStringField;
    fdtClientaddress: TStringField;
    fdtClientnumber: TStringField;
    fdtClientdistrict: TStringField;
    fdtClientcity: TLargeintField;
    fdtClientstate: TStringField;
    fdtClientphone: TStringField;
    fdtCity: TFDTable;
    fdtState: TFDTable;
    fdtStateestado: TStringField;
    fdtStateuf: TStringField;
    fdtCityibge7: TLargeintField;
    fdtCityuf: TStringField;
    fdtCitymunicipio: TStringField;
    fdtStateibge: TLargeintField;
    fdtStateregiao: TStringField;
    fdtStateqtdmun: TIntegerField;
    fdtStatesintaxe: TStringField;
    fdtCityibge: TLargeintField;
    fdtCityregiao: TStringField;
    fdtCitypopulacao: TLargeintField;
    fdtCityporte: TStringField;
    fdtCitycapital: TStringField;
    fdqSearchid: TFDAutoIncField;
    fdqSearchname: TStringField;
    fdqSearchaddress: TStringField;
    fdqSearchnumber: TStringField;
    fdqSearchdistrict: TStringField;
    fdqSearchphone: TStringField;
    fdqSearchmunicipio: TStringField;
    fdqSearchuf_1: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure fdtClientBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConnection: TdmConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConnection.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.DriverName  :=  'SQLITE' ;
  FDConnection1.Params.Values[ 'Database' ] :=
    'C:\Clientes\dbClient.sdb';
  try
    FDConnection1.Open;
  except
    on E :  EDatabaseError  do
      ShowMessage( 'Exce��o gerada com mensagem  ' +  E.Message );
  end
end;

procedure TdmConnection.DataModuleDestroy(Sender: TObject);
begin
  FDConnection1.Close;
end;

procedure TdmConnection.fdtClientBeforePost(DataSet: TDataSet);
begin
  if ((length(Trim(DataSet.FieldByName('name').AsString)) < 3) and
     (length(Trim(DataSet.FieldByName('name').AsString)) > 200)) or
     (Trim(DataSet.FieldByName('name').AsString) = '') then
  begin

    DataSet.FieldByName('name').FocusControl;

    DatabaseError('Nome n�o deve ser menor que 3 ou maior que 200 caracter ou em branco');

  end;

  if (length(DataSet.FieldByName('address').AsString) < 3) and
     (length(DataSet.FieldByName('address').AsString) > 200) or
     (Trim(DataSet.FieldByName('address').AsString) = '') then
  begin

    DataSet.FieldByName('address').FocusControl;

    DatabaseError('Endere�o n�o deve ser menor que 3 ou maior que 200 caracter ou em branco, favor informar');

  end;

  if (length(DataSet.FieldByName('number').AsString) < 3) and
     (length(DataSet.FieldByName('number').AsString) > 50) or
     (Trim(DataSet.FieldByName('number').AsString) = '') then
  begin

    DataSet.FieldByName('number').FocusControl;

    DatabaseError('N�mero n�o deve ser menor que 3 ou maior que 200 caracter ou em branco, favor informar');

  end;

  if (length(DataSet.FieldByName('district').AsString) < 3) and
     (length(DataSet.FieldByName('district').AsString) > 50) or
     (Trim(DataSet.FieldByName('district').AsString) = '') then
  begin

    DataSet.FieldByName('district').FocusControl;

    DatabaseError('Bairro n�o deve ser menor que 3 ou maior que 200 caracter ou em branco, favor informar');

  end;

  if (DataSet.FieldByName('city').AsInteger <= 0) then
  begin

    DataSet.FieldByName('city').FocusControl;

    DatabaseError('Cidade deve ser informada.');

  end;

  if (length(DataSet.FieldByName('state').AsString) < 2 ) then
  begin

    DataSet.FieldByName('state').FocusControl;

    DatabaseError('Estado deve ser informado');

  end;

  if (length(DataSet.FieldByName('phone').AsString) < 9) or
     (Trim(DataSet.FieldByName('phone').AsString) = '') then
  begin

    DataSet.FieldByName('phone').FocusControl;

    DatabaseError(
      'Telefone n�o deve ser menor que 3 ou maior que 200 caracter ou em branco, favor informar');

  end;

end;

end.
