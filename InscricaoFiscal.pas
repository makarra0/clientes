unit InscricaoFiscal;

interface

uses
  System.SysUtils;

type

  /// <summary>
  /// Classe base para validação da inscrição fiscal: CPF e CNPJ
  /// </summary>
  TInscricaoFiscal = class abstract(TObject)
  public
    function DocumentoValido(const ADocumento: string): Boolean; virtual; abstract;
  end;

  TCNPJ = class(TInscricaoFiscal)
  public
    function DocumentoValido(const ADocumento: string): Boolean; override;
  end;

  TCPF = class(TInscricaoFiscal)
  public
    function DocumentoValido(const ADocumento: string): Boolean; override;
  end;

implementation

{ TCNPJ }

function TCNPJ.DocumentoValido(const ADocumento: string): Boolean;
var
  CNPJCalc: string;
  SomaCNPJ, CNPJDigit: Integer;
  I: Byte;
begin
  try
    CNPJCalc:= Copy(ADocumento, 1, 12);
    SomaCNPJ:= 0;
    for I:= 1 to 4 do
      SomaCNPJ:= SomaCNPJ + StrToInt(Copy(CNPJCalc, I, 1)) * (6 - I);
    for I:= 1 to 8 do
      SomaCNPJ:= SomaCNPJ + StrToInt(Copy(CNPJCalc, I + 4, 1)) * (10 - I);
    CNPJDigit:= 11 - SomaCNPJ mod 11;
    if CNPJDigit in [10, 11] then
      CNPJCalc:= CNPJCalc + '0'
    else
      CNPJCalc:= CNPJCalc + IntToStr(CNPJDigit);
    SomaCNPJ:= 0;
    for I:= 1 to 5 do
      SomaCNPJ:= SomaCNPJ + StrToInt(Copy(CNPJCalc, I, 1)) * (7 - I);
    for I:= 1 to 8 do
      SomaCNPJ:= SomaCNPJ + StrToInt(Copy(CNPJCalc, I + 5, 1)) * (10 - I);
    CNPJDigit:= 11 - SomaCNPJ mod 11;
    if CNPJDigit in [10, 11] then
      CNPJCalc:= CNPJCalc + '0'
    else
      CNPJCalc:= CNPJCalc + IntToStr(CNPJDigit);
    Result:= (ADocumento = CNPJCalc);
  except
    Result:= False;
  end;
end;

{ TCPF }

function TCPF.DocumentoValido(const ADocumento: string): Boolean;
var
  CPFCalc : string;
  SomaCPF, CPFDigit: Integer;
  I: Byte;
begin
  try
    CPFCalc:= Copy(ADocumento, 1, 9);
    SomaCPF:= 0;
    for I:= 1 to 9 do
      SomaCPF:= SomaCPF + StrToInt(Copy(CPFCalc, I, 1)) * (11 - I);
    CPFDigit:= 11 - SomaCPF mod 11;
    if CPFDigit in [10, 11] then
      CPFCalc:= CPFCalc + '0'
    else
      CPFCalc:= CPFCalc + IntToStr(CPFDigit);
    SomaCPF:= 0;
    for I:= 1 to 10 do
      SomaCPF:= SomaCPF + StrToInt(Copy(CPFCalc, I, 1)) * (12 - I);
    CPFDigit:= 11 - SomaCPF mod 11;
    if CPFDigit in [10, 11] then
      CPFCalc:= CPFCalc + '0'
    else
      CPFCalc:= CPFCalc + IntToStr(CPFDigit);
    Result:= (ADocumento = CPFCalc);
  except
    Result:= false;
  end;
end;

end.
