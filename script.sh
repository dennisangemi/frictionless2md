#!/bin/bash

# create a test file in markdown format
# touch test.md

# add license info
# echo "Quest'opera è distribuita con Licenza ["$(cat datapackage.yaml | yq -r '.licenses[0].title') "]($(cat datapackage.yaml | yq -r '.licenses[0].path')) ("$(cat datapackage.yaml | yq -r '.licenses[0].name')")" > test.md

# copy template
cp template.md metadata.md

# add license info
sed -i "s|{{{license}}}|$(echo "Quest'opera è distribuita con Licenza ["$(cat datapackage.yaml | yq -r '.licenses[0].title') "]($(cat datapackage.yaml | yq -r '.licenses[0].path')) ("$(cat datapackage.yaml | yq -r '.licenses[0].name')")")|g" metadata.md

# add contributors table
# contributors_table="$(cat datapackage.yaml | yq -r '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)"
# sed -i "s/{{{contributors}}}/$contributors_table/g" metadata.md
# echo $contributors_table
# echo ciao
# cat datapackage.yaml | yq -r '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat

# awk '{gsub("{{{contributors}}}", "$contributors_table")}1' metadata.md

# perl -i -pe 's/{{{contributors}}}/$(cat datapackage.yaml | yq -r '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)/g' metadata.md

cat datapackage.yaml | yq -r '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat > contributors.md

# sed -i "s!{{{contributors}}}!$(cat contributors.md)!g" metadata.md
# sed -i "s/{{{contributors}}}/$(cat contributors.md)/" metadata.md
# sed -i "s/{{{contributors}}}/$(cat contributors.md)/" metadata.md
# sed -i "s/{{{contributors}}}/$(sed 's:/:\\/:g' contributors.md)/" metadata.md

sed -i "s/{{{contributors}}}/$(cat datapackage.yaml | yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)/" metadata.md

