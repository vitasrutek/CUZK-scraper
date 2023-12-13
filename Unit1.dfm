object mainForm: TmainForm
  Left = 0
  Top = 83
  Caption = 'V'#253'pis parcel z CUZK'
  ClientHeight = 606
  ClientWidth = 930
  Color = clBtnFace
  Constraints.MinHeight = 644
  Constraints.MinWidth = 942
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  DesignSize = (
    930
    606)
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 745
    Height = 329
    Caption = 'Prohl'#237#382'e'#269
    TabOrder = 0
    object EdgeBrowser1: TEdgeBrowser
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 735
      Height = 304
      Align = alClient
      TabOrder = 0
      TabStop = True
      UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
    end
    object MemoStranka: TMemo
      Left = 573
      Top = 52
      Width = 65
      Height = 244
      TabOrder = 1
      Visible = False
      WordWrap = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 343
    Width = 745
    Height = 58
    Caption = 'Akce'
    TabOrder = 1
    object Button10: TButton
      AlignWithMargins = True
      Left = 479
      Top = 21
      Width = 68
      Height = 25
      Caption = 'Vlo'#382'it'
      TabOrder = 0
      OnClick = Button10Click
    end
    object Button11: TButton
      AlignWithMargins = True
      Left = 359
      Top = 21
      Width = 114
      Height = 25
      Caption = 'Ozna'#269'it a kop'#237'rovat'
      TabOrder = 1
      OnClick = Button11Click
    end
    object Button13: TButton
      AlignWithMargins = True
      Left = 100
      Top = 21
      Width = 84
      Height = 25
      Caption = 'Na'#269'ten'#237' CUZK'
      TabOrder = 2
      OnClick = Button13Click
    end
    object Button15: TButton
      AlignWithMargins = True
      Left = 553
      Top = 21
      Width = 85
      Height = 25
      Caption = 'V'#253'pis hodnot'
      TabOrder = 3
      OnClick = Button15Click
    end
    object Button16: TButton
      AlignWithMargins = True
      Left = 189
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Zad'#225'n'#237' KU'
      TabOrder = 4
      OnClick = Button16Click
    end
    object Button17: TButton
      AlignWithMargins = True
      Left = 270
      Top = 21
      Width = 83
      Height = 25
      Caption = 'Zad'#225'n'#237' parcely'
      TabOrder = 5
      OnClick = Button17Click
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 13
      Top = 21
      Width = 81
      Height = 25
      Caption = 'Pro p'#345'ihl'#225#353'en'#237
      TabOrder = 6
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 644
      Top = 21
      Width = 93
      Height = 25
      Caption = 'Vytvo'#345'it EXCEL'
      TabOrder = 7
      OnClick = Button2Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 406
    Width = 911
    Height = 194
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Tabulka'
    TabOrder = 2
    ExplicitWidth = 907
    ExplicitHeight = 193
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 887
      Height = 155
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      ColCount = 25
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goFixedRowDefAlign]
      TabOrder = 0
      ExplicitWidth = 883
      ExplicitHeight = 154
    end
  end
  object GroupBox4: TGroupBox
    Left = 763
    Top = 8
    Width = 156
    Height = 393
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Seznam parcel'
    TabOrder = 3
    ExplicitWidth = 152
    object Label1: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 132
      Height = 15
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'K'#218':'
      ExplicitWidth = 18
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 85
      Width = 132
      Height = 15
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Parcely (pod sebou):'
      ExplicitWidth = 108
    end
    object MemoParcely: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 110
      Width = 132
      Height = 271
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 128
    end
    object edit_katastr: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 52
      Width = 132
      Height = 23
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 1
      TextHint = 'zadej katastr'#225'ln'#237' '#250'zem'#237
      ExplicitWidth = 128
    end
  end
end
