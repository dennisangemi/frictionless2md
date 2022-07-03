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
