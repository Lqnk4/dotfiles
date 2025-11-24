##
## dabruin.kak by nasmevka
## file structure based on base16.kak
## dark theme
##

evaluate-commands %sh{
	background='rgb:242124'
	foreground='rgb:FAFAFA'
	middleground="rgb:B2B2B2"
	ratio="${kak_opt_dabruin_ratio:-3/5}"
	accent="${kak_opt_dabruin_accent:-rgb:FFB852}"
	fore_middle_ratio='1.2'
	back_middle_ratio='0.8'

	export background foreground middleground ratio accent fore_middle_ratio back_middle_ratio
	source_directory="$(dirname "${kak_source}")"
	sh "${source_directory}/dabruin.sh"
}
