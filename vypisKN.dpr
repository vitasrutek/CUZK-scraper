program vypisKN;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {mainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'CUZK-scraper';
  TStyleManager.TrySetStyle('Windows11 Modern Light');
  Application.CreateForm(TmainForm, mainForm);
  Application.Run;
end.
