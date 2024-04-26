program vypisKN;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {mainForm},
  Vcl.Themes,
  Vcl.Styles,
  Unit2 in 'Unit2.pas' {clearForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CUZK-scraper';
  TStyleManager.TrySetStyle('Windows11 Modern Light');
  Application.CreateForm(TmainForm, mainForm);
  Application.CreateForm(TclearForm, clearForm);
  Application.Run;
end.
