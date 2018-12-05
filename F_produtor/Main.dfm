object Form5: TForm5
  Left = 0
  Top = 0
  ActiveControl = Edit1
  Caption = 'TDC POA - 2018 | Enfileiramento - PRODUTOR'
  ClientHeight = 618
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 27
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 542
    Height = 108
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 132
      Height = 27
      Caption = 'Nome da fila:'
    end
    object Edit1: TEdit
      Left = 8
      Top = 64
      Width = 521
      Height = 35
      TabOrder = 0
      Text = 'TDC:2018:POA:QUEUE:EXEMPLO#'
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 164
    Width = 542
    Height = 449
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 123
    ExplicitHeight = 459
    object Label2: TLabel
      Left = 19
      Top = 10
      Width = 66
      Height = 28
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 19
      Top = 384
      Width = 145
      Height = 49
      Caption = 'ENFILEIRAR'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 336
      Top = 384
      Width = 193
      Height = 49
      Caption = 'NOVA INST'#194'NCIA'
      TabOrder = 1
      OnClick = Button3Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 19
      Top = 104
      Width = 121
      Height = 35
      EditLabel.Width = 35
      EditLabel.Height = 27
      EditLabel.Caption = 'PID'
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
    end
    object LabeledEdit2: TLabeledEdit
      Left = 19
      Top = 178
      Width = 510
      Height = 35
      EditLabel.Width = 57
      EditLabel.Height = 27
      EditLabel.Caption = 'Nome'
      TabOrder = 3
    end
    object LabeledEdit3: TLabeledEdit
      Left = 19
      Top = 253
      Width = 121
      Height = 35
      EditLabel.Width = 56
      EditLabel.Height = 27
      EditLabel.Caption = 'Idade'
      TabOrder = 4
    end
    object LabeledEdit4: TLabeledEdit
      Left = 19
      Top = 328
      Width = 510
      Height = 35
      EditLabel.Width = 53
      EditLabel.Height = 27
      EditLabel.Caption = 'Frase'
      TabOrder = 5
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 118
    Width = 552
    Height = 41
    Align = alTop
    Caption = '** PRODUTOR **'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -23
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 192
    ExplicitTop = 296
    ExplicitWidth = 185
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 381
    Top = 133
  end
end
