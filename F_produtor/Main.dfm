object Form5: TForm5
  Left = 0
  Top = 0
  ActiveControl = Edit1
  Caption = 'TDC POA - 2018 | Enfileiramento - PRODUTOR'
  ClientHeight = 448
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
    Top = 123
    Width = 542
    Height = 320
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 10
    ExplicitHeight = 162
    object Label2: TLabel
      Left = 168
      Top = 18
      Width = 64
      Height = 27
      Caption = 'Label2'
    end
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 145
      Height = 49
      Caption = 'ENFILEIRAR'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 63
      Width = 145
      Height = 49
      Caption = 'THREAD'
      TabOrder = 1
    end
    object Button3: TButton
      Left = 336
      Top = 256
      Width = 193
      Height = 49
      Caption = 'NOVA INST'#194'NCIA'
      TabOrder = 2
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 381
    Top = 133
  end
end
