#!/bin/bash
cp ~/.zshrc .zshrc
git add --all
git commit -m "$1"
git push
