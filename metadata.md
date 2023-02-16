# Comunicare l'Unione Europea

Analisi della copertura delle elezioni europee del 2019 nella televisione italiana (contenuti trasmessi da "#cartabianca" e "Dritto e Rovescio"). Dataset allegato alla tesi triennale di Chiara Adornetto

## Repository structure 
```
.
├── METADATA.md
├── README.md
├── data
│   ├── dialect.json
│   └── trasmissioni.csv
├── datapackage.json
├── datapackage.yaml
├── diary.md
├── imieimetadatai.md
├── requirements.txt
├── script.sh
├── template.md
├── test.json
└── test.sh
```

## Data Dictionary 
### 📄 [contenuti](data/contenuti.csv)
- Path: `data/contenuti.csv`
- URL:
- Encoding: `utf-8`

| Field | Type | Description |
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

### 📄 [ospiti](data/ospiti.csv)
- Path: `data/ospiti.csv`
- URL:
- Delimiter: `,`
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id_ospite | string | Codice identificativo dell'ospite |
| nome | string |  |
| cognome | string |  |
| titolo | string | Professione o attività svolta |
| appartenenza | string | Testa giornalistica o partito politico di appartenenza |

### 📄 [puntate](data/puntate.csv)
- Path: `data/puntate.csv`
- URL:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| id_puntata | string | Codice identificativo della puntata |
| trasmissione | string | Denominazione della trasmissione |
| data | date | Data della messa in onda della puntata |
| durata_puntata | time | Durata della puntata |

### 📄 [trasmissioni](data/trasmissioni.csv)
- Path: `data/trasmissioni.csv`
- URL:
- Encoding: `utf-8`

| Field | Type | Description |
| --- | --- | --- |
| trasmissione | string | Denominazione della trasmissione |
| rete | string | Denominazione della rete televisiva |
| canale | string | Denominazione del canale televisivo |
| numero | integer | Numerazione LCN nazionale dei canali TV |


## 📖 License
This work is licensed under a [Creative Commons Attribution 4.0 ](https://creativecommons.org/licenses/by/4.0/) (CC-BY-4.0) License

## 👥 Contributors
| Name | Role | Email |
| --- | --- | --- |
| Chiara Adornetto | author | chiara.adornetto@tiscali.it |
| Dennis Angemi | maintainer | dennisangemi@gmail.com |
