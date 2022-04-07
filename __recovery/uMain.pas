unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmConnection, Data.DB, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, uCustomer, ComObj;

type
  TfrmClient = class(TForm)
    dsClient: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Panel2: TPanel;
    Label1: TLabel;
    edtSearch: TEdit;
    cmbSearch: TComboBox;
    SpeedButton7: TSpeedButton;
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure cmbSearchChange(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure edtSearchEnter(Sender: TObject);
    procedure DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClient: TfrmClient;

implementation

{$R *.dfm}


procedure TfrmClient.cmbSearchChange(Sender: TObject);
begin
  edtSearch.ReadOnly := (cmbSearch.ItemIndex = 0);
end;

procedure TfrmClient.DBGrid1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCustomer, frmCustomer);

  with frmCustomer do
  begin
    dmConnection.fdtClient.Filter := 'id = ' + QuotedStr(IntToStr(dmConnection.fdqSearch.FieldByName('id').AsInteger));
    dmConnection.fdtClient.Filtered := True;
    if dmConnection.fdtClient.Active then
    begin
      dsCustomer.DataSet.Edit;
    end;

    btnExcluir.Visible := True;
    ShowModal;
    dmConnection.fdtClient.Filtered := False;
    dsClient.DataSet.Refresh;
    btnExcluir.Visible := False;
    Free;

  end;
end;

procedure TfrmClient.DBGrid1DrawDataCell(Sender: TObject; const Rect: TRect;
  Field: TField; State: TGridDrawState);
begin
  if Length(dsClient.DataSet.FieldByName('cpf_cnpj').AsString) = 14 then
    dsClient.DataSet.FieldByName('cpf_cnpj').EditMask := '99.999.999\/9999\-99;0;_'
  else
    dsClient.DataSet.FieldByName('cpf_cnpj').EditMask := '999.999.999\-99;0;_';
end;

procedure TfrmClient.edtSearchEnter(Sender: TObject);
begin
  if edtSearch.Text <> '' then
    edtSearch.Clear;
end;

procedure TfrmClient.FormActivate(Sender: TObject);
begin
  if dmConnection.fdqSearch.Active then
    dmConnection.fdqSearch.Close;

  dmConnection.fdqSearch.Open;

  cmbSearch.SetFocus;
end;

procedure TfrmClient.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCustomer, frmCustomer);

  with frmCustomer do
  begin
    if dmConnection.fdtClient.Active then
    begin
      dsCustomer.DataSet.Insert;
    end;

    ShowModal;
    dsClient.DataSet.Refresh;
    Free;
  end;
end;

procedure TfrmClient.SpeedButton4Click(Sender: TObject);
var
  linha, coluna : integer;
  planilha : variant;
  valorcampo : string;
begin

  planilha:= CreateoleObject('Excel.Application');
  planilha.caption := 'Relação de Clientes';
  planilha.visible := true;
  planilha.WorkBooks.add(1);

  dsClient.DataSet.First;

  for linha := 0 to dsClient.DataSet.RecordCount - 1 do
  begin
    for coluna := 1 to dsClient.DataSet.FieldCount do
    begin
      valorcampo := dsClient.DataSet.Fields[coluna - 1].AsString;
      planilha.cells[linha + 2,coluna] := valorCampo;
    end;
    dsClient.DataSet.Next;
  end;

  for coluna := 1 to dsClient.DataSet.FieldCount do
  begin
    valorcampo := dsClient.DataSet.Fields[coluna - 1].DisplayLabel;
    planilha.cells[1,coluna] := valorcampo;
  end;

  planilha.columns.Autofit;
end;

procedure TfrmClient.SpeedButton6Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmClient.SpeedButton7Click(Sender: TObject);
begin
  case cmbSearch.ItemIndex of
    0: begin
      dsClient.DataSet.Filter   := '';
      dsClient.DataSet.Filtered := False;
      edtSearch.Clear;
    end;
    1: begin
      dsClient.DataSet.Filtered := False;
      dsClient.DataSet.Filter   := 'upper(name) LIKE ' + QuotedStr( '%' + uppercase(Trim(edtSearch.Text)) + '%' );
      dsClient.DataSet.Filtered := True;
    end;
    2: begin
      dsClient.DataSet.Filtered := False;
      dsClient.DataSet.Filter   := 'upper(name) LIKE ' + QuotedStr( '%' + uppercase(Trim(edtSearch.Text)) + '%' ) +
                                    ' and ativo = true';
      dsClient.DataSet.Filtered := True;
    end;
    3: begin
      dsClient.DataSet.Filtered := False;
      dsClient.DataSet.Filter   := 'upper(name) LIKE ' + QuotedStr( '%' + uppercase(Trim(edtSearch.Text)) + '%' ) +
                                    ' and ativo = false';
      dsClient.DataSet.Filtered := True;
    end;
  end;
end;

end.
