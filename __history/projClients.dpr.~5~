program projClients;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmClient},
  uDmConnection in 'uDmConnection.pas' {dmConnection: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  uCustomer in 'uCustomer.pas' {frmCustomer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Customers';
  TStyleManager.TrySetStyle('Light');
  Application.CreateForm(TfrmClient, frmClient);
  Application.CreateForm(TdmConnection, dmConnection);
  Application.Run;
end.
