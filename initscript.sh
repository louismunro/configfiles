#!/bin/bash
# a script to create the configuration files and link them to the files in the 
# repository
set -e
RCFILES=$( ls -da .??* * | grep -v README | grep -v '.git$' )
set +e
for f in $RCFILES; do mv -f  ~/$f{,.original} ; done

set -e
for f in $RCFILES; do ln -svf $PWD/$f ~/$f; done
