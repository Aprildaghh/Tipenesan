unit editUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TeditForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    nameBox: TEdit;
    CategoryBox: TEdit;
    releaseDateBox: TDateTimePicker;
    ratingBox: TEdit;
    finishedBox: TCheckBox;
    seasonBox: TEdit;
    addBtn: TButton;
    procedure addBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    id: integer;
  public
    { Public declarations }
  end;

var
  editForm: TeditForm;

implementation

uses mainUnit, DBModule;

{$R *.dfm}

function clearFields():boolean;
begin
  editForm.nameBox.Text := '';
  editForm.categoryBox.Text := '';
  editForm.releaseDateBox.Date := now;
  editForm.ratingBox.Text := '';
  editForm.seasonBox.Text := '';
  editForm.finishedBox.Checked := False;

end;

procedure TeditForm.addBtnClick(Sender: TObject);
begin
  if (Length(nameBox.Text) <> 0) and (Length(categoryBox.Text) <> 0) and (Length(ratingBox.Text) <> 0) then
  begin
    DBDataModule.DBTable.Edit;

    DBDataModule.DBTable['id'] := mainForm.selectedId;
    DBDataModule.DBTable['name'] := nameBox.Text;
    DBDataModule.DBTable['category'] := categoryBox.Text;
    DBDataModule.DBTable['release_date'] := releaseDateBox.Date;
    DBDataModule.DBTable['rating'] := ratingBox.Text;
    DBDataModule.DBTable['finished'] := finishedBox.Checked;
    try
      if seasonBox.Text <> '' then
        DBDataModule.DBTable['season'] := seasonBox.Text;

    except
    end;

    DBDataModule.DBTable.Post;
    DBDataModule.DBTable.Refresh;
    mainForm.gridBox.Refresh;
  end
  else
  begin
    ShowMessage('Invalid input!');
  end;

  clearFields;
  self.Close;
end;

procedure TeditForm.FormActivate(Sender: TObject);
var
i : integer;
begin
  nameBox.Text := DBDataModule.DBConn.ExecSQLScalar('select name from popular_culture where id = '+inttostr(mainForm.selectedId));
  categoryBox.Text := DBDataModule.DBConn.ExecSQLScalar('select category from popular_culture where id = '+inttostr(mainForm.selectedId));
  releaseDateBox.Date := DBDataModule.DBConn.ExecSQLScalar('select release_date from popular_culture where id = '+inttostr(mainForm.selectedId));
  ratingBox.Text := DBDataModule.DBConn.ExecSQLScalar('select rating from popular_culture where id = '+inttostr(mainForm.selectedId));
  if VarNull <> VarType(DBDataModule.DBConn.ExecSQLScalar('select season from popular_culture where id = '+inttostr(mainForm.selectedId))) then
    seasonBox.Text := DBDataModule.DBConn.ExecSQLScalar('select season from popular_culture where id = '+inttostr(mainForm.selectedId));
  finishedBox.Checked := DBDataModule.DBConn.ExecSQLScalar('select finished from popular_culture where id = '+inttostr(mainForm.selectedId));
end;
end.
