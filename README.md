# 🔧 frictionless2md
A tool to convert frictionless metadata (datapackage.yaml or json) to md file that can me used as readme

You can obtain a README file like this

> screenshot of the README.md generated with the tool https://github.com/chiaraadornetto/dati-tv-elezioni-ue-2019#readme

## Installation
You can install this tool
```bash
apt-get bla bla instal bla bla frictionless2md
```

## Usage

Launch simply `frictionless2md` in the same directory where `datapackage.yaml` is located.

### Options

```bash
frictionless2md -f README.md
```

`-f README.md` declare the output filename

```bash
frictionless2md -u username repository-name -f README.md
```

`-u username repository-name` permits to define your github username and the name of the repo in which data are located. `-f README.md` at the same time declare the output filename.

Example:
```bash
frictionless2md -u dennisangemi ordinanze-covid -f README.md
```

## Test
2023-02-14
Installo jq https://stedolan.github.io/jq/
```bash
sudo apt-get install jq
```

Installo yq https://github.com/kislyuk/yq
```bash
pip install yp
```

faccio i primi test.

Per fare un prettyprint e trasformare yaml in json basta lanciare

```bash
cat datapackage.yaml | yq .
```

### Note sui file json
- un oggetto si indica con `{...}`;
- un array si indica con `[...]`;
- un oggetto contiene delle `key`;

[Qui](https://earthly.dev/blog/jq-select/) un tutorial per usare jq e imparare a selezionare oggetti, array e key 

### Test
per avere la lista di tutti i file che sono stati descritti

```bash
cat datapackage.yaml | yq -r '.resources[].name'
```

note:
- con `.resources` selezioniamo la key resources dell'oggetto corrente;
- `.resources[]` iteriamo su tutti gli elementi dell'array resources;
- `.name` selezioniamo la key `name` per ogni elemento dell'array resources
- `-r` sta per "raw" e ci evita le virgolette nell'output

per avere una tabella md per la licenza

```bash
cat datapackage.yaml | yq '.licenses[]' | mlr --j2m cat
```

e si ottiene
| name | title | path |
| --- | --- | --- |
| CC-BY-4.0 | Creative Commons Attribution 4.0 | https://creativecommons.org/licenses/by/4.0/ |

per ottenere solo il titolo della licenza 
```bash
cat datapackage.yaml | yq -r '.licenses[0].title
```

Per generare la stringa a cui siamo interessati noi nel file markdowon possiamo usare uno script del tipo 
```bash
echo "Quest'opera è distribuita con Licenza ["$(cat datapackage.yaml | yq -r '.licenses[0].title') "]($(cat datapackage.yaml | yq -r '.licenses[0].path')) ("$(cat datapackage.yaml | yq -r '.licenses[0].name')")" > test.md
```

che torna in output:
```md
Quest'opera è distribuita con Licenza [Creative Commons Attribution 4.0 ](https://creativecommons.org/licenses/by/4.0/) (CC-BY-4.0)
```

ovvero:
Quest'opera è distribuita con Licenza [Creative Commons Attribution 4.0 ](https://creativecommons.org/licenses/by/4.0/) (CC-BY-4.0)

Adesso dobbiamo fare in modo che questa stringa sostituisca la stringa `{{{license}}}` nel file `template.md`.

possiamo creare una copia di template.md

Per sostituire `{{{license}}}` con "ciao" bisognerà usare una cosa del tipo

```bash
sed -i "s|{{{license}}}|$(echo "ciao")|g" file.md
```

adesso funziona 

```bash
# copy template
cp template.md metadata.md

# add license info
sed -i "s|{{{license}}}|$(echo "Quest'opera è distribuita con Licenza ["$(cat datapackage.yaml | yq -r '.licenses[0].title') "]($(cat datapackage.yaml | yq -r '.licenses[0].path')) ("$(cat datapackage.yaml | yq -r '.licenses[0].name')")")|g" metadata.md
```

questo script:
- copia il file template.md in uno che si chiama `metadata.md`
- sostituisce `{{{license}}}` con l'output del comando che abbiamo scritto prima che torna tutte le info della licenza.

Passiamo ai contributors

usiamo
```bash
cat datapackage.yaml | yq '.contributors[] | {Name: .title, Role: .role, Email: .email}'
```
per:
- accedere ad ogni elemento dell'array contributors con `.contributors[]`
- costruire l'array di output rinominando le key

Metto tutto dentro [] altrimenti non ottengo un json valido

```bash
cat datapackage.yaml | yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]'
```

poi converto in markdown e viene fuori in definitiva
```bash
cat datapackage.yaml | yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat
```

in output ottengo 
```md
| Name | Role | Email |
| --- | --- | --- |
| Chiara Adornetto | author | chiara.adornetto@tiscali.it |
| Dennis Angemi | maintainer | dennisangemi@gmail.com |
```

ovvero
| Name | Role | Email |
| --- | --- | --- |
| Chiara Adornetto | author | chiara.adornetto@tiscali.it |
| Dennis Angemi | maintainer | dennisangemi@gmail.com |

aggiorno lo script 

sono bloccato per un errore di sed

sed: -e expression #1, char 44: unterminated `s' command

