unit uCustomer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, uDmConnection, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TfrmCustomer = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsCustomer: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    dsState: TDataSource;
    DBLookupComboBox2: TDBLookupComboBox;
    dsCity: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnExcluir: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBLookupComboBox2Enter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomer: TfrmCustomer;

implementation

{$R *.dfm}

procedure TfrmCustomer.BitBtn1Click(Sender: TObject);
begin
  if dsCustomer.DataSet.State in [dsInsert, dsEdit] then
    dsCustomer.DataSet.Post;
  Close;
end;

procedure TfrmCustomer.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmCustomer.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir o cliente?', 'Exclus�o Cliente' , MB_ICONQUESTION+MB_YESNO+MB_APPLMODAL+MB_DEFBUTTON2) = 6 then
    dsCustomer.DataSet.Delete;
  Close;
end;

procedure TfrmCustomer.DBLookupComboBox2Enter(Sender: TObject);
begin
  if DBLookupComboBox1.KeyValue <> '' then
  begin
    dmConnection.fdtCity.Filtered := False;
    dmConnection.fdtCity.Filter := 'uf = ' + QuotedStr(DBLookupComboBox1.KeyValue);
    dmConnection.fdtCity.Filtered := True;
  end;
end;

procedure TfrmCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmConnection.fdtState.Close;
  dmConnection.fdtCity.Close;
  dmConnection.fdtClient.Close;
end;

procedure TfrmCustomer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (dsCustomer.DataSet.State in [dsInsert, dsEdit]) and (canClose = True) then
    dsCustomer.DataSet.Cancel;
end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  dmConnection.fdtState.Open;
  dmConnection.fdtCity.Open;
  dmConnection.fdtClient.Open;
end;

end.
