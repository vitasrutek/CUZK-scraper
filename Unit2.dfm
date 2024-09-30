object clearForm: TclearForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Vymaz'#225'n'#237' dat'
  ClientHeight = 197
  ClientWidth = 266
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 250
    Height = 145
    Caption = 'Co bude vymaz'#225'no?'
    TabOrder = 0
    object CheckBox1: TCheckBox
      AlignWithMargins = True
      Left = 12
      Top = 22
      Width = 226
      Height = 17
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Nic, br'#225't parcely od za'#269#225'tku seznamu'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      AlignWithMargins = True
      Left = 12
      Top = 49
      Width = 226
      Height = 17
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Seznam parcel + katastr'#225'ln'#237' '#250'zem'#237
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      AlignWithMargins = True
      Left = 12
      Top = 76
      Width = 226
      Height = 17
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'V'#253'pis v tabulce'
      TabOrder = 2
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 12
      Top = 103
      Width = 226
      Height = 2
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 3
    end
    object CheckBox4: TCheckBox
      AlignWithMargins = True
      Left = 12
      Top = 115
      Width = 226
      Height = 17
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'V'#353'e'
      TabOrder = 4
      OnClick = CheckBox4Click
    end
  end
  object Button1: TButton
    Left = 20
    Top = 164
    Width = 226
    Height = 25
    Caption = 'Vymazat'
    TabOrder = 1
    OnClick = Button1Click
  end
end
