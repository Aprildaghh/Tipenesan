unit mainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBModule, Data.DB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.CheckLst, addUnit, editUnit;

type
  TmainForm = class(TForm)
    gridBox: TDBGrid;
    navigatorPanel: TDBNavigator;
    addBtn: TButton;
    editBtn: TButton;
    removeBtn: TButton;
    Label1: TLabel;
    searchBox: TEdit;
    categoryFilterBox: TCheckListBox;
    Label2: TLabel;
    categoryFilterBtn: TButton;
    procedure searchBoxKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure addBtnClick(Sender: TObject);
    procedure editBtnClick(Sender: TObject);
    procedure categoryFilterBtnClick(Sender: TObject);
    procedure removeBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selectedId: integer;
  end;

var
  mainForm: TmainForm;

implementation

{$R *.dfm}

procedure TmainForm.addBtnClick(Sender: TObject);
begin
  addForm.showModal;
end;

procedure TmainForm.categoryFilterBtnClick(Sender: TObject);
var
  i, categoryIndex, categorySize: Integer;
  categories: array[0..100] of string;
  sqlFilter: string;
begin
  categoryIndex := 0;
  categorySize := 5;

  for i := 0 to categorySize - 1 do
  begin
    if(categoryFilterBox.Checked[i]) then
    begin
      categories[categoryIndex] := categoryFilterBox.Items[i];
      inc(categoryIndex);
    end;
  end;

  for i := 0 to categoryIndex - 1 do
  begin
    sqlFilter := sqlFilter + QuotedStr(categories[i]);
    if i <> categoryIndex - 1 then
      sqlFilter := sqlFilter + ', ';
  end;

  if sqlFilter = '' then
  begin
    for i := 0 to categorySize - 1 do
    begin
      sqlFilter := sqlFilter + quotedStr(categoryFilterBox.Items[i]);
      if i <> categorySize - 1 then
        sqlFilter := sqlFilter + ', ';
    end;

  end;
  sqlFilter := 'category in (' + sqlFilter + ')';

  DBDataModule.DBTable.Filter := sqlFilter;
  DBDataModule.DBTable.Filtered := True;

end;

procedure TmainForm.editBtnClick(Sender: TObject);
begin
  selectedId := gridBox.SelectedField.AsInteger;
  editForm.showModal;
end;

procedure TmainForm.removeBtnClick(Sender: TObject);
begin
  selectedId := gridBox.SelectedField.AsInteger;
  DBDataModule.DBConn.execSql('delete from popular_culture where id = ' + inttostr(selectedId));
  DBDataModule.DBTable.Refresh;
  gridBox.Refresh;

end;

procedure TmainForm.searchBoxKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  input:string;
begin
  input := searchBox.Text;
  DBDataModule.DBTable.Filter := 'name like ' + QuotedStr('%'+input+'%');
  DBDataModule.DBTable.Filtered := True;
end;
end.
