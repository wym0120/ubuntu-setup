#!/bin/bash
cp ~/.zshrc .zshrc
git add --all
git commit -m "$*"
git push
