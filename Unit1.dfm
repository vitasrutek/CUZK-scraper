object mainForm: TmainForm
  Left = 0
  Top = 83
  Caption = 'V'#253'pis parcel z CUZK (v1.12)'
  ClientHeight = 696
  ClientWidth = 1054
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
    1054
    696)
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 475
    Width = 1054
    Height = 10
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ResizeStyle = rsUpdate
    ExplicitTop = 392
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1054
    Height = 475
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 297
    TabOrder = 0
    DesignSize = (
      1054
      475)
    object GroupBox1: TGroupBox
      Left = 8
      Top = 10
      Width = 711
      Height = 459
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Prohl'#237#382'e'#269
      TabOrder = 0
      ExplicitWidth = 707
      object EdgeBrowser1: TEdgeBrowser
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 701
        Height = 434
        Align = alClient
        TabOrder = 0
        TabStop = True
        UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
        OnExecuteScript = EdgeBrowser1ExecuteScript
        ExplicitWidth = 697
      end
    end
    object GroupBox5: TGroupBox
      Left = 725
      Top = 10
      Width = 149
      Height = 456
      Anchors = [akTop, akRight]
      Caption = 'Akce'
      TabOrder = 1
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
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 82
        Width = 139
        Height = 79
        Align = alTop
        Caption = 's p'#345'ihl'#225#353'en'#237'm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object Button4: TButton
          AlignWithMargins = True
          Left = 5
          Top = 20
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'vypsat parcelu'
          TabOrder = 0
          OnClick = Button4Click
        end
        object ToggleSwitch1: TToggleSwitch
          AlignWithMargins = True
          Left = 5
          Top = 51
          Width = 129
          Height = 20
          Align = alTop
          StateCaptions.CaptionOn = 'najednou'
          StateCaptions.CaptionOff = 'po jedn'#233
          TabOrder = 1
          OnClick = ToggleSwitch1Click
          ExplicitWidth = 107
        end
      end
      object GroupBox6: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 167
        Width = 139
        Height = 146
        Align = alTop
        Caption = 'bez p'#345'ihl'#225#353'en'#237
        TabOrder = 3
        object Button17: TButton
          AlignWithMargins = True
          Left = 5
          Top = 20
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Zad'#225'n'#237' parcely'
          TabOrder = 0
          OnClick = Button17Click
        end
        object Button11: TButton
          AlignWithMargins = True
          Left = 5
          Top = 51
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Ozna'#269'en'#237' dat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = Button11Click
        end
        object Button10: TButton
          AlignWithMargins = True
          Left = 5
          Top = 82
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Kopie a p'#345#237'prava'
          TabOrder = 2
          OnClick = Button10Click
        end
        object Button15: TButton
          AlignWithMargins = True
          Left = 5
          Top = 113
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'V'#253'pis hodnot'
          TabOrder = 3
          OnClick = Button15Click
        end
      end
      object Panel4: TPanel
        AlignWithMargins = True
        Left = 9
        Top = 319
        Width = 131
        Height = 72
        Margins.Left = 7
        Margins.Right = 7
        Align = alTop
        BevelKind = bkSoft
        TabOrder = 4
        object Button2: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 119
          Height = 25
          Align = alTop
          Caption = 'Vytvo'#345'it EXCEL'
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button6: TButton
          AlignWithMargins = True
          Left = 51
          Top = 35
          Width = 25
          Height = 25
          Margins.Left = 50
          Margins.Right = 50
          Align = alTop
          Caption = '?'
          TabOrder = 1
          OnClick = Button3Click
        end
      end
      object GroupBox7: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 397
        Width = 139
        Height = 51
        Align = alTop
        Caption = 'Vymaz'#225'n'#237
        TabOrder = 5
        object Button1: TButton
          AlignWithMargins = True
          Left = 5
          Top = 20
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Vybrat k vymaz'#225'n'#237
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
    object GroupBox4: TGroupBox
      Left = 880
      Top = 10
      Width = 162
      Height = 459
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Seznam parcel'
      TabOrder = 2
      ExplicitLeft = 876
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
        Height = 350
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
    end
  end
  object MemoStranka: TMemo
    Left = 664
    Top = 371
    Width = 55
    Height = 52
    Anchors = [akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
    Visible = False
    WordWrap = False
    ExplicitLeft = 660
    ExplicitTop = 370
  end
  object Panel3: TPanel
    Left = 0
    Top = 485
    Width = 1054
    Height = 211
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 1050
    ExplicitHeight = 210
    object GroupBox3: TGroupBox
      Left = 0
      Top = 0
      Width = 1054
      Height = 211
      Align = alClient
      Caption = 'Tabulka'
      TabOrder = 0
      ExplicitWidth = 1050
      ExplicitHeight = 210
      object StringGrid1: TStringGrid
        AlignWithMargins = True
        Left = 12
        Top = 27
        Width = 1030
        Height = 172
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
        ExplicitWidth = 1026
        ExplicitHeight = 171
      end
    end
  end
end
