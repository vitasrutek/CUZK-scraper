unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TclearForm = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Panel2: TPanel;
    CheckBox4: TCheckBox;
    Button1: TButton;
    procedure CheckBox4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  clearForm: TclearForm;

implementation

{$R *.dfm}

uses Unit1;

procedure TclearForm.Button1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
    begin
      parcela_radek := 0;
    end;

  if CheckBox2.Checked = true then
    begin
      parcela_radek := 0;
      mainForm.ComboBox_katastr.Text := '';
      mainForm.MemoParcely.Lines.Clear;
      mainForm.EdgeBrowser1.ExecuteScript(
      'var inputElement = document.getElementById(''ctl00_bodyPlaceHolder_vyberObecKU_vyberKU_btnZmenKU'').click()');
    end;

  if CheckBox3.Checked = true then
    begin
      mainForm.StringGrid1.ColCount := 25;
      mainForm.StringGrid1.RowCount := 2;
      mainForm.StringGrid1.Rows[1].Clear;
    end;
end;

procedure TclearForm.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then
    begin
      Checkbox1.Checked := true;
      Checkbox2.Checked := true;
      Checkbox3.Checked := true;
    end
    else
    begin
      Checkbox1.Checked := false;
      Checkbox2.Checked := false;
      Checkbox3.Checked := false;
    end;


end;

procedure TclearForm.FormShow(Sender: TObject);
begin
  CheckBox1.Checked := false;
  CheckBox2.Checked := false;
  CheckBox3.Checked := false;
  CheckBox4.Checked := false;
end;

end.
