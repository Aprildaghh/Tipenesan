object MyDataModule: TMyDataModule
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'User_Name=root')
    Left = 184
    Top = 176
  end
end
