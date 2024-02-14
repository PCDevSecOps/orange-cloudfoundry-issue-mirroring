#!/bin/bash

repo=orange-cloudfoundry/paas-templates
skip_existing_issue=true
limit=100
#See https://github.com/cli/cli/issues/3098#issuecomment-802842606 for sorting
last_issue=$(gh issue -R ${repo} list -L 1 --json number  --search sort:created-asc --state all | jq -r .[].number)
# even with --limit 4000 the list only returns ~ 1200 issues, out of 2.500 issues total
# therefore we take them all in sequential order from last one
all_issues=$(seq 1 ${last_issue} )

recent_issues=$(gh issue -R ${repo} list -L ${limit} --json number  --search sort:created-desc --state all | jq -r .[].number)
issues=${recent_issues}
for i in ${issues}; do
  if [[ "${skip_existing_issue}" == "true" && -d issues/$i ]]; then
    echo "skipping existing $i"
  else
    echo "synching $i"
    mkdir -p issues/$i
    gh issue -R ${repo} view $i --json title,author,closed,number,labels,milestone,createdAt,state,url | yq --prettyPrint . > issues/$i/meta.yaml
    gh issue -R ${repo} view $i --json body | jq -r .body > issues/$i/body.md
  fi
done;