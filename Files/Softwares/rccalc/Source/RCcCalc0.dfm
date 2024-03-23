object FormSplash: TFormSplash
  Left = 411
  Top = 523
  BorderStyle = bsNone
  ClientHeight = 169
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 397
    Height = 56
    Align = alTop
    Caption = 'RRcad 1.3beta'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblMsg: TLabel
    Left = 12
    Top = 64
    Width = 373
    Height = 73
    AutoSize = False
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 224
    Width = 397
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object ProgressBar: TProgressBar
    Left = 12
    Top = 140
    Width = 377
    Height = 16
    Min = 0
    Max = 100
    TabOrder = 1
  end
end
