return {
    cmd = { "ada_language_server" },
    filetypes = { "ada" },
    root_markers = {
        '*.gpr',
        'Makefile',
        'alire.toml',
        '*.adc',
        '.git',
    },
    settings = {
        ada = {
            -- number of parameters/components at which point named notation is
            -- used for subprogram/aggregate completion snippets.
            namedNotationThreshold = 6,
        }
    },
}
