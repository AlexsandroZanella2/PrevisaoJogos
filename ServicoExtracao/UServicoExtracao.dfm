object ServicoExtracaoInicial: TServicoExtracaoInicial
  Left = 0
  Top = 0
  Caption = 'ServicoExtracaoInicial'
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
  object Button1: TButton
    Left = 95
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 80
    Width = 587
    Height = 314
    ActivePage = TabSheet3
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Paginas'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 579
        Height = 286
        Align = alClient
        Lines.Strings = (
          'Memo2')
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Registros'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 579
        Height = 286
        Align = alClient
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Teste'
      ImageIndex = 2
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 579
        Height = 286
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object BitBtn2: TBitBtn
    Left = 176
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Gerar Paginas'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 39
    Width = 162
    Height = 21
    TabOrder = 4
    TextHint = 'site'
  end
  object BitBtn3: TBitBtn
    Left = 176
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Teste'
    TabOrder = 5
    OnClick = BitBtn3Click
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
