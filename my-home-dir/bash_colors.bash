# Reset

export GT_RESET=$(   tput sgr0)  # Reset all attributes
export GT_BRIGHT=$(  tput bold)  # Set “bright” attribute
export GT_DIM=$(     tput dim)   # Set “dim” attribute (normal/non-bright)
export GT_ULINE=$(   tput smul)  # Set “underscore” (underlined text) attribute
export GT_BLINK=$(   tput blink) # Set “blink” attribute
export GT_INVERSE=$( tput rev)   # Set “inverse” attribute
export GT_HIDDEN=$(  tput invis) # Set “hidden” attribute

export FG_BLACK=$(   tput setaf 0) #foreground to color #0 - black
export FG_RED=$(     tput setaf 1) #foreground to color #1 - red
export FG_GREEN=$(   tput setaf 2) #foreground to color #2 - green
export FG_YELLOW=$(  tput setaf 3) #foreground to color #3 - yellow
export FG_BLUE=$(    tput setaf 4) #foreground to color #4 - blue
export FG_MAGENTA=$( tput setaf 5) #foreground to color #5 - magenta
export FG_CYAN=$(    tput setaf 6) #foreground to color #6 - cyan
export FG_WHITE=$(   tput setaf 7) #foreground to color #7 - white

export BG_BLACK=$(   tput setab 0) #background to color #0 - black
export BG_RED=$(     tput setab 1) #background to color #1 - red
export BG_GREEN=$(   tput setab 2) #background to color #2 - green
export BG_YELLOW=$(  tput setab 3) #background to color #3 - yellow
export BG_BLUE=$(    tput setab 4) #background to color #4 - blue
export BG_MAGENTA=$( tput setab 5) #background to color #5 - magenta
export BG_CYAN=$(    tput setab 6) #background to color #6 - cyan
export BG_WHITE=$(   tput setab 7) #background to color #7 - white


export txtrst='\e[0m'    # Text Reset
export endcolorcode='\]'
export txtblk='\e[0;30m' # Black - Regular
export txtred='\e[0;31m' # Red
export txtgrn='\e[0;32m' # Green
export txtylw='\e[0;33m' # Yellow
export txtblu='\e[0;34m' # Blue
export txtpur='\e[0;35m' # Purple
export txtcyn='\e[0;36m' # Cyan
export txtwht='\e[0;37m' # White
export bldblk='\e[1;30m' # Black - Bold
export bldred='\e[1;31m' # Red
export bldgrn='\e[1;32m' # Green
export bldylw='\e[1;33m' # Yellow
export bldblu='\e[1;34m' # Blue
export bldpur='\e[1;35m' # Purple
export bldcyn='\e[1;36m' # Cyan
export bldwht='\e[1;37m' # White
export unkblk='\e[4;30m' # Black - Underline
export undred='\e[4;31m' # Red
export undgrn='\e[4;32m' # Green
export undylw='\e[4;33m' # Yellow
export undblu='\e[4;34m' # Blue
export undpur='\e[4;35m' # Purple
export undcyn='\e[4;36m' # Cyan
export undwht='\e[4;37m' # White
export bakblk='\e[40m'   # Black - Background
export bakred='\e[41m'   # Red
export bakgrn='\e[42m'   # Green
export bakylw='\e[43m'   # Yellow
export bakblu='\e[44m'   # Blue
export bakpur='\e[45m'   # Purple
export bakcyn='\e[46m'   # Cyan
export bakwht='\e[47m'   # White
