unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls;

type
  TdataForm = class(TForm)
    GroupBox1: TGroupBox;
    MemoStranka: TMemo;
    GroupBox2: TGroupBox;
    MemoParcely: TMemo;
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    edit_katastr: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure MemoStrankaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dataForm: TdataForm;

implementation

{$R *.dfm}

procedure TdataForm.FormCreate(Sender: TObject);
begin
  Stringgrid1.Cells[0, 0] := 'Název KÚ';
  Stringgrid1.Cells[1, 0] := 'Èíslo KÚ';
  Stringgrid1.Cells[2, 0] := 'Obec';
  Stringgrid1.Cells[3, 0] := 'Èást obce';
  Stringgrid1.Cells[4, 0] := 'Kraj';
  Stringgrid1.Cells[5, 0] := 'Pracovištì';
  Stringgrid1.Cells[6, 0] := 'Typ';
  Stringgrid1.Cells[7, 0] := 'Parcela';
  Stringgrid1.Cells[8, 0] := 'Budova';
  Stringgrid1.Cells[9, 0] := 'LV';
  Stringgrid1.Cells[10, 0] := 'Typ parcely';
  Stringgrid1.Cells[11, 0] := 'Zdroj';
  Stringgrid1.Cells[12, 0] := 'Typ budovy';
  Stringgrid1.Cells[13, 0] := 'Výmìra';
  Stringgrid1.Cells[14, 0] := 'Druh pozemku';
  Stringgrid1.Cells[15, 0] := 'Zpùsob využití';
  Stringgrid1.Cells[16, 0] := 'Platnost';
  Stringgrid1.Cells[17, 0] := 'Zpùsob ochrany';
  Stringgrid1.Cells[18, 0] := 'Omezení';
  Stringgrid1.Cells[19, 0] := 'Jméno';
  Stringgrid1.Cells[20, 0] := 'Podíl';
  Stringgrid1.Cells[21, 0] := 'vztah';
  Stringgrid1.Cells[22, 0] := 'Adresa';
  Stringgrid1.Cells[23, 0] := 'Adresa obec';
  Stringgrid1.Cells[24, 0] := 'PSÈ';


  Stringgrid1.ColWidths[0] := 150;
  Stringgrid1.ColWidths[1] := 50;
  Stringgrid1.ColWidths[2] := 100;
  Stringgrid1.ColWidths[3] := 1;
  Stringgrid1.ColWidths[4] := 1;
  Stringgrid1.ColWidths[5] := 1;
  Stringgrid1.ColWidths[6] := 1;
  Stringgrid1.ColWidths[7] := 60;
  Stringgrid1.ColWidths[8] := 1;
  Stringgrid1.ColWidths[9] := 60;
  Stringgrid1.ColWidths[10] := 1;
  Stringgrid1.ColWidths[11] := 1;
  Stringgrid1.ColWidths[12] := 1;
  Stringgrid1.ColWidths[13] := 30;
  Stringgrid1.ColWidths[14] := 100;
  Stringgrid1.ColWidths[15] := 100;
  Stringgrid1.ColWidths[16] := 1;
  Stringgrid1.ColWidths[17] := 100;
  Stringgrid1.ColWidths[18] := 100;
  Stringgrid1.ColWidths[19] := 150;
  Stringgrid1.ColWidths[20] := 60;
  Stringgrid1.ColWidths[21] := 1;
  Stringgrid1.ColWidths[22] := 150;
  Stringgrid1.ColWidths[23] := 150;
  Stringgrid1.ColWidths[24] := 60;

end;

procedure TdataForm.MemoStrankaClick(Sender: TObject);
begin
caption := IntToStr(MemoStranka.CaretPos.Y);
end;

end.
