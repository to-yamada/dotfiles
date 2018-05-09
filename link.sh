#!/bin/bash

set -u
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_CONFIG=".config"

cd ${DOT_DIRECTORY}
for f in .??*
do
    #無視したいファイルやディレクトリ
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".config" ] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

mkdir -p ${HOME}/${DOT_CONFIG}
cd ${DOT_DIRECTORY}/${DOT_CONFIG}
for d in *
do
    ln -snfv ${DOT_DIRECTORY}/${DOT_CONFIG}/$d ${HOME}/${DOT_CONFIG}/${d}
done

cd ${DOT_DIRECTORY}
