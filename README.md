# issue-mirroring
Sample project to experiment with mirroring gh issues as files in the repo 


## motivations

* search issues with ide
* search prs with ide
* exec issues workaround code snippetsedit issues with ide
* edit pr body with ide


## Issues scope
* Gh issues
* Gitlab issues
* Gh pr
* Gitlab pr

* [ ] Submit Intellij RFE indexing & full-text search of GH and gitlab issues & PRs

## Mirror gh issues as files

How:
* Gh action calling script calling gh cli
* Local script exec, cron ?

## Why git committing mirror files in repo
* Use as a cache (for mirroring process)
* Facility for history: Git log
* Username mirroring gh issue author/modif
* Publish as gh pages to control seo
* Gitguardian/Git leak action detect leaks (in issues/comments)

## Format suiteable for searching
* Fs layout: dirs files
* Files: meta-data, issue content, issue comments
* Rdms: sqllite

Issue File content: json/yaml produced from cli

Meta-data file content options:
* Markdown
* Csv
* Rdms: sqllite
* Code: js, ts, bash

### use of code to format content/metadata 

Code potentials
* Leverage IDE native code support
* Leverage native sdk to interact with api

Relevant IDE code support features:
* Code navigation
* Code completion
* Code call hierarchy
* Code exec: run, run as test
* Vendor Native gh/gitlab sdk
* Code dependency analysis
* Code structure navigation
* Code quick outlook
* Code structure (navigation and simple search)
* Code quick doc
* Code doc Markdown rendering

Code dependency analysis use cases;
* Issue clustering: as tree
* Cyclonatic complexity

Issue clustering use cases:
* Discover group of Related issues
* Automate applying missing labels to clusters


Code navigation use cases:
* Issue/pr relationships: closes/ relates
* Issue/issue relationship: xref

Code completion use cases:
* Author query by meta-data ( fluent api)

Code exec use cases:
* Trigger search: response in terminal / run logs

Code call hierarchy use cases:
* Browse relationship graph

Code doc use cases;
* Issue content
* Issue meta-data

Code structure options:
* Static: meta-data structure (reflects gh api=native sdk)
* Almost static: repo labels
* Dynamic: issue meta-data, issue content

## Fs layout options:
* Custom: issue id / comments =
* Natice Gh rest api structure

## Searching worflows:
* By criteria:
* By full text search

## Searching ux priorities:
* Responsiveness
* Precision
* Criteria completion/history
* Enable execute script snipet workflow
* Enable edit issue workflow

## Searching ux options:
* Cli
* Ide search

## Criteria searching options
* IDE full-text search
* IDE code search
* IDE code navigation
* Script (grep/find/jq/yq)

## Full-text search options:
* Intellij natural langage search
* Script

## Edit workflow options:
* Git watch + gh cli issue update



## prior art

How to search for prior art:
* Gh cli repo: issues prs, who is using
* Gh gh discussions
* Google
* Gh sdks
* Awesome gh 

https://github.com/matomo-org/github-issues-mirror
> All issues are stored as JSON on the file system in src/data:
> * There is one JSON file for each issue in src/data/issues. To not end up having too many files in one directory they are split into subdirectories from 1 to 100. Otherwise the file names are equal to the issue number: 1875.json = Issue 1875.
> * There is one JSON file for each page in src/data/pages. 1.json === Page 1, 2.json === Page 2, ..

https://github.com/IQAndreas/github-issues-import
