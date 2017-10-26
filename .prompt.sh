#!/bin/bash
RET_VAL=$?

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto verbose"
# Do promˇenn ́e PS1 pˇridat: $(__git_ps1 " [%s]")


END="\[\e[0m\]"
CYAN="\[\e[36;1m\]"
GREEN="\[\e[32;1m\]"
YELLOW="\[\e[33;1m\]"
RED="\[\e[1;31m\]"

if [ $RET_VAL -eq 0 ]
then
  DOLLAR="${YELLOW}\$"
else
 DOLLAR="${RED}\\\$($RET_VAL)"
fi

PS1="${GREEN}\w${END}$(__git_ps1 " [%s]") ${DOLLAR}${END} "
