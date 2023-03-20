local bind = require('doodleVim.keymap.bind')
local map_cr = bind.map_cr
local map_cmd = bind.map_cmd

local map = {}

map.Default = {
    n = {
        ["Y"] = map_cmd('y$'):with_label("Copy To End Of Line"),
        ["<C-q>"] = map_cr('lua require("doodleVim.extend.misc").safe_exit()'):with_noremap():
        with_silent():with_label("Save Session And Safe Exit"),
        ["<C-s>"] = map_cr('silent! lua require("doodleVim.extend.misc").safe_save()'):
        with_noremap():with_silent():with_label("Save Session"),
        ["<C-d>"] = map_cr("lua require('neoscroll').scroll(vim.wo.scroll, true, 150)"):
        with_noremap():with_silent():with_label("Smooth Scroll Down"),
        ["<C-u>"] = map_cr("lua require('neoscroll').scroll(-vim.wo.scroll, true, 150)"):
        with_noremap():with_silent():with_label("Smooth Scroll Up"),
        ["<M-n>"] = map_cr("tabnext"):with_noremap():with_silent():with_label("Next Tabpage"),
        ["x"] = map_cmd('"_x'):with_noremap():with_label("Delete Without Copy"),
        ["c"] = map_cmd('"_c'):with_noremap():with_label("Change Without Copy"),
        ["d"] = map_cmd('""d'):with_noremap():with_label("Delete Without Copy"),
        ["P"] = map_cmd('""p'):with_noremap():with_label("Paste Content In Register \""),
    },
    i = {
        ["<C-b>"] = { "<Left>", "Move Cursor To Previous", noremap = true, silent = true },
        ["<C-f>"] = { "<Right>", "Move Cursor To Next", noremap = true, silent = true },
        ["<C-d>"] = { "<Del>", "Delete", noremap = true, silent = true },
        ["<C-h>"] = { "<BS>", "Backspace", noremap = true, silent = true },
        ["<C-a>"] = { "<Esc>^i", "Append Before Head", noremap = true, silent = true },
        ["<C-e>"] = { "<Esc>A", "Append After Tail", noremap = true, silent = true },
        ["<C-l>"] = { "<Esc>o", "New Line", noremap = true, silent = true },
        -- ["<C-o>"] = { "<Esc>O", "New Line Upper", noremap = true, silent = true },
        ["<C-s>"] = { '<Esc>:lua require("doodleVim.extend.misc").safe_save()<CR>', "New Line Upper", noremap = true,
            silent = true },
        ["<C-q>"] = { '<Esc>:lua require("doodleVim.extend.misc").safe_exit()<CR>', "New Line Upper", noremap = true,
            silent = true },
    },
    c = {
        ["<C-b>"] = { "<Left>", "Move Cursor To Previous", noremap = true, silent = true },
        ["<C-f>"] = { "<Right>", "Move Cursor To Next", noremap = true, silent = true },
        ["<C-d>"] = { "<Del>", "Delete", noremap = true, silent = true },
        ["<C-h>"] = { "<BS>", "Backspace", noremap = true, silent = true },
        ["<C-a>"] = { "<Home>", "Home", noremap = true, silent = true },
        ["<C-e>"] = { "<End>", "End", noremap = true, silent = true },
    },
    v = {
        ["<C-d>"] = { "<cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 150)<CR>", "Smooth Scroll Down",
            noremap = true, silent = true },
        ["<C-u>"] = { "<cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 150)<CR>", "Smooth Scroll Up",
            noremap = true, silent = true },
    },
    x = {
        [">"] = { ">gv", "Indent Right", noremap = true },
        ["<"] = { "<gv", "Indent Left", noremap = true },
        ["x"] = { '"_x', "Delete Without Copy", noremap = true },
        ["c"] = { '"_c', "Cut Without Copy", noremap = true },
        ["d"] = { '""d', "Delete Without Copy", noremap = true },
        ["P"] = { '""p', "Paste Content In Register \"", noremap = true },
    }
}


map.Lsp = {
    n = {
        ["g"] = {
            name = "Lsp Function",
            d = map_cr("lua require('doodleVim.extend.lsp').lsp_definitions()"):with_noremap():
            with_silent():with_label("Go To Definition"),
            D = map_cr("lua vim.lsp.buf.declaration()"):with_noremap():with_silent():with_label("Go To Declaration"),
            t = map_cr("lua require('doodleVim.extend.lsp').lsp_type_definition()"):with_noremap()
                :
                with_silent():with_label("Go To Type Definition"),
            i = map_cr("lua require('doodleVim.extend.lsp').lsp_implementations()"):with_noremap()
                :
                with_silent():with_label("Go To Implementation"),
            r = map_cr("lua require('doodleVim.extend.lsp').lsp_references()"):with_noremap():
            with_silent():with_label("Go To Reference"),
            h = map_cr("lua require('doodleVim.extend.lsp').hover()"):with_noremap():with_silent():with_label(
                "Hover Documentation"),
            f = map_cr("lua require('doodleVim.extend.lsp').format({async=true})"):with_noremap():with_silent():
            with_label("Code Formatting"),
            a = map_cr("lua require('doodleVim.extend.lsp').code_action()"):with_noremap():with_silent():with_label(
                "Code Action"),
            n = map_cr("lua require('rename').rename({prompt='Rename'})"):with_noremap():
            with_silent():with_label("Rename"),
        },
        ["<C-n>"] = map_cr("lua vim.diagnostic.goto_next()"):with_noremap():with_silent():
        with_label("Go To Next Diagnostic"),
        ["<C-p>"] = map_cr("lua vim.diagnostic.goto_prev()"):with_noremap():with_silent():
        with_label("Go To Previous Diagnostic"),
    },
    x = {
        ["g"] = {
            name = "Lsp Function",
            f = map_cmd("<Cmd>lua require('doodleVim.extend.lsp').format({async=true})<CR>"):with_noremap():with_silent()
                :with_label("Selected Code Formatting"),
            a = map_cmd("<Cmd>lua require('doodleVim.extend.lsp').code_action()<CR>"):with_noremap():with_silent():
            with_label("Range Code Action"),
            n = map_cmd("<Cmd>lua require('rename').rename({label='Rename'})<CR>"):with_noremap():with_silent()
                :with_label("Rename"),
        },
    },
}

map.NvimTree = {
    n = {
        ["<leader>t"] = {
            name = "Tree",
            t = map_cr("lua require('doodleVim.extend.tree').toggle()"):with_noremap():
            with_silent():with_label("Enhanced NvimTree Toggle"),
            r = map_cr("lua require('doodleVim.extend.tree').find_file()"):with_noremap():
            with_silent():with_label("Find File"),
        },
    },
}

map.SymbolsOutline = {
    n = {
        ["<leader>j"] = {
            name = "Symbols-Outline",
            j = map_cr("lua require'symbols-outline'.toggle_outline()"):with_noremap():with_silent():with_label(
                "Symbols And Function Preview"),
        },
    }
}

map.Diagnostic = {
    n = {
        ["<leader>d"] = {
            name = "Show Diagnostics",
            d = map_cr("Telescope diagnostics bufnr=0"):with_noremap():with_silent():with_label(
                "Show Diagnostics In Current Buffer"),
            e = map_cr("Telescope diagnostics"):with_noremap():with_silent():with_label("Show Diagnostics In WorkSpace"),
            f = map_cr("lua require('doodleVim.extend.diagnostics').toggle_virtual_text()"):
            with_noremap():with_silent():with_label("Toggle Diagnostics Virtual Text"),
        },
    }
}

map.EasyAlign = {
    v = {
        ["<leader>e"] = {
            name = "EasyAlign",
            e = map_cmd("<Cmd>EasyAlign<CR>"):with_label("EasyAlign File"),
        }
    }
}


map.MarkdownPreview = {
    n = {
        ["<leader>m"] = {
            name = "MarkdownPreview",
            m = map_cr('MarkdownPreviewToggle'):with_noremap():with_silent():with_label("Toggle Markdown Preview"),
        }
    }
}

map.Floaterm = {
    n = {
        ["<C-Space>"] = map_cr('FloatermToggle'):with_noremap():with_silent():with_label("Toggle Floaterm"),
        ["<M-j>"] = map_cr('FloatermNew'):with_noremap():with_silent():with_label("Open Floaterm In Project Root Dir"),
        ["<M-k>"] = map_cr('FloatermNew --cwd=<buffer>'):with_noremap():with_silent():with_label("Open Floaterm In Current Buffer Dir"),
    },
    v = {
        ["<M-j>"] = map_cr('FloatermNew'):with_noremap():with_silent():with_label("Open Floaterm In Project Root Dir"),
        ["<M-k>"] = map_cr('FloatermNew --cwd=<buffer>'):with_noremap():with_silent():with_label("Open Floaterm In Current Buffer Dir"),
    },
    t = {
        ["<C-Space>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
            "Toggle Terminal", noremap = true, silent = true },
        ["<C-h>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermPrev<CR>", true, true, true),
            "Go To Next Terminal", noremap = true, silent = true },
        ["<C-l>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNext<CR>", true, true, true),
            "Go To Previous Terminal", noremap = true, silent = true },
        ["<C-k>"] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>:lua require("doodleVim.extend.floaterm").kill()<CR>',
            true, true, true),
            "Kill Current Terminal", noremap = true, silent = true },
        ["<C-j>"] = { vim.api.nvim_replace_termcodes(
            '<C-\\><C-N>:lua require("doodleVim.extend.floaterm").kill(true)<CR>'
            , true, true, true),
            "Kill All Terminal", noremap = true, silent = true },
        ["<M-j>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNew<CR>", true, true, true),
            "Floaterm In Project Root Dir", noremap = true, silent = true },
        ["<M-k>"] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>:lua require("doodleVim.extend.floaterm").new()<CR>'
        , true, true, true),
            "Floaterm In Current Buffer Dir", noremap = true, silent = true },
    }
}

map.Comment = {
    n = {
        ["<leader>c"] = {
            name = "Comment",
            c = map_cr('lua require("Comment.api").toggle.linewise.current()'):with_noremap():
            with_silent():with_label("Comment Current Line"),
            v = map_cr('lua require("Comment.api").toggle.blockwise.current()'):with_noremap():
            with_silent():with_label("Comment Current Line With Block"),
        },
    },
    v = {
        ["<leader>c"] = {
            name = "Comment",
            c = map_cmd('<ESC><CMD>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())<CR>')
                :with_noremap():with_silent():with_label("comment selected line"),
            v = map_cmd('<ESC><CMD>lua require("Comment.api").locked("toggle.blockwise")(vim.fn.visualmode())<CR>')
                :with_noremap():with_silent():with_label("comment selected line"),
        },
    }
}


map.Telescope = {
    n = {
        ["<leader>f"] = {
            name = "Telescope Search",
            f = map_cr('Telescope find_files'):with_noremap():with_silent():with_label("Find Files"),
            g = map_cr('Telescope live_grep'):with_noremap():with_silent():with_label("Live Grep"),
            s = map_cr('Telescope file_browser'):with_noremap():with_silent():with_label("File Browser"),
            p = map_cr('Telescope projects'):with_noremap():with_silent():with_label("Find Projects"),
            t = map_cr('Telescope todo-comments todo'):with_noremap():with_silent():with_label("Find Todos"),
            r = map_cr('Telescope oldfiles'):with_noremap():with_silent():with_label("Find Recent Files"),
            c = map_cr('Telescope command_history'):with_noremap():with_silent():with_label("Find Command History"),
            b = map_cr('Telescope buffers'):with_noremap():with_silent():with_label("Buffers Navigation"),
            m = map_cr('Telescope marks'):with_noremap():with_silent():with_label("Find Marks"),
        },
    }
}

map.Hop = {
    n = {
        ["<leader>s"] = {
            name = "Search Word",
            w = map_cr("lua require'hop'.hint_words()"):with_noremap():with_silent():
            with_label("Search Word"),
            s = map_cr("lua require'hop'.hint_char2()"):with_noremap():with_silent():
            with_label("Search By First 2 Char"),
        },
    }
}

map.ToggleNumber = {
    n = {
        ["<leader>n"] = {
            name = "Toggle Line Number",
            n = map_cr("lua require('doodleVim.extend.misc').toggle_nu()"):with_noremap():
                with_silent()
                :with_label("Toggle Absolute Line Number"),
            m = map_cr("lua require('doodleVim.extend.misc').toggle_rnu()"):with_noremap():
            with_silent():with_label("Toggle Relative Line Number"),
        },
    }
}

map.Neogen = {
    n = {
        ["<leader>g"] = {
            name = "Generate Documentation",
            c = map_cr("lua require('neogen').generate({type='class'})"):with_noremap():
                with_silent()
                :with_label("Generate Class Documentation"),
            t = map_cr("lua require('neogen').generate({type='type'})"):with_noremap():
            with_silent():
            with_label("Generate Type Documentation"),
            f = map_cr("lua require('neogen').generate({type='func'})"):with_noremap():
            with_silent():
            with_label("Generate Function Documentation"),
            d = map_cr("lua require('neogen').generate({type='file'})"):with_noremap():
            with_silent():
            with_label("Generate File Documentation"),
        },
    }
}

map.Dap = {
    n = {
        ["<F5>"] = map_cr('DapContinue'):with_noremap():with_silent():with_label("Debug Continue"),
        ["<S-F5>"] = map_cr('DapTerminate'):with_noremap():with_silent():with_label("Debug Terminate"),
        ["<F6>"] = map_cr('DapRestartFrame'):with_noremap():with_silent():with_label("Debug Restart Frame"),
        ["<F9>"] = map_cr('PBToggleBreakpoint'):with_noremap():with_silent():with_label("Toggle Breakpoint"),
        ["<S-F9>"] = map_cr('PBClearAllBreakpoints'):with_noremap():with_silent():with_label("Clean All Breakpoint"),
        ["<F10>"] = map_cr('DapStepOver'):with_noremap():with_silent():with_label("Run Step Over"),
        ["<F11>"] = map_cr('DapStepInto'):with_noremap():with_silent():with_label("Run Step Into"),
        ["<S-F11>"] = map_cr('DapStepOut'):with_noremap():with_silent():with_label("Run Step Out"),
    }
}

map.Bufferline = {
    n = {
        ["<S-h>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferPrevious')")
            :with_noremap():with_silent():with_label("Previous Buffer"),
        ["<S-l>"] = map_cr((
            "lua require('doodleVim.extend.tab').enhanced_bufferline('BufferNext')")):with_noremap():with_silent():
        with_label("Next Buffer"),
        ["<S-n>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_buffer_close()"):
        with_noremap():with_silent():with_label("Close Current Buffer"),
        ["<M-s>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferOrderByDirectory')")
            :with_noremap():with_silent():with_label("Sort Buffer"),
        ["<M-b>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferCloseBuffersLeft')")
            :with_noremap():with_silent():with_label("Close All Buffers Left"),
        ["<M-m>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferCloseBuffersRight')")
            :with_noremap():with_silent():with_label("Close All Buffers Right"),
        ["<M-h>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferMovePrevious')")
            :with_noremap():with_silent():with_label("Re-order To Previous"),
        ["<M-l>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferMoveNext')")
            :with_noremap():with_silent():with_label("Re-order To Next"),
        ["<M-i>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferPin')")
            :with_noremap():with_silent():with_label("Pin Buffer"),
        ["<M-o>"] = map_cr("lua require('doodleVim.extend.tab').enhanced_bufferline('BufferPick')")
            :with_noremap():with_silent():with_label("Pick Buffer"),
    }
}

map.WhichKey = {
    n = {
        ["<C-_>"] = map_cr("lua require('doodleVim.extend.misc').toggle_whichkey()"):
            with_noremap()
            :with_silent():with_label("Show Keymaps"),
    },
    v = {
        ["<C-_>"] = map_cmd("<Cmd>lua require('doodleVim.extend.misc').toggle_whichkey()<CR>")
            :with_noremap():with_label("Show Keymaps"),
    },
    i = {
        ["<C-_>"] = map_cmd("<Cmd>lua require('doodleVim.extend.misc').toggle_whichkey()<CR>")
            :with_noremap():with_label("Show Keymaps"),
    }
}

map.Hydra = {
    n = {
        ["<leader>h"] = {
            name = "Hydra Tools",
            g = map_cr('lua require("doodleVim.extend.hydra").run("gitsigns")'):with_noremap()
                :with_silent():with_label("Start Gitsigns"),
            v = map_cr('lua require("doodleVim.extend.hydra").run("venn")'):with_noremap():
            with_silent():with_label("Start Draw Ascii Diagram"),
            t = map_cr('lua require("doodleVim.extend.hydra").run("telescope")'):with_noremap():
            with_silent():with_label("Start Telescope"),
        }
    }
}

map.codewindow = {
    n = {
        ["<leader>w"] = {
            name = "Code Window",
            w = map_cr('lua require("codewindow").toggle_minimap()'):with_noremap()
                :with_silent():with_label("Toggle Code Window"),
            e = map_cr('lua require("codewindow").toggle_focus()'):with_noremap()
                :with_silent():with_label("Toggle Code Focus"),
        }
    }
}

map.nvim_ufo = {
    n = {
        ["z"] = {
            name = "Folding",
            R = map_cr("lua require('ufo').openAllFolds()"):with_noremap():with_silent():with_label("Open All Folds"),
            M = map_cr("lua require('ufo').closeAllFolds()"):with_noremap():with_silent():with_label("Close All Folds"),
            r = map_cr("lua require('ufo').openFoldsExceptKinds()"):with_noremap():with_silent():with_label(
                "Open Folds Except Kinds"),
            m = map_cr("lua require('ufo').closeFoldsWith()"):with_noremap():with_silent():with_label("Open All Folds"),
        }
    }
}

return map
