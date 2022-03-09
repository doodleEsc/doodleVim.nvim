local cmp = {
   Text = "",
   Method = "",
   Function = "",
   Constructor = "",
   Field = "ﰠ",
   Variable = "",
   Class = "ﴯ",
   Interface = "",
   Module = "",
   Property = "ﰠ",
   Unit = "塞",
   Value = "",
   Enum = "",
   Keyword = "",
   Snippet = "",
   Color = "",
   File = "",
   Reference = "",
   Folder = "",
   EnumMember = "",
   Constant = "",
   Struct = "פּ",
   Event = "",
   Operator = "",
   TypeParameter = "𝙏",
   Namespace = "",
   Package = "",
   String = "",
   Number = "",
   Boolean = "﯄",
   Array = "",
   Object = "⦿",
   Null = "ﳠ",
}

local diagnostics = {
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
	debug_sign = "  ",
}

return {
	cmp = cmp,
	diag = diagnostics
}
