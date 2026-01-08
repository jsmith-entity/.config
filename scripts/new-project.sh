#!/usr/bin/env bash

TEMPLATE_DIR="/home/jsmith-entity/nixos-dotfiles/config/project-templates"

project_name=$1
project_type=$(ls $TEMPLATE_DIR | fzf)

mkdir $project_name
cd $project_name
cp -r $TEMPLATE_DIR/$project_type/* ./
git init
