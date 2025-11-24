# Expect to be ran with the following variables defined:
# - background = 'rgb:rrggbb'
# - foreground = 'rgb:rrggbb'
# - middleground = 'rgb:rrggbb'
# - accent = 'rgb:rrggbb'
# - ratio = 'n/m' or 'n.m'
# - back_middle_ratio = 'n/m' or 'n.m'
# - fore_middle_ratio = 'n/m' or 'n.m'

ratio_calculate() {
	printf "${1##rgb:}" | fold -w2 |
		awk -v ratio="$2" '
		function char2num(char) {
			if (char == "f") { return 15; }
			if (char == "e") { return 14; }
			if (char == "d") { return 13; }
			if (char == "c") { return 12; }
			if (char == "b") { return 11; }
			if (char == "a") { return 10; }
			return char
		}
		function hex2dec(hex) {
			left = tolower(substr(hex, 1, 1))
			right = tolower(substr(hex, 2, 1))
			return char2num(left) * 16 + char2num(right)
		}

		BEGIN {
			printf "rgb:"
			if (ratio ~ /[0-9]+\/[0-9]+/) {
				split(ratio, nums, "/")
				ratio =	nums[1]/nums[2]
			}
		}
		{
			decimal	= hex2dec($0)
			ratioed	= int(decimal *	ratio)
			printf("%02x", ratioed > 255 ? 255 : ratioed)
		}'
}

to_foreground_middleground="$(ratio_calculate "${middleground}" "${fore_middle_ratio}")"
to_background_middleground="$(ratio_calculate "${middleground}" "${back_middle_ratio}")"
second_accent="$(ratio_calculate "${accent}" "${ratio}")"

# code
cat <<-COLORSCHEME
	face global value ${to_foreground_middleground},${background}+biF
	face global type ${foreground},${background}+buF
	face global variable ${foreground}+i
	face global module string
	face global function ${second_accent},${background}+biF
	face global string ${middleground}+i
	face global keyword ${accent}+b
	face global operator ${foreground}
	face global attribute ${foreground}+i
	face global comment ${to_background_middleground}+i
	face global documentation comment
	face global meta ${second_accent}+ab
	face global builtin ${accent}+i

	face global title ${accent}+bi
	face global header title
	face global mono string
	face global block mono
	face global link ${second_accent}+u
	face global bullet ${middleground}
	face global list bullet

	face global Default ${foreground},${background}
	face global PrimarySelection ${foreground},${second_accent}+fg
	face global SecondarySelection ${foreground},${to_background_middleground}+fg
	face global PrimaryCursor ${background},${accent}+fg
	face global SecondaryCursor ${background},${middleground}+fg
	face global PrimaryCursorEol ${background},${foreground}+F
	face global SecondaryCursorEol ${background},${to_foreground_middleground}+F
	face global LineNumbers	${to_foreground_middleground},${background}
	face global LineNumbersWrapped ${background},${background}
	face global LineNumberCursor ${accent},${background}
	face global MenuForeground ${background},${accent}+b
	face global MenuBackground ${foreground},${background}
	face global MenuInfo ${accent}@MenuBackground
	face global Information	${accent}+b@MenuBackground
	face global Error red
	face global DiagnosticError red
	face global DiagnosticWarning yellow
	face global StatusLine ${foreground},${background}
	face global StatusLineMode ${accent}
	face global StatusLineInfo ${middleground}
	face global StatusLineValue ${middleground}
	face global StatusCursor ${background},${accent}
	face global Prompt ${accent},${background}
	face global MatchingChar ${background},${middleground}+F
	face global BufferPadding ${to_background_middleground},${background}+F
	face global Whitespace ${to_background_middleground},${background}+F
COLORSCHEME

