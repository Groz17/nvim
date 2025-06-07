function! CrazyColorColumn()
  let arr = []
  for i in range(1,float2nr(floor(log(1000)/log(2))))
    call add(arr,float2nr(pow(2,i)))
  endfor
  return arr
endfunction

let &colorcolumn=join(CrazyColorColumn(),',')
