#!/bin/bash

set -e

# set default output filename
DEFAULT_OUTPUT_FILENAME="METADATA.md"

### OPTIONS ###

# parsing
while getopts "o:" arg; do
  case $arg in
    o)
      output_file=$OPTARG
      ;;
    *)
      echo -e "❌ \e[31mError: option not found\e[0m"
      echo "Usage: ./script.sh -o FILENAME.md"
      exit 1
      ;;
  esac
done

# if output file is not set, use default
if [ -z $output_file ]; then
    output_file=$DEFAULT_OUTPUT_FILENAME
    # echo "Using default output filename: $output_file"
fi

### CHECK IF DATAPACKAGE EXISTS ###
# if datapckage.yaml exists, convert to json
if [ -f datapackage.yaml ]; then

    # set package format
    package_format="yaml"

    # convert to json
    cat datapackage.yaml | yq . > datapackage.json

# if datapackage.json exists
elif [ -f datapackage.json ]; then

    # set package format
    package_format="json"

# if neither exists, exit
else
    echo -e "❌ \e[31mError: datapackage not found\e[0m"
    echo "Please create a datapackage.json or datapackage.yaml file."
    exit 1
fi

# confirm existance
echo "✅ datapackage exists"


### SETUP TEMPLATE ###
# copy template (to be modified)
# cp template.md $output_file

echo "Building $output_file..."

# if $output_file exists, delete it
if [ -f $output_file ]; then
    rm $output_file
fi

# create new $output_file
touch $output_file

echo "# {{{title}}}
" >> $output_file
echo "{{{repository-description}}}
" >> $output_file
echo "## Repository structure 
\`\`\`
{{{repository-structure}}}
\`\`\`

## Data Dictionary 
{{{data-dictionary}}}

## 📖 License
{{{license}}}

## 👥 Contributors
{{{contributors}}}" >> $output_file


### PACKAGE TITLE ###

# check if title key exists
key_existence_check=$(cat datapackage.json | jq -r '. | has("title")')

# if title key exists, add title to $output_file
if [ "$key_existence_check" = "true" ]; then
    perl -i -p -e 's/{{{title}}}/'"$(cat datapackage.json | jq -r '.title')"'/g' $output_file
else
    perl -i -p -e 's/{{{title}}}/'"$(echo "")"'/g' $output_file
    echo -e "⚠️  Warning: Title key not found"
    echo "Your $output_file will not contain a title"
fi

### PACKAGE DESCRIPTION ###

# check if description key exists
key_existence_check=$(cat datapackage.json | jq -r '. | has("description")')

# if description key exists, add description to $output_file
if [ "$key_existence_check" = "true" ]; then
    perl -i -p -e 's/{{{repository-description}}}/'"$(cat datapackage.json | jq -r '.description')"'/g' $output_file
else
    perl -i -p -e 's/{{{repository-description}}}/'"$(echo "")"'/g' $output_file
    echo -e "⚠️  Warning: Description key not found"
    echo "Your $output_file will not contain a description"
fi


### REPORITORY STRUCTURE ###
perl -i -p -e 's/{{{repository-structure}}}/'"$(tree | head -n -2)"'/g' $output_file

### PACKAGE LICENSE
sed -i "s|{{{license}}}|$(echo "This work is licensed under a ["$(cat datapackage.json | jq -r '.licenses[0].title') "]($(cat datapackage.json | jq -r '.licenses[0].path')) ("$(cat datapackage.json | jq -r '.licenses[0].name')") License")|g" $output_file

### CONTRIBUTORS
# contributors_table=$(cat datapackage.json | jq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)
# perl -i -p -e 's/{{{contributors}}}/'"$contributors_table"'/g' $output_file
cat datapackage.json | jq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat > frct-contributors.md
sed -i -e '/{{{contributors}}}/r frct-contributors.md' -e '//d' $output_file

# if frct-contributors.md exists, delete it
if [ -f frct-contributors.md ]; then
    rm frct-contributors.md
fi

### DATA DICTIONARY ###

# count the number of resources
n_resources=$(cat datapackage.json | jq -r '.resources[].name' | wc -l)

# if dictionary.md exists, delete it
if [ -f dictionary.md ]; then
    rm dictionary.md
fi

# create temp file dictionary.md
touch dictionary.md

# loop over resources
for (( i=0; i<$n_resources; i++ ))
do
    # get resource infos
    filename=$(cat datapackage.json | jq -r '.resources['$i'].name')
    filepath=$(cat datapackage.json | jq -r '.resources['$i'].path')
    title=$(cat datapackage.json | jq -r '.resources['$i'].title')

    # print resource infos
    echo "### 📄 [$filename]($filepath)" >> dictionary.md
    echo "- Path: \`$filepath\`" >> dictionary.md
    echo "- URL:" >> dictionary.md

    # check if delimiter key exists
    delimiter_exists=$(jq '.resources['$i'].dialect.csv | has("delimiter")' datapackage.json)

    # if delimiter key exists, add delimiter info to dictionary.md
    if [ "$delimiter_exists" = "true" ]; then
        delimiter=$(jq -r '.resources['$i'].dialect.csv.delimiter' datapackage.json)
        echo "- Delimiter: \`$delimiter\`" >> dictionary.md
    else
        echo -e "⚠️  Warning: Dialect key not found for $filename"
        echo "Delimiter info will not be added to $output_file"
    fi

    echo "- Encoding: \`$(cat datapackage.json | jq -r '.resources['$i'].encoding')\`" >> dictionary.md
    echo "" >> dictionary.md

    # create csv table
    cat datapackage.json | jq '[.resources['$i'].schema.fields[] | {Field: .name, Type: .type, Description: .description}]' | mlr --j2c cat > frct-schema-$i.csv
    # cat datapackage.json | jq '[.resources[0].schema.fields[] | {name, type, title, description} | {Field: .name, Type: .type, Description: ((.title // "") + if .description then ": " else "" end + (.description // ""))}]' | mlr --j2c cat > frct-schema-$i.csv
    # join frct-schema-$i.csv with first 2 line of $path (transposed) to get the column example

    # convert frct-schema-$i.csv to markdown
    mlr --c2m cat frct-schema-$i.csv >> dictionary.md

    # rm frct-schema-$i.csv
    rm frct-schema-$i.csv

    # add a line break
    echo "" >> dictionary.md
done

# substitute {{{data-dictionary}}} with dictionary.md
sed -i -e '/{{{data-dictionary}}}/r dictionary.md' -e '//d' $output_file

### CLEANUP

# delete dictionary.md
rm dictionary.md

# if package is yaml, delete json created
if package_format="yaml"; then
    rm datapackage.json
fi

### END

echo "✅ $output_file created"