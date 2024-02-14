#!/bin/bash

function state_open() {
  echo '.state=="OPEN"'
}

function state_closed() {
  echo '.state=="CLOSED"'
}

# In: space separated labels
function labels() {
  local labels="$*"
  echo
}

function label_feature() {
  echo
}

function author_gberche_orange() {
  echo
}

open
labels feature_label
author_gberche_orange

yq ". | select .state==\"OPEN\"" find .issues -type f -name "meta.yaml"