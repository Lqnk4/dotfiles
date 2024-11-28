return {
    -- statusline
    {
        "rebelot/heirline.nvim",
        enabled = true,
        event = "VeryLazy",
        init = function()
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        opts = function()
            local conditions = require("heirline.conditions")
            local utils = require("heirline.utils")


            local function setup_colors()
                local get_highlight_with_fallback = function(group, layer, alt_group)
                    return utils.get_highlight(group)[layer] or utils.get_highlight(alt_group)[layer]
                end
                return {
                    bright_bg = get_highlight_with_fallback("Folded", "bg", "StatusLine"),
                    bright_fg = utils.get_highlight("Folded").fg,
                    red = utils.get_highlight("DiagnosticError").fg,
                    dark_red = get_highlight_with_fallback("DiffDelete", "bg", "StatusLine"),
                    green = utils.get_highlight("String").fg,
                    blue = utils.get_highlight("Function").fg,
                    gray = utils.get_highlight("NonText").fg,
                    orange = utils.get_highlight("Constant").fg,
                    purple = utils.get_highlight("Statement").fg,
                    cyan = utils.get_highlight("Special").fg,
                    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
                    diag_error = utils.get_highlight("DiagnosticError").fg,
                    diag_hint = utils.get_highlight("DiagnosticHint").fg,
                    diag_info = utils.get_highlight("DiagnosticInfo").fg,
                    git_del = get_highlight_with_fallback("diffDeleted", "fg", "DiagnosticError"),
                    git_add = get_highlight_with_fallback("diffAdded", "fg", "String"),
                    git_change = get_highlight_with_fallback("diffChanged", "fg", "DiagnosticWarn"),
                }
            end

            -- change colors automatically
            vim.api.nvim_create_augroup("Heirline", { clear = true })
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    utils.on_colorscheme(setup_colors)
                end,
                group = "Heirline",
            })
            -- temp fix for update schedule_warp crash on exit
            vim.cmd(":au VimLeavePre * set stl=")

            -- mode
            local ViMode = {
                init = function(self)
                    self.mode = vim.fn.mode(1) -- :h mode()
                end,
                static = {
                    mode_names = {
                        n = "Normal",
                        no = "N?",
                        nov = "N?",
                        noV = "N?",
                        ["no\22"] = "N?",
                        niI = "Ni",
                        niR = "Nr",
                        niV = "Nv",
                        nt = "Nt",
                        v = "Visual",
                        vs = "Vs",
                        V = "Visual_Block",
                        Vs = "Vs",
                        ["\22"] = "^V",
                        ["\22s"] = "^V",
                        s = "Select",
                        S = "S_",
                        ["\19"] = "^S",
                        i = "Insert",
                        ic = "Ic",
                        ix = "Ix",
                        R = "Replace",
                        Rc = "Rc",
                        Rx = "Rx",
                        Rv = "Rv",
                        Rvc = "Rv",
                        Rvx = "Rv",
                        c = "Command",
                        cv = "Ex",
                        r = "...",
                        rm = "M",
                        ["r?"] = "?",
                        ["!"] = "!",
                        t = "Terminal",
                    },
                },
                provider = function(self)
                    return "%2(" .. self.mode_names[self.mode] .. "%)"
                end,
                -- Same goes for the highlight. Now the foreground will change according to the current mode.
                hl = function(self)
                    local mode = self.mode:sub(1, 1) -- get only the first mode character
                    return { fg = self.mode_colors[mode], bold = true, }
                end,
                update = {
                    "ModeChanged",
                    pattern = "*:*",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                    end),
                },
            }

            local FileName = {
                init = function(self)
                    self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
                    if self.lfilename == "" then
                        self.lfilename = "[No Name]"
                    end
                    if not conditions.width_percent_below(#self.lfilename, 0.27) then
                        self.lfilename = vim.fn.pathshorten(self.lfilename)
                    end
                end,
                hl = function()
                    if vim.bo.modified then
                        return { fg = utils.get_highlight("Directory").fg, bold = true, italic = true }
                    end
                    return "Directory"
                end,
                flexible = 2,

                {
                    provider = function(self)
                        return self.lfilename
                    end,
                },
                {
                    provider = function(self)
                        return vim.fn.pathshorten(self.lfilename)
                    end,
                },
            }

            local FileFlags = {
                {
                    condition = function()
                        return vim.bo.modified
                    end,
                    provider = "[+]",
                    hl = { fg = "green" },
                },
                {
                    condition = function()
                        return not vim.bo.modifiable or vim.bo.readonly
                    end,
                    provider = "",
                    hl = { fg = "orange" },
                },
            }

            -- filename
            local FileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(0)
                end,
                FileName,
                unpack(FileFlags),
            }

            -- filetype
            local FileType = {
                provider = function()
                    return string.upper(vim.bo.filetype)
                end,
                hl = { fg = utils.get_highlight("Type").fg, bold = true },
            }

            -- file encoding
            local FileEncoding = {
                provider = function()
                    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
                    return enc ~= 'utf-8' and enc:upper()
                end
            }

            -- file format
            local FileFormat = {
                provider = function()
                    local fmt = vim.bo.fileformat
                    return fmt ~= 'unix' and fmt:upper()
                end
            }

            -- file size
            local FileSize = {
                provider = function()
                    -- stackoverflow, compute human readable file size
                    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
                    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
                    fsize = (fsize < 0 and 0) or fsize
                    if fsize < 1024 then
                        return fsize .. suffix[1]
                    end
                    local i = math.floor((math.log(fsize) / math.log(1024)))
                    return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
                end
            }

            -- file last modified
            local FileLastModified = {
                -- did you know? Vim is full of functions!
                provider = function()
                    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
                    return (ftime > 0) and os.date("%c", ftime)
                end
            }

            -- cursor position
            -- We're getting minimalist here!
            local Ruler = {
                -- %l = current line number
                -- %L = number of lines in the buffer
                -- %c = column number
                -- %P = percentage through file of displayed window
                provider = "%7(%l/%3L%):%2c %P",
            }

            -- scrollbar cursor position
            -- I take no credits for this! 🦁
            local ScrollBar = {
                static = {
                    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
                    -- Another variant, because the more choice the better.
                    -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
                },
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                    return string.rep(self.sbar[i], 2)
                end,
                hl = { fg = "blue", bg = "bright_bg" },
            }

            -- active lsp servers
            local LSPActive = {
                condition = conditions.lsp_attached,
                update = { 'LspAttach', 'LspDetach' },
                on_click = {
                    callback = function()
                        vim.defer_fn(function()
                            vim.cmd("LspInfo")
                        end, 100)
                    end,
                    name = "heirline_LSP",
                },

                provider = function()
                    local names = {}
                    for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                        table.insert(names, server.name)
                    end
                    return " [" .. table.concat(names, " ") .. "]"
                end,
                hl = { fg = "green", bold = true },
            }

            -- navic
            -- Full nerd (with icon colors and clickable elements)!
            -- works in multi window, but does not support flexible components (yet ...)
            local Navic = {
                condition = function() return require("nvim-navic").is_available() end,
                static = {
                    -- create a type highlight map
                    type_hl = {
                        File = "Directory",
                        Module = "@include",
                        Namespace = "@namespace",
                        Package = "@include",
                        Class = "@structure",
                        Method = "@method",
                        Property = "@property",
                        Field = "@field",
                        Constructor = "@constructor",
                        Enum = "@field",
                        Interface = "@type",
                        Function = "@function",
                        Variable = "@variable",
                        Constant = "@constant",
                        String = "@string",
                        Number = "@number",
                        Boolean = "@boolean",
                        Array = "@field",
                        Object = "@type",
                        Key = "@keyword",
                        Null = "@comment",
                        EnumMember = "@field",
                        Struct = "@structure",
                        Event = "@keyword",
                        Operator = "@operator",
                        TypeParameter = "@type",
                    },
                    -- bit operation dark magic, see below...
                    enc = function(line, col, winnr)
                        return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
                    end,
                    -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
                    dec = function(c)
                        local line = bit.rshift(c, 16)
                        local col = bit.band(bit.rshift(c, 6), 1023)
                        local winnr = bit.band(c, 63)
                        return line, col, winnr
                    end
                },
                init = function(self)
                    local data = require("nvim-navic").get_data() or {}
                    local children = {}
                    -- create a child for each level
                    for i, d in ipairs(data) do
                        -- encode line and column numbers into a single integer
                        local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
                        local child = {
                            {
                                provider = d.icon,
                                hl = self.type_hl[d.type],
                            },
                            {
                                -- escape `%`s (elixir) and buggy default separators
                                provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),
                                -- highlight icon only or location name as well
                                -- hl = self.type_hl[d.type],

                                on_click = {
                                    -- pass the encoded position through minwid
                                    minwid = pos,
                                    callback = function(_, minwid)
                                        -- decode
                                        local line, col, winnr = self.dec(minwid)
                                        vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                                    end,
                                    name = "heirline_navic",
                                },
                            },
                        }
                        -- add a separator only if needed
                        if #data > 1 and i < #data then
                            table.insert(child, {
                                provider = " > ",
                                hl = { fg = 'bright_fg' },
                            })
                        end
                        table.insert(children, child)
                    end
                    -- instantiate the new child, overwriting the previous one
                    self.child = self:new(children, 1)
                end,
                -- evaluate the children containing navic components
                provider = function(self)
                    return self.child:eval()
                end,
                hl = { fg = "gray" },
                update = 'CursorMoved'
            }

            -- lsp diagnostics
            local Diagnostics = {

                condition = conditions.has_diagnostics,

                static = {
                    error_icon = require("config").icons.diagnostics.Error,
                    warn_icon = require("config").icons.diagnostics.Warn,
                    info_icon = require("config").icons.diagnostics.Info,
                    hint_icon = require("config").icons.diagnostics.Hint,
                },

                init = function(self)
                    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
                end,

                update = {
                    "DiagnosticChanged",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                        vim.cmd("redrawtabline")
                    end),
                },

                {
                    provider = "![",
                },
                {
                    provider = function(self)
                        -- 0 is just another output, we can decide to print it or not!
                        return self.errors > 0 and (self.error_icon .. self.errors .. " ")
                    end,
                    hl = { fg = "diag_error" },
                },
                {
                    provider = function(self)
                        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
                    end,
                    hl = { fg = "diag_warn" },
                },
                {
                    provider = function(self)
                        return self.info > 0 and (self.info_icon .. self.info .. " ")
                    end,
                    hl = { fg = "diag_info" },
                },
                {
                    provider = function(self)
                        return self.hints > 0 and (self.hint_icon .. self.hints)
                    end,
                    hl = { fg = "diag_hint" },
                },
                {
                    provider = "]",
                },
            }

            -- git
            local Git = {
                condition = conditions.is_git_repo,

                init = function(self)
                    self.status_dict = vim.b.gitsigns_status_dict
                    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
                        self.status_dict.changed ~= 0
                end,

                hl = { fg = "orange" },


                { -- git branch name
                    provider = function(self)
                        return " " .. self.status_dict.head
                    end,
                    hl = { bold = true }
                },
                -- You could handle delimiters, icons and counts similar to Diagnostics
                {
                    condition = function(self)
                        return self.has_changes
                    end,
                    provider = "("
                },
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and ("+" .. count)
                    end,
                    hl = { fg = "git_add" },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and ("-" .. count)
                    end,
                    hl = { fg = "git_del" },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0
                        return count > 0 and ("~" .. count)
                    end,
                    hl = { fg = "git_change" },
                },
                {
                    condition = function(self)
                        return self.has_changes
                    end,
                    provider = ")",
                },
                update = {
                    "User",
                    pattern = "GitSignsUpdate",
                    callback = vim.schedule_wrap(function()
                        vim.cmd("redrawstatus")
                    end),
                },
            }

            -- -- provides info from nvim-dap
            -- Note that we add spaces separately, so that only the icon characters will be clickable
            -- local DAPMessages = {
            --     condition = function()
            --         local session = require("dap").session()
            --         return session ~= nil
            --     end,
            --     provider = function()
            --         return " " .. require("dap").status() .. " "
            --     end,
            --     hl = "Debug",
            --     {
            --         provider = "",
            --         on_click = {
            --             callback = function()
            --                 require("dap").step_into()
            --             end,
            --             name = "heirline_dap_step_into",
            --         },
            --     },
            --     { provider = " " },
            --     {
            --         provider = "",
            --         on_click = {
            --             callback = function()
            --                 require("dap").step_out()
            --             end,
            --             name = "heirline_dap_step_out",
            --         },
            --     },
            --     { provider = " " },
            --     {
            --         provider = " ",
            --         on_click = {
            --             callback = function()
            --                 require("dap").step_over()
            --             end,
            --             name = "heirline_dap_step_over",
            --         },
            --     },
            --     { provider = " " },
            --     {
            --         provider = "ﰇ",
            --         on_click = {
            --             callback = function()
            --                 require("dap").run_last()
            --             end,
            --             name = "heirline_dap_run_last",
            --         },
            --     },
            --     { provider = " " },
            --     {
            --         provider = "",
            --         on_click = {
            --             callback = function()
            --                 require("dap").terminate()
            --                 require("dapui").close({})
            --             end,
            --             name = "heirline_dap_close",
            --         },
            --     },
            --     { provider = " " },
            --     -- icons:       ﰇ  
            -- }

            -- working directory
            local WorkDir = {
                init = function(self)
                    self.icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
                    local cwd = vim.fn.getcwd(0)
                    self.cwd = vim.fn.fnamemodify(cwd, ":~")
                end,
                hl = { fg = "blue", bold = true },

                flexible = 1,

                {
                    -- evaluates to the full-lenth path
                    provider = function(self)
                        local trail = self.cwd:sub(-1) == "/" and "" or "/"
                        return self.icon .. self.cwd .. trail .. " "
                    end,
                },
                {
                    -- evaluates to the shortened path
                    provider = function(self)
                        local cwd = vim.fn.pathshorten(self.cwd)
                        local trail = self.cwd:sub(-1) == "/" and "" or "/"
                        return self.icon .. cwd .. trail .. " "
                    end,
                },
                {
                    -- evaluates to "", hiding the component
                    provider = "",
                }
            }

            -- hepfile name
            local HelpFilename = {
                condition = function()
                    return vim.bo.filetype == "help"
                end,
                provider = function()
                    local filename = vim.api.nvim_buf_get_name(0)
                    return vim.fn.fnamemodify(filename, ":t")
                end,
                hl = "Directory",
            }

            -- terminal buf name
            local TerminalName = {
                -- we could add a condition to check that buftype == 'terminal'
                -- or we could do that later (see #conditional-statuslines below)
                provider = function()
                    local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
                    return " " .. tname
                end,
                hl = { fg = "blue", bold = true },
            }

            -- indicator of when inside a snippet
            local Snippets = {
                -- check that we are in insert or select mode
                condition = function()
                    return vim.tbl_contains({ 's', 'i' }, vim.fn.mode())
                end,
                provider = function()
                    local forward = (vim.snippet.active({ direction = 1 })) and "" or ""
                    local backward = (vim.snippet.active({ direction = -1 })) and " " or ""
                    return backward .. forward
                end,
                hl = { fg = "red", bold = true },
            }

            -- indicate when spell is set
            local Spell = {
                condition = function()
                    return vim.wo.spell
                end,
                provider = 'SPELL ',
                hl = { bold = true, fg = "orange" }
            }

            -- count for [/] search
            local SearchCount = {
                condition = function()
                    return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
                end,
                init = function(self)
                    local ok, search = pcall(vim.fn.searchcount)
                    if ok and search.total then
                        self.search = search
                    end
                end,
                provider = function(self)
                    local search = self.search
                    return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
                end,
            }

            -- indicator for recording macros
            local MacroRec = {
                condition = function()
                    return vim.fn.reg_recording() ~= "" --and vim.o.cmdheight == 0
                end,
                provider = " ",
                hl = { fg = "orange", bold = true },
                utils.surround({ "[", "]" }, nil, {
                    provider = function()
                        return vim.fn.reg_recording()
                    end,
                    hl = { fg = "green", bold = true },
                }),
                update = {
                    "RecordingEnter",
                    "RecordingLeave",
                }
            }

            -- show cmd mode
            vim.opt.showcmdloc = 'statusline'
            local ShowCmd = {
                -- condition = function()
                --     return vim.o.cmdheight == 0
                -- end,
                provider = "%3.5(%S%) ",
            }

            -- spacing
            local Align = { provider = "%=" }
            local Space = { provider = " " }

            ViMode = utils.surround({ "█", "█" }, "bright_bg", { MacroRec, ViMode, Snippets, })

            local DefaultStatusline = {
                ViMode,
                Space,
                Spell,
                WorkDir,
                FileNameBlock,
                { provider = "%<" },
                Space,
                Git,
                Space,
                Diagnostics,
                Align,
                { flexible = 3,   { Navic, Space }, { provider = "" } },
                Align,
                ShowCmd,
                Space,
                LSPActive,
                Space,
                FileType,
                { flexible = 3, { FileEncoding, Space }, { provider = "" } },
                Space,
                Ruler,
                SearchCount,
                Space,
                ScrollBar,
            }

            -- for inactive windows
            local InactiveStatusline = {
                condition = conditions.is_not_active,
                { hl = { fg = "gray", force = true }, WorkDir },
                FileNameBlock,
                { provider = "%<" },
                Align,
            }

            -- helpfile statusline
            local SpecialStatusline = {
                condition = function()
                    return conditions.buffer_matches({
                        buftype = { "nofile", "prompt", "help", "quickfix" },
                        filetype = { "^git.*", "fugitive" },
                    })
                end,
                FileType,
                { provider = "%q" },
                Space,
                HelpFilename,
                Align,
            }

            -- git statusline
            local GitStatusline = {
                condition = function()
                    return conditions.buffer_matches({
                        filetype = { "^git.*", "fugitive" },
                    })
                end,
                FileType,
                Space,
                {
                    provider = function()
                        return vim.fn.FugitiveStatusline()
                    end,
                },
                Space,
                Align,
            }

            -- terminal statusline
            local TerminalStatusline = {
                condition = function()
                    return conditions.buffer_matches({ buftype = { "terminal" } })
                end,
                hl = { bg = "dark_red" },
                { condition = conditions.is_active, ViMode, Space },
                FileType,
                Space,
                TerminalName,
                Align,
            }

            -- assembling conditional statuslines
            local StatusLines = {
                hl = function()
                    if conditions.is_active() then
                        return "StatusLine"
                    else
                        return "StatusLineNC"
                    end
                end,
                static = {
                    mode_colors = {
                        n = "red",
                        i = "green",
                        v = "cyan",
                        V = "cyan",
                        ["\22"] = "cyan", -- this is an actual ^V, type <C-v><C-v> in insert mode
                        c = "orange",
                        s = "purple",
                        S = "purple",
                        ["\19"] = "purple", -- this is an actual ^S, type <C-v><C-s> in insert mode
                        R = "orange",
                        r = "orange",
                        ["!"] = "red",
                        t = "green",
                    },
                    mode_color = function(self)
                        local mode = conditions.is_active() and vim.fn.mode() or "n"
                        return self.mode_colors[mode]
                    end,
                },
                fallthrough = false,
                --GitStatusline,
                SpecialStatusline,
                TerminalStatusline,
                InactiveStatusline,
                DefaultStatusline,
            }

            return {
                -- intentional duplicate, see :h heirline config.opts
                opts = {
                    colors = setup_colors
                },
                statusline = { StatusLines }
            }
        end,
    },

    -- alternate statusline
    {
        'bluz71/nvim-linefly',
        enabled = false,
    },

    -- dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        enabled = true,
        init = false,
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local saturn = [[

                                         _.oo.
                 _.u[[/;:,.         .odMMMMMM'
              .o888UU[[[/;:-.  .o@P^    MMM^
             oN88888UU[[[/;::-.        dP^
            dNMMNN888UU[[[/;:--.   .o@P^
           ,MMMMMMN888UU[[/;::-. o@^
           NNMMMNN888UU[[[/~.o@P^
           888888888UU[[[/o@^-..
          oI8888UU[[[/o@P^:--..
       .@^  YUU[[[/o@^;::---..
     oMP     ^/o@P^;:::---..
  .dMMM    .o@^ ^;::---...
 dMMMMMMM@^`       `^^^^
YMMMUP^
 ^^


    ]]
            dashboard.section.header.val = vim.split(saturn, "\n")
            -- stylua: ignore
            dashboard.section.buttons.val = {
                dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  > Find file", "<cmd>FzfLua files<cr>"),
                dashboard.button("r", "  > Recent", "<cmd>FzfLua oldfiles<cr>"),
                dashboard.button("c", "  > Config", ":e $MYVIMRC | :cd %:p:h |<CR>"),
                dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)
        end,
    },

    -- edgy
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>ue",
                function()
                    require("edgy").toggle()
                end,
                desc = "Edgy Toggle",
            },
            -- stylua: ignore
            { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
        },
        opts = function()
            local opts = {
                bottom = {},
                left = {},
                right = {
                    { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
                },
                keys = {
                    -- increase width
                    ["<c-Right>"] = function(win)
                        win:resize("width", 2)
                    end,
                    -- decrease width
                    ["<c-Left>"] = function(win)
                        win:resize("width", -2)
                    end,
                    -- increase height
                    ["<c-Up>"] = function(win)
                        win:resize("height", 2)
                    end,
                    -- decrease height
                    ["<c-Down>"] = function(win)
                        win:resize("height", -2)
                    end,
                },
            }

            -- snacks terminal
            for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
                opts[pos] = opts[pos] or {}
                table.insert(opts[pos], {
                    ft = "snacks_terminal",
                    size = { height = 0.25 },
                    title = "%{b:snacks_terminal.id}: %{b:term_title}",
                    filter = function(_buf, win)
                        return vim.w[win].snacks_win
                            and vim.w[win].snacks_win.position == pos
                            and vim.w[win].snacks_win.relative == "editor"
                            and not vim.w[win].trouble_preview
                    end,
                })
            end
            return opts
        end,
    }
}
