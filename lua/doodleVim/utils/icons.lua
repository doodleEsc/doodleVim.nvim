local cmp = {
   Text          = "",
   Method        = "",
   Function      = "",
   Constructor   = "",
   Field         = "",
   Variable      = "",
   Class         = "",
   Interface     = "",
   Module        = "",
   Property      = "",
   Unit          = "",
   Value         = "",
   Enum          = "",
   Keyword       = "",
   Snippet       = "",
   Color         = "",
   File          = "",
   Reference     = "",
   Folder        = "",
   EnumMember    = "",
   Constant      = "",
   Struct        = "",
   Event         = "",
   Operator      = "",
   TypeParameter = "𝙏",
   Namespace     = "",
   Package       = "",
   String        = "",
   Number        = "",
   Boolean       = "",
   Array         = "",
   Object        = "",
   Null          = "",
   Parameter     = "",
   Associated    = "",
}

local diagnostics = {
  error_sign = "",
  warn_sign  = "",
  hint_sign  = "",
  infor_sign = "",
  debug_sign = "",
  trace_sign = "",
}

local todo = {
    fix = "",
    todo = "",
    hack = "",
    warn = "",
    perf = "",
    note = "",
}

return {
  cmp = cmp,
  diag = diagnostics,
  todo = todo
}
