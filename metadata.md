# Comunicare l'Unione Europea

Analisi della copertura delle elezioni europee del 2019 nella televisione italiana (contenuti trasmessi da "#cartabianca" e "Dritto e Rovescio"). Dataset allegato alla tesi triennale di Chiara Adornetto

## Repository structure 
```
.
├── README.md
├── data
│   └── trasmissioni.csv
├── datapackage.json
├── datapackage.yaml
├── metadata.md
├── requirements.txt
├── script.sh
└── template.md
```

## Data Dictionary 
### 📄 contenuti
- Path: `data/contenuti.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| name | type | description |
| --- | --- | --- |
| id_contenuto | string | Codice identificativo del contenuto trasmesso |
| id_puntata | string | Codice identificativo della puntata |
| tipologia | string | Tipologia del contenuto trasmesso |
| UE | boolean | Indicatore dei contenuti legati all'Unione Europea |
| id_ospite | string | Codici identificativi ospiti separati da virgole |
| keyword | string | Parole chiave degli argomenti trattati |
| start | time | Coordinata temporale inizio intervento |
| end | time | Coordinata temporale fine intervento |
| sentiment | string | Sentiment attribuito all'intervento |

### 📄 ospiti
- Path: `data/ospiti.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| name | type | description |
| --- | --- | --- |
| id_contenuto | string | Codice identificativo del contenuto trasmesso |
| id_puntata | string | Codice identificativo della puntata |
| tipologia | string | Tipologia del contenuto trasmesso |
| UE | boolean | Indicatore dei contenuti legati all'Unione Europea |
| id_ospite | string | Codici identificativi ospiti separati da virgole |
| keyword | string | Parole chiave degli argomenti trattati |
| start | time | Coordinata temporale inizio intervento |
| end | time | Coordinata temporale fine intervento |
| sentiment | string | Sentiment attribuito all'intervento |

### 📄 puntate
- Path: `data/puntate.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| name | type | description |
| --- | --- | --- |
| id_contenuto | string | Codice identificativo del contenuto trasmesso |
| id_puntata | string | Codice identificativo della puntata |
| tipologia | string | Tipologia del contenuto trasmesso |
| UE | boolean | Indicatore dei contenuti legati all'Unione Europea |
| id_ospite | string | Codici identificativi ospiti separati da virgole |
| keyword | string | Parole chiave degli argomenti trattati |
| start | time | Coordinata temporale inizio intervento |
| end | time | Coordinata temporale fine intervento |
| sentiment | string | Sentiment attribuito all'intervento |

### 📄 trasmissioni
- Path: `data/trasmissioni.csv`
- URL:
- Delimiter:
- Encoding: `utf-8`

| name | type | description |
| --- | --- | --- |
| id_contenuto | string | Codice identificativo del contenuto trasmesso |
| id_puntata | string | Codice identificativo della puntata |
| tipologia | string | Tipologia del contenuto trasmesso |
| UE | boolean | Indicatore dei contenuti legati all'Unione Europea |
| id_ospite | string | Codici identificativi ospiti separati da virgole |
| keyword | string | Parole chiave degli argomenti trattati |
| start | time | Coordinata temporale inizio intervento |
| end | time | Coordinata temporale fine intervento |
| sentiment | string | Sentiment attribuito all'intervento |


## 🕮 License
Quest'opera è distribuita con Licenza [Creative Commons Attribution 4.0 ](https://creativecommons.org/licenses/by/4.0/) (CC-BY-4.0)

## 👥 Contributors
| Name | Role | Email |
| --- | --- | --- |
| Chiara Adornetto | author | chiara.adornetto.it |
| Dennis Angemi | maintainer | dennisangemi.com |
