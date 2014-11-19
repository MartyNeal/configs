# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

. '/cygdrive/c/Program Files (x86)/Git/etc/git-prompt.sh';
. '/cygdrive/c/Program Files (x86)/Git/etc/git-completion.bash'
__git_complete g __git_main # tie alias g to git complete

export GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\e]0;\w\a\]\n\[\e[1;33m\]`__git_ps1 "(%s)"` \[\e[0;33m\]\w\[\e[0m\]\n\$ '
export EDITOR='edit'
export GREP_COLOR=';30;43' #black text, yellow backround
export POD=G

#eval `ssh-agent -s` > /dev/null
#ssh-add 2> /dev/null

COMPONENTS='["wt_explore_app_data", "wt_lookup_svc"]'
#COMPONENTS='["wt_cam_db", "wt_cam", "wt_sauth", "wt_portfolio_admin_rails", "wt_portfolio_manager"]'

alias knife='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/knife'
alias chef-client='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/chef-client'
alias chef-solo='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/chef-solo'
alias shef='/cygdrive/c/opscode/chef/embedded/bin/ruby C:/opscode/chef/bin/shef'

alias dump='tee /dev/fd/2'
alias ls='ls -h --color --file-type --time-style="+%Y-%m-%d %H:%M:%S"'
alias desktop='cd /cygdrive/c/Users/nealm/Desktop/'
alias nealm='cd /cygdrive/c/Users/nealm/'
alias logs='cd /cygdrive/c/Logs'
alias src='cd ~/Src'
alias cam='cd ~/Src/Portfolio-CAM/'
alias streams='cd ~/Src/Streams-automation/'
alias ads='cd ~/Src/ads-automation/'
alias io='cd ~/Src/jvm-common-lib/io'
alias testng='cd ~/Src/jvm-common-lib/testng'
alias web='cd ~/Src/webtesting'
alias explore='cd ~/Src/explore-ui'
alias suites='cd /cygdrive/c/QATestSuite/'
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
alias g="hub"
alias k="knife"
alias s="ssh"
alias e="emacs-nox"
alias ccat="pygmentize"

function rt { gradle test -i -Dtest.single="$1"; }
function utc {  [ -t 0 ] && date -u +%FT%T || date -d "$1" +%FT%T; }
function epoch {  [ -t 0 ] && date +%s || date -d "$1" +%s; }
function fromEpoch { date -d "@$1"; }
function whatsknifed {
  echo showing what is knifed in POD="$POD"-LAS for COMPONENTS="$COMPONENTS";
  knife environment show $POD-LAS -Fj | jq "reduce ($COMPONENTS"'|.[]) as $item (.res = []; .res = [.res[], {download_url: (.default_attributes|.[$item].download_url), cookbook: (.cookbook_versions|.[$item]), component: $item}])|.res[]' -C;
}

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/nealm/.gvm/bin/gvm-init.sh" ]] && source "/home/nealm/.gvm/bin/gvm-init.sh"

