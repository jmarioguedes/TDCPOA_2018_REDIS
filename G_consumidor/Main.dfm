object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'TDC POA - 2018 | Enfileiramento - CONSUMIDOR'
  ClientHeight = 583
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 27
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 595
    Height = 105
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 780
    object Label1: TLabel
      Left = 16
      Top = 15
      Width = 132
      Height = 27
      Caption = 'Nome da fila:'
    end
    object Edit1: TEdit
      Left = 16
      Top = 48
      Width = 425
      Height = 35
      TabOrder = 0
      Text = 'TDC:2018:POA:QUEUE:EXEMPLO#'
    end
    object Button1: TButton
      Left = 456
      Top = 47
      Width = 121
      Height = 36
      Caption = 'PR'#211'XIMO'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 161
    Width = 595
    Height = 417
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 120
    ExplicitWidth = 780
    ExplicitHeight = 375
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 48
      Width = 121
      Height = 35
      EditLabel.Width = 156
      EditLabel.Height = 27
      EditLabel.Caption = 'PID do produtor'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 16
      Top = 136
      Width = 561
      Height = 35
      EditLabel.Width = 57
      EditLabel.Height = 27
      EditLabel.Caption = 'Nome'
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 16
      Top = 224
      Width = 121
      Height = 35
      EditLabel.Width = 56
      EditLabel.Height = 27
      EditLabel.Caption = 'Idade'
      TabOrder = 2
    end
    object LabeledEdit4: TLabeledEdit
      Left = 16
      Top = 312
      Width = 553
      Height = 35
      EditLabel.Width = 53
      EditLabel.Height = 27
      EditLabel.Caption = 'Frase'
      TabOrder = 3
    end
    object Button2: TButton
      Left = 400
      Top = 353
      Width = 169
      Height = 49
      Caption = '"DAR BAIXA"'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 115
    Width = 605
    Height = 41
    Align = alTop
    Caption = '** CONSUMIDOR **'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 5
    ExplicitWidth = 790
  end
end
