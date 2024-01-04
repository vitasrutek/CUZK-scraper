object mainForm: TmainForm
  Left = 0
  Top = 83
  Caption = 'V'#253'pis parcel z CUZK (v1.2)'
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
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    961
    539)
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 622
    Height = 281
    Caption = 'Prohl'#237#382'e'#269
    TabOrder = 0
    object EdgeBrowser1: TEdgeBrowser
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 612
      Height = 256
      Align = alClient
      TabOrder = 0
      TabStop = True
      UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
      ExplicitHeight = 261
    end
    object MemoStranka: TMemo
      Left = 382
      Top = 21
      Width = 224
      Height = 244
      TabOrder = 1
      Visible = False
      WordWrap = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 295
    Width = 946
    Height = 236
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Tabulka'
    TabOrder = 1
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 922
      Height = 197
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
      ExplicitWidth = 918
      ExplicitHeight = 164
    end
  end
  object GroupBox4: TGroupBox
    Left = 791
    Top = 8
    Width = 162
    Height = 281
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Seznam parcel'
    TabOrder = 2
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
      ExplicitWidth = 108
    end
    object MemoParcely: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 100
      Width = 138
      Height = 172
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 7
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 134
      ExplicitHeight = 204
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
      ExplicitWidth = 134
    end
  end
  object GroupBox5: TGroupBox
    Left = 636
    Top = 8
    Width = 149
    Height = 281
    Caption = 'Akce'
    TabOrder = 3
    object Button13: TButton
      AlignWithMargins = True
      Left = 9
      Top = 20
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
      TabOrder = 0
      OnClick = Button13Click
      ExplicitTop = 51
    end
    object Button16: TButton
      AlignWithMargins = True
      Left = 9
      Top = 51
      Width = 131
      Height = 25
      Margins.Left = 7
      Margins.Right = 7
      Align = alTop
      Caption = 'Zad'#225'n'#237' KU'
      TabOrder = 1
      OnClick = Button16Click
      ExplicitTop = 82
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 9
      Top = 82
      Width = 131
      Height = 161
      Margins.Left = 7
      Margins.Right = 7
      Align = alTop
      BevelKind = bkSoft
      TabOrder = 2
      ExplicitTop = 113
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
      end
      object Button10: TButton
        AlignWithMargins = True
        Left = 4
        Top = 66
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'Kopie a p'#345#237'prava'
        TabOrder = 1
        OnClick = Button10Click
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
      end
      object Button11: TButton
        AlignWithMargins = True
        Left = 4
        Top = 35
        Width = 119
        Height = 25
        Align = alTop
        Caption = 'Ozna'#269'en'#237' dat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = Button11Click
      end
    end
    object Button3: TButton
      AlignWithMargins = True
      Left = 52
      Top = 249
      Width = 45
      Height = 25
      Margins.Left = 50
      Margins.Right = 50
      Align = alTop
      Caption = '?'
      TabOrder = 3
      OnClick = Button3Click
      ExplicitTop = 280
    end
  end
end
