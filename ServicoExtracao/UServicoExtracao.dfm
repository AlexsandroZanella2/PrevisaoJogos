object ServicoExtracao: TServicoExtracao
  Left = 0
  Top = 0
  Caption = 'ServicoExtracao'
  ClientHeight = 394
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 8
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Extracao Inicial'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 104
    Width = 587
    Height = 290
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    ExplicitWidth = 455
    ExplicitHeight = 295
  end
  object Button1: TButton
    Left = 95
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 2
  end
  object DataBase: TpFIBDatabase
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA')
    DefaultTransaction = Transacao
    SQLDialect = 3
    Timeout = 0
    GeneratorsCache.UseGeneratorCache = forGeneratorList
    WaitForRestoreConnect = 0
    Left = 400
    Top = 56
  end
  object DataSet: TpFIBDataSet
    Transaction = Transacao
    Database = DataBase
    Left = 344
    Top = 56
  end
  object Transacao: TpFIBTransaction
    DefaultDatabase = DataBase
    Left = 448
    Top = 56
  end
  object DataSource: TDataSource
    DataSet = DataSet
    Left = 272
    Top = 56
  end
end
