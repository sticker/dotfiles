#!/bin/bash

cd ~/dotfiles

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    ln -snfv ~/dotfiles/"$f" ~/"$f"
done
