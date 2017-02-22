#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. ${DIR}/common.sh

# Install the scripts
cd ${DIR}
for i in checkStackUsage.py patchAPLCs.py taste_orchestrator.py 
do
    cp -u ../orchestrator/orchestrator/$i ${PREFIX}/bin/
done

# Install a symlink for the old name of the build tool
cd ${PREFIX}/bin/ || exit 1
[ ! -h assert-builder-ocarina.py ] && ln -s taste_orchestrator.py assert-builder-ocarina.py

# Add to PATH
PATH_CMD='export PATH=$PATH:'"${PREFIX}/bin"
UpdatePATH
