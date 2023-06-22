#!/bin/bash

for i in `cat acc`
do
 tmux new-session -d -s $i
done

# List the sessions
tmux list-sessions


