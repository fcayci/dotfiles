#!/usr/bin/env bash

#PUT THIS FILE IN ~/.local/share/rofi/finder.sh
#USE: rofi  -show find -modi find:~/.local/share/rofi/finder.sh
if [ ! -z "$@" ]
then
  QUERY=$@
  if [[ "$@" == /* ]]
  then
    if [[ "$@" == *\?\? ]]
    then
      coproc ( exo-open "${QUERY%\/* \?\?}"  > /dev/null 2>&1 )
      exec 1>&-
      exit;
    else
      coproc ( exo-open "$@"  > /dev/null 2>&1 )
      exec 1>&-
      exit;
    fi
  elif [[ "$@" == \?* ]]
  then
    while read -r line; do
      echo "$line" \?\?
    done <<< $(find /tank/docs /tank/tablet /tank/papers -iname *"${QUERY#\?}"*.pdf 2>&1 | grep -v 'Permission denied\|Input/output error')
  else
    find /tank/docs /tank/tablet /tank/papers -iname *"${QUERY#!}"*.pdf 2>&1 | grep -v 'Permission denied\|Input/output error'
  fi
fi
