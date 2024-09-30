unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, MSHTML,
  Winapi.WebView2, Vcl.Edge, Vcl.ExtCtrls, System.Win.ComObj, Winapi.ActiveX, System.Net.URLClient,
  FMX.WebBrowser, System.Net.HttpClient, System.IOUtils, Clipbrd, StrUtils, System.Types, Excel_TLB,
  Vcl.Grids,
  System.NetEncoding, Vcl.ComCtrls, RegularExpressions, System.UITypes,
  Vcl.WinXCtrls;

type
  TmainForm = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    EdgeBrowser1: TEdgeBrowser;
    GroupBox5: TGroupBox;
    Button13: TButton;
    Button16: TButton;
    Panel1: TPanel;
    Button2: TButton;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MemoParcely: TMemo;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    Splitter1: TSplitter;
    Panel4: TPanel;
    RichEdit2: TRichEdit;
    StringGrid2: TStringGrid;
    GroupBox2: TGroupBox;
    GroupBox6: TGroupBox;
    Button17: TButton;
    Button10: TButton;
    Button3: TButton;
    Button5: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RichEdit1: TRichEdit;
    ToggleSwitch1: TToggleSwitch;
    Timer1: TTimer;
    ComboBox_katastr: TComboBoxEx;
    GroupBox7: TGroupBox;
    Button4: TButton;
    procedure Button10Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
    procedure Button5Click(Sender: TObject);
    procedure EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser;
      Args: TNavigationStartingEventArgs);
    procedure EdgeBrowser1SourceChanged(Sender: TCustomEdgeBrowser;
      IsNewDocument: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

  public
    procedure zadatParcelu;
    procedure zadatKU;
    procedure RozdelitParcelu(const vstupniCislo: string; var predLomitkem, zaLomitkem: Integer; var obsahujeLomitko: Boolean);
    procedure RozdelitVlastnika(const vstupniRetezec: string; var jmeno, ulice, mesto, psc: string);
    procedure VyplnitDoExcelu(Grid: TStringGrid; const SouborCesta: string);
    procedure VymazatGrid(Grid: TStringGrid);
    procedure VysekParcela;
    procedure VysekVlastnici;
    procedure VysekOchrana;
    procedure VysekOmezeni;
    procedure VysekJine;
    procedure VysekObec;
    procedure VysekLV;
    procedure VysekVymera;
    procedure VysekTyp;
    procedure VysekDruh;
    procedure VysekKraj;
    procedure VysekVyuziti;
    procedure VysekCisloKU;
    procedure HTMLdoGrid(HTMLSource: string);
    procedure InsertConcatenatedTextToCell(const RowIndex, ColumnIndex: Integer; var ResultString: string);

    procedure FOmezeni;
    procedure FOchana;
    procedure FJine;
    procedure Vlastnici;
    procedure FVlastniciPodil;
    procedure FVypis2;

    procedure VyznaceniRadku(LineIndex: Integer);
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  parcela_radek: integer;
  aktualni_parcela: string;
  Nacteno, Vypsano: Boolean;
  Kraj, Vyuziti, Parcela, Omezeni, Ochrana, Jine, Obec, CisloKU, KU, LV, Vymera, Typ, Druh, Jmeno, Ulice, PSC, Mesto: string;

implementation

{$R *.dfm}

uses Unit2;


procedure TmainForm.VyznaceniRadku(LineIndex: Integer);
var
  LineStart, LineEnd: Integer;
begin
  LineStart := SendMessage(MemoParcely.Handle, EM_LINEINDEX, LineIndex, 0);
  LineEnd := SendMessage(MemoParcely.Handle, EM_LINEINDEX, LineIndex + 1, 0) - 1;

  MemoParcely.SetFocus;
  MemoParcely.SelStart := LineStart;
  MemoParcely.SelLength := LineEnd - LineStart;
end;

procedure TMainForm.FJine;
begin
  VymazatGrid(StringGrid2);
  VysekJine;
  HTMLdoGrid(RichEdit2.Text);
  InsertConcatenatedTextToCell(1, 18, Jine);
end;

procedure TmainForm.FOmezeni;
begin
  VymazatGrid(StringGrid2);
  VysekOmezeni;
  HTMLdoGrid(RichEdit2.Text);
  InsertConcatenatedTextToCell(1, 18, omezeni);
end;

procedure TmainForm.FOchana;
begin
  VymazatGrid(StringGrid2);
  VysekOchrana;
  HTMLdoGrid(RichEdit2.Text);
  InsertConcatenatedTextToCell(1, 17, ochrana);
end;

procedure TmainForm.Vlastnici;
begin
  VymazatGrid(StringGrid2);
  VysekVlastnici;
  HTMLdoGrid(RichEdit2.Text);
end;

procedure TmainForm.VysekParcela;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Parcelní èíslo:</td><td><a href=https://vdp.cuzk.cz/vdp/ruian/parcely/[^>]+>([^<]+)</a></td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    Parcela := Match.Groups[1].Value
  else
    Parcela := 'N/A';
end;

procedure TmainForm.VysekKraj;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('Katastrální úøad\s+pro\s+([^\s,]+[\s[^\s,]+]*)', [roIgnoreCase]);
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    Kraj := Match.Groups[1].Value + ' kraj'
  else
    Kraj := 'N/A';
end;

procedure TmainForm.VysekVyuziti;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Zpùsob využití:</td><td>([^<]+)</td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    Vyuziti := Match.Groups[1].Value
  else
    Vyuziti := 'N/A';
end;

procedure TmainForm.VysekObec;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Obec:</td><td><a href=https://vdp.cuzk.cz/vdp/ruian/obce/[^>]+>([^<]+) \[\d+\]</a></td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    Obec := Match.Groups[1].Value
  else
    Obec := 'N/A';
end;

procedure TmainForm.VysekLV;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Èíslo LV:</td><td><a href=[^>]+>[^<]*?(\d+)</a></td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    LV := Match.Groups[1].Value
  else
    LV := 'N/A';
end;

procedure TmainForm.VysekVymera;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Výmìra \[m<sup>2</sup>\]:</td><td>(\d+)</td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    vymera := Match.Groups[1].Value
  else
    vymera := 'N/A';
end;

procedure TmainForm.VysekTyp;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Typ parcely:</td><td>([^<]+)</td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    typ := Match.Groups[1].Value
  else
    typ := 'N/A';
end;

procedure TmainForm.VysekDruh;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Druh pozemku:</td><td>([^<]+)</td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
    druh := Match.Groups[1].Value
  else
    druh := 'N/A';
end;

procedure TmainForm.VysekCisloKU;
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Katastrální území:</td><td><a href=[^>]+>([^<]+) \[(\d+)\]</a></td>');
  Match := Regex.Match(RichEdit1.Text);
  if Match.Success then
  begin
    KU := Match.Groups[1].Value;
    cisloKU := Match.Groups[2].Value;
  end
  else
  begin
    KU := 'N/A';
    cisloKU := 'N/A';
  end;
end;

procedure TmainForm.VymazatGrid(Grid: TStringGrid);
var
  i, j: Integer;
begin
  for i := 0 to Grid.RowCount - 1 do
    for j := 0 to Grid.ColCount - 1 do
      Grid.Cells[j, i] := '';
end;

procedure TmainForm.InsertConcatenatedTextToCell(const RowIndex, ColumnIndex: Integer; var ResultString: string);
var
  ConcatenatedText: string;
  i: Integer;
begin
  ConcatenatedText := '';
  for i := 0 to StringGrid2.RowCount - 1 do
  begin
    if (StringGrid2.Cells[0, i] <> '') then
    begin
      if ConcatenatedText <> '' then
        ConcatenatedText := ConcatenatedText + ', ';
      ConcatenatedText := ConcatenatedText + StringGrid2.Cells[0, i];
    end;
  end;
    ResultString := ConcatenatedText;
end;

procedure TmainForm.HTMLdoGrid(HTMLSource: string);
var
  TableStart, TableEnd, RowStart, RowEnd, ColStart, ColEnd: Integer;
  TableHTML, TableRowHTML: string;
  TableRow, TableColumn: TStringList;
  RowIndex: Integer;
  Vlastnik, Adresa, Podil: string;
  InColspan: Boolean;
begin
  TableStart := Pos('<table', HTMLSource);
  TableEnd := Pos('</table>', HTMLSource);

  if (TableStart > 0) and (TableEnd > TableStart) then
  begin
    TableHTML := Copy(HTMLSource, TableStart, TableEnd + Length('</table>') - TableStart);

    TableRow := TStringList.Create;
    TableColumn := TStringList.Create;
    try
      RowStart := Pos('<tr>', TableHTML);
      while RowStart > 0 do
      begin
        RowEnd := Pos('</tr>', TableHTML);
        TableRowHTML := Copy(TableHTML, RowStart, RowEnd - RowStart + Length('</tr>'));
        TableRow.Add(TableRowHTML);
        Delete(TableHTML, 1, RowEnd);
        RowStart := Pos('<tr>', TableHTML);
      end;

      InColspan := False;
      RowIndex := 0;
      StringGrid2.RowCount := TableRow.Count - 1;
      for RowIndex := 1 to TableRow.Count - 1 do
      begin
        TableColumn.Clear;
        TableRowHTML := TableRow[RowIndex];

        if Pos('colspan=2', TableRowHTML) > 0 then
        begin
          ColStart := Pos('<i>', TableRowHTML);
          ColEnd := Pos('</i>', TableRowHTML);
          Adresa := Copy(TableRowHTML, ColStart + Length('<i>'), ColEnd - ColStart - Length('<i>'));
          StringGrid2.Cells[0, RowIndex - 1] := Adresa;
        end
        else
        begin
          ColStart := Pos('<td>', TableRowHTML);
          ColEnd := Pos('</td>', TableRowHTML);
          Vlastnik := Copy(TableRowHTML, ColStart + Length('<td>'), ColEnd - ColStart - Length('<td>'));

          ColStart := Pos('class=right>', TableRowHTML) + Length('class=right>');
          ColEnd := Pos('</td>', TableRowHTML, ColStart);
          Podil := Copy(TableRowHTML, ColStart, ColEnd - ColStart);
          StringGrid2.Cells[0, RowIndex - 1] := Vlastnik;
          StringGrid2.Cells[1, RowIndex - 1] := Podil;
        end;
      end;
    finally
      TableRow.Free;
      TableColumn.Free;
    end;
  end;
end;

function ExtractTableHTML(const HTML, StartPattern: string): string;
var
  Regex: TRegEx;
  Match: TMatch;
  EndPattern: string;
begin
  EndPattern := '</table>';
  Regex := TRegEx.Create(StartPattern + '.*?' + EndPattern, [roSingleLine]);
  Match := Regex.Match(HTML);

  if Match.Success then
    Result := Match.Value
  else
    Result := '';
end;

procedure TmainForm.VysekVlastnici;
var
  HTML: string;
  TableHTML: string;
  StartPattern: string;
begin
  VymazatGrid(StringGrid2);
  HTML := RichEdit1.Text;

  StartPattern := '<table summary=Vlastníci, jiní oprávnìní cellspacing=0 class=zarovnat stinuj  zarovnat stinuj  vlastnici>';
  TableHTML := ExtractTableHTML(HTML, StartPattern);

  RichEdit2.Text := TableHTML;
end;

procedure TmainForm.VysekOchrana;
var
  HTML: string;
  TableHTML: string;
  StartPattern: string;
begin
  VymazatGrid(StringGrid2);
  HTML := RichEdit1.Text;

  StartPattern := '<table summary=Zpùsob ochrany nemovitosti cellspacing=0 class=zarovnat stinuj  >';
  TableHTML := ExtractTableHTML(HTML, StartPattern);

  RichEdit2.Text := TableHTML;
end;

procedure TmainForm.VysekOmezeni;
var
  HTML: string;
  TableHTML: string;
  StartPattern: string;
begin
  VymazatGrid(StringGrid2);
  HTML := RichEdit1.Text;

  StartPattern := '<table summary=Omezení vlastnického práva cellspacing=0 class=zarovnat stinuj  >';
  TableHTML := ExtractTableHTML(HTML, StartPattern);

  RichEdit2.Text := TableHTML;
end;

procedure TmainForm.VysekJine;
var
  HTML: string;
  TableHTML: string;
  StartPattern: string;
begin
  VymazatGrid(StringGrid2);
  HTML := RichEdit1.Text;

  StartPattern := '<table summary=Jiné zápisy cellspacing=0 class=zarovnat stinuj  >';
  TableHTML := ExtractTableHTML(HTML, StartPattern);

  RichEdit2.Text := TableHTML;
end;

procedure TmainForm.Button10Click(Sender: TObject);
begin
  FVypis2;
end;

procedure TmainForm.Button13Click(Sender: TObject);
begin
  EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/VyberParcelu/Parcela/InformaceO');
  Button13.Font.Style := Font.Style - [TFontStyle.fsBold];
  Button16.Font.Style := Font.Style + [TFontStyle.fsBold];
end;

procedure TmainForm.Button16Click(Sender: TObject);
begin
  zadatKU;
  Button17.Font.Style := Font.Style + [TFontStyle.fsBold];
  Button16.Font.Style := Font.Style - [TFontStyle.fsBold];
end;

procedure TmainForm.Button17Click(Sender: TObject);
begin
  while not Nacteno do
    begin
      sleep(500);
      Application.ProcessMessages;
    end;
  sleep(500);
  zadatParcelu;
  parcela_radek := parcela_radek + 1;
  Button10.Font.Style := Font.Style + [TFontStyle.fsBold];
  Button17.Font.Style := Font.Style - [TFontStyle.fsBold];

  EdgeBrowser1.ExecuteScript('encodeURI(document.documentElement.outerHTML)');
end;

procedure TmainForm.FVlastniciPodil;
var
  HTMLContent: string;
  Owner, Share: string;
  StartPos, EndPos, RowIndex: Integer;
begin
  HTMLContent := RichEdit2.Lines.Text;

  StringGrid2.RowCount := 1;
  StringGrid2.ColCount := 2;
  RowIndex := 0;

  StartPos := Pos('<td>', HTMLContent);
  while StartPos > 0 do
  begin
    EndPos := PosEx('</td>', HTMLContent, StartPos);
    Owner := Copy(HTMLContent, StartPos + 4, EndPos - StartPos - 4);

    StartPos := PosEx('<td class=right>', HTMLContent, EndPos);
    EndPos := PosEx('</td>', HTMLContent, StartPos);
    Share := Copy(HTMLContent, StartPos + 16, EndPos - StartPos - 16);

    StringGrid2.RowCount := RowIndex + 1;
    StringGrid2.Cells[0, RowIndex] := Trim(Owner);
    StringGrid2.Cells[1, RowIndex] := Trim(Share);

    Inc(RowIndex);

    StartPos := PosEx('<td>', HTMLContent, EndPos);
  end;
end;

procedure TmainForm.Button2Click(Sender: TObject);
begin
  VyplnitDoExcelu(StringGrid1, ExtractFilePath(Application.ExeName) + 'Seznam dotèených vlastníkù.xlsx');
end;

procedure TmainForm.Button3Click(Sender: TObject);
begin
  ShowMessage('2024' + sLineBreak +
              'Vita Srutek' + sLineBreak +
              'https://github.com/vitasrutek/CUZK-scraper' + sLineBreak +
              'at GPL-3.0 license');
end;

procedure TmainForm.Button4Click(Sender: TObject);
begin
  clearForm.Show;
end;

procedure TmainForm.FVypis2;
var
  i, Row: integer;
begin
  sleep(50);
  FOmezeni;
  sleep(50);
  FOchana;
  sleep(50);
  VysekCisloKU;
  sleep(50);
  VysekObec;
  sleep(50);
  VysekLV;
  sleep(50);
  VysekParcela;
  sleep(50);
  VysekVymera;
  sleep(50);
  VysekDruh;
  sleep(50);
  VysekTyp;
  sleep(50);
  FJine;
  sleep(50);
  VysekVyuziti;
  sleep(50);

  {ShowMessage('Omezeni: '+  Omezeni + sLineBreak +
              'Ochrana: ' + Ochrana + sLineBreak +
              'KU: ' + KU + sLineBreak +
              'Cislo KU: ' +CisloKU + sLineBreak +
              'Obec: ' + Obec + sLineBreak +
              'LV: ' + LV + sLineBreak +
              'Parcela: ' + Parcela + sLineBreak +
              'Vymera: ' + Vymera + sLineBreak +
              'Druh: ' + Druh + sLineBreak +
              'Typ: ' + Typ + sLineBreak +
              'Jine: ' + Jine + sLineBreak +
              'Vyuziti: ' + Vyuziti);
  }
  VysekVlastnici;
  HTMLdoGrid(RichEdit2.Text);

  sleep(1000);
  Application.ProcessMessages;
  for i := 0 to StringGrid2.RowCount - 1 do
  begin
      Row := StringGrid1.RowCount - 1;    // -1
      RozdelitVlastnika(StringGrid2.Cells[0, i], jmeno, ulice, mesto, psc);
      StringGrid1.Cells[19, row] := jmeno;
      StringGrid1.Cells[22, row] := ulice;
      StringGrid1.Cells[23, row] := mesto;
      StringGrid1.Cells[24, row] := psc;
      StringGrid1.Cells[20, row] := StringGrid2.Cells[1, i];
      StringGrid1.Cells[2, row] := Obec;
      StringGrid1.Cells[7, row] := Parcela;
      StringGrid1.Cells[15, row] := Vyuziti;

      StringGrid1.Cells[0, row] := KU;
      StringGrid1.Cells[4, row] := Kraj;
      StringGrid1.Cells[1, row] := cisloKU;
      StringGrid1.Cells[9, row] := LV;
      StringGrid1.Cells[13, row] := Vymera;
      StringGrid1.Cells[14, row] := Druh;
      StringGrid1.Cells[10, row] := Typ;
      if Jine <> '' then
        StringGrid1.Cells[18, row] := Omezeni + ', ' + Jine
      else
       StringGrid1.Cells[18, row] := Omezeni;
      StringGrid1.Cells[17, row] := Ochrana;
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
  end;
  EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/VyberParcelu/Parcela/InformaceO');

  if parcela_radek = (MemoParcely.Lines.Count) then
    begin
      Button2.Font.Style := Font.Style + [TFontStyle.fsBold];
      Button10.Font.Style := Font.Style - [TFontStyle.fsBold];
      Showmessage('Všechny parcely byly vyspány, mùže být proveden export do Excelu.');
    end
    else
    begin
      Button17.Font.Style := Font.Style + [TFontStyle.fsBold];
      Button10.Font.Style := Font.Style - [TFontStyle.fsBold];
    end;
end;

procedure TmainForm.Button5Click(Sender: TObject);
var
  i: integer;
begin
  if RadioButton1.Checked then
    begin
      repeat
        begin
          sleep(500);
          Application.ProcessMessages;
        end;
      until Nacteno = True;
      sleep(200);
      Application.ProcessMessages;
      VyznaceniRadku(parcela_radek);
      zadatParcelu;
      parcela_radek := parcela_radek + 1;

      repeat
        begin
          sleep(500);
          Application.ProcessMessages;
        end;
      until Nacteno = True;
      sleep(200);
      Application.ProcessMessages;

      FVypis2;
    end
  else
  if RadioButton2.Checked then
    begin
      for i := 0 to MemoParcely.Lines.Count - 1 do
        begin
          repeat
            begin
              sleep(500);
              Application.ProcessMessages;
            end;
          until Nacteno = True;
          sleep(200);
          Application.ProcessMessages;
          VyznaceniRadku(parcela_radek);
          zadatParcelu;
          parcela_radek := parcela_radek + 1;

          repeat
            begin
              sleep(500);
              Application.ProcessMessages;
            end;
          until Nacteno = True;
          sleep(200);
          Application.ProcessMessages;

          FVypis2;
          Sleep(1500);
          Application.ProcessMessages;
        end;
    end;
end;

procedure TmainForm.EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
begin
  if AResultObjectAsJson <> 'null' then
    begin
      RichEdit1.Text := TNetEncoding.URL.Decode(AResultObjectAsJson).DeQuotedString('"');
    end;
end;

procedure TmainForm.EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
  IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
begin
  if IsSuccess then
  begin
    Nacteno := True;
    Sleep(500);
    Application.ProcessMessages;
    EdgeBrowser1.ExecuteScript('encodeURI(document.documentElement.outerHTML)');
  end
  else
  begin
    Nacteno := False;
  end;

end;

procedure TmainForm.EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser;
  Args: TNavigationStartingEventArgs);
begin
  Nacteno := False;
end;

procedure TmainForm.EdgeBrowser1SourceChanged(Sender: TCustomEdgeBrowser;
  IsNewDocument: Boolean);
begin
  if IsNewDocument then
    begin
      EdgeBrowser1.ExecuteScript('encodeURI(document.documentElement.outerHTML)');
      sleep(500);
      Application.ProcessMessages;
    end;
end;

procedure TmainForm.FormCreate(Sender: TObject);
begin
  Nacteno := False;
  Vypsano := False;
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

  ComboBox_katastr.Items.LoadFromFile('KU.txt');
end;

procedure TmainForm.zadatParcelu;
var
  cisloPredLomitkem, cisloZaLomitkem: Integer;
  obsahujeLomitko: Boolean;
begin
  aktualni_parcela := 'PRAZDNE';
  aktualni_parcela := MemoParcely.Lines[parcela_radek];
  if Copy(aktualni_parcela, 1, 4) = 'st. ' then
    begin
      aktualni_parcela := copy(aktualni_parcela, 5, Length(aktualni_parcela));
      EdgeBrowser1.ExecuteScript(
        'var radioButton = document.getElementById(''ctl00_bodyPlaceHolder_druhCislovani_0'');' +
        'if (radioButton) {' +
        '  radioButton.checked = true;' +
        '}'
      );
    end;
  RozdelitParcelu(aktualni_parcela, cisloPredLomitkem, cisloZaLomitkem, obsahujeLomitko);
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
      'document.getElementById(''ctl00_bodyPlaceHolder_btnVyhledat'').click();' +
    'var interval = setInterval(function() {' +
    '  var resultElement = document.getElementById(''ctl00_bodyPlaceHolder_resultDiv'');' +
    '  if (resultElement) {' +
    '    clearInterval(interval);' +
    '    window.chrome.webview.postMessage(encodeURI(document.documentElement.outerHTML));' +
    '  }' +
    '}, 1000);'
  );
  end
  else
  begin
    EdgeBrowser1.ExecuteScript(
    'var inputElement = document.getElementById(''ctl00_bodyPlaceHolder_txtParcis'');' +
    'if (inputElement) {' +
    '  inputElement.value = ''' + aktualni_parcela + ''';' +
    '}' +
    'document.getElementById(''ctl00_bodyPlaceHolder_btnVyhledat'').click();' +
    'var interval = setInterval(function() {' +
    '  var resultElement = document.getElementById(''ctl00_bodyPlaceHolder_resultDiv'');' +
    '  if (resultElement) {' +
    '    clearInterval(interval);' +
    '    window.chrome.webview.postMessage(encodeURI(document.documentElement.outerHTML));' +
    '  }' +
    '}, 1000);'
  );
  end;
  GroupBox1.Caption := 'Prohlížeè: ' + 'parcela ' + (MemoParcely.Lines[parcela_radek]);
end;

procedure TmainForm.zadatKU;
begin
  EdgeBrowser1.ExecuteScript(
    'var inputElement = document.getElementById(''ctl00_bodyPlaceHolder_vyberObecKU_vyberKU_txtKU'');' +
    'if (inputElement) {' +
    '  inputElement.value = ''' + ComboBox_katastr.text + ''';' +
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

procedure TMainForm.RozdelitVlastnika(const vstupniRetezec: string; var jmeno, ulice, mesto, psc: string);
var
  seznam: TStringDynArray;
  i: Integer;
  mestoText, mestoTextOriginal: string;
begin
  jmeno := '';
  ulice := '';
  mesto := '';
  psc := '';
  mestoText := '';
  begin
    seznam := SplitString(vstupniRetezec, ',');
    if Length(seznam) = 4 then
    begin
      jmeno := seznam[0];
      ulice := Copy(seznam[1], 2, Length(seznam[1]));
      mestoText := copy(seznam[3], 8, Length(seznam[3]));   //7
      mestoTextOriginal := mestoText;
      for i := 1 to Length(mestoText) do
      begin
        CharLowerBuffW(@mestoText[i], 1);
        if (mestoText[i] >= 'a') and (mestoText[i] <= 'z') or
           (mestoText[i] >= 'á') and (mestoText[i] <= 'ž') or
           (mestoText[i] = ' ') then
        begin
          mesto := mesto + mestoTextOriginal[i];
        end;
      end;
      psc := copy(seznam[3], 2, 5);
    end
    else
    if Length(seznam) = 3 then
      begin
        jmeno := seznam[0];
        ulice := Copy(seznam[1], 2, Length(seznam[1]));         //  ulice := seznam[1];
        psc := copy(seznam[2], 2, 5);   //1, 6
        mestoText := copy(seznam[2], 8, length(seznam[2])); //5,
        mestoTextOriginal := mestoText;
        for i := 1 to Length(mestoText) do
          begin
            CharLowerBuffW(@mestoText[i], 1);
            if (mestoText[i] >= 'a') and (mestoText[i] <= 'z') or
               (mestoText[i] >= 'á') and (mestoText[i] <= 'ž') or
               (mestoText[i] = ' ') then
            begin
              mesto := mesto + mestoTextOriginal[i];
            end;
          end;
      end
    else
    if Length(seznam) = 5 then
      begin
        jmeno := seznam[0];
        ulice := Copy(seznam[2], 2, length(seznam[2]));  // ulice := seznam[2];
        mesto := copy(seznam[4], 7, Length(seznam[4]));
        psc := copy(seznam[4], 1, 6);
      end
    else
    if Length(seznam) = 1 then
      begin
        jmeno := seznam[0];
        ulice := 'N/A';
        mesto := 'N/A';
        psc := 'N/A';
      end
  end
end;

procedure TmainForm.Timer1Timer(Sender: TObject);
begin
  if Nacteno = True then
    ToggleSwitch1.State := tssOn
  else
    ToggleSwitch1.State := tssOff;
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
