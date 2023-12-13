# CUZK-scraper
Jednoduché stahování informací z CUZK, byť lehce manuální.

Stahování informací z CUZK je prakticky identické s vybíráním parcel a informací k nim jako přes webový prohlížeč. Zde jsou dané informace ukládány do tabulky.

Nepodařilo se mi civilizovaně zajistit plnou automatizaci z důvodu omezených možností komponenty EdgeBrowser oproti WebBrowser, kde bylo možné vše téměř provést procedurami (ale nešel JavaScript).
Lze řešit pomocí přihlášení přes třeba Egovernment nebo klasicky přes Captcha.

6 tlačítek, postupně se musí použít jedno po druhém.

Pro kompilaci je třeba komponent Excel_TLB (součást Office - instalace přes Import Component) a EdgeView2 SDK (přes GetIt).
Více info o EdgeBrowser - https://docwiki.embarcadero.com/RADStudio/Sydney/en/Using_TEdgeBrowser_Component_and_Changes_to_the_TWebBrowser_Component
