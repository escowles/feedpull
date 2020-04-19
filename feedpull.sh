#!/bin/sh

# update from github
git pull

for repo in `cat repos.txt`; do
  bundle exec ./atom.rb $repo
done
