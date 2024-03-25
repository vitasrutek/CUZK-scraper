object mainForm: TmainForm
  Left = 0
  Top = 83
  Caption = 'V'#253'pis parcel z CUZK (v1.9)'
  ClientHeight = 636
  ClientWidth = 998
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
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 369
    Width = 998
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ResizeStyle = rsUpdate
    ExplicitTop = 333
    ExplicitWidth = 1023
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 998
    Height = 369
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 297
    TabOrder = 0
    ExplicitWidth = 994
    DesignSize = (
      998
      369)
    object GroupBox1: TGroupBox
      Left = 8
      Top = 10
      Width = 655
      Height = 353
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Prohl'#237#382'e'#269
      TabOrder = 0
      ExplicitWidth = 651
      object EdgeBrowser1: TEdgeBrowser
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 645
        Height = 328
        Align = alClient
        TabOrder = 0
        TabStop = True
        UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
        OnExecuteScript = EdgeBrowser1ExecuteScript
        ExplicitWidth = 641
      end
    end
    object GroupBox5: TGroupBox
      Left = 669
      Top = 10
      Width = 149
      Height = 281
      Anchors = [akTop, akRight]
      Caption = 'Akce'
      TabOrder = 1
      ExplicitLeft = 665
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
      end
    end
    object GroupBox4: TGroupBox
      Left = 824
      Top = 10
      Width = 162
      Height = 353
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Seznam parcel'
      TabOrder = 2
      ExplicitLeft = 820
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
        Height = 244
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 7
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 1
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
      end
      object Button1: TButton
        Left = 16
        Top = 247
        Width = 75
        Height = 25
        Caption = 'reset '#345#225'dku'
        TabOrder = 2
        Visible = False
        OnClick = Button1Click
      end
    end
  end
  object MemoStranka: TMemo
    Left = 569
    Top = 205
    Width = 54
    Height = 77
    ScrollBars = ssBoth
    TabOrder = 1
    Visible = False
    WordWrap = False
  end
  object Panel3: TPanel
    Left = 0
    Top = 372
    Width = 998
    Height = 264
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 994
    ExplicitHeight = 263
    DesignSize = (
      998
      264)
    object GroupBox3: TGroupBox
      Left = 7
      Top = 6
      Width = 979
      Height = 246
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Tabulka'
      TabOrder = 0
      ExplicitWidth = 975
      ExplicitHeight = 245
      object StringGrid1: TStringGrid
        AlignWithMargins = True
        Left = 12
        Top = 27
        Width = 955
        Height = 207
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
        ExplicitWidth = 951
        ExplicitHeight = 206
      end
    end
  end
end
