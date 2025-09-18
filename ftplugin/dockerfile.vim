augroup UPPERCASE_DOCKER_COMMANDS
  au!
  au InsertCharPre <buffer> if getline(".") !~ '[[:space:]]' | let v:char = v:char->toupper() | endif
augroup END
