unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TdebugForm = class(TForm)
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    StringGrid2: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  debugForm: TdebugForm;

implementation

{$R *.dfm}

uses Unit1;

procedure TdebugForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  mainForm.ToggleSwitch1.Visible := False;
end;

procedure TdebugForm.FormShow(Sender: TObject);
begin
  mainForm.ToggleSwitch1.Visible := True;
end;

end.
