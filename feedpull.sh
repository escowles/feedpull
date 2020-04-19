#!/bin/sh

# update from github
git pull

for repo in `cat repos.txt`; do
  ./atom.rb $repo
done
