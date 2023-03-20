local doodleHydra = require("doodleVim.extend.hydra")

local venn_hydra_factory = function()
    local hint = [[
 ╭━━━━━━━┳━━╮    Arrow^^^^^^   Select region with <C-v>
 ┃    ╭╯ ┃ ▋┃╭━┓ ^ ^ ^ ^ ^ ^   _f_: single line box
╭┫    ┃  ┃  ┃┃╭┛ ^ ^ _K_ ^ ^   _d_: double line box
┃┃    ╰━━╯ ┃╰╯┃  _H_ ^ ^ _L_   _h_: Hard line box
╯┃         ╰┳━╯  ^ ^ _J_ ^ ^   _o_: crossed single line
 ┃ ┏━┳━━┓ ┏ ┃    ^ ^ ^ ^ ^ ^   _F_: Fill the box
 ┗━┻━┛  ┗━┻━┛    ^ ^ ^ ^ ^ ^   _<Esc>_: exit
]]
    local Hydra = require('hydra')
    local venn_hydra = Hydra({
        name = 'Draw Diagram',
        hint = hint,
        config = {
            color = 'pink',
            invoke_on_body = false,
            hint = {
                border = 'rounded',
            },
            on_enter = function()
                vim.o.virtualedit = 'all'
            end,
        },
        mode = 'n',
        heads = {
            { 'H',     '<C-v>h:VBox<CR>', { silent = true } },
            { 'J',     '<C-v>j:VBox<CR>', { silent = true } },
            { 'K',     '<C-v>k:VBox<CR>', { silent = true } },
            { 'L',     '<C-v>l:VBox<CR>', { silent = true } },
            { 'f',     ':VBox<CR>',       { mode = 'v', silent = true } },
            { 'd',     ':VBoxD<CR>',      { mode = 'v', silent = true } },
            { 'h',     ':VBoxH<CR>',      { mode = 'v', silent = true } },
            { 'o',     ':VBoxO<CR>',      { mode = 'v', silent = true } },
            { 'F',     ':VFill<CR>',      { mode = 'v', silent = true } },
            { '<Esc>', nil,               { exit = true } },
        }
    })
    return venn_hydra
end



local dap_hydra_factory = function()
    local hint = [[
╭╭━━━╮╮            _<F5>_   : Continue
 ┃╭━━╯    ▕╲▂▂╱▏   _<S-F5>_ : Terminate
 ┃┃╱▔▔▔▔▔▔▔▏ ▋▋╮   _<F6>_   : Restart
 ┃╰▏       ▏  ▆┃   _<F9>_   : Toggle BreakPoint
 ╰━▏      ╱  ╰┻┫   _<F10>_  : Step Over
   ▏┏┳━━━━▏┏┳━━╯   _<F11>_  : Step Into
   ▏┃┃    ▏┃┃      _<S-F11>_: Step Out
^
                   _<Esc>_  : Terminate
]]
    local Hydra = require('hydra')
    local cmd = require('hydra.keymap-util').cmd
    local dap_hydra = Hydra({
        name = 'Dap',
        hint = hint,
        config = {
            invoke_on_body = false,
            color = 'pink',
            hint = {
                position = 'top-right',
                border = 'rounded',
            },
        },
        mode = 'n',
        heads = {
            { '<F5>',    cmd 'DapContinue',         { silent = true } },
            { '<S-F5>',  cmd 'DapTerminate',        { silent = true, exit = true, } },
            { '<F6>',    cmd 'DapRestartFrame',     { silent = true } },
            { '<F9>',    cmd 'DapToggleBreakpoint', { silent = true } },
            { '<F10>',   cmd 'DapStepOver',         { silent = true } },
            { '<F11>',   cmd 'DapStepInto',         { silent = true } },
            { '<S-F11>', cmd 'DapStepOut',          { silent = true } },
            { '<Esc>',   cmd 'DapTerminate',        { exit = true, nowait = false, desc = 'exit' } },
        }
    })
    return dap_hydra
end


local gitsign_hydra_factory = function()
    local hint = [[
 ╱▔▔▔▔▔▔▔╲┏━╮╭━┓ _p_: preview hunk  _d_: show deleted
▕ ╭╮     ▕╰━╮╭━╯ _J_: next hunk     _b_: blame line
▕━━━╯     ╲━╯┃   _K_: prev hunk     _B_: blame show full
 ╲▂▂▂▂▂▂▂▂▂▂▂╯   _s_: stage hunk    _u_: undo last stage
                 _S_: stage buffer  _/_: show base file
╭┳╭┳╭┳╭┳╭┳╭┳╭┳╭┳
╯╰╯╰╯╰╯╰╯╰╯╰╯╰╯╰ _<Enter>_: Lazygit        _<Esc>_: exit
]]

    local Hydra = require("hydra")
    local gitsigns = require("gitsigns")
    local gitsigns_hydra = Hydra({
        name = 'Git',
        hint = hint,
        config = {
            buffer = true,
            color = 'pink',
            hint = {
                border = 'rounded'
            },
            on_enter = function()
                vim.cmd 'mkview'
                vim.cmd 'silent! %foldopen!'
                vim.bo.modifiable = false
                gitsigns.toggle_signs(true)
                gitsigns.toggle_linehl(true)
            end,
            on_exit = function()
                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                vim.cmd 'loadview'
                vim.api.nvim_win_set_cursor(0, cursor_pos)
                vim.cmd 'normal zv'
                gitsigns.toggle_signs(false)
                gitsigns.toggle_linehl(false)
                gitsigns.toggle_deleted(false)
            end,
        },
        mode = { 'n', 'x' },
        heads = {
            { 'J',
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gitsigns.next_hunk() end)
                    return '<Ignore>'
                end,
                { expr = true, desc = 'next hunk' } },
            { 'K',
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gitsigns.prev_hunk() end)
                    return '<Ignore>'
                end,
                { expr = true, desc = 'prev hunk' } },
            { 's',       ':Gitsigns stage_hunk<CR>',                         { silent = true, desc = 'stage hunk' } },
            { 'u',       gitsigns.undo_stage_hunk,                           { desc = 'undo last stage' } },
            { 'S',       gitsigns.stage_buffer,                              { desc = 'stage buffer' } },
            { 'p',       gitsigns.preview_hunk,                              { desc = 'preview hunk' } },
            { 'd',       gitsigns.toggle_deleted,                            { nowait = true, desc = 'toggle deleted' } },
            { 'b',       gitsigns.blame_line,                                { desc = 'blame' } },
            { 'B',       function() gitsigns.blame_line { full = true } end, { desc = 'blame show full' } },
            { '/',       gitsigns.show,                                      { exit = true, desc = 'show base file' } },
            { '<Enter>', '<Cmd>Lazygit<CR>',                                 { exit = true, desc = 'Lazygit' } },
            { '<Esc>',       nil,                                                { exit = true, nowait = true, desc = 'exit' } },
        }
    })
    return gitsigns_hydra
end

local telescope_hydra_factory = function()
    local hint = [[
  ┏━╮╭━┓         _f_: files         _m_: marks
  ┃┏┗┛┓┃         _r_: recent files  _g_: live grep
  ╰┓▋▋┏╯         _p_: projects      _/_: search in file
 ╭━┻╮ ┗━━━━━╮╭╮
 ┃▎▎┃       ┣━╯  _t_: todos         _b_: buffers
 ╰━┳┻▅╯     ┃    _h_: vim help      _c_: execute command
   ╰━┳┓┏━┳┓┏╯    _k_: keymaps       _;_: commands history
     ┗┻┛ ┗┻┛     _O_: options       _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]
    local Hydra = require("hydra")
    local cmd = require('hydra.keymap-util').cmd
    local telescope_hydra = Hydra({
        name = 'Telescope',
        hint = hint,
        config = {
            color = 'teal',
            hint = {
                position = 'middle',
                border = 'rounded',
            },
        },
        mode = 'n',
        heads = {
            { 'f',       cmd 'Telescope find_files' },
            { 'g',       cmd 'Telescope live_grep' },
            { 'r',       cmd 'Telescope oldfiles',                  { desc = 'recently opened files' } },
            { 'h',       cmd 'Telescope help_tags',                 { desc = 'vim help' } },
            { 'm',       cmd 'Telescope marks',                     { desc = 'marks' } },
            { 'k',       cmd 'Telescope keymaps' },
            { 'O',       cmd 'Telescope vim_options' },
            { 't',       cmd 'Telescope todo-comments' },
            { 'p',       cmd 'Telescope projects',                  { desc = 'projects' } },
            { '/',       cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
            { '?',       cmd 'Telescope search_history',            { desc = 'search history' } },
            { ';',       cmd 'Telescope command_history',           { desc = 'command-line history' } },
            { 'c',       cmd 'Telescope commands',                  { desc = 'execute command' } },
            { 'b',       cmd 'Telescope buffers',                   { desc = 'buffers' } },
            { '<Enter>', cmd 'Telescope',                           { exit = true, desc = 'list all pickers' } },
            { '<Esc>',   nil,                                       { exit = true, nowait = true } },
        }
    })

    return telescope_hydra
end

local neorg_hydra_factory = function()
    local hint = [[
       _D_ : done       _U_: undone      _P_: pending    _C_: cancel
   _<C-Space>_: cycle   _R_: recurring   _I_: important  _H_: on hold
^
  _<Enter>_: Neorg    _<Esc>_: exit hydra mode           _q_: quit
]]
    local Hydra = require("hydra")
    local cmd = require('hydra.keymap-util').cmd
    local neorg_hydra = Hydra({
        name = 'Neorg',
        hint = hint,
        config = {
            buffer = true,
            color = 'pink',
            hint = {
                border = 'rounded',
            },
            on_enter = function()
                vim.cmd 'Neorg mode norg'
            end,
            -- on_exit = function()
            --     vim.cmd 'Neorg return'
            -- end,
        },
        mode = 'n',
        heads = {
            { 'D',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_done' },
            { 'U',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_undone' },
            { 'P',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_pending' },
            { 'C',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_cancelled' },
            { 'R',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_recurring' },
            { 'I',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_important' },
            { 'H',         cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_on_hold' },
            { '<C-Space>', cmd 'Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle' },
            { '<Enter>', cmd 'Neorg', {
                exit = true,
                desc = 'list all modules'
            } },
            { '<Esc>', cmd 'write', {
                exit = true,
                nowait = true,
                desc = 'exit without return'
            } },
            { 'q', cmd 'write|Neorg return', {
                exit = true,
                nowait = true,
                desc = 'exit'
            } },
        }
    })

    return neorg_hydra
end


local hydra_factories = {
    -- neorg = neorg_hydra_factory,
    venn = venn_hydra_factory,
    -- dap = dap_hydra_factory,
    gitsigns = gitsign_hydra_factory,
    telescope = telescope_hydra_factory,
}

for name, factory in pairs(hydra_factories) do
    doodleHydra.add(name, factory)
end
