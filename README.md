# 🔧 frictionless2md
A tool to convert frictionless metadata (datapackage.yaml or json) to md file that can be used as readme

> You can obtain a README file like this https://github.com/chiaraadornetto/dati-tv-elezioni-ue-2019#readme

Currently you can launch `./script.sh` in a directory where datapackage is located (make sure to copy `template.md`).
Read [requirements.txt](requirements.txt) otherwise the bash script won't work. 

# Future developments 
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

Example (get the datapackage from dennisangemi/myrepo and convert to markdown):
```bash
frictionless2md -u dennisangemi myrepo -f README.md
```
