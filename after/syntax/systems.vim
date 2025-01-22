if exists('b:current_syntax')
    finish
endif

" Keywords
syntax keyword systemsKeyword Rate Conversion Leak inf contained

" Comments
syntax match systemsComment "#.*$"

" Numbers
syntax match systemsNumber "\<\d\+\>" contained
syntax match systemsNumber "\<inf\>" contained

" Operators
syntax match systemsOperator "@" contained
syntax match systemsOperator ">" contained
syntax match systemsOperator "*" contained

" Stock names and definitions
syntax match systemsStock "\<[A-Za-z][A-Za-z0-9_]*\>" contained
syntax match systemsStockDef "^\s*[A-Za-z][A-Za-z0-9_]*\s*(\d\+\(\s*,\s*[^)]\+\)\?)" contains=systemsStock,systemsNumber,systemsFormula
syntax match systemsInfiniteStock "\[\s*[A-Za-z][A-Za-z0-9_]*\s*\]" contains=systemsStock

" Flow definitions
syntax match systemsFlow "^\s*\([A-Za-z][A-Za-z0-9_]*\|[\[]\s*[A-Za-z][A-Za-z0-9_]*\s*[\]]\)\s*>\s*\([A-Za-z][A-Za-z0-9_]*\|[\[]\s*[A-Za-z][A-Za-z0-9_]*\s*[\]]\)\s*@" contains=systemsStock,systemsOperator,systemsInfiniteStock

" Formulas
syntax region systemsFormula start="(" end=")" contained contains=systemsNumber,systemsOperator,systemsStock

" Link everything to highlight groups
highlight default link systemsKeyword Keyword
highlight default link systemsComment Comment
highlight default link systemsNumber Number
highlight default link systemsOperator Operator
highlight default link systemsStock Identifier
highlight default link systemsStockDef Type
highlight default link systemsInfiniteStock Special
highlight default link systemsFlow Statement
highlight default link systemsFormula PreProc

let b:current_syntax = 'systems'
