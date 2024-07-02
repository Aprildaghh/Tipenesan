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
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    filterByName, filterByCategory: string;
  public
    { Public declarations }
    selectedId: integer;
  end;

var
  mainForm: TmainForm;

implementation

{$R *.dfm}

function contains(arr: array of string ; value: string; index: integer): boolean;
var
  i: Integer;
  flag: boolean;
begin
  flag := False;
  for i := 0 to index do
  begin
    try
      if CompareStr(arr[i], value) = 0 then
      begin
        flag := True;
        break;
      end;
    except
    end;
  end;
  Result := flag;
end;

function fillCategoryBox: integer;
var
  i, categoryIndex, maxIndex: integer;
  newData: string;
  categories: array[0..100] of string;
begin

  categoryIndex := 0;
  maxIndex := DBDataModule.DBConn.ExecSQLScalar('select count(*) from popular_culture order by id asc');
  for i := 0 to maxIndex-1 do
  begin
    newData := DBDataModule.DBConn.ExecSQLScalar('select category from popular_culture order by id asc limit 1 offset '+inttostr(i));  
    if not contains(categories, newData, categoryIndex-1) then
    begin
      categories[categoryIndex] := newData;
      inc(categoryIndex);
    end;
  end;

  for i := 0 to categoryIndex-1 do
  begin
    mainForm.categoryFilterBox.Items.Add(categories[i]);
  end;
    
end;

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
  categorySize := categoryFilterBox.Items.Count;

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
  filterByCategory := 'category in (' + sqlFilter + ')';

  if filterByName <> '' then
    sqlFilter := filterByName + ' and ' + filterByCategory
  else
    sqlFilter := filterByCategory;

  DBDataModule.DBTable.Filter := sqlFilter;
  DBDataModule.DBTable.Filtered := True;

end;

procedure TmainForm.editBtnClick(Sender: TObject);
begin
  selectedId := gridBox.SelectedField.AsInteger;
  editForm.showModal;
end;

procedure TmainForm.FormActivate(Sender: TObject);
begin
  fillCategoryBox;
  categoryFilterBox.Refresh;
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
  input, filter:string;
begin
  input := searchBox.Text;
  filterByName := 'name like ' + QuotedStr('%'+input+'%');

  if filterByCategory <> '' then
    filter := filterByName + ' and ' + filterByCategory
  else
    filter := filterByName;

  DBDataModule.DBTable.Filter := filter;
  DBDataModule.DBTable.Filtered := True;
end;
end.
