#!/bin/sh

for repo in $(ls $HOME/github)
do
    cd $HOME/github/$repo
    git pull
done
