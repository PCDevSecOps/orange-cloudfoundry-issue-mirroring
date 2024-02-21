#!/bin/bash

repo=orange-cloudfoundry/paas-templates
skip_existing_issue=true
#skip_existing_issue=false

#useful to only refresh the recent issues
recent_issues_limit=30
#potentially slow down to avoid reaching gh rate limit
sleep_seconds=5

#See https://github.com/cli/cli/issues/3098#issuecomment-802842606 for sorting
last_issue=$(gh issue -R ${repo} list -L 1 --json number  --search sort:created-desc --state all | jq -r .[].number)

# even with --limit 4000 the list only returns ~ 1200 issues, out of 2.500 issues total
# therefore we take them all in sequential order from last one
all_issues=$(seq 1 ${last_issue} | sort -nr)
recent_issues=$(gh issue -R ${repo} list -L ${recent_issues_limit} --json number  --search sort:created-desc --state all | jq -r .[].number)

#Choose which issues to download
issues=${recent_issues}
issues=${all_issues}
for i in ${issues}; do
  if [[ "${skip_existing_issue}" == "true" && -d issues/$i ]]; then
    echo "skipping existing $i"
  else
    echo "synching $i"
    mkdir -p issues/$i
    gh issue -R ${repo} view $i --json title,author,closed,number,labels,milestone,createdAt,state,url | yq --prettyPrint . > issues/$i/meta.yaml
    gh issue -R ${repo} view $i --json body | jq -r .body > issues/$i/body.md
    comment_file=issues/$i/comments.md
    gh issue -R ${repo} view $i --json comments | jq -r  ".comments[] | \"\ncreatedAt: \" + .createdAt + \"\nauthor.login: \" + .author.login + \"\nbody:\n\" + .body " > ${comment_file}
    if ! [ -s ${comment_file} ]; then
      rm ${comment_file}
    else
      echo "some comments in $i"
    fi
    if [ -n "${sleep_seconds}" ]; then
      echo "sleeping ${sleep_seconds} seconds"
      sleep ${sleep_seconds}
    fi;
  fi
done;