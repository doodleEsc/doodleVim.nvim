local editor = {}
local conf = require('modules.editor.config')

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

editor['tyru/caw.vim'] = {
	keys = {"<Leader>c", "<Leader>cc"},
	config = conf.caw
}

editor['easymotion/vim-easymotion'] = {
	keys = {"<Leader>s"},
	config = conf.easymotion
}

editor['junegunn/vim-easy-align'] = {
	keys = {"ma"},
	config = conf.easyalign
}

return editor
