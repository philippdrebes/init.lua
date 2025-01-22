local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.systems = {
  install_info = {
    url = "url_to_your_parser_repo", -- This would need to be updated with actual parser repository
    files = {"src/parser.c"},
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "systems",
}

-- Query for syntax highlighting
local queries = [[
;; Keyword definitions
((identifier) @keyword
  (#match? @keyword "^(Rate|Conversion|Leak|inf)$"))

;; Comments
(comment) @comment

;; Numbers
(number) @number

;; Operators
((operator) @operator
  (#match? @operator "^[@>*]$"))

;; Stock names
(stock_name) @variable

;; Stock definitions
(stock_definition
  name: (identifier) @type
  value: (number)? @number
  max_value: (number)? @number)

;; Infinite stocks
(infinite_stock
  name: (identifier) @special)

;; Flow definitions
(flow
  source: [
    (stock_reference)
    (infinite_stock)
  ] @variable.builtin
  destination: [
    (stock_reference)
    (infinite_stock)
  ] @variable.builtin
  rate: [
    (number)
    (formula)
  ] @number)

;; Formulas
(formula) @string
]]

-- Register the queries
vim.treesitter.query.set("systems", "highlights", queries)

-- Configure the grammar
vim.treesitter.language.register("systems", "systems")

-- Additional queries for textobjects and indentation can be added here
