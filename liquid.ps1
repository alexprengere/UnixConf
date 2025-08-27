LP_PS1="${LP_PS1_PREFIX}${LP_TIME}${LP_BATT}${LP_LOAD}${LP_TEMP}${LP_RAM}${LP_DISK}${LP_WIFI}${LP_JOBS}"
LP_PS1+="${LP_USER}${LP_HOST}${LP_PERM} "
LP_PS1+="${LP_PWD}${LP_DIRSTACK}${LP_PROXY}${LP_ENVVARS}${LP_SHLVL}${LP_DEV_ENV}"

# Add VCS infos
LP_PS1+="${LP_VCS}"

# Add last runtime, return code & meaning, prompt mark and user-defined postfix.
LP_PS1+="${LP_RUNTIME}${LP_ERR}${LP_ERR_MEANING}${LP_MARK_PREFIX}${LP_COLOR_MARK}${LP_MARK}${LP_PS1_POSTFIX}"

# Get the core sections without prompt escapes and make them into a title.
_lp_formatted_title "$LP_PS1"

# vim: set et sts=4 sw=4 tw=120 ft=sh:
