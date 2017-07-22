#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/common.sh

# Setup pymsc in ~/.local
cd $DIR/../pymsc || exit 1

# Skip install if the version installed is the same and the tree is clean
HEAD="$(grep __version msccore/__init__.py | awk '{print $NF}' | tr -d '"')"

VERSION_INSTALLED="$(pip2 freeze | grep taste-msc | awk -F= '{print $NF}')"
git status >/dev/null
TREE_CLEAN=$?
if [ ${TREE_CLEAN} -eq 0 -a "${HEAD}" == "${VERSION_INSTALLED}" ] ; then
    echo taste-msc tree is clean and already installed. Skipping taste-msc install...
    exit 0
fi

# Unfortunately, the --upgrade DOES NOT ALWAYS WORK.
# Uninstall first...
echo y | pip2 uninstall taste-msc
pip2 install --user --upgrade . || exit 1

# Add .local/bin to PATH
PATH_CMD='export PATH=$PATH:$HOME/.local/bin'
UpdatePATH
