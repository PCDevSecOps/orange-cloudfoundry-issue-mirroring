#!/bin/bash

repo=orange-cloudfoundry/paas-templates
skip_existing_issue=true
#skip_existing_issue=false

#useful to only refresh the recent issues
recent_issues_limit=30
#potentially slow down to avoid reaching gh rate limit
#sleep_seconds=5

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
  # credit https://stackoverflow.com/a/8789815/1484823
  normalized_index=$(printf "%04d" ${i})
  if [[ "${skip_existing_issue}" == "true" && -d issues/${normalized_index} ]]; then
    echo "skipping existing ${normalized_index}"
  else
    echo "synching ${normalized_index}"
    mkdir -p issues/${normalized_index}
    gh issue -R ${repo} view ${normalized_index} --json title,author,closed,number,labels,milestone,createdAt,state,url | yq --prettyPrint . > issues/${normalized_index}/meta.yaml
    gh issue -R ${repo} view ${normalized_index} --json body | jq -r .body > issues/${normalized_index}/body.md
    comment_file=issues/${normalized_index}/comments.md
    gh issue -R ${repo} view ${normalized_index} --json comments | jq -r  ".comments[] | \"\ncreatedAt: \" + .createdAt + \"\nauthor.login: \" + .author.login + \"\nbody:\n\" + .body " > ${comment_file}
    if ! [ -s ${comment_file} ]; then
      rm ${comment_file}
    else
      echo "some comments in ${normalized_index}"
    fi
    if [ -n "${sleep_seconds}" ]; then
      echo "sleeping ${sleep_seconds} seconds"
      sleep ${sleep_seconds}
    fi;
  fi
done;