#!/bin/bash

# copy template
cp template.md metadata.md

# add title
perl -i -p -e 's/{{{title}}}/'"$(cat datapackage.yaml | yq -r '.title')"'/g' metadata.md

# add repo description
perl -i -p -e 's/{{{repository-description}}}/'"$(cat datapackage.yaml | yq -r '.description')"'/g' metadata.md

# add license info
sed -i "s|{{{license}}}|$(echo "Quest'opera è distribuita con Licenza ["$(cat datapackage.yaml | yq -r '.licenses[0].title') "]($(cat datapackage.yaml | yq -r '.licenses[0].path')) ("$(cat datapackage.yaml | yq -r '.licenses[0].name')")")|g" metadata.md

# add contributors table
contributors_table=$(cat datapackage.yaml | yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)
perl -i -p -e 's/{{{contributors}}}/'"$contributors_table"'/g' metadata.md
