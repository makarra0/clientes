object dmConnection: TdmConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 171
  Width = 274
  object FDConnection1: TFDConnection
    ConnectionName = 'C:\Clientes\dbCliente.sdb'
    Params.Strings = (
      'Database=C:\Clientes\dbClient.sdb'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    DriverID = 'SQLite'
    VendorHome = 'C:\Clientes'
    VendorLib = 'C:\Clientes\sqlite3.dll'
    Left = 160
    Top = 40
  end
  object fdqSearch: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM clientes cl'
      '      INNER JOIN cidades cd ON (cd.ibge7 = cl.city)'
      '      INNER JOIN estados es ON (es.uf = cd.uf)')
    Left = 24
    Top = 104
    object fdqSearchid: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqSearchname: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 100
      FieldName = 'name'
      Origin = 'name'
      Size = 200
    end
    object fdqSearchaddress: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 100
      FieldName = 'address'
      Origin = 'address'
      Size = 200
    end
    object fdqSearchnumber: TStringField
      DisplayLabel = 'N'#250'mero'
      DisplayWidth = 20
      FieldName = 'number'
      Origin = 'number'
      Size = 50
    end
    object fdqSearchdistrict: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'district'
      Origin = 'district'
      Size = 100
    end
    object fdqSearchphone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'phone'
      Origin = 'phone'
      EditMask = '!\(99\) 0 0000-0000;0; '
    end
    object fdqSearchmunicipio: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Munic'#237'pio'
      DisplayWidth = 100
      FieldName = 'municipio'
      Origin = 'municipio'
      ProviderFlags = []
      ReadOnly = True
      Size = 200
    end
    object fdqSearchuf_1: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Estado'
      FieldName = 'uf_1'
      Origin = 'uf'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
  end
  object fdtClient: TFDTable
    BeforePost = fdtClientBeforePost
    IndexFieldNames = 'id'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'clientes'
    TableName = 'clientes'
    Left = 88
    Top = 104
    object fdtClientid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdtClientname: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 80
      FieldName = 'name'
      Origin = 'name'
      Size = 200
    end
    object fdtClientaddress: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 80
      FieldName = 'address'
      Origin = 'address'
      Size = 200
    end
    object fdtClientnumber: TStringField
      DisplayLabel = 'N'#250'mero'
      DisplayWidth = 10
      FieldName = 'number'
      Origin = 'number'
      Size = 50
    end
    object fdtClientdistrict: TStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 60
      FieldName = 'district'
      Origin = 'district'
      Size = 100
    end
    object fdtClientcity: TLargeintField
      DisplayLabel = 'Cidade'
      FieldName = 'city'
      Origin = 'city'
    end
    object fdtClientstate: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'state'
      Origin = 'state'
      FixedChar = True
      Size = 2
    end
    object fdtClientphone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'phone'
      Origin = 'phone'
      EditMask = '!\(99\) 0 0000-0000;0;_'
    end
  end
  object fdtCity: TFDTable
    IndexFieldNames = 'uf'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'cidades'
    TableName = 'cidades'
    Left = 144
    Top = 104
    object fdtCityibge7: TLargeintField
      FieldName = 'ibge7'
      Origin = 'ibge7'
    end
    object fdtCityuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object fdtCitymunicipio: TStringField
      FieldName = 'municipio'
      Origin = 'municipio'
      Size = 200
    end
    object fdtCityibge: TLargeintField
      FieldName = 'ibge'
      Origin = 'ibge'
    end
    object fdtCityregiao: TStringField
      FieldName = 'regiao'
      Origin = 'regiao'
      Size = 100
    end
    object fdtCitypopulacao: TLargeintField
      FieldName = 'populacao'
      Origin = 'populacao'
    end
    object fdtCityporte: TStringField
      FieldName = 'porte'
      Origin = 'porte'
      Size = 100
    end
    object fdtCitycapital: TStringField
      FieldName = 'capital'
      Origin = 'capital'
      Size = 100
    end
  end
  object fdtState: TFDTable
    IndexFieldNames = 'uf'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'estados'
    TableName = 'estados'
    Left = 192
    Top = 104
    object fdtStateestado: TStringField
      FieldName = 'estado'
      Origin = 'estado'
      Size = 200
    end
    object fdtStateuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object fdtStateibge: TLargeintField
      FieldName = 'ibge'
      Origin = 'ibge'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object fdtStateregiao: TStringField
      FieldName = 'regiao'
      Origin = 'regiao'
      Size = 100
    end
    object fdtStateqtdmun: TIntegerField
      FieldName = 'qtdmun'
      Origin = 'qtdmun'
    end
    object fdtStatesintaxe: TStringField
      FieldName = 'sintaxe'
      Origin = 'sintaxe'
      Size = 50
    end
  end
end
