# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: https://bbs.archlinux.org/viewtopic.php?pid=521888#p521888
PROMPT=$'%{\e[0;95m%}%B┌─[%b%{\e[0m%}%{\e[1;33m%}%n%{\e[1;95m%}@%{\e[0m%}%{\e[0;32m%}%m%{\e[0;95m%}%B]%b%{\e[0m%} : %b%{\e[0;95m%}%B[%b%{\e[1;33m%}%~%{\e[0;95m%}%B]%b%{\e[0m%}
%{\e[0;95m%}%B└─%B[%{\e[1;94m%}$%{\e[0;95m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
