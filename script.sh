#!/bin/bash

# set output filename
OUTPUT_FILENAME="metadata.md"

# if datapckage.yaml exists, convert to json
if [ -f datapackage.yaml ]; then
    cat datapackage.yaml | yq . > datapackage.json
    package_format="yaml"
else
    package_format="json"
fi

# copy template
cp template.md $OUTPUT_FILENAME

# add title
perl -i -p -e 's/{{{title}}}/'"$(cat datapackage.json | jq -r '.title')"'/g' $OUTPUT_FILENAME

# add repo description
perl -i -p -e 's/{{{repository-description}}}/'"$(cat datapackage.json | jq -r '.description')"'/g' $OUTPUT_FILENAME

# add tree
perl -i -p -e 's/{{{repository-structure}}}/'"$(tree | head -n -2)"'/g' $OUTPUT_FILENAME

# add license info
sed -i "s|{{{license}}}|$(echo "Quest'opera è distribuita con Licenza ["$(cat datapackage.json | jq -r '.licenses[0].title') "]($(cat datapackage.json | jq -r '.licenses[0].path')) ("$(cat datapackage.json | jq -r '.licenses[0].name')")")|g" $OUTPUT_FILENAME

# add contributors table
contributors_table=$(cat datapackage.json | jq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)
perl -i -p -e 's/{{{contributors}}}/'"$contributors_table"'/g' $OUTPUT_FILENAME

# data dictionary

# count the number of resources
n_resources=$(cat datapackage.json | jq -r '.resources[].name' | wc -l)

# if dictionary.md exists, delete it
if [ -f dictionary.md ]; then
    rm dictionary.md
fi

# create dictionary.md
touch dictionary.md

# test n_resources
# n_resources=2

# loop over resources
for (( i=0; i<$n_resources; i++ ))
do
    # get resource name
    filename=$(cat datapackage.json | jq -r '.resources['$i'].name')
    echo "### 📄 $filename" >> dictionary.md
    filepath=$(cat datapackage.json | jq -r '.resources['$i'].path')
    echo "- Path: \`$filepath\`" >> dictionary.md
    echo "- URL:" >> dictionary.md
    echo "- Delimiter:" >> dictionary.md
    echo "- Encoding: \`$(cat datapackage.json | jq -r '.resources['$i'].encoding')\`" >> dictionary.md
    echo "" >> dictionary.md

    # create csv table
    cat datapackage.json | jq '[.resources[0].schema.fields[] | {name, type, description}]' | mlr --j2c cat > frct-schema-$i.csv
    # join frct-schema-$i.csv with first 2 line of $path (transposed) to get the column example

    # convert frct-schema-$i.csv to markdown
    mlr --c2m cat frct-schema-$i.csv >> dictionary.md

    # rm frct-schema-$i.csv
    rm frct-schema-$i.csv

    # add a line break
    echo "" >> dictionary.md
done

# substitute {{{data-dictionary}}} with dictionary.md
sed -i -e '/{{{data-dictionary}}}/r dictionary.md' -e '//d' $OUTPUT_FILENAME

# delete dictionary.md
rm dictionary.md

# delete unnecessary files
if package_format="yaml"; then
    rm datapackage.json
fi
