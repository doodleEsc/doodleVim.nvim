local doodleHydra = require("doodleVim.extend.hydra")

-- ensure all dependency loaded
require("doodleVim.utils.defer").immediate_load({
    "hydra.nvim",
    "venn.nvim",
    "gitsigns.nvim",
    "vim-floaterm",
    "telescope.nvim",
    "nvim-dap"
})

local venn_hydra_factory = function()
    local hint = [[
Arrow^^^^^^   Select region with <C-v>
^ ^ ^ ^ ^ ^   _f_: single line box
^ ^ _K_ ^ ^   _d_: double line box
_H_ ^ ^ _L_   _h_: Hard line box
^ ^ _J_ ^ ^   _o_: crossed single line
^ ^ ^ ^ ^ ^   _F_: Fill the box
^ ^ ^ ^ ^ ^                     _<Esc>_
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
                position = 'top-right'
            },
            on_enter = function()
                vim.o.virtualedit = 'all'
            end,
        },
        mode = 'n',
        heads = {
            { 'H', '<C-v>h:VBox<CR>', { silent = true } },
            { 'J', '<C-v>j:VBox<CR>', { silent = true } },
            { 'K', '<C-v>k:VBox<CR>', { silent = true } },
            { 'L', '<C-v>l:VBox<CR>', { silent = true } },
            { 'f', ':VBox<CR>', { mode = 'v', silent = true } },
            { 'd', ':VBoxD<CR>', { mode = 'v', silent = true } },
            { 'h', ':VBoxH<CR>', { mode = 'v', silent = true } },
            { 'o', ':VBoxO<CR>', { mode = 'v', silent = true } },
            { 'F', ':VFill<CR>', { mode = 'v', silent = true } },
            { '<Esc>', nil, { exit = true } },
        }
    })
    return venn_hydra
end



local dap_hydra_factory = function()
    local hint = [[
_<F5>_ : Continue             _<S-F5>_ : Terminate
_<F6>_ : Restart
_<F9>_ : Toggle BreakPoint
_<F10>_: Step Over
_<F11>_: Step Into            _<S-F11>_: Step Out
^
_<Esc>_: Terminate
]]
    local Hydra = require('hydra')
    local dap = require("dap")
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
        body = "",
        mode = 'n',
        heads = {
            { '<F5>', dap.continue, },
            { '<S-F5>', dap.terminate, { exit = true, } },
            { '<F6>', dap.restart_frame, },
            { '<F9>', dap.toggle_breakpoint, },
            { '<F10>', dap.step_over, },
            { '<F11>', dap.step_into, },
            { '<S-F11>', dap.step_out, },
            { '<Esc>', nil, { exit = true, } },
        }
    })
    return dap_hydra
end


local gitsign_hydra_factory = function()
    local hint = [[
 _J_: next hunk     _s_: stage hunk        _d_: show deleted
 _K_: prev hunk     _u_: undo last stage   _b_: blame line
 _p_: preview hunk  _S_: stage buffer      _B_: blame show full
 ^
 ^ ^             _<Enter>_: Lazygit        _q_: exit
]]

    local Hydra = require("hydra")
    local gitsigns = require("gitsigns")
    local gitsigns_hydra = Hydra({
        name = 'Git',
        hint = hint,
        config = {
            buffer = bufnr,
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
            { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
            { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
            { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
            { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
            { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
            { 'b', gitsigns.blame_line, { desc = 'blame' } },
            { 'B', function() gitsigns.blame_line { full = true } end, { desc = 'blame show full' } },
            { '<Enter>', '<Cmd>Lazygit<CR>', { exit = true, desc = 'Lazygit' } },
            { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
        }
    })
    return gitsigns_hydra
end

local telescope_hydra_factory = function()
    local hint = [[
   _f_: files
   _o_: old files   _g_: live grep
   _p_: projects    _/_: search in file
 
   _h_: vim help    _c_: execute command
   _k_: keymaps     _;_: commands history 
   _O_: options     _?_: search history
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
            { 'f', cmd 'Telescope find_files' },
            { 'g', cmd 'Telescope live_grep' },
            { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
            { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
            { 'k', cmd 'Telescope keymaps' },
            { 'O', cmd 'Telescope vim_options' },
            { 'p', cmd 'Telescope projects', { desc = 'projects' } },
            { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
            { '?', cmd 'Telescope search_history', { desc = 'search history' } },
            { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
            { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
            { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
            { '<Esc>', nil, { exit = true, nowait = true } },
        }
    })

    return telescope_hydra
end


local hydra_factories = {
    venn = venn_hydra_factory,
    dap = dap_hydra_factory,
    gitsigns = gitsign_hydra_factory,
    telescope = telescope_hydra_factory,
}

for name, factory in pairs(hydra_factories) do
    doodleHydra.add(name, factory)
end
