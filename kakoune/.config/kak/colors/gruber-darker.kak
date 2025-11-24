# Gruber-Darker theme for Kakoune
# 
# Based on Rexim's gruber-darker-theme for Emacs.
#

# Color palette
declare-option str foreground       "rgb:e4e4e4"
declare-option str foreground1      "rgb:f4f4f4"
declare-option str foreground2      "rgb:f5f5f5"

declare-option str background_1     "rgb:101010"
declare-option str background       "rgb:181818"
declare-option str background1      "rgb:282828"
declare-option str background2      "rgb:453d41"
declare-option str background3      "rgb:484848"
declare-option str background4      "rgb:52494e"

declare-option str darker_red_1     "rgb:c73c3f"
declare-option str darker_red       "rgb:f43841"
declare-option str darker_red1      "rgb:ff4f58"

declare-option str darker_green     "rgb:73c936"
declare-option str darker_yellow    "rgb:ffdd33"
declare-option str darker_brown     "rgb:cc8c3c"
declare-option str darker_quartz    "rgb:95a99f"

declare-option str darker_niagara_2 "rgb:303540"
declare-option str darker_niagara_1 "rgb:565f73"
declare-option str darker_niagara   "rgb:96a6c8"
declare-option str darker_wisteria  "rgb:9e95c7"

# Code
set-face global value               "%opt{foreground}"
set-face global type                "%opt{darker_yellow}"
set-face global variable            "%opt{foreground1}"
set-face global module              "%opt{darker_quartz}"
set-face global function            "%opt{darker_niagara}"
set-face global string              "%opt{darker_green}"
set-face global keyword             "%opt{darker_yellow}+b"
set-face global attribute           "%opt{darker_niagara}"
# set-face global comment             "%opt{background3}+b"
set-face global comment             "%opt{darker_brown}"
set-face global documentation       "%opt{darker_brown}+i"

# #include <...>
set-face global meta                "%opt{darker_quartz}"

set-face global operator            "%opt{foreground}"
set-face global comma               "%opt{foreground}"
set-face global bracket             "%opt{darker_quartz}"

set-face global builtin             "%opt{darker_yellow}+b"

# Markup
set-face global title               "%opt{foreground}"
set-face global header              "%opt{darker_yellow}"
set-face global bold                "%opt{darker_quartz}"
set-face global italic              "%opt{darker_brown}"
set-face global mono                "%opt{foreground2}"
set-face global block               "%opt{darker_brown}"
set-face global link                "%opt{darker_wisteria}"
set-face global bullet              "%opt{darker_yellow}"
set-face global list                "%opt{darker_brown}"

# Builtin
# fg,bg+attributes

# face global Default default,rgb:262626 <- change the terminal bg color instead
set-face global Default             "%opt{foreground},%opt{background}"

set-face global PrimarySelection    "%opt{darker_niagara},%opt{background3}"
set-face global SecondarySelection  "%opt{foreground2},%opt{background2}"

set-face global PrimaryCursor       "%opt{background_1},%opt{darker_yellow}+bfg"
set-face global SecondaryCursor     "%opt{background3},%opt{darker_yellow}+bfg"
set-face global PrimaryCursorEol    "%opt{background_1},%opt{darker_yellow}"
set-face global SecondaryCursorEol  "%opt{background3},%opt{darker_yellow}"

set-face global LineNumbers         "%opt{background4},%opt{background}"
set-face global LineNumberCursor    "%opt{darker_yellow},%opt{background1}"
set-face global LineNumbersWrapped  "%opt{background3},%opt{darker_brown}+i"

# Bottom menu:
# selected entry in menu
set-face global MenuForeground      "%opt{background},%opt{darker_yellow}+b" # "%opt{background1},%opt{darker_wisteria}+b"
# text + background
set-face global MenuBackground      "%opt{foreground1},%opt{background1}"

# completion menu info
set-face global MenuInfo            "%opt{darker_brown},default"

# assistant, [+]
set-face global Information         "%opt{foreground1},%opt{background}"


set-face global Error               "%opt{darker_red},%opt{background}"
set-face global DiagnosticError     "%opt{darker_red},%opt{background}"
set-face global DiagnosticWarning   "%opt{darker_brown},%opt{background}"
set-face global StatusLine          "%opt{darker_quartz},%opt{background}"

# Status line modes and prompts:
# insert, prompt, enter key ...
set-face global StatusLineMode      "%opt{foreground2},%opt{background}"

# 1 sel
set-face global StatusLineInfo      "%opt{darker_brown},%opt{background}"

# param=value, reg=value. ex: "ey
set-face global StatusLineValue     "%opt{darker_brown},%opt{background}"

set-face global StatusCursor        "%opt{foreground},%opt{darker_quartz}"

# :
set-face global Prompt              "%opt{darker_yellow},%opt{background}"

# {}, ()
set-face global MatchingChar        "%opt{darker_brown},%opt{background}"

# Whitespace characters
set-face global Whitespace          "%opt{background2},%opt{background}+f"

set-face global WrapMarker          "%opt{darker_wisteria},%opt{background}"

# EOF tildas (~)
set-face global BufferPadding       "%opt{darker_wisteria},%opt{background}"

## Tree-sitter
# TODO:
set-face global ts_attribute                    "%opt{darker_niagara}"
set-face global ts_comment                      "%opt{darker_brown}+i"
set-face global ts_conceal                      "%opt{darker_brown}+i"
set-face global ts_constant                     "%opt{foreground2}"
set-face global ts_constant_builtin_boolean     "%opt{foreground2}+b"
set-face global ts_constant_character           "%opt{foreground2}"
set-face global ts_constant_macro               "%opt{foreground2}"
set-face global ts_constructor                  "%opt{darker_yellow}"
set-face global ts_diff_plus                    "%opt{darker_green}"
set-face global ts_diff_minus                   "%opt{darker_red1}"
set-face global ts_diff_delta                   "%opt{foreground}"
set-face global ts_diff_delta_moved             "%opt{foreground2}"
set-face global ts_error                        "%opt{darker_red}+b"
set-face global ts_function                     "%opt{darker_niagara}"
set-face global ts_function_builtin             "%opt{darker_niagara}+i"
set-face global ts_function_macro               "%opt{darker_niagara_1}"
set-face global ts_hint                         "%opt{darker_brown}+b"
set-face global ts_info                         "%opt{darker_brown}+b"
set-face global ts_keyword                      "%opt{darker_yellow}"
set-face global ts_keyword_conditional          "%opt{darker_yellow}+b"
set-face global ts_keyword_control_conditional  "%opt{darker_yellow}+b"
set-face global ts_keyword_control_directive    "%opt{darker_yellow}+i"
set-face global ts_keyword_control_import       "%opt{darker_yellow}+i"
set-face global ts_keyword_directive            "%opt{darker_yellow}+i"
set-face global ts_label                        "%opt{darker_yellow}+i"
set-face global ts_markup_bold                  "%opt{darker_quartz}+b"
set-face global ts_markup_heading               "%opt{foreground}"
set-face global ts_markup_heading_1             "%opt{foreground}"
set-face global ts_markup_heading_2             "%opt{darker_yellow}"
set-face global ts_markup_heading_3             "%opt{darker_brown}"
set-face global ts_markup_heading_4             "%opt{darker_quartz}"
set-face global ts_markup_heading_5             "%opt{foreground}"
set-face global ts_markup_heading_6             "%opt{foreground2}"
set-face global ts_markup_heading_marker        "%opt{background3}+b"
set-face global ts_markup_italic                "%opt{darker_brown}+i"
set-face global ts_markup_list_checked          "%opt{foreground}"
set-face global ts_markup_list_numbered         "%opt{foreground}+i"
set-face global ts_markup_list_unchecked        "%opt{darker_quartz}"
set-face global ts_markup_list_unnumbered       "%opt{foreground}"
set-face global ts_markup_link_label            "%opt{foreground2}"
set-face global ts_markup_link_url              "%opt{darker_wisteria}+u"
set-face global ts_markup_link_uri              "%opt{darker_wisteria}+u"
set-face global ts_markup_link_text             "%opt{darker_niagara}"
set-face global ts_markup_quote                 "%opt{darker_green}"
set-face global ts_markup_raw                   "%opt{foreground}"
set-face global ts_markup_strikethrough         "%opt{darker_green}+s"
set-face global ts_namespace                    "%opt{darker_yellow}+i"
set-face global ts_operator                     "%opt{foreground}"
set-face global ts_property                     "%opt{foreground1}"
set-face global ts_punctuation                  "%opt{foreground}"
set-face global ts_punctuation_special          "%opt{foreground}"
set-face global ts_special                      "%opt{darker_wisteria}"
set-face global ts_spell                        "%opt{darker_niagara_2}"
set-face global ts_string                       "%opt{darker_green}"
set-face global ts_string_regex                 "%opt{darker_green}"
set-face global ts_string_regexp                "%opt{darker_niagara_1}"
set-face global ts_string_escape                "%opt{darker_niagara_1}"
set-face global ts_string_special               "%opt{darker_green}"
set-face global ts_string_special_path          "%opt{darker_niagara}"
set-face global ts_string_special_symbol        "%opt{darker_niagara}"
set-face global ts_string_symbol                "%opt{foreground}"
set-face global ts_tag                          "%opt{darker_quartz}"
set-face global ts_tag_error                    "%opt{darker_red1}"
set-face global ts_text                         "%opt{foreground}"
set-face global ts_text_title                   "%opt{foreground1}"
set-face global ts_type                         "%opt{darker_wisteria}"
set-face global ts_type_enum_variant            "%opt{darker_wisteria}"
set-face global ts_variable                     "%opt{foreground1}"
set-face global ts_variable_builtin             "%opt{foreground1}"
set-face global ts_variable_other_member        "%opt{foreground2}"
set-face global ts_variable_parameter           "%opt{foreground2}+i"
set-face global ts_warning                      "%opt{darker_brown}+b"
