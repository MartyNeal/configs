# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

shopt -s autocd
shopt -s cdspell
shopt -s histappend
shopt -s globstar

complete -d cd
#function emacsclientWindowsPath() { emacsclient -a= -- $(cygpath -w $1); }
export EDITOR='emacsclientWindowsPath'
export PSQL_EDITOR='emacsclientWindowsPath'
export GREP_COLOR=';30;43' #black text, yellow backround
export HISTCONTROL=ignoreboth
export HISTSIZE=99999
export TERM=cygwin

alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias catt='pygmentize -g'
alias chrome='/cygdrive/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
alias date='date --iso-8601=seconds'
alias downloads='cd /cygdrive/c/Users/marty/Downloads'
alias dump='tee /dev/fd/2'
alias fixPermissions='find . -name "*.java" -print0 |xargs -0 chmod -x'
alias g='git'
alias killall='taskkill /F /IM'
alias ls='ls -h --color --file-type --time-style="+%Y-%m-%d %H:%M:%S"'
alias myip='curl http://ipecho.net/plain'
alias r='gradle'
alias src='cd ~/Src/'
alias ssh='ssh -o PreferredAuthentications=publickey -2 -o PubkeyAuthentication=yes'
alias sudo='sudo '
alias sum='paste -sd+ -|bc'
alias webar='cd ~/Src/webar'
alias tomcat='cd /cygdrive/c/var/tomcat'
alias winUser='cd /cygdrive/c/Users/marty/'
alias xml='xmlstarlet'
alias jira='export JIRA_API_TOKEN=${JIRA_API_TOKEN-`lpass show --password jira-api-token`};/usr/bin/jira.exe'
function utc { [ -t 0 ] && \date -u +%FT%T || \date -d "$1" +%FT%T; }
function epoch {  [ -t 0 ] && \date +%s || \date -d "$1" +%s; }
function fromEpoch { date -ud "@$1"; }
function updateLiquibaseMd5 {
    psql -h localhost -U webar -d webar_marty -c "UPDATE databasechangelog SET md5sum='$2' WHERE id = '$1';";
    psql -h localhost -U webar_admin -d webar_mcpaws -c "UPDATE databasechangelog SET md5sum='$2' WHERE id = '$1';";
}
function sqlPatch {
    RELATIVE="com/interprose/db/changelog/$(\date +%Y/%m_%h|tr a-z A-Z)"
    ABSOLUTE="/cygdrive/c/Src/webar/src/$RELATIVE"
    NAME="patch-$1.xml"
    FILE="$ABSOLUTE/$NAME"
    mkdir -p "$ABSOLUTE"
    cat >"$FILE" <<TEMPLATE
<?xml version="1.0" encoding="UTF-8"?>
<databaseChangeLog
  xmlns="http://www.liquibase.org/xml/ns/dbchangelog/1.9"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog/1.9
                      http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-1.9.xsd">
     <changeSet author="marty.neal" id="patch-$1-01">
       <sql>
         
       </sql>
       <rollback><sql>

       </sql></rollback>
     </changeSet>
 </databaseChangeLog>
TEMPLATE
    sed "/<\/databaseChangeLog>/i\  <include file=\"$RELATIVE/$NAME\"\/>" -i /cygdrive/c/Src/webar/src/com/interprose/db/changelog/db.changelog-master.xml
    emacsclient -a= -- +9 $(cygpath -w "$FILE")
}

#to send a message to my phone at a specified time, ie. 1pm  using schtasks:
#schtasks.exe  /Create /SC Once /ST '13:00' /TN reminder /TR 'bash -ic push "message goes here"'
function push {
    curl \
        -H 'Content-Type:application/json' \
        -H 'Access-Token: xxx' \
        https://api.pushbullet.com/v2/pushes \
        -d '{"body":"'"$*"'","type":"note"}'
}

for f in ~/.sdkman/bin/sdkman-init.sh\
         /etc/git/git-prompt.sh\
         /etc/git/git-completion.bash\
         /etc/bashrc\
         ; do
    [[ -s "$f" ]] && source "$f"
done

declare -F __git_complete >/dev/null &&
    __git_complete g __git_main && # tie alias g to git complete
    declare -F __git_ps1 >/dev/null &&    
    export GIT_PS1_SHOWDIRTYSTATE=true &&
    export GIT_PS1_SHOWUPSTREAM=auto &&
    export PROMPT_COMMAND='__git_ps1 "\n\033[1;33m(%s) "' &&
    export PS1='\[\e[0;33m\]\w \[\e[1;30m\]\T\[\e[0m\]\n\$ '

if [[ -n $TITLE ]]; then
    export PS1='\n\[\e[1;33m\]`__git_ps1 "(%s)"` \[\e[0;33m\]\w \[\e[1;30m\]\T\[\e[0m\]\n\$ '
    export PROMPT_COMMAND="echo -ne \"\\033]0;$TITLE\\007\""
fi

# save_output() { 
#    exec 1>&3
#    { [ -f /tmp/current ] && mv /tmp/current /tmp/last; }
#    exec > >(tee /tmp/current)
# }

# exec 3>&1
# trap save_output DEBUG
