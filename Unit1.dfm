object mainForm: TmainForm
  Left = 247
  Top = 0
  Caption = 'V'#253'pis parcel z CUZK (v2.0)'
  ClientHeight = 817
  ClientWidth = 1274
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
    1274
    817)
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 481
    Width = 1274
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
    Width = 1274
    Height = 481
    Align = alTop
    BevelOuter = bvNone
    Constraints.MinHeight = 297
    TabOrder = 0
    DesignSize = (
      1274
      481)
    object GroupBox1: TGroupBox
      Left = 8
      Top = 10
      Width = 931
      Height = 465
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Prohl'#237#382'e'#269
      TabOrder = 0
      object EdgeBrowser1: TEdgeBrowser
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 921
        Height = 440
        Align = alClient
        TabOrder = 0
        TabStop = True
        AllowSingleSignOnUsingOSPrimaryAccount = False
        TargetCompatibleBrowserVersion = '117.0.2045.28'
        UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
        OnExecuteScript = EdgeBrowser1ExecuteScript
        OnNavigationStarting = EdgeBrowser1NavigationStarting
        OnNavigationCompleted = EdgeBrowser1NavigationCompleted
        OnSourceChanged = EdgeBrowser1SourceChanged
      end
      object ToggleSwitch1: TToggleSwitch
        Left = 12
        Top = 20
        Width = 112
        Height = 20
        StateCaptions.CaptionOn = 'na'#269'teno'
        StateCaptions.CaptionOff = 'nena'#269'teno'
        TabOrder = 1
        Visible = False
      end
    end
    object GroupBox5: TGroupBox
      Left = 945
      Top = 10
      Width = 149
      Height = 468
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
        Caption = 'Na'#269#237'st CUZK'
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
        Caption = 'Zadat KU'
        TabOrder = 1
        OnClick = Button16Click
      end
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 9
        Top = 281
        Width = 131
        Height = 73
        Margins.Left = 7
        Margins.Right = 7
        Align = alTop
        BevelKind = bkSoft
        TabOrder = 2
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
        object Button3: TButton
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
      object GroupBox2: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 191
        Width = 139
        Height = 84
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
          Caption = 'Zadat parcelu'
          TabOrder = 0
          OnClick = Button17Click
        end
        object Button10: TButton
          AlignWithMargins = True
          Left = 5
          Top = 51
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Vypsat parcelu'
          TabOrder = 1
          OnClick = Button10Click
        end
      end
      object GroupBox6: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 82
        Width = 139
        Height = 103
        Align = alTop
        Caption = 's p'#345'ihl'#225#353'en'#237'm'
        DefaultHeaderFont = False
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -12
        HeaderFont.Name = 'Segoe UI'
        HeaderFont.Style = [fsBold]
        TabOrder = 4
        object Button5: TButton
          AlignWithMargins = True
          Left = 5
          Top = 20
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Vypsat parcely'
          TabOrder = 0
          OnClick = Button5Click
        end
        object RadioButton1: TRadioButton
          AlignWithMargins = True
          Left = 5
          Top = 51
          Width = 129
          Height = 17
          Align = alTop
          Caption = 'po jedn'#233
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object RadioButton2: TRadioButton
          AlignWithMargins = True
          Left = 5
          Top = 74
          Width = 129
          Height = 17
          Align = alTop
          Caption = 'v'#353'echny najednou'
          TabOrder = 2
        end
      end
      object GroupBox7: TGroupBox
        AlignWithMargins = True
        Left = 5
        Top = 360
        Width = 139
        Height = 52
        Align = alTop
        Caption = 'Vymaz'#225'n'#237' dat'
        TabOrder = 5
        object Button4: TButton
          AlignWithMargins = True
          Left = 5
          Top = 20
          Width = 129
          Height = 25
          Align = alTop
          Caption = 'Vybrat k vymaz'#225'n'#237
          TabOrder = 0
          OnClick = Button4Click
        end
      end
    end
    object GroupBox4: TGroupBox
      Left = 1100
      Top = 10
      Width = 162
      Height = 465
      Anchors = [akTop, akRight, akBottom]
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
        Top = 81
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
        Top = 101
        Width = 138
        Height = 355
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 7
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object ComboBox_katastr: TComboBoxEx
        AlignWithMargins = True
        Left = 12
        Top = 47
        Width = 138
        Height = 24
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        ItemsEx = <>
        TabOrder = 1
        Text = 'zadej / vyber'
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 484
    Width = 1274
    Height = 333
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1274
      333)
    object GroupBox3: TGroupBox
      Left = 8
      Top = 6
      Width = 1255
      Height = 315
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Tabulka'
      TabOrder = 0
      DesignSize = (
        1255
        315)
      object StringGrid1: TStringGrid
        AlignWithMargins = True
        Left = 12
        Top = 27
        Width = 1231
        Height = 276
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
      end
      object Panel4: TPanel
        Left = 264
        Top = 88
        Width = 988
        Height = 224
        Anchors = [akRight, akBottom]
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 1
        Visible = False
        object RichEdit2: TRichEdit
          Left = 344
          Top = 8
          Width = 233
          Height = 161
          Font.Charset = EASTEUROPE_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
          Zoom = 70
        end
        object StringGrid2: TStringGrid
          Left = 583
          Top = 8
          Width = 370
          Height = 161
          DefaultColWidth = 300
          FixedCols = 0
          RowCount = 10
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goFixedRowDefAlign]
          TabOrder = 1
          RowHeights = (
            24
            24
            24
            24
            24
            24
            24
            24
            24
            24)
        end
      end
    end
  end
  object RichEdit1: TRichEdit
    Left = 293
    Top = 600
    Width = 317
    Height = 193
    Anchors = [akRight, akBottom]
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
    WordWrap = False
    Zoom = 70
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 496
    Top = 58
  end
end
