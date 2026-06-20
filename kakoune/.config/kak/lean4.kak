# https://lean-lang.org/

hook global BufCreate .*[.](lean) %{
    set-option buffer filetype lean
}


hook global WinSetOption filetype=lean %{
    require-module lean4

    set-option window comment_line '--'
    set-option window comment_block_begin '/-'
    set-option window comment_block_end '-/'

    set-option window extra_word_chars '_' "'"

    set-option -add window matching_pairs '⦃' '⦄' '⟦' '⟧' '⟨' '⟩' '‹' '›' '«' '»' '⁅' '⁆' '‖' '‖'
    set-option -add window matching_pairs '⌊' '⌋' '⌈' '⌉' '⦋' '⦌' '⟪' '⟫'

    hook window ModeChange pop:insert:.* -group lean4-trim-indent lean4-trim-indent
    hook window InsertChar \n -group lean4-insert lean4-insert-on-new-line
    hook window InsertChar \n -group lean4-indent lean4-indent-on-new-line

    hook -group lean4-infoview window BufReload  .* %{ lean4_update_infoview } 
    hook -group lean4-infoview window NormalIdle .* %{ lean4_update_infoview } 
    hook -group lean4-infoview window InsertIdle .* %{ lean4_update_infoview }

    hook -group lean4-abbrev window InsertChar ' ' %{ lean4_expand_abbrevs }
    hook -group lean4-abbrev window InsertKey '<tab>' %{ lean4_expand_abbrevs }
    hook -group lean4-abbrev window InsertChar \n %{
        evaluate-commands -draft %sh{
            printf 'select %s.%s,%s.%s\n' \
            $((${kak_cursor_line}-1)) ${kak_cursor_column} \
            $((${kak_cursor_line}-1)) ${kak_cursor_column}
            printf 'lean4_expand_abbrevs'
        }
    }
    hook -group lean4-abbrev window ModeChange pop:insert:.* %{ lean4_expand_abbrevs }

    hook -once -always window WinSetOption filetype=.* %{ remove-hooks window lean4-.+ }
}

hook -group lean4-highlight global WinSetOption filetype=lean %{
    add-highlighter window/lean4 ref lean4
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/lean4 }
}

provide-module lean4 %[

add-highlighter shared/lean4 regions
add-highlighter shared/lean4/code default-region group
# TODO: support for s! and r! strings
add-highlighter shared/lean4/string region (?<!'\\)(?<!')" (?<!\\)(\\\\)*" fill string
add-highlighter shared/lean4/line_comment region -- $ fill comment
add-highlighter shared/lean4/block_comment region -recurse /- /-  -/ fill comment

add-highlighter shared/lean4/code/ regex (?<!')\b0x+[A-Fa-f0-9]+ 0:value
add-highlighter shared/lean4/code/ regex (?<!')\b\d+([.]\d+)? 0:value

# Infoview
define-command -hidden lean4_update_infoview %{
    lean-get-goal *lean-infoview*
    lean-get-term-goal *lean-infoview-term*
}

# Abbreviations
declare-option -hidden str lean4_saved_sel
define-command -hidden lean4_expand_abbrevs %{
    try %[
        evaluate-commands -draft -save-regs '"' %{
                execute-keys "xs\\\S+<ret>"
                set-register '"' %sh{
                    python $kak_config/lean4_expand_abbrevs.py $kak_selection
                }
                execute-keys "R"
        }
        set-option window lean4_saved_sel %val{selection_desc}
        try %[
            execute-keys "<a-;>x<a-;>s\$CURSOR<ret><a-;>d"
        ] catch %[
            select %opt{lean4_saved_sel}
        ]
    ]
}

# Indentation
# Taken explicitly from rc/filetype/haskell.kak
# https://github.com/mawww/kakoune/blob/master/rc/filetype/haskell.kak
define-command -hidden lean4-trim-indent %{
    try %{ execute-keys -draft -itersel x s \h+$ <ret> d }
}

define-command -hidden lean4-insert-on-new-line %{
    evaluate-commands -draft -itersel %{
        # copy -- comments prefix and following white spaces
        try %{ execute-keys -draft k x s ^\h*\K--\h* <ret> y gh j P }
    }
}

define-command -hidden lean4-indent-on-new-line %{
    evaluate-commands -draft -itersel %{
        # preserve previous line indent
        try %{ execute-keys -draft <semicolon> K <a-&> }
        # align to first clause
        try %{ execute-keys -draft <semicolon> k x X s ^\h*(if|then|else)?\h*(([\w']+\h+)+=)?\h*(case\h+[\w']+\h+of|do|let|where)\h+\K.* <ret> s \A|.\z <ret> & }
        # filter previous line
        try %{ execute-keys -draft k : lean4-trim-indent <ret> }
        # indent after lines beginning with condition or ending with expression or =(
        try %{ execute-keys -draft <semicolon> k x <a-k> ^\h*if|[=(]$|\b(case\h+[\w']+\h+of|do|let|where)$ <ret> j <a-gt> }
    }
}

]


