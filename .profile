alias gpom='git push origin master'
alias gitlog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x1b[33m[%an]%x1b[39m%x20%s"'

function parse_git_branch_status {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  branch=${ref#refs/heads/}
  ( git diff --exit-code >/dev/null 2>&1 ) && c='' || c='*'
  ( git status 2>&1 | grep -q 'Untracked') && u='+' || u=''
  ( git log origin/${branch} ${branch} 2>&1 | grep -q 'commit') && p='>>' || p=''

  echo -n "$(tput setaf 1)${p}$(tput setaf 2)[${ref#refs/heads/}]$(tput setaf 1)${c}$(tput setaf 3)${u}$(tput setaf 0) "
}

PS1="\w \$(parse_git_branch_status)\$ "
