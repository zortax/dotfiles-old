" ==================================
" Filename: lightline_theme.vim
" Author: Leonard Seibold
" License: MIT
" ===================================

let s:bg = [ '#181818', 0 ]

let s:c00 = [ '#39414E', 0 ]
let s:c08 = [ '#2C323C', 8 ]

let s:c01 = [ '#EFA6A2', 1 ]
let s:c09 = [ '#E0AF85', 9 ]

let s:c02 = [ '#80C990', 2 ]
let s:c10 = [ '#5ACCAF', 10 ]

let s:c03 = [ '#A69460', 3 ]
let s:c11 = [ '#C8C874', 11 ]

let s:c04 = [ '#A3B8EF', 4 ]
let s:c12 = [ '#CCACED', 12 ]

let s:c05 = [ '#E6A3DC', 5 ]
let s:c13 = [ '#F2A1C2', 13 ]

let s:c06 = [ '#50CACD', 6 ]
let s:c14 = [ '#74C3E4', 14 ]

let s:c07 = [ '#808080', 7 ]
let s:c15 = [ '#C0C0C0', 15 ]

let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {} }

let s:p.normal.left = [ [ s:c08, s:c09, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.normal.middle = [ [ s:c15, s:c08 ] ]
let s:p.normal.right = [ [ s:c15, s:c00, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.normal.error = [ [ s:c01, s:c08 ] ]
let s:p.normal.warning = [ [ s:c12, s:c08 ] ]
let s:p.normal.borderleft = [ [ s:c09, s:bg ] ]
let s:p.normal.borderright = [ [ s:c00, s:bg ] ]

let s:p.insert.left = [ [ s:c08, s:c02, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.insert.right = [ [ s:c15, s:c00, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.insert.borderleft = [ [ s:c02, s:bg ] ]
let s:p.insert.borderright = [ [ s:c00, s:bg ] ]

let s:p.replace.left = [ [ s:c08, s:c01, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.replace.right = [ [ s:c15, s:c00, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.replace.borderleft = [ [ s:c01, s:bg ] ]
let s:p.replace.borderright = [ [ s:c00, s:bg ] ]

let s:p.visual.left = [ [ s:c08, s:c04, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.visual.right = [ [ s:c15, s:c00, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.visual.borderleft = [ [ s:c04, s:bg ] ]
let s:p.visual.borderright = [ [ s:c00, s:bg ] ]

let s:p.tabline.left = [ [ s:c15, s:c00, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.tabline.tabsel = [ [ s:c08, s:c09, 'bold' ] ]
let s:p.tabline.middle = [ [ s:c15, s:c08 ] ]
let s:p.tabline.right = [ [ s:c15, s:c00, 'bold' ], [ s:c15, s:c00 ] ]
let s:p.tabline.borderleft = [ [ s:c00, s:bg ] ]
let s:p.tabline.borderright = [ [ s:c00, s:bg ] ]



let g:lightline#colorscheme#dark_qualitative#palette = lightline#colorscheme#flatten(s:p)

