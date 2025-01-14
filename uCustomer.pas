unit uCustomer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, uDmConnection, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxMaskEdit, cxSpinEdit, cxDBEdit,
  cxTextEdit, cxDropDownEdit, cxCalendar, ViaCEP.Intf,
  ViaCEP.Core,
  ViaCEP.Model;

type
  TfrmCustomer = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsCustomer: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnExcluir: TBitBtn;
    RgTipoPessoa: TRadioGroup;
    Label8: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label10: TLabel;
    lblCpf: TLabel;
    lblRg: TLabel;
    Label14: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbeEndereco: TDBEdit;
    dbeNumero: TDBEdit;
    dbeBairro: TDBEdit;
    Label9: TLabel;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label11: TLabel;
    dbeCpfCnpj: TDBEdit;
    dbeCep: TDBEdit;
    dbeCidade: TDBEdit;
    dbeEstado: TDBEdit;
    dbePais: TDBEdit;
    dbeDataCadastro: TDBEdit;
    DBEdit3: TDBEdit;
    dbeCodigo: TDBEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExcluirClick(Sender: TObject);
    procedure RgTipoPessoaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCepExit(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCpfCnpjExit(Sender: TObject);
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

procedure TfrmCustomer.dbeCepExit(Sender: TObject);
var
  ViaCEP: IViaCEP;
  CEP: TViaCEPClass;
begin
  if Trim(dbeCep.Text) <> '' then
  begin
    ViaCEP := TViaCEP.Create;

    if ViaCEP.Validate(dbeCep.Text) then
    begin
      CEP := ViaCEP.Get(dbeCep.Text);
      if Assigned(CEP) then
      begin
        try
          dsCustomer.DataSet.FieldValues['address']  := CEP.Logradouro;
          dsCustomer.DataSet.FieldValues['district'] := CEP.Bairro;
          dsCustomer.DataSet.FieldValues['city']     := CEP.Localidade;
          dsCustomer.DataSet.FieldValues['state']    := CEP.UF;
        finally
          CEP.Free;
        end;
      end
      else
        messagedlg('Favor verificar, CEP n�o encontrado.', mtwarning, [mbok], 0);
    end
    else
    begin
      messagedlg('CEP inv�lido...!', mtwarning, [mbok], 0);
      if dsCustomer.DataSet.State in [dsInsert] then
        dsCustomer.DataSet.FieldByName('zip').Clear;
      dbeCep.SetFocus;
    end;
  end;
end;

procedure TfrmCustomer.DBEdit1Exit(Sender: TObject);
begin
  if trim(DBEdit1.Text) <> '' then
    dbeCep.SetFocus;
end;

procedure TfrmCustomer.dbeCpfCnpjExit(Sender: TObject);
begin
  if (trim(dbeCpfCnpj.Text) <> '') and (dsCustomer.DataSet.State in [dsInsert]) then
  begin
    if (dmConnection.ValidarCPF_CNPJ(dbeCpfCnpj.Text, RgTipoPessoa.ItemIndex, true ) = '') then
    begin
      if dmConnection.fdqSearch.Locate('cpf_cnpj',dbeCpfCnpj.Text,[loCaseInsensitive, loPartialKey]) then
      begin
        messagedlg('Aten��o! Cliente ' + dbeCpfCnpj.Text + ' j� cadastrado, por favor verificar.', mtWarning, [mbok], 0);
        dsCustomer.DataSet.FieldByName('cpf_cnpj').Clear;
        dbeCpfCnpj.SetFocus;
      end;
    end;

  end;
end;

procedure TfrmCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmConnection.fdtClient.Close;
end;

procedure TfrmCustomer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (dsCustomer.DataSet.State in [dsInsert, dsEdit]) and (canClose = True) then
  begin
    dbeCodigo.Visible := True;
    dsCustomer.DataSet.Cancel;
  end;
end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  dmConnection.fdtClient.Open;
end;

procedure TfrmCustomer.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCustomer.FormShow(Sender: TObject);
begin
  if dsCustomer.DataSet.FieldByName('type').AsString = 'F' then
  begin
    RgTipopessoa.ItemIndex := 0;
    lblCpf.Caption         := 'CPF';
    lblRg.Caption          := 'N� Identidade';
    dsCustomer.DataSet.FieldByName('cpf_cnpj').EditMask := '999.999.999\-99;0;_';
  end
  else
  begin
    RgTipopessoa.ItemIndex := 1;
    lblCpf.Caption         := 'CNPJ';
    lblRg.Caption          := 'Inscri��o Estadual';
    dsCustomer.DataSet.FieldByName('cpf_cnpj').EditMask := '99.999.999\/9999\-99;0;_';
  end;

  if (dsCustomer.DataSet.State in [dsInsert]) then
  begin
     dsCustomer.DataSet.FieldValues['data_cadastro'] := Date();
     dsCustomer.DataSet.FieldValues['ativo']         := True;
     dbeCodigo.Visible                               := False;

     RgTipoPessoa.SetFocus;
  end;
end;

procedure TfrmCustomer.RgTipoPessoaClick(Sender: TObject);
begin
  if rgTipoPessoa.ItemIndex = 0 then
  begin
    lblCpf.Caption         := 'CPF';
    lblRg.Caption          := 'N� Identidade';
    dsCustomer.DataSet.FieldByName('cpf_cnpj').EditMask := '999.999.999\-99;0;_';

    if (dsCustomer.DataSet.State in [dsInsert]) then
      dsCustomer.DataSet.FieldByName('type').AsString := 'F';
  end
  else
  begin
    lblCpf.Caption         := 'CNPJ';
    lblRg.Caption          := 'Inscri��o Estadual';
    dsCustomer.DataSet.FieldByName('cpf_cnpj').EditMask:= '99.999.999\/9999\-99;0;_';

    if (dsCustomer.DataSet.State in [dsInsert]) then
      dsCustomer.DataSet.FieldByName('type').AsString := 'J';
  end;

  dbeCpfCnpj.SetFocus;
end;

end.
