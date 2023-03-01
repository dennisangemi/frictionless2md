# 🔧 frictionless2md
A tool to convert [frictionless datapackage](https://specs.frictionlessdata.io/) (YAML or JSON) to markdown file (that can be used as README).

> You can obtain a [markdown file like this](https://github.com/chiaraadornetto/dati-tv-elezioni-ue-2019#readme).

## Set-up
Download `frictionless2md` 
```bash
wget "https://raw.githubusercontent.com/dennisangemi/frictionless2md/main/frictionless2md"
```

Move it to `/usr/local/bin`
```bash
sudo mv ./frictionless2md /usr/local/bin
```

Make it executable
```bash
sudo chmod +x /usr/local/bin/frictionless2md
```

## Usage

You can simply launch 
```bash
frictionless2md
``` 
in a directory where a datapackage is located. The default output file will be `METADATA.md`.

### Options

**`-w` Show warnings**

If you want to see the warnings, you can use `-w` flag:

```bash
frictionless2md -w
```
<details>
<summary>Output</summary>
You will get for example

```
⚠️ Warning: data/contenuti.csv not found. Your meta.md will not contain the example column.
```
</details>


**`-o` Set custom output filename**

If you want to use a custom output filename you can use `-o` flag:
```bash
frictionless2md -o customfilename.md
```

**`-t` Add repository structure**

If you want to add the tree of the folder where your datapackage is located you can add the `-t` flag:
```bash
frictionless2md -t
```

This option requires the `tree` utility.

**`-u` Add GitHub URLs to files**

You can add "- URL" to the bulleted list of the output (Data dictionary section) specifying the flag `-u` followed by your GitHub username and the repository name (`username/repo`):

```bash
frictionless2md -u dennisangemi/frictionless2md
```

![image](https://user-images.githubusercontent.com/77018886/222280556-8638848d-aa4a-4fa9-a7d2-204876497b6d.png)


## Development
`frictionless2md` is a bash script. Read [requirements.txt](requirements.txt)

