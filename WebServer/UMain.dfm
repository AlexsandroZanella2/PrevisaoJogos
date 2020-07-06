object frm_Main: Tfrm_Main
  Left = 0
  Top = 0
  Caption = 'WebServer'
  ClientHeight = 351
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object txtinfolabel: TLabel
    Left = 0
    Top = 338
    Width = 492
    Height = 13
    Align = alBottom
    Alignment = taCenter
    Caption = 'Porta 8080'
    ExplicitWidth = 53
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 91
    Height = 13
    Caption = 'Log de Requisi'#231#245'es'
  end
  object Label3: TLabel
    Left = 8
    Top = 195
    Width = 85
    Height = 13
    Caption = 'Log de Respostas'
  end
  object btnAtivar: TBitBtn
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Ativar'
    TabOrder = 0
    OnClick = btnAtivarClick
  end
  object btnParar: TBitBtn
    Left = 89
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Desativar'
    TabOrder = 1
    OnClick = btnPararClick
  end
  object memoResp: TMemo
    Left = 8
    Top = 214
    Width = 473
    Height = 116
    TabOrder = 2
    OnChange = memoRespChange
  end
  object memoReq: TMemo
    Left = 8
    Top = 70
    Width = 473
    Height = 116
    TabOrder = 3
    OnChange = memoReqChange
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 8080
    OnCommandOther = IdHTTPServer1CommandOther
    OnCommandGet = IdHTTPServer1CommandGet
    Left = 216
    Top = 104
  end
  object TrayIcon1: TTrayIcon
    OnClick = TrayIcon1Click
    Left = 296
    Top = 104
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 128
    Top = 104
  end
  object pFIBQuery1: TpFIBQuery
    Left = 320
    Top = 40
    qoAutoCommit = True
  end
end
