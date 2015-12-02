# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

. '/etc/git/git-prompt.sh';
. '/etc/git/git-completion.bash';
#. '/cygdrive/c/Program Files (x86)/Git/etc/git-prompt.sh';
#. '/cygdrive/c/Program Files (x86)/Git/etc/git-completion.bash'
__git_complete g __git_main # tie alias g to git complete

export GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\e]0;\w\a\]\n\[\e[1;33m\]`__git_ps1 "(%s)"` \[\e[0;33m\]\w\[\e[0m\]\n\$ '
alias g="hub"
#alias g="git"
export HARNESSLOG='/var/log/webtrends/harness/service.log'
export SAPILOG='/var/log/webtrends/streamingapi/streaming.log'
export EDITOR='emacs'
export GREP_COLOR=';30;43' #black text, yellow backround
export POD=G

COMPONENTS='["wt_explore_app_data", "wt_lookup_svc"]'

alias knife='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/knife'
alias gem='/cygdrive/c/opscode/chef/embedded/bin/gem'
alias chef-client='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/chef-client'
alias chef-solo='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/chef-solo'
alias shef='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/chef-shell'
alias dump='tee /dev/fd/2'
alias ls='ls -h --color --file-type --time-style="+%Y-%m-%d %H:%M:%S"'
alias desktop='cd /cygdrive/c/Users/nealm/Desktop/'
alias downloads='cd /cygdrive/c/Users/nealm/Downloads/'
alias nealm='cd /cygdrive/c/Users/nealm/'
alias src='cd ~/Src'
alias chef='cd ~/Src/chef-repo/;git pull'
alias cam='cd ~/Src/portfolio-cam-automation/'
alias streams='cd ~/Src/streams-automation/'
alias ads='cd ~/Src/ads-automation/'
alias io='cd ~/Src/jvm-common-lib/io'
alias testng='cd ~/Src/jvm-common-lib/testng'
alias plugin='cd ~/Src/jvm-common-lib/gradle'
alias web='cd ~/Src/webtesting'
alias explore='cd ~/Src/explore-ui-automation'
alias optimize='cd ~/Src/optimize-ui-automation'
alias suites='cd /cygdrive/c/QATestSuite/'
alias pati='cd ~/Src/ui-automation-lib'
alias m2='cd /cygdrive/c/Users/nealm/.gradle/caches/modules-2/files-2.1'
alias c='cd /cygdrive/c/'
alias cygwingui='/cygdrive/c/Users/nealm/Downloads/setup-x86_64.exe'
alias cygwin='/cygdrive/c/Users/nealm/Downloads/setup-x86_64.exe -q -P'
alias r='gradle'
alias ri='gradle idea'
alias rb='gradle build'
alias rj='gradle jar'
alias clear='printf "\033c"'
alias cls='printf "\033c"'
alias t='tail -f -n1000'
alias chrome='/cygdrive/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias sum='paste -sd+ -|bc'
alias emacs="emacs-nox"
alias keff="knife environment from file"
alias s="ssh"
alias e="emacs-nox"
alias ccat="pygmentize"
alias top="cygstart --action=runas taskmgr"

alias deployAll='for m in $(harnessNodesInA); do echo $m;ssh -t $m "sudo deploy_build=true chef-client"; done'
alias checkAll='for m in $(harnessNodesInA); do echo -n $m" "; curl -s $m":8080/plugins/$(curl -s $m":8080/plugins" | cut -d\" -f4)" | cut -d\" -f8; done'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

function define { curl -sL "http://dictionary.reference.com/browse/$@" | grep -P '(?<=browse/)[a-z]*"' -o | sed s/.$// | perl -ne 'print unless $seen{$_}++' | head; }
function harnessNodes { knife exec -E 'nodes.find(name:"'"${POD,,}"'*") {|n| puts n.name}'; }
function grepAll { for m in $(harnessNodesInA); do ssh $m grep "$1"; done; }
function rt { gradle test -i -Dtest.single="$1"; }
function utc {  [ -t 0 ] && date -u +%FT%T || date -d "$1" +%FT%T; }
function epoch {  [ -t 0 ] && date +%s || date -d "$1" +%s; }
function fromEpoch { date -d "@$1"; }
function whatsknifed {
  echo showing what is knifed in POD="$POD"-LAS for COMPONENTS="$COMPONENTS";
  knife environment show $POD-LAS -Fj | jq "reduce ($COMPONENTS"'|.[]) as $item (.res = []; .res = [.res[], {download_url: (.default_attributes|.[$item].download_url), cookbook: (.cookbook_versions|.[$item]), component: $item}])|.res[]' -C;
}

pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
}

dirstack() { echo -n "DIRSTACK: "; dirs; }

alias cd='pushd'
alias pop='popd -n +0'
alias dirs='dirs -v'


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "/home/nealm/.sdkman/bin/sdkman-init.sh" ]] && source "/home/nealm/.sdkman/bin/sdkman-init.sh"
