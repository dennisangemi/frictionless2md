# 🔧 frictionless2md
A tool to convert frictionless metadata (datapackage.yaml or json) to markdown file (that can be used as README).

> You can obtain a [markdown file like this](https://github.com/chiaraadornetto/dati-tv-elezioni-ue-2019#readme).

## Usage
Read [requirements.txt](requirements.txt) otherwise the bash script won't work.

Currently you can launch 
```bash
./script.sh
``` 
in a directory where a datapackage is located and the default output file will be `METADATA.md`.

### Options

**Set custom output filename**

If you want to use a custom output filename you can use `-o` flag:
```bash
./script.sh -o customfilename.md
```

## Development
`script.sh` is a bash script

---
<details>
<summary>Future developments</summary>

## Installation

You can install this tool
```bash
apt-get bla bla instal bla bla frictionless2md
```
## Usage

Launch simply `frictionless2md` in the same directory where `datapackage.yaml` is located.

### Options

### Specify output filename

```bash
frictionless2md -o README.md
```

`-o README.md` declare the output filename

### Specify GitHub infos

```bash
frictionless2md -u username repository-name -f README.md
```

`-u username repository-name` permits to define your github username and the name of the repo in which data are located. `-f README.md` at the same time declare the output filename.

Example (get the datapackage from dennisangemi/myrepo and convert to markdown):
```bash
frictionless2md -u dennisangemi myrepo -f README.md
```
</details>
