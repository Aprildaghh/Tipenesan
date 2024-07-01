program Tipenesan;

uses
  Vcl.Forms,
  mainUnit in 'mainUnit.pas' {mainForm},
  DBModule in 'DBModule.pas' {myDataModule: TDataModule},
  addUnit in 'addUnit.pas' {addForm},
  editUnit in 'editUnit.pas' {editForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TmainForm, mainForm);
  Application.CreateForm(TDBDataModule, DBDataModule);
  Application.CreateForm(TaddForm, addForm);
  Application.CreateForm(TeditForm, editForm);
  Application.Run;
end.
