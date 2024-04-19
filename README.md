# CUZK-scraper
Jednoduché stahování informací z CUZK, byť lehce manuální.

![Screenshot](obrazek2.png)

Stahování informací z CUZK je prakticky identické s vybíráním parcel a informací k nim jako přes webový prohlížeč. Zde jsou dané informace ukládány do tabulky.

Nepodařilo se mi civilizovaně zajistit plnou automatizaci z důvodu omezených možností komponenty EdgeBrowser oproti WebBrowser, kde bylo možné vše téměř provést procedurami (ale nešel JavaScript).
Lze řešit pomocí přihlášení přes třeba Egovernment nebo klasicky přes Captcha.

4 nejdůležitější tlačítka - postupně se musí použít jedno po druhém - je tam časovač u těch, které přistupují do schránky, aby nedošlo ke kolizi dat -- zvýraznění.

Pro kompilaci je třeba komponent Excel_TLB (součást Office - instalace přes Import Component) a EdgeView2 SDK (přes GetIt).
Více info o EdgeBrowser - https://docwiki.embarcadero.com/RADStudio/Sydney/en/Using_TEdgeBrowser_Component_and_Changes_to_the_TWebBrowser_Component


## Update 04/2024
Pokud je uživatel přihlášen do KN, lze provést částečnou automatizaci tlačítkem "vypsat parcelu", kdy dojde k načtení stránky s parcelou a následnému vypsání do tabulky. Vždy jen pro jednu parcelu. Opětovným stiskem dojde k výpisu následující parcely ze seznamu.

### Používání aplikace s přihlášením
1. Vypsat název katastrálního území
2. Vypsat seznam pozemků k výpisu (co řádek to pozemek)
3. Tlačítko "Načtení CUZK"
4. přihlašení přes třeba eGovernment - je potřeba vyscrollovat nahoru a vybrat přihlášení atd..
5. Tlačítko "Zadání KU"
6. Tlačítko "vypsat parcelu"
7. Pokud je potřeba další parcely, opakuje se krok č.6
8. Úprava seznamu parcel je možná jen přidáváním pozemků na konec seznamu
9. Výpis dat do Excelu je proveden tlačítkem "Vytvořit EXCEL"

### Používání aplikace bez přihlášení (výpis přes CAPTCHA)
1. Vypsat název katastrálního území
2. Vypsat seznam pozemků k výpisu (co řádek to pozemek)
3. Tlačítko "Načtení CUZK"
4. Tlačítko "Zadání KU"
   - vždy je vhodné čekat na vytučnění tlačítka (časovač)
6. Tlačítko "Zadání parcely"
7. Tlačítko "Označení dat"
8. Tlačítko "Kopie a příprava"
9. Tlačítko "Výpis hodnot"
10. Pokud je potřeba další parcely, opakuje se krok č.6
11. Úprava seznamu parcel je možná jen přidáváním pozemků na konec seznamu
12. Výpis dat do Excelu je proveden tlačítkem "Vytvořit EXCEL"


Vzhledem k tomu, že způsob přenosu informací mezi EdgeBrowser komponentou a aplikací samotnou není zcela stoprocentní, neprovádí se výpis pro všechny parcely kvůli omezenému přístupu do schránky.   

!! Pakliže dojde k nějaké chybě ve výpisu dat, objeví se hláška s tím, že je potřeba provést dodatečnou kontrolu u nějakého pozemku. Program ale pokračuje dál ve výpisu.
