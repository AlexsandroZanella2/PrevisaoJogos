object Service13: TService13
  OldCreateOrder = False
  OnCreate = ServiceCreate
  DisplayName = 'Service13'
  Height = 241
  Width = 339
  object database: TpFIBDatabase
    DBName = 'localhost:C:\ServicoExtracao\DADOS.FDB'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA')
    DefaultTransaction = transacao
    SQLDialect = 3
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 96
    Top = 8
  end
  object transacao: TpFIBTransaction
    DefaultDatabase = database
    Left = 24
    Top = 128
  end
  object query: TpFIBQuery
    Transaction = transacao
    Database = database
    Left = 24
    Top = 72
    qoAutoCommit = True
  end
  object dataset: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from JOGOS_TENISMESA')
    Transaction = transSelect
    Database = database
    Left = 152
    Top = 72
    object datasetCODIGO: TFIBIntegerField
      FieldName = 'CODIGO'
    end
    object datasetDATA_JOGO: TFIBDateTimeField
      FieldName = 'DATA_JOGO'
      DisplayFormat = 'dd.mm.yyyy hh:nn'
    end
    object datasetJOGADOR1: TFIBStringField
      FieldName = 'JOGADOR1'
      Size = 50
      EmptyStrToNull = True
    end
    object datasetJOGADOR2: TFIBStringField
      FieldName = 'JOGADOR2'
      Size = 50
      EmptyStrToNull = True
    end
    object datasetRESULTADO1: TFIBIntegerField
      FieldName = 'RESULTADO1'
    end
    object datasetRESULTADO2: TFIBIntegerField
      FieldName = 'RESULTADO2'
    end
    object datasetNOME_COMPETICAO: TFIBStringField
      FieldName = 'NOME_COMPETICAO'
      Size = 100
      EmptyStrToNull = True
    end
    object datasetLINK: TFIBStringField
      FieldName = 'LINK'
      Size = 8
      EmptyStrToNull = True
    end
    object datasetTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object datasetPROB1: TFIBIntegerField
      FieldName = 'PROB1'
    end
    object datasetPROB2: TFIBIntegerField
      FieldName = 'PROB2'
    end
    object datasetSET_1: TFIBIntegerField
      FieldName = 'SET_1'
    end
    object datasetSET_1_: TFIBIntegerField
      FieldName = 'SET_1_'
    end
    object datasetSET_2: TFIBIntegerField
      FieldName = 'SET_2'
    end
    object datasetSET_2_: TFIBIntegerField
      FieldName = 'SET_2_'
    end
    object datasetSET_3: TFIBIntegerField
      FieldName = 'SET_3'
    end
    object datasetSET_3_: TFIBIntegerField
      FieldName = 'SET_3_'
    end
    object datasetSET_4: TFIBIntegerField
      FieldName = 'SET_4'
    end
    object datasetSET_4_: TFIBIntegerField
      FieldName = 'SET_4_'
    end
    object datasetSET_5: TFIBIntegerField
      FieldName = 'SET_5'
    end
    object datasetSET_5_: TFIBIntegerField
      FieldName = 'SET_5_'
    end
  end
  object transSelect: TpFIBTransaction
    DefaultDatabase = database
    Left = 152
    Top = 128
  end
  object Aux: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from JOGOS_TENISMESA')
    Transaction = transAux
    Database = database
    Left = 280
    Top = 64
    object FIBIntegerField1: TFIBIntegerField
      FieldName = 'CODIGO'
    end
    object FIBDateTimeField1: TFIBDateTimeField
      FieldName = 'DATA_JOGO'
      DisplayFormat = 'dd.mm.yyyy hh:nn'
    end
    object FIBStringField1: TFIBStringField
      FieldName = 'JOGADOR1'
      Size = 50
      EmptyStrToNull = True
    end
    object FIBStringField2: TFIBStringField
      FieldName = 'JOGADOR2'
      Size = 50
      EmptyStrToNull = True
    end
    object FIBIntegerField2: TFIBIntegerField
      FieldName = 'RESULTADO1'
    end
    object FIBIntegerField3: TFIBIntegerField
      FieldName = 'RESULTADO2'
    end
    object FIBStringField3: TFIBStringField
      FieldName = 'NOME_COMPETICAO'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField4: TFIBStringField
      FieldName = 'LINK'
      Size = 8
      EmptyStrToNull = True
    end
    object FIBStringField5: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object FIBIntegerField4: TFIBIntegerField
      FieldName = 'PROB1'
    end
    object FIBIntegerField5: TFIBIntegerField
      FieldName = 'PROB2'
    end
    object FIBIntegerField6: TFIBIntegerField
      FieldName = 'SET_1'
    end
    object FIBIntegerField7: TFIBIntegerField
      FieldName = 'SET_1_'
    end
    object FIBIntegerField8: TFIBIntegerField
      FieldName = 'SET_2'
    end
    object FIBIntegerField9: TFIBIntegerField
      FieldName = 'SET_2_'
    end
    object FIBIntegerField10: TFIBIntegerField
      FieldName = 'SET_3'
    end
    object FIBIntegerField11: TFIBIntegerField
      FieldName = 'SET_3_'
    end
    object FIBIntegerField12: TFIBIntegerField
      FieldName = 'SET_4'
    end
    object FIBIntegerField13: TFIBIntegerField
      FieldName = 'SET_4_'
    end
    object FIBIntegerField14: TFIBIntegerField
      FieldName = 'SET_5'
    end
    object FIBIntegerField15: TFIBIntegerField
      FieldName = 'SET_5_'
    end
  end
  object transAux: TpFIBTransaction
    DefaultDatabase = database
    Left = 280
    Top = 128
  end
end
