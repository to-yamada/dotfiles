#!/bin/bash

# 存在していない変数を参照するとエラーにする
set -u

DOTFILES="${HOME}/dotfiles"
DOT_CONFIG=".config"

# dotfiles へのリンク作成
cd ${DOTFILES}
for f in .??*; do
  #無視したいファイルやディレクトリ
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".gitignore" ]] && continue
  [[ "$f" == ${DOT_CONFIG} ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue
  ln -snfv ${DOTFILES}/${f} ${HOME}/${f}
done

# dotfiles/.config へのリンク作成
mkdir -p ${HOME}/${DOT_CONFIG}
cd ${DOTFILES}/${DOT_CONFIG}
for d in *; do
  ln -snfv ${DOTFILES}/${DOT_CONFIG}/$d ${HOME}/${DOT_CONFIG}/${d}
done
cd ${DOTFILES}
