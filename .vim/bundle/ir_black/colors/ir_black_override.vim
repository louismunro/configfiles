" these colors override the default ir_black theme

if exists(g:colors_name) == 'ir_black'
    let g:colors_name = 'ir_black_override'

    " override the selection menu colors in cterm (for omnicomplete)
    hi clear Pmenu
    hi clear PmenuSel
    hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
    hi PmenuSel       guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=black        ctermbg=cyan        cterm=NONE
endif

