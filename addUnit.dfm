object addForm: TaddForm
  Left = 0
  Top = 0
  Caption = 'Add'
  ClientHeight = 343
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 38
    Height = 15
    Caption = 'Name: '
  end
  object Label2: TLabel
    Left = 24
    Top = 88
    Width = 54
    Height = 15
    Caption = 'Category: '
  end
  object TLabel
    Left = 24
    Top = 136
    Width = 72
    Height = 15
    Caption = 'Release Date: '
  end
  object Label4: TLabel
    Left = 24
    Top = 184
    Width = 40
    Height = 15
    Caption = 'Rating: '
  end
  object Label6: TLabel
    Left = 24
    Top = 240
    Width = 43
    Height = 15
    Caption = 'Season: '
  end
  object nameBox: TEdit
    Left = 160
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object CategoryBox: TEdit
    Left = 160
    Top = 85
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object releaseDateBox: TDateTimePicker
    Left = 160
    Top = 136
    Width = 121
    Height = 23
    Date = 45472.000000000000000000
    Time = 0.499856898146390400
    TabOrder = 2
  end
  object ratingBox: TEdit
    Left = 160
    Top = 181
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 3
  end
  object finishedBox: TCheckBox
    Left = 24
    Top = 300
    Width = 97
    Height = 17
    Caption = 'Finished'
    TabOrder = 4
  end
  object seasonBox: TEdit
    Left = 160
    Top = 237
    Width = 121
    Height = 23
    TabOrder = 5
  end
  object addBtn: TButton
    Left = 206
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 6
    OnClick = addBtnClick
  end
end
