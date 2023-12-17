unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, MSHTML,
  Winapi.WebView2, Vcl.Edge, Vcl.ExtCtrls, System.Win.ComObj, Winapi.ActiveX, System.Net.URLClient,
  FMX.WebBrowser, System.Net.HttpClient, System.IOUtils, Clipbrd, StrUtils, System.Types, Excel_TLB,
  Vcl.Grids;

type
  TmainForm = class(TForm)
    GroupBox1: TGroupBox;
    EdgeBrowser1: TEdgeBrowser;
    GroupBox2: TGroupBox;
    Button10: TButton;
    Button11: TButton;
    Button13: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button1: TButton;
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MemoParcely: TMemo;
    edit_katastr: TEdit;
    MemoStranka: TMemo;
    Button2: TButton;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
  procedure SendCtrlA;
  procedure SendCtrlC;
  function GetTextAfterPrefixInLine(const Memo: TMemo; const Prefix: string; const LineIndex: Integer): string;
  function GetLineIndexOfText(const Memo: TMemo; const SearchText: string): Integer;
  procedure zadatParcelu;
  procedure zadatKU;
  procedure RozdelitParcelu(const vstupniCislo: string; var predLomitkem, zaLomitkem: Integer; var obsahujeLomitko: Boolean);
  procedure RozdelitVlastnika(const vstupniRetezec: string; var jmeno, ulice, mesto, psc, podil: string);
  procedure VyplnitDoExcelu(Grid: TStringGrid; const SouborCesta: string);
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  parcela_radek: integer;

implementation

{$R *.dfm}

uses Unit2;

const
  WM_KEYDOWN = $0100;
  WM_KEYUP = $0101;
  VK_CONTROL = $11;
  VK_A = $41;
  VK_C = $43;
  VK_V = $56;
  KEYEVENTF_KEYUP = $0002;


procedure TmainForm.Button10Click(Sender: TObject);
begin
MemoStranka.Clear;
MemoStranka.Text := Clipboard.AsText
end;

procedure TmainForm.Button11Click(Sender: TObject);
begin
  EdgeBrowser1.SetFocus;
  SendCtrlA;
  application.ProcessMessages;

  EdgeBrowser1.SetFocus;
  SendCtrlC;
  Application.ProcessMessages;
end;

procedure TmainForm.Button13Click(Sender: TObject);
begin
EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/VyberParcelu/Parcela/InformaceO');

end;

procedure TmainForm.Button15Click(Sender: TObject);
var
  row, radek, radek2, vlastniciRadek, i: integer;
  jmeno, ulice, mesto, psc, podil: string;
  KU, KUText, Obec, ObecText, parcela, LV, vymera, druh, vyuziti, ochrana, omezeni : string;
begin
  row := StringGrid1.RowCount - 1;

  radek := GetLineIndexOfText(MemoStranka, 'Katastrální');
  KUText := GetTextAfterPrefixInLine(MemoStranka, 'Katastrální území:	', radek);
  for i := 1 to Length(KUText) do
    if CharInSet(KUText[i], ['a'..'z', 'A'..'Z', ' ']) then
      KU := KU + KUText[i];
  StringGrid1.Cells[0, row] := KU;

  KU := '';
  KUText := GetTextAfterPrefixInLine(MemoStranka, 'Katastrální území:	', radek);
  for i := 1 to Length(KUText) do
    if CharInSet(KUText[i], ['0'..'9']) then
      KU := KU + KUText[i];
  StringGrid1.Cells[1, row] := KU;

  radek := GetLineIndexOfText(MemoStranka, 'Obec');
  ObecText := GetTextAfterPrefixInLine(MemoStranka, 'Obec:	', radek);
  for i := 1 to Length(ObecText) do
    if CharInSet(ObecText[i], ['a'..'z', 'A'..'Z', ' ']) then
      Obec := Obec + ObecText[i];
  StringGrid1.Cells[2, row] := Obec;

  radek := GetLineIndexOfText(MemoStranka, 'Parcelní');
  Parcela := GetTextAfterPrefixInLine(MemoStranka, 'Parcelní èíslo:	', radek);
  StringGrid1.Cells[7, row] := Parcela;

  radek := GetLineIndexOfText(MemoStranka, 'Èíslo LV');
  LV := GetTextAfterPrefixInLine(MemoStranka, 'Èíslo LV:	', radek);
  StringGrid1.Cells[9, row] := LV;

  radek := GetLineIndexOfText(MemoStranka, 'Výmìra');
  Vymera := GetTextAfterPrefixInLine(MemoStranka, 'Výmìra [m2]:	', radek);
  StringGrid1.Cells[13, row] := Vymera;

  radek := GetLineIndexOfText(MemoStranka, 'Druh pozemku');
  Druh := GetTextAfterPrefixInLine(MemoStranka, 'Druh pozemku:	', radek);
  StringGrid1.Cells[14, row] := Druh;

  radek := GetLineIndexOfText(MemoStranka, 'Zpùsob využití');
  Vyuziti := GetTextAfterPrefixInLine(MemoStranka, 'Zpùsob využití:	', radek);
  StringGrid1.Cells[15, row] := Vyuziti;

  radek := GetLineIndexOfText(MemoStranka, 'Zpùsob ochrany');
  if (Copy(MemoStranka.Lines[radek + 1], 1, 2)) = 'Ne' then
    begin
      ochrana := '';
      StringGrid1.Cells[17, row] := ochrana;
    end
    else
    begin
      ochrana := MemoStranka.Lines[radek + 1];
      StringGrid1.Cells[17, row] := ochrana;
    end;

  radek := GetLineIndexOfText(MemoStranka, 'Omezení vlastnického');
  if ((Copy(MemoStranka.Lines[radek + 1], 1, 2)) = 'Ne') or ((Copy(MemoStranka.Lines[radek + 1], 1, 2)) = 'Ty') then
    begin
      omezeni := '';
      StringGrid1.Cells[18, row] := omezeni;
    end
    else
    begin
      omezeni := MemoStranka.Lines[radek + 1];
      StringGrid1.Cells[18, row] := omezeni;
    end;

  radek := GetLineIndexOfText(MemoStranka, 'Vlastnické právo');
  if (Copy(MemoStranka.Lines[radek + 2], 1, 2)) = 'Zp' then
  begin
    RozdelitVlastnika(MemoStranka.Lines[radek + 1]  , jmeno, ulice, mesto, psc, podil);
    StringGrid1.Cells[19, row] := jmeno;
    StringGrid1.Cells[22, row] := ulice;
    StringGrid1.Cells[23, row] := mesto;
    StringGrid1.Cells[24, row] := psc;
    StringGrid1.Cells[20, row] := podil;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
  end
  else
  begin
    radek2 := GetLineIndexOfText(MemoStranka, 'Zpùsob ochrany nemovitosti');
    for vlastniciRadek := (radek + 1) to (radek2 - 1) do
    begin
      RozdelitVlastnika(MemoStranka.Lines[vlastniciRadek]  , jmeno, ulice, mesto, psc, podil);
      StringGrid1.Cells[19, row] := jmeno;
      StringGrid1.Cells[22, row] := ulice;
      StringGrid1.Cells[23, row] := mesto;
      StringGrid1.Cells[24, row] := psc;
      StringGrid1.Cells[20, row] := podil;

      StringGrid1.Cells[0, row] := KU;
      StringGrid1.Cells[1, row] := KU;
      StringGrid1.Cells[2, row] := Obec;
      StringGrid1.Cells[7, row] := Parcela;
      StringGrid1.Cells[9, row] := LV;
      StringGrid1.Cells[13, row] := Vymera;
      StringGrid1.Cells[14, row] := Druh;
      StringGrid1.Cells[15, row] := Vyuziti;
      StringGrid1.Cells[17, row] := Ochrana;
      StringGrid1.Cells[18, row] := Omezeni;

      StringGrid1.RowCount := StringGrid1.RowCount + 1;
      row := StringGrid1.RowCount - 1;
    end;
  end;
  EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/VyberParcelu/Parcela/InformaceO')
end;

procedure TmainForm.Button16Click(Sender: TObject);
begin
zadatKU;
end;

procedure TmainForm.Button17Click(Sender: TObject);
begin
zadatParcelu;
parcela_radek := parcela_radek + 1;
end;

procedure TmainForm.Button1Click(Sender: TObject);
begin
EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/')
end;

procedure TmainForm.Button2Click(Sender: TObject);
begin
VyplnitDoExcelu(StringGrid1, ExtractFilePath(Application.ExeName) + '\Seznam dotèených vlastníkù.xlsx');
end;

procedure TmainForm.FormCreate(Sender: TObject);
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

procedure Tmainform.SendCtrlA;
begin
  EdgeBrowser1.SetFocus;
  keybd_event(VK_CONTROL, 0, 0, 0);
  keybd_event(VK_A, 0, 0, 0);
  keybd_event(VK_A, 0, KEYEVENTF_KEYUP, 0);
  keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
end;

procedure Tmainform.SendCtrlC;
begin
  EdgeBrowser1.SetFocus;
  keybd_event(VK_CONTROL, 0, 0, 0);
  keybd_event(VK_C, 0, 0, 0);
  keybd_event(VK_C, 0, KEYEVENTF_KEYUP, 0);
  keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
end;

function TmainForm.GetTextAfterPrefixInLine(const Memo: TMemo; const Prefix: string; const LineIndex: Integer): string;
var
  LineText, PrefixText: string;
  PrefixIndex: Integer;
begin
  if (LineIndex >= 0) and (LineIndex < Memo.Lines.Count) then
    LineText := Memo.Lines[LineIndex]
  else
    Exit('');

  PrefixText := Prefix;
  PrefixIndex := Pos(PrefixText, LineText);
  if PrefixIndex = 0 then
    Exit('');

  Result := Copy(LineText, PrefixIndex + Length(PrefixText), Length(LineText));
end;

function TMainform.GetLineIndexOfText(const Memo: TMemo; const SearchText: string): Integer;
var
  i: Integer;
begin
  for i := 0 to Memo.Lines.Count - 1 do
  begin
    if Pos(SearchText, Memo.Lines[i]) > 0 then
    begin
      Result := i;
      Exit;
    end;
  end;
  Result := -1;
end;

procedure TmainForm.zadatParcelu;
var
  cisloPredLomitkem, cisloZaLomitkem: Integer;
  obsahujeLomitko: Boolean;
begin
  RozdelitParcelu(MemoParcely.Lines[parcela_radek], cisloPredLomitkem, cisloZaLomitkem, obsahujeLomitko);
  if obsahujeLomitko = true then
  begin
    EdgeBrowser1.ExecuteScript(
      'var inputElement = document.getElementById(''ctl00_bodyPlaceHolder_txtParcis'');' +
      'if (inputElement) {' +
      '  inputElement.value = ''' + inttostr(cisloPredLomitkem) + ''';' +
      '}' +
      'var inputElement2 = document.getElementById(''ctl00_bodyPlaceHolder_txtParpod'');' +
      'if (inputElement2) {' +
      '  inputElement2.value = ''' + inttostr(cisloZaLomitkem) + ''';' +
      '}' +
      'document.getElementById(''ctl00_bodyPlaceHolder_btnVyhledat'').click();'
    );
  end
  else
  begin
    EdgeBrowser1.ExecuteScript(
    'var inputElement = document.getElementById(''ctl00_bodyPlaceHolder_txtParcis'');' +
    'if (inputElement) {' +
    '  inputElement.value = ''' + MemoParcely.Lines[parcela_radek] + ''';' +
    '}' +
    'document.getElementById(''ctl00_bodyPlaceHolder_btnVyhledat'').click();'
    );
  end;
end;

procedure TmainForm.zadatKU;
begin
EdgeBrowser1.ExecuteScript(
  'var inputElement = document.getElementById(''ctl00_bodyPlaceHolder_vyberObecKU_vyberKU_txtKU'');' +
  'if (inputElement) {' +
  '  inputElement.value = ''' + Edit_katastr.text + ''';' +
  '}' +
  'document.getElementById(''ctl00_bodyPlaceHolder_vyberObecKU_vyberKU_btnKU'').click();'
  );
end;

procedure TMainForm.RozdelitParcelu(const vstupniCislo: string; var predLomitkem, zaLomitkem: Integer; var obsahujeLomitko: Boolean);
var
  lomitkoIndex: Integer;
  celeCisloPredLomitkem, celeCisloZaLomitkem: string;
begin
  predLomitkem := 0;
  zaLomitkem := 0;
  obsahujeLomitko := False;

  lomitkoIndex := Pos('/', vstupniCislo);

  if lomitkoIndex > 0 then
  begin
    obsahujeLomitko := True;

    celeCisloPredLomitkem := Copy(vstupniCislo, 1, lomitkoIndex - 1);
    celeCisloZaLomitkem := Copy(vstupniCislo, lomitkoIndex + 1, Length(vstupniCislo));

    predLomitkem := StrToIntDef(celeCisloPredLomitkem, 0);
    zaLomitkem := StrToIntDef(celeCisloZaLomitkem, 0);
  end
  else
  begin
    predLomitkem := StrToIntDef(vstupniCislo, 0);
  end;
end;

procedure TMainForm.RozdelitVlastnika(const vstupniRetezec: string; var jmeno, ulice, mesto, psc, podil: string);
var
  seznam: TStringDynArray;
  indexA, i: Integer;
  podilText, mestoText: string;
begin
jmeno := '';
ulice := '';
mesto := '';
psc := '';
podil := '';
mestoText := '';
podilText := '';
  try
    indexA := Pos('a', vstupniRetezec);
    if (indexA > 1) then
    begin
      seznam := SplitString(vstupniRetezec, ',');

      if Length(seznam) >= 4 then
      begin
        jmeno := seznam[0];
        ulice := seznam[1];

        if (seznam[2][1]) in ['0'..'9'] then
        begin
          psc := copy(seznam[2], 1, 6);
          mestoText := copy(seznam[2], 7, Length(seznam[3]));
          for i := 1 to Length(podilText) do
            if CharInSet(mestoText[i], ['a'..'z', 'A'..'Z', ' ']) then
            mesto := mesto + mestoText[i];
        end
        else
        begin
          mesto := seznam[2];
          psc := copy(seznam[3], 1, 6);
          podilText := copy(seznam[3], 7, Length(seznam[3]));
          if (seznam[3][Length(seznam[3])]) in ['0'..'9'] then
          begin
            for i := 1 to Length(podilText) do
            begin
              if (podilText[i] in ['0'..'9', '/']) then
              podil := podil + podilText[i];
            end;
          end
          else
          begin
            podil := '1/1';
          end;
        end;
      end
      else
      if Length(seznam) = 3 then
      begin
        jmeno := seznam[0];
        ulice := seznam[1];
        psc := copy(seznam[2], 1, 6);
        mestoText := seznam[2];
        for i := 1 to Length(mestoText) do
          if CharInSet(mestoText[i], ['a'..'z', 'A'..'Z', ' ']) then
          mesto := mesto + mestoText[i];
        podilText := Copy(seznam[2], 7, Length(seznam[2]));
        for i := 1 to Length(podilText) do
          begin
            if (podilText[i] in ['0'..'9', '/']) then
            podil := podil + podilText[i];
          end;
      end
      else
        raise Exception.Create('Neplatný formát øetìzce.');
    end

  except
    on E: Exception do
      raise Exception.Create('Chyba: ' + E.Message);
  end;
end;

procedure TmainForm.VyplnitDoExcelu(Grid: TStringGrid; const SouborCesta: string);
var
  Excel, Workbook, Sheet: OleVariant;
  Row, ExcelRow: Integer;
begin
  try
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible := True;

    Workbook := Excel.Workbooks.Open(SouborCesta);
    Sheet := Workbook.Worksheets[1];

    ExcelRow := 2;
    for Row := 1 to Grid.RowCount - 1 do
    begin
      if Grid.Cells[0, Row] <> '' then 
      begin
        Sheet.Cells[ExcelRow, 1].Value := Stringgrid1.Cells[0, Row];
        Sheet.Cells[ExcelRow, 2].Value := Stringgrid1.Cells[1, Row];
        Sheet.Cells[ExcelRow, 3].Value := Stringgrid1.Cells[2, Row];
        Sheet.Cells[ExcelRow, 4].Value := Stringgrid1.Cells[3, Row];
        Sheet.Cells[ExcelRow, 5].Value := Stringgrid1.Cells[4, Row];
        Sheet.Cells[ExcelRow, 6].Value := Stringgrid1.Cells[5, Row];
        Sheet.Cells[ExcelRow, 7].Value := Stringgrid1.Cells[6, Row];
        Sheet.Cells[ExcelRow, 8].Value := Stringgrid1.Cells[7, Row];
        Sheet.Cells[ExcelRow, 9].Value := Stringgrid1.Cells[8, Row];
        Sheet.Cells[ExcelRow, 10].Value := Stringgrid1.Cells[9, Row];
        Sheet.Cells[ExcelRow, 11].Value := Stringgrid1.Cells[10, Row];
        Sheet.Cells[ExcelRow, 12].Value := Stringgrid1.Cells[11, Row];
        Sheet.Cells[ExcelRow, 13].Value := Stringgrid1.Cells[12, Row];
        Sheet.Cells[ExcelRow, 14].Value := Stringgrid1.Cells[13, Row];
        Sheet.Cells[ExcelRow, 15].Value := Stringgrid1.Cells[14, Row];
        Sheet.Cells[ExcelRow, 16].Value := Stringgrid1.Cells[15, Row];
        Sheet.Cells[ExcelRow, 17].Value := Stringgrid1.Cells[16, Row];
        Sheet.Cells[ExcelRow, 18].Value := Stringgrid1.Cells[17, Row];
        Sheet.Cells[ExcelRow, 19].Value := Stringgrid1.Cells[18, Row];
        Sheet.Cells[ExcelRow, 20].Value := Stringgrid1.Cells[19, Row];
        Sheet.Cells[ExcelRow, 21].Value := Stringgrid1.Cells[20, Row];
        Sheet.Cells[ExcelRow, 22].Value := Stringgrid1.Cells[21, Row];
        Sheet.Cells[ExcelRow, 23].Value := Stringgrid1.Cells[22, Row];
        Sheet.Cells[ExcelRow, 24].Value := Stringgrid1.Cells[23, Row];
        Sheet.Cells[ExcelRow, 25].Value := Stringgrid1.Cells[24, Row];
        Inc(ExcelRow);
      end
      else
      begin
        Break;
      end;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Nastala chyba: ' + E.Message);
    end;
  end;
end;

end.
