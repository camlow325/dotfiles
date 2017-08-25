alias sd='svn diff'
alias ss='svn status'
alias sclean='svn status --no-ignore | grep '^\?' | sed 's/^\?     //' | xargs rm -rf'
