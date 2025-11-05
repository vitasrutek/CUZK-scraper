object debugForm: TdebugForm
  Left = 613
  Top = 42
  Caption = 'debugForm'
  ClientHeight = 701
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    617
    701)
  TextHeight = 15
  object RichEdit1: TRichEdit
    Left = 8
    Top = 8
    Width = 601
    Height = 225
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object RichEdit2: TRichEdit
    Left = 8
    Top = 248
    Width = 601
    Height = 249
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 512
    Width = 601
    Height = 185
    Anchors = [akLeft, akTop, akRight]
    DefaultColWidth = 300
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goFixedRowDefAlign]
    TabOrder = 2
  end
end
