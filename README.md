## Jak nainstalovat projekt

### Ručně
1. Nainstalujte Python
2. V termiálu (cmd, Powershell, bash, ...) se přesuňte do kořenu projektu 
3. Vytvořte virtuální prostředí pomocí: `python3 -m venv .venv`
4. Aktivujte prostředí pomocí: \
    Linux: `source .venv/bin/activate` \
    Windows: `.venv\Scripts\activate`
5. Spusťte příkaz: `pip install -r requirements.txt`
6. Spusťte aplikaci pomocí: `python app.py`
7. Ve webovém prohlížeči přejděte na adresu: [http://127.0.0.1:5000](http://127.0.0.1:5000)

### Pomocí instalačního programu (Windows)
1. Spusťte soubor: `install.bat`
2. Počkejte minutu, aby v pozadí vše naistalovalo