unit addUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TaddForm = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  addForm: TaddForm;

implementation

uses mainUnit, DBModule;

{$R *.dfm}

function clearFields():boolean;
begin
  addForm.nameBox.Text := '';
  addForm.categoryBox.Text := '';
  addForm.releaseDateBox.Date := now;
  addForm.ratingBox.Text := '';
  addForm.seasonBox.Text := '';
  addForm.finishedBox.Checked := False;

end;

procedure TaddForm.addBtnClick(Sender: TObject);
begin

  if (Length(nameBox.Text) <> 0) and (Length(categoryBox.Text) <> 0) and (Length(ratingBox.Text) <> 0) then
  begin
    DBDataModule.DBTable.Insert;

    DBDataModule.DBTable['name'] := nameBox.Text;
    DBDataModule.DBTable['category'] := categoryBox.Text;
    DBDataModule.DBTable['release_date'] := releaseDateBox.Date;
    DBDataModule.DBTable['added_date'] := now;
    DBDataModule.DBTable['rating'] := ratingBox.Text;
    DBDataModule.DBTable['finished'] := finishedBox.Checked;
    if seasonBox.Text <> '' then
      DBDataModule.DBTable['season'] := seasonBox.Text;

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

end.
