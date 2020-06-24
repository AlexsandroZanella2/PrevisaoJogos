object FControl: TFControl
  Left = 0
  Top = 0
  Caption = 'Painel de Controle'
  ClientHeight = 447
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 660
    Height = 447
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 655
    ExplicitHeight = 440
    object TabSheet1: TTabSheet
      Caption = 'Clientes'
      ExplicitWidth = 647
      ExplicitHeight = 412
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 105
        Height = 419
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 412
        object btnNovo: TBitBtn
          Left = 8
          Top = 8
          Width = 89
          Height = 25
          Caption = '&Novo'
          TabOrder = 0
        end
        object BitBtn2: TBitBtn
          Left = 8
          Top = 39
          Width = 89
          Height = 25
          Caption = '&Excluir'
          TabOrder = 1
        end
        object BitBtn3: TBitBtn
          Left = 8
          Top = 70
          Width = 89
          Height = 25
          Caption = '&Alterar'
          TabOrder = 2
        end
        object BitBtn1: TBitBtn
          Left = 8
          Top = 101
          Width = 89
          Height = 25
          Caption = '&Liberar Acesso'
          TabOrder = 3
        end
      end
      object GroupBox1: TGroupBox
        Left = 111
        Top = 0
        Width = 541
        Height = 419
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        ExplicitWidth = 536
        ExplicitHeight = 412
        object PageControl2: TPageControl
          Left = 2
          Top = 56
          Width = 537
          Height = 361
          ActivePage = TabSheet4
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          ExplicitWidth = 532
          ExplicitHeight = 354
          object TabSheet4: TTabSheet
            Caption = '&Pesquisar'
            ExplicitWidth = 524
            ExplicitHeight = 326
            object GroupBox2: TGroupBox
              Left = 0
              Top = 0
              Width = 529
              Height = 333
              Align = alClient
              TabOrder = 0
              ExplicitWidth = 524
              ExplicitHeight = 326
              object wwDBGrid1: TwwDBGrid
                Left = 2
                Top = 15
                Width = 525
                Height = 316
                IniAttributes.Delimiter = ';;'
                IniAttributes.UnicodeIniFile = False
                TitleColor = clBtnFace
                FixedCols = 0
                ShowHorzScrollBar = True
                Align = alClient
                TabOrder = 0
                TitleAlignment = taLeftJustify
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'Tahoma'
                TitleFont.Style = []
                TitleLines = 1
                TitleButtons = False
                ExplicitWidth = 520
                ExplicitHeight = 309
              end
            end
          end
          object TabSheet5: TTabSheet
            Caption = '&Dados'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 281
            ExplicitHeight = 165
          end
          object TabSheet6: TTabSheet
            Caption = '&Hist'#243'rico de Pagamentos'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 281
            ExplicitHeight = 165
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Jogos e Previs'#245'es'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
    end
    object TabSheet3: TTabSheet
      Caption = 'Links de pagamento'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
    end
  end
end
