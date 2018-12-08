object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'TDC  POA 2018 | TOTEM DE SENHA'
  ClientHeight = 261
  ClientWidth = 419
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
  object Label1: TLabel
    Left = 88
    Top = 8
    Width = 234
    Height = 39
    Caption = 'A SUA SENHA '#201':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 72
    Width = 377
    Height = 49
    Alignment = taCenter
    AutoSize = False
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -48
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 128
    Top = 176
    Width = 145
    Height = 52
    Caption = 'SENHA'
    TabOrder = 0
    OnClick = Button1Click
  end
end
