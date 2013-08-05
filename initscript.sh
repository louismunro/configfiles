#!/bin/bash
# a script to create the configuration files and link them to the files in the 
# repository
RCFILES=$( ls -da .??* * | grep -v README )
for f in $RCFILES; do mv -f  ~/$f{,.original} ; done

for f in $RCFILES; do ln -svf $PWD/$f ~/$f; done
