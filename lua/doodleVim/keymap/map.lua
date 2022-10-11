local bind = require('doodleVim.keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

local map = {}

map.Lsp = {
    n = {
        ["g"] = {
            name = "Lsp Function",
            d = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.lsp').lsp_definitions()"):with_noremap():
                with_silent():with_label("Go To Definition")),
            D = bind.convert_wk_format(map_cr("lua vim.lsp.buf.declaration()"):with_noremap():with_silent():with_label("Go To Declaration")),
            t = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.lsp').lsp_type_definition()"):with_noremap()
                :
                with_silent():with_label("Go To Type Definition")),
            i = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.lsp').lsp_implementations()"):with_noremap()
                :
                with_silent():with_label("Go To Implementation")),
            r = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.lsp').lsp_references()"):with_noremap():
                with_silent():with_label("Go To Reference")),
            h = bind.convert_wk_format(map_cr("lua vim.lsp.buf.hover()"):with_noremap():with_silent():with_label("Hover Documentation")),
            f = bind.convert_wk_format(map_cr("lua vim.lsp.buf.format { async = true }"):with_noremap():with_silent():
                with_label("Code Formatting")),
            a = bind.convert_wk_format(map_cr("lua vim.lsp.buf.code_action()"):with_noremap():with_silent():with_label("Code Action")),
            n = bind.convert_wk_format(map_cr("lua require('rename').rename()"):with_noremap():with_silent():with_label("Rename"))
        },
        ["<C-n>"] = bind.convert_wk_format(map_cr("lua vim.diagnostic.goto_next()"):with_noremap():with_silent():
            with_label("Go To Next Diagnostic")),
        ["<C-p>"] = bind.convert_wk_format(map_cr("lua vim.diagnostic.goto_prev()"):with_noremap():with_silent():
            with_label("Go To Previous Diagnostic")),


    },
    v = {
        ["g"] = {
            name = "Lsp Function",
            f = bind.convert_wk_format(map_cu("lua vim.lsp.buf.formatting()"):with_noremap():with_silent():with_label("Selected Code Formatting")),
            a = bind.convert_wk_format(map_cu("lua vim.lsp.buf.code_action()"):with_noremap():with_silent():
                with_label("Range Code Action")),
            n = bind.convert_wk_format(map_cr("lua require('rename').rename()"):with_noremap():with_silent():with_label("Rename"))
        },
    },
}

map.NvimTree_Translator = {
    n = {
        ["t"] = {
            name = "Tree, Translator",
            t = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.tree').toggle()"):with_noremap():
                with_silent():
                with_label("Enhanced NvimTree Toggle")),
            w = bind.convert_wk_format(map_cmd("<Cmd>NvimTreeRefresh<CR>"):
                with_noremap():with_silent():with_label("NvimTree Refresh")),
            r = bind.convert_wk_format(map_cr("TranslateW"):with_silent():with_label("Translate Word In Cursor"))
        },
    },
}

map.SymbolsOutline = {
    n = {
        ["<leader>v"] = {
            name = "Symbols-Outline",
            v = bind.convert_wk_format(map_cr('lua ensure_require"symbols-outline".toggle_outline()'):with_noremap():
                with_silent():with_label("Symbols And Function Preview"))
        },
    }
}

map.Packer = {
    n = {
        ["<leader>p"] = {
            name = "Packer Manage",
            u = bind.convert_wk_format(map_cr("PackerUpdate"):with_silent():with_noremap():with_label("Packer Update")),
            c = bind.convert_wk_format(map_cr("PackerCompile"):with_silent():with_noremap():with_label("Packer Compile")),
            x = bind.convert_wk_format(map_cr("PackerClean"):with_silent():with_noremap():with_label("Packer Clean")),
        },
    }
}

map.Diagnostic = {
    n = {
        ["<leader>e"] = {
            name = "Show Diagnostics",
            d = bind.convert_wk_format(map_cr("Telescope diagnostics bufnr=0"):with_noremap():with_silent():with_label("Show Diagnostics In Current Buffer")),
            e = bind.convert_wk_format(map_cr("Telescope diagnostics"):with_noremap():with_silent():with_label("Show Diagnostics In WorkSpace")),
            t = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.diagnostics').toggle_virtual_text()"):
                with_noremap():with_silent():with_label("Toggle Diagnostics Virtual Text"))
        },
    }
}

map.MarkdownPreview_EasyAlign = {
    n = {
        ["<leader>m"] = {
            name = "MarkdownPreview, EasyAlign",
            w = bind.convert_wk_format(map_cr('MarkdownPreviewToggle'):with_noremap():with_silent():with_label("Toggle Markdown Preview")),
            a = bind.convert_wk_format(map_cmd("<Plug>(EasyAlign)<CR>"):with_label("EasyAlign File"))
        }
    },
    v = {
        ["<leader>m"] = {
            name = "MarkdownPreview, EasyAlign",
            -- w = bind.convert_wk_format(map_cr('MarkdownPreviewToggle'):with_noremap():with_silent():with_label("Toggle Markdown Preview")),
            a = bind.convert_wk_format(map_cmd("<Plug>(EasyAlign)"):with_label("EasyAlign File"))
        }
    }
}

map.Floaterm = {
    n = {
        ["m"] = {
            name = "Floaterm",
            m = bind.convert_wk_format(map_cr('FloatermToggle'):with_noremap():with_silent():with_label("Toggle Floaterm")),
            y = bind.convert_wk_format(map_cr('FloatermNew'):with_noremap():with_silent():with_label("Open Floaterm In Project Root Dir")),
            t = bind.convert_wk_format(map_cr('FloatermNew --cwd=<buffer>'):with_noremap():with_silent():with_label("Open Floaterm In Current Buffer Dir")),
            j = { "Kill All Floaterm In Terminal Mode" },
            k = { "Kill Current Floaterm In Terminal Mode" },
        },
    },

    t = {

        ["<C-Space>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
            "Toggle Terminal", noremap = true, silent = true },
        ["<C-h>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermPrev<CR>", true, true, true),
            "Go To Next Terminal", noremap = true, silent = true },
        ["<C-l>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNext<CR>", true, true, true),
            "Go To Previous Terminal", noremap = true, silent = true },
        ["<C-j>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermKill<CR>", true, true, true),
            "Kill Current Terminal", noremap = true, silent = true },
        ["<C-k>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermKill!<CR>", true, true, true),
            "Kill All Terminal", noremap = true, silent = true },
        ["<C-y>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNew<CR>", true, true, true),
            "Floaterm In Project Root Dir", noremap = true, silent = true },
        ["<C-t>"] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>:lua require("doodleVim.extend.misc").new_floaterm()<CR>'
            , true, true, true),
            "Floaterm In Current Buffer Dir", noremap = true, silent = true },
    }
}

map.Comment = {
    n = {
        ["<leader>c"] = {
            name = "Comment",
            c = bind.convert_wk_format(map_cr('lua require("Comment.api").toggle.linewise.current()'):with_noremap():
                with_silent():with_label("Comment Current Line")),
        },
    },
    v = {
        ["<leader>c"] = {
            name = "Comment",
            c = bind.convert_wk_format(map_cmd('<esc><cmd>lua require("comment.api").toggle.linewise(vim.fn.visualmode())<cr>')
                :with_noremap():with_silent():with_label("comment selected line")),
            v = bind.convert_wk_format(map_cmd('<esc><cmd>lua require("comment.api").toggle.blockwise(vim.fn.visualmode())<cr>')
                :with_noremap():with_silent():with_label("comment selected line")),
        },

    }
}


map.Telescope = {
    n = {
        ["<leader>f"] = {
            name = "Telescope Search",
            f = bind.convert_wk_format(map_cr('Telescope find_files'):with_noremap():with_silent():with_label("Find Files")),
            d = bind.convert_wk_format(map_cr('Telescope file_browser'):with_noremap():with_silent():with_label("File Browser")),
            g = bind.convert_wk_format(map_cr('Telescope live_grep'):with_noremap():with_silent():with_label("Live Grep")),
            h = bind.convert_wk_format(map_cr('Telescope projects'):with_noremap():with_silent():with_label("Find Projects")),
            j = bind.convert_wk_format(map_cr('Telescope todo-comments todo'):with_noremap():with_silent():with_label("Find Todos")),
            o = bind.convert_wk_format(map_cr('Telescope oldfiles'):with_noremap():with_silent():with_label("Find Recent Files")),
            n = bind.convert_wk_format(map_cr('Telescope neoclip'):with_noremap():with_silent():with_label("Find Saved Buffer In Clipboard")),
            b = bind.convert_wk_format(map_cr('Telescope buffers'):with_noremap():with_silent():with_label("Buffers Navigation"))
        },
    }
}

map.Hop = {
    n = {
        ["<leader>s"] = {
            name = "Search Word",
            w = bind.convert_wk_format(map_cr("lua ensure_require'hop'.hint_words()"):with_noremap():with_silent():
                with_label("Search Word")),
            s = bind.convert_wk_format(map_cr("lua ensure_require'hop'.hint_char2()"):with_noremap():with_silent():
                with_label("Search By First 2 Char"))
        },
    }
}

map.Neogen_toogleNu = {
    n = {
        ["<leader>n"] = {
            name = "Generate Documentation or Line Number Toggle",
            c = bind.convert_wk_format(map_cr("lua require('neogen').generate({type='class'})"):with_noremap():
                with_silent()
                :with_label("Generate Class Documentation")),
            t = bind.convert_wk_format(map_cr("lua require('neogen').generate({type='type'})"):with_noremap():
                with_silent():
                with_label("Generate Type Documentation")),
            f = bind.convert_wk_format(map_cr("lua require('neogen').generate({type='func'})"):with_noremap():
                with_silent():
                with_label("Generate Function Documentation")),
            d = bind.convert_wk_format(map_cr("lua require('neogen').generate({type='file'})"):with_noremap():
                with_silent():
                with_label("Generate File Documentation")),
            u = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.misc').toggle_nu()"):with_noremap():
                with_silent()
                :with_label("Toggle Absolute Line Number")),
            r = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.misc').toggle_rnu()"):with_noremap():
                with_silent():with_label("Toggle Relative Line Number")),
        },
    }
}

map.Dap = {
    n = {
        ["<F7>"] = bind.convert_wk_format(map_cr("DapContinue"):with_noremap():with_silent():with_label("Start Or Continue Debug")),
        ["<S-F7>"] = bind.convert_wk_format(map_cr("DapTerminate"):with_noremap():with_silent():with_label("Stop Debugging, Shortcut: Shift + F7")),
        ["<F8>"] = bind.convert_wk_format(map_cr("lua require('dap').pause()"):with_noremap():with_silent():with_label("Pause Debug")),
        ["<S-F8>"] = bind.convert_wk_format(map_cr("lua require('dap').restart()"):with_noremap():with_silent():
            with_label("Restart Debug")),
        ["<F9>"] = bind.convert_wk_format(map_cr("DapToggleBreakpoint"):with_noremap():with_silent():with_label("Toggle Breakpoint")),
        ["<F10>"] = bind.convert_wk_format(map_cr("DapStepOver"):with_noremap():with_silent():with_label("Step Over")),
        ["<F11>"] = bind.convert_wk_format(map_cr("DapStepInto"):with_noremap():with_silent():with_label("Step Into")),
        ["<S-F11>"] = bind.convert_wk_format(map_cr("DapStepOut"):with_noremap():with_silent():with_label("Step Out, Shortcut: Shift + F11")),
        ["<F12>"] = bind.convert_wk_format(map_cr("lua require('dap').run_to_cursor()"):with_noremap():with_silent():
            with_label("Run To Cursor")),
        ["<S-F12>"] = bind.convert_wk_format(map_cr("lua require('dap').run_last()"):with_noremap():with_silent():
            with_label("Run To Last, Shortcut: Shift + F12")),

    }
}

map.Bufferline = {
    n = {
        ["<S-h>"] = bind.convert_wk_format(map_cr("BufferPrevious"):with_noremap():with_silent():with_label("Previous Buffer")),
        ["<S-l>"] = bind.convert_wk_format(map_cr("BufferNext"):with_noremap():with_silent():with_label("Next Buffer")),
        ["<S-n>"] = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.misc').enhanced_buffer_close()"):
            with_noremap():with_silent():with_label("Close Current Buffer")),
        ["<M-s>"] = bind.convert_wk_format(map_cr("BufferOrderByDirectory"):with_noremap():with_silent():with_label("Sort Buffer")),
        ["<M-b>"] = bind.convert_wk_format(map_cr("BufferCloseBuffersLeft"):with_noremap():with_silent():with_label("Close All Buffers Left")),
        ["<M-m>"] = bind.convert_wk_format(map_cr("BufferCloseBuffersRight"):with_noremap():with_silent():with_label("Close All Buffers Right")),
        ["<M-h>"] = bind.convert_wk_format(map_cr("BufferMovePrevious"):with_noremap():with_silent():with_label("Re-order To Previous")),
        ["<M-l>"] = bind.convert_wk_format(map_cr("BufferMoveNext"):with_noremap():with_silent():with_label("Re-order To Next")),
        ["<M-i>"] = bind.convert_wk_format(map_cr("BufferPin"):with_noremap():with_silent():with_label("Pin Buffer")),
        ["<M-o>"] = bind.convert_wk_format(map_cr("BufferPick"):with_noremap():with_silent():with_label("Pick Buffer")),

    }
}

map.WhichKey = {
    n = {
        ["<C-Space>"] = bind.convert_wk_format(map_cr("lua require('doodleVim.extend.misc').toggle_whichkey()"):
            with_noremap()
            :with_silent():with_label("Show Keymaps")),
    },
    v = {
        ["<C-Space>"] = bind.convert_wk_format(map_cmd("<Cmd>lua require('doodleVim.extend.misc').toggle_whichkey()<CR>")
            :with_noremap():with_label("Show Keymaps"))

    },
    i = {
        ["<C-Space>"] = bind.convert_wk_format(map_cmd("<Cmd>lua require('doodleVim.extend.misc').toggle_whichkey()<CR>")
            :with_noremap():with_label("Show Keymaps")),
    }
}

map.Gitsigns = {
    n = {
        ["<M-n>"] = bind.convert_wk_format(map_cr("Gitsigns next_hunk"):with_noremap():with_silent():with_label("Next Hunk")),
        ["<M-p>"] = bind.convert_wk_format(map_cr("Gitsigns prev_hunk"):with_noremap():with_silent():with_label("Previous Hunk")),

    }
}

map.VBox = {
    v = {

        ["<leader>l"] = {
            name = "Draw Ascii Picture",
            l = bind.convert_wk_format(map_cu("VBox"):with_noremap():with_silent():with_label("Normal Line")),
            d = bind.convert_wk_format(map_cu("VBoxD"):with_noremap():with_silent():with_label("Double Line")),
            h = bind.convert_wk_format(map_cu("VBoxH"):with_noremap():with_silent():with_label("Hard Line")),
            f = bind.convert_wk_format(map_cu("VFill"):with_noremap():with_silent():with_label("Fill Box"))
        },
    }
}

map.Default = {
    n = {
        ["Y"] = bind.convert_wk_format(map_cmd('y$'):with_label("Copy To End Of Line")),
        ["<C-q>"] = bind.convert_wk_format(map_cr('lua require("doodleVim.extend.misc").safe_exit()'):with_noremap():
            with_silent():with_label("Save Session And Safe Exit")),
        ["<C-s>"] = bind.convert_wk_format(map_cr('silent! lua require("doodleVim.extend.misc").safe_save()'):
            with_noremap():with_silent():with_label("Save Session")),
        ["<C-d>"] = bind.convert_wk_format(map_cr("lua ensure_require('neoscroll').scroll(vim.wo.scroll, true, 150)"):
            with_noremap():with_silent():with_label("Smooth Scroll Down")),
        ["<C-u>"] = bind.convert_wk_format(map_cr("lua ensure_require('neoscroll').scroll(-vim.wo.scroll, true, 150)"):
            with_noremap():with_silent():with_label("Smooth Scroll Up")),
        ["x"] = bind.convert_wk_format(map_cmd('"_x'):with_noremap():with_label("Delete Without Copy")),
        ["c"] = bind.convert_wk_format(map_cmd('"_c'):with_noremap():with_label("Change Without Copy")),
        ["d"] = bind.convert_wk_format(map_cmd('""d'):with_noremap():with_label("Delete Without Copy")),
        ["P"] = bind.convert_wk_format(map_cmd('""p'):with_noremap():with_label("Paste Content In Register \"")),

    },
    i = {
        ["<C-b>"] = bind.convert_wk_format(map_cmd('<Left>'):with_noremap()),
        ["<C-f>"] = bind.convert_wk_format(map_cmd('<Right>'):with_noremap()),
        ["<C-d>"] = bind.convert_wk_format(map_cmd('<Del>'):with_noremap()),
        ["<C-h>"] = bind.convert_wk_format(map_cmd('<BS>')),
        ["<C-a>"] = bind.convert_wk_format(map_cmd('<ESC>^i'):with_noremap()),
        ["<C-e>"] = bind.convert_wk_format(map_cmd('<ESC>A'):with_noremap()),
        ["<C-l>"] = bind.convert_wk_format(map_cmd('<Esc>o'):with_noremap()),
        ["<C-o>"] = bind.convert_wk_format(map_cmd('<Esc>O'):with_noremap()),
        ["<C-s>"] = bind.convert_wk_format(map_cmd('<Esc>:lua require("doodleVim.extend.misc").safe_save()<CR>'):
            with_noremap()),
        ["<C-q>"] = bind.convert_wk_format(map_cmd('<Esc>:lua require("doodleVim.extend.misc").safe_exit()<CR>'):
            with_noremap()),
    },
    c = {
        ["<C-b>"] = bind.convert_wk_format(map_cmd('<Left>'):with_noremap()),
        ["<C-f>"] = bind.convert_wk_format(map_cmd('<Right>'):with_noremap()),
        ["<C-a>"] = bind.convert_wk_format(map_cmd('<Home>'):with_noremap()),
        ["<C-e>"] = bind.convert_wk_format(map_cmd('<End>'):with_noremap()),
        ["<C-d>"] = bind.convert_wk_format(map_cmd('<Del>'):with_noremap()),
        ["<C-h>"] = bind.convert_wk_format(map_cmd('<BS>'):with_noremap()),
        ["<C-t>"] = bind.convert_wk_format(map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap():
            with_label("Show Current Directory"))
    },
    v = {
        ["<C-d>"] = bind.convert_wk_format(map_cmd("<cmd>lua ensure_require('neoscroll').scroll(vim.wo.scroll, true, 150)<CR>")
            :with_noremap():with_silent():with_label("Smooth Scroll Down")),
        ["<C-u>"] = bind.convert_wk_format(map_cmd("<cmd>lua ensure_require('neoscroll').scroll(-vim.wo.scroll, true, 150)<CR>")
            :with_noremap():with_silent():with_label("Smooth Scroll Up")),
        [">"] = bind.convert_wk_format(map_cmd(">gv"):with_noremap():with_label("Indent Right")),
        ["<"] = bind.convert_wk_format(map_cmd("<gv"):with_noremap():with_label("Indent Left")),
        ["x"] = bind.convert_wk_format(map_cmd('"_x'):with_noremap():with_label("Delete Without Copy")),
        ["c"] = bind.convert_wk_format(map_cmd('"_c'):with_noremap():with_label("Cut Without Copy")),
        ["d"] = bind.convert_wk_format(map_cmd('""d'):with_noremap():with_label("Delete Without Copy")),
        ["P"] = bind.convert_wk_format(map_cmd('""p'):with_noremap():with_label("Paste Content In Register \"")),
    }
}

return map
