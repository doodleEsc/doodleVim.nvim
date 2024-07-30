local vim = vim

local map = {}

map.Default = {
	n = {
		{ "Y", "y$", desc = "Copy to End" },
		{
			"<C-q>",
			function()
				require("doodleVim.extend.misc").safe_exit()
			end,
			desc = "Safe Exit",
		},
		{
			"<C-s>",
			function()
				require("doodleVim.extend.misc").safe_save()
			end,
			desc = "Safe Save",
		},
		{ "x", '"_x', desc = "Delete Without Copy" },
		{ "c", '"_c', desc = "Change Without Copy" },
		{ "d", '""d', desc = 'Delete To Register "' },
		{ "p", '""p', desc = 'Paste From Register "' },
		{
			"<C-d>",
			function()
				require("neoscroll").scroll(vim.wo.scroll, true, 150)
			end,
			desc = "Smoothing Scroll Down",
		},
		{
			"<C-u>",
			function()
				require("neoscroll").scroll(-vim.wo.scroll, true, 150)
			end,
			desc = "Smoothing Scroll Up",
		},
	},

	i = {
		{ "<C-b>", "<Left>", desc = "Move Cursor To Previous" },
		{ "<C-f>", "<Right>", desc = "Move Cursor To Next" },
		{ "<C-h>", "<BS>", desc = "Delete Previous Character" },
		{ "<C-a>", "<Esc>^i", desc = "Insert Before First Character" },
		{ "<C-e>", "<Esc>A", desc = "Insert After Last Character" },

	},

	v = {
		{
			"<C-d>",
			function()
				require("neoscroll").scroll(vim.wo.scroll, true, 150)
			end,
			desc = "Smooth Scroll Down",
		},
		{
			"<C-u>",
			function()
				require("neoscroll").scroll(-vim.wo.scroll, true, 150)
			end,
			desc = "Smooth Scroll Up",
		},
	},

	x = {
		{ ">", ">gv", desc = "Indent Right" },
		{ "<", "<gv", desc = "Indent Left" },
		{ "x", '"_x', desc = "Delete Without Copy" },
		{ "c", '"_c', desc = "Cut Without Copy" },
		{ "d", '""d', desc = "Delete Without Copy" },
		{ "P", '""p', desc = 'Paste Content In Register "' },
	},
}

map.Lsp = {
	n = {
		{
			"gd",
			function()
				require("doodleVim.extend.lsp").lsp_definitions()
			end,
			desc = "Go To Definition",
		},
		{
			"gD",
			function()
				vim.lsp.buf.declaration()
			end,
			desc = "Go To Declaration",
		},
		{
			"gt",
			function()
				require("doodleVim.extend.lsp").lsp_type_definition()
			end,
			desc = "Go To Type Definition",
		},
		{
			"gi",
			function()
				require("doodleVim.extend.lsp").lsp_implementations()
			end,
			desc = "Go To Implementation",
		},
		{
			"gr",
			function()
				require("doodleVim.extend.lsp").lsp_references()
			end,
			desc = "Go To Reference",
		},
		{
			"gh",
			function()
				require("doodleVim.extend.lsp").hover()
			end,
			desc = "Hover Documentation",
		},
		{
			"gf",
			function()
				require("doodleVim.extend.lsp").format({ async = true })
			end,
			desc = "Code Formatting",
		},
		{
			"gn",
			function()
				require("rename").rename({ prompt = "Rename" })
			end,
			desc = "Rename",
		},
		{
			"ga",
			function()
				require("doodleVim.extend.lsp").code_action()
			end,
			desc = "Code Action",
		},
		{
			"<M-j>",
			function()
				vim.diagnostic.goto_next()
			end,
			desc = "Go To Next Diagnostic",
		},
		{
			"<M-k>",
			function()
				vim.diagnostic.goto_prev()
			end,
			desc = "Go To Previous Diagnostic",
		},
	},

	v = {
		{
			"gf",
			":<C-u>lua vim.lsp.buf.format()<CR>",
			desc = "Selected Code Formatting",
			noremap = true,
			silent = true,
		},
		{
			"gn",
			function()
				require("rename").rename({ label = "Rename" })
			end,
			desc = "Rename Selected",
		},
	},
}

map.NvimTree = {
	n = {
		{
			"tt",
			function()
				require("doodleVim.extend.tree").toggle()
			end,
			desc = "Enhanced NvimTree Toggle",
		},
		{
			"tr",
			function()
				require("doodleVim.extend.tree").find_file()
			end,
			desc = "Find File",
		},
	},
}

map.Outline = {
	n = {
		{
			"<leader>jj",
			function()
				require("outline").toggle_outline()
			end,
			desc = "Preview Symbols And Functions",
		},
	},
}

map.NeoAI = {
	n = {
		{ "<leader>ai", "<Cmd>NeoAI<CR>", desc = "NeoAI Toggle" },
	},
	v = {

		{ "<leader>ai", ":<C-u>'<,'>NeoAIContext<CR>", desc = "NeoAI Context" },
	},
}

map.Diagnostic = {
	n = {
		{
			"<leader>ee",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope diagnostics bufnr=0")
			end,
			desc = "Show Diagnostics In Current Buffer",
		},
		{
			"<leader>ew",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope diagnostics")
			end,
			desc = "Show Diagnostics In WorkSpace",
		},
		{
			"<leader>ef",
			function()
				require("doodleVim.extend.diagnostics").toggle_virtual_text()
			end,
			desc = "Toggle Diagnostics Virtual Text",
		},
	},
}

map.EasyAlign = {
	n = {
		{ "<leader>ea", "<Cmd>EasyAlign<CR>", desc = "EasyAlign Range" },
	},
	v = {
		{ "<leader>ea", ":<C-u>'<,'>EasyAlign<CR>", desc = "EasyAlign Range" },
	},
}

map.MarkDownPreview = {
	n = {
		{ "<leader>mm", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
	},
}

map.Floaterm = {
	n = {
		{ "<C-Space>", "<Cmd>FloatermToggle<CR>", desc = "Toggle Floaterm" },
		{ "<M-n>", "<Cmd>FloatermNew<CR>", desc = "Open Floaterm In Project Root Dir" },
		{ "<M-m>", "<Cmd>FloatermNew --cwd=<buffer><CR>", desc = "Open Floaterm In Current Buffer Dir" },
	},
	v = {
		{ "<M-n>", ":<C-u>'<,'>FloatermNew<CR>", desc = "Open Floaterm In Project Root Dir" },
		{ "<M-m>", ":<C-u>'<,'>FloatermNew --cwd=<buffer><CR>", desc = "Open Floaterm In Current Buffer Dir" },
	},

	t = {
		{
			"<C-Space>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<C-\\><C-n>:FloatermToggle<CR>", true, false, true),
						"n",
						false
					)
				end
			end,
			desc = "Toggle Terminal",
			silent = true,
			noremap = true,
		},

		{
			"<C-h>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<C-\\><C-n>:FloatermPrev<CR>", true, false, true),
						"n",
						false
					)
				end
			end,
			desc = "Go To Next Terminal",
		},
		{
			"<C-l>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<C-\\><C-n>:FloatermNext<CR>", true, false, true),
						"n",
						false
					)
				end
			end,
			desc = "Go To Previous Terminal",
		},
		{
			"<M-x>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<C-\\><C-n>:FloatermKill", true, false, true),
						"n",
						false
					)
					-- vim.cmd("FloatermKill")
				end
			end,
			desc = "Kill Current Terminal",
		},
		{
			"<M-q>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<C-\\><C-n>:FloatermKill!", true, false, true),
						"n",
						false
					)
				end
			end,
			desc = "Kill All Terminal",
		},
		{
			"<M-n>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes("<C-\\><C-n>:FloatermNew<CR>", true, false, true),
						"n",
						false
					)
				end
			end,
			desc = "Floaterm In Project Root Dir",
			silent = true,
		},
		{
			"<M-m>",
			function()
				local buftype = vim.bo.buftype
				if buftype == "terminal" then
					-- 停止插入模式
					vim.cmd("stopinsert")
					-- 切换到普通模式
					vim.api.nvim_feedkeys(
						vim.api.nvim_replace_termcodes(
							'<C-\\><C-n>:lua require("doodleVim.extend.floaterm").new()<CR>',
							true,
							false,
							true
						),
						"n",
						false
					)
				end
			end,
			desc = "Floaterm In Current Buffer Dir",
			silent = true,
		},
	},
}

map.Comment = {
	n = {
		{
			"<leader>cc",
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			desc = "Comment Current Line",
		},
		{
			"<leader>cv",
			function()
				require("Comment.api").toggle.blockwise.current()
			end,
			desc = "Comment Current Line With Block",
		},
	},

	v = {
		{
			"<leader>cc",
			':<C-u>\'<,\'>lua require("Comment.api").locked("toggle.linewise")(vim.fn.visualmode())<CR>',
			desc = "Comment Selected Line",
		},
		{
			"<leader>cv",
			':<C-u>\'<,\'>lua require("Comment.api").locked("toggle.blockwise")(vim.fn.visualmode())<CR>',
			desc = "Comment Selected Line",
		},
	},
}

map.Telescope = {
	n = {
		{
			"<leader>ff",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope find_files")
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope live_grep")
			end,
			desc = "Live Grep",
		},
		{
			"<leader>fs",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope file_browser")
			end,
			desc = "File Browser",
		},
		{
			"<leader>fp",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope projects")
			end,
			desc = "Find Projects",
		},
		-- {
		--   "t",
		--   function()
		--     require("doodleVim.extend.telescope").enhanced("Telescope todo-comments todo")
		--   end,
		--   desc = "Find Todos"
		-- },
		{
			"<leader>fr",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope oldfiles")
			end,
			desc = "Find Recent Files",
		},
		{
			"<leader>fc",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope command_history")
			end,
			desc = "Find Command History",
		},
		{
			"<leader>fb",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope buffers")
			end,
			desc = "Buffers Navigation",
		},
		{
			"<leader>fm",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope marks")
			end,
			desc = "Find Marks",
		},
		{
			"<leader>fd",
			function()
				require("doodleVim.extend.tree").find_directory_and_focus()
			end,
			desc = "Find Directory And Focus",
		},
		{
			"<C-t>",
			function()
				require("doodleVim.extend.telescope").enhanced("Telescope resume")
			end,
			desc = "Resume Telescope",
		},
	},
}

map.Hop = {
	n = {
		{
			"<leader>hw",
			function()
				require("hop").hint_words()
			end,
			desc = "Search Word",
		},
		{
			"<leader>hs",
			function()
				require("hop").hint_char2()
			end,
			desc = "Search By First 2 Char",
		},
	},
}

map.ToggleNumber = {
	n = {
		{
			"<leader>nn",
			function()
				require("doodleVim.extend.misc").toggle_nu()
			end,
			desc = "Toggle Absolute Line Number",
		},
		{
			"<leader>nm",
			function()
				require("doodleVim.extend.misc").toggle_rnu()
			end,
			desc = "Toggle Relative Line Number",
		},
	},
}

map.Barbecue = {
	n = {
		{
			"<leader>bb",
			function()
				require("doodleVim.extend.misc").toggle_barbecue()
			end,
			desc = "Toggle Barbecue",
		},
	},
}

map.Neogen = {
	n = {
		{
			"<leader>dc",
			function()
				require("neogen").generate({ type = "class" })
			end,
			desc = "Generate Class Documentation",
		},
		{
			"<leader>dt",
			function()
				require("neogen").generate({ type = "type" })
			end,
			desc = "Generate Type Documentation",
		},
		{
			"<leader>dm",
			function()
				require("neogen").generate({ type = "func" })
			end,
			desc = "Generate Function Documentation",
		},
		{
			"<leader>df",
			function()
				require("neogen").generate({ type = "file" })
			end,
			desc = "Generate File Documentation",
		},
	},
}

map.Dap = {
	n = {
		{
			"<F7>",
			function()
				require("doodleVim.extend.debug").debug_test()
			end,
			desc = "Debug Test",
		},
		{
			"<F5>",
			function()
				require("doodleVim.extend.debug").wrapped_command("DapContinue")
			end,
			desc = "Debug Continue",
		},
		{
			"<S-F5>",
			function()
				require("doodleVim.extend.debug").wrapped_command("DapTerminate")
			end,
			desc = "Debug Terminate",
		},
		{
			"<F6>",
			function()
				require("doodleVim.extend.debug").wrapped_command("DapRestartFrame")
			end,
			desc = "Debug Restart Frame",
		},
		{
			"<F9>",
			function()
				require("doodleVim.extend.debug").wrapped_command("PBToggleBreakpoint")
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<S-F9>",
			function()
				require("doodleVim.extend.debug").wrapped_command("PBClearAllBreakpoints")
			end,
			desc = "Clean All Breakpoint",
		},
		{
			"<F10>",
			function()
				require("doodleVim.extend.debug").wrapped_command("DapStepOver")
			end,
			desc = "Run Step Over",
		},
		{
			"<F11>",
			function()
				require("doodleVim.extend.debug").wrapped_command("DapStepInto")
			end,
			desc = "Run Step Into",
		},
		{
			"<S-F11>",
			function()
				require("doodleVim.extend.debug").wrapped_command("DapStepOut")
			end,
			desc = "Run Step Out",
		},
	},

	v = {
		{
			"<F7>",
			function()
				require("doodleVim.extend.debug").debug_test()
			end,
			desc = "Debug Test",
		},
	},
}

map.BufferLine = {
	n = {
		{
			"<S-h>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferPrevious")
			end,
			desc = "Previous Buffer",
		},
		{
			"<S-l>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferNext")
			end,
			desc = "Next Buffer",
		},
		{
			"<S-n>",
			function()
				require("doodleVim.extend.tab").enhanced_buffer_close()
			end,
			desc = "Close Current Buffer",
		},
		{
			"<M-s>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferOrderByDirectory")
			end,
			desc = "Sort Buffer",
		},
		{
			"<M-,>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferCloseBuffersLeft")
			end,
			desc = "Close All Buffers Left",
		},
		{
			"<M-.>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferCloseBuffersRight")
			end,
			desc = "Close All Buffers Right",
		},
		{
			"<M-h>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferMovePrevious")
			end,
			desc = "Re-order To Previous",
		},
		{
			"<M-l>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferMoveNext")
			end,
			desc = "Re-order To Next",
		},
		{
			"<M-i>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferPin")
			end,
			desc = "Pin Buffer",
		},
		{
			"<M-o>",
			function()
				require("doodleVim.extend.tab").enhanced_bufferline("BufferPick")
			end,
			desc = "Pick Buffer",
		},
	},
}

map.Hydra = {
	n = {
		{
			"<leader>hg",
			function()
				require("doodleVim.extend.hydra").run("gitsigns")
			end,
			desc = "Start Gitsigns",
		},
		{
			"<leader>hv",
			function()
				require("doodleVim.extend.hydra").run("venn")
			end,
			desc = "Start Draw Ascii Diagram",
		},
		{
			"<leader>ht",
			function()
				require("doodleVim.extend.hydra").run("telescope")
			end,
			desc = "Start Telescope",
		},
	},
}

map.CodeWindow = {
	n = {
		{
			"<leader>ww",
			function()
				require("codewindow").toggle_minimap()
			end,
			desc = "Toggle Code Window",
		},
		{
			"<leader>we",
			function()
				require("codewindow").toggle_focus()
			end,
			desc = "Toggle Code Focus",
		},
	},
}

map.NvimUfo = {
	n = {
		{
			"zR",
			function()
				require("ufo").openAllFolds()
			end,
			desc = "Open All Folds",
		},
		{
			"zM",
			function()
				require("ufo").closeAllFolds()
			end,
			desc = "Close All Folds",
		},
		{
			"zr",
			function()
				require("ufo").openFoldsExceptKinds()
			end,
			desc = "Open Folds Except Kinds",
		},
		{
			"zm",
			function()
				require("ufo").closeFoldsWith()
			end,
			desc = "Close Folds With",
		},
	},
}

return map
