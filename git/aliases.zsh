# For checkout completion function remapping
alias __git-branch_main=_git_branch
alias __git-checkout_main=_git_checkout
alias __git-diff_main=_git_diff
alias __git-fetch_main=_git_fetch
alias __git-merge_main=_git_merge
alias __git-pull_main=_git_pull
alias __git-push_main=_git_push

# The rest of my fun git aliases
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gclean='git clean -dfqx'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdca='git diff --cached'
alias gf='git fetch'
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gm='git merge --no-ff --log'
alias gmt='git merge-tool'
alias gp='git push'
alias gpuoc='git push -u origin $(current_branch)'
alias gpfoc='git push -f origin $(current_branch)'
alias gra='git remote add'
alias grhh='git reset HEAD --hard'
alias grv='git remote -v'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gac='git add -A && git commit -m'
