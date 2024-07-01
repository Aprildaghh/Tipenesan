object DBDataModule: TDBDataModule
  Height = 480
  Width = 640
  object DBConn: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'Password=zxcasd45'
      'Database=tipenesan'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    Left = 112
    Top = 188
  end
  object DBTable: TFDTable
    Active = True
    IndexFieldNames = 'id'
    Connection = DBConn
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    CatalogName = 'DBTable'
    TableName = 'tipenesan.popular_culture'
    Left = 224
    Top = 136
  end
  object DBDataSource: TDataSource
    DataSet = DBTable
    Left = 352
    Top = 104
  end
  object DBQueryCategory: TFDQuery
    Active = True
    Connection = DBConn
    SQL.Strings = (
      'select distinct category from popular_culture')
    Left = 472
    Top = 168
  end
end
