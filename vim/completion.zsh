# Putting this in a completion script so it can remap the bindkey
# after the default mapping is applied by compinit, run earlier.

# From http://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode:
bindkey -M viins '\e/' vi-search-fix
