object FControl: TFControl
  Left = 0
  Top = 0
  Caption = 'Painel de Controle'
  ClientHeight = 440
  ClientWidth = 655
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
    Width = 655
    Height = 440
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 700
    ExplicitHeight = 449
    object TabSheet1: TTabSheet
      Caption = 'Clientes'
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 105
        Height = 412
        Align = alLeft
        TabOrder = 0
        ExplicitHeight = 401
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
        Width = 536
        Height = 412
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 1
        ExplicitWidth = 619
        ExplicitHeight = 427
        object PageControl2: TPageControl
          Left = 2
          Top = 56
          Width = 532
          Height = 354
          ActivePage = TabSheet4
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          object TabSheet4: TTabSheet
            Caption = '&Pesquisar'
            ExplicitWidth = 281
            ExplicitHeight = 165
            object GroupBox2: TGroupBox
              Left = 0
              Top = 0
              Width = 524
              Height = 326
              Align = alClient
              TabOrder = 0
              ExplicitLeft = -6
              ExplicitWidth = 569
              ExplicitHeight = 321
              object wwDBGrid1: TwwDBGrid
                Left = 2
                Top = 15
                Width = 520
                Height = 309
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
                ExplicitLeft = 56
                ExplicitTop = 40
                ExplicitWidth = 320
                ExplicitHeight = 120
              end
            end
          end
          object TabSheet5: TTabSheet
            Caption = '&Dados'
            ImageIndex = 1
            ExplicitWidth = 281
            ExplicitHeight = 165
          end
          object TabSheet6: TTabSheet
            Caption = '&Hist'#243'rico de Pagamentos'
            ImageIndex = 2
            ExplicitWidth = 281
            ExplicitHeight = 165
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Jogos e Previs'#245'es'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
    end
    object TabSheet3: TTabSheet
      Caption = 'Links de pagamento'
      ImageIndex = 2
      ExplicitWidth = 281
      ExplicitHeight = 165
    end
  end
end
