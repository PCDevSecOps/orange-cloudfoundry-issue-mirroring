#!/bin/bash

repo=orange-cloudfoundry/paas-templates
#See https://github.com/cli/cli/issues/3098#issuecomment-802842606 for sorting
last_issue=$(gh issue -R ${repo} list -L 1 --json number  --search sort:created-desc --state all | jq -r .[].number)
# even with --limit 4000 the list only returns ~ 1200 issues, out of 2.500 issues total
# therefore we take them all in sequential order from last one
issues=$(seq 1 ${last_issue} )
for i in ${issues}; do
  if [ -d issues/$i ]; then
    echo "skipping existing $i"
  else
    echo "synching $i"
    mkdir -p issues/$i
    gh issue -R ${repo} view $i --json title,author,closed,labels,milestone,createdAt,state,url | yq --prettyPrint . > issues/$i/meta.yaml
    gh issue -R ${repo} view $i --json body | jq -r .body > issues/$i/body.md
  fi
done;