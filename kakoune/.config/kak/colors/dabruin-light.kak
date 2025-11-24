##
## dabruin.kak by nasmevka
## file	structure based	on base16.kak
## light theme
##

evaluate-commands %sh{
	background='rgb:FAFAFA'
	foreground='rgb:242124'
	middleground="rgb:666666"
	accent="${kak_opt_dabruin_accent:-rgb:9F6514}"
	ratio="${kak_opt_dabruin_ratio:-9/5}"
	fore_middle_ratio='0.85'
	back_middle_ratio='1.5'

	export background foreground middleground accent ratio fore_middle_ratio back_middle_ratio
	source_directory="$(dirname "${kak_source}")"
	sh "${source_directory}/dabruin.sh"
}
