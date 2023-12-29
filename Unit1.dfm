object mainForm: TmainForm
  Left = 0
  Top = 83
  Caption = 'V'#253'pis parcel z CUZK (v1.1)'
  ClientHeight = 539
  ClientWidth = 961
  Color = clBtnFace
  Constraints.MinHeight = 577
  Constraints.MinWidth = 973
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  DesignSize = (
    961
    539)
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 622
    Height = 313
    Caption = 'Prohl'#237#382'e'#269
    TabOrder = 0
    object EdgeBrowser1: TEdgeBrowser
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 612
      Height = 288
      Align = alClient
      TabOrder = 0
      TabStop = True
      UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
      ExplicitWidth = 380
      ExplicitHeight = 304
    end
    object MemoStranka: TMemo
      Left = 382
      Top = 21
      Width = 224
      Height = 277
      TabOrder = 1
      Visible = False
      WordWrap = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 327
    Width = 946
    Height = 204
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Tabulka'
    TabOrder = 1
    ExplicitWidth = 944
    ExplicitHeight = 271
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 922
      Height = 165
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
      ExplicitWidth = 884
      ExplicitHeight = 154
    end
  end
  object GroupBox4: TGroupBox
    Left = 791
    Top = 8
    Width = 162
    Height = 313
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Seznam parcel'
    TabOrder = 2
    ExplicitWidth = 160
    object Label1: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 138
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
      Top = 80
      Width = 138
      Height = 15
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Parcely (pod sebou):'
      ExplicitTop = 85
      ExplicitWidth = 108
    end
    object MemoParcely: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 100
      Width = 138
      Height = 204
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 7
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 14
      ExplicitTop = 110
      ExplicitWidth = 136
      ExplicitHeight = 272
    end
    object edit_katastr: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 47
      Width = 138
      Height = 23
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 0
      TextHint = 'zadej katastr'#225'ln'#237' '#250'zem'#237
      ExplicitTop = 52
      ExplicitWidth = 124
    end
  end
  object GroupBox5: TGroupBox
    Left = 636
    Top = 8
    Width = 149
    Height = 313
    Caption = 'Akce'
    TabOrder = 3
    object Button1: TButton
      AlignWithMargins = True
      Left = 9
      Top = 20
      Width = 131
      Height = 25
      Margins.Left = 7
      Margins.Right = 7
      Align = alTop
      Caption = 'Pro p'#345'ihl'#225#353'en'#237
      TabOrder = 0
      ExplicitLeft = 13
      ExplicitTop = 21
      ExplicitWidth = 81
    end
    object Button13: TButton
      AlignWithMargins = True
      Left = 9
      Top = 51
      Width = 131
      Height = 25
      Margins.Left = 7
      Margins.Right = 7
      Align = alTop
      Caption = 'Na'#269'ten'#237' CUZK'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button13Click
      ExplicitLeft = 33
      ExplicitTop = 75
      ExplicitWidth = 84
    end
    object Button16: TButton
      AlignWithMargins = True
      Left = 9
      Top = 82
      Width = 131
      Height = 25
      Margins.Left = 7
      Margins.Right = 7
      Align = alTop
      Caption = 'Zad'#225'n'#237' KU'
      TabOrder = 2
      OnClick = Button16Click
      ExplicitLeft = 41
      ExplicitTop = 109
      ExplicitWidth = 68
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 9
      Top = 113
      Width = 131
      Height = 161
      Margins.Left = 7
      Margins.Right = 7
      Align = alTop
      BevelKind = bkSoft
      TabOrder = 3
      ExplicitLeft = 5
      ExplicitWidth = 139
      object Button17: TButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'Zad'#225'n'#237' parcely'
        TabOrder = 0
        OnClick = Button17Click
        ExplicitLeft = 47
        ExplicitTop = 6
        ExplicitWidth = 83
      end
      object Button10: TButton
        AlignWithMargins = True
        Left = 4
        Top = 66
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'Vlo'#382'it'
        TabOrder = 1
        OnClick = Button10Click
        ExplicitLeft = 120
        ExplicitTop = 68
        ExplicitWidth = 50
      end
      object Button15: TButton
        AlignWithMargins = True
        Left = 4
        Top = 97
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'V'#253'pis hodnot'
        TabOrder = 2
        OnClick = Button15Click
        ExplicitLeft = 152
        ExplicitTop = 99
        ExplicitWidth = 85
      end
      object Button2: TButton
        AlignWithMargins = True
        Left = 4
        Top = 128
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'Vytvo'#345'it EXCEL'
        TabOrder = 3
        OnClick = Button2Click
        ExplicitLeft = 163
        ExplicitTop = 130
        ExplicitWidth = 93
      end
      object Button11: TButton
        AlignWithMargins = True
        Left = 4
        Top = 35
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'Ozna'#269'it a kop'#237'rovat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = Button11Click
        ExplicitLeft = 48
        ExplicitTop = 37
        ExplicitWidth = 114
      end
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 52
      Top = 280
      Width = 45
      Height = 25
      Margins.Left = 50
      Margins.Right = 50
      Align = alTop
      Caption = '?'
      TabOrder = 4
      OnClick = Button3Click
      ExplicitLeft = 66
      ExplicitWidth = 27
    end
  end
end
