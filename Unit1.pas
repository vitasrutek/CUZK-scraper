unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, MSHTML,
  Winapi.WebView2, Vcl.Edge, Vcl.ExtCtrls, System.Win.ComObj, Winapi.ActiveX, System.Net.URLClient,
  FMX.WebBrowser, System.Net.HttpClient, System.IOUtils, Clipbrd, StrUtils, System.Types, Excel_TLB,
  Vcl.Grids,
  System.NetEncoding, System.UITypes;

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
    MemoStranka: TMemo;
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
    GroupBox2: TGroupBox;
    Button4: TButton;
    GroupBox6: TGroupBox;
    Button17: TButton;
    Button11: TButton;
    Button10: TButton;
    Button15: TButton;
    Button3: TButton;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
      AResult: HRESULT; const AResultObjectAsJson: string);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    function GetTextAfterPrefixInLine(const Memo: TMemo; const Prefix: string; const LineIndex: Integer): string;
    function GetLineIndexOfText(const Memo: TMemo; const SearchText: string): Integer;
    procedure zadatParcelu;
    procedure zadatKU;
    procedure RozdelitParcelu(const vstupniCislo: string; var predLomitkem, zaLomitkem: Integer; var obsahujeLomitko: Boolean);
    procedure RozdelitVlastnika(const vstupniRetezec: string; var jmeno, ulice, mesto, psc, podil: string);
    procedure VyplnitDoExcelu(Grid: TStringGrid; const SouborCesta: string);
    procedure KopieStranky;
    procedure VyznaceniRadku(LineIndex: Integer);
    { Public declarations }
  end;

var
  mainForm: TmainForm;
  parcela_radek: integer;
  aktualni_parcela: string;

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

procedure Tmainform.KopieStranky;
var
  EdgeBrowser: TEdgeBrowser;
  Script: WideString;
begin
  MemoStranka.Clear;
  EdgeBrowser := EdgeBrowser1;

  if Assigned(EdgeBrowser) then
  begin
    Script :=
      'var textToCopy = document.body.innerText;' +
      'var textArea = document.createElement("textarea");' +
      'textArea.value = textToCopy;' +
      'document.body.appendChild(textArea);' +
      'textArea.select();' +
      'document.execCommand(''copy'');' +
      'document.body.removeChild(textArea);';

    EdgeBrowser.ExecuteScript(Script);
    sleep(1000);
  end;
end;

procedure TmainForm.Button10Click(Sender: TObject);
begin
  MemoStranka.Clear;
  MemoStranka.Text := Clipboard.AsText;

  sleep(500);

  Button15.Font.Style := Font.Style + [TFontStyle.fsBold];
  Button10.Font.Style := Font.Style - [TFontStyle.fsBold];
end;

procedure TmainForm.Button11Click(Sender: TObject);
begin
  KopieStranky;
  MemoStranka.Lines.Text := Clipboard.AsText;

  sleep(500);

  Button10.Font.Style := Font.Style + [TFontStyle.fsBold];
  Button11.Font.Style := Font.Style - [TFontStyle.fsBold];
end;

procedure TmainForm.Button13Click(Sender: TObject);
begin
  EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/VyberParcelu/Parcela/InformaceO');
  Button13.Font.Style := Font.Style - [TFontStyle.fsBold];
  Button16.Font.Style := Font.Style + [TFontStyle.fsBold];
end;

procedure TmainForm.Button15Click(Sender: TObject);
var
  row, radek, radek2, vlastniciRadek, i: integer;
  jmeno, ulice, mesto, psc, podil: string;
  KU1, KU2, KUText, KUTextOriginal, Obec, ObecText, ObecTextOriginal, parcela, LV, vymera, druh, vyuziti, ochrana, ochrana2, omezeni : string;
  seznam: TStringDynArray;
begin
  row := StringGrid1.RowCount - 1;

  radek := GetLineIndexOfText(MemoStranka, 'Katastr�ln�');
  KUText := GetTextAfterPrefixInLine(MemoStranka, 'Katastr�ln� �zem�:	', radek);
  KUTextOriginal := KUText;
  KU1 := '';
  for i := 1 to Length(KUText) do
    begin
      CharLowerBuffW(@KUText[i], 1);
      if (KUText[i] >= 'a') and (KUText[i] <= 'z') or
         (KUText[i] >= '�') and (KUText[i] <= '�') or
         (KUText[i] = ' ') then
      begin
        KU1 := KU1 + KUTextOriginal[i];
      end;
    end;
  StringGrid1.Cells[0, row] := KU1;

  KUText := GetTextAfterPrefixInLine(MemoStranka, 'Katastr�ln� �zem�:	', radek);
  KU2 := '';
  for i := 1 to Length(KUText) do
    if CharInSet(KUText[i], ['0'..'9']) then
      KU2 := KU2 + KUText[i];

  StringGrid1.Cells[1, row] := KU2;

  radek := GetLineIndexOfText(MemoStranka, 'Obec');
  ObecText := GetTextAfterPrefixInLine(MemoStranka, 'Obec:	', radek);
  ObecTextOriginal := ObecText;
  for i := 1 to Length(ObecText) do
    begin
      CharLowerBuffW(@ObecText[i], 1);
      if (ObecText[i] >= 'a') and (ObecText[i] <= 'z') or
         (ObecText[i] >= '�') and (ObecText[i] <= '�') or
         (ObecText[i] = ' ') then
      begin
        Obec := Obec + ObecTextOriginal[i];
      end;
    end;
  StringGrid1.Cells[2, row] := Obec;

  radek := GetLineIndexOfText(MemoStranka, 'Parceln�');
  Parcela := GetTextAfterPrefixInLine(MemoStranka, 'Parceln� ��slo:	', radek);
  StringGrid1.Cells[7, row] := Parcela;

  if StringGrid1.Cells[7, row] = MemoParcely.Lines[parcela_radek - 1] then
    else ShowMessage('Vyskytla se chyba u parcely �. ' + MemoParcely.Lines[parcela_radek - 1] + '.' + sLineBreak + 'Prove� kontrolu po ukon�en�.');

  radek := GetLineIndexOfText(MemoStranka, '��slo LV');
  LV := GetTextAfterPrefixInLine(MemoStranka, '��slo LV:	', radek);
  StringGrid1.Cells[9, row] := LV;

  radek := GetLineIndexOfText(MemoStranka, 'V�m�ra');
  Vymera := GetTextAfterPrefixInLine(MemoStranka, 'V�m�ra [m2]:	', radek);
  StringGrid1.Cells[13, row] := Vymera;

  radek := GetLineIndexOfText(MemoStranka, 'Druh pozemku');
  Druh := GetTextAfterPrefixInLine(MemoStranka, 'Druh pozemku:	', radek);
  StringGrid1.Cells[14, row] := Druh;

  radek := GetLineIndexOfText(MemoStranka, 'Zp�sob vyu�it�');
  Vyuziti := GetTextAfterPrefixInLine(MemoStranka, 'Zp�sob vyu�it�:	', radek);
  StringGrid1.Cells[15, row] := Vyuziti;

  radek := GetLineIndexOfText(MemoStranka, 'Zp�sob ochrany');
  if (Copy(MemoStranka.Lines[radek + 1], 1, 2)) = 'Ne' then   //Nen�
    begin
      ochrana := '';
      StringGrid1.Cells[17, row] := ochrana;
    end
    else
    if (Copy(MemoStranka.Lines[radek + 2], 1, 2)) = 'N�' then  //N�zev
      begin
        radek2 := GetLineIndexOfText(MemoStranka, 'Seznam BPEJ');
        for i := radek + 1 to radek2 do
          begin
            ochrana := MemoStranka.Lines[i + 1];
              if ochrana2 = '' then
                ochrana2 := ochrana
              else
                ochrana2 := ochrana2 + ', ' + ochrana;
          end;
        StringGrid1.Cells[17, row] := ochrana2;
      end
      else
      if (Copy(MemoStranka.Lines[radek + 1], 1, 2)) = 'N�' then  //N�zev
        begin
          ochrana := '';
          radek2 := GetLineIndexOfText(MemoStranka, 'Seznam BPEJ');
          for i := radek + 2 to radek2 -1 do
            begin
              ochrana := MemoStranka.Lines[i];
              if ochrana2 = '' then
                ochrana2 := ochrana
              else
                ochrana2 := ochrana2 + ', ' + ochrana;
            end;
          StringGrid1.Cells[17, row] := ochrana2;
        end;

  radek := GetLineIndexOfText(MemoStranka, 'Omezen� vlastnick�ho');
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

  radek := GetLineIndexOfText(MemoStranka, 'Vlastnick� pr�vo');
  if (Copy(MemoStranka.Lines[radek + 2], 1, 11)) = 'P��slu�nost' then
  begin
    try
      begin
        RozdelitVlastnika(MemoStranka.Lines[radek + 3]  , jmeno, ulice, mesto, psc, podil);
        StringGrid1.Cells[19, row] := jmeno;
        StringGrid1.Cells[22, row] := ulice;
        StringGrid1.Cells[23, row] := mesto;
        StringGrid1.Cells[24, row] := psc;
        StringGrid1.Cells[20, row] := podil;
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
      end
    except
      on E: Exception do
        begin
          StringGrid1.Cells[19, row] := jmeno;
          StringGrid1.RowCount := StringGrid1.RowCount + 1;
        end;
    end;
  end
  else
  if (Copy(MemoStranka.Lines[radek + 2], 1, 2)) = 'Zp' then
    begin
      try
        begin
          RozdelitVlastnika(MemoStranka.Lines[radek + 1]  , jmeno, ulice, mesto, psc, podil);
          StringGrid1.Cells[19, row] := jmeno;
          StringGrid1.Cells[22, row] := ulice;
          StringGrid1.Cells[23, row] := mesto;
          StringGrid1.Cells[24, row] := psc;
          StringGrid1.Cells[20, row] := podil;
          StringGrid1.RowCount := StringGrid1.RowCount + 1;
        end
      except
        on E: Exception do
          begin
            StringGrid1.Cells[19, row] := jmeno;
            StringGrid1.RowCount := StringGrid1.RowCount + 1;
          end;
      end;
    end
    else
    begin
      radek2 := GetLineIndexOfText(MemoStranka, 'Zp�sob ochrany nemovitosti');
      try
        vlastniciRadek := (radek + 1);
        while vlastniciRadek <= (radek2 - 1) do
        begin
          seznam := SplitString(MemoStranka.Lines[vlastniciRadek], ',');
          if Length(seznam) > 2 then
          begin
            RozdelitVlastnika(MemoStranka.Lines[vlastniciRadek]  , jmeno, ulice, mesto, psc, podil);
            StringGrid1.Cells[19, row] := jmeno;
            StringGrid1.Cells[22, row] := ulice;
            StringGrid1.Cells[23, row] := mesto;
            StringGrid1.Cells[24, row] := psc;
            StringGrid1.Cells[20, row] := podil;

            StringGrid1.Cells[0, row] := KU1;
            StringGrid1.Cells[1, row] := KU2;
            StringGrid1.Cells[2, row] := Obec;
            StringGrid1.Cells[7, row] := Parcela;
            StringGrid1.Cells[9, row] := LV;
            StringGrid1.Cells[13, row] := Vymera;
            StringGrid1.Cells[14, row] := Druh;
            StringGrid1.Cells[15, row] := Vyuziti;
            StringGrid1.Cells[17, row] := Ochrana2;
            StringGrid1.Cells[18, row] := Omezeni;

            StringGrid1.RowCount := StringGrid1.RowCount + 1;
            row := StringGrid1.RowCount - 1;
          end
          else
          if copy(MemoStranka.Lines[vlastniciRadek], 1, 3) = 'SJM' then
          begin
            RozdelitVlastnika(MemoStranka.Lines[vlastniciRadek]  , jmeno, ulice, mesto, psc, podil);
            StringGrid1.Cells[20, row] := 'SJM ' + podil;

            RozdelitVlastnika(MemoStranka.Lines[vlastniciRadek + 1]  , jmeno, ulice, mesto, psc, podil);
            StringGrid1.Cells[19, row] := jmeno;
            StringGrid1.Cells[22, row] := ulice;
            StringGrid1.Cells[23, row] := mesto;
            StringGrid1.Cells[24, row] := psc;

            StringGrid1.Cells[0, row] := KU1;
            StringGrid1.Cells[1, row] := KU2;
            StringGrid1.Cells[2, row] := Obec;
            StringGrid1.Cells[7, row] := Parcela;
            StringGrid1.Cells[9, row] := LV;
            StringGrid1.Cells[13, row] := Vymera;
            StringGrid1.Cells[14, row] := Druh;
            StringGrid1.Cells[15, row] := Vyuziti;
            StringGrid1.Cells[17, row] := Ochrana2;
            StringGrid1.Cells[18, row] := Omezeni;

            vlastniciRadek := vlastniciRadek + 1;

            StringGrid1.RowCount := StringGrid1.RowCount + 1;
            row := StringGrid1.RowCount - 1;


            RozdelitVlastnika(MemoStranka.Lines[vlastniciRadek + 1]  , jmeno, ulice, mesto, psc, podil);
            StringGrid1.Cells[19, row] := jmeno;
            StringGrid1.Cells[22, row] := ulice;
            StringGrid1.Cells[23, row] := mesto;
            StringGrid1.Cells[24, row] := psc;
            StringGrid1.Cells[20, row] := StringGrid1.Cells[20, row - 1];//podil;

            StringGrid1.Cells[0, row] := KU1;
            StringGrid1.Cells[1, row] := KU2;
            StringGrid1.Cells[2, row] := Obec;
            StringGrid1.Cells[7, row] := Parcela;
            StringGrid1.Cells[9, row] := LV;
            StringGrid1.Cells[13, row] := Vymera;
            StringGrid1.Cells[14, row] := Druh;
            StringGrid1.Cells[15, row] := Vyuziti;
            StringGrid1.Cells[17, row] := Ochrana2;
            StringGrid1.Cells[18, row] := Omezeni;

            vlastniciRadek := vlastniciRadek + 1;

            StringGrid1.RowCount := StringGrid1.RowCount + 1;
            row := StringGrid1.RowCount - 1;
          end
          else                 //pokud je to SJM s rozd�ln�mi adresami a jsou tud� 2 pod t�mto      //a pakli�e to tak nen�, to nen� good..
          begin
            RozdelitVlastnika(MemoStranka.Lines[vlastniciRadek + 1]  , jmeno, ulice, mesto, psc, podil);
            StringGrid1.Cells[19, row] := jmeno;
            StringGrid1.Cells[22, row] := ulice;
            StringGrid1.Cells[23, row] := mesto;
            StringGrid1.Cells[24, row] := psc;
            StringGrid1.Cells[20, row] := podil;

            StringGrid1.Cells[0, row] := KU1;
            StringGrid1.Cells[1, row] := KU2;
            StringGrid1.Cells[2, row] := Obec;
            StringGrid1.Cells[7, row] := Parcela;
            StringGrid1.Cells[9, row] := LV;
            StringGrid1.Cells[13, row] := Vymera;
            StringGrid1.Cells[14, row] := Druh;
            StringGrid1.Cells[15, row] := Vyuziti;
            StringGrid1.Cells[17, row] := Ochrana2;
            StringGrid1.Cells[18, row] := Omezeni;

            vlastniciRadek := vlastniciRadek + 1;

            StringGrid1.RowCount := StringGrid1.RowCount + 1;
            row := StringGrid1.RowCount - 1;
          end;
          vlastniciRadek := vlastniciRadek + 1;
        end
      except
        on E: Exception do
          begin
            StringGrid1.Cells[19, row] := jmeno;
            StringGrid1.RowCount := StringGrid1.RowCount + 1;
            row := StringGrid1.RowCount - 1;
          end;
      end;
    end;
  EdgeBrowser1.Navigate('https://nahlizenidokn.cuzk.cz/VyberParcelu/Parcela/InformaceO');

  if parcela_radek = (MemoParcely.Lines.Count) then
    begin
      Button2.Font.Style := Font.Style + [TFontStyle.fsBold];
      Button15.Font.Style := Font.Style - [TFontStyle.fsBold];
      Showmessage('V�echny parcely byly vysp�ny, m��e b�t proveden export do Excelu.');
    end
    else
    begin
      Button17.Font.Style := Font.Style + [TFontStyle.fsBold];
      Button15.Font.Style := Font.Style - [TFontStyle.fsBold];
    end;
end;

procedure TmainForm.Button16Click(Sender: TObject);
begin
  zadatKU;
  Button17.Font.Style := Font.Style + [TFontStyle.fsBold];
  Button16.Font.Style := Font.Style - [TFontStyle.fsBold];
end;

procedure TmainForm.Button17Click(Sender: TObject);
begin
  VyznaceniRadku(parcela_radek);
  zadatParcelu;
  parcela_radek := parcela_radek + 1;
  Button11.Font.Style := Font.Style + [TFontStyle.fsBold];
  Button17.Font.Style := Font.Style - [TFontStyle.fsBold];
end;

procedure TmainForm.Button1Click(Sender: TObject);
begin
  parcela_radek := 0;
end;

procedure TmainForm.Button2Click(Sender: TObject);
begin
  VyplnitDoExcelu(StringGrid1, ExtractFilePath(Application.ExeName) + 'Seznam dot�en�ch vlastn�k�.xlsx');
end;

procedure TmainForm.Button3Click(Sender: TObject);
begin
  ShowMessage('2024' + sLineBreak +
              'Vita Srutek' + sLineBreak +
              'https://github.com/vitasrutek/CUZK-scraper' + sLineBreak +
              'at GPL-3.0 license');
end;

procedure TmainForm.Button4Click(Sender: TObject);
//var
  //i: integer;
begin
  //for i := 0 to MemoParcely.Lines.Count - 1 do
  begin
    Button17.Click;
    Application.ProcessMessages;
    Sleep(750);
    Button11.Click;
    Application.ProcessMessages;
    Sleep(750);
    Button10.Click;
    Application.ProcessMessages;
    Sleep(750);
    Button15.Click;
    Application.ProcessMessages;
    Sleep(750);
  end;
end;

procedure TmainForm.EdgeBrowser1ExecuteScript(Sender: TCustomEdgeBrowser;
  AResult: HRESULT; const AResultObjectAsJson: string);
begin
  if AResultObjectAsJson <> 'null' then
    MemoStranka.Text := TNetEncoding.URL.Decode(AResultObjectAsJson).DeQuotedString('"');
end;

procedure TmainForm.FormCreate(Sender: TObject);
begin
  Stringgrid1.Cells[0, 0] := 'N�zev K�';
  Stringgrid1.Cells[1, 0] := '��slo K�';
  Stringgrid1.Cells[2, 0] := 'Obec';
  Stringgrid1.Cells[3, 0] := '��st obce';
  Stringgrid1.Cells[4, 0] := 'Kraj';
  Stringgrid1.Cells[5, 0] := 'Pracovi�t�';
  Stringgrid1.Cells[6, 0] := 'Typ';
  Stringgrid1.Cells[7, 0] := 'Parcela';
  Stringgrid1.Cells[8, 0] := 'Budova';
  Stringgrid1.Cells[9, 0] := 'LV';
  Stringgrid1.Cells[10, 0] := 'Typ parcely';
  Stringgrid1.Cells[11, 0] := 'Zdroj';
  Stringgrid1.Cells[12, 0] := 'Typ budovy';
  Stringgrid1.Cells[13, 0] := 'V�m�ra';
  Stringgrid1.Cells[14, 0] := 'Druh pozemku';
  Stringgrid1.Cells[15, 0] := 'Zp�sob vyu�it�';
  Stringgrid1.Cells[16, 0] := 'Platnost';
  Stringgrid1.Cells[17, 0] := 'Zp�sob ochrany';
  Stringgrid1.Cells[18, 0] := 'Omezen�';
  Stringgrid1.Cells[19, 0] := 'Jm�no';
  Stringgrid1.Cells[20, 0] := 'Pod�l';
  Stringgrid1.Cells[21, 0] := 'vztah';
  Stringgrid1.Cells[22, 0] := 'Adresa';
  Stringgrid1.Cells[23, 0] := 'Adresa obec';
  Stringgrid1.Cells[24, 0] := 'PS�';

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
  RozdelitParcelu(aktualni_parcela, cisloPredLomitkem, cisloZaLomitkem, obsahujeLomitko);           //bylo MemoParcely.Lines[parcela_radek]
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
      '  inputElement.value = ''' + aktualni_parcela + ''';' +                                   /// bylo MemoParcela
      '}' +
      'document.getElementById(''ctl00_bodyPlaceHolder_btnVyhledat'').click();'
      );
    end;
  GroupBox1.Caption := 'Prohl�e�: ' + 'parcela ' + (MemoParcely.Lines[parcela_radek]);         /// nech�v�m MemoParcela kv�li kontrole
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
  indexA, i, tabulator: Integer;
  podilText, mestoText, mestoTextOriginal: string;
begin
  jmeno := '';
  ulice := '';
  mesto := '';
  psc := '';
  //podil := '';
  mestoText := '';
  podilText := '';
  begin
    seznam := SplitString(vstupniRetezec, ',');
    if Length(seznam) = 4 then                            /// kdo jich m� 5? Na�el jsem jen instituce viz n�e.. :-/
      begin
        jmeno := seznam[0];
        ulice := Copy(seznam[1], 2, Length(seznam[1]));
        //psc := copy(seznam[2], 2, 6);
        mestoText := copy(seznam[3], 8, Length(seznam[3]));  //bylo seznam-2
        mestoTextOriginal := mestoText;
        for i := 1 to Length(mestoText) do
          begin
            CharLowerBuffW(@mestoText[i], 1);
            if (mestoText[i] >= 'a') and (mestoText[i] <= 'z') or
               (mestoText[i] >= '�') and (mestoText[i] <= '�') or
               (mestoText[i] = ' ') then
              begin
                mesto := mesto + mestoTextOriginal[i];
              end;
          end;
        psc := copy(seznam[3], 2, 6);
        tabulator := Pos(Chr(9), vstupniRetezec);
        if tabulator > 0 then
          podil := Copy(vstupniRetezec, tabulator + 1, Length(vstupniRetezec) - tabulator)
          else
          podil := '1/1';
      end
      else
      if Length(seznam) = 3 then
        begin
          jmeno := seznam[0];
          //ulice := seznam[1];
          ulice := Copy(seznam[1], 2, Length(seznam[1]));
          psc := copy(seznam[2], 2, 6);
          mestoText := copy(seznam[2], 8, length(seznam[2]));
          mestoTextOriginal := mestoText;
          for i := 1 to Length(mestoText) do
            begin
              CharLowerBuffW(@mestoText[i], 1);
              if (mestoText[i] >= 'a') and (mestoText[i] <= 'z') or
                 (mestoText[i] >= '�') and (mestoText[i] <= '�') or
                 (mestoText[i] = ' ') then
              begin
                mesto := mesto + mestoTextOriginal[i];
              end;
            end;
          podil := '';
          tabulator := Pos(Chr(9), vstupniRetezec);
          if tabulator > 0 then
            podil := Copy(vstupniRetezec, tabulator + 1, Length(vstupniRetezec) - tabulator)
            else
            podil := '1/1';
        end
      else
      if Length(seznam) < 3 then
        begin
          podil := '';
          tabulator := Pos(Chr(9), vstupniRetezec);
          if tabulator > 0 then
            podil := Copy(vstupniRetezec, tabulator + 1, Length(vstupniRetezec) - tabulator)
            else
            podil := '1/1';
        end
      else // zkusmo pro Povod� atp.
      if Length(seznam) = 5 then
        begin
          jmeno := seznam[0];
          //ulice := seznam[2];
          ulice := Copy(seznam[2], 2, Length(seznam[2]));
          mesto := copy(seznam[4], 8, Length(seznam[4]));  //bylo seznam-2
          //mestoTextOriginal := mestoText;
          psc := copy(seznam[4], 2, 6);
          tabulator := Pos(Chr(9), vstupniRetezec);
          if tabulator > 0 then
            podil := Copy(vstupniRetezec, tabulator + 1, Length(vstupniRetezec) - tabulator)
            else
            podil := '1/1';
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
