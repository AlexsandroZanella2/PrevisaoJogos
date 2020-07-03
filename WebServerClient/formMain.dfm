object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'RestClientApp'
  ClientHeight = 436
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 274
    Top = 290
    Width = 145
    Height = 13
    Caption = 'Lista de alunos (dados brutos)'
  end
  object Label2: TLabel
    Left = 274
    Top = 23
    Width = 47
    Height = 13
    Caption = 'Response'
  end
  object Label3: TLabel
    Left = 274
    Top = 143
    Width = 169
    Height = 13
    Caption = 'Lista de alunos (dados formatados)'
  end
  object btnPut: TButton
    Left = 48
    Top = 154
    Width = 75
    Height = 25
    Caption = 'Put'
    TabOrder = 0
    OnClick = btnPutClick
  end
  object btnGet: TButton
    Left = 48
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 1
    OnClick = btnGetClick
  end
  object btnPost: TButton
    Left = 152
    Top = 154
    Width = 75
    Height = 25
    Caption = 'Post'
    TabOrder = 2
    OnClick = btnPostClick
  end
  object btnDelete: TButton
    Left = 152
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object Memo1: TMemo
    Left = 274
    Top = 309
    Width = 343
    Height = 92
    TabOrder = 4
  end
  object Memo2: TMemo
    Left = 274
    Top = 42
    Width = 343
    Height = 89
    TabOrder = 5
  end
  object DBGrid1: TDBGrid
    Left = 274
    Top = 162
    Width = 343
    Height = 119
    DataSource = DataSource1
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    AutoCreateParams = False
    BaseURL = 'http://localhost:8080/GetListaAlunos'
    Params = <>
    HandleRedirects = True
    Left = 16
    Top = 255
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 168
    Top = 255
  end
  object RESTResponse1: TRESTResponse
    Left = 88
    Top = 255
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 16
    Top = 384
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse2
    Left = 120
    Top = 384
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 216
    Top = 384
  end
  object RESTResponse2: TRESTResponse
    RootElement = 'Alunos'
    Left = 88
    Top = 319
  end
  object RESTClient2: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    AutoCreateParams = False
    BaseURL = 'http://localhost:8080/GetListaAlunos'
    Params = <>
    HandleRedirects = True
    Left = 16
    Top = 319
  end
  object RESTRequest2: TRESTRequest
    Client = RESTClient2
    Params = <>
    Response = RESTResponse2
    SynchronizedEvents = False
    Left = 176
    Top = 319
  end
end
