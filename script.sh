#!/bin/bash

set -e

# set default output filename
DEFAULT_OUTPUT_FILENAME="METADATA.md"


### OPTIONS ###
# parsing
while getopts ":o:t" arg; do
  case $arg in
    o)
      output_file=$OPTARG
      ;;
    t)
      tree_flag="true"
      ;;
    \?)
      echo -e "❌ \e[31mError. Invalid option: -$OPTARG \e[0m" 1>&2
      exit 1
      ;;
    :)
      echo -e "❌ \e[31mError. Option -$OPTARG requires an argument. \e[0m" 1>&2
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
# if datapckage exists, set package format else exit
if [ -f datapackage.yaml ]; then
    package_format="yaml"
elif [ -f datapackage.json ]; then
    package_format="json"
else
    echo -e "❌ \e[31mError: datapackage not found\e[0m"
    echo "Please create a datapackage.json or datapackage.yaml file."
    exit 1
fi

# confirm existance
echo "✅ datapackage exists"


### CHECK DATAPACKAGE VALIDITY ###
# WIP #16
valid_key_check=$(frictionless validate datapackage.$package_format --pick-errors "package-error" --json | jq '.tasks | has(0)')
# if package is valid
if [ $valid_key_check = "true" ]; then
    echo "✅ datapackage is valid"

    # if package is yaml, convert to json
    if [ $package_format = "yaml" ]; then
        yq . datapackage.yaml > datapackage.json
    fi
else
    echo -e "❌ \e[31mError: datapackage is invalid\e[0m"
    exit 1
fi


### SETUP $output_file ###
echo "Building $output_file..."
# if $output_file exists, delete it
if [ -f $output_file ]; then
    rm $output_file
fi
# create new $output_file
touch $output_file


### PACKAGE TITLE ###
# check if title key exists
valid_key_check=$(jq -r '. | has("title")' datapackage.json)
# if title key exists, add title to $output_file
if [ "$valid_key_check" = "true" ]; then
    echo "#" "$(cat datapackage.json | jq -r '.title')" >> $output_file
    echo "" >> $output_file
else
    echo -e "⚠️  Warning: Title key not found"
    echo "Your $output_file will not contain a title"
fi


### PACKAGE DESCRIPTION ###
# check if description key exists
valid_key_check=$(jq -r '. | has("description")' datapackage.json)
# if description key exists, add description to $output_file
if [ "$valid_key_check" = "true" ]; then
    echo "$(cat datapackage.json | jq -r '.description')" >> $output_file
    echo "" >> $output_file
else
    echo -e "⚠️  Warning: Description key not found"
    echo "Your $output_file will not contain a description"
fi


### REPOSITORY STRUCTURE ###
# if tree flag is set, add tree to $output_file
if [ "$tree_flag" = "true" ]; then
    echo "## Repository structure " >> $output_file
    echo "\`\`\`" >> $output_file
    echo "$(tree | head -n -2)" >> $output_file
    echo "\`\`\`" >> $output_file
    echo "" >> $output_file
else
    echo -e "⚠️  Warning: Tree flag (-t) not set"
    echo "Your $output_file will not contain a repository structure"
fi


### DATA DICTIONARY ###
echo "## Data Dictionary" >> $output_file
# count the number of resources
n_resources=$(cat datapackage.json | jq -r '.resources[].name' | wc -l)
# loop over resources
for (( i=0; i<$n_resources; i++ ))
do
    # get resource infos
    filename=$(cat datapackage.json | jq -r '.resources['$i'].name')
    filepath=$(cat datapackage.json | jq -r '.resources['$i'].path')
    title=$(cat datapackage.json | jq -r '.resources['$i'].title')

    # print resource name
    echo "### 📄 [$filename]($filepath)" >> $output_file

    # print resource description
    # check if description key exists
    valid_key_check=$(jq -r '.resources['$i'] | has("description")' datapackage.json)
    # if description key exists, add description to $output_file
    if [ "$valid_key_check" = "true" ]; then
        
        echo "$(cat datapackage.json | jq -r '.resources['$i'].description')" >> $output_file
    else
        echo -e "⚠️  Warning: Description key not found for $filename"
        echo "Description info will not be added to $output_file"
    fi

    # print resource path
    echo "- Path: \`$filepath\`" >> $output_file

    # check if delimiter key exists
    valid_key_check=$(jq -r '.resources['$i'].dialect.csv | has("delimiter")' datapackage.json)
    # if delimiter key exists, add delimiter info to $output_file
    if [ "$valid_key_check" = "true" ]; then
        delimiter=$(jq -r '.resources['$i'].dialect.csv.delimiter' datapackage.json)
        echo "- Delimiter: \`$delimiter\`" >> $output_file
    else
        echo -e "⚠️  Warning: Dialect key not found for $filename"
        echo "Delimiter info will not be added to $output_file"
    fi

    # check if encoding key exists
    valid_key_check=$(jq '.resources['$i'] | has("encoding")' datapackage.json)
    # if encoding key exists, add encoding info to $output_file
    if [ "$valid_key_check" = "true" ]; then
        echo "- Encoding: \`$(cat datapackage.json | jq -r '.resources['$i'].encoding')\`" >> $output_file
    else
        echo -e "⚠️  Warning: Encoding key not found for $filename"
        echo "Encoding info will not be added to $output_file"
    fi

    # add line break
    echo "" >> $output_file

    # create csv table
    cat datapackage.json | jq '[.resources['$i'].schema.fields[] | {Field: .name, Type: .type, Description: .description}]' | mlr --j2c cat > frct-schema-$i.csv
    
    # this is the line that reminds me that I have to add example column to frct-schema-$i.csv

    # convert frct-schema-$i.csv to markdown and add to $output_file
    mlr --c2m cat frct-schema-$i.csv >> $output_file

    # if frct-schema-$i.csv exists, delete it
    if [ -f frct-schema-$i.csv ]; then
        rm frct-schema-$i.csv
    fi

    # add a line break
    echo "" >> $output_file
done


### PACKAGE LICENSE ###
# check if license key exists
valid_key_check=$(jq -r '. | has("licenses")' datapackage.json)
# if license key exists, add license to $output_file
if [ "$valid_key_check" = "true" ]; then
    echo "## 📖 License" >> $output_file
    echo "This work is licensed under a ["$(cat datapackage.json | jq -r '.licenses[0].title') "]($(cat datapackage.json | jq -r '.licenses[0].path')) ("$(cat datapackage.json | jq -r '.licenses[0].name')") License" >> $output_file
    echo "" >> $output_file
else
    echo -e "⚠️  Warning: License key not found"
    echo "Your $output_file will not contain a license"
fi


### PACKAGE CONTRIBUTORS ###
# check if contributors key exists
valid_key_check=$(cat datapackage.json | jq -r '. | has("contributors")')
# if contributors key exists, add contributors table to $output_file
if [ "$valid_key_check" = "true" ]; then
    # print contributors title to $output_file
    echo "## 👥 Contributors" >> $output_file
    # add contributors table to $output_file
    cat datapackage.json | jq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat >> $output_file
else
    echo -e "⚠️  Warning: Contributors key not found"
    echo "Your $output_file will not contain a contributors table"
fi


### CLEANUP ###
# if package is yaml, delete json created
if package_format="yaml"; then
    rm datapackage.json
fi


### END ###
echo "✅ $output_file created"