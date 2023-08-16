local config = {}

function config.cellular(plugin, opts)
    local scramble = require("doodleVim.extend.animations.scramble")
    local slide = require("doodleVim.extend.animations.slide")

    require("cellular-automaton").register_animation(slide)
    require("cellular-automaton").register_animation(scramble)
end

function config.killersheep(plugin, opts)
    require("killersheep").setup({
        gore = true,  -- Enables/disables blood and gore.
        keymaps = {
            move_left = "h", -- Keymap to move cannon to the left.
            move_right = "l", -- Keymap to move cannon to the right.
            shoot = "<Space>", -- Keymap to shoot the cannon.
        },
    })
end

function config.blackjack(plugin, opts)
    require("blackjack").setup({
        card_style = "mini",                       -- Can be "mini" or "large".
        suit_style = "black",                      -- Can be "black" or "white".
        scores_path = "/home/foo/blackjack_scores.json", -- Default location to store the scores.json file.
    })
end

function config.sudoku(plugin, opts)
    -- These are the defaults for the settings
    require("sudoku").setup({
        persist_settings = true, -- safe the settings under vim.fn.stdpath("data"), usually ~/.local/share/nvim,
        persist_games = true, -- persist a history of all played games
        default_mappings = true, -- if set to false you need to set your own, like the following:
        mappings = {
            { key = "x",     action = "clear_cell" },
            { key = "r1",    action = "insert=1" },
            { key = "r2",    action = "insert=2" },
            { key = "r3",    action = "insert=3" },
            { key = "r4",    action = "insert=4" },
            { key = "r5",    action = "insert=5" },
            { key = "r6",    action = "insert=6" },
            { key = "r7",    action = "insert=7" },
            { key = "r8",    action = "insert=8" },
            { key = "r9",    action = "insert=9" },
            { key = "gn",    action = "new_game" },
            { key = "gr",    action = "reset_game" },
            { key = "gs",    action = "view=settings" },
            { key = "gt",    action = "view=tip" },
            { key = "gz",    action = "view=zen" },
            { key = "gh",    action = "view=help" },
            { key = "u",     action = "undo" },
            { key = "<C-r>", action = "redo" },
            { key = "+",     action = "increment" },
            { key = "-",     action = "decrement" },
        },
        custom_highlights = {
            board = { fg = "#7d7d7d" },
            number = { fg = "white", bg = "black" },
            active_menu = { fg = "white", bg = "black", gui = "bold" },
            hint_cell = { fg = "white", bg = "yellow" },
            square = { bg = "#292b35", fg = "white" },
            column = { bg = "#14151a", fg = "#d5d5d5" },
            row = { bg = "#14151a", fg = "#d5d5d5" },
            settings_disabled = { fg = "#8e8e8e", gui = "italic" },
            same_number = { fg = "white", gui = "bold" },
            set_number = { fg = "white", gui = "italic" },
            error = { fg = "white", bg = "#843434" },
        },
    })
end

return config
