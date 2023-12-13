object dataForm: TdataForm
  Left = 980
  Top = 104
  Caption = 'dataForm'
  ClientHeight = 627
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  DesignSize = (
    764
    627)
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 569
    Height = 426
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Text z na'#269'ten'#233' HTML str'#225'nky'
    TabOrder = 0
    object MemoStranka: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 545
      Height = 387
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
      OnClick = MemoStrankaClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 591
    Top = 8
    Width = 162
    Height = 426
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Seznam parcel'
    TabOrder = 1
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
      Top = 85
      Width = 138
      Height = 15
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Parcely (pod sebou)'
      ExplicitWidth = 105
    end
    object MemoParcely: TMemo
      AlignWithMargins = True
      Left = 12
      Top = 110
      Width = 138
      Height = 304
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Lines.Strings = (
        '1305/29'
        '1587')
      TabOrder = 0
    end
    object edit_katastr: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 52
      Width = 138
      Height = 23
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 1
      Text = 'Vesec u Liberce'
      TextHint = 'zadej katastr'#225'ln'#237' '#250'zem'#237
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 440
    Width = 745
    Height = 177
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'GroupBox3'
    TabOrder = 2
    object StringGrid1: TStringGrid
      AlignWithMargins = True
      Left = 12
      Top = 27
      Width = 721
      Height = 138
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
  end
end
