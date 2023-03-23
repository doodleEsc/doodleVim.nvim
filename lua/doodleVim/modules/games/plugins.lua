local games = {}
local conf = require("doodleVim.modules.games.config")

games['eandrju/cellular-automaton.nvim'] = {
    lazy = true,
    cmd = "CellularAutomaton",
    config = conf.cellular
}

games['alec-gibson/nvim-tetris'] = {
    lazy = true,
    cmd = "Tetris"
}

games['seandewar/killersheep.nvim'] = {
    lazy = true,
    cmd = "KillKillKill",
    config = conf.killersheep
}

games['seandewar/nvimesweeper'] = {
    lazy = true,
    cmd = "Nvimesweeper"
}

games['alanfortlink/blackjack.nvim'] = {
    lazy = true,
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    cmd = { "BlackJackNewGame", "BlackJackQuit", "BlackJackResetScores" },
    config = conf.blackjack
}

games['jim-fx/sudoku.nvim'] = {
    lazy = true,
    cmd = "Sudoku",
    config = conf.sudoku
}


return games
