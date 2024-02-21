#!/bin/bash

# automated adding zero padding to issues, e.g.
# mv issues/454 issues/0454

for i in $(dir issues); do
  # credit https://stackoverflow.com/a/8789815/1484823
  normalized_index=$(printf "%04d" ${i});
  # just ignore errors when moving to self
  #> mv: cannot move 'issues/1071' to a subdirectory of itself, 'issues/1071/1071'
  mv issues/$i issues/$normalized_index;
done;
