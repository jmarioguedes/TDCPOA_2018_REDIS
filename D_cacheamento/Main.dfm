object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'TDC POA - 2018 | Cacheamento'
  ClientHeight = 509
  ClientWidth = 778
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
    Width = 768
    Height = 84
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 18
      Width = 121
      Height = 49
      Caption = 'LISTAR'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 536
      Top = 18
      Width = 217
      Height = 49
      Caption = 'NOVA INST'#194'NCIA'
      TabOrder = 1
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 152
      Top = 22
      Width = 233
      Height = 41
      Caption = 'Ativar temporizador'
      TabOrder = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 490
    Width = 778
    Height = 19
    Panels = <>
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 99
    Width = 768
    Height = 386
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 403
      Height = 374
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -22
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'UF'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sum'
          Title.Caption = 'FATURAMENTO'
          Width = 250
          Visible = True
        end>
    end
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 419
      Top = 6
      Width = 343
      Height = 374
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Consolas'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      TabOrder = 1
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'ApplicationName=TDC2018'
      'Password=postgres'
      'Server=localhost'
      'User_Name=postgres'
      'Database=TDC2018')
    LoginPrompt = False
    Left = 72
    Top = 208
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT "UF", SUM("VALOR") '
      'FROM "TB_VENDAS"'
      'GROUP BY "UF"'
      'ORDER BY "UF";')
    Left = 165
    Top = 205
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDQuery1
    Left = 256
    Top = 200
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 69
    Top = 293
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 69
    Top = 371
  end
end
