#!/bin/bash

repo=orange-cloudfoundry/paas-templates
#See https://github.com/cli/cli/issues/3098#issuecomment-802842606 for sorting
#last_issue=$(gh issue -R ${repo} list -L 1 --json number  --search sort:created-desc --state all | jq -r .[].number)
# even with --limit 4000 the list only returns ~ 1200 issues, out of 2.500 issues total
# therefore we take them all in sequential order from last one
#issues=$(seq 1 ${last_issue} )
issues=2163
for i in ${issues}; do
  echo updating issue $i with body
  ls -al issues/$i/body.md
  gh issue -R ${repo} edit $i --body-file issues/$i/body.md
done;