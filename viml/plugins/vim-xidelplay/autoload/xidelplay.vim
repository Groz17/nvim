" ==============================================================================
" Run xidel (the command-line XML processor) interactively in Vim
" File:         autoload/xidelplay.vim
" Author:       Groz17 <https://github.com/Groz17>
" Website:      https://github.com/Groz17/vim-xidelplay
" Last Change:  Feb 06, 2024
" License:      Same as Vim itself (see :h license)
" ==============================================================================

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:running = 0               " 1 if xidelplay session running, 0 otherwise
let s:in_buf = -1               " Input buffer number (optional)
let s:in_changedtick = -1       " b:changedtick of input buffer (optional)
let s:in_timer = 0              " timer-ID of input buffer (optional)
let s:filter_buf = 0            " Filter buffer number
let s:filter_changedtick = 0    " b:changedtick of filter buffer
let s:filter_timer = 0          " timer-ID of filter buffer
let s:filter_file = ''          " Full path to filter file on disk
let s:out_buf = 0               " Output buffer number
let s:xidel_cmd = ''               " xidel command running on buffer change

const s:defaults = {
        \ 'exe': exepath('xidel'),
        \ 'opts': '',
        \ 'delay': 500,
        \ 'autocmds': ['InsertLeave', 'TextChanged'],
        \ 'mods': 'split'
        \ }

const s:getopt = {k -> get(g:, 'xidelplay', {})->get(k, s:defaults[k])}

" Helper function to create full xidel command
const s:xidelcmd = {exe, opts, args, file -> printf('%s %s %s --extract-file %s', exe, opts, args, file)}

" Is xidelplay session running with input buffer?
const s:xidel_with_input = {-> s:in_buf != -1}

function s:error(...)
    echohl ErrorMsg | echomsg 'xidelplay:' call('printf', a:000) | echohl None
endfunction

function s:warning(...)
    echohl WarningMsg | echomsg 'xidelplay:' call('printf', a:000) | echohl None
endfunction

function s:new_scratch(bufname, filetype, clean, mods, ...) abort
    if bufexists(a:bufname)
        const bufnr = bufnr(a:bufname)
        call setbufvar(bufnr, '&filetype', a:filetype)
        if a:clean
            silent call deletebufline(bufnr, 1, '$')
        endif

        if bufwinnr(bufnr) > 0
            return bufnr
        else
            silent execute a:mods 'sbuffer' bufnr
        endif
    else
        silent execute a:mods 'new' fnameescape(a:bufname)
        setlocal noswapfile buflisted buftype=nofile bufhidden=hide
        const bufnr = bufnr('%')
        call setbufvar(bufnr, '&filetype', a:filetype)
    endif

    if a:0
        execute 'resize' a:1
    endif
    return bufnr
endfunction

function s:run_manually(bang, args) abort
    if a:args =~# '\v--extract-file\=='
        return s:error('--extract-file option not allowed')
    endif

    if s:filter_changedtick != getbufvar(s:filter_buf, 'changedtick')
        call getbufline(s:filter_buf, 1, '$')->writefile(s:filter_file)
    endif

    let xidel_cmd = s:xidelcmd(s:getopt('exe'), s:getopt('opts'), a:args, s:filter_file)
    call s:run_xidel(xidel_cmd)

    if a:bang
        let s:xidel_cmd = xidel_cmd
    endif
endfunction

function s:on_filter_changed() abort
    if s:filter_changedtick == getbufvar(s:filter_buf, 'changedtick')
        return
    endif

    let s:filter_changedtick = getbufvar(s:filter_buf, 'changedtick')
    call timer_stop(s:filter_timer)
    let s:filter_timer = s:getopt('delay')->timer_start(funcref('s:filter_changed'))
endfunction

function s:filter_changed(...) abort
    call getbufline(s:filter_buf, 1, '$')->writefile(s:filter_file)
    call s:run_xidel(s:xidel_cmd)
endfunction

function s:on_input_changed() abort
    if s:in_changedtick == getbufvar(s:in_buf, 'changedtick')
        return
    endif

    let s:in_changedtick = getbufvar(s:in_buf, 'changedtick')
    call timer_stop(s:in_timer)
    let s:in_timer = s:getopt('delay')->timer_start({_ -> s:run_xidel(s:xidel_cmd)})
endfunction

function s:close_cb(...) abort
    if !has("nvim")
        silent call deletebufline(s:out_buf, 1)
        redrawstatus!
    endif
endfunction

function s:stdout_cb(_, msg, ...) abort
    if has('nvim')
        if empty(join(a:msg))
            return
        endif

        let l:non_empty_lines = filter(a:msg, {_, val -> !empty(v:val)})

        call nvim_buf_set_lines(
                \ s:out_buf,
                \ nvim_buf_line_count(s:out_buf) - 1,
                \ nvim_buf_line_count(s:out_buf) + len(a:msg),
                \ 0,
                \ l:non_empty_lines
                \ )
    else
        call appendbufline(s:out_buf, '$', a:msg)
    endif
endfunction

function s:stderr_cb(_, msg, ...) abort
    if has('nvim')
        if empty(join(a:msg))
            return
        endif

        let l:non_empty_lines = filter(a:msg, {_, val -> !empty(v:val)})
        let l:formatted_lines = map(l:non_empty_lines, {_, val -> '// ' .. val})

        call nvim_buf_set_lines(s:out_buf, 0, -1, 0, l:formatted_lines)
    else
        call appendbufline(s:out_buf, '$', '// ' .. a:msg)
    endif
endfunction

function s:run_xidel(xidel_cmd) abort
    silent call deletebufline(s:out_buf, 1, '$')

    if exists('s:job')
        if has('nvim')
            call jobstop(s:job)
        else
            if job_status(s:job) ==# 'run'
                call job_stop(s:job)
            endif
        endif
    endif

    if has('nvim')
        let opts = {
                \ 'on_stdout': funcref('s:stdout_cb'),
                \ 'on_stderr': funcref('s:stderr_cb'),
                \ 'on_exit': funcref('s:close_cb'),
                \ }

        let s:job = jobstart(a:xidel_cmd, opts)

        if s:xidel_with_input()
            let s:in_buflines = nvim_buf_get_lines(s:in_buf, 0, nvim_buf_line_count(s:in_buf), 0)
            call chansend(s:job, join(s:in_buflines))
            call chanclose(s:job, 'stdin')
        endif

        return
    endif

    let opts = {
            \ 'in_io': 'null',
            \ 'out_cb': funcref('s:stdout_cb'),
            \ 'err_cb': funcref('s:stderr_cb'),
            \ 'close_cb': funcref('s:close_cb')
            \ }

    if s:xidel_with_input()
        call extend(opts, {'in_io': 'buffer', 'in_buf': s:in_buf})
    endif

    " https://github.com/vim/vim/issues/4688
    try
        let s:job = job_start([&shell, &shellcmdflag, a:xidel_cmd], opts)
    catch /^Vim\%((\a\+)\)\=:E631:/
    endtry
endfunction

function s:xidel_stop(...) abort
    if !exists('s:job')
        return ''
    endif

    if has('nvim')
        return jobstop(s:job)
    endif

    return job_stop(s:job, a:0 ? a:1 : 'term')
endfunction

function s:xidel_close(bang) abort
    if !s:running && !(exists('#xidelplay#BufDelete') || exists('#xidelplay#BufWipeout'))
        return
    endif

    call s:xidel_stop()
    autocmd! xidelplay

    if a:bang
        execute 'bwipeout' s:filter_buf
        execute 'bwipeout' s:out_buf
        if s:xidel_with_input() && getbufvar(s:in_buf, '&buftype') ==# 'nofile'
            execute 'bwipeout' s:in_buf
        endif
    endif

    delcommand XidelplayClose
    delcommand Xidelrun
    delcommand Xidelstop
    let s:running = 0

    call s:warning('xidelplay interactive session closed')
endfunction

" When 'in_buf' is set to -1, no input buffer is passed to xidel
function xidelplay#start(mods, args, in_buf) abort
    if a:args =~# '\v--extract-file\=='
        return s:error('--extract-file option not allowed')
    endif

    if s:running
        return s:error('only one interactive session allowed')
    endif

    let s:running = 1
    let s:in_buf = a:in_buf

    " Check if -r/--raw-output or -j/--join-output options are passed
    const out_ft = a:args =~# '\v-@1<!-\a*%(r|j)\a*|--%(raw|join)-output>' ? '' : 'xml'

    const winid = win_getid()

    " Output buffer
    const out_buf_mods = empty(a:mods) ? s:getopt('mods') : a:mods
    const out_name = 'xidel-output://' .. (a:in_buf == -1 ? '' : bufname(a:in_buf))
    let s:out_buf = s:new_scratch(out_name, out_ft, 1, out_buf_mods)

    " xidel filter buffer
    const filter_name = 'xidel-filter://' .. (a:in_buf == -1 ? '' : bufname(a:in_buf))
    let s:filter_buf = s:new_scratch(filter_name, 'xidel', 0, 'belowright', 10)

    call win_gotoid(winid)

    " Temporary file where xidel filter buffer is written to
    let s:filter_file = tempname()

    let s:in_changedtick = getbufvar(a:in_buf, 'changedtick', -1)
    let s:filter_changedtick = getbufvar(s:filter_buf, 'changedtick')
    let s:in_timer = 0
    let s:filter_timer = 0
    let s:xidel_cmd = s:xidelcmd(s:getopt('exe'), s:getopt('opts'), a:args, s:filter_file)

    " When input, output or filter buffer are deleted/wiped out, close the
    " interactive session
    augroup xidelplay
        autocmd!
        if s:xidel_with_input()
            execute printf('autocmd BufDelete,BufWipeout <buffer=%d> call s:xidel_close(0)', a:in_buf)
        endif
        execute printf('autocmd BufDelete,BufWipeout <buffer=%d> call s:xidel_close(0)', s:out_buf)
        execute printf('autocmd BufDelete,BufWipeout <buffer=%d> call s:xidel_close(0)', s:filter_buf)
    augroup END

    " Run xidel interactively when input or filter buffer are modified
    if !empty(s:getopt('autocmds'))
        const events = s:getopt('autocmds')->join(',')
        if s:xidel_with_input()
            execute printf('autocmd xidelplay %s <buffer> call s:on_input_changed()', events)
        endif
        execute printf('autocmd xidelplay %s <buffer=%d> call s:on_filter_changed()', events, s:filter_buf)
    endif

    execute 'command -bar -bang XidelplayClose call s:xidel_close(<bang>0)'
    execute 'command -bar -bang -nargs=? -complete=customlist,xidelplay#complete Xidelrun call s:run_manually(<bang>0, <q-args>)'
    execute 'command -nargs=? -complete=custom,xidelplay#stopcomplete Xidelstop call s:xidel_stop(<f-args>)'
endfunction

function xidelplay#scratch(bang, mods, args) abort
    if s:running
        return s:error('only one interactive session allowed')
    endif

    if a:args =~# '\v--extract-file\=='
        return s:error('--extract-file option not allowed')
    endif

    const raw_input = a:args =~# '-\@1<!-\a*R\a*\>\|--raw-input\>'
    const null_input = a:args =~# '-\@1<!-\a*n\a*\>\|--null-input\>'

    if a:bang && raw_input && null_input
        return s:error('not possible to run :XidelplayScratch! with -n and -R')
    endif

    if a:bang
        tab split
    else
        tabnew
        setlocal buflisted buftype=nofile bufhidden=hide noswapfile
        call setbufvar('%', '&filetype', raw_input ? '' : 'json')
    endif

    const args = a:bang && !null_input ? (a:args .. ' -n') : a:args
    const bufnr = a:bang ? -1 : bufnr('%')
    call xidelplay#start(a:mods, args, bufnr)

    " Close the initial window that we opened with :tab split
    if a:bang
        close
    endif
endfunction

function xidelplay#job() abort
    return exists('s:job') ? s:job : ''
endfunction

function xidelplay#stopcomplete(arglead, cmdline, cursorpos) abort
    return join(['term', 'hup', 'quit', 'int', 'kill'], "\n")
endfunction

function xidelplay#complete(arglead, cmdline, cursorpos) abort
    if a:arglead[0] ==# '-'
        return copy(['-e', '-f', '-d', '-F', '-X', '-H', '-s', '-q',
                \ '--input', '--download', '--extract', '--extract-exclude', '--extract-include',
                \ '--extract-file', '--extract-kind', '--css', '--xpath', '--xquery',
                \ '--xpath2', '--xquery1', '--xpath3', '--xquery3', '--xpath3.0',
                \ '--xquery3.0', '--xpath3.1', '--xquery3.1', '--template-file', '--template-action',
                \ '--module', '--module-path', '--follow', '--follow-kind', '--follow-exclude',
                \ '--follow-include', '--follow-file', '--follow-level', '--allow-repetitions', '--wait',
                \ '--user-agent', '--proxy', '--post', '--form', '--method',
                \ '--header', '--load-cookies', '--save-cookies', '--print-received-headers', '--error-handling',
                \ '--compressed', '--raw-url', '--no-check-certificate', '--ca-certificate', '--ca-directory',
                \ '--silent', '--verbose', '--default-variable-name', '--print-variables', '--print-type-annotations',
                \ '--hide-variable-names', '--variable', '--xmlns', '--output-node-format', '--output-json-indent',
                \ '--output-node-indent', '--output-format', '--output-encoding', '--output-declaration', '--output-separator',
                \ '--output-header', '--output-footer', '--output-key-order', '--color', '--stdin-encoding',
                \ '--input-format', '--xml', '--html', '--in-place', '--debug-arguments',
                \ '--trace', '--trace-stack', '--trace-context', '--json-mode', '--no-json',
                \ '--no-json-literals', '--dot-notation', '--only-json-objects', '--no-extended-json', '--strict-type-checking',
                \ '--strict-namespaces', '--no-extended-strings', '--ignore-namespaces', '--no-optimizations', '--deprecated-string-options',
                \ '--deprecated-trim-nodes', '--version', '--usage', '--quiet'])
                \ ->filter('stridx(v:val, a:arglead) == 0')
    endif
    return getcompletion(a:arglead, 'file')->map('fnameescape(v:val)')
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
