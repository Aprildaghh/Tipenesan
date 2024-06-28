unit Unit2;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMySQL, Data.DB, Data.SqlExpr;

type
  TMyDataModule = class(TDataModule)
    FDConnection1: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MyDataModule: TMyDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
