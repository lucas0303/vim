:syntax match cscFix "\[.*\]$"
:syntax match cscFix2 "【.*】"
:syntax match cscFix3 "([0-9]\{1,2\})"
:syntax match cscFix31 "([0-9]).\{1,25\}:"
:syntax match cscFix4 " #.*$"
:syntax match cscFix5 "eg: "
:syntax match title "^[0-9]*\..*"
:syntax match chapter "Chapter [0-9]: .\{1,30\}$"
:highlight cscFix ctermfg=174 guifg=#00FFFF
:highlight cscFix2 ctermfg=174 guifg=#00FFFF
:highlight cscFix3 ctermfg=170 guifg=#00FFFF
:highlight cscFix31 ctermfg=170 guifg=#00FFFF
:highlight cscFix4 ctermfg=160 guifg=#00FFFF
:highlight cscFix5 ctermfg=164 guifg=#00FFFF
:highlight title ctermfg=160 guifg=#00FFFF
:highlight chapter ctermfg=161 guifg=#00FFFF
