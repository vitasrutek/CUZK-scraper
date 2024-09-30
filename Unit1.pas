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
    edit_katastr: TEdit;
    Button1: TButton;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    StringGrid1: TStringGrid;
    Splitter1: TSplitter;
    Panel4: TPanel;
    RichEdit1: TRichEdit;
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
    procedure Button10Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);
    procedure Button1Click(Sender: TObject);
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
      IsSuccess: Boolean; WebErrorStatus: COREWEBVIEW2_WEB_ERROR_STATUS);
    procedure Button5Click(Sender: TObject);
    procedure EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser;
      Args: TNavigationStartingEventArgs);
    procedure EdgeBrowser1SourceChanged(Sender: TCustomEdgeBrowser;
      IsNewDocument: Boolean);
  private
    { Private declarations }

  public
    procedure zadatParcelu;
    procedure zadatKU;
    procedure RozdelitParcelu(const vstupniCislo: string; var predLomitkem, zaLomitkem: Integer; var obsahujeLomitko: Boolean);
    procedure RozdelitVlastnika(const vstupniRetezec: string; var jmeno, ulice, mesto, psc: string);
    procedure VyplnitDoExcelu(Grid: TStringGrid; const SouborCesta: string);
    procedure ClearStringGrid(Grid: TStringGrid);
    procedure VysekParcela(const InputStr: string; var Parcela: string);
    procedure VysekVlastnici;
    procedure VysekOchrana;
    procedure VysekOmezeni;
    procedure VysekJine;
    procedure VysekObec(const InputStr: string; var Obec: string);
    procedure VysekLV(const InputStr: string; var LV: string);
    procedure VysekVymera(const InputStr: string; var Vymera: string);
    procedure VysekTyp(const InputStr: string; var Typ: string);
    procedure VysekDruh(const InputStr: string; var Druh: string);
    procedure VysekCisloKU(const InputStr: string; var cisloKU, KU: string);
    procedure LoadHTMLTableToGrid(HTMLSource: string);
    procedure InsertConcatenatedTextToCell(const RowIndex, ColumnIndex: Integer; var ResultString: string);

    function FParcela: string;
    function FObec: string;
    procedure FKU;
    function FLV: string;
    function FVymera: string;
    function FTyp: string;
    function FDruh: string;
    procedure FOmezeni;
    procedure FOchana;
    procedure Vlastnici;
    procedure FVlastniciPodil;
    procedure FVypis;

    procedure VyznaceniRadku(LineIndex: Integer);
    { Public declarations }

  end;

var
  mainForm: TmainForm;
  parcela_radek: integer;
  aktualni_parcela: string;
  Nacteno, Vypsano: Boolean;
  Parcela, omezeni, ochrana, jine, obec, cisloKU, KU, LV, vymera, typ, druh, jmeno, ulice, PSC, mesto: string;

implementation

{$R *.dfm}

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

function TMainForm.FParcela: string;
var
  InputStr: string;
begin
  Obec := '';
  InputStr := RichEdit1.Text;
  VysekParcela(InputStr, Parcela);
  if Parcela <> '' then
    Result := Parcela
  else
    Result := 'N/A';
end;

function TMainForm.FObec: string;
var
  InputStr: string;
begin
  Obec := '';
  InputStr := RichEdit1.Text;
  VysekObec(InputStr, Obec);
  if Obec <> '' then
    Result := Obec
  else
    Result := 'N/A';
end;

procedure TmainForm.FKU;
var
  InputStr: string;
begin
  KU := '';
  cisloKU := '';
  InputStr := RichEdit1.Text;
  VysekCisloKU(InputStr, cisloKU, KU);
  if (KU <> '') and (cisloKU <> '') then
  else
    begin
      KU := 'N/A';
      cisloKU := 'N/A';
    end
end;

function TmainForm.FLV: string;
var
  InputStr: string;
begin
  LV := '';
  InputStr := RichEdit1.Text;
  VysekLV(InputStr, LV);
  if LV <> '' then
    Result := LV
  else
    LV := 'N/A';
end;

function TmainForm.FVymera: string;
var
  InputStr: string;
begin
  InputStr := RichEdit1.Text;
  VysekVymera(InputStr, Vymera);
  if Vymera <> '' then
    Result := Vymera
  else
    Vymera := 'N/A';
end;

function TmainForm.FTyp: string;
var
  InputStr: string;
  TypParcely: string;
begin
  InputStr := RichEdit1.Text;
  VysekTyp(InputStr, TypParcely);
  if TypParcely <> '' then
    Result := TypParcely
  else
    TypParcely := 'N/A';
end;

function TmainForm.FDruh: string;
var
  InputStr: string;
begin
  druh := '';
  InputStr := RichEdit1.Text;
  VysekDruh(InputStr, druh);
  if druh <> '' then
    Result := Druh
  else
    Druh := 'N/A';
end;

procedure TmainForm.FOmezeni;
begin
  StringGrid2.RowCount := 1;
  StringGrid2.ColCount := 1;
  StringGrid2.Cells[0, 0] := '';
  VysekOmezeni;
  LoadHTMLTableToGrid(RichEdit2.Text);
  InsertConcatenatedTextToCell(1, 18, omezeni);
end;

procedure TmainForm.FOchana;
begin
  ClearStringGrid(StringGrid2);
  VysekOchrana;
  LoadHTMLTableToGrid(RichEdit2.Text);
  InsertConcatenatedTextToCell(1, 17, ochrana);
end;

procedure TmainForm.Vlastnici;
begin
  ClearStringGrid(StringGrid2);
  VysekVlastnici;
  LoadHTMLTableToGrid(RichEdit2.Text);
end;


//////////////////////////////////
//////////////////////////////////
//////////////////////////////////
//////////////////////////////////
//////////////////////////////////

procedure TmainForm.VysekParcela(const InputStr: string; var Parcela: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Parcelní èíslo:</td><td><a href=https://vdp.cuzk.cz/vdp/ruian/parcely/[^>]+>([^<]+)</a></td>');
  Match := Regex.Match(InputStr);
  if Match.Success then
    Parcela := Match.Groups[1].Value
  else
    Parcela := 'N/A';
end;

procedure TmainForm.VysekObec(const InputStr: string; var Obec: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Obec:</td><td><a href=https://vdp.cuzk.cz/vdp/ruian/obce/[^>]+>([^<]+) \[\d+\]</a></td>');
  Match := Regex.Match(InputStr);
  if Match.Success then
    Obec := Match.Groups[1].Value
  else
    Obec := 'N/A';
end;

procedure TmainForm.VysekLV(const InputStr: string; var LV: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Èíslo LV:</td><td><a href=[^>]+>[^<]*?(\d+)</a></td>');
  Match := Regex.Match(InputStr);
  if Match.Success then
    LV := Match.Groups[1].Value
  else
    LV := 'N/A';
end;

procedure TmainForm.VysekVymera(const InputStr: string; var Vymera: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Výmìra \[m<sup>2</sup>\]:</td><td>(\d+)</td>');
  Match := Regex.Match(InputStr);
  if Match.Success then
    vymera := Match.Groups[1].Value
  else
    vymera := 'N/A';
end;

procedure TmainForm.VysekTyp(const InputStr: string; var Typ: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Typ parcely:</td><td>([^<]+)</td>');
  Match := Regex.Match(InputStr);
  if Match.Success then
    typ := Match.Groups[1].Value
  else
    typ := 'N/A';
end;

procedure TmainForm.VysekDruh(const InputStr: string; var Druh: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Druh pozemku:</td><td>([^<]+)</td>');
  Match := Regex.Match(InputStr);
  if Match.Success then
    druh := Match.Groups[1].Value
  else
    druh := 'N/A';
end;

procedure TmainForm.VysekCisloKU(const InputStr: string; var cisloKU, KU: string);
var
  Regex: TRegEx;
  Match: TMatch;
begin
  Regex := TRegEx.Create('<td class=nazev>Katastrální území:</td><td><a href=[^>]+>([^<]+) \[(\d+)\]</a></td>');
  Match := Regex.Match(InputStr);
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

procedure TmainForm.ClearStringGrid(Grid: TStringGrid);
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


procedure TmainForm.LoadHTMLTableToGrid(HTMLSource: string);
var
  TableStart, TableEnd, RowStart, RowEnd, ColStart, ColEnd: Integer;
  TableHTML, TableRowHTML, TableHeaderHTML: string;
  TableRow, TableHeaderRow, TableColumn: TStringList;
  RowIndex, ColIndex: Integer;
begin
  TableStart := Pos('<table', HTMLSource);
  TableEnd := Pos('</table>', HTMLSource);

  if (TableStart > 0) and (TableEnd > TableStart) then
  begin
    TableHTML := Copy(HTMLSource, TableStart, TableEnd + Length('</table>') - TableStart);

    TableRow := TStringList.Create;
    TableHeaderRow := TStringList.Create;
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

      if TableRow.Count > 0 then
      begin
        TableHeaderHTML := TableRow[0];
        ColStart := Pos('<th>', TableHeaderHTML);
        while ColStart > 0 do
        begin
          ColEnd := Pos('</th>', TableHeaderHTML);
          TableHeaderRow.Add(Copy(TableHeaderHTML, ColStart + Length('<th>'), ColEnd - ColStart - Length('<th>')));
          Delete(TableHeaderHTML, 1, ColEnd);
          ColStart := Pos('<th>', TableHeaderHTML);
        end;

        StringGrid2.ColCount := 5;

        for RowIndex := 1 to TableRow.Count - 1 do
        begin
          TableColumn.Clear;
          TableHeaderHTML := TableRow[RowIndex];
          ColStart := Pos('<td>', TableHeaderHTML);
          while ColStart > 0 do
          begin
            ColEnd := Pos('</td>', TableHeaderHTML);
            TableColumn.Add(Copy(TableHeaderHTML, ColStart + Length('<td>'), ColEnd - ColStart - Length('<td>')));
            Delete(TableHeaderHTML, 1, ColEnd);
            ColStart := Pos('<td>', TableHeaderHTML);
          end;

          for ColIndex := 0 to TableColumn.Count - 1 do
            begin
              StringGrid2.Cells[ColIndex, RowIndex - 1] := TableColumn[ColIndex];
            end;
        end;
      end;
    finally
      TableRow.Free;
      TableHeaderRow.Free;
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
  ClearStringGrid(StringGrid2);
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
  ClearStringGrid(StringGrid2);
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
  ClearStringGrid(StringGrid2);
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
  ClearStringGrid(StringGrid2);
  HTML := RichEdit1.Text;

  StartPattern := '<table summary=Jiné zápisy cellspacing=0 class=zarovnat stinuj  >';
  TableHTML := ExtractTableHTML(HTML, StartPattern);

  RichEdit2.Text := TableHTML;
end;

procedure TmainForm.Button10Click(Sender: TObject);
var
  i, Row: integer;
begin
  sleep(500);
  FOmezeni;
  FOchana;
  FKU;

  VysekVlastnici;
  LoadHTMLTableToGrid(RichEdit2.Text);
  FVlastniciPodil;
  sleep(1000);
  for i := 0 to StringGrid2.RowCount - 1 do
    begin
      Row := StringGrid1.RowCount - 1;
      RozdelitVlastnika(StringGrid2.Cells[0, i], jmeno, ulice, mesto, psc);
      StringGrid1.Cells[19, row] := jmeno;
      StringGrid1.Cells[22, row] := ulice;
      StringGrid1.Cells[23, row] := mesto;
      StringGrid1.Cells[24, row] := psc;
      StringGrid1.Cells[20, row] := StringGrid2.Cells[1, i];
      StringGrid1.Cells[2, row] := FObec;
      StringGrid1.Cells[7, row] := FParcela;

      StringGrid1.Cells[0, row] := KU;
      StringGrid1.Cells[1, row] := cisloKU;
      StringGrid1.Cells[9, row] := FLV;
      StringGrid1.Cells[13, row] := FVymera;
      StringGrid1.Cells[14, row] := FDruh;
      StringGrid1.Cells[15, row] := FTyp;
      StringGrid1.Cells[18, row] := Omezeni;
      StringGrid1.Cells[17, row] := Ochrana;
      StringGrid1.RowCount := StringGrid1.RowCount + 1;
    end;

  sleep(1000);
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

procedure TmainForm.Button1Click(Sender: TObject);
begin
parcela_radek := 0;
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

procedure TmainForm.FVypis;
var
  i, Row: integer;
begin
  while not Nacteno do
    begin
      sleep(500);
      Application.ProcessMessages;
    end;
  sleep(500);
  Application.ProcessMessages;
  VyznaceniRadku(parcela_radek);
  zadatParcelu;
  parcela_radek := parcela_radek + 1;

  while not Nacteno do
    begin
      sleep(500);
      Application.ProcessMessages;
    end;
  sleep(500);
  Application.ProcessMessages;

  sleep(500);
  Application.ProcessMessages;

  FOmezeni;
  FOchana;
  FKU;

  VysekVlastnici;
  LoadHTMLTableToGrid(RichEdit2.Text);
  FVlastniciPodil;
  sleep(1000);
  Application.ProcessMessages;
  for i := 0 to StringGrid2.RowCount - 1 do
  begin
    Row := StringGrid1.RowCount - 1;
    RozdelitVlastnika(StringGrid2.Cells[0, i], jmeno, ulice, mesto, psc);
    StringGrid1.Cells[19, row] := jmeno;
    StringGrid1.Cells[22, row] := ulice;
    StringGrid1.Cells[23, row] := mesto;
    StringGrid1.Cells[24, row] := psc;
    StringGrid1.Cells[20, row] := StringGrid2.Cells[1, i];
    StringGrid1.Cells[2, row] := FObec;
    StringGrid1.Cells[7, row] := FParcela;

    StringGrid1.Cells[0, row] := KU;
    StringGrid1.Cells[1, row] := cisloKU;
    StringGrid1.Cells[9, row] := FLV;
    StringGrid1.Cells[13, row] := FVymera;
    StringGrid1.Cells[14, row] := FDruh;
    StringGrid1.Cells[15, row] := FTyp;
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
      FVypis;
    end
  else
  if RadioButton2.Checked then
    begin
      for i := 0 to MemoParcely.Lines.Count - 1 do
        begin
          FVypis;
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
      ulice := seznam[1];
      psc := copy(seznam[2], 1, 6);
      mestoText := copy(seznam[3], 7, Length(seznam[3]));
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
      psc := copy(seznam[3], 1, 6);
    end
    else
    if Length(seznam) = 3 then
      begin
        jmeno := seznam[0];
        ulice := seznam[1];
        psc := copy(seznam[2], 1, 6);
        mestoText := copy(seznam[2], 5, length(seznam[2]));
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
        ulice := seznam[2];
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
