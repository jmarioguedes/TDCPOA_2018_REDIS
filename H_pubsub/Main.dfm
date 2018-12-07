object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'TDC POA - 2018 | Publica'#231#227'o e Assinatura'
  ClientHeight = 699
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 27
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 446
    Height = 380
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Panel1'
    Color = 8454143
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 438
      Height = 141
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel4'
      Color = 8454143
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      object Label3: TLabel
        Left = 16
        Top = 8
        Width = 163
        Height = 28
        Caption = 'ASSINATURA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 16
        Top = 49
        Width = 259
        Height = 27
        Caption = 'TDC:2018:POA:NOTIFICA:'
      end
      object Label2: TLabel
        Left = 408
        Top = 49
        Width = 16
        Height = 27
        Caption = '#'
      end
      object Edit1: TEdit
        Left = 281
        Top = 44
        Width = 120
        Height = 35
        Alignment = taCenter
        TabOrder = 0
        Text = 'MARIO'
      end
      object Button2: TButton
        Left = 109
        Top = 91
        Width = 203
        Height = 49
        Caption = 'ASSINAR'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 6
      Top = 153
      Width = 434
      Height = 221
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 395
    Width = 446
    Height = 216
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    Color = 8421631
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 206
    object Label4: TLabel
      Left = 16
      Top = 16
      Width = 152
      Height = 28
      Caption = 'PUBLICA'#199#195'O'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 24
      Top = 67
      Width = 125
      Height = 27
      Caption = 'Destinat'#225'rio:'
    end
    object Label6: TLabel
      Left = 36
      Top = 108
      Width = 113
      Height = 27
      Caption = 'Mensagem:'
    end
    object Edit2: TEdit
      Left = 155
      Top = 64
      Width = 280
      Height = 35
      TabOrder = 0
      Text = 'Edit2'
    end
    object Button3: TButton
      Left = 113
      Top = 146
      Width = 203
      Height = 49
      Caption = 'PUBLICAR'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Edit3: TEdit
      Left = 155
      Top = 105
      Width = 280
      Height = 35
      TabOrder = 2
      Text = 'Edit3'
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 621
    Width = 446
    Height = 73
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 2
    ExplicitTop = 628
    object Button1: TButton
      Left = 232
      Top = 13
      Width = 203
      Height = 49
      Caption = 'NOVA INST'#194'NCIA'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
