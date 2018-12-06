object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'TDC POA - 2018 | Benchmark'
  ClientHeight = 659
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 27
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 594
    Height = 82
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      594
      82)
    object Button1: TButton
      Left = 8
      Top = 17
      Width = 105
      Height = 49
      Caption = 'Iniciar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 128
      Top = 24
      Width = 121
      Height = 37
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 500
    end
    object Button2: TButton
      Left = 371
      Top = 17
      Width = 217
      Height = 49
      Anchors = [akTop, akRight]
      Caption = 'NOVA INST'#194'NCIA'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 97
    Width = 594
    Height = 557
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 427
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 582
      Height = 545
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 415
    end
  end
end
