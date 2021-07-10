#!/bin/bash

# ARG_OPTIONAL_SINGLE([globalfile], g, [Path to global tool-versions file], [$HOME/.tool-versions])
# ARG_HELP([This script will update all versions of installed asdf plugins])
# ARG_VERSION([echo $0 v0.1.0])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_GO

# [ <-- needed because of Argbash

asdf update || true

asdf plugin update --all

PLUGINS=$(cat ${_arg_globalfile} | awk '{ print $1 }')
for plugin in ${PLUGINS[@]}; do
  latest_version=$(asdf latest ${plugin})
  asdf install ${plugin} ${latest_version}
  sed -i "s/${plugin}.*/${plugin} ${latest_version}/g" ${_arg_globalfile}
done




# ] <-- needed because of Argbash