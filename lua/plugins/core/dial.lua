-- make it work with neovin plugin config? like lua_ls config
-- nrformats here? for hex...
return {
  -- How to make it work like targets.nvim and jump? first string that matches any of the augends works
  -- Support dot repeating~
  -- add option to disable inheriting for filetypes? like inherit = false (default is true) (add groups to make it work for many related filetypes like javascript, vue, etc...)
  -- sarebbe utile anche per convertire ascii to unicode like -> to →
  -- telescope extension to show possible things to use dial on?
  'monaqa/dial.nvim',
  -- stylua: ignore
  -- diff here?
  -- { '<C-a>',  function() return require('dial.map').inc_normal()  end, expr = true },
  keys = {
    { "<C-a>", function() require('dial.map').manipulate('increment', 'normal') end },
    { "<C-x>", function() require('dial.map').manipulate('decrement', 'normal') end },
    { "g<C-a>", function() require('dial.map').manipulate('increment', 'gnormal') end },
    { "g<C-x>", function() require('dial.map').manipulate('decrement', 'gnormal') end },
    { mode="x", "<C-a>", function() require('dial.map').manipulate('increment', 'visual') end },
    { mode="x", "<C-x>", function() require('dial.map').manipulate('decrement', 'visual') end },
    { mode="x", "g<C-a>", function() require('dial.map').manipulate('increment', 'gvisual') end },
    { mode="x", "g<C-x>", function() require('dial.map').manipulate('decrement', 'gvisual') end },
  },
  -- Should be built into the plugin, cond only works the first time...
  -- cond = vim.bo[vim.api.nvim_win_get_buf(0)].modifiable,
  config = function()
    local augend = require('dial.augend')
    local default = {
      augend.integer.alias.decimal_int, -- any decimal number (0, 1, 2, 3, ...)
      augend.integer.alias.hex,         -- nonnegative hex number  (0x01, 0x1a20, etc.)
      augend.integer.alias.octal,       -- 0o00, 0o11, 0o24,
      augend.integer.alias.binary,      -- 0b0101, 0b11000111

      augend.constant.alias.bool,  -- boolean value (true <-> false)

      -- Apparently without these visual mode doesn't work?
      -- augend.constant.alias.alpha, -- a b c d
      -- augend.constant.alias.Alpha, -- A B C D

      augend.semver.alias.semver,  -- 4.3.0

      augend.date.new({ pattern = "%Y/%m/%d", default_kind = "day" }), -- date (2022/02/19, etc.)
      augend.date.new({ pattern = "%Y-%m-%d", default_kind = "day" }), -- date (2022-02-19, etc.)
      augend.date.new({ pattern = "%Y_%m_%d", default_kind = "day" }),

      -- FIX: Skips 2 on each
      augend.date.alias["%H:%M:%S"], -- 28:49:23
      augend.date.alias["%H:%M"],    -- hour/minute 13:49

      augend.decimal_fraction.new({ signed = false, point_char = '.' }),


      augend.hexcolor.new{ case = "lower" },

      -- augend.paren.alias.quote, -- " -> ' | ' -> "
      -- augend.paren.alias.brackets, -- ( [ {  } ] )

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Antonyms                                                │
      -- ╰─────────────────────────────────────────────────────────╯
      -- would be nice if those words would trigger dial only in comments (integrate dial with treesitter? @comment.inner?)
      augend.constant.new({ elements = { "FIX", "TODO", "HACK", "WARN", "PERF", "NOTE", "TEST" },  word = true, }), -- like in todo-comments.nvim

      -- doesn't work :/ (maybe for trailing space)
      -- augend.constant.new({ elements = { "not ", "" }, }),
      -- augend.constant.new({ elements = { " not", "" }, }),
      -- augend.constant.new({ elements = { "not\32", "" }, }),
      augend.constant.new({ elements = { "not", "" }, }),

      augend.constant.new({ elements = { "above", "below" }, preserve_case = true }),
      augend.constant.new({ elements = { "after", "before" }, preserve_case = true }),
      augend.constant.new({ elements = { "and", "or" }, preserve_case = true }),
      augend.constant.new({ elements = { "and", "&" }, word = false, preserve_case = true }),
      augend.constant.new({ elements = { "beginning", "middle", "end" }, preserve_case = true }),
      augend.constant.new({ elements = { "capitalize", "uppercase", "lowercase" }, preserve_case = true }),
      augend.constant.new({ elements = { "dark", "light" }, preserve_case = true }),
      augend.constant.new({ elements = { "enable", "disable" }, preserve_case = true }),
      augend.constant.new({ elements = { "even", "odd" }, word = true, cyclic = true, preserve_case = true }),
      augend.constant.new({ elements = { "Even", "Odd" }, word = true, cyclic = true, preserve_case = true }),
      augend.constant.new({ elements = { "expand", "collapse" }, preserve_case = true }),
      augend.constant.new({ elements = { "fg", "bg" }, preserve_case = true }),
      augend.constant.new({ elements = { "first", "last" }, preserve_case = true }),
      augend.constant.new({ elements = { "floor", "ceil" }, preserve_case = true }),
      augend.constant.new({ elements = { "foreground", "background" }, preserve_case = true }),
      augend.constant.new({ elements = { "forward", "backward" }, preserve_case = true }),
      augend.constant.new({ elements = { "for", "while" }, preserve_case = true }),
      augend.constant.new({ elements = { "from", "to" }, preserve_case = true }),
      augend.constant.new({ elements = { "get", "set" }, preserve_case = true }),
      augend.constant.new({ elements = { "good", "bad" }, preserve_case = true }),
      augend.constant.new({ elements = { "horizontal", "vertical" }, preserve_case = true }),
      augend.constant.new({ elements = { "incoming", "outgoing" }, preserve_case = true }),
      augend.constant.new({ elements = { "increase", "decrease" }, preserve_case = true }),
      augend.constant.new({ elements = { "inc", "dec" }, preserve_case = true }),
      augend.constant.new({ elements = { "inner", "outer" }, preserve_case = true }),
      augend.constant.new({ elements = { "in", "out" }, preserve_case = true }),
      augend.constant.new({ elements = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }, preserve_case = true }),
      augend.constant.new({ elements = { "largest", "smallest" }, preserve_case = true }),
      augend.constant.new({ elements = { "large", "small" }, preserve_case = true }),
      augend.constant.new({ elements = { "left", "right" }, preserve_case = true }),
      augend.constant.new({ elements = { "less", "more" }, preserve_case = true }),
      augend.constant.new({ elements = { "longest", "shortest" }, preserve_case = true }),
      augend.constant.new({ elements = { "long", "short" }, preserve_case = true }),
      augend.constant.new({ elements = { "new", "old" }, preserve_case = true }),
      augend.constant.new({ elements = { "on", "off" }, preserve_case = true }),
      augend.constant.new({ elements = { "open", "close" }, preserve_case = true }),
      augend.constant.new({ elements = { "parent", "child" }, preserve_case = true }),
      augend.constant.new({ elements = { "positive", "negative" }, preserve_case = true }),
      augend.constant.new({ elements = { "pos", "neg" }, preserve_case = true }),
      augend.constant.new({ elements = { "previous", "prev", "next" }, preserve_case = true }),
      augend.constant.new({ elements = { "Previous", "Prev", "Next" }, preserve_case = true }),
      augend.constant.new({ elements = { "read", "write" }, preserve_case = true }),
      augend.constant.new({ elements = { "start", "finish" }, preserve_case = true }),
      augend.constant.new({ elements = { "stdin", "stdout", "stderr" }, preserve_case = true }),
      augend.constant.new({ elements = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }, preserve_case = true }),
      -- augend.constant.new({ elements = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }, word = false, preserve_case = true }),
      augend.constant.new({ elements = { "Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat." }, word = false, preserve_case = true }),
      augend.constant.new({ elements = { "surround", "enclose" }, preserve_case = true }),
      augend.constant.new({ elements = { "top", "bottom" }, preserve_case = true }),
      augend.constant.new({ elements = { "top", "bottom" }, word = true, cyclic = true, preserve_case = true }),
      augend.constant.new({ elements = { "trace", "debug", "info", "warn", "error", "fatal" }, preserve_case = true }),
      -- better way to write true/TRUE/True, etc...?
      augend.constant.new({ elements = { "true", "false" }, preserve_case = true }),
      augend.constant.new({ elements = { "True", "False" }, preserve_case = true }),
      augend.constant.new({ elements = { "TRUE", "FALSE" }, preserve_case = true }),
      augend.constant.new({ elements = { "upper", "lower" }, preserve_case = true }),
      augend.constant.new({ elements = { "up", "down" }, preserve_case = true }),
      augend.constant.new({ elements = { "width", "height" }, preserve_case = true }),
      augend.constant.new({ elements = { "yes", "no" }, preserve_case = true }),
      augend.constant.new({ elements = { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten" }, word = false, preserve_case = true }),

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Programming symbols                                     │
      -- ╰─────────────────────────────────────────────────────────╯

      -- augend.constant.new({elements = {"+", "-", "*", "/", "%"},  word = false}),
      augend.constant.new({elements = {"&&", "||"}, word = false}),
      augend.constant.new({elements = {"==", "!="}, word = false}),
      -- would be nice if it allowed a regex-like syntax: [<+]=->[>-]= (respectively first and second and third...)
      augend.constant.new({elements = {"<=", ">="}, word = false}),
      augend.constant.new({ elements = { "+=", "-=" }, word = false }),
      augend.constant.new({elements = {"<", ">"}, word = false}),
      -- Cosa succede qua? < è contenuto in <<...
      augend.constant.new({elements = {"<<", ">>"}, word = false}),
      -- augend.constant.new({elements = {"++", "--"}, word = false}),

      -- ╭─────────────────────────────────────────────────────────╮
      -- │ Unicode                                                 │
      -- ╰─────────────────────────────────────────────────────────╯
      augend.constant.new({elements = {"<-", "←"},  word = false}),
      augend.constant.new({elements = {"->", "→"},  word = false}),


    }
    local visual = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,

      augend.constant.alias.bool, -- boolean value (true <-> false)

      augend.date.new({ pattern = "%Y/%m/%d", default_kind = "day" }),
      augend.date.new({ pattern = "%Y-%m-%d", default_kind = "day" }),
      augend.date.new({ pattern = "%Y_%m_%d", default_kind = "day" }),

      -- doesn't work? a->b for ex?
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
      augend.paren.alias.brackets,        -- ( [ {  } ] )
    }

    require('dial.config').augends:register_group({default = default, visual = visual})

    -- ╭─────────────────────────────────────────────────────────╮
    -- │ Filetypes                                               │
    -- ╰─────────────────────────────────────────────────────────╯

    -- crea for loop per non ripetere vim.list_extend tante volte
    require("dial.config").augends:on_filetype {
      -- BUG: doesn't work
      alda = augend.constant.new({ elements = {"a","b","c","d","e","f","g"},word = true, cyclic = true}),

      -- Not sure if I should use vim.tbl_extend('keep'... here
      typescript = vim.list_extend(default,{ augend.integer.alias.hex, augend.constant.new { elements = { "var", "let", "const" } } }),

      javascript = vim.list_extend(default,{
        augend.constant.new({ elements = { "===", "!==" }, word = false, }),
        augend.constant.new({ elements = {"let", "const", "var"}}),
        -- augend.constant.new({ elements = {"of", "in"}, word = false, }),
        augend.constant.new({ elements = {"of", "in"}, word = true, }),
        augend.constant.new({ elements = {"public", "private", "protected"}}), }),

        -- zsh = vim.list_extend(default,{
        --   augend.constant.new({ elements = {"elif", "if"}, }),
        --   augend.constant.new({ elements = {"local", "typeset", "integer", "float", "readonly", "private"}, }),
        --   -- usa text-case.nvim o plugin simile per usare operatore...
        --   augend.case.new({ types = { "camelCase", "snake_case", "kebab-case" }, }),
        --   augend.paren.new({ patterns = { { "[[", "]]" }, { "((", "))" } }, nested = false, cyclic = true }),}),


      lua = vim.list_extend(default,{
        augend.constant.new({ elements = { "==", "~=" }, word = false, }),
        -- augend.paren.alias.lua_str_literal, -- ' " [[ [=[ [==[ [===[
        augend.paren.new{ patterns = { {"[[", "]]"}, {"[=[", "]=]"}, {"[==[", "]==]"}, {"[===[", "]===]"}, }, nested = false, cyclic = false, }}),

        -- Apparently works also for vimwiki, not complaining
      markdown = vim.list_extend(default,{ --[[augend.misc.alias.markdown_header,]]
      augend.constant.new({ elements = { "TODO", "DONE" }}),
      augend.constant.new({ elements = { "[ ]", "[x]" }, word = false, }), }),

      java = vim.list_extend(default,{
        augend.constant.new({ elements = { 'private', 'public', 'protected' }}),
        augend.constant.new({ elements = { 'class', 'interface', 'enum' }}) }),

      gitrebase = vim.list_extend(default,{
        augend.constant.new { elements = { "pick", "squash", "edit", "reword", "fixup", "exec", "drop" }, word = true, cyclic = false }, }),

      haskell = vim.list_extend(default,{ augend.constant.new({ elements = { "==", "/=" }, word = false, }) }),

      elixir = vim.list_extend(default,{
        augend.constant.new { elements = { "def", "defp" }, word = true, cyclic = false },
        augend.constant.new { elements = { "{:ok, ", "{:error, " }, word = true, cyclic = false }, }),

      zig = vim.list_extend(default,{
        augend.constant.new({ elements = { "var", "const" }})}),

      go = vim.list_extend(default,{
        -- non funge
        augend.constant.new({ elements = {":=", "="}}),
        augend.constant.new({ elements = {"interface", "struct"}})
      }),

      c = vim.list_extend(default,{

        -- 1234; 1234L; 1234LL;
        -- 1234U; 1234UL; 1234ULL;
        -- 1234F; 1234; 1234L;
        augend.constant.new({elements = {"typedef", "struct", "enum", "union"}}),
        augend.constant.new({elements = {"malloc", "calloc", "realloc"}}),
        augend.constant.new({elements = {"sizeof", "offsetof", "typeof"}}),
        augend.constant.new({elements = {"printf", "fprintf", "sprintf", "asprintf", "dprintf"}}),
        augend.constant.new({elements = {"vprintf", "vfprintf", "vsprintf", "vasprintf", "vdprintf"}}),
        augend.constant.new({elements = {"snprintf", "vsnprintf"}}),
        augend.constant.new({elements = {"scanf", "fscanf", "sscanf"}}),
        augend.constant.new({elements = {"vscanf", "vfscanf", "vsscanf"}}),
        augend.constant.new({elements = {"getc", "fgetc", "getchar"}}),
        augend.constant.new({elements = {"putc", "fputc", "putchar"}}),
        augend.constant.new({elements = {"getw", "putw"}}),
        augend.constant.new({elements = {"puts", "fputs"}}),
        augend.constant.new({elements = {"fread", "fwrite"}}),
        augend.constant.new({elements = {"fseek", "ftell", "rewind", "ftello", "fseeko"}}),
        augend.constant.new({elements = {"flockfile", "ftrylockfile", "funlockfile"}}),
        augend.constant.new({elements = {"clearerr", "feof", "ferror"}}),
        augend.constant.new({elements = {"perror", "err", "warn", "verr", "vwarn"}}),
        augend.constant.new({elements = {"errx", "warnx"}}),
        --
        augend.constant.new({elements = {"i8", "i16", "i32", "i64"}}),
        augend.constant.new({elements = {"u8", "u16", "u32", "u64"}}),
        augend.constant.new({elements = {"f32", "f64", "f128"}}),
        --
        augend.constant.new({elements = {"int8", "int16", "int32", "int64"}}),
        augend.constant.new({elements = {"uint8", "uint16", "uint32", "uint64"}}),
        augend.constant.new({elements = {"float32", "float64"}}),
        --
        augend.constant.new({elements = {"int8_t", "int16_t", "int32_t", "int64_t"}}),
        augend.constant.new({elements = {"uint8_t", "uint16_t", "uint32_t", "uint64_t"}}),
        augend.constant.new({elements = {"u_int8_t", "u_int16_t", "u_int32_t", "u_int64_t"}}),
        augend.constant.new({elements = {"float32_t", "float64_t"}}),
        --
        augend.constant.new({elements = {"intmax_t", "uintmax_t"}}),
        augend.constant.new({elements = {"intptr_t", "uintptr_t", "nullptr_t", "ptrdiff_t"}}),
        --
        augend.constant.new({elements = {"quad_t", "u_quad_t"}}),
        augend.constant.new({elements = {"s_char", "u_char"}}),
        augend.constant.new({elements = {"char", "schar", "uchar"}}),
        augend.constant.new({elements = {"short", "int", "long", "llong"}}),
        augend.constant.new({elements = {"sshort", "sint", "slong", "sllong"}}),
        augend.constant.new({elements = {"ushort", "uint", "ulong", "ullong"}}),
        augend.constant.new({elements = {"s_short", "s_int", "s_long", "s_llong"}}),
        augend.constant.new({elements = {"u_short", "u_int", "u_long", "u_llong"}}),
        augend.constant.new({elements = {"float", "double", "ldouble"}}),
        --
        augend.constant.new({elements = {"gid_t", "uid_t"}}),
        augend.constant.new({elements = {"ino_t", "ino64_t"}}),
        augend.constant.new({elements = {"off_t", "fpos_t"}}),
        augend.constant.new({elements = {"size_t", "ssize_t"}}),
        augend.constant.new({elements = {"wchar_t", "rsize_t"}}),
        augend.constant.new({elements = {"fsid_t", "pid_t", "id_t"}}),
        augend.constant.new({elements = {"loff_t", "dev_t", "mode_t", "nlink_t"}}),
        augend.constant.new({elements = {"useconds_t", "suseconds_t", "suseconds64_t"}}),
        augend.constant.new({elements = {"time_t", "timer_t"}}),
        augend.constant.new({elements = {"clock_t", "clockid_t"}}),
        augend.constant.new({elements = {"rlim_t", "rlim64_t"}}),
        augend.constant.new({elements = {"register_t", "socklen_t", "sigset_t"}}),
        augend.constant.new({elements = {"daddr_t", "caddr_t", "key_t"}}),
        augend.constant.new({elements = {"fsblkcnt_t", "fsfilcnt_t", "blkcnt_t"}}),
        augend.constant.new({elements = {"fsblkcnt64_t", "fsfilcnt64_t", "blkcnt64_t"}}),
        augend.constant.new({elements = {"pthread_t", "pthread_attr_t", "pthread_cond_t", "pthread_key_t"}}),
        augend.constant.new({elements = {"pthread_once_t", "pthread_mutex_t", "pthread_rwlock_t", "pthread_spinlock_t"}}),
        -- end.constant.newa{elements = ug({"fsword_t"}}),
        --
        augend.constant.new({elements = {"signed_char", "unsigned_char"}}),
        augend.constant.new({elements = {"signed_short", "unsigned_short", "signed_short_int", "unsigned_short_int"}}),
        augend.constant.new({elements = {"signed_int", "unsigned_int", "signed", "unsigned"}}),
        augend.constant.new({elements = {"signed_long", "unsigned_long", "signed_long_int", "unsigned_long_int"}}),
        augend.constant.new({elements = {"signed_long_long", "unsigned_long_long"}}),
        augend.constant.new({elements = {"signed_long_long_int", "unsigned_long_long_int",}}),
        --
        augend.constant.new({elements = {"int_least8_t", "int_least16_t", "int_least32_t", "int_least64_t"}}),
        augend.constant.new({elements = {"uint_least8_t", "uint_least16_t", "uint_least32_t", "uint_least64_t"}}),
        augend.constant.new({elements = {"int_fast8_t", "int_fast16_t", "int_fast32_t", "int_fast64_t"}}),
        augend.constant.new({elements = {"uint_fast8_t", "uint_fast16_t", "uint_fast32_t", "uint_fast64_t"}}),
        --
        augend.constant.new({elements = {"INT8_MIN", "INT16_MIN", "INT32_MIN", "INT64_MIN"}}),
        augend.constant.new({elements = {"INT8_MAX", "INT16_MAX", "INT32_MAX", "INT64_MAX"}}),
        augend.constant.new({elements = {"UINT8_MIN", "UINT16_MIN", "UINT32_MIN", "UINT64_MIN"}}),
        augend.constant.new({elements = {"UINT8_MAX", "UINT16_MAX", "UINT32_MAX", "UINT64_MAX"}}),
        augend.constant.new({elements = {"INT_LEAST8_MIN", "INT_LEAST16_MIN", "INT_LEAST32_MIN", "INT_LEAST64_MIN"}}),
        augend.constant.new({elements = {"INT_LEAST8_MAX", "INT_LEAST16_MAX", "INT_LEAST32_MAX", "INT_LEAST64_MAX"}}),
        augend.constant.new({elements = {"UINT_LEAST8_MAX", "UINT_LEAST16_MAX", "UINT_LEAST32_MAX", "UINT_LEAST64_MAX"}}),
        augend.constant.new({elements = {"INT_FAST8_MIN", "INT_FAST16_MIN", "INT_FAST32_MIN", "INT_FAST64_MIN"}}),
        augend.constant.new({elements = {"INT_FAST8_MAX", "INT_FAST16_MAX", "INT_FAST32_MAX", "INT_FAST64_MAX"}}),
        augend.constant.new({elements = {"UINT_FAST8_MAX", "UINT_FAST16_MAX", "UINT_FAST32_MAX", "UINT_FAST64_MAX"}}),
        augend.constant.new({elements = {"INTPTR_MIN", "INTPTR_MAX", "UINTPTR_MAX"}}),
        augend.constant.new({elements = {"INTMAX_MIN", "INTMAX_MAX", "UINTMAX_MAX"}}),
        --
        augend.constant.new({elements = {"INT8_C", "INT16_C", "INT32_C", "INT64_C"}}),
        augend.constant.new({elements = {"UINT8_C", "UINT16_C", "UINT32_C", "UINT64_C"}}),
        augend.constant.new({elements = {"INTMAX_C", "UINTMAX_C"}}),
        --
        augend.constant.new({elements = {"INT8_WIDTH", "INT16_WIDTH", "INT32_WIDTH", "INT64_WIDTH"}}),
        augend.constant.new({elements = {"UINT8_WIDTH", "UINT16_WIDTH", "UINT32_WIDTH", "UINT64_WIDTH"}}),
        augend.constant.new({elements = {"INT_LEAST8_WIDTH", "INT_LEAST16_WIDTH", "INT_LEAST32_WIDTH", "INT_LEAST64_WIDTH"}}),
        augend.constant.new({elements = {"UINT_LEAST8_WIDTH", "UINT_LEAST16_WIDTH", "UINT_LEAST32_WIDTH", "UINT_LEAST64_WIDTH"}}),
        augend.constant.new({elements = {"INT_FAST8_WIDTH", "INT_FAST16_WIDTH", "INT_FAST32_WIDTH", "INT_FAST64_WIDTH"}}),
        augend.constant.new({elements = {"UINT_FAST8_WIDTH", "UINT_FAST16_WIDTH", "UINT_FAST32_WIDTH", "UINT_FAST64_WIDTH"}}),
        --
        augend.constant.new({elements = {"PTRDIFF_MIN", "PTRDIFF_MAX"}}),
        augend.constant.new({elements = {"WCHAR_MIN", "WCHAR_MAX"}}),
        augend.constant.new({elements = {"WINT_MIN", "WINT_MAX"}}),
        --
        augend.constant.new({elements = {"FLT_DECIMAL_DIG", "DBL_DECIMAL_DIG", "LDBL_DECIMAL_DIG", "DECIMAL_DIG"}}),
        --
        augend.constant.new({elements = {"F_RDLCK", "F_WRLCK", "F_UNLCK"}}),
        augend.constant.new({elements = {"O_RDONLY", "O_WRONLY", "O_RDWR"}}),
        augend.constant.new({elements = {"O_CREAT", "O_EXCL", "O_NOCTTY"}}),
        augend.constant.new({elements = {"O_TRUNC", "O_APPEND"}}),
        augend.constant.new({elements = {"O_DIRECTORY", "O_NOFOLLOW", "O_CLOEXEC", "O_RSYNC"}}),
        augend.constant.new({elements = {"O_NOATIME", "O_TMPFILE", "O_PATH", "O_DIRECT"}}),
        augend.constant.new({elements = {"F_DUPFD", "F_GETFD", "F_SETFD", "F_GETFL", "F_SETFL"}}),
        augend.constant.new({elements = {"F_GETSIG", "F_SETSIG"}}),
      }),

      rust = vim.list_extend(default,{
        -- augend.paren.alias.rust_str_literal,      -- " r# r## r###
        augend.constant.new({ elements = { "let", "const" }}),
        augend.constant.new({ elements = {"type", "trait", "struct", "enum"}}),
      }),

      ruby = vim.list_extend(default,{
        augend.integer.alias.decimal,
        augend.constant.new {
          elements = { "debug", "info", "warning", "error" },
          word = true,
          cyclic = true
        },
      }),
    }
  end,
}
