# 🔧 frictionless2md
A tool to convert [frictionless datapackage](https://specs.frictionlessdata.io/) (YAML or JSON) to markdown file (that can be used as README).

> You can obtain a [markdown file like this](https://github.com/chiaraadornetto/dati-tv-elezioni-ue-2019#readme).

## Set-up
Download `frictionless2md` 
```sh
wget "https://raw.githubusercontent.com/dennisangemi/frictionless2md/main/frictionless2md"
```

Move it to `/usr/local/bin`
```sh
sudo mv ./frictionless2md /usr/local/bin
```

Make it executable
```sh
sudo chmod +x /usr/local/bin/frictionless2md
```

## Usage

You can simply launch 
```sh
frictionless2md
``` 
in a directory where a datapackage is located. The default output file will be `METADATA.md`.

### Options

Here's a summary

Short option | Long option | Requires argument | Description 
--- | --- | --- | ---
`-h` | `--help` | `false` | Show help. [See more](#help)
`-w` | `--warnings` | `false` | Show warnings. [See more](#warnings)
`-o` | `--output` | `true` | Set custom output filename. [See more](#custom-output-filename)
`-t` | `--tree` | `false` | Add repository structure (tree). [See more](#repository-structore)
`-u` | `--userepo` | `true` | Add GitHub URLs to files. [See more](#github-urls-to-files)

<help>

#### Help
`-h` or `--help`

If you want to open the help, you can run

```sh
frictionless2md -h
```

<br>

#### Warnings
`-w` or `--warnings`

If you want to see the warnings, you can use `-w` or `--warnings` flag:

```sh
frictionless2md -w
```

and you will get for example

```
⚠️ Warning: data/contenuti.csv not found. Your METADATA.md will not contain the example column.
```
<br>

#### Custom output filename
`-o` or `--output`

If you want to use a custom output filename you can use `-o` or `--output`flag:

```sh
frictionless2md -o customfilename.md
```

<br>

#### Repository structure
`-t` or `--tree`

If you want to add the tree of the folder where your datapackage is located you can add the `-t` or `--tree` flag:

```sh
frictionless2md -t
```

This option requires the [`tree-emoji-cli` utility](https://github.com/sandoche/tree-emoji-cli). 

Your output will be something like this

```
🌳 /Documents/GitHub/myrepo
├── 📄 CHANGELOG.md
├── 📄 METADATA.md
├── 📄 README.md
├── 📄 build
├── 📁 data
└── 📄 datapackage.yaml
```

<br>

#### GitHub URLs to files
`-u` or `--userepo`

You can add "- URL" to the bulleted list of the output (Data dictionary section) specifying the flag `-u` (or `--userepo`) followed by your GitHub username and the repository name (`username/repo`):

```sh
frictionless2md -u chiaraadornetto/dati-tv-elezioni-ue-2019
```

and you will get for example

![image](https://user-images.githubusercontent.com/77018886/222280556-8638848d-aa4a-4fa9-a7d2-204876497b6d.png)

<br>

## Development
`frictionless2md` is a bash script. Read [requirements.txt](requirements.txt)

