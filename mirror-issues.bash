#!/bin/bash

repo=orange-cloudfoundry/paas-templates
issues=$(gh issue -R ${repo} list -L 10 --json number | jq -r .[].number)
for i in ${issues}; do
  echo "synching $i"
  mkdir -p issues/$i
  gh issue -R ${repo} view $i --json title,author,closed,labels,milestone,createdAt,state,url | yq --prettyPrint . > issues/$i/meta.yaml
  gh issue -R ${repo} view $i --json body | jq -r .body > issues/$i/body.md
done;